?BANK 1F

---------------------------------------------

code_0FAA49 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAA57

  code_0FAA51:
    COP [1B] ( &code_0FAA49, #$0008 )

  loc_0FAA57:
    COP [9A] ( #$0010, &code_0FAA61, &code_0FAA73, &code_0FAA6A )
}

code_0FAA61 {
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FAA73
}

code_0FAA6A {
    COP [96]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FAA73
}

code_0FAA73 {
    COP [9B] ( #$0010, &code_0FAA7D, &code_0FAA51, &code_0FAA86 )
}

code_0FAA7D {
    COP [97]
    COP [80] ( #04 )
    COP [82]
    BRA code_0FAA49
}

code_0FAA86 {
    COP [97]
    COP [80] ( #03 )
    COP [82]
    BRA code_0FAA49
}