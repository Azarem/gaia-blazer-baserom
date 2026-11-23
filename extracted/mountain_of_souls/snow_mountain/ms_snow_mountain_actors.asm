; The ice sliding of the top of Snow Mountain and the Ice field of Laynole (file offsets 139090-139788, SNES $04:9F52-$A20C): a marker scan that tells when the hero is on the ice, and the slide itself.
; 
; === WHAT RUNS HERE ===
; Two actors placed together in A0CS01 (top of Snow Mountain, location $45) and A0CS03 (Ice field of Laynole, location $47): meta type $3A ms_obj_ice_marker_scan_021F52 and $3B ms_obj_ice_slide_022007.
; - The marker scan reads a list of (x, y, value) records for its location (ms_ice_markers_summit_021FA9 for $45, ms_ice_markers_laynole_021FED for $47; any other location: it kills itself). Every frame it compares the hero's exact pixel position with the markers; on a hit, value 1 sets scene flag $0000 (the hero is on the ice) and value 0 clears it.
; - The slide waits for flag $0000 (COP 05). Without the Mushroom Shoes (item $22; COP 19 jumps unless they are equipped) and when the hero's animation is a walking one (table ms_ice_walk_anims_022032), it takes the direction of that animation from PlayerMoveDirByAnim (0 up, 1 down, 2 right, 3 left), blocks input and moves the hero 2 pixels per frame in that direction (COP 2F) until the flag clears or a wall stops him; then it releases input and waits again.
; - A wall is checked at each tile boundary on the way: COP 21 / 22 / 23 / 24 when the hero is also aligned on the cross axis, otherwise two explicit checks of tile_type_map (a non-zero byte is solid) by ms_obj_ice_tile_blocked_0221FA.
; 
; === EVENT FLAGS ===
; Scene flag $0000: the hero stands on the ice (set by the entry markers, cleared by the exit markers). Item $22 = Mushroom Shoes (the walkthrough: the shoes stop the sliding on level ice; 'Once on the ice, you'll automatically go south').
; 
; === OPEN ===
; The marker positions were read from the data, not verified at runtime; which marker is an entry and which an exit in the game (OQ-I037-8). The hero's +$14 word that the slide clears is not named (OQ-I037-5).
---------------------------------------------

?BANK 04

?INCLUDE 'data_engine_tables'
?INCLUDE 'lib_map_index_helpers'

!joy_block_mask                 0326
!player_actor                   039C
!location_id                    1C6A
!tile_type_map                  7F8000

---------------------------------------------

; Sets and clears scene flag $0000 when the hero stands exactly on a marker.
; 
; When: meta type $3A, placed in A0CS01 and A0CS03; runs every frame (COP 91).
; Sees: location $45 uses ms_ice_markers_summit_021FA9, $47 ms_ice_markers_laynole_021FED; any other location: COP 86. Each record is three words (x, y, value) at bank 4; the list ends with $FFFF. The hero's x (+0) and y (+2) must both equal the record. A match with value 0 clears the flag, any other value sets it (COP 09).
; Why: the slide needs to know where the ice starts and ends; markers on the entry and exit tiles do that without a map layer.
; In: X = D = slot.
; Out: RTL each frame (PLX keeps X for COP 91).
; Clobbers: A, Y.

ms_obj_ice_marker_scan_021F52 {
    LDA $location_id
    AND #$00FF
    CMP #$0045
    BEQ loc_021F6D
    CMP #$0047
    BEQ loc_021F65
    COP [86]
    RTL 

  loc_021F65:
    COP [91]
    PHX 
    LDX #$&ms_ice_markers_laynole_021FED
    BRA loc_021F73

  loc_021F6D:
    COP [91]
    PHX 
    LDX #$&ms_ice_markers_summit_021FA9

  loc_021F73:
    LDY $player_actor

  loc_021F76:
    LDA $040000, X
    CMP #$FFFF
    BEQ loc_021F95
    CMP $0000, Y
    BNE loc_021F8D
    LDA $040002, X
    CMP $0002, Y
    BEQ loc_021F97

  loc_021F8D:
    TXA 
    CLC 
    ADC #$0006
    TAX 
    BRA loc_021F76

  loc_021F95:
    PLX 
    RTL 

  loc_021F97:
    LDA $040004, X
    BEQ loc_021FA3
    COP [09] ( #$8000 )   ; marker value non-zero: sets flag $0000 (the hero is on the ice)
    BRA loc_021FA7

  loc_021FA3:
    COP [09] ( #$0000 )   ; marker value 0: clears flag $0000 (the hero left the ice)

  loc_021FA7:
    PLX 
    RTL 
}
---------------------------------------------

; Ice markers of the top of Snow Mountain ($45): 11 records.
; 
; When: read by ms_obj_ice_marker_scan_021F52.
; Sees: six records with value 1 ((x,y): $00A0,$00B0; $01C0,$00A0; $0290,$0230; $0170,$01D0; $01C0,$0260; $0290,$00A0) and five with value 0, each 16 pixels (one tile) above its partner ($00A0,$00A0; $01C0,$0090; $0290,$0220; $0170,$01C0; $01C0,$0250); the sixth value-1 record ($0290,$00A0) has no partner.
; Why: the on / off pairs mark the ice by position; which tile is the entry is OQ-I037-8.
; In: n/a (data, 3 words per record).
; Out: n/a.
; Clobbers: n/a.

ms_ice_markers_summit_021FA9 [
  unk15 < #$00A0, #$00B0, #$0001 >   ;00
  unk15 < #$01C0, #$00A0, #$0001 >   ;01
  unk15 < #$0290, #$0230, #$0001 >   ;02
  unk15 < #$0170, #$01D0, #$0001 >   ;03
  unk15 < #$01C0, #$0260, #$0001 >   ;04
  unk15 < #$0290, #$00A0, #$0001 >   ;05
  unk15 < #$00A0, #$00A0, #$0000 >   ;06
  unk15 < #$01C0, #$0090, #$0000 >   ;07
  unk15 < #$0290, #$0220, #$0000 >   ;08
  unk15 < #$0170, #$01C0, #$0000 >   ;09
  unk15 < #$01C0, #$0250, #$0000 >   ;0A
]

---------------------------------------------
; Ice markers of the Ice field of Laynole ($47): 4 records.
; 
; When: read by ms_obj_ice_marker_scan_021F52.
; Sees: value 1 at ($0220,$0200), ($0120,$0140) and ($01A0,$01A0); value 0 at ($0220,$0210).
; Why: see ms_ice_markers_summit_021FA9.
; In: n/a (data, 3 words per record).
; Out: n/a.
; Clobbers: n/a.

ms_ice_markers_laynole_021FED [
  unk15 < #$0220, #$0200, #$0001 >   ;00
  unk15 < #$0120, #$0140, #$0001 >   ;01
  unk15 < #$01A0, #$01A0, #$0001 >   ;02
  unk15 < #$0220, #$0210, #$0000 >   ;03
]
---------------------------------------------

; The ice slide: waits for the ice flag and starts a slide when the hero walks without the Mushroom Shoes.
; 
; When: meta type $3B, placed in A0CS01 and A0CS03; runs every frame.
; Sees: input is released ($2F80 cleared), COP 91, COP 05 waits for flag $0000 (the hero is on the ice), COP 19 on item $22: jumps unless the shoes are equipped, to code_02201C; with the shoes the actor yields with COP 27 and starts over.
; Why: the Mushroom Shoes cancel the slide on level ice (the boy's text).
; In: X = D = slot.
; Out: RTL after COP 27 or into code_02201C.
; Clobbers: A, Y.

ms_obj_ice_slide_022007 {
    LDA #$2F80
    TRB $joy_block_mask
    COP [91]
    COP [05] ( #$0000 )   ; waits until flag $0000 is set (the hero stands on the ice)
    COP [19] ( #22, &code_02201C ) ; item $22 = Mushroom Shoes; jumps unless they are equipped: the slide only runs without them
    COP [27] ( &ms_obj_ice_slide_022007 )
}

---------------------------------------------
; Starts a slide when the hero's animation is a walking one.
; 
; When: ms_obj_ice_slide_022007 without the Mushroom Shoes.
; Sees: A = the hero's animation id (+$1E) & $3F, looked up in ms_ice_walk_anims_022032; non-zero branches to ms_obj_ice_slide_move_022072, zero returns (RTL).
; Why: a standing hero does not slide.
; In: X = own slot, Y is loaded with player_actor.
; Out: RTL or branch.
; Clobbers: A, Y.

code_02201C {
    LDY $player_actor
    LDA $001E, Y
    AND #$003F
    PHX 
    TAX 
    LDA $@ms_ice_walk_anims_022032, X
    PLX 
    AND #$00FF
    BNE ms_obj_ice_slide_move_022072
    RTL 
}
---------------------------------------------

; Table of the animation ids that count as walking: 64 bytes, 1 for ids $04-$13, $25, $26, $28 and $2A.
; 
; When: read by code_02201C.
; Sees: n/a (data).
; Why: the ids are the walking and running poses of the hero (the exact poses were not matched to ids here).
; In: n/a (data, index = animation id & $3F).
; Out: n/a.
; Clobbers: n/a.

ms_ice_walk_anims_022032 [
  #00   ;00
  #00   ;01
  #00   ;02
  #00   ;03
  #01   ;04
  #01   ;05
  #01   ;06
  #01   ;07
  #01   ;08
  #01   ;09
  #01   ;0A
  #01   ;0B
  #01   ;0C
  #01   ;0D
  #01   ;0E
  #01   ;0F
  #01   ;10
  #01   ;11
  #01   ;12
  #01   ;13
  #00   ;14
  #00   ;15
  #00   ;16
  #00   ;17
  #00   ;18
  #00   ;19
  #00   ;1A
  #00   ;1B
  #00   ;1C
  #00   ;1D
  #00   ;1E
  #00   ;1F
  #00   ;20
  #00   ;21
  #00   ;22
  #00   ;23
  #00   ;24
  #01   ;25
  #01   ;26
  #00   ;27
  #01   ;28
  #00   ;29
  #01   ;2A
  #00   ;2B
  #00   ;2C
  #00   ;2D
  #00   ;2E
  #00   ;2F
  #00   ;30
  #00   ;31
  #00   ;32
  #00   ;33
  #00   ;34
  #00   ;35
  #00   ;36
  #00   ;37
  #00   ;38
  #00   ;39
  #00   ;3A
  #00   ;3B
  #00   ;3C
  #00   ;3D
  #00   ;3E
  #00   ;3F
]
---------------------------------------------

; Stores the slide direction and keeps sliding every frame.
; 
; When: code_02201C found a walking pose.
; Sees: the direction = PlayerMoveDirByAnim[hero animation id] goes to own $2C, the hero's +$14 word is cleared, input is blocked ($2F80 set), COP 91. From now on each frame: COP 07 with bit 15 clear jumps to code_0220B4 when flag $0000 is clear (the hero left the ice: the slide ends), COP 19 on item $22 jumps to the step when the shoes are not equipped, otherwise to code_0220B4 (restart).
; Why: the direction is fixed at the start, so the hero slides until a wall or the end of the ice.
; In: X = own slot, Y = player_actor.
; Out: RTL (via the step) or the restart.
; Clobbers: A, Y.

ms_obj_ice_slide_move_022072 {
    LDA $001E, Y
    TAY 
    LDA $&data_engine_tables.PlayerMoveDirByAnim, Y
    STA $002C, X
    LDY $player_actor
    LDA #$0000
    STA $0014, Y
    LDA #$2F80
    TSB $joy_block_mask
    COP [91]
    COP [07] ( #$0000, &code_0220B4 ) ; bit 15 clear: jumps when flag $0000 is clear: the hero left the ice, the slide ends
    COP [19] ( #22, &ms_obj_ice_slide_step_02209B )
    BRL code_0220B4
}

---------------------------------------------
; One frame of the slide: checks the wall and moves the hero 2 pixels.
; 
; When: every frame while the slide runs.
; Sees: the direction in own $2C: 0 up (loc_0220B8), 1 down (loc_022106), 2 right (loc_0221A6), 3 left (loc_022152). Each branch tests for a wall only when the hero is on a 16-pixel boundary along the direction of travel: if he is also aligned on the cross axis, the tile ahead is tested with COP 21 / 22 / 23 / 24; otherwise the two tiles ahead are tested with ms_obj_ice_tile_blocked_0221FA. A wall jumps to code_0220B3 and ends the slide. If free (or between boundaries): COP 2F shifts the hero by (0,-2), (0,+2), (+2,0) or (-2,0).
; Why: the slide stops at the first wall in the direction, never in the middle of a tile.
; In: X = own slot (PHX / PLX around the step), DBR as set by the script.
; Out: RTL; a wall ends in code_0220B4 (COP 27 back to ms_obj_ice_slide_022007).
; Clobbers: A, X, dp$16, dp$18.

ms_obj_ice_slide_step_02209B {
    LDA $002C, X
    PHX 
    LDX $player_actor
    AND #$00FF
    BEQ loc_0220B8
    DEC 
    BEQ loc_022106
    DEC 
    BNE loc_0220B0
    BRL loc_0221A6

  loc_0220B0:
    BRL loc_022152

  code_0220B3:
    PLX 
}

code_0220B4 {
    COP [27] ( &ms_obj_ice_slide_022007 )

  loc_0220B8:
    LDA $0002, X
    AND #$000F
    BNE loc_0220FE
    LDA $0000, X
    AND #$000F
    BEQ loc_0220FA
    LDA $0000, X
    AND #$FFF0
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0020
    STA $18
    JSR $&ms_obj_ice_tile_blocked_0221FA
    BCS code_0220B3
    LDA $0000, X
    AND #$FFF0
    CLC 
    ADC #$0010
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0020
    STA $18
    JSR $&ms_obj_ice_tile_blocked_0221FA
    BCS code_0220B3
    BRA loc_0220FE

  loc_0220FA:
    COP [21] ( &code_0220B3 )

  loc_0220FE:
    COP [2F] ( #$0000, #$FFFE ) ; up: shifts the hero by dy = -2
    PLX 
    RTL 

  loc_022106:
    LDA $0002, X
    AND #$000F
    BNE loc_02214A
    LDA $0000, X
    AND #$000F
    BEQ loc_022146
    LDA $0000, X
    AND #$FFF0
    STA $16
    LDA $0002, X
    STA $18
    JSR $&ms_obj_ice_tile_blocked_0221FA
    BCC loc_02212B
    BRL code_0220B3

  loc_02212B:
    LDA $0000, X
    AND #$FFF0
    CLC 
    ADC #$0010
    STA $16
    LDA $0002, X
    STA $18
    JSR $&ms_obj_ice_tile_blocked_0221FA
    BCC loc_022144
    BRL code_0220B3

  loc_022144:
    BRA loc_02214A

  loc_022146:
    COP [22] ( &code_0220B3 )

  loc_02214A:
    COP [2F] ( #$0000, #$0002 ) ; down: shifts the hero by dy = +2
    PLX 
    RTL 

  loc_022152:
    LDA $0000, X
    AND #$000F
    BNE loc_02219E
    LDA $0002, X
    AND #$000F
    BEQ loc_02219A
    LDA $0000, X
    SEC 
    SBC #$0010
    STA $16
    LDA $0002, X
    AND #$FFF0
    SEC 
    SBC #$0010
    STA $18
    JSR $&ms_obj_ice_tile_blocked_0221FA
    BCC loc_02217F
    BRL code_0220B3

  loc_02217F:
    LDA $0000, X
    SEC 
    SBC #$0010
    STA $16
    LDA $0002, X
    AND #$FFF0
    STA $18
    JSR $&ms_obj_ice_tile_blocked_0221FA
    BCC loc_022198
    BRL code_0220B3

  loc_022198:
    BRA loc_02219E

  loc_02219A:
    COP [23] ( &code_0220B3 )

  loc_02219E:
    COP [2F] ( #$FFFE, #$0000 ) ; left: shifts the hero by dx = -2
    PLX 
    RTL 

  loc_0221A6:
    LDA $0000, X
    AND #$000F
    BNE loc_0221F2
    LDA $0002, X
    AND #$000F
    BEQ loc_0221EE
    LDA $0000, X
    CLC 
    ADC #$0010
    STA $16
    LDA $0002, X
    AND #$FFF0
    SEC 
    SBC #$0010
    STA $18
    JSR $&ms_obj_ice_tile_blocked_0221FA
    BCC loc_0221D3
    BRL code_0220B3

  loc_0221D3:
    LDA $0000, X
    CLC 
    ADC #$0010
    STA $16
    LDA $0002, X
    AND #$FFF0
    STA $18
    JSR $&ms_obj_ice_tile_blocked_0221FA
    BCC loc_0221EC
    BRL code_0220B3

  loc_0221EC:
    BRA loc_0221F2

  loc_0221EE:
    COP [24] ( &code_0220B3 )

  loc_0221F2:
    COP [2F] ( #$0002, #$0000 ) ; right: shifts the hero by dx = +2
    PLX 
    RTL 
}

---------------------------------------------
; Tests whether the pixel position at dp$16 / dp$18 lies on a solid tile.
; 
; When: JSR from ms_obj_ice_slide_step_02209B, one or two times per frame.
; Sees: PixelToMapIndex of (dp$16, dp$18) indexes tile_type_map; a non-zero byte is solid.
; Why: the slide cannot use the actor tile test when the hero is between two tiles.
; In: dp$16 = x, dp$18 = y in pixels; X is saved (PHX / PLX).
; Out: carry set = blocked, carry clear = free.
; Clobbers: A.

ms_obj_ice_tile_blocked_0221FA {
    PHX 
    JSL $@lib_map_index_helpers.PixelToMapIndex
    LDA $tile_type_map, X
    PLX 
    AND #$00FF
    BNE loc_02220B
    CLC 
    RTS 

  loc_02220B:
    SEC 
    RTS 
}