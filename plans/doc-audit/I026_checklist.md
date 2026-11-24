# I026 checklist: annotate batch A4 (library `0100-0111`)

Plan: `c:\Users\azare\.cursor\plans\blazer_docs_and_analysis_e740ea3f.plan.md`, step PC for batch A4. Full depth (core code, not actors).

Rules for this iteration: names only through `npm run names`, notes and comments only through `npm run merge`, both dry-run first; hand edits only in `us/mnemonics.json`, `us/overrides.json` (M flags), `docs/cop/index.md` and `docs/wram-memory-map.md`; no ad-hoc scripts; no commits; the original ROM is never compared with the rebuilt ROM.

## Where the A4 rows live

| File | Content | Block note |
|------|---------|------------|
| `extracted/library/lib_010000.asm` | `AimCameraAtPlayer` | new |
| `extracted/library/lib_map_streaming.asm` | scroll, strips, redraw at entry, `ScaleByRatio`, strip upload | new |
| `extracted/library/lib_animation.asm` | `NextFrameRecord`, `CopyFrameData` | new |
| `extracted/library/lib_0109D6_part1.asm`, `lib_0108BB.asm` | tile lookup, `SetMetatileBg1`, `ApplyMapPatchRect` | new |
| `extracted/library/lib_0109D6_part3.asm` | `StoreInventoryEntry` | new, part rewritten |
| `extracted/library/lib_tile_triggers_and_lair_return.asm` | triggers, chests, exits, lair release, NPC return | new |
| `extracted/library/lib_map_sweep_redraw.asm` | `StepSweepRedraw`, `SweepStepTable` | new |
| `extracted/library/lib_scene_map_patches.asm` | rectangle copies (A4 routines only) | new |
| `extracted/system/engine_boot_main_loop.asm`, `cop_handlers/cop_items_stats_text.asm`, `cop_handlers/cop_actor_fields_animation.asm` | wording fixes that cite the A4 routines | edited |

## Checklist

- [x] Read: `notes-and-comments.md`, `rom-mapping-guide.md`, `code-bank-documentation.md`, `mapping-action-plan.md`, `plans/doc-audit/README.md`, `FM-A4.md`, the I025 records, the walkthrough chapters for the lairs, chests and NPCs, and the A4 files
- [x] Baseline: fresh `npm run extract:lt`, `npm run rebuild`, SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`
- [x] Names spec `plans/extracted-audit/renames/apply-I026_names.json` (38 rows); dry-run; apply; `npm run extract:lt`
- [x] Mnemonics in `us/mnemonics.json` for the names with evidence (49 entries); evidence in `docs/wram-memory-map.md` section 7e
- [x] Override `67277` set to `M: 0` (`CopyFrameData`; SHA-neutral)
- [x] Merge spec `plans/extracted-audit/edits/I026.json`: block notes, part notes (In / Out / Clobbers + When, Sees, Why), comments with `expect` guards
- [x] `npm run merge -- <spec> --dry-run`; apply; `npm run extract:lt`; read the result
- [x] Wrong 'return-point store' text of `code_0109D6` corrected in the engine notes
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 unchanged), `names -- --check`, `merge -- --check`
- [x] `plans/extracted-audit/questions/I026_questions.md` (`OQ-I026-1` to `-11`)
- [x] `plans/extracted-audit/results/I026_results.md` with a suggested commit message
- [ ] Left for the user: decide OQ-I026-1 (the `65803` override changes the SHA-1)
- [ ] Left for a later batch: `lib_scene_map_patches` gap routines, files `0112-0116`, `0122-0123`, `0131-0132`, part notes of `data_00BA0D`, `table_00A9DE`, `table_00AC96`, `table_00B69A`
