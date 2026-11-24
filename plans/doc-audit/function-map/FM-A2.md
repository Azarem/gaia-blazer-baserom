# FM-A2: `engine_*` (rest), `native_mode_brk`, `engine_routines_*`

PA batch A2, iteration I006. Read-only analysis: no names, notes, comments, `blocks.json`, `overrides.json` or docs were changed. Every proposed name below is a proposal for step PC (`npm run names`); every unverified claim is an `OQ-I006-k` row in `plans/extracted-audit/questions/I006_questions.md`.

Source: a fresh `npm run extract:lt` of `extracted/system/`. Fifteen files were read end to end; offsets are decimal file offsets (the `{n}` tag; LoROM, so every A2 routine is in bank `$00` and the SNES address is `$8000 + (offset - 32768 * bank)`, which for these files is `$00:8000 + hex(offset)`; a label `code_00AABB` is at `$00:AABB`, with offset `$AABB` hex in its name).

| File | Offsets | Top-level labels | Content (this batch's reading) |
|------|---------|------------------|--------------------------------|
| `engine_routines_001D3B` | 7483-8143 | 27 (+1 sub-label row) | player attack and animation start handlers (targets of the state table `code_list_001B2B`) |
| `engine_routines_002678` | 9848-9959 | 5 | Phoenix projectile actor scripts |
| `engine_0026F3` | 9971-10728 | 15 | monster-lair scripts (spawners, seal, effect puff) |
| `engine_0029EC` | 10732-11419 | 10 (+1 sub-label row) | enemy death, gem drop, EXP popup, boss death, kill-all helpers |
| `engine_002EC0` | 11968-12118 | 5 | gem pickup actors and the pickup applier |
| `engine_003005` | 12293-12717 | 9 | player death check, held-NPC script, Soul of Shield effect, scripted map patch |
| `engine_004281` | 17025-17049 | 3 | three one-shot effect actors |
| `engine_005354` | 21332-21958 | 6 | ending sequence and its strings |
| `native_mode_brk_0055FC` | 22012-22046 | 1 | BRK vector (sound request) |
| `engine_00561E` | 22046-22430 | 4 | COP vector and the command tables |
| `engine_0064F8` | 25848-25911 | 3 | event-flag test, bit table, inventory lookup |
| `engine_0065A7` | 26023-26310 | 8 | actor footprint clear, slot arithmetic, spawn |
| `engine_006B7F` | 27519-28200 | 8 (+1 sub-label row) | title screen Mode 7 hook, file-select and save-slot menu |
| `engine_0074B1` | 29873-29907 | 1 | unreferenced animation loop |
| `engine_007A52` | 31314-31319 | 1 | dialogue tail string |

109 rows in total: the 106 top-level labels of the 15 files plus three sub-label rows (`loc_001ED3`, `loc_002B96`, `loc_006CC1`), each a separate routine that needs its own override row in PC because the namespace is flat.

Context that the callee/caller reading relied on: `engine_000000` (FM-A1, rows R25, R34-R39, R51, R52), `common_actor_001A28_part1.asm` lines 760-1239 (player dispatcher and the state table), the COP handlers `cop_handler_005E0D` (Cop3B), `_0059CC` (Cop14), `_005A28` (Cop19), `_005B79` (Cop26), `lib_0276A5`/`lib_0276C9` (gem add/subtract), `lib_0116C3` (soul effects), `lib_0118FC`, `common_actor_0031AD` and `w1_actor_01D045` (callers), plus `docs/walkthrough/items.md`, `magic.md`, `08-world-of-evil.md`.

## 0. Reading the tables

| Column | Meaning |
|--------|---------|
| Off / size | decimal file offset and size in bytes (distance to the next label; the last row of a file ends at the part end in `us/blocks.json`) |
| Callers | reference count and files, from `rg` over `extracted/` (`JSL`, `JSR`, branches, `BRL`, pushed addresses); cross-checked with `npm run audit -- --block=<name>`. "table" means pointer words in a data list. A bank byte and an address word pushed for an `RTL` jump count as one site |
| Name (conf, evidence) | proposed `VerbNoun` name. Confidence: **A** behaviour fully read and independently corroborated (consumer, walkthrough, existing doc or name); **B** behaviour fully read, purpose inferred from code only; **C** guessed or dead code. Evidence labels: `code`, `callee`, `caller`, `cons` (consumer), `walk` (walkthrough), `doc`, `hw`, `dead` |
| In / Out | registers, DP and WRAM inputs and results. M/X widths are those at entry unless stated. D is 0 |
| Clobbers | registers and scratch that are not restored, DP scratch bytes written |
| Data touched | WRAM names from `us/mnemonics.json` where one exists; otherwise the raw address (proposals for the unnamed ones are in section 5). `r` read, `w` write |

Actor fields are written `$nn,X` (WRAM absolute with X = actor slot, `$0800 + 0x40 * n`). DP scratch is written `dp$nn`. Field meanings are those of FM-A1 section 4.1.

A routine that is entered through `COP [85]`/`[84]`/`[B0]` is an **actor script**: it runs once per frame with X = its own slot, ends by yielding (`COP [91]`, `COP [82]`, `COP [1B]`, `RTL` with `$18` unchanged) or by `COP [86]` (kill self). A routine entered through `JSR`/`JSL` from a script is a **subroutine**.

## 1. Models that several rows share

### 1.1 Player attack and animation dispatch (`engine_routines_001D3B`)

`common_actor_001A28_part1` (the player script) chooses a handler from the 6-word states of `code_list_001B2B` (index `$1E * 6 + slot`, slot 0 = a swing button was pressed, slots 1-4 = the four d-pad directions plus idle; every state lists 6 words) or by direct `BRL` from `loc_001A7A` (no weapon) and `loc_001ACD` (armed walk). It jumps into the handler with an RTS trick (`DEC`, `PHA`, `RTS`) or a `BRL`; a handler never returns: it ends with `BRL common_actor_001A28_part1.loc_001A65`, the player loop.

Every handler is the same four steps: `LDA #anim`, `JSR code_001F9D` (publishes the animation to the weapon actor and recomputes attack and defence), `COP [80](#anim)`, `COP [82]` (play the animation and wait), then back to `loc_001A65`. Eight handlers choose between two animations with the carry flag (`BCS`); the carry is set by the caller path:

| Path | Carry on entry |
|------|----------------|
| `loc_001A7A` (no weapon) | clear |
| `loc_001ACD` (armed walk), direct `BRL` | set |
| table path `loc_001B19` | clear when `joy_pressed` has bit `$0030` (L or R) set, otherwise set |

`joy_pressed` is the raw `$4218` word (bit 15 B, 14 Y, 13 Select, 12 Start, 11-8 Up Down Left Right, 7 A, 6 X, 5 L, 4 R); `$8000` is B (the swing button), `$0030` L or R. The Phoenix swing handlers clear bit 15 of `joy_release_latch` with `TRB`, which consumes the B edge. Meaning of the carry in the table path beyond this (swing vs thrust) belongs to A10 (OQ-I006-4).

### 1.2 Lairs (`engine_0026F3`)

A lair is an actor with a `data_00BA0D` record (32 bytes, FM-A11 will define it). The record's script pointer (`+10`, 3 bytes) points at one of the five spawner scripts (417 references: `code_0026F3` 156, `code_00271B` 139, `code_002752` 107, `code_002813` 8, `code_0027D2` 7; `code_0027A0` has none). The lair keeps three counters: `$2E` (monsters alive; written by the child death script `code_002B86`), `$2F` (last synchronised count) and the lair index `$34` (index into `data_00BA0D` and into `$7F0203`). Monsters it spawns carry the lair slot in `$32`. All six spawners call the same subroutines:

| Step | Routine |
|------|---------|
| wait for the lair tile | `code_002842` (returns only while the tile `$FD` is under (x, y-16) in the `$7E8000` buffer; otherwise `PLA; RTL`, so the script restarts next frame) |
| spawn one monster | `code_0028ED` (free-slot check, `COP [84]`-style clone through `code_006662`, script `code_002928`) |
| delay | `code_002913` (`$14 = 3 * $26 - 1`, yield) |
| count and finish | `code_0028C6` (count sync; carry set when the last monster died) then `code_002871` (seal) |

### 1.3 Souls (`$1B82`)

`$1B82` is a bit field of recruited souls: `$01` Magician (set by `w0_actor_01A7AC` in Grass Valley), `$02` Light (`w1_actor_01D6AB`, Greenwood), `$04` Shield (`w2_actor_0F80A4`, St. Elles), `$08` Detection (`w4_actor_022E10`, Leo's Lab), `$10` Reality (`w5_actor_0251DC`, Magridd's Castle). The five effect routines in `lib_0116C3` test them in the order `$02`, `$10`, `$08`, `$04`; the `$04` routine spawns `engine_003005.code_00310F`. Walkthrough `items.md` agrees: Shield "protects you from the magma bombs", Reality "your orb of light circles over" hidden passages.

### 1.4 Death flow

Enemy: R35/R36 (FM-A1) installs `code_002A10` as the target's script; it drops gems, shows the EXP popup, then `code_002B7E` decrements the parent lair and kills the actor. Boss (`X == $039A`): `loc_002B96`. Player: `code_003005` runs once per frame after the hit passes (FM-A1 step 11): Medical Herb, Strange Bottle, Magic Bell, else zero the Gems and set `$16` bit `$0400` (the dying flag that `common_actor_001A28_part1` tests to enter `loc_001ED3`).

## 2. Routine table

### 2.1 COP and BRK dispatch

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| X001 | `native_mode_brk_0055FC` | 22012 / 34 | 0 (BRK vector `$FFE6`) | sound | `HandleBrkSoundRequest` (A; code, doc, A1 R13) | BRK `#n`: the signature byte follows the BRK opcode | `RTI`; one byte stored: `$0398` when `n` bit 6 is clear, else `$0399 = n and $BF` | A (saved), `dp$3B-$3D` | r the stacked return address (`$04,S` minus 1) and bank (`$06,S`), the signature byte via `[$3B]`; w `$0398` or `$0399` |
| X002 | `native_mode_cop_00561E` | 22046 / 26 | 0 (COP vector `$FFE4`) | COP dispatch | `DispatchCop` (A; existing block note, A1 R25) | COP `#id` and operands follow; X = actor slot | jumps to the handler with `dp$38/$3A` = script pointer past the id | A, Y (`TXY`) | w `dp$38`, `dp$3A` |
| X003 | `code_list_005638` | 22072 / 122 | 1 (indexed jump in X002) | COP dispatch | `CopHandlerTable_00_3C` (A; code, doc) | - | 61 handler pointers, ids `00`-`3C` | - | data |
| X004 | `cop_junk` | 22194 / 134 | 0 (never indexed: ids `3D`-`7F` have no handler; the words keep the next table at id `80`) | COP dispatch | `CopFillerTable_3D_7F` (A; existing note, dead) | - | 67 filler words (`#$0000`, `#$FFFF`) | - | data |
| X005 | `code_list_005738` | 22328 / 102 | 0 direct (reached by the same indexed jump, ids `80`-`B2`) | COP dispatch | `CopHandlerTable_80_B2` (A; code, doc) | - | 51 handler pointers | - | data |

### 2.2 Flags, inventory, actor pool

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| X006 | `code_0064F8` | 25848 / 30 | 4 (`cop_handler_00581D` x2, `cop_handler_00583E` x2) | flags | `TestEventFlag` (A; code, existing note, callers) | A = flag word (low byte bit 0-7 index into the mask table, high byte (and `$7F`) byte index) | carry set when the flag is set; X, Y preserved | A, `dp$00/$01` | r `event_flags` (`$1A5E`), `binary_006516` |
| X007 | `binary_006516` | 25878 / 8 | 3 (`cop_handler_005867_part2` x2, X006) | flags | `BitMaskTable` (A; code) | - | `01 02 04 08 10 20 40 80` | - | data |
| X008 | `code_00651E` | 25886 / 25 | 4 (`cop_handler_005874`, `_005888`, `_005A0F`, `_005A28`) | inventory | `LookupInventoryEntry` (A; code, existing note) | A (8-bit) = entry number, 1-based | carry set when the low 7 bits of the entry are zero (A preserved); else carry clear and A = the raw byte (bit 7 = equipped) | A, Y | r `inventory` (`$1B1E`) |
| X009 | `code_0065A7` | 26023 / 112 | 2 (`cop_handler_005970`, `cop_handler_0059FB`) | actor footprint | `ClearActorFootprint` (A; code, existing note, Cop15/16 pairing) | X = actor | tile-block bytes under the actor cleared | A, Y, `dp` scratch | r actor `$00-$12`; w tile map |
| X010 | `code_006617` | 26135 / 17 | 6 (`cop_handler_00590D`, `_0058A9`, `_0059B5`, `_00599E`, `_005970`, `_005C81`) | actor pool | `SlotNumberToActor` (A; code, existing note) | A = slot number | Y = `$0800 + A * $40` | A | - |
| X011 | `code_006628` | 26152 / 5 | 5 (`cop_handler_005970` x2, `_00590D` x2, `_0058A9`) | arithmetic | `MultiplyBy16` (A; code) | A | A = A * 16 | A | - |
| X012 | `code_00662D` | 26157 / 13 | 2 (`cop_handler_0059CC` Cop14, `cop_handler_005E0D` Cop3B) | switches | `RegisterSwitchOwner` (B; code, callers) | X = actor, A = switch id | records the actor in the table at `switch_owner_table`; A kept | A, Y | w `switch_owner_table` |
| X013 | `code_00663A` | 26170 / 40 | 4 (`cop_handler_005ECF`, `_0062FF`, `_006431`, `_0063E1`) | spawn | `SpawnActorAfter` (A; code, existing note) | X = spawner | Y = new actor linked after X and initialised (X014); carry set and Y = `$06AA` when no free slot | A, Y | w `actor_list_tail`, actor links `$3C/$3E` |
| X014 | `code_006662` | 26210 / 40 | 8 (`cop_handler_005CF0`, `_005D10`, `_005EEE`, `_006473`, `_006409`, `_006339`, `engine_000000` x1, `engine_0026F3` x1) | spawn | `SpawnActorBefore` (A; code, existing note) | as X013 | as X013, linked before X | A, Y | w `actor_list_head`, actor links |
| X015 | `code_00668A` | 26250 / 25 | 4 (`engine_000000` x2, X013, X014; long call `JSL`, ends `RTL`) | actor pool | `PopFreeSlot` (A; code, A1 R48) | `dp$4A` = free-stack pointer | Y = slot, carry clear; or carry set and Y = `$06AA`; the stack entry is zeroed and `dp$4A` advanced by 2 (low byte only) | A, Y | w `dp$4A` stack |
| X016 | `code_0066A3` | 26275 / 35 | 2 (X013, X014) | spawn | `InitSpawnedActor` (A; code, existing note) | X = source, Y = new actor | `MVN` copies `$3C` bytes (A = `$3B`, bank `$01`) from X to Y, then `$16 \|= $2000`, `$16 and= $FFEF`, `$1A = $30 = $14 = 0` | A | r/w actor |

### 2.3 Player attack and animation handlers (`engine_routines_001D3B`)

All handlers: In = X = player slot, carry as in 1.1. Out = never returns (`BRL loc_001A65`). Clobbers = A, Y; each `JSR code_001F9D` writes the weapon actor (`$3E,X`) fields `$1E/$20/$14` and `$1B8C/$1B8E`. Data touched is therefore the same for every row (`w $1B8C`, `w $1B8E`, `r $1B70-$1B76`) and is only listed where it differs. Callers: all handlers come from `common_actor_001A28_part1` through `code_list_001B2B` (table words) and some by direct `BRL`.

Names follow the animation ids because the pose each id shows (facing, armed or unarmed) is a question for A10 (OQ-I006-4); the carry-pair names list `carry clear / carry set`.

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | Behaviour |
|---|-------|-----------|---------|-----------|-----------------------|-----------|
| X017 | `code_001D3B` | 7483 / 30 | 80 (table words only) | player anim | `StartPlayerAnim01Or2B` (B; code, caller) | anim `$01` (carry clear) or `$2B` (carry set); `loc_001D4B` is the carry-set arm |
| X018 | `code_001D59` | 7513 / 30 | 8 (table) | player anim | `StartPlayerAnim00Or29` (B; code, caller) | `$00` / `$29`; sub-label `loc_001D69` |
| X019 | `code_001D77` | 7543 / 30 | 8 (table) | player anim | `StartPlayerAnim02Or27` (B; code, caller) | `$02` / `$27`; sub-label `loc_001D87` |
| X020 | `code_001D95` | 7573 / 30 | 8 (table) | player anim | `StartPlayerAnim03Or24` (B; code, caller) | `$03` / `$24`; sub-label `loc_001DA5` |
| X021 | `code_001DB3` | 7603 / 30 | 10 (table x8, `BRL` from `loc_001A7A` and `loc_001ACD`) | player anim | `StartPlayerAnim06Or2A` (B; code, caller) | `$06` / `$2A`; reached by the Up key on the no-weapon and armed-walk paths |
| X022 | `code_001DD1` | 7633 / 30 | 10 (table x8, two `BRL`) | player anim | `StartPlayerAnim04Or28` (B; code, caller) | `$04` / `$28`; Down key |
| X023 | `code_001DEF` | 7663 / 30 | 10 (table x8, two `BRL`) | player anim | `StartPlayerAnim08Or26` (B; code, caller) | `$08` / `$26`; Left key |
| X024 | `code_001E0D` | 7693 / 30 | 10 (table x8, two `BRL`) | player anim | `StartPlayerAnim0AOr25` (B; code, caller) | `$0A` / `$25`; Right key |
| X025 | `code_001E2B` | 7723 / 14 | 8 (table) | player anim | `StartPlayerAnim05` (B; code, caller) | `$05` |
| X026 | `code_001E39` | 7737 / 14 | 8 (table) | player anim | `StartPlayerAnim11` (B; code, caller) | `$11` |
| X027 | `code_001E47` | 7751 / 14 | 8 (table) | player anim | `StartPlayerAnim12` (B; code, caller) | `$12` |
| X028 | `code_001E55` | 7765 / 14 | 8 (table) | player anim | `StartPlayerAnim07` (B; code, caller) | `$07` |
| X029 | `code_001E63` | 7779 / 14 | 8 (table) | player anim | `StartPlayerAnim10` (B; code, caller) | `$10` |
| X030 | `code_001E71` | 7793 / 14 | 8 (table) | player anim | `StartPlayerAnim13` (B; code, caller) | `$13` |
| X031 | `code_001E7F` | 7807 / 14 | 8 (table) | player anim | `StartPlayerAnim0E` (B; code, caller) | `$0E` |
| X032 | `code_001E8D` | 7821 / 14 | 8 (table) | player anim | `StartPlayerAnim0D` (B; code, caller) | `$0D` |
| X033 | `code_001E9B` | 7835 / 14 | 8 (table) | player anim | `StartPlayerAnim0B` (B; code, caller) | `$0B` |
| X034 | `code_001EA9` | 7849 / 14 | 8 (table) | player anim | `StartPlayerAnim0F` (B; code, caller) | `$0F` |
| X035 | `code_001EB7` | 7863 / 14 | 8 (table) | player anim | `StartPlayerAnim0C` (B; code, caller) | `$0C` |
| X036 | `code_001EC5` | 7877 / 14 | 8 (table) | player anim | `StartPlayerAnim09` (B; code, caller) | `$09` |
| X037 | `loc_001ED3` (sub-label of X036, own label in PC) | 7891 / 40 | 1 (`BRL` from `common_actor_001A28_part1.loc_001A65` when the player `$16` has bit `$0400`) | player death | `PlayDeathAndReturnToShrine` (B; code, caller, walk) | Entry when the player is dying. `$24,X = $0B` (player anim bank), weapon actor `$24 = $0C`, `BRK #$84`, anim `$1C` and wait, then `scene_next = $03BA + 1` (world index plus one: scenes 1-7, the shrine of each world, OQ-I006-22), `COP [91]`, `RTL`. Data: w `scene_next`, r `$03BA`, `$039E` |
| X038 | `code_001EFB` | 7931 / 32 | 8 (table) | swing | `SwingSword21` (B; code, caller, walk) | `BRK #$01` (swing sound), X041 check; when carry is clear `COP [84]` spawns `engine_routines_002678.code_002678`; `TRB` bit `$8000` of `joy_release_latch`; anim `$21` |
| X039 | `code_001F1B` | 7963 / 32 | 8 (table) | swing | `SwingSword20` (B; code, caller, walk) | same, spawns `code_00268D`, anim `$20` |
| X040 | `code_001F3B` | 7995 / 32 | 8 (table) | swing | `SwingSword22` (B; code, caller, walk) | same, spawns `code_0026A4`, anim `$22` |
| X041 | `code_001F5B` | 8027 / 32 | 8 (table) | swing | `SwingSword23` (B; code, caller, walk) | same, spawns `code_0026B9`, anim `$23` |
| X042 | `code_001F7B` | 8059 / 32 | 4 (X038-X041) | Phoenix | `PayPhoenixCost` (A; code, callee, walk) | Out: carry clear when `$1B5E == $08` (Soul Blade), `$1B60 == $10` (Soul Armor), `$1B62 == $18` (Phoenix) and `COP [26](#$0002, ...)` could pay 2 Gems (the Gems are subtracted); carry set otherwise. Walkthrough: Phoenix needs Soul Blade and Soul Armor and costs Gems; Magic Armor halves and the Magic Bell zeroes the cost (Cop26). Data: r `$1B5E/$1B60/$1B62`, w Gems `$1B66/$1B68` (through Cop26), `$0332` bit `$10` |
| X043 | `code_001F9B` | 8091 / 2 | 4 (three `BNE` in X042, Cop26 jump operand) | Phoenix | `FailPhoenixCost` (A; code) | `SEC; RTS` |
| X044 | `code_001F9D` | 8093 / 50 | 33 (every handler, `JSR`) | player anim | `PublishPlayerAnim` (A; code, cons R35/R39) | In: A = anim id, X = player. `Y = $3E,X` (the weapon actor, `$039E`): `$1E,Y = A`, `$20,Y = 0`, `$14,Y = 0`; `$1B8C = $1B70` plus `$1B72` only when `A - $20 < 4`; `$1B8E = $1B74 + $1B76`. Out: A = 0, carry clear/set from the last add. Data: w `$1B8C`, `$1B8E`; r `$1B70-$1B76`. Answers OQ-I005-23 statically: the `$20-$23` animations are the four swing handlers X038-X041 |

The routine rows above are numbered X017-X044 (28 rows: 27 labels plus `loc_001ED3`); the Phoenix projectile scripts continue the numbering in 2.4.

### 2.4 Phoenix projectiles (`engine_routines_002678`)

Each of the four scripts is a one-shot actor: `JSR code_0026D0` (common init), `COP [A0]` (offset Y by one tile above or below), anim set, `COP [86]` after the burst. Movement is not in the script; it comes from the animation steps (bank `$0F` table). The flags written by X049 (`$16 = $02A0`: bit `$0200`, hit source `$0080`, projectile `$0020`) and the damage byte `$30 = $0014` are what R34/R36 consume. Callers: one each, `COP [84]` from X038-X041.

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| X045 | `code_002678` | 9848 / 21 | 1 (X038) | Phoenix | `PhoenixProjectileA` (B; code, caller) | X = new actor | script: `COP [A0](#$FFF0)`, anim `$30`, `COP [81](#$31, #$08)`, kill | A | actor `$16`, `$30`, `$1A`, `$22/$24` |
| X046 | `code_00268D` | 9869 / 23 | 1 (X039) | Phoenix | `PhoenixProjectileFlippedY` (B; code, caller) | as X045 | adds `COP [98]` (flip Y) and `COP [A0](#$0010)` (below) | A | as X045 |
| X047 | `code_0026A4` | 9892 / 21 | 1 (X040) | Phoenix | `PhoenixProjectileB` (B; code, caller) | as X045 | `COP [A0](#$FFF0)`, anims `$2E` / `$2F` (count 8), kill | A | as X045 |
| X048 | `code_0026B9` | 9913 / 23 | 1 (X041) | Phoenix | `PhoenixProjectileFlippedX` (B; code, caller) | as X045 | adds `COP [96]` (flip X) to X047's body | A | as X045 |
| X049 | `code_0026D0` | 9936 / 23 | 4 (X045-X048, `JSR`) | Phoenix | `InitPhoenixProjectile` (A; code, cons R34/R36) | X = projectile | `$16 = $02A0`, `$30 = $0014`, `COP [A3]`, `COP [A2](#$30)`, `COP [A8](#$8000, #$0F)` (animation table `$0F:8000`) | A | w actor `$16`, `$30`, `$22/$24` |

Directions: `$20`/`$21`/`$22`/`$23` map to `code_00268D` (flipped Y: below), `code_002678` (above), `code_0026A4`, `code_0026B9` (flip X) by the spawn calls in X038-X041. Which facing each animation id has is OQ-I006-3.

### 2.5 Lair scripts (`engine_0026F3`)

Callers of the five spawner entries are data records (section 1.2); `code_00299D` is a spawn target of `COP [85]`. In/out for the spawners: In = X = lair slot, entered as an actor script; Out = yields or ends by `JMP code_002871` (never returns to the caller).

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| X050 | `code_0026F3` | 9971 / 40 | 156 (data_00BA0D records) | lair | `RunLairSpawnForever` (B; code, caller) | lair actor | after the tile gate, loops: wait while `$16` bit 15 is set (off-screen), wait while the free-slot stack is empty (`LDA ($4A)` zero, `COP [27]`), `BRK #$53`, X057, X059, `COP [91]`, X056; carry set from X056 leads to X055. | A, Y | `$16`, `$26`, `$2E`, `$2F`, `$34`; `dp$4A` |
| X051 | `code_00271B` | 10011 / 55 | 139 (records) | lair | `RunLairSpawnFixedCount` (B; code, caller) | as X050 | gate, `$2C = $2E and $FF` (monsters to spawn), spawns that many with the same steps, then polls the count (X056) | A, Y | as X050, `$2C` |
| X052 | `code_002752` | 10066 / 78 | 107 (records) | lair | `RunLairSpawnFormation` (B; code, caller) | as X050 | spawns `$2E` monsters at positions from the formation table `data_00EE8E[$26 * 2]` (entries x, y, flip word), loader `code_00295E` | A, Y, `dp$16-$18` | `$26`, `$2E`, `data_00EE8E` |
| X053 | `code_0027A0` | 10144 / 50 | 0 (no record, no branch) | lair | `RunLairSpawnForeverFlipping` (C; code, dead) | as X050 | as X050, but cycles the flip bits with `ADC #$4000` into `$1C` | A, Y | as X050 |
| X054 | `code_0027D2` | 10194 / 65 | 7 (records) | lair | `RunLairSpawnFixedCountFlipping` (B; code, caller) | as X051 | as X051 with the flip cycle of X053 | A, Y | as X051 |
| X055 | `code_002813` | 10259 / 21 | 8 (records) | lair | `RunLairSpawnOnProximity` (B; code, caller) | as X050 | waits (`$16` bit 15), then `COP [0C](#0, #2, &code_002828)`: continues at X056 only when slot 0 (the player) is within the lair box plus 2 | A | `$16` |
| X056 | `code_002828` | 10280 / 26 | 1 (`COP [0C]` operand in X055) | lair | `SpawnWhenPlayerNear` (B; code, caller) | as X055 | as the X050 body once (free-slot check, spawn, delay, count, then `JMP code_002871`) | A, Y | as X050 |
| X057 | `code_002842` | 10306 / 47 | 6 (`JSR` from X050, X051, X052, X053, X054, X055) | lair | `WaitForLairTile` (B; code, caller) | X = lair | first call: stores the buffer offset of (x, y-16) in `$2C` via `lib_027462_part1.code_0272B8`; returns (`RTS`) only while the byte at `$7E8000 + $2C` is `$FD`; otherwise `PLA; RTL` (the caller script ends this frame and restarts) | A, Y | w `$2C`; r `$7E8000` buffer |
| X058 | `code_002871` | 10353 / 85 | 6 (`JMP` from X050, X051, X052, X053, X054, X056) | lair | `SealLair` (B; code, caller, walk) | lair actor, count reached zero | waits for `vram_write_queue == 0`; reads the byte `data_00BA0D+8` of record `$34 << 5` and calls `lib_0109D6_part1.code_0107AC` (non-zero) or `code_0106F1` (zero) with A = `$FE` at (x, y-16) (tile edit, `$FD` becomes `$FE`); the actor becomes an effect (`$16 = $0310`, `COP [A8](#$8000, #$0E)`, `BRK #$83`, anim 1) and dies | A, Y, `dp$16-$18` | r `vram_write_queue`, `data_00BA0D+8`; tile buffer |
| X059 | `code_0028C6` | 10438 / 39 | 6 (`JSR` from X050-X054, X056) | lair | `SyncLairCount` (B; code, caller) | lair actor | if `$2E == $2F` yields; else `$2F = $2E`; when the value is 0 stores 0 in `$7F0203[$34]` and sets carry | A | w `$2F`, `$7F0203` |
| X060 | `code_0028ED` | 10477 / 38 | 6 (`JSR` from X050-X054, X056) | lair | `SpawnLairMonster` (B; code, caller) | lair actor | `PHX; JSR code_006662` (spawn before), new actor `$16 = meta+6 or $8000`, script `code_002928` (bank 0), `$32 = lair slot`; `PLX` | A, Y | w new actor; r meta entry via `$38` |
| X061 | `code_002913` | 10515 / 21 | 5 (`JSR` from X050, X051, X053, X054, X056) | lair | `DelayBetweenSpawns` (B; code, caller) | lair actor, `$26` = interval | `$14 = 3 * $26 - 1`, `$18` = return address plus one; `RTL` (yield; the script resumes after the `JSR`) | A | w `$14`, `$18` |
| X062 | `code_002928` | 10536 / 54 | 1 (address built in X060) | lair | `SpawnMonsterEffect` (B; code, caller) | new monster actor | `COP [A8]`, anim 0 with `$1C` stashed in `$30`, `$26 = $3C`, `$16 = meta+6 or $8800`, falls into X063 | A, Y | actor |
| X063 | `code_00295E` | 10590 / 63 | 1 (`LDA #&code_00295E` in X052) plus fall-in from X062 | lair | `LoadMonsterFromMeta` (B; code, caller) | new monster actor, `$38` = meta entry | loads anim bank, script bank, anim, anim table and script from the meta entry, pushes script address and bank, `RTL` into the monster script | A, Y | w `$1E`, `$22`, `$24`, `$18`, `$36`; r meta entry |
| X064 | `code_00299D` | 10653 / 75 | 150 sites in 137 files (`COP [85](@code_00299D)`, for example `w1_actor_01D045`) | NPC and object spawn | `SpawnAppearPuff` (B; code, caller, walk) | any actor | if `scene_active` is 0 kills itself; else plays effect anim 2 centred on the actor, so an NPC or object "appears" with a puff, then kills | A | r `scene_active` |

### 2.6 Death, drops, boss, pickups (`engine_0029EC`, `engine_002EC0`)

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| X065 | `code_0029EC` | 10732 / 36 | 1 (`engine_003005.code_00310F`) | effect | `PlayHazardPuff` (B; code, caller) | actor script | `$36 = 0`, `$16 = $0300`, `COP [A3]`, `$1C = $0372`, anim table `$0E:$8000`, anim `$10`, kill | A | `$0372` |
| X066 | `code_002A10` | 10768 / 327 | 2 sites in `engine_000000` (R35 and R36 install it; bank and address pushed) | enemy death | `RunEnemyDeath` (A; code, cons, walk) | actor script of a defeated enemy | if `X == $039A` jumps to X073; else: effect table, `$16 = $0300`, drops a gem (below), plays the death puff `COP [80](#3)`, shows the EXP number (below), then `COP [91]`, `COP [82]`, `COP [1B](&code_002B7E, #$10)` | A, Y, `dp$00`, `dp$16-$18` | see below |
| X067 | `code_002B57` | 11095 / 4 | 2 (`JSR` in X066) | EXP popup | `AddDigitTile` (C; code) | A | writes a tile byte pair into the popup sprite map | A | `$7EF005+` |
| X068 | `code_002B5B` | 11099 / 25 | 2 (`JSR` in X066) | EXP popup | `WriteDigitSprite` (C; code) | A = digit, X, Y | one popup digit into the RAM spritemap using `data_002B74` | A, X | `$7EF000` area |
| X069 | `data_002B74` | 11124 / 10 | 1 (X068) | EXP popup | `ExpDigitTiles` (B; code) | - | `B7 C8 C9 D8 D9 CE CF DE DF A7`: tile bytes for the digits | - | data |
| X070 | `code_002B7E` | 11134 / 8 | 3 (`COP [1B]` operand in X066, `BNE`, `BRA` from X073) | enemy death | `FinishEnemyDeath` (B; code) | actor script | `LDY $32,X`; when zero (no parent lair) `BRL cop_handler_005CF0_part1.loc_002D40` (kill); else falls to X071 | A, Y | `$32` |
| X071 | `code_002B86` | 11142 / 16 | 1 (falls in from X070) | lair | `NotifyLairOfDeath` (B; code, caller) | Y = parent lair slot | decrements `$2E,Y` when non-zero, `COP [86]` | A | w `$2E,Y` |
| X072 | `loc_002B96` (sub-label of X071, own label in PC) | 11158 / 104 | 1 (`BRL` from X066 head) | boss | `RunBossDeath` (A; code, cons R35, walk) | boss actor | `$16 = $0700`, velocity cleared, `INC $042D`; stores the box into `$0425/$0427/$0429/$042B`; spawns 32 explosions (`COP [03](#$20)` between each `COP [84](@code_002BFE)`, `$14 = 3`); `JSR code_002C63` (kill every other actor); when `location_id == $7D` pushes `engine_005354.code_005354` and `RTL`s into the ending, else `COP [31](#2)` and `BRA code_002B7E` | A, Y | w `$042D`, `$0425-$042B` |
| X073 | `code_002BFE` | 11262 / 101 | 1 (`COP [84]` in X072) | boss | `RunBossExplosion` (B; code, caller) | X = explosion actor | random point in the boss box (`rng_state+1 and $7F`, reduced by the box size in a loop, offset by the box origin); `BRK #$85` when the low bit of the y roll is 0; anim 0; kill | A, Y | r `rng_state`, `$0425-$042B` |
| X074 | `code_002C63` | 11363 / 26 | 1 (`JSR` in X072) | boss | `KillAllOtherActors` (A; code, doc) | - | walks from `actor_list_tail` through `$3E`; every actor whose `$16 and $24D0` is zero gets `COP [86]` (flags `$2000`, `$0400`, `$0080`, `$0040`, `$0010` protect it) | A, Y | r `actor_list_tail`, links |
| X075 | `code_002C7D` | 11389 / 30 | 1 (`lib_0118FC` offset 72787) | menu | `KillAllProjectiles` (A; code, caller) | - | kills every actor with `$16` bit `$0020`; called from the menu when the equipped magic (`$1B62`) changed; P and X preserved | A, Y | `$1B62`, `$0435` |
| X076 | `code_002EC0` | 11968 / 26 | 1 (`w1_actor_01E4BB`, `COP [85]`) | pickup | `SpawnFixedGemPickup` (B; code, caller) | spawner | `$16 = $4000` (pickup), `COP [A4]`, `$1C = sprite_attr_base`, loops anim 7; picked up as 10 Gems by X080 (anim 7 falls into the default) | A | `$0372` |
| X077 | `code_002EDA` | 11994 / 16 | 1 (`COP [B0]` in X066) | pickup | `RunGemPickupSmall` (B; code, caller) | spawn target | `COP [A4]`, anim 4, then `COP [81](#9, #4)`, kill; worth 1 Gem | A | - |
| X078 | `code_002EEA` | 12010 / 16 | 1 (X066) | pickup | `RunGemPickupMedium` (B; code, caller) | as X077 | anim 5, then `$0A`; worth 5 Gems | A | - |
| X079 | `code_002EFA` | 12026 / 16 | 1 (X066) | pickup | `RunGemPickupLarge` (B; code, caller) | as X077 | anim 6, then `$0B`; worth 10 Gems | A | - |
| X080 | `code_002F0A` | 12042 / 76 | 1 (`engine_000000` offset 3874, R39) | pickup | `ApplyGemPickup` (A; code, callee) | actor X = the pickup, player contact | `PHP; PHY; REP #$20; BRK #$4D`; Gems added by anim `$1E`: `$06`/`$0B` give 10, `$05`/`$0A` give 5, `$04`/`$09` give 1, anything else gives 10; `JSL lib_0276A5` (BCD add with cap); `$0332 or= $10`, `$16 or= $2000`, `COP [86]`; `PLY; PLP; RTL` | A | w Gems `$1B66/$1B68`, `$0332` |

Gem drop (X066): `w = $03BA` (world index, 6 is replaced by `$19`); `t1 = 2w + 1`, `t2 = 4w + 4`; both double when `$1B5E == 4` (Lucky Blade, walkthrough "more Gems than usual"). `COP [1F]; COP [35](#$64)` rolls `random_mod_result` in 0-99. `< t1` drops X079 (10 Gems), `< t2` drops X078 (5 Gems), else X077 (1 Gem). World 0: 1 %, 3 %, 96 %; world 5: 11 %, 13 %, 76 %; world 6 (t1 = 51, t2 = 104) never drops 1 Gem.

EXP popup (X066): reads the BCD word `meta+3` (the entry's EXP), the digit count is 1 below `$10`, 2 below `$100`, 3 below `$1000`, else 4, the popup x offset shifts by +5, +3, +1 or -1, the animation id is the slot number (a popup per actor), `$22 = $F000`, `$24 = $7E` (the sprite map lives in RAM at `$7EF005+`).

### 2.7 Death check, souls, map patch, effects (`engine_003005`, `engine_004281`)

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| X081 | `code_003005` | 12293 / 38 | 1 (`JSL` at `engine_000000` offset 109, FM-A1 step 11) | player death | `CheckPlayerDeath` (A; code, caller, walk) | `PHP; REP #$20`, X = `player_actor` | returns doing nothing when the player `$16` has bit `$0400` or `player_hp or $043B != 0`. Else `COP [19](#$38, &code_00302B)`: Medical Herb equipped means `$043B = player_max_hp`, `COP [0B](#$38)` (remove it), exit | A, X, Y | r `player_actor`, `player_hp`, `$043B`, `player_max_hp`; w `$043B` |
| X082 | `code_00302B` | 12331 / 10 | 1 (jump operand in X081) | player death | `TryStrangeBottle` (A; code, walk) | as X081 | `COP [19](#$39, &code_003035)`: Strange Bottle equipped means `COP [0B](#$39)` and `BRA loc_003042` (die, Gems kept) | A | - |
| X083 | `code_003035` | 12341 / 7 | 1 (jump operand in X082) | player death | `TryMagicBell` (B; code) | as X081 | `COP [19](#$40, &code_00303C)`: Magic Bell equipped means `BRA loc_003042` (die, Gems kept, Bell not consumed; OQ-I006-1) | A | - |
| X084 | `code_00303C` | 12348 / 35 | 1 (jump operand in X083) | player death | `ZeroGemsAndDie` (A; code, walk) | as X081 | `STZ $1B66; STZ $1B68` (all Gems lost), then `loc_003042`: `$16 and= $F7FF`, `$16 or= $0400`, `joy_block_mask = $2080`, `INC $043F`, `PLP; RTL`. `$043F` is read and cleared by `common_actor_00766C` (death counter or flag) | A | w Gems, `$16`, `joy_block_mask`, `$043F` |
| X085 | `code_00305F` | 12383 / 176 | 54 lines in 27 files (each actor pushes `^code_00305F`, `&code_00305F-1`, `RTL`; for example `w1_actor_01D045`, `w2_actor_0F982F`) | NPC release | `HoldActorUntilReleased` (B; code, caller) | entered by `COP [3B]` (Cop3B) in the actor; `$34` = own switch id | `$16 and= $DFF7`, `$36 = 0`, saves `$1C` in `$32`, `COP [15]` (blocks its tiles), loops anim `$0D` until the bit named by the word `data_00BA0D+1E` of record `$34 << 5` is set in the switch array `$1ADE` (`lib_0273A2`); then `COP [16]`, sets bit `$34` in `$1A9E` and `$1ADE` (`lib_027348`), clears bit 6 of `$7F0203[$34]`, loads anim, bank, flags, anim table and script from the meta entry (`$38`), runs `engine_000000.code_0008F3`, zeroes `$14/$04/$06`, `RTL` into the real script | A, Y | `data_00BA0D`, `$1ADE`, `$1A9E`, `$7F0203` |
| X086 | `code_00310F` | 12559 / 121 | 1 (`COP [B0](@code_00310F, #$2010)` in `lib_0116C3.code_01172E`) | souls | `DestroyHazardsNearOrb` (A; code, caller, walk) | actor script of the Shield soul effect, `PHX/PLX` around it | box of 0x30 pixels around `$03A0` (the orb actor); every actor whose `$16 == $0301` inside it gets script `code_0029EC` and `$14 = 0`; the effect actor itself persists (the script returns without yielding, so it restarts every frame) | A, Y, `dp$16-$1A` | r `$03A0`, actor `$00/$02/$16` |
| X087 | `code_003188` | 12680 / 12 | 5 (`common_actor_0031AD`, `_0033C6`, `_004659`, `_004299`, `_004D8B`; each `COP [85]`) | scene | `RunLockedMapPatch` (B; code, caller) | spawned by a boss actor, `$30,Y` = patch id | `joy_block_mask = $FFFF`, `COP [1B](&code_003194, #1)` | A | w `joy_block_mask` |
| X088 | `code_003194` | 12692 / 19 | 1 (`COP [1B]` operand in X087) | scene | `ApplyMapPatchAndUnlock` (B; code, caller) | as X087 | waits for `vram_write_queue == 0`, `BRK #$83`, `A = $30,X`, `JSL lib_0108BB.code_0108BB` (copies a map rectangle record from `unk14_017504`), `COP [27](&code_0031A7)` | A, Y | r `vram_write_queue`, `$30` |
| X089 | `code_0031A7` | 12711 / 6 | 1 (`COP [27]` operand in X088) | scene | `ReleaseInputAndKill` (B; code, caller) | as X087 | `STZ joy_block_mask`, kill | A | w `joy_block_mask` |
| X090 | `code_004281` | 17025 / 8 | 2 (`common_actor_004102` `COP [B0]`, `common_actor_004248`) | effect | `PlayEffectAnim1B` (B; code, caller) | spawn target, `COP [B0]` flag `$0200` | anim `$1B` (the spawner's table, copied by X016), `COP [82]`, kill | A | - |
| X091 | `code_004289` | 17033 / 8 | 2 (same callers) | effect | `PlayEffectAnim1C` (B; code, caller) | as X090 | anim `$1C`, kill | A | - |
| X092 | `code_004291` | 17041 / 8 | 2 (same callers) | effect | `PlayEffectAnim1D` (B; code, caller) | as X090 | anim `$1D`, kill | A | - |

`$039A` is the boss slot: `common_actor_0031AD` (and the three other boss actors found in A1) store their slot in it before spawning X087, and X066 and R35/R36 compare it.

### 2.8 Ending (`engine_005354`)

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| X093 | `code_005354` | 21332 / 114 | 1 (pushed by X072 when `location_id == $7D`) | ending | `RunEnding` (A; code, caller, walk) | boss actor after Deathtoll's death | `$16 = $2010`, `INC $0466`, `COP [37]`, `COP [31](#0)`, waits `COP [03](#$F1)` frames, shows three strings (the choice of the second one depends on `$1B82 and $1F == 1`: one soul versus several), `STZ $1B82`, shows the last string, `COP [85](@code_0055B9)`, `COP [09](#$9F02)` (sets event flag `$1F02`), `$1B84 = 6`, `$031E = 1`, `COP [10](#$0700, #1, #$0070, #$0060)` (area 0, scene 7, anim 1, x `$70`, y `$60`), `COP [91]`, `RTL` | A, Y | w `$0466`, `$1B82`, `$1B84`, `$031E`, event flag `$1F02`; r `$1B82` |
| X094 | `asciistring_0053C6` | 21446 / 69 | 1 (X093) | ending text | `EndingTextDefeated` (A; code, walk) | - | "Finally, [02:2] defeated Deathtoll! Suddenly [02:2] heard a small voice-" | - | data |
| X095 | `asciistring_00540B` | 21515 / 48 | 1 (X093) | ending text | `EndingTextStaySingular` (A; code) | - | "I decided to stay here and seal the World of Evil" | - | data |
| X096 | `asciistring_00543B` | 21563 / 344 | 1 (X093) | ending text | `EndingTextStayPlural` (A; code) | - | "we decided ..." (the multi-soul variant; the table has no other readers) | - | data |
| X097 | `asciistring_005593` | 21907 / 38 | 1 (X093) | ending text | `EndingTextWorldFades` (A; code) | - | "The World of Evil began to disappear-" | - | data |
| X098 | `code_0055B9` | 21945 / 13 | 1 (`COP [85]` in X093) | ending | `RunEndingEffect` (C; code) | spawn target | `COP [A8](#$8000, #$0D)`, `COP [92](#$4D)`, `COP [94]`, kill; the effect is not decoded (OQ-I006-21) | A | - |

The walkthrough ends with "Enjoy the credits" and has no text for the warp to scene 00/07; the ROM sends the player there after the text (OQ-I006-11).

### 2.9 Title, Mode 7, file select (`engine_006B7F`)

Entry points: `code_006B7F` is called from `engine_000000` (NMI hook, line 512) and `loc_006CC1` from `common_actor_0066FC` (line 40, `BRL`). The Mode 7 registers belong to the title screen only (`location_id == $10`).

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| X099 | `code_006B7F` | 27519 / 38 | 1 (NMI hook, `engine_000000`) | title | `UpdateTitleMode7` (A; code, caller) | NMI, DBR `$00` assumed by caller | only when `location_id == $10`: X102 then X101, then copies `$0476/$0478/$047A/$047C` to `$046E/$0470/$0472/$0474`. Correction to FM-A1 section 1.2: the hook does not copy `$70xxxx` blocks; the `MVN` blocks are in X107 | A, X, Y | r `location_id`; w `$046E-$0475` |
| X100 | `code_006BA5` | 27557 / 3 | 0 | title | `RefreshTitleMatrixAlt` (C; code, dead) | - | `JSR code_006C50`, falls into X101 | A | - |
| X101 | `code_006BA8` | 27560 / 73 | 1 (X099) | title | `WriteMode7Matrix` (A; code, hw) | - | writes the double-write registers M7A, M7B, M7C, M7D, M7X, M7Y from `$046E-$0475` and `$046A-$046D` | A | w `M7A-M7Y`; r `$046A-$0475` |
| X102 | `code_006BF1` | 27633 / 95 | 1 (X099) | title | `BuildRotationMatrix` (B; code, hw) | `$047E` = angle (8-bit index), `$0480` = scale | `$0476 = cos`, `$0478 = sin`, `$047A = -sin`, `$047C = cos`, from `data_00F9F7.binary_00FCC4`/`binary_00FC84` and X104 | A, X, Y, `$00/$01` | r `$047E`, `$0480`; w `$0476-$047C` |
| X103 | `code_006C50` | 27728 / 80 | 1 (X100 only) | title | `BuildRotationMatrixAlt` (C; code, dead) | as X102 | alternative matrix routine (adds `$41`, `ASL`, table lookup) | A, X, Y | as X102 |
| X104 | `code_006CA0` | 27808 / 33 | 1 (X102) | title | `ScaleByMode7Multiply` (B; code, hw) | A = value, scale in M7B | 16x8 product from the hardware multiplier (MPYL/MPYM) in `dp$00/$01` | A | r `MPYL`, `MPYM`; w `M7A`, `M7B` |
| X105 | `loc_006CC1` (sub-label of X104, own label in PC) | 27841 / 15 | 1 (`BRL` in `common_actor_0066FC`) | file select | `EnterFileSelect` (B; code, caller) | title actor | `PHX; JSL lib_01232B; JSR code_006D4E; PLX; COP [1B](&code_006CD0, #1)` | A | - |
| X106 | `code_006CD0` | 27856 / 126 | 1 (`COP [1B]` operand in X105) | file select | `HandleFileSelectChoice` (B; code, caller) | file-select actor | slot from `$701FFE` (reset to 0 when 4 or more); `lib_0118FC_part2.code_0121E8` with A = 5 + slot * 256; choice 4 opens the erase menu (palette entry `$7F0006` set to `$03FF`, restored to `$7FFF`; erase writes `slot << 8` to `$700000,X` and `$701000,X`, X = slot * `$400`); otherwise `$03A4 = choice`, `JSL lib_027132`; carry set gives `scene_next = 1`, else `$1B90`; `warp_dest_anim = 1`, `warp_dest_x = $70`, `warp_dest_y = $60`, `STZ $0445`, `INC $0454`, `COP [91]`, `RTL` | A, X, Y | w `$03A4`, `scene_next`, `warp_dest_*`, `$0445`, `$0454`, `$700000` and `$701000` blocks |
| X107 | `code_006D4E` | 27982 / 218 | 1 (`JSR` in X105) | file select | `DrawSaveSlotMenu` (B; code, callee) | - | draws the menu string `lib_0143B0.asciistring_0143B0` through `lib_shared_012769`, then for each of 4 slots computes the `lib_shared_02716E` checksum (`dp$16`, `dp$18`) against `$7003FA/$7003FC`, copies main to backup or backup to main with `MVN` (`$3FE` bytes, `MVN #$70,#$70`) and prints the slot data (`$0447-$0453`, 0x14 bytes per entry) through `lib_01440D` | A, X, Y, `dp$16-$18` | r/w `$700000`, `$701000` slot blocks |

### 2.10 Dead and tail pieces

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| X108 | `code_0074B1` | 29873 / 34 | 0 | unknown | `LoopAnimUntil04` (C; code, dead) | actor script | loops anim 7 while `$0482 != 4`, then anims 7, 8, 9, `INC $0482`, `COP [91]`, `RTL`; `$0482` is written by `common_actor_0066FC` and `common_actor_00729D` | A | `$0482` |
| X109 | `asciistring_007A52` | 31314 / 5 | 6 (`common_actor_00766C` x4, `common_actor_00797B` x2) | dialogue | `DialogueTail` (C; code) | - | `[12][08:408][END]`; the same five bytes appear in about 12 files (OQ-I006-14) | - | data |

Row count: X001-X109 is 109 rows. Top-level labels per file: 27, 5, 15, 10, 5, 9, 3, 6, 1, 4, 3, 8, 8, 1, 1 = 106, plus the sub-label rows X037 (`loc_001ED3`), X072 (`loc_002B96`) and X105 (`loc_006CC1`).

## 3. Fan-in summary

| Group | Count | Note |
|-------|-------|------|
| Highest fan-in | `code_0026F3` 156, `code_00271B` 139, `code_002752` 107 (all `data_00BA0D` records); `code_00299D` 150 sites in 137 files; `code_001D3B` 80 table words; `code_00305F` 54 lines (27 sites) in 27 files | the lair scripts and `code_00299D` make `engine_0026F3` the most referenced file of the batch: 567 references from 138 files, 417 of them records |
| No reference at all | `code_0027A0`, `code_006BA5`, `code_0074B1`; `native_mode_brk_0055FC` and `native_mode_cop_00561E` are vectors; `cop_junk` is filler data | the first three are dead candidates (OQ-I006-5, -6, -7); `code_006C50` has only the dead `code_006BA5` as caller |
| External callers of `engine_0065A7` | 29 sites in 21 files (COP handlers, `engine_000000` x3, `engine_0026F3` x1) | the spawn helpers `code_006662` (8) and `code_00663A` (4) dominate |
| Callers of `engine_routines_001D3B` | one file, `common_actor_001A28_part1` | every handler except `loc_001ED3` is a table target |
| Callers of `engine_0029EC` | `engine_000000` (R35/R36), `lib_0118FC`, `engine_003005` | |
| Callers of `engine_003005.code_003188` | five boss actors | `common_actor_0031AD` stores `$039A` before the spawn |

## 4. Structures observed (consumer evidence only; widths are the access sizes seen)

### 4.1 Meta entry (14 bytes at `meta_tables_008000`, FM-A1 4.5), fields read in A2

`+3` EXP as a BCD word (X066 reads it as a word and picks the digit count); `+5` anim id (byte), `+6` flags word (OR `$8000` in X060/X062/X085), `+8` anim table pointer (word), `+A` anim bank (byte), `+B` script pointer (word), `+D` script bank (byte). Nothing new for `+0` to `+2`.

### 4.2 Lair counters and the record (`data_00BA0D`, 32 bytes at index `$34 << 5`, FM-A11 will confirm)

| Offset | Width | Evidence |
|--------|-------|----------|
| `+08` | byte (read with `SEP #$20`) | X058: non-zero selects `code_0107AC`, zero selects `code_0106F1` for the tile edit |
| `+10` | 3 bytes | script pointer of the lair actor (the 417 references into `engine_0026F3`) |
| `+14` | word | `$26` of the lair actor: spawn interval, or formation id for X052 |
| `+15` | byte | meta index |
| `+1E` | word | switch or lair id that X085 and Cop3B test in `$1ADE` |
| other offsets | - | not read by A2; `+13` stays unknown (OQ-I006-16) |

### 4.3 Lair actor fields

`$2C` (word) tile buffer offset or remaining spawn count; `$2E` (byte, with `$2F`) live count; `$32` (word) parent lair slot (children); `$34` (word) record and switch index; `$26` interval or formation id; `$14` delay counter.

### 4.4 Save slot (X106, X107)

4 slots at `$700000 + n * $400`, backup mirror at `+$1000`, checksum words at `+$3FA` and `+$3FC`, copy size `$3FE`; selected slot `$03A4`, last played slot `$701FFE` (word); loaded scene `$1B90`.

### 4.5 Joypad word (`joy_pressed` and `joy_release_latch`)

`$4218` layout (1.1). Settled here: `$8000` B, `$0030` L or R.

## 5. WRAM touched by A2 without a mnemonic (proposals only, nothing applied)

| Address | Use in A2 | Proposed name | Conf | Evidence |
|---------|-----------|---------------|------|----------|
| `$0398/$0399` | sound request word (A1 has it as `sound_request`) | `sound_request` | A | X001 |
| `$039A` | boss actor slot | `boss_actor` | B | X087 callers, X066 compare (A1 had C) |
| `$039E` | weapon actor slot (the `$3E` neighbour of the player) | `weapon_actor` | B | X044 |
| `$03A0` | orb actor slot used as the light centre | `orb_actor` | B | X086, walkthrough "little orb of light" |
| `$03A4` | selected save slot | `save_slot` | B | X106 |
| `$03BA` | world index (A1 `world_index`) | `world_index` | B | X037, X066 |
| `$0425/$0427/$0429/$042B` | boss explosion box x, y, width, height | `boss_box_x`, `boss_box_y`, `boss_box_w`, `boss_box_h` | B | X072, X073 |
| `$042D` | contact lock (A1 `contact_lock`) | `contact_lock` | B | X072 increments it |
| `$043B` | pending heal (A1) | `heal_pending` | A | X081 stores `player_max_hp` |
| `$043F` | death flag consumed by `common_actor_00766C` | `death_pending` | C | X084 |
| `$0445` | title-to-file-select switch | `title_state` | C | X106 |
| `$0454` | set after a file is chosen | `file_chosen` | C | X106 |
| `$0466` | set at the start of the ending | `ending_active` | C | X093 |
| `$046A-$0475` | Mode 7 register shadows (M7A-M7D, M7X, M7Y) | `m7_shadow_*` | B | X099, X101 |
| `$0476-$047C` | computed matrix (cos, sin, -sin, cos) | `m7_matrix_*` | B | X102 |
| `$047E/$0480` | Mode 7 angle and scale | `m7_angle`, `m7_scale` | B | X102 |
| `$0482` | animation counter, written by `common_actor_0066FC` and `common_actor_00729D` | `title_anim_step` | C | X108 |
| `$0372` | OAM attribute base (A1) | `sprite_attr_base` | B | X065, X066, X076 |
| `$1B64` | 4th equipment slot holds the equipped key item (bracelets `$35-$37`, Magic Bell `$40`); A1 called it `equipped_bracelet` | `equipped_accessory` | B | Cop26 (`$40`), `lib_0109D6_part3` (stores entry id when bit 7 of the inventory byte is set) |
| `$1B66/$1B68` | Gems as two BCD words (low and high, high capped at `$99:9999`) | `gems_low`, `gems_high` | A | X080, X084, `lib_0276A5` |
| `$1B78` | EXP (`player_exp`, mnemonic exists) | - | - | - |
| `$1B82` | recruited souls bit field (1.3) | `souls_flags` | A | six setters and the consumers |
| `$1B84` | set to 6 after Deathtoll | `ending_flag` | C | X093 (OQ-I006-12) |
| `$1B90` | scene loaded by a save file | `save_scene` | B | X106 |
| `$701FFE` | last-used save slot | `save_last_slot` | B | X106 |
| `$7E8000` | byte buffer in which `$FD` marks an intact lair tile | `lair_tile_buffer` (identity unknown) | C | X057, X058 (OQ-I006-23) |
| `$7EF000`, `$7EF005` | popup sprite pointers and sprite map | `popup_spritemap` | C | X066 |
| `$7F0203` | per-lair state bytes (A1) | `lair_state` | B | X059, X085 |
| `$1A9E`, `$1ADE` | switch bit arrays | `switch_bits_a`, `switch_bits_b` | B | Cop14, Cop3B, X085 |
| DP `$3B-$3D` | BRK scratch | - | A | X001 |
| DP `$4A` | free-slot stack pointer (A1) | `actor_free_ptr` | A | X015 |

## 6. Findings for later batches

- Correction to FM-A1 section 1.2: `engine_006B7F.code_006B7F` is the Mode 7 matrix hook (only for `location_id == $10`), not a block-copy routine. The `MVN` save-slot mirror is in `code_006D4E`, which runs from the file-select entry, not from the NMI.
- OQ-I005-23 is answered statically (X044, X038-X041). OQ-I005-24 is answered in part: the Magic Bell (`$40`) occupies `$1B64` and Cop26 tests it; the Medical Herb and Strange Bottle are tested through inventory bit 7 (Cop19).
- OQ-I005-15: `$039A` is the boss slot (stored by the boss actors, tested in X066).
- The lair system is data driven: `data_00BA0D` (batch A11) holds the script pointer, interval and switch ids; A11 should define the 32-byte struct from sections 1.2 and 4.2.
- The player attack state table (`code_list_001B2B`) belongs to A10; section 1.1 gives the carry and button facts it needs.
- `docs/cop/index.md` should say that Cop26 pays (subtracts) the Gems when it can, not only tests (X042).
- Suggested names for PC with their risks: the 28 handler names in X017-X044 are mechanical (`StartPlayerAnimNN`); once A10 knows the facing they should be renamed, so PC may prefer to hold them back.
- Dead candidates to confirm with the profiler: `code_0027A0`, `code_006BA5`, `code_006C50`, `code_0074B1`.
