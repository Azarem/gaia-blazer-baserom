?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA7_ClearFlag1A2000 {
    TYX                   ; {25240}
    LDA $001A, X          ; {25241}
    AND #$DFFF            ; {25244}
    STA $001A, X          ; {25247}
    BRL cop_handler_006473.loc_0064BF ; {25250}
}