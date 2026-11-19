?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'engine_0065A7'
?INCLUDE 'lib_0273A2'

---------------------------------------------

Cop14_JumpIfSwitchSet {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    JSR $&engine_0065A7.code_00662D
    LDY #$1ADE
    JSL $@lib_0273A2.code_0273A2
    BCC loc_0059F1
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1

  loc_0059F1:
    BRL cop_handler_006473.loc_0064BB
}