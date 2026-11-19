?BANK 00

!joy_release_latch              032A

---------------------------------------------

code_0026E7 {
    LDA #$4000            ; {9959}
    TRB $joy_release_latch ; {9962}
    STZ $0433             ; {9965}
    COP [86]              ; {9968}
    RTL                   ; {9970}
}