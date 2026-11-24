# I037 checklist (PC annotate actor batch mountain_of_souls)

Scope: the blocks of group `mountain_of_souls`: the Soul of Mountain house actors (`ms_soul_of_mountain_house_actors_020000`, `ms_soul_of_mountain_house_actors_02100B`), the dream and effect actors (`ms_dungeon_actors`), the multi-area actors (`ms_multi_area_actors`), the snow mountain actors (`ms_snow_mountain_actors`), the enemies (`ms_multi_area_enemies`, `ms_enemy_0FCFD6`, `ms_enemy_0FD058`) and the boss Poseidon (`ms_boss_poseidon`).

Rules for this iteration: names only through `npm run names`, notes and comments only through `npm run merge`, both dry-run first; hand edits only in `us/mnemonics.json` (none needed); no ad-hoc scripts; no commits; the original ROM is never compared with the rebuilt ROM. The walkthrough (`docs/walkthrough/05-mountain-of-souls.md`, `enemy-bestiary.md`) is the source of truth for game names, the ROM text for exact spelling; a mismatch is logged as an OQ with tag DISCREPANCY. Light depth for actors: a name, a block note (roster, trigger, flags, dialogue) and a part note per actor root; comments only for non-obvious logic. Evidence chain for naming: meta type (`MetaMountainOfSouls` in `WorldMetaPointers`) -> placement scene (`data_scene_placements`, A0A-A0C) -> walkthrough; switch id (the operand of COP 14 / COP 3B) -> lair record (`data_lair_records`) -> walkthrough.

## Progress

- [x] Read the conventions, the nine mountain_of_souls files, `WorldMetaPointers` (`MetaMountainOfSouls`), the placements, the lair records, `docs/cop/index.md`, the engine notes and the walkthrough chapter 5
- [x] Names specs `renames/apply-I037a..e_names.json` (108 names): dry-run, apply, `names -- --check` (2063 names), `extract:lt`
- [x] Merge specs `edits/I037a..e.json`: dry-run, apply, `extract:lt` (a, b: Soul of Mountain house; c: dream, multi-area and snow mountain actors; d: enemies; e: Poseidon)
- [x] Mnemonics (`us/mnemonics.json`, by hand): no new evidence, none added (the scroll, push zone and player mnemonics already exist)
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, unchanged), `names -- --check` (2063), `merge -- --check` (1150 comments, 1238 part notes, 120 block notes; 0 errors, 0 warnings, 0 orphans)
- [x] Questions `questions/I037_questions.md` (`OQ-I037-1` to `-14`; DISCREPANCY on -1, -2, -3)
- [x] Results `results/I037_results.md` with the suggested commit message
- [ ] The user commits (agents never commit)
