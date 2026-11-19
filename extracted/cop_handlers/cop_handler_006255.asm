?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA4_SetFlag1A2000 {
    TYX 
    LDA $001A, X
    ORA #$2000
    STA $001A, X
    BRL cop_handler_006473.loc_0064BF
}