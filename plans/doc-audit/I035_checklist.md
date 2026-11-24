# I035 checklist (PC annotate actor batch greenwood)

Scope: the 8 blocks of group `greenwood`: the Woods of GreenWood actors (`gw_woods_actors_01B98D`, `gw_woods_actors_01D045`), the Lostside marsh actors (`gw_lostside_marsh_actors`, including the fairy gems, rafts and effects), `w1_actor_01E4BB`, the enemies (`gw_lostside_marsh_enemies`, `gw_enemies_without_placement`), the boss `gw_boss_light_water_fire_statues` and the text block `gw_watching_over_world_return_prompt_texts` (no note exists yet, one is added; the strings are not renamed).

Rules for this iteration: names only through `npm run names`, notes and comments only through `npm run merge`, both dry-run first; hand edits only in `us/mnemonics.json` (no tool exists); no ad-hoc scripts; no commits; the original ROM is never compared with the rebuilt ROM. The walkthrough (`docs/walkthrough/03-greenwood.md`) is the source of truth for game names, the ROM text for exact spelling. Light depth for actors: a name, a block note (roster, trigger, flags, dialogue) and a part note per actor root; comments only for non-obvious logic. Evidence chain for naming without invention: meta type (`MetaGreenwood` in `WorldMetaPointers`) -> placement scene (`data_scene_placements`: A04 Woods, A05 Lostside) -> location (`LocationNameList`) -> walkthrough; switch id (the operand of COP 14 / COP 3B) -> lair record (`data_lair_records`, +9 name index into `NpcNameStrings`) -> walkthrough.

## Progress

- [x] Read the conventions (`notes-and-comments.md`, `code-bank-documentation.md`, mapping plan §0 and §8c-8e, doc-audit README), the eight greenwood files, `WorldMetaPointers` (`MetaGreenwood`), the A04 / A05 placement lists, the lair records, `NpcNameStrings`, `LocationNameList`, `ItemNameList`, `docs/cop/index.md` and the walkthrough chapter 3
- [x] Names specs `renames/apply-I035a..c_names.json` (72 names): dry-run, apply, `names -- --check` (1835 names), `extract:lt`
- [x] Merge specs `edits/I035a..e.json` (8 block notes, 72 part notes, 85 comments): dry-run, apply, `extract:lt`
- [x] Mnemonics (`us/mnemonics.json`, by hand): no evidence for a new entry, none added
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, unchanged), `names -- --check` (1835), `merge -- --check` (0 errors, 0 warnings, 0 orphans)
- [x] Questions `questions/I035_questions.md` (OQ-I035-1..17)
- [x] Results `results/I035_results.md` with the suggested commit message (nothing committed)
