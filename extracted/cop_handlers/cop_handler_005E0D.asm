?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'data_00BA0D'
?INCLUDE 'engine_0065A7'
?INCLUDE 'lib_0273A2'

---------------------------------------------

Cop3B_JumpIfSwitchSetData {
    TYX                   ; {24077}
    LDA [$38]             ; {24078}
    JSR $&engine_0065A7.code_00662D ; {24080}
    ASL                   ; {24083}
    ASL                   ; {24084}
    ASL                   ; {24085}
    ASL                   ; {24086}
    ASL                   ; {24087}
    TAY                   ; {24088}
    LDA $&data_00BA0D+1E, Y ; {24089}
    BEQ loc_005E27        ; {24092}
    LDY #$1ADE            ; {24094}
    JSL $@lib_0273A2.code_0273A2 ; {24097}
    BCC loc_005E4B        ; {24101}

  loc_005E27:
    LDA [$38]             ; {24103}
    INC $38               ; {24105}
    INC $38               ; {24107}
    LDY #$1ADE            ; {24109}
    JSL $@lib_0273A2.code_0273A2 ; {24112}
    BCC loc_005E48        ; {24116}
    LDA $0016, X          ; {24118}
    AND #$DFFF            ; {24121}
    STA $0016, X          ; {24124}
    LDA [$38]             ; {24127}
    INC $38               ; {24129}
    INC $38               ; {24131}
    BRL cop_handler_006473.loc_0064C1 ; {24133}

  loc_005E48:
    BRL cop_handler_006473.loc_0064C9 ; {24136}

  loc_005E4B:
    LDA [$38]             ; {24139}
    INC $38               ; {24141}
    INC $38               ; {24143}
    STA $0034, X          ; {24145}
    PHX                   ; {24148}
    TAX                   ; {24149}
    LDA $7F0203, X        ; {24150}
    PLX                   ; {24154}
    BIT #$0040            ; {24155}
    BEQ loc_005E48        ; {24158}
    LDA $0016, X          ; {24160}
    ORA #$0010            ; {24163}
    STA $0016, X          ; {24166}
    BRL cop_handler_006473.loc_0064BB ; {24169}
}