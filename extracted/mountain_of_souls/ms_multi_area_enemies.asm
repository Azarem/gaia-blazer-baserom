?BANK 1F

?INCLUDE 'shared_actor_helpers_bank0'

!rng_state                      0301
!map_width_px                   0342
!map_height_px                  0344
!player_x                       0374
!player_y                       0376

---------------------------------------------

code_0FC72F {
    COP [A4]
    COP [A5] ( &code_0FC766, &code_0FC7BC, &code_0FC791, &code_0FC73B )
}

code_0FC73B {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC7E7 )
    COP [21] ( &code_0FC773 )

  code_0FC748:
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [A0] ( #$FFF8 )
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [A0] ( #$FFF8 )
    BRA code_0FC73B
}

code_0FC766 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC7E7 )
    COP [22] ( &code_0FC748 )
}

code_0FC773 {
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [A0] ( #$0008 )
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [A0] ( #$0008 )
    BRA code_0FC766
}

code_0FC791 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC7E7 )
    COP [24] ( &code_0FC7C9 )

  code_0FC79E:
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [9F] ( #$0008 )
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [9F] ( #$0008 )
    BRA code_0FC791
}

code_0FC7BC {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC7E7 )
    COP [23] ( &code_0FC79E )
}

code_0FC7C9 {
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [9F] ( #$FFF8 )
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @code_0FC835 )
    COP [9F] ( #$FFF8 )
    BRA code_0FC7BC
}

code_0FC7E7 {
    COP [A7]
    COP [80] ( #0B )
    COP [82]
    LDA #$1000
    STA $0016, X

  loc_0FC7F4:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FC7FD, &code_0FC819 )
}

code_0FC7FD {
    COP [9A] ( #$0010, &code_0FC807, &code_0FC810, &code_0FC810 )
}

code_0FC807 {
    COP [97]
    COP [80] ( #0E )
    COP [82]
    BRA loc_0FC7F4
}

code_0FC810 {
    COP [96]
    COP [80] ( #0E )
    COP [82]
    BRA loc_0FC7F4
}

code_0FC819 {
    COP [9B] ( #$0010, &code_0FC823, &code_0FC82C, &code_0FC82C )
}

code_0FC823 {
    COP [97]
    COP [80] ( #0D )
    COP [82]
    BRA loc_0FC7F4
}

code_0FC82C {
    COP [97]
    COP [80] ( #0C )
    COP [82]
    BRA loc_0FC7F4
}

code_0FC835 {
    LDA #$0300
    STA $0016, X
    COP [A4]
    COP [80] ( #0A )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

code_0FC845 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC854 )
    COP [1B] ( &code_0FC845, #$0008 )
}

code_0FC854 {
    COP [80] ( #29 )
    COP [82]
    COP [80] ( #1F )
    COP [82]

  loc_0FC85E:
    COP [AD] ( #08 )
    COP [80] ( #20 )
    COP [82]
    COP [9A] ( #$0018, &code_0FC884, &code_0FC870, &code_0FC895 )
}

code_0FC870 {
    COP [9B] ( #$0000, &code_0FC8A6, &code_0FC8B7, &code_0FC8B7 )

  code_0FC87A:
    COP [9A] ( #$0000, &code_0FC884, &code_0FC895, &code_0FC895 )
}

code_0FC884 {
    COP [23] ( &code_0FC88F )
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FC8C8
}

code_0FC88F {
    COP [1B] ( &code_0FC870, #$0008 )
}

code_0FC895 {
    COP [24] ( &code_0FC8A0 )
    COP [80] ( #23 )
    COP [82]
    BRA loc_0FC8C8
}

code_0FC8A0 {
    COP [1B] ( &code_0FC870, #$0008 )
}

code_0FC8A6 {
    COP [21] ( &code_0FC8B1 )
    COP [80] ( #22 )
    COP [82]
    BRA loc_0FC8C8
}

code_0FC8B1 {
    COP [1B] ( &code_0FC87A, #$0008 )
}

code_0FC8B7 {
    COP [22] ( &code_0FC8C2 )
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FC8C8
}

code_0FC8C2 {
    COP [1B] ( &code_0FC87A, #$0008 )

  loc_0FC8C8:
    COP [80] ( #25 )
    COP [82]
    COP [0C] ( #00, #04, &code_0FC8D5 )
    BRA loc_0FC85E
}

code_0FC8D5 {
    COP [85] ( @code_0FC8F0 )
    LDA #$0200
    STA $0016, X
    COP [80] ( #27 )
    COP [82]
    STZ $0016, X
    COP [80] ( #1F )
    COP [82]
    BRL loc_0FC85E
}

code_0FC8F0 {
    LDA #$0200
    STA $0016, X
    COP [80] ( #26 )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

code_0FC8FE {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC90C

  code_0FC906:
    COP [1B] ( &code_0FC8FE, #$0004 )

  loc_0FC90C:
    COP [9B] ( #$0008, &code_0FC916, &code_0FC930, &code_0FC923 )
}

code_0FC916 {
    COP [21] ( &code_0FC964 )
    COP [97]
    COP [80] ( #04 )
    COP [82]
    BRA code_0FC8FE
}

code_0FC923 {
    COP [22] ( &code_0FC964 )
    COP [97]
    COP [80] ( #03 )
    COP [82]
    BRA code_0FC8FE
}

code_0FC930 {
    COP [9A] ( #$0000, &code_0FC93A, &code_0FC94B, &code_0FC94B )
}

code_0FC93A {
    COP [AE] ( #$FFF0, #$0000, &code_0FC964 )
    COP [97]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FC95C
}

code_0FC94B {
    COP [AE] ( #$0010, #$0000, &code_0FC964 )
    COP [96]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FC95C

  code_0FC95C:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC96A
}

code_0FC964 {
    COP [1B] ( &code_0FC95C, #$0004 )

  loc_0FC96A:
    COP [9A] ( #$0008, &code_0FC974, &code_0FC98E, &code_0FC981 )
}

code_0FC974 {
    COP [23] ( &code_0FC906 )
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FC95C
}

code_0FC981 {
    COP [24] ( &code_0FC906 )
    COP [96]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FC95C
}

code_0FC98E {
    COP [9B] ( #$0000, &code_0FC998, &code_0FC9AA, &code_0FC9AA )
}

code_0FC998 {
    COP [AE] ( #$0000, #$FFF0, &code_0FC906 )
    COP [97]
    COP [80] ( #07 )
    COP [82]
    BRL code_0FC8FE
}

code_0FC9AA {
    COP [AE] ( #$0000, #$0010, &code_0FC906 )
    COP [97]
    COP [80] ( #06 )
    COP [82]
    BRL code_0FC8FE
}
---------------------------------------------

code_0FC9BC {
    COP [A5] ( &code_0FC9C6, &code_0FC9CF, &code_0FC9D6, &code_0FC9DD )
}

code_0FC9C6 {
    COP [96]
    COP [80] ( #0F )
    COP [82]
    BRA loc_0FC9E4
}

code_0FC9CF {
    COP [80] ( #10 )
    COP [82]
    BRA loc_0FC9E4
}

code_0FC9D6 {
    COP [80] ( #0F )
    COP [82]
    BRA loc_0FC9E4
}

code_0FC9DD {
    COP [96]
    COP [80] ( #10 )
    COP [82]

  loc_0FC9E4:
    COP [AD] ( #08 )
    COP [03] ( #08 )
    COP [80] ( #33 )
    COP [82]
    COP [0C] ( #00, #03, &code_0FCA05 )
    COP [04]
    COP [80] ( #11 )
    COP [82]
    COP [B0] ( @code_0FCA1F, #$0200 )
    BRA loc_0FC9E4
}

code_0FCA05 {
    COP [8F]
    COP [9B] ( #$0000, &code_0FCA11, &code_0FCA18, &code_0FCA18 )
}

code_0FCA11 {
    COP [80] ( #10 )
    COP [82]
    BRA loc_0FC9E4
}

code_0FCA18 {
    COP [80] ( #0F )
    COP [82]
    BRA loc_0FC9E4
}

code_0FCA1F {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$64
    LDY #$002A
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.code_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.code_002D67-1
    PHA 
    RTL 
}
---------------------------------------------

code_0FCA35 {
    LDA $001A, X
    ORA #$0200
    STA $001A, X
    COP [A5] ( &code_0FCA48, &code_0FCAAD, &code_0FCB12, &code_0FCB77 )
}

code_0FCA48 {
    LDA #$0005
    STA $002C, X

  loc_0FCA4E:
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FCA5E )

  code_0FCA57:
    COP [80] ( #2F )
    COP [82]
    BRA loc_0FCA4E
}

code_0FCA5E {
    COP [9C] ( &code_0FCA64, &code_0FCA88 )
}

code_0FCA64 {
    COP [9A] ( #$0010, &code_0FCA6E, &code_0FCA79, &code_0FCA79 )
}

code_0FCA6E {
    COP [23] ( &code_0FCA57 )
    COP [80] ( #14 )
    COP [82]
    BRA loc_0FCAA8
}

code_0FCA79 {
    COP [24] ( &code_0FCA57 )
    COP [96]
    COP [80] ( #14 )
    COP [82]
    COP [97]
    BRA loc_0FCAA8
}

code_0FCA88 {
    COP [9B] ( #$0010, &code_0FCA92, &code_0FCA9D, &code_0FCA9D )
}

code_0FCA92 {
    COP [21] ( &code_0FCA57 )
    COP [80] ( #13 )
    COP [82]
    BRA loc_0FCAA8
}

code_0FCA9D {
    COP [22] ( &code_0FCA57 )
    COP [80] ( #12 )
    COP [82]
    BRA loc_0FCAA8

  loc_0FCAA8:
    DEC $002C, X
    BNE loc_0FCA4E
}

code_0FCAAD {
    LDA #$0005
    STA $002C, X

  loc_0FCAB3:
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FCAC3 )

  code_0FCABC:
    COP [80] ( #30 )
    COP [82]
    BRA loc_0FCAB3
}

code_0FCAC3 {
    COP [9C] ( &code_0FCAC9, &code_0FCAED )
}

code_0FCAC9 {
    COP [9A] ( #$0010, &code_0FCAD3, &code_0FCADE, &code_0FCADE )
}

code_0FCAD3 {
    COP [23] ( &code_0FCABC )
    COP [80] ( #17 )
    COP [82]
    BRA loc_0FCB0D
}

code_0FCADE {
    COP [24] ( &code_0FCABC )
    COP [96]
    COP [80] ( #17 )
    COP [82]
    COP [97]
    BRA loc_0FCB0D
}

code_0FCAED {
    COP [9B] ( #$0010, &code_0FCAF7, &code_0FCB02, &code_0FCB02 )
}

code_0FCAF7 {
    COP [21] ( &code_0FCABC )
    COP [80] ( #16 )
    COP [82]
    BRA loc_0FCB0D
}

code_0FCB02 {
    COP [22] ( &code_0FCABC )
    COP [80] ( #15 )
    COP [82]
    BRA loc_0FCB0D

  loc_0FCB0D:
    DEC $002C, X
    BNE loc_0FCAB3
}

code_0FCB12 {
    LDA #$0005
    STA $002C, X

  loc_0FCB18:
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FCB28 )

  code_0FCB21:
    COP [80] ( #31 )
    COP [82]
    BRA loc_0FCB18
}

code_0FCB28 {
    COP [9C] ( &code_0FCB2E, &code_0FCB52 )
}

code_0FCB2E {
    COP [9A] ( #$0010, &code_0FCB38, &code_0FCB43, &code_0FCB43 )
}

code_0FCB38 {
    COP [23] ( &code_0FCB21 )
    COP [80] ( #1A )
    COP [82]
    BRA loc_0FCB72
}

code_0FCB43 {
    COP [24] ( &code_0FCB21 )
    COP [96]
    COP [80] ( #1A )
    COP [82]
    COP [97]
    BRA loc_0FCB72
}

code_0FCB52 {
    COP [9B] ( #$0010, &code_0FCB5C, &code_0FCB67, &code_0FCB67 )
}

code_0FCB5C {
    COP [21] ( &code_0FCB21 )
    COP [80] ( #19 )
    COP [82]
    BRA loc_0FCB72
}

code_0FCB67 {
    COP [22] ( &code_0FCB21 )
    COP [80] ( #18 )
    COP [82]
    BRA loc_0FCB72

  loc_0FCB72:
    DEC $002C, X
    BNE loc_0FCB18
}

code_0FCB77 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FCB87 )
    COP [80] ( #32 )
    COP [82]
    BRA code_0FCB77
}

code_0FCB87 {
    COP [9C] ( &code_0FCB8D, &code_0FCBB1 )
}

code_0FCB8D {
    COP [9A] ( #$0010, &code_0FCB97, &code_0FCBA2, &code_0FCBA2 )
}

code_0FCB97 {
    COP [23] ( &code_0FCBD7 )
    COP [80] ( #1D )
    COP [82]
    BRA loc_0FCBD1
}

code_0FCBA2 {
    COP [24] ( &code_0FCBD7 )
    COP [96]
    COP [80] ( #1D )
    COP [82]
    COP [97]
    BRA loc_0FCBD1
}

code_0FCBB1 {
    COP [9B] ( #$0010, &code_0FCBBB, &code_0FCBC6, &code_0FCBC6 )
}

code_0FCBBB {
    COP [21] ( &code_0FCBD7 )
    COP [80] ( #1C )
    COP [82]
    BRA loc_0FCBD1
}

code_0FCBC6 {
    COP [22] ( &code_0FCBD7 )
    COP [80] ( #1B )
    COP [82]
    BRA loc_0FCBD1

  loc_0FCBD1:
    COP [1B] ( &code_0FCB77, #$0001 )
}

code_0FCBD7 {
    COP [80] ( #1E )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

code_0FCBDF {
    COP [AA] ( #00 )

  code_0FCBE2:
    LDA $0016, X
    BIT #$8000
    BNE loc_0FCBF0
    COP [0C] ( #00, #05, &code_0FCD52 )

  loc_0FCBF0:
    COP [1B] ( &code_0FCBE2, #$0010 )

  code_0FCBF6:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FCC0F
    DEC 
    BEQ loc_0FCC5F
    DEC 
    BNE loc_0FCC09
    BRL loc_0FCCB2

  loc_0FCC09:
    DEC 
    BNE loc_0FCC0F
    BRL loc_0FCD04

  loc_0FCC0F:
    LDA $player_x
    STA $0000, X
    LDA $player_y
    SEC 
    SBC #$0040
    BPL loc_0FCC21
    BRL code_0FCD69

  loc_0FCC21:
    AND #$FFF0
    STA $0002, X
    COP [28] ( &code_0FCD69 )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #00 )
    COP [82]
    COP [81] ( #03, #04 )
    COP [83]
    COP [85] ( @code_0FCD7A )
    COP [80] ( #04 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    BRL code_0FCD52

  loc_0FCC5F:
    LDA $player_x
    STA $0000, X
    LDA $player_y
    CLC 
    ADC #$0040
    CMP $map_height_px
    BCC loc_0FCC74
    BRL code_0FCD69

  loc_0FCC74:
    AND #$FFF0
    STA $0002, X
    COP [28] ( &code_0FCD69 )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #01 )
    COP [82]
    COP [81] ( #05, #04 )
    COP [83]
    COP [85] ( @code_0FCD6F )
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    BRL code_0FCD52

  loc_0FCCB2:
    LDA $player_x
    CLC 
    ADC #$0040
    CMP $map_width_px
    BCC loc_0FCCC1
    BRL code_0FCD69

  loc_0FCCC1:
    AND #$FFF0
    STA $0000, X
    LDA $player_y
    STA $0002, X
    COP [28] ( &code_0FCD69 )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    COP [81] ( #07, #04 )
    COP [83]
    COP [85] ( @code_0FCD83 )
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    BRA code_0FCD52

  loc_0FCD04:
    LDA $player_x
    SEC 
    SBC #$0040
    BMI code_0FCD69
    AND #$FFF0
    STA $0000, X
    LDA $player_y
    STA $0002, X
    COP [28] ( &code_0FCD69 )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [96]
    COP [80] ( #02 )
    COP [82]
    COP [81] ( #07, #04 )
    COP [83]
    COP [85] ( @code_0FCD8E )
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    COP [97]
}

code_0FCD52 {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #09 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
}

code_0FCD69 {
    COP [1B] ( &code_0FCBF6, #$0020 )
}

code_0FCD6F {
    COP [A1] ( #$0002, #$FFF8 )
    LDA #$000C
    BRA loc_0FCD97
}

code_0FCD7A {
    COP [9F] ( #$FFFF )
    LDA #$000B
    BRA loc_0FCD97
}

code_0FCD83 {
    COP [A1] ( #$FFF7, #$FFFC )
    LDA #$000D
    BRA loc_0FCD97
}

code_0FCD8E {
    COP [A1] ( #$0009, #$FFFC )
    LDA #$000D

  loc_0FCD97:
    STA $001E, X
    STZ $0020, X
    LDA #$0200
    STA $0016, X
    COP [AA] ( #00 )
    COP [A3]
    COP [A2] ( #30 )
    LDA #$0010
    STA $002A, X
    BRK #$52
    COP [91]
    COP [83]
    COP [86]
    RTL 
}
---------------------------------------------

code_0FCDBA {
    COP [AA] ( #02 )

  code_0FCDBD:
    LDA $0016, X
    BIT #$8000
    BNE loc_0FCDCB
    COP [0C] ( #00, #05, &code_0FCF55 )

  loc_0FCDCB:
    COP [1B] ( &code_0FCDBD, #$0010 )

  code_0FCDD1:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FCDEA
    DEC 
    BEQ loc_0FCE44
    DEC 
    BNE loc_0FCDE4
    BRL loc_0FCEA1

  loc_0FCDE4:
    DEC 
    BNE loc_0FCDEA
    BRL loc_0FCEFD

  loc_0FCDEA:
    LDA $player_x
    STA $0000, X
    LDA $player_y
    SEC 
    SBC #$0020
    BPL loc_0FCDFC
    BRL code_0FCF6C

  loc_0FCDFC:
    AND #$FFF0
    STA $0002, X
    COP [28] ( &code_0FCF6C )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #00 )
    COP [82]
    COP [81] ( #03, #04 )
    COP [83]
    COP [85] ( @code_0FCF87 )
    COP [85] ( @code_0FCF8E )
    COP [85] ( @code_0FCF95 )
    COP [80] ( #04 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    BRL code_0FCF55

  loc_0FCE44:
    LDA $player_x
    STA $0000, X
    LDA $player_y
    CLC 
    ADC #$0020
    CMP $map_height_px
    BCC loc_0FCE59
    BRL code_0FCF6C

  loc_0FCE59:
    AND #$FFF0
    STA $0002, X
    COP [28] ( &code_0FCF6C )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #01 )
    COP [82]
    COP [81] ( #05, #04 )
    COP [83]
    COP [85] ( @code_0FCF72 )
    COP [85] ( @code_0FCF79 )
    COP [85] ( @code_0FCFA3 )
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    BRL code_0FCF55

  loc_0FCEA1:
    LDA $player_x
    CLC 
    ADC #$0020
    CMP $map_width_px
    BCC loc_0FCEB0
    BRL code_0FCF6C

  loc_0FCEB0:
    AND #$FFF0
    STA $0000, X
    LDA $player_y
    STA $0002, X
    COP [28] ( &code_0FCF6C )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    COP [81] ( #07, #04 )
    COP [83]
    COP [85] ( @code_0FCF95 )
    COP [85] ( @code_0FCF9C )
    COP [85] ( @code_0FCFA3 )
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    BRA code_0FCF55

  loc_0FCEFD:
    LDA $player_x
    SEC 
    SBC #$0020
    BMI code_0FCF6C
    AND #$FFF0
    STA $0000, X
    LDA $player_y
    STA $0002, X
    COP [28] ( &code_0FCF6C )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [96]
    COP [80] ( #02 )
    COP [82]
    COP [81] ( #07, #04 )
    COP [83]
    COP [85] ( @code_0FCF79 )
    COP [85] ( @code_0FCF80 )
    COP [85] ( @code_0FCF87 )
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    COP [97]
}

code_0FCF55 {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #09 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
}

code_0FCF6C {
    COP [1B] ( &code_0FCDD1, #$0020 )
}

code_0FCF72 {
    COP [97]
    LDA #$0011
    BRA loc_0FCFA8
}

code_0FCF79 {
    COP [96]
    LDA #$0014
    BRA loc_0FCFA8
}

code_0FCF80 {
    COP [96]
    LDA #$0012
    BRA loc_0FCFA8
}

code_0FCF87 {
    COP [96]
    LDA #$0013
    BRA loc_0FCFA8
}

code_0FCF8E {
    COP [97]
    LDA #$0010
    BRA loc_0FCFA8
}

code_0FCF95 {
    COP [97]
    LDA #$0013
    BRA loc_0FCFA8
}

code_0FCF9C {
    COP [97]
    LDA #$0012
    BRA loc_0FCFA8
}

code_0FCFA3 {
    COP [97]
    LDA #$0014

  loc_0FCFA8:
    STA $001E, X
    STZ $0020, X
    LDA #$0200
    STA $0016, X
    COP [AA] ( #00 )
    COP [A3]
    COP [A2] ( #30 )
    LDA #$0004
    STA $002A, X
    BRK #$52
    COP [91]
    COP [83]
    COP [80] ( #15 )
    COP [82]
    COP [81] ( #2F, #08 )
    COP [83]
    COP [86]
    RTL 
}
---------------------------------------------

code_0FD11B {
    COP [A3]
    COP [1B] ( &code_0FD123, #$0000 )
}

code_0FD123 {
    COP [AD] ( #08 )
    BRL loc_0FD195

  code_0FD129:
    COP [97]
    COP [80] ( #29 )
    COP [82]
    BRA loc_0FD195

  code_0FD132:
    COP [96]
    COP [80] ( #26 )
    COP [82]
    BRA loc_0FD1A9

  code_0FD13B:
    COP [96]
    COP [80] ( #25 )
    COP [82]
    BRA loc_0FD195

  code_0FD144:
    COP [96]
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FD1A9

  code_0FD14D:
    COP [96]
    COP [80] ( #27 )
    COP [82]
    BRA loc_0FD1BD

  code_0FD156:
    COP [96]
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FD1A9

  code_0FD15F:
    COP [97]
    COP [80] ( #28 )
    COP [82]
    BRA loc_0FD1BD

  code_0FD168:
    COP [97]
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FD1D1

  code_0FD171:
    COP [97]
    COP [80] ( #27 )
    COP [82]
    BRA loc_0FD1BD

  code_0FD17A:
    COP [97]
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FD1D1

  code_0FD183:
    COP [97]
    COP [80] ( #25 )
    COP [82]
    BRA loc_0FD195

  code_0FD18C:
    COP [97]
    COP [80] ( #26 )
    COP [82]
    BRA loc_0FD1D1

  loc_0FD195:
    COP [9B] ( #$0000, &code_0FD129, &code_0FD19F, &code_0FD19F )
}

code_0FD19F {
    COP [9A] ( #$0000, &code_0FD18C, &code_0FD132, &code_0FD132 )

  loc_0FD1A9:
    COP [9A] ( #$0000, &code_0FD1B3, &code_0FD1B3, &code_0FD144 )
}

code_0FD1B3 {
    COP [9B] ( #$0000, &code_0FD13B, &code_0FD14D, &code_0FD14D )

  loc_0FD1BD:
    COP [9B] ( #$0000, &code_0FD1C7, &code_0FD1C7, &code_0FD15F )
}

code_0FD1C7 {
    COP [9A] ( #$0000, &code_0FD168, &code_0FD168, &code_0FD156 )

  loc_0FD1D1:
    COP [9A] ( #$0000, &code_0FD17A, &code_0FD1DB, &code_0FD1DB )
}

code_0FD1DB {
    COP [9B] ( #$0000, &code_0FD183, &code_0FD183, &code_0FD171 )
}
---------------------------------------------

code_0FD1E5 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FD1F5 )
    COP [80] ( #2B )
    COP [82]
    BRA code_0FD1E5
}

code_0FD1F5 {
    COP [1F]
    LDA $rng_state+1
    BPL loc_0FD21A
    COP [9A] ( #$0000, &code_0FD206, &code_0FD210, &code_0FD210 )
}

code_0FD206 {
    COP [9B] ( #$0000, &code_0FD261, &code_0FD24E, &code_0FD24E )
}

code_0FD210 {
    COP [9B] ( #$0000, &code_0FD228, &code_0FD23B, &code_0FD23B )

  loc_0FD21A:
    AND #$0003
    BEQ code_0FD228
    DEC 
    BEQ code_0FD23B
    DEC 
    BEQ code_0FD24E
    DEC 
    BEQ code_0FD261
}

code_0FD228 {
    COP [96]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRA code_0FD1E5
}

code_0FD23B {
    COP [96]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #2D )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRA code_0FD1E5
}

code_0FD24E {
    COP [97]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #2D )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRA code_0FD1E5
}

code_0FD261 {
    COP [97]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRL code_0FD1E5
}