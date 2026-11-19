?BANK 1F

---------------------------------------------

code_0FC0E5 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC0F3
    COP [1B] ( &code_0FC0E5, #$0010 )

  loc_0FC0F3:
    COP [0C] ( #00, #04, &code_0FC100 )

  code_0FC0F9:
    COP [80] ( #1D )
    COP [82]
    BRA code_0FC0E5
}

code_0FC100 {
    COP [9C] ( &code_0FC106, &code_0FC12A )
}

code_0FC106 {
    COP [9A] ( #$0010, &code_0FC110, &code_0FC11D, &code_0FC11D )
}

code_0FC110 {
    COP [23] ( &code_0FC0F9 )
    COP [97]
    COP [80] ( #20 )
    COP [82]
    BRA code_0FC0F9
}

code_0FC11D {
    COP [24] ( &code_0FC0F9 )
    COP [96]
    COP [80] ( #20 )
    COP [82]
    BRA code_0FC0F9
}

code_0FC12A {
    COP [9B] ( #$0010, &code_0FC134, &code_0FC141, &code_0FC141 )
}

code_0FC134 {
    COP [21] ( &code_0FC0F9 )
    COP [97]
    COP [80] ( #1F )
    COP [82]
    BRA code_0FC0F9
}

code_0FC141 {
    COP [22] ( &code_0FC0F9 )
    COP [97]
    COP [80] ( #1E )
    COP [82]
    BRA code_0FC0F9
}