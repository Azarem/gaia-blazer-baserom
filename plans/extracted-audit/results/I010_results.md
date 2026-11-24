# I010 results: PA batch A6 (library `0124`-`0127`)

Date 2026-11-21. Scope: read-only analysis. No names, notes, comments, blocks, overrides or docs of the project were changed. One function-map document and this record pair were added.

The batch named "library 0127 and 0124-0126". There is no `lib_0127`; the `0127xx` range is the head of `lib_shared_012769`, which runs to `code_013169`. The five files read are `lib_shared_012416`, `lib_0124EE` (+ `lib_0124EE_part2`), `lib_0126CF` and `lib_shared_012769`.

## Added

| File | Purpose |
|------|---------|
| `plans/doc-audit/function-map/FM-A6.md` | 84 routine rows (23 top-level labels plus 61 sub-label entry points), the other 145 sub-labels as an inner-branch inventory (all 229 code labels are covered, offsets and sizes checked against the line-tracked extraction), 3 string rows and the external data the code reads; models for the BG3 text page, the two renderers, the control-code table, the dialogue box flow, name entry, the dictionary, the gauge bar, the staff roll and the wait helpers; structure layouts with the evidence for each field width; WRAM name proposals |
| `plans/extracted-audit/questions/I010_questions.md` | `OQ-I010-1` .. `OQ-I010-17` (1 tagged DISCREPANCY: dictionary entry `$06` `Deathtole` against `Deathtoll`) |
| `plans/extracted-audit/results/I010_results.md` | this file |

## Method

Fresh `npm run extract:lt`; every label of the five files read end to end; callers counted with `rg -w` over `extracted/`; every row offset and size compared with the `{n}` tags (no mismatch); the walkthrough chapters checked for the name entry, the HP bar colours, Deathtoll's HP and the credits; branch ladders traced by hand against the handler bodies.

## Findings

- **`$1B84` is the text delay in frames per printed glyph**, not `ending_flag` (FM-A2/FM-A4, conf C). Readers `code_013124`, `loc_012D90`, `loc_012F3B`; writers are the new-game init (3), the Deathtoll scene (6) and speech scenes (7, 1, 5, 4, 3). Width unresolved (byte read, word writes): OQ-I010-1.
- The text renderer (`code_012769`) and the dialogue renderer (`code_012C27`) share one control-code set (table in FM-A6 1.3); the differences (text state restore, `[0B]` skipped, `[0E]`/`[0F]`/`[10]`/`[11]`/`[12]` handled only in dialogue, `$03F3` resume) are listed there.
- Name entry: 8 characters at `$1B92-$1B99`, accepted while `Y < $1B9A` (answers OQ-I007-15), 13 x 5 letter grid, Start finishes, Y deletes, B picks, an empty name cannot finish. The walkthrough ("no default name") agrees.
- `$03F7` is the origin of the last choice window drawn by the menu renderer; `Cop02` and `Cop1A` erase it (answers OQ-I007-17); `$03F3` is the dialogue resume line start.
- Gauge bar: colour index `2 * floor(cur / 10)` before the clamp to 50, from `word_00FB2F` (13 words: dark blue below 50, then light blue, cyan-green, green, yellow, pale yellow, white from 100); this matches `level-up.md`. A `cur` of 130 or more indexes past the table (OQ-I010-5).
- DISCREPANCY: `string_lookup_080000` entry `$06` is `Deathtole`; the walkthrough and the dialogue strings say `Deathtoll`. The entry appears unused (OQ-I010-2).
- No M/X decode anomalies in the A6 files. No `overrides.json` rows are needed for them.
- Batch gap (unchanged from FM-A4): `lib_012281`, `lib_01232B`, `lib_shared_01230B`, `lib_shared_012390`, `lib_shared_0131B7` and library `0131`-`0132` have no batch.
- Placement proposals for PB are in FM-A6 7.3 (split `lib_shared_012769` at `code_012C27`; name entry with `Cop3A`; staff roll with `common_actor_00729D`; the wait helpers as system helpers).

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK, 0 stale files removed |
| `npm run rebuild` | OK, SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes (unchanged) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | OK: 26 part notes and 4 block notes against 704 extracted files, 0 errors, 0 warnings, 0 orphans |

`extracted/` shows as modified in `git status` only because it holds the line-tracked extraction. The other modified or untracked paths (`package.json`, `src/`, `.cursor/rules`, the other `plans/` files) come from earlier iterations, not from this step.

## Suggested commit message

```
docs(blazer): function map FM-A6 for library 0124-0127 (I010)

Add the function map for batch A6 (84 routine rows, 145 inner labels,
3 string rows, structure layouts), 17 open questions (1 DISCREPANCY) and
the results record. No names, notes, db files or ROM bytes changed.
```

Please commit when you're ready.
