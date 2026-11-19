?BANK 00

?INCLUDE 'lib_0118FC_part9'

!player_x                       0374
!player_y                       0376

---------------------------------------------

code_002D67 {
    TYA 
    STA $001E, X
    STZ $0020, X
    COP [85] ( @code_002D96 )
    CPY #$06AA
    BEQ loc_002D93
    SEP #$20
    LDA #$00
    STA $0036, X
    REP #$20
    COP [91]

  loc_002D83:
    COP [82]
    LDA $0016, X
    BIT #$8000
    BEQ loc_002D83
    LDY $003E, X
    STA $0030, Y

  loc_002D93:
    COP [86]
    RTL 
}

code_002D96 {
    LDA $003C, X
    STA $0030, X
    LDA $player_x
    SEC 
    SBC $0000, X
    BMI loc_002DC4
    STA $16
    LDA $player_y
    SEC 
    SBC $0002, X
    BMI loc_002DB8
    STA $18
    CMP $16
    BCS loc_002E23
    BRA loc_002E11

  loc_002DB8:
    EOR #$FFFF
    INC 
    STA $18
    CMP $16
    BCS loc_002DEA
    BRA loc_002DFF

  loc_002DC4:
    EOR #$FFFF
    INC 
    STA $16
    LDA $player_y
    SEC 
    SBC $0002, X
    BMI loc_002DDB
    STA $18
    CMP $16
    BCS loc_002E35
    BRA loc_002E47

  loc_002DDB:
    EOR #$FFFF
    INC 
    STA $18
    CMP $16
    BCC loc_002DE8
    BRL loc_002E6B

  loc_002DE8:
    BRA loc_002E59

  loc_002DEA:
    JSR $&code_002E9C
    COP [91]
    DEC $0002, X
    DEC $0010, X
    BEQ loc_002DFA
    BRL loc_002E83

  loc_002DFA:
    INC $0000, X
    BRA loc_002E7D

  loc_002DFF:
    JSR $&code_002EA4
    COP [91]
    INC $0000, X
    DEC $0010, X
    BNE loc_002E83
    DEC $0002, X
    BRA loc_002E7D

  loc_002E11:
    JSR $&code_002EA4
    COP [91]
    INC $0000, X
    DEC $0010, X
    BNE loc_002E83
    INC $0002, X
    BRA loc_002E7D

  loc_002E23:
    JSR $&code_002E9C
    COP [91]
    INC $0002, X
    DEC $0010, X
    BNE loc_002E83
    INC $0000, X
    BRA loc_002E7D

  loc_002E35:
    JSR $&code_002E9C
    COP [91]
    INC $0002, X
    DEC $0010, X
    BNE loc_002E83
    DEC $0000, X
    BRA loc_002E7D

  loc_002E47:
    JSR $&code_002EA4
    COP [91]
    DEC $0000, X
    DEC $0010, X
    BNE loc_002E83
    INC $0002, X
    BRA loc_002E7D

  loc_002E59:
    JSR $&code_002EA4
    COP [91]
    DEC $0000, X
    DEC $0010, X
    BNE loc_002E83
    DEC $0002, X
    BRA loc_002E7D

  loc_002E6B:
    JSR $&code_002E9C
    COP [91]
    DEC $0002, X
    DEC $0010, X
    BNE loc_002E83
    DEC $0000, X
    BRA loc_002E7D

  loc_002E7D:
    LDA $0012, X
    STA $0010, X

  loc_002E83:
    LDA $003C, X
    CMP $0030, X
    BNE loc_002E99
    TAY 
    LDA $0000, X
    STA $0000, Y
    LDA $0002, X
    STA $0002, Y
    RTL 

  loc_002E99:
    COP [86]
    RTL 
}

code_002E9C {
    SEP #$20
    LDY $18
    LDA $16
    BRA loc_002EAA
}

code_002EA4 {
    SEP #$20
    LDY $16
    LDA $18

  loc_002EAA:
    BNE loc_002EAD
    INC 

  loc_002EAD:
    JSL $@lib_0118FC_part9.code_0131E8
    REP #$20
    AND #$00FF
    BNE loc_002EB9
    INC 

  loc_002EB9:
    STA $0010, X
    STA $0012, X
    RTS 
}