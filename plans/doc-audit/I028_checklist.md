# I028 checklist: annotate batch A6 (library `0124`-`0127`)

Plan: `c:\Users\azare\.cursor\plans\blazer_docs_and_analysis_e740ea3f.plan.md`, step PC for batch A6 (`FM-A6.md`). Core code, so full depth; no actor in this batch. Annotation only: no regroup, no code change.

Rules for this iteration: names only through `npm run names`, notes and comments only through `npm run merge`, both dry-run first; hand edits only in `us/mnemonics.json` and `docs/wram-memory-map.md`; no ad-hoc scripts; no commits; the original ROM is never compared with the rebuilt ROM. The walkthrough is the source of truth for game names, the ROM text for exact spelling.

## Where the A6 rows live now (after the regroup)

| File | A6 content | Block note |
|------|------------|------------|
| `extracted/library/lib_shared_012416.asm` | menu BG2 graphics and palette loaders | new |
| `extracted/library/lib_name_entry.asm` | name entry screen and its three strings | new |
| `extracted/library/lib_0126CF.asm` | staff roll scroller | new |
| `extracted/library/lib_text_render.asm` | `PrintTextString`, `ShowDialogueText`, helpers, wait helpers, text lists | new |
| `extracted/cop_handlers/cop_items_stats_text.asm`, `extracted/system/engine_boot_main_loop.asm`, `extracted/system/engine_spawn_lairs_death_drops.asm` | wording that cited the renderer or `$1B84` | edited |

## Checklist

- [x] Read: `notes-and-comments.md`, `code-bank-documentation.md`, `mapping-action-plan.md`, `plans/doc-audit/README.md`, `FM-A6.md`, `I010_questions.md`, the I027 records (template), the walkthrough chapters `01-in-the-beginning.md` and `level-up.md`, and the four A6 files end to end
- [x] Baseline: fresh `npm run extract:lt`, `npm run rebuild`, SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`
- [x] Re-check the FM-A6 claims against the code (gauge operands, `[09]` order, 8 KB, caller names); record every correction
- [x] Names spec `plans/extracted-audit/renames/apply-I028_names.json`; `--dry-run`; apply; `npm run extract:lt`
- [x] Mnemonics in `us/mnemonics.json` for the A6 WRAM that prints; check that none is a pointer-table operand; SHA-1 unchanged
- [x] Merge spec `plans/extracted-audit/edits/I028.json`: 4 block notes, 95 part notes, 77 comments with `expect` guards, wording fixes
- [x] `npm run merge -- <spec> --dry-run`; apply; `npm run extract:lt`; read the extracted files as a consumer would
- [x] `docs/wram-memory-map.md` section 7g; section 8 updated
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 unchanged), `names -- --check`, `merge -- --check`
- [x] `plans/extracted-audit/questions/I028_questions.md` (new rows `OQ-I028-k`; `OQ-I010-*` rows stay valid)
- [x] `plans/extracted-audit/results/I028_results.md` with a suggested commit message
- [x] Left for the user: commit; decisions in the questions file

## Progress

- Names: 95 rows applied (dry-run clean first); 621 names now.
- Mnemonics: 11 entries added; SHA-1 unchanged.
- Merge: dry-run clean, applied; the four `edit` operations were removed from the spec after the first run (second run: all unchanged).
- Final gate: extract:lt OK, rebuild SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, names --check OK (621), merge --check 0 errors, 0 warnings, 0 orphans.
- Questions `OQ-I028-1` to `-4` and results written. Nothing committed; the user commits.
