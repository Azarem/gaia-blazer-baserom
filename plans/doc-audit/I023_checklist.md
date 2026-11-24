# I023 checklist: annotate batch A1 (boot, NMI, main loop, scheduler)

Plan: `c:\Users\azare\.cursor\plans\blazer_docs_and_analysis_e740ea3f.plan.md`, step PC for batch A1. Source of the routine table: `plans/doc-audit/function-map/FM-A1.md` (rows R01-R52, written in I005 for the old file `engine_000000`; the regroup waves split it into five files).

Rules for this iteration: names only through `npm run names`, notes and comments only through `npm run merge`, both dry-run first; no ad-hoc scripts; no commit; the original ROM is not compared with the rebuilt ROM; the rebuilt SHA-1 must stay `3148390ed40ce14060b33c1387303a8a77e7a0c1` (annotation only, no regroup).

## Files of A1 (all in `extracted/system/`)

| File | FM-A1 rows |
|------|------------|
| `engine_boot_main_loop.asm` | R01-R04 |
| `engine_unreferenced_code.asm` | R05-R12 (and `code_0074B1`, not an A1 row; left alone) |
| `engine_vblank_nmi.asm` | R13-R23 |
| `engine_scheduler_sprites_combat_collision.asm` | R24-R47 |
| `engine_spawn_lairs_death_drops.asm` | R48-R52 (the rest of the file belongs to A2) |

## Checklist

- [x] Read: FM-A1, the five files, the callee heads named in FM-A1, `docs/walkthrough/items.md`, the crosswalk rows, I005 and I022 questions
- [x] Baseline: fresh `npm run extract:lt`, `npm run rebuild`, SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`
- [x] Names spec `plans/extracted-audit/renames/apply-I023_names.json` (R01-R52 plus the sub-labels that the notes refer to)
- [x] `npm run names -- <spec> --dry-run`, then apply, then `npm run extract:lt`; check `us/config.json` vector names
- [x] Merge spec `plans/extracted-audit/edits/I023.json`: 5 block notes, part notes (In / Out / clobbers + when, what the player sees, why), sparse comments with `expect` guards
- [x] `npm run merge -- <spec> --dry-run`, then apply, then `npm run extract:lt`
- [x] Mnemonics: `us/mnemonics.json` for the names with evidence; evidence sentences in `docs/wram-memory-map.md`
- [x] Gate: `npm run extract:lt`, `npm run rebuild` (SHA-1 unchanged), `npm run names -- --check`, `npm run merge -- --check`
- [x] `plans/extracted-audit/questions/I023_questions.md` (new `OQ-I023-k` rows only)
- [x] `plans/extracted-audit/results/I023_results.md` with a suggested commit message (the user commits)

## Progress

- Read phase done. FM-A1 is the routine table; names that clash with other batches were checked (`UploadScrollStrips` belongs to A4 `code_01057D`, so R19 gets another name; `SpawnLairMonster` belongs to A2 `code_0028ED`, so R52 is `SpawnLairActor`).
- Names: 92 rows applied (all additions in `us/names/bank00.json`); the tool rewrote references in `docs/`, `us/blocks.json` and `us/config.json` (vector names). SHA-1 unchanged.
- Merge: 5 block notes, 92 part notes, 133 comments applied (one `expect` guard fixed: address 2976 became 2977). SHA-1 unchanged.
- Mnemonics: 27 new entries in `us/mnemonics.json` (one is the `joy_pressed+1` high byte). `docs/wram-memory-map.md` has new rows and a section 7b. SHA-1 unchanged.
- Gate passed. Questions `OQ-I023-1` to `-5` written; results file written. Nothing committed.
