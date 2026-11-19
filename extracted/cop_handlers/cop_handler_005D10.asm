?BANK 00

?INCLUDE 'cop_handler_005CF0_part1'
?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop32_SpawnEngineActor2CCB {
    TYX                   ; {23824}
    JSR $&engine_0065A7.code_006662 ; {23825}
    LDA #$&cop_handler_005CF0_part1.code_002CCB ; {23828}
    STA $0018, Y          ; {23831}
    SEP #$20              ; {23834}
    LDA #$^cop_handler_005CF0_part1.code_002CCB ; {23836}
    STA $0036, Y          ; {23838}
    REP #$20              ; {23841}
    LDA [$38]             ; {23843}
    INC $38               ; {23845}
    AND #$00FF            ; {23847}
    STA $0030, Y          ; {23850}
    BRL cop_handler_006473.loc_0064BF ; {23853}
}