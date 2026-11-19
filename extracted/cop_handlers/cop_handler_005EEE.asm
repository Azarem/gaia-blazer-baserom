?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop85_SpawnActorBefore {
    TYX                   ; {24302}
    JSR $&engine_0065A7.code_006662 ; {24303}
    LDA [$38]             ; {24306}
    INC $38               ; {24308}
    INC $38               ; {24310}
    STA $0018, Y          ; {24312}
    TXA                   ; {24315}
    LDA [$38]             ; {24316}
    INC $38               ; {24318}
    AND #$00FF            ; {24320}
    SEP #$20              ; {24323}
    STA $0036, Y          ; {24325}
    REP #$20              ; {24328}
    BRL cop_handler_006473.loc_0064BF ; {24330}
}