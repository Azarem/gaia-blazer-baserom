?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop99_ClearFlipY {
    TYX                   ; {24868}
    LDA $001C, X          ; {24869}
    BIT #$8000            ; {24872}
    BEQ loc_006133        ; {24875}
    AND #$7FFF            ; {24877}
    STA $001C, X          ; {24880}

  loc_006133:
    BRL cop_handler_006473.loc_0064BF ; {24883}
}