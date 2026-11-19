?BANK 02

!rng_state                      0301

---------------------------------------------

code_013246 {
    PHX 
    PHY 
    PHP 
    SEP #$20
    REP #$10
    LDX #$000F
    LDA #$00
    XBA 
    CLC 

  loc_013254:
    LDA $rng_state+1, X
    ADC $rng_state, X
    STA $rng_state, X
    DEX 
    BNE loc_013254
    LDX #$0010

  loc_013263:
    INC $rng_state, X
    BNE loc_01326B
    DEX 
    BNE loc_013263

  loc_01326B:
    LDA $rng_state+1
    PLP 
    PLY 
    PLX 
    RTL 
}