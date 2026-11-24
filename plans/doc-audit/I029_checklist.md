# I029 checklist: annotate batch A7 (library `0133`-`0147`)

Plan: `c:\Users\azare\.cursor\plans\blazer_docs_and_analysis_e740ea3f.plan.md`, step PC for batch A7 (`FM-A7.md`, `I011_questions.md`). Core code, so full depth. No actor is in this batch (the loader, the profile data, the boot code and the text data are library and `grass_valley/front_end` text files), so the light actor depth does not apply; the actors that print these strings (`gv_front_end`, `gv_up_above_trial_room_and_lisa_turbo_actors`, `player_spells_level_up`) belong to their world batches. Annotation only: no regroup, no code change, SHA-1 must stay.

Rules for this iteration: names only through `npm run names`, notes and comments only through `npm run merge`, both dry-run first; hand edits only in `us/mnemonics.json` and `docs/wram-memory-map.md` (no tool exists); no ad-hoc scripts (the only shell use is `printf` to convert hex file offsets to decimal for the data-part name rows, because data parts have no `; {n}` tag); no commits; the original ROM is never compared with the rebuilt ROM. The walkthrough is the source of truth for game names, the ROM text for exact spelling.

## Where the A7 rows live now (after the regroup)

| File | A7 content | Block note |
|------|------------|------------|
| `extracted/library/lib_scene_asset_loader.asm` | L004-L025: the whole scene asset loader (wait N vblanks, Quintet LZ expander, record walker, eight command handlers, profile applier, pointer and cache helpers) and the boot hardware reset | new |
| `extracted/library/lib_scene_profile_data.asm` | D01, D02: scene profile list (128 words) and the 97 twelve-byte profile records | new |
| `extracted/library/lib_scene_map_patches.asm` | L001-L003 (lair states, flag map patches, scene variant lookup) and D03 (`unk13` patch table); the five routines `code_0112F5`, `code_011395`, `code_011445`, `code_0114D0`, `code_0114E4` have no function-map row (see questions) | existing: edited |
| `extracted/library/lib_013ADA.asm` | L026: default PPU layout at boot | new |
| `extracted/library/lib_banner_texts.asm` | D33-D37 (level up, pause banner, lair counter) and D06 (location name list and 128 names) | new |
| `extracted/grass_valley/front_end/gv_title_texts.asm` | D07, D08, D23, D32, D05 (title texts, tile block, save slot menu and line templates) | new |
| `extracted/grass_valley/front_end/gv_prologue_texts.asm` | D09-D22 (intro narration, 14 pages) | new |
| `extracted/grass_valley/front_end/gv_epilogue_texts.asm` | D24-D31 (ending narration, 7 pages, THE END); the staff roll string `asciistring_016264` belongs to the front-end batch (I028) | new |

## Checklist

- [x] Read: `notes-and-comments.md` (Notes Merge, Names Merge, Comment Authoring Guide), `code-bank-documentation.md` (via the I028 template), `mapping-action-plan.md` conventions, `plans/doc-audit/README.md`, `FM-A7.md`, `I011_questions.md`, the I026 to I028 records (template), the walkthrough chapters `01-in-the-beginning.md` and `02-grass-valley.md`, the crosswalk, and every A7 file end to end
- [x] Baseline: fresh `npm run extract:lt`
- [x] Re-check the FM-A7 claims against the code (command ladder lengths, cache slots, profile bytes, tileset raw path, boot clears); record every correction
- [x] Names spec `plans/extracted-audit/renames/apply-I029_names.json`: routines, key inner labels, the profile list and 97 records, the patch table, the title, intro, ending, banner and save-slot strings, the location name list and its 128 strings; `--dry-run`; apply; `npm run extract:lt`
- [x] Mnemonics in `us/mnemonics.json` for the A7 WRAM (`$031A`, `$031C`, `$031E`, `$0372`/`$0373`, `$03A2`, `$03B4`, the ten asset cache cells, `$0439`, `$0346`-`$0349`, `$1B80`); check none is a pointer-table operand; SHA-1 unchanged
- [x] Merge spec `plans/extracted-audit/edits/I029.json`: 7 new block notes, 1 edited, part notes (When, Sees, Why, In, Out, Clobbers), sparse comments with `expect` guards
- [x] `npm run merge -- <spec> --dry-run`; apply; `npm run extract:lt`; read the extracted files as a consumer would
- [x] `docs/wram-memory-map.md` section 7h; section 8 updated (`$03B4`, `$031E` leave the unnamed list)
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 unchanged `3148390ed40ce14060b33c1387303a8a77e7a0c1`), `names -- --check`, `merge -- --check`
- [x] `plans/extracted-audit/questions/I029_questions.md` (new rows `OQ-I029-k`; `OQ-I011-*` rows stay valid)
- [x] `plans/extracted-audit/results/I029_results.md` with a suggested commit message
- [ ] Left for the user: commit; decisions in the questions file

## Progress

- Reading done; FM-A7 claims re-checked while reading (corrections are collected in the results file).
- Names: 333 rows applied (`apply-I029_names.json`), `extract:lt` re-run.
- Mnemonics added by hand in `us/mnemonics.json`; SHA-1 unchanged after the rebuild.
- Merge: `I029.json` applied (8 block notes, 42 part notes, 86 comments), 0 errors.
- `docs/wram-memory-map.md` section 7h added and section 8 trimmed; wording of `pause_latch`, `scene_sprite_attr` and `no_combat_scene` re-checked against the code and corrected.
- Gate passed (see `I029_results.md`): SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, names OK (954), merge 630 comments, 602 part notes, 40 block notes, 0 errors.
- Questions `OQ-I029-1` to `-5` written; `OQ-I028-2` answered.
- Results file written. Nothing committed.
