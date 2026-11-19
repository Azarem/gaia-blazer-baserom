?BANK 1F

?INCLUDE 'data_00F9F7'

---------------------------------------------

code_0FED8F {
    COP [A5] ( &code_0FED99, &code_0FEDC8, &code_0FEDF7, &code_0FEE26 )
}

code_0FED99 {
    COP [AD] ( #10 )
    COP [1B] ( &code_0FEDA2, #$0078 )
}

code_0FEDA2 {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @code_0FEE55, #$0200 )
    LDA $0030, X
    CLC 
    ADC $0000, Y
    STA $0000, Y
    JSR $&code_0FEE5D
    COP [1B] ( &code_0FEDC4, #$0001 )
}

code_0FEDC4 {
    COP [04]
    BRA code_0FED99
}

code_0FEDC8 {
    COP [AD] ( #10 )
    COP [1B] ( &code_0FEDD1, #$0078 )
}

code_0FEDD1 {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @code_0FEE55, #$0200 )
    LDA $0000, Y
    SEC 
    SBC $0030, X
    STA $0000, Y
    JSR $&code_0FEE5D
    COP [1B] ( &code_0FEDF3, #$0001 )
}

code_0FEDF3 {
    COP [04]
    BRA code_0FEDC8
}

code_0FEDF7 {
    COP [AD] ( #10 )
    COP [1B] ( &code_0FEE00, #$0078 )
}

code_0FEE00 {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @code_0FEE55, #$0200 )
    LDA $0030, X
    CLC 
    ADC $0000, Y
    STA $0000, Y
    JSR $&code_0FEE83
    COP [1B] ( &code_0FEE22, #$0001 )
}

code_0FEE22 {
    COP [04]
    BRA code_0FEDF7
}

code_0FEE26 {
    COP [AD] ( #10 )
    COP [1B] ( &code_0FEE2F, #$0078 )
}

code_0FEE2F {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @code_0FEE55, #$0200 )
    LDA $0000, Y
    SEC 
    SBC $0030, X
    STA $0000, Y
    JSR $&code_0FEE83
    COP [1B] ( &code_0FEE51, #$0001 )
}

code_0FEE51 {
    COP [04]
    BRA code_0FEE26
}

code_0FEE55 {
    COP [80] ( #29 )
    COP [82]
    COP [86]
    RTL 
}

code_0FEE5D {
    PHY 
    LDY $0030, X
    LDA $&data_00F9F7.binary_00FC84+10, Y
    PLY 
    AND #$00FF
    LSR 
    EOR #$FFFF
    INC 
    CLC 
    ADC $0002, Y
    CLC 
    ADC #$0008
    STA $0002, Y
    LDA $0030, X
    CLC 
    ADC #$0010
    STA $0030, X
    RTS 
}

code_0FEE83 {
    PHY 
    LDY $0030, X
    LDA $&data_00F9F7.binary_00FC84+10, Y
    PLY 
    AND #$00FF
    LSR 
    CLC 
    ADC $0002, Y
    SEC 
    SBC #$0008
    STA $0002, Y
    LDA $0030, X
    CLC 
    ADC #$0010
    STA $0030, X
    RTS 
}