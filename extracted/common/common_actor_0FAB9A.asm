?BANK 1F

---------------------------------------------

code_0FAB9A {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FABA8
    COP [1B] ( &code_0FAB9A, #$0010 )

  loc_0FABA8:
    COP [0C] ( #00, #05, &code_0FABB5 )
    COP [80] ( #1B )
    COP [82]
    BRA code_0FAB9A
}

code_0FABB5 {
    COP [9A] ( #$0010, &code_0FABBF, &code_0FABFB, &code_0FABC9 )
}

code_0FABBF {
    COP [9B] ( #$0010, &code_0FABE7, &code_0FAC1F, &code_0FABF1 )
}

code_0FABC9 {
    COP [9B] ( #$0010, &code_0FABD3, &code_0FAC15, &code_0FABDD )
}

code_0FABD3 {
    COP [96]
    COP [81] ( #1E, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FABDD {
    COP [96]
    COP [81] ( #1D, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FABE7 {
    COP [97]
    COP [81] ( #1E, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FABF1 {
    COP [97]
    COP [81] ( #1D, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FABFB {
    COP [9B] ( #$0000, &code_0FAC0D, &code_0FAC0D, &code_0FAC05 )
}

code_0FAC05 {
    COP [81] ( #34, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FAC0D {
    COP [81] ( #1A, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FAC15 {
    COP [96]
    COP [81] ( #1C, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FAC1F {
    COP [97]
    COP [81] ( #1C, #10 )
    COP [83]
    BRA loc_0FAC29

  loc_0FAC29:
    COP [80] ( #1B )
    COP [82]
    BRL code_0FAB9A
}