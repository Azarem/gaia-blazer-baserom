?BANK 1F

---------------------------------------------

code_0FB695 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB6A3
    COP [1B] ( &code_0FB695, #$0010 )

  loc_0FB6A3:
    COP [0C] ( #00, #06, &code_0FB6B0 )
    COP [80] ( #1A )
    COP [82]
    BRA code_0FB695
}

code_0FB6B0 {
    COP [80] ( #1B )
    COP [82]
    COP [A3]
    COP [A2] ( #30 )

  loc_0FB6BA:
    COP [9C] ( &code_0FB6C0, &code_0FB6DC )
}

code_0FB6C0 {
    COP [9A] ( #$0000, &code_0FB6CA, &code_0FB6D3, &code_0FB6D3 )
}

code_0FB6CA {
    COP [97]
    COP [80] ( #1E )
    COP [82]
    BRA loc_0FB6BA
}

code_0FB6D3 {
    COP [96]
    COP [80] ( #1E )
    COP [82]
    BRA loc_0FB6BA
}

code_0FB6DC {
    COP [9B] ( #$0000, &code_0FB6E6, &code_0FB6EF, &code_0FB6EF )
}

code_0FB6E6 {
    COP [97]
    COP [80] ( #1D )
    COP [82]
    BRA loc_0FB6BA
}

code_0FB6EF {
    COP [97]
    COP [80] ( #1C )
    COP [82]
    BRA loc_0FB6BA
}