?BANK 1F

---------------------------------------------

code_0FD944 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FD952

  code_0FD94C:
    COP [1B] ( &code_0FD944, #$0004 )

  loc_0FD952:
    COP [9B] ( #$0008, &code_0FD95C, &code_0FD976, &code_0FD969 )
}

code_0FD95C {
    COP [21] ( &code_0FD99C )
    COP [97]
    COP [80] ( #04 )
    COP [82]
    BRA code_0FD944
}

code_0FD969 {
    COP [22] ( &code_0FD99C )
    COP [97]
    COP [80] ( #03 )
    COP [82]
    BRA code_0FD944
}

code_0FD976 {
    COP [9A] ( #$0000, &code_0FD980, &code_0FD98A, &code_0FD98A )
}

code_0FD980 {
    COP [97]
    COP [81] ( #02, #02 )
    COP [83]
    BRA code_0FD994
}

code_0FD98A {
    COP [96]
    COP [81] ( #02, #02 )
    COP [83]
    BRA code_0FD994

  code_0FD994:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FD9A2
}

code_0FD99C {
    COP [1B] ( &code_0FD994, #$0004 )

  loc_0FD9A2:
    COP [9A] ( #$0008, &code_0FD9AC, &code_0FD9C6, &code_0FD9B9 )
}

code_0FD9AC {
    COP [23] ( &code_0FD94C )
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FD994
}

code_0FD9B9 {
    COP [24] ( &code_0FD94C )
    COP [96]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FD994
}

code_0FD9C6 {
    COP [9B] ( #$0000, &code_0FD9D0, &code_0FD9DB, &code_0FD9DB )
}

code_0FD9D0 {
    COP [97]
    COP [81] ( #01, #02 )
    COP [83]
    BRL code_0FD944
}

code_0FD9DB {
    COP [97]
    COP [81] ( #00, #02 )
    COP [83]
    BRL code_0FD944
}
---------------------------------------------

code_0FD9E6 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FD9F4

  code_0FD9EE:
    COP [1B] ( &code_0FD9E6, #$0004 )

  loc_0FD9F4:
    COP [9B] ( #$0008, &code_0FD9FE, &code_0FDA18, &code_0FDA0B )
}

code_0FD9FE {
    COP [21] ( &code_0FDA5C )
    COP [97]
    COP [80] ( #07 )
    COP [82]
    BRA code_0FD9E6
}

code_0FDA0B {
    COP [22] ( &code_0FDA5C )
    COP [97]
    COP [80] ( #06 )
    COP [82]
    BRA code_0FD9E6
}

code_0FDA18 {
    COP [9A] ( #$0000, &code_0FDA22, &code_0FDA3B, &code_0FDA3B )
}

code_0FDA22 {
    COP [97]
    COP [80] ( #0D )
    COP [82]
    COP [B2] ( @code_0FDAC4, #$FFF8, #$0000, #$0200 )
    COP [80] ( #0E )
    COP [82]
    BRA code_0FDA54
}

code_0FDA3B {
    COP [96]
    COP [80] ( #0D )
    COP [82]
    COP [B2] ( @code_0FDACE, #$0008, #$0000, #$0200 )
    COP [80] ( #0E )
    COP [82]
    BRA code_0FDA54

  code_0FDA54:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDA62
}

code_0FDA5C {
    COP [1B] ( &code_0FDA54, #$0004 )

  loc_0FDA62:
    COP [9A] ( #$0008, &code_0FDA6C, &code_0FDA86, &code_0FDA79 )
}

code_0FDA6C {
    COP [23] ( &code_0FD9EE )
    COP [97]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FDA54
}

code_0FDA79 {
    COP [24] ( &code_0FD9EE )
    COP [96]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FDA54
}

code_0FDA86 {
    COP [9B] ( #$0000, &code_0FDA90, &code_0FDAAA, &code_0FDAAA )
}

code_0FDA90 {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    COP [B2] ( @code_0FDAD8, #$0002, #$FFF8, #$0200 )
    COP [80] ( #0C )
    COP [82]
    BRL code_0FD9E6
}

code_0FDAAA {
    COP [97]
    COP [80] ( #09 )
    COP [82]
    COP [B2] ( @code_0FDAE2, #$FFFD, #$0008, #$0200 )
    COP [80] ( #0A )
    COP [82]
    BRL code_0FD9E6
}

code_0FDAC4 {
    BRK #$5B
    COP [81] ( #11, #08 )
    COP [83]
    BRA loc_0FDAEA
}

code_0FDACE {
    BRK #$5B
    COP [81] ( #11, #08 )
    COP [83]
    BRA loc_0FDAEA
}

code_0FDAD8 {
    BRK #$5B
    COP [81] ( #10, #08 )
    COP [83]
    BRA loc_0FDAEA
}

code_0FDAE2 {
    BRK #$5B
    COP [81] ( #0F, #08 )
    COP [83]

  loc_0FDAEA:
    COP [86]
    RTL 
}
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
---------------------------------------------

code_0FDCFC {
    COP [A2] ( #20 )
    COP [A5] ( &code_0FDD09, &code_0FDDD9, &code_0FDD94, &code_0FDD4E )
}

code_0FDD09 {
    COP [AD] ( #08 )
    COP [22] ( &code_0FDD33 )
    COP [81] ( #2D, #04 )
    COP [83]
    COP [22] ( &code_0FDD33 )
    COP [81] ( #2D, #04 )
    COP [83]

  loc_0FDD20:
    COP [B2] ( @code_0FDE3B, #$0000, #$FFFA, #$0200 )
    COP [81] ( #2B, #08 )
    COP [83]
    BRA code_0FDD09
}

code_0FDD33 {
    COP [80] ( #2B )
    COP [82]
    COP [80] ( #32 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #31 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    BRA loc_0FDD65
}

code_0FDD4E {
    COP [AD] ( #08 )
    COP [21] ( &code_0FDD78 )
    COP [81] ( #2E, #04 )
    COP [83]
    COP [21] ( &code_0FDD78 )
    COP [81] ( #2E, #04 )
    COP [83]

  loc_0FDD65:
    COP [B2] ( @code_0FDE2E, #$0000, #$FFE6, #$0200 )
    COP [81] ( #2B, #08 )
    COP [83]
    BRA code_0FDD4E
}

code_0FDD78 {
    COP [80] ( #2B )
    COP [82]
    COP [80] ( #32 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #31 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    BRL loc_0FDD20
}

code_0FDD94 {
    COP [AD] ( #08 )
    COP [24] ( &code_0FDDBE )
    COP [81] ( #30, #04 )
    COP [83]
    COP [24] ( &code_0FDDBE )
    COP [81] ( #30, #04 )
    COP [83]

  loc_0FDDAB:
    COP [B2] ( @code_0FDE1F, #$0012, #$FFF9, #$0200 )
    COP [81] ( #2C, #08 )
    COP [83]
    BRA code_0FDD94
}

code_0FDDBE {
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #32 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    COP [80] ( #31 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRA loc_0FDDF0
}

code_0FDDD9 {
    COP [AD] ( #08 )
    COP [23] ( &code_0FDE03 )
    COP [81] ( #2F, #04 )
    COP [83]
    COP [23] ( &code_0FDE03 )
    COP [81] ( #2F, #04 )
    COP [83]

  loc_0FDDF0:
    COP [B2] ( @code_0FDE21, #$FFFB, #$FFF9, #$0200 )
    COP [81] ( #2C, #08 )
    COP [83]
    BRA code_0FDDD9
}

code_0FDE03 {
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #32 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    COP [80] ( #31 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRL loc_0FDDAB
}

code_0FDE1F {
    COP [96]
}

code_0FDE21 {
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #35 )
    COP [82]
    COP [86]
    RTL 
}

code_0FDE2E {
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #34 )
    COP [82]
    COP [86]
    RTL 
}

code_0FDE3B {
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #33 )
    COP [82]
    COP [86]
    RTL 
}