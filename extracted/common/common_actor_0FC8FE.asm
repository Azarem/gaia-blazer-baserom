?BANK 1F

---------------------------------------------

code_0FC8FE {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC90C

  code_0FC906:
    COP [1B] ( &code_0FC8FE, #$0004 )

  loc_0FC90C:
    COP [9B] ( #$0008, &code_0FC916, &code_0FC930, &code_0FC923 )
}

code_0FC916 {
    COP [21] ( &code_0FC964 )
    COP [97]
    COP [80] ( #04 )
    COP [82]
    BRA code_0FC8FE
}

code_0FC923 {
    COP [22] ( &code_0FC964 )
    COP [97]
    COP [80] ( #03 )
    COP [82]
    BRA code_0FC8FE
}

code_0FC930 {
    COP [9A] ( #$0000, &code_0FC93A, &code_0FC94B, &code_0FC94B )
}

code_0FC93A {
    COP [AE] ( #$FFF0, #$0000, &code_0FC964 )
    COP [97]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FC95C
}

code_0FC94B {
    COP [AE] ( #$0010, #$0000, &code_0FC964 )
    COP [96]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FC95C

  code_0FC95C:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC96A
}

code_0FC964 {
    COP [1B] ( &code_0FC95C, #$0004 )

  loc_0FC96A:
    COP [9A] ( #$0008, &code_0FC974, &code_0FC98E, &code_0FC981 )
}

code_0FC974 {
    COP [23] ( &code_0FC906 )
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FC95C
}

code_0FC981 {
    COP [24] ( &code_0FC906 )
    COP [96]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FC95C
}

code_0FC98E {
    COP [9B] ( #$0000, &code_0FC998, &code_0FC9AA, &code_0FC9AA )
}

code_0FC998 {
    COP [AE] ( #$0000, #$FFF0, &code_0FC906 )
    COP [97]
    COP [80] ( #07 )
    COP [82]
    BRL code_0FC8FE
}

code_0FC9AA {
    COP [AE] ( #$0000, #$0010, &code_0FC906 )
    COP [97]
    COP [80] ( #06 )
    COP [82]
    BRL code_0FC8FE
}