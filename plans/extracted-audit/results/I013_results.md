# I013 results: PA batch A9 (library `0270`-`0279`)

Date 2026-11-21. Scope: read-only analysis. No names, notes, comments, blocks, overrides or docs of the project were changed. One function-map document and this record pair were added.

## Added

| File | Purpose |
|------|---------|
| `plans/doc-audit/function-map/FM-A9.md` | 35 routine rows (34 labels plus the sub-label `loc_02787C`, which has a caller outside its routine), 1 data row, the tables the code reads, the 97-row location size table (header sizes against live sizes), models for the save system, scene change and transitions, scene init, map index and the tile type map, pause, pending HP and EXP, Gems, bit arrays and the `$0100-$02FF` page; 8 structure layouts with the evidence for each field width; WRAM name proposals; inner-label inventory; fan-in, findings and placement proposals |
| `plans/extracted-audit/questions/I013_questions.md` | `OQ-I013-1` .. `OQ-I013-14` (two tagged DISCREPANCY: 1 and 2) |
| `plans/extracted-audit/results/I013_results.md` | this file |

## Method

Fresh `npm run extract:lt`; all 25 files of the batch read end to end (one contiguous run `$04:70E4`-`$04:7AD2`, offsets 159972-162515, 2543 bytes; the row sizes sum to the `us/blocks.json` sizes). Callers were counted with the Grep tool over the extraction. The callers and callees that give each routine its meaning (boot and main loop in `engine_000000`, the slot menu in `engine_006B7F`, the save actor, the loader, the random number routine, the return trip) were read in full. Tables were joined with their consumers (header sizes in the asset stream against the live size table `unk14_017504+$28`, the lair record byte `+$13`, the iris frames in `data_048000`). No names, notes or db files were edited.

## Findings

- Save slot layout and checksum: four `$400`-byte slots plus mirrors at `+$1000`, `lair_state` then `$1A5E-$1C57`, sum at `+$3FA` and XOR at `+$3FC`, both seeded with `$3652` over `$1FD` words; the last-slot word `$70:1FFE` sits in slot 3's mirror tail.
- Transition types: the full matrix (0-7, `$80`), the iris frame formula and the undefined `$81`+ range.
- Scene init order, with event flags `$00`-`$07` scene-local and `$1A7D` as event-flag byte 31 (flag `$FF` set by new game, `$FA` suppresses the HUD redraw).
- `tile_type_map` is one **byte per metatile** (FM-A3 said one word: DISCREPANCY OQ-I013-2). `rng_state` is `$0302-$0311`; `$0301` is the high byte of the sort end marker (DISCREPANCY OQ-I013-1).
- EXP, Gems and pending HP/EXP: BCD, caps 99,999,999 (agrees with the walkthrough) and 999,999 (no walkthrough value, OQ-I013-8); the pending EXP drain removes the lowest non-zero digit every 8 frames.
- Answers to earlier questions: OQ-I011-1 (`dp$2E` is `$7E` from boot), OQ-I011-8 (the LZ ring page is the sort bucket page), OQ-I011-13 (event flag `$FF`), OQ-I005-21 (the boot scene `00/0C` is location `$12`).
- Two dead routines (`code_027277`, `code_027374`); latent defects: the erase marker may equal the stored first word (OQ-I013-10), the animated strip reserves tiles `$206-$21D` in every tileset (OQ-I013-14), a duplicate `STX $0433` (OQ-I013-13).
- Naming hazard for step PC: `lib_027462` and `lib_027781` have `part1`/`part2`/`part3` legacy names that are not subsystems; `loc_02787C` needs its own `names` row.

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK |
| `npm run rebuild` | OK, SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes (unchanged) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | OK: 0 errors, 0 warnings, 0 orphans (0 comments, 26 part notes, 4 block notes, 704 extracted files) |

`git status` shows `extracted/` as modified because the line-tracked extraction was run last; run `npm run extract` if the tracking annotations should not be committed.

## Suggested commit message

```
docs(blazer): A9 function map for save system, scene change, transitions and map helpers (I013)
```

Please commit when you're ready.
