# I059 results: Mesen2 question inventory (PQ consolidation)

Step "PQ - Consolidation" of the plan "Blazer docs and analysis". ROM unchanged (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`). No note, name, comment, block, override or doc changed. **No experiment was run.**

## What was written

| File | Action |
|------|--------|
| `plans/doc-audit/mesen2/question-inventory.md` | new, 569 lines: conventions, the mapping-plan carry-ins, 219 deduplicated rows in 15 tables, 25 experiment groups and queues, the settled rows, a run order |
| `plans/extracted-audit/questions/I059_questions.md` | four rows (fixtures location, legend and scale, stale `pinned.md` rows, unchecked mapping boxes) |
| `plans/extracted-audit/results/I059_results.md` | this file |

## Input and coverage

- Read: all 57 files of `plans/extracted-audit/questions/` (I001, I002, I004 to I058; I003 has no file), `plans/mapping/mapping-action-plan.md`, `spike-decision.md`, `pinned.md`, the I058 results, and the headings of `gaia-core/docs/notes-and-comments.md`.
- 560 distinct `OQ-Innn-k` ids are defined in the question files (`OQ-I032-11` and `-14` were retired in I032). Checked with a read-only `rg` and `awk` comparison of the ids in the "Absorbs" column and in the settled table against the ids defined in the question files: **0 missing, 0 duplicated** (the check found `OQ-I041-1` and `-2` in two rows; fixed in the file).
- 28 ids are settled by a later iteration and sit in section 5 of the inventory (for example `I005-5` by `I013-1`, `I015-1` and `I016-5` by `I017`, `I024-1`, `I025-2` and `I042-6` by `I056`). Five of them keep a runtime half as a row.
- The 532 open source ids were merged into 215 rows; the four new ids of this iteration add four rows (219 in all). The largest merges are boss HP (5 ids), the `$16` and `$1A` bit meanings (7), colour animation (10), VRAM layout (11), the dead code rows (up to 11 ids each).

## Counts

| Mode | Rows | | Priority | Rows |
|------|-----:|-|----------|-----:|
| ST (static queue) | 19 | | P1 | 1 |
| ST+RT | 102 | | P2 | 43 |
| RT | 79 | | P3 | 115 |
| DEC (decision queue) | 19 | | P4 | 60 |

Rows per experiment group: A 3, B 5, C 18, D 10, E 4, F 19, G 11, H 13, I 12, J 14, K 6, L 4, M 12, N 26, O 3, P1 4, P2 4, P3 2, P4 2, P5 3, P6 2, P7 1, P8 3, SQ 19, DQ 19.

The single P1 row is Q-TO-03: `us/overrides.json` lacks `"65803": {"M": 1}` for `BuildScrollStrips` (OQ-I026-1, OQ-I008-1). The fix changes the SHA-1, so it is your decision.

## Findings while consolidating

- The source files use two opposite mode legends and four priority scales; the inventory re-derives the mode from each "how to settle" text (OQ-I059-2).
- The recordings and savestates behind every comparison are not in the repository (OQ-I059-1).
- `OQ-I033-7` wrote dictionary entry `$09` for `Deathtole`; the extract and the block note say `$06`. No change needed, the inventory uses `$06`.
- `pinned.md` has four rows that predate `split-part` (OQ-I059-3); mapping boxes 1.11, 2.17 and 3.6 are done but unchecked (OQ-I059-4).
- `OQ-I058-1` is the same question as `OQ-I004-1`; they are one row (Q-BH-01) with `I004-1` as the canonical id, as the documents already cite it.
- Mapping items 1.8, 1.10, 2.8, 2.10, 3.7 and 3.9 are still open and are carried (section 2.1 of the inventory); 3.7 is experiment group B.

## Gate

| Step | Result |
|------|--------|
| `npm run extract:lt` (fresh, at the start) | OK; stale files removed: 0 |
| `npm run rebuild` | OK; SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` (unchanged), 1,081,344 bytes |
| `npm run names -- --check` | OK (2765 names) |
| `npm run merge -- --check` | OK: 1401 comments, 1684 part notes, 135 block notes; errors 0, warnings 0, orphans 0, duplicate keys 0 |

No `merge`, `names` or `blocks` spec was needed. The working tree still holds the uncommitted work of earlier iterations (many staged `docs/code/*` files and modified `extracted/*`); I did not touch or stage it.

## Follow-ups

- Answer Q-TO-03 (the P1 override) and OQ-I059-1 (fixtures) before any experiment.
- Run EG-B (the CDL session) first; it settles the five dead-code rows and most of the "never spawned / unreferenced" rows of the world passes.
- Fix the legend of the next preamble (OQ-I059-2).

## Suggested commit message

```
docs: add the Mesen2 question inventory (I059)

plans/doc-audit/mesen2/question-inventory.md merges the 560 open question
ids of I001 to I058 and the open mapping-plan items into 219 deduplicated
rows with normalised mode and priority, 25 experiment groups and queues
(setup, watches, expected observation, affected note or doc) and a run order.
No experiment was run. ROM unchanged.
```
