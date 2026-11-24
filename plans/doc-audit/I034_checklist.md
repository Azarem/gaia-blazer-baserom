# I034 checklist (PC annotate actor batch grass_valley)

Scope: the 17 blocks of group `grass_valley`: the village actors (`gv_village_actors_018000`, `gv_village_actors_019475`), `gv_multi_area_actors`, the three enemy blocks (`gv_enemy_0FAA49`, `gv_leos_paintings_enemies`, `gv_underground_castle_enemies`), the boss `gv_boss_metal_mantis`, the Leo's Paintings and Underground Castle actors, the Up Above actors and name entry, the trial room and Lisa/Turbo actors, `gv_front_end` (title, prologue, ending and staff roll actors) and the stub `gv_unreferenced_string_stub_01A4F9`. The three text blocks (`gv_title_texts`, `gv_prologue_texts`, `gv_epilogue_texts`) and `gv_watching_over_world_texts` already have their notes from I029 and are only read.

Rules for this iteration: names only through `npm run names`, notes and comments only through `npm run merge`, both dry-run first; hand edits only in `us/mnemonics.json` (no tool exists); no ad-hoc scripts; no commits; the original ROM is never compared with the rebuilt ROM. The walkthrough is the source of truth for game names, the ROM text for exact spelling. Light depth for actors: a name, a block note (roster, trigger, flags, dialogue) and a part note per actor root; comments only for non-obvious logic. Evidence chain for naming without invention: meta type (`WorldMetaPointers`) -> placement scene (`data_scene_placements`) -> location -> walkthrough; switch id -> lair record (`data_lair_records`) -> NPC name index (`NpcNameStrings`).

## Progress

- [x] Read the conventions, the actor and enemy files, `WorldMetaPointers`, the placement lists, the lair records, `NpcNameStrings` and the walkthrough chapters 1 and 2
- [x] Read `gv_front_end`
- [x] Names specs `renames/apply-I034a..e_names.json` (116 names): dry-run, apply, `names -- --check`, `extract:lt`
- [x] Merge specs `edits/I034a..f.json` (13 block notes, 150 part notes, 51 comments): dry-run, apply, `extract:lt`
- [x] Mnemonics (`us/mnemonics.json`, by hand): `front_end_step` (`$0482`) and `file_select_request` (`$0445`) added; SHA-1 unchanged. `ending_page_flag` (`$0466`) deliberately not added: other files use the same word (OQ-I034-16)
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, unchanged), `names -- --check` (1763 names), `merge -- --check` (errors 0, warnings 0, orphans 0)
- [x] Questions `questions/I034_questions.md` (OQ-I034-1 to -18)
- [x] Results `results/I034_results.md` with the suggested commit message (nothing committed)
