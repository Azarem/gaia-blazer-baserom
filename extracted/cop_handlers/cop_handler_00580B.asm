?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop04_LoopNext {
    TYX 
    DEC $002E, X
    BNE loc_005814
    BRL cop_handler_006473.loc_0064BF

  loc_005814:
    LDA $002C, X
    STA $0018, X
    BRL cop_handler_006473.loc_0064C9
}