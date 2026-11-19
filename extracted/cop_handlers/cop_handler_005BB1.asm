?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop27_SetResumeAndYield {
    TYX                   ; {23473}
    LDA [$38]             ; {23474}
    INC $38               ; {23476}
    INC $38               ; {23478}
    STA $0018, X          ; {23480}
    STZ $0014, X          ; {23483}
    BRL cop_handler_006473.loc_0064C9 ; {23486}
}