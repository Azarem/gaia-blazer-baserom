# I057 results: docs/code/data-tables.md

Topic: the data tables. `<files>` was not given, so the files were chosen like in I043-I056 (list in `plans/doc-audit/I057_checklist.md`): the 19 `data_*.asm` and `WorldMetaPointers.asm` blocks, the tables inside the libraries (`FlagMapPatchTable`, `MapPatchRectsAndMapSizes`, `LocationAreaScene`, `NpcNameStrings`, `LocationNameList`, `SceneProfileList`), and the readers needed to confirm key, index step and terminator. The rebuilt ROM was not compared with the original.

## Deliverables

| File | What |
|------|------|
| `docs/code/data-tables.md` | the spoke (433 lines): breadcrumb, source links, overview with two diagrams (15 and 9 nodes), memory map (data, state), the seven keys, terminators, the 31 id holes, the lair records and formations, the meta lists, the engine tables, the animation banks, the row layouts, the data nothing reads, walkthrough cross-check, open questions, See Also |
| `plans/doc-audit/I057_checklist.md` | the checklist, written before the first edit |
| `plans/extracted-audit/edits/I057.json` | merge spec: 13 note edits in 4 files (formation block and pointer notes, lair record block note, exit list block note, three engine-table part notes) |
| `plans/extracted-audit/questions/I057_questions.md` | OQ-I057-1 to OQ-I057-5 and the four earlier questions settled or narrowed |
| `docs/code/actor-system.md`, `scene-area-warp-loading.md`, `combat-damage-and-enemy-records.md`, `flags-switches-and-inventory-bytes.md` | one See Also bullet each |

The document was written with one Write call; after the identifier check it got ten targeted corrections with the edit tool (the chest bit space, the facing tables, the sine and circle wording, one unsupported clause each in the key table and the terminator list, the unk4/15/16 names, the bank-rule sentence).

## Findings

- **31 holes.** The profile, chest, exit and plate tables and `LocationAreaScene` hold a zero word at exactly the same 31 ids (`$25-$27`, `$35-$3B`, `$48-$4F`, `$5D-$63`, `$74-$77`, `$7E-$7F`), the unused tails of the seven world blocks of `$14` ids. The 15 filler rows of `LairRecords` sit at location `$63`, one of them. (Explains OQ-I015-2.)
- **Formation lists.** In all 107 records that use `RunLairFormation` the list has exactly as many rows as `+13`; five of the 112 lists (`$06`, `$0B`, `$0E`, `$29`, `$2B`) are named by no record (27 of the 434 rows). The notes said "at least".
- **`LairRecords` `+A`** is the world index of the lair location in 403 of 420 rows and is ORed into `lair_state`; no reader tests its low bits (OQ-I057-1). The records are grouped by world (ranges in the document); the script counts per world add up to the block note totals.
- **Dream rooms.** Five records have count 0 (the notes said three): `$32`, `$74`, `$75` without a script, `$79` and `$E7` with an unreachable `RunLairRespawn`. The walkthrough describes exactly these five switches.
- **Meta lists.** Nine rows are reached by no placement and no lair record (confirms OQ-I015-6); the highest placed type of each world equals the list size minus one; the hero entry is identical in the seven lists; the animation field splits 358 / 69 / 31 / 7 / 4.
- **`MapPatchRectsAndMapSizes`** is two tables (five patch rectangles, then 128 map-size pairs) under one label (OQ-I057-5).
- **`CircleHalfWidths`**: the reader is `BuildSoulOrbCircleWindow`, not the iris; the table is mirrored about row 64 (settles OQ-I033-9). **`SineTable`** only approximates 127 × sin (largest deviation 1.9) and its negative half is not the exact negation of the positive one.
- **Facing against move direction**: 12 of the 44 animation ids differ; ids `$14-$1F` hold 0 in both (OQ-I014-2).
- `FM-A11 4.17` is not a ghost reference (the file exists); the two notes that cite it now point to OQ-I033-10 and the document.

## Open questions

| ID | Tag | Short |
|----|-----|-------|
| OQ-I057-1 | GAP | what the world number in `LairRecords` `+A` is for |
| OQ-I057-2 | GAP | five formation lists named by no record |
| OQ-I057-3 | GAP | whether the scripts of the dolphin's and mushroom's dream rows ever run |
| OQ-I057-4 | GAP | the two words past `$7F` of `LocationAreaScene` |
| OQ-I057-5 | D | split `MapPatchRectsAndMapSizes` into two labels |

No new DISCREPANCY. The walkthrough rows already logged (OQ-I033-1, OQ-I010-2, OQ-I033-7) are cited, not re-opened.

## Gate

| Step | Result |
|------|--------|
| `npm run merge -- plans/extracted-audit/edits/I057.json --dry-run`, then applied | 4 files, 2 notes files written (`notes/blockNotes/bank00.json`, `notes/partNotes/bank00.json`) |
| `npm run extract:lt` (after the merge) | OK; the new text is in `extracted/system/data_lair_records.asm`, `data_lair_formations.asm`, `data_exit_lists.asm`, `data_engine_tables.asm` |
| `npm run rebuild` | OK; SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` (unchanged) |
| `npm run names -- --check` | OK (2765 names) |
| `npm run merge -- --check` | OK: 1401 comments, 1684 part notes, 135 block notes; errors 0, warnings 0, orphans 0, duplicate keys 0 |
| identifier and link check of the document | every backticked identifier exists in `extracted/`, `us/`; the only dead link is the hub `README.md`; 433 lines; 2 diagrams of 15 and 9 nodes |

## Follow-ups

- The hub `docs/code/README.md` still has to list the 15th spoke.
- OQ-I033-10 (retyping `unk6`, `unk8`, `unk3`, `unk12`) is still a decision; the document now holds the field widths it needs.
- The `LairRecords` block note now describes `+A` as the world index; OQ-I057-1 is the only open question about it and needs a runtime watch.

## Suggested commit message

```
docs: add docs/code/data-tables.md (I057)

Cross-table reference for the keyed data tables: keys, terminators, the 31
id holes, lair records and formation lists, meta lists, engine tables,
animation banks and row layouts. Corrects the notes the survey proved
wrong: formation lists have exactly as many rows as the monster count
(five lists are unused), LairRecords +A is the world index, five dream rows
have count 0, CircleHalfWidths is read by BuildSoulOrbCircleWindow, the sine
table is approximate. Adds See Also links in four spokes. ROM unchanged.
```

Please commit when you're ready.
