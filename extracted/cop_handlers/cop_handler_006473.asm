; CopB2_SpawnBeforeRelative and the exit chain shared by every COP handler.
; 
; The chain (loc_0064B5 .. loc_0064C9) is entered by BRL from the other handlers: loc_0064B5 skips 5 operand bytes, loc_0064B7 skips 4, loc_0064B9 skips 3, loc_0064BB skips 2, loc_0064BD skips 1, loc_0064BF skips none. They fall through to loc_0064C1, which writes A over the return address on the stack ($02,S) and returns with RTI, so the script continues at A (for a jump, A is the target). loc_0064C4 stores $38 as the actor's resume pointer ($18,X) and falls into loc_0064C9, which pops the COP frame and returns with RTL (yield to the actor loop).
---------------------------------------------

?BANK 00

?INCLUDE 'engine_0065A7'

---------------------------------------------

CopB2_SpawnBeforeRelative {
    TYX                   ; {25715}
    JSR $&engine_0065A7.code_006662 ; {25716}
    LDA [$38]             ; {25719}
    INC $38               ; {25721}
    INC $38               ; {25723}
    STA $0018, Y          ; {25725}
    TXA                   ; {25728}
    LDA [$38]             ; {25729}
    INC $38               ; {25731}
    AND #$00FF            ; {25733}
    SEP #$20              ; {25736}
    STA $0036, Y          ; {25738}
    REP #$20              ; {25741}
    LDA [$38]             ; {25743}
    INC $38               ; {25745}
    INC $38               ; {25747}
    CLC                   ; {25749}
    ADC $0000, X          ; {25750}
    STA $0000, Y          ; {25753}
    LDA [$38]             ; {25756}
    INC $38               ; {25758}
    INC $38               ; {25760}
    CLC                   ; {25762}
    ADC $0002, X          ; {25763}
    STA $0002, Y          ; {25766}
    LDA [$38]             ; {25769}
    INC $38               ; {25771}
    INC $38               ; {25773}
    STA $0016, Y          ; {25775}
    BRL loc_0064BF        ; {25778}

; Skip 5 operand bytes (falls through the INC chain to loc_0064BF).

  loc_0064B5:
    INC $38               ; {25781}

; Skip 4 operand bytes.

  loc_0064B7:
    INC $38               ; {25783}

; Skip 3 operand bytes.

  loc_0064B9:
    INC $38               ; {25785}

; Skip 2 operand bytes (a not-taken jump with one &Code operand).

  loc_0064BB:
    INC $38               ; {25787}

; Skip 1 operand byte.

  loc_0064BD:
    INC $38               ; {25789}

; Continue at the script pointer: A = $38.

  loc_0064BF:
    LDA $38               ; {25791}

; A = new script pointer (jump target or $38). Replaces the return address on the stack and returns with RTI.

  loc_0064C1:
    STA $02, S            ; {25793}
    RTI                   ; {25795}

; Save $38 as the actor's resume pointer ($18,X), then yield.

  loc_0064C4:
    LDA $38               ; {25796}
    STA $0018, X          ; {25798}

; Yield: PLA PLA RTL back to the actor loop. The script resumes next time from $18,X/$36,X.

  loc_0064C9:
    PLA                   ; {25801}
    PLA                   ; {25802}
    RTL                   ; {25803}
}