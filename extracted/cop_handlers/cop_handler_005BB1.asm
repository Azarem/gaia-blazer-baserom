?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop27_SetResumeAndYield {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    STA $0018, X
    STZ $0014, X
    BRL cop_handler_006473.loc_0064C9
}