# I016 results: PB2, R-2 and the regroup spike

Date 2026-11-21. Scope: resolve the bank-base idiom hazard (R-2) with Mesen2, run one regroup through `npm run blocks`, decide go or no-go. The original ROM was never compared with a rebuilt ROM; the baseline for every comparison is the build before the step.

## Changed in the project

| File | Change |
|------|--------|
| `us/transforms.json` | rule on the animation routine: `LDA \$&meta_tables_008000, Y` becomes `LDA $$8000, Y` (the false R-2 reference). The merge moved the rule to the key `lib_animation` |
| `us/blocks.json` | by `npm run blocks`: `meta_tables_008000` pinned (`movable` removed, now `?BANK 01`); `lib_01065B` + `lib_0106CD` merged into `lib_animation` (group `library`, `movable: true`) |
| `docs/cop/index.md` | rows for COP 92 and 94 now name `code_01065B` and `code_0106CD` in block `lib_animation` (the merge rewrote the block names; prose fixed by hand) |
| `plans/doc-audit/README.md` | gate value updated |
| `plans/doc-audit/placement/spike-decision.md` | new: decision, evidence, fallback |
| `plans/extracted-audit/edits/I016_blocks_01_pin_meta_tables.json`, `_02_spike_lib_animation.json` | applied |
| `plans/extracted-audit/edits/I016_blocks_03_fallback_cop_animation.json`, `_04_neutrality_probe.json` | dry-run only, not applied |
| `plans/extracted-audit/questions/I016_questions.md` | `OQ-I016-1` .. `-6`; closes `OQ-I015-3`, `OQ-I015-4`, `OQ-I008-3`; no row tagged DISCREPANCY |
| `plans/extracted-audit/results/I016_results.md` | this file |

No names, notes or comments were changed. The extracted tree was regenerated (`extracted/` shows as modified and 2 files removed by the merge).

## Findings

- **The baseline rebuild had a real bug.** `lib_01065B:18` read `0D:E490 + Y` instead of `0D:8000 + Y`. After a jump to Grass Valley (`$0318 = 0x0101`, 600 frames) the baseline spins in the animation tick (65,536+ entries, NMI 159); the fixed build enters it 522 times (NMI 463). The literal `$8000` is right for every animation bank: all 349 traced loads ran with DBR `$0D` (`table_068000`).
- **The other 34 reads are base-relative with DBR `$01`**: 81 traced reads from 20 engine PCs, all in `01:E490`-`01:E713`. `meta_tables_008000` may move inside bank 1 but not out of it; it is now pinned to bank 1.
- **`blocks-verify` does not see this dependence** (cross-bank 2-byte references with a run-time DBR); `OQ-I016-1`.
- **Spike**: `lib_animation` (150 bytes) was gap-filled by the packer from `02:E946` to `00:FDBA`. Text identical for all 6,047 top-level labels, 0 undefined, 0 broken banks. `compare_runs` over the 3,677 recorded frames (five watches): identical. Counts after the jump: 522 entries, 463 NMI, same as the baseline.
- **`set group` and `set scene` are byte-neutral; `set movable` and `merge` are not.**
- **Decision: GO** with three conditions (pin DBR-relative tables, movable only for bank-agnostic blocks, Mesen2 per wave). Fallback (pinned multi-part blocks and `order`) proven by a dry-run of `cop_animation`.

## Builds

| Build | SHA-1 | Meaning |
|-------|-------|---------|
| B0 | `65ff27aaf7ae15537351f5eace690193813a5556` | start of I016 (I001-I015 gate) |
| B1 | `f20dcbdf1443876c0972f251c4b79a70440950a3` | plus the R-2 transform (two bytes) |
| B2 | `6224eaf97d703ab67d6709c2aa88470fcf6d0f34` | plus the bank-1 pin of `meta_tables_008000` (`01:B481`) |
| B3 | `fdafd6c9ddf6b153ad74c6ad8bd8fc2a20991de3` | plus `lib_animation` movable: **the new gate value** (1,081,344 bytes, checksum 110119158) |
| dry-run | `0c8748f65740...` | `cop_animation` merge (not applied) |

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK (fresh before each build; 703 files) |
| `npm run rebuild` | OK, SHA-1 `fdafd6c9ddf6b153ad74c6ad8bd8fc2a20991de3`, 1,081,344 bytes. The change from `65ff27aa` is expected (R-2 fix and regroup) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | OK: 0 errors, 0 warnings, 0 orphans (0 comments, 26 part notes, 4 block notes, 703 extracted files) |
| `npm run blocks` verify | text 6,047 of 6,047 labels identical for both applied specs; 0 undefined references; 0 broken bank guarantees |
| `npm run audit` | R-2 findings fall from 5 blocks (`meta_tables_008000` included) to 4: `spc_030000` (1), `data_04F000` (5), `asset_list_028000` (1), `string_lookup_080000` (2) |
| Mesen2 | `compare_runs` B1 vs B3, 3,677 frames, 0 divergent frames; counts and registers equal after the Grass Valley jump |

`git status` shows `extracted/` as modified because the line-tracked extraction was run last; run `npm run extract` if the tracking annotations should not be committed.

## Suggested commit message

```
PB2: resolve R-2, regroup spike (I016)

Fix the false bank-base reference in the animation frame-advance routine
(transforms.json: LDA $8000, Y; the baseline rebuild read the wrong table
and spun in the animation tick in Grass Valley). Pin meta_tables_008000 to
bank 1 (DBR-relative reads). Merge lib_01065B + lib_0106CD into the movable
block lib_animation. Add placement/spike-decision.md (go with conditions,
fallback), I016 edit specs, questions and results. Rebuilt SHA-1 changes
65ff27aa -> fdafd6c9 (expected); text identical for all 6,047 labels.
```

Please commit when you're ready.
