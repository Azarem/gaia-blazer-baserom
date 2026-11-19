?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop96_SetFlipX {
    TYX 
    LDA $001C, X
    BIT #$4000
    BNE loc_0060FD
    ORA #$4000
    STA $001C, X

  loc_0060FD:
    BRL cop_handler_006473.loc_0064BF
}