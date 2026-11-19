?BANK 1F

---------------------------------------------

code_0FDAED {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDAFB

  code_0FDAF5:
    COP [1B] ( &code_0FDAED, #$0004 )

  loc_0FDAFB:
    COP [9B] ( #$0008, &code_0FDB05, &code_0FDB1F, &code_0FDB12 )
}

code_0FDB05 {
    COP [21] ( &code_0FDB7B )
    COP [97]
    COP [80] ( #16 )
    COP [82]
    BRA code_0FDAED
}

code_0FDB12 {
    COP [22] ( &code_0FDB7B )
    COP [97]
    COP [80] ( #12 )
    COP [82]
    BRA code_0FDAED
}

code_0FDB1F {
    COP [9A] ( #$0000, &code_0FDB29, &code_0FDB4E, &code_0FDB4E )
}

code_0FDB29 {
    COP [97]
    LDA $0016, X
    ORA #$1000
    STA $0016, X
    COP [80] ( #1B )
    COP [82]
    COP [80] ( #1C )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    LDA $0016, X
    AND #$EFFF
    STA $0016, X
    BRA code_0FDB73
}

code_0FDB4E {
    COP [96]
    LDA $0016, X
    ORA #$1000
    STA $0016, X
    COP [80] ( #1B )
    COP [82]
    COP [80] ( #1C )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    LDA $0016, X
    AND #$EFFF
    STA $0016, X
    BRA code_0FDB73

  code_0FDB73:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDB81
}

code_0FDB7B {
    COP [1B] ( &code_0FDB73, #$0004 )

  loc_0FDB81:
    COP [9A] ( #$0008, &code_0FDB8B, &code_0FDBA5, &code_0FDB98 )
}

code_0FDB8B {
    COP [23] ( &code_0FDAF5 )
    COP [97]
    COP [80] ( #1A )
    COP [82]
    BRA code_0FDB73
}

code_0FDB98 {
    COP [24] ( &code_0FDAF5 )
    COP [96]
    COP [80] ( #1A )
    COP [82]
    BRA code_0FDB73
}

code_0FDBA5 {
    COP [9B] ( #$0000, &code_0FDBAF, &code_0FDBD5, &code_0FDBD5 )
}

code_0FDBAF {
    COP [97]
    LDA $0016, X
    ORA #$1000
    STA $0016, X
    COP [80] ( #17 )
    COP [82]
    COP [80] ( #18 )
    COP [82]
    COP [80] ( #19 )
    COP [82]
    LDA $0016, X
    AND #$EFFF
    STA $0016, X
    BRL code_0FDAED
}

code_0FDBD5 {
    COP [97]
    LDA $0016, X
    ORA #$1000
    STA $0016, X
    COP [80] ( #13 )
    COP [82]
    COP [80] ( #14 )
    COP [82]
    COP [80] ( #15 )
    COP [82]
    LDA $0016, X
    AND #$EFFF
    STA $0016, X
    BRL code_0FDAED
}