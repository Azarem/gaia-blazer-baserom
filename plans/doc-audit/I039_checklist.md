# I039 checklist (PC annotate actor batch magridds_castle)

Scope: the 9 blocks of group `magridds_castle` in 9 files: the castle town NPCs (`mc_castle_actors`, file offsets 147368-154393, SNES $04:BFA8-$04:DB19), the airship dock actors and dream scenes (`mc_airship_dock_actors`), the Demon Falcon boss (`mc_boss_demon_falcon`), the dungeon actors (`mc_castle_dungeon_actors`), the tower actors (`mc_castle_towers_actors`), the two enemy blocks (`mc_castle_dungeon_enemies`, `mc_castle_towers_enemies`) and the two text blocks (`mc_return_prompt_and_chest_hint_texts`, `mc_unreferenced_string_stub_02623C`).

Rules for this iteration: names only through `npm run names`, notes and comments only through `npm run merge`, both dry-run first; hand edits only in `us/mnemonics.json` (no tool exists); no ad-hoc scripts; no commits; the original ROM is never compared with the rebuilt ROM. The walkthrough (`docs/walkthrough/07-king-magridds-castle.md`, `enemy-bestiary.md`) is the source of truth for game names, the ROM text for exact spelling; every mismatch is an OQ tagged DISCREPANCY. Light depth for actors: a name, a block note (roster, trigger, flags, dialogue) and a part note per actor root; comments only for non-obvious logic. Evidence chain for naming without invention: meta type (`WorldMetaPointers`, `MetaMagriddsCastle`) -> placement scene (`data_scene_placements`, `PlacementA10S01`-`A13S03`) -> location (`LocationNameList`, ids $65-$73) -> walkthrough; switch id -> lair record (`data_lair_records`) -> NPC name index (`NpcNameStrings`).

## Progress

- [x] Read the conventions (notes-and-comments, mapping-action-plan, doc-audit README, walkthrough chapter 7, COP index)
- [x] Fresh `npm run extract:lt`
- [x] Read the 9 files, `MetaMagriddsCastle`, the placements A10-A13, the lair records $158-$198, `NpcNameStrings`, `ItemNameList`, `LocationNameList`
- [x] Names specs `renames/apply-I039a..h_names.json` (303 rows; g and h added after reading the dock and boss code): dry-run, apply, `names -- --check`, `extract:lt`
- [x] Merge specs `edits/I039a..e.json` (9 block notes, 124 part notes, 69 comments): dry-run, apply, `extract:lt`
- [x] Mnemonics (`us/mnemonics.json`, by hand) only if evidence exists: none found, file untouched
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, unchanged), `names -- --check` (2457 names), `merge -- --check` (0 errors, 0 warnings, 0 orphans)
- [x] Questions `questions/I039_questions.md` (12 OQs)
- [x] Results `results/I039_results.md` with the suggested commit message (nothing committed)
