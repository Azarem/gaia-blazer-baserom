?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA9_SetFields34And2C {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    STA $0034, X
    SEP #$20
    LDA [$38]
    INC $38
    BNE loc_0062D5
    INC $39

  loc_0062D5:
    STA $002C, X
    REP #$20
    LDA $001A, X
    ORA #$8000
    STA $001A, X
    BRL cop_handler_006473.loc_0064BF
}