# I053 checklist: docs/code/menus-inventory-status-hud.md

Topic: menus, inventory, status and HUD. `<files>` was not given, so the files are chosen like in I043-I052.

Rules in force: notes and comments change only through `npm run merge`, names only through `npm run names`; no ad-hoc scripts; no commits; no comparison of the original ROM with the rebuilt ROM; every claim cites a label; the walkthrough is the source of truth for game names, the ROM text for exact spelling and behaviour; every mismatch is an OQ with tag DISCREPANCY.

## Scope

Files (all under `extracted/`):

- `library/lib_menus.asm` (`DispatchFieldButtons`, the status and souls screen, the equipment and item menu, the icon drawing, `RecalcGearStats`, the menu text, `ItemNameList`, the item descriptions, `GearStatTable`, `WeaponMinLevelBcd`)
- `library/lib_choice_menus.asm` (only `ChooseMenuRow`, `ChooseMenuRowAtTable`, `TitleMenuCursorOffsets`; `RunChoiceMenu` and `BlinkChoiceCursor` are in `text-and-dialogue.md`)
- `library/lib_menu_screen_setup.asm` (menu graphics, palettes, tile groups, restore on exit, `LoadEquippedMagicGfx`)
- `library/lib_inventory_store.asm` (`StoreInventoryEntry`)
- `library/lib_hud.asm` (`UpdateHud`, the HUD strings, the enemy gauge)
- `library/lib_player_helpers.asm` (only `DrainPendingHeal`, `DrainPendingExp`, `AddExp`, `AddGems`, `SubtractGems`)
- `cop_handlers/cop_items_stats_text.asm` (only the item, Gem, EXP and HP commands: `Cop0A`, `Cop0B`, `Cop18`, `Cop19`, `Cop25`, `Cop26`, `Cop36`-`Cop39`)
- `system/cop_core.asm` (`LookupInventoryEntry`)
- `system/data_engine_tables.asm` (icon position tables, `MagicGraphicsPointers`, `MagicPalettePointers`), `system/data_iris_and_icon_tiles.asm` (`IconTileRecords`), `system/data_menu_palettes_and_groups.asm` (menu palettes and tile groups)
- readers of the equipped cells: `system/engine_combat_hits.asm`, `system/player_core.asm` (`PayPhoenixCost`), `system/engine_player_death_and_actor_helpers.asm` (`CheckPlayerDeath`), `system/engine_spawn_lairs_death_drops.asm` (Lucky Blade), `system/data_chest_lists.asm` (chest contents)

Not repeated (already in the spokes): the text renderer and the string format (text-and-dialogue.md), the BG3 upload and the DMA (vram-dma-hdma-palettes.md), the pause banner and the frame structure (boot-nmi-main-loop.md), the level-up watcher (player.md), the damage formula (combat-damage-and-enemy-records.md), the file select and save slots (a later spoke).

## To do

- [x] Fresh `npm run extract:lt` before any edit (baseline `npm run rebuild`: SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 27 "Cross bank call" warnings).
- [x] Read the conventions: notes-and-comments.md, code-bank-documentation.md, doc-audit README, walkthrough README, `items.md`, `magic.md`, `level-up.md`, chapter 01; the format of I052.
- [x] Read every routine and string of the topic in the annotated asm; trace the readers of the four equipped cells and the writers of `inventory`.
- [x] Check the existing notes against the code and the other spokes.
- [x] Check the chest lists for repeated Medical Herb content (static answer to the reachability part of OQ-I026-7).
- [x] Cross-check game terms against the walkthrough (menu buttons, the grid, weapon, armor and magic tables, Gem costs, bracelets, Herb, Bottle, Bell).
- [x] Write this checklist (before any edit).
- [x] Write `docs/code/menus-inventory-status-hud.md` in one Write call: breadcrumb, source links, overview with one mermaid diagram (at most 15 nodes), memory map (code, data, state), `###` sections that answer the Three Questions, walkthrough cross-check, open questions, See Also.
- [x] Write `plans/extracted-audit/edits/I053.json` (note corrections: `When: ExitEquipmentMenu` in two part notes, the `MagicPalettePointers` wording, the doubled library name in the `lib_menus` block note); `npm run merge -- ... --dry-run`, apply, `npm run extract:lt`.
- [x] Write `plans/extracted-audit/questions/I053_questions.md`.
- [x] Hand edits: link the new document from the sibling spokes (planned-spokes lines, See Also); correct `ExitEquipmentMenu` in `player.md` and in the rows of `docs/wram-memory-map.md`.
- [x] Verify: every backticked identifier of the new document exists in `extracted/` or `us/names/`; every relative link resolves (hub `README.md` excepted); line count 50-900; at most 2 mermaid diagrams with at most 15 nodes; addresses of the memory-map tables match `us/names/` after the LoROM conversion.
- [x] Gate: `npm run extract:lt`, `npm run rebuild` (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` unchanged), `npm run names -- --check`, `npm run merge -- --check`.
- [x] Write `plans/extracted-audit/results/I053_results.md` with the gate table and a suggested commit message.

## Progress

- Research done; baseline gate confirmed. Findings so far that shape the document and the merge spec:
  - `ExitEquipmentMenu` is only the `SEC` / `RTS` return path of `RunEquipmentMenu`. The restore of scroll, video registers, graphics, palette and pose is the tail of `OpenEquipmentMenu`. Two part notes (`LoadEquippedMagicGfx`, `RestoreSceneBgGfxAndPalette`), the `player.md` text and three rows of `wram-memory-map.md` name the wrong routine.
  - `MagicPalettePointers` is eight 3-byte pointers like `MagicGraphicsPointers` (`LoadEquippedMagicGfx` indexes both with 3 x n and reads only the word of the palette entry, the bank is fixed to `$0F`); the `lib_menu_screen_setup` block note says "a word per spell".
  - 13 chest rows hold the Medical Herb (`$38`), so `StoreInventoryEntry`'s "old value was `$38`" branch is reachable by opening a second Herb chest while one is owned; this agrees with `items.md` ("if you already have one and get another, effect is immediate").
- `docs/code/menus-inventory-status-hud.md` written (385 lines, one diagram of 14 nodes). Verification: 200 backticked identifiers exist in `extracted/` or `us/`; 83 `label` + `$bank:addr` pairs match `us/names/` after the LoROM conversion; 34 state rows match `us/mnemonics.json`; all relative links resolve except the hub `README.md`.
- Note corrections merged in two specs: `edits/I053.json` (8 edits in 3 notes files; `I053.json` is an edit spec and cannot be re-applied) and `edits/I053b.json` (the `lib_player_helpers` block note); `extract:lt` re-run after each.
- Written while the document was being checked: the `player_exp_next` meaning ("Next level :" is the next level's EXP total, not a remainder; OQ-I053-6) and the inventory address of entry `$38` (`$1B55`, not `$1B56` as OQ-I026-7 and OQ-I006-2 wrote).
- Hand edits done: planned-spoke lines of `player.md`, `vram-dma-hdma-palettes.md`, `actor-system.md`, `boot-nmi-main-loop.md`, `sprites-oam-animation.md`, `text-and-dialogue.md` now link the new spoke; `ExitEquipmentMenu` corrected in `player.md` and in five places of `docs/wram-memory-map.md`.
- Gate passed: SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` unchanged, 27 "Cross bank call" warnings as before, `names --check` OK (2765 names), `merge --check` 0 errors, 0 warnings, 0 orphans.
- Questions file `questions/I053_questions.md` and results file `results/I053_results.md` written.
