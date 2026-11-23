; The band shear of Deathtoll's final-battle room (file offsets 127311-127481, SNES $03:F14F-$03:F1F9, bank 03). MetaWorldOfEvil type $08, placed in A15S02 (location $7D) at tile (0,0), row ;01, next to the Demon (row ;02). Walkthrough chapter: docs/walkthrough/08-world-of-evil.md ('FINAL BOSS, PART TWO - Deathtoll the Demon').
; 
; === WHAT RUNS HERE ===
; One actor, we_fx_battle_bg2_hofs_bands_01F14F. First frame: 12 direct HDMA bands at $7E7800 (3 bytes each: line count and a word), heights 6, 8, 10, 6, 9, $10, $10, $10, $11, $18, $20 and $10 lines (176 lines in all, end byte 0), then COP 91. Every frame: an accumulator starts at frame_counter * 8; for each band the previous accumulator, bytes swapped, becomes the band's BG2 horizontal scroll word and the accumulator grows by (frame_counter * 8) * band height, a product taken from the hardware multiplier (M7A = accumulator base, M7B = height, result MPYL). QueueHdmaDirect then sends the bands to register $0F (BG2HOFS) from bank $7E, table $7800.
; The speed of a band grows with the summed height of the bands above it, so the lower bands slide faster, like a floor in perspective (inferred from the arithmetic; the picture was not checked, OQ-I040-8).
; 
; === OPEN ===
; The swap puts the accumulator's low byte into the high byte of the scroll word, so its low two bits end up in the scroll's upper bits; whether that is intended is open (OQ-I040-8).
---------------------------------------------

?BANK 03

?INCLUDE 'lib_system_helpers'

!frame_counter                  0312
!M7A                            211B
!M7B                            211C
!MPYL                           2134

---------------------------------------------

; The BG2 band shear behind the final battle.
; 
; When: placement script (meta type $08, row ;01 of A15S02); runs from the scene load.
; Sees: the 12 band heights written to $7E7800 once, then COP 91; each frame the 12 band words are rebuilt from frame_counter * 8 with the multiplier (M7A / M7B / MPYL) and QueueHdmaDirect is called with register $0F (BG2HOFS), bank $7E, table $7800.
; Why: the moving backdrop of Deathtoll's room.
; In: X = D = slot $01 (X is saved and restored around the loops).
; Out: RTL each frame; DP $00 holds frame_counter * 8; M7A, M7B and the HDMA table are written.
; Clobbers: A, Y.

we_fx_battle_bg2_hofs_bands_01F14F {
    PHX 
    LDX #$0000
    LDA #$0006
    STA $7E7800, X        ; band heights in lines: 6, 8, 10, 6, 9, $10, $10, $10, $11, $18, $20, $10; the end byte 0 follows
    LDA #$0008
    STA $7E7803, X
    LDA #$000A
    STA $7E7806, X
    LDA #$0006
    STA $7E7809, X
    LDA #$0009
    STA $7E780C, X
    LDA #$0010
    STA $7E780F, X
    LDA #$0010
    STA $7E7812, X
    LDA #$0010
    STA $7E7815, X
    LDA #$0011
    STA $7E7818, X
    LDA #$0018
    STA $7E781B, X
    LDA #$0020
    STA $7E781E, X
    LDA #$0010
    STA $7E7821, X
    LDA #$0000
    STA $7E7824, X
    PLX 
    COP [91]              ; the set-up above runs once; later frames resume after this COP 91
    PHX 
    LDA $frame_counter    ; accumulator base = frame_counter * 8
    ASL 
    ASL 
    ASL 
    STA $00
    TAY 
    LDX #$0000

  loc_01F1BE:
    XBA 
    STA $7E7801, X
    XBA 
    PHA 
    TYA 
    SEP #$20
    STA $M7A
    XBA 
    STA $M7A
    LDA $7E7800, X
    STA $M7B
    STA $M7B
    REP #$20
    PLA 
    CLC 
    ADC $MPYL
    INX 
    INX 
    INX 
    CPX #$0024
    BNE loc_01F1BE
    SEP #$20
    LDA #$0F
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaDirect ; register $0F = BG2HOFS, direct table in bank $7E at $7800
    REP #$20
    PLX 
    RTL 
}