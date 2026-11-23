; Reset, main loop and sub-frame runners (file offsets 0-516, SNES $00:8000-$8204, bank 00).
; 
; === FRAME MODEL ===
; BootGame (the reset vector) sets native mode, D = 0, S = $1FFF and DBR = $01, runs the hardware init (InitHardwareAndClearWram), ApplyBootPpuLayout, InitFixedState and ClearBg3Buffer (BG3 tilemap buffer), sets scene_next = $000C (scene 0C of area 0, the boot scene), enables NMI, calls the scene loader once and falls into RunMainLoop.
; 
; One pass of RunMainLoop is one game frame (location_id not $10-$12 and the low byte of return_active zero):
;   1. WaitVBlank: NMI is on, so HandleVBlank runs inside this wait.
;   2. Scene loader ChangeSceneIfRequested, only when the low byte of scene_next is non-zero; it runs its own frames through RunSubFrameLoader.
;   3. DispatchFieldButtons (Select or X: equipment menu; B: talk to the actor in front; A without a direction: status and souls screen) and pause HandlePauseBanner (Start), NMI still on.
;   4. DisableNmi: everything below is the work phase and runs with NMI off.
;   5. CheckPlayerTileTriggers (lair switch, pressure plate, chest and exit regions under the player), ResetHdmaQueue (per-frame reset: HDMA shadow dp$42 = 0 and dp$44-dp$48).
;   6. RunActors, CullAndSortActors, DetectHitSourceCollisions, DetectPlayerContact, CheckPlayerDeath (death check and automatic Medical Herb), ScrollCameraByDelta and BuildScrollStrips (scroll), BuildOamFromActors.
;   7. HUD (UpdateHud, which skips locations $0F-$12 entirely, including the heal and EXP drains; code_011695), QueueAnimatedTileStrip (queues one animated tile strip), EnableNmi, back to step 1.
; 
; === VARIANTS ===
; RunReducedLoop: location_id $10-$12 (unnamed scenes of the Up Above area, OQ-I001-6; the boot scene 00/0C should be location $12, OQ-I005-21). Runs DisableNmi, ResetHdmaQueue, RunActors, CullAndSortActors, BuildOamFromActors and EnableNmi only: no menu, no hit tests, no HUD.
; RunReturnLoop: low byte of return_active non-zero. Same as the main loop without menu, hit tests and scroll update, and Start, Select and X are cleared; after one frame it loops over RunSubFrame (WaitReturnDone) while bit 7 of $03FC is set, then adds player_max_hp / 8 to heal_pending, calls WaitFrames with A = $78, sets transition_type = $80, copies return_area, return_scene, return_x and return_y into area_next, scene_next, warp_dest_x and warp_dest_y, enables NMI and jumps back to RunMainLoop (OQ-I005-17).
; 
; === SUB-FRAMES ===
; RunSubFrameLoader, RunSubFrameMapSweep and RunSubFrame run one complete game frame from inside a script, a menu, the text renderer or the scene loader. They set subframe_active ($03A6) to 1 while the work phase runs: RunActorList then runs only actors whose $16 bit $0010 is set, so a modal routine keeps its own actors alive while the rest of the game stands still. The player actor code and w2_actor_0FA6F5 also read $03A6.
; 
; === WRAM ===
; return_active $03FB (word read, low byte = flag), return_area $03FD, return_scene $03FF, return_x $0401, return_y $0403; scene_next $0318 (word) and area_next $0319; warp_dest_x $037C, warp_dest_y $037E; transition_type $03E3; heal_pending $043B; subframe_active $03A6; scene_loading $0462 (HUD skipped while non-zero in RunSubFrameLoader).
; 
; === NOTES ===
; - The three RunSubFrame* routines differ only in setup: RunSubFrameLoader disables NMI itself, calls the camera update AimCameraAtPlayer and skips the HUD while scene_loading is set; RunSubFrameMapSweep and RunSubFrame expect NMI off and set DBR = $01 (OQ-I005-20 asks whether every caller guarantees that).
; - The extractor decodes BuildScrollStrips with the wrong M flag (OQ-I026-1); the callers run with M = 1. ResetHdmaQueue had the same fault until the M override at 71774 (OQ-I005-7).
---------------------------------------------

?BANK 00

?INCLUDE 'engine_003005'
?INCLUDE 'engine_scheduler_sprites_combat_collision'
?INCLUDE 'lib_010000'
?INCLUDE 'lib_011695'
?INCLUDE 'lib_0118FC_part6'
?INCLUDE 'lib_013ADA'
?INCLUDE 'lib_027223'
?INCLUDE 'lib_027572'
?INCLUDE 'lib_027912'
?INCLUDE 'lib_map_streaming'
?INCLUDE 'lib_map_sweep_redraw'
?INCLUDE 'lib_menus'
?INCLUDE 'lib_scene_asset_loader'
?INCLUDE 'lib_scene_change_init'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'lib_text_render'
?INCLUDE 'lib_tile_triggers_and_lair_return'

!scene_next                     0318
!area_next                      0319
!joy_pressed                    0322
!warp_dest_x                    037C
!warp_dest_y                    037E
!subframe_active                03A6
!transition_type                03E3
!return_active                  03FB
!return_area                    03FD
!return_scene                   03FF
!return_x                       0401
!return_y                       0403
!heal_pending                   043B
!scene_loading                  0462
!player_max_hp                  1B8A
!location_id                    1C6A

---------------------------------------------

; Reset vector: puts the machine in a known state and enters the main loop; never returns.
; 
; When: power on or reset (emulation-mode reset vector).
; Sees: nothing until the first scene (scene_next = $000C) has loaded; then the boot scene (OQ-I005-21).
; Why: native mode with D = 0, S = $1FFF and DBR = $01 (the bank the NMI and the loops assume), hardware init, then the scene loader builds the first scene.
; In: power-on state, emulation mode.
; Out: never returns; the loop runs with M = 1, X = 16-bit, D = 0, S = $1FFF, DBR = $01.
; Clobbers: everything.

BootGame {
    SEI 
    CLD 
    CLC 
    XCE 
    REP #$30
    LDA #$0000
    TCD 
    LDA #$1FFF
    TCS 
    SEP #$20
    LDA #$01
    PHA 
    PLB 
    JSL $@lib_scene_asset_loader.InitHardwareAndClearWram
    JSL $@lib_013ADA.ApplyBootPpuLayout
    JSL $@lib_027912.InitFixedState
    JSL $@lib_scene_change_init.ClearBg3Buffer
    LDX #$000C
    STX $scene_next
    JSL $@lib_system_helpers.EnableNmi
    JSL $@lib_scene_change_init.ChangeSceneIfRequested

; One game frame (steps in the block note): wait for vblank, scene loader, menu and pause, then the work phase with NMI off. Entered from BootGame, RunReducedLoop and RunReturnLoop; every pass ends with EnableNmi and a jump back here.

  RunMainLoop:
    JSL $@lib_system_helpers.WaitVBlank ; Wait for vblank. NMI is on here, so HandleVBlank runs inside this wait; every game frame starts here
    JSL $@lib_scene_change_init.ChangeSceneIfRequested ; Scene loader: acts only when the low byte of scene_next is non-zero
    LDA $location_id
    SEC 
    SBC #$10              ; location_id - $10 below 3 (locations $10-$12): reduced loop, no menu, hit tests or HUD (OQ-I005-21)
    CMP #$03
    BCC RunReducedLoop
    LDA $return_active    ; Low byte non-zero: a return to the stored return point is running (RunReturnLoop)
    BNE RunReturnLoop
    JSL $@lib_menus.DispatchFieldButtons ; Menu (Select or X) and pause (Start) run first, with NMI still on
    JSL $@lib_027572.HandlePauseBanner
    JSL $@lib_system_helpers.DisableNmi ; NMI off: the work phase below relocates S in the sort and OAM code, so no NMI may run (OQ-I005-20)
    JSL $@lib_tile_triggers_and_lair_return.CheckPlayerTileTriggers ; Tile triggers under the player (lair switch, plate, chest, exit regions), before the actors run
    JSL $@lib_system_helpers.ResetHdmaQueue ; Per-frame reset: dp$42 (HDMA shadow) = 0, dp$44 = $10 (channel 4), dp$46 = $40 ($4340), dp$48 = $6000
    JSL $@engine_scheduler_sprites_combat_collision.RunActors
    JSL $@engine_scheduler_sprites_combat_collision.CullAndSortActors
    JSL $@engine_scheduler_sprites_combat_collision.DetectHitSourceCollisions
    JSL $@engine_scheduler_sprites_combat_collision.DetectPlayerContact
    JSL $@engine_003005.CheckPlayerDeath ; Death check and automatic Medical Herb
    JSL $@lib_map_streaming.ScrollCameraByDelta ; Scroll and camera updates (BuildScrollStrips tests and clears the scroll request bits in $0396)
    JSL $@lib_map_streaming.BuildScrollStrips
    JSL $@engine_scheduler_sprites_combat_collision.BuildOamFromActors
    JSL $@lib_0118FC_part6.UpdateHud ; HUD: the enemy gauge and the parts flagged in hud_dirty_flags; nothing at all in locations $0F-$12
    JSL $@lib_011695.code_011695
    JSL $@lib_027223.QueueAnimatedTileStrip ; Queues one animated background tile strip for the NMI (not in locations $0F-$12)
    JSL $@lib_system_helpers.EnableNmi ; NMI on again; the loop returns to WaitVBlank
    BRA RunMainLoop

; Frame for location_id $10-$12: actors, sort and OAM only (no menu, hit tests, HUD or return-point store).
; 
; When: every frame while location_id is $10, $11 or $12 (OQ-I005-21).
; Sees: the scenes that need no player input handling (location $10 is where the title code runs; OQ-I001-6 leaves $11 and $12 open).
; Why: those scenes have no player-driven combat or menu, so the loop skips that work.

  RunReducedLoop:
    JSL $@lib_system_helpers.DisableNmi
    JSL $@lib_system_helpers.ResetHdmaQueue
    JSL $@engine_scheduler_sprites_combat_collision.RunActors
    JSL $@engine_scheduler_sprites_combat_collision.CullAndSortActors
    JSL $@engine_scheduler_sprites_combat_collision.BuildOamFromActors
    JSL $@lib_system_helpers.EnableNmi
    BRL RunMainLoop

; Frame while a return to the stored return point is pending (low byte of return_active non-zero).
; 
; When: return_active is incremented by ReleaseLairAtSwitch (the freed NPC's home is in another location) and set by actor scripts of worlds 2 and 3 (OQ-I005-17); in the home scene every frame of this loop calls RunLairReleaseOnReturn.
; Sees: the world keeps animating without the player: Start, Select and X are cleared so the menu cannot open, and the HUD runs. When WaitReturnDone ends, the player is warped to return_area, return_scene, return_x, return_y.
; Why: moves the player back to a saved place with a short heal (max HP / 8 added to heal_pending).
; In: NMI on at the label; it disables it first.

  RunReturnLoop:
    JSL $@lib_system_helpers.DisableNmi
    JSL $@lib_tile_triggers_and_lair_return.RunLairReleaseOnReturn
    JSL $@lib_system_helpers.ResetHdmaQueue
    STZ $joy_pressed+1    ; Drops Start, Select and X so the menu and pause cannot open while the return runs
    JSL $@engine_scheduler_sprites_combat_collision.RunActors
    JSL $@engine_scheduler_sprites_combat_collision.CullAndSortActors
    JSL $@engine_scheduler_sprites_combat_collision.BuildOamFromActors
    JSL $@lib_0118FC_part6.UpdateHud
    JSL $@lib_011695.code_011695
    JSL $@lib_027223.QueueAnimatedTileStrip
    JSL $@lib_system_helpers.EnableNmi
    JSL $@lib_system_helpers.WaitVBlank
    JSL $@lib_system_helpers.DisableNmi

; Runs RunSubFrame while bit 7 of $03FC is set (word read of return_active), then finishes the return: clears return_active and $03FC, adds player_max_hp / 8 to heal_pending, runs WaitFrames with A = $78, sets transition_type = $80, copies the return point into the next-scene variables and jumps to RunMainLoop with NMI on.

  WaitReturnDone:
    JSL $@RunSubFrame
    LDX $return_active    ; Word read: keep running RunSubFrame while bit 7 of $03FC is set
    BMI WaitReturnDone
    STZ $return_active
    STZ $03FC
    LDA $player_max_hp    ; heal_pending += player_max_hp / 8 (three LSR); the HUD update plays the refill
    LSR 
    LSR 
    LSR 
    CLC 
    ADC $heal_pending
    STA $heal_pending
    LDA #$78
    JSL $@lib_text_render.WaitFrames
    LDA #$80
    STA $transition_type
    LDA $return_area      ; Warp to the stored return point: area, scene, then x and y
    STA $area_next
    LDA $return_scene
    STA $scene_next
    REP #$20
    LDA $return_x
    STA $warp_dest_x
    LDA $return_y
    STA $warp_dest_y
    SEP #$20
    JSL $@lib_system_helpers.EnableNmi
    BRL RunMainLoop
}

---------------------------------------------
; Runs one complete game frame from inside the scene loader (and once from the menu code), then returns with NMI enabled.
; 
; When: 12 call sites in the scene loader and 1 in the menu code, usually to let actors, scroll and OAM advance while the scene is being built.
; Sees: the scene appears and animates while the loader works (for example the iris transition).
; Why: the loader cannot wait for the main loop, so it steps the frame itself.
; In: any NMI state; M = 1; DBR kept. B, A (both bytes), X, Y and DBR are saved and restored.
; Out: one vblank has passed, NMI on. subframe_active is 1 during the work phase and 0 on return. The HUD is skipped while scene_loading ($0462) is non-zero; the camera update AimCameraAtPlayer runs here only.
; Clobbers: none visible; the callees use dp $00-$1C, $38-$3A and $42-$54.

RunSubFrameLoader {
    PHB 
    PHA 
    XBA 
    PHA 
    PHX 
    PHY 
    JSL $@lib_system_helpers.DisableNmi
    INC $subframe_active  ; subframe_active = 1: RunActorList now runs only actors with $16 bit $0010
    JSL $@lib_system_helpers.ResetHdmaQueue
    JSL $@engine_scheduler_sprites_combat_collision.RunActors
    JSL $@engine_scheduler_sprites_combat_collision.CullAndSortActors
    JSL $@lib_010000.AimCameraAtPlayer
    JSL $@lib_map_streaming.ScrollCameraByDelta
    JSL $@lib_map_streaming.BuildScrollStrips
    JSL $@engine_scheduler_sprites_combat_collision.BuildOamFromActors
    LDA $scene_loading    ; HUD skipped while $0462 is non-zero (set by the iris transition in the scene loader)
    BNE loc_00015D
    JSL $@lib_0118FC_part6.UpdateHud
    JSL $@lib_011695.code_011695

  loc_00015D:
    JSL $@lib_027223.QueueAnimatedTileStrip
    STZ $subframe_active
    JSL $@lib_system_helpers.EnableNmi
    JSL $@lib_system_helpers.WaitVBlank
    PLY 
    PLX 
    PLA 
    XBA 
    PLA 
    PLB 
    RTL 
}

---------------------------------------------
; Runs one complete game frame with NMI off before and after, adding the map sweep redraw (StepSweepRedraw).
; 
; When: 8 call sites in the lair release code (TriggerVariantPlate 1, ReleaseLairAtSwitch 4, PlayLairReleaseScene 3).
; Sees: the map sweep effect that redraws the map while those routines run.
; Why: lets the routine animate a multi-frame effect without leaving its own code.
; In: NMI must be off (OQ-I005-20); M = 1; DBR is set to $01 and restored.
; Out: one vblank passed; NMI off again. subframe_active is 1 during the work phase.
; Clobbers: none visible (B, A, X, Y saved).

RunSubFrameMapSweep {
    PHB 
    PHA 
    XBA 
    PHA 
    PHX 
    PHY 
    LDA #$01
    PHA 
    PLB 
    INC $subframe_active
    JSL $@lib_system_helpers.ResetHdmaQueue
    JSL $@engine_scheduler_sprites_combat_collision.RunActors
    JSL $@engine_scheduler_sprites_combat_collision.CullAndSortActors
    JSL $@lib_map_streaming.ScrollCameraByDelta
    JSL $@lib_map_streaming.BuildScrollStrips
    JSL $@engine_scheduler_sprites_combat_collision.BuildOamFromActors
    JSL $@lib_0118FC_part6.UpdateHud
    JSL $@lib_011695.code_011695
    JSL $@lib_027223.QueueAnimatedTileStrip
    JSL $@lib_map_sweep_redraw.StepSweepRedraw
    JSL $@lib_system_helpers.EnableNmi
    JSL $@lib_system_helpers.WaitVBlank
    JSL $@lib_system_helpers.DisableNmi
    STZ $subframe_active
    PLY 
    PLX 
    PLA 
    XBA 
    PLA 
    PLB 
    RTL 
}

---------------------------------------------
; Runs one complete game frame with NMI off before and after (actors, sort, scroll, OAM, HUD, tile strip), without the map sweep.
; 
; When: 4 call sites: WaitReturnDone, the text helpers WaitFrames and RunFrameReadButtons, and ScrollStaffRollText.
; Sees: actors keep animating while text prints or a return waits.
; Why: a routine that must wait several frames calls this instead of returning to the main loop.
; In: NMI must be off (OQ-I005-20); M = 1; DBR is set to $01 and restored.
; Out: one vblank passed; NMI off again. subframe_active is 1 during the work phase.
; Clobbers: none visible (B, A, X, Y saved).

RunSubFrame {
    PHB 
    PHA 
    XBA 
    PHA 
    PHX 
    PHY 
    LDA #$01
    PHA 
    PLB 
    INC $subframe_active
    JSL $@lib_system_helpers.ResetHdmaQueue
    JSL $@engine_scheduler_sprites_combat_collision.RunActors
    JSL $@engine_scheduler_sprites_combat_collision.CullAndSortActors
    JSL $@lib_map_streaming.ScrollCameraByDelta
    JSL $@lib_map_streaming.BuildScrollStrips
    JSL $@engine_scheduler_sprites_combat_collision.BuildOamFromActors
    JSL $@lib_0118FC_part6.UpdateHud
    JSL $@lib_011695.code_011695
    JSL $@lib_027223.QueueAnimatedTileStrip
    JSL $@lib_system_helpers.EnableNmi
    JSL $@lib_system_helpers.WaitVBlank
    JSL $@lib_system_helpers.DisableNmi
    STZ $subframe_active
    PLY 
    PLX 
    PLA 
    XBA 
    PLA 
    PLB 
    RTL 
}