?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA3_SetFlag1A4000 {
    TYX 
    LDA $001A, X
    ORA #$4000
    STA $001A, X
    BRL cop_handler_006473.loc_0064BF
}