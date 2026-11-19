?BANK 1F

---------------------------------------------

code_0FAF44 {
    COP [A2] ( #30 )
    COP [A3]

  code_0FAF49:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAF57
    COP [1B] ( &code_0FAF49, #$0010 )

  loc_0FAF57:
    COP [9C] ( &code_0FAF5D, &code_0FAF85 )
}

code_0FAF5D {
    COP [9A] ( #$0010, &code_0FAF67, &code_0FAF74, &code_0FAF74 )
}

code_0FAF67 {
    COP [81] ( #1C, #02 )
    COP [83]
    COP [80] ( #1D )
    COP [82]
    BRA loc_0FAF57
}

code_0FAF74 {
    COP [96]
    COP [81] ( #1C, #02 )
    COP [83]
    COP [80] ( #1D )
    COP [82]
    COP [97]
    BRA loc_0FAF57
}

code_0FAF85 {
    COP [9B] ( #$0010, &code_0FAF8F, &code_0FAF9C, &code_0FAF9C )
}

code_0FAF8F {
    COP [81] ( #1A, #02 )
    COP [83]
    COP [80] ( #1B )
    COP [82]
    BRA loc_0FAF57
}

code_0FAF9C {
    COP [96]
    COP [81] ( #18, #02 )
    COP [83]
    COP [80] ( #19 )
    COP [82]
    COP [97]
    BRA loc_0FAF57
}