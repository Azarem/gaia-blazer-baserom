?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop91_SetEntryHere {
    TYX 
    SEP #$20
    LDA $3A
    STA $0036, X
    REP #$20
    LDA $38
    STA $0018, X
    BRL cop_handler_006473.loc_0064C1
}