?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop1D_SetActorFlags {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    ORA $0016, X
    STA $0016, X
    BRL cop_handler_006473.loc_0064BF
}