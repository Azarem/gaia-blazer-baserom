?BANK 1F

---------------------------------------------

code_0FBB1F {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FBB2D
    COP [1B] ( &code_0FBB1F, #$0010 )

  loc_0FBB2D:
    COP [0C] ( #00, #05, &code_0FBB3A )
    COP [80] ( #04 )
    COP [82]
    BRA code_0FBB1F
}

code_0FBB3A {
    COP [9C] ( &code_0FBB40, &code_0FBB5C )
}

code_0FBB40 {
    COP [9A] ( #$0000, &code_0FBB4A, &code_0FBB53, &code_0FBB53 )
}

code_0FBB4A {
    COP [97]
    COP [80] ( #07 )
    COP [82]
    BRA code_0FBB1F
}

code_0FBB53 {
    COP [96]
    COP [80] ( #07 )
    COP [82]
    BRA code_0FBB1F
}

code_0FBB5C {
    COP [9B] ( #$0000, &code_0FBB66, &code_0FBB6F, &code_0FBB6F )
}

code_0FBB66 {
    COP [97]
    COP [80] ( #06 )
    COP [82]
    BRA code_0FBB1F
}

code_0FBB6F {
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FBB1F
}