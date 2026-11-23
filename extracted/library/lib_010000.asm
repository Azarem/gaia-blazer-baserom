; Camera aim: one routine, AimCameraAtPlayer (file offsets 65536-65640, SNES $02:8000-$8068, bank 02).
; 
; The camera follows the player without smoothing: AimCameraAtPlayer converts 'where the camera should be' into the signed deltas scroll_delta_x and scroll_delta_y, and ScrollCameraByDelta (lib_map_streaming) applies them in the same frame. The whole scroll model is in the lib_map_streaming block note.
---------------------------------------------

?BANK 02

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_px                   0342
!map_height_px                  0344
!player_x                       0374
!player_y                       0376
!scroll_delta_x                 0382
!scroll_delta_y                 0384
!view_height_px                 03CA

---------------------------------------------

; Computes how far the camera must move to centre on the player and stores it as the scroll deltas.
; 
; When: every frame from the player code (player_core), in every sub-frame of the scene loader (RunSubFrameLoader), and from the Grass Valley name-entry actor.
; Sees: the screen follows the player and stops at the map edges (the walkthrough's rooms scroll only as far as the map goes).
; Why: keeps the scroll logic in one place: this routine only says where to go, ScrollCameraByDelta does the clamping to the map and the strip requests.
; In: none (native mode; M and X are set to 16 bits inside). Reads player_x, player_y, scroll_bg1_x, scroll_bg1_y, map_width_px, map_height_px, view_height_px.
; Out: scroll_delta_x = target x - scroll_bg1_x with target x = player_x - $70, limited to 0 .. map_width_px - $100; scroll_delta_y likewise with player_y - $80 and the view height view_height_px ($E0 or $100) in place of $100. The scroll itself is not changed.
; Clobbers: A, X, Y (P restored).

AimCameraAtPlayer {
    PHP 
    REP #$30
    LDX #$0000
    TXY 
    LDA $scroll_bg1_x
    PHA 
    LDA $player_x
    SEC 
    SBC #$0070            ; Target x: the player's x minus $70, so the player sits a little left of the centre of the 256-pixel view
    BPL loc_010019
    LDA #$0000
    BRA loc_01002F

  loc_010019:
    CLC 
    ADC #$0100
    CMP $map_width_px
    BCS loc_010028
    SEC 
    SBC #$0100
    BRA loc_01002F

  loc_010028:
    LDA $map_width_px
    SEC 
    SBC #$0100

  loc_01002F:
    SEC 
    SBC $01, S            ; Delta = target - current scroll: the camera snaps to its target in one frame (no easing)
    TAX 
    PLA 
    LDA $scroll_bg1_y
    PHA 
    LDA $player_y
    SEC 
    SBC #$0080
    BPL loc_010046
    LDA #$0000
    BRA loc_01005C

  loc_010046:
    CLC 
    ADC $view_height_px
    CMP $map_height_px
    BCS loc_010055
    SEC 
    SBC $view_height_px
    BRA loc_01005C

  loc_010055:
    LDA $map_height_px
    SEC 
    SBC $view_height_px

  loc_01005C:
    SEC 
    SBC $01, S
    TAY 
    PLA 
    STX $scroll_delta_x
    STY $scroll_delta_y
    PLP 
    RTL 
}