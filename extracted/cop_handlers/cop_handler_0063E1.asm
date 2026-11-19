?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

CopAF_SpawnAfterFlags {
    TYX 
    JSR $&engine_0065A7.code_00663A
    LDA [$38]
    INC $38
    INC $38
    STA $0018, Y
    TXA 
    LDA [$38]
    INC $38
    AND #$00FF
    SEP #$20
    STA $0036, Y
    REP #$20
    LDA [$38]
    INC $38
    INC $38
    STA $0016, Y
    BRL cop_handler_006473.loc_0064BF
}