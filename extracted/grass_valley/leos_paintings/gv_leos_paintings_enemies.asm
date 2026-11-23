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
---------------------------------------------

code_0FAEE5 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [A5] ( &code_0FAF32, &code_0FAF20, &code_0FAEF8, &code_0FAF0E )
}

code_0FAEF8 {
    COP [21] ( &code_0FAEFE )
    BRA loc_0FAF18
}

code_0FAEFE {
    COP [24] ( &code_0FAF32 )

  loc_0FAF02:
    COP [96]
    COP [81] ( #21, #02 )
    COP [83]
    COP [97]
    BRA code_0FAEF8
}

code_0FAF0E {
    COP [23] ( &code_0FAF14 )
    BRA loc_0FAF2A
}

code_0FAF14 {
    COP [21] ( &code_0FAEF8 )

  loc_0FAF18:
    COP [81] ( #20, #02 )
    COP [83]
    BRA code_0FAF0E
}

code_0FAF20 {
    COP [22] ( &code_0FAF26 )
    BRA loc_0FAF3C
}

code_0FAF26 {
    COP [23] ( &code_0FAF0E )

  loc_0FAF2A:
    COP [81] ( #21, #02 )
    COP [83]
    BRA code_0FAF20
}

code_0FAF32 {
    COP [24] ( &code_0FAF38 )
    BRA loc_0FAF02
}

code_0FAF38 {
    COP [22] ( &code_0FAF20 )

  loc_0FAF3C:
    COP [81] ( #1F, #02 )
    COP [83]
    BRA code_0FAF32
}
---------------------------------------------

code_0FAF44 {
    COP [A2] ( #30 )
    COP [A3]

  code_0FAF49:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAF57
    COP [1B] ( &code_0FAF49, #$0010 )

  loc_0FAF57:
    COP [9C] ( &code_0FAF5D, &code_0FAF85 )
}

code_0FAF5D {
    COP [9A] ( #$0010, &code_0FAF67, &code_0FAF74, &code_0FAF74 )
}

code_0FAF67 {
    COP [81] ( #1C, #02 )
    COP [83]
    COP [80] ( #1D )
    COP [82]
    BRA loc_0FAF57
}

code_0FAF74 {
    COP [96]
    COP [81] ( #1C, #02 )
    COP [83]
    COP [80] ( #1D )
    COP [82]
    COP [97]
    BRA loc_0FAF57
}

code_0FAF85 {
    COP [9B] ( #$0010, &code_0FAF8F, &code_0FAF9C, &code_0FAF9C )
}

code_0FAF8F {
    COP [81] ( #1A, #02 )
    COP [83]
    COP [80] ( #1B )
    COP [82]
    BRA loc_0FAF57
}

code_0FAF9C {
    COP [96]
    COP [81] ( #18, #02 )
    COP [83]
    COP [80] ( #19 )
    COP [82]
    COP [97]
    BRA loc_0FAF57
}
---------------------------------------------

code_0FAFAD {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAFBB
    COP [1B] ( &code_0FAFAD, #$0008 )

  loc_0FAFBB:
    COP [97]
    COP [80] ( #22 )
    COP [82]
    COP [9B] ( #$0010, &code_0FAFCC, &code_0FAFD6, &code_0FAFCC )
}

code_0FAFCC {
    COP [9A] ( #$0010, &code_0FAFAD, &code_0FAFF6, &code_0FAFAD )
}

code_0FAFD6 {
    COP [9A] ( #$0000, &code_0FAFE0, &code_0FAFEA, &code_0FAFEA )
}

code_0FAFE0 {
    COP [80] ( #23 )
    COP [82]
    LDA #$0029
    BRA loc_0FB014
}

code_0FAFEA {
    COP [80] ( #23 )
    COP [82]
    COP [96]
    LDA #$0029
    BRA loc_0FB014
}

code_0FAFF6 {
    COP [9B] ( #$0000, &code_0FB000, &code_0FB00A, &code_0FB00A )
}

code_0FB000 {
    COP [80] ( #23 )
    COP [82]
    LDA #$0028
    BRA loc_0FB014
}

code_0FB00A {
    COP [80] ( #23 )
    COP [82]
    LDA #$0027
    BRA loc_0FB014

  loc_0FB014:
    PHA 
    COP [84] ( @code_0FB02F )
    PLA 
    STA $001E, Y
    LDA #$0000
    STA $0020, Y
    COP [97]
    COP [81] ( #22, #04 )
    COP [83]
    BRL code_0FAFAD
}

code_0FB02F {
    LDA #$0200
    STA $0016, X
    COP [A2] ( #30 )
    COP [A3]
    COP [A0] ( #$FFFC )
    BRK #$64
    COP [91]

  loc_0FB042:
    COP [82]
    COP [1C] ( #$8000, &code_0FB04C )
    BRA loc_0FB042
}

code_0FB04C {
    COP [86]
    RTL 
}
---------------------------------------------

code_0FB04F {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB05D

  loc_0FB057:
    COP [1B] ( &code_0FB04F, #$0010 )

  loc_0FB05D:
    COP [0C] ( #00, #05, &code_0FB065 )
    BRA loc_0FB057
}

code_0FB065 {
    COP [80] ( #02 )
    COP [82]
    COP [81] ( #03, #02 )
    COP [83]
    COP [80] ( #01 )
    COP [82]

  loc_0FB075:
    COP [0C] ( #00, #05, &code_0FB087 )
    COP [80] ( #02 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    BRA loc_0FB057
}

code_0FB087 {
    COP [9A] ( #$0010, &code_0FB091, &code_0FB0AB, &code_0FB09E )
}

code_0FB091 {
    COP [23] ( &code_0FB0CF )
    COP [97]
    COP [80] ( #06 )
    COP [82]
    BRA code_0FB0AB
}

code_0FB09E {
    COP [24] ( &code_0FB0CF )
    COP [96]
    COP [80] ( #06 )
    COP [82]
    BRA code_0FB0AB
}

code_0FB0AB {
    COP [9B] ( #$0010, &code_0FB0B5, &code_0FB0CF, &code_0FB0C2 )
}

code_0FB0B5 {
    COP [21] ( &code_0FB0CF )
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FB0CF
}

code_0FB0C2 {
    COP [22] ( &code_0FB0CF )
    COP [97]
    COP [80] ( #04 )
    COP [82]
    BRA code_0FB0CF
}

code_0FB0CF {
    COP [80] ( #01 )
    COP [82]
    BRA loc_0FB075
}
---------------------------------------------

code_0FB0D6 {
    COP [A2] ( #00 )
    COP [A4]
    COP [A5] ( &code_0FB0E5, &code_0FB0ED, &code_0FB0ED, &code_0FB0ED )
}

code_0FB0E5 {
    COP [81] ( #2C, #FF )
    COP [83]
    BRA code_0FB0E5
}

code_0FB0ED {
    COP [81] ( #2D, #FF )
    COP [83]
    BRA code_0FB0ED
}