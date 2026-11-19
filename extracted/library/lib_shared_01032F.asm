?BANK 02

?INCLUDE 'lib_shared_010419'
?INCLUDE 'lib_shared_0131D1'

---------------------------------------------

code_01032F {
    PHP 
    PHB 
    SEP #$20
    LDA $19
    XBA 
    LDA $05
    JSL $@lib_shared_0131D1.code_0131D1
    CLC 
    ADC $17
    CLC 
    ADC $03
    XBA 
    LDA $16
    LSR 
    LSR 
    LSR 
    LSR 
    TAY 
    LDA #$7E
    PHA 
    PLB 
    LDA $17
    AND #$01
    ASL 
    ASL 
    XBA 
    LDA $16
    LSR 
    LSR 
    LSR 
    AND #$1E
    REP #$20
    CLC 
    ADC $00
    STA $0000, X
    INX 
    INX 
    LDA $18
    AND #$0100
    BNE loc_01038B
    JSR $&lib_shared_010419.code_010419
    TYA 
    CLC 
    ADC $04
    CMP $08
    BCC loc_01037E
    SEC 
    SBC $08
    CLC 
    ADC $02

  loc_01037E:
    TAY 
    TXA 
    CLC 
    ADC #$0080
    TAX 
    JSR $&lib_shared_010419.code_010419
    PLB 
    PLP 
    RTS 

  loc_01038B:
    PHX 
    TXA 
    CLC 
    ADC #$0080
    TAX 
    JSR $&lib_shared_010419.code_010419
    TYA 
    CLC 
    ADC $04
    CMP $08
    BCC loc_0103A3
    SEC 
    SBC $08
    CLC 
    ADC $02

  loc_0103A3:
    TAY 
    PLX 
    JSR $&lib_shared_010419.code_010419
    PLB 
    PLP 
    RTS 
}