; The dream scripts, the Master's Emblem F trigger and three screen effects of the dungeon scenes of the Mountain of Souls (file offsets 138516-138957 and 140042-140441, SNES $04:9D14-$9ECD and $04:A30A-$A498; the multi-area actors lie between the two ranges).
; 
; === WHAT RUNS HERE ===
; Meta types, all started by placement rows of the A0B scenes (area $0B = the dungeon, scene n = location $3D + n):
; - $40 ms_npc_old_man_dream_021D14 and $41 ms_npc_old_man_dream_girl_021DF8: the old man's dream (A0BS03, location $40), rows $07 and $08 at tiles ($0B,$0E) and ($0C,$0E). The old man speaks and sends the hero back; $41 is a figure that only returns (RTL), probably the girl of the dream (OQ-I037-12).
; - $42 ms_npc_mushroom_dream_021DF9: the sleeping mushroom of its dream (A0BS06, location $43), row $04 at tile ($20,$2E): a talk handler and a way out at tile ($1C,$31).
; - $43 ms_obj_master_emblem_f_021E8F: the Master's Emblem F trigger in the underground lake (A0BS05, location $42), row $08 at ($01,$00): the hero standing at tile ($20,$2E) gets the item once.
; - $10 ms_effect_hdma_bg2_shear_02230A (A0BS01), $11 ms_effect_hdma_bg2_wave_02237E (A0BS02, A0BS03, A0BS07) and $3C ms_effect_hdma_coldata_gradient_022457 (A0BS02, A0BS03): HDMA effects that rebuild their table every frame (COP 91, then PHX / PLX around the table code); see the part notes (OQ-I037-11: what each looks like on screen is not verified at runtime).
; 
; === DREAM TEXTS ===
; Old man: 'I will not leave you and go off to other places I promise. As proof of my promise, I buried my belongings in the Aurora Ridge. The Magic Armor, 50 GEMs, and one Medical Herb. I hope someone will find them.' Mushroom: 'This is my hometown. The mountain winds carried my spores and now we live there.' and at the exit 'Make sure you don t walk around in a dream or you will get lost.' Emblem F: '<name> found Master s Emblem F.'
; 
; === EVENT FLAGS ===
; $0707 the old man's dream was seen (set at the end of his speech, tested by ms_npc_grandpa_dream_rod_0218BF in the house); $1A05 the Master's Emblem F was found (set by the trigger, tested at its start). Item $2F = Master's Emblem F.
; 
; === OPEN ===
; The walkthrough (chapter 5): speak with the mushroom in the westernmost cell with the Dream Rod equipped, press the switch in the dream, walk left out of the dream, and stand on the northernmost point of the island for the Emblem; the trigger tile ($20,$2E) is the ROM's version of that point (not verified at runtime). OQ-I037-11, OQ-I037-12.
---------------------------------------------

?BANK 04

?INCLUDE 'lib_system_helpers'
?INCLUDE 'shared_actor_helpers_bank4'

!frame_counter                  0312
!joy_block_mask                 0326
!cgram_buffer                   7F0000

---------------------------------------------

; The old man of his dream: the speech about the buried belongings, then back to the house.
; 
; When: placement script (type $40, A0BS03).
; Sees: input is blocked ($2F80 in joy_block_mask), two frames, COP 34 hides the player actors, 61 frames of wait, flip X set, animation $02, the text 'I will not leave you and go off to other places I promise ...' (the Magic Armor, 50 GEMs and one Medical Herb buried in the Aurora Ridge), flag $0707 set, input released, transition type 4 (COP 3C) and COP 10 to area $0A scene $01 (A0AS01, the house) at pixel ($0330,$0370).
; Why: the dream is a cut scene; the flag makes the old man in the house say 'Oops! I must have fallen asleep.' afterwards.
; In: X = D = slot (placement row $07).
; Out: RTL after COP 10.
; Clobbers: A.

ms_npc_old_man_dream_021D14 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #02 )
    COP [04]
    COP [34]
    COP [03] ( #3D )
    COP [04]
    COP [96]
    COP [80] ( #02 )
    COP [82]
    COP [01] ( &asciistring_021D48 )
    COP [09] ( #$8707 )   ; flag $0707 = the old man's dream was seen; tested by the old man in the house
    LDA #$2F80
    TRB $joy_block_mask
    COP [3C] ( #04 )
    COP [10] ( #$010A, #00, #$0330, #$0370 ) ; area $0A scene $01 = A0AS01, the Soul of Mountain House
    RTL 
}

asciistring_021D48 |[10]I will not leave you [N]and go off to other [N]places I promise- [FIN]As proof of my [N]promise, I buried my [N]belongings in the [N]Aurora Ridge- [FIN]The Magic Armor, [N]50 GEMs, and [N]one Medical Herb- [FIN]I hope someone will [N]find them- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Meta type $41: an actor whose script is only RTL.
; 
; When: placement row $08 of A0BS03, next to the old man.
; Sees: nothing; it is shown with the sprite and animation of its meta type (the earlier analysis: animation 8, probably the girl, OQ-I037-12).
; Why: scenery of the dream.
; In: X = D = slot.
; Out: RTL.
; Clobbers: none.

ms_npc_old_man_dream_girl_021DF8 {
    RTL 
}
---------------------------------------------

; The mushroom in its dream: tells where it comes from and warns about leaving.
; 
; When: placement script (type $42, A0BS06, tile ($20,$2E)).
; Sees: COP 15 blocks its tiles, talk handler code_021E1A ('This is my hometown. The mountain winds carried my spores and now we live there.'), COP 91, then a per-frame COP 0D test on slot 0 (the hero) against tile ($1C,$31): code_021E09 shows 'Make sure you don t walk around in a dream or you will get lost.', transition type 4 and COP 10 to area $0A scene $01 (A0AS01) at pixel ($0120,$02C0).
; Why: the exit of the dream is a tile on the walkway, not a door (walkthrough: walk left out of the dream).
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

ms_npc_mushroom_dream_021DF9 {
    COP [15]
    COP [17] ( &code_021E1A )
    COP [91]
    COP [0D] ( #00, #1C, #31, &code_021E09 ) ; slot 0 (the hero) at tile ($1C,$31) = the way out of the dream
    RTL 
}

code_021E09 {
    COP [01] ( &asciistring_021E64 )
    COP [3C] ( #04 )
    COP [10] ( #$010A, #01, #$0120, #$02C0 )
    RTL 
}

code_021E1A {
    COP [01] ( &asciistring_021E1F )
    RTL 
}

asciistring_021E1F |[10]This is my [N]hometown- [FIN]The mountain winds [N]carried my spores and [N]now we live there- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021E64 |[10]Make sure you don t [N]walk around in a dream[N]or you will get lost- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Trigger actor for the Master's Emblem F.
; 
; When: placement script (type $43, A0BS05, row $08).
; Sees: flag $1A05 set (the emblem was found): code_021EAC kills the actor. Otherwise COP 91 and a per-frame COP 0D test of slot 0 against tile ($20,$2E): code_021E9F shows '<name> found Master s Emblem F.', sound $5E, gives item $2F, sets flag $1A05 and falls into code_021EAC (COP 86).
; Why: the emblem is a place, not a chest; the flag makes the actor vanish on later visits.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

ms_obj_master_emblem_f_021E8F {
    COP [07] ( #$9A05, &code_021EAC ) ; bit 15 set: jumps when flag $1A05 (Emblem F found) is set
    COP [91]
    COP [0D] ( #00, #20, #2E, &code_021E9F ) ; slot 0 (the hero) at tile ($20,$2E)
    RTL 
}

code_021E9F {
    COP [01] ( &asciistring_021EAF )
    BRK #$5E
    COP [0A] ( #2F )      ; item $2F = Master's Emblem F
    COP [09] ( #$9A05 )
}

code_021EAC {
    COP [86]
    RTL 
}

asciistring_021EAF |[10][02:2] found [N][03:24]Master s Emblem F- [03:20][JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; HDMA effect of the north slope: the lines below a fixed top part are shifted by a ramp.
; 
; When: placement script (type $10, A0BS01); runs once per frame after COP 91.
; Sees: setup writes the table at $7E:7800 once: an entry of $7F lines and one of $10 lines with value 0 (the top 143 lines are not shifted), then 80 entries of one line each, ended by a 0 byte. Every frame the loop queues the table (JSL QueueHdmaDirect, register $0F = BG2HOFS) and refills the 80 values with a ramp: the step is (scroll_bg1_x - $60) * 2, the value of each line is the running sum of that step, stored with its two bytes swapped (XBA).
; Why: a perspective-like shear of the second layer that follows the scroll position.
; In: X = D = slot; M = 16.
; Out: RTL each frame (PLX / PHX keep X for COP 91).
; Clobbers: A, Y, dp$00, dp$0C.

ms_effect_hdma_bg2_shear_02230A {
    PHX 
    LDX #$0000
    LDA #$007F            ; first entry: $7F lines with value 0; the next entry is $10 lines: the top 143 lines are not shifted
    STA $7E7800, X
    LDA #$0010
    STA $7E7803, X
    LDA #$0000
    STA $7E7801, X
    STA $7E7804, X
    LDA #$0050
    STA $0C
    LDA #$0001

  loc_02232F:
    STA $7E7806, X
    INX 
    INX 
    INX 
    DEC $0C
    BNE loc_02232F
    LDA $0C
    STA $7E7806, X
    PLX 
    COP [91]
    PHX 
    PHB 
    SEP #$20
    LDA #$0F
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaDirect
    LDA #$7E
    PHA 
    PLB 
    REP #$20
    LDA #$0050
    STA $0C
    LDA $033A             ; (scroll_bg1_x - $60) * 2 is the step added on each of the 80 lines
    SEC 
    SBC #$0060
    ASL 
    STA $00
    LDX #$0000

  loc_02236B:
    XBA 
    STA $7E7807, X
    XBA 
    INX 
    INX 
    INX 
    CLC 
    ADC $00
    DEC $0C
    BNE loc_02236B
    PLB 
    PLX 
    RTL 
}
---------------------------------------------

; HDMA effect: a vertical wave of the second layer.
; 
; When: placement script (type $11, A0BS02, A0BS03 and A0BS07); once per frame after COP 91.
; Sees: setup builds seven entries at $7E:7800, each with count $A0 (repeat mode, 32 lines) and the data pointer $7900, plus a 0 end. Every frame it copies 32 words of the 64-word sine table ms_hdma_wave_offsets_0223D7 to $7E:7900, starting at word ((frame_counter >> 1) & $1F), and queues the table with JSL QueueHdmaIndirect, register $10 = BG2VOFS.
; Why: 7 x 32 = 224 lines all repeat the same 32 offsets, so the whole screen ripples and the ripple moves one word every second frame.
; In: X = D = slot; M = 16.
; Out: RTL each frame.
; Clobbers: A, X, Y.

ms_effect_hdma_bg2_wave_02237E {
    PHX 
    LDX #$0000

  loc_022382:
    LDA #$00A0
    STA $7E7800, X
    LDA #$7900
    STA $7E7801, X
    INX 
    INX 
    INX 
    CPX #$0015            ; 7 entries of 3 bytes: count $A0 (repeat, 32 lines) and pointer $7900
    BNE loc_022382
    LDA #$0000
    STA $7E7800, X
    PLX 
    COP [91]
    PHX 
    LDA $frame_counter    ; the 32-word window moves one word every second frame
    LSR 
    AND #$001F
    ASL 
    TAX 
    LDY #$0000
    SEP #$20
    PHB 
    LDA #$7E
    PHA 
    PLB 

  loc_0223B6:
    LDA $@ms_hdma_wave_offsets_0223D7, X
    STA $7900, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0040
    BNE loc_0223B6
    PLB 
    LDA #$10
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaIndirect
    REP #$20
    PLX 
    RTL 
}
---------------------------------------------

; Two periods of a sine of 32 words (peak +3 / -3 pixels).
; 
; When: read by ms_effect_hdma_bg2_wave_02237E every frame.
; Sees: n/a (data).
; Why: the table is twice as long as one period so that any 32-word window is a full wave.
; In: n/a (data, 64 words).
; Out: n/a.
; Clobbers: n/a.

ms_hdma_wave_offsets_0223D7 [
  #$0000   ;00
  #$0001   ;01
  #$0001   ;02
  #$0002   ;03
  #$0002   ;04
  #$0002   ;05
  #$0003   ;06
  #$0003   ;07
  #$0003   ;08
  #$0003   ;09
  #$0003   ;0A
  #$0002   ;0B
  #$0002   ;0C
  #$0002   ;0D
  #$0001   ;0E
  #$0001   ;0F
  #$0000   ;10
  #$FFFF   ;11
  #$FFFF   ;12
  #$FFFE   ;13
  #$FFFE   ;14
  #$FFFE   ;15
  #$FFFD   ;16
  #$FFFD   ;17
  #$FFFD   ;18
  #$FFFD   ;19
  #$FFFD   ;1A
  #$FFFE   ;1B
  #$FFFE   ;1C
  #$FFFE   ;1D
  #$FFFF   ;1E
  #$FFFF   ;1F
  #$0000   ;20
  #$0001   ;21
  #$0001   ;22
  #$0002   ;23
  #$0002   ;24
  #$0002   ;25
  #$0003   ;26
  #$0003   ;27
  #$0003   ;28
  #$0003   ;29
  #$0003   ;2A
  #$0002   ;2B
  #$0002   ;2C
  #$0002   ;2D
  #$0001   ;2E
  #$0001   ;2F
  #$0000   ;30
  #$FFFF   ;31
  #$FFFF   ;32
  #$FFFE   ;33
  #$FFFE   ;34
  #$FFFE   ;35
  #$FFFD   ;36
  #$FFFD   ;37
  #$FFFD   ;38
  #$FFFD   ;39
  #$FFFD   ;3A
  #$FFFE   ;3B
  #$FFFE   ;3C
  #$FFFE   ;3D
  #$FFFF   ;3E
  #$FFFF   ;3F
]
---------------------------------------------

; HDMA effect: a vertical gradient of the fixed colour.
; 
; When: placement script (type $3C, A0BS02 and A0BS03); once at the start and per frame after COP 91.
; Sees: writes $1C81 (a dark blue) to the first word of cgram_buffer (colour 0, the backdrop), then every frame queues ms_hdma_coldata_table_022471 with JSL QueueHdmaDirect on register $32 (COLDATA).
; Why: the fixed colour fades down the screen, giving the backdrop a gradient.
; In: X = D = slot.
; Out: RTL each frame.
; Clobbers: A, Y.

ms_effect_hdma_coldata_gradient_022457 {
    LDA #$1C81            ; colour 0 (backdrop) = $1C81, a dark blue
    STA $cgram_buffer
    COP [91]
    PHP 
    SEP #$20
    LDA #$32
    XBA 
    LDA #$^ms_hdma_coldata_table_022471
    LDY #$&ms_hdma_coldata_table_022471
    JSL $@lib_system_helpers.QueueHdmaDirect
    PLP 
    RTL 
}
---------------------------------------------

; COLDATA gradient table: $F3 for 9 lines, then $F2 down to $E1 for 10 lines each, then $E0 for 34 lines, end 0.
; 
; When: queued by ms_effect_hdma_coldata_gradient_022457.
; Sees: n/a (data). The value is $E0 | n: all three colour channels at intensity n, from 19 at the top to 0 at the bottom.
; Why: see ms_effect_hdma_coldata_gradient_022457.
; In: n/a (HDMA table in the direct format: line count, value).
; Out: n/a.
; Clobbers: n/a.

ms_hdma_coldata_table_022471 #09F30AF20AF10AF00AEF0AEE0AED0AEC0AEB0AEA0AE90AE80AE70AE60AE50AE40AE30AE20AE122E000