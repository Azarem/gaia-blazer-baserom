?BANK 1F

!rng_state                      0301
!player_x                       0374
!player_y                       0376

---------------------------------------------

code_0FBFA1 {
    LDA #$&code_0FBFB7
    STA $0018, X

  loc_0FBFA7:
    COP [1F]
    LDA $rng_state+1
    AND #$007F
    CLC 
    ADC #$007F
    STA $0014, X
    RTL 
}
---------------------------------------------

code_0FBFB7 {
    COP [07] ( #$8503, &code_0FBFC4 )
    COP [85] ( @code_0FBFC7 )
    BRA loc_0FBFA7
}

code_0FBFC4 {
    COP [86]
    RTL 
}

code_0FBFC7 {
    LDA #$0301
    STA $0016, X
    COP [A3]
    BRK #$50

  loc_0FBFD1:
    COP [80] ( #03 )
    COP [82]
    COP [1C] ( #$8000, &code_0FBFDE )
    BRA loc_0FBFD1
}

code_0FBFDE {
    COP [1F]
    LDA $rng_state+1
    AND #$007F
    SEC 
    SBC #$0040
    CLC 
    ADC $player_x
    STA $0000, X
    COP [1F]
    LDA $rng_state+1
    AND #$007F
    SEC 
    SBC #$0040
    CLC 
    ADC $player_y
    SEC 
    SBC #$00E0
    STA $0002, X
    COP [81] ( #04, #07 )
    COP [83]
    LDA #$0200
    STA $0016, X
    COP [A6]
    COP [80] ( #05 )
    COP [82]
    COP [86]
    RTL 
}