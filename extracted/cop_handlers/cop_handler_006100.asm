?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop97_ClearFlipX {
    TYX 
    LDA $001C, X
    BIT #$4000
    BEQ loc_00610F
    AND #$BFFF
    STA $001C, X

  loc_00610F:
    BRL cop_handler_006473.loc_0064BF
}