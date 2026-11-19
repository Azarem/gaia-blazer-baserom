?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA6_ClearFlag1A4000 {
    TYX                   ; {25227}
    LDA $001A, X          ; {25228}
    AND #$BFFF            ; {25231}
    STA $001A, X          ; {25234}
    BRL cop_handler_006473.loc_0064BF ; {25237}
}