?BANK 00

?INCLUDE 'cop_handler_005CF0_part1'
?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop31_SpawnEngineActor2C9B {
    TYX                   ; {23792}
    JSR $&engine_0065A7.code_006662 ; {23793}
    LDA #$&cop_handler_005CF0_part1.code_002C9B ; {23796}
    STA $0018, Y          ; {23799}
    SEP #$20              ; {23802}
    LDA #$^cop_handler_005CF0_part1.code_002C9B ; {23804}
    STA $0036, Y          ; {23806}
    REP #$20              ; {23809}
    LDA [$38]             ; {23811}
    INC $38               ; {23813}
    AND #$00FF            ; {23815}
    STA $0030, Y          ; {23818}
    BRL cop_handler_006473.loc_0064BF ; {23821}
}