# I042 checklist - final layout and naming of the core engine and library files

Ad-hoc audit step, before the documentation pass (PD). Request: many library routines sit alone in a file that still carries a generated name; group the core engine routines so that cross-file references are minimal; name every group or single routine by what it does; block names must follow the names in `us/names`. Continues I041. A regroup step: the ROM SHA-1 changes; the gate is per-label text equality (inside `blocks`), 0 undefined references and a Mesen2 comparison.

Baseline gate before this step: `3148390ed40ce14060b33c1387303a8a77e7a0c1` (1,081,344 bytes, checksum 110068443). Gate after: `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` (checksum 110070696).

## Tool extension

- [x] `blocks` gets `split-part` (`src/blocks-edit.ts`): cut one part at a label, optionally move the second half. Documented in `gaia-core/docs/notes-and-comments.md` (Blocks Merge table and Limits) and `gaia-core/docs/rom-mapping-guide.md`.
- [x] `blocks-verify.ts` compares text per label (a cut at a sub-label changed the text of the parent label before; cosmetic braces are ignored). The report line reads `text: N labels compared, N identical`.

## Analysis

- [x] Fresh `extract:lt` + `audit --matrix`: 151 blocks, 2,936 cross-file references.
- [x] Every cut point was read in the `extract:lt` text: the instruction before it is `RTS` (scheduler 2612 and 3880, `lib_menus` 72152 and 72599).
- [x] Constraints kept (`placement/pinned.md`): souls string run, strings in bank 02, COP tables and return-address targets, `lib_027781_part1` with its branch target, no bank crossing.
- [x] New pin found: the never-taken `BRA loc_0139E6` of `FindAssetLabel` keeps `InitHardwareAndClearWram` in the loader (`OQ-I042-7`).

## Plan

### A. Bank 02 library (`edits/I042a_blocks.json`)

- [x] A1 merge into `lib_map_scroll_and_redraw`
- [x] A2 merge into `lib_map_tile_patches`
- [x] A3 merge into `lib_hdma_window_effects`
- [x] A4 merge into `lib_choice_menus`
- [x] A5 merge into `lib_menu_screen_setup`
- [x] A6 merge into `lib_name_entry_and_staff_roll`
- [x] A7 move `EnableDisplayAndNmi` to `lib_system_helpers`
- [x] A8 move `HudRepeatCounts` + `HudFrameText` to `lib_hud` (renamed from `lib_0118FC_part6`)
- [x] A9 rename `lib_0109D6_part3` to `lib_inventory_store`
- [x] A10 (changed) the loader is NOT split: `lib_013ADA` (`ApplyBootPpuLayout`) is merged into `lib_system_helpers`; the pin is in `OQ-I042-7`
- [x] A11 `split-part` `DispatchFieldButtons` at 72152 (`RunTalkInteraction` to new `lib_field_talk`) and at 72599 (`OpenEquipmentMenu` back to `lib_menus`)

### B. Bank 04 library (`edits/I042b_blocks.json`)

- [x] B1 merge into `lib_boot_and_scene_init`
- [x] B2 merge into `lib_main_loop_helpers`
- [x] B3 merge into `lib_player_helpers`
- [x] B4 rename `lib_027277` to `lib_unused_sine_wave_tables`

### C. System (`edits/I042c_blocks.json`)

- [x] C1 `split-part` the scheduler at 2612 (`engine_combat_hits`) and 3880 (`engine_tile_collision`); rename the rest to `engine_actor_scheduler_and_sprites`
- [x] C2 rename `engine_003005` to `engine_player_death_and_actor_helpers`
- [x] C3 (D1 of the plan, same spec) rename nine single-actor world blocks to follow the name of their part

### E. Names (`renames/apply-I042_names.json`, `apply-I042b_names.json`, `apply-I042c_names.json`)

- [x] E1 generated names in the core named: soul effects and HDMA table, map patch helpers, arithmetic helpers, menu setup, SPC upload and the sine wave mover family, stubs
- [x] E2 `names -- --check`: OK (2,679 names)

### F. Notes (`edits/I042a_notes.json`, `edits/I042b_notes.json`)

- [x] F1 block note for every merged or new block (overview paragraph with what it holds, callers, why together); the old notes are kept below it
- [x] F2 block and part notes for the files that had none (`lib_hdma_window_effects`, `lib_field_talk`, `engine_combat_hits`, `engine_tile_collision`, the SPC upload, the stubs, the arithmetic helpers, the map patch routines, the menu setup routines)
- [x] F3 stale references repaired (`lib_menus` -> `lib_field_talk`, `engine_actor_scheduler_and_sprites` -> `engine_combat_hits`, two block names that never existed)

### G. Gate

- [x] G1 `extract:lt`, `rebuild` (`040a408a...`), `names -- --check`, `merge -- --check` (1,397 comments, 1,684 part notes, 135 block notes, 0 errors), `audit` (one finding: R-2)
- [x] G2 Mesen2 comparison (baseline `3148390e` in slot `w5`, `040a408a` in slot `w6`, both power-cycled): `trial.rec` 3,677 frames 0 divergent, Trial Room screenshot identical, status page screenshot identical, a B press with nothing in front identical, boss fight (`boss_fight.rec`, 538 frames) 0 divergent. Not covered: talk to an NPC and an opened chest (`OQ-I042-9`)
- [x] G3 normal `npm run extract`
- [x] G4 `pinned.md` wave 6, `questions/I042_questions.md`, `results/I042_results.md`

## Progress

- 2026-11-23: tool extension, blocks specs A, B and C, names specs, notes specs and the gate done; see `results/I042_results.md`.
