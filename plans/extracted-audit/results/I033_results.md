# I033 results (PC annotate batch A11, data and tables)

## Scope

The data blocks of function map `FM-A11`, now 20 files in `extracted/system/` (the old `meta_tables_008000`, `table_*`, `data_00F9F7`, `asset_list_*`, `spc_*`, `string_lookup_080000` and friends): the seven world meta lists, the scene placement, chest, exit and plate lists, the lair records and formations, the scene variant rules, the engine tables, the scene asset lists, the SPC driver block, the iris and icon tiles, the menu palettes and groups, the six animation banks and the dictionary.

## Depth

Data only: names, block notes and part notes. No comments and no mnemonics are possible (no instructions). Every part note has When / Sees / Why / In / Out / Clobbers (n/a for data); every block note gives the layout, counts and the readers.

## Counts

| | Before | After |
|-|-------:|------:|
| Names | 1362 | 1647 (+285 new, +2 renames of new names); new bank files `bank03` - `bank08` |
| Part notes | 694 | 754 (+60) |
| Block notes | 58 | 78 (+20) |
| Comments | 826 | 826 |
| Blocks renamed | - | 21 (19 + 2) to snake_case `data_*` |

Named: 8 meta lists, the scene placement index and its 97 lists, the chest pointers and 37 lists, the exit pointers and 96 lists (+ `ExitListUnreferenced`), the plate pointers and 6 lists, `LairRecords`, `FormationPointers`, `SceneVariantRules`, 16 engine tables, and the asset, SPC, iris, icon, palette, animation and dictionary blocks.

Left with auto names on purpose: 112 formation lists, 265 animation step lists and 951 frame leaves (OQ-I033-15). The 97 placement lists, 97 exit lists and 6 plate lists are named but have no part note of their own: the pointer or index table note covers them.

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK |
| `npm run rebuild` | OK, SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, unchanged |
| `npm run names -- --check` | OK (1647 names) |
| `npm run merge -- --check` | 826 comments, 754 part notes, 78 block notes; errors 0, warnings 0, orphans 0, duplicates 0 |
| `blocks` renames | byte-identical (dry-run verified) |

## Main findings

- **The record index is the switch number.** A lair record (32 bytes, 420 records) is a release record: bit n of `$1ADE`, the released array `$1A9E` and `lair_state` (`$7F0203 + n`) all use the record index. 417 records have scripts (156 + 139 + 107 + 8 + 7), 3 are pure switches (`$32`, `$74`, `$75`), 15 are filler records (location `$63`, type `$FF`).
- **Scene variants are boss lairs.** The 23 rows of `SceneVariantRules` use the six boss lair records (`$09`, `$50`, `$B6`, `$103`, `$12F`, `$195`) as their switch words, so rooms change after the boss lair is released. What changes is still music by inference (OQ-I033-13, extends OQ-I011-5).
- **Bank `$0D` is palette cycling, not VRAM copies** (OQ-I033-6, DISCREPANCY with FM-A4/FM-A11 and the same question as OQ-I026-3): 53 steps write the three COLDATA bytes. Bank `$0E` (`EffectAnims`, the puffs) and bank `$0F` (`MagicAnims`, the player spell scripts and the Phoenix shots) were named after their readers.
- **Meta entry layout** (14 bytes): attack, defence, HP (binary), EXP (BCD word), animation id, flags word, `Address` of the animation list (word table + bank), `@Code` script. 358 entries use `$7E3800`, 69 palette lists, 7 player animations, 4 effect animations, 31 `$000000`.
- **Exit list quirk:** the pointer of location `$5A` equals that of `$56`, and an empty list (`ExitListUnreferenced`) has no reader (OQ-I033-5).
- **Discrepancies with the walkthrough (never resolved by invention):** boss HP (OQ-I033-1: 69 / 79 / 89 / 99 vs 70 / 70 / 80 / 90; Deathtoll 99 + 100 vs 200), Purple Bull HP 45 vs 23 (-2), nine meta types that match no bestiary row (-3), world 4 type `$27` HP 24 vs Toy Calvary 29 (-4), dictionary 'Liesa' and 'Deathtole' vs 'Lisa' and 'Deathtoll' (-7).
- **Rename hazard:** the block `WorldMetaPointers` cannot become snake_case without changing the ROM, because `NextFrameRecord`'s `LDA $8000, Y` resolves to the label once the block is renamed (OQ-I033-14). It keeps its name.
- One stale sentence in the `lib_tile_triggers_and_lair_return` block note ("the part note of LairRecords is not written yet") was corrected with an `edit` entry (`edits/I033_fixes.json`).

## Files changed (not committed)

- `plans/extracted-audit/renames/apply-I033_names.json`, `apply-I033b_names.json`
- `plans/extracted-audit/edits/I033_blocks.json`, `I033b_blocks.json`, `I033.json`, `I033_fixes.json`
- `plans/extracted-audit/questions/I033_questions.md`, `plans/extracted-audit/results/I033_results.md`, `plans/doc-audit/I033_checklist.md`
- Tool output: `us/blocks.json`, `us/names/bank00.json` - `bank08.json` (new `bank03` - `bank08`), `src/names.ts` (imports), `us/transforms.json` and docs (reference rewrites by `names`), `notes/blockNotes|partNotes/bank*.json`, `extracted/**` (from `extract:lt`: run `npm run extract` before committing if the `; {n}` tags are not wanted)

## Open questions

15 rows in `questions/I033_questions.md` (`OQ-I033-1` to `-15`; DISCREPANCY on -1 to -7).

## Suggested commit message

```
Annotate A11 data and tables (I033)

Name and document the 20 data blocks of FM-A11: world meta lists, scene
placement/chest/exit/plate lists, lair records and formations, scene
variant rules, engine tables, asset lists, SPC driver, iris/icon/menu
data, animation banks and the dictionary. 285 names, 21 block renames,
20 block notes, 60 part notes. ROM SHA-1 unchanged. Open questions
OQ-I033-1..15 (boss HP, palette-cycle bank, exit pointer of 5A).
```

Please commit when you're ready.
