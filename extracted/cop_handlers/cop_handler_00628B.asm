?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA6_ClearFlag1A4000 {
    TYX 
    LDA $001A, X
    AND #$BFFF
    STA $001A, X
    BRL cop_handler_006473.loc_0064BF
}