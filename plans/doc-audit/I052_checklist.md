# I052 checklist: docs/code/text-and-dialogue.md

Topic: text and dialogue. `<files>` was not given, so the files are chosen like in I043-I051.

Rules in force: notes and comments change only through `npm run merge`, names only through `npm run names`; no ad-hoc scripts; no commits; no comparison of the original ROM with the rebuilt ROM; every claim cites a label; the walkthrough is the source of truth for game names, the ROM text for exact spelling and behaviour; every mismatch is an OQ with tag DISCREPANCY.

## Scope

Files (all under `extracted/`):

- `library/lib_text_render.asm` (both renderers, control codes, dictionary expansion, window frames, gauge bar, wait helpers, `TextListPointers`)
- `system/data_dictionary.asm` (`Dictionary`)
- `cop_handlers/cop_items_stats_text.asm` (only `Cop01_ShowText`, `Cop02_PromptYesNo`, `Cop1A_ChoiceMenu`, `Cop3A_EnterPlayerName`; the item, Gem, EXP and HP commands stay for the inventory and stats spokes)
- `library/lib_choice_menus.asm` (`RunChoiceMenu`, `BlinkChoiceCursor`; the row choosers `ChooseMenuRow` and `ChooseMenuRowAtTable` belong to the menus spoke)
- `actor_shared/shared_choice_prompt_texts.asm` (the five option windows)
- `library/lib_field_talk.asm` (the B-button talk)
- `library/lib_tile_triggers_and_lair_return.asm` (only the chest and lair messages, `NpcNameStrings`, `text_arg`)
- `library/lib_banner_texts.asm` (level-up, pause and location banner strings, `LocationNameList`)
- `library/lib_name_entry_and_staff_roll.asm` (`RunNameEntryScreen`, `ScrollStaffRollText`)
- `grass_valley/front_end/gv_title_texts.asm`, `gv_prologue_texts.asm`, `gv_epilogue_texts.asm` (what the story screens print)
- the worked example: `greenwood/woods_of_greenwood/gw_woods_actors_01B98D.asm` (`gw_npc_dog_restaurant_01B98D`)

Not repeated (already in the spokes): the pause flow (boot-nmi-main-loop.md), the level-up watcher (player.md), the BG3 page upload and the DMA (vram-dma-hdma-palettes.md), the COP operand types and dispatcher (cop-dispatch.md), `RunSubFrame` and the sub-frame actor filter (boot-nmi-main-loop.md, actor-system.md), the location table as scene data (scene-area-warp-loading.md, areas-and-scenes.md). Left to the menus and HUD spokes: `PrintTextString` call sites in menus, the status and soul screens, `ItemNameList` content, `lib_hud`.

## To do

- [x] Fresh `npm run extract:lt` before any edit.
- [x] Read the conventions: notes-and-comments.md (merge spec format), code-bank-documentation.md (skeleton, Three Questions), doc-audit README, walkthrough README and chapter 01, the format of I051.
- [x] Read every routine and string of the topic in the annotated asm; trace the callers of both renderers, the writers of `text_delay`, `text_arg`, `choice_result`.
- [x] Check the existing notes against the code and the other spokes: found three notes that say actors keep running during a text wait (only actors with `$16` bit `$0010` do) and one that says a new game sets `text_delay` (`InitFixedState` runs once at boot).
- [x] Cross-check game terms against the walkthrough (names, the Master's menu, the lair count, the name entry, Gems, Queen Magridd, Lisa, Deathtoll).
- [x] Write this checklist (before any edit).
- [x] Write `docs/code/text-and-dialogue.md` in one Write call: breadcrumb, source links, overview with one mermaid diagram (at most 15 nodes), memory map (code, data, state), `###` sections that answer the Three Questions, walkthrough cross-check, open questions, See Also.
- [x] Write `plans/extracted-audit/edits/I052.json` (note corrections); `npm run merge -- ... --dry-run`, apply, `npm run extract:lt`.
- [x] Write `plans/extracted-audit/questions/I052_questions.md`.
- [x] Hand edits: link the new document from the sibling spokes (planned-spokes lines, See Also) and correct the `text_delay` line of `docs/wram-memory-map.md`.
- [x] Verify: every backticked identifier of the new document exists in `extracted/` or `us/names/`; every relative link resolves (hub `README.md` excepted); line count 50-900; at most 2 mermaid diagrams with at most 15 nodes; addresses of the memory-map tables match `us/names/` after the LoROM conversion.
- [x] Gate: `npm run extract:lt`, `npm run rebuild` (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` unchanged), `npm run names -- --check`, `npm run merge -- --check`.
- [x] Write `plans/extracted-audit/results/I052_results.md` with the gate table and a suggested commit message.

## Progress

- Fresh `npm run extract:lt` done before any edit; baseline `npm run rebuild` gave SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` and 27 "Cross bank call" warnings.
- Note corrections merged (`edits/I052.json`), then `extract:lt` again.
- `docs/code/text-and-dialogue.md` written (426 lines); sibling documents linked.
- Verification and gate passed: SHA-1 unchanged, 27 warnings as before, `names --check` OK, `merge --check` 0 errors.
- Results file `results/I052_results.md` and questions file `questions/I052_questions.md` written.
