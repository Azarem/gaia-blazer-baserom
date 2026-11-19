?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'

---------------------------------------------

Cop84_SpawnActorAfter {
    TYX                   ; {24271}
    JSR $&engine_0065A7.code_00663A ; {24272}
    LDA [$38]             ; {24275}
    INC $38               ; {24277}
    INC $38               ; {24279}
    STA $0018, Y          ; {24281}
    TXA                   ; {24284}
    LDA [$38]             ; {24285}
    INC $38               ; {24287}
    AND #$00FF            ; {24289}
    SEP #$20              ; {24292}
    STA $0036, Y          ; {24294}
    REP #$20              ; {24297}
    BRL cop_handler_006473.loc_0064BF ; {24299}
}