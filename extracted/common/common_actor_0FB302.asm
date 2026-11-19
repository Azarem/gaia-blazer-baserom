?BANK 1F

---------------------------------------------

code_0FB302 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB310

  code_0FB30A:
    COP [1B] ( &code_0FB302, #$0002 )

  loc_0FB310:
    COP [9A] ( #$0010, &code_0FB31A, &code_0FB32C, &code_0FB323 )
}

code_0FB31A {
    COP [97]
    COP [80] ( #26 )
    COP [82]
    BRA code_0FB32C
}

code_0FB323 {
    COP [96]
    COP [80] ( #26 )
    COP [82]
    BRA code_0FB32C
}

code_0FB32C {
    COP [9B] ( #$0010, &code_0FB336, &code_0FB30A, &code_0FB33F )
}

code_0FB336 {
    COP [97]
    COP [80] ( #25 )
    COP [82]
    BRA code_0FB302
}

code_0FB33F {
    COP [97]
    COP [80] ( #24 )
    COP [82]
    BRA code_0FB302
}