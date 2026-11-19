?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop12_SetActorResume {
    TYX                   ; {22942}
    LDA [$38]             ; {22943}
    INC $38               ; {22945}
    AND #$00FF            ; {22947}
    JSR $&engine_0065A7.code_006617 ; {22950}
    LDA [$38]             ; {22953}
    INC $38               ; {22955}
    INC $38               ; {22957}
    STA $0018, Y          ; {22959}
    BRL cop_handler_006473.loc_0064BF ; {22962}
}