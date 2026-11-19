?BANK 04

---------------------------------------------

code_02716E {
    PHP 
    PHX 
    PHY 
    REP #$20
    LDA $03A4
    XBA 
    ASL 
    ASL 
    TAX 
    LDA #$3652
    STA $16
    STA $18
    LDA #$01FD
    STA $0C

  loc_027186:
    LDA $700000, X
    PHA 
    CLC 
    ADC $16
    STA $16
    PLA 
    EOR $18
    STA $18
    INX 
    INX 
    DEC $0C
    BNE loc_027186
    PLY 
    PLX 
    PLP 
    RTL 
}