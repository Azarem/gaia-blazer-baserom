?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_01065B'
?INCLUDE 'lib_0106CD'

---------------------------------------------

Cop93_StartAnimationCount {
    TYX                   ; {24718}
    LDA [$38]             ; {24719}
    INC $38               ; {24721}
    AND #$00FF            ; {24723}
    STA $001E, X          ; {24726}
    STZ $0020, X          ; {24729}
    LDA [$38]             ; {24732}
    INC $38               ; {24734}
    AND #$00FF            ; {24736}
    STA $002A, X          ; {24739}
    JSL $@lib_01065B.code_01065B ; {24742}
    JSL $@lib_0106CD.code_0106CD ; {24746}
    BRL cop_handler_006473.loc_0064C4 ; {24750}
}