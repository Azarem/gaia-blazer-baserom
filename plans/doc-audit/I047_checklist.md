# I047 checklist - `docs/code/collision-and-physics.md` (collision and physics)

PD step of the plan "Blazer docs and analysis" (`c:\Users\azare\.cursor\plans\blazer_docs_and_analysis_e740ea3f.plan.md`, prompt "PD - Docs", topic = collision and physics). Continues I046. Annotation and docs only: the ROM SHA-1 must not change.

Baseline gate before this step: `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` (1,081,344 bytes, checksum 110070696), measured with `npm run rebuild` at the start.

Files of the topic (the prompt left `<files>` empty): `extracted/system/{engine_tile_collision, engine_actor_scheduler_and_sprites (RunActorList, StepActorMotion, SetActorAnimFrame, EndAnimation), cop_core (BlockActorFootprint, ClearActorFootprint, SlotNumberToActor, TileToPixel), player_core (FinishPlayerMove, ScanPushZones, SlideAroundCorner, GetMoveDirectionOfAnim), engine_combat_hits (boundary only)}.asm`, `extracted/library/{lib_map_index_helpers, lib_boot_and_scene_init (BuildTileTypeMap, FillTileTypeMap), lib_map_tile_patches (type-map rewrites), lib_tile_triggers_and_lair_return (type-1 marker, velocity zeroing), lib_field_talk (type 6)}.asm`, `extracted/cop_handlers/{cop_tiles_spawn_kill, cop_actor_fields_animation, cop_conditions}.asm`, and the data users `grass_valley/gv_multi_area_actors`, `mountain_of_souls/{ms_multi_area_actors, snow_mountain/ms_snow_mountain_actors}`, `st_elles/seabed_of_st_elles/se_seabed_of_st_elles_actors`, `magridds_castle/airship_dock/mc_airship_dock_actors`, `greenwood/lostside_marsh/gw_lostside_marsh_actors`, `st_elles/seabed_sanctuary/se_seabed_sanctuary_actors_0F8D58`, `leos_lab/town_models/ll_town_models_enemies`.

## Read first

- [x] `gaia-core/docs/notes-and-comments.md` (Notes Merge, Names Merge), `gaia-core/docs/rom-mapping-guide.md`
- [x] `gaia-knowledge/curated/gaialabs/code-bank-documentation.md` (skeleton, Three Questions)
- [x] `plans/mapping/mapping-action-plan.md` section 0 and 8c-8e, `plans/doc-audit/README.md`, `docs/walkthrough/README.md` and the chapters for the terms used (02 conveyor belts, 04 current, 05 ice, 07 wind and the walk-through-walls cheat, `items.md` Mushroom Shoes)
- [x] `docs/code/actor-system.md`, `docs/code/cop-dispatch.md`, `docs/code/scene-area-warp-loading.md`, `docs/cop/index.md` (style and overlap: link, do not repeat)
- [x] Fresh `npm run extract:lt`; the files above read

## Analysis findings to settle before writing

- [x] Collision is opt-in per actor: `$16` bit `$1000` (`StepActorMotion`); 71 of the 469 meta types start with it (the hero row `$1180` included); scripts toggle it (lunges in `ll_town_models_enemies`, the pearl ride in `se_seabed_sanctuary_actors_0F8D58`)
- [x] Velocity source: `SetActorAnimFrame` copies the step velocity (negated by the flip bits of `$1C`) at every animation step, so the box (`$10`, `$12`) and the extents come from the current frame; `EndAnimation` zeroes `$04` and `$06`
- [x] `tile_type_map` build: solid flag (bit 9) of the four tile words, first word = bit 0 (TL 1, TR 2, BL 4, BR 8); `$F0` = actor footprint; index formula of `PixelToMapIndex` against `GetTileType`
- [x] The per-direction blocking rule (current tile `$0A` / `$05` / `$0C` / `$03`; next tile `$0F`, the opposite half and `$06`); the pre-check only in `CollideWest` and `CollideNorth`; the unset `$0004` bit when a footprint or the index limit blocks
- [x] `ProbeTileAtVelocity`: one point `(x + dx - 4, y + dy - 4)`, only `$0F`, returns at once for dx = 0
- [x] Footprint life cycle: `BlockActorFootprint` / `ClearActorFootprint` (single tile for width + height < `$21`), `Cop2A` / `Cop2B`, `SetMetatileBg1` rewriting the byte, `Cop11` clearing at the new position; unblock zeroes the type too
- [x] Script probes `Cop21-24`, `Cop28` (whole byte non-zero), `CopAE` (type nibble), `Cop9D` / `Cop9E` (blocked bit)
- [x] Moves that bypass collision: `Cop9F` / `CopA0` / `CopA1`, `Cop2F`, direct writes (pearl ride, lair return), the ice slide asking `Cop21-24` itself
- [x] Push zones: record layout, overlap test, last record wins per axis, swap-velocity-and-clip in `FinishPlayerMove`, no corner slide, 13 lists / 54 records; Grass Valley, Mountain of Souls (dy = +1 slopes), St. Elles (dx = -4), airship deck (dy = +1)
- [x] `SlideAroundCorner`: needs `$0004`, key held, off-grid on the other axis, quadrant masks `$FC` `$F3` `$F5` `$FA`; left or up first
- [x] Hazard floors use BG1 metatile ids (`IsPlayerOnMetatile`), not types; the type-1 marker of the lair NPC; type 6 and the talk probe; actors reading the byte as state (Purple Fish, pop-up turret)
- [x] Boundary with combat: boxes `$08-$0E` against `TestSpriteOverlap`; no positional write in `engine_combat_hits`
- [x] Walkthrough cross-check: conveyor belts, current, ice and Mushroom Shoes, slopes, ship wind, Ice Armor / Elemental Mail floors; the Game Genie cheat (DISCREPANCY)

## Plan

### A. Document

- [x] A1 `docs/code/collision-and-physics.md`: breadcrumb, source links, overview with one diagram (at most 15 nodes), memory-map tables, `###` sections that pass the Three Questions, walkthrough cross-check, worked example, Open questions, See Also
- [x] A2 One See Also line each in `actor-system.md`, `cop-dispatch.md` and `scene-area-warp-loading.md`
- [x] A3 Every backticked label exists in `extracted/`, every relative link resolves (the hub `README.md` excepted, as in I043-I046)

### B. Notes and names

- [x] B1 `edits/I047.json`: two part-note corrections found while writing (`mc_deck_push_zone_records_02702B` 8-byte records; `unk16_0FA5AE` layout confirmed); no rename. The "knocked back" wording of `ApplySwordHit` and `DetectHitSourceCollisions` stays an open question (OQ-I047-6): the evidence is the absence of a positional write, not a runtime result

### C. Records and gate

- [x] C1 `plans/extracted-audit/questions/I047_questions.md`
- [x] C2 Gate: `extract:lt`, `rebuild` (SHA-1 `040a408a...`), `names -- --check`, `merge -- --check`
- [x] C3 `plans/extracted-audit/results/I047_results.md` with the suggested commit message

## Progress

- Read-and-verify phase finished (see the findings above); `npm run rebuild` baseline recorded (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`); nothing edited before this file was written.
- B: `edits/I047.json` dry-run, applied (`partNotes/bank02.json`, `partNotes/bank0F.json`).
- A: `docs/code/collision-and-physics.md` written (350 lines, 1 mermaid diagram, 20 `###` sections, 117 distinct backticked identifiers all found in `extracted/`; every relative link resolves except the hub `README.md`). Corrected while checking: the airship deck list is installed by the placement script `mc_deck_push_zones_027019` (not by dock actors); `BuildTileTypeMap` keeps pages in one byte, the byte count is pages x `$100`; the type-1 marker, the pearl ride and the ice slide cited with their labels; removed two statements the code does not support (a purpose for `Cop9F`-`CopA1`, statues pushed by the hero). See Also lines added in `actor-system.md`, `cop-dispatch.md` and `scene-area-warp-loading.md`.
- C: questions (8), gate and results file done. Gate: `extract:lt` OK, `rebuild` SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` unchanged, `names -- --check` OK (2765 names), `merge -- --check` OK (0 errors, 0 warnings, 0 orphans).
