?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop17_SetOwnData30 {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    STA $0030, X
    BRL cop_handler_006473.loc_0064BF
}