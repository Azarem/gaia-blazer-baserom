?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop80_SetAnimation {
    TYX                   ; {24186}
    LDA [$38]             ; {24187}
    INC $38               ; {24189}
    AND #$00FF            ; {24191}
    STA $001E, X          ; {24194}
    STZ $0020, X          ; {24197}
    LDA $38               ; {24200}
    STA $0018, X          ; {24202}
    BRL cop_handler_006473.loc_0064BF ; {24205}
}