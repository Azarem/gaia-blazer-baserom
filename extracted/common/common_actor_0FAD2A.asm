?BANK 1F

---------------------------------------------

code_0FAD2A {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAD38
    COP [1B] ( &code_0FAD2A, #$0010 )

  loc_0FAD38:
    COP [9A] ( #$0010, &code_0FAD42, &code_0FAE1B, &code_0FAD42 )
}

code_0FAD42 {
    COP [9B] ( #$0010, &code_0FAD4C, &code_0FAE53, &code_0FAD4C )
}

code_0FAD4C {
    COP [9C] ( &code_0FAD52, &code_0FADB1 )
}

code_0FAD52 {
    COP [9A] ( #$0010, &code_0FAD5C, &code_0FAE07, &code_0FAD7B )
}

code_0FAD5C {
    COP [23] ( &code_0FADA1 )
    COP [80] ( #14 )
    COP [82]
    COP [9A] ( #$0010, &code_0FAD6F, &code_0FAE1B, &code_0FAD6F )
}

code_0FAD6F {
    COP [23] ( &code_0FADA1 )
    COP [80] ( #0E )
    COP [82]
    BRL code_0FAE07
}

code_0FAD7B {
    COP [24] ( &code_0FADA1 )
    COP [96]
    COP [80] ( #14 )
    COP [82]
    COP [97]
    COP [9A] ( #$0010, &code_0FAD92, &code_0FAE1B, &code_0FAD92 )
}

code_0FAD92 {
    COP [24] ( &code_0FADA1 )
    COP [96]
    COP [80] ( #0E )
    COP [82]
    COP [97]
    BRA code_0FAE07
}

code_0FADA1 {
    COP [1B] ( &code_0FADA7, #$0000 )
}

code_0FADA7 {
    COP [9B] ( #$0000, &code_0FADBB, &code_0FADD9, &code_0FADD9 )
}

code_0FADB1 {
    COP [9B] ( #$0010, &code_0FADBB, &code_0FAE07, &code_0FADD9 )
}

code_0FADBB {
    COP [21] ( &code_0FADF7 )
    COP [80] ( #13 )
    COP [82]
    COP [9B] ( #$0010, &code_0FADCE, &code_0FAE53, &code_0FADCE )
}

code_0FADCE {
    COP [21] ( &code_0FADF7 )
    COP [80] ( #0D )
    COP [82]
    BRA code_0FAE07
}

code_0FADD9 {
    COP [22] ( &code_0FADF7 )
    COP [80] ( #12 )
    COP [82]
    COP [9B] ( #$0010, &code_0FADEC, &code_0FAE53, &code_0FADEC )
}

code_0FADEC {
    COP [22] ( &code_0FADF7 )
    COP [80] ( #0C )
    COP [82]
    BRA code_0FAE07
}

code_0FADF7 {
    COP [1B] ( &code_0FADFD, #$0000 )
}

code_0FADFD {
    COP [9A] ( #$0000, &code_0FAD5C, &code_0FAD7B, &code_0FAD7B )
}

code_0FAE07 {
    COP [9A] ( #$0010, &code_0FAE11, &code_0FAE1B, &code_0FAE11 )
}

code_0FAE11 {
    COP [9B] ( #$0010, &code_0FAD2A, &code_0FAE53, &code_0FAD2A )
}

code_0FAE1B {
    COP [9B] ( #$0000, &code_0FAE25, &code_0FAE3C, &code_0FAE3C )
}

code_0FAE25 {
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #16 )
    COP [82]
    COP [85] ( @code_0FAEAF )
    COP [80] ( #10 )
    COP [82]
    BRL code_0FAD2A
}

code_0FAE3C {
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #15 )
    COP [82]
    COP [85] ( @code_0FAEBA )
    COP [80] ( #0F )
    COP [82]
    BRL code_0FAD2A
}

code_0FAE53 {
    COP [9A] ( #$0000, &code_0FAE5D, &code_0FAE74, &code_0FAE74 )
}

code_0FAE5D {
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #17 )
    COP [82]
    COP [85] ( @code_0FAE8F )
    COP [80] ( #11 )
    COP [82]
    BRL code_0FAD2A
}

code_0FAE74 {
    COP [96]
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #17 )
    COP [82]
    COP [85] ( @code_0FAE8F )
    COP [80] ( #11 )
    COP [82]
    COP [97]
    BRL code_0FAD2A
}

code_0FAE8F {
    COP [A1] ( #$FFFF, #$FFF8 )
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [A2] ( #30 )
    BRK #$5B

  loc_0FAEA2:
    COP [80] ( #26 )
    COP [82]
    COP [1C] ( #$8000, &code_0FAEE2 )
    BRA loc_0FAEA2
}

code_0FAEAF {
    COP [A1] ( #$0004, #$FFF1 )
    LDA #$0025
    BRA loc_0FAEC3
}

code_0FAEBA {
    COP [A1] ( #$FFFC, #$FFF8 )
    LDA #$0024

  loc_0FAEC3:
    STA $001E, X
    STZ $0020, X
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [A2] ( #30 )
    BRK #$5B
    COP [91]

  loc_0FAED8:
    COP [82]
    COP [1C] ( #$8000, &code_0FAEE2 )
    BRA loc_0FAED8
}

code_0FAEE2 {
    COP [86]
    RTL 
}