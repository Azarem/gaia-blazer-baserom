?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop38_SetParam043D {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    STA $043D
    BRL cop_handler_006473.loc_0064BF
}