?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

CopAA_SetPalette {
    TYX                   ; {25318}
    LDA $001C, X          ; {25319}
    AND #$F1FF            ; {25322}
    PHA                   ; {25325}
    LDA [$38]             ; {25326}
    INC $38               ; {25328}
    AND #$00FF            ; {25330}
    XBA                   ; {25333}
    ORA $01, S            ; {25334}
    STA $001C, X          ; {25336}
    PLA                   ; {25339}
    BRL cop_handler_006473.loc_0064BF ; {25340}
}