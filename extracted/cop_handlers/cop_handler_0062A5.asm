?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA8_SetFields22And24 {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    STA $0022, X
    SEP #$20
    LDA [$38]
    INC $38
    BNE loc_0062B9
    INC $39

  loc_0062B9:
    STA $0024, X
    REP #$20
    BRL cop_handler_006473.loc_0064BF
}