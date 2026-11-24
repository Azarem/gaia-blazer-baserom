# Soul Blazer WRAM memory map

*Part of the [Soul Blazer Documentation](README.md) · code hub: [Soul Blazer Code Documentation](code/README.md)*

Source: `us/mnemonics.json` (Pass 5). Every name below has one sentence of evidence taken from the extracted code
(`extracted/`); an address with no verified meaning stays unnamed and is listed in §8. Addresses are SNES
addresses (WRAM mirror `$0000-$1FFF`, or long `$7E/$7F`); the keys in `mnemonics.json` are the same numbers in
decimal.

## 1. How names reach the extracted code

- The baserom builds `mnemonics = { ...snes.vectors, ...mnemonics.json }`. **Hardware registers** (`INIDISP`,
  `VMADDL`, `DMAPx`, `APUIO0`, ...) come from `gaia-core/snes/vectors.json`; they print only where the extractor
  knows the data bank. `us/overrides.json` supplies that with `"B": 1` at `LoadSceneAssets` (78758) and `InitHardwareAndClearWram`
  (80300), both entered with DBR = `$01` (the reset code does `LDA #$01 / PHA / PLB`); the SPC upload routine
  `UploadSpcStream` inherits it through its `JSL` caller. After that no `$21xx`, `$42xx` or `$43xx` operand is left raw
  in `extracted/`.
- A name is printed only for an **absolute** operand (`LDA $0312`, `LDA $7F8000, X`). Immediates
  (`LDY #$1ADE`, `CPY #$06AA`) and **direct-page** operands (`LDA $38`) are never resolved, so neither can be
  named; the direct page is documented in §5 only.
- `rng_state+1` is the engine's `name+N` form: it prints `$rng_state+1` for `$0302`.
- Absolute operands below `$0100` with an index register (`LDA $0016, X`) are actor-slot fields, not globals (§4).

## 2. System, input and frame state

| Address | Name | Evidence |
|---|---|---|
| `$0301`-`$0311` | `rng_state` | 17-byte generator state: `StepRandomState` and `cop_script_flow_flags` add neighbouring bytes (`$rng_state+1,X` + `$rng_state,X`, X counting down) and then increment from `$0311` with carry. |
| `$0302` | `rng_state+1` | `StepRandomState` returns `LDA $rng_state+1` as the random byte (44 reads in total). |
| `$0312` | `frame_counter` | `INC $frame_counter` once per NMI (`engine_vblank_nmi`); its bit 0 selects odd/even frame work. |
| `$0322` | `joy_pressed` | The NMI joypad code stores `JOY1L` masked by `joy_block_mask` and the release latch here. |
| `$0326` | `joy_block_mask` | NMI does `EOR #$FFFF / AND` with it before writing `joy_pressed`; actors set and clear bits with `TSB`/`TRB` (123 uses). |
| `$032A` | `joy_release_latch` | NMI ORs the inverted current buttons into it; actors clear the bit of a consumed button with `LDA #$4000 / TRB` (`$4000` and `$8000` seen). |
| `$032E` | `scene_active` | `ChangeSceneIfRequested` zeroes it at the start of a scene load and increments it when the scene is built; `RunAppearPuff` skips its work while it is 0. |
| `$0437` | `random_mod_result` | `Cop35_RandomMod` stores its result here; scripts read it back (10 reads). |
| `$03D0` | `choice_result` | `Cop1A_ChoiceMenu` stores the player's choice here (its only write); 25 reads test it. |
| `$0445` | `file_select_request` | `gv_obj_title_start_button_006B61` sets it to 1 when Start is pressed on the title; the title actor of `gv_front_end` hands over to `EnterFileSelect` on it, and `engine_title_file_select` clears it once a slot is chosen ([code/save-and-load.md](code/save-and-load.md)). |
| `$0482` | `front_end_step` | Step counter of the `gv_front_end` sequences (20 sites in that file, 2 in `engine_unreferenced_code`). Title: 0, set to 1 when the prologue starts, `$FFFF` while the title restarts (the sprite actors end on it). Ending: 0, 1 when the BG1 scroll has finished, then 2, 3 and 4 as the two ending sprites and the main actor advance the animation steps ([code/boot-nmi-main-loop.md](code/boot-nmi-main-loop.md)). |

## 3. Scene, area, scrolling and player

| Address | Name | Evidence |
|---|---|---|
| `$0314` | `area_current` | Debug dump `DebugShowPosition` prints it as the area; `lib_tile_triggers_and_lair_return` room entry stores it into `return_area`. (`mnemonics.json` previously keyed `$0300`, an unreferenced address.) |
| `$0316` | `scene_current` | Same debug dump prints it as the scene; `lib_tile_triggers_and_lair_return` room entry stores it into `return_scene`. |
| `$0318` | `scene_next` | A non-zero value starts `ChangeSceneIfRequested` (`LDA $scene_next / BEQ`); low byte = scene. |
| `$0319` | `area_next` | High byte of the `$0318` word: `lib_tile_triggers_and_lair_return` writes it with an 8-bit `STA $area_next` next to `scene_next`. |
| `$1C6A` | `location_id` | Debug dump prints it next to the area/scene; `lib_tile_triggers_and_lair_return` compares it with the first byte of each 32-byte `LairRecords` record, and area actors compare it with constants. |
| `$033A` / `$033C` | `scroll_bg1_x` / `_y` | NMI `WriteScrollPair` writes `$scroll_bg1_x, X` / `$scroll_bg1_y, X` (X = 0) to `BG1HOFS`/`BG1VOFS`; `lib_map_scroll_and_redraw` moves it with the player. |
| `$033E` / `$0340` | `scroll_bg2_x` / `_y` | The same helper called with X = 4, Y = 2 sends this pair to the BG2 scroll registers. |
| `$0386` / `$0388` | `scroll_bg3_x` / `_y` | `WriteScrollRegisters` writes `$scroll_bg3_x` to `BG3HOFS` (the Y word goes to `BG3VOFS`). |
| `$0342` / `$0344` | `map_width_px` / `map_height_px` | Actors compare their position against them (`CMP $map_width_px` in `cop_conditions`, `gw_lostside_marsh_enemies`, ...); `InitSceneState` fills them from the scene header. |
| `$0343` / `$0345` | `map_width_pages` / `map_height_pages` | High bytes of the two words, read as page counts (`InitSceneState` loads them from `MapPatchRectsAndMapSizes+28/+29`). |
| `$0374` / `$0376` | `player_x` / `player_y` | Pixel position copied from the player actor (`STA $player_y` after `LDA $0002,X`); the debug dump prints both. |
| `$0378` / `$037A` | `player_tile_x` / `_y` | Stored after two `LSR`s of the pixel X (`player_core`); `lib_tile_triggers_and_lair_return` compares `player_tile_x` with trigger-table bytes (`ChestListPointers`). |
| `$037C` / `$037E` / `$0380` | `warp_dest_x` / `_y` / `_anim` | `lib_tile_triggers_and_lair_return` and `cop_script_flow_flags` store the arrival position and animation from the exit tables (`ExitListPointers`, `LairRecords`); the return path copies `return_x`/`return_y` into them (`engine_boot_main_loop`). |
| `$039C` | `player_actor` | `LDY`/`LDX $player_actor` (56 uses) loads the player's actor slot address; `$039E` (`player_weapon_actor`) and `$03A0` (`soul_orb_actor`) follow it (section 7c). |
| `$03E3` | `transition_type` | `Cop3C_SetTransitionType` stores its operand here and `lib_tile_triggers_and_lair_return` stores `$80`; the loader (`PlayTransitionOut`, `PlayTransitionIn`) branches on bit 7 and `lib_boot_and_scene_init` zeroes it afterwards. |
| `$03FB` | `return_active` | `lib_tile_triggers_and_lair_return` does `INC $return_active` after storing the return point; `ClearSwitchOwnersOnReturn`, `Cop30_SpawnIfEnteredViaRecord` and the player actor test it (14 uses). |
| `$03FD` / `$03FF` / `$0401` / `$0403` | `return_area` / `_scene` / `_x` / `_y` | `lib_tile_triggers_and_lair_return` stores `area_current`, `scene_current` and the player position; the return path in `engine_boot_main_loop` copies them to `area_next`, `scene_next`, `warp_dest_x`/`_y`. |

## 4. Actor system

| Address | Name | Evidence |
|---|---|---|
| `$0800` + `n*$40` | actor slot table | Slots are 0x40 bytes wide (`InitSpawnedActor` clones the first `$3C` bytes of the caller); fields in `docs/cop/index.md` §2. |
| `$06A6` | `actor_list_tail` | First actor in run order: `RunActors` and the bulk kills start here and follow `$3E`; `SpawnActorAfter` and `Cop86_KillSelf` update it (9 uses). |
| `$06A8` | `actor_list_head` | Last actor in run order: `CullAndSortActors` starts here and follows `$3C`; `SpawnPlacementList`, `SpawnActorBefore` and `Cop86_KillSelf` update it (5 uses). |

`$06AA` is the scratch slot returned when the free-slot stack (`$4A`) is empty, and `$1ADE` is the switch bit
array; both are only ever loaded as immediates (`LDY #$06AA`, `LDY #$1ADE`), which the extractor never names, so
they carry no mnemonic (documented here and in `docs/cop/index.md`).

Actor fields (accessed as `$00xx, X`, or with D = slot): `$00/$02` position, `$10/$12` size, `$14` wait counter,
`$16` flags (bit 15 set = off screen), `$18` resume pointer (`$36` bank), `$1A` attribute flags, `$1C` OAM attribute word,
`$1E/$20` animation, `$30` data word, `$3C/$3E` list links (`$3C` toward the tail = earlier in run order, `$3E` toward the
head). Evidence and open fields (OQ-I001-4) are in `docs/cop/index.md` §2; the pool, the list and the scheduler are in
`docs/code/actor-system.md`.

## 5. Direct page

The extractor does not resolve direct-page operands, so there are no direct-page mnemonics. Verified roles:

| DP | Role | Evidence |
|---|---|---|
| `$38` / `$3A` | COP script pointer | `HandleCop` reads the opcode through it; handlers advance it past operands (`LDA [$38]`). |
| `$18` + `$36` | actor resume pointer and bank | `Cop1B_DelayThenGoto` / `Cop27_YieldThenGoto` write them before yielding. |
| `$4A` | free-slot stack pointer | `cop_core` pops a free slot from it. |
| `$42` | HDMA enable shadow | NMI does `LDA $42 / STA $HDMAEN`; `ChangeSceneIfRequested` clears it while loading. |

## 6. Video, DMA and buffers

| Address | Name | Evidence |
|---|---|---|
| `$03B8` | `vram_upload_flags` | NMI tests bit 0 / bit 1 to DMA the tilemap buffers to VRAM `$5800` / `$5C00`; 20 `TSB` and 17 `STA` set it elsewhere. |
| `$03B6` | `tile_dma_pending` | `DmaDynamicSpriteTiles` returns when it is 0; `DmaSpriteTileRecords` DMAs the records then does `STZ $tile_dma_pending`; the queue builder in `engine_actor_scheduler_and_sprites` increments it. |
| `$1A06` | `tile_dma_list` | `DmaSpriteTileRecords` walks it (`LDX $tile_dma_list, Y / BEQ`) and loads each non-zero entry into `A1T2L`. |
| `$03DD` / `$03DF` / `$03E1` | `vram_strip_src` / `_dest` / `_pending` | `DmaAnimatedTileStrip` DMAs from `$vram_strip_src` to the VRAM address stored at `$vram_strip_dest`, then `STZ $vram_strip_pending`; `lib_main_loop_helpers` sets the source. |
| `$1C7B` | `vram_write_queue` | NMI `FlushVramWriteQueue` points the stack at `$1C7A` and pops (VRAM address, data) word pairs into `VMADDL`/`VMDATAL` until an address of 0, then zeroes the first word; `lib_map_tile_patches`/`lib_map_scroll_and_redraw` push the pairs. |
| `$0486` | `oam_buffer` | NMI OAM DMA reads `$0220` bytes from it. |
| `$7F0000` | `cgram_buffer` | NMI CGRAM DMA reads `$0200` bytes from it. |
| `$7F0200` | `coldata_buffer` | NMI writes `COLDATA` from `$7F0200`-`$7F0202`. |
| `$7F7000` | `bg3_tilemap_buffer` | NMI tilemap DMA source for VRAM `$5800` when `vram_upload_flags` bit 0 is set (`$7F7800` goes to `$5C00` for bit 1); `BG3SC` = `$58` in `ApplyBootPpuLayout`. |
| `$7F8000` | `tile_type_map` | 43 uses; the low nibble of each byte is the collision tile type (`$F0` marks blocked, see `Cop15_BlockOwnTiles`). |
| `$7F0483` | `switch_owner_table` | `Cop14_JumpIfSwitchSet` registers the actor slot id per switch id here (`RegisterSwitchOwner`). Zeroed only on a return trip (`ClearSwitchOwnersOnReturn`); its one reader is `FacePlayerTowardReturnTarget`. |

## 7. Game state

| Address | Name | Evidence |
|---|---|---|
| `$1A5E` | `event_flags` | `Cop05_WaitWhileFlagEquals` / `Cop07` / `Cop08` test and set it (flag word: low byte = bit, high 7 bits = byte index). Byte 0 is cleared at every scene load; see [code/flags-switches-and-inventory-bytes.md](code/flags-switches-and-inventory-bytes.md). |
| `$1B1E` | `inventory` | Byte array indexed by `operand - 1` (bit 7 flag, bits 0-6 value); item commands read and write it. |
| `$1B86` | `player_level` | New-game init (`lib_boot_and_scene_init`) stores 1; level-up `WatchForLevelUp` does `INC $player_level`. |
| `$1B6A` | `player_level_bcd` | Same init stores 1; `WatchForLevelUp` increments it with `SED / ADC #$0001` (decimal level for display). |
| `$1B78` / `$1B7A` | `player_exp` / `player_exp+2` | Eight BCD digits in two words (low word `$1B78`, high word `$1B7A`): `cop_items_stats_text` and `lib_player_helpers.AddExp` add rewards with `SED / ADC`, and `AddExp` sets both words to `$9999` on overflow, so EXP maxes at 99,999,999 (walkthrough `level-up.md` agrees); `WatchForLevelUp` subtracts `player_exp_next` from it. An earlier version of this table said 24-bit BCD (OQ-I031-4). |
| `$1B7C` / `$1B7E` | `player_exp_next` / `player_exp_next+2` | Eight BCD digits in two words: `WatchForLevelUp` loads the low word from `data_engine_tables.LevelExpThresholds+2,Y` and the high word (`$1B7E`) from `LevelExpThresholds,Y` (4 bytes per level; walkthrough: the threshold of level 50 is 99,999,999). |
| `$1B88` | `player_hp` | New-game init stores 8; `cop_items_stats_text` subtracts damage from it and level-up adds 2 (`WatchForLevelUp`). |
| `$1B8A` | `player_max_hp` | New-game init stores 8; `cop_items_stats_text` computes `player_max_hp - player_hp` into `$043B`. |
| `$1B90` | `saved_scene` | `lib_save_system.SaveGameToSlot` stores `world_index + 1` here before it copies the image; `HandleFileSelectChoice` loads it into `scene_next` when a slot is chosen (scene 1 to 7 of area 0 are the shrines of the worlds; [code/save-and-load.md](code/save-and-load.md)). Inside the saved image `$1A5E-$1C57`. |
| `$1B5E` / `$1B60` / `$1B62` / `$1B64` | `equipped_weapon` / `_armor` / `_magic` / `_bracelet` | The equipment menu in `lib_menus` stores the chosen id into each of them (`STA $1B5E` ... `STA $1B64`); `RecalcGearStats` indexes `GearStatTable` with the weapon and armor ids. |
| `$1B70` / `$1B74` | `gear_power` / `gear_defense` | `RecalcGearStats` sets `gear_power` = `GearStatTable[weapon]` + `GearStatTable[armor]` and `gear_defense` the same sum from the second half of the table (`+11`). |
| `$1B72` / `$1B76` | `level_power` / `level_defense` | Read and written by the level-up code in `lib_menus`; added to the gear values by the player code. |
| `$1B8C` / `$1B8E` | `attack_current` / `defense_current` | The player code stores `gear_power` (or `gear_power + level_power` while the actor animation is 20-23) in `attack_current`, and `gear_defense + level_defense` in `defense_current`. |

## 7b. Engine state (batch A1)

| Address | Name | Evidence |
|---|---|---|
| `$0330` / `$0336` / `$0338` | `enemy_gauge_timer` / `_hp` / `_max` | `SetEnemyGauge` stores the enemy HP after the hit and its max HP (meta entry +2), then `$80` into the timer; the HUD gauge string reads them (OQ-I023-2 asks for the runtime timer). |
| `$0332` | `hud_dirty_flags` | Five dirty bits (`$1F` = all, stored by the menus and scene init): the HUD routine `UpdateHud` shifts them out with `LSR` and redraws the part of each set bit, then clears the word. The hit code sets `$02` and `$04`, pickups `$10`. |
| `$0398` | `sound_request` | Filled by the BRK handler; the NMI sends it to `APUIO2` on even frames and clears it. `HandleBrk` stores `BRK #n` here when bit 6 of `n` is clear and `n and $BF` into `$0399` (the high byte of the word) when it is set. The low byte is the request for SFX voice 7 (`APUIO2`), the high byte for voice 8 (`APUIO3`), bit 7 of the low byte means both voices ([code/spc-interface.md](code/spc-interface.md), OQ-I024-1). |
| `$03A6` | `subframe_active` | `RunSubFrame*` do `INC` before and `STZ` after the work phase; `RunActorList` then runs only actors with `$16` bit `$0010`. |
| `$03B0` | `meta_table_offset` | `SpawnSceneActors` stores the world's list offset inside `WorldMetaPointers`; the spawn code adds it to the meta index. |
| `$03BA` | `world_index` | Indexes the per-world pointer table of `WorldMetaPointers`; also read by the save code. |
| `$03D2` | `nmi_enabled` | `EnableNmi` increments it, `DisableNmi` clears it. |
| `$03DB` | `bg_scroll_swap` | When non-zero, `WriteScrollRegisters` writes the BG2 scroll pair to BG1 and the BG1 pair to BG2. |
| `$042D` | `contact_lock` | Non-zero skips `DetectPlayerContact` for the frame; the lair code increments it. |
| `$043B` | `heal_pending` | `RunReturnLoop` adds `player_max_hp / 8`; the HUD update plays the refill. |
| `$0462` | `scene_loading` | Non-zero skips the HUD in `RunSubFrameLoader`; set by the iris transition in the scene loader. |
| `$0468` | `joy_override` | Non-zero skips the joypad read in the NMI and keeps the scripted value in `joy_pressed`. |
| `$1900` | `draw_list` | `CullAndSortActors` pass 1 writes (key, slot) pairs here; pass 2 pops them. |
| `$1F00` | `actor_run_count` | `RunActors` clears it, and `RunActorList` increments it for every actor it visits; the debug position display shows it. |

## 7c. Engine state (batch A2)

| Address | Name | Evidence |
|---|---|---|
| `$039A` | `boss_actor` | Each boss script starts with `STX $boss_actor` (`gv_boss_metal_mantis`, `ll_boss_tin_doll`, `ms_boss_poseidon`, `mc_boss_demon_falcon`, `se_boss_floating_skull`, ...) and later loads it with `LDY $boss_actor` to reach the boss; `lib_boot_and_scene_init` initialises it together with the two actor slots below. |
| `$039E` | `player_weapon_actor` | `player_core` stores the weapon actor's slot with `STY $player_weapon_actor` (offset 6752) and loads it back (`PlayPlayerDeath`, offset 7898); `cop_actor_fields_animation` and `lib_player_helpers` read it too. |
| `$03A0` | `soul_orb_actor` | `player_core` stores the soul orb's slot with `STY $soul_orb_actor` (offset 6734); `player_spells_level_up` loads it 7 times and `cop_actor_fields_animation` also reads it. |
| `$03A4` | `save_slot` | `HandleFileSelectChoice` stores the chosen slot 0-3 (offset 27936); `DrawSaveSlotMenu` clears it (`STZ`) and increments it once per slot it lists; `lib_save_system` reads it 3 times. |
| `$0425` / `$0427` / `$0429` / `$042B` | `boss_box_x` / `_y` / `_w` / `_h` | `RunBossDeath` stores the boss's box (position minus extents, width and height); `RunBossExplosion` reads all four to place each explosion. |
| `$043F` | `player_died` | `MarkPlayerDead` increments it; `shared_actor_helpers_bank0` tests it and clears it (`STZ`). |
| `$046A` / `$046C` | `m7x_shadow` / `m7y_shadow` | `WriteMode7Matrix` writes them (low byte, then high byte) to `M7X`/`M7Y`. No code in `extracted/` writes them, so the centre stays at its initial value. |
| `$046E` / `$0470` / `$0472` / `$0474` | `m7a_shadow` / `m7b_shadow` / `m7c_shadow` / `m7d_shadow` | `WriteMode7Matrix` writes them to `M7A`-`M7D`; `UpdateTitleMode7` copies the new matrix into them after the write. |
| `$0476` / `$0478` / `$047A` / `$047C` | `m7_matrix_a` / `_b` / `_c` / `_d` | `BuildRotationMatrix` stores the middle and high bytes of the PPU multiplier result (`LDY $MPYM`) in each. |
| `$047E` | `m7_angle` | `BuildRotationMatrix` loads it once (`LDX $m7_angle`) as an 8-bit index into the sine and cosine tables (`SineTable`, `SineTableTail`); no code in `extracted/` writes it (OQ-I024-4). |
| `$0480` | `m7_scale` | `BuildRotationMatrix` multiplies each table byte by it (four `LDY $m7_scale`); `gv_front_end` stores and reads it (offsets 26427-27164). |
| `$1B66` / `$1B68` | `gems_low` / `gems_high` | `lib_player_helpers` adds into them in BCD (`AddGems`, `ADC $gems_low`, `STA $gems_high`); `ZeroGemsAndDie` clears both (the no-item death penalty). |
| `$1B82` | `souls_flags` | Bit mask of the recruited souls (`$01` Magician, `$02` Light, `$04` Shield, `$08` Detection, `$10` Reality; OQ-I006-10): world actors OR a bit in (`ORA #$02` in `gw_woods_actors_01D045`), `lib_hdma_window_effects` tests `$02`, `$10`, `$08` and `$04` (`AND #$0002` etc.), `RunEnding` tests the low five bits and clears it (`STZ`). |
| `$7F0203` | `lair_state` | Byte table indexed by lair number: `SpawnLairActor` loads it into the lair's `$2E` and `$2F`, `SyncLairCount` stores 0 in it when the lair is cleared, `HoldActorUntilReleased` clears bit `$40`; `lib_boot_and_scene_init` (new-game init), `lib_tile_triggers_and_lair_return` and `lib_map_tile_patches` also access it. |

## 7d. Engine state (batch A3, COP handlers)

| Address | Name | Evidence |
|---|---|---|
| `$0405` | `return_record` | The return-trip warp in `lib_tile_triggers_and_lair_return` stores the lair record index here and increments `return_active` (`$03FB`); `Cop30_SpawnIfEnteredViaRecord` compares its word operand with it (32 scripts). |
| `$043D` / `$043E` | `exp_pending` | `Cop38_QueueExp` stores the BCD amount (13 scripts); `lib_player_helpers.DrainPendingExp` pays it into `$1B78`/`$1B7A` one digit step per 8 frames. |
| `$0458` | `boss_fight_active` | The boss scripts increment it when the fight starts, the switch-tile code in `lib_tile_triggers_and_lair_return` reads it, `MusicLoadFinish` and the scene init zero it. |
| `$0464` | `player_hidden_count` | `Cop34_HidePlayerActors` increments it, `Cop33_ShowPlayerActors` zeroes it, and `player_core` clears `joy_pressed` while it is non-zero (OQ-I025-10). |

Also documented by the A3 notes without a mnemonic: `$1ADE` is the switch bit array (indexed by the lair record index of `LairRecords`, set by `HoldActorUntilReleased`, tested by `Cop14`/`Cop3B`); `$0422` and `$0424` hold copies of the long pointer `MusicLoadUpload` takes from `MusicPointerTable`.

## 7e. Scroll, map and lair state (batch A4)

Per-layer tables are word pairs: X = 0 selects the BG1 entry, X = 4 the BG2 entry (`$ratio_x_bg1, X` with X = 4 reads `ratio_x_bg2`), the same convention as `scroll_bg1_x`.

| Address | Name | Evidence |
|---|---|---|
| `$034A` / `$034C` / `$034E` / `$0350` | `ratio_x_bg1`, `ratio_y_bg1`, `ratio_x_bg2`, `ratio_y_bg2` | `UpdateLayerScrollX/Y` pass `$ratio_x_bg1, X` / `$ratio_y_bg1, X` to `ScaleByRatio`: low byte = numerator, high byte = divisor; `ScrollCameraByDelta` skips BG2 when its ratio is 0. |
| `$0352` / `$0356` | `map_base_bg1`, `map_base_bg2` | `BuildColumnStrip` stores the word in dp$02 and the strip filler wraps to it at the end of the map data; set to `$8000` / `$C000` (the `$7E` map arrays). |
| `$0354` / `$0358` | `tilemap_vram_bg1`, `tilemap_vram_bg2` | Stored in dp$00 and added to the strip's VRAM address; `lib_boot_and_scene_init` writes `$7000` to the BG2 entry, the sweep lookups add `$6000` and `$7000`. |
| `$035A` / `$035E`, `$035C` / `$0360` | `tile_defs_bg1/2`, `tile_mask_bg1/2` | The definition tables `$2000` / `$2800` read with `LDA ($29), Y`; the masks (default `$FDFF`) are ANDed with every definition word before it goes to VRAM. |
| `$0362` / `$0364` / `$0366` / `$0368` | `strip_col_bg1`, `strip_row_bg1`, `strip_col_bg2`, `strip_row_bg2` | The strip buffers `$3000`, `$3102`, `$3204`, `$3306` (258 bytes each) in bank `$7E`; `lib_boot_and_scene_init` stores them, `Build*Strip` and `UploadMapStripBuffers` use them. |
| `$036A` / `$036E` | `tile_attr_bg1`, `tile_attr_bg2` | ORed into every tile word (`$2000` = priority bit when the scene profile asks); `$036B` / `$036F` (`+1`) are the high bytes the strip builders load into dp$06. |
| `$0382` / `$0384` | `scroll_delta_x`, `scroll_delta_y` | `AimCameraAtPlayer` stores target - scroll; `ScrollCameraByDelta` adds them to `scroll_bg1_x/y`; `BuildScrollStrips` clears them. |
| `$038A` / `$038C` | `bg2_offset_x`, `bg2_offset_y` | Added to the scaled BG2 position in `UpdateLayerScrollX/Y`; cleared at scene change, changed by scripts in the castle, airship dock and evil world and set to 1 by the soul code (`lib_hdma_window_effects`). |
| `$038E` / `$0390` | `bg2_delta_x`, `bg2_delta_y` | New minus old BG2 position (`UpdateLayerScrollX/Y`); `BuildScrollStrips` copies them to `scroll_delta_x/y` for the BG2 strips. |
| `$0396` | `scroll_requests` | `TSB` of `$80` / `$40` / `$20` / `$10` (BG1 column, BG1 row, BG2 column, BG2 row) when a scroll crosses a 16-pixel line; `BuildScrollStrips` tests and clears each with `TRB`. |
| `$03A8` / `$03AA` / `$03AC` | `plate_variant`, `plate_lists_ofs`, `plate_list_ofs` | `TriggerVariantPlate` toggles `$03A8`, adds it to the slab number (`+ 2`), and reloads `$03AC` (the start of the plate list in `PlateListPointers`) from the pair at `$03AA`. Set at scene entry by `lib_map_tile_patches` (not annotated yet). |
| `$03AE` / `$03B2` | `chest_list_ofs`, `exit_list_ofs` | Start of the chest rows (`ChestListPointers`) and exit region rows (`ExitListPointers`) of the room; 0 / `$FF` end markers. |
| `$03C8` | `text_arg` | The word the text controls `[TBL:...,03C8]` and `[06:3,03C8]` read; the lair code stores the NPC name index, the chest code the item entry or the Gem amount. |
| `$03CA` | `view_height_px` | `$E0` or `$100` from the scene profile (`lib_scene_asset_loader`); replaces `$100` in the vertical camera clamps. |
| `$0456` | `lairs_left` | `lib_map_tile_patches` zeroes it at scene entry and increments it per lair; `ReleaseLairAtSwitch` decrements it; the pause code reads it. |
| `$1C5C` / `$1C5E` | `wram_copy_stub`, `wram_copy_stub+2` | The RAM stub `PHB; MVN; PLB; RTS` built by `lib_boot_and_scene_init`; `CopyFrameData` patches its bank operands and calls it with `JSR`. |
| `$1C6C` | `sweep_bg1` | `INC` before a BG1 sweep, `STZ` after; `StepSweepRedraw` takes the BG1 pass when non-zero, the BG2 pass when zero. |
| `$1C6E`-`$1C74` | `release_slab`, `release_npc_x/y`, `release_rect_x/y/w/h` | Bytes 1-7 of the lair record, copied with `MVN` to `$1C6D`-`$1C74` before the rectangle copies (`$1C6D` is byte 0, the NPC's home location). |
| `$1C75` | `sweep_step` | 1-35 while a sweep runs, 0 = idle (`StepSweepRedraw`). |
| `$1C77` / `$1C79` | `sweep_origin_x`, `sweep_origin_y` | The scroll position rounded down to 16 pixels, stored by each sweep step. |

Also documented by the A4 notes without a mnemonic: `$1A7E` is the chest-opened bit array (bit = chest id and `$7F`), `$1A9E` the released-lair bit array (bit = lair record index), `$1ADE` the switch array (all four are read with the same bit-array routines: [code/flags-switches-and-inventory-bytes.md](code/flags-switches-and-inventory-bytes.md)); `$0392` / `$0394` are written by `RedrawBackgroundsAtEntry` and never read (OQ-I026-5).

## 7f. Menu, status screen and HUD state (batch A5)

The equipped cells `equipped_weapon` / `equipped_armor` / `equipped_magic` / `equipped_bracelet` (`$1B5E`-`$1B64`) are word cells: the low byte is the item id, the high byte is never written, and the text codes read the cell as a word (`[TBL:&ItemNameList,1B5E]`). The inventory table `inventory` (`$1B1E`, 64 bytes) is indexed by item id minus 1; bits 0-6 of a slot byte are the id (0 = not owned) and bit 7 is the equipped or cursor marker (`DrawInventoryIcon` draws a selection frame around every slot with bit 7 set).

| Address | Name | Evidence |
|---|---|---|
| `$03C0` / `$03C1` / `$03C2` / `$03C3` | `tm_shadow`, `cgadsub_shadow`, `bg2sc_shadow`, `w12sel_shadow` | `OpenEquipmentMenu` writes `TM = 6`, `BG2SC = $5C`, colour math and windows off; the tail of `OpenEquipmentMenu` (after `RunEquipmentMenu` returns through `ExitEquipmentMenu`, which is only `SEC` / `RTS`) copies these four bytes back to `TM`, `CGADSUB`, `BG2SC` and `W12SEL`. `ApplySceneProfile` stores them (`tm_shadow`, `cgadsub_shadow`, `bg2sc_shadow`; section 7h). |
| `$03C4` | `menu_count` | Entry count of the list or row set being chosen: `ChooseFromEquipmentList` and `ChooseItemSlot` store A (8 or `$28`) and bound every move with it, `ChooseMenuRow` stores the row count. |
| `$03C6` | `menu_blink` | Incremented by `BlinkSelectionMarker`; the marker is shown while `menu_blink and $1F` is below `$18` (24 of 32 frames). Zeroed on every cursor move. |
| `$042F` | `menu_item_page` | `ChooseMenuRow` sets it when the row cursor reaches row 3 (item page drawn) and clears it when the cursor leaves row 3; `OpenEquipmentMenu` clears it on entry. |
| `$0435` | `menu_magic_on_open` | `OpenEquipmentMenu` stores `equipped_magic` and, in its tail, compares it and kills the projectiles when the equipped magic changed. |
| `$045A` / `$045C` / `$045E` / `$0460` | `menu_saved_bg1_x`, `menu_saved_bg1_y`, `menu_saved_bg2_x`, `menu_saved_bg2_y` | `OpenEquipmentMenu` saves `scroll_bg1_x/y` and `scroll_bg2_x/y` here and zeroes the live words and restores them in its tail. |
| `$1B6C` / `$1B6E` | `hp_bcd`, `max_hp_bcd` | `ShowStatusAndSoulsScreen` fills them with `ByteToPackedBcd` (tens and ones in byte 0, hundreds in byte 1); `StatusScreenText` prints them with `[06:3,1B6C]` and `[06:3,1B6E]`. |
| `$1B92` | (no mnemonic) | The player name string. `[02:2]` in `StatusScreenText`, `DescElementalMail` and `DescPhoenix` prints it (entry 2 of `TextListPointers`). A mnemonic is not possible: that list prints the entry as a pointer operand and a name there changes the assembled bytes. |

Also documented by the A5 notes without a mnemonic (the accesses are immediates, DP, or long addresses, which never print a name): `$1A1E`-`$1A5D` (`talk_actor_backup`: the 64-byte copy of an NPC slot that `TalkFacingPlayer` makes and `RestoreTalkedActor` copies back), `$7E6000`-`$7E61FF` (CGRAM backup while a menu is open), `$7F0403`-`$7F042A` (backup of the list being chosen, only the dead cancel paths restore it), `$7F:C000`-`$7F:DFFF` (8 KB copy of `graphics_04D000` that `RestoreSceneBgGfxAndPalette` DMAs back to VRAM `$2000`), the `$7F7800` page (BG2 icon tilemap, VRAM `$5C00`), DP `$56`/`$57` (list pointer of the choosers), DP `$00`, `$01`, `$16`, `$18` (talk probe: facing, result, x, y) and DP `$42`/`$44`/`$46`/`$48` (the HDMA channel queue: pending mask, next channel bit, next register block offset from `$4300`, `$6000` stored and never read). `$0433` and `$0434` are cleared by the tail of `OpenEquipmentMenu` when the magic changed; `$0433` is `spell_active_count` (section 7j; the player script and the spell actors change it too, OQ-I009-11).

## 7g. Text renderer and name entry state (batch A6)

Both renderers (`PrintTextString` and `ShowDialogueText` in `lib_text_render`) write tile words into the BG3 page `bg3_tilemap_buffer` (`$7F7000`, 32 x 32 tiles, row stride `$40`). A glyph is two tiles: the lower half at the write cell, the upper half (tile + `$100`) one row up, which for the first page row is the 64 bytes `$7F6FC0`-`$7F6FFF` just before the page (OQ-I010-7).

| Address | Name | Evidence |
|---|---|---|
| `$03E9` | `text_attr` | Attribute byte of every tile written (starts at `$20`). `[03:v]` replaces bits 2-4 (`AND #$E3`, `ORA v`); `[09]` toggles bit 1 (one-row mode, tile bit 9). `PrintTextString` saves and restores it; `ShowDialogueText` sets it to `$20` and does not restore it. |
| `$03EB` | `text_window_origin` | Word: interior top-left of the window, set by `FindTextWindowBounds`, read by `ClearTextWindowInterior` and `ScrollTextWindowUp`. |
| `$03ED` / `$03EF` | `text_window_width`, `text_window_height` | Counted by `FindTextWindowBounds` (to tile 8 and tile 6). The scroll and clear code read them as words and assume the high byte is 0 (OQ-I010-9). |
| `$03F3` | `text_resume_pos` | Line start saved by `EndDialogue`; the next `ShowDialogueText` call whose first byte is neither `$01` nor `$10` continues there. The debug scanner writes it as well. |
| `$03F5` | `text_blip_flag` | Bit 0: typing blip on (`TickAfterGlyph`). Set to 1 at the start of a dialogue, toggled by `[0F]`. |
| `$03F7` | `text_last_window_origin` | Origin of the last `[07]` window drawn by `PrintTextString` (`HandleWindowCode`); `Cop02` and `Cop1A` erase the choice window from it. |
| `$03F9` | `text_font_flip` | Bit 7, ORed into every tile low byte (`[0A]` toggles it: tiles `$80`-`$FF`, OQ-I010-3). |
| `$0441` / `$0443` | `name_cursor_col`, `name_cursor_row` | Cursor column (0-12) and row (0-4) of the name entry grid; zeroed on entry, changed by the four `MoveNameCursor` routines. |
| `$1B84` | `text_delay` | Frames per printed glyph (`TickAfterGlyph` calls `WaitFrames` with it); 0 = instant text, no waits and no scrolling prompt. `InitFixedState` stores 3 once at boot (`lib_boot_and_scene_init`); scenes store other values (`RunEnding` 6; see [text-and-dialogue.md](code/text-and-dialogue.md)). The renderer reads a byte, scenes write words (OQ-I010-1). The earlier reading of the cell as an ending flag (OQ-I024-2) is withdrawn. |

Without a mnemonic: the name buffer `$1B92`-`$1B99` (`RunNameEntryScreen` fills it through the Y register; the terminator is stored at `[Y]`, so a full name has it at `$1B9A`), the save-slot name field `$0447`-`$044E` (list entry 3 of `TextListPointers`, filled by `DrawSaveSlotMenu`) and the text cells `$7F6FC0`-`$7F6FFF`. Both `$1B92` and `$0447` are pointer-table entries, where a name would change the assembled bytes.

## 7h. Scene loader and scene profile state (batch A7)

`LoadSceneAssets` and `ApplySceneProfile` (`lib_scene_asset_loader`) run with the screen in forced blank. They write the PPU layout of a scene and the per-scene variables below; `InitSceneState` (`lib_boot_and_scene_init`) clears the per-scene ones: `no_combat_scene` before the load, `scene_variant` and `asset_skip_mask` after it.

| Address | Name | Evidence |
|---|---|---|
| `$031A` / `$031C` | `bgm_start_cmd`, `bgm_record_variant` | `LoadSceneMusic` stores byte 0 and byte 1 of the music record. `UploadSceneMusic` writes `bgm_start_cmd` to `APUIO0` after the song upload (always 1 in the shipped list); `bgm_record_variant` is the variant the record belongs to. |
| `$031E` | `scene_variant` | Selects the music record of the scene (`LoadSceneMusic` compares it with `bgm_record_variant`). A one-shot request: an actor may set it before the scene change; otherwise `LookupSceneVariant` may set it from `SceneVariantRules`; otherwise bits 7 and 6 of profile byte 11 add 1 each (`ApplySceneProfile`). Cleared after the load. Meaning of the values: OQ-I011-5. |
| `$0320` | (unnamed) | ARAM address of the next sample for `UploadSpcStream`: `UploadSpcDriver` sets it to `$3000`, then to `$7353` (the end of the driver's 13 samples); every song's samples start there ([code/spc-interface.md](code/spc-interface.md)). |
| `$0342`-`$0345` / `$0346`-`$0349` | `map_width_px`, `map_width_pages`, `map_height_px`, `map_height_pages` / `map2_width_px`, `map2_width_pages`, `map2_height_px`, `map2_height_pages` | `LoadMapLayer` stores the width and height words (pages x 256) at `map_width_px + X` and `map_height_px + X` (X = 0 BG1, 4 BG2); the pages are the high bytes. |
| `$034A`-`$0351` | `ratio_x_bg1`, `ratio_y_bg1`, `ratio_x_bg2`, `ratio_y_bg2` (words) and their `+1` bytes | `ApplySceneProfile` fills the four words from profile bytes 7-10: the high nibble of each byte is the low byte of the word (numerator), the low nibble the high byte (divisor). `ScaleByRatio` reads them as a ratio word. |
| `$0372` / `$0373` | `scene_sprite_attr`, `scene_sprite_attr+1` | Default sprite attribute word that actor spawns OR into the record attribute (`engine_spawn_lairs_death_drops` and several actor helpers read it). `ApplySceneProfile` writes only the high byte: profile byte 4 and `$30` (OQ-I029-3). |
| `$03A2` | `pause_latch` | `lib_main_loop_helpers` (the pause banner): incremented when Start is pressed (the pause runs inside the routine); while it is non-zero the routine returns at once, and it is zeroed when Start is no longer held, so holding Start does not pause twice. A negative value also returns at once; no writer of such a value was found. |
| `$03B4` | `asset_skip_mask` | Bit mask that makes `LoadSceneAssets` skip a command (bit 0 tilemap, 1 tileset, 2 palette, 3 graphics, 4 spritemap, 5 music). Actors that warp inside a world write `$0020` (keep the music); `InitSceneState` clears it after the load. |
| `$03BA` | `world_index` | Low nibble of profile byte 11 (0 Grass Valley to 6 World of Evil). |
| `$0407`-`$0424` | `asset_cache_gfx0`-`gfx3`, `asset_cache_tileset1`/`2`, `asset_cache_tilemap1`/`2`, `asset_cache_spritemap`, `asset_cache_music` | Ten 3-byte cells at `$0407`, `$040A`, `$040D`, `$0410`, `$0413`, `$0416`, `$0419`, `$041C`, `$041F`, `$0422`: the LoROM pointer of the last asset loaded into each slot (`CheckAssetCache`). A zeroed cell forces a reload. `MusicLoadUpload` writes `$0422`/`$0424` (the third byte is named `asset_cache_music+2`). The immediates `LDX #$0407` etc. print as numbers. |
| `$0439` | `no_combat_scene` | Profile byte 11 bit 5. Cleared by `InitSceneState` before the load. `lib_main_loop_helpers` skips the lair counter when it is set; `player_core` and `lib_player_helpers` test it before `equipped_weapon`, `player_spells_level_up` before `subframe_active`; the exact meaning is open (OQ-I029-2). |
| `$1B80` | `lair_count_bcd` | The two BCD digits of `lairs_left` that `LairCounterText` prints (`[06:2,1B80]`). |

DP scratch of the loader: `$00`-`$06` (operands: start, end, destination offset, flags), `$1E` (bit mask of the LZ reader), `$1F`/`$21` (ring write and read position), `$23` (output length), `$25` (destination), `$29`-`$2B` (source pointer), `$2C`-`$2E` (copy destination; `$2E` is the SPC upload's bank counter, OQ-I011-1), `$2F`-`$31` (asset list pointer, set once at boot). They have no mnemonic: DP accesses print as plain numbers.

## 7i. Scene change and library state (batch A9)

| Address | Name | Evidence |
|---|---|---|
| `$03CC` / `$03CD` / `$03CE` | `wave_amplitude`, `wave_request`, `wave_phase_step` | Parameters of `lib_unused_sine_wave_tables.FillSineWaveTables`, which no code calls (dead, OQ-I013-12): the multiplier of the sine (`M7A`), the request flag (cleared when served) and the phase advance per word. Named from that routine only (confidence C). |
| `$03E5` | `iris_frame` | `lib_boot_and_scene_init.RunIrisTransition`: the frame of the iris mask, `$1E` counting down to 0 going out and 0 counting up to `$1F` coming in (set by `ChangeSceneIfRequested`). Bit 4 and bits 3-0 select the 16-byte frame of `IrisFrames` written to VRAM word `$4000`. |
| `$03E7` | `iris_step` | Direction and step of the iris frame: `$FF` out (bit 7 set also selects the out branch), 1 in. |
| `$0454` | `reload_menu_gfx` | One-shot flag: the front end (`gv_front_end`, `HandleFileSelectChoice`) and two Up Above scripts increment it; `InitSceneState` clears it after `LoadSceneAssets` and then calls `RestoreSceneBgGfxAndPalette` and `LoadEquippedMagicGfx`. The word `$0454` inside `data_iris_and_icon_tiles` unk17 rows is a literal and prints as a number. |

`InitFixedState` writes the starting values `$1A7D = $0080` (event flag `$FF`), `player_hp` and `player_max_hp` = 8, `player_level` and `player_level_bcd` = 1, and `$1A02/$1A04` = `$7F:3000`; the last two bytes are the long pointer of the dynamic-tile sprite code (`BuildDynamicTileSprites` stores `$34,X` and `$2C,X` into it before reading it).

## 7j. Player state (batch A10)

| Address | Name | Evidence |
|---|---|---|
| `$03D4` / `$03D6` | `push_dx` / `push_dy` | `player_core.ScanPushZones` stores the signed pixels per frame of the push zone record the hero stands in (dx word, dy word), or 0 when no record matches; `FinishPlayerMove` adds them to the hero's position. Records are 8 bytes (x0, x1, y0, y1 in tiles, dx, dy). |
| `$03D8` / `$03DA` | `push_zone_list` / `push_zone_bank` | Address and bank of the list of push records of the scene. The actor scripts of Grass Valley, Mountain of Souls, Magridd's Castle (airship dock) and the Seabed of St. Elles store them when the scene starts (4 stores each); a list ends at a first byte of `$FF`. 13 lists and 54 records in the game. |
| `$0431` | `soul_orbit_phase` | `player_spells_level_up.RunSoulOrbController` increments it every frame; index x 2 mod 256 into the sine tables `SineTable` / `SineTableTail` places the orb on its circle of radius 31 px (128 phases per turn). |
| `$0433` | `spell_active_count` | The cast lock: `DispatchSpellCast` refuses a new spell while it is not 0. `EndSpellActor` and the parents of the Spark Bomb, Flame Pillar and Tornado set, increment and decrement it. the tail of `OpenEquipmentMenu` clears it (with `$0434`) when the magic changed, and the scene initializer clears it (OQ-I009-11, OQ-I032-7). |

`$039C`, `$039E` and `$03A0` (`player_actor`, `player_weapon_actor`, `soul_orb_actor`) are in section 7c and the table above it; batch A10 shows that `InitPlayerActor` stores all three when it spawns the helpers.

## 8. Left unnamed (open)

No sentence of verified evidence yet; tracked in `plans/extracted-audit/questions/I002_questions.md`:
`$0466` (a step word shared by the ending of `we_deathtolls_shrine_actors`, where `RunEnding` increments it, and `gv_front_end`; OQ-I034-16, OQ-I040-3),
`$1C62`-`$1C68` (cursors of the rectangle copies in `lib_map_tile_patches`), `$1C7D`-`$1C9B` (queue entries), `$7E8000` (OQ-I006-23), `$7EC000`,
`$7E7000`/`$7E7800` (HDMA table staging).

## 9. Where each section is explained

| Section | Topic documents |
|---|---|
| 2. System, input and frame state | [code/boot-nmi-main-loop.md](code/boot-nmi-main-loop.md), [code/cop-dispatch.md](code/cop-dispatch.md) |
| 3. Scene, area, scrolling and player | [code/scene-area-warp-loading.md](code/scene-area-warp-loading.md), [code/player.md](code/player.md), [code/collision-and-physics.md](code/collision-and-physics.md) |
| 4. Actor system | [code/actor-system.md](code/actor-system.md) |
| 5. Direct page | [code/actor-system.md](code/actor-system.md), [code/cop-dispatch.md](code/cop-dispatch.md) |
| 6. Video, DMA and buffers | [code/vram-dma-hdma-palettes.md](code/vram-dma-hdma-palettes.md), [code/sprites-oam-animation.md](code/sprites-oam-animation.md) |
| 7. Game state | [code/flags-switches-and-inventory-bytes.md](code/flags-switches-and-inventory-bytes.md), [code/combat-damage-and-enemy-records.md](code/combat-damage-and-enemy-records.md), [code/save-and-load.md](code/save-and-load.md) |
| 7f, 7g. Menu, HUD and text state | [code/menus-inventory-status-hud.md](code/menus-inventory-status-hud.md), [code/text-and-dialogue.md](code/text-and-dialogue.md) |
| Sound request and the APU ports | [code/spc-interface.md](code/spc-interface.md) |

The hub [code/README.md](code/README.md) lists every document and the files each one covers.
