?BANK 1F

---------------------------------------------

code_0FDBFB {
    COP [A2] ( #20 )

  code_0FDBFE:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDC0C

  code_0FDC06:
    COP [1B] ( &code_0FDBFE, #$0020 )

  loc_0FDC0C:
    COP [9A] ( #$0010, &code_0FDC16, &code_0FDC20, &code_0FDC16 )
}

code_0FDC16 {
    COP [9B] ( #$0010, &code_0FDC06, &code_0FDC2A, &code_0FDC06 )
}

code_0FDC20 {
    COP [9B] ( #$0000, &code_0FDC70, &code_0FDC8F, &code_0FDC8F )
}

code_0FDC2A {
    COP [9A] ( #$0000, &code_0FDC34, &code_0FDC52, &code_0FDC52 )
}

code_0FDC34 {
    COP [97]
    COP [80] ( #27 )
    COP [82]
    COP [B2] ( @code_0FDCAE, #$FFF8, #$FFF8, #$0300 )
    COP [80] ( #29 )
    COP [82]
    COP [80] ( #26 )
    COP [82]
    BRA code_0FDC06
}

code_0FDC52 {
    COP [96]
    COP [80] ( #27 )
    COP [82]
    COP [B2] ( @code_0FDCBB, #$0008, #$FFF8, #$0300 )
    COP [80] ( #29 )
    COP [82]
    COP [80] ( #26 )
    COP [82]
    BRA code_0FDC06
}

code_0FDC70 {
    COP [97]
    COP [80] ( #23 )
    COP [82]
    COP [B2] ( @code_0FDCC8, #$0000, #$FFF0, #$0300 )
    COP [80] ( #25 )
    COP [82]
    COP [80] ( #22 )
    COP [82]
    BRL code_0FDC06
}

code_0FDC8F {
    COP [97]
    COP [80] ( #1F )
    COP [82]
    COP [B2] ( @code_0FDCD5, #$0000, #$FFF8, #$0300 )
    COP [80] ( #21 )
    COP [82]
    COP [80] ( #1E )
    COP [82]
    BRL code_0FDC06
}

code_0FDCAE {
    COP [97]
    COP [A3]
    BRK #$52
    COP [80] ( #28 )
    COP [82]
    BRA loc_0FDCE0
}

code_0FDCBB {
    COP [96]
    COP [A3]
    BRK #$52
    COP [80] ( #28 )
    COP [82]
    BRA loc_0FDCE0
}

code_0FDCC8 {
    COP [97]
    COP [A3]
    BRK #$52
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FDCE0
}

code_0FDCD5 {
    COP [97]
    COP [A3]
    BRK #$52
    COP [80] ( #20 )
    COP [82]

  loc_0FDCE0:
    LDA $0016, X
    AND #$FEFF
    STA $0016, X
    COP [A2] ( #30 )
    COP [A1] ( #$FFF8, #$0008 )
    BRK #$61
    COP [80] ( #2A )
    COP [82]
    COP [86]
    RTL 
}