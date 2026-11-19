?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'data_00BA0D'
?INCLUDE 'engine_0065A7'
?INCLUDE 'lib_0273A2'

---------------------------------------------

Cop3B_JumpIfSwitchSetData {
    TYX 
    LDA [$38]
    JSR $&engine_0065A7.code_00662D
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    TAY 
    LDA $&data_00BA0D+1E, Y
    BEQ loc_005E27
    LDY #$1ADE
    JSL $@lib_0273A2.code_0273A2
    BCC loc_005E4B

  loc_005E27:
    LDA [$38]
    INC $38
    INC $38
    LDY #$1ADE
    JSL $@lib_0273A2.code_0273A2
    BCC loc_005E48
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1

  loc_005E48:
    BRL cop_handler_006473.loc_0064C9

  loc_005E4B:
    LDA [$38]
    INC $38
    INC $38
    STA $0034, X
    PHX 
    TAX 
    LDA $7F0203, X
    PLX 
    BIT #$0040
    BEQ loc_005E48
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    BRL cop_handler_006473.loc_0064BB
}