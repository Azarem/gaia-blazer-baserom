?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop97_ClearFlipX {
    TYX                   ; {24832}
    LDA $001C, X          ; {24833}
    BIT #$4000            ; {24836}
    BEQ loc_00610F        ; {24839}
    AND #$BFFF            ; {24841}
    STA $001C, X          ; {24844}

  loc_00610F:
    BRL cop_handler_006473.loc_0064BF ; {24847}
}