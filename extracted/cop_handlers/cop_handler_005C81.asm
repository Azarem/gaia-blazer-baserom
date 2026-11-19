?BANK 00

?INCLUDE 'cop_handler_0058A9'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop2E_JumpIfActorInBoxWord {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&engine_0065A7.code_006617
    LDA [$38]
    INC $38
    INC $38
    STA $00
    BRL cop_handler_0058A9.loc_0058C0
}