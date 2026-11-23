?BANK 1F

!rng_state                      0301

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
---------------------------------------------

code_0FBBA3 {
    COP [A3]
    COP [A2] ( #30 )

  loc_0FBBA8:
    COP [AD] ( #10 )
    COP [9A] ( #$0018, &code_0FBBB5, &code_0FBBC9, &code_0FBBB5 )
}

code_0FBBB5 {
    COP [9B] ( #$0018, &code_0FBBD3, &code_0FBBBF, &code_0FBBD3 )
}

code_0FBBBF {
    COP [9A] ( #$0000, &code_0FBC01, &code_0FBC09, &code_0FBC09 )
}

code_0FBBC9 {
    COP [9B] ( #$0000, &code_0FBC11, &code_0FBC19, &code_0FBC19 )
}

code_0FBBD3 {
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FBBE5
    DEC 
    BEQ loc_0FBBEC
    DEC 
    BEQ loc_0FBBF3
    BRA loc_0FBBFA

  loc_0FBBE5:
    COP [80] ( #03 )
    COP [82]
    BRA loc_0FBBA8

  loc_0FBBEC:
    COP [80] ( #2C )
    COP [82]
    BRA loc_0FBBA8

  loc_0FBBF3:
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FBBA8

  loc_0FBBFA:
    COP [80] ( #01 )
    COP [82]
    BRA loc_0FBBA8
}

code_0FBC01 {
    COP [81] ( #2A, #02 )
    COP [83]
    BRA code_0FBBD3
}

code_0FBC09 {
    COP [81] ( #2B, #02 )
    COP [83]
    BRA code_0FBBD3
}

code_0FBC11 {
    COP [81] ( #29, #02 )
    COP [83]
    BRA code_0FBBD3
}

code_0FBC19 {
    COP [81] ( #28, #02 )
    COP [83]
    BRL code_0FBBD3
}
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
---------------------------------------------

code_0FBD12 {
    COP [A5] ( &code_0FBD1C, &code_0FBD23, &code_0FBD2A, &code_0FBD33 )
}

code_0FBD1C {
    COP [80] ( #08 )
    COP [82]
    BRA loc_0FBD38
}

code_0FBD23 {
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FBD38
}

code_0FBD2A {
    COP [96]
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FBD38
}

code_0FBD33 {
    COP [80] ( #09 )
    COP [82]

  loc_0FBD38:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FBD41, &code_0FBDC2 )
}

code_0FBD41 {
    COP [9A] ( #$0000, &code_0FBD4B, &code_0FBD86, &code_0FBD86 )
}

code_0FBD4B {
    COP [97]
    COP [80] ( #0A )
    COP [82]

  code_0FBD52:
    COP [80] ( #0D )
    COP [82]
    COP [9A] ( #$0000, &code_0FBD52, &code_0FBD61, &code_0FBD61 )
}

code_0FBD61 {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @code_0FBE44, #$FFF8, #$0008, #$0200 )
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #0A, #02 )
    COP [83]
    BRA loc_0FBD38
}

code_0FBD86 {
    COP [96]
    COP [80] ( #0A )
    COP [82]

  code_0FBD8D:
    COP [80] ( #0D )
    COP [82]
    COP [9A] ( #$0000, &code_0FBD9C, &code_0FBD9C, &code_0FBD8D )
}

code_0FBD9C {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @code_0FBE44, #$FFF8, #$0008, #$0200 )
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #0A, #02 )
    COP [83]
    BRL loc_0FBD38
}

code_0FBDC2 {
    COP [9B] ( #$0000, &code_0FBDCC, &code_0FBE08, &code_0FBE08 )
}

code_0FBDCC {
    COP [97]
    COP [80] ( #09 )
    COP [82]

  code_0FBDD3:
    COP [80] ( #0C )
    COP [82]
    COP [9B] ( #$0000, &code_0FBDD3, &code_0FBDE2, &code_0FBDE2 )
}

code_0FBDE2 {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @code_0FBE44, #$FFF8, #$0008, #$0200 )
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #09, #02 )
    COP [83]
    BRL loc_0FBD38
}

code_0FBE08 {
    COP [97]
    COP [80] ( #08 )
    COP [82]

  code_0FBE0F:
    COP [80] ( #0B )
    COP [82]
    COP [9B] ( #$0000, &code_0FBE1E, &code_0FBE1E, &code_0FBE0F )
}

code_0FBE1E {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @code_0FBE44, #$FFF8, #$0008, #$0200 )
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #08, #02 )
    COP [83]
    BRL loc_0FBD38
}

code_0FBE44 {
    COP [A3]
    COP [97]
    COP [99]
    COP [81] ( #10, #08 )
    COP [83]
    BRK #$4B
    COP [9C] ( &code_0FBE58, &code_0FBE62 )
}

code_0FBE58 {
    COP [9A] ( #$0000, &code_0FBE78, &code_0FBE76, &code_0FBE76 )
}

code_0FBE62 {
    COP [9B] ( #$0000, &code_0FBE6C, &code_0FBE6E, &code_0FBE6E )
}

code_0FBE6C {
    COP [98]
}

code_0FBE6E {
    COP [81] ( #0E, #20 )
    COP [83]
    BRA loc_0FBE7E
}

code_0FBE76 {
    COP [96]
}

code_0FBE78 {
    COP [81] ( #0F, #20 )
    COP [83]

  loc_0FBE7E:
    COP [86]
    RTL 
}
---------------------------------------------

code_0FBE81 {
    LDA $0025, X
    AND #$00FF
    STA $0030, X

  loc_0FBE8A:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FBE93, &code_0FBED3 )
}

code_0FBE93 {
    COP [9A] ( #$0000, &code_0FBE9D, &code_0FBEB8, &code_0FBEB8 )
}

code_0FBE9D {
    COP [97]
    COP [81] ( #16, #08 )
    COP [83]
    JSR $&code_0FBF13
    BCC loc_0FBE8A
    COP [81] ( #19, #04 )
    COP [83]
    COP [81] ( #13, #10 )
    COP [83]
    BRA loc_0FBE8A
}

code_0FBEB8 {
    COP [96]
    COP [81] ( #16, #08 )
    COP [83]
    JSR $&code_0FBF13
    BCC loc_0FBE8A
    COP [81] ( #19, #04 )
    COP [83]
    COP [81] ( #13, #10 )
    COP [83]
    BRA loc_0FBE8A
}

code_0FBED3 {
    COP [9B] ( #$0000, &code_0FBEDD, &code_0FBEF8, &code_0FBEF8 )
}

code_0FBEDD {
    COP [97]
    COP [81] ( #15, #08 )
    COP [83]
    JSR $&code_0FBF13
    BCC loc_0FBE8A
    COP [81] ( #18, #04 )
    COP [83]
    COP [81] ( #12, #10 )
    COP [83]
    BRA loc_0FBE8A
}

code_0FBEF8 {
    COP [97]
    COP [81] ( #14, #08 )
    COP [83]
    JSR $&code_0FBF13
    BCC loc_0FBE8A
    COP [81] ( #17, #04 )
    COP [83]
    COP [80] ( #11 )
    COP [82]
    BRL loc_0FBE8A
}

code_0FBF13 {
    LDA $0025, X
    AND #$00FF
    CMP $0030, X
    BEQ loc_0FBF23
    STA $0030, X
    SEC 
    RTS 

  loc_0FBF23:
    CLC 
    RTS 
}