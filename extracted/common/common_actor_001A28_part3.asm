?BANK 00

!joy_release_latch              032A

---------------------------------------------

code_0026E7 {
    LDA #$4000
    TRB $joy_release_latch
    STZ $0433
    COP [86]
    RTL 
}