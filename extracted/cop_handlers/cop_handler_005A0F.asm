?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0064F8'

---------------------------------------------

Cop18_JumpIfInventoryZero {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&engine_0064F8.code_00651E
    BCS loc_005A1F
    BRL cop_handler_006473.loc_0064BB

  loc_005A1F:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}