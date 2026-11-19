?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop12_SetActorResume {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&engine_0065A7.code_006617
    LDA [$38]
    INC $38
    INC $38
    STA $0018, Y
    BRL cop_handler_006473.loc_0064BF
}