?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA7_ClearFlag1A2000 {
    TYX 
    LDA $001A, X
    AND #$DFFF
    STA $001A, X
    BRL cop_handler_006473.loc_0064BF
}