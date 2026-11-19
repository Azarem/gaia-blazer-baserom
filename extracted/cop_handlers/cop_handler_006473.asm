; CopB2_SpawnBeforeRelative and the exit chain shared by every COP handler.
; 
; The chain (loc_0064B5 .. loc_0064C9) is entered by BRL from the other handlers: loc_0064B5 skips 5 operand bytes, loc_0064B7 skips 4, loc_0064B9 skips 3, loc_0064BB skips 2, loc_0064BD skips 1, loc_0064BF skips none. They fall through to loc_0064C1, which writes A over the return address on the stack ($02,S) and returns with RTI, so the script continues at A (for a jump, A is the target). loc_0064C4 stores $38 as the actor's resume pointer ($18,X) and falls into loc_0064C9, which pops the COP frame and returns with RTL (yield to the actor loop).
---------------------------------------------

?BANK 00

?INCLUDE 'engine_0065A7'

---------------------------------------------

CopB2_SpawnBeforeRelative {
    TYX 
    JSR $&engine_0065A7.code_006662
    LDA [$38]
    INC $38
    INC $38
    STA $0018, Y
    TXA 
    LDA [$38]
    INC $38
    AND #$00FF
    SEP #$20
    STA $0036, Y
    REP #$20
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0000, X
    STA $0000, Y
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0002, X
    STA $0002, Y
    LDA [$38]
    INC $38
    INC $38
    STA $0016, Y
    BRL loc_0064BF

; Skip 5 operand bytes (falls through the INC chain to loc_0064BF).

  loc_0064B5:
    INC $38

; Skip 4 operand bytes.

  loc_0064B7:
    INC $38

; Skip 3 operand bytes.

  loc_0064B9:
    INC $38

; Skip 2 operand bytes (a not-taken jump with one &Code operand).

  loc_0064BB:
    INC $38

; Skip 1 operand byte.

  loc_0064BD:
    INC $38

; Continue at the script pointer: A = $38.

  loc_0064BF:
    LDA $38

; A = new script pointer (jump target or $38). Replaces the return address on the stack and returns with RTI.

  loc_0064C1:
    STA $02, S
    RTI 

; Save $38 as the actor's resume pointer ($18,X), then yield.

  loc_0064C4:
    LDA $38
    STA $0018, X

; Yield: PLA PLA RTL back to the actor loop. The script resumes next time from $18,X/$36,X.

  loc_0064C9:
    PLA 
    PLA 
    RTL 
}