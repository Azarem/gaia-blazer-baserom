?BANK 1F

---------------------------------------------

code_0FBB1F {
    LDA $0016, X          ; {1030943}
    BIT #$8000            ; {1030946}
    BEQ loc_0FBB2D        ; {1030949}
    COP [1B] ( &code_0FBB1F, #$0010 ) ; {1030951}

  loc_0FBB2D:
    COP [0C] ( #00, #05, &code_0FBB3A ) ; {1030957}
    COP [80] ( #04 )      ; {1030963}
    COP [82]              ; {1030966}
    BRA code_0FBB1F       ; {1030968}
}

code_0FBB3A {
    COP [9C] ( &code_0FBB40, &code_0FBB5C ) ; {1030970}
}

code_0FBB40 {
    COP [9A] ( #$0000, &code_0FBB4A, &code_0FBB53, &code_0FBB53 ) ; {1030976}
}

code_0FBB4A {
    COP [97]              ; {1030986}
    COP [80] ( #07 )      ; {1030988}
    COP [82]              ; {1030991}
    BRA code_0FBB1F       ; {1030993}
}

code_0FBB53 {
    COP [96]              ; {1030995}
    COP [80] ( #07 )      ; {1030997}
    COP [82]              ; {1031000}
    BRA code_0FBB1F       ; {1031002}
}

code_0FBB5C {
    COP [9B] ( #$0000, &code_0FBB66, &code_0FBB6F, &code_0FBB6F ) ; {1031004}
}

code_0FBB66 {
    COP [97]              ; {1031014}
    COP [80] ( #06 )      ; {1031016}
    COP [82]              ; {1031019}
    BRA code_0FBB1F       ; {1031021}
}

code_0FBB6F {
    COP [97]              ; {1031023}
    COP [80] ( #05 )      ; {1031025}
    COP [82]              ; {1031028}
    BRA code_0FBB1F       ; {1031030}
}