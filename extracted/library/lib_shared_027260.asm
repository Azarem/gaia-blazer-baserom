?BANK 04

---------------------------------------------

code_027260 {
    PHP 
    REP #$20
    LDX #$0000
    TXA 

  loc_027267:
    STA $0100, X
    INX 
    INX 
    CPX #$0200
    BNE loc_027267
    DEC 
    STA $0100, X
    PLP 
    RTL 
}