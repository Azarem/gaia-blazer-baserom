# I015 results: PB1, static placement audit

Date 2026-11-21. Scope: read-only analysis. No names, notes, comments, blocks, overrides, transforms or docs of the project were changed. One audit document and this record pair were added. No merge was applied; every proposal is an `npm run blocks` outline.

## Added

| File | Purpose |
|------|---------|
| `plans/doc-audit/placement/placement-audit.md` | capacity and structure, cross-file call analysis (3,531 refs, 1,514 pairs), per-block pin constraints (eight classes), scene and group audit against the spawn tables, target file layout per subsystem, merge waves 0 to 4 as spec outlines, tool gaps |
| `plans/extracted-audit/questions/I015_questions.md` | `OQ-I015-1` .. `OQ-I015-10` (no row tagged DISCREPANCY: walkthrough, crosswalk and ROM agree for every world, area and boss lair) |
| `plans/extracted-audit/results/I015_results.md` | this file |

## Method

Fresh `npm run extract:lt`, `npm run audit -- --json`, the function maps FM-A1 .. FM-A11 and the crosswalk, `rebuilt/layout.json` (block adjacency only; the original ROM was not compared with the rebuilt ROM), and the extracted meta lists, placement rows and lair records. A scan of all 635 code parts for a last instruction that does not end the control flow found the fall-through class of finding 1. Scratch scripts stayed outside the repository and did not write to names, notes, comments or `blocks.json`.

## Findings

- **Nine actors fall through a file boundary, and the rebuilt layout does not keep them adjacent.** `COP [09]` and `COP [AD]` both continue. `w0_actor_01AC32`, `w1_actor_01E4C3`, `w1_actor_01E759`, `01E7D5`, `01E851`, `01E8ED`, `w2_actor_0FA440`, `w3_actor_021ECE` and `w4_actor_023DD3` run on into a `*_shared_` file in the original, and none of the nine pairs is adjacent in `layout.json`. The four GreenWood shims are consecutive `COP [AD]` files that end in an `RTL`. Neither `npm run audit` nor `blocks-verify` can see this. Whether the game misbehaves is `OQ-I015-1` (Mesen2). Wave 0 of the audit merges each pair.
- **`common` is not common**: 7 of 125 blocks serve more than one world (the player, `common_actor_0029E8`, the save point, `common_actor_004659_part1`); 116 belong to one world (83 enemy files in bank `$1F`, 8 bosses and the front-end actors in bank 0), 2 are unreachable stubs.
- **The six boss actors are tied to their lair records**: record, home location, lair location and scene agree with the crosswalk's spawn areas in all six (this answers OQ-I004-13 statically).
- **World groups are clean** and **area routing exists** for 357 of 376 meta-listed blocks (14 multi-area, 5 without evidence). The lair record's lair location (`+B`), not the home location (`+0`), is used for monsters (`OQ-I015-10`).
- **Shared helpers in world groups**: `w0_shared_01B161`, `w0_actor_0191D2_part3`, `w3_shared_022289`, `w3_shared_02249A` (and the string `w0_shared_01B988`) serve other worlds; with `common_actor_0029E8`, `common_actor_004659_part1` and the save point they form the proposed `actor_shared` group.
- **632 of 3,531 refs (253 of 1,514 pairs) are removable by same-bank, same-group merges**: 149 refs in 45 single-caller blocks, 524 inside the proposed (world, area, bank) files, overlapping. 1,305 refs go to shared utilities with 10 or more calling files and stay. All 205 cross-file branches are `BRL`.
- **Pins**: vectors and handler tables (bank 0), bank-2 strings (DBR `$02`), bank-1 data read with DBR `$01`, `labels.json` selectors (banks 0, 1, 2, 5, 6, 9), 15 overrides, 7 rewrites, four return-address helper targets, `$&` clusters, and the false R-2 read `lib_01065B:18` (`OQ-I015-4`). Every bank is full (1 to 84 bytes free), so only bank-local, size-neutral merges are possible.
- **Layout**: `engine_000000` can already be cut at its 7 part boundaries (boot, dead debug, NMI, the 3,338-byte actor core, spawn); a finer cut needs a `split-part` operation (`OQ-I015-8`). The 110 COP handlers go to `cop_core` plus five family files; the library into text, menus, loader, scene flow, player stats, map helpers, scene loader and strings; the actors into one file per world, area and bank, with one enemy file per world.
- **Dead or unreferenced**: `engine_0074B1` (34 bytes), `common_shared_0FDFC0`, `common_shared_0FE769`, `w0_shared_01A4F9`, `w5_shared_02623C`, `code_027277`, `code_027374`, `code_006BA5`, and `engine_000000` R05 to R12.

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
PB1: static placement audit (I015)

Add plans/doc-audit/placement/placement-audit.md: cross-file call analysis,
per-block pin classes, scene/group audit against the spawn tables, target
layout per subsystem and merge waves 0-4 (outlines, none applied). Record
nine actors whose COP [09]/[AD] tail falls into a file the rebuilt layout
places elsewhere. Add I015 questions (10) and results. No project data
changed; SHA-1 unchanged.
```

Please commit when you're ready.
