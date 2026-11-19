?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

CopAF_SpawnAfterFlags {
    TYX                   ; {25569}
    JSR $&engine_0065A7.code_00663A ; {25570}
    LDA [$38]             ; {25573}
    INC $38               ; {25575}
    INC $38               ; {25577}
    STA $0018, Y          ; {25579}
    TXA                   ; {25582}
    LDA [$38]             ; {25583}
    INC $38               ; {25585}
    AND #$00FF            ; {25587}
    SEP #$20              ; {25590}
    STA $0036, Y          ; {25592}
    REP #$20              ; {25595}
    LDA [$38]             ; {25597}
    INC $38               ; {25599}
    INC $38               ; {25601}
    STA $0016, Y          ; {25603}
    BRL cop_handler_006473.loc_0064BF ; {25606}
}