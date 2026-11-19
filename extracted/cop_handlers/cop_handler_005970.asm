?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop11_MoveActorToTile {
    TYX                   ; {22896}
    LDA [$38]             ; {22897}
    INC $38               ; {22899}
    AND #$00FF            ; {22901}
    JSR $&engine_0065A7.code_006617 ; {22904}
    LDA [$38]             ; {22907}
    INC $38               ; {22909}
    AND #$00FF            ; {22911}
    JSR $&engine_0065A7.code_006628 ; {22914}
    STA $0000, Y          ; {22917}
    LDA [$38]             ; {22920}
    INC $38               ; {22922}
    AND #$00FF            ; {22924}
    JSR $&engine_0065A7.code_006628 ; {22927}
    STA $0002, Y          ; {22930}
    PHX                   ; {22933}
    TYX                   ; {22934}
    JSR $&engine_0065A7.code_0065A7 ; {22935}
    PLX                   ; {22938}
    BRL cop_handler_006473.loc_0064BF ; {22939}
}