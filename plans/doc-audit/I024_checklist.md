# I024 checklist: annotate batch A2 (`engine_*` rest, BRK and COP vectors, `engine_routines_*`)

Plan: `c:\Users\azare\.cursor\plans\blazer_docs_and_analysis_e740ea3f.plan.md`, step PC for batch A2. Routine table: `plans/doc-audit/function-map/FM-A2.md` (rows X001-X109, written in I006 for the old files; the regroup waves moved the routines, see the table below). The pose names of the 28 player handlers come from `FM-A10.md` section 1.3 and 7 (it settled the carry and the facing).

Rules for this iteration: names only through `npm run names`, notes and comments only through `npm run merge`, both dry-run first; hand edits only in `us/mnemonics.json` (no tool exists for it, as in I023); no ad-hoc scripts; no commit; the original ROM is not compared with the rebuilt ROM; the rebuilt SHA-1 must stay `3148390ed40ce14060b33c1387303a8a77e7a0c1` (annotation only).

## Where the A2 rows live now

| File | FM-A2 rows | Block note |
|------|------------|------------|
| `extracted/system/cop_dispatch.asm` | X001-X005 (BRK and COP vectors, three handler tables) | update (exists) |
| `extracted/system/cop_core.asm` | X006-X016 (flag test, inventory lookup, footprint, slots, spawn helpers); the exit chain, `CopB2_SpawnBeforeRelative`, `code_0064CC` and `code_006537` are batch A3 | exists, kept (names are rewritten by the names tool) |
| `extracted/system/engine_spawn_lairs_death_drops.asm` | X050-X080 (lair scripts, enemy death, drops, boss death, pickups) and X093-X098 (ending); `code_002C9B`-`code_002D64` are A3 | update (A1 text kept, A2 text added) |
| `extracted/system/engine_003005.asm` | X081-X089 | new |
| `extracted/system/engine_title_file_select.asm` | X099-X107 | new |
| `extracted/system/engine_unreferenced_code.asm` | X108 | update |
| `extracted/system/player_core.asm` | X017-X049 (the 28 handlers, swings, Phoenix cost, projectiles) | part notes and comments written; block note not written: the file is batch A10 |
| `extracted/st_elles/ghost_ship/se_ghost_ship_enemies.asm` | X090-X092 | not touched: world actor batch |
| `extracted/actor_shared/shared_actor_helpers_bank0.asm` | X109 | not touched: `actor_shared` batch |

## Checklist

- [x] Read: FM-A2, FM-A10 sections 1.3 and 7, FM-A11 section 4.6, I006 and I023 questions, the files above, the COP 0B and 19 handlers, the callers of the boss map patch, the walkthrough (items, magic, sidequests, chapters 02 and 08)
- [x] Baseline: fresh `npm run extract:lt`, `npm run rebuild`, SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`
- [x] Names spec `plans/extracted-audit/renames/apply-I024_names.json`; `npm run names -- <spec> --dry-run`; apply; `npm run extract:lt`
- [x] Mnemonics in `us/mnemonics.json` for the names with evidence; evidence sentences in `docs/wram-memory-map.md` (section 7c)
- [x] Merge spec `plans/extracted-audit/edits/I024.json`: block notes, part notes (In / Out / Clobbers + When, Sees, Why), sparse comments with `expect` guards
- [x] `npm run merge -- <spec> --dry-run`; apply; `npm run extract:lt`; read the result
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 unchanged), `names -- --check`, `merge -- --check`
- [x] `plans/extracted-audit/questions/I024_questions.md` (new `OQ-I024-k` rows only)
- [x] `plans/extracted-audit/results/I024_results.md` with a suggested commit message (the user commits)

## Progress

- Read phase done. Baseline gate passed (SHA-1 unchanged after a fresh extract).
- Names applied (111 spec rows, 314 names). Merge applied (9 block notes, 214 part notes, 256 comments); one comment key corrected after the dry run (9987 to 9985).
- Mnemonics (25) and `docs/wram-memory-map.md` section 7c written; evidence sentences re-checked against the extracted source.
- Final gate passed: SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, `names --check` OK, `merge --check` 0 errors, 0 warnings, 0 orphans.
- Questions `OQ-I024-1` to `-9` and the results file written. Nothing committed; the user commits.
