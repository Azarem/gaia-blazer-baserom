?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA0_AddY {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0002, X
    STA $0002, X
    BRL cop_handler_006473.loc_0064BF
}