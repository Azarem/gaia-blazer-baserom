?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop11_MoveActorToTile {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&engine_0065A7.code_006617
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&engine_0065A7.code_006628
    STA $0000, Y
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&engine_0065A7.code_006628
    STA $0002, Y
    PHX 
    TYX 
    JSR $&engine_0065A7.code_0065A7
    PLX 
    BRL cop_handler_006473.loc_0064BF
}