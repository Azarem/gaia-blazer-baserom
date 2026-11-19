?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop1E_MaskActorFlags {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    AND $0016, X
    STA $0016, X
    BRL cop_handler_006473.loc_0064BF
}