?BANK 1F

---------------------------------------------

code_0FC3E8 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [AA] ( #04 )

  code_0FC3F4:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC402

  code_0FC3FC:
    COP [1B] ( &code_0FC3F4, #$0008 )

  loc_0FC402:
    COP [9A] ( #$0010, &code_0FC40C, &code_0FC41E, &code_0FC415 )
}

code_0FC40C {
    COP [97]
    COP [80] ( #13 )
    COP [82]
    BRA code_0FC458
}

code_0FC415 {
    COP [96]
    COP [80] ( #13 )
    COP [82]
    BRA code_0FC458
}

code_0FC41E {
    COP [9B] ( #$0010, &code_0FC428, &code_0FC458, &code_0FC440 )
}

code_0FC428 {
    COP [97]
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #15 )
    COP [82]
    COP [85] ( @code_0FC4EA )
    COP [80] ( #0F )
    COP [82]
    BRA code_0FC458
}

code_0FC440 {
    COP [97]
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #14 )
    COP [82]
    COP [85] ( @code_0FC507 )
    COP [80] ( #0E )
    COP [82]
    BRA code_0FC458
}

code_0FC458 {
    COP [9B] ( #$0010, &code_0FC462, &code_0FC474, &code_0FC46B )
}

code_0FC462 {
    COP [97]
    COP [80] ( #12 )
    COP [82]
    BRA code_0FC3F4
}

code_0FC46B {
    COP [97]
    COP [80] ( #11 )
    COP [82]
    BRA code_0FC3F4
}

code_0FC474 {
    COP [9A] ( #$0010, &code_0FC47E, &code_0FC3FC, &code_0FC497 )
}

code_0FC47E {
    COP [97]
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #16 )
    COP [82]
    COP [85] ( @code_0FC4B0 )
    COP [80] ( #10 )
    COP [82]
    BRL code_0FC3FC
}

code_0FC497 {
    COP [96]
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #16 )
    COP [82]
    COP [85] ( @code_0FC4CD )
    COP [80] ( #10 )
    COP [82]
    BRL code_0FC3FC
}

code_0FC4B0 {
    JSR $&code_0FC524
    COP [80] ( #1B )
    COP [82]
    COP [A6]

  loc_0FC4BA:
    COP [23] ( &code_0FC4C5 )
    COP [80] ( #37 )
    COP [82]
    BRA loc_0FC4BA
}

code_0FC4C5 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC4CD {
    JSR $&code_0FC524
    COP [80] ( #1B )
    COP [82]
    COP [A6]

  loc_0FC4D7:
    COP [24] ( &code_0FC4E2 )
    COP [80] ( #37 )
    COP [82]
    BRA loc_0FC4D7
}

code_0FC4E2 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC4EA {
    JSR $&code_0FC524
    COP [80] ( #19 )
    COP [82]
    COP [A6]

  loc_0FC4F4:
    COP [21] ( &code_0FC4FF )
    COP [80] ( #36 )
    COP [82]
    BRA loc_0FC4F4
}

code_0FC4FF {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC507 {
    JSR $&code_0FC524
    COP [80] ( #17 )
    COP [82]
    COP [A6]

  loc_0FC511:
    COP [22] ( &code_0FC51C )
    COP [80] ( #35 )
    COP [82]
    BRA loc_0FC511
}

code_0FC51C {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC524 {
    LDA #$0202
    STA $0016, X
    COP [AA] ( #04 )
    COP [A3]
    COP [A0] ( #$FFEE )
    BRK #$61
    RTS 
}