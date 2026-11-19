?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop9D_SetAnimationUnlock {
    TYX                   ; {25010}
    LDA [$38]             ; {25011}
    INC $38               ; {25013}
    AND #$00FF            ; {25015}
    STA $001E, X          ; {25018}
    STZ $0020, X          ; {25021}
    LDA $38               ; {25024}
    STA $0018, X          ; {25026}
    LDA $0016, X          ; {25029}
    AND #$FFFB            ; {25032}
    STA $0016, X          ; {25035}
    BRL cop_handler_006473.loc_0064BF ; {25038}
}