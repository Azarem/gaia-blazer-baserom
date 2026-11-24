; Sine wave tables for an HDMA effect, unused (file offsets 160375-160439, SNES $04:F277-$F2B7, bank 04).
; 
; === MODEL ===
; FillSineWaveTables is a request-driven table builder: when wave_request ($03CD) is non-zero it clears it and writes 256 words amplitude x sin(phase), using the hardware multiplier (M7A, M7B, MPYM), twice, to $7E:7900 and $7E:7B00. The sine byte comes from SineTable (a signed table in data_engine_tables); the phase starts at 0 and advances by wave_phase_step ($03CE) per word; wave_amplitude ($03CC) is the multiplier (one byte, M7A written twice with its second write 0).
; 
; === NOTES ===
; - Dead code: no routine calls it (OQ-I013-12) and the three parameter cells $03CC-$03CE have no other user (searched in the extracted sources). The tables $7E:7900 and $7E:7B00 sit in the area the HDMA staging uses ($7E:7000-$7BFF, left unnamed in docs/wram-memory-map.md); no other reader of the two addresses was checked here.
; - The mnemonics wave_amplitude, wave_request and wave_phase_step name the cells from this routine only (confidence C).
---------------------------------------------

?BANK 04

?INCLUDE 'data_engine_tables'

!wave_amplitude                 03CC
!wave_request                   03CD
!wave_phase_step                03CE
!M7A                            211B
!M7B                            211C
!MPYM                           2135

---------------------------------------------

; Builds two 256-word sine tables when a request flag is set (dead code).
; 
; When: never called; if it were, once per request (wave_request non-zero).
; Sees: nothing in the shipped game.
; Why: probably left over from a wave distortion effect; the parameters, the tables and the multiplier fit an HDMA scroll wave (inferred).
; In: JSL; any M (SEP #$20 inside; X = 16-bit); wave_request ($03CD), wave_amplitude ($03CC), wave_phase_step ($03CE).
; Out: wave_request = 0; $7E:7900-$7AFF and $7E:7B00-$7CFF = amplitude x sine(phase) as 256 words each (the signed 16-bit product MPYM/MPYH). X and P restored.
; Clobbers: A, Y; the multiplier registers.

FillSineWaveTables {
    PHP 
    PHX 
    SEP #$20
    LDA $wave_request     ; request flag: non-zero starts a refill and is cleared at once
    BEQ SineWaveDone
    STZ $wave_request
    LDX #$0000
    TXY 
    LDA $wave_amplitude
    STA $M7A
    STZ $M7A

  SineWaveLoop:
    LDA $&data_engine_tables.SineTable, Y
    STA $M7B
    STA $M7B
    REP #$20
    LDA $MPYM
    STA $7E7900, X
    STA $7E7B00, X
    TYA 
    SEP #$20
    CLC 
    ADC $wave_phase_step  ; the phase advances by wave_phase_step per word, 256 words in all
    TAY 
    INX 
    INX 
    CPX #$0200
    BNE SineWaveLoop

  SineWaveDone:
    PLX 
    PLP 
    RTL 
}