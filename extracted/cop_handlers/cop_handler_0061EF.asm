?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop9F_AddX {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0000, X
    STA $0000, X
    BRL cop_handler_006473.loc_0064BF
}