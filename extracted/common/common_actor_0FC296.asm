?BANK 1F

---------------------------------------------

code_0FC296 {
    COP [AA] ( #02 )

  code_0FC299:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC2A7

  code_0FC2A1:
    COP [1B] ( &code_0FC299, #$0008 )

  loc_0FC2A7:
    COP [9A] ( #$0010, &code_0FC2B1, &code_0FC2C3, &code_0FC2BA )
}

code_0FC2B1 {
    COP [97]
    COP [80] ( #13 )
    COP [82]
    BRA code_0FC303
}

code_0FC2BA {
    COP [96]
    COP [80] ( #13 )
    COP [82]
    BRA code_0FC303
}

code_0FC2C3 {
    COP [9B] ( #$0010, &code_0FC2CD, &code_0FC303, &code_0FC2E8 )
}

code_0FC2CD {
    COP [97]
    COP [81] ( #0F, #02 )
    COP [83]
    COP [81] ( #15, #02 )
    COP [83]
    COP [85] ( @code_0FC39C )
    COP [81] ( #0F, #02 )
    COP [83]
    BRA code_0FC303
}

code_0FC2E8 {
    COP [97]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [81] ( #14, #02 )
    COP [83]
    COP [85] ( @code_0FC3B9 )
    COP [81] ( #0E, #02 )
    COP [83]
    BRA code_0FC303
}

code_0FC303 {
    COP [9B] ( #$0010, &code_0FC30D, &code_0FC320, &code_0FC316 )
}

code_0FC30D {
    COP [97]
    COP [80] ( #12 )
    COP [82]
    BRA code_0FC299
}

code_0FC316 {
    COP [97]
    COP [80] ( #11 )
    COP [82]
    BRL code_0FC299
}

code_0FC320 {
    COP [9A] ( #$0010, &code_0FC32A, &code_0FC2A1, &code_0FC346 )
}

code_0FC32A {
    COP [97]
    COP [81] ( #10, #02 )
    COP [83]
    COP [81] ( #16, #02 )
    COP [83]
    COP [85] ( @code_0FC362 )
    COP [81] ( #10, #02 )
    COP [83]
    BRL code_0FC2A1
}

code_0FC346 {
    COP [96]
    COP [81] ( #10, #02 )
    COP [83]
    COP [81] ( #16, #02 )
    COP [83]
    COP [85] ( @code_0FC37F )
    COP [81] ( #10, #02 )
    COP [83]
    BRL code_0FC2A1
}

code_0FC362 {
    JSR $&code_0FC3D6
    COP [80] ( #1B )
    COP [82]
    COP [A6]

  loc_0FC36C:
    COP [23] ( &code_0FC377 )
    COP [80] ( #37 )
    COP [82]
    BRA loc_0FC36C
}

code_0FC377 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC37F {
    JSR $&code_0FC3D6
    COP [80] ( #1B )
    COP [82]
    COP [A6]

  loc_0FC389:
    COP [24] ( &code_0FC394 )
    COP [80] ( #37 )
    COP [82]
    BRA loc_0FC389
}

code_0FC394 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC39C {
    JSR $&code_0FC3D6
    COP [80] ( #19 )
    COP [82]
    COP [A6]

  loc_0FC3A6:
    COP [21] ( &code_0FC3B1 )
    COP [80] ( #36 )
    COP [82]
    BRA loc_0FC3A6
}

code_0FC3B1 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC3B9 {
    JSR $&code_0FC3D6
    COP [80] ( #17 )
    COP [82]
    COP [A6]

  loc_0FC3C3:
    COP [22] ( &code_0FC3CE )
    COP [80] ( #35 )
    COP [82]
    BRA loc_0FC3C3
}

code_0FC3CE {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC3D6 {
    LDA #$0202
    STA $0016, X
    COP [AA] ( #02 )
    COP [A3]
    COP [A0] ( #$FFEE )
    BRK #$61
    RTS 
}