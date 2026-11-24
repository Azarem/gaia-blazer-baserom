# I055 checklist: docs/code/flags-switches-and-inventory-bytes.md

Topic: flags, switches and inventory bytes. `<files>` was not given, so the files are chosen like in I043-I054 (list below). Written before the first edit; the Progress section is updated as items finish.

Rules in force: notes and comments change only through `npm run merge`, names only through `npm run names` (dry-run first); no ad-hoc scripts for notes, comments or names; no commits; no comparison of the original ROM with the rebuilt ROM; every claim cites a label; the walkthrough is the source of truth for game names and facts, the ROM text for exact spelling and behaviour; every mismatch is an OQ with tag DISCREPANCY; record files (`edits/`, `questions/`, `results/`, the document) are written once with the Write tool. Read-only survey scripts (counts of COP operands, decoding of the patch and chest tables) live outside the repository and write nothing into it.

## Scope

Files (all under `extracted/`):

- `library/lib_bit_array.asm` (`SetBitInArray`, `ClearBitInArray`, `TestBitInArray`: all of it)
- `system/cop_core.asm` (`WriteEventFlag`, `TestEventFlag`, `BitMaskTable`, `LookupInventoryEntry`, `RegisterSwitchOwner`)
- `cop_handlers/cop_script_flow_flags.asm` (`Cop05`, `Cop07`, `Cop08`, `CopFlagJumpTail`, `Cop09`, `Cop14`, `Cop3B`), `cop_handlers/cop_items_stats_text.asm` (`Cop0A`, `Cop0B`, `Cop18`, `Cop19`)
- `library/lib_inventory_store.asm` (`StoreInventoryEntry`: all of it)
- `library/lib_boot_and_scene_init.asm` (`InitFixedState`, `InitSceneState`, `ClearSwitchOwnersOnReturn`), `library/lib_scene_asset_loader.asm` (`InitHardwareAndClearWram`)
- `library/lib_map_tile_patches.asm` (`ApplyFlagMapPatches`, `FlagMapPatchTable`, `ShowOpenedChests`, `ApplyReleasedLairRects`, `SetHeldLairTileType`, `InitPlateVariantAtEntry`, `LookupSceneVariant`)
- `library/lib_tile_triggers_and_lair_return.asm` (`TryOpenChest`, `TriggerVariantPlate`, `ReleaseLairAtSwitch`, `PlayLairReleaseScene`), `system/engine_player_death_and_actor_helpers.asm` (`CheckPlayerDeath`, `HoldActorUntilReleased`)
- `system/data_chest_lists.asm`, `system/data_lair_records.asm` (the `+1E` word), `system/player_core.asm` (`FacePlayerTowardReturnTarget`, the one reader of `switch_owner_table`)
- the souls: `souls_flags` writers (`gv_up_above_trial_room_and_lisa_turbo_actors`, `gw_woods_actors_01D045`, `se_seabed_sanctuary_actors_0F8000`, `ll_laboratory_actors`, `mc_castle_actors`), clearers (`RunEnding`, `gv_front_end`) and readers (`lib_hdma_window_effects`, `player_spells_level_up`, `lib_menus`)
- progress scripts: `we_obj_master_shrine_event` (the stones), `gw_woods_actors_01B98D` (Magic Bell), the Emblem and Fairy Gem scripts named in the flag survey

Not repeated (already in the spokes): the COP command set and dispatch (`cop-dispatch.md`), the item and equipment menus, the HUD and the status screen (`menus-inventory-status-hud.md`), the slot format (`save-and-load.md`), lair spawning and sealing, the boss scripts.

## To do

- [x] Fresh `npm run extract:lt` before any edit.
- [x] Read the conventions: notes-and-comments.md, code-bank-documentation.md, doc-audit README, walkthrough README, `items.md`, `sidequests.md`, mapping plan §0 and §8c-8e, the format of I054.
- [x] Survey every COP flag command (05, 07, 08, 09: 480 sites, 114 distinct flags), switch command (14, 3B), item command (0A, 0B, 18, 19) and the three tables (`FlagMapPatchTable` 70 rows, `ChestListPointers` 67 chests, `LairRecords` +1E).
- [x] Read every routine of the topic in the annotated asm; check that no other operand touches `$1A5E-$1B5D` (absolute and immediate forms).
- [x] Cross-check game terms against the walkthrough (Emblems, Stones, Magic Bell, Red-Hot items, Medical Herb and Strange Bottle, souls, equip-to-hand-over).
- [x] Check the existing notes against the code (`RegisterSwitchOwner`, the `lib_bit_array` model note, `InitSceneState`).
- [x] Write `docs/code/flags-switches-and-inventory-bytes.md` in one Write call: breadcrumb, source links, overview with one mermaid diagram (at most 15 nodes), memory map (code, data, state, the bit-number space), `###` sections that answer the Three Questions, walkthrough cross-check, open questions, See Also.
- [x] Write `plans/extracted-audit/edits/I055.json` (note corrections found while writing); `npm run merge -- ... --dry-run`, apply, `npm run extract:lt`.
- [x] Write `plans/extracted-audit/questions/I055_questions.md`.
- [x] Hand edits: link the new spoke from `cop-dispatch.md`, `menus-inventory-status-hud.md` and `save-and-load.md`; `wram-memory-map.md` where the new facts correct a row.
- [x] Verify: every backticked identifier exists in `extracted/` or `us/names/`; every relative link resolves (hub `README.md` excepted); line count 50-900; at most 2 mermaid diagrams with at most 15 nodes; memory-map addresses match `us/names/` after the LoROM conversion.
- [x] Gate: `npm run extract:lt`, `npm run rebuild` (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` unchanged), `npm run names -- --check`, `npm run merge -- --check`.
- [x] Write `plans/extracted-audit/results/I055_results.md` with the gate table and a suggested commit message.

## Progress

- Fresh `extract:lt` done. Facts that shape the document:
  - One 1024-bit space starts at `$1A5E` (`TestBitInArray` masks the bit number with `$3FF`): flags `$1A5E-$1A7D` (bit numbers `$000-$0FF`), chests `$1A7E` (`$100-`), released lairs `$1A9E-$1ADD` (`$200-$3FF`), switches `$1ADE-$1B1D`; the inventory follows at `$1B1E`. `ApplyFlagMapPatches` passes `Y = $1A5E` and the row word as the bit number, so its 33 event rows and 37 lair rows use one table.
  - The COP flag word is the same number split in two: bits 0-7 = bit in byte, bits 8-14 = byte index; flag `$1F02` is bit number `$FA`, `$1F04` is `$FC`, `$1F07` is `$FF`.
  - Byte 0 of the flags is cleared at every scene load (`InitSceneState`, `STZ $event_flags`), all other bytes persist and are saved; `$FF` is set by `InitFixedState` at boot, nothing clears it, so the 13 `FlagMapPatchTable` rows that test it are unconditional.
  - The five flags that scripts only set (`$0502`, `$0601`, `$0706`, `$0907`, `$0A00`) are read as map-patch rows (`$002A`, `$0031`, `$003E`, `$004F`, `$0050`).
  - `$1A0n` = Emblem n taken (A, C, E, F, G, H; B and D come from chests), `$1B0n` = stone n given (`$1B00-$1B05` = items `$3A-$3F`), `$1C00-$1E00` = Fairy Gem rewards paid once.
  - `$1A9E` and `$1ADE` are always set together (all three writer routines), so they are bit for bit equal; `+1E` of a lair record names the release switch of another record in 27 of 420 records.
  - `switch_owner_table` has one reader, `FacePlayerTowardReturnTarget`; its note said "cleared at every scene load", but `ClearSwitchOwnersOnReturn` zeroes it only on a return trip.
  - Handing an item to an NPC is `Cop19` (equipped) followed by `Cop0B`; the walkthrough says "equip the ..." for the Platinum Card, Harp String, Leaves, Dream Rod and Mobile Key.

- Document written and corrected after a re-count of the survey: bytes `$03`-`$04` write 15 flags, bytes `$1C`-`$1E` hold 14 flags (14 reads, 14 writes); the chest row of the bit-space table, the `ShowOpenedChests` wording (a column walk) and the lair writer list (`PlayLairReleaseScene` runs in the NPC's home location) were refined. 356 lines, one mermaid diagram of 14 nodes; the only dead link is the hub `README.md`; all 134 backticked identifiers exist in `extracted/` or `us/names/` (the four hex fragments `D83E`, `D843`, `D888`, `DA28` are address suffixes).
- `edits/I055.json` applied: 5 block and part notes corrected, 5 comments rewritten (`$1B01`, `$0907`, `$0706`, `$0A00`, `$0601`). Dry run had no errors; two length warnings only.
- New finding while checking `ShowOpenedChests`: the redraw walks the chest column down the map, and `ChestListLoc2B` has two chests in one column twice (OQ-I055-3).
- Hand edits done in `cop-dispatch.md` (section "Event flags and switches" and See Also), `menus-inventory-status-hud.md`, `save-and-load.md` (See Also) and `wram-memory-map.md` (rows `switch_owner_table`, `event_flags`, the A4 note on the arrays).
- Gate passed: `extract:lt` OK, `rebuild` SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` (1,081,344 bytes, checksum 110070696), `names --check` OK (2765 names), `merge --check` OK (0 errors, 0 warnings, 0 orphans).
