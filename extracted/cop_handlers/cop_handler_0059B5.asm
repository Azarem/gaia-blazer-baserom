?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop13_SetActorData30 {
    TYX                   ; {22965}
    LDA [$38]             ; {22966}
    INC $38               ; {22968}
    AND #$00FF            ; {22970}
    JSR $&engine_0065A7.code_006617 ; {22973}
    LDA [$38]             ; {22976}
    INC $38               ; {22978}
    INC $38               ; {22980}
    STA $0030, Y          ; {22982}
    BRL cop_handler_006473.loc_0064BF ; {22985}
}