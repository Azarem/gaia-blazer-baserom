?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopAA_SetPalette {
    TYX 
    LDA $001C, X
    AND #$F1FF
    PHA 
    LDA [$38]
    INC $38
    AND #$00FF
    XBA 
    ORA $01, S
    STA $001C, X
    PLA 
    BRL cop_handler_006473.loc_0064BF
}