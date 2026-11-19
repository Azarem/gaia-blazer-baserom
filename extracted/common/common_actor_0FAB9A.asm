?BANK 1F

---------------------------------------------

code_0FAB9A {
    LDA $0016, X          ; {1026970}
    BIT #$8000            ; {1026973}
    BEQ loc_0FABA8        ; {1026976}
    COP [1B] ( &code_0FAB9A, #$0010 ) ; {1026978}

  loc_0FABA8:
    COP [0C] ( #00, #05, &code_0FABB5 ) ; {1026984}
    COP [80] ( #1B )      ; {1026990}
    COP [82]              ; {1026993}
    BRA code_0FAB9A       ; {1026995}
}

code_0FABB5 {
    COP [9A] ( #$0010, &code_0FABBF, &code_0FABFB, &code_0FABC9 ) ; {1026997}
}

code_0FABBF {
    COP [9B] ( #$0010, &code_0FABE7, &code_0FAC1F, &code_0FABF1 ) ; {1027007}
}

code_0FABC9 {
    COP [9B] ( #$0010, &code_0FABD3, &code_0FAC15, &code_0FABDD ) ; {1027017}
}

code_0FABD3 {
    COP [96]              ; {1027027}
    COP [81] ( #1E, #10 ) ; {1027029}
    COP [83]              ; {1027033}
    BRA loc_0FAC29        ; {1027035}
}

code_0FABDD {
    COP [96]              ; {1027037}
    COP [81] ( #1D, #10 ) ; {1027039}
    COP [83]              ; {1027043}
    BRA loc_0FAC29        ; {1027045}
}

code_0FABE7 {
    COP [97]              ; {1027047}
    COP [81] ( #1E, #10 ) ; {1027049}
    COP [83]              ; {1027053}
    BRA loc_0FAC29        ; {1027055}
}

code_0FABF1 {
    COP [97]              ; {1027057}
    COP [81] ( #1D, #10 ) ; {1027059}
    COP [83]              ; {1027063}
    BRA loc_0FAC29        ; {1027065}
}

code_0FABFB {
    COP [9B] ( #$0000, &code_0FAC0D, &code_0FAC0D, &code_0FAC05 ) ; {1027067}
}

code_0FAC05 {
    COP [81] ( #34, #10 ) ; {1027077}
    COP [83]              ; {1027081}
    BRA loc_0FAC29        ; {1027083}
}

code_0FAC0D {
    COP [81] ( #1A, #10 ) ; {1027085}
    COP [83]              ; {1027089}
    BRA loc_0FAC29        ; {1027091}
}

code_0FAC15 {
    COP [96]              ; {1027093}
    COP [81] ( #1C, #10 ) ; {1027095}
    COP [83]              ; {1027099}
    BRA loc_0FAC29        ; {1027101}
}

code_0FAC1F {
    COP [97]              ; {1027103}
    COP [81] ( #1C, #10 ) ; {1027105}
    COP [83]              ; {1027109}
    BRA loc_0FAC29        ; {1027111}

  loc_0FAC29:
    COP [80] ( #1B )      ; {1027113}
    COP [82]              ; {1027116}
    BRL code_0FAB9A       ; {1027118}
}