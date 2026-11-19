?BANK 1F

---------------------------------------------

code_0FAC7A {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAC88
    COP [1B] ( &code_0FAC7A, #$0020 )

  loc_0FAC88:
    COP [0C] ( #00, #05, &code_0FAC95 )
    COP [80] ( #2E )
    COP [82]
    BRA code_0FAC7A
}

code_0FAC95 {
    COP [80] ( #2F )
    COP [82]

  loc_0FAC9A:
    COP [9C] ( &code_0FACA0, &code_0FACC0 )
}

code_0FACA0 {
    COP [9A] ( #$0000, &code_0FACAA, &code_0FACDC, &code_0FACB5 )
}

code_0FACAA {
    COP [97]
    COP [9D] ( #33 )
    COP [9E] ( &code_0FACC0 )

  loc_0FACB3:
    BRA code_0FACDC
}

code_0FACB5 {
    COP [96]
    COP [9D] ( #33 )
    COP [9E] ( &code_0FACC0 )

  loc_0FACBE:
    BRA code_0FACDC
}

code_0FACC0 {
    COP [9B] ( #$0000, &code_0FACCA, &code_0FACDC, &code_0FACD3 )
}

code_0FACCA {
    COP [9D] ( #32 )
    COP [9E] ( &code_0FACA0 )

  loc_0FACD1:
    BRA code_0FACDC
}

code_0FACD3 {
    COP [9D] ( #31 )
    COP [9E] ( &code_0FACA0 )

  loc_0FACDA:
    BRA code_0FACDC
}

code_0FACDC {
    LDA $0016, X
    BIT #$8000
    BNE loc_0FACEB
    COP [80] ( #30 )
    COP [82]
    BRA loc_0FAC9A

  loc_0FACEB:
    COP [80] ( #2E )
    COP [82]
    BRA code_0FAC7A
}