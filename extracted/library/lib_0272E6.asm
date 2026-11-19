?BANK 04

---------------------------------------------

code_0272E6 {
    LDA $18
    AND #$00F8
    ASL 
    ASL 
    PHA 
    LDA $16
    AND #$00F8
    LSR 
    LSR 
    LSR 
    CLC 
    ADC $01, S
    STA $01, S
    LDA $16
    AND #$0100
    ASL 
    ASL 
    CLC 
    ADC $01, S
    STA $01, S
    LDA $18
    AND #$0100
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $01, S
    STA $01, S
    PLA 
    CLC 
    ADC #$6000
    RTL 
}