?BANK 00

?INCLUDE 'cop_handler_006473'

!rng_state                      0301

---------------------------------------------

Cop1F_StepRandom {
    PHY                   ; {23254}
    SEP #$20              ; {23255}
    LDX #$000F            ; {23257}
    LDA #$00              ; {23260}
    XBA                   ; {23262}
    CLC                   ; {23263}

  loc_005AE0:
    LDA $rng_state+1, X   ; {23264}
    ADC $rng_state, X     ; {23267}
    STA $rng_state, X     ; {23270}
    DEX                   ; {23273}
    BNE loc_005AE0        ; {23274}
    LDX #$0010            ; {23276}

  loc_005AEF:
    INC $rng_state, X     ; {23279}
    BNE loc_005AF7        ; {23282}
    DEX                   ; {23284}
    BNE loc_005AEF        ; {23285}

  loc_005AF7:
    REP #$20              ; {23287}
    PLX                   ; {23289}
    BRL cop_handler_006473.loc_0064BF ; {23290}
}