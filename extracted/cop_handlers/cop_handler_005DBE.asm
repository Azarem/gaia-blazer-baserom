?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop38_SetParam043D {
    TYX                   ; {23998}
    LDA [$38]             ; {23999}
    INC $38               ; {24001}
    INC $38               ; {24003}
    STA $043D             ; {24005}
    BRL cop_handler_006473.loc_0064BF ; {24008}
}