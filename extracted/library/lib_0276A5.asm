?BANK 04

---------------------------------------------

code_0276A5 {
    SED 
    CLC 
    ADC $1B66
    STA $1B66
    LDA $1B68
    ADC #$0000
    STA $1B68
    CMP #$009A
    BCC loc_0276C7
    LDA #$9999
    STA $1B66
    LDA #$0099
    STA $1B68

  loc_0276C7:
    CLD 
    RTL 
}