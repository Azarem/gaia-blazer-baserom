?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA1_AddXY {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0000, X
    STA $0000, X
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0002, X
    STA $0002, X
    BRL cop_handler_006473.loc_0064BF
}