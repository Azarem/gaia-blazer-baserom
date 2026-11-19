?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FE88E {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE89C
    COP [1B] ( &code_0FE88E, #$0008 )

  loc_0FE89C:
    COP [9A] ( #$0000, &code_0FE8A6, &code_0FE8B0, &code_0FE8B0 )
}

code_0FE8A6 {
    COP [9B] ( #$0000, &code_0FE936, &code_0FE90E, &code_0FE90E )
}

code_0FE8B0 {
    COP [9B] ( #$0000, &code_0FE8BA, &code_0FE8E4, &code_0FE8E4 )
}

code_0FE8BA {
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE8D3
    COP [97]
    COP [AE] ( #$0010, #$FFE0, &code_0FE990 )
    COP [80] ( #43 )
    COP [82]
    BRL code_0FE990

  loc_0FE8D3:
    COP [96]
    COP [AE] ( #$0020, #$FFF0, &code_0FE95D )
    COP [80] ( #45 )
    COP [82]
    BRA code_0FE95D
}

code_0FE8E4 {
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE8FC
    COP [96]
    COP [AE] ( #$0020, #$0010, &code_0FE95D )
    COP [80] ( #44 )
    COP [82]
    BRA code_0FE95D

  loc_0FE8FC:
    COP [97]
    COP [AE] ( #$0010, #$0020, &code_0FE9C3 )
    COP [80] ( #41 )
    COP [82]
    BRL code_0FE9C3
}

code_0FE90E {
    COP [97]
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE927
    COP [AE] ( #$FFF0, #$0020, &code_0FE9C3 )
    COP [80] ( #40 )
    COP [82]
    BRL code_0FE9C3

  loc_0FE927:
    COP [AE] ( #$FFE0, #$0010, &code_0FE95D )
    COP [80] ( #44 )
    COP [82]
    BRA code_0FE95D
}

code_0FE936 {
    COP [97]
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE94E
    COP [AE] ( #$FFE0, #$FFF0, &code_0FE95D )
    COP [80] ( #45 )
    COP [82]
    BRA code_0FE95D

  loc_0FE94E:
    COP [AE] ( #$FFF0, #$FFE0, &code_0FE990 )
    COP [80] ( #42 )
    COP [82]
    BRA code_0FE990
}

code_0FE95D {
    COP [81] ( #3F, #04 )
    COP [83]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #4C )
    COP [82]
    JSR $&code_0FE9F6
    COP [80] ( #4D )
    COP [82]
    COP [80] ( #4E )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #3F, #04 )
    COP [83]
    BRL code_0FE88E
}

code_0FE990 {
    COP [81] ( #3E, #04 )
    COP [83]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #49 )
    COP [82]
    JSR $&code_0FE9F6
    COP [80] ( #4A )
    COP [82]
    COP [80] ( #4B )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #3E, #04 )
    COP [83]
    BRL code_0FE88E
}

code_0FE9C3 {
    COP [81] ( #3D, #04 )
    COP [83]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #46 )
    COP [82]
    JSR $&code_0FE9F6
    COP [80] ( #47 )
    COP [82]
    COP [80] ( #48 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #3D, #04 )
    COP [83]
    BRL code_0FE88E
}

code_0FE9F6 {
    COP [B2] ( @code_0FEA0D, #$0000, #$0010, #$0200 )
    COP [B2] ( @code_0FEA15, #$FFF0, #$0000, #$0200 )
    RTS 
}

code_0FEA0D {
    COP [80] ( #4F )
    COP [82]
    COP [86]
    RTL 
}

code_0FEA15 {
    COP [80] ( #50 )
    COP [82]
    COP [86]
    RTL 
}