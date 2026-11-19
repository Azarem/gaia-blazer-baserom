?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA4_SetFlag1A2000 {
    TYX                   ; {25173}
    LDA $001A, X          ; {25174}
    ORA #$2000            ; {25177}
    STA $001A, X          ; {25180}
    BRL cop_handler_006473.loc_0064BF ; {25183}
}