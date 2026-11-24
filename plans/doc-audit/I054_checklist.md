# I054 checklist: docs/code/save-and-load.md

Topic: save and load. `<files>` was not given, so the files are chosen like in I043-I053 (list below). Written before the first edit; the Progress section is updated as items finish.

Rules in force: notes and comments change only through `npm run merge`, names only through `npm run names` (dry-run first); no ad-hoc scripts; no commits; no comparison of the original ROM with the rebuilt ROM; every claim cites a label; the walkthrough is the source of truth for game names and facts, the ROM text for exact spelling and behaviour; every mismatch is an OQ with tag DISCREPANCY; record files (`edits/`, `questions/`, `results/`, the document) are written once with the Write tool.

## Scope

Files (all under `extracted/`):

- `library/lib_save_system.asm` (`SaveGameToSlot`, `LoadGameFromSlot`, `ComputeSlotChecksum`: all of it)
- `system/engine_title_file_select.asm` (only `EnterFileSelect`, `HandleFileSelectChoice`, `DrawSaveSlotMenu`; the Mode 7 hook is in `vram-dma-hdma-palettes.md`)
- `actor_shared/shared_actor_helpers_bank0.asm` (only the Master: `cm_npc_master_*`, the one caller of `SaveGameToSlot`)
- `actor_shared/shared_choice_prompt_texts.asm` (the Record / Move / Quit windows)
- `grass_valley/front_end/gv_front_end.asm` (only `gv_obj_title_start_button_006B61` and the hand-over in `gv_obj_title_and_prologue_0066FC`), `grass_valley/front_end/gv_title_texts.asm` (`SaveSlotMenuText`, `SaveSlotLineTemplates`)
- `library/lib_choice_menus.asm` (`ChooseMenuRowAtTable`, `TitleMenuCursorOffsets`), `library/lib_menu_screen_setup.asm` (`SetupMenuBg2Screen`)
- `library/lib_boot_and_scene_init.asm` (`InitFixedState`: the new-game values), `library/lib_scene_asset_loader.asm` (`InitHardwareAndClearWram`, `ApplySceneProfile`: where `world_index` comes from)
- `grass_valley/up_above/gv_up_above_actors_and_name_entry.asm` (`gv_obj_name_entry_voice_00797B`), `library/lib_name_entry_and_staff_roll.asm` (`RunNameEntryScreen`: who fills the name that is saved)
- `system/player_core.asm` (`PlayPlayerDeath`: death does not touch the slots)

Not repeated (already in the spokes): Mode 7 title, text renderer and string format, `Cop1A_ChoiceMenu`, the scene loader and the warp arrival, death items and Gems, the HUD and the status screen.

## To do

- [x] Fresh `npm run extract:lt` before any edit.
- [x] Read the conventions: notes-and-comments.md (Notes Merge), code-bank-documentation.md, doc-audit README, walkthrough README and chapter 01, mapping plan §0 and §8c-8e, the format of I053.
- [x] Read every routine, string and caller of the topic in the annotated asm; check that no other file touches SRAM (`$70:xxxx` operands, `MVN` with bank `$70`).
- [x] Cross-check game terms against the walkthrough (title, file selection, empty file, the Master, name, save and heal, Move, Gems lost on death).
- [x] Check the existing notes against the code (`engine_title_file_select`, `lib_save_system`, `gv_title_texts`).
- [x] Write `docs/code/save-and-load.md` in one Write call: breadcrumb, source links, overview with one mermaid diagram (at most 15 nodes), memory map (code, data, state, SRAM), `###` sections that answer the Three Questions, walkthrough cross-check, open questions, See Also.
- [x] Write `plans/extracted-audit/edits/I054.json` (note corrections found while writing); `npm run merge -- ... --dry-run`, apply, `npm run extract:lt`.
- [x] Write `plans/extracted-audit/questions/I054_questions.md`.
- [x] Hand edits: planned-spoke line and file-select sentence of `menus-inventory-status-hud.md`; link the new spoke from `scene-area-warp-loading.md`, `text-and-dialogue.md` and `boot-nmi-main-loop.md` where they mention the file select.
- [x] Verify: every backticked identifier exists in `extracted/` or `us/names/`; every relative link resolves (hub `README.md` excepted); line count 50-900; at most 2 mermaid diagrams with at most 15 nodes; memory-map addresses match `us/names/` after the LoROM conversion.
- [x] Gate: `npm run extract:lt`, `npm run rebuild` (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` unchanged), `npm run names -- --check`, `npm run merge -- --check`.
- [x] Write `plans/extracted-audit/results/I054_results.md` with the gate table and a suggested commit message.

## Progress

- Fresh `extract:lt` done. Facts that shape the document:
  - SRAM is touched in exactly two files: `lib_save_system` (write, mirror, validate) and `engine_title_file_select` (list, repair, erase, load). No other absolute `$70:xxxx` operand and no other `MVN` with bank `$70` exists in `extracted/`.
  - The fifth row of the file select is the text "Erase record" (`SaveSlotMenuText`), and its cursor cell `$5CA` is `TitleMenuCursorOffsets[4]`: the "probably erase" of OQ-I024-5 is settled by the label; what the erase does (overwrites the first word of both copies, so the checksum fails) is static.
  - The "Area" column prints one BCD digit (`[06:1,0452]`): the low nibble of `saved_scene`, the world number 1-7 (answers the width question of OQ-I011-12).
  - The walkthrough ("Opt for an empty file to begin") settles the "inferred" new game of a failed load.
- Document written (`docs/code/save-and-load.md`, one diagram of 11 nodes). Corrections found while writing: the name field is nine bytes (`$0447-$044F`); there is no "Continue" row; `EnterFileSelect` follows Start, not "choose to load"; the Master's northern square is where the walkthrough puts the save ("The northern square will allow you to save your adventure").
- `edits/I054.json` dry-run and applied (7 notes files: blockNotes bank00/bank02, partNotes bank00/bank01/bank02, comments bank00/bank02); `extract:lt` shows the corrected notes.
- Hand edits: `menus-inventory-status-hud.md` (overview sentence and the planned-spoke line), `scene-area-warp-loading.md` (two "inferred" cells), `boot-nmi-main-loop.md`, `text-and-dialogue.md` (links), `wram-memory-map.md` (`$1B90` "after Continue").
- Questions: `questions/I054_questions.md` (OQ-I054-1, OQ-I054-2; both GAP).
- Gate passed; results in `results/I054_results.md`.
