?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop1B_SetResumeAndDelay {
    TYX                   ; {23176}
    LDA [$38]             ; {23177}
    INC $38               ; {23179}
    INC $38               ; {23181}
    STA $0018, X          ; {23183}
    LDA [$38]             ; {23186}
    INC $38               ; {23188}
    INC $38               ; {23190}
    STA $0014, X          ; {23192}
    BRL cop_handler_006473.loc_0064C9 ; {23195}
}