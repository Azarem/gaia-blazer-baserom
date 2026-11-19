?BANK 00

?INCLUDE 'lib_01186E'
?INCLUDE 'lib_0126CF'
?INCLUDE 'lib_016264'

!scroll_bg1_x                   033A

---------------------------------------------

code_0074D3 {
    INC $046A
    LDA $046A
    STA $scroll_bg1_x
    CMP #$0100
    BEQ loc_0074E2
    RTL 

  loc_0074E2:
    INC $0482
    COP [91]
    RTL 
}

code_0074E8 {
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    STZ $0030, X
    PHX 
    LDX #$0000
    LDA #$0070
    STA $7E7800, X
    LDA #$0030
    STA $7E7803, X
    LDA #$0010
    STA $7E7806, X
    LDA #$0010
    STA $7E7809, X
    LDA #$0010
    STA $7E780C, X
    LDA #$0008
    STA $7E780F, X
    LDA #$0001
    STA $7E7812, X
    LDA #$0000
    STA $7E7815, X
    STA $7E7801, X
    PLX 
    COP [91]
    PHX 
    TXY 
    LDX #$0000
    LDA $046A
    LSR 
    STA $16
    STA $7E780A, X
    LDA $0030, Y
    LSR 
    PHA 
    LSR 
    CLC 
    ADC $01, S
    LSR 
    CLC 
    ADC $16
    STA $7E7810, X
    PLA 
    LDA $0030, Y
    LSR 
    CLC 
    ADC $16
    STA $7E7804, X
    STA $7E7813, X
    LDA $0030, Y
    LSR 
    LSR 
    CLC 
    ADC $16
    STA $7E7807, X
    STA $7E780D, X
    SEP #$20
    LDA #$0F
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_01186E.code_01188A
    REP #$20
    PLX 
    INC $0030, X
    RTL 
}

code_00758C {
    LDA $0016, X
    ORA #$0010
    STA $0016, X

  loc_007595:
    COP [91]
    LDA $0466
    BMI loc_0075DE
    BNE loc_0075A2
    JSR $&code_0075E7
    RTL 

  loc_0075A2:
    STZ $0030, X
    COP [03] ( #E0 )
    LDA $0030, X
    JSR $&code_0075E7
    COP [27] ( &code_0075B2 )
}

code_0075B2 {
    LDA $0030, X
    JSR $&code_0075E7
    INC $0030, X
    COP [04]
    COP [91]
    LDA $0466
    BEQ loc_0075CB
    LDA #$00E0
    JSR $&code_0075E7
    RTL 

  loc_0075CB:
    COP [03] ( #70 )
    LDA $0030, X
    JSR $&code_0075E7
    DEC $0030, X
    DEC $0030, X
    COP [04]
    BRA loc_007595

  loc_0075DE:
    COP [91]
    LDA #$00E0
    JSR $&code_0075E7
    RTL 
}

code_0075E7 {
    PHX 
    SEP #$20
    LDX #$0000
    CMP #$00
    BEQ loc_007614
    CMP #$80
    BCC loc_007608
    SEC 
    SBC #$7F
    PHA 
    LDA #$7F
    STA $7E7000, X
    LDA #$17
    STA $7E7001, X
    INX 
    INX 
    PLA 

  loc_007608:
    STA $7E7000, X
    LDA #$17
    STA $7E7001, X
    INX 
    INX 

  loc_007614:
    LDA #$01
    STA $7E7000, X
    LDA #$13
    STA $7E7001, X
    INX 
    INX 
    LDA #$00
    STA $7E7000, X
    LDA #$2C
    XBA 
    LDA #$7E
    LDY #$7000
    JSL $@lib_01186E.code_01188A
    REP #$20
    PLX 
    RTS 
}

code_007638 {
    PHX 
    LDY #$&lib_016264.asciistring_016264
    JSL $@lib_0126CF.code_0126CF
    PLX 
    COP [1B] ( &code_007647, #$00F0 )
}

code_007647 {
    COP [31] ( #00 )
    COP [1B] ( &code_007650, #$00F0 )
}

code_007650 {
    COP [10] ( #$0D00, #02, #$0000, #$0000 )
    SEP #$20
    STZ $1B82
    REP #$20
    LDA #$0020
    STA $03B4
    INC $0454
    COP [91]
    RTL 
}