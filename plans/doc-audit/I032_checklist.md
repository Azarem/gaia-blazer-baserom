# I032 checklist (PC annotate A10, the player: `player_core` and `player_spells_level_up`)

Scope: the old `common_actor_001A28_part1..4` are now `extracted/system/player_core.asm` (P01-P11, D01, D02; the A2 handlers inside it are already annotated) and `extracted/system/player_spells_level_up.asm` (P12-P39). The player is core code (input, motion, orb, spells, level-up), so the full part-note depth is used; the actor light depth applies to the world actors, not here.

## Progress

- [x] Read the conventions, `FM-A10.md`, `I014_questions.md`, the two extracted files end to end, the walkthrough (`magic.md`, `level-up.md`, chapters 1, 2, 7), `table_078000` (tornado arcs), `data_00F9F7` (sine tables, EXP table)
- [x] Names spec `renames/apply-I032_names.json` (221 rows: top-level routines and every inner label of the two files): dry-run, apply, `extract:lt`, `names --check` (1362 names)
- [x] Merge spec `edits/I032.json`: 2 block notes, 40 part notes (In/Out/Clobbers + When/Sees/Why), 102 comments with `expect`: dry-run, apply, re-applied once with two hedged wordings (return trip)
- [x] Update the A2 part note of `StartIdleUp` (it pointed at "batch A10"): done once with an `edit` list in the first run
- [x] Mnemonics (`us/mnemonics.json`, by hand): `push_dx`, `push_dy`, `push_zone_list`, `push_zone_bank`, `soul_orbit_phase`, `spell_active_count`; SHA-1 unchanged
- [x] `docs/wram-memory-map.md`: section 7j (player cells), section 8 list trimmed, section 7f sentence about `$0433` fixed
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1` unchanged), `names --check`, `merge --check` (826 comments, 694 part notes, 58 block notes, 0 errors)
- [x] Questions `questions/I032_questions.md` (13 rows; DISCREPANCY on -1, -3, -8; -11 and -14 retired)
- [x] Results `results/I032_results.md` with the suggested commit message (nothing committed)
