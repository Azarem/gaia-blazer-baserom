# I060 results: final audit

Step "Final audit" of the plan "Blazer docs and analysis". ROM unchanged (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`). No note, name, comment, block, override, doc or script was changed; no `merge`, `names` or `blocks` spec was needed. **No experiment was run.**

## What was written

| File | Action |
|------|--------|
| `plans/doc-audit/final-audit.md` | new: gate, baseline against now, the orphan and generic-name sweeps, files without a block note, docs without sources, 17 prioritized follow-ups, method |
| `plans/extracted-audit/questions/I060_questions.md` | five rows (audit metric, `spc-disassembly.md` and its stale scripts, the R-2 count, the missing block note and source line, the plan file front matter) |
| `plans/extracted-audit/results/I060_results.md` | this file |

## Findings in short

- **The gate is green.** `names --check` 2765 names, `merge --check` 0 errors, 0 warnings, 0 orphans, 0 duplicates; the audit has one finding (the R-2 hazard, now 9 two-byte references into four movable blocks).
- **No orphans.** 8,256 labels, 2,765 names: every name is a label, every non-generated label has a name, all 992 offset-suffixed names carry the right hex, no doc link is broken, no doc cites a label that does not exist (one stale file name: `chunk_0FAA49.asm`).
- **Remaining generated names: 5,491 of 8,256 (66.5%)**, not the 6,454 (78.2%) of `npm run audit`: the audit counts 963 descriptive world names with an offset suffix as auto (OQ-I060-1). The 5,491 are 1,890 top-level `code_` routines inside world actors (23 blocks hold 1,680 of them, `gw_boss_light_water_fire_statues` alone 160 with one part note), 1,328 animation and table data labels in `system` (waiting for the struct decisions), 1,491 `loc_` branch targets and 650 `asciistring_` lines (leave).
- **Files without a block note: 1** (`gv_watching_over_world_texts`). Named labels without a part note: 766, of which 591 are rows of indexed series.
- **Docs without sources: `docs/areas-and-scenes.md` (no source line) and `docs/audio/spc-disassembly.md`.** The second one starts with four lines of tool log and cites a file that does not exist; the script that wrote it and a second one still read that file (OQ-I060-2). Every spoke, world page, the hub and the WRAM map have a source line.
- **Still open from earlier steps:** the P1 override `65803 {"M": 1}` (`BuildScrollStrips`, Q-TO-03) changes the SHA-1 and is your decision; 42 DISC rows await a spelling and value decision; the Mesen2 groups (EG-B first) have not been run; the recordings behind every comparison are not in the repository (Q-TO-11).
- **The work since `b32b31d` is uncommitted** (143 `extracted/` entries, `notes/`, `us/`, `docs/`, `src/`, `plans/`, `.cursor/rules/`).

## Gate

| Step | Result |
|------|--------|
| `npm run extract:lt` (fresh, at the start) | OK; stale files removed: 0 |
| `npm run rebuild` | OK; SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` (unchanged), 1,081,344 bytes, checksum 110070696; 27 known `Cross bank call detected` warnings |
| `npm run names -- --check` | OK (2765 names) |
| `npm run merge -- --check` | OK: 1401 comments, 1684 part notes, 135 block notes against 136 extracted files; errors 0, warnings 0, orphans 0, duplicate keys 0 |
| `npm run audit` | summary, `--blocks`, `--block=<name>` for every block and `--json` run; one finding (R-2) |

## Follow-ups

Prioritized list in `plans/doc-audit/final-audit.md` section 4. The first four:

1. Decide Q-TO-03 (the `BuildScrollStrips` override).
2. Commit the work in slices (tooling, `us/` + `notes/` + `extracted/`, `docs/`, `plans/`).
3. Repair `docs/audio/spc-disassembly.md` and add the source line to `docs/areas-and-scenes.md`; repoint or remove the two stale SPC scripts.
4. Add the block note of `gv_watching_over_world_texts` with `npm run merge`.

## Suggested commit message

```
docs: final audit of the Blazer documentation plan (I060)

plans/doc-audit/final-audit.md reports the gate (names and merge checks,
audit, orphan and generic-name sweeps), the remaining generated labels
(5,491 of 8,256, by group and kind), the one file without a block note,
the docs without a source line and a prioritized follow-up list.
I060_questions.md logs five new rows. No experiment was run. ROM unchanged.
```

Please commit when you're ready.
