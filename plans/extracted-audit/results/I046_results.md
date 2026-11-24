# I046 results: `docs/code/scene-area-warp-loading.md` (scene, area and warp loading)

PD step of the plan "Blazer docs and analysis", topic "scene, area and warp loading (asset list, spawn tables, bank layout)". The prompt left `<files>` empty; I chose the files that make up the topic (see Sources), as in I043 to I045. Work started from a fresh `npm run extract:lt`; the gate was run at the end. The plan checklist is `plans/doc-audit/I046_checklist.md`.

## Deliverables

| File | What |
|------|------|
| `docs/code/scene-area-warp-loading.md` | New topic document (369 lines): breadcrumb, source links, overview with two mermaid diagrams (the request to `InitSceneState` pipeline; the key model `(area, scene)` against `location_id` with `LocationAreaScene` as the bridge), memory-map tables (code, data, state), 22 `###` sections (who writes `scene_next`, scene identity, `ChangeSceneIfRequested`, transitions and the iris, `InitSceneState`, record and command format, shared segments, pointers, cache and skip mask, the loaders, music, Quintet LZ, `ApplySceneProfile`, `LookupSceneVariant`, placement tables, scene-load patches, exit regions, arrival, `Cop10` and `Cop3C`, return trip, bank layout), a worked example (the Grass Valley Shrine), a walkthrough cross-check table, open questions and See Also. |
| `plans/extracted-audit/renames/apply-I046_names.json` | 7 sub-label renames in `CheckExitRegions` and `ReleaseLairAtSwitch`, applied with `npm run names` (`bank01.json`). |
| `plans/extracted-audit/edits/I046.json` | Merge spec: one block-note correction in `lib_scene_asset_loader`. |
| `plans/extracted-audit/questions/I046_questions.md` | OQ-I046-1 to OQ-I046-5 (all GAP). |
| `plans/extracted-audit/results/I046_results.md` | This file. |
| `plans/doc-audit/I046_checklist.md` | The checklist with its progress section. |
| `docs/code/boot-nmi-main-loop.md`, `docs/code/actor-system.md`, `docs/code/cop-dispatch.md`, `docs/areas-and-scenes.md` | One See Also line each (the planned "scene loading" spoke is now written). Edited by hand; no notes, comments or names. |

Sources documented: `lib_scene_asset_loader` (all loaders, `FindSceneRecord`, `FindAssetLabel`, `ReadAssetPointer`, `CheckAssetCache`, `ApplySceneProfile`, `DecompressQuintetLz`), `lib_boot_and_scene_init` (`ChangeSceneIfRequested`, the transitions, `InitSceneState`, `BuildTileTypeMap`), the data tables `data_scene_asset_lists`, `lib_scene_profile_data`, `data_scene_variant_rules`, `data_scene_placements`, `data_exit_lists`, `data_chest_lists`, `data_plate_lists`, the scene-load patches of `lib_map_tile_patches`, `lib_tile_triggers_and_lair_return` (`CheckExitRegions`, `ReleaseLairAtSwitch`, `LocationAreaScene`), `SpawnSceneActors` and `SpawnPlacementList`, `Cop10_SetNextScene` and `Cop3C_SetTransitionType`.

## Findings

1. **`asset_skip_mask` note was wrong in two places.** The block note of `lib_scene_asset_loader` said "an actor that warps inside a world writes `$0020` ... 15 writer sites in 13 files". `rg` over `extracted/` finds 15 `STA` sites in 10 files (the clear is the single `STZ` of `InitSceneState`), and the writers are cutscene scripts plus `ReleaseLairAtSwitch`; several warps leave the world (the Phoenix scene of the Soul of Mountain House goes to the World of Evil, the Master's Shrine event to the hub and the castle town). Corrected with `npm run merge` (`edits/I046.json`).
2. **Three word encodings of a scene.** The `Cop10` operand and `LocationAreaScene` are `#$SSAA` (area low), `scene_next` is `#$AASS` (scene low, `$0318`), an exit row stores two separate bytes. `Cop10_SetNextScene` converts with `XBA`; `ReleaseLairAtSwitch` copies the bytes of `LocationAreaScene` one at a time. Now stated in the document.
3. **Every `scene_next` writer accounted for (8):** `Cop10_SetNextScene` (65 sites), `CheckExitRegions`, `StartLairReturnTrip`, `WaitReturnDone`, `HandleFileSelectChoice`, `PlayPlayerDeath`, the Master's Move helper `cm_npc_master_move_to_hub_0076B2` and `BootGame` (`$000C`); `ChangeSceneIfRequested` is the only clear.
4. **Key model verified.** The 97 asset records, the 97 `ScenePlacementIndex` rows, the 97 non-zero exit pointers and the non-empty words of `LocationAreaScene` are the same 97 scenes, and the first `asset8` id of every record is the location of the scene. The world shrines are `LocationAreaScene` area 0, scene `world_index + 1`, which is why death and Continue use `world_index + 1`.
5. **Exit-region pixel test in numbers.** `TestExitPixels` compares `player_x - x × 16` with `width × 16 - 15` and `player_y - (y × 16 + 16)` with `height × 16 - 15`, so a 1 × 1 region fires only at one exact pixel and a 2-wide region over 17 pixels. The arrival point (`warp_dest_y + 16`) is by construction one tile inside the partner region, never in it: checked on the Grass Valley Shrine and highlands pair, the Trial room pair and the painting entrance.
6. **Shared segments.** All 65 jumps are the last command of their record (a jump never returns); the only label that no jump reaches is `$DE`, in the record of area `$12`, scene 1; label `$DA` (area 0, scene 1) is reached by six jumps `$9A`. The first record is the dummy `(area $53, scene $59)`.
7. **Variant priority.** `ApplySceneProfile`: an actor request wins, then a `SceneVariantRules` row, then bits 6 and 7 of profile byte 11; with the first two, `ProfileKeepVariant` strips those bits. The six boss lairs are the switch numbers of the variant rules.
8. **Walkthrough cross-check agrees** (no DISCREPANCY): the three exits of the Grass Valley Shrine (west to the Trial room, south to the highlands, east to Leo's Paintings) match chapters 01 and 06; the west and east exits of the GreenWood Shrine (Lostside, Light Shrine) match chapters 06 to 08; a new game starting in the shrine matches chapter 01 if "carry set" means a new game (OQ-I024-5). The seven shrine room names ("Grass Valley Shrine" and so on) against the walkthrough's "Master's Shrine" are the crosswalk class C naming difference.
9. **Counts recorded:** exit lists 97 (78 with rows, 201 rows, 19 empty of which one is `ExitListUnreferenced`; locations `56` and `5A` share a list); plates only in locations `01`, `29` and `65`; 60 of 97 chest lists are `ChestListEmpty`; asset commands 107 graphics, 109 palette, 62 tileset, 135 tilemap, 65 music, 47 spritemap; 913 placement rows.
10. **Bank layout written down:** tables of bank `$01` are read with 16-bit addresses from banks `$00` and `$02` (DBR = `$01`), tables of bank `$02` with long addresses, the asset list through the long pointer dp`$2F`-`$31` (`movable`), pointers as file offsets; a compressed stream cannot cross a bank by static reading (OQ-I046-3).

## Open questions

OQ-I046-1 (the byte after `world_index` read by `PlayPlayerDeath` and `SaveGameToSlot`), OQ-I046-2 (the hub's music after the Master's Shrine event with `asset_skip_mask` set), OQ-I046-3 (compressed assets inside one bank, and the rebuild), OQ-I046-4 (the walkthrough's four squares against the three exit rows of a shrine), OQ-I046-5 (what the four hero-less placement lists are). Details and Mesen2 tools in `questions/I046_questions.md`. Earlier questions the document relies on: OQ-I024-5, OQ-I011-1, -3, -5, -8, -10, OQ-I033-5, OQ-I044-5.

## Not done / follow-ups

- The breadcrumb links to `docs/code/README.md`, which does not exist yet (the hub is a later PD step); the link is dead until then, as in I043 to I045.
- Renames: only the 7 sub-labels the document cites were renamed. `CheckPlayerTileTriggers`, `TriggerVariantPlate`, `PlayLairReleaseScene` and `RunLairReleaseOnReturn` still hold many `loc_xxxxxx` sub-labels.
- The counts of `Cop10` sites (65), `Cop3C` sites (23) and the asset command totals come from the existing notes; I re-counted the jumps (65), the exit lists and rows, the label definitions and the `asset_skip_mask` writers, not every other number.
- The walkthrough's "southwest" direction of the Trial room exit was not checked against the map (row at tile (4, 10)).
- No Mesen2 run was made; the claims that rest on static reading are marked (OQ-I046-1, -2, -3, -4).
- `docs/code/README.md` should list this document once the hub is written.

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK (fresh before the work, after the names step, after the merge and at the end) |
| `npm run names -- apply-I046_names.json --dry-run`, then applied | 7 renames, `bank01.json` only |
| `npm run merge -- plans/extracted-audit/edits/I046.json --dry-run`, then applied | 1 extracted file, 1 notes file changed (`blockNotes/bank01`) |
| `npm run rebuild` | OK, SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1081344 bytes, checksum 110070696: unchanged (annotation and rename only) |
| `npm run names -- --check` | OK (2765 names; 2758 before + 7) |
| `npm run merge -- --check` | OK: 1401 comments, 1684 part notes, 135 block notes; 0 errors, 0 warnings, 0 orphans, 0 duplicate keys |
| Backticked labels of the new document | 186 distinct tokens, each found in `extracted/` except `movable` (a key of `us/blocks.json`) |
| Links in the new document | all relative targets exist except the hub `README.md` (see above) |

## Suggested commit message

```
docs: scene, area and warp loading (I046)

Add docs/code/scene-area-warp-loading.md: scene_next writers, ChangeSceneIfRequested
and transitions, InitSceneState order, the asset list and its loaders, scene profile
and variant rules, placement/exit/chest/plate tables, scene-load patches, exit
regions, arrival, Cop10 and the lair return trip, bank layout, and a worked example
checked against the walkthrough. Rename 7 sub-labels in CheckExitRegions and
ReleaseLairAtSwitch; correct the asset_skip_mask note (15 sites in 10 files, cutscene
warps that keep the music). Add I046 questions, results and checklist. ROM SHA-1
unchanged.
```

Please commit when you're ready.
