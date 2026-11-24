# Mesen2 question inventory (PQ, consolidation)

Written in iteration I059. Inputs: all 57 files of `plans/extracted-audit/questions/` (I001, I002, I004 to I058; there is no I003 file), the open items of `plans/mapping/mapping-action-plan.md` (§0, §8c to §8e and the unchecked boxes), `plans/doc-audit/placement/spike-decision.md` and `plans/doc-audit/placement/pinned.md`. Built from a fresh `npm run extract:lt`.

**Nothing in this file was run.** Every "expected" line is the static reading of the source row, written as a hypothesis for the experiment to confirm or reject. Nothing here is a fact about the game. No note, name, comment, block, override or doc was changed by this step.

How to use it: take one experiment group (section 4) at a time. Each group lists its rows, the setup, the few watches, what the static reading expects, and which note, name or doc the result changes. Rows that need no emulator are in the static queue (EG = `SQ`), rows that need a decision from you are in the decision queue (EG = `DQ`). Counts per mode, priority and experiment group are in `plans/extracted-audit/results/I059_results.md`.

## 1. Conventions used in this inventory

### 1.1 Why the source files could not be merged by their own letters

The 57 files do not use one scheme:

| Item | What the files do | What this inventory does |
|------|-------------------|--------------------------|
| Mode letters | I004 to I016 and I024 to I058: `R` = static read, `R+S` = read then runtime, `S` = runtime, `D` = decision. I017 to I023 (and the plan): `S` = static, `R` = runtime. Some I017 to I023 rows use the letter the other way round from their own header. | **Mode is re-derived from the "how to settle" text of each row**, not from the letter. |
| Priority | `P1` to `P5` in most files; `L`/`M` in I025; `Low`/`Med` in I042 to I049; `low`/`medium`/`high` in I050 and I051. | `P1` source P1; `P2` source P2 or "high"; `P3` source P3, "Med", "medium", "M"; `P4` source P4, P5, "Low", "low", "L". A merged row takes the highest priority of its members. |
| Tags | `DISCREPANCY`, `GAP`, `BUG`, `TOOL`, `DECISION`, or none | Kept. `DISC` below means `DISCREPANCY` (ROM against the walkthrough or against a project document). |
| IDs | `OQ-Innn-k`, scoped to one iteration, some reused as aliases (for example `OQ-I058-1` asks what `OQ-I004-1` asks) | One canonical row per question (`Q-xx-nn`); the **Absorbs** column lists every source ID as `Innn-k` (the `OQ-` prefix is left out). `OQ-I032-11` and `OQ-I032-14` were retired in I032 and do not exist. |

### 1.2 Mode

| Mode | Meaning |
|------|---------|
| `ST` | Settled by reading `extracted/`, the walkthrough or a document. No emulator. Queue: `SQ`. |
| `ST+RT` | Read first (the static half is usually written in the source row), then confirm with a short Mesen2 run. |
| `RT` | Needs a runtime run. |
| `DEC` | Needs a decision from you (naming, layout, tool change, wording). Queue: `DQ`. |

### 1.3 Priority

| Pri | Meaning |
|-----|---------|
| P1 | A defect in the rebuilt ROM, or a change that alters the ROM bytes. |
| P2 | Changes a documented fact or name of a high fan-in routine, feeds many other rows, or guards the regroup and rebuild. |
| P3 | A documented fact about one feature, a walkthrough mismatch, or an isolated routine. |
| P4 | Flavour, rare path, dead-code confirmation, cosmetic wording. |

### 1.4 Experiment group (EG) codes

`A` boot, title and special locations; `B` code/data log (CDL) coverage; `C` hero damage and item effects; `D` enemy and boss stats; `E` level-up and stat caps; `F` hero movement, spells, orb, return trip; `G` flags, switches, lairs, chests, save; `H` scene load, maps, transitions, camera; `I` collision and tile types; `J` text engine, glyphs and spellings; `K` menus, HUD, status, Master's menu; `L` audio and SPC; `M` VRAM, HDMA, palettes, sprites, animation; `N` engine invariants (pool, NMI, DP and DBR, COP trace, bit meanings); `O` regroup regression harness and R-2 residuals; `P1` to `P8` one pass per world (Grass Valley, GreenWood, St. Elles, Mountain of Souls, Dr. Leo's Lab, King Magridd's Castle, World of Evil, common actors); `SQ` static queue; `DQ` decision queue.

### 1.5 Method limits learned in earlier iterations (apply to every group)

- Power-on work RAM is random: do not watch `$1C6A` (or any scratch cell) from frame 0; take the watch after the title.
- `compare_runs` with 232 watches timed out. Use at most about 6 watches per `compare_runs`; use `get_access_summary`, `set_breakpoints` or `trace_between` for wide questions.
- A plain `take_screenshot` after `advance_frame`, `play_input_file` or a scene jump can be black or a strip while the machine runs. Use `take_screenshot` with `layers` = `["bg1","bg2","bg3","obj"]` (I021 method) or `step_scanline` with count 235 first.
- A scene jump needs the scene word and the arrival values together: `$0318` (area << 8 or scene), `$037C`, `$037E` and `$0380`. Known good: `$0318 = 0x0306`, `$037C = $0080`, `$037E = $00A0`, `$0380 = 0` loads the Metal Mantis room from the Trial Room. `$0318 = 0x0501` and `0x0101` showed black screens in the I018/I019 runs without a diagnosis (rows Q-TO-08).
- Recordings used so far: `trial.rec` (3,677 frames, title to Trial Room), `boss_fight.rec` (538 frames). `menu.rec` (354 frames) is timing-sensitive and no longer a valid comparator. **None of these files is stored in the repository** (new row Q-TO-11).
- Relocated code changes the pc and the frame phase: per-frame equality is only valid between two builds that keep the bank 0 engine code where it is (Q-EN-19).
- Only the rebuilt ROM is run. Never compare it with the original ROM; convert CDL and trace addresses through `rebuilt/layout.json` and `us/names/`. Resolve a label to an address with `load_labels` and `get_label_address` instead of typing an address from memory.

## 2. Carry-ins that are not question rows

### 2.1 Mapping plan items (`plans/mapping/mapping-action-plan.md`)

| ID | Item | State at I059 | Disposition |
|----|------|---------------|-------------|
| M-1.8 | 1.8 Descriptive file names: 319 `graphics_`, `tilemap_`, `palette_`, `spritemap_`, `music_` keys in `us/files.json` still carry only an offset | Open. The location-name table that the plan said it was waiting for exists (§8c). | `DQ` after the identification runs of EG-M (screenshots and VRAM/CGRAM dumps give the role of each asset). Rename mechanism is `us/files.json` keys, not `names/`. P3. |
| M-1.10 | 1.10 Spritemap struct (`us/structs.json` has a `spritemap` entry) | Open as a decision. I050 decoded the record layouts statically. | `DQ`: apply or not (with M-2.8). P3. |
| M-1.11 | 1.11 `config.json` vector names | Done in practice: `BootGame`, `HandleCop`, `HandleBrk`, `HandleVBlank`, `HandleIrq` are in `us/config.json` (rewritten by the names tool in I023 to I025). | Tick the box (row I059-4). |
| M-2.8 | 2.8 Struct inventory: `unk1` .. `unk17` remain in `us/structs.json`, only `meta_entry` and `spritemap` are named | Open. Facts: `unk8` is 420 records of 32 bytes. FM-A11 §4.17 proposes retypes. | `DQ`, row Q-TO-09 (I033-10). P3. |
| M-2.10 | 2.10 Pointer coagulation of about 1,100 `binary_` leaves | Open; waits for the sprite frame format (documented statically in I050). | `DQ`, row Q-TO-09 (I033-15). P4. |
| M-2.17 | 2.17 Properties (`scene`, `order`, `movable`) | Applied through `npm run blocks` in I015 to I022 (`set group`, `set scene`, `set movable`). | Tick the box (row I059-4). |
| M-3.6 | 3.6 `data_00BA0D`, `data_00EE8E`, `data_00F99A`, `data_00F9F7`: who loads them | Identified and named in I033 (lair records, scene variant rules, exit/chest/plate lists); the checkbox is still empty. Remaining unknowns are field meanings (Q-FL-06, Q-SC-06). | Tick the box after row I059-4 is checked. |
| M-3.7 | 3.7 CDL cross-check: bytes executed that the extraction calls data, code never executed, M/X at run time | Open; equivalence of the Pass 3 partition was verified in §8c. | **EG-B.** P2. |
| M-3.9 | 3.9 `meta_tables_008000` split | Blocked by R-2: the block is pinned `movable: false` and the bank-base idiom is fixed by a transform (spike-decision.md). A split keeps it in bank 1. | `DQ`, row Q-TO-01 (decision after the residual hazards). P3. |
| M-8c | §8c "Still open": 3.6, 3.7, 3.9, 2.17, 1.8 | As above. | |
| M-NAMES | Area and scene names table (areas `00` to `15`) | Written into `us/groups.json`. Locations `$0F` to `$13` of Up Above have no name string. | Row Q-LC-01. |

### 2.2 Early open questions (I001, I002) and R-2

All 15 rows of `OQ-I001-*` and `OQ-I002-*` are in the tables below (Q-CO, Q-WM, Q-EN, Q-LC, Q-TO). `OQ-I001-2` (R-2) is settled by the spike (section 5); its residuals are Q-TO-01. R-2 summary for the experiments: `meta_tables_008000` is pinned `movable: false`; `lib_01065B` (now `lib_animation`) uses a transform (`LDA $&meta_tables_008000, Y` to `LDA $$8000, Y`); eight 2-byte references to the five other movable blocks remain unchecked.

### 2.3 Open points this step found (new rows, logged in `I059_questions.md`)

| ID | Point | Row |
|----|-------|-----|
| OQ-I059-1 | The recordings and savestates behind every Mesen2 comparison are not in the repository | Q-TO-11 |
| OQ-I059-2 | Mode legends and priority scales of the question files conflict; the legend of later files should be fixed in the iteration preamble | Q-TO-12 |
| OQ-I059-3 | `plans/doc-audit/placement/pinned.md` still says in four rows that `npm run blocks` has no `split-part` and the IRQ part cannot be split; I042 added `split-part` and cut that part | Q-TO-13 |
| OQ-I059-4 | Mapping plan boxes 1.11, 2.17 and 3.6 are unchecked although the work was done in later iterations | Q-TO-14 |

## 3. Deduplicated rows

Columns: **Absorbs** = source IDs (`Innn-k` is `OQ-Innn-k`). **State** is written in the question text when the static half is done. Tag `-` = none.

### 3.1 Enemy and boss stats, identity and lairs (cluster BH)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-BH-01 | Boss HP: ROM 69 / 79 / 89 / 99 for Floating Skull, Poseidon, Tin Doll, Demon Falcon, and 99 for the Deathtoll Mage (walkthrough 70 / 70 / 80 / 90 / 100). One question under four IDs; keep I004-1 as the canonical ID (I058-1 asks whether to retire the duplicate) | I004-1, I033-1, I039-3, I040-2, I058-1 | ST+RT | P2 | DISC | D |
| Q-BH-02 | Purple Bull: the walkthrough says 23 HP, the only 2700 EXP record has 45 HP | I004-2, I033-2 | ST+RT | P3 | DISC | D |
| Q-BH-03 | Toy Calvary: walkthrough 29 HP / 175 EXP; ROM type `$27` is 24 / 175 and type `$26` is 20 / 170 with no bestiary row. Which record is which | I004-3, I033-4, I038-3 | ST+RT | P3 | DISC | D |
| Q-BH-04 | Monster Blocks: walkthrough 4 HP and 2 EXP; ROM row `$2E` has 4 HP and EXP word 3 | I004-4, I034-11, I049-1 | ST+RT | P3 | DISC | D |
| Q-BH-05 | Skeleton Soldier is in the chapter 7 prose and has no bestiary row. Matched in I058 to `mc_enemy_skeleton_soldier_0FE236` (w5 type `$10`, 23 HP, 750 EXP, confidence C); what stays open is the missing bestiary row (a DISC note, no runtime need) | I004-7, I039-5 | ST | P4 | DISC | SQ |
| Q-BH-06 | ROM meta records with no walkthrough name (w1 `$31`, `$34`, `$36`, `$37`, `$38`; w3 `$31`, `$35`; w4 `$23`, ...) and world 4 `$26` / `$23`: which monsters are they | I004-8, I033-3 | ST | P2 | DISC | SQ |
| Q-BH-07 | Green Lizard Man: bestiary 8 HP / 14 EXP; ROM types `$37` and `$38` have 12 / 12 and 15 / 15 | I035-1 | ST+RT | P3 | DISC | D |
| Q-BH-08 | EXP words that look never paid (Ice Crystal `$35`; floor spears `$31` with EXP `$3000` and immunity `$0200`): real or a data slip | I035-2, I049-5 | RT | P3 | GAP | D |
| Q-BH-09 | Pool matches that HP and EXP cannot tell apart (Blue Liquid, Fly, Green Humanoid, Walking Bush; Purple Bird; Ghost Head): are the identities right | I004-11, I034-10 | ST+RT | P3 | - | D |
| Q-BH-10 | Which monster type each lair spawns, which lair records spawn the bosses, where the Fairy Gem EXP amounts come from, and whether a lair's monsters appear in the lair location (+B) or the home location (+0) (170 of 420 records differ) | I004-12, I004-13, I015-10, I040-14 | ST+RT | P2 | - | D |
| Q-BH-11 | Mountain of Souls lairs `$CB`, `$CC` spawn Fire Bat stats where the walkthrough says Cave Bats | I037-2 | ST+RT | P4 | DISC | D |
| Q-BH-12 | The Hermit Crab and the Tin Doll set `$1A` bit `$0400` (metal class) but the bestiary says "Metal? No" | I036-8, I038-2 | RT | P3 | DISC | D |

### 3.2 Hero damage, items and combat (cluster CB)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-CB-01 | Super Bracelet: text and walkthrough say +2 strength and defense; the code doubles damage dealt and halves damage taken. Which is real | I005-1, I009-4 | ST+RT | P2 | DISC | C |
| Q-CB-02 | Power Bracelet and Shield Bracelet: "doubles offensive power" and "doubles defense"; where is the doubling applied (before or after the defense subtraction) and what is the "50" of level-up.md | I049-2 | ST+RT | P3 | DISC | C |
| Q-CB-03 | Critical Sword: the code has a critical branch for sword 3 only (kills the target unless it is `$039A`); the walkthrough says a higher critical rate | I005-2 | ST+RT | P3 | DISC | C |
| Q-CB-04 | Psycho Sword: the walkthrough lists "N/A" but the code freezes metal, spirit and special actors (`$1A` bits `$0E00`, `$26` = 180). Which wording goes into the notes | I005-3, I009-3, I053-1 | ST+RT | P3 | DISC | C |
| Q-CB-05 | Recovery Sword: 1 HP per kill in the code; the description says "filled", the walkthrough "some HP in battles" | I005-4, I053-2 | ST+RT | P3 | DISC | C |
| Q-CB-06 | Magic Bell, Strange Bottle, Medical Herb: they act only when equipped (inventory bit 7, `equipped_bracelet`). Does the Bell keep Gems at death and does the walkthrough wording hold; what does a Herb found after use do | I006-1, I006-2, I053-4 | ST+RT | P2 | DISC | C |
| Q-CB-07 | Runtime half of the Herb chest: a second Herb chest opened while one is owned heals at once (`heal_pending = max HP - HP`). Reachability is answered statically (I053, from OQ-I026-7) | I053-3 | RT | P3 | GAP | C |
| Q-CB-08 | Gem costs (4, 8, 8, 1, 8, 20, 8, 2), Magic Armor halving (minimum 1), Bell exemption and weapon minimum levels: do the descriptions equal what `Cop26` deducts and are BCD halves safe. Static half answered in earlier iterations | I004-9, I006-24, I007-16, I009-10 | ST+RT | P2 | - | C |
| Q-CB-09 | Gem pickup values (10 for any animation not listed; `code_002EC0` loops animation 7) and drop thresholds (2w+1 and 4w+4 per cent, Lucky Blade) | I006-8, I006-9 | ST+RT | P3 | - | C |
| Q-CB-10 | Is 999,999 the real Gems cap (the walkthrough lists none)? | I013-8 | ST+RT | P4 | - | C |
| Q-CB-11 | What a hit does to the victim: who writes a positive stun `$26` (blink on alternate frames) and a negative one (palette 7 flash); `Cop39` writes `$FFE0` and BRK `$04`; the "knock-back" wording in notes has no routine behind it | I023-1, I025-7, I047-6 | ST+RT | P3 | GAP | C |
| Q-CB-12 | Enemy gauge: how long it stays (`$0330` set to `$80` on a hit, minus 2 per frame, `$FE` idle); who reads `$0336` and `$0338`; the colour for a gauge value of 130 or more (index past `GaugeColorLadder`) | I005-13, I009-15, I023-2, I010-5 | ST+RT | P2 | - | C |
| Q-CB-13 | Meaning of the actor `$16` bits `$0008`, `$0040`, `$0200` and `$1A` bits (`$0080`, `$0200`, `$2000`, `$4000`, `$8000`) and the shared fields `$22`, `$24`, `$2C`, `$34`, `$14`, `$30` | I001-4, I005-14, I009-17, I035-14, I035-15, I037-5, I049-9 | ST+RT | P2 | GAP | N |
| Q-CB-14 | Phoenix: `$30 = $14` for the projectile but the equipped Phoenix uses the attack formula; final form defence `$FF` against the walkthrough's "1 ~ 2 points" | I006-26, I049-3 | ST+RT | P3 | GAP | C |
| Q-CB-15 | Light Armor block (BRK `$0C`, no stun, carry clear): does the same hit repeat every frame | I049-4 | ST+RT | P3 | GAP | C |
| Q-CB-16 | An actor spawned by another copies the first `$3C` bytes, so a fireball hurts with the spawner's attack (`$38`), and a child of a lair monster inherits the lair slot `$32`: intended | I049-8, I044-7 | ST+RT | P3 | GAP | C |
| Q-CB-17 | `KillAllOtherActors` at each boss death: which actors survive (NPCs, HUD, player), and does a living NPC ever get killed | I006-17 | ST+RT | P3 | - | C |
| Q-CB-18 | `DestroyHazardsNearOrb` (Soul of Shield, `$16` = `$0301` inside +-`$30`): what is destroyed | I024-9 | ST+RT | P4 | - | C |
| Q-CB-19 | Sword hit conditions: the attack stat adds level strength only in animations `$20`-`$23`; a hit is ignored from `$24`; an armed hero walking without L or R uses `$24`-`$2B`; is the blade the only hit source | I005-23, I048-4, I048-6 | ST+RT | P2 | GAP | C |
| Q-CB-20 | Respawn: `RespawnOrKillActor` respawns only when `$1A` bit `$1000` is set; no code stores it, and `RunEnemyDeath` clears `$1A` first. Is the branch dead (and the "600 frames off screen" reading wrong) | I007-12, I044-6, I049-7 | ST | P3 | GAP | SQ |
| Q-CB-21 | Which actors carry `$16` bit `$0080` (hit sources) and `$0020` (projectiles) and what each puts in `$30` (`$FF` always kills) | I005-18 | ST | P2 | - | SQ |

### 3.3 Hero: level-up, movement, spells, return trip (cluster HE)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-HE-01 | Strength and defense caps: the walkthrough says 13 / 12, the level-up code has no cap, the status screen clamps the shown parts at 12 (`CMP #$0C`); which screen enforces what | I004-10, I009-6, I014-16, I014-18, I032-8 | ST+RT | P2 | DISC | E |
| Q-HE-02 | `level_power` `$1B72` and `level_defense` `$1B76` at the start of a new game, against the walkthrough's `Level / 2 + 1` and `Level / 2 - 1` | I048-1 | ST+RT | P3 | GAP | E |
| Q-HE-03 | Status page "Next level": the threshold from `LevelExpThresholds` or the points still missing; EXP is stored as 8 BCD digits, not 24 bits (static half done) | I053-6, I031-4 | ST+RT | P3 | DISC | E |
| Q-HE-04 | Level-up: heal speed (`COP [37]` sets `max HP - HP` as pending heal), blink once per level when two levels come together | I014-17, I014-19, I032-9 | RT | P4 | GAP | E |
| Q-HE-05 | Spark Bomb: the walkthrough says four bombs at 60 degree intervals, the fourth 180 degrees from the first; the code spaces them differently | I014-5, I032-3 | ST+RT | P2 | DISC | F |
| Q-HE-06 | Flame Pillar duration (walkthrough 5 to 8 seconds; code: animation `$1B` repeated `$14` times) | I014-8, I032-13 | RT | P4 | GAP | F |
| Q-HE-07 | Tornado first heading is `LDA #$0302; AND #$0003` (always 2): random or fixed | I014-6, I032-6 | ST+RT | P4 | GAP | F |
| Q-HE-08 | Spell cast lock: no spell while a Spark Bomb, Flame Pillar or Tornado lives (`$0433` != 0), and what `$0433` / `$0434` are (the menu exit clears both when the magic changed) | I014-9, I032-7, I009-11 | RT | P3 | GAP | F |
| Q-HE-09 | What the Tornado body actor draws (animation `$42` of table `$0D`, second animation system) | I014-20, I032-12 | RT | P4 | GAP | F |
| Q-HE-10 | Magic Flair damage `$14` for all charge levels, only the burst grows | I014-7, I032-5 | RT | P3 | GAP | F |
| Q-HE-11 | Rotator: 1 Gem per burst (every 5 frames) and what a short supply does | I014-12 | RT | P4 | - | F |
| Q-HE-12 | Walk speed 2 px per frame in all four directions and the derived timings (24 frames per walk cycle) | I014-1, I032-15, I048-3 | RT | P3 | GAP | F |
| Q-HE-13 | Hero animations `$14`-`$17`, `$18`-`$1B`, `$1D`-`$1F`: when are they played and why does the filter protect them | I014-2, I032-2, I048-2 | RT | P3 | GAP | F |
| Q-HE-14 | Soul orb: starts at map (0, 0) when a soul is obtained after the scene loaded; lags the hero by one frame | I014-4, I032-4, I014-15 | RT | P4 | GAP | F |
| Q-HE-15 | St. Elles push records (dx = -4): can the hero walk against them; visible effect of the even-pixel snap | I014-10, I014-11 | RT | P4 | - | F |
| Q-HE-16 | A walk animation ends when the key is released and a swing needs no wait | I014-14 | RT | P3 | - | F |
| Q-HE-17 | `warp_dest_anim` `$0380` during the return trip and the facing wait | I014-13, I032-10 | ST+RT | P4 | GAP | F |
| Q-HE-18 | Pull Gems: FM-A8 called the routine a "sword push-back scan"; the code moves Gems toward the hero | I014-3, I032-1 | ST+RT | P3 | DISC | F |
| Q-HE-19 | Death return: scene = world index + 1 (areas 0 / 1 to 7); is each a world shrine; `SaveGameToSlot` stores the same value | I006-22, I046-1 | RT | P3 | GAP | F |
| Q-HE-20 | Return path: what starts `return_active` `$03FB`, what `$03B4` = `$20` is, what `$0405` holds (the last door record used) and how return mode ends | I005-17, I007-8, I008-12 | ST+RT | P2 | - | F |
| Q-HE-21 | Facing of animations `$20`-`$23` and of the four Phoenix scripts; what carry set or clear means in the pose state table | I006-3, I006-4 | ST+RT | P3 | - | F |
| Q-HE-22 | Animation data bank `$0A` (unarmed) against `$0B` (armed) | I031-3 | RT | P4 | GAP | F |
| Q-HE-23 | `player_hidden_count` `$0464`: input lock, can it count above 1 (`Cop34` increments, `Cop33` clears) | I007-9, I025-10 | RT | P3 | - | F |

### 3.4 Engine, scheduler, COP semantics (clusters EN, CO)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-EN-01 | `rng_state`: `mnemonics.json` and the memory map put it at `$0301-$0311`; the bucket scan of `CullAndSortActors` stops on a negative word right after the bucket table. I013-1 answers the scan stop (I005-5 settled, section 5); the runtime half is the real range | I013-1 | ST+RT | P2 | DISC | N |
| Q-EN-02 | Stack relocation during `RunActors` and `RunSubFrame`: NMI must be off; `MusicLoadUpload` calls `EnableNmi` in the middle of the work phase with the stack pointer possibly moved | I005-20, I056-4 | RT | P2 | GAP | N |
| Q-EN-03 | D is 0 whenever NMI fires and a script reaches COP with D = 0 and DBR = `$01`; are the `B = 1` overrides at 78758 and 80300 true at every call site | I043-3, I045-3, I002-7 | RT | P3 | GAP | N |
| Q-EN-04 | Quintet LZ ring at `$7E:0100-$01FF` shares page 1 with the stack: safe | I011-8 | ST+RT | P2 | - | N |
| Q-EN-05 | Second `STX $0433` in the library and the dependence of the tile type map build on the bank `$01` mirror of `$0200` | I013-13 | ST+RT | P4 | - | N |
| Q-EN-06 | Worst case length of `HandleVBlank` against vblank | I043-5 | RT | P4 | GAP | N |
| Q-EN-07 | The 64-slot pool: what ends the free-slot stack (`dp$4A` reaches `$1880`), can the pool fill during play, and the spawn handlers ignore the carry of `PopFreeSlot` (Y = `$06AA`) | I044-2, I044-3, I007-26 | RT | P3 | GAP | N |
| Q-EN-08 | Why `InitSceneState` calls `RunActors` twice before `ApplyPlayerWeaponPose` | I044-1 | ST+RT | P4 | GAP | N |
| Q-EN-09 | Spawn order: do "After" spawns first run next frame and "Before" spawns in the same frame; the names say after and before | I044-4, I007-25 | RT | P4 | GAP | N |
| Q-EN-10 | Two `COP [82]` sites that follow neither `COP [80]` nor `COP [91]` | I045-2 | ST+RT | P4 | GAP | N |
| Q-EN-11 | Boss death stores the box in `$0425`-`$042B` and increments `$042D` (contact lock): where is it cleared | I006-20 | ST+RT | P4 | - | N |
| Q-EN-12 | `$0458`: boss-fight lock that stops the exit tile `$FE`, set by the six boss actors, cleared when the music reload ends | I007-10 | ST+RT | P2 | - | N |
| Q-EN-13 | `Cop17` (367 uses) stores a script pointer in `$30`: what consumes it | I007-14 | ST+RT | P2 | - | N |
| Q-EN-14 | Shared fields `$2C`, `$2E`, `$34`: does any actor use two meanings at once | I007-19 | ST+RT | P3 | - | N |
| Q-EN-15 | `Cop2F` shifts the player and the actor at its `$3E` link: always the weapon `$039E` (or the shadow) | I007-21, I025-9 | ST+RT | P3 | - | N |
| Q-EN-16 | `COP [B0]` flags `$4000`, `$2010`, `$0200`: OR-ed into or stored in the new actor's `$16` | I006-19 | ST+RT | P3 | - | N |
| Q-EN-17 | Units of the `COP [0C]` margin (lair box plus 2) and the `COP 9A/9B` thresholds: pixels or tiles | I006-25, I037-10 | RT | P4 | - | N |
| Q-EN-18 | `Cop8F`/`Cop90` "face the player" with flipX; `Cop9A`/`9B` treat left and right differently (left `abs(d) > t`, right `d >= t`) | I007-27, I007-28, I025-5 | ST+RT | P3 | - | N |
| Q-EN-19 | Frame phase: after the bank 0 regroup the builds differ by one frame of output on a scene change and the CPU registers differ at equal frames while watched values are equal; is `compare_runs` per-frame equality still a valid comparator | I019-1, I020-8, I021-4 | RT | P2 | - | O |
| Q-CO-01 | `Cop8D` / `Cop8E` read the jump operand only on the taken path (BRL without skipping it) and have 0 uses: intended or a defect, delete | I001-1, I007-3 | DEC | P3 | - | DQ |
| Q-CO-02 | The flag test of `Cop07` / `Cop08` when the flag word has bit 15 set: does `docs/cop/index.md` describe it correctly | I007-1 | ST | P2 | DISC | SQ |
| Q-CO-03 | `$16` bit 15: "in view" (docs/cop/index.md) or "off screen" (FM-A1 R27); does `CopAD` wait while off screen | I005-11, I007-2 | ST+RT | P2 | DISC | N |
| Q-CO-04 | `docs/cop/index.md` has stale use counts (`Cop91`: 0, measured 414) and describes `Cop22` as "at the actor position" while the code samples the row below the footprint | I007-18, I007-23 | ST | P3 | DISC | SQ |
| Q-CO-05 | Which `$1B1E` inventory entries do commands `0A`, `0B`, `18`, `19` handle; what `Cop25`, `Cop26`, `Cop3A` do | I001-3 | ST | P3 | - | SQ |
| Q-CO-06 | Handler and mnemonic names are readings of the code, not trace-checked: which are wrong | I001-7, I002-8 | RT | P3 | - | N |

### 3.5 WRAM names and mnemonics (cluster WM)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-WM-01 | Direct page operands (about 1,617 uses) and immediates such as `LDY #$06AA` cannot be named: should gaia-core learn to resolve them | I002-1 | DEC | P2 | TOOL | DQ |
| Q-WM-02 | `$0332` HUD dirty bits (`$10` set by `ApplyGemPickup`, `Cop26` and the Gems chest; `$02` EXP, `$04` HP) and the other next most used unnamed cells (`$03B4`, `$03A6`, `$03E5/$03E7`, `$046A`, `$0454`-`$0468`) | I002-2, I006-18, I008-13 | ST+RT | P3 | - | N |
| Q-WM-03 | `$043B`, `$043D` result words of commands | I002-3 | ST+RT | P3 | - | N |
| Q-WM-04 | Slot words `$039A` (boss actor, exempt from critical kill, freeze and projectile immunity), `$039C`, `$039E`, `$03A0`, and the unnamed `$0372`, `$1A02`, `$1A04` | I002-4, I005-15, I023-3 | ST+RT | P2 | - | N |
| Q-WM-05 | Status cells `$1B5E`-`$1B64`, `$1B72`, `$1B76`, `$1B8C`-`$1B90`, `$1C62`-`$1C89` | I002-5 | ST | P3 | - | SQ |
| Q-WM-06 | Long buffers: `$7E8000` (tile `$FD` intact lair, `$FE` sealed; same layer as `tile_type_map`?), `$7EC000`, `$7F0203`, `$7F6FC0` (top halves of two-row glyphs), `$7E7000/$7800` HDMA staging | I002-6, I006-23, I010-7 | ST+RT | P3 | - | N |
| Q-WM-07 | Confirm the names and roles of `$0372`, `$042D` (contact lock), `$0462` (scene loading), `$0468` (scripted input), `$03DB` (BG) | I005-16 | ST+RT | P3 | - | N |
| Q-WM-08 | `$0466`: a "page shown" counter in `gv_front_end`, the curtain actor, `RunEnding` and the lair engine; leave unnamed or name per use | I034-16, I040-3 | DEC | P4 | - | DQ |
| Q-WM-09 | `equipped_bracelet` `$1B64` also holds the Herb, Bottle or Bell: rename | I024-7 | DEC | P4 | - | DQ |

### 3.6 Scene load, locations, maps, transitions (clusters LC, SC)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-LC-01 | Up Above locations `$0F` to `$13` (`unnamed_0f` .. `unnamed_13`) have no name string; the reduced main loop runs for locations `$10` to `$12`; are `$10` = title, `$11` = ending, `$12` = boot; the four placement lists without a hero (`PlacementA00S09` to `S0C`) belong to them | I001-6, I005-21, I043-2, I044-5, I046-5 | ST+RT | P2 | - | A |
| Q-LC-02 | Title Mode 7 scene `00/0A`: `$047E` angle is read once and never written, `$0480` scale, `$0445` file-select switch; which actor moves the picture | I006-13, I011-4, I024-4 | ST+RT | P3 | - | A |
| Q-LC-03 | Hub `A00S09` (`unnamed_0f`): when is the player there; the walker has seven stops with gates `$1B00`-`$1B05`, post-ending steps depend on `$1F04` | I034-14 | RT | P3 | GAP | A |
| Q-SC-01 | Extra rows of a tilemap stream (33 locations with H+1, 8 with H+2, 3 with H+3, one with W+1) and the source rectangle of the five map patches: inside the live map or in extra rows | I012-1, I012-2 | ST+RT | P2 | - | H |
| Q-SC-02 | Map patch records 0 (Metal Mantis, location `0C`) and 4 (Deathtoll, location `7C`) are byte for byte equal: intended | I012-3 | DEC | P3 | - | DQ |
| Q-SC-03 | After a scene load, `map_width_pages` and `map_height_pages` equal the table entry for every location | I012-5 | RT | P3 | - | H |
| Q-SC-04 | `RunBossMapPatch` (spawned by five boss scripts): does its patch close the room, open a way or reveal a floor | I024-3 | RT | P4 | - | H |
| Q-SC-05 | First tileset load after boot writes through `[dp$2C], Y` and never sets `dp$2E` (bank `$7E`?); the raw tilemap flag (height bit 7) leaking into `map_height_px`; the asset list has a dummy first record and no end sentinel | I011-1, I011-2, I011-3 | ST+RT | P2 | - | H |
| Q-SC-06 | `$031E` scene variant: music only or more; the six variant-0 rows (`$0C`, `$22`, `$32`, `$44`, `$59`, `$72`) are the "boss defeated" switches | I011-5, I011-6, I033-13 | ST+RT | P2 | - | H |
| Q-SC-07 | Scene profile bits: byte 4 bits 2-3 and `$036F`; `no_combat_scene` `$0439`; bits 4-5 of byte 4 as OAM priority (`$0373`); BG2 attribute bit 8 | I011-7, I029-2, I029-3, I029-4 | ST+RT | P3 | - | H |
| Q-SC-08 | First frame camera: `RedrawBackgroundsAtEntry` centres BG1 at player y - `$90`, `AimCameraAtPlayer` at y - `$80`: visible 16 px jump | I008-8, I026-4 | RT | P3 | - | H |
| Q-SC-09 | Dead stores and divide: `$0392` / `$0394` are written and never read; a BG1 ratio nibble of 0 divides by zero | I008-6, I008-7, I026-5 | ST | P3 | - | SQ |
| Q-SC-10 | `$038A` / `$038C` added to the BG1 and BG2 parallax result | I008-9 | RT | P3 | - | H |
| Q-SC-11 | Transition types `$00`-`$07`, `$80`, `$81`-`$FF`: what each looks like; which values are ever selected (scripts set only 4, return trips `$80`) | I013-3, I013-4, I025-6, I031-6 | RT | P3 | GAP | H |
| Q-SC-12 | Ending warps: after the Deathtoll text the ROM warps to area 0 scene 7; the King's epilogue goes to area `$06` scene `$01`; Marie's monologue leads to `A0AS01`: which scenes are they | I006-11, I037-6, I038-9 | RT | P3 | - | H |
| Q-SC-13 | Scenes `0E/05` and `11/04` are both named "A dream 1": which walkthrough dreams, are they used | I004-14 | ST+RT | P3 | - | H |
| Q-SC-14 | Exit pointer of dream location `$5A` points at `ExitListLoc56` (56 rows): shared doors or a slip | I033-5 | RT | P3 | DISC | H |
| Q-SC-15 | Each compressed asset must lie in one 32 KiB bank of the source ROM; does the rebuild keep that | I046-3 | ST+RT | P3 | GAP | H |
| Q-SC-16 | `docs/areas-and-scenes.md` lists the A03 scenes in an order that differs from the placements (scene 4 is the tulip's dream, scene 5 is Leo's Paintings 4) | I034-17 | DEC | P4 | DISC | DQ |

### 3.7 Collision and tile types (cluster TL)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-TL-01 | Tile type codes `$05`, `$0A`, `$03`, `$0C`, `$06`, `$0F`, `$01` (lair marker): which occur in the shipped maps; `tile_type_map` is one byte per metatile, not one word | I005-8, I047-2, I013-2 | ST+RT | P3 | DISC | I |
| Q-TL-02 | `ProbeTileAtVelocity` ORs `$0004,X` twice, and `GetTileType` leaves B stale before a 16-bit `CMP #$000F`; one-point path actors (width or height bit 3, `$16` bit `$1000`) | I005-9, I005-10, I047-4 | ST+RT | P2 | - | I |
| Q-TL-03 | East and south have no tile boundary pre-check; an actor footprint mark (`$F0`) or an index of `$4000` or more stops the actor | I005-12, I047-1 | ST+RT | P3 | - | I |
| Q-TL-04 | Map edges wrap (tile x is a byte); map product at most 64 pages | I047-7, I047-8 | ST | P4 | GAP | SQ |
| Q-TL-05 | Size of the hero's collision box (frame width and height `$10`, `$12`) | I047-3 | RT | P4 | GAP | I |
| Q-TL-06 | Hazard tiles: four floor hazards of `IsPlayerOnMetatile` (Lostside `$80`, Lab `$F3` and `$E1`, St. Elles coast differs), hot coals `$47`, the "fire pit" metatiles | I031-2, I036-6, I038-1 | ST+RT | P3 | GAP | I |
| Q-TL-07 | Purple Fish reads `tile_type_map`: is a non-zero byte the water marker and which switches change it | I036-10 | ST+RT | P4 | - | I |
| Q-TL-08 | `SetHeldLairTileType` (tile type 1, stride from the map size) and `ShowOpenedChests`: replay field talk with an NPC and an opened chest | I042-4, I042-9 | ST+RT | P3 | GAP | I |
| Q-TL-09 | Walkthrough cheats ("flip `0x008A24` to `DD`", Game Genie `2264-6FD4`): the address is a ROM operand | I047-5 | RT | P4 | DISC | I |
| Q-TL-10 | Facing code from `code_0273D4` (0 = up, 1 = down, 2 = right, 3 = left) and the four probe points; NPC animations base + 0, +1, +2 | I009-7, I009-8 | ST+RT | P2 | - | I |
| Q-TL-11 | `PixelToMapIndex` adds the whole low byte of y; callers pass y with a low nibble of 0? Same for `code_0272B8` | I007-7, I031-1 | ST+RT | P2 | GAP | I |
| Q-TL-12 | `Cop0D` compares y with (tile y + 1) * 16, `Cop11` stores tile y * 16; after `Cop11` the old footprint stays blocked | I007-4, I007-5, I025-8 | ST+RT | P2 | - | I |
| Q-TL-13 | `Cop2B` and `Cop16` clear the whole low byte of a tile word including the type nibble | I007-6 | ST+RT | P2 | - | I |

### 3.8 Flags, switches, lairs, chests, save (cluster FL)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-FL-01 | Low event flags `$0000`-`$0007`: used as scratch by village, statues and closing scene | I034-2, I035-8 | ST+RT | P4 | - | G |
| Q-FL-02 | Flags set and never cleared or read: St. Elles `$0903`, `$0406`, `$0407`, `$0500`, `$0501`; King's `$0A00` and `$0706`; `$1B01` readers; `$0907` | I036-1, I037-4, I035-7, I035-6 | ST+RT | P4 | - | G |
| Q-FL-03 | `$1A9E` (released) and `$1ADE` (switch) arrays: ever different; flag words with byte index `$40`-`$4F` alias the released array | I055-1, I007-20 | ST+RT | P3 | GAP | G |
| Q-FL-04 | Unused flags (bytes `$0B`-`$18`, `$1A01`, `$1A03`, `$1B06`), `$1B07` (Leo's town models), flag `$00FF` (set by `InitFixedState`; set in a game loaded from an older slot?), the saved image tail `$1B9B`-`$1C57` | I011-13, I031-5, I055-4, I055-5, I055-6, I054-2 | ST+RT | P4 | GAP | G |
| Q-FL-05 | Release switch chain: `data_00BA0D+1E` (27 of 420 records), `Cop3B_JumpIfSwitchSetElseHold`, `HoldActorUntilReleased` (what writes `$34` of those NPCs), `SetHeldLairTileType`, `$16` bit `$0010` | I007-13, I025-1, I006-15, I024-8, I055-2 | ST+RT | P3 | GAP | G |
| Q-FL-06 | Lair record bytes: `+13` low values (0 to 10) and the initial lair state, `+18`-`+1C`, `+A` world number | I006-16, I013-11, I033-12, I057-1 | ST+RT | P3 | GAP | G |
| Q-FL-07 | Lair data oddities: 15 records with home `$63` and no scene; five formation lists named by no record; dream rows with count 0 and interval 1; two words past location `$7F` in `LocationAreaScene` | I015-2, I057-2, I057-3, I057-4 | ST | P4 | GAP | SQ |
| Q-FL-08 | Pressure plates (`table_00B69A`, variants) and map slabs 1-3 (`$7E8000` region; lair record bytes `+1`, `+A`) | I008-11, I026-9, I026-8 | ST+RT | P2 | - | G |
| Q-FL-09 | Chest list `Loc29` has two rows with chest id `$17` (both Mermaid's Tears): is the second reachable; does one opened chest mark both | I055-3 | ST+RT | P3 | GAP | G |
| Q-FL-10 | `$1B82` souls: `$01` Magician, `$02` Light, `$04` Shield, `$08` Detection, `$10` Reality; the ending text picks "I decided" only when | I006-10 | ST+RT | P3 | - | G |
| Q-FL-11 | Inventory cells: high bytes of the equipped cells `$1B5F`-`$1B65` always 0 (word reads); the fourth equipment slot `$1B64` filled from the 40-entry row `$1B36` | I009-18, I005-24 | ST+RT | P3 | - | G |
| Q-FL-12 | After the ending: `$1B84` (set to 6; the ending-flag reading is withdrawn), `$031E` = 1, flag `$1F02`: who reads them | I006-12, I024-2 | ST+RT | P4 | - | G |

### 3.9 Text, glyphs, spellings (cluster TX)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-TX-01 | Dictionary entry `$06` reads "Deathtole" (every dialogue and the walkthrough: "Deathtoll"); entry `$0C` reads "Liesa" (walkthrough: "Lisa"). The extract shows `;06` and `;0C`; I033-7 wrote `$09` for Deathtole, a slip | I004-5, I010-2, I033-7 | DEC | P3 | DISC | DQ |
| Q-TX-02 | Glyph printing: the blank plus dictionary word "s" for the apostrophe (Goat s Food, Leo s brush); the extractor prints some glyphs as other characters; the unmapped glyph of the ghost ship statue and the `#` of the prison hint | I008-15, I012-10, I036-2, I037-3 | RT | P3 | DISC | J |
| Q-TX-03 | Staff roll spellings ("Soul Blader", "COPORATION", glyph runs): typos of the ROM | I010-11, I012-7 | RT | P3 | DISC | J |
| Q-TX-04 | Chest message prints "recieved" while the Seabed text prints "received" | I026-11 | RT | P3 | DISC | J |
| Q-TX-05 | Item name spellings: Recovery against Recover Sword, Emblem A-H against Master's Emblem, Elemental Armor against Mail, walkthrough variants (Clubhouse Pass, Metal Gorillas), two identical "Leaves" strings | I004-6, I027-3, I034-3, I039-1, I004-15, I012-12 | DEC | P3 | DISC | DQ |
| Q-TX-06 | ROM text against walkthrough: VIP Card (whole Magridd Castle against Right Tower), Strange Bottle string ends without "0-", Bubble Clothing against Bubble Armor, "Invulnerable Bracelet" speech against the Super Bracelet item | I009-1, I009-2, I036-3, I039-2 | ST+RT | P3 | DISC | J |
| Q-TX-07 | Place names in prompts: Fairy Gem asks "Seabed Palace" and "the location of the Mountain of Souls" (walkthrough: Seabed Sanctuary, Soul of Mountain House); "Leo's Painting" against the ROM name; ROM names against the walkthrough | I017-1, I017-2, I045-1, I008-14 | DEC | P3 | DISC | DQ |
| Q-TX-08 | Status screen prints "Defence" (walkthrough: "Defense") | I048-5 | DEC | P4 | DISC | DQ |
| Q-TX-09 | Control codes: `[0A]` second font, `[09]` one-row font, `[12]` `[08:408]` tail, unhandled codes in the wrong renderer (`[0B]`, `[14]`, `[0E]`-`[12]`), `[14:n]` leaves attribute bytes, `$03F7` last window origin | I006-14, I010-3, I010-4, I010-15, I028-4, I007-17, I010-14 | RT | P3 | - | J |
| Q-TX-10 | One-row dialogue overlay tiles (`$FE`, `$FF`), `VMAIN` set by an earlier routine, the high bytes of `$03EE` / `$03F0` | I010-6, I010-8, I010-9 | ST+RT | P3 | - | J |
| Q-TX-11 | `$1B84` `text_delay`: byte or word (the renderer reads a byte, scenes write words) | I010-1, I028-1 | ST+RT | P2 | - | J |
| Q-TX-12 | What `TileBlockText` draws (4 x 5 tile block at BG3 rows 11-15) and the rows of list entries 4-8 | I011-9, I028-3 | RT | P3 | - | J |
| Q-TX-13 | Staff roll: how long it runs, what ends it, 8-bit `scroll_bg3_y` wrap, the 128-word clear per line against a 32-row map (about 6,976 frames expected) | I010-12, I010-17, I012-8, I030-2 | RT | P3 | - | J |
| Q-TX-14 | Standard box holds four lines and scrolls; B for talk against sword; every speech ends with `[08:408]` | I052-1, I052-2, I052-3 | ST+RT | P3 | GAP | J |
| Q-TX-15 | Fixed string `asciistring_014F02` (`Cop02`) and the menu type bytes of `Cop1A` | I001-5 | ST+RT | P3 | - | J |
| Q-TX-16 | Choice windows: geometry (five windows above the dialogue box) and BRK `$07`/`$18` in the chooser | I012-11, I012-6 | RT | P3 | - | J |
| Q-TX-17 | "Allright, please continue" (Underground Castle return prompt), Lisa's Yes / No answers in the closing scene, the fairy's prompt strings | I034-9, I034-18, I037-14 | ST+RT | P4 | - | J |
| Q-TX-18 | `ClearBg3Page` and `ClearBg3UpperHalf` run with DBR `$7F` and end with `TSB $03B8`: the bit lands in `$7F:03B8`, not in `vram_upload_flags` | I027-1 | ST+RT | P3 | BUG | J |
| Q-TX-19 | `UpdateHud` returns at once for locations `$0F`-`$12`, skipping the heal and EXP drains | I027-2 | ST+RT | P3 | - | K |
| Q-TX-20 | Player name buffer `$1B92`: 8 letters, terminator at `$1B9A`; `Cop3A` ends how. The I054 document may already answer it: check statically first | I007-15, I010-13 | ST | P3 | - | SQ |

### 3.10 Menus, HUD, save (cluster MN)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-MN-01 | The A button with no direction opens a status and souls page that the walkthrough does not describe | I009-5 | RT | P3 | - | K |
| Q-MN-02 | Erase record: second prompt turns palette word `$7F:0006` from `$7FFF` to `$03FF`; can the erase marker equal the stored first word | I024-5, I054-1, I013-10 | RT | P3 | GAP | K |
| Q-MN-03 | Master's menu: which flag word `$9B00` turns the two-option shrine menu into Record / Quit (the "Rest well" and Move questions are Q-CM-01 and Q-CM-03) | I012-9 | RT | P2 | - | K |
| Q-MN-04 | Pause: `$03A2` bit 7 and the A-held behaviour; the pause banner index `[TBL:list_0147C2,1C6A]` (is `$1C6B` ever written) | I013-7, I011-11 | RT | P4 | - | K |
| Q-MN-05 | Save-slot line template: width of the digits printed by `[06:1,$0452]`, what `$0452` is, `binary_01440D` layout | I011-12, I022-3 | ST+RT | P3 | - | K |

### 3.11 Audio and SPC (cluster AU)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-AU-01 | `HandleVBlank` sends `sound_request` to `APUIO2` on even frames and 0 on odd frames: does one sound word start the sound once or twice | I043-1, I056-1 | RT | P3 | GAP | L |
| Q-AU-02 | Which sounds are the BRK ids: `$07` cursor, `$18` confirm, `$48` tick, `$04`, chest `$15`, `$9E`, `$8D`, `$94`, `$98`, `$9C`, region ids `$A0`, `$4B`, `$51`, `$5D`, `$52`, `$64`, `$86`, Record `$66`, Rest well `$8E` | I009-12, I010-16, I013-5, I026-10, I040-7, I041-6 | RT | P4 | - | L |
| Q-AU-03 | Music changes: which songs are tracks `$00`, `$02`, `$0D`, `$11`, `$12`, `$13`; how many frames a change and a fade take; the hub music after the Master's farewell | I007-11, I025-3, I056-5, I046-2 | RT | P4 | GAP | L |
| Q-AU-04 | Runtime halves of two static answers (I056): the dog's joke (music cut, restart from the first phrase) and the pause (`SetEchoBit6`, bits 6 and 5 of SPC byte `$48`) | I056-2, I056-3 | RT | P4 | GAP | L |
| Q-AU-05 | `SpcDriverBlock` contents; the 38 sound ids and the 13 driver samples | I033-8, I056-6 | ST | P4 | GAP | SQ |

### 3.12 Graphics, VRAM, HDMA, palettes, sprites (cluster GX)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-GX-01 | Soul circle windows: what each soul clips (W12SEL, WOBJSEL, CGWSEL), what shows outside the circle, where Soul of Light matters (the old note said the dark GreenWood and Lostside areas) | I042-2, I051-1, I051-2, I051-3 | RT | P3 | DISC | M |
| Q-GX-02 | HDMA budget and timing: can a frame need more than four channels, no guard against a fifth (`dp$46` / `$47`), are tables rewritten while drawn, which layer each wave moves, cross-wired scroll names | I009-9, I051-4, I051-5, I051-7, I035-16 | ST+RT | P3 | GAP | M |
| Q-GX-03 | VRAM layout: words `$2000`-`$21FF` shared by dynamic sprite tiles and OBJ; strip tiles `$206`-`$21D`; OAM tiles `$6`, `$8`, `$A`, `$C` named by effects frames; who writes the BG3 character range after boot; sprite name table 1; Mode 7 character loading; is the hero the only dynamic tile sprite; `graphics_04D000` and `graphics_04B000` roles | I043-4, I013-14, I050-1, I050-3, I050-5, I051-8, I051-9, I051-10, I005-6, I009-13, I010-10 | ST+RT | P3 | GAP | M |
| Q-GX-04 | `Bg3ScrollHdmaTable` (BG3 vertical scroll -4 / 0 / +4 / +3 / +2 / +1 over the first lines): purpose, why off in `$10`-`$12`, HUD wobble | I042-1, I053-5 | RT | P3 | GAP | M |
| Q-GX-05 | `LookupBg2TileAndVramAddr` loads `map_width_pages` with no index; the strip builders index it | I051-6 | ST+RT | P3 | BUG | M |
| Q-GX-06 | Colour animation (`Cop92`-`Cop95`, `CopyFrameData`): frame records are palette data; length code 2 adds `$200`; palette-cycle list types `$01`-`$0F` per scene effect (FM-A4 / FM-A11 called bank `$0D` "VRAM copy lists"); `ADC #$0000` in `lib_animation`; `$0D:$8000` ending effect; master-shrine effect animations `$48`, `$4A` | I007-24, I008-4, I008-5, I026-3, I033-6, I033-11, I025-11, I016-6, I006-21, I040-9 | ST+RT | P2 | DISC | M |
| Q-GX-07 | EXP popup map at `$7E:F000`: what keeps it intact; sprite-limit headroom (128); `binary_060836` leaves | I050-2, I050-6, I050-4 | RT | P2 | GAP | M |
| Q-GX-08 | Title and ending HDMA effects, dream scene shears and waves, the band-shear effect (and why it swaps table bytes) | I034-15, I037-11, I040-8 | RT | P4 | - | M |
| Q-GX-09 | BG3 tilemap page DMA is skipped when the first word of the write queue has a non-zero high byte: can a stream of writes starve it | I005-19 | ST+RT | P3 | - | M |
| Q-GX-10 | Colour of the iris (BG3 palette 0 colour 1) | I051-11 | RT | P4 | GAP | M |
| Q-GX-11 | Tile `$1A` row at BG3 offset `$700` and the 25 / 32 tile counters in `binary_01470C` | I009-16 | RT | P4 | - | M |
| Q-GX-12 | Movement and variants carried by animation data, not scripts: shy bird, Monmo, dog, Mud Man, projectiles, Purple Bull shots, turret shots, snowball flip variants, Wall Tile flips, overlay sprites of helper actors | I035-4, I037-9, I040-12, I037-7, I040-13, I038-5, I036-5 | RT | P4 | - | M |

### 3.13 Dead and unreferenced code, code against data (cluster DC)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-DC-01 | Bank 0 engine never executed: debug block `R05`-`R12` (pad 2 poll, bank scanner), `code_0027A0` lair cycler, `code_006BA5` / `code_006C50` pair, `code_0074B1`, the whole of `engine_unreferenced_code`, `DebugScanBank` marker bytes `02 01 AA` | I005-22, I006-5, I006-6, I006-7, I019-2, I023-4 | ST+RT | P3 | - | B |
| Q-DC-02 | Library dead code: `code_011E44`, `code_012086`, `loc_011D42`, `code_011EBD`, `SignExtendByte`, `ArithmeticShiftRight`, `StepRandomState`, `RunSineWaveMover`, `FillSineWaveTables`, `ClearBitInArray`, two dead `BRA $74`, unused `meta4`, `CMP #$80; BCS self` guards, `PlayLairReleaseScene` dead stores | I009-14, I013-12, I042-3, I042-5, I011-10, I008-10, I026-6 | ST+RT | P4 | - | B |
| Q-DC-03 | The 17 COP handlers with 0 uses (`00`, `02`, `06`, `13`, `25`, `29`, `36`, `89`-`8E`, `93`, `95`, `AB`, `B1`): never executed or reached through a script in an unmapped data block | I007-22, I025-4 | RT | P3 | - | B |
| Q-DC-04 | Stubs, unreferenced strings and never spawned meta types: bank 1F stubs (`code_0FDFC0`, `code_0FE769`), the unreferenced string stubs, `asciistring_01B2AB`, "I am dreaming.", `asciistring_02706C`, placeholder `$1A`, unused types (world 0 `$09`; world 1 `$34`, `$36`, `$3B`, `$3E`; world 2 `$14`, `$25`, `$27`, `$33`), the BG2 scroller `$2F` | I015-6, I020-4, I021-2, I034-8, I034-13, I035-11, I036-7, I036-9, I039-4, I039-9, I039-12 | RT | P4 | - | B |
| Q-DC-05 | Code in data, data in code: `asciistring_018480` is printed as a string, is it code; plus the CDL cross-check of the whole partition (mapping 3.7) | I034-1 | ST+RT | P2 | - | B |

### 3.14 World passes (clusters GV, GW, SE, MS, LL, MC, WE, CM)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-GV-01 | Water mill animation `$1D`; the goat as the old man's wife; push-zone coordinates and elevator readings; which paintings use the BG2 drift | I034-4, I034-5, I034-6, I034-7 | RT | P4 | - | P1 |
| Q-GV-02 | Metal Mantis attacks and the "silver phase" | I034-12 | RT | P4 | - | P1 |
| Q-GV-03 | Where is the Grass Valley Gem actor `gv_fairy_gem_advice_return` (type `$39`) and does first contact give EXP then the return prompt | I017-4 | RT | P3 | - | P1 |
| Q-GV-04 | Four actors keep address names (`w0_actor_01A440`, `w0_actor_01A3B0`, `common_actor_006E28`, ...): who are they in game | I018-2 | RT | P3 | - | P1 |
| Q-GW-01 | The four `gw_player_shift_*` actors: an ice or current tile, a conveyor | I017-3 | RT | P3 | - | P2 |
| Q-GW-02 | Billy and the Woodstin Trio flag protocol; raft ride end (`COP 22` to `24` tile tests) and the digger's "tunnel" text; "Tiki" in the ghost's text | I035-5, I035-9 | RT | P4 | - | P2 |
| Q-GW-03 | Statue boss: the order in which the second and third statue take over (`boss_actor` slot order); the Water Statue far right and the Fire Statue between in the walkthrough against formation `$20` | I035-12, I035-13 | RT | P3 | DISC | P2 |
| Q-GW-04 | The return-only fairy pays 1 EXP at every talk; the ripple loop runs with M = 8 | I035-17 | RT | P4 | - | P2 |
| Q-SE-01 | The skull link actor (`se_boss_skull_link_00409B`) copies from `$3C` of the skull: which actor | I036-12 | RT | P3 | - | P3 |
| Q-SE-02 | Unnamed mermaid with the Red-Hot Stick; worm burst placement (meta type `$46`) | I036-4, I036-11 | ST+RT | P4 | - | P3 |
| Q-MS-01 | Who calls the Phoenix: the elderly women (chapter 5) or the King (chapter 8) | I037-1 | RT | P3 | DISC | P4 |
| Q-MS-02 | Ice markers (six position records): entry or exit; the silent figure `$41`; Poseidon's triple fireball flags (`$0200` left, `$0300` right) | I037-8, I037-12, I037-13 | RT | P4 | - | P4 |
| Q-LL-01 | Tin Doll: second animation of each walking pair, the reappearance at x = `$30` / `$1A0`, the "flower" he takes control of | I038-4, I038-13 | RT | P4 | - | P5 |
| Q-LL-02 | Master's Emblem G: walkthrough says hold R then move left; the ROM waits for a new Left press | I038-7 | RT | P3 | DISC | P5 |
| Q-LL-03 | Cat's dream speakers; the mouse reward ("Please come inside" with no item); the speaking door; `COP 28` in the Mini Helicopter; release pieces and lair `$143` | I038-6, I038-10, I038-11, I038-12, I038-8 | RT | P4 | DISC | P5 |
| Q-MC-01 | Static props `$0F` (`A11S01`) and `$13` (`A12S02`); the twelve statue shooters in `A12S01`; who speaks in the dock scene | I039-6, I039-8, I039-7 | RT | P4 | - | P6 |
| Q-MC-02 | Dungeon fairy (`$38`) and prison fairy (`$37`) hints; Demon Falcon dive and fire strafe | I039-10, I039-11 | RT | P4 | - | P6 |
| Q-WE-01 | The hub step after the ending is called "post-ending" in parts and a comment; the walkthrough does not | I040-1 | ST | P3 | DISC | SQ |
| Q-WE-02 | Mage / Demon fight: three orbs, two side pieces, types `$0D`, `$0E`, `$0F`; Dazzling Space damage; the Demon damage window; Phoenix-call scene | I040-4, I040-6, I040-11, I040-5 | RT | P4 | - | P7 |
| Q-WE-03 | Why the Demon's pillar-gem pickup reads `LDA $0005` (absolute) and `ll_effect_model_release_piece_023EF3` | I040-10 | ST | P4 | - | SQ |
| Q-CM-01 | After "Finished recording- Do you wish to continue?" answered No ("Rest well"): is the pad blocked for good | I041-1 | RT | P3 | GAP | P8 |
| Q-CM-02 | `cm_enemy_aimed_shot_mover` flies toward the hero's position at launch (Tin Doll and Fire Man fireballs); the minor distance above 255 | I041-3, I041-5 | ST+RT | P3 | GAP | P8 |
| Q-CM-03 | Tile (7,4) opens the Master's menu: the "northern square"; separate scenes `A00S01`-`A00S07` per world; the four squares clockwise; Move destination (settled static, section 5) | I041-4, I046-4, I041-2 | RT | P3 | GAP | P8 |
| Q-CM-04 | Which in-game object asks "Would you like to return to ..." in worlds 0, 1, 4 and 5 | I030-4 | ST | P4 | GAP | SQ |

### 3.15 Tooling, layout, regression, documents (cluster TO and DQ)

| ID | Question | Absorbs | Mode | Pri | Tag | EG |
|----|----------|---------|------|-----|-----|----|
| Q-TO-01 | R-2 residuals: are the eight 2-byte references to movable blocks that `npm run audit` lists (`LDX #$&spc_030000`, `#$&data_04F000.*`, ...) real hazards; should `blocks-verify` refuse `movable: true` on a block with a cross-bank 2-byte reference; `meta_tables` split decision (M-3.9) | I016-1, I016-2 | ST+RT | P2 | - | O |
| Q-TO-02 | Should `npm run audit` and `blocks-verify` detect fall-through at a file boundary, and address-equality loops (`CPY #$&label`) and stride walks over several files | I015-9, I017-5, I018-3 | DEC | P2 | TOOL | DQ |
| Q-TO-03 | **`us/overrides.json` needs `"65803": {"M": 1}`** for `BuildScrollStrips` (`code_01010B`): the extractor reads `LDA #$80; TRB $0396` as `LDA #$1C80; STX $03, Y` and hides two `JSR`s as literals in the rebuilt ROM. The fix changes the SHA-1, so it is your decision | I026-1, I008-1 | DEC | P1 | BUG | DQ |
| Q-TO-04 | Overrides by hand: is a hand edit of `us/overrides.json` acceptable (done for `71774`, `67277`, `78242`, `78254`), `OQ-I005-7` is half applied (`71774` done, `65803` is Q-TO-03), and a bisect tool for mnemonics and overrides | I005-7, I022-1, I023-5 | DEC | P2 | TOOL | DQ |
| Q-TO-05 | Block layout decisions left open: clusters for a later wave; split by ROM order for files over 1,500 lines; placement of the 27 blocks without a scene; `ending_sequence` home; `lib_menus` size (1,848 lines); `lib_0118FC_part2/5/6` names; `lib_0116C3` in `actor_shared`; split of `player_core` and `engine_spawn_lairs_death_drops`; `InitHardwareAndClearWram` dead branch; stacked block notes of `cop_core`; names of the new regroup blocks | I019-4, I019-5, I020-2, I020-5, I021-5, I021-6, I022-2, I022-4, I027-4, I015-5, I042-7, I042-8 | DEC | P3 | - | DQ |
| Q-TO-06 | `MapPatchRectsAndMapSizes` is two tables in one part (5 patch records of 8 bytes, 128 size pairs): split into two labels and re-type | I012-4, I013-9, I026-2, I030-3, I057-5 | DEC | P3 | TOOL | DQ |
| Q-TO-07 | Which batch annotates `code_0112F5`, `code_011395`, `code_0114D0`, `code_0114E4` in `lib_scene_map_patches`; names of the 82 bank `1F` enemy blocks and three ghost-ship blocks | I029-1, I020-1 | ST | P3 | - | SQ |
| Q-TO-08 | Harness gaps: black screens after `$0318 = 0x0501` and `0x0101` and what the souls page needs to render; replay of the real first entrance of each world (not a jump); `menu.rec` timing; field talk and chest replay | I016-4, I018-4, I018-5, I019-6, I021-3 | RT | P2 | - | O |
| Q-TO-09 | Structs and names: `structs.json` retypes of FM-A11 §4.17 (meta entry, lair record, exit, chest, plate, variant rows); pointer coagulation of the 112 formation lists, 265 animation step lists and 951 frame leaves; why `WorldMetaPointers` cannot be snake_case (a literal `$8000`) | I033-10, I033-14, I033-15 | DEC | P3 | - | DQ |
| Q-TO-10 | Documents to refresh: placement-audit 5.3 labels ("file select" for `00729D`, `00797B` as front end); crosswalk labels (`w0_actor_01AB4F`, `common_actor_0033C6`, `lib_0118FC_part13`); folder name `deathtolls_shrine` plural against "Deathtoll's Shrine" and "Deathtole" | I018-1, I020-3, I058-2, I058-3 | DEC | P3 | - | DQ |
| Q-TO-11 | (new, OQ-I059-1) Where do the recordings and savestates live so any session can replay them | I059-1 | DEC | P2 | TOOL | DQ |
| Q-TO-12 | (new, OQ-I059-2) Fix the mode legend and the priority scale in the preamble of later iterations | I059-2 | DEC | P3 | - | DQ |
| Q-TO-13 | (new, OQ-I059-3) Refresh the stale `split-part` rows of `pinned.md` | I059-3 | ST | P4 | - | SQ |
| Q-TO-14 | (new, OQ-I059-4) Tick mapping boxes 1.11, 2.17, 3.6 | I059-4 | ST | P3 | - | SQ |

## 4. Experiment groups

Every group lists: rows, setup, watches and tools, expected observation (the static reading to confirm or reject), the note, name or doc the result changes, priority and mode. All groups use the rebuilt ROM only. "Address from label" means `load_labels` then `get_label_address`.

### EG-B Code and data log (CDL) coverage run (P2, RT) - mapping 3.7

- **Rows:** Q-DC-01 to Q-DC-05, Q-CO-01 (never executed), Q-WM-02 (which dirty bits are read), Q-TO-03 (M at `BuildScrollStrips`), and every "never spawned / unreferenced" claim of the world passes. Mapping M-3.7.
- **Setup:** `reset_cdl`, cold boot. One long session that visits: title, file select, name entry, opening dialogue, Trial Room (replay `trial.rec`), then one scene of each of the seven worlds plus a boss room each (scene jump with `$0318`, `$037C`, `$037E`, `$0380`), a dungeon, the menus (status, equipment, souls, pause), a chest, a lair release, a death and return, save and erase of a slot, the ending (jump to the ending scene), Master's menu in each world. `save_cdl` after each segment so no segment is lost.
- **Watches and tools:** `get_cdl_data`, `get_cdl_statistics`, `get_prg_rom_offset` / `resolve_address` to turn CPU addresses into rebuilt-ROM offsets (use `rebuilt/layout.json` and `us/names/` to name them), `get_access_summary` for the cells of Q-WM-02. No `compare_runs`.
- **Expected:** (a) every row of Q-DC-01 to Q-DC-04 stays "never executed"; (b) no byte that the extraction calls data is executed (Q-DC-05), except possibly the entry bytes of `asciistring_018480`; (c) the M and X flags that the CDL records for `BuildScrollStrips` show M = 1, which confirms Q-TO-03.
- **Changes:** wording of the "unreferenced" claims in part notes and in `pinned.md`; block note of `engine_unreferenced_code`; `docs/cop/index.md` use counts; `us/overrides.json` (through your decision on Q-TO-03). Names through `npm run names` only when a part is proven dead and you want the name changed.
- **Order:** first of all groups: it removes rows and shortens the world passes.

### EG-N Engine invariants (P2, RT and ST+RT)

- **Rows:** Q-EN-01 to Q-EN-18, Q-CO-03, Q-CO-06, Q-CB-13, Q-WM-02 to Q-WM-04, Q-WM-06, Q-WM-07.
- **Setup:** savestate in the Trial Room (end of `trial.rec`); a field scene with several actors for the pool; the Metal Mantis arena for the boss rows (scene jump values of section 1.5).
- **Watches and tools:**
  - `set_breakpoints` with read, write and execute kinds; `get_breakpoint_hits`.
  - `get_access_summary` for the readers and writers of `$16`, `$1A`, `$30`, `$0458`, `$042D`, `$039A`, `$0372`.
  - `trace_between` on the spawn handlers for the pool carry, and a long write to the pool pointer `dp$4A`.
  - `get_execution_trace` to record the COP ids and compare them with the handler names (Q-CO-06).
  - `read_word` on the rng range (Q-EN-01).
- **Expected:** `rng_state` is not at `$0301-$0311` (the bucket table ends at an `$FFFF` word, I013-1); `dp$4A` goes to `$1880` after 64 pops; D = 0 at NMI; `$0458` is set in the six boss scripts and cleared when the music reload finishes; `$16` bit 15 is "off screen" (FM-A1 R27); `COP [82]` sites resume at a saved pointer.
- **Changes:** `rng_state` name and range in `us/names/`, `us/mnemonics.json` and `docs/wram-memory-map.md`; notes of `CullAndSortActors`, `PopFreeSlot`, `HandleVBlank`; `docs/cop/index.md` (bit 15 wording); `docs/code/actor-system.md`, `docs/code/boot-nmi-main-loop.md`; the bit table of `$16` / `$1A` in `docs/code/combat-damage-and-enemy-records.md`.

### EG-O Regroup regression harness and R-2 residuals (P2, RT)

- **Rows:** Q-EN-19, Q-TO-01, Q-TO-08.
- **Setup:** two builds that keep the bank 0 engine code in place, power-cycled slots, `trial.rec` (3,677 frames) and `boss_fight.rec` (538 frames) from the same savestate.
- **Watches and tools:** `compare_runs` with at most 6 words (`$0301`, `$0312`, `$0374`, `$0376`, `$033A`, `$0808`); `take_screenshot` with `layers` at the end of each run.
- **Expected:** 0 divergent frames between builds that keep the engine code in place (I017, I020, I021, I022 results); a one-frame difference after a scene change only when bank 0 code moved (Q-EN-19). For Q-TO-01 each of the eight cross-bank 2-byte references is read at run time with DBR logged (`set_breakpoints` execute at the referencing instruction) to see whether DBR equals the block's bank.
- **Changes:** `plans/doc-audit/placement/spike-decision.md` (R-2 residuals), `docs/code` build notes, the rule text on when per-frame equality is valid, and the `movable` flags in `us/blocks.json` through `npm run blocks`.
- **Order:** needed before any further regroup; not needed for the documentation rows.

### EG-A Boot, title and special locations (P2, ST+RT and RT)

- **Rows:** Q-LC-01, Q-LC-02, Q-LC-03.
- **Setup:** cold boot with `record_input` from power-on (no savestate); then the hub scene `A00S09` by jump.
- **Watches and tools:** `location_id` (address from label), `$047E` (m7 angle), `$0480` (scale), `$0445`, `$0482`, `$0318`; `get_ppu_state` for `BGMODE`; `take_screenshot` with `layers`; a write breakpoint on `$047E`.
- **Expected:** `location_id` is `$10` at the title (`00/0A`), `$11` in the ending (`00/0B`), `$12` in the boot scene (`00/0C`); `$047E` is never written (angle 0) and the title moves through the scale; the reduced main loop (no menu, hits, HUD) runs in those scenes; the hub has seven stops with gates `$1B00`-`$1B05`.
- **Changes:** names of the scenes `unnamed_0f` .. `unnamed_13` in `us/groups.json` and `docs/areas-and-scenes.md` (names tool and group tool, no ad-hoc edit); notes of `HandleVBlank`, `RunMainLoop`, `BuildRotationMatrix`; `docs/code/boot-nmi-main-loop.md`.

### EG-C Hero damage formulas and item effects (P2, ST+RT)

- **Rows:** Q-CB-01 to Q-CB-12, Q-CB-14 to Q-CB-19.
- **Setup:** savestate in a field scene with one plain enemy; for bosses the Metal Mantis arena. Write the equipment cells, level cells (`$1B72`, `$1B76`, `$1B8C`), HP and Gems with `write_memory` / `write_word` instead of playing for them.
- **Watches and tools:** write the sword id, take one hit, read the target HP field; breakpoints on `ApplySwordHit`, `ApplyProjectileHit`, `ApplyPhoenixDamage`, `FinishEnemyDeath`; `read_word` of `$0330`, `$0336`, `$0338`, `$26` of the target, `$0332`; a `compare_runs` of the same hit with and without the bracelet (2 watches).
- **Expected:** Super Bracelet doubles damage dealt and halves damage taken (not +2); the Critical Sword kills the target on its critical branch unless it is `$039A`; the Psycho Sword freezes metal, spirit and special actors (`$26` = 180); the Recovery Sword adds 1 HP per kill; the Medical Herb, Strange Bottle and Magic Bell act only when equipped; gem costs equal the descriptions; `$0330` starts at `$80` and counts down by 2 per frame to `$FE`.
- **Changes:** part notes of `ApplySwordHit`, `ApplyProjectileHit`, `DrawGaugeBar`, `CheckPlayerDeath`; `docs/code/combat-damage-and-enemy-records.md`, `docs/code/menus-inventory-status-hud.md`; the item description rows (as DISC notes against `items.md`, no change to ROM text).

### EG-D Enemy and boss stats, identities, lairs (P2, ST+RT)

- **Rows:** Q-BH-01 to Q-BH-04, Q-BH-07 to Q-BH-12 (Q-BH-05 and Q-BH-06 are static, `SQ`).
- **Setup:** scene jumps to each lair scene (jump values per scene from the area and scene numbers of `docs/areas-and-scenes.md`) and to the five boss rooms; for HP, kill the target in measured hits (or read the HP field right after the spawn).
- **Watches and tools:** `read_memory` of the target actor right after the spawn (HP, EXP word, `$1A`); `take_screenshot` for the identity; `get_oam` to match sprites to bestiary names.
- **Expected:** boss HP 69, 79, 89, 99, 99 (the ROM records); Purple Bull 45; Toy Calvary types `$27` (24 / 175) and `$26` (20 / 170) are two different enemies; Monster Blocks pay 3 EXP.
- **Changes:** DISC notes in the notes of the `Meta*` lists and the world-actor block notes; `docs/code/combat-damage-and-enemy-records.md`; `docs/walkthrough-crosswalk.md` (rows that carry the DISC tag). The ROM wins: the walkthrough is not edited.
- **Static half first** (Q-BH-06, SQ): list every meta record with its HP and EXP and match it to the bestiary; only the rows that stay unmatched need the emulator.

### EG-E Level-up, EXP and stat caps (P2, ST+RT)

- **Rows:** Q-HE-01 to Q-HE-04.
- **Setup:** savestate in a field scene; `write_memory` of EXP and `$1B72` / `$1B76`; open the status page after each change.
- **Watches and tools:** `$1B72`, `$1B76`, `$1B8C`, the EXP cells, `heal_pending` (`$043B`), screenshots of the status page.
- **Expected:** `level_power` and `level_defense` rise without a cap (stored values pass 12 and 13) while the status page clamps the displayed part at 12; start values per the code; "Next level" is the threshold from `LevelExpThresholds`, not the points missing; EXP has 8 BCD digits.
- **Changes:** notes of `WatchForLevelUp` and the status screen routine; `docs/code/player.md`, `docs/code/menus-inventory-status-hud.md`; `docs/wram-memory-map.md` (EXP width, already corrected in I031).

### EG-F Hero movement, spells, orb, return trip (P3, RT)

- **Rows:** Q-HE-05 to Q-HE-23 (Q-HE-01 to Q-HE-04 are EG-E).
- **Setup:** savestate in an open field scene with room to cast; all eight spells and the orb unlocked by writing `$1B82` and the magic cells.
- **Watches and tools:** `set_breakpoints` on the spell spawners; `get_oam` per frame of each spell (`advance_frame` with `layers`); `read_word` of `$0433`, `$0434`, `$0464`, `$03FB`, `$03B4`, `$0405`, `$0380`; a frame count with `get_timing_info`.
- **Expected:** four Spark Bombs spaced as the code says (18-frame spacing; not 60 degrees); the Flame Pillar burns for animation `$1B` repeated `$14` times; the Tornado heading is always 2; no second spell while `$0433` is non-zero; the hero walks 2 px per frame; the orb starts at (0, 0).
- **Changes:** notes of `RunSpellSparkBomb`-family routines and `player_core` parts, `docs/code/player.md`, `docs/code/combat-damage-and-enemy-records.md`; walkthrough DISC note for `magic.md`.

### EG-G Flags, switches, lairs, chests, save (P2, ST+RT)

- **Rows:** Q-FL-01 to Q-FL-06, Q-FL-08 to Q-FL-12 (Q-FL-07 is static, `SQ`). Save and erase behaviour is Q-MN-02 in EG-K.
- **Setup:** savestate after the Trial Room; `dump_memory` of `$1A5E`-`$1B9A` and the lair state `$7F0203` before and after each action: open a chest, release a lair (kill a lair), flip a plate, finish a boss, save and load.
- **Watches and tools:** `snapshot_memory` plus `diff_snapshots` over the flag block (not a `compare_runs`); `get_access_summary` on `$1A9E`, `$1ADE`; a write breakpoint on each flag named in the rows.
- **Expected:** `$1A9E` and `$1ADE` change together; flag words with byte index `$40`-`$4F` alias the released array; `$00FF` is set by `InitFixedState` in every game; the lair state byte takes the world number in its low bits when released.
- **Changes:** `docs/code/flags-switches-and-inventory-bytes.md`, `docs/code/save-and-load.md`, `docs/wram-memory-map.md`; names in `us/names/` for flags (through `npm run names`, dry-run first).

### EG-H Scene load, maps, transitions, camera (P2, ST+RT and RT)

- **Rows:** Q-SC-01, Q-SC-03 to Q-SC-08, Q-SC-10 to Q-SC-15.
- **Setup:** scene jumps (section 1.5); for the boss-patch rows the five boss rooms; for transitions a scene with a script that sets each type.
- **Watches and tools:** `$0318`, `$0343`, `$0345`, `$0348`, `$0392`, `$0394`, `$038A`, `$038C`, `$03E3` (transition type), BG scroll registers via `get_ppu_state`; `take_screenshot` with `layers` on the first frame and ten frames later.
- **Expected:** after load the page counts equal the location table; the first frame of a scene moves the camera by 16 px; the transition types look as in FM-A9 §1.3 (fade, instant, mosaic, BG3 iris); the map patch of the boss rooms closes or opens a barrier.
- **Changes:** notes of the scene loader and `RedrawBackgroundsAtEntry`, `docs/code/scene-area-warp-loading.md`, `docs/areas-and-scenes.md` (dream names), `docs/wram-memory-map.md`.

### EG-I Collision and tile types (P3, ST+RT)

- **Rows:** Q-TL-01 to Q-TL-03, Q-TL-05 to Q-TL-13.
- **Setup:** savestate in a scene with water, a wall edge, a chest, a lair tile and a hazard tile; a scene whose script uses `Cop11`.
- **Watches and tools:** `dump_memory` of `tile_type_map` (`$7F:8000`) and count the type nibbles; breakpoints on `ProbeTileAtVelocity`, `CollideEast` .. `CollideNorth`, `PixelToMapIndex` with the caller recorded.
- **Expected:** only the type codes `$0F`, `$06`, `$0A`, `$05`, `$0C`, `$03` and the lair marker `$01` occur; `PixelToMapIndex` callers pass y with a low nibble of 0; the old footprint after `Cop11` stays blocked.
- **Changes:** `docs/code/collision-and-physics.md`, notes of the collision routines and `Cop11`, `Cop2B`, `Cop16`.

### EG-J Text engine, glyphs and spellings (P3, RT)

- **Rows:** Q-TX-02 to Q-TX-04, Q-TX-06, Q-TX-09 to Q-TX-18 (Q-TX-19 is EG-K; Q-TX-01, 05, 07, 08 are decisions; Q-TX-20 is static).
- **Setup:** savestate at a dialogue; for strings `write_word` the string pointer into the dialogue call, or play to the speaker; the staff roll by jumping to the ending scene.
- **Watches and tools:** `take_screenshot` with `layers` per page; `$1B84`, `$03E9`, `$03F9`, `$03EB`-`$03F3`; `get_ppu_state` for BG3 scroll; `step_scanline` count 235 before a screenshot.
- **Expected:** the apostrophe words print a blank (not an apostrophe); "Soul Blader" and "COPORATION" are printed as in the ROM; the box holds four lines and scrolls two rows on the fifth; the staff roll runs about 6,976 frames.
- **Changes:** DISC notes in the block notes of the text routines and string files, `docs/code/text-and-dialogue.md`. ROM spelling is kept in the notes; the walkthrough is not edited.

### EG-K Menus, HUD, status, Master's menu (P3, RT)

- **Rows:** Q-MN-01 to Q-MN-05, Q-TX-19.
- **Setup:** savestate in a field scene; `a` held for 3 frames for the status page (hash `6a3c7d11eec9c32a4e17667dea73f3741cd918b3` of earlier runs is the baseline picture); Master's menu by walking onto tile (7,4) in each world scene.
- **Watches and tools:** `$03A2`, `$9B00` flag, `$0452`, `$1C6A`; `take_screenshot` with `layers`; `write_word` of `$7FFF` palette for the erase prompt.
- **Expected:** the A button opens the status and souls page; the erase prompt turns colour 3 of palette 0 from white to yellow; the Master's menu offers Record, Move, Quit once `$9B00` is set.
- **Changes:** `docs/code/menus-inventory-status-hud.md`, `docs/code/save-and-load.md`, notes of the menu routines.

### EG-L Audio and SPC (P3, RT)

- **Rows:** Q-AU-01 to Q-AU-04.
- **Setup:** savestate in a scene that plays a known song; the dog's joke scene in GreenWood; pause with Start.
- **Watches and tools:** `read_memory` of the APU ports (`$2140`-`$2143` through the port mirror), `trace_between` on `HandleVBlank`, `get_execution_trace`, breakpoints on `WriteSoundPort`; SPC side per `docs/audio/spc-disassembly.md`.
- **Expected:** `sound_request` low byte goes to `APUIO2` on even frames and 0 on odd frames; the dog's 0 and 1 restart song 1 from the first phrase; the pause writes `$F2` then `$01`.
- **Changes:** `docs/code/spc-interface.md`, notes of `HandleBrk`, `WriteSoundPort`, `PlaySong`; sound id names (names tool).

### EG-M VRAM, HDMA, palettes, sprites and asset identification (P3, RT)

- **Rows:** Q-GX-01 to Q-GX-12; mapping M-1.8 and M-1.10 (evidence only).
- **Setup:** savestates in the title, a field scene, a soul-effect scene (Woods of GreenWood B1F and Lostside), a dream scene, the ending.
- **Watches and tools:** `dump_memory` of VRAM, CGRAM and OAM; `get_oam`; `get_dma_state`; `get_ppu_state` (window and colour math registers); `get_palette_info`; `take_screenshot` with `layers` per layer; `step_scanline` to read HDMA effects across lines.
- **Expected:** the soul windows follow the register bits (Light: WOBJSEL `$30`, CGWSEL `$12`); no frame needs more than four HDMA channels; the effects frames use OAM tiles `$6`, `$8`, `$A`, `$C` of the strip slots; the EXP popup map at `$7E:F000` survives scene changes; the iris colour is CGRAM word `$7F:0002`.
- **Changes:** `docs/code/vram-dma-hdma-palettes.md`, `docs/code/sprites-oam-animation.md`; descriptive asset names (M-1.8) through `us/files.json` keys after your decision.

### EG-P1 to EG-P8 World passes (P3 and P4, RT)

One pass per world, in this order: P1 Grass Valley (Q-GV-01 to 04), P2 GreenWood (Q-GW-01 to 04), P3 St. Elles (Q-SE-01, 02), P4 Mountain of Souls (Q-MS-01, 02), P5 Dr. Leo's Lab (Q-LL-01 to 03), P6 King Magridd's Castle (Q-MC-01, 02), P7 World of Evil (Q-WE-02), P8 common actors (Q-CM-01 to 03).

- **Setup:** scene jump into the area and scene of the row; savestate at the speaker or the boss; `layers` screenshots.
- **Watches:** the flag cells that the row names (read at each step), actor fields through `read_memory` at the slot, `get_oam` for sprite identity.
- **Expected:** the static reading of each row (the actor does what the script says; the open points are speakers, movement carried by animation data, and walkthrough mismatches).
- **Changes:** the actor part notes of that world file; names of the four `w0_` address-named actors (names tool); DISC notes against the walkthrough chapter.
- **Combine** each pass with a short CDL segment (EG-B) so the dead-stub rows close in the same session.

### SQ Static queue (no emulator)

All rows with EG = `SQ`. Method: read `extracted/`, the notes and the documents; settle with `rg` over `extracted/` and the walkthrough. Order: Q-TO-13 and Q-TO-14 (housekeeping), Q-TX-20, Q-BH-05, Q-BH-06, Q-CB-20, Q-CB-21, Q-CO-02, Q-CO-04, Q-CO-05, Q-SC-09, Q-TL-04, Q-FL-07, Q-AU-05, Q-TO-07, Q-WE-01, Q-WE-03, Q-CM-04, Q-WM-05. Results go through `npm run merge` (notes) and `npm run names` only.

### DQ Decision queue

All rows with EG = `DQ`. Ask first: **Q-TO-03** (P1: the 65803 override changes the ROM bytes). Then the tool and layout decisions (Q-TO-02, Q-TO-04, Q-TO-06, Q-TO-05, Q-WM-01), the spelling and name decisions as one batch (Q-TX-01, Q-TX-05, Q-TX-07, Q-TX-08, Q-TO-10), and the small naming rows (Q-WM-08, Q-WM-09, Q-CO-01, Q-SC-02, Q-SC-16, Q-TO-09, Q-TO-11, Q-TO-12).

## 5. Rows already settled (not repeated in the tables)

| Source ID | Settled by | What is left |
|-----------|------------|--------------|
| I001-2 (R-2) | spike-decision.md and I016 (pin `meta_tables_008000`, transform) | residuals: Q-TO-01 |
| I005-5 | I013-1 (the bucket scan stops on an `$FFFF` word) | the runtime half is Q-EN-01 |
| I008-2 | I026 (`67277` set to `M: 0`, SHA neutral) | none |
| I008-3, I015-4 | I016 (transform rebuilds to `B9 00 80`, only those bytes change) | none |
| I015-3 | I016 (`set group` and `set scene` are byte-neutral, `set movable` is not) | none |
| I015-1, I016-5 | I017 (the baseline ran wrong; fixed in wave 0) | none |
| I016-3 | I017 (the boss scene loads when the arrival values are written with the scene) | none |
| I015-7 | I020 (decided at PB3) | none |
| I015-8, I019-3 | I042 (`split-part` added; the IRQ part and three other parts cut) | `MapPatchRectsAndMapSizes` is Q-TO-06 |
| I020-6 | I021 (method: `layers` screenshot) | none |
| I020-7, I021-1 | I021 (the block has one part; no split needed) | none |
| I024-1, I025-2, I042-6 | I056 (static: sound ports, fade-out direction, stream format) | none |
| I013-6, I035-3 | I056 (static answers) | runtime halves are Q-AU-04 |
| I024-6 | I034 (named `front_end_step`) | none |
| I026-7 | I053 (reachability half: 13 chest rows hold the Herb) | runtime half is Q-CB-07 |
| I028-2 | I029 (`SaveSlotLineTemplates` prints list entry 3) | none |
| I029-5 | I030 (`StaffRollText` has a part note) | none |
| I030-1 | I041 (Move goes to scene 9 of area 0) | runtime half is Q-CM-03 |
| I033-9 | I057 | none |
| I035-10 | I041 (`CPY #$06AA` is the pool-full value of `PopFreeSlot`) | none |
| I049-6 | I050 (the EXP popup layout is decoded) | integrity is Q-GX-07 |

Partly answered rows keep their row above: I005-7 (Q-TO-04), I011-13 (Q-FL-04), I009-11 (Q-HE-08), I043-4 (Q-GX-03, collision part answered by I050), I004-9 (Q-CB-08).

## 6. Suggested run order

1. Q-TO-11 (fixtures) and Q-TO-03 (the P1 decision) first, both small.
2. EG-B (CDL, one long session): shrinks the rest.
3. EG-N, then EG-O (only before the next regroup).
4. The P2 groups: EG-A, EG-C, EG-D, EG-E, EG-G, EG-H.
5. The P3 groups: EG-I, EG-J, EG-K, EG-L, EG-M, EG-F.
6. The world passes P1 to P8, each with a short CDL segment.
7. The static queue and decision queue can run at any time; do the SQ housekeeping rows (Q-TO-13, Q-TO-14) with the next documentation step.
