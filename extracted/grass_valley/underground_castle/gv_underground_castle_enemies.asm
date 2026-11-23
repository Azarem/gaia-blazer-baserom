?BANK 1F

?INCLUDE 'shared_actor_helpers_bank0'

!rng_state                      0301

---------------------------------------------

code_0FAA8F {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAA9D

  code_0FAA97:
    COP [1B] ( &code_0FAA8F, #$0008 )

  loc_0FAA9D:
    COP [9A] ( #$0010, &code_0FAAA7, &code_0FAAB9, &code_0FAAB0 )
}

code_0FAAA7 {
    COP [97]
    COP [80] ( #0D )
    COP [82]
    BRA code_0FAAF3
}

code_0FAAB0 {
    COP [96]
    COP [80] ( #0D )
    COP [82]
    BRA code_0FAAF3
}

code_0FAAB9 {
    COP [9B] ( #$0010, &code_0FAAC3, &code_0FAAF3, &code_0FAADB )
}

code_0FAAC3 {
    COP [97]
    COP [80] ( #0C )
    COP [82]
    COP [80] ( #10 )
    COP [82]
    COP [85] ( @code_0FAB61 )
    COP [80] ( #36 )
    COP [82]
    BRA code_0FAAF3
}

code_0FAADB {
    COP [97]
    COP [80] ( #0A )
    COP [82]
    COP [80] ( #0F )
    COP [82]
    COP [85] ( @code_0FAB6C )
    COP [80] ( #35 )
    COP [82]
    BRA code_0FAAF3
}

code_0FAAF3 {
    COP [9B] ( #$0010, &code_0FAAFD, &code_0FAB0F, &code_0FAB06 )
}

code_0FAAFD {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    BRA code_0FAA8F
}

code_0FAB06 {
    COP [97]
    COP [80] ( #09 )
    COP [82]
    BRA code_0FAA8F
}

code_0FAB0F {
    COP [9A] ( #$0010, &code_0FAB19, &code_0FAA97, &code_0FAB32 )
}

code_0FAB19 {
    COP [97]
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    COP [85] ( @code_0FAB4B )
    COP [80] ( #37 )
    COP [82]
    BRL code_0FAA97
}

code_0FAB32 {
    COP [96]
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    COP [85] ( @code_0FAB4B )
    COP [80] ( #37 )
    COP [82]
    BRL code_0FAA97
}

code_0FAB4B {
    COP [A1] ( #$FFFF, #$0002 )
    LDA #$0025
    BRA loc_0FAB75

  loc_0FAB56:
    COP [A1] ( #$0001, #$0002 )
    LDA #$0025
    BRA loc_0FAB75
}

code_0FAB61 {
    COP [A1] ( #$0004, #$FFF3 )
    LDA #$0026
    BRA loc_0FAB75
}

code_0FAB6C {
    COP [A1] ( #$FFFD, #$0002 )
    LDA #$0027

  loc_0FAB75:
    STA $001E, X
    STZ $0020, X
    LDA #$000C
    STA $002A, X
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [A2] ( #30 )
    BRK #$5B
    COP [91]
    COP [83]
    COP [80] ( #24 )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

code_0FAB9A {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FABA8
    COP [1B] ( &code_0FAB9A, #$0010 )

  loc_0FABA8:
    COP [0C] ( #00, #05, &code_0FABB5 )
    COP [80] ( #1B )
    COP [82]
    BRA code_0FAB9A
}

code_0FABB5 {
    COP [9A] ( #$0010, &code_0FABBF, &code_0FABFB, &code_0FABC9 )
}

code_0FABBF {
    COP [9B] ( #$0010, &code_0FABE7, &code_0FAC1F, &code_0FABF1 )
}

code_0FABC9 {
    COP [9B] ( #$0010, &code_0FABD3, &code_0FAC15, &code_0FABDD )
}

code_0FABD3 {
    COP [96]
    COP [81] ( #1E, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FABDD {
    COP [96]
    COP [81] ( #1D, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FABE7 {
    COP [97]
    COP [81] ( #1E, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FABF1 {
    COP [97]
    COP [81] ( #1D, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FABFB {
    COP [9B] ( #$0000, &code_0FAC0D, &code_0FAC0D, &code_0FAC05 )
}

code_0FAC05 {
    COP [81] ( #34, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FAC0D {
    COP [81] ( #1A, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FAC15 {
    COP [96]
    COP [81] ( #1C, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FAC1F {
    COP [97]
    COP [81] ( #1C, #10 )
    COP [83]
    BRA loc_0FAC29

  loc_0FAC29:
    COP [80] ( #1B )
    COP [82]
    BRL code_0FAB9A
}
---------------------------------------------

code_0FAC31 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAC3F

  code_0FAC39:
    COP [1B] ( &code_0FAC31, #$0010 )

  loc_0FAC3F:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FAC52
    DEC 
    BEQ loc_0FAC5B
    DEC 
    BEQ loc_0FAC64
    DEC 
    BEQ loc_0FAC6F

  loc_0FAC52:
    COP [9D] ( #14 )
    COP [9E] ( &code_0FAC39 )

  loc_0FAC59:
    BRA code_0FAC31

  loc_0FAC5B:
    COP [9D] ( #12 )
    COP [9E] ( &code_0FAC39 )

  loc_0FAC62:
    BRA code_0FAC31

  loc_0FAC64:
    COP [96]
    COP [9D] ( #16 )
    COP [9E] ( &code_0FAC39 )

  loc_0FAC6D:
    BRA code_0FAC31

  loc_0FAC6F:
    COP [97]
    COP [9D] ( #16 )
    COP [9E] ( &code_0FAC39 )

  loc_0FAC78:
    BRA code_0FAC31
}
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
---------------------------------------------

code_0FACF2 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAD00
    COP [1B] ( &code_0FACF2, #$0008 )

  loc_0FAD00:
    COP [81] ( #18, #08 )
    COP [83]
    COP [80] ( #19 )
    COP [82]
    COP [B0] ( @code_0FAD14, #$0200 )
    BRA code_0FACF2
}

code_0FAD14 {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$64
    LDY #$001F
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.code_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.code_002D67-1
    PHA 
    RTL 
}