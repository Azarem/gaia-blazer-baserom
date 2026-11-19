?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

CopB0_SpawnBeforeFlags {
    TYX                   ; {25609}
    JSR $&engine_0065A7.code_006662 ; {25610}
    LDA [$38]             ; {25613}
    INC $38               ; {25615}
    INC $38               ; {25617}
    STA $0018, Y          ; {25619}
    TXA                   ; {25622}
    LDA [$38]             ; {25623}
    INC $38               ; {25625}
    AND #$00FF            ; {25627}
    SEP #$20              ; {25630}
    STA $0036, Y          ; {25632}
    REP #$20              ; {25635}
    LDA [$38]             ; {25637}
    INC $38               ; {25639}
    INC $38               ; {25641}
    STA $0016, Y          ; {25643}
    BRL cop_handler_006473.loc_0064BF ; {25646}
}