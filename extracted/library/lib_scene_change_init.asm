; Scene change: the loader, the transitions, the iris, the tile type map and the scene state init (file offsets 161518-162065 and 162229-162514, SNES $04:F6EE-$F911 and $F9B5-$FAD2, bank 04).
; 
; === MODEL ===
; ChangeSceneIfRequested is the scene loader called from RunMainLoop (and once at boot). It acts only when the low byte of scene_next ($0318) is non-zero. With scene_active set it first plays PlayTransitionOut with iris_frame = $1E and iris_step = $FF (the out direction of the iris); then it clears scene_active and dp$42, forces blank with the NMI off, copies scene_next and area_next into scene_current and area_current, clears scene_next, runs InitSceneState and one RunSubFrameLoader, enables the NMI, sets iris_frame = 0 and iris_step = 1, plays PlayTransitionIn, sets scene_active, clears transition_type and scene_loading and runs one more sub-frame. At boot scene_active is 0 and the out transition is skipped.
; transition_type ($03E3, set by Cop3C_SetTransitionType; RunReturnLoop writes $80) selects the effect. Out: 0 and 1 fade, 2 and 3 instant, 4 and 5 mosaic, 6 and 7 instant, 8-$7F fade, $80 and above iris. In: 0 fade, 1 instant, 2 fade, 3 instant, 4 mosaic, 5 instant, 6 mosaic, 7 instant, 8-$7F fade, $80 and above iris. The type is cleared only after the in transition, so one type drives both halves of a scene change. The values in use are few: 0 (the default, fade out and fade in), 4 (set by 23 scripts through Cop3C, always just before a Cop10: mosaic out and mosaic in) and $80 (return trips: iris out and iris in); the other ladder entries are never selected by a script (static, OQ-I031-6). Fade = INIDISP brightness $0F down to 0 (out) or 0 up to $0F (in), one sub-frame per step; instant = one sub-frame, then INIDISP 0 or $0F; mosaic = two sub-frames per brightness step with MOSAIC = ((brightness xor $0F) << 4) | 3 (BG1 and BG2), 16 steps.
; The iris (RunIrisTransition) writes one 16-byte frame of IrisFrames to VRAM word $4000 per step (the mask tile) and runs two sub-frames. The frame offset is ((2 x type + bit 4 of iris_frame) << 8) | ((iris_frame & $0F) << 4), the type's bit 7 drops out of the 8-bit add. iris_step is $FF for out (frames $1E down to 0, 31 steps = 62 sub-frames) and 1 for in (frames 0 up to $1F, 32 steps = 64 sub-frames). Out sets scene_loading, clears the BG3 buffer and sets vram_upload_flags bit 0 first.
; BuildTileTypeMap fills tile_type_map ($7F:8000, one byte per metatile, OQ-I013-2) when a scene loads: FillTileTypeMap first builds a mask table at $0200-$02FF from the metatile definitions at $7E:2000 (8 bytes per metatile id = four tile words TL, TR, BL, BR): mask = TL + 2 TR + 4 BL + 8 BR where each term is bit 9 of the tile word (the solid flag; the same rule SetMetatileBg1 uses); then it replaces every id byte of the BG1 id map ($7E:8000) by mask[id]. The byte count is map_width_pages x map_height_pages x $100; the XBA/TAY that makes it is right only while the product fits one byte, and the largest header is 64 pages.
; InitSceneState runs with the screen blanked and the NMI off. In order: zero player_x and player_y, the scroll deltas, joy_pressed, $03D4-$03D8, the BG2 offsets, joy_block_mask, $0433 (stored twice, OQ-I013-13), boss_fight_active, player_hidden_count and joy_override; weapon actor, soul orb actor and boss actor = $06AA (none); clear event_flags byte 0 (flags $00-$07 are scene-local), contact_lock, no_combat_scene, the PPU shadows and the colour buffer; LoadSceneAssets; if reload_menu_gfx is set, clear it and call RestoreSceneBgGfxAndPalette and LoadEquippedMagicGfx; BuildTileTypeMap; the map size in pages from MapPatchRectsAndMapSizes+$28/+$29 by location_id; InitActorPool; SpawnSceneActors; the map patches (code_011395, code_0112F5, ApplyLairStatesToScene, code_011445, code_0114D0, code_0114E4, ApplyFlagMapPatches); ClearBg3Buffer; ClearSwitchOwnersOnReturn; two RunActors passes; ApplyPlayerWeaponPose; RedrawBackgroundsAtEntry unless location_id is $10; vram_upload_flags bit 0; scene_variant and asset_skip_mask = 0; rng_state+1 = frame_counter (OQ-I013-1); joy_release_latch = $FFFF; frame_counter = $FFFF; window registers WH0 = 0 and WH1 = $FF; ResetSortBuckets; hud_dirty_flags = $1F unless event flag $FA ($1A7D bit 2).
; 
; === NOTES ===
; - ClearBg3Buffer (25 call sites: the front end, the scene init, the iris out) fills bg3_tilemap_buffer ($7F:7000, $1000 bytes) with $2000; the upload flag is the caller's business. ClearSwitchOwnersOnReturn zeroes switch_owner_table ($7F:0483, $400 bytes) only on a return trip (return_active non-zero).
; - The transition and iris routines are JSR targets of ChangeSceneIfRequested and must stay in this block in this order: RunIrisTransition is reached by BRL from PlayTransitionOut and BMI from PlayTransitionIn, and ends with the RTS of the iris loop.
; - Locations $0F-$12 have no HUD, no animated strip and no weapon pose; location $10 also skips the background redraw. $10-$12 run the reduced loop (OQ-I027-2).
---------------------------------------------

?BANK 04

?INCLUDE 'data_iris_and_icon_tiles'
?INCLUDE 'engine_boot_main_loop'
?INCLUDE 'engine_scheduler_sprites_combat_collision'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'lib_0108BB'
?INCLUDE 'lib_0118FC_part5'
?INCLUDE 'lib_027781_part1'
?INCLUDE 'lib_arithmetic'
?INCLUDE 'lib_map_streaming'
?INCLUDE 'lib_scene_asset_loader'
?INCLUDE 'lib_scene_map_patches'
?INCLUDE 'lib_shared_027260'
?INCLUDE 'lib_system_helpers'

!rng_state                      0301
!frame_counter                  0312
!area_current                   0314
!scene_current                  0316
!scene_next                     0318
!area_next                      0319
!scene_variant                  031E
!joy_pressed                    0322
!joy_block_mask                 0326
!joy_release_latch              032A
!scene_active                   032E
!hud_dirty_flags                0332
!map_width_pages                0343
!map_height_pages               0345
!player_x                       0374
!player_y                       0376
!scroll_delta_x                 0382
!scroll_delta_y                 0384
!bg2_offset_x                   038A
!bg2_offset_y                   038C
!boss_actor                     039A
!player_weapon_actor            039E
!soul_orb_actor                 03A0
!asset_skip_mask                03B4
!vram_upload_flags              03B8
!w12sel_shadow                  03C3
!push_dx                        03D4
!push_dy                        03D6
!push_zone_list                 03D8
!transition_type                03E3
!iris_frame                     03E5
!iris_step                      03E7
!return_active                  03FB
!contact_lock                   042D
!spell_active_count             0433
!no_combat_scene                0439
!reload_menu_gfx                0454
!boss_fight_active              0458
!scene_loading                  0462
!player_hidden_count            0464
!joy_override                   0468
!S_switch_owner_table           0483
!event_flags                    1A5E
!location_id                    1C6A
!INIDISP                        2100
!MOSAIC                         2106
!BG12NBA                        210B
!VMADDL                         2116
!VMDATAL                        2118
!W12SEL                         2123
!W34SEL                         2124
!WOBJSEL                        2125
!WH0                            2126
!WH1                            2127
!COLDATA                        2132
!cgram_buffer                   7F0000
!coldata_buffer                 7F0200
!bg3_tilemap_buffer             7F7000

---------------------------------------------

; Fills the BG3 tilemap buffer with the blank word.
; 
; When: 25 call sites: the front end sequence (about 22), the boot, InitSceneState and the iris out.
; Sees: the text layer is empty at the next upload (nothing is shown by this call alone).
; Why: BG3 carries the text; clearing the buffer is how a text screen is erased.
; In: JSL; any M.
; Out: bg3_tilemap_buffer ($7F:7000-$7FFF) = $2000 in every word (priority bit, tile 0); the upload flag is not set. X and P restored.
; Clobbers: A.

ClearBg3Buffer {
    PHX 
    PHP 
    REP #$20
    LDA #$2000            ; blank word: tile 0 with the priority bit
    LDX #$0000

  ClearBg3BufferLoop:
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    CPX #$1000
    BNE ClearBg3BufferLoop
    PLP 
    PLX 
    RTL 
}

---------------------------------------------
; Clears the switch owner table after a return trip.
; 
; When: InitSceneState, once per scene.
; Sees: after a return trip (RunReturnLoop) no switch of the old scene keeps an owner actor.
; Why: the table maps switch ids to actor slots; a return trip rebuilds all actors, so the old slots are stale.
; In: JSL; M = 8, X = 16-bit; return_active ($03FB).
; Out: when return_active is non-zero: switch_owner_table ($7F:0483-$7F:0882) zeroed; DBR restored.
; Clobbers: A, X.

ClearSwitchOwnersOnReturn {
    LDA $return_active
    BEQ ClearSwitchOwnersDone
    PHB 
    LDA #$7F
    PHA 
    PLB 
    REP #$20
    LDX #$0000

  ClearSwitchOwnersLoop:
    STZ $S_switch_owner_table, X
    INX 
    INX 
    CPX #$0400
    BNE ClearSwitchOwnersLoop
    SEP #$20
    PLB 

  ClearSwitchOwnersDone:
    RTL 
}

---------------------------------------------
; Builds the tile type map of the new scene.
; 
; When: InitSceneState, once per scene, after LoadSceneAssets.
; Sees: nothing directly; it is what makes walls, water and holes solid for the collision tests.
; Why: the collision tests read one byte per 16 x 16 metatile, so the per-tile solid flags are folded into one byte once at load time.
; In: JSL; M = 8, X = 16-bit; map_width_pages, map_height_pages (the loader's header values); DBR in $00-$3F.
; Out: dp$2A = 2; Y = pages x $100; when Y is not 0 FillTileTypeMap runs with X = $8000. XBA/TAY gives pages x $100 only while width x height fits one byte (at most 64 pages).
; Clobbers: A, X, Y; dp$0C, $0E, $29, $2A.

BuildTileTypeMap {
    LDA #$02
    STA $2A               ; dp$2A = 2: high byte of the pointer $29/$2A = $0200 + id used by FillTileTypeMap
    LDA $map_width_pages
    XBA 
    LDA $map_height_pages
    JSL $@lib_arithmetic.Multiply8x8
    XBA                   ; Y = pages x $100: right only while width x height fits one byte (at most 64 pages)
    TAY 
    BEQ loc_02773C
    LDX #$8000
    JSR $&FillTileTypeMap

  loc_02773C:
    RTL 
}

---------------------------------------------
; Converts the BG1 id map into the tile type map.
; 
; When: BuildTileTypeMap, by JSR.
; Sees: nothing.
; Why: the type nibble of each metatile is the solid flags of its four tiles, which only change per metatile id, so a 256-entry mask table is built once and looked up per cell.
; In: JSR; M = 8, X = 16-bit; X = $8000, Y = byte count, dp$2A = 2, DBR in $00-$3F; the metatile definitions at $7E:2000.
; Out: mask table $0200-$02FF (mask = TL + 2 TR + 4 BL + 8 BR from bit 9 of the four tile words of each id); tile_type_map ($7F:8000 + n) = mask[id of the BG1 map byte $7E:8000 + n] for the whole count.
; Clobbers: A, X, Y; dp$0C, $0E, $29.

FillTileTypeMap {
    PHX 
    PHY 
    LDX #$0000
    TXY 
    LDA #$00
    STA $0C

  TypeMaskIdLoop:
    LDA #$04
    STA $0E

  TypeMaskQuadrantLoop:
    LDA $7E2001, X        ; high byte of a tile word & $02 = bit 9 (solid flag); four words per metatile id at $7E:2000
    INX 
    INX 
    AND #$02
    PHA 
    DEC $0E
    BNE TypeMaskQuadrantLoop
    PLA 
    ASL 
    ORA $01, S
    ASL 
    ORA $02, S
    ASL 
    ORA $03, S
    LSR                   ; mask = TL + 2 TR + 4 BL + 8 BR
    STA $0200, Y          ; mask table in the sort bucket page ($0200-$02FF), wiped by ResetSortBuckets at the end of InitSceneState
    INY 
    PLA 
    PLA 
    PLA 
    DEC $0C
    BNE TypeMaskIdLoop
    PLY 
    PLX 

  TypeMapCopyLoop:
    LDA $7E0000, X
    STA $29
    LDA ($29)
    STA $cgram_buffer, X  ; X runs from $8000: this writes tile_type_map ($7F:8000+), not the colour buffer
    INX 
    DEY 
    BNE TypeMapCopyLoop
    RTS 
}

---------------------------------------------
; Changes the scene when scene_next is set.
; 
; When: RunMainLoop every frame and once at boot (engine_boot_main_loop).
; Sees: the screen fades out (or mosaics, or irises), the new scene appears, and the screen fades in.
; Why: one routine owns the order: out transition, forced blank, scene init, in transition, so no actor ever runs on a half-loaded scene.
; In: JSL; M = 8, X = 16-bit; scene_next ($0318, the scene, area in $0319), scene_active, transition_type ($03E3).
; Out: nothing when scene_next is 0. Otherwise scene_current and area_current = next, scene_next = 0, scene state rebuilt (InitSceneState), scene_active = 1, transition_type = 0, scene_loading = 0; iris_frame and iris_step are set for each direction ($1E and $FF going out, 0 and 1 coming in).
; Clobbers: A, X, Y; dp$42 (cleared); nothing is saved or restored.

ChangeSceneIfRequested {
    LDA $scene_next
    BEQ loc_0277D4
    LDA $scene_active
    BEQ ChangeSceneRebuild
    LDA #$1E
    STA $iris_frame       ; out iris starts at frame $1E and counts down (iris_step $FF below)
    LDA #$FF
    STA $iris_step
    JSR $&PlayTransitionOut

  ChangeSceneRebuild:
    STZ $scene_active
    STZ $42
    JSL $@lib_system_helpers.ForceBlankNmiOff
    LDA $scene_next
    STA $scene_current
    LDA $area_next
    STA $area_current
    STZ $scene_next
    JSL $@InitSceneState
    JSL $@engine_boot_main_loop.RunSubFrameLoader
    JSL $@lib_system_helpers.EnableNmi
    STZ $iris_frame
    LDA #$01
    STA $iris_step
    JSR $&PlayTransitionIn
    INC $scene_active     ; the scene counts as running from here
    STZ $transition_type
    STZ $scene_loading
    JSL $@engine_boot_main_loop.RunSubFrameLoader

  loc_0277D4:
    RTL 
}

---------------------------------------------
; Plays the screen-out effect selected by transition_type.
; 
; When: ChangeSceneIfRequested, only when a scene is already running.
; Sees: a fade to black, a mosaic that grows while the screen darkens, an instant black, or an iris closing (type $80 and above, used for return trips).
; Why: the effect is data (transition_type), so scripts choose it with Cop3C_SetTransitionType.
; In: JSR; M = 8; transition_type. 0 and 1 fade, 2 and 3 instant, 4 and 5 mosaic, 6 and 7 instant, 8-$7F fade, $80 and above iris. Only 0, 4 (23 scripts) and $80 (return trips) occur in the scripts.
; Out: INIDISP = 0 (screen off) and MOSAIC as left by the effect; RunSubFrameLoader runs inside, so the game keeps running.
; Clobbers: A.

PlayTransitionOut {
    LDA $transition_type
    BPL loc_0277DD
    BRL RunIrisTransition

  loc_0277DD:
    BEQ TransitionOutFade ; out ladder: 0 and 1 fade, 2 and 3 instant, 4 and 5 mosaic, 6 and 7 instant, 8-$7F fade, $80+ iris
    DEC 
    BEQ TransitionOutFade
    DEC 
    BEQ TransitionOutInstant
    DEC 
    BEQ TransitionOutInstant
    DEC 
    BEQ TransitionOutMosaic
    DEC 
    BEQ TransitionOutMosaic
    DEC 
    BEQ TransitionOutInstant
    DEC 
    BEQ TransitionOutInstant

  TransitionOutFade:
    LDA #$0F

  TransitionOutFadeStep:
    JSL $@engine_boot_main_loop.RunSubFrameLoader
    STA $INIDISP
    DEC 
    BPL TransitionOutFadeStep
    RTS 

  TransitionOutInstant:
    JSL $@engine_boot_main_loop.RunSubFrameLoader
    STZ $INIDISP
    RTS 

  TransitionOutMosaic:
    LDA #$0F

  TransitionOutMosaicStep:
    JSL $@engine_boot_main_loop.RunSubFrameLoader
    JSL $@engine_boot_main_loop.RunSubFrameLoader
    STA $INIDISP
    PHA 
    EOR #$0F
    ASL 
    ASL 
    ASL 
    ASL 
    ORA #$03              ; MOSAIC: size in bits 7-4 (grows as brightness falls), BG1 and BG2 in bits 1-0
    STA $MOSAIC
    PLA 
    DEC 
    BPL TransitionOutMosaicStep
    RTS 
}

---------------------------------------------
; Plays the screen-in effect selected by transition_type.
; 
; When: ChangeSceneIfRequested after InitSceneState.
; Sees: a fade in from black, a mosaic that sharpens, an instant cut, or an iris opening.
; Why: same data-driven choice as PlayTransitionOut, with its own ladder; the type is still the one that was set for the way out (it is cleared after this call).
; In: JSR; M = 8; transition_type. 0 fade, 1 instant, 2 fade, 3 instant, 4 mosaic, 5 instant, 6 mosaic, 7 instant, 8-$7F fade, $80 and above iris.
; Out: INIDISP = $0F (full brightness); MOSAIC = 3 after a mosaic.
; Clobbers: A.

PlayTransitionIn {
    LDA $transition_type
    BMI RunIrisTransition
    BEQ TransitionInFade  ; in ladder: 0 fade, 1 instant, 2 fade, 3 instant, 4 mosaic, 5 instant, 6 mosaic, 7 instant, 8-$7F fade
    DEC 
    BEQ TransitionInInstant
    DEC 
    BEQ TransitionInFade
    DEC 
    BEQ TransitionInInstant
    DEC 
    BEQ TransitionInMosaic
    DEC 
    BEQ TransitionInInstant
    DEC 
    BEQ TransitionInMosaic
    DEC 
    BEQ TransitionInInstant

  TransitionInFade:
    LDA #$00

  TransitionInFadeStep:
    JSL $@engine_boot_main_loop.RunSubFrameLoader
    STA $INIDISP
    INC 
    CMP #$10
    BCC TransitionInFadeStep
    RTS 

  TransitionInInstant:
    JSL $@engine_boot_main_loop.RunSubFrameLoader
    LDA #$0F
    STA $INIDISP
    RTS 

  TransitionInMosaic:
    LDA #$00

  TransitionInMosaicStep:
    JSL $@engine_boot_main_loop.RunSubFrameLoader
    JSL $@engine_boot_main_loop.RunSubFrameLoader
    STA $INIDISP
    PHA 
    EOR #$0F
    ASL 
    ASL 
    ASL 
    ASL 
    ORA #$03
    STA $MOSAIC
    PLA 
    INC 
    CMP #$10
    BCC TransitionInMosaicStep
    RTS 

; Plays the iris wipe in either direction (transition type $80 and above).
; 
; When: PlayTransitionOut (BRL) and PlayTransitionIn (BMI); the type is $80 for return trips (RunReturnLoop and the trip to a freed NPC's home in lib_tile_triggers_and_lair_return).
; Sees: a circle closes on the player (out) or opens (in).
; Why: the iris is a mask tile rewritten every step instead of an HDMA effect, so it needs no table setup.
; In: entered by branch; M = 8; iris_step ($03E7) = $FF (out) or 1 (in), iris_frame ($03E5) = first frame ($1E out, 0 in), transition_type with bit 7.
; Out: each step two RunSubFrameLoader calls and 16 bytes of IrisFrames (offset ((2 x type + frame bit 4) << 8) | ((frame & $0F) << 4)) to VRAM word $4000; out ends at frame < 0, in at frame $20. Out also sets scene_loading, clears the BG3 buffer and sets vram_upload_flags bit 0 first; in sets INIDISP = $0F. It leaves through the RTS of the caller's JSR.
; Clobbers: A, X.

  RunIrisTransition:
    LDA $iris_step        ; iris_step: bit 7 set = out ($FF), else in (1)
    BPL IrisStartIn
    INC $scene_loading
    JSL $@ClearBg3Buffer
    LDA #$01
    TSB $vram_upload_flags
    BRA IrisFrameStep

  IrisStartIn:
    LDA #$0F
    STA $INIDISP

  IrisFrameStep:
    JSL $@engine_boot_main_loop.RunSubFrameLoader
    JSL $@engine_boot_main_loop.RunSubFrameLoader
    LDA $iris_frame
    ASL 
    ASL 
    ASL 
    ASL 
    XBA 
    LDA $transition_type
    ADC $transition_type  ; the carry of the fourth ASL is bit 4 of the frame: A = 2 x type + frame bit 4 (the type's bit 7 drops out)
    XBA 
    TAX 
    REP #$20
    LDA #$4000            ; VRAM word $4000: the iris mask tile, 8 words from IrisFrames per step
    STA $VMADDL
    LDA $@data_iris_and_icon_tiles.IrisFrames, X
    STA $VMDATAL
    LDA $@data_iris_and_icon_tiles.IrisFrames+2, X
    STA $VMDATAL
    LDA $@data_iris_and_icon_tiles.IrisFrames+4, X
    STA $VMDATAL
    LDA $@data_iris_and_icon_tiles.IrisFrames+6, X
    STA $VMDATAL
    LDA $@data_iris_and_icon_tiles.IrisFrames+8, X
    STA $VMDATAL
    LDA $@data_iris_and_icon_tiles.IrisFrames+A, X
    STA $VMDATAL
    LDA $@data_iris_and_icon_tiles.IrisFrames+C, X
    STA $VMDATAL
    LDA $@data_iris_and_icon_tiles.IrisFrames+E, X
    STA $VMDATAL
    SEP #$20
    LDA $iris_step
    BPL IrisAdvanceIn
    LDA $iris_frame
    CLC 
    ADC $iris_step
    STA $iris_frame
    BPL IrisFrameStep
    RTS 

  IrisAdvanceIn:
    LDA $iris_frame
    CLC 
    ADC $iris_step
    STA $iris_frame
    CMP #$20              ; in ends at frame $20 (frames 0-$1F, 32 steps)
    BEQ IrisDone
    BRL IrisFrameStep

  IrisDone:
    RTS 
}
---------------------------------------------

; Rebuilds all per-scene state for the scene in scene_current and area_current.
; 
; When: ChangeSceneIfRequested, once per scene change, with the screen blanked and the NMI off.
; Sees: nothing during the call; afterwards the scene's actors, map patches and background are in place for the in transition.
; Why: every scene starts from the same cleared state, so scripts of the old scene cannot leak into the new one.
; In: JSL; M = 8, X = 16-bit; area_current and scene_current set.
; Out: see the block note for the order: player position, scrolls, input latches, the scene-local event flags ($00-$07), PPU shadows and colour buffer zeroed; assets, tile type map, map size, actor pool, actors, map patches, BG3 clear, two actor passes, the weapon pose and the background redraw done; rng_state+1 = frame_counter, joy_release_latch = $FFFF, frame_counter = $FFFF, windows WH0 = 0 / WH1 = $FF, sort buckets reset; hud_dirty_flags = $1F unless event flag $FA is set.
; Clobbers: A, X, Y; dp scratch of its callees.

InitSceneState {
    LDX #$0000
    STX $player_x
    STX $player_y
    STX $scroll_delta_x
    STX $scroll_delta_y
    STX $joy_pressed
    STX $push_dx
    STX $push_dy
    STX $push_zone_list
    STX $bg2_offset_x
    STX $bg2_offset_y
    STX $joy_block_mask
    STX $spell_active_count
    STX $spell_active_count
    STX $boss_fight_active
    STX $player_hidden_count
    STX $joy_override
    LDX #$06AA
    STX $player_weapon_actor
    STX $soul_orb_actor
    STX $boss_actor
    STZ $event_flags      ; clears event flags $00-$07: scene-local flags
    STZ $contact_lock
    STZ $no_combat_scene
    STZ $BG12NBA
    STZ $vram_upload_flags
    STZ $W12SEL
    STZ $w12sel_shadow
    STZ $W34SEL
    STZ $WOBJSEL
    STZ $MOSAIC
    LDA #$E0
    STA $COLDATA
    LDA #$00
    STA $coldata_buffer
    STA $7F0201
    STA $7F0202
    STA $cgram_buffer
    STA $7F0001
    JSL $@lib_scene_asset_loader.LoadSceneAssets
    LDA $reload_menu_gfx  ; one-shot flag from the front end and Up Above scripts: reload the menu graphics, palette and magic graphics after this load
    BEQ InitSceneAfterReload
    STZ $reload_menu_gfx
    JSL $@lib_0118FC_part5.RestoreSceneBgGfxAndPalette
    JSL $@lib_0118FC_part5.LoadEquippedMagicGfx

  InitSceneAfterReload:
    JSL $@BuildTileTypeMap
    REP #$20
    LDA $location_id
    ASL 
    TAX 
    SEP #$20
    LDA $@lib_0108BB.MapPatchRectsAndMapSizes+28, X ; map size in pages of this location: table + $28 (width) and + $29 (height)
    STA $map_width_pages
    LDA $@lib_0108BB.MapPatchRectsAndMapSizes+29, X
    STA $map_height_pages
    JSL $@engine_spawn_lairs_death_drops.InitActorPool
    JSL $@engine_spawn_lairs_death_drops.SpawnSceneActors
    JSL $@lib_scene_map_patches.code_011395
    JSL $@lib_scene_map_patches.code_0112F5
    JSL $@lib_scene_map_patches.ApplyLairStatesToScene
    JSL $@lib_scene_map_patches.code_011445
    JSL $@lib_scene_map_patches.code_0114D0
    JSL $@lib_scene_map_patches.code_0114E4
    JSL $@lib_scene_map_patches.ApplyFlagMapPatches
    JSL $@ClearBg3Buffer
    JSL $@ClearSwitchOwnersOnReturn
    JSL $@engine_scheduler_sprites_combat_collision.RunActors
    JSL $@engine_scheduler_sprites_combat_collision.RunActors
    JSL $@lib_027781_part1.ApplyPlayerWeaponPose
    LDA $location_id
    CMP #$10              ; location $10 skips the background redraw
    BEQ InitSceneAfterRedraw
    JSL $@lib_map_streaming.RedrawBackgroundsAtEntry

  InitSceneAfterRedraw:
    LDA #$01
    TSB $vram_upload_flags
    STZ $scene_variant
    STZ $asset_skip_mask
    LDX $frame_counter
    STX $rng_state+1      ; random state seeded from frame_counter before it is set to $FFFF (OQ-I013-1)
    LDX #$FFFF
    STX $joy_release_latch ; $FFFF: every button must be released before it counts again
    STX $frame_counter    ; $FFFF: the first NMI makes it 0
    LDA #$00
    STA $WH0
    DEC 
    STA $WH1
    JSL $@lib_shared_027260.ResetSortBuckets
    LDA $1A7D
    BIT #$04              ; event flag $FA (bit 2 of $1A7D): when set the HUD is not marked dirty at scene start
    BNE InitSceneDone
    LDA #$1F
    STA $hud_dirty_flags

  InitSceneDone:
    RTL 
}