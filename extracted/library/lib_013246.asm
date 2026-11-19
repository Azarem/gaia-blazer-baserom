?BANK 02

!rng_state                      0301

---------------------------------------------

code_013246 {
    PHX                   ; {78406}
    PHY                   ; {78407}
    PHP                   ; {78408}
    SEP #$20              ; {78409}
    REP #$10              ; {78411}
    LDX #$000F            ; {78413}
    LDA #$00              ; {78416}
    XBA                   ; {78418}
    CLC                   ; {78419}

  loc_013254:
    LDA $rng_state+1, X   ; {78420}
    ADC $rng_state, X     ; {78423}
    STA $rng_state, X     ; {78426}
    DEX                   ; {78429}
    BNE loc_013254        ; {78430}
    LDX #$0010            ; {78432}

  loc_013263:
    INC $rng_state, X     ; {78435}
    BNE loc_01326B        ; {78438}
    DEX                   ; {78440}
    BNE loc_013263        ; {78441}

  loc_01326B:
    LDA $rng_state+1      ; {78443}
    PLP                   ; {78446}
    PLY                   ; {78447}
    PLX                   ; {78448}
    RTL                   ; {78449}
}