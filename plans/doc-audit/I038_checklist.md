# I038 checklist (PC annotate actor batch leos_lab)

Scope: the 7 blocks of group `leos_lab` in 8 files: the laboratory NPCs and dream actors (`ll_laboratory_actors`, file offsets 140579-146898, SNES $04:A523-$BDD2), the dungeon actors (`ll_laboratory_dungeon_actors`: the two Fairy Gems of the dungeon and the fire pit), the town model actors (`ll_town_models_actors`: the third Fairy Gem and the building-removal effect), the two enemy blocks (`ll_laboratory_dungeon_enemies`, `ll_town_models_enemies`) and the boss `ll_boss_tin_doll`, plus the text block `ll_watching_over_world_return_prompt_texts` (block note only).

Rules for this iteration: names only through `npm run names`, notes and comments only through `npm run merge`, both dry-run first; hand edits only in `us/mnemonics.json` (no tool exists); no ad-hoc scripts; no commits; the original ROM is never compared with the rebuilt ROM. The walkthrough (`docs/walkthrough/06-dr-leos-lab.md`, `enemy-bestiary.md`) is the source of truth for game names, the ROM text for exact spelling; every mismatch is an OQ tagged DISCREPANCY. Light depth for actors: a name, a block note (roster, trigger, flags, dialogue) and a part note per actor root; comments only for non-obvious logic. Evidence chain for naming without invention: meta type (`WorldMetaPointers`, `MetaLeosLab`) -> placement scene (`data_scene_placements`, `PlacementA0DS01`-`A0FS02`) -> location (`LocationNameList`) -> walkthrough; switch id -> lair record (`data_lair_records`) -> NPC name index (`NpcNameStrings`).

## Progress

- [x] Read the conventions (notes-and-comments, rom-mapping-guide, code-bank-documentation, mapping-action-plan, doc-audit README, walkthrough chapter 6)
- [x] Fresh `npm run extract:lt`
- [x] Read the 7 actor/enemy/boss files, the text block, `MetaLeosLab`, the placements, the lair records, `NpcNameStrings`, `ItemNameList`, the COP reference
- [x] Names specs `renames/apply-I038a..e_names.json`: dry-run, apply, `names -- --check`, `extract:lt` (96 names)
- [x] Merge specs `edits/I038a..e.json`: dry-run, apply, `extract:lt` (7 block notes, 96 part notes, 78 comments)
- [x] Mnemonics (`us/mnemonics.json`, by hand) only if evidence exists: none found, file untouched
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, unchanged), `names -- --check`, `merge -- --check`
- [x] Questions `questions/I038_questions.md` (13)
- [x] Results `results/I038_results.md` with the suggested commit message (nothing committed)
