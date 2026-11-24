# I011 results: PA batch A7 (library `0133`-`0147`)

Date 2026-11-21. Scope: read-only analysis. No names, notes, comments, blocks, overrides or docs of the project were changed. One function-map document and this record pair were added.

## Added

| File | Purpose |
|------|---------|
| `plans/doc-audit/function-map/FM-A7.md` | 26 routine rows (24 top-level labels, 21 of them in `lib_0133A6_part3`, plus the 2 sub-labels `code_0115F1` and `code_011662`, which have external callers), 41 data rows, the 97-row scene profile table, models for the scene loader, the Quintet LZ expander, the skip mask and pointer caches, tilemap and tileset loading, the scene profile, the scene variant, lair and map-patch application, the pause banner, boot and the story text; five structure layouts (asset record, scene profile, `unk13`, `unk10`, save-slot template) with the evidence for each field width; WRAM name proposals; inner-label inventory; fan-in and placement proposals |
| `plans/extracted-audit/questions/I011_questions.md` | `OQ-I011-1` .. `OQ-I011-13` (none tagged DISCREPANCY) |
| `plans/extracted-audit/results/I011_results.md` | this file |

## Method

Fresh `npm run extract:lt`; every file of the batch read end to end (the five `lib_0133A6` parts, `lib_013ADA` and the string and binary files `lib_013B27` .. `lib_shared_014789`). Callers, the writers of `$03B4`, `$031E` and the pointer caches, and the consumers of each data table were counted with the Grep tool over the extraction. Data tables were joined with their consumers: the asset list was checked against the profile ids (97 records, 97 profiles, one dummy record), the profile bytes against the code that reads them, the `$031E` variant against `data_00F99A`, the lair and `unk13` records against L001 and L002. No names, notes or db files were edited.

## Findings

- The scene loader is a 98-record asset list walked from the top, with eight commands dispatched through a `BIT` ladder, a skip mask at `$03B4` (13 files, 15 sites write it) and ten pointer caches. Pointers are linear file offsets converted to LoROM.
- The Quintet LZ expander matches `corpus/gaia-core/quintet-lz.md`; its ring sits at `$7E:0100` (OQ-I011-8).
- The scene profile is a 12-byte record per location id (97 used). Byte layout, flag bits and the `$031E` variant logic are in FM-A7 sections 1.7, 1.8 and 4.2. Boss rooms (profile `C0`) and dream rooms (`A0`) match the profile bits exactly.
- `code_01157E` (lair states) and `code_0115F1` (map patches by event flag) are documented with their record layouts.
- Latent defects, none seen in play: the raw tilemap flag leaks into `map_height_px` (OQ-I011-2), `dp$2E` is trusted to be `$7E` (OQ-I011-1), the asset list has no end sentinel (OQ-I011-3), two unreachable `BRA $74` pin the layout (OQ-I011-10).
- No DISCREPANCY: ROM place names agree with the walkthrough and crosswalk apart from capitalisation. The intro and ending text, and "Freil Empire", are not in the walkthrough.
- Naming hazard for step PC: `code_0115F1` and `code_011662` are colon sub-labels and need their own `names` rows; the 21 brace labels of `lib_0133A6_part3` are a single part today (placement proposals in FM-A7 section 7).

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK |
| `npm run rebuild` | OK, SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes (unchanged) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | OK (0 errors, 0 warnings, 0 orphans; 26 part notes, 4 block notes) |

`extracted/` shows as modified in `git status` because of the line-tracked extraction (`; {n}` annotations); run `npm run extract` again before committing if those annotations should not be committed. `package.json`, `src/` and `.cursor/rules/` changes shown by `git status` were already there and are not part of this step.

## Suggested commit message

```
docs(blazer): A7 function map for scene loader, LZ, profiles and story text (I011)

Add FM-A7 (library 0133-0147: 26 routines, 41 data rows, scene profile
table, struct layouts), the I011 open questions (13 rows) and results.
No names, notes or db files changed; ROM SHA-1 unchanged.
```

Please commit when you're ready.
