; Record stepper used by the animation COP commands Cop92-Cop95 (file offsets 67163-67312, SNES $02:865B-$86F0, bank 02).
; 
; === MODEL ===
; An actor field set drives a list of 6-byte records: $1E = animation id, $20 = step, $24 = data bank. The word list at $8000 of that bank (one word per animation id) points to the records. NextFrameRecord loads the record of the current step into the actor's work fields; CopyFrameData copies the bytes the record points to into WRAM bank $7F.
; Record (6 bytes): +0 duration (0 = end of the animation), +1 word source address (bank $24,X) -> $08,X, +3 byte x 2 -> $0A,X (destination offset), +4 byte -> $0C,X (byte count - 1 for the block move), +5 byte -> $0E,X and $14,X (the wait reload). The tick counter $26,X = duration - 1.
; The destination is bank $7F offset $0A,X, i.e. the CGRAM shadow $7F0000 (two bytes per colour) when the offset is a colour index x 2; a count byte of 2 (three bytes) adds $200 to the offset, which lands on coldata_buffer ($7F0200, the three COLDATA bytes). This makes the stepper a colour animation, but nothing in the code names it, so it is inferred from the destination (OQ-I026-3).
; 
; === NOTES ===
; - The block move runs through a RAM stub at $1C5C built by the scene init (lib_boot_and_scene_init): PHB, MVN, PLB, RTS. CopyFrameData patches its two bank operands (wram_copy_stub+2): destination $7F, source = the actor's data bank.
---------------------------------------------

?INCLUDE 'WorldMetaPointers'

!wram_copy_stub                 1C5C

---------------------------------------------

; Loads the next record of the actor's animation into its work fields.
; 
; When: Cop92_StartAnimation, Cop93, Cop94_AnimTick and Cop95 (not SetActorAnimFrame, which has its own stepper).
; Sees: the next step of the animation starts.
; Why: keeps the record format in one place.
; In: X = actor; $1E = animation id, $20 = step, $24 = data bank.
; Out: carry clear: $26 = duration - 1, $08 = source address, $0A = destination offset, $0C = byte count - 1, $0E and $14 = reload, $20 incremented; when the count byte is 2 then $0B is incremented twice ($0A + $200). Carry set: the duration was 0 (end): $20 = 0, nothing loaded.
; Clobbers: A, Y (B and P restored).

NextFrameRecord {
    PHP 
    PHB 
    SEP #$20
    LDA $0024, X
    PHA 
    PLB 
    REP #$20
    LDA $001E, X
    ASL 
    TAY 
    LDA $8000, Y
    PHA 
    LDA $0020, X
    ASL 
    CLC 
    ADC $0020, X
    ASL 
    CLC 
    ADC $01, S
    PLY 
    TAY 
    LDA $0000, Y
    AND #$00FF
    BEQ loc_0106C6        ; Duration 0 = end of the animation: the step is reset and carry is set
    DEC 
    STA $0026, X
    LDA $0001, Y
    STA $0008, X
    LDA $0003, Y
    AND #$00FF
    ASL 
    CLC 
    ADC #$0000
    STA $000A, X
    LDA $0004, Y
    AND #$00FF
    STA $000C, X
    PHA 
    LDA $0005, Y
    AND #$00FF
    STA $0014, X
    STA $000E, X
    INC $0020, X
    PLA 
    CMP #$0002
    BNE loc_0106C2
    INC $000B, X          ; Count byte 2: destination + $200 = coldata_buffer instead of the palette shadow
    INC $000B, X

  loc_0106C2:
    PLB 
    PLP 
    CLC 
    RTL 

  loc_0106C6:
    STZ $0020, X
    PLB 
    PLP 
    SEC 
    RTL 
}
---------------------------------------------

; Copies the current record's bytes to WRAM bank $7F and advances the source pointer.
; 
; When: after NextFrameRecord, and on every tick of Cop94 / Cop95.
; Sees: the colours of the animation change (inferred, OQ-I026-3).
; Why: the NMI uploads the WRAM shadow, so the stepper only has to fill it.
; In: X = actor; $08 = source address, $0A = destination offset, $0C = byte count - 1, $24 = data bank. M = 16 (the extractor override was fixed: the code runs with a 16-bit accumulator).
; Out: bytes copied to $7F:$0A (MVN through wram_copy_stub); $08,X = the source address after the block. X is preserved.
; Clobbers: A, Y (B saved).

CopyFrameData {
    PHB 
    PHX 
    LDA $0023, X
    AND #$FF00
    ORA #$007F
    STA $wram_copy_stub+2 ; Patch the MVN operands of the RAM stub: destination bank $7F, source bank = the actor's data bank
    LDA $000C, X
    PHA 
    LDY $000A, X
    LDA $0008, X
    TAX 
    PLA 
    JSR $wram_copy_stub   ; Runs the stub PHB / MVN / PLB / RTS (A = count - 1, X = source, Y = destination)
    TXA 
    PLX 
    STA $0008, X
    PLB 
    RTL 
}