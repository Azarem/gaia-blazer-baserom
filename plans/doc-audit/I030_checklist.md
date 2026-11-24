# I030 checklist (PC annotate A8, library `014F`-`0175`)

## Progress

- [x] Read the conventions, `FM-A8.md`, the extracted files of every A8 row and their callers
- [x] Verify by code and `rg`: the 27 `COP [1A]` uses and option counts, the six return-prompt scripts, the chooser flow, the item names against `items.md`, the staff roll counts (`[N]`, `[14:n]`), the `COP [10]` / `COP [31]` end chain
- [x] Names spec `renames/apply-I030_names.json` (90 rows): dry-run, apply, `extract:lt`, `names --check`
- [x] Merge spec `edits/I030.json`: block notes, part notes, comments with `expect`: dry-run, apply
- [x] Follow-up `edits/I030b.json` (flag `$1B00` found, walkthrough mention of 'move on'): dry-run, apply
- [x] `docs/wram-memory-map.md` example label
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 unchanged), `names --check`, `merge --check`
- [x] Questions `OQ-I030-1` to `-4`
- [x] Results `results/I030_results.md` with the suggested commit message (nothing committed)
- [x] Mnemonics: none added (no new evidence)
- [x] No actor in the batch, so the light actor depth was not needed
