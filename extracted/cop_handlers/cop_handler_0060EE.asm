?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop96_SetFlipX {
    TYX                   ; {24814}
    LDA $001C, X          ; {24815}
    BIT #$4000            ; {24818}
    BNE loc_0060FD        ; {24821}
    ORA #$4000            ; {24823}
    STA $001C, X          ; {24826}

  loc_0060FD:
    BRL cop_handler_006473.loc_0064BF ; {24829}
}