?BANK 1F

---------------------------------------------

code_0FE236 {
    COP [AD] ( #10 )
    COP [0C] ( #00, #02, &code_0FE246 )
    COP [80] ( #3C )
    COP [82]
    BRA code_0FE236
}

code_0FE246 {
    COP [80] ( #3D )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X

  loc_0FE254:
    COP [9B] ( #$0000, &code_0FE25E, &code_0FE286, &code_0FE286 )
}

code_0FE25E {
    COP [97]
    COP [9B] ( #$0018, &code_0FE26A, &code_0FE275, &code_0FE26A )
}

code_0FE26A {
    COP [21] ( &code_0FE3BF )
    COP [80] ( #2D )
    COP [82]
    BRA loc_0FE254
}

code_0FE275 {
    COP [9A] ( #$0028, &code_0FE27F, &code_0FE345, &code_0FE27F )
}

code_0FE27F {
    COP [80] ( #2C )
    COP [82]
    BRA loc_0FE2AC
}

code_0FE286 {
    COP [97]
    COP [9B] ( #$0018, &code_0FE292, &code_0FE29D, &code_0FE292 )
}

code_0FE292 {
    COP [22] ( &code_0FE3BF )
    COP [80] ( #25 )
    COP [82]
    BRA loc_0FE254
}

code_0FE29D {
    COP [9A] ( #$0028, &code_0FE2A7, &code_0FE382, &code_0FE2A7 )
}

code_0FE2A7 {
    COP [80] ( #24 )
    COP [82]

  loc_0FE2AC:
    COP [9A] ( #$0000, &code_0FE2B6, &code_0FE2DF, &code_0FE2DF )
}

code_0FE2B6 {
    COP [97]
    COP [9A] ( #$0018, &code_0FE2C2, &code_0FE2CD, &code_0FE2C2 )
}

code_0FE2C2 {
    COP [23] ( &code_0FE3BF )
    COP [80] ( #35 )
    COP [82]
    BRA loc_0FE2AC
}

code_0FE2CD {
    COP [9B] ( #$0028, &code_0FE2D7, &code_0FE308, &code_0FE2D7 )
}

code_0FE2D7 {
    COP [80] ( #34 )
    COP [82]
    BRL loc_0FE254
}

code_0FE2DF {
    COP [96]
    COP [9A] ( #$0018, &code_0FE2EB, &code_0FE2F6, &code_0FE2EB )
}

code_0FE2EB {
    COP [24] ( &code_0FE3BF )
    COP [80] ( #35 )
    COP [82]
    BRA loc_0FE2AC
}

code_0FE2F6 {
    COP [9B] ( #$0028, &code_0FE300, &code_0FE308, &code_0FE300 )
}

code_0FE300 {
    COP [80] ( #34 )
    COP [82]
    BRL loc_0FE254
}

code_0FE308 {
    COP [9B] ( #$0010, &code_0FE312, &code_0FE323, &code_0FE334 )
}

code_0FE312 {
    COP [B0] ( @code_0FE404, #$0200 )
    BRK #$41
    COP [80] ( #37 )
    COP [82]
    BRL loc_0FE254
}

code_0FE323 {
    COP [B0] ( @code_0FE40B, #$0200 )
    BRK #$41
    COP [80] ( #38 )
    COP [82]
    BRL loc_0FE254
}

code_0FE334 {
    COP [B0] ( @code_0FE3FD, #$0200 )
    BRK #$41
    COP [80] ( #36 )
    COP [82]
    BRL loc_0FE254
}

code_0FE345 {
    COP [9A] ( #$0010, &code_0FE34F, &code_0FE360, &code_0FE371 )
}

code_0FE34F {
    COP [B0] ( @code_0FE3E8, #$0200 )
    BRK #$41
    COP [80] ( #2E )
    COP [82]
    BRL loc_0FE2AC
}

code_0FE360 {
    COP [B0] ( @code_0FE3F6, #$0200 )
    BRK #$41
    COP [80] ( #30 )
    COP [82]
    BRL loc_0FE2AC
}

code_0FE371 {
    COP [B0] ( @code_0FE3EF, #$0200 )
    BRK #$41
    COP [80] ( #2F )
    COP [82]
    BRL loc_0FE2AC
}

code_0FE382 {
    COP [9A] ( #$0010, &code_0FE38C, &code_0FE39D, &code_0FE3AE )
}

code_0FE38C {
    COP [B0] ( @code_0FE3D3, #$0200 )
    BRK #$41
    COP [80] ( #26 )
    COP [82]
    BRL loc_0FE2AC
}

code_0FE39D {
    COP [B0] ( @code_0FE3E1, #$0200 )
    BRK #$41
    COP [80] ( #28 )
    COP [82]
    BRL loc_0FE2AC
}

code_0FE3AE {
    COP [B0] ( @code_0FE3DA, #$0200 )
    BRK #$41
    COP [80] ( #27 )
    COP [82]
    BRL loc_0FE2AC
}

code_0FE3BF {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #3E )
    COP [82]
    COP [1B] ( &code_0FE236, #$003C )
}

code_0FE3D3 {
    COP [80] ( #29 )
    COP [82]
    BRA loc_0FE410
}

code_0FE3DA {
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FE410
}

code_0FE3E1 {
    COP [80] ( #2B )
    COP [82]
    BRA loc_0FE410
}

code_0FE3E8 {
    COP [80] ( #2E )
    COP [82]
    BRA loc_0FE410
}

code_0FE3EF {
    COP [80] ( #2F )
    COP [82]
    BRA loc_0FE410
}

code_0FE3F6 {
    COP [80] ( #30 )
    COP [82]
    BRA loc_0FE410
}

code_0FE3FD {
    COP [80] ( #39 )
    COP [82]
    BRA loc_0FE410
}

code_0FE404 {
    COP [80] ( #3A )
    COP [82]
    BRA loc_0FE410
}

code_0FE40B {
    COP [80] ( #3B )
    COP [82]

  loc_0FE410:
    COP [86]
    RTL 
}