?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop17_SetOwnData30 {
    TYX                   ; {23042}
    LDA [$38]             ; {23043}
    INC $38               ; {23045}
    INC $38               ; {23047}
    STA $0030, X          ; {23049}
    BRL cop_handler_006473.loc_0064BF ; {23052}
}