?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopA2_SetPriority {
    TYX                   ; {25135}
    LDA $001C, X          ; {25136}
    AND #$CFFF            ; {25139}
    PHA                   ; {25142}
    LDA [$38]             ; {25143}
    INC $38               ; {25145}
    AND #$00FF            ; {25147}
    XBA                   ; {25150}
    ORA $01, S            ; {25151}
    STA $001C, X          ; {25153}
    PLA                   ; {25156}
    BRL cop_handler_006473.loc_0064BF ; {25157}
}