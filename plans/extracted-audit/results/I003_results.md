# I003 results: P0 tooling (`npm run audit`, `npm run blocks`), baseline

Date 2026-11-19. Scope: new tools, documentation, baseline. No names, notes, comments or blocks of the project were changed.

## Added

### Code (`gaia-blazer-baserom/src/`)

| File | Purpose |
|------|---------|
| `asm-index.ts` (new) | shared parser of the extracted `.asm` tree: units, labels (top-level and sub-labels), cross-file references classified by form (`short`, `long`, `bank`, `rel`), `?INCLUDE` lists, auto-label pattern, canonical per-label text for comparisons |
| `audit.ts` (new) | `npm run audit`: read-only coverage and reference matrix (below) |
| `blocks-verify.ts` (new) | scratch-folder extract and rebuild before and after a regroup, text/rebuild/include/bank checks |
| `blocks-edit.ts` (new) | `npm run blocks`: spec parsing, the four operations, canonical `blocks.json` writer, note-key and text rewrite, atomic write |
| `index.ts`, `package.json` | `audit` and `blocks` commands and scripts |

### `npm run audit`

Per group, block and label: block note, part-note and inline-comment coverage, auto-named labels still left; the cross-file reference matrix (group to group, file to file with `--matrix`), the top fan-in labels and files, and findings (blocks without file, files without block, duplicate labels, wrong `block.label` qualifiers, dangling `?INCLUDE`, closure gaps, 2-byte references into movable blocks). Flags: `--blocks [--group=<g>]`, `--block=<name>`, `--matrix`, `--top=N`, `--json=<path>`. Read-only (only `--json` writes).

### `npm run blocks -- <spec.json> [--dry-run]`

Operations `merge`, `move-part` (with `create` for a new block), `rename`, `set` (`scene`, `group`, `order`, `movable`, `createGroup`). Validation before any write: structure (names, overlaps, bank crossing, non-movable in one bank), then an in-process extract and rebuild of the current and the new layout in a scratch folder: asm text of every label unchanged, no label lost or created, rebuild OK (0 undefined references), `?INCLUDE` closure consistent, and 2-byte references keep their bank guarantee (same file, or both blocks pinned to one bank; a cross-file target keeps its pin). Writes `us/blocks.json` (project format), `us/transforms.json` when a list moves, `notes/blockNotes/bankNN.json` (key moves with the block), and rewrites whole-word block names in notes text, `docs/`, `baserom/` and `us/*.json`. Merge rewrites mentions of absorbed block names to the target.

### Documentation

- `gaia-core/docs/notes-and-comments.md`: the "Future Improvement: Block Audit Report" section is replaced by §"Implemented: Audit Report (`npm run audit`)" and §"Implemented: Blocks Merge (`npm run blocks`)".
- `gaia-core/docs/rom-mapping-guide.md`: new §9.3a "Measuring and regrouping with `audit` and `blocks`" (Phase 9).
- `.cursor/rules/no-adhoc-scripts.mdc` (Blazer): names `blocks` and `audit` next to `merge` and `names`.
- `plans/doc-audit/`: `README.md` (rules, tools, gate), `baseline.md`, `baseline-audit.txt`, and `function-map/`, `placement/`, `mesen2/` with a README each.

## Tests (on a copy of the project; the real `us/`, `notes/` and `docs/` were not changed)

Copy: `%TEMP%\blazer-copy` with the project folders and a `node_modules` junction. After each applied spec: `extract:lt`, `rebuild`, `merge --check`, `names --check`. The SHA-1 printed by the real rebuild equalled the SHA-1 the dry-run predicted in every case.

| Case | Result |
|------|--------|
| `merge` `lib_010000` + `lib_010069` | dry-run OK (6047/6047 labels identical, 0 undefined, 0 broken banks); applied; `blocks.json` diff is exactly the merged block (the writer reproduces the committed format byte for byte); SHA-1 changes `65ff27aa` to `af7e051c` as predicted; checks OK; re-applying is refused ("block(s) not found ... a merge cannot be applied twice") |
| `move-part` `code_010069` to a new block `lib_010069` (`create`), `rename` `lib_01010B_part3`, `set scene` on two blocks, `set order` | applied; SHA-1 returns to `65ff27aa...` (the split undid the merge); checks OK; stale files swept |
| `rename` `engine_0064F8` (has a block note) + `set group` into a new group (`createGroup`) | applied; note key moved and re-sorted, mention in `docs/cop/index.md` rewritten; SHA-1 unchanged; checks OK |
| `merge` of two blocks that both have a block note | refused without `"notes": "join"`; with it, notes joined, mentions in `docs/cop/index.md` and `docs/wram-memory-map.md` rewritten to the target; SHA-1 as predicted; checks OK |
| `move-part` between two library blocks | first run refused: text of `code_011695` changed (only the padding of a trailing comment, caused by the shorter `block.` qualifier). Fixed in `canonicalUnitText` (padding before `;` is normalised); then dry-run OK, applied, checks OK |
| Negative: `set movable: true` on a block that short references reach | refused: 7 references lose their bank guarantee (named); the message was shortened and a first-difference line added to the text error |
| Negative: merge across banks, part into a block of another bank, emptying a block, name collision with a block or a part, missing block or part, unknown op or key, one-block merge, `set` without properties, unknown group, bad scene, disagreeing properties, two blocks with notes | each refused with a specific error; nothing written |

Fixed during testing: audit fan-in missed the `[JMP:]` references on data label lines (106 for `asciistring_01B988`); comment padding false positive (above); merge did not rewrite mentions of absorbed block names (now recorded like renames).

## Baseline

See [`plans/doc-audit/baseline.md`](../../doc-audit/baseline.md). Summary: SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556` (1,081,344 bytes); 704 blocks in 11 groups, 789 parts, 6 movable; 6,047 top-level labels and 2,209 sub-labels, 98.7% auto-named; 111 names, 4 block notes, 26 part notes, 0 comments; 3,531 cross-file references in 1,514 file pairs; `merge --check` 0 errors, `names --check` OK. Plan figure corrected: `engine_routines_001D3B` fan-in is 273, not 264. R-2 quantified: 44 two-byte references from other files target the 5 movable blocks that matter (`meta_tables_008000` 35).

## Gate (real project)

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK, 704 files |
| `npm run rebuild` | SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes (unchanged) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | 0 errors, 0 warnings, 0 orphans |
| `npm run blocks -- <spec> --dry-run` on the real project | OK, nothing written |

After the gate the committed plain tree was restored with `npm run extract` (only `extracted/.extract-state.json` timestamps differ).

## Limits and open points

- `blocks` cannot split a part or edit `files.json`; the first failing operation stops a run (fix and re-run).
- A regroup normally changes the ROM bytes (the packer orders by size); the tool reports old and new SHA-1 and requires a Mesen2 comparison to be done by the iteration that regroups.
- `names --check` counts 111 names, the audit finds 109 labelled names; not investigated (no impact on the tools).
- `tsc --noEmit` is not usable in this repo (no `@types/node`, pre-existing); the tools run natively on Node 24 type stripping.

## Suggested commit message

```
Add audit and blocks tooling, doc-audit baseline

- npm run audit: read-only coverage and cross-file reference matrix
- npm run blocks: merge/move-part/rename/set with scratch extract+rebuild verification
- plans/doc-audit: rules, baseline, I003 results
```

Please commit when you're ready (the code and plans in `gaia-blazer-baserom`, and `docs/notes-and-comments.md` plus `docs/rom-mapping-guide.md` in `gaia-core`).
