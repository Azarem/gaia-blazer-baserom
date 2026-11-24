# I020 results: PB3 wave 3, regroup of `common`

Date 2026-11-22. Scope: `placement-audit.md` section 7.4 ("regroup `common`"), applied with `npm run blocks` (five specs, each dry-run first). The original ROM was never compared with a rebuilt ROM; the baseline for every comparison is the wave 2 build (`1b5950f9`, the I019 gate value). Rebuilt locations below are from `rebuilt/layout.json`.

## Changed in the project

| File | Change |
|------|--------|
| `us/blocks.json` | by `npm run blocks`: five specs, 120 + 1 renames, 124 + 258 + 1 `set` rows, 2 merges, see the tables below. Group `common` is gone (the tool removed it when it became empty); group `actor_shared` is new; no block became `movable` |
| `notes/blockNotes/bank00.json` | not changed in this step (the modification in `git status` is from I019) |
| `extracted/` | regenerated (`npm run extract:lt`, then the plain `npm run extract` at the end): 549 to 547 files, 0 stale left, `extracted/common/` removed (an empty folder was left by the extract and was deleted with `rmdir`). New folders: `actor_shared/`, and scene folders under the world groups for the moved blocks (`grass_valley/front_end`, `grass_valley/up_above`, `grass_valley/grass_valley_village`, ...) |
| `docs/cop/index.md` (line 231), `docs/wram-memory-map.md` (lines 48, 51) | whole-word block-name rewrites done by the tool (`gv_up_above_name_entry_voice`, `gw_enemy_0FB433`, `player_core`). All three read correctly; **no doc was edited by hand in this step**. No `common_actor` or `common_shared` name is left in `docs/`, `notes/`, `us/` or `src/` |
| `plans/extracted-audit/edits/I020_blocks_01_wave3_renames.json` | new, applied: 120 renames (W3-01 .. W3-120), each with a `note` where the evidence matters |
| `plans/extracted-audit/edits/I020_blocks_02_wave3_common_groups.json` | new, applied: 23 `set` ops (124 blocks), W3-S01 .. W3-S23 |
| `plans/extracted-audit/edits/I020_blocks_03_wave3_world_scenes.json` | new, applied: 23 `set scene` ops (258 blocks), W3-A01 .. W3-A23 |
| `plans/extracted-audit/edits/I020_blocks_04_wave3_merges.json` | new, applied: 2 merges, W3-M01, W3-M02 |
| `plans/extracted-audit/edits/I020_blocks_05_wave3_ghost_ship_children.json` | new, applied: `engine_004281` renamed `se_ghost_ship_enemy_child_scripts` (W3-R121) and moved to `st_elles/ghost_ship` (W3-S24) |
| `plans/doc-audit/placement/pinned.md` | wave 3 section: two merges, what moved without merging, what was left apart and why, one new constraint |
| `plans/doc-audit/README.md` | gate value |
| `plans/extracted-audit/questions/I020_questions.md` | `OQ-I020-1` .. `-8` (one DISCREPANCY, `OQ-I020-3`) |
| `plans/extracted-audit/results/I020_results.md` | this file |

No names (outside the 121 block renames of the tool), notes, comments, `transforms.json` or `overrides.json` were changed by hand. No part notes had to move: `merge --check` reports 26 part notes and 2 block notes, 0 orphans. `git status` also shows files modified by earlier iterations (`us/transforms.json`, `package.json`, `src/`, `notes/blockNotes/bank00.json`, `docs/areas-and-scenes.md`); they are not from this step.

## What moved

| Group | What | Rows |
|-------|------|------|
| `system` | `player_core` (merge of `common_actor_001A28_part1` and `player_attack_animation_handlers`; parts `code_001512`, `word_001588`, `code_0015E0`, `code_list_001B2B`, `code_001D3B`, `code_002678`; bank 0, location 6346, 2,860 bytes), `player_spells_level_up` (bank 0, 11891, 1,892), `engine_spc_ipl_upload` (bank 1F, 1015808, 3,575), `unreferenced_stubs_bank1f` (merge of `common_shared_0FDFC0` and `common_shared_0FE769`; bank 1F, 1047508, 6 bytes) | W3-S01, W3-M01, W3-M02 |
| `actor_shared` (new, no scene) | nine shared helpers named `shared_*`: `shared_animation_tick_loop`, `shared_shrine_save_menu`, `shared_enemy_helper_002D67`, `shared_dialogue_tail_007A52`, `shared_animation_loop_helper_01B161`, `shared_help_me_message_0191D2`, `shared_dialogue_tail_01B988`, `shared_animation_loop_hurt_message_022289`, `shared_ms_fairy_gem_texts_dialogue_tail` | W3-S02 |
| `grass_valley` | scene `front_end` (boot, title, ending), scene `up_above` (name entry and 14 small actors), `leos_paintings` (boss Metal Mantis and 6 enemies), `underground_castle` (5 enemies); 1 enemy without a scene | W3-S03 .. S07 |
| `greenwood`, `st_elles`, `mountain_of_souls`, `leos_lab`, `magridds_castle`, `world_of_evil` | bosses and enemies by area key: `lostside_marsh`, `ghost_ship` (+ `se_ghost_ship_enemy_child_scripts`), `seabed_of_st_elles`, `st_elles_coast`, `mountain_of_souls_dungeon`, `snow_mountain`, `laboratory_dungeon`, `town_models`, `airship_dock`, `castle_dungeon`, `castle_towers`, `deathtolls_shrine`, `evil_world`; 14 blocks without a scene | W3-S08 .. S24 |
| all world groups | 258 existing blocks got their scene (27 blocks stay without one, see `pinned.md` and `OQ-I020-5`) | W3-A01 .. W3-A23 |

Names: bosses and the Deathtoll blocks follow the walkthrough; the 82 enemy blocks, the 14 Up Above actors, the ghost-ship enemies and the shared helpers say where the block is or what the code does (`OQ-I020-1`). `00797B` is named from the ROM text (`OQ-I020-3`, DISCREPANCY with placement-audit 5.3).

## Findings

- **Renames, `set group`, `set scene` are byte-neutral.** The SHA-1 stayed `1b5950f9...` after specs 01, 02, 03 and 05 (the dry-run of each said "identical to the current build"). Only the two merges (spec 04) changed it, as predicted: `3939c4be...`.
- **`player_core` is pinned to bank 0 by a return-address table.** `code_list_001B2B` is read with `LDA $@code_list_001B2B, X`, `DEC`, `PHA`, `RTS` (twice); the `RTS` target must be in the bank of the executing routine. Recorded in `pinned.md`.
- **Group `common` held only blocks that had a better home.** 124 blocks left it in spec 02; the two stub blocks left it in spec 04.
- **Screenshots are only valid after the machine has run a few frames.** Several screenshots taken right after `play_input_file` with `turbo`, or right after an `advance_frame`, were black in both builds; the same state showed the expected image two frames later. See `OQ-I020-6`.

## Builds and SHA-1

| Build | SHA-1 | Note |
|-------|-------|------|
| baseline (Mesen2 slot `w2`) | `1b5950f9716428765936d6b494126bde1a1851a5` | end of I019 |
| after specs 01, 02, 03 | `1b5950f9...` | byte-identical, dry-run and apply |
| after spec 04 (merges) | `3939c4bec982b62d6be59ddfb7fac661cf36e034` | **the new gate value** (1,081,344 bytes, checksum 110095162, header complement valid). The dry-run SHA-1 (`3939c4bec982...`) was identical |
| after spec 05 | `3939c4be...` | byte-identical |

## Gate

| Check | Result |
|-------|--------|
| `npm run blocks` (each spec, in its scratch folder) | 6,047 of 6,047 top-level labels with identical text before and after; 8,256 labels before and after; 549 to 547 files; `?INCLUDE` lines 1,204 to 1,202; 13,950 two-byte references with a bank guarantee checked, 0 broken. An undefined reference would fail the scratch rebuild, which was OK each time |
| `npm run extract:lt` | OK, 382 stale files removed after specs 01 to 03 (one extract), 4 after spec 04, 1 after spec 05 |
| `npm run rebuild` | OK, `3939c4be...`; 27 "Cross bank call detected" notices of the form `COP asciistring_*` are printed (the same kind of notice appears in `FM-A8.md` and `core-migration.md`; the count for the wave 2 build was not recorded, so this is not claimed to be unchanged) |
| `npm run names -- --check` | OK, 111 names |
| `npm run merge -- --check` | 0 comments, 26 part notes, 2 block notes; errors 0, warnings 0, orphans 0, duplicate keys 0 |
| `npm run audit` | 547 blocks in 11 groups (`system`, `library`, `cop_handlers`, `actor_shared` and the seven world groups); one finding, the movable-target hazard R-2 (`data_04F000`, `asset_list_028000`, `string_lookup_080000`, `spc_030000`), unchanged |
| plain `npm run extract` | OK, 0 stale |
| Empty groups or folders | none (`common` removed; every `extracted/*` folder has files) |

## Mesen2 comparison (baseline `1b5950f9` in slot `w2` against wave 3 `3939c4be` in slot `w3`, both from power-on; scratch ROMs, states and screenshots in `%TEMP%\blazer-spike`, not in the repository)

| Scenario | Method | Result |
|----------|--------|--------|
| Title, file select, name entry, opening dialogue, Trial Room (3,677 frames) | `compare_runs` of `trial.rec`, watches `$0301`, `$0312` (frame counter), `$0374` | 0 divergent frames in 3,677. Then `play_input_file` of `trial.rec` on each power-cycled slot: same CPU registers (`A=$0060 X=$0980 SP=$1FFB`) and the same screenshot hash `2767aaeed2dc283b51a2b2c9f017c23a5fdbf131` at frame 3,677 (the Trial Room with the player and the status line) |
| Menu, status page | state saved at frame 3,677; `a` for 3 frames, 30 frames later, 2 more frames | identical hash `6a3c7d11eec9c32a4e17667dea73f3741cd918b3` in both builds (the same value as in I018 and I019) |
| Boss fight | scene jump `$0318 = 0x0306`, `$037C = $0080`, `$037E = $00A0`, `$0380 = 0`, state saved at frame 3,977 in each build; `compare_runs` of `boss_fight.rec` (538 frames, watches `$0301`, `$0374`, `$0376`, `$033A`, `$0808`, `$0312`) | 0 divergent frames. The work RAM words `$0300` .. `$043F` are identical at frame 3,977 (SHA-1 `10d5dc33de64fde781560d4949ed930ccd8fae5b` in both). The screen is black at that frame in both builds and shows the same top band (hash `2f3ba53c...`) one frame later: **the boss room itself did not come on screen in this run** (`OQ-I020-6`), so the evidence is the equal state words and the equal watched values, not a picture of the boss |
| World scene jump | not repeated | no evidence (`OQ-I018-5`, `OQ-I019-6`, `OQ-I020-6`) |
| CPU phase | registers at equal frames | the two builds are at different places of the main loop at some frames (frame 3,977: `pc` `$8419` against `$8D0A`; frame 4,517: `A` `$0010` against `$0101`, `pc` `$E4BF` against `$E4BD`), as in `OQ-I019-1`; recorded as `OQ-I020-8` |

Limits: the runtime evidence is the 3,677-frame title to Trial Room run, the status page, and the state of the boss room jump over 538 frames. The merged `player_core` holds the player actor (`meta_entry` `$00` of every world list points at `code_001A28`), which is on screen and handles input in the Trial Room run; the actors of the seven worlds that this wave regrouped (bosses, enemies, world actors) were verified statically (text, references, banks) only, because no world scene rendered. They are reached by 3-byte references from `meta_tables_008000`, and no block changed bank. Screenshot hashes are used only on a settled screen: a black frame right after a replay or an `advance_frame` was not treated as a result.

## Suggested commit message

```
Regroup wave 3 (placement-audit 7.4): dissolve group common

- 121 renames (bosses, front end, Up Above actors, shared helpers,
  82 bank 1F enemy blocks) so that names say where or what a block is
- group and scene per area for the former common blocks and 258 world
  blocks; new group actor_shared for the nine shared helpers
- merge player_core (player core + attack/animation handlers) and
  unreferenced_stubs_bank1f; ghost-ship child scripts to st_elles
- pinned.md wave 3, OQ-I020-1..8, I020 results; new gate SHA-1
  3939c4bec982b62d6be59ddfb7fac661cf36e034
```

Please commit when you're ready.
