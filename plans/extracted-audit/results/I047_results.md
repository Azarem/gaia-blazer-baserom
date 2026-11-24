# I047 results: `docs/code/collision-and-physics.md` (collision and physics)

PD step of the plan "Blazer docs and analysis", topic "collision and physics". The prompt left `<files>` empty; I chose the files that make up the topic (see Sources), as in I043 to I046. Work started from a fresh `npm run extract:lt`; the gate was run at the end. The plan checklist is `plans/doc-audit/I047_checklist.md`.

## Deliverables

| File | What |
|------|------|
| `docs/code/collision-and-physics.md` | New topic document (350 lines): breadcrumb, source links, overview with one mermaid diagram (12 nodes), memory-map tables (code, COP handlers, state), 20 `###` sections (where the velocity comes from, the turn and the `$1000` opt-in, what `MoveActorWithTileCollision` does, how the type map is built, the quadrant meaning of the nibble, index math, `GetTileType`, the four directions, the one-point probe, footprints, script probes, position commands and forced moves, the ice worked example, other direct writers, push zones, how a push is applied, the corner slide, the map as state, where collision ends, position tests), a walkthrough cross-check table, open questions and See Also. |
| `plans/extracted-audit/edits/I047.json` | Merge spec: two part-note corrections (`mc_deck_push_zone_records_02702B`: 8-byte records, not 6; `unk16_0FA5AE`: the record layout is now confirmed by `ScanPushZones`). |
| `plans/extracted-audit/questions/I047_questions.md` | OQ-I047-1 to OQ-I047-8 (seven GAP, one DISCREPANCY). |
| `plans/extracted-audit/results/I047_results.md` | This file. |
| `plans/doc-audit/I047_checklist.md` | The checklist with its progress section. |
| `docs/code/actor-system.md`, `docs/code/cop-dispatch.md`, `docs/code/scene-area-warp-loading.md` | One See Also line each. Edited by hand; no notes, comments or names. |

Sources documented: `engine_tile_collision` (all eight parts), `StepActorMotion`, `RunActorList` (hit stun and sub-frame filter), `SetActorAnimFrame` and `EndAnimation`, `BlockActorFootprint` and `ClearActorFootprint` (`cop_core`), `FinishPlayerMove`, `ScanPushZones`, `SlideAroundCorner` and `GetMoveDirectionOfAnim` (`player_core`), `PixelToMapIndex`, `StepMapIndexEast`, `StepMapIndexSouth` and `IsPlayerOnMetatile` (`lib_map_index_helpers`), `BuildTileTypeMap` and `FillTileTypeMap`, the type-map writers of `lib_map_tile_patches` and `lib_tile_triggers_and_lair_return`, the tile and position COP commands (`cop_tiles_spawn_kill`, `cop_actor_fields_animation`, `cop_conditions`), and the push-zone and ice actors of Grass Valley, Mountain of Souls, St. Elles and Magridd's Castle. Not written here: damage and hit rules (`engine_combat_hits` is only the boundary), the camera and scroll, the player's walk handlers.

## Findings

1. **Answer to OQ-I005-8 by static reading.** The type nibble is a quadrant mask: `FillTileTypeMap` ORs bit 9 (solid flag) of the four tile words of a metatile with the first word as bit 0 (TL 1, TR 2, BL 4, BR 8; the definition order TL, TR, BL, BR is stated in the `lib_map_scroll_and_redraw` note). So `$0A` is the right half, `$05` left, `$0C` bottom, `$03` top, `$0F` a full wall, and `$06` (TR + BL) is treated as a wall in all four directions. The box routines react to no other non-zero nibble. Which values the shipped maps contain is OQ-I047-2.
2. **Collision is opt-in and per frame.** `StepActorMotion` tests `$16` bit `$1000`; 71 of the 469 meta types start with it (7 are the hero rows); scripts toggle it (`ll_enemy_toy_lunge_0FDAED`, the pearl ride clears it on the hero). The box (`$10`, `$12`) is copied from the sprite record of the current animation step, so the box follows the frame, and the one-point probe is chosen per frame.
3. **A footprint stop does not set `$0004`.** When the next tile reads with carry set (an actor's `$F0` mark or an index of `$4000` or more), all four box routines branch to the snap-and-stop code without the `ORA #$0004`; a map wall sets it. `Cop9E` and `SlideAroundCorner` test only that bit. Runtime check is OQ-I047-1.
4. **The routines read only the sign of the velocity.** The same tiles are tested for a step of 1 and of 20. East and south test every frame, west and north only when the step crosses a 16-pixel line (OQ-I005-12); all four snap to the grid line below the position, so an off-grid actor jumps back by up to 15 pixels when blocked.
5. **Unblocking erases the type.** `ClearActorFootprint` and `Cop2B_UnblockTileAt` `AND #$FF00` the word, so the type nibble goes with the mark; `SetMetatileBg1` rewrites the whole byte from the metatile definition and removes any mark.
6. **Push zones, all 13 lists accounted for.** Grass Valley 7 lists / 35 records, Mountain of Souls 4 / 9 (all `dy = +1`, the slopes the Mushroom Shoes do not stop), the airship deck 1 / 8 (`dy = +1`), the seabed current 1 / 2 (`dx = -4`): 54 records, 52 of 1 pixel and two of 4. `FinishPlayerMove` applies a push as a second move through `MoveActorWithTileCollision` (clipped by walls) and skips the corner slide. The walkthrough's "you can only slow the current by holding Right" and "you can recross the conveyor belt, but it'll be rather slow" follow from the arithmetic if the walk step is 2 pixels per frame (OQ-I032-15).
7. **The ice is a script, not an engine feature.** `ms_obj_ice_slide_022007` moves the hero 2 pixels per frame with `Cop2F` (no collision) and asks `Cop21`-`Cop24` or `ms_obj_ice_tile_blocked_0221FA` for a wall at every tile line; the Mushroom Shoes are an item test (`Cop19`, item `$22`).
8. **Hazard floors use BG1 ids, not types** (`IsPlayerOnMetatile`: ids `$80`, `$F3`, `$E1`, `$88`, `$47`), each behind an item test; the type byte is also used as state (the lair NPC marker `$01`, the Purple Fish and the pop-up turret read a byte over and over).
9. **No hit moves anyone by itself.** No store to `$00`-`$06` in `engine_combat_hits.asm` or in `Cop39_DamagePlayer`; the "knocked back" wording of the notes in `engine_combat_hits` and `mc_castle_dungeon_actors` is OQ-I047-6.
10. **DISCREPANCY (OQ-I047-5).** The walkthrough's `0x008A24` is a ROM address (the operand high byte of `LDA $0016, X` in `StepActorMotion`), not RAM; its Game Genie code 2264-6FD4 decodes (standard SNES scramble) to `$04:8222`, a different place. Not checked in an emulator.
11. **Part-note errors corrected with `merge`:** `mc_deck_push_zone_records_02702B` said "6-byte records" (they are 8 bytes, as `ScanPushZones` steps Y by 8 and the WRAM map says); `unk16_0FA5AE` said the layout was "not verified in the push code" (it is, statically).
12. **Counts recorded:** 71 of 469 meta types with `$1000` at spawn, 13 push lists and 54 records, 117 distinct labels cited.

## Open questions

OQ-I047-1 (a walker stopped by a footprint is not marked blocked), OQ-I047-2 (type values of the shipped maps), OQ-I047-3 (box size of the hero's frames), OQ-I047-4 (which actors use the one-point probe), OQ-I047-5 (DISCREPANCY: walk-through-walls cheat), OQ-I047-6 (the "knocked back" wording), OQ-I047-7 (the edge of the map), OQ-I047-8 (maps of more than 64 pages). Details and Mesen2 tools in `questions/I047_questions.md`.

## Not done / follow-ups

- The breadcrumb links to `docs/code/README.md`, which does not exist yet (the hub is a later PD step); the link is dead until then, as in I043 to I046. **The hub should link this document and should not repeat the type table.**
- The "knocked back" notes (`ApplySwordHit`, `DetectHitSourceCollisions`, `mc_castle_dungeon_actors`) were not changed: the evidence is the absence of a positional write, not a runtime result (OQ-I047-6).
- The walk handlers of the hero and the per-step velocities in `PlayerAnims` were not read (OQ-I032-15, OQ-I047-3).
- No Mesen2 run was made; the claims that rest on static reading are marked.
- `docs/wram-memory-map.md` line for `tile_type_map` could add "quadrant mask" (it says "the collision tile type"); not edited, the hub/refresh step owns that file.

## Gate

| Check | Result |
|-------|--------|
| `npm run rebuild` at the start | SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1081344 bytes, checksum 110070696 |
| `npm run extract:lt` | OK (fresh before the work and after the merge) |
| `npm run merge -- plans/extracted-audit/edits/I047.json --dry-run`, then applied | 2 notes files changed (`partNotes/bank02`, `partNotes/bank0F`) |
| `npm run rebuild` at the end | OK, SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1081344 bytes, checksum 110070696: unchanged (annotation only) |
| `npm run names -- --check` | OK (2765 names; no rename in this step) |
| `npm run merge -- --check` | OK: 1401 comments, 1684 part notes, 135 block notes; 0 errors, 0 warnings, 0 orphans, 0 duplicate keys |
| Backticked labels of the new document | 117 distinct identifiers, each found in `extracted/` |
| Links in the new document | all relative targets exist except the hub `README.md` (see above) |

## Suggested commit message

```
docs: collision and physics (I047)

Add docs/code/collision-and-physics.md: StepActorMotion and the $1000 opt-in,
animation-step velocity and box, the tile type map (quadrant mask, index math,
GetTileType), the four box routines and the one-point probe, actor footprints,
script tile probes, moves that skip collision (Cop9F-CopA1, Cop2F, the ice slide),
push zones (conveyors, current, slopes, ship wind), the corner slide, hazard
floors, and a walkthrough cross-check. Correct two push-zone part notes (8-byte
records). Add I047 questions (one DISCREPANCY: the walk-through-walls cheat),
results and checklist. ROM SHA-1 unchanged.
```

Please commit when you're ready.
