# I046 checklist - `docs/code/scene-area-warp-loading.md` (scene, area and warp loading)

PD step of the plan "Blazer docs and analysis" (`c:\Users\azare\.cursor\plans\blazer_docs_and_analysis_e740ea3f.plan.md`, prompt "PD - Docs", topic = scene, area and warp loading: asset list, spawn tables, bank layout). Continues I045. Annotation and docs only: the ROM SHA-1 must not change.

Baseline gate before this step: `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` (1,081,344 bytes, checksum 110070696), measured with `npm run rebuild` at the start.

Files of the topic (the prompt left `<files>` empty): `extracted/library/{lib_scene_asset_loader, lib_boot_and_scene_init, lib_scene_profile_data, lib_map_tile_patches, lib_tile_triggers_and_lair_return}.asm`, `extracted/system/{data_scene_asset_lists, data_scene_placements, data_exit_lists, data_chest_lists, data_plate_lists, data_scene_variant_rules, engine_spawn_lairs_death_drops}.asm`, `extracted/cop_handlers/{cop_script_flow_flags, cop_tiles_spawn_kill}.asm`.

## Read first

- [x] `gaia-core/docs/notes-and-comments.md` (Notes Merge, Names Merge), `gaia-core/docs/rom-mapping-guide.md`
- [x] `gaia-knowledge/curated/gaialabs/code-bank-documentation.md` (skeleton, Three Questions)
- [x] `plans/mapping/mapping-action-plan.md` section 0 and 8c-8e, `plans/doc-audit/README.md`, `docs/walkthrough/README.md` and the chapters for the terms used (01, 06, 07, 08)
- [x] `docs/code/boot-nmi-main-loop.md`, `docs/code/actor-system.md`, `docs/code/cop-dispatch.md`, `docs/areas-and-scenes.md` (style and overlap: link, do not repeat)
- [x] Fresh `npm run extract:lt`; the files above read

## Analysis findings to settle before writing

- [x] Key model: (area, scene) keys the asset list and the placement index; `location_id` (first asset8 profile id) keys everything else; `LocationAreaScene` is the bridge (set equality of the four keys checked over all 97 scenes)
- [x] Every writer of `scene_next` found (`Cop10` 65 sites, `CheckExitRegions`, file select, Master's Move, player death, lair return trip)
- [x] Asset list: command sizes (`FindSceneRecord` skip lengths), asset8 classes (profile / jump / label), 65 jumps to 37 labels, label `$DE` never referenced
- [x] Pointer type: file offset to LoROM (`ReadAssetPointer`), 10 cache cells, `asset_skip_mask` writers counted (15 sites, 10 files; the loader note said 13 files and "inside a world")
- [x] Exit rows: tile test and the shrunk pixel test (`w x 16 - 15`), arrival `warp_dest_y + 16`, partner pairs (Grass Valley Shrine, Grass Valley highlands, Trial room, Leo's painting 1)
- [x] Walkthrough cross-check: Trial room, blue portal west, blue tile south, east exit to Leo's painting, GreenWood shrine exits (Lostside, Light Shrine)
- [x] Bank layout: `$&` against `$@` sites, DBR = $01, `dp$2B = $01`, `movable` asset list, `Location` pointers

## Plan

### A. Names (`renames/apply-I046_names.json`)

- [x] A1 (7 renames: `TestExitRow`, `AdvanceExitRow`, `NoExitHit`, `TestExitPixels`, `ReleaseLairPathCase`, `ReleaseLairNpcCase`, `StartLairReturnTrip`) sub-labels of `CheckExitRegions` and the return trip that the document cites; `--dry-run`, apply, `extract:lt`

### B. Notes (`edits/I046.json`)

- [x] B1 `lib_scene_asset_loader` block note: `asset_skip_mask` writers (15 sites in 10 files; the cutscene warps that keep the music, some of them across a world)
- [x] B2 no further note correction needed (the document corrections were all in the document itself)

### C. Document

- [x] C1 `docs/code/scene-area-warp-loading.md`: breadcrumb, source links, overview with two diagrams, memory-map table, `###` sections that pass the Three Questions, walkthrough cross-check, worked example, Open questions, See Also
- [x] C2 Link from `docs/code/boot-nmi-main-loop.md` (planned spoke), See Also entries in `actor-system.md`, `cop-dispatch.md` and `docs/areas-and-scenes.md`
- [x] C3 Every backticked label exists in `extracted/`, every relative link resolves (the hub `README.md` excepted, as in I043-I045)

### D. Records and gate

- [x] D1 `plans/extracted-audit/questions/I046_questions.md`
- [x] D2 Gate: `extract:lt`, `rebuild` (SHA-1 `040a408a...`), `names -- --check`, `merge -- --check`
- [x] D3 `plans/extracted-audit/results/I046_results.md` with the suggested commit message

## Progress

- Read-and-verify phase finished (see the findings above); nothing edited before this file was written.
- A: `renames/apply-I046_names.json` dry-run, applied (7 added to `bank01.json`); `extract:lt` prints the new names.
- B: `edits/I046.json` dry-run, applied (block note of `lib_scene_asset_loader`, `blockNotes/bank01.json`).
- C: `docs/code/scene-area-warp-loading.md` written (369 lines, 2 mermaid diagrams, 22 `###` sections, 186 distinct backticked tokens all found in `extracted/` except the JSON key `movable`, which is in `us/blocks.json`; every relative link resolves except the hub `README.md`). Corrected while checking: the `$DE` label is in the record of area `$12`, scene 1 (not the first record); `asset8 #DA` in area 0 scene 1 is a label, not a jump; `saved_scene` is written by `SaveGameToSlot`, and "carry set = new game" is OQ-I024-5. Links added in `boot-nmi-main-loop.md`, `actor-system.md`, `cop-dispatch.md` and `areas-and-scenes.md`.
- D: questions (5), gate and results file done. Gate: `extract:lt` OK, `rebuild` SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` unchanged, `names -- --check` OK (2765 names), `merge -- --check` OK (0 errors, 0 warnings, 0 orphans).
