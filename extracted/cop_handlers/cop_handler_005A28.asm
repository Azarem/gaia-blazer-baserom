?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0064F8'

---------------------------------------------

Cop19_JumpUnlessInventoryBit7 {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&engine_0064F8.code_00651E
    BCS loc_005A3A
    BPL loc_005A3A
    BRL cop_handler_006473.loc_0064BB

  loc_005A3A:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}