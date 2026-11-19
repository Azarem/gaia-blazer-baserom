?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop99_ClearFlipY {
    TYX 
    LDA $001C, X
    BIT #$8000
    BEQ loc_006133
    AND #$7FFF
    STA $001C, X

  loc_006133:
    BRL cop_handler_006473.loc_0064BF
}