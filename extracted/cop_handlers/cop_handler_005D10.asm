?BANK 00

?INCLUDE 'cop_handler_005CF0_part1'
?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop32_SpawnEngineActor2CCB {
    TYX 
    JSR $&engine_0065A7.code_006662
    LDA #$&cop_handler_005CF0_part1.code_002CCB
    STA $0018, Y
    SEP #$20
    LDA #$^cop_handler_005CF0_part1.code_002CCB
    STA $0036, Y
    REP #$20
    LDA [$38]
    INC $38
    AND #$00FF
    STA $0030, Y
    BRL cop_handler_006473.loc_0064BF
}