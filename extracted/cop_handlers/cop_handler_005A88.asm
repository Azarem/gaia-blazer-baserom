?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop1B_SetResumeAndDelay {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    STA $0018, X
    LDA [$38]
    INC $38
    INC $38
    STA $0014, X
    BRL cop_handler_006473.loc_0064C9
}