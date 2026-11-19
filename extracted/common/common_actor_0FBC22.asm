?BANK 1F

!rng_state                      0301

---------------------------------------------

code_0FBC22 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X

  code_0FBC2B:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FBC39

  loc_0FBC33:
    COP [1B] ( &code_0FBC2B, #$001E )

  loc_0FBC39:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ code_0FBC4C
    DEC 
    BEQ code_0FBC7D
    DEC 
    BEQ code_0FBCAE
    BRL code_0FBCE0

  code_0FBC4C:
    COP [23] ( &code_0FBC7D )
    LDA $001A, X
    AND #$FBFF
    STA $001A, X
    COP [80] ( #1B )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1C )
    COP [82]
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [80] ( #1A )
    COP [82]
    BRA loc_0FBC33
}

code_0FBC7D {
    COP [24] ( &code_0FBCAE )
    LDA $001A, X
    AND #$FBFF
    STA $001A, X
    COP [80] ( #1B )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #21 )
    COP [82]
    COP [80] ( #1C )
    COP [82]
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [80] ( #1A )
    COP [82]
    BRA loc_0FBC33
}

code_0FBCAE {
    COP [21] ( &code_0FBCE0 )
    LDA $001A, X
    AND #$FBFF
    STA $001A, X
    COP [80] ( #1B )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #1C )
    COP [82]
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [80] ( #1A )
    COP [82]
    BRL loc_0FBC33
}

code_0FBCE0 {
    COP [22] ( &code_0FBC4C )
    LDA $001A, X
    AND #$FBFF
    STA $001A, X
    COP [80] ( #1B )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #1E )
    COP [82]
    COP [80] ( #1C )
    COP [82]
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [80] ( #1A )
    COP [82]
    BRL loc_0FBC33
}