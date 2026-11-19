?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_shared_012769'

---------------------------------------------

Cop01_ShowText {
    TYX                   ; {22434}
    LDA [$38]             ; {22435}
    INC $38               ; {22437}
    INC $38               ; {22439}
    TAY                   ; {22441}
    SEP #$20              ; {22442}
    PHX                   ; {22444}
    PHB                   ; {22445}
    LDA $3A               ; {22446}
    PHA                   ; {22448}
    PLB                   ; {22449}
    JSL $@lib_shared_012769.code_012C27 ; {22450}
    PLB                   ; {22454}
    PLX                   ; {22455}
    REP #$20              ; {22456}
    BRL cop_handler_006473.loc_0064BF ; {22458}
}