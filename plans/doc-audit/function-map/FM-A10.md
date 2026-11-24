# FM-A10: the player actor `common_actor_001A28` (input filter, action choice, motion, soul orb, spells, level-up)

PA batch A10, iteration I014. Read-only analysis: no names, notes, comments, `blocks.json`, `overrides.json` or docs were changed. Every proposed name below is a proposal for step PC (`npm run names`); every unverified claim is an `OQ-I014-k` row in `plans/extracted-audit/questions/I014_questions.md`. (A9 took I013; A10 takes I014.)

Source: a fresh `npm run extract:lt`. Four files were read end to end; offsets are decimal file offsets (the `{n}` tag; LoROM: bank = `offset >> 15`, address = `$bank:(8000 + (offset & 7FFF))`). Every file is `?BANK 00`, so the label suffix is the hex file offset and the address is `$00:xxxx` (for example `code_001A28` is at `$00:9A28`, `code_002F56` at `$00:AF56`). The four files are not contiguous: the player actor is cut into four pieces by the files of other batches.

| File | Offsets | Labels | Content |
|------|---------|--------|---------|
| `common_actor_001A28_part1` | 5394-7483 (2089 bytes) | 10 routines, 2 tables | input filter, per-frame motion sync, push zones, corner slide, gem pull, return-trip facing, the player script and its state table |
| (A2: `engine_routines_001D3B`) | 7483-8143 | - | the 28 animation-start and swing handlers (FM-A2 X017-X044) |
| `common_actor_001A28_part2` | 8143-9848 (1705 bytes) | 25 labels | weapon layer actor, soul orb actor and its controller, spell dispatcher, the seven spells and their child actors |
| (A2: `engine_routines_002678`) | 9848-9959 | - | the four Phoenix projectile scripts (FM-A2 X045-X049) |
| `common_actor_001A28_part3` | 9959-9971 (12 bytes) | 1 | "release the Y latch, clear the spell counter, kill self" |
| `common_actor_001A28_part4` | 12118-12293 (175 bytes) | 3 | level-up watcher and the "LEVEL UP !" blink |

3981 bytes in all: 39 rows P01-P39 (the sub-labels `loc_001A65`, `code_002163` and `code_0023E3` have their own rows; P02 is the table `word_001588`, listed again as data row D01), a second data row D02, and the tables the code reads. The `?BANK`/`?INCLUDE` lines and sizes agree with `us/blocks.json`; no override is needed.

Context read for the callee and caller models: `engine_000000` (NMI joypad decode lines 505-545, scheduler `code_0009BF`-`code_000A22`, anim step `code_0008F3`, hit detection R34-R39, spawn init R51), `engine_routines_001D3B` (all 28 handlers, `PublishPlayerAnim`, `loc_001ED3`), `engine_routines_002678`, `engine_0065A7` (spawn helpers), `engine_002EC0` (gem pickups), `engine_003005` (player death), `cop_handler_005EB0` (Cop82), `cop_handler_006409` (CopB0), `lib_027781_part1` (`ApplyPlayerWeaponPose`), `lib_0118FC` (status screen clamp, souls screen), `lib_0116C3` (soul effects), `lib_0161CE` (`word_0161CE`), `data_00F9F7` (every table named below), `table_050000`, `table_058000`, `table_060000`, `table_068000`, `table_070000`, `table_078000` (anim tables), `meta_tables_008000` (hero entries), the four push-zone setters (`w0_actor_01AFFD`, `w2_actor_0FA59C`, `w3_actor_02220D`, `w5_actor_027019`), the five soul actors (`w0_actor_01A7AC`, `w1_actor_01D6AB`, `w2_actor_0F80A4`, `w4_actor_022E10`, `w5_actor_0251DC`), `us/structs.json` (`unk16`, `unk3`, `unk12`, `meta_entry`), `us/copdef.json`, `us/mnemonics.json`, `docs/wram-memory-map.md`, `docs/walkthrough/` (`magic.md`, `items.md`, `level-up.md`, chapters 1, 2, 7, 8) and FM-A1 to FM-A9.

## 0. Reading the tables

Same conventions as FM-A9 section 0 (columns, confidence A/B/C, evidence labels `code`, `callee`, `caller`, `cons`, `walk`, `doc`, `hw`, `dead`; `r` read, `w` write; DP scratch is `dp$nn`; actor fields are `$nn,X` with X = slot). Two additions:

- **Actor script** = a routine entered through `COP [84]/[85]/[B0]/[B2]` (or the meta-table pointer): it runs when the slot's countdown `$14` underflows, with X = its own slot, and ends by yielding (`COP [91]`, `COP [82]`, `COP [1B]`, `RTL` with `$18` unchanged) or `COP [86]` (kill self). A **subroutine** is entered through `JSR`.
- Animation ids are written `$nn`. Direction codes are the game's own: **0 up, 1 down, 2 right, 3 left** (`binary_00FA7F` for facing, `binary_00FAAB` for movement). Anim ids `$00`-`$03` are the idle poses facing **down, up, left, right** (see 1.4).

## 1. Models that several rows share

### 1.1 One actor, five helpers (P10)

The hero is one actor per scene, created from the first record of the meta table of the world (`meta_entry` at `$00:800E`, `$8540`, `$89AE`, `$8E70`, `$9228`, `$952A`, `$988E`, seven references to `code_001A28`; section 4.6). The fields the spawn code (R51) copies from the entry are: `$1E = 0` (idle down), `$16 = $1180` (bit `$1000` tile collision, `$0100` not a hit source, `$0080` player), `$22 = $8000` and `$24 = $0B` (anim table `table_058000`, the armed hero), script `code_001A28`.

`code_001A28` stores `X` into `player_actor` (`$039C`), sets the dynamic-tile source with `COP [A9](#$3000, #7F)` (sprite tiles are DMAed from `$7F:3000`), then clones five helper actors. The clones copy the player's `$3C` bytes (FM-A3 1.4), so each starts as a hidden copy of the player at the player's position:

| Helper | Spawn | Script | Role | Pointer kept |
|--------|-------|--------|------|--------------|
| Y1 | `COP [84]` | `code_002F56` (P37) | level-up watcher | - |
| Y2 | `COP [84]` | `code_001FE0` (P13) | soul orb (sprite, orbit centre) | `$03A0`; `$16 = ($16 and $CF7F) or $0310` (no collision, not a hit source or target, runs in sub-frames) |
| Y3 | `COP [84]` | `code_001512` (P01) | input filter | - |
| Y4 | `COP [85]` | `code_0015E0` (P03) | per-frame motion finish, position publish | - |
| Y5 | `COP [85]` | `code_001FCF` (P12) | weapon layer (blade sprite) | `$039E` (it is `$3E,X` of the player: the weapon actor of FM-A2 X044) |

Y2 spawns one more actor, the **orb controller** S (`code_002026`, P14) with `COP [85]`. Run order inside a frame (list run from the tail through `$3E`, FM-A3 1.4: "After" = earlier, "Before" = later): **Y1, Y2, S, Y3, player, Y5, Y4**. Consequences: S reads `joy_pressed` before Y3 strips B and Y, so the spells work even when the filter would remove Y (no weapon); S reads `player_x/y` as published by Y4 in the **previous** frame (one frame of lag); the weapon layer and the sync actor see the player after its animation step.

When `return_active` (`$03FB`) is non-zero at the spawn, the player becomes the passive return-trip actor (P09) after Y1 has been created: no orb, no filter, no weapon layer, no sync actor (the camera does not follow). Every scene reload rebuilds the full set.

### 1.2 What drives the player: animation steps, not frames

The scheduler (`code_0009BF`) runs an actor's script only when `$14` underflows: `DEC $14,X; BPL skip`. `COP [82]` (`Cop82_AnimStepYield`, FM-A3 H090) calls `code_0008F3`, which loads the next 8-byte step of the current animation: `$14` = step duration, velocity `$04` = dx and `$06` = dy (words from the step, negated by the flip bits `$1C`), the sprite map for the step; it returns carry set when the end marker is reached. The actor then yields for `duration + 1` frames; the engine applies `$04/$06` to the position every frame (`code_000A22`: `JSL code_000F28` collision when `$16` bit `$1000`, then `code_00129A`). So:

- the player script runs **once per animation step**, not once per frame; a walk cycle (6 steps of duration 3) costs 24 frames, and the velocity of the first step of each handler decides the speed: **2 px per frame** in all four directions, also for the crab-walk poses (anim `$04` `dy = +2`, `$05` `dy = -2`, `$06` `dy = -2`, `$08` and `$26` `dx = -2`, `$0C` `dx = +2`; `table_058000` steps `03 00 | 00 00 | 02 00`);
- idle animations (`$00`-`$03`) are one step of duration 0 and then the end marker, so the player script runs every frame while standing and re-decides at once;
- everything that must react **between** steps (a released d-pad key, a swing button) has to interrupt the script from outside: that is the whole job of the input filter (P01), which overwrites the player's resume pointer `$18` with `loc_001A65` (P11).

### 1.3 Choosing the action (P11, `code_list_001B2B`) and what the carry means

`loc_001A65` (P11) runs after every animation: dying (`$16` bit `$0400`) goes to `loc_001ED3` (FM-A2 X037); otherwise three paths, by `$0439` (no-combat scene) and `$1B5E` (equipped weapon):

| Path | When | Button handling | Carry on entry to a handler |
|------|------|-----------------|-----------------------------|
| `loc_001A7A` | `$0439 != 0` or `$1B5E = 0` | L or R held: table path; otherwise Right, Left, Down, Up in that priority by direct `BRL`; none: table path (idle slot) | **clear** |
| `loc_001ACD` | armed | B, L or R held: table path; otherwise Right, Left, Down, Up by direct `BRL`; none: table path (idle slot) | **set** on the direct `BRL` |
| table path `loc_001A9E` / `loc_001AEE` | see above | slot by priority B (armed only), Right, Left, Down, Up, none; handler = word `code_list_001B2B[$1E * 6 + slot]`, entered with `PHA; RTS` | `loc_001A9E`: clear; `loc_001AEE` (`loc_001B19`): clear when L or R is held, set otherwise |

The carry chooses between the two animation ids of the eight paired handlers (FM-A2 X017-X024): **carry clear = the `$00`-`$13` pose family, carry set = the `$24`-`$2B` family.** The two families are the same eight poses (idle and walk in the four directions) in two states of the sword:

| Evidence | Reading |
|----------|---------|
| Carry is clear for every no-weapon path, and the unarmed table `table_050000` has 26 entries (`$00`-`$19`) | the unarmed hero only ever plays `$00`-`$13` |
| The armed table `table_058000` has 44 entries (`$00`-`$2B`); `ApplyPlayerWeaponPose` (A9 L017) uses bank `$0A` unarmed and `$0B` armed | `$24`-`$2B` exist only for the armed hero |
| Carry is clear in the armed table path exactly when L or R is held | armed with L or R = the `$00`-`$13` family: **thrust**, the blade stays out |
| R35 (FM-A1 `ApplySwordHit`) ignores a hit unless the player animation `$1E` is below `$24`; `code_001F9D` adds the level strength `$1B72` only for `$20`-`$23` | `$00`-`$13` and the swings `$20`-`$23` can hurt; `$24`-`$2B` (sword carried) cannot |
| `items.md`: L/R thrust, no minimum level; `02-grass-valley.md`: "hold L or R to move sideways ... with a sword you also thrust" | agrees |

This **answers OQ-I006-4**: carry clear = L or R held, or no weapon / no combat; carry set = armed and not holding L or R (walk or idle with the sword carried). Why the table path gives carry set when neither L nor R is held: that is the armed B-only case (a swing, whose handlers ignore the carry) and the armed idle case.

**The state table.** `code_list_001B2B` is 44 rows (anim `$00`-`$2B`) of 6 words; slot 0 = B (swing), slots 1-4 = Right, Left, Down, Up, slot 5 = no key. Every row depends only on the **facing** of its animation (`binary_00FA7F[anim]`), except the 12 rows `$14`-`$1F` (all slots `code_001D3B`, idle up). So the table says "keep facing, choose the pose for the pressed key":

| Facing (of the current anim) | Rows | B | Right | Left | Down | Up | none |
|------------------------------|------|---|-------|------|------|----|------|
| down | `$00 $04 $05 $0C $0D $20 $28 $29` | `$20` | `$0C` | `$0D` | `$04`/`$28` | `$05` | `$00`/`$29` |
| up | `$01 $06 $07 $0E $0F $21 $2A $2B` | `$21` | `$0F` | `$0E` | `$07` | `$06`/`$2A` | `$01`/`$2B` |
| left | `$02 $08 $09 $10 $11 $22 $26 $27` | `$22` | `$09` | `$08`/`$26` | `$10` | `$11` | `$02`/`$27` |
| right | `$03 $0A $0B $12 $13 $23 $24 $25` | `$23` | `$0A`/`$25` | `$0B` | `$13` | `$12` | `$03`/`$24` |

(`x`/`y` = carry clear / carry set. Anims `$05 $07 $09 $0B` walk backwards, `$0C $0D $0E $0F $10 $11 $12 $13` walk sideways, both keeping the facing: the **crab-walk** of the walkthrough, `02-grass-valley.md`: "press and hold the L or R Button to basically move sideways".) Since a direct `BRL` (no L, R or B) always picks the pose for the pressed key without the table, holding Down while facing up turns the player around; with L or R held the table keeps the facing. Both orders use the priority Right, Left, Down, Up; the player does not change direction in the middle of a walk cycle (the filter lets the cycle finish while the key that matches the animation is held).

### 1.4 Facing and movement tables

| Table | Read by | Entry | Meaning |
|-------|---------|-------|---------|
| `binary_00FA7F` (44 bytes) | `code_0021D5` (P17), A9 L015/L017, A4 `TryOpenChest` | byte per anim | facing: 0 up, 1 down, 2 right, 3 left. Idle `$00 $01 $02 $03` = 1 0 3 2, i.e. down, up, left, right; the swings `$20`-`$23` = 1 0 3 2 |
| `binary_00FAAB` (44 bytes) | `code_001892` (P06) | byte per anim | movement direction of the pose: equal to the facing for walks and idles, different for the crab-walk poses (`$05` = 0, `$07` = 1, `$09` = 2, `$0B` = 3, `$0C` = 2, `$0D` = 3, `$0E` = 3, `$0F` = 2, `$10` = 1, `$11` = 0, `$12` = 0, `$13` = 1) |
| `word_00FAD7` (44 words) | `code_0015E0` (P03) | word per anim | extra y offset (0 or 1) of the weapon layer sprite against the player |
| `word_001588` (D01) | `code_001512` (P01) | word per anim | the d-pad bit that keeps the animation alive; equal to the movement direction (`binary_00FAAB`) as a button mask |

The widths come from the readers: `LDA binary_00FAAB,Y` and `LDA binary_00FA7F,Y` are 16-bit loads from byte tables indexed by the animation id (the callers mask with `AND #$00FF`), `LDA word_00FAD7,X` and `word_001588,X` use the doubled index.

### 1.5 The input filter (P01)

Run once per frame before the player script (Y3). In order:

1. `$0464 != 0` (`player_input_lock`, A3: Cop34 increments, Cop33 clears): `joy_pressed = 0` (no key at all).
2. No-combat scene or no weapon: clear B and Y (`TRB #$C000`); this is why you cannot swing in a village.
3. Armed: `JSR code_0018A1` (gem pull, P07, 1.7), then the **minimum level**: `word_0161CE[(weapon - 1) * 2]` (BCD, A5: 01, 05, 11, 15, 16, 19, 22, 24) against `player_level_bcd` (`$1B6A`); a level below the minimum clears bit `$8000` (B). L and R are never touched: thrusts have no minimum level (`items.md`: "thrusts (L/R) don't fall under this though").
4. Player animation in `$14`-`$23`: return at once (these animations must finish: the four swings `$20`-`$23`, the death `$1C`, and `$14`-`$1B`, `$1D`-`$1F`, OQ-I014-2). Otherwise B pressed: interrupt now (a swing starts in the middle of a walk).
5. Dying (`$16` bit `$0400`): force the player script to `loc_001A65` and `COP [91]` here, so this actor idles for good.
6. Otherwise, if `word_001588[anim] and joy_pressed` is zero (the key of the current animation was released): force the player script to `loc_001A65`.

"Force" means `$18,Y = loc_001A65`: the player resumes there on its next run, which is the next frame, and leaves the animation. Idle animations are re-decided every frame anyway, so for them the check changes nothing.

### 1.6 Motion finish, push zones, corner slide (P03-P06)

Y4 runs after the player (and the weapon layer). It sets `$16 bit $0010` (it keeps running in sub-frames, so the player keeps being published during dialogue) and then every frame:

1. `P04` scans the **push zone list** (`$03D8` pointer, `$03DA` bank; both zero outside the rooms below; section 4.1) for a record whose tile rectangle overlaps the player. The zone velocity (`$03D4` dx, `$03D6` dy, signed words, pixels per frame) comes from the last overlapping record that has a non-zero word on that axis. It also publishes `player_x`, `player_y`, `player_tile_x` (`x >> 4`) and `player_tile_y` (`(y >> 4) - 1`). It returns carry clear without scanning when `$03D8 = 0` or `$03A6` (a sub-frame is running).
2. Zone found (carry set): the player's own velocity `$04/$06` is saved, replaced by the zone velocity, `code_000F28` (tile collision, FM-A1 R40) clips it, the clipped value is stored back into `$03D4/$03D6` and **added to the position**, and the player's velocity is restored. So a conveyor pushes at its speed also while the player walks on it, with tile collision, and no corner slide is tried.
3. No zone: `P05` (corner slide, below).
4. If none of the four d-pad bits of `joy_block_mask` is set (the player is in free control) the position is made even on each axis whose push component is zero (`AND #$FFFE`). The player walks 2 px per frame; a conveyor with an odd speed leaves the player on an odd pixel; this snaps back.
5. `$03D4 = $03D6 = 0`; `player_x`, `player_y`, `player_tile_x/y` published again.
6. The weapon layer actor (`$039E`) gets the player's x and `y + word_00FAD7[anim]`.
7. `JSL code_010000` (`AimCameraAtPlayer`, A4 L001).

Zones: the lists are installed by one-shot setter actors (they store the pointers and `COP [86]`) in the rooms of Grass Valley (7 lists, `location_id` 5-9, 11, 12; the conveyor belts of the walkthrough, chapter 2: "the conveyor belt moving southbound"), St. Elles (1 list, two records with `dx = -4`, twice the walking speed), Mountain of Souls (4 lists) and Magridd's Castle (1 list, 8 records all `dy = +1`; chapter 7: "the wind pushes you down"). Of the 54 records, 52 move 1 px per frame (28 `+1` in y, 12 `-1` in y, 7 `+1` in x, 5 `-1` in x) and 2 move 4 px per frame to the left. `lib_027781_part3` zeroes `$03D8` at every scene start (A9).

**Corner slide (P05).** Needs the "blocked" bit `$0004` of the player's `$16` (set by the walk collision R41-R45) and a movement direction from `binary_00FAAB`; it acts only when the matching key is held and the player is **not tile aligned on the other axis** (`x and $0F`, `y and $0F`). It probes the tile column or row beyond the corner with the quadrant masks of the tile type map (`$FC` moving up, `$F3` down, `$F5` right, `$FA` left; low nibble = TL 1, TR 2, BL 4, BR 8 and any high nibble, A9 1.5) and moves the player 2 px toward the side whose tile is free, so the hero slides around the corner of a wall instead of stopping at it. If neither side is free nothing happens.

### 1.7 Gem pull (P07, P08)

Called by the filter only when armed. `code_0018A1` returns at once unless the player animation is `$00`-`$03`, which for an armed hero means **standing still with L or R held (thrust idle)**. Then it walks the actor list from the tail for every actor with `$16` bit `$4000` (pickup) and not `$8000` (off screen) whose animation is `$04`, `$05` or `$06` (the small, medium and large Gem of FM-A2 X077-X079: 1, 5 and 10 Gems), and P08 moves it toward the player when it lies in the lane **in front** of the thrust (17 pixels wide, centred on the player: `player_x + 8 - x < $11` for facing down or up, the same on y for facing left or right) and on the facing side: a Gem 3 px per frame (small), 2 px (medium) or 1 px (large) closer. FM-A8 C04 calls this "the sword push-back scan"; the code **pulls** the Gems toward the player (OQ-I014-3, DISCREPANCY with FM-A8).

### 1.8 Soul orb and spells (P12-P36)

**The orb.** `$1B82` is the bit field of recruited souls (FM-A2 1.3: `$01` Magician, `$02` Light, `$04` Shield, `$08` Detection, `$10` Reality). Y2 (P13) stays hidden (`$16 or $2000`) until `$1B82` is non-zero, then shows itself, spawns S, and loops the orb animation (`COP [A8](#$8000, #0E)` = table `table_070000`, anim 8, repeat `$10`). The walkthrough (`items.md`): "[Soul of Magician] also ends up being the little orb of light surrounding you". S (P14) places the orb every frame:

- steering: the d-pad moves S by +-2 px per axis (`$16`, `$18` = +2, -2 or 0), **whether or not the player can move** (the orb is steered from the controller), and a pull toward the player is added: x +1 when the player is to the right (+2 from a distance of `$50`), -1 to the left (-2 from `$60`), y +1 below (+2 from `$50`), -1 above (-2 from `$40`). With no key S slides to the player at 1 or 2 px per frame; walking with the player it matches the player's 2 px; pushing against a wall the orb drifts ahead by 1 px per frame until the distance grows to `$60` (x) or `$40` (y) and stops there. It leads the player and can be parked in front of enemies: the thing the walkthrough means by "extend far beyond the reach of the sword". S's position is stored back as the centre in `$16`/`$18`;
- orbit: `$0431` is a phase that `code_002163` (P16) increments **once per frame** (twice per frame while the Rotator is held); the sine table `binary_00FC84` and its continuation `binary_00FCC4` (one 256-entry signed period split in 64-byte pieces) is read at `(phase * 2) and $FF` for x, and at the same index into the next 64 bytes (a quarter period later) for y. Each sample is divided by 4 (signed), giving a **circle of radius 31 px** around S, a period of 128 frames. The result is written into Y2 (`$3C,X` of S): Y2 is the visible orb;
- if the cast gate says "skip" (carry set, see below) neither the steering nor the orbit runs for that frame.

**The cast gate (P15)**, called by S every frame with `PHX; JSR`. Order of the tests; each failure falls into `code_002163` (orbit tick, carry clear):

1. `$0439 != 0` (no-combat scene), 2. `$03A6 != 0` (sub-frame running), 3. `$1B62 = 0` (no magic equipped), 4. `($4A) = 0`: the actor free stack is empty (every spawn handler ignores "no slot", OQ-I007-26; this test is what protects the spells from it).
5. `$0433 != 0` ("a spell is live"): no new cast. Only the orbit rules change: with Flame Ball or Light Arrow equipped the gate returns **carry set** (the orb freezes for the launch frames); with the Rotator equipped the phase is bumped once more (double orbit speed while the Rotator is held).
6. `$0433 = 0`: Y held (`joy_pressed and $4000`; the latch makes this a press) and the equipped magic `$1B62 - $11` selects the arm:

| `$1B62` | Spell (ROM text; walkthrough) | Pay (`COP [26]`, BCD, Magic Armor halves, Magic Bell zero, FM-A3 H030) | Cast actor | Damage byte `$30` | Carry | Walkthrough |
|---------|-------------------------------|--------------------------------------------------------------------------|------------|-------------------|-------|-------------|
| `$11` | Flame Ball | 4 | `code_0021D5` (P17) | 5 | set | 4 Gems |
| `$12` | Light Arrow | 8 | `code_002246` (P18) | 10 per arrow | set | 8 Gems |
| `$13` | Magic Flair | 8 | `code_0022F1` (P23) | 20 | clear | 8 Gems |
| `$14` | Rotator | 0 now, 1 per burst | `code_0023DD` (P25) | 5 per burst | clear (+1 phase) | 1 Gem per burst |
| `$15` | Spark Bomb | 8 | `code_002439` (P28) | 30 per bomb | clear | 8 Gems |
| `$16` | Flame Pillar | `$20` = 20 (BCD) | `code_00249D` (P31) | 6 | clear | 20 Gems |
| `$17` | Tornado | 8 | `code_0024F8` (P34) | 15 | clear | 8 Gems |
| `$18` | Phoenix | (not here: the swing handlers, FM-A2 X038-X042) | - | - | - | 2 Gems |

The ROM text spells the third spell "Magic Flair" (`lib_shared_014F74`, `w2_actor_0F905C`), as the walkthrough does. Insufficient Gems: `COP [26]` jumps to `code_002163`, nothing is cast.

**The spell lock.** `$0433` counts live spell actors: the gate does `INC $0433` before it spawns; the Flame Ball, Light Arrow, Rotator and Magic Flair actors end through `code_0026E7` (P36), which `STZ $0433` and consumes the Y press (`TRB #$4000` of `joy_release_latch`, so a held Y does not recast); the Spark Bomb, Flame Pillar and Tornado parents reset the counter to 0 and let their **children** `INC`/`DEC` it, the last child consuming the press. Because the gate tests `$0433` before everything else, **no spell at all can be cast while a Tornado, a pillar or a bomb exists** (the walkthrough says only that one Tornado is allowed; OQ-I014-9).

**Common shape of a cast actor.** The gate spawns it with `COP [85]` (clone of S, so it starts at S's position), flags are stored with `$16 = $03A0` or `$2020` and later `$02A0`: bit `$0100` is "not a hit source" (R34 requires none of `$0D00`), `$0200` "not a hit target", `$0080` hit source, `$0020` projectile, `$0010` runs in sub-frames, `$2000` hidden. So `$03A0` is an **unarmed** state (no damage yet) and `$02A0` the **armed** one. Each copies the orb's position from `$03A0` (Y2) at its first run (`LDY $03A0; $00,X = $00,Y; $02,X = $02,Y`) and plays animations of bank `$0F` (`COP [A8](#$8000, #0F)` = `table_078000`, 54 entries). Movement is not in the scripts: the animation steps carry the velocity (Flame Ball anim 1: `dx = -4`, anim 2: `dy = +4`).

| Spell | Behaviour (source of each number) |
|-------|-----------------------------------|
| Flame Ball (P17) | unarmed `$03A0`, `$30 = 5`, anim `$00` (launch frame, `COP [82]`), sound `BRK #$1B`, armed `$02A0`; facing from `binary_00FA7F[player anim]`: up = anim `$02` with `COP [98]` (flip Y), down = `$02`, right = anim `$01` with `COP [96]` (flip X), left = `$01`; `$1E`, `$20 = 0`, `$2A = 8` passes of 2 steps; `TRB $4000`, `STZ $0433` at launch; kill after the passes. "The direction of the fireball is determined by your facing" (`magic.md`) |
| Light Arrow (P18) | launch anims `$03`, `BRK #$12`, four `COP [B2]` spawns at relative (0, -8), (0, +8), (-8, 0), (+8, 0) with `$16 = $02A0` (P19-P22: north = anim 7 flipped Y, south = 7, west = 5 then 6 x 8, east = 5 flipped X then 6 x 8; `$30 = $0A`), anim `$04`, then P36. "four arrows ... due north, due east, due south, and due west" |
| Magic Flair (P23) | `$16 = $03A0` (unarmed), `$30 = $14`, `COP [85]` the follower P24 (it copies the orb position into its parent every frame while Y is held and kills itself when Y is released: the burst stays where Y was released); charge animations `$09` (5 passes), `$0A` (5), `$0B` (5) and `$0C` (loops while held); on release, armed `$02A0`, burst `$0D` (x3) then `$10` after stage 1, `$0E` (x3) then `$11` after stage 2, `$12` after stage 3, `$13` after the hold; sound `BRK #$21`; then P36. A tap plus three charge levels: "There are three levels of charge" |
| Rotator (P25, P26, P27) | parent `$16 = $2020`; while Y is held: `COP [26](#1)`, `COP [B0]` a burst actor P27 (`$16 = $02B0`, `$30 = 5`, anims `$14`-`$17`, `BRK #$24`) then `COP [1B]` delay 4: one burst per 5 frames, 1 Gem each; when Y is released or the Gems run out: P36 |
| Spark Bomb (P28-P30) | parent hidden `$2020`, `STZ $0433`, loop 4 times: `COP [B0]` a bomb (P30, flags `$03A0`), wait 16 (`COP [1B]` in P29, then `COP [04]` costs one frame more: **18 frames per bomb**); bomb: `$30 = $1E`, `INC $0433`, anims `$18` x4 and `$19` x4, then armed `$02A0`, `BRK #$21`, anim `$1A`, `DEC $0433` and (the last one) consume Y |
| Flame Pillar (P31-P33) | the same spawner pattern (4 pillars, flags `$02A0`, wait 16); pillar: `INC $0433`, `$30 = 6`, `BRK #$0B`, anim `$1C`, anim `$1B` x `$14`, anim `$1D`, `DEC $0433` (last consumes Y). The pillar is damaging for its whole life (6 per hit, no unarmed phase): "fire pillars that last 5 ~ 8 seconds and damage any enemy that touches them" |
| Tornado (P34, P35) | `$16 = $02A0`, spawns the visual P35 (`COP [A8](#$8000, #0D)`, animation `$42` in the second animation system, `COP [92]`/`[94]`, lives while `$0433 != 0`), starts 16 px above the orb, anims `$24` x4, sound `BRK #$16`, `$25`, then `$30 = $0F` and a random walk (a 4-state graph over the 12 movement animations `$1E`-`$23`, `$28`-`$2D`, chosen by `rng_state+1 and 3`; the countdown `$2E` starts at 60 and every state decrements it) until the countdown ends or the actor leaves the screen (`$16` bit `$8000`); then anim `$26` x2, consume Y, `STZ $0433`, kill. "randomly-moving tornado that cannot be controlled; only one is allowed on-screen at a time" |

Two code oddities: the Tornado's first choice is `LDA #$0302; AND #$0003` (an immediate, so always 2, not `rng_state+1`): the first heading is constant (OQ-I014-6). The Spark Bomb walkthrough text ("intervals of sixty degrees ... fourth ... 180 degrees opposite") against the code: one bomb every 18 frames, the orb moving 2 sine steps of 256 per frame, which is 36 steps = 50.6 degrees per interval and 152 degrees in all (OQ-I014-5, DISCREPANCY).

### 1.9 Level-up (P37-P39)

Y1 runs every frame (not in sub-frames). `code_002F56`: at `player_level >= $32` (50) it kills itself (the cap of the walkthrough). Otherwise it loads `player_exp_next` from `word_00FBB8[player_level * 4]` (section 4.4), `COP [91]`, and compares EXP (`player_exp`, 4 bytes BCD) with the threshold (a 32-bit subtract; BCD compares like binary). Level reached:

| Step | Code | Walkthrough (`level-up.md`) |
|------|------|-----------------------------|
| max HP and HP `+2`, capped at `$64` (100) | `loc_002F82`-`loc_002FA3` | "+2 per level", 8 at level 1, 100 at level 47 |
| `COP [37]` | `$043B = max HP - HP` (FM-A3 H032): the pending heal refills HP over time (+1 per 4 frames, A9 L021) | not stated (OQ-I014-17) |
| `INC player_level`; BCD `player_level_bcd + 1` in decimal mode | `loc_002FA3` | - |
| the new BCD level's low bit: odd = `INC $1B76` (defence part), even = `INC $1B72` (strength part) | `loc_002FBF` | "Strength +1 at even levels, defence at odd" (crosswalk 11: A) |
| `TSB $0332 #$1F` | all five HUD dirty bits (A9) | - |
| next threshold loaded; `BRK #$97` (jingle) | - | - |
| 3 times: print "LEVEL UP !" (`asciistring_014516`), wait 21 frames, erase it (`asciistring_014527`, A7), wait 11 frames | `COP [03](#3)` ... `COP [04]` in P39 | not stated |

Then `BRL code_002F56` again, so a large EXP gain gives several level-ups in a row. `PHX`/`PLX` surround the text calls (the renderer clobbers X). The strength and defence parts have **no cap here**; the status screen clamps their display to 12 (A5 `ShowStatusAndSoulsScreen`), which is the "13 / 12" of the walkthrough's table (OQ-I014-18, answers the "where is the cap" half of OQ-I004-10).

### 1.10 Return trip and death

`code_0019A4` (P09) replaces the whole player when `return_active` is set. It waits while `warp_dest_anim` (`$0380`) is non-zero, then takes the owner actor of `switch_owner_table[$0405]` (A3: the record index stored by `lib_0109D6`) and turns the player to face it: the dominant axis of (player - target) decides, ties go to the vertical axis; the result is one of the idle anims `$00` (down), `$01` (up), `$02` (left), `$03` (right), stepped once with `code_0008F3`, then `COP [91]` moves the entry to the final `RTL`. Death is `loc_001ED3` (FM-A2 X037): it forces bank `$0B` and the weapon bank `$0C` because the death animation `$1C` exists only in the 44-entry armed tables (the unarmed `table_050000` stops at `$19`); this answers the "why `$0B` and `$0C`" half of OQ-I006-22.

## 2. Code rows

IDs `P01`-`P39` follow the offsets; the sub-label rows P11, P16 and P26 split the size of the label that contains them.

| ID | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|----|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| P01 | `code_001512` | 5394 / 118 | 1 site / 1 file (`COP [84]` in P10) | player input | `FilterPlayerInput` (A; code, cons FM-A8 C04, FM-A3 H064/H066, walk `items.md`) | actor script Y3; X = own slot; M = X = 16 bits | `joy_pressed` filtered (1.5); player `$18 = loc_001A65` when the animation must be left; dying: `COP [91]` here (idles forever) | A, Y (= `player_actor`); X restored (`PHX`/`PLX`); `dp$00`, `$16`, `$18` (via P07); P08 | r `$0464`, `$0439`, `$1B5E`, `player_level_bcd`, `word_0161CE`, `word_001588`, player `$16`, `$1E`; w `joy_pressed`, player `$18` |
| P02 | `word_001588` | 5512 / 88 | 1 (P01) | player input | see D01 | - | - | - | data |
| P03 | `code_0015E0` | 5600 / 188 | 1 site / 1 file (`COP [85]` in P10) | player motion | `FinishPlayerMove` (B; code, cons camera and weapon layer) | actor script Y4 (`$16 or $0010`); X = own slot, saved with `PHX` | position published (1.6), weapon layer placed, camera aimed (`code_010000`); push applied; position made even; `$03D4/$03D6` zeroed | A, Y; X restored | r `$03D8`, `$03D4`, `$03D6`, `joy_block_mask`, `$039E`, `word_00FAD7`; w `player_x`, `player_y`, `player_tile_x`, `player_tile_y`, player `$00`, `$02`, weapon `$00`, `$02`, `$03D4`, `$03D6` |
| P04 | `code_00169C` | 5788 / 151 | 1 site / 1 file (P03, `JSR`) | player motion | `ScanPushZones` (A; code, cons setters, walk chapters 2 and 7) | X = player; M = 16 | carry set when a zone pushes (`$03D4`/`$03D6` = velocity); carry clear: no list, `$03A6` set, or no overlap; `player_x/y`, `player_tile_x/y` published; DBR restored | A, Y, `dp$16`, `dp$18`; M = 16 on return | r `$03D8`, `$03DA`, `$03A6`, `unk16` records; w `player_x`, `player_y`, `player_tile_x`, `player_tile_y`, `$03D4`, `$03D6` |
| P05 | `code_001733` | 5939 / 351 | 1 site / 1 file (P03, `JSR`) | player motion | `SlideAroundCorner` (B; code, cons R41-R45) | X = player; `$16` bit `$0004` (blocked) | player x or y +-2 toward the free side; X preserved (`TXY` ... `TYX`) | A, Y, `dp$16`, `dp$18`; X through `code_0272B8` | r player `$00`, `$02`, `$16`, `$1E`, `joy_pressed`, `binary_00FAAB`, `tile_type_map`; w player `$00` or `$02` |
| P06 | `code_001892` | 6290 / 15 | 1 site / 1 file (P05) | player motion | `GetMoveDirectionOfAnim` (A; code, data) | X = player | carry clear: A = `binary_00FAAB[$1E]` (word read; caller masks `$FF`); carry set when `$1E >= $2C` | A, Y | r player `$1E`, `binary_00FAAB` |
| P07 | `code_0018A1` | 6305 / 74 | 1 site / 1 file (P01) | pickups | `PullGemsToPlayer` (B; code, cons FM-A2 X077-X079; contradicts FM-A8 "push-back", OQ-I014-3) | A saved; X saved; player animation must be `$00`-`$03` | A, X unchanged; pickups in front moved by P08 | Y, `dp$00`, `dp$16`, `dp$18` | r `player_actor`, `actor_list_tail`, actor `$16`, `$1E`, `$00`, `$02`, player `$1E`, `$00`, `$02`; w `dp$00` |
| P08 | `code_0018EB` | 6379 / 185 | 1 site / 1 file (P07) | pickups | `PullGemTowardPlayer` (B; code) | X = pickup; `dp$00` = player anim 0-3 (0 down, 1 up, 2 left, 3 right), `dp$16`, `dp$18` = player x + 8, y + 8 | the pickup's x or y moved by 3 (anim `$04`), 2 (`$05`) or 1 (`$06`) px toward the player when it is in the 17 px lane and on the facing side | A | w actor `$00` or `$02` |
| P09 | `code_0019A4` | 6564 / 132 | 1 site / 1 file (`BRL` in P10) | return trip | `FacePlayerTowardReturnTarget` (B; code, caller) | actor script, X = player; `return_active` set | player `$1E` = idle anim facing the target, `$20 = 0`, `code_0008F3` once, `$14 = 0`; waits while `warp_dest_anim != 0` or no owner is registered; then `COP [91]` at the final `RTL` | A, Y, `dp$16`, `dp$18` | r `warp_dest_anim`, `$0405`, `switch_owner_table`, player and target `$00`, `$02`; w player `$1E`, `$20`, `$14` |
| P10 | `code_001A28` (part up to `loc_001A65`) | 6696 / 61 | 7 sites / 1 file (`meta_tables_008000`: the hero entry of each of the seven world tables) | player | `InitPlayerActor` (A; code, cons 1.1, A9 L017, FM-A2 X044) | meta entry spawn; X = player slot | `player_actor`, `$03A0` (orb) and `$039E` (weapon) set; five helpers spawned (1.1); return trip branches to P09; ends `COP [91]` at `loc_001A65` | A, Y | w `player_actor`, `$039E`, `$03A0`, player `$34`, `$2C`, `$1A` (A9), Y2 `$16`; r `return_active` |
| P11 | `loc_001A65` | 6757 / 198 | 34 sites / 2 files (`common_actor_001A28_part1` 2, `engine_routines_001D3B` 32: every handler ends `BRL` here) | player | `ChoosePlayerAction` (A; code, cons FM-A2 1.1) | X = player slot; M = 16 | tail-jumps to a handler (`RTS` trick through `PHA` or direct `BRL`), or to `loc_001ED3` when `$16` bit `$0400`; carry as in 1.3 | A; X restored by `PLX` in the table path | r player `$16`, `$1E`, `$0439`, `$1B5E`, `joy_pressed`, `code_list_001B2B` |
| P12 | `code_001FCF` | 8143 / 17 | 1 site / 1 file (`COP [85]` in P10) | player weapon | `RunWeaponLayer` (A; code, cons X044, A9 L017) | actor script Y5; X = own slot | `$16 and $CEFF` (visible, no collision), `INC $24` (clone of the player: bank `$0B` becomes `$0C`, `table_060000`), `COP [91]`, `COP [82]`: steps the animation that FM-A2 X044 writes into `$1E/$20/$14` | A | w `$16`, `$24`, `$1E`, `$20` |
| P13 | `code_001FE0` | 8160 / 70 | 1 site / 1 file (`COP [84]` in P10) | soul orb | `RunSoulOrb` (A; code, walk `items.md`) | actor script Y2 | hidden (`$16 or $2000`) while `$1B82 = 0` or `return_active`; then visible, `COP [85]` P14, table `$0E` anim 8 x `$10` forever; when the soul appears after the scene start the actor is first placed at (0, 0) (OQ-I014-4) | A, Y | r `return_active`, `$1B82`; w `$16`, `$00`, `$02`, `$22`, `$24`, `$1A` |
| P14 | `code_002026` | 8230 / 228 | 1 site / 1 file (`COP [85]` in P13) | soul orb | `RunSoulOrbController` (A; code, cons 1.8) | actor script S (`$16 or $0010`); X = own slot, `PHX` | calls P15; steers S, pulls it to the player, writes the orbit position into Y2 (`$3C,X`) | A, Y (set to Y2), X restored (`PLX`) | r `joy_pressed`, `player_x`, `player_y`, `$0431`, `binary_00FC84`, `binary_00FCC4`; w own `$00`, `$02`, `$16`, `$18`, Y2 `$00`, `$02`; `dp$16`, `dp$18` |
| P15 | `code_00210A` | 8458 / 198 | 1 site / 1 file (`JSR` in P14) | spells | `DispatchSpellCast` (A; code, walk `magic.md`) | X = S (saved by P14); `COP` valid because X is the slot | carry set: skip steering this frame (Flame Ball and Light Arrow launch); carry clear otherwise; casts through `COP [26]` + `COP [85]` (1.8) | A, Y; callee scratch | r `$0439`, `$03A6`, `$1B62`, `($4A)`, `$0433`, `joy_pressed`; w `$0433`, `$0431`, Gems (`$1B66/$1B68`, `$0332` through `Cop26`) |
| P16 | `code_002163` | 8547 / 5 | 21 sites / 1 file (`BEQ`/`BNE` exits of P15 x 18, `COP [26]` jump operands x 6) | spells | `TickOrbitPhase` (A; code) | - | `INC $0431`, carry clear, `RTS` | - | w `$0431` |
| P17 | `code_0021D5` | 8661 / 113 | 1 site / 1 file (`COP [85]` in P15 `loc_002168`) | spells | `RunFlameBall` (A; code, walk) | actor script, clone of S | one fireball (1.8): flags `$03A0` then `$02A0`, `$30 = 5`, anim `$00`, then `$01` or `$02` by facing, 8 passes, kill; `TRB $4000`, `STZ $0433` at launch | A, Y | r `$03A0`, `player_actor`, `binary_00FA7F`; w `$16`, `$30`, `$00`, `$02`, `$1E`, `$20`, `$2A`, `joy_release_latch`, `$0433` |
| P18 | `code_002246` | 8774 / 90 | 1 site / 1 file (`COP [85]` in P15 `loc_002178`) | spells | `RunLightArrow` (A; code, walk) | as P17 | launch anim `$03`, sound `$12`, four arrows P19-P22 by `COP [B2]`, anim `$04`, `BRL` P36 | A, Y | as P17; spawns 4 actors |
| P19 | `code_0022A0` | 8864 / 21 | 1 site / 1 file (`COP [B2]` in P18) | spells | `RunLightArrowUp` (A; code) | spawned at (0, -8), `$16 = $02A0` | `$30 = $0A`, flip Y, anim `$07`, then `$08` x 8, kill (`loc_0022EE`) | A | w `$30`, `$1C` |
| P20 | `code_0022B5` | 8885 / 19 | 1 site / 1 file (`COP [B2]` in P18) | spells | `RunLightArrowDown` (A; code) | spawned at (0, +8) | as P19 without the flip | A | w `$30` |
| P21 | `code_0022C8` | 8904 / 19 | 1 site / 1 file (`COP [B2]` in P18) | spells | `RunLightArrowLeft` (A; code) | spawned at (-8, 0) | `$30 = $0A`, anim `$05`, then `$06` x 8, kill | A | w `$30` |
| P22 | `code_0022DB` | 8923 / 22 | 1 site / 1 file (`COP [B2]` in P18) | spells | `RunLightArrowRight` (A; code) | spawned at (+8, 0) | as P21 with flip X; `loc_0022EE` (`COP [86]`) is the shared kill of P19-P22 | A | w `$30`, `$1C` |
| P23 | `code_0022F1` | 8945 / 192 | 1 site / 1 file (`COP [85]` in P15 `loc_002188`) | spells | `RunMagicFlair` (A; code, walk) | as P17 | charge stages and burst (1.8); `COP [85]` P24; ends in P36 | A, Y | r `joy_pressed`; w `$16`, `$30`, `$1C`, `$1E`, `$20` |
| P24 | `code_0023B1` | 9137 / 44 | 1 site / 1 file (`COP [85]` in P23) | spells | `TrackOrbWhileCharging` (A; code) | child of P23 (`$3C,X` = P23) | while Y is held the parent P23 is moved to the orb's position; Y released: `COP [86]` | A, Y; X saved | r `joy_pressed`, `$03A0`; w parent `$00`, `$02` |
| P25 | `code_0023DD` | 9181 / 6 | 1 site / 1 file (`COP [85]` in P15 `loc_002198`) | spells | `RunRotator` (A; code, walk) | as P17 | `$16 = $2020`, falls into P26 | A | w `$16` |
| P26 | `code_0023E3` | 9187 / 30 | 1 site / 1 file (`COP [1B]` resume operand of itself) | spells | `RepeatRotatorBurst` (A; code) | Rotator parent | Y held: pays 1 Gem (`COP [26]`, jump to P36), `COP [B0]` burst P27, `COP [1B]` delay 4; Y released: `BRL` P36 | A, Y | r `joy_pressed`; Gems |
| P27 | `code_002401` | 9217 / 56 | 1 site / 1 file (`COP [B0]` in P26) | spells | `RunRotatorBurst` (A; code, walk) | spawned with `$16 = $02B0` | at the orb: `$30 = 5`, `BRK #$24`, anims `$14`-`$17` one step each, kill | A, Y | w `$00`, `$02`, `$30` |
| P28 | `code_002439` | 9273 / 25 | 1 site / 1 file (`COP [85]` in P15 `loc_0021A5`) | spells | `RunSparkBombSpawner` (A; code, walk) | as P17 | `$16 = $2020`, `STZ $0433`, loop 4: `COP [B0]` P30 (`$03A0`), `COP [1B]` P29 after 16 frames | A | w `$16`, `$0433` |
| P29 | `code_002452` | 9298 / 5 | 1 site / 1 file (`COP [1B]` in P28) | spells | `RepeatSparkBombSpawn` (A; code) | - | `COP [04]` (next bomb) or, after the fourth, `COP [86]` | A | - |
| P30 | `code_002457` | 9303 / 70 | 1 site / 1 file (`COP [B0]` in P28) | spells | `RunSparkBomb` (A; code, walk) | spawned with `$16 = $03A0` | `INC $0433`, `$30 = $1E`, at the orb, `COP [A4]` (behind), anims `$18` x4, `$19` x4, `$16 = $02A0`, `BRK #$21`, anim `$1A`, `DEC $0433`; the last one `TRB $4000`; kill | A, Y | w `$0433`, `joy_release_latch` |
| P31 | `code_00249D` | 9373 / 25 | 1 site / 1 file (`COP [85]` in P15 `loc_0021B5`) | spells | `RunFlamePillarSpawner` (A; code, walk) | as P17 | as P28 with `COP [B0]` P33 (flags `$02A0`) and `COP [1B]` P32 | A | w `$16`, `$0433` |
| P32 | `code_0024B6` | 9398 / 5 | 1 site / 1 file (`COP [1B]` in P31) | spells | `RepeatFlamePillarSpawn` (A; code) | - | as P29 | A | - |
| P33 | `code_0024BB` | 9403 / 61 | 1 site / 1 file (`COP [B0]` in P31) | spells | `RunFlamePillar` (A; code, walk) | spawned with `$16 = $02A0` | `INC $0433`, `$30 = 6`, at the orb, sound `$0B`, anim `$1C`, `$1B` x `$14`, `$1D`, `DEC $0433`, last consumes Y, kill | A, Y | w `$0433`, `joy_release_latch` |
| P34 | `code_0024F8` | 9464 / 366 | 1 site / 1 file (`COP [85]` in P15 `loc_0021C5`) | spells | `RunTornado` (A; code, walk) | as P17 | one Tornado (1.8): grows, wanders, vanishes | A, Y | r `rng_state+1`, `$16`; w `$16`, `$30`, `$2E`, `$0433`, `joy_release_latch` |
| P35 | `code_002666` | 9830 / 18 | 1 site / 1 file (`COP [85]` in P34) | spells | `RunTornadoBody` (B; code; second animation system `COP [92]`/`[94]`, table `$0D` anim `$42`: what it draws is OQ-I014-20) | child of P34 | loops while `$0433 != 0`, then kill | A | r `$0433` |
| P36 | `code_0026E7` | 9959 / 12 | 7 sites / 1 file (`BRL` x 6 in P18, P23, P26; `COP [26]` jump operand in P26) | spells | `EndSpellActor` (A; code) | spell actor, X = slot | `TRB $4000` of `joy_release_latch` (consume the Y press), `STZ $0433`, `COP [86]` | A | w `joy_release_latch`, `$0433` |
| P37 | `code_002F56` | 12118 / 152 | 2 sites / 2 files (`COP [84]` in P10, `BRL` in P39) | level-up | `WatchForLevelUp` (A; code, walk `level-up.md`) | actor script Y1; X = own slot | until EXP reaches the next threshold: `RTL` each frame; then the level-up of 1.9 and the blink | A, Y; X saved around the text calls | r `player_level`, `word_00FBB8`, `player_exp`, `player_exp+2` (`$1B7A`); w `player_exp_next`, `player_exp_next+2` (`$1B7E`), `player_max_hp`, `player_hp`, `$043B`, `player_level`, `player_level_bcd`, `$1B72` or `$1B76`, `$0332` |
| P38 | `code_002FEE` | 12270 / 15 | 1 site / 1 file (`COP [1B]` in P37) | level-up | `ClearLevelUpText` (A; code) | - | overwrite the text, wait 11 frames, resume at P39 | A, Y | text renderer |
| P39 | `code_002FFD` | 12285 / 8 | 1 site / 1 file (`COP [1B]` in P38) | level-up | `RepeatLevelUpBlink` (A; code) | `$2E` = blinks left | `COP [04]` (next blink) or back to P37 (`BRL`); `loc_003002` = `COP [86]`, the level-50 exit of P37 | A | r `$2E` |

## 3. Data rows

| ID | Label | Off / size | Readers | Name | Content |
|----|-------|-----------|---------|------|---------|
| D01 | `word_001588` | 5512 / 88 | P01 (`LDA word_001588,X`, X = anim * 2) | `AnimKeepKeyMask` (A; code, cons P01) | 44 words (anims `$00`-`$2B`): `$0400` Down, `$0800` Up, `$0200` Left, `$0100` Right = the d-pad bit that keeps the animation. `$00`-`$13` follow `binary_00FAAB` (idle `$00 $01 $02 $03` = Down, Up, Left, Right); `$14`-`$23` are `$0000` (never read: P01 returns before the table for these anims); `$24`-`$2B` = Right, Right, Left, Left, Down, Down, Up, Up |
| D02 | `code_list_001B2B` | 6955 / 528 | P11 (two `LDA @code_list_001B2B,X` at 6852 and 6947) | `PlayerActionTable` (A; code, cons 1.3) | 44 rows x 6 words (section 4.2): `&engine_routines_001D3B` handler addresses |

### 3.1 Tables read from other blocks

| Table | Owner | Read here by | Width evidence |
|-------|-------|--------------|----------------|
| `binary_00FA7F`, `binary_00FAAB`, `word_00FAD7` | `data_00F9F7` | P17, P05/P06, P03 | 1.4 |
| `binary_00FC84`, `binary_00FCC4` | `data_00F9F7` | P14 | byte reads (`SEP #$20`) at index `(phase * 2) and $FF`; `BPL` tests the sign; the second table is read at the same index |
| `word_00FBB8` | `data_00F9F7` | P37 | section 4.4 |
| `word_0161CE` | `lib_0161CE` | P01 | word read at `(weapon - 1) * 2` |
| `table_050000`, `table_058000`, `table_060000`, `table_068000`, `table_070000`, `table_078000` | system | `code_0008F3` through `$22`/`$24` | entry counts: 26, 44, 44, 80, 17, 54 (counted from the extracted table headers) |
| `unk16` lists | `w0_actor_01AFFD`, `w2_actor_0FA59C`, `w3_actor_02220D`, `w5_actor_027019` | P04 | section 4.1 |
| `meta_entry` (hero, 7 copies) | `meta_tables_008000` | R51 | section 4.6 |

## 4. Structure layouts

### 4.1 Push zone record (`unk16`, 8 bytes, list ends at a first byte of `$FF`)

`us/structs.json`: `unk16` = Byte, Byte, Byte, Byte, Word, Word, delimiter `255`. Field evidence from P04 (`SEP #$20` for the bytes, `REP #$20` for the words; the list is read with `DBR = $03DA`):

| Offset | Width | Field | Evidence |
|--------|-------|-------|----------|
| +0 | 1 | `x0`: first tile column | `CMP $0000,Y` against `dp$16 = (x + 15) >> 4`: the zone is skipped when `dp$16 < x0` |
| +1 | 1 | `x1`: end column (exclusive) | `CMP $0001,Y` with `player_tile_x = x >> 4`: skipped when `player_tile_x >= x1` |
| +2 | 1 | `y0`: first tile row | against `dp$18 = (y - 1) >> 4` |
| +3 | 1 | `y1`: end row (exclusive) | against `player_tile_y = (y >> 4) - 1` |
| +4 | 2 | `dx`: push in x, pixels per frame, signed | `LDA $0004,Y; BEQ skip; STA $03D4` |
| +6 | 2 | `dy`: push in y | `LDA $0006,Y; BEQ skip; STA $03D6` |

Terminator: `LDA $0000,Y; INC; BEQ end` (first byte `$FF`). Stride `$08`. 13 lists, 54 records. Pointer `$03D8` (word) and bank `$03DA` (byte).

### 4.2 State table row (`code_list_001B2B`, 12 bytes)

Index = `anim * 12 + slot * 2`: `ASL; CLC; ADC anim; ASL; ASL` = `anim * 12`, then `INX INX` per slot (B slot 0 only on the armed path). Each word is a handler address in bank `$00` minus nothing: the code stores `DEC; PHA; RTS`, so the handler's address is the table word and the routine is entered at that address. Rows `$00`-`$2B` as in 1.3; 264 words. Size check: 6955 to 7483 = 528 = 264 x 2.

### 4.3 Animation step (`unk3`, `unk12`, `unk11`: not owned here)

For the player the step is `unk3` (`us/structs.json`: 6 bytes and a 3-byte pointer): word `+0` = duration (`$14`), word `+2` = dx, word `+4` = dy, then the sprite map pointer; widths confirmed by `code_0008F3` (`LDA $0000,Y` etc.). Spell tables use `unk12` with the same first six bytes.

### 4.4 EXP threshold table (`word_00FBB8`, 4 bytes per level)

Index `Y = player_level << 2` (`ASL; ASL`); `LDA word_00FBB8,Y` is stored in `$1B7E` (**high** word) and `LDA word_00FBB8+2,Y` in `player_exp_next` (**low** word): the entry is two big-endian BCD words. The compare subtracts the low words and then the high words with carry. Walkthrough check (`level-up.md`): level 18 (words at index `$24`, `$25`) = `$0008 $3000` = 83,000; level 19 = `$0011 $5000` = 115,000; level 1 = `$0000 $0100` = 100 and level 2 = `$0000 $0280`. Entry 50 is never read (P37 stops at level 50).

### 4.5 Soul bit field (`$1B82`)

One byte used: `$01` Magician (`w0_actor_01A7AC`, written with `STA`), `$02` Light (`w1_actor_01D6AB`), `$04` Shield (`w2_actor_0F80A4`), `$08` Detection (`w4_actor_022E10`), `$10` Reality (`w5_actor_0251DC`); the four later souls `ORA` their bit. `lib_0116C3` tests `$02`, `$10`, `$08`, `$04` (the effects), `engine_005354` masks `$1F`, `lib_0118FC` shifts it for the souls page. P13 uses only "not zero".

### 4.6 Hero meta entry (`meta_entry`, 14 bytes; the seven copies are identical)

`us/structs.json`: Byte, Byte, Byte, Word, Byte, Word, Address, `@Code`. Hero entry: `01 02 03 | 0005 | 00 | 1180 | table_058000 | code_001A28`. R51 maps `+2` to `$25`, `+5` to `$1E`, `+6` to `$16`, `+8` to `$22` and `+A` to `$24`, `+B` to `$18` and `+D` to `$36` (FM-A1). The hero therefore starts with animation 0, `$16 = $1180`, table `$8000`, bank `$0B`. The meaning of `+0`, `+1` and `+3` is not read here.

## 5. WRAM and DP proposals

| Address | Evidence | Proposed name | Conf | Users |
|---------|----------|---------------|------|-------|
| `$0431` | incremented once per frame by P16 and once more by the Rotator arm of P15; `(value * 2) and $FF` indexes the sine tables in P14 | `soul_orbit_phase` | A | P14, P15, P16 |
| `$0433` | `INC` in P15 per cast, `INC`/`DEC` in P30 and P33, zeroed by P28, P31, P36 and by P34; tested first in P15 and P35 (FM-A5 proposed `spell_charge`, C; the code shows a live-actor count) | `spell_active_count` | B | P15, P17-P36, A5 menu exit |
| `$03A0` | `STY` of the Y2 spawn in P10; every spell copies its position | `soul_orb_actor` | A | P10, P17-P36 |
| `$039E` | `STY` of the Y5 spawn in P10; FM-A2 X044, A9 L017 | `player_weapon_actor` | A | P03, X044, A9 |
| `$03D4`, `$03D6` | push velocity of the current zone, zeroed every frame by P03 | `push_dx`, `push_dy` | A | P03, P04 |
| `$03D8`, `$03DA` | pointer and bank of the zone list, set by the four setters, zeroed by A9 L035 | `push_zone_list`, `push_zone_bank` | A | P04 |
| `$0464` | A3 (`player_input_lock`) confirmed: zeroes `joy_pressed` in P01 | `player_input_lock` | A | P01 |
| `$1B82` | 4.5 | `souls_owned` | A | P13, `lib_0116C3`, `engine_005354`, `lib_0118FC`, five soul actors |
| `$1B72`, `$1B76` | strength and defence parts of the level (FM-A1 `level_power`, `level_defense`); P37 increments one per level | (names kept) | A | P37, A5, X044 |
| `$1B7A`, `$1B7E` | high words of `player_exp` and `player_exp_next` | `player_exp+2`, `player_exp_next+2` | A | P37 |
| `$0405` | switch id read by P09 (A3 `return_record`) | (kept) | B | P09 |

Existing names kept: `joy_pressed`, `joy_release_latch`, `joy_block_mask`, `player_x`, `player_y`, `player_tile_x`, `player_tile_y`, `player_actor`, `warp_dest_anim`, `return_active`, `actor_list_tail`, `player_level_bcd`, `player_exp`, `player_exp_next`, `player_level`, `player_hp`, `player_max_hp`, `rng_state`, `switch_owner_table`, `tile_type_map`. Equipped ids: `$1B5E` `equipped_weapon`, `$1B62` `equipped_magic`; `$0439` `no_combat_scene`; `$03A6` `subframe_active`; `$043B` `heal_pending`; `$0332` `hud_dirty`.

## 6. Inner labels

Every label that is not a row. Offsets are the `{n}` tag of the first instruction.

| Row | Labels (offset) |
|-----|-----------------|
| P01 (8) | `loc_00151A` 5402, `loc_001524` 5412, `loc_00152F` 5423, `loc_001547` 5447, `loc_00155F` 5471, `loc_001577` 5495, `loc_001578` 5496, `loc_00157F` 5503 |
| P03 (4) | `loc_001630` 5680, `loc_001633` 5683, `loc_001649` 5705, `loc_001657` 5719 |
| P04 (7) | `loc_0016BE` 5822, `loc_0016C4` 5828, `loc_0016E3` 5859, `loc_001711` 5905, `loc_001719` 5913, `loc_001725` 5925, `loc_001732` 5938 |
| P05 (28) | `loc_00173C` 5948, `loc_001742` 5954, `loc_001750` 5968, `loc_001753` 5971 (an unreferenced `RTS`), `loc_001754` 5972, `loc_00175D` 5981, `loc_00178E` 6030, `loc_001790` 6032, `loc_001795` 6037, `loc_001798` 6040, `loc_0017A1` 6049, `loc_0017AA` 6058, `loc_0017D7` 6103, `loc_0017D9` 6105, `loc_0017DE` 6110, `loc_0017E1` 6113, `loc_0017EA` 6122, `loc_0017F3` 6131, `loc_00182B` 6187, `loc_00182D` 6189, `loc_001832` 6194, `loc_001835` 6197, `loc_00183E` 6206, `loc_001847` 6215, `loc_00187F` 6271, `loc_001881` 6273, `loc_001886` 6278, `loc_001889` 6281 |
| P06 (1) | `loc_00189F` 6303 |
| P07 (3) | `loc_0018C7` 6343, `loc_0018CA` 6346, `loc_0018E8` 6376 |
| P08 (20) | `loc_0018F8` 6392, `loc_001900` 6400, `loc_00190C` 6412, `loc_00191C` 6428, `loc_00191F` 6431, `loc_001923` 6435, `loc_00192B` 6443, `loc_001937` 6455, `loc_001947` 6471, `loc_00194A` 6474, `loc_00194E` 6478, `loc_001956` 6486, `loc_001962` 6498, `loc_001972` 6514, `loc_001975` 6517, `loc_001979` 6521, `loc_001981` 6529, `loc_00198D` 6541, `loc_00199D` 6557, `loc_0019A0` 6560 |
| P09 (10) | `loc_0019AC` 6572, `loc_0019BB` 6587, `loc_0019D7` 6615, `loc_0019E3` 6627, `loc_0019FA` 6650, `loc_001A06` 6662, `loc_001A0B` 6667, `loc_001A10` 6672, `loc_001A15` 6677, `loc_001A18` 6680 |
| P10 (1) | `loc_001A3D` 6717 |
| P11 (14) | `loc_001A70` 6768, `loc_001A7A` 6778, `loc_001A8C` 6796, `loc_001A92` 6802, `loc_001A98` 6808, `loc_001A9E` 6814, `loc_001AC4` 6852, `loc_001ACD` 6861, `loc_001ADC` 6876, `loc_001AE2` 6882, `loc_001AE8` 6888, `loc_001AEE` 6894, `loc_001B19` 6937, `loc_001B23` 6947 (`loc_001A65` itself, 6757, is the row) |
| P13 (5) | `loc_001FF3` 8179, `loc_00200B` 8203, `loc_002013` 8211, `loc_002016` 8214, `loc_00201E` 8222 |
| P14 (12) | `loc_00203A` 8250, `loc_002050` 8272, `loc_002065` 8293, `loc_002081` 8321, `loc_00208A` 8330, `loc_0020AF` 8367, `loc_0020B8` 8376, `loc_0020E1` 8417, `loc_0020E3` 8419, `loc_0020FE` 8446, `loc_002100` 8448, `loc_002108` 8456 |
| P15 (11) | `loc_002140` 8512, `loc_002168` 8552, `loc_002176` 8566, `loc_002178` 8568, `loc_002186` 8582, `loc_002188` 8584, `loc_002198` 8600, `loc_0021A0` 8608, `loc_0021A5` 8613, `loc_0021B5` 8629, `loc_0021C5` 8645 |
| P17 (5) | `loc_00221E` 8734, `loc_002220` 8736, `loc_002225` 8741, `loc_002227` 8743, `loc_00222A` 8746 |
| P22 (1) | `loc_0022EE` 8942 (branch target of P19-P22) |
| P23 (5) | `loc_002342` 9026, `loc_002351` 9041, `loc_002369` 9065, `loc_002381` 9089, `loc_002399` 9113 |
| P24 (1) | `loc_0023DA` 9178 |
| P26 (1) | `loc_0023EE` 9198 |
| P30 (1) | `loc_00249A` 9370 |
| P33 (1) | `loc_0024F5` 9461 |
| P34 (34) | `loc_002534` 9524, `loc_002546` 9542, `loc_00254C` 9548, `loc_002552` 9554, `loc_002555` 9557, `loc_00255C` 9564, `loc_002564` 9572, `loc_00256C` 9580, `loc_002573` 9587, `loc_00257A` 9594, `loc_002582` 9602, `loc_002589` 9609, `loc_002590` 9616, `loc_002598` 9624, `loc_00259F` 9631, `loc_0025A6` 9638, `loc_0025AD` 9645, `loc_0025B5` 9653, `loc_0025C0` 9664, `loc_0025D0` 9680, `loc_0025D6` 9686, `loc_0025D9` 9689, `loc_0025F3` 9715, `loc_0025F9` 9721, `loc_0025FF` 9727, `loc_002602` 9730, `loc_00261C` 9756, `loc_002622` 9762, `loc_002628` 9768, `loc_00262B` 9771, `loc_002645` 9797, `loc_00264B` 9803, `loc_002651` 9809, `loc_002654` 9812 |
| P35 (1) | `loc_00266B` 9835 |
| P37 (6) | `loc_002F61` 12129, `loc_002F82` 12162, `loc_002F91` 12177, `loc_002FA3` 12195, `loc_002FBF` 12223, `loc_002FC2` 12226 |
| P39 (1) | `loc_003002` 12290 |

Sub-label rows that exist because something branches or jumps into them from outside the routine that contains them: P11 (`loc_001A65`: 32 `BRL` from FM-A2's handlers, plus P01), P16 (`code_002163`: 21 references, 18 of them from P15's own arms but also the `COP [26]` failure operands), P26 (`code_0023E3`: its own `COP [1B]` resume) and, in other batches, `loc_001ED3` (FM-A2 X037, one `BRL` from P11). `loc_002176` and `loc_002186` are internal. Each of P11, P16 and P26 needs its own `names` row in PC; a branch into them from a moved routine would not create the label (mapping plan 8c).

## 7. Fan-in, findings and placement

Fan-in of the batch (references outside the definition):

| Routine | Sites | Files |
|---------|-------|-------|
| `loc_001A65` P11 | 34 | 2 |
| `code_002163` P16 | 21 | 1 |
| `code_001A28` P10 | 7 | 1 (`meta_tables_008000`) |
| `code_0026E7` P36 | 7 | 1 |
| `code_002F56` P37 | 2 | 2 |
| `code_list_001B2B` D02 | 2 | 1 |
| every other row | 1 | 1 |

Findings for later batches and for PB:

- **The state table is a function of facing**, not a 44-state machine (1.3): 8 rows per facing plus 12 filler rows. The 28 handlers of A2 can be renamed by pose (FM-A2 suggested holding the mechanical names back until A10): `StartPlayerAnim00Or29` = `StartIdleDown` (`$00`/`$29`), `01Or2B` = `StartIdleUp`, `02Or27` = `StartIdleLeft`, `03Or24` = `StartIdleRight`, `04Or28` = `StartWalkDown`, `06Or2A` = `StartWalkUp`, `08Or26` = `StartWalkLeft`, `0AOr25` = `StartWalkRight`; `05` `07` `09` `0B` = `StartBackstepDown/Up/Left/Right` (face one way, walk the other), `0C`-`13` = `StartSidestep{Down,Up,Left,Right}{Right,Left,Down,Up}` as in the table of 1.3; `$20`-`$23` = the swings facing down, up, left, right. Names for PC to decide; the facing of every id is fixed by `binary_00FA7F`.
- **OQ-I006-4 answered** (carry clear = L/R held or no weapon: the `$00`-`$13` pose family, which for the armed hero is the thrust; carry set = armed walk and idle: `$24`-`$2B`). **OQ-I006-22 partly answered** (why the death handler forces banks `$0B` and `$0C`). **OQ-I007-26** is guarded in the spell gate by `LDA ($4A)`; the other spawners (the pillar and bomb spawners spawn four actors in a row) rely on the same check made once, before the first spawn.
- **FM-A8 C04**: the "sword push-back scan" `code_0018A1` pulls Gems toward a standing, thrusting player (OQ-I014-3, DISCREPANCY).
- **Walkthrough checks**: Flame Ball 4 Gems, Light Arrow 8 with four arrows N/E/S/W, Magic Flair 8 with three charge levels (the code has a tap plus three levels), Rotator 1 Gem per burst held, Spark Bomb 8 (four bombs), Flame Pillar 20, Tornado 8 with one at a time, Phoenix 2 (`magic.md`: all costs match); the min-level thrust exemption (`items.md`); L/R crab-walk and thrust (chapters 1 and 2); level cap 50, HP +2 per level, strength at even levels and defence at odd levels (`level-up.md`, crosswalk 11); EXP table rows 1, 2, 18, 19. Two mismatches: the Spark Bomb angle (OQ-I014-5, DISCREPANCY) and the strength and defence cap (OQ-I014-18: the cap is in the display only; DISCREPANCY against the walkthrough's "caps" wording). ROM spelling "Magic Flair" equals the walkthrough's.
- **Latent defects and dead bytes**: `LDA #$0302` in the Tornado (OQ-I014-6); `loc_001753` is an unreferenced `RTS`; `word_001588` entries `$14`-`$23` are never read; the 12 filler rows of D02 are only reachable if a `$14`-`$1F` animation ends while L, R or B is held; a spell that fails `COP [26]` still flows through `code_002163` (no refund needed: nothing is paid).
- **Subsystem split (proposals for PB, no move in this step)**: `player_core` (P01, P03-P11, D01, D02 and the A2 handlers X017-X044: one actor), `soul_orb` (P12-P16), `spells` (P17-P36 together with A2's Phoenix projectiles X045-X049), `level_up` (P37-P39). Today the file names `common_actor_001A28_part1`..`part4` describe positions in the interleaving, not subsystems: `part3` is 12 bytes that only the spells use, `part4` is unrelated to the player script apart from being a helper actor.
- **Placement constraints**: P05, P07 and P08 call `code_0272B8`, `code_02731A`, `code_027331` (bank `$04`) by `JSL`, so they are bank-free; every `JSR` inside the part is `&`, so P01/P03-P09 and P14-P16 must stay in one bank with their callees (`$00`); `code_list_001B2B` holds `&` 16-bit handler addresses, so the table and the 28 handlers (A2) must share bank `$00`; P11 reaches the handlers by `BRL` (a 16-bit signed offset): moving the handlers away needs `JML`s. `loc_001A65` is the `BRL` target of 32 handler sites.
- **Hidden inputs**: P09 depends on `warp_dest_anim` being zero (OQ-I014-13); P14 assumes `$3C,X` is Y2 (S is cloned from Y2 and linked "Before" it: `COP [85]`); P24 assumes `$3C,X` is P23 (spawned with `COP [85]` from P23); P36 and the pillar and bomb children rely on `$0433` being a counter.
