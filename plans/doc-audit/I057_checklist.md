# I057 checklist: docs/code/data-tables.md

Topic: the data tables (every table the engine reads by key: the location-keyed lists, the lair records and formations, the meta lists, the 16 engine tables, the animation banks, the menu and graphics tables). `<files>` was not given, so the files are chosen like in I043-I056 (list below). Written before the first edit; the Progress section is updated as items finish.

Rules in force: notes and comments change only through `npm run merge`, names only through `npm run names` (dry-run first); no ad-hoc scripts for notes, comments or names; no commits; no comparison of the original ROM with the rebuilt ROM; every claim cites a label; the walkthrough is the source of truth for game names and facts, the ROM text for exact spelling and behaviour; every mismatch is an OQ with tag DISCREPANCY; record files (`edits/`, `questions/`, `results/`, the document) are written once with the Write tool. Read-only survey scripts (key and hole comparison, lair record field statistics, formation row counts, meta type usage, sine and circle table analysis, EXP rows against `level-up.md`) live outside the repository and write nothing into it.

## Scope

Files (all under `extracted/`):

- `system/data_engine_tables.asm` (the 16 small tables), `system/WorldMetaPointers.asm` (7 lists, the 14-byte meta entry)
- `system/data_scene_placements.asm`, `data_chest_lists.asm`, `data_exit_lists.asm`, `data_plate_lists.asm`, `data_scene_variant_rules.asm`, `data_scene_asset_lists.asm`
- `system/data_lair_records.asm`, `data_lair_formations.asm`
- `library/lib_scene_profile_data.asm`, `lib_map_tile_patches.asm` (`FlagMapPatchTable`, `MapPatchRectsAndMapSizes`), `lib_tile_triggers_and_lair_return.asm` (`LocationAreaScene`, `NpcNameStrings`), `lib_banner_texts.asm` (`LocationNameList`), `lib_unused_sine_wave_tables.asm` (dead `FillSineWaveTables`)
- `system/data_menu_palettes_and_groups.asm`, `data_iris_and_icon_tiles.asm`, `data_dictionary.asm`, `data_spc_driver.asm`, `data_anim_*.asm` (six animation banks)
- readers read only to confirm key, index step and terminator: `system/engine_spawn_lairs_death_drops.asm` (`SpawnSceneActors`, `SpawnLairActor`, `RunLairFormation`), `library/lib_tile_triggers_and_lair_return.asm` (`TryOpenChest`, `CheckExitRegions`), `library/lib_map_tile_patches.asm` (`InitExitListOffset`, `ShowOpenedChests`), `library/lib_hdma_window_effects.asm` (`BuildSoulOrbCircleWindow`), `system/player_spells_level_up.asm`, `system/engine_title_file_select.asm` (sine users)
- plan inputs: `plans/doc-audit/function-map/FM-A11.md` (the struct inventory), questions I015, I033

Not repeated (owned by the other spokes): how the scene loader uses the tables (`scene-area-warp-loading.md`), the 14-byte enemy record and the damage numbers (`combat-damage-and-enemy-records.md`), the lair scripts (`actor-system.md`), animation stepping (`sprites-oam-animation.md`), the dictionary and text (`text-and-dialogue.md`), the SPC upload (`spc-interface.md`), the menu drawing (`menus-inventory-status-hud.md`), switch arrays (`flags-switches-and-inventory-bytes.md`). The document is the cross-table view: key, index step, terminator and bank rules side by side; the row layouts in one place; the two tables no spoke covers (lair records, formations); the findings from comparing the tables with each other.

## To do

- [x] Fresh `npm run extract:lt` before any edit.
- [x] Read the required documents, `FM-A11.md`, the questions of I015 and I033, the neighbouring spokes (headings and the parts that touch the tables).
- [x] Survey (read-only, outside the repo): holes of the five location-keyed tables, shared lists, `+A` of the lair records, formation rows against monster counts, unreferenced formation lists, unused meta types, the sine and circle tables, EXP rows against the walkthrough, boss records against `enemy-bestiary.md`.
- [x] Write this checklist.
- [x] Write `docs/code/data-tables.md` (one Write call): breadcrumb, source links, overview with two diagrams, memory map, sections, walkthrough cross-check, open questions, See Also.
- [x] Write `plans/extracted-audit/edits/I057.json`: corrections of the notes the survey proved wrong or incomplete (`FormationPointers` and the formation block note: exact row count; `LairRecords` block note: `+A`, the five count-0 records; the `FM-A11 4.17` pointers; the sine and circle notes). Dry-run, apply, `npm run extract:lt`.
- [x] Write `plans/extracted-audit/questions/I057_questions.md`.
- [x] Link the new spoke from the neighbours (See Also): `actor-system.md`, `scene-area-warp-loading.md`, `combat-damage-and-enemy-records.md`, `flags-switches-and-inventory-bytes.md`.
- [x] Verify: every backticked identifier exists in `extracted/` or `us/`; relative links resolve (the hub `README.md` is the only dead link); 433 lines; two diagrams of 15 and 9 nodes; memory-map addresses converted from `us/names/`.
- [x] Gate: `npm run extract:lt`, `npm run rebuild` (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`), `npm run names -- --check`, `npm run merge -- --check`.
- [x] Write `plans/extracted-audit/results/I057_results.md` with the suggested commit message. Do not commit.

## Progress

- All items done; see `plans/extracted-audit/results/I057_results.md`.
- `FM-A11 4.17` turned out not to be a ghost reference (the file exists); the two notes that cited it now point to OQ-I033-10 and the document.
