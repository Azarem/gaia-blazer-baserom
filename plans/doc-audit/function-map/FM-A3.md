# FM-A3: `cop_handlers`

PA batch A3, iteration I007. Read-only analysis: no names, notes, comments, `blocks.json`, `overrides.json` or docs were changed. Every proposed name below is a proposal for step PC (`npm run names`); every unverified claim is an `OQ-I007-k` row in `plans/extracted-audit/questions/I007_questions.md`.

Source: a fresh `npm run extract:lt` of `extracted/cop_handlers/`. All 110 files were read end to end; offsets are decimal file offsets (the `{n}` tag; LoROM, so SNES address = `$(offset >> 15):(8000 + (offset & 7FFF))`; every A3 routine is in bank `$00`, so a label `cop_handler_00583E` is at `$00:D83E`, that is `$00:8000 + hex(name)`; `code_002C9B` is at `$00:AC9B`).

| File group | Offsets | Top-level labels | Content (this batch's reading) |
|------------|---------|------------------|--------------------------------|
| `cop_handler_005CF0_part1` | 11419-11623 | 7 (+1 sub-label row) | not COP handlers: the actor scripts spawned by Cop31/Cop32 (music load through the SPC IPL) and the respawn-or-kill routine `loc_002D40` |
| `cop_handler_00579E` .. `_00613x` (ids 00-3C) | 22430-24186 | 57 (+4 sub-label rows, 2 helper labels) | script-control, flag, inventory, text, scene, tile, spawn, random and player handlers |
| `cop_handler_005E7A` .. `_006431` (ids 80-B1) | 24186-25715 | 51 | animation, actor-field, player-relative, spawn handlers |
| `cop_handler_006473` | 25715-25804 | 1 (+9 sub-label rows) | `CopB2` and the shared exit chain |
| `cop_handler_005867_part2`, `_0059F4_part2` | 25804, 25911 | 2 | engine helpers `code_0064CC` (write event flag) and `code_006537` (block actor footprint) |

132 rows in total: the 119 top-level labels of the 110 files plus 13 sub-label rows (`loc_005849`, `loc_0058C0`, `loc_005BD0`, `loc_002D40` and the nine exit-chain labels `loc_0064B5` .. `loc_0064C9`), each of which is referenced from another label or is an entry point and therefore needs its own override row in PC (the namespace is flat). About 90 other sub-labels are internal branch targets and have no row.

Context that the reading relied on: `engine_00561E` (dispatcher and the two handler word tables), `engine_0064F8` (flag test, inventory lookup), `engine_0065A7` (slot arithmetic, spawn helpers), `lib_027462_part1/part2` (`code_0272B8` tile index, `code_02731A` step east), `lib_0273A2` (bit array test), `lib_0276A5/0276C9` (gem add/subtract), `lib_0275ED` and `lib_027614` (pending heal and pending EXP), `lib_01065B` and `lib_0106CD` (table-driven animation), `lib_0124EE` and its strings (name entry), `lib_0109D6` (return record), `common_actor_001A28_part1` (player script), `data_00F9F7.table_00FB49` (music pointers), `common_shared_0FEEA6.code_0FEFF5` (SPC upload), `docs/audio/spc-disassembly.md`, `docs/cop/index.md`, `docs/walkthrough/` (`01-in-the-beginning.md`, `magic.md`, `level-up.md`) and `plans/doc-audit/walkthrough-crosswalk.md` section 4, plus FM-A1 and FM-A2.

## 0. Reading the tables

| Column | Meaning |
|--------|---------|
| Off / size | decimal file offset and size in bytes (distance to the next label; sizes of sub-label rows are split from the label they sit in, so the two rows add up to the handler's own size) |
| Callers (uses) | reference count and files from `rg` over `extracted/` (`JSL`, `JSR`, branches, `BRL`, pointer words). Every handler has exactly one reference: its pointer word in `code_list_005638` (ids 00-3C) or `code_list_005738` (ids 80-B2) in `engine_00561E`. "uses" is the measured count of `COP [id]` statements in all of `extracted/` (engine code included), so it counts script call sites, not executions |
| Name (conf, evidence) | current name `->` proposed `VerbNoun` name (the `CopNN_` prefix stays), or `keep`. Confidence: **A** behaviour fully read and independently corroborated (consumer, walkthrough, existing doc or name); **B** behaviour fully read, purpose inferred from code only; **C** guessed or dead code. Evidence labels: `code`, `callee`, `caller`, `cons` (consumer), `walk` (walkthrough), `doc`, `hw`, `dead` (0 uses) |
| In / Out | script operands in order, then the effect. Operand types: `b` byte, `w` word, `&c` code pointer (word, relative to the script bank `$3A`), `t` jump target (`&c`), "slot" = actor slot number. M/X are 16-bit on entry (COP entrancy); handlers that switch to 8-bit restore 16-bit before the exit |
| Clobbers | registers and DP scratch that are not restored. All handlers end by `BRL` into the exit chain (section 1.1); A and Y are always free on exit, P is not preserved |
| Data touched | WRAM names from `us/mnemonics.json` where one exists; otherwise the raw address (proposals for the unnamed ones are in section 5). `r` read, `w` write |

Actor fields are written `$nn,X` (WRAM absolute with X = actor slot, `$0800 + 0x40 * n`). DP scratch is written `dp$nn`. Field meanings are those of FM-A1 section 4.1 and FM-A2. "Target" in a row means the actor named by a slot operand (`code_006617`: Y = `$0800 + 0x40 * slot`).

Common convention of the 108 real handlers (confirmed on every file): the dispatcher `native_mode_cop_00561E` sets `Y` = actor slot, `dp$38` = address of the first operand byte (the id byte plus one) and `dp$3A` = script bank; the handler starts with `TYX`, consumes operands with `LDA [$38]` / `INC $38`, and leaves through the exit chain.

## 1. Models that several rows share

### 1.1 The exit chain (`cop_handler_006473`, rows H001-H009)

Nine labels after `CopB2` form the only exits. Each skip label is one `INC $38` (2 bytes) and falls into the next, so entering at label *k* skips *k* operand bytes that the handler did not consume.

| Row | Label | Off | Effect | Sites |
|-----|-------|-----|--------|-------|
| H001 | `loc_0064B5` | 25781 | skip 5, continue | 1 (Cop30) |
| H002 | `loc_0064B7` | 25783 | skip 4, continue | 1 (the shared tail `loc_005849` of Cop07/08) |
| H003 | `loc_0064B9` | 25785 | skip 3, continue | 2 (Cop0D, Cop30) |
| H004 | `loc_0064BB` | 25787 | skip 2, continue (a not-taken jump with one `&c` operand) | 21 in 20 files |
| H005 | `loc_0064BD` | 25789 | skip 1, continue | 3 (CopAD) |
| H006 | `loc_0064BF` | 25791 | continue at `$38` (`LDA $38`), falls into H007 | 68 in 66 files, +1 inside `CopB2` |
| H007 | `loc_0064C1` | 25793 | `STA $02,S; RTI`: A becomes the low word of the saved return address, so the script continues at A (a jump when A is the target) | 29 in 29 files, plus the fall-through from H006 |
| H008 | `loc_0064C4` | 25796 | `$18,X = $38`, falls into H009 | 3 (Cop05, Cop92, Cop93) |
| H009 | `loc_0064C9` | 25801 | `PLA; PLA; RTL`: drops the COP frame and returns to the scheduler (yield); `$18,X` is left as it is | 11 in 11 files, plus the fall-through from H008 |

A handler therefore has four possible ends: **continue** (H006), **jump** (H007 with A = target), **yield with the current resume pointer** (H009: the actor next runs at the old `$18,X`, which is why the delaying handlers store `$18` first) and **save `$38` as resume pointer and yield** (H008). Cop86 (kill) does not end the script: it continues through H006 and the script normally has an `RTL` next.

### 1.2 Yield and resume

The scheduler (FM-A1 R32) calls the script at `$36,X`:`$18,X` once `$14,X` (wait counter) reaches 0. The handlers that set up a resume:

| Handler | `$18` becomes | `$14` | Next run |
|---------|---------------|-------|----------|
| Cop05 (wait flag), CopAD (wait on screen) | the address of the COP instruction itself (`$38 - 2`: opcode, signature byte) | CopAD: poll interval byte; Cop05: unchanged | the same command again, until its condition clears |
| Cop1B | operand `&c` | operand word | the target after the delay |
| Cop27 | operand `&c` | 0 | the target next frame |
| Cop80, Cop81, Cop9D | `$38` after the operand (the next COP, normally `COP [82]`) | unchanged | `COP [82]` steps the animation each frame |
| Cop91 (`SetEntryHere`), Cop92, Cop93 | `$38` | unchanged | the next command (Cop91 continues at once) |
| Cop03/Cop04 | Cop03: `$38` and `$2C = $38`; Cop04 (not last pass): `$18 = $2C` | unchanged | the body restarts one frame later, so each pass of a `Cop03`/`Cop04` loop costs one frame |

Cop3B, Cop82, Cop83, Cop94, Cop95 and Cop04 (last pass excluded) yield through H009 and rely on `$18` being set by an earlier command.

### 1.3 Flag word, event flags, switches and inventory

**Flag word** (Cop05, 07, 08, 09 and `code_0064CC`, `code_0064F8`): bits 0-7 = bit number (the table `binary_006516` has 8 masks), bits 8-14 = byte index into `event_flags` (`$1A5E`, so 128 bytes `$1A5E-$1ADD`), **bit 15 = the value `v`**. The handlers use `v` as a comparison value: Cop09 writes `v` into the flag; Cop07 jumps when flag = `v`; Cop08 jumps when flag != `v`; Cop05 waits while flag = `v`. With bit 15 clear this reads as the names say (Cop07 jumps when clear, Cop05 waits until set); with bit 15 set they invert (OQ-I007-1). Bit-15-set operands are common (for example `common_actor_00797B`: `COP [07] (#$9F06, &code_007995)`; `common_actor_006E28`: `COP [08] (#$9B00, ...)`).

**Switches** (Cop14, Cop3B): a switch id indexes the 128-byte array `$1ADE-$1B5D` through `lib_0273A2` (A = bit word, Y = array base, carry = bit), and registers the calling actor as the switch's owner in `switch_owner_table` (`$7F0483`, one word per id) through `code_00662D`. `$7F0203` holds one byte per switch id (proposed `lair_state`); bit 6 (`$40`) is tested by Cop3B. The event-flag range ends where the switch array begins, but A2 `X085` writes bit `$34` in `$1A9E`, which is `event_flags + $40` (OQ-I007-20).

**Inventory** `$1B1E`: entry *n* (1-64, the item ids of the crosswalk section 4) is the byte at `$1B1E + n - 1`; bits 0-6 are the value, bit 7 = equipped. `code_00651E` (A2 X008): in A (8-bit) = n; out carry set = value bits 0 (not owned; A kept), else carry clear, A = raw byte, Y = n - 1, N = bit 7. Cop0A gives the item only when not owned; Cop0B removes it (an equipped entry becomes `$80`, an unequipped one `$00`; an equipped one also zeroes `$1B64`); Cop18 and Cop19 branch on it.

**Gems** are BCD words `$1B66`/`$1B68` (`lib_0276A5` add with cap, `lib_0276C9` subtract with carry = insufficient); `$0332` is the HUD dirty mask (`$02` EXP, `$04` HP, `$10` Gems).

### 1.4 Spawn model (Cop84/85, AB/AC, AF/B0, B1/B2, 30, 31, 32)

All eight spawn handlers call `code_00663A` ("After": links the new actor on the `$3C` side of the caller) or `code_006662` ("Before": on the `$3E` side), which pop a slot from the free stack (`dp$4A`, Cop86 pushes) and clone the caller's `$3C` bytes with `code_0066A3` (`$16 |= $2000`, `$16 &= $FFEF`, `$1A`, `$30` and `$14` zeroed). The list is run from `actor_list_tail` through `$3E` to the head (FM-A1 4.1), so a "Before" actor runs later in the same frame and an "After" actor first runs next frame (OQ-I007-25). The handler then stores `$18,Y` = the operand `&c` and `$36,Y` = the operand bank byte. The "absolute", "relative" and "flags" variants additionally **store** (not add) words into the new actor:

| Handler | Operands after `&c`, bank | Stored in the new actor |
|---------|--------------------------|-------------------------|
| Cop84, Cop85 | none | nothing (the clone keeps the caller's position) |
| CopAF, CopB0 | `w` flags | `$16` = flags |
| CopAB, CopAC | `w` x, `w` y, `w` flags | `$00` = x, `$02` = y (absolute), `$16` = flags |
| CopB1, CopB2 | `w` dx, `w` dy, `w` flags | `$00` = caller x + dx, `$02` = caller y + dy, `$16` = flags |

This answers OQ-I006-19 statically: the flags variants store `$16`, they do not add (the old extracted names and `docs/cop/index.md` say "flags"/"adds"). The carry from `code_00668A` (set and Y = `$06AA` when no slot is free) is ignored by every spawn handler (OQ-I007-26).

### 1.5 Tile footprint and tile sampling

`tile_type_map` (`$7F8000`) holds one word per tile; only the low byte is the field: the high nibble of the low byte is the "blocked" mark (`$F0`), the low nibble is the tile type. `lib_027462_part1.code_0272B8` (in `dp$16` = x pixel, `dp$18` = y pixel; out X = byte index): the index is `((map_width_pages * (y >> 8) + (x >> 8)) << 8) + (y & $FF) + ((x >> 4) & $0F)` (the multiply uses the hardware multiplier, an index of `$4000` or more gives 0). A page is 16x16 tiles: the low byte of the index should be `(y & $F0) + column`, but `y & $0F` is not masked, so for a y that is not a multiple of 16 the column shifts by `y & $0F` and the low byte can overflow without a carry (OQ-I007-7). `code_02731A` steps X one column east, wrapping to the next page row (`+ $F1`).

Single-tile samples use the footprint row `y - $10` (y is the bottom edge). Cop22 samples the row `y` itself (below the actor), Cop21 `y - $10 - h` (above), Cop23 `x - 16` and Cop24 `x + w` (left and right). Block = `ORA #$00F0`; unblock (Cop2B) = `AND #$FF00`, which also clears the type nibble (OQ-I007-6). Cop29 reads the parallel byte buffer `$7E8000,X`.

### 1.6 Text and menus

Cop01 sets DBR to the script bank (`$3A`) around `code_012C27`; the string pointer operand is relative to that bank. Cop02, Cop1A call `code_012769` (forces bank `$02`, so the string pointer is a bank-`$02` offset, which is why Cop02 passes `#$&lib_014F02.asciistring_014F02`) and `code_012281` (menu: A = option count, returns the selection in A, carry set = cancelled), then `LDX $03F7; JSL code_012BDA` (erase the box at the position `code_012769` saved in `$03F7`) and `vram_upload_flags = 1`.

### 1.7 Music load through the SPC IPL (Cop31, Cop32, rows H123-H132)

Cop31 and Cop32 spawn a small actor (`code_002C9B` / `code_002CCB`, `$30` = track index) that talks to the SPC700 through `APUIO0` (`$2140`) and then re-uploads the sound engine's music block through the IPL boot ROM:

| Step | Row | Port 0 write | Wait |
|------|-----|--------------|------|
| 1 (Cop31 only) | H125 | `$F1` | H126: read-back equals `$F1` |
| 2 (Cop31 only) | H126 | `$01` | H127: read-back is 0 |
| 3 | H128 (Cop32 starts here) | `$F0` | H129: read-back is 0, then a 2-frame delay |
| 4 | H130 | `$FF`, then the upload of `table_00FB49[$30]` | none (NMI off during the upload) |
| 5 | H131 | `$01` | none; `$0458` = 0; the actor kills itself |

`docs/audio/spc-disassembly.md` lists the SPC commands: `$F0` StopAllChannels, `$F1` HandleFadeIn (sets the fade registers `$30 = $FF`, `$31 = $7F`), `$FF` HandleBootHandshake (returns the SPC to the IPL boot loop that answers `$BBAA`). `common_shared_0FEEA6.code_0FEFF5` is the IPL uploader (waits for `$BBAA`, answers `$CC`, then sends the block bytes). `table_00FB49` is 21 long pointers (`@music_0F6D31` ... `@music_0C6897`, indices `$00-$14`); the indices used by scripts are `$00`, `$02`, `$0D`, `$11`, `$12`, `$13`.

### 1.8 Player-relative operands

Threshold handlers (Cop89-8C, Cop9A-9C) use `d = player - actor` (`player_x` `$0374` against `$00,X`, `player_y` `$0376` against `$02,X`; y is the actor's bottom edge). Cop89/8A jump when `|d| <= threshold`, Cop8B/8C when `|d| > threshold`. Cop9A/9B take a threshold and three targets (`[+2]` left/above, `[+4]` within, `[+6]` right/below) and always jump. The test is asymmetric: left uses `|d| - 1 >= threshold` (because `EOR #$FFFF` without `INC` gives `|d| - 1`), right uses `d >= threshold`. Cop9C takes two targets: the first when `|dx| > |dy|`, the second otherwise.

## 2. Routine tables

Each table is a family; rows are in offset order inside the family. Ids `H001-H132` are unique across the document.

### 2.1 Exit chain (`cop_handler_006473`)

| Id | Label | Off / size | Callers (uses) | Name (conf, evidence) | In / Out | Clobbers | Data touched |
|----|-------|-----------|----------------|-----------------------|----------|----------|--------------|
| H001 | `loc_0064B5` | 25781 / 2 | 1 (Cop30) | `CopExitSkip5` (A; code, header comment) | in `dp$38`; out: `$38 += 5`, continues at H006 | none | w `dp$38` |
| H002 | `loc_0064B7` | 25783 / 2 | 1 (`loc_005849`) | `CopExitSkip4` (A; code) | `$38 += 4`; reached by a not-taken Cop07/08 (flag word and target) | none | w `dp$38` |
| H003 | `loc_0064B9` | 25785 / 2 | 2 (Cop0D, Cop30) | `CopExitSkip3` (A; code) | `$38 += 3` | none | w `dp$38` |
| H004 | `loc_0064BB` | 25787 / 2 | 21 sites in 20 files | `CopExitSkip2` (A; code) | `$38 += 2`; the not-taken path of every jump with one `&c` operand | none | w `dp$38` |
| H005 | `loc_0064BD` | 25789 / 2 | 3 (CopAD) | `CopExitSkip1` (A; code) | `$38 += 1` | none | w `dp$38` |
| H006 | `loc_0064BF` | 25791 / 2 | 68 sites in 66 files, +1 in CopB2 | `CopExitContinue` (A; code) | `A = $38`, falls into H007 | A | r `dp$38` |
| H007 | `loc_0064C1` | 25793 / 3 | 29 sites in 29 files, +fall-through | `CopExitJump` (A; code) | in A = new script pointer; `STA $02,S; RTI` (bank unchanged) | none (RTI restores P) | w stack |
| H008 | `loc_0064C4` | 25796 / 5 | 3 (Cop05, Cop92, Cop93) | `CopExitSaveResume` (A; code) | `$18,X = $38`, falls into H009; X must be the slot (every handler did `TYX`) | A | r `dp$38`; w `$18,X` |
| H009 | `loc_0064C9` | 25801 / 3 | 11 sites in 11 files, +fall-through | `CopExitYield` (A; code) | `PLA; PLA; RTL`: returns to the scheduler | A | none |

### 2.2 Script flow

| Id | Label | Off / size | Callers (uses) | Name (conf, evidence) | In / Out | Clobbers | Data touched |
|----|-------|-----------|----------------|-----------------------|----------|----------|--------------|
| H010 | `Cop00_Yield` | 22430 / 4 | table (0) | keep `Cop00_Yield` (A; code, dead) | no operand; yields through H009 without changing `$18` | A | none |
| H011 | `Cop03_LoopStart` | 22517 / 22 | table (229) | keep (A; code) | `b` count: `$2E,X = count`, `$2C,X = $38`, `$18,X = $38`, continues | A | w `$2C`, `$2E`, `$18` |
| H012 | `Cop04_LoopNext` | 22539 / 18 | table (228) | keep (A; code) | `$2E,X -= 1`; zero: continues; else `$18,X = $2C,X` and yields (one pass per frame) | A | r/w `$2E`; r `$2C`; w `$18` |
| H013 | `Cop05_WaitFlag` | 22557 / 27 | table (70) | `Cop05_WaitFlag` -> `Cop05_WaitWhileFlagEquals` (A; code, doc) | `w` flag word: flag != `v` continues (skip 2); flag = `v` rewinds `$38` by 2 (the COP instruction), saves it and yields | A, Y, `dp$00`, `dp$01` | r `event_flags`; w `$18` |
| H014 | `Cop06_Jump` | 22584 / 6 | table (0) | `Cop06_Jump` -> `Cop06_Goto` (A; code, dead) | `t`: continues at the target | A | none |
| H015 | `Cop07_JumpIfFlagClear` | 22590 / 5 | table (190) | `Cop07_JumpIfFlagClear` -> `Cop07_JumpIfFlagEquals` (A; code) | `w` flag word, `t`: jumps when flag = `v` (bit 15), else skip 4; `BRA` into H017 | A, Y, `dp$00-01` | r `event_flags` |
| H016 | `Cop08_JumpIfFlagSet` | 22595 / 6 | table (7) | `Cop08_JumpIfFlagSet` -> `Cop08_JumpIfFlagNotEquals` (A; code) | same operands; `EOR #$8000` inverts `v` first, then falls into H017 | A, Y, `dp$00-01` | r `event_flags` |
| H017 | `loc_005849` | 22601 / 30 | 2 (Cop07 `BRA`, Cop08 fall-in) | `CopFlagJumpTail` (A; code) | in A = flag word (bit 15 = `v`); tests through `code_0064F8` (A2 X007, X preserved); jump taken: skips the flag word, reads the target, H007; not taken: H002 | A, Y, `dp$00-01` | r `event_flags` |
| H018 | `Cop1B_SetResumeAndDelay` | 23176 / 22 | table (211) | `Cop1B_SetResumeAndDelay` -> `Cop1B_DelayThenGoto` (A; code) | `&c`, `w` frames: `$18,X = &c`, `$14,X = frames`, yields | A | w `$18`, `$14` |
| H019 | `Cop27_SetResumeAndYield` | 23473 / 16 | table (81) | `Cop27_SetResumeAndYield` -> `Cop27_YieldThenGoto` (A; code) | `&c`: `$18,X = &c`, `$14,X = 0`, yields | A | w `$18`, `$14` |
| H020 | `Cop91_SetEntryHere` | 24675 / 18 | table (414) | keep (A; code, doc names it) | no operand: `$36,X = $3A` (script bank), `$18,X = $38`, continues. `docs/cop/index.md` lists 0 uses; the measured count is 414 | A | w `$36`, `$18` |

### 2.3 Flags and switches

| Id | Label | Off / size | Callers (uses) | Name (conf, evidence) | In / Out | Clobbers | Data touched |
|----|-------|-----------|----------------|-----------------------|----------|----------|--------------|
| H021 | `Cop09_SetOrClearFlag` | 22631 / 13 | table (213) | `Cop09_SetOrClearFlag` -> `Cop09_WriteFlag` (A; code) | `w` flag word: writes `v` (bit 15) into the flag through H022; continues | A, Y, `dp$00-01` | w `event_flags` |
| H022 | `code_0064CC` | 25804 / 44 | 1 (Cop09) | `WriteEventFlag` (A; code, existing note) | in A = flag word; sets (bit 15 set) or clears the bit `binary_006516[bit]` in `event_flags[index]`; X preserved; 16-bit on return | A, Y, `dp$00-01` | w `event_flags`; r `binary_006516` |
| H023 | `Cop14_JumpIfSwitchSet` | 22988 / 40 | table (245) | keep (A; code, cons) | `w` switch id, `t`: registers X in `switch_owner_table[id]` (`code_00662D`); switch set: `$16 &= $DFFF` (clears the hidden/inactive bit) and jumps; clear: skip 2 | A, Y, `lib_0273A2` scratch | r/w `switch_owner_table`; r `$1ADE` array; w `$16` |
| H024 | `Cop3B_JumpIfSwitchSetData` | 24077 / 95 | table (28) | `Cop3B_JumpIfSwitchSetData` -> `Cop3B_JumpIfSwitchSetElseHold` (B; code, caller A2 X085) | `w` switch id (peeked, then consumed), `t`: registers X as owner; Y = id * 32; record word `data_00BA0D+1E`: zero or its gate switch set: own switch set -> `$16 &= $DFFF`, jump; own switch clear -> yield through H009 (no resume update). Gate clear: `$34,X = id`; `lair_state[id]` bit 6 clear -> yield; set -> `$16 \|= $0010`, skip 2 | A, Y, `lib_0273A2` scratch | r `data_00BA0D+1E`, `lair_state`, `$1ADE` array; w `switch_owner_table`, `$34`, `$16` |

### 2.4 Inventory, Gems, EXP, HP

| Id | Label | Off / size | Callers (uses) | Name (conf, evidence) | In / Out | Clobbers | Data touched |
|----|-------|-----------|----------------|-----------------------|----------|----------|--------------|
| H025 | `Cop0A_SetInventoryIfEmpty` | 22644 / 20 | table (47) | `Cop0A_SetInventoryIfEmpty` -> `Cop0A_GiveItemIfNotOwned` (A; code, walk: crosswalk section 4 lists `COP [0A] (#id)` as the grant site) | `b` item id: when `code_00651E` says not owned, `lib_0109D6_part3.code_0120F9` stores the item (it may also write `$1B64` and `$043B`); continues | A, Y | r/w `inventory` |
| H026 | `Cop0B_ClearInventoryEntry` | 22664 / 33 | table (27) | `Cop0B_ClearInventoryEntry` -> `Cop0B_RemoveItem` (A; code, caller A2 X081) | `b` item id: owned: byte `EOR` its low 7 bits, so an equipped entry becomes `$80` and an unequipped one `$00`; an equipped one also zeroes `$1B64` (low byte); continues | A, Y | r/w `inventory`; w `$1B64` |
| H027 | `Cop18_JumpIfInventoryZero` | 23055 / 25 | table (55) | `Cop18_JumpIfInventoryZero` -> `Cop18_JumpIfItemMissing` (A; code) | `b` item id, `t`: jumps when the value bits are 0 (not owned), else skip 2 | A, Y | r `inventory` |
| H028 | `Cop19_JumpUnlessInventoryBit7` | 23080 / 27 | table (36) | `Cop19_JumpUnlessInventoryBit7` -> `Cop19_JumpUnlessItemEquipped` (A; code, caller A2 X081-X083) | `b` item id, `t`: jumps when not owned or bit 7 clear; continues (skip 2) when owned and bit 7 set | A, Y | r `inventory` |
| H029 | `Cop25_CallLib0276A5` | 23397 / 20 | table (0) | `Cop25_CallLib0276A5` -> `Cop25_AddGems` (A; callee, dead) | `w` BCD amount: `lib_0276A5` adds it to Gems with the cap `$99:9999`; `$0332 \|= $10`; continues | A, Y, callee scratch | w `$1B66`, `$1B68`, `$0332` |
| H030 | `Cop26_JumpIfLib0276C9` | 23417 / 56 | table (8) | `Cop26_JumpIfLib0276C9` -> `Cop26_PayGemsOrJump` (A; code, callee, walk: `magic.md` costs) | `w` BCD cost, `t`: cost is 0 when `$1B64` = `$40` (Magic Bell); halved (min 1) when `$1B60` = `$0C` (Magic Armor); `lib_0276C9` subtracts: enough: `$0332 \|= $10`, skip 2; short (carry set): jumps | A, Y, callee scratch | r `$1B64`, `$1B60`; w `$1B66`, `$1B68`, `$0332` |
| H031 | `Cop36_AddBcdCounter` | 23956 / 28 | table (0) | `Cop36_AddBcdCounter` -> `Cop36_AddExp` (A; code, walk: EXP is a four-byte BCD stat at `$1B78`, `level-up.md`; dead) | `w` BCD amount added in decimal mode to `player_exp`, carry into `$1B7A`; no cap, no HUD flag | A | w `player_exp`, `$1B7A` |
| H032 | `Cop37_GetMissingHp` | 23984 / 14 | table (12) | `Cop37_GetMissingHp` -> `Cop37_HealPlayerToFull` (A; code, cons `lib_0275ED`) | no operand: `$043B = player_max_hp - player_hp`. `lib_0275ED` gives +1 HP every 4 frames while `$043B` counts down | A | r `player_max_hp`, `player_hp`; w `$043B` |
| H033 | `Cop38_SetParam043D` | 23998 / 13 | table (13) | `Cop38_SetParam043D` -> `Cop38_QueueExp` (A; code, cons `lib_027614`, walk) | `w` BCD amount (operands seen: `$0300`, `$0400`, `$0250`, `$0030`, `$0001`): `$043D = amount` (a store, not an add). `lib_027614` moves the lowest non-zero digit unit into `player_exp` every 8 frames (sound `BRK #$48`, `$0332 \|= $02`) | A | w `$043D` |
| H034 | `Cop39_DamagePlayer` | 24011 / 58 | table (6) | keep (A; code, walk: max HP is 100, `level-up.md`) | `b` damage (operands seen 1-4): `player_hp` = max(hp - damage, 0) in 8-bit; `$0332 \|= $04`; player `$26 = $FFE0` (stun tick), `BRK #$04`, player `$16 \|= $0800` | A, Y (X restored) | r/w `player_hp`, `$0332`; w player `$26`, `$16` |

### 2.5 Text, menus, name entry

| Id | Label | Off / size | Callers (uses) | Name (conf, evidence) | In / Out | Clobbers | Data touched |
|----|-------|-----------|----------------|-----------------------|----------|----------|--------------|
| H035 | `Cop01_ShowText` | 22434 / 27 | table (608) | keep (A; code) | `&c` string (bank = script bank): DBR = `$3A` around `lib_shared_012769.code_012C27`, then continues (no yield here) | A, Y (X, DBR restored) | text engine state (callee `code_012C27`) |
| H036 | `Cop02_PromptFixedString` | 22461 / 56 | table (0) | `Cop02_PromptFixedString` -> `Cop02_PromptYesNo` (A; code, string `[CUR:288]... Yes ... No`; dead) | `t`: shows `asciistring_014F02` (Yes / No), menu with 2 options; erases the box, `vram_upload_flags = 1`; Yes (0): skip 2; No or cancel: jumps | A, Y (X restored) | r `$03F7`; w `vram_upload_flags` |
| H037 | `Cop1A_ChoiceMenu` | 23107 / 69 | table (27) | keep (A; code) | `&c` string, `b` option count, `t`: selection -> `choice_result`, skip 2; cancel (carry set): jumps; erases the box, `vram_upload_flags = 1` | A, Y (X restored) | r `$03F7`; w `choice_result`, `vram_upload_flags` |
| H038 | `Cop3A_CallLib0124EE` | 24069 / 8 | table (1: `common_actor_00797B`) | `Cop3A_CallLib0124EE` -> `Cop3A_EnterPlayerName` (A; callee strings "Please enter your name-" and the letter grid, caller text "Please choose a name for yourself", walk: `01-in-the-beginning.md`) | no operand: runs `lib_0124EE.code_0124EE` (cursor navigation over the grid, writes the name buffer `$1B92`); continues | A, Y, callee scratch | w `$1B92` buffer |

### 2.6 Scene and transition

| Id | Label | Off / size | Callers (uses) | Name (conf, evidence) | In / Out | Clobbers | Data touched |
|----|-------|-----------|----------------|-----------------------|----------|----------|--------------|
| H039 | `Cop10_SetNextScene` | 22854 / 42 | table (65) | keep (A; code, mnemonics) | `w` (first byte area, second byte scene; the `XBA` puts them into `$0318`/`$0319`), `b` -> `warp_dest_anim`, `w` -> `warp_dest_x`, `w` -> `warp_dest_y` (raw pixels); continues | A | w `scene_next`, `area_next`, `warp_dest_anim`, `warp_dest_x`, `warp_dest_y` |
| H040 | `Cop3C_SetMode03E3` | 24172 / 14 | table (23) | `Cop3C_SetMode03E3` -> `Cop3C_SetTransitionType` (A; mnemonics name `$03E3` `transition_type`) | `b`: `transition_type = b` (all sampled uses pass 4); continues | A | w `transition_type` |

### 2.7 Conditions on actors, the player and the screen

| Id | Label | Off / size | Callers (uses) | Name (conf, evidence) | In / Out | Clobbers | Data touched |
|----|-------|-----------|----------------|-----------------------|----------|----------|--------------|
| H041 | `Cop0C_JumpIfActorInBox` | 22697 / 23 | table (94) | keep (B; code) | `b` slot, `b` margin (tiles, `* 16`), `t`: falls into H042 with `dp$00` = margin in pixels (FM-A2 X055 read this as "plus 2"; it is `* 16`) | A, Y, `dp$00`, `dp$16`, `dp$18` | r actor `$00`, `$02`, `$10`, `$12` |
| H042 | `loc_0058C0` | 22720 / 77 | 2 (Cop0C fall-in, Cop2E `BRL`) | `CopActorBoxTest` (B; code) | in Y = target, `dp$00` = margin (px); jumps when the target's point is inside the caller's box grown by the margin: x in `[X.x - m, X.x + w + m - 16]`, y in `[X.y - h - m + 16, X.y + m]` (w = `$10`, h = `$12`); else skip 2 | A, `dp$16`, `dp$18` | r actor `$00`, `$02`, `$10`, `$12` of both |
| H043 | `Cop0D_JumpIfActorAtTile` | 22797 / 57 | table (76) | keep (A; code) | `b` slot, `b` tile x, `b` tile y, `t`: jumps when target x = `tx * 16` and target y = `(ty + 1) * 16`; x miss: skip 3 (H003), y miss: skip 2. Cop11 stores `ty * 16` (OQ-I007-4) | A, Y | r target `$00`, `$02` |
| H044 | `Cop2E_JumpIfActorInBoxWord` | 23681 / 22 | table (3) | keep (B; code) | `b` slot, `w` margin (raw pixels), `t`: as H041 but the margin is not `* 16`; `BRL` into H042 | A, Y, `dp$00` | as H042 |
| H045 | `Cop20_JumpIfPlayerOffGrid` | 23293 / 24 | table (3) | keep (A; code) | `t`: jumps when `(player_x or player_y) and $0F` is non-zero, else skip 2 | A | r `player_x`, `player_y` |
| H046 | `Cop89_JumpIfPlayerWithinX` | 24415 / 38 | table (0) | keep (A; code, dead) | `w` threshold, `t`: jumps when `abs(player_x - $00,X) <= threshold` | A, `dp$00` | r `player_x`, `$00` |
| H047 | `Cop8A_JumpIfPlayerWithinY` | 24453 / 38 | table (0) | keep (A; code, dead) | as H046 with `player_y` and `$02,X` | A, `dp$00` | r `player_y`, `$02` |
| H048 | `Cop8B_JumpIfPlayerBeyondX` | 24491 / 38 | table (0) | keep (A; code, dead) | jumps when `abs(player_x - $00,X) > threshold` | A, `dp$00` | r `player_x`, `$00` |
| H049 | `Cop8C_JumpIfPlayerBeyondY` | 24529 / 38 | table (0) | keep (A; code, dead) | jumps when `abs(player_y - $02,X) > threshold` | A, `dp$00` | r `player_y`, `$02` |
| H050 | `Cop9A_JumpByPlayerDeltaX` | 24886 / 39 | table (175) | keep (A; code) | `w` threshold, `t` left, `t` within, `t` right (always jumps; see 1.8) | A, Y | r `player_x`, `$00` |
| H051 | `Cop9B_JumpByPlayerDeltaY` | 24925 / 39 | table (174) | keep (A; code) | `w` threshold, `t` above, `t` within, `t` below | A, Y | r `player_y`, `$02` |
| H052 | `Cop9C_JumpByPlayerAxis` | 24964 / 46 | table (28) | keep (A; code) | `t` first, `t` second: first when `abs(dx) > abs(dy)`, second otherwise | A, Y | r `player_x`, `player_y`, `$00`, `$02` |
| H053 | `Cop8D_JumpIfBit15Clear` | 24567 / 21 | table (0) | `Cop8D_JumpIfBit15Clear` -> `Cop8D_JumpIfOnScreen` (B; code, FM-A1 R27: `$16` bit 15 = off screen; dead) | `t`: jumps when `$16` bit 15 is clear; when set it continues through H006 without skipping the operand (latent bug, OQ-I007-3) | A | r `$16` |
| H054 | `Cop8E_JumpIfBit15Set` | 24588 / 21 | table (0) | `Cop8E_JumpIfBit15Set` -> `Cop8E_JumpIfOffScreen` (B; code, FM-A1 R27; dead) | `t`: jumps when bit 15 is set; clear: same latent bug as H053 | A | r `$16` |
| H055 | `CopAD_YieldWhileInView` | 25459 / 54 | table (80) | `CopAD_YieldWhileInView` -> `CopAD_WaitUntilOnScreen` (A; code, cons FM-A1 R27) | `b` poll interval: on screen (bit 15 clear): skip 1; off screen but x >= `map_width_px` or y >= `map_height_px` (unsigned): skip 1; else `$18,X = $38 - 2` (the COP itself), `$14,X = b`, yields. `docs/cop/index.md` calls bit 15 "in view" and the handler "yields when in view" (OQ-I007-2) | A | r `$16`, `$00`, `$02`, `map_width_px`, `map_height_px`; w `$18`, `$14` |
| H056 | `Cop1C_JumpIfActorFlags` | 23198 / 24 | table (6) | keep (A; code) | `w` mask, `t`: jumps when `$16 and mask` is non-zero (seen: `#$8000`, the off-screen test) | A | r `$16` |

### 2.8 Actor field setters, movement, appearance

| Id | Label | Off / size | Callers (uses) | Name (conf, evidence) | In / Out | Clobbers | Data touched |
|----|-------|-----------|----------------|-----------------------|----------|----------|--------------|
| H057 | `Cop11_MoveActorToTile` | 22896 / 46 | table (32) | keep (A; code) | `b` slot, `b` tile x, `b` tile y: target `$00 = tx * 16`, `$02 = ty * 16`, then `code_0065A7` (clears the footprint, FM-A2) with X = target, after the move (OQ-I007-5); continues | A, Y | w target `$00`, `$02`; w `tile_type_map` |
| H058 | `Cop12_SetActorResume` | 22942 / 23 | table (10) | keep (A; code) | `b` slot, `&c`: target `$18 = &c` (the bank `$36` is not touched) | A, Y | w target `$18` |
| H059 | `Cop13_SetActorData30` | 22965 / 23 | table (0) | `Cop13_SetActorData30` -> `Cop13_SetActorParam` (B; code, FM-A2 `$30` = parameter word; dead) | `b` slot, `w`: target `$30 = w` | A, Y | w target `$30` |
| H060 | `Cop17_SetOwnData30` | 23042 / 13 | table (367) | `Cop17_SetOwnData30` -> `Cop17_SetOwnParam` (B; code) | `w` (copdef type `&Code`): `$30,X = w`. Scripts pass a script pointer, for example `w0_actor_018000`: `COP [17] (&code_018036)` (a text script); the reader of that pointer is not identified (OQ-I007-14) | A | w `$30` |
| H061 | `Cop1D_SetActorFlags` | 23222 / 16 | table (1) | keep (A; code) | `w`: `$16,X \|= w` | A | w `$16` |
| H062 | `Cop1E_MaskActorFlags` | 23238 / 16 | table (1) | keep (A; code) | `w`: `$16,X &= w` | A | w `$16` |
| H063 | `Cop2F_ShiftPlayerActors` | 23703 / 63 | table (12) | keep (B; code) | `w` dx, `w` dy: adds to `$00`, `$02` of `player_actor` and of the actor at its `$3E` (list neighbour; assumed to be the weapon, OQ-I007-21). Only `w3_actor_022007` uses it (steps of 2 pixels) | A, Y, `dp$16`, `dp$18` | r/w `player_actor` slot `$00`, `$02`, `$3E` |
| H064 | `Cop33_PlayerActorsClearBit7` | 23856 / 25 | table (5) | `Cop33_PlayerActorsClearBit7` -> `Cop33_ShowPlayerActors` (A; code, cons `common_actor_001A28_part1.code_001512`) | no operand: `$1A and= $FF7F` on `player_actor`, `$039E`, `$03A0` (shown again), `$0464 = 0` (input unlocked); continues | A, Y | w `$1A` of three actors, `$0464` |
| H065 | `code_005D49` | 23881 / 10 | 3 (Cop33) | `ShowActorSprite` (A; code) | in Y = actor: `$1A,Y and= $FF7F` | A | w `$1A` |
| H066 | `Cop34_PlayerActorsSetBit7` | 23891 / 25 | table (12) | `Cop34_PlayerActorsSetBit7` -> `Cop34_HidePlayerActors` (A; code, cons `code_001512`: a non-zero `$0464` zeroes `joy_pressed`) | no operand: `$1A \|= $0080` on the three actors (not drawn), `INC $0464` (input locked); continues | A, Y | w `$1A` of three actors, `$0464` |
| H067 | `code_005D6C` | 23916 / 10 | 3 (Cop34) | `HideActorSprite` (A; code) | in Y = actor: `$1A,Y \|= $0080` | A | w `$1A` |
| H068 | `Cop87_ToggleFlipX` | 24389 / 13 | table (45) | keep (A; code) | `$1C,X ^= $4000` | A | w `$1C` |
| H069 | `Cop88_ToggleFlipY` | 24402 / 13 | table (4) | keep (A; code) | `$1C,X ^= $8000` | A | w `$1C` |
| H070 | `Cop8F_FacePlayerX` | 24609 / 33 | table (3) | keep (B; code) | sets flipX (`$1C` bit 14) when `player_x >= $00,X`, else clears it | A | r `player_x`, `$00`; w `$1C` |
| H071 | `Cop90_FacePlayerY` | 24642 / 33 | table (2) | keep (B; code) | sets flipY (bit 15) when `player_y >= $02,X`, else clears it | A | r `player_y`, `$02`; w `$1C` |
| H072 | `Cop96_SetFlipX` | 24814 / 18 | table (226) | keep (A; code) | sets `$1C` bit 14 | A | w `$1C` |
| H073 | `Cop97_ClearFlipX` | 24832 / 18 | table (310) | keep (A; code) | clears `$1C` bit 14 | A | w `$1C` |
| H074 | `Cop98_SetFlipY` | 24850 / 18 | table (10) | keep (A; code) | sets `$1C` bit 15 | A | w `$1C` |
| H075 | `Cop99_ClearFlipY` | 24868 / 18 | table (14) | keep (A; code) | clears `$1C` bit 15 | A | w `$1C` |
| H076 | `Cop9F_AddX` | 25071 / 17 | table (79) | keep (A; code) | `w`: `$00,X += w` (pixels, signed) | A | w `$00` |
| H077 | `CopA0_AddY` | 25088 / 17 | table (39) | keep (A; code) | `w`: `$02,X += w` | A | w `$02` |
| H078 | `CopA1_AddXY` | 25105 / 30 | table (58) | keep (A; code) | `w` dx, `w` dy | A | w `$00`, `$02` |
| H079 | `CopA2_SetPriority` | 25135 / 25 | table (54) | keep (A; code, FM-A1 4.1: `$1C` bits 12-13) | `b`: `$1C = ($1C and $CFFF) or (b << 8)`; the byte is not masked, so only `$00-$30` are safe (seen: 30) | A | w `$1C` |
| H080 | `CopA3_SetFlag1A4000` | 25160 / 13 | table (121) | `CopA3_SetFlag1A4000` -> `CopA3_DrawInFront` (A; code, cons FM-A1 R27) | `$1A \|= $4000` | A | w `$1A` |
| H081 | `CopA4_SetFlag1A2000` | 25173 / 13 | table (34) | `CopA4_SetFlag1A2000` -> `CopA4_DrawBehind` (A; code, cons R27) | `$1A \|= $2000` | A | w `$1A` |
| H082 | `CopA5_JumpByFlipState` | 25186 / 41 | table (25) | keep (A; code) | `t` x 4: reads `$1C` bits 14-15 and clears them, jumps to `[+0]` none, `[+2]` flipX only, `[+4]` flipY only, `[+6]` both | A, Y | r/w `$1C` |
| H083 | `CopA6_ClearFlag1A4000` | 25227 / 13 | table (13) | `CopA6_ClearFlag1A4000` -> `CopA6_ClearDrawInFront` (A; code) | `$1A and= $BFFF` | A | w `$1A` |
| H084 | `CopA7_ClearFlag1A2000` | 25240 / 13 | table (5) | `CopA7_ClearFlag1A2000` -> `CopA7_ClearDrawBehind` (A; code) | `$1A and= $DFFF` | A | w `$1A` |
| H085 | `CopA8_SetFields22And24` | 25253 / 28 | table (37) | `CopA8_SetFields22And24` -> `CopA8_SetAnimationTable` (A; code, FM-A1 4.1: `$22` table word, `$24` bank byte) | `w` -> `$22`, `b` -> `$24` | A | w `$22`, `$24` |
| H086 | `CopA9_SetFields34And2C` | 25281 / 37 | table (1: the player script, `COP [A9] (#$3000, #7F)`) | `CopA9_SetFields34And2C` -> `CopA9_SetDynamicTileSource` (A; code, cons FM-A1 R29: dynamic-tile actors read `$2C`/`$34`) | `w` -> `$34` (source), `b` -> `$2C` (bank), `$1A \|= $8000`; the player's source is `$7F:3000` | A | w `$34`, `$2C`, `$1A` |
| H087 | `CopAA_SetPalette` | 25318 / 25 | table (11) | keep (A; code, FM-A1 4.1: `$1C` bits 9-11) | `b`: `$1C = ($1C and $F1FF) or (b << 8)` (byte not masked) | A | w `$1C` |

### 2.9 Animation

| Id | Label | Off / size | Callers (uses) | Name (conf, evidence) | In / Out | Clobbers | Data touched |
|----|-------|-----------|----------------|-----------------------|----------|----------|--------------|
| H088 | `Cop80_SetAnimation` | 24186 / 22 | table (1614) | keep (A; code) | `b` id: `$1E = id`, `$20 = 0`, `$18 = $38`; continues | A | w `$1E`, `$20`, `$18` |
| H089 | `Cop81_SetAnimationCount` | 24208 / 32 | table (522) | `Cop81_SetAnimationCount` -> `Cop81_SetAnimationRepeat` (A; code) | `b` id, `b` count: `$1E`, `$20 = 0`, `$2A = count`, `$18 = $38` | A | w `$1E`, `$20`, `$2A`, `$18` |
| H090 | `Cop82_AnimStepYield` | 24240 / 13 | table (1623) | `Cop82_AnimStepYield` -> `Cop82_WaitAnimationDone` (A; code, callee FM-A1 R25) | `engine_000000.code_0008F3` steps once; carry set (done): continues; clear: yields (the resume `$18` is the COP itself when Cop80 stored it) | A, Y, callee scratch | r/w `$1E`, `$20`, sprite fields |
| H091 | `Cop83_AnimStepRepeat` | 24253 / 18 | table (529) | `Cop83_AnimStepRepeat` -> `Cop83_WaitAnimationRepeat` (A; code) | like H090; when a pass is done `$2A -= 1` and the next pass starts in the same call; continues at 0 | A, Y | r/w `$2A` |
| H092 | `Cop92_StartAnimation` | 24693 / 25 | table (21) | keep (B; code) | `b` id: `$1E`, `$20 = 0`, `lib_01065B.code_01065B` (loads the first 6-byte step), `lib_0106CD.code_0106CD`, then H008 (saves `$38`, yields) | A, Y | w `$1E`, `$20`, `$26`, `$08-$0E`, `$14` |
| H093 | `Cop93_StartAnimationCount` | 24718 / 35 | table (0) | keep (B; code, dead) | `b` id, `b` count (`$2A`), as H092 | A, Y | as H092, `$2A` |
| H094 | `Cop94_AnimTick` | 24753 / 28 | table (22) | keep (B; code) | `$26 -= 1`; negative: next step through `code_01065B` (carry set = table ended: continues); else `$14 = $0E` (OQ-I007-24); `code_0106CD`; yields | A, Y | r/w `$26`, `$0E`, `$14` |
| H095 | `Cop95_AnimTickRepeat` | 24781 / 33 | table (0) | keep (B; code, dead) | as H094 with the repeat count `$2A` | A, Y | as H094, `$2A` |
| H096 | `Cop9D_SetAnimationUnlock` | 25010 / 31 | table (51) | `Cop9D_SetAnimationUnlock` -> `Cop9D_SetAnimationClearBlocked` (A; code, FM-A1: `$16` bit 2 = blocked) | `b` id: as Cop80, and `$16 and= $FFFB` | A | w `$1E`, `$20`, `$18`, `$16` |
| H097 | `Cop9E_AnimStepUnlessBit2` | 25041 / 30 | table (51) | `Cop9E_AnimStepUnlessBit2` -> `Cop9E_WaitAnimationDoneOrJumpIfBlocked` (A; code, FM-A1) | `t`: `$16` bit 2 set (blocked): jumps; else one `code_0008F3` step: done: skip 2 (continues); not done: yields | A, Y | r `$16`; r/w animation fields |

### 2.10 Tiles and collision

| Id | Label | Off / size | Callers (uses) | Name (conf, evidence) | In / Out | Clobbers | Data touched |
|----|-------|-----------|----------------|-----------------------|----------|----------|--------------|
| H098 | `Cop15_BlockOwnTiles` | 23028 / 7 | table (209) | keep (A; code) | no operand: `JSR code_006537`; continues | A, Y, `dp$0C`, `dp$0E`, `dp$16`, `dp$18` | w `tile_type_map` |
| H099 | `code_006537` | 25911 / 112 | 1 (Cop15) | `BlockActorFootprint` (A; code) | in X = actor: when `w + h < $21` marks the one tile at (x, y - 16); else `h / 16` rows by `w / 16` columns from (x, y - h), `ORA #$00F0` on every tile (`code_0272B8` then `code_02731A` east). X restored | A, Y, `dp$0C`, `dp$0E`, `dp$16`, `dp$18` | r actor `$00`, `$02`, `$10`, `$12`; w `tile_type_map` |
| H100 | `Cop16_UnblockOwnTiles` | 23035 / 7 | table (82) | keep (A; code, callee FM-A2) | no operand: `JSR engine_0065A7.code_0065A7` (clears the footprint); continues | A, Y | w `tile_type_map` |
| H101 | `Cop21_JumpIfTileAbove` | 23317 / 22 | table (43) | keep (A; code) | `t`: samples (x, y - 16 - h); low byte non-zero: jumps | A, `dp$16`, `dp$18` | r `tile_type_map` |
| H102 | `Cop22_JumpIfTileAtPos` | 23339 / 14 | table (45) | `Cop22_JumpIfTileAtPos` -> `Cop22_JumpIfTileBelow` (A; code) | `t`: samples (x, y), the row below the footprint row (`y - 16`); `docs/cop/index.md` says "at the actor position" (OQ-I007-23) | A, `dp$16`, `dp$18` | r `tile_type_map` |
| H103 | `Cop23_JumpIfTileLeft` | 23353 / 22 | table (50) | keep (A; code) | `t`: samples (x - 16, y - 16) | A, `dp$16`, `dp$18` | r `tile_type_map` |
| H104 | `Cop24_JumpIfTileRight` | 23375 / 22 | table (47) | keep (A; code) | `t`: samples (x + w, y - 16) | A, `dp$16`, `dp$18` | r `tile_type_map` |
| H105 | `Cop28_JumpIfTileHere` | 23489 / 15 | table (24) | keep (A; code) | `t`: samples (x, y - 16), falls into H106 | A, `dp$16`, `dp$18` | r `tile_type_map` |
| H106 | `loc_005BD0` | 23504 / 27 | 5 (Cop21-24 `BRL`, Cop28 fall-in) | `CopTileTestTail` (A; code) | in `dp$16`, `dp$18` = pixel; X saved around `code_0272B8`; jumps when the low byte of the tile word is non-zero (blocked mark or type), else skip 2 | A, Y | r `tile_type_map` |
| H107 | `Cop29_JumpIfTileIdDiffers` | 23531 / 52 | table (0) | keep (B; code, dead) | `b` value, `t`: samples (x, y - 16) in the byte buffer `$7E8000`; equal: skip 2; differs: jumps | A, Y, `dp$16`, `dp$18` | r `$7E8000` buffer |
| H108 | `Cop2A_BlockTileAt` | 23583 / 49 | table (20) | keep (A; code) | `w` dx, `w` dy: `ORA #$00F0` on the tile at (x + dx, y + dy - 16) | A, Y, `dp$16`, `dp$18` | w `tile_type_map` |
| H109 | `Cop2B_UnblockTileAt` | 23632 / 49 | table (20) | keep (A; code) | same position; `AND #$FF00` (clears the type nibble too, OQ-I007-6) | A, Y, `dp$16`, `dp$18` | w `tile_type_map` |
| H110 | `CopAE_JumpIfTileTypeSet` | 25513 / 56 | table (52) | `CopAE_JumpIfTileTypeSet` -> `CopAE_JumpIfTileTypeNonZero` (A; code) | `w` dx, `w` dy, `t`: tile at (x + dx, y + dy - 16); low nibble non-zero: jumps, else skip 2 | A, Y, `dp$16`, `dp$18` | r `tile_type_map` |

### 2.11 Spawn and kill

| Id | Label | Off / size | Callers (uses) | Name (conf, evidence) | In / Out | Clobbers | Data touched |
|----|-------|-----------|----------------|-----------------------|----------|----------|--------------|
| H111 | `Cop84_SpawnActorAfter` | 24271 / 31 | table (13) | keep (A; code) | `&c`, `b` bank: spawns "After" (`code_00663A`), new `$18 = &c`, `$36 = bank`; continues | A, Y, callee scratch | free-slot stack, actor list, new slot |
| H112 | `Cop85_SpawnActorBefore` | 24302 / 31 | table + Cop30 `BRL` (346) | keep (A; code) | as H111 with "Before" (`code_006662`) | A, Y | as H111 |
| H113 | `CopAB_SpawnAfterAbsolute` | 25343 / 58 | table (0) | keep (A; code, dead) | `&c`, `b`, `w` x, `w` y, `w` flags: spawn After, stores `$00`, `$02`, `$16` | A, Y | as H111 |
| H114 | `CopAC_SpawnBeforeAbsolute` | 25401 / 58 | table (38) | keep (A; code) | as H113 with Before | A, Y | as H111 |
| H115 | `CopAF_SpawnAfterFlags` | 25569 / 40 | table (12) | `CopAF_SpawnAfterFlags` -> `CopAF_SpawnAfterWithFlags` (A; code: `STA $0016,Y` stores) | `&c`, `b`, `w` flags: spawn After, `$16 = flags` | A, Y | as H111 |
| H116 | `CopB0_SpawnBeforeFlags` | 25609 / 40 | table (76) | `CopB0_SpawnBeforeFlags` -> `CopB0_SpawnBeforeWithFlags` (A; code) | as H115 with Before | A, Y | as H111 |
| H117 | `CopB1_SpawnAfterRelative` | 25649 / 66 | table (0) | keep (A; code, dead) | `&c`, `b`, `w` dx, `w` dy, `w` flags: new `$00 = X.x + dx`, `$02 = X.y + dy`, `$16 = flags` | A, Y | as H111 |
| H118 | `CopB2_SpawnBeforeRelative` | 25715 / 66 | table (114) | keep (A; code) | as H117 with Before; then `BRL H006` | A, Y | as H111 |
| H119 | `Cop30_ConditionalSpawn` | 23766 / 26 | table (32) | `Cop30_ConditionalSpawn` -> `Cop30_SpawnIfReturnedFrom` (B; code, cons `lib_0109D6`: `$0405` = record index of the warp the player used) | `w` record index, `&c`, `b` bank: `return_active` = 0: skip 5 (H001); index != `$0405`: skip 3 (H003); equal: `BRL Cop85` | A, Y | r `return_active`, `$0405` |
| H120 | `Cop86_KillSelf` | 24333 / 56 | table (283) | keep (A; code) | no operand: unlinks the actor (`$3C`/`$3E`, `actor_list_head`/`tail`), pushes the slot on the free stack (`dp$4A -= 2`), then continues (the script must end itself, usually `RTL`) | A, Y | w `actor_list_tail`, `actor_list_head`, neighbours' `$3C`/`$3E`, `dp$4A` stack |

### 2.12 Random

| Id | Label | Off / size | Callers (uses) | Name (conf, evidence) | In / Out | Clobbers | Data touched |
|----|-------|-----------|----------------|-----------------------|----------|----------|--------------|
| H121 | `Cop1F_StepRandom` | 23254 / 39 | table (49) | keep (A; code) | no operand: `rng_state[i] += rng_state[i+1]` with carry for i = 15 .. 1, then `INC` of `rng_state+16` with the carry rippling down to `rng_state+1`; B = 0; X restored from Y | A | r/w `rng_state` (`$0301-$0311`) |
| H122 | `Cop35_RandomMod` | 23926 / 30 | table (9) | keep (A; code) | `b` N (non-zero; N = 0 would loop for ever): `random_mod_result = rng_state+1 mod N` (repeated subtraction) | A, `dp$00` | r `rng_state+1`; w `random_mod_result` |

### 2.13 Music load (spawned by Cop31/Cop32; file `cop_handler_005CF0_part1`)

| Id | Label | Off / size | Callers (uses) | Name (conf, evidence) | In / Out | Clobbers | Data touched |
|----|-------|-----------|----------------|-----------------------|----------|----------|--------------|
| H123 | `Cop31_SpawnEngineActor2C9B` | 23792 / 32 | table (9) | `Cop31_SpawnEngineActor2C9B` -> `Cop31_FadeOutAndLoadMusic` (B; code, callee, doc `spc-disassembly.md`) | `b` track index: spawns Before an actor at `code_002C9B` with `$30 = index`; continues | A, Y | as H111, new `$30` |
| H124 | `Cop32_SpawnEngineActor2CCB` | 23824 / 32 | table (5) | `Cop32_SpawnEngineActor2CCB` -> `Cop32_StopAndLoadMusic` (B; code, callee, doc) | as H123 with `code_002CCB` (skips the fade steps) | A, Y | as H123 |
| H125 | `code_002C9B` | 11419 / 13 | 2 (Cop31: address word and bank byte) | `MusicLoadSendFade` (B; code, doc: `$F1` HandleFadeIn) | `APUIO0 = $F1`; `COP [27](&code_002CA8)` | A | w `APUIO0` |
| H126 | `code_002CA8` | 11432 / 25 | 1 (`COP [27]` in H125) | `MusicLoadWaitFadeAck` (B; code) | read-back of `APUIO0` != `$F1`: `RTL` (polls next frame); equal: `APUIO0 = $01`, `COP [27](&code_002CC1)` | A | r/w `APUIO0` |
| H127 | `code_002CC1` | 11457 / 10 | 1 (`COP [27]` in H126) | `MusicLoadWaitSilence` (B; code) | `APUIO0` non-zero: `RTL`; zero: falls into H128 | A | r `APUIO0` |
| H128 | `code_002CCB` | 11467 / 13 | 3 (Cop32: address word and bank byte, fall-in from H127) | `MusicLoadSendStop` (B; code, doc: `$F0` StopAllChannels) | `APUIO0 = $F0`; `COP [27](&code_002CD8)` | A | w `APUIO0` |
| H129 | `code_002CD8` | 11480 / 16 | 1 (`COP [27]` in H128) | `MusicLoadWaitStopped` (B; code) | `APUIO0` non-zero: `RTL`; zero: `COP [1B](&code_002CE8, #2)` | A | r `APUIO0` |
| H130 | `code_002CE8` | 11496 / 73 | 1 (`COP [1B]` in H129) | `MusicLoadUpload` (B; code, callee) | `APUIO0 = $FF`; `Y = $30 * 3`, `$30 = 0`; long pointer `table_00FB49[Y]` -> `dp$29-$2B` and `$0422/$0424`; wait for vblank (`code_0131B7`), NMI off (`code_0131AE`), `common_shared_0FEEA6.code_0FEFF5` (IPL upload), vblank, NMI on (`code_0131A2`); `COP [1B](&code_002D31, #2)` | A, Y, `dp$29-$2B` | r `table_00FB49`; w `$0422`, `$0424`, `$03D2` |
| H131 | `code_002D31` | 11569 / 15 | 1 (`COP [1B]` in H130) | `MusicLoadFinish` (B; code) | `APUIO0 = $01`, `$0458 = 0`, `COP [86]` (kill), `RTL` | A | w `APUIO0`, `$0458` |
| H132 | `loc_002D40` | 11584 / 39 | 2 (`code_002B7E` `BRL` in FM-A2 X070, `engine_0029EC`) | `RespawnOrKillActor` (B; code, callee `engine_000000.code_0013AB`) | `$1A` bit `$1000` clear: `COP [86]` kill. Set: `$26 = $0258` (600), `COP [91]`; each call while `$16` bit 15 (off screen) is set: `$26 -= 1`, negative: `engine_000000.code_0013AB` re-initialises the actor from its placement record, i.e. a respawn after 600 frames off screen. Corrects FM-A2 X070 ("kill") | A, Y | r `$1A`, `$16`; w `$26` |

## 3. Fan-in summary

| Target | Fan-in |
|--------|--------|
| Exit chain | `CopExitContinue` 68 sites (+1 `CopB2`), `CopExitJump` 29, `CopExitSkip2` 21, `CopExitYield` 11, the other five 1-3 each |
| Helper calls | `code_00651E` 4 (Cop0A, 0B, 18, 19), `code_006617` 6 slot-operand handlers (0C, 0D, 11, 12, 13, 2E), `code_0272B8` 9 handlers (Cop21-24, 28, 29, 2A, 2B, AE) plus `code_006537` and about 15 other files (`rg`: 24 files in all), `code_0065A7` 2 (Cop11, Cop16) |
| Most used handlers (`COP [id]` sites in `extracted/`) | Cop82 1623, Cop80 1614, Cop01 608, Cop83 529, Cop81 522, Cop91 414, Cop17 367, Cop85 346, Cop97 310, Cop86 283 |
| Handlers with 0 uses (17) | 00, 02, 06, 13, 25, 29, 36, 89, 8A, 8B, 8C, 8D, 8E, 93, 95, AB, B1 |
| Ids without a handler | `0E`, `0F`, `2C`, `2D` (no entry in `code_list_005638`); `3D-7F` are `cop_junk`; `B3` and above are not handlers |

## 4. Structures observed

### 4.1 Actor fields the handlers read or write

| Field | Width | Read or written by | Meaning here |
|-------|-------|--------------------|--------------|
| `$00`, `$02` | word | Cop0C/0D/11/21-24/9F-A1/AB-B2 | x and y pixel (y = bottom edge) |
| `$10`, `$12` | word | Cop0C, `code_006537`, Cop24 | width and height in pixels (multiples of 16 where used by the footprint) |
| `$14` | word | Cop1B, Cop27, CopAD, Cop94/95 | wait counter |
| `$16` | word | Cop14, 1C-1E, 3B, 39, 8D/8E, 9D/9E, AD, spawn handlers | flags: bit 15 off screen, bit 13 hidden/inactive, bit 11 hit stun, bit 4 sub-frame runner, bit 2 blocked (FM-A1 4.1) |
| `$18`, `$36` | word, byte | all flow, spawn and animation handlers | resume address and bank |
| `$1A` | word | Cop33/34, A3/A4/A6/A7, A9, `loc_002D40` | bit 15 dynamic tile, bit 14 draw in front, bit 13 draw behind, bit 12 respawn (new), bit 7 not drawn |
| `$1C` | word | Cop87-90, 96-99, A2, A5, AA | OAM attribute: bit 15 flipY, bit 14 flipX, bits 12-13 priority, bits 9-11 palette |
| `$1E`, `$20` | word | Cop80-83, 92-95, 9D | animation id and step |
| `$22`, `$24` | word, byte | CopA8 | animation table word and bank |
| `$26` | word | Cop39, Cop92-95, `loc_002D40` | stun tick, animation tick or the 600-frame respawn counter |
| `$2A` | word | Cop81, 83, 93, 95 | repeat count |
| `$2C`, `$2E` | word | Cop03/04 (loop start, counter), CopA9 (`$2C` = bank) | shared: a script that used CopA9 and Cop03 on the same actor would collide (OQ-I007-19) |
| `$30` | word | Cop13, 17, 31, 32 | parameter word (track index for the music actors) |
| `$34` | word | CopA9, Cop3B | dynamic tile source word, or the switch id (OQ-I007-19) |
| `$3C`, `$3E` | word | Cop86, Cop2F | list links |

### 4.2 `data_00BA0D` record fields used by this batch

The records are 32 bytes (`id << 5`; Cop3B, `lib_0109D6`, `lib_010EA9`). Widths are the widths of the accesses:

| Field | Width | Read by | Meaning |
|-------|-------|---------|---------|
| `+0` | byte | `lib_0109D6` (`CMP location_id`) | location id |
| `+2`, `+3` | byte, byte | `lib_0109D6` (`* 16` into `dp$16`/`dp$18`, `warp_dest_x/y`) | tile x and y |
| `+9` | byte | `lib_010EA9` (`STA $03C8`) | unnamed (to `$03C8`) |
| `+1D` | byte | `lib_0109D6` (`STA warp_dest_anim`) | warp animation |
| `+1E` | word | Cop3B | gate switch word (0 = no gate) |

### 4.3 Operand encodings

| Encoding | Layout | Used by |
|----------|--------|---------|
| flag word | bit 15 = `v`, bits 8-14 = byte index, bits 0-7 = bit number (0-7) | Cop05, 07, 08, 09 |
| scene word | byte 1 = area, byte 2 = scene | Cop10 |
| tile coordinates | `b` tile x, `b` tile y (`* 16` pixels) | Cop0D, Cop11 |
| spawn | `&c` (word), bank byte, then optional words (section 1.4) | Cop84/85, AB-B2, 30 |
| jump table | consecutive `&c` words indexed by `Y` (Cop9A/9B: `+2`, `+4`, `+6` after the threshold word; Cop9C: `+0`, `+2`; CopA5: `+0` .. `+6`) | Cop9A-9C, CopA5 |
| music index | `b` into `table_00FB49` (21 entries of 3 bytes: word + bank) | Cop31, Cop32 |

## 5. WRAM without a mnemonic: proposals

| Address | Evidence | Proposed name | Conf | Readers and writers |
|---------|----------|---------------|------|---------------------|
| `$0405` | `lib_0109D6` stores Y (the record index) with `INC return_active`; `common_actor_001A28_part1` code at 6564 indexes `switch_owner_table`, `lib_010EA9` indexes `data_00BA0D` (`<< 5`); Cop30 compares it | `return_record` | B | w `lib_0109D6`; r Cop30, `code_0019A4`, `lib_010EA9` |
| `$043B` | Cop37 and `lib_0275ED` (A2 `heal_pending`) | `heal_pending` | A | w Cop37, `lib_0275ED`, `code_0120F9`; r `lib_0275ED` |
| `$043D` | Cop38 stores a BCD amount, `lib_027614` drains it into `player_exp` | `exp_pending` | A | w Cop38, `lib_027614`; r `lib_027614` |
| `$0464` | Cop33 clears, Cop34 increments; `code_001512` zeroes `joy_pressed` while non-zero; `lib_027781_part3` initialises it | `player_input_lock` | B | w Cop33, Cop34, `lib_027781_part3`; r `code_001512` |
| `$0458` | six boss actors `INC` it; `code_002D31` clears it; `code_0109D6` skips the exit on tile `$FE` while non-zero; `lib_027781_part3` initialises it | `boss_lock` | B | w `common_actor_0031AD`, `_0033C6`, `_003E43`, `_004299`, `_004659`, `_004BEE`, `code_002D31`; r `code_0109D6` |
| `$03F7` | saved by `code_012769` (`STX`), read by Cop02/Cop1A to erase the box | `text_box_pos` | B | w `code_012769`; r Cop02, Cop1A |
| `$1B7A` | Cop36 and `code_027687` carry the BCD sum into it; walkthrough: EXP is four bytes at `$1B78` | `player_exp_hi` | A | r/w Cop36, `code_027687` |
| `$0422`, `$0424` | `code_002CE8` stores the music long pointer; `lib_0133A6_part3` (offset 80070) loads `#$0422` as an address | `music_ptr` (word + bank byte) | C | w `code_002CE8`; the reader in `lib_0133A6_part3` was not examined (OQ-I007-11) |
| `$7E8000` | byte buffer read by Cop29 and `lib_0109D6` (`CMP #$FE`) | `tile_id_map` | B | r Cop29, `lib_0109D6` |
| `$7F0203` | per-id byte, bit 6 tested by Cop3B (A2 lair state) | `lair_state` | B | r Cop3B; w `lib_0109D6`, A2 `X085` |
| `$1B92` | name buffer used by `lib_0124EE` and copied into the save slot (`engine_006B7F`) | `player_name` | B | r/w `lib_0124EE`, `engine_006B7F` |

## 6. Findings for later batches

- **Placement.** `code_0064CC` (`WriteEventFlag`) belongs next to `engine_0064F8`, and `code_006537` (`BlockActorFootprint`) next to `engine_0065A7` (its counterpart `code_0065A7` unblocks); both sit in `cop_handlers` only because Cop09 and Cop15 are their sole callers. `cop_handler_005CF0_part1` is not a COP handler at all: it is the music-load actor chain (`code_002C9B`-`code_002D31`) plus `loc_002D40`, a general respawn routine called from `engine_*`; it should move to a sound or engine block. The exit chain (`loc_0064B5`-`loc_0064C9`) could become its own `cop_core` block instead of the tail of `CopB2`.
- **Corrections to earlier work.** FM-A2 X055 (`Cop0C` margin) is `* 16`, not "plus 2". FM-A2 X070 (`loc_002D40`) is a respawn-or-kill, not a kill. FM-A2/`docs/cop/index.md` call the `AF`/`B0` operand "flags (adds)"; it is stored. OQ-I006-19 is answered statically (section 1.4).
- **`docs/cop/index.md` differs from the code** in these places: Cop07/08 (the names are right only for flag words with bit 15 clear, OQ-I007-1); `$16` bit 15 (off screen, not in view) and `CopAD` (OQ-I007-2); Cop22 ("at the actor position", OQ-I007-23); Cop91 listed with 0 uses (measured 414); Cop31/32 are described as engine-actor spawns, which is true but hides that they load music; Cop3A is described only by its callee (it is the player-name entry); Cop37/38 are described by field names (they are the pending heal and the pending EXP).
- **Walkthrough cross-checks (all agree).** Cop26 pays the costs listed in `magic.md` (4/8/8/1/8/20/8/2 Gems, half with the Magic Armor, none with the Magic Bell); Cop3A matches "you will then get to pick a name for yourself"; Cop38 awards `$0300`, `$0400`, `$0250` and similar BCD amounts against the EXP table of `level-up.md` (a four-byte stat at `$1B78`); Cop39 (damage 1-4) works in 8 bits and the maximum HP is 100; the item ids of Cop0A/0B/18/19 are the ids of the crosswalk section 4. No walkthrough mismatch was found; all open points are doc or code questions.
- **Latent defects, none reproducible in play so far (all rows in I007):** Cop8D/8E skip nothing on the other path (dead, 0 uses); `code_0272B8` adds `y & $0F` unmasked; Cop2B and (per FM-A2) Cop16 clear the type nibble; Cop11 unblocks the new position and not the old; CopAB/B1 and the spawn handlers ignore an empty slot stack (`Y = $06AA`); Cop35 hangs on 0.
- **Dead handlers.** 17 of the 108 handlers have no `COP [id]` site in `extracted/`; whether any is reached through data (a byte stream that the extractor did not turn into code) can be checked with the CDL (OQ-I007-22).
- **Cross-batch hooks.** `$0458` (`boss_lock`) links the boss actors (A2 X070-X072, `common_actor_*`) to `code_0109D6`; `$0464` links Cop33/34 to the player script (`common_actor_001A28_part1`); the music chain links `engine_0029EC` (boss death `COP [31](#2)`) and `engine_005354` (ending `COP [31](#0)`) to `table_00FB49`. `lib_01065B` writes `$08-$0E` per animation step (6-byte steps: count, word, byte, byte, byte), which FM-A1 4.1 lists as extents (OQ-I007-24).
