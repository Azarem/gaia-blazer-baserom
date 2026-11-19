?BANK 04

!map_width_px                   0342

---------------------------------------------

code_02731A {
    PHP 
    SEP #$20
    TXA 
    AND #$0F
    CMP #$0F
    REP #$20
    BEQ loc_027329
    INX 
    PLP 
    RTL 

  loc_027329:
    TXA 
    CLC 
    ADC #$00F1
    TAX 
    PLP 
    RTL 
}

code_027331 {
    PHP 
    REP #$20
    TXA 
    SEP #$20
    CLC 
    ADC #$10
    REP #$20
    BCS loc_027341
    TAX 
    PLP 
    RTL 

  loc_027341:
    CLC 
    ADC $map_width_px
    TAX 
    PLP 
    RTL 
}