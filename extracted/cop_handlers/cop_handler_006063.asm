?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop91_SetEntryHere {
    TYX                   ; {24675}
    SEP #$20              ; {24676}
    LDA $3A               ; {24678}
    STA $0036, X          ; {24680}
    REP #$20              ; {24683}
    LDA $38               ; {24685}
    STA $0018, X          ; {24687}
    BRL cop_handler_006473.loc_0064C1 ; {24690}
}