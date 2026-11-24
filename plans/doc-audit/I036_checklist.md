# I036 checklist (PC annotate actor batch st_elles)

Scope: the 12 blocks of group `st_elles`: the Seabed Sanctuary actors (`se_seabed_sanctuary_actors_0F8000`, `se_seabed_sanctuary_actors_0F8D58`), the seabed actors and enemies (`se_seabed_of_st_elles_actors`, `se_seabed_of_st_elles_enemies`, `se_enemy_0FBB78`), the coast (`se_st_elles_coast_actors`, `se_st_elles_coast_enemies`, `w2_actor_0FA6F5`, `w2_shared_0FA945`) and the Ghost Ship (`se_ghost_ship_actors`, `se_ghost_ship_enemies`, `se_boss_floating_skull`).

Rules for this iteration: names only through `npm run names`, notes and comments only through `npm run merge`, both dry-run first; hand edits only in `us/mnemonics.json` (no tool exists, none needed); no ad-hoc scripts; no commits; the original ROM is never compared with the rebuilt ROM. The walkthrough (`docs/walkthrough/04-st-elles.md`, `enemy-bestiary.md`, `sidequests.md`) is the source of truth for game names, the ROM text for exact spelling; a mismatch is logged as an OQ with tag DISCREPANCY. Light depth for actors: a name, a block note (roster, trigger, flags, dialogue) and a part note per actor root; comments only for non-obvious logic. Evidence chain for naming without invention: meta type (`MetaStElles` in `WorldMetaPointers`) -> placement scene (`data_scene_placements`, A06-A09) -> walkthrough; switch id (the operand of COP 14 / COP 3B) -> lair record (`data_lair_records`, +9 name index into `NpcNameStrings`, +B lair location, +15 meta type of the world) -> walkthrough; engine notes for the `$16` / `$1A` bits.

## Progress

- [x] Read the conventions (`notes-and-comments.md`, `code-bank-documentation.md`, mapping plan §0 and §8c-8e, doc-audit README), the twelve st_elles files, `WorldMetaPointers` (`MetaStElles`), the lair records, `docs/cop/index.md`, the combat and `engine_003005` notes and the walkthrough chapter 4
- [x] Names specs `renames/apply-I036a..c_names.json` (120 names): dry-run, apply, `names -- --check` (1955 names), `extract:lt`
- [x] Merge specs `edits/I036a..d.json` (actors: 7 blocks) and `I036e..g.json` (enemies and boss: 5 blocks incl. `se_enemy_0FBB78`): dry-run, apply, `extract:lt`
- [x] Mnemonics (`us/mnemonics.json`, by hand): no evidence for a new entry, none added
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, unchanged), `names -- --check` (1955), `merge -- --check` (0 errors, 0 warnings, 0 orphans)
- [x] Questions `questions/I036_questions.md` (OQ-I036-1..12)
- [x] Results `results/I036_results.md` with the suggested commit message (nothing committed)
