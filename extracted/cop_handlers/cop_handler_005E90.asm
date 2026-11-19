?BANK 00

?INCLUDE 'cop_handler_006473'

---------------------------------------------

Cop81_SetAnimationCount {
    TYX                   ; {24208}
    LDA [$38]             ; {24209}
    INC $38               ; {24211}
    AND #$00FF            ; {24213}
    STA $001E, X          ; {24216}
    STZ $0020, X          ; {24219}
    LDA [$38]             ; {24222}
    INC $38               ; {24224}
    AND #$00FF            ; {24226}
    STA $002A, X          ; {24229}
    LDA $38               ; {24232}
    STA $0018, X          ; {24234}
    BRL cop_handler_006473.loc_0064BF ; {24237}
}