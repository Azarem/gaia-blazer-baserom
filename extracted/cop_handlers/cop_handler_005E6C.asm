?BANK 00

?INCLUDE 'cop_handler_006473'

!transition_type                03E3

---------------------------------------------

Cop3C_SetMode03E3 {
    TYX                   ; {24172}
    LDA [$38]             ; {24173}
    INC $38               ; {24175}
    AND #$00FF            ; {24177}
    STA $transition_type  ; {24180}
    BRL cop_handler_006473.loc_0064BF ; {24183}
}