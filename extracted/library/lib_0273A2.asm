?BANK 04

?INCLUDE 'data_00F9F7'

---------------------------------------------

code_0273A2 {
    PHP 
    REP #$20
    PHA 
    PHX 
    PHY 
    PHA 
    PHY 
    AND #$03F8
    LSR 
    LSR 
    LSR 
    CLC 
    ADC $01, S
    STA $01, S
    PLY 
    PLA 
    AND #$0007
    TAX 
    SEP #$20
    LDA $@data_00F9F7.binary_00FA77, X
    AND $0000, Y
    REP #$20
    BNE loc_0273CE
    PLY 
    PLX 
    PLA 
    PLP 
    CLC 
    RTL 

  loc_0273CE:
    PLY 
    PLX 
    PLA 
    PLP 
    SEC 
    RTL 
}