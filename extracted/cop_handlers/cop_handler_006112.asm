?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop98_SetFlipY {
    TYX 
    LDA $001C, X
    BIT #$8000
    BNE loc_006121
    ORA #$8000
    STA $001C, X

  loc_006121:
    BRL cop_handler_006473.loc_0064BF
}