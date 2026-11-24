# Baseline (P0, iteration I003, 2026-11-19)

Measured on the project as committed (no names, notes or blocks changed by P0), from a fresh `npm run extract:lt`. Full report: [`baseline-audit.txt`](baseline-audit.txt) (`npm run audit -- --top=25`).

## Gate values

| Item | Value |
|------|-------|
| `npm run rebuild` | SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes, checksum 110102861 |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | 0 errors, 0 warnings, 0 orphans, 0 duplicate keys; 0 comments, 26 part notes and 4 block notes checked against 704 extracted files |
| `us/blocks.json` | 704 blocks in 11 groups, 789 parts; 6 movable blocks (`meta_tables_008000`, `asset_list_028000`, `spc_030000`, `data_048000`, `data_04F000`, `string_lookup_080000`) |
| Non-contiguous blocks | 1: `data_048000` (gap 295424 to 296960), movable. Every non-movable block is contiguous |

## Coverage

| Group | Blocks | Lines | Instr | Top labels | Sub-labels | Auto-named | Block notes | Part-note labels | Commented instr |
|-------|-------:|------:|------:|-----------:|-----------:|-----------:|------------:|-----------------:|----------------:|
| common | 125 | 18,420 | 11,143 | 1,500 | 821 | 100.0% | 0 | 0 | 0 |
| cop_handlers | 110 | 2,918 | 1,636 | 119 | 104 | 51.6% | 1 | 4.5% | 0 |
| grass_valley | 52 | 2,952 | 1,431 | 399 | 41 | 100.0% | 0 | 0 | 0 |
| greenwood | 57 | 3,340 | 1,672 | 421 | 32 | 100.0% | 0 | 0 | 0 |
| leos_lab | 37 | 1,747 | 810 | 242 | 22 | 100.0% | 0 | 0 | 0 |
| library | 139 | 13,161 | 8,286 | 668 | 743 | 100.0% | 0 | 0.1% | 0 |
| magridds_castle | 45 | 2,333 | 1,194 | 307 | 15 | 100.0% | 0 | 0 | 0 |
| mountain_of_souls | 42 | 2,589 | 1,306 | 271 | 59 | 100.0% | 0 | 0 | 0 |
| st_elles | 54 | 2,994 | 1,551 | 328 | 60 | 100.0% | 0 | 0 | 0 |
| system | 36 | 16,699 | 4,087 | 1,771 | 307 | 100.0% | 3 | 0.7% | 0 |
| world_of_evil | 7 | 593 | 282 | 21 | 5 | 100.0% | 0 | 0 | 0 |
| **Total** | **704** | **67,746** | **33,398** | **6,047** | **2,209** | **98.7%** | **4** | **0.3%** | **0** |

8,256 labels (6,047 top-level and 2,209 sub-labels); 8,147 auto-named (5,938 top-level and all 2,209 sub-labels); 109 labels with a name (`names --check` counts 111 entries; the 2 entries without a label of their own are not investigated here). 4 block notes, 26 part notes, 0 inline comments.

## Cross-file references

16,249 references: 12,718 inside a file, 3,531 across files (1,514 file pairs).

Group to group (rows reference columns; the diagonal is between two files of one group):

| from \ to | common | cop_handlers | grass_valley | greenwood | leos_lab | library | magridds_castle | mountain_of_souls | st_elles | system | world_of_evil |
|---|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|
| common | 35 | . | . | . | . | 107 | . | . | . | 309 | . |
| cop_handlers | 1 | 151 | . | . | . | 35 | . | . | . | 42 | . |
| grass_valley | . | . | 141 | . | . | 11 | . | . | . | 22 | . |
| greenwood | . | . | 20 | 130 | . | 9 | . | . | . | 33 | . |
| leos_lab | . | . | 3 | . | 69 | 5 | . | 6 | . | 25 | . |
| library | 1 | . | . | . | . | 414 | . | . | . | 197 | . |
| magridds_castle | . | . | 2 | . | . | 6 | 110 | 11 | . | 37 | . |
| mountain_of_souls | . | . | 2 | . | . | 5 | . | 94 | . | 45 | . |
| st_elles | . | . | 4 | . | . | 8 | . | . | 104 | 48 | . |
| system | 230 | 109 | 42 | 50 | 35 | 100 | 41 | 39 | 54 | 577 | 6 |
| world_of_evil | . | . | . | . | . | 3 | . | . | . | . | 3 |

Top fan-in files (references from other files / referencing files): `engine_0026F3` 567 / 138, `engine_routines_001D3B` 273 / 1, `cop_handler_006473` 140 / 102, `w0_shared_01B988` 106 / 35, `w1_shared_01EBC2` 101 / 38, `w2_shared_0FA945` 94 / 42, `w5_shared_02706C` 90 / 34, `lib_shared_012769` 82 / 18, `w3_shared_02249A` 80 / 34, `lib_shared_014F74` 73 / 4, `data_00BA0D` 71 / 10, `table_068000` 69 / 1.

Top fan-in labels: `code_0026F3` 156, `code_00299D` 150 (from 137 files), `code_00271B` 139, `code_002752` 107, `asciistring_01B988` 106, `asciistring_01EC46` 95, `asciistring_0270DF` 87, `code_001D3B` 80, `asciistring_02251E` 75, `asciistring_list_014F74` 73, `data_00BA0D` 71, `asciistring_0FAA44` 70, `table_068000` 69, `loc_0064BF` 68 (from 66 files).

## Findings

- **R-2 (bank-base hazard) is quantified:** 2-byte references from other files target movable blocks: `meta_tables_008000` (35 references from 7 files), `data_04F000` (5), `string_lookup_080000` (2), `spc_030000` (1), `asset_list_028000` (1). These are the references whose bank the packer decides; the `blocks` tool's bank check refuses to make a further block movable when short references reach it.
- **Plan figure corrected:** the plan quotes `engine_routines_001D3B` fan-in 264; the audit counts **273** (80 on `code_001D3B` and the rest on the block's other labels). A grep of `engine_routines_001D3B.` qualified references agrees with 273. The other fan-in figures of the plan match (`engine_0026F3` 567, `w*_shared_*` 64 to 106 each).
- No block without a file, no file without a block, no duplicate labels, no dangling `?INCLUDE`, no closure gap.
- Documentation state: only `system` (3 of 36 blocks) and `cop_handlers` (1 of 110) have block notes; `library`, `common` and the world groups are 100% auto-named.

## How the numbers were checked

`audit` was verified against the plan's figures and with greps of the qualified references (`block.label`) in `extracted/`. Fan-in of string data counts the `[JMP:...]` references on the label line of data units (106 for `asciistring_01B988`), which is why the world-shared string lines top the list.
