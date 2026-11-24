; The scene scripts of the three outdoor areas of the World of Evil: the Phoenix-call scene, the Dazzling Space hazard and two BG2 scroll effects (file offsets 126573-126660 and 126666-127310, SNES $03:EE6D-$03:EEC4 and $03:EECA-$03:F14E, bank 03; asciistring_01EEC5 of we_obj_master_shrine_event lies between the two ranges). Scenes A14S01 (location $79), A14S02 ($7A) and A14S03 ($7B, the 'Dazzling Space'). Walkthrough chapter: docs/walkthrough/08-world-of-evil.md ('Sorry, the game doesn't give any clever names for these areas except the "Dazzling Space" zone later on').
; 
; === WHAT RUNS HERE ===
; Every script is a scene actor placed at tile (0,0) (MetaWorldOfEvil, rows of PlacementA14S01-03):
; - Type $06 we_fx_bg2_hofs_wave_01EEF3, row ;05 of A14S01 and A14S02: a sine wave on BG2's horizontal scroll, HDMA register $0F, 4 groups of 64 lines (the BG2 parallax is half of BG1's scroll).
; - Type $07 we_fx_bg2_vofs_wobble_01F063, row ;06 of A14S03: a small wobble on BG2's vertical scroll, HDMA register $10, 7 groups of 32 lines, and a constant diagonal drift of the BG2 offsets.
; - Type $04 we_obj_dazzling_space_hazard_01EECA, row ;04 of A14S03 only: a palette-cycle actor (meta animation list $37 of PaletteAnimLists, then $4F) that also hurts the hero by 1 HP every 8 frames unless Soul Armor (item $10) is equipped or the Phoenix has been called (flag $0A01). The walkthrough's Soul Armor and Soul Blade advice for the final battle ('If you equip SoulBlade and Soul Armor the Phoenix will be able to help you', said by the King of the Soul of Mountain House) is the context.
; - Type $14 we_obj_phoenix_call_scene_01EE6D, row ;15 of A14S03 (flags $01): the scene shown after the Phoenix is called in the Soul of Mountain House (the King sets $0A01 and sends the hero here at pixel ($00F8,$0128)); it moves the camera north, then returns the hero to the house.
; - Types $01, $02, $03 and $05 of the same rows run the shared palette tick shared_actor_helpers_bank0.cm_fx_palette_cycle_loop_0029E8 (animation banks $03, $34, $35, $38) and are not in this file.
; 
; === THE HDMA EFFECTS ===
; Both build their table in WRAM $7E7800 on the first frame (COP 91 then sets the re-entry point after the set-up) and queue it every frame through lib_system_helpers.QueueHdmaIndirect (A low = indirect bank $7E, A high = PPU register low byte, Y = $7800). Entries are repeat-mode groups ($C0 = 64 lines, $A0 = 32 lines) that all point at the same data row $7E7900, filled every frame with one word per scanline.
; - Wave (type $06): word = scroll_bg1_x / 2 + we_data_bg2_hofs_wave_table_01EF63[((frame_counter / 4 + scroll_bg1_y / 2) & $3F) + line]. The table is two periods of a sine with amplitude $20 (128 words), so the window of 64 words never runs off its end.
; - Wobble (type $07): word = scroll_bg2_y + we_data_bg2_vofs_wobble_table_01F0CF[((frame_counter / 4 + scroll_bg2_y) & $1F) + line], amplitude 4 (64 words, two periods of 32). Each frame it also does DEC bg2_offset_x and INC bg2_offset_y.
; 
; === OPEN ===
; Which actors the Phoenix-call scene parks (slots $0C, $0D, $10 and $11 are the nearest Wall Tiles and pop-up turrets of A14S03 by the row numbers) and what appears while the camera moves north (the Master says 'the palace of Deathtoll will appear', the Phoenix says 'Deathtoll moved into position') are open (OQ-I040-5). What animations $37 and $4F draw is open (OQ-I033-11).
---------------------------------------------

?BANK 03

?INCLUDE 'lib_system_helpers'

!frame_counter                  0312
!joy_block_mask                 0326
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!scroll_bg2_y                   0340
!bg2_offset_x                   038A
!bg2_offset_y                   038C
!player_actor                   039C

---------------------------------------------

; The scene after the Phoenix call: the camera runs north while the hero is hidden.
; 
; When: placement script (meta type $14, row ;15 of A14S03, flags $01); COP 07 with operand $0A01 (bit 15 clear) jumps when the flag is clear to we_obj_phoenix_call_not_called_01EEC2.
; Sees: with flag $0A01 set: the pad is blocked ($FF80), the actor is put at pixel ($00F8,$0138), slots $0C, $0D, $10 and $11 are moved to tile (0,1) (COP 11), COP 34 hides the player actors, 3 frames, sound BRK $86, then 250 frames in which the actor's y and the hero's y both drop by 1 per frame (the camera follows the hero, so the view moves north by 250 px), 241 more frames, and COP 10 to the Soul of Mountain House A0AS01 at pixel ($0100,$0360).
; Why: the Phoenix's voice says 'As soon as I was called, Deathtoll moved into position'; the Master says 'the palace of Deathtoll will appear in the World of Evil' (the pan is the shown part of that; OQ-I040-5). The King's farewell (flag $0A01 still set) follows in the house.
; In: X = D = slot $15.
; Out: the scene change; the script never returns normally.
; Clobbers: A, Y.

we_obj_phoenix_call_scene_01EE6D {
    COP [07] ( #$0A01, &we_obj_phoenix_call_not_called_01EEC2 ) ; operand $0A01 has bit 15 clear: jumps when the Phoenix is NOT called, to the idle branch
    LDA #$FF80
    TSB $joy_block_mask
    LDA #$00F8
    STA $0000, X
    LDA #$0138
    STA $0002, X
    COP [11] ( #0C, #00, #01 ) ; moves slot $0C to tile (0,1); slots $0D, $10 and $11 follow: the four actors nearest the arrival point are parked
    COP [11] ( #0D, #00, #01 )
    COP [11] ( #10, #00, #01 )
    COP [11] ( #11, #00, #01 )
    COP [34]              ; hides the player actors; the camera still follows the hero's y
    COP [03] ( #03 )
    COP [04]
    BRK #$86
    COP [03] ( #FA )      ; 250 frames: the actor's y and the hero's y drop by 1 per frame, the view runs north
    LDY $player_actor
    LDA $0002, X
    DEC 
    STA $0002, X
    STA $0002, Y
    COP [04]
    COP [03] ( #F1 )
    COP [04]
    COP [10] ( #$010A, #01, #$0100, #$0360 ) ; scene change to A0AS01 (Soul of Mountain House) at pixel ($0100,$0360); the King's farewell follows
}

---------------------------------------------
; The idle branch of the Phoenix-call actor.
; 
; When: flag $0A01 is clear (every normal visit of A14S03).
; Sees: COP 86.
; Why: the scene exists only for the call.
; In: X = D = slot $15.
; Out: the actor ends.
; Clobbers: none.

we_obj_phoenix_call_not_called_01EEC2 {
    COP [86]
    RTL 
}
---------------------------------------------

; The Dazzling Space: a palette cycle that hurts without Soul Armor.
; 
; When: placement script (meta type $04, row ;04 of A14S03); runs from the scene load.
; Sees: animation $37 of PaletteAnimLists started and ticked (COP 92 / COP 94), then a loop of 96 frames (COP 03 #60 / COP 04): flag $0A01 set (the Phoenix called) or item $10 (Soul Armor) equipped: nothing; otherwise we_obj_dazzling_space_hazard_damage_01EEDF. After the loop animation $4F is started and ticked and everything starts again.
; Why: the walkthrough: you need the Soul Armor in the Dazzling Space; the type is the area's own hazard (the walkthrough does not describe the damage, OQ-I040-6).
; In: X = D = slot $04.
; Out: loops for ever.
; Clobbers: A.

we_obj_dazzling_space_hazard_01EECA {
    COP [92] ( #37 )
    COP [94]
    COP [03] ( #60 )
    COP [07] ( #$8A01, &we_obj_dazzling_space_hazard_next_01EEEA ) ; bit 15 set: jumps when flag $0A01 is set: no damage while the Phoenix has been called
    COP [19] ( #10, &we_obj_dazzling_space_hazard_damage_01EEDF ) ; item $10 = Soul Armor: jumps to the damage tick when it is NOT equipped
    BRA we_obj_dazzling_space_hazard_next_01EEEA
}

---------------------------------------------
; The damage tick of the hazard.
; 
; When: Soul Armor not equipped and flag $0A01 clear, once per frame of the 96-frame loop.
; Sees: frame_counter & 7: only every 8th frame COP 39 with 1 (the hero loses 1 HP and gets the hit reaction).
; Why: the cost of walking the Dazzling Space without the armor.
; In: X = D = slot $04.
; Out: falls through to we_obj_dazzling_space_hazard_next_01EEEA.
; Clobbers: A.

we_obj_dazzling_space_hazard_damage_01EEDF {
    LDA $frame_counter
    AND #$0007
    BNE we_obj_dazzling_space_hazard_next_01EEEA
    COP [39] ( #01 )      ; 1 HP of damage every 8th frame
}

---------------------------------------------
; The loop end of the hazard: COP 04, then the second animation.
; 
; When: every frame of the loop (all branches land here).
; Sees: COP 04 repeats the loop until its 96 counts are used; then COP 92 / COP 94 start animation $4F and the script restarts at we_obj_dazzling_space_hazard_01EECA.
; Why: alternates the two palette-cycle lists every 96 frames.
; In: X = D = slot $04.
; Out: yields (COP 04) or loops.
; Clobbers: A.

we_obj_dazzling_space_hazard_next_01EEEA {
    COP [04]
    COP [92] ( #4F )
    COP [94]
    BRA we_obj_dazzling_space_hazard_01EECA
}
---------------------------------------------

; The BG2 horizontal wave of the first two areas.
; 
; When: placement script (meta type $06, row ;05 of A14S01 and A14S02).
; Sees: first frame: four HDMA entries ($C0 = 64 lines each, all pointing at $7E7900) and the end byte in $7E7800, then COP 91. Every frame: $16 = scroll_bg1_x / 2, $18 = scroll_bg1_y / 2, index = ((frame_counter / 4 + $18) & $3F) * 2 into we_data_bg2_hofs_wave_table_01EF63, 64 words are copied plus $16 into $7E7900, and QueueHdmaIndirect is called for register $0F (BG2HOFS).
; Why: the rippling backdrop of the World of Evil; BG2 scrolls at half the speed of BG1.
; In: X = D = the actor slot.
; Out: RTL each frame; $16, $18 and the HDMA table are written (DP $16 / $18 are scratch).
; Clobbers: A, Y (X and the data bank are restored).

we_fx_bg2_hofs_wave_01EEF3 {
    PHX 
    LDX #$0000

  loc_01EEF7:
    LDA #$00C0
    STA $7E7800, X
    LDA #$7900
    STA $7E7801, X
    INX 
    INX 
    INX 
    CPX #$000C
    BNE loc_01EEF7
    LDA #$0000
    STA $7E7800, X
    PLX 
    COP [91]
    LDA $scroll_bg1_x
    LSR 
    STA $16
    LDA $scroll_bg1_y
    LSR 
    STA $18
    PHX 
    LDA $frame_counter
    LSR 
    LSR 
    CLC 
    ADC $18
    AND #$003F
    ASL 
    TAX 
    LDY #$0000
    PHB 
    SEP #$20
    LDA #$7E
    PHA 
    PLB 
    REP #$20

  loc_01EF3D:
    LDA $@we_data_bg2_hofs_wave_table_01EF63, X
    CLC 
    ADC $16
    STA $7900, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0080
    BNE loc_01EF3D
    PLB 
    SEP #$20
    LDA #$0F
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaIndirect ; register $0F = BG2HOFS, indirect table in bank $7E at $7800
    REP #$20
    PLX 
    RTL 
}
---------------------------------------------

; 128 signed words: two periods of a sine of amplitude 32 (0, 3, 6, ... $20 ... 0, -3 ... -$20 ... 0), added to the BG2 horizontal scroll per scanline by we_fx_bg2_hofs_wave_01EEF3.

we_data_bg2_hofs_wave_table_01EF63 [
  #$0000   ;00
  #$0003   ;01
  #$0006   ;02
  #$0009   ;03
  #$000C   ;04
  #$000F   ;05
  #$0012   ;06
  #$0014   ;07
  #$0017   ;08
  #$0019   ;09
  #$001B   ;0A
  #$001C   ;0B
  #$001E   ;0C
  #$001F   ;0D
  #$001F   ;0E
  #$0020   ;0F
  #$0020   ;10
  #$0020   ;11
  #$001F   ;12
  #$001F   ;13
  #$001E   ;14
  #$001C   ;15
  #$001B   ;16
  #$0019   ;17
  #$0017   ;18
  #$0014   ;19
  #$0012   ;1A
  #$000F   ;1B
  #$000C   ;1C
  #$0009   ;1D
  #$0006   ;1E
  #$0003   ;1F
  #$0000   ;20
  #$FFFD   ;21
  #$FFFA   ;22
  #$FFF7   ;23
  #$FFF4   ;24
  #$FFF1   ;25
  #$FFEE   ;26
  #$FFEC   ;27
  #$FFE9   ;28
  #$FFE7   ;29
  #$FFE5   ;2A
  #$FFE4   ;2B
  #$FFE2   ;2C
  #$FFE1   ;2D
  #$FFE1   ;2E
  #$FFE0   ;2F
  #$FFE0   ;30
  #$FFE0   ;31
  #$FFE1   ;32
  #$FFE1   ;33
  #$FFE2   ;34
  #$FFE4   ;35
  #$FFE5   ;36
  #$FFE7   ;37
  #$FFE9   ;38
  #$FFEC   ;39
  #$FFEE   ;3A
  #$FFF1   ;3B
  #$FFF4   ;3C
  #$FFF7   ;3D
  #$FFFA   ;3E
  #$FFFD   ;3F
  #$0000   ;40
  #$0003   ;41
  #$0006   ;42
  #$0009   ;43
  #$000C   ;44
  #$000F   ;45
  #$0012   ;46
  #$0014   ;47
  #$0017   ;48
  #$0019   ;49
  #$001B   ;4A
  #$001C   ;4B
  #$001E   ;4C
  #$001F   ;4D
  #$001F   ;4E
  #$0020   ;4F
  #$0020   ;50
  #$0020   ;51
  #$001F   ;52
  #$001F   ;53
  #$001E   ;54
  #$001C   ;55
  #$001B   ;56
  #$0019   ;57
  #$0017   ;58
  #$0014   ;59
  #$0012   ;5A
  #$000F   ;5B
  #$000C   ;5C
  #$0009   ;5D
  #$0006   ;5E
  #$0003   ;5F
  #$0000   ;60
  #$FFFD   ;61
  #$FFFA   ;62
  #$FFF7   ;63
  #$FFF4   ;64
  #$FFF1   ;65
  #$FFEE   ;66
  #$FFEC   ;67
  #$FFE9   ;68
  #$FFE7   ;69
  #$FFE5   ;6A
  #$FFE4   ;6B
  #$FFE2   ;6C
  #$FFE1   ;6D
  #$FFE1   ;6E
  #$FFE0   ;6F
  #$FFE0   ;70
  #$FFE0   ;71
  #$FFE1   ;72
  #$FFE1   ;73
  #$FFE2   ;74
  #$FFE4   ;75
  #$FFE5   ;76
  #$FFE7   ;77
  #$FFE9   ;78
  #$FFEC   ;79
  #$FFEE   ;7A
  #$FFF1   ;7B
  #$FFF4   ;7C
  #$FFF7   ;7D
  #$FFFA   ;7E
  #$FFFD   ;7F
]
---------------------------------------------

; The BG2 vertical wobble of the Dazzling Space.
; 
; When: placement script (meta type $07, row ;06 of A14S03).
; Sees: first frame: seven HDMA entries ($A0 = 32 lines each, all pointing at $7E7900), then COP 91. Every frame: DEC bg2_offset_x, INC bg2_offset_y (the BG2 offsets drift diagonally), index = ((frame_counter / 4 + scroll_bg2_y) & $1F) * 2 into we_data_bg2_vofs_wobble_table_01F0CF, 32 words plus scroll_bg2_y are copied into $7E7900 and QueueHdmaIndirect is called for register $10 (BG2VOFS).
; Why: the shimmer of the Dazzling Space backdrop.
; In: X = D = the actor slot.
; Out: RTL each frame; bg2_offset_x and bg2_offset_y change.
; Clobbers: A, Y (X and the data bank are restored).

we_fx_bg2_vofs_wobble_01F063 {
    PHX 
    LDX #$0000

  loc_01F067:
    LDA #$00A0
    STA $7E7800, X
    LDA #$7900
    STA $7E7801, X
    INX 
    INX 
    INX 
    CPX #$0015
    BNE loc_01F067
    LDA #$0000
    STA $7E7800, X
    PLX 
    COP [91]
    PHX 
    DEC $bg2_offset_x
    INC $bg2_offset_y
    LDA $frame_counter
    LSR 
    LSR 
    CLC 
    ADC $scroll_bg2_y
    AND #$001F
    ASL 
    TAX 
    LDY #$0000
    SEP #$20
    PHB 
    LDA #$7E
    PHA 
    PLB 
    REP #$20

  loc_01F0A8:
    LDA $@we_data_bg2_vofs_wobble_table_01F0CF, X
    CLC 
    ADC $0340
    STA $7900, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0040
    BNE loc_01F0A8
    PLB 
    SEP #$20
    LDA #$10
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaIndirect ; register $10 = BG2VOFS, indirect table in bank $7E at $7800
    REP #$20
    PLX 
    RTL 
}
---------------------------------------------

; 64 signed words: two periods of a sine of amplitude 4 (0, 1, 2, 2, 3, 3, 4 ... -4 ... 0), added to the BG2 vertical scroll per scanline by we_fx_bg2_vofs_wobble_01F063.

we_data_bg2_vofs_wobble_table_01F0CF [
  #$0000   ;00
  #$0001   ;01
  #$0002   ;02
  #$0002   ;03
  #$0003   ;04
  #$0003   ;05
  #$0004   ;06
  #$0004   ;07
  #$0004   ;08
  #$0004   ;09
  #$0004   ;0A
  #$0003   ;0B
  #$0003   ;0C
  #$0002   ;0D
  #$0002   ;0E
  #$0001   ;0F
  #$0000   ;10
  #$FFFF   ;11
  #$FFFE   ;12
  #$FFFE   ;13
  #$FFFD   ;14
  #$FFFD   ;15
  #$FFFC   ;16
  #$FFFC   ;17
  #$FFFC   ;18
  #$FFFC   ;19
  #$FFFC   ;1A
  #$FFFD   ;1B
  #$FFFD   ;1C
  #$FFFE   ;1D
  #$FFFE   ;1E
  #$FFFF   ;1F
  #$0000   ;20
  #$0001   ;21
  #$0002   ;22
  #$0002   ;23
  #$0003   ;24
  #$0003   ;25
  #$0004   ;26
  #$0004   ;27
  #$0004   ;28
  #$0004   ;29
  #$0004   ;2A
  #$0003   ;2B
  #$0003   ;2C
  #$0002   ;2D
  #$0002   ;2E
  #$0001   ;2F
  #$0000   ;30
  #$FFFF   ;31
  #$FFFE   ;32
  #$FFFE   ;33
  #$FFFD   ;34
  #$FFFD   ;35
  #$FFFC   ;36
  #$FFFC   ;37
  #$FFFC   ;38
  #$FFFC   ;39
  #$FFFC   ;3A
  #$FFFD   ;3B
  #$FFFD   ;3C
  #$FFFE   ;3D
  #$FFFE   ;3E
  #$FFFF   ;3F
]