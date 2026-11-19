?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FE045 {
    LDA $001A, X
    ORA #$0800
    STA $001A, X
    COP [AD] ( #08 )

  loc_0FE051:
    COP [9B] ( #$0008, &code_0FE05B, &code_0FE0CC, &code_0FE073 )
}

code_0FE05B {
    COP [97]

  code_0FE05D:
    COP [80] ( #19 )
    COP [82]
    COP [9B] ( #$0018, &code_0FE05D, &code_0FE06C, &code_0FE073 )
}

code_0FE06C {
    COP [80] ( #16 )
    COP [82]
    BRA loc_0FE089
}

code_0FE073 {
    COP [97]

  code_0FE075:
    COP [80] ( #18 )
    COP [82]
    COP [9B] ( #$0018, &code_0FE05B, &code_0FE084, &code_0FE075 )
}

code_0FE084 {
    COP [80] ( #15 )
    COP [82]

  loc_0FE089:
    COP [1F]
    LDA $rng_state+1
    BPL code_0FE0CC
    LDA $0016, X
    BIT #$0200
    BEQ loc_0FE0B3
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    BRK #$60
    COP [80] ( #1C )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    BRA code_0FE0CC

  loc_0FE0B3:
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    BRK #$60
    COP [80] ( #1B )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
}

code_0FE0CC {
    COP [9A] ( #$0008, &code_0FE0D6, &code_0FE104, &code_0FE0EE )
}

code_0FE0D6 {
    COP [97]

  code_0FE0D8:
    COP [80] ( #1A )
    COP [82]
    COP [9A] ( #$0018, &code_0FE0D8, &code_0FE0E7, &code_0FE0EE )
}

code_0FE0E7 {
    COP [80] ( #17 )
    COP [82]
    BRA code_0FE104
}

code_0FE0EE {
    COP [96]

  code_0FE0F0:
    COP [80] ( #1A )
    COP [82]
    COP [9A] ( #$0018, &code_0FE0D6, &code_0FE0FF, &code_0FE0F0 )
}

code_0FE0FF {
    COP [80] ( #17 )
    COP [82]
}

code_0FE104 {
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE10E
    BRL loc_0FE051

  loc_0FE10E:
    LDA $0016, X
    BIT #$0200
    BEQ loc_0FE132
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    BRK #$60
    COP [80] ( #1C )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    BRL loc_0FE051

  loc_0FE132:
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    BRK #$60
    COP [80] ( #1B )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRL loc_0FE051
}