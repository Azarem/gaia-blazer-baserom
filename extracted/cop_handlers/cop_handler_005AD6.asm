?BANK 00

?INCLUDE 'cop_handler_006473'

!rng_state                      0301

---------------------------------------------

Cop1F_StepRandom {
    PHY 
    SEP #$20
    LDX #$000F
    LDA #$00
    XBA 
    CLC 

  loc_005AE0:
    LDA $rng_state+1, X
    ADC $rng_state, X
    STA $rng_state, X
    DEX 
    BNE loc_005AE0
    LDX #$0010

  loc_005AEF:
    INC $rng_state, X
    BNE loc_005AF7
    DEX 
    BNE loc_005AEF

  loc_005AF7:
    REP #$20
    PLX 
    BRL cop_handler_006473.loc_0064BF
}