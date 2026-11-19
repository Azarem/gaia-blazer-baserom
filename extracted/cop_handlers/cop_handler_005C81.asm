?BANK 00

?INCLUDE 'cop_handler_0058A9'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop2E_JumpIfActorInBoxWord {
    TYX                   ; {23681}
    LDA [$38]             ; {23682}
    INC $38               ; {23684}
    AND #$00FF            ; {23686}
    JSR $&engine_0065A7.code_006617 ; {23689}
    LDA [$38]             ; {23692}
    INC $38               ; {23694}
    INC $38               ; {23696}
    STA $00               ; {23698}
    BRL cop_handler_0058A9.loc_0058C0 ; {23700}
}