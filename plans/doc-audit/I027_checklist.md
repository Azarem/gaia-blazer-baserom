# I027 checklist: annotate batch A5 (library `0118`)

Plan: `c:\Users\azare\.cursor\plans\blazer_docs_and_analysis_e740ea3f.plan.md`, step PC for batch A5 (`FM-A5.md`). Core code, so full depth (not the light actor depth). Annotation only: no regroup, no code change.

Rules for this iteration: names only through `npm run names`, notes and comments only through `npm run merge`, both dry-run first; hand edits only in `us/mnemonics.json`, `us/overrides.json` (M flag), `docs/wram-memory-map.md` and the one-word wording fixes of `docs/cop/index.md` if the names tool does not reach them; no ad-hoc scripts; no commits; the original ROM is never compared with the rebuilt ROM. The walkthrough is the source of truth for game names (`items.md`, `magic.md`, `level-up.md`, `01-in-the-beginning.md`), the ROM text for exact spelling.

## Where the A5 rows live now (after the PB3 regroup)

| File | A5 content | Block note |
|------|------------|------------|
| `extracted/library/lib_system_helpers.asm` | HDMA channel queue (L001-L005), NMI pair (L058, L059), `WaitVBlank` (named here because every A5 routine calls it), `code_01318C` (not an A5 row, batch gap) | new |
| `extracted/library/lib_arithmetic.asm` | `DivideWordByByte` (L060), `ByteToPackedBcd` (L061), `Multiply8x8` (named here, used by L017); `code_0131FE`, `code_01320E`, `code_013246` are batch gaps | new |
| `extracted/library/lib_menus.asm` | L006-L045, L049-L052, L057, strings D01-D23 and the 65 description strings, tables | new |
| `extracted/library/lib_0118FC_part2.asm` | row chooser (L046-L048) | new |
| `extracted/library/lib_0118FC_part5.asm` | palette and graphics handoff (L053-L055) | new |
| `extracted/library/lib_0118FC_part6.asm` | HUD and enemy gauge (L056) | new |
| `extracted/system/engine_boot_main_loop.asm` | wording that cites `code_0118FC`, `code_012659`, `code_0131B7`, `code_01185E` (rewritten by `names`, then edited by `merge`) | edited |

## Checklist

- [x] Read: `notes-and-comments.md` (Merge, Names, Comment Authoring Guide), `code-bank-documentation.md` (§4), `mapping-action-plan.md` (§0, §8c-8e), `plans/doc-audit/README.md`, `FM-A5.md`, `I009_questions.md`, the I026 records (template), the walkthrough chapters `01-in-the-beginning.md`, `items.md`, `magic.md`, `level-up.md`, and all six A5 files end to end
- [x] Baseline: fresh `npm run extract:lt`, `npm run rebuild`, SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`
- [x] Re-check the FM-A5 claims against the code (HUD skip range, enemy gauge timer, `WaitFrameKeepClock`, facing codes); record every correction
- [x] Names spec `plans/extracted-audit/renames/apply-I027_names.json`; `--dry-run`; apply; `npm run extract:lt`
- [x] Override `71774` `M: 1` (`ResetHdmaQueue` is mis-decoded: `LDA #$8510; MVP` are really `LDA #$10; STA $44; LDA #$40`); check the SHA-1 is unchanged, else revert and ask
- [x] Mnemonics in `us/mnemonics.json` for the A5 WRAM that prints (`$03C0-$03C4`, `$03C6`, `$042F`, `$0435`, `$045A-$0460`); `docs/wram-memory-map.md` section 7f; `npm run extract:lt`
- [x] Merge spec `plans/extracted-audit/edits/I027.json`: 6 block notes, part notes (When, Sees, Why, In, Out, Clobbers), sparse comments with `expect` guards, wording fixes in the engine notes
- [x] `npm run merge -- <spec> --dry-run`; apply; `npm run extract:lt`; read the extracted files as a consumer would
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 unchanged), `names -- --check`, `merge -- --check`
- [x] `plans/extracted-audit/questions/I027_questions.md` (new rows `OQ-I027-k`; the open `OQ-I009-*` rows stay valid and are cited by ID)
- [x] `plans/extracted-audit/results/I027_results.md` with a suggested commit message
- [x] Left for the user: commit; decisions in the questions file

## Progress

- Names: 151 rows applied (dry-run clean first); 526 names now.
- Override 71774 M:1 and 14 mnemonics added by hand. The first full gate gave SHA-1 `4802dc2f...`; bisecting found the `player_name` mnemonic (a name inside the pointer table `binary_list_014789` changes the assembled bytes). Removed; SHA-1 back to `3148390e...`.
- Merge: dry-run clean, applied; the six engine block-note `edit` operations were removed from the spec after the first run so it can be re-run (second run: all unchanged).
- Final gate: extract:lt OK, rebuild SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, names --check OK (526), merge --check 0 errors, 0 warnings, 0 orphans.
- Questions `OQ-I027-1` to `-4` and results written. Nothing committed; the user commits.
- Note: one-off `node -e` commands were used to bisect `us/overrides.json` and `us/mnemonics.json` (both restored); reported in the results file.
