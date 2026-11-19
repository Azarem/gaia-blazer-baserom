?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA3_SetFlag1A4000 {
    TYX                   ; {25160}
    LDA $001A, X          ; {25161}
    ORA #$4000            ; {25164}
    STA $001A, X          ; {25167}
    BRL cop_handler_006473.loc_0064BF ; {25170}
}