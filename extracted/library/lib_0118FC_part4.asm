?BANK 02

!cgram_buffer                   7F0000

---------------------------------------------

code_0123EA {
    PHP                   ; {74730}
    PHX                   ; {74731}
    REP #$20              ; {74732}
    LDX #$01FE            ; {74734}

  loc_0123F1:
    LDA $cgram_buffer, X  ; {74737}
    STA $7E6000, X        ; {74741}
    DEX                   ; {74745}
    DEX                   ; {74746}
    BPL loc_0123F1        ; {74747}
    PLX                   ; {74749}
    PLP                   ; {74750}
    RTS                   ; {74751}
}

code_012400 {
    PHP                   ; {74752}
    PHX                   ; {74753}
    REP #$20              ; {74754}
    LDX #$01FE            ; {74756}

  loc_012407:
    LDA $7E6000, X        ; {74759}
    STA $cgram_buffer, X  ; {74763}
    DEX                   ; {74767}
    DEX                   ; {74768}
    BPL loc_012407        ; {74769}
    PLX                   ; {74771}
    PLP                   ; {74772}
    RTS                   ; {74773}
}