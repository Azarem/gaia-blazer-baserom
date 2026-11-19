?BANK 1F

---------------------------------------------

code_0FEB95 {
    COP [AD] ( #10 )

  loc_0FEB98:
    COP [9A] ( #$0018, &code_0FEBA2, &code_0FEBB6, &code_0FEBAC )
}

code_0FEBA2 {
    COP [9B] ( #$0018, &code_0FEBC4, &code_0FECA3, &code_0FEBFD )
}

code_0FEBAC {
    COP [9B] ( #$0018, &code_0FEBC0, &code_0FEC9F, &code_0FEBF9 )
}

code_0FEBB6 {
    COP [9B] ( #$0000, &code_0FEC69, &code_0FEC33, &code_0FEC33 )
}

code_0FEBC0 {
    COP [96]
    BRA loc_0FEBC6
}

code_0FEBC4 {
    COP [97]

  loc_0FEBC6:
    COP [80] ( #26 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #27 )
    COP [82]
    COP [81] ( #28, #04 )
    COP [83]
    COP [80] ( #27 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #19 )
    COP [82]
    BRA loc_0FEB98
}

code_0FEBF9 {
    COP [96]
    BRA loc_0FEBFF
}

code_0FEBFD {
    COP [97]

  loc_0FEBFF:
    COP [80] ( #23 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #24 )
    COP [82]
    COP [81] ( #25, #04 )
    COP [83]
    COP [80] ( #24 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #23 )
    COP [82]
    COP [80] ( #18 )
    COP [82]
    BRL loc_0FEB98
}

code_0FEC33 {
    COP [97]
    COP [80] ( #1A )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #1B )
    COP [82]
    COP [81] ( #1C, #04 )
    COP [83]
    COP [80] ( #1B )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #1A )
    COP [82]
    COP [80] ( #15 )
    COP [82]
    BRL loc_0FEB98
}

code_0FEC69 {
    COP [97]
    COP [80] ( #1D )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #1E )
    COP [82]
    COP [81] ( #1F, #04 )
    COP [83]
    COP [80] ( #1E )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #16 )
    COP [82]
    BRL loc_0FEB98
}

code_0FEC9F {
    COP [96]
    BRA loc_0FECA5
}

code_0FECA3 {
    COP [97]

  loc_0FECA5:
    COP [80] ( #20 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #21 )
    COP [82]
    COP [81] ( #22, #04 )
    COP [83]
    COP [80] ( #21 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #17 )
    COP [82]
    BRL loc_0FEB98
}