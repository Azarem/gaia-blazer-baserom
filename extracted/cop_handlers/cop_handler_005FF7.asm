?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop8D_JumpIfBit15Clear {
    TYX 
    LDA $0016, X
    BIT #$8000
    BEQ loc_006003
    BRL cop_handler_006473.loc_0064BF

  loc_006003:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}