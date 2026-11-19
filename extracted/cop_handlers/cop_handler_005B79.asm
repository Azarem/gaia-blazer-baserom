?BANK 00

?INCLUDE 'cop_handler_006473'
?INCLUDE 'lib_0276C9'

---------------------------------------------

Cop26_JumpIfLib0276C9 {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    LDY $1B64
    CPY #$0040
    BNE loc_005B8D
    LDA #$0000
    BRA loc_005B99

  loc_005B8D:
    LDY $1B60
    CPY #$000C
    BNE loc_005B99
    LSR 
    BNE loc_005B99
    INC 

  loc_005B99:
    JSL $@lib_0276C9.code_0276C9
    BCS loc_005BA8
    LDA #$0010
    TSB $0332
    BRL cop_handler_006473.loc_0064BB

  loc_005BA8:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_handler_006473.loc_0064C1
}