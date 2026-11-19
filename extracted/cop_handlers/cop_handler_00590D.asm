?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop0D_JumpIfActorAtTile {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&engine_0065A7.code_006617
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&engine_0065A7.code_006628
    CMP $0000, Y
    BEQ loc_00592A
    BRL cop_handler_006473.loc_0064B9

  loc_00592A:
    LDA [$38]
    INC $38
    AND #$00FF
    INC 
    JSR $&engine_0065A7.code_006628
    CMP $0002, Y
    BEQ loc_00593D
    BRL cop_handler_006473.loc_0064BB

  loc_00593D:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}