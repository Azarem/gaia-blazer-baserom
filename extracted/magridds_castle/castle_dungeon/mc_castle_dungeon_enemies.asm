?BANK 1F

?INCLUDE 'shared_actor_helpers_bank0'

!rng_state                      0301

---------------------------------------------

code_0FDE48 {
    LDA $001A, X
    ORA #$0200
    STA $001A, X
    COP [A5] ( &code_0FDE5B, &code_0FDE65, &code_0FDE5B, &code_0FDE65 )
}

code_0FDE5B {
    COP [80] ( #01 )
    COP [82]
    COP [AD] ( #10 )
    BRA code_0FDE5B
}

code_0FDE65 {
    COP [96]

  loc_0FDE67:
    COP [80] ( #00 )
    COP [82]
    COP [AD] ( #10 )
    BRA loc_0FDE67
}
---------------------------------------------

code_0FDE71 {
    COP [A5] ( &code_0FDE7B, &code_0FDEC7, &code_0FDF13, &code_0FDF61 )
}

code_0FDE7B {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDE89

  code_0FDE83:
    COP [1B] ( &code_0FDE7B, #$0078 )

  loc_0FDE89:
    COP [0C] ( #00, #07, &code_0FDE91 )
    BRA code_0FDE83
}

code_0FDE91 {
    COP [9B] ( #$0010, &code_0FDE83, &code_0FDE83, &code_0FDE9B )
}

code_0FDE9B {
    COP [28] ( &code_0FDEA3 )
    COP [27] ( &code_0FDE83 )
}

code_0FDEA3 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    COP [B2] ( @code_0FDFAD, #$0000, #$0010, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FDE83
}

code_0FDEC7 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDED5

  code_0FDECF:
    COP [1B] ( &code_0FDEC7, #$0078 )

  loc_0FDED5:
    COP [0C] ( #00, #07, &code_0FDEDD )
    BRA code_0FDECF
}

code_0FDEDD {
    COP [9A] ( #$0010, &code_0FDEE7, &code_0FDECF, &code_0FDECF )
}

code_0FDEE7 {
    COP [28] ( &code_0FDEEF )
    COP [27] ( &code_0FDECF )
}

code_0FDEEF {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #04 )
    COP [82]
    COP [B2] ( @code_0FDFAD, #$FFF0, #$0000, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FDECF
}

code_0FDF13 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDF21

  code_0FDF1B:
    COP [1B] ( &code_0FDF13, #$0078 )

  loc_0FDF21:
    COP [0C] ( #00, #07, &code_0FDF29 )
    BRA code_0FDF1B
}

code_0FDF29 {
    COP [9A] ( #$0010, &code_0FDF1B, &code_0FDF1B, &code_0FDF33 )
}

code_0FDF33 {
    COP [28] ( &code_0FDF3B )
    COP [27] ( &code_0FDF1B )
}

code_0FDF3B {
    COP [96]
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #04 )
    COP [82]
    COP [B2] ( @code_0FDFAD, #$0010, #$0000, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FDF1B
}

code_0FDF61 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDF6F

  code_0FDF69:
    COP [1B] ( &code_0FDF61, #$0078 )

  loc_0FDF6F:
    COP [0C] ( #00, #07, &code_0FDF77 )
    BRA code_0FDF69
}

code_0FDF77 {
    COP [9B] ( #$0010, &code_0FDF81, &code_0FDF69, &code_0FDF69 )
}

code_0FDF81 {
    COP [28] ( &code_0FDF89 )
    COP [27] ( &code_0FDF69 )
}

code_0FDF89 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #03 )
    COP [82]
    COP [B2] ( @code_0FDFAD, #$0000, #$FFF0, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FDF69
}

code_0FDFAD {
    COP [A3]
    BRK #$64
    LDY #$0005
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.code_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.code_002D67-1
    PHA 
    RTL 
}
---------------------------------------------

code_0FDFC3 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #04, &code_0FDFD3 )
    COP [80] ( #0A )
    COP [82]
    BRA code_0FDFC3
}

code_0FDFD3 {
    COP [9A] ( #$0000, &code_0FDFE1, &code_0FDFDD, &code_0FDFDD )
}

code_0FDFDD {
    COP [96]
    BRA loc_0FDFE3
}

code_0FDFE1 {
    COP [97]

  loc_0FDFE3:
    COP [9B] ( #$0028, &code_0FDFF7, &code_0FDFED, &code_0FE00C )
}

code_0FDFED {
    COP [9B] ( #$0000, &code_0FDFFE, &code_0FE005, &code_0FE005 )
}

code_0FDFF7 {
    COP [80] ( #0E )
    COP [82]
    BRA loc_0FE011
}

code_0FDFFE {
    COP [80] ( #0D )
    COP [82]
    BRA loc_0FE011
}

code_0FE005 {
    COP [80] ( #0C )
    COP [82]
    BRA loc_0FE011
}

code_0FE00C {
    COP [80] ( #0B )
    COP [82]

  loc_0FE011:
    COP [81] ( #0A, #02 )
    COP [83]
    COP [0C] ( #00, #02, &code_0FDFC3 )
    COP [81] ( #0F, #04 )
    COP [83]
    COP [B0] ( @code_0FE032, #$0200 )
    COP [81] ( #0A, #02 )
    COP [83]
    BRA code_0FDFC3
}

code_0FE032 {
    COP [A3]
    BRK #$64
    LDY #$0010
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.code_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.code_002D67-1
    PHA 
    RTL 
}
---------------------------------------------

code_0FE045 {
    LDA $001A, X
    ORA #$0800
    STA $001A, X
    COP [AD] ( #08 )

  loc_0FE051:
    COP [9B] ( #$0008, &code_0FE05B, &code_0FE0CC, &code_0FE073 )
}

code_0FE05B {
    COP [97]

  code_0FE05D:
    COP [80] ( #19 )
    COP [82]
    COP [9B] ( #$0018, &code_0FE05D, &code_0FE06C, &code_0FE073 )
}

code_0FE06C {
    COP [80] ( #16 )
    COP [82]
    BRA loc_0FE089
}

code_0FE073 {
    COP [97]

  code_0FE075:
    COP [80] ( #18 )
    COP [82]
    COP [9B] ( #$0018, &code_0FE05B, &code_0FE084, &code_0FE075 )
}

code_0FE084 {
    COP [80] ( #15 )
    COP [82]

  loc_0FE089:
    COP [1F]
    LDA $rng_state+1
    BPL code_0FE0CC
    LDA $0016, X
    BIT #$0200
    BEQ loc_0FE0B3
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    BRK #$60
    COP [80] ( #1C )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    BRA code_0FE0CC

  loc_0FE0B3:
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    BRK #$60
    COP [80] ( #1B )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
}

code_0FE0CC {
    COP [9A] ( #$0008, &code_0FE0D6, &code_0FE104, &code_0FE0EE )
}

code_0FE0D6 {
    COP [97]

  code_0FE0D8:
    COP [80] ( #1A )
    COP [82]
    COP [9A] ( #$0018, &code_0FE0D8, &code_0FE0E7, &code_0FE0EE )
}

code_0FE0E7 {
    COP [80] ( #17 )
    COP [82]
    BRA code_0FE104
}

code_0FE0EE {
    COP [96]

  code_0FE0F0:
    COP [80] ( #1A )
    COP [82]
    COP [9A] ( #$0018, &code_0FE0D6, &code_0FE0FF, &code_0FE0F0 )
}

code_0FE0FF {
    COP [80] ( #17 )
    COP [82]
}

code_0FE104 {
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE10E
    BRL loc_0FE051

  loc_0FE10E:
    LDA $0016, X
    BIT #$0200
    BEQ loc_0FE132
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    BRK #$60
    COP [80] ( #1C )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    BRL loc_0FE051

  loc_0FE132:
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    BRK #$60
    COP [80] ( #1B )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRL loc_0FE051
}
---------------------------------------------

code_0FE14E {
    COP [A5] ( &code_0FE158, &code_0FE161, &code_0FE168, &code_0FE171 )
}

code_0FE158 {
    COP [96]
    COP [80] ( #1D )
    COP [82]
    BRA code_0FE1A9
}

code_0FE161 {
    COP [80] ( #1F )
    COP [82]
    BRA code_0FE178
}

code_0FE168 {
    COP [96]
    COP [80] ( #1F )
    COP [82]
    BRA code_0FE178
}

code_0FE171 {
    COP [80] ( #1E )
    COP [82]
    BRA code_0FE1A9

  code_0FE178:
    COP [AD] ( #08 )
    COP [9B] ( #$0008, &code_0FE18F, &code_0FE185, &code_0FE18F )
}

code_0FE185 {
    COP [9A] ( #$0000, &code_0FE1DA, &code_0FE1EE, &code_0FE1EE )
}

code_0FE18F {
    COP [9A] ( #$0020, &code_0FE1A3, &code_0FE199, &code_0FE1A3 )
}

code_0FE199 {
    COP [A5] ( &code_0FE1EE, &code_0FE1DA, &code_0FE1EE, &code_0FE1DA )
}

code_0FE1A3 {
    COP [1B] ( &code_0FE178, #$0008 )

  code_0FE1A9:
    COP [AD] ( #08 )
    COP [9A] ( #$0008, &code_0FE1C0, &code_0FE1B6, &code_0FE1C0 )
}

code_0FE1B6 {
    COP [9B] ( #$0000, &code_0FE203, &code_0FE217, &code_0FE217 )
}

code_0FE1C0 {
    COP [9B] ( #$0020, &code_0FE1D4, &code_0FE1CA, &code_0FE1D4 )
}

code_0FE1CA {
    COP [A5] ( &code_0FE217, &code_0FE203, &code_0FE217, &code_0FE203 )
}

code_0FE1D4 {
    COP [1B] ( &code_0FE1A9, #$0008 )
}

code_0FE1DA {
    COP [97]

  loc_0FE1DC:
    COP [23] ( &code_0FE1E7 )
    COP [80] ( #22 )
    COP [82]
    BRA loc_0FE1DC
}

code_0FE1E7 {
    COP [80] ( #1F )
    COP [82]
    BRA code_0FE178
}

code_0FE1EE {
    COP [96]

  loc_0FE1F0:
    COP [24] ( &code_0FE1FB )
    COP [80] ( #22 )
    COP [82]
    BRA loc_0FE1F0
}

code_0FE1FB {
    COP [80] ( #1F )
    COP [82]
    BRL code_0FE178
}

code_0FE203 {
    COP [97]

  loc_0FE205:
    COP [21] ( &code_0FE210 )
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FE205
}

code_0FE210 {
    COP [80] ( #1E )
    COP [82]
    BRA code_0FE1A9
}

code_0FE217 {
    COP [96]

  loc_0FE219:
    COP [22] ( &code_0FE224 )
    COP [80] ( #20 )
    COP [82]
    BRA loc_0FE219
}

code_0FE224 {
    COP [80] ( #1D )
    COP [82]
    BRL code_0FE1A9
}
---------------------------------------------

code_0FE22C {
    COP [80] ( #23 )
    COP [82]
    COP [AD] ( #08 )
    BRA code_0FE22C
}
---------------------------------------------

code_0FE236 {
    COP [AD] ( #10 )
    COP [0C] ( #00, #02, &code_0FE246 )
    COP [80] ( #3C )
    COP [82]
    BRA code_0FE236
}

code_0FE246 {
    COP [80] ( #3D )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X

  loc_0FE254:
    COP [9B] ( #$0000, &code_0FE25E, &code_0FE286, &code_0FE286 )
}

code_0FE25E {
    COP [97]
    COP [9B] ( #$0018, &code_0FE26A, &code_0FE275, &code_0FE26A )
}

code_0FE26A {
    COP [21] ( &code_0FE3BF )
    COP [80] ( #2D )
    COP [82]
    BRA loc_0FE254
}

code_0FE275 {
    COP [9A] ( #$0028, &code_0FE27F, &code_0FE345, &code_0FE27F )
}

code_0FE27F {
    COP [80] ( #2C )
    COP [82]
    BRA loc_0FE2AC
}

code_0FE286 {
    COP [97]
    COP [9B] ( #$0018, &code_0FE292, &code_0FE29D, &code_0FE292 )
}

code_0FE292 {
    COP [22] ( &code_0FE3BF )
    COP [80] ( #25 )
    COP [82]
    BRA loc_0FE254
}

code_0FE29D {
    COP [9A] ( #$0028, &code_0FE2A7, &code_0FE382, &code_0FE2A7 )
}

code_0FE2A7 {
    COP [80] ( #24 )
    COP [82]

  loc_0FE2AC:
    COP [9A] ( #$0000, &code_0FE2B6, &code_0FE2DF, &code_0FE2DF )
}

code_0FE2B6 {
    COP [97]
    COP [9A] ( #$0018, &code_0FE2C2, &code_0FE2CD, &code_0FE2C2 )
}

code_0FE2C2 {
    COP [23] ( &code_0FE3BF )
    COP [80] ( #35 )
    COP [82]
    BRA loc_0FE2AC
}

code_0FE2CD {
    COP [9B] ( #$0028, &code_0FE2D7, &code_0FE308, &code_0FE2D7 )
}

code_0FE2D7 {
    COP [80] ( #34 )
    COP [82]
    BRL loc_0FE254
}

code_0FE2DF {
    COP [96]
    COP [9A] ( #$0018, &code_0FE2EB, &code_0FE2F6, &code_0FE2EB )
}

code_0FE2EB {
    COP [24] ( &code_0FE3BF )
    COP [80] ( #35 )
    COP [82]
    BRA loc_0FE2AC
}

code_0FE2F6 {
    COP [9B] ( #$0028, &code_0FE300, &code_0FE308, &code_0FE300 )
}

code_0FE300 {
    COP [80] ( #34 )
    COP [82]
    BRL loc_0FE254
}

code_0FE308 {
    COP [9B] ( #$0010, &code_0FE312, &code_0FE323, &code_0FE334 )
}

code_0FE312 {
    COP [B0] ( @code_0FE404, #$0200 )
    BRK #$41
    COP [80] ( #37 )
    COP [82]
    BRL loc_0FE254
}

code_0FE323 {
    COP [B0] ( @code_0FE40B, #$0200 )
    BRK #$41
    COP [80] ( #38 )
    COP [82]
    BRL loc_0FE254
}

code_0FE334 {
    COP [B0] ( @code_0FE3FD, #$0200 )
    BRK #$41
    COP [80] ( #36 )
    COP [82]
    BRL loc_0FE254
}

code_0FE345 {
    COP [9A] ( #$0010, &code_0FE34F, &code_0FE360, &code_0FE371 )
}

code_0FE34F {
    COP [B0] ( @code_0FE3E8, #$0200 )
    BRK #$41
    COP [80] ( #2E )
    COP [82]
    BRL loc_0FE2AC
}

code_0FE360 {
    COP [B0] ( @code_0FE3F6, #$0200 )
    BRK #$41
    COP [80] ( #30 )
    COP [82]
    BRL loc_0FE2AC
}

code_0FE371 {
    COP [B0] ( @code_0FE3EF, #$0200 )
    BRK #$41
    COP [80] ( #2F )
    COP [82]
    BRL loc_0FE2AC
}

code_0FE382 {
    COP [9A] ( #$0010, &code_0FE38C, &code_0FE39D, &code_0FE3AE )
}

code_0FE38C {
    COP [B0] ( @code_0FE3D3, #$0200 )
    BRK #$41
    COP [80] ( #26 )
    COP [82]
    BRL loc_0FE2AC
}

code_0FE39D {
    COP [B0] ( @code_0FE3E1, #$0200 )
    BRK #$41
    COP [80] ( #28 )
    COP [82]
    BRL loc_0FE2AC
}

code_0FE3AE {
    COP [B0] ( @code_0FE3DA, #$0200 )
    BRK #$41
    COP [80] ( #27 )
    COP [82]
    BRL loc_0FE2AC
}

code_0FE3BF {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #3E )
    COP [82]
    COP [1B] ( &code_0FE236, #$003C )
}

code_0FE3D3 {
    COP [80] ( #29 )
    COP [82]
    BRA loc_0FE410
}

code_0FE3DA {
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FE410
}

code_0FE3E1 {
    COP [80] ( #2B )
    COP [82]
    BRA loc_0FE410
}

code_0FE3E8 {
    COP [80] ( #2E )
    COP [82]
    BRA loc_0FE410
}

code_0FE3EF {
    COP [80] ( #2F )
    COP [82]
    BRA loc_0FE410
}

code_0FE3F6 {
    COP [80] ( #30 )
    COP [82]
    BRA loc_0FE410
}

code_0FE3FD {
    COP [80] ( #39 )
    COP [82]
    BRA loc_0FE410
}

code_0FE404 {
    COP [80] ( #3A )
    COP [82]
    BRA loc_0FE410
}

code_0FE40B {
    COP [80] ( #3B )
    COP [82]

  loc_0FE410:
    COP [86]
    RTL 
}