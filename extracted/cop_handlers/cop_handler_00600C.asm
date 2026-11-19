?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop8E_JumpIfBit15Set {
    TYX 
    LDA $0016, X
    BIT #$8000
    BNE loc_006018
    BRL cop_handler_006473.loc_0064BF

  loc_006018:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}