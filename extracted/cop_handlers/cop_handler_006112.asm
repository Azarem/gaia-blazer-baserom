?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop98_SetFlipY {
    TYX                   ; {24850}
    LDA $001C, X          ; {24851}
    BIT #$8000            ; {24854}
    BNE loc_006121        ; {24857}
    ORA #$8000            ; {24859}
    STA $001C, X          ; {24862}

  loc_006121:
    BRL cop_handler_006473.loc_0064BF ; {24865}
}