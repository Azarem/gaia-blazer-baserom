?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'
?INCLUDE 'lib_0273A2'

---------------------------------------------

Cop14_JumpIfSwitchSet {
    TYX                   ; {22988}
    LDA [$38]             ; {22989}
    INC $38               ; {22991}
    INC $38               ; {22993}
    JSR $&engine_0065A7.code_00662D ; {22995}
    LDY #$1ADE            ; {22998}
    JSL $@lib_0273A2.code_0273A2 ; {23001}
    BCC loc_0059F1        ; {23005}
    LDA $0016, X          ; {23007}
    AND #$DFFF            ; {23010}
    STA $0016, X          ; {23013}
    LDA [$38]             ; {23016}
    INC $38               ; {23018}
    INC $38               ; {23020}
    BRL cop_handler_006473.loc_0064C1 ; {23022}

  loc_0059F1:
    BRL cop_handler_006473.loc_0064BB ; {23025}
}