; Hardware multiply and divide wrappers and packed BCD (file offsets 78289-78333 and 78357-78405, SNES $02:B1D1-$B1FD and $02:B215-$B245, bank 02; the neighbours SignExtendByte, ArithmeticShiftRight and StepRandomState at 78334-78349, 78350-78356 and 78406-78449 have part notes of their own).
; 
; === MODEL ===
; Multiply8x8 and DivideWordByByte use the SNES multiplier ($4202/$4203) and divider ($4204-$4206): write the operands, wait the fixed time with NOPs and read the result. All three routines are entered by long call with M = 8 and X = 16 and have no side effects beyond A, B and the hardware registers. ByteToPackedBcd converts 0-255 to the packed BCD that the text control [06:n,addr] prints (digit bytes, least significant first).
; 
; === NOTES ===
; - Multiply8x8 has about 22 call sites (map streaming and sweep, scene loading, COP core, combat and spawn code, ChooseFacingAnim); DivideWordByByte only two: ChooseFacingAnim and shared_actor_helpers_bank0.
; - docs/wram-memory-map.md names StepRandomState as the generator of rng_state.
---------------------------------------------

?BANK 02

!L_WRMPYA                       004202
!L_WRMPYB                       004203
!L_RDMPYL                       004216
!L_RDMPYH                       004217
!rng_state                      0301
!WRDIVL                         4204
!WRDIVB                         4206
!RDDIVL                         4214
!RDMPYL                         4216

---------------------------------------------

; Multiplies two bytes with the hardware multiplier.
; 
; When: about 22 call sites, among them SlotNumberToActor (slot x $40), the map streaming and sweep code and ChooseFacingAnim (6 x quotient).
; Sees: n/a.
; Why: the 5A22 multiplier needs only four NOPs, faster than a software loop.
; In: long call; M = 8; A.low = first factor, B = second factor.
; Out: A (16 bits) = the product (high byte in B, low byte in A.low), read after four NOPs.
; Clobbers: A, B.

Multiply8x8 {
    STA $L_WRMPYA
    XBA 
    STA $L_WRMPYB
    NOP                   ; Four NOPs (8 cycles): the product is not ready sooner
    NOP 
    NOP 
    NOP 
    LDA $L_RDMPYH
    XBA 
    LDA $L_RDMPYL
    RTL 
}
---------------------------------------------

; Divides a 16-bit value by a byte with the hardware divider.
; 
; When: ChooseFacingAnim (animation id / 6) and shared_actor_helpers_bank0.
; Sees: n/a.
; Why: the divider takes 16 cycles, eight NOPs, and avoids a software loop.
; In: long call; M = 8, X = 16; Y = dividend, A.low = divisor.
; Out: A.low = quotient (low 8 bits only), B = remainder.
; Clobbers: A, B.

DivideWordByByte {
    STY $WRDIVL
    STA $WRDIVB
    NOP                   ; Eight NOPs (16 cycles): the divide takes 16
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    LDA $RDMPYL
    XBA 
    LDA $RDDIVL
    RTL 
}
---------------------------------------------

; Sign-extends the byte in A.low into the 16-bit accumulator.
; 
; When: no call site in the extraction (OQ-I042-3).
; Sees: n/a.
; Why: signed bytes (velocities, offsets) are added to 16-bit positions, which needs $FF in the high byte for a negative value (inferred; no caller).
; In: long call; any M; A.low = the byte.
; Out: A.low unchanged, B = $FF when bit 7 of A.low is set, otherwise $00; P restored.
; Clobbers: B.

SignExtendByte {
    PHP 
    SEP #$20
    XBA 
    LDA #$00
    XBA 
    CMP #$80
    BCC loc_01320C
    XBA 
    DEC 
    XBA 

  loc_01320C:
    PLP 
    RTL 
}
---------------------------------------------

; Shifts A right by one bit and keeps the sign bit.
; 
; When: no call site in the extraction (OQ-I042-3).
; Sees: n/a.
; Why: LSR would turn a negative value positive; this halves a signed value (inferred; no caller).
; In: long call; A in the current width. The routine tests the N flag as the caller left it (BMI), it does not reload A, so N must describe A.
; Out: N set: SEC, ROR (the sign stays); N clear: LSR. Carry = the bit shifted out.
; Clobbers: A, carry.

ArithmeticShiftRight {
    BMI loc_013212
    LSR 
    RTL 

  loc_013212:
    SEC 
    ROR 
    RTL 
}
---------------------------------------------

; Converts a byte (0-255) to packed BCD in two bytes.
; 
; When: ShowStatusAndSoulsScreen (HP and maximum HP) and the pause code (lib_main_loop_helpers).
; Sees: the status screen prints the result with [06:3,1B6C] and [06:3,1B6E], three BCD digits.
; Why: the text renderer prints digits from BCD bytes, not binary.
; In: long call; M = 8, X = 16; A = value, X = destination address (DBR-relative, WRAM).
; Out: [X] = tens in the high nibble and ones in the low nibble, [X+1] = hundreds (0-2).
; Clobbers: A.

ByteToPackedBcd {
    STZ $0000, X
    STZ $0001, X

  loc_01321B:
    CMP #$64              ; Hundreds: subtract 100 and count in [X+1]
    BCC loc_013227
    SEC 
    SBC #$64
    INC $0001, X
    BRA loc_01321B

  loc_013227:
    CMP #$0A
    BCC loc_013233
    SEC 
    SBC #$0A
    INC $0000, X
    BRA loc_013227

  loc_013233:
    ASL $0000, X          ; Tens x 16 (four ASL) then OR the ones: packed BCD
    ASL $0000, X
    ASL $0000, X
    ASL $0000, X
    ORA $0000, X
    STA $0000, X
    RTL 
}
---------------------------------------------

; Steps the 17-byte random generator and returns one random byte.
; 
; When: no call site in the extraction; Cop1F_StepRandom (cop_script_flow_flags) contains the same loops and is what the scripts use (OQ-I042-3).
; Sees: n/a.
; Why: an additive generator: it needs no multiplication and keeps its state in WRAM ($0301-$0311, rng_state).
; In: long call; any M; X and Y are saved.
; Out: M = 8, X = 16 inside: for X = 15 down to 1 rng_state[X] += rng_state[X+1] with the carry running through the bytes, then rng_state[$10] is incremented with the carry running up toward rng_state[1]; A (16-bit, high byte 0) = rng_state+1 ($0302); P, X and Y restored.
; Clobbers: A.

StepRandomState {
    PHX 
    PHY 
    PHP 
    SEP #$20
    REP #$10
    LDX #$000F
    LDA #$00
    XBA 
    CLC 

  loc_013254:
    LDA $rng_state+1, X
    ADC $rng_state, X
    STA $rng_state, X
    DEX 
    BNE loc_013254
    LDX #$0010

  loc_013263:
    INC $rng_state, X
    BNE loc_01326B
    DEX 
    BNE loc_013263

  loc_01326B:
    LDA $rng_state+1
    PLP 
    PLY 
    PLX 
    RTL 
}