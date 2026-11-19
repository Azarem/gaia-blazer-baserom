?BANK 02

?INCLUDE 'lib_01010B_part3'
?INCLUDE 'lib_shared_0131D1'

---------------------------------------------

code_0103AB {
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
    LDA $18
    AND #$F0
    TAY 
    LDA #$7E
    PHA 
    PLB 
    REP #$20
    LDA $18
    AND #$00F0
    ASL 
    ASL 
    PHA 
    LDA $18
    AND #$0100
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $01, S
    CLC 
    ADC $00
    STA $0000, X
    PLA 
    INX 
    INX 
    LDA $16
    AND #$0100
    BNE loc_010402
    JSR $&lib_01010B_part3.code_010466
    TYA 
    CLC 
    ADC #$0100
    TAY 
    TXA 
    CLC 
    ADC #$0080
    TAX 
    JSR $&lib_01010B_part3.code_010466
    PLB 
    PLP 
    RTS 

  loc_010402:
    PHX 
    TXA 
    CLC 
    ADC #$0080
    TAX 
    JSR $&lib_01010B_part3.code_010466
    TYA 
    CLC 
    ADC #$0100
    TAY 
    PLX 
    JSR $&lib_01010B_part3.code_010466
    PLB 
    PLP 
    RTS 
}