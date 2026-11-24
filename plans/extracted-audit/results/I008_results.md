# I008 results: PA batch A4 (library `0100-0111`)

Date 2026-11-21. Scope: read-only analysis. No names, notes, comments, blocks, overrides or docs of the project were changed. One function-map document and this record pair were added.

## Added

| File | Purpose |
|------|---------|
| `plans/doc-audit/function-map/FM-A4.md` | 42 routine and data rows (L001-L042) for the 24 files `lib_010000` .. `lib_shared_01112A`: offset, size, callers, proposed subsystem, proposed name with confidence and evidence, inputs, outputs, clobbers, data touched; six shared models (maps and slabs, camera and strip streaming, palette-style frame records, triggers, lair release, sweep redraw), structures (layer parameter block, strip buffer, chest, exit and plate rows, frame record, `binary_016E2D`, the 53 NPC names), WRAM proposals, findings |
| `plans/extracted-audit/questions/I008_questions.md` | `OQ-I008-1` .. `OQ-I008-15` (1 tagged DISCREPANCY, against the walkthrough) |
| `plans/extracted-audit/results/I008_results.md` | this file |

## Method

Fresh `npm run extract:lt` tree. Read all 24 `extracted/library/lib_*` files of the range end to end, plus the callees and callers they depend on (`lib_shared_0131D1`, `lib_027462_part1/part2`, `lib_0272E6`, `lib_0273A2`, `lib_027348`, `lib_027374`, `lib_0276A5`, `lib_027912`, `lib_0133A6_part3`, `lib_017504`, the four `Cop92`-`Cop95` handlers, `engine_000000`, `engine_003005`, `table_058000`, `table_068000`, `data_00BA0D`, `table_00A9DE`, `table_00AC96`, `table_00B69A`). Field widths of `data_00BA0D` were measured over its 420 rows. Game names and facts were checked against `docs/walkthrough/` (chapters 02, 03, 04, 06).

## Findings

- **Decode anomalies in `us/overrides.json`:** `code_01010B` (65803) needs `"M":1` (the current extract is nonsense and hides two `JSR`s); the existing `"67277": {"M":1}` is wrong for `code_0106CD`, which needs M = 0 (OQ-I008-1, -2). Not applied here.
- **False reference:** `$&meta_tables_008000` in `code_01065B` is `$8000` read under `DBR = $24,X`, so the reference (and the `?INCLUDE` in five files) is an artefact (OQ-I008-3).
- **Frame records of `Cop92`-`Cop95` are palette data** (destination `cgram_buffer`), which corrects FM-A1 4.1 for those actors and answers OQ-I007-24 in part (OQ-I008-4, -5).
- **Camera pipeline:** camera delta, parallax (`A * low / high` with the hardware multiply and divide), scroll clamp, strip request bits `$0396`, strip buffers at `$7E:3000..`, NMI DMA on channel 2; the per-layer parameter block (stride 4) is set at boot by `lib_027912`.
- **Metatile maps:** BG1 ids at `$7E:8000` (answers OQ-I006-23 from A2), BG2 ids at `$7E:C000`, definition tables at `$7E:2000/$2800`, bit 9 of a definition word is the per-quadrant solid flag.
- **Triggers:** one per-frame chain in `code_0109D6` (exit tile `$FE`, plates, chests, exits). **Lair release:** `code_010C25` with or without a rectangle, return trip only for a no-rectangle record whose host is another location, `code_010EA9` in the host location, 35-step sweep redraw (`binary_016E2D`).
- **Dead or suspicious code:** the discarded slab loop in `code_010DBD`; the hang guards (L031-L033) never trip for the current table (OQ-I008-10); `unk14_017504` records are 8 bytes.
- **Batch gap:** library files `0112-0116`, `0122-0123` and `0131-0132` (16 files) belong to no batch of the plan.
- **DISCREPANCY (OQ-I008-14):** `Wood s guardian`, `a model of town`, `Dr-Leo`, `The village Chief` against the walkthrough wording; glyph printing is OQ-I008-15. The ROM spelling `recieved` is kept as ROM truth.

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK, 0 stale files removed |
| `npm run rebuild` | OK, SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes (unchanged) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | OK: 26 part notes and 4 block notes against 704 extracted files, 0 errors, 0 warnings, 0 orphans |

`extracted/` shows as modified in `git status` only because it holds the line-tracked extraction; earlier iterations left it in the same state.

## Suggested commit message

Please commit when you're ready.

```
Add PA batch A4 function map (library 0100-0111)

FM-A4: 42 rows (24 files) with proposed names, contracts, camera and
strip-streaming, frame-record, trigger, lair-release and sweep models,
structures and WRAM proposals. I008: 15 open questions (1 DISCREPANCY
vs the walkthrough, 2 override corrections). No name, note, comment or
db change; SHA-1 unchanged.
```
