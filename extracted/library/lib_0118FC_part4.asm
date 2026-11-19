?BANK 02

!cgram_buffer                   7F0000

---------------------------------------------

code_0123EA {
    PHP 
    PHX 
    REP #$20
    LDX #$01FE

  loc_0123F1:
    LDA $cgram_buffer, X
    STA $7E6000, X
    DEX 
    DEX 
    BPL loc_0123F1
    PLX 
    PLP 
    RTS 
}

code_012400 {
    PHP 
    PHX 
    REP #$20
    LDX #$01FE

  loc_012407:
    LDA $7E6000, X
    STA $cgram_buffer, X
    DEX 
    DEX 
    BPL loc_012407
    PLX 
    PLP 
    RTS 
}