?BANK 1F

?INCLUDE 'shared_actor_helpers_bank0'

!rng_state                      0301

---------------------------------------------

code_0FE413 {
    COP [AA] ( #00 )

  loc_0FE416:
    COP [AD] ( #08 )
    COP [9B] ( #$0000, &code_0FE423, &code_0FE441, &code_0FE441 )
}

code_0FE423 {
    COP [97]
    COP [9B] ( #$0018, &code_0FE42F, &code_0FE4C0, &code_0FE42F )
}

code_0FE42F {
    COP [21] ( &code_0FE43A )
    COP [80] ( #08 )
    COP [82]
    BRA loc_0FE416
}

code_0FE43A {
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FE416
}

code_0FE441 {
    COP [97]
    COP [9B] ( #$0018, &code_0FE44D, &code_0FE4A8, &code_0FE44D )
}

code_0FE44D {
    COP [22] ( &code_0FE458 )
    COP [80] ( #06 )
    COP [82]
    BRA loc_0FE416
}

code_0FE458 {
    COP [80] ( #00 )
    COP [82]
    BRA loc_0FE416

  loc_0FE45F:
    COP [AD] ( #08 )
    COP [9A] ( #$0000, &code_0FE46C, &code_0FE48A, &code_0FE48A )
}

code_0FE46C {
    COP [9A] ( #$0018, &code_0FE476, &code_0FE4D9, &code_0FE476 )
}

code_0FE476 {
    COP [97]
    COP [23] ( &code_0FE483 )
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FE45F
}

code_0FE483 {
    COP [80] ( #04 )
    COP [82]
    BRA loc_0FE45F
}

code_0FE48A {
    COP [9A] ( #$0018, &code_0FE494, &code_0FE4D9, &code_0FE494 )
}

code_0FE494 {
    COP [96]
    COP [24] ( &code_0FE4A1 )
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FE45F
}

code_0FE4A1 {
    COP [80] ( #04 )
    COP [82]
    BRA loc_0FE45F
}

code_0FE4A8 {
    BRK #$41
    COP [80] ( #0C )
    COP [82]
    COP [B0] ( @code_0FE4B8, #$0200 )
    BRA loc_0FE45F
}

code_0FE4B8 {
    COP [80] ( #19 )
    COP [82]
    COP [86]
    RTL 
}

code_0FE4C0 {
    BRK #$41
    COP [80] ( #0D )
    COP [82]
    COP [B0] ( @code_0FE4D1, #$0200 )
    BRL loc_0FE45F
}

code_0FE4D1 {
    COP [80] ( #1A )
    COP [82]
    COP [86]
    RTL 
}

code_0FE4D9 {
    BRK #$41
    COP [80] ( #0E )
    COP [82]
    COP [B0] ( @code_0FE4EA, #$0200 )
    BRL loc_0FE416
}

code_0FE4EA {
    COP [80] ( #1B )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

code_0FE4F2 {
    COP [AA] ( #02 )

  loc_0FE4F5:
    COP [AD] ( #08 )
    COP [9B] ( #$0000, &code_0FE502, &code_0FE520, &code_0FE520 )
}

code_0FE502 {
    COP [97]
    COP [9B] ( #$0018, &code_0FE50E, &code_0FE5B2, &code_0FE50E )
}

code_0FE50E {
    COP [21] ( &code_0FE519 )
    COP [80] ( #08 )
    COP [82]
    BRA loc_0FE4F5
}

code_0FE519 {
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FE4F5
}

code_0FE520 {
    COP [97]
    COP [9B] ( #$0018, &code_0FE52C, &code_0FE587, &code_0FE52C )
}

code_0FE52C {
    COP [22] ( &code_0FE537 )
    COP [80] ( #06 )
    COP [82]
    BRA loc_0FE4F5
}

code_0FE537 {
    COP [80] ( #00 )
    COP [82]
    BRA loc_0FE4F5

  loc_0FE53E:
    COP [AD] ( #08 )
    COP [9A] ( #$0000, &code_0FE54B, &code_0FE569, &code_0FE569 )
}

code_0FE54B {
    COP [9A] ( #$0018, &code_0FE555, &code_0FE5DE, &code_0FE555 )
}

code_0FE555 {
    COP [97]
    COP [23] ( &code_0FE562 )
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FE53E
}

code_0FE562 {
    COP [80] ( #04 )
    COP [82]
    BRA loc_0FE53E
}

code_0FE569 {
    COP [9A] ( #$0018, &code_0FE573, &code_0FE5DE, &code_0FE573 )
}

code_0FE573 {
    COP [96]
    COP [24] ( &code_0FE580 )
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FE53E
}

code_0FE580 {
    COP [80] ( #04 )
    COP [82]
    BRA loc_0FE53E
}

code_0FE587 {
    BRK #$52
    COP [80] ( #0F )
    COP [82]
    COP [B0] ( @code_0FE59C, #$0200 )
    COP [80] ( #10 )
    COP [82]
    BRA loc_0FE53E
}

code_0FE59C {
    COP [A3]
    COP [9A] ( #$0000, &code_0FE5AA, &code_0FE5A8, &code_0FE5A8 )
}

code_0FE5A8 {
    COP [96]
}

code_0FE5AA {
    COP [80] ( #15 )
    COP [82]
    COP [86]
    RTL 
}

code_0FE5B2 {
    BRK #$52
    COP [80] ( #11 )
    COP [82]
    COP [B0] ( @code_0FE5C8, #$0200 )
    COP [80] ( #12 )
    COP [82]
    BRL loc_0FE53E
}

code_0FE5C8 {
    COP [A3]
    COP [9A] ( #$0000, &code_0FE5D6, &code_0FE5D4, &code_0FE5D4 )
}

code_0FE5D4 {
    COP [96]
}

code_0FE5D6 {
    COP [80] ( #18 )
    COP [82]
    COP [86]
    RTL 
}

code_0FE5DE {
    BRK #$52
    COP [80] ( #13 )
    COP [82]
    COP [B0] ( @code_0FE5F4, #$0200 )
    COP [80] ( #14 )
    COP [82]
    BRL loc_0FE4F5
}

code_0FE5F4 {
    COP [A3]
    COP [9B] ( #$0000, &code_0FE600, &code_0FE608, &code_0FE608 )
}

code_0FE600 {
    COP [80] ( #17 )
    COP [82]
    COP [86]
    RTL 
}

code_0FE608 {
    COP [80] ( #16 )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

code_0FE610 {
    COP [80] ( #1C )
    COP [82]
    COP [AD] ( #08 )
    BRA code_0FE610
}
---------------------------------------------

code_0FE61A {
    COP [A5] ( &code_0FE624, &code_0FE670, &code_0FE6BC, &code_0FE70A )
}

code_0FE624 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE632

  code_0FE62C:
    COP [1B] ( &code_0FE624, #$0078 )

  loc_0FE632:
    COP [0C] ( #00, #07, &code_0FE63A )
    BRA code_0FE62C
}

code_0FE63A {
    COP [9B] ( #$0010, &code_0FE62C, &code_0FE62C, &code_0FE644 )
}

code_0FE644 {
    COP [28] ( &code_0FE64C )
    COP [27] ( &code_0FE62C )
}

code_0FE64C {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #1D )
    COP [82]
    COP [B2] ( @code_0FE756, #$0000, #$0010, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FE62C
}

code_0FE670 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE67E

  code_0FE678:
    COP [1B] ( &code_0FE670, #$0078 )

  loc_0FE67E:
    COP [0C] ( #00, #07, &code_0FE686 )
    BRA code_0FE678
}

code_0FE686 {
    COP [9A] ( #$0010, &code_0FE690, &code_0FE678, &code_0FE678 )
}

code_0FE690 {
    COP [28] ( &code_0FE698 )
    COP [27] ( &code_0FE678 )
}

code_0FE698 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #1F )
    COP [82]
    COP [B2] ( @code_0FE756, #$FFF0, #$0000, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FE678
}

code_0FE6BC {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE6CA

  code_0FE6C4:
    COP [1B] ( &code_0FE6BC, #$0078 )

  loc_0FE6CA:
    COP [0C] ( #00, #07, &code_0FE6D2 )
    BRA code_0FE6C4
}

code_0FE6D2 {
    COP [9A] ( #$0010, &code_0FE6C4, &code_0FE6C4, &code_0FE6DC )
}

code_0FE6DC {
    COP [28] ( &code_0FE6E4 )
    COP [27] ( &code_0FE6C4 )
}

code_0FE6E4 {
    COP [96]
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #1F )
    COP [82]
    COP [B2] ( @code_0FE756, #$0010, #$0000, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FE6C4
}

code_0FE70A {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE718

  code_0FE712:
    COP [1B] ( &code_0FE70A, #$0078 )

  loc_0FE718:
    COP [0C] ( #00, #07, &code_0FE720 )
    BRA code_0FE712
}

code_0FE720 {
    COP [9B] ( #$0010, &code_0FE72A, &code_0FE712, &code_0FE712 )
}

code_0FE72A {
    COP [28] ( &code_0FE732 )
    COP [27] ( &code_0FE712 )
}

code_0FE732 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #1E )
    COP [82]
    COP [B2] ( @code_0FE756, #$0000, #$FFF0, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA code_0FE712
}

code_0FE756 {
    COP [A3]
    BRK #$64
    LDY #$0020
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.code_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.code_002D67-1
    PHA 
    RTL 
}
---------------------------------------------

code_0FE76C {
    LDA $0016, X
    ORA #$2000
    STA $0016, X

  code_0FE775:
    COP [28] ( &code_0FE77B )
    BRA loc_0FE781
}

code_0FE77B {
    COP [1B] ( &code_0FE775, #$0008 )

  loc_0FE781:
    LDA $0016, X
    AND #$DFFF
    STA $0016, X

  code_0FE78A:
    COP [AD] ( #08 )
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [15]
    COP [97]
    COP [03] ( #32 )
    COP [0C] ( #00, #01, &code_0FE7E1 )
    COP [80] ( #25 )
    COP [82]
    COP [04]
    COP [80] ( #29 )
    COP [82]
    COP [16]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FE7CC
    DEC 
    BEQ loc_0FE7D3
    DEC 
    BEQ loc_0FE7DA
    COP [96]

  loc_0FE7CC:
    COP [80] ( #28 )
    COP [82]
    BRA code_0FE78A

  loc_0FE7D3:
    COP [80] ( #27 )
    COP [82]
    BRA code_0FE78A

  loc_0FE7DA:
    COP [80] ( #26 )
    COP [82]
    BRA code_0FE78A
}

code_0FE7E1 {
    COP [81] ( #25, #0A )
    COP [83]
    COP [16]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X

  code_0FE7F2:
    COP [1B] ( &code_0FE7F8, #$0008 )
}

code_0FE7F8 {
    COP [9C] ( &code_0FE7FE, &code_0FE808 )
}

code_0FE7FE {
    COP [9A] ( #$0008, &code_0FE828, &code_0FE808, &code_0FE833 )
}

code_0FE808 {
    COP [9B] ( #$0008, &code_0FE812, &code_0FE7F2, &code_0FE81D )
}

code_0FE812 {
    COP [97]
    COP [9D] ( #2B )
    COP [9E] ( &code_0FE78A )

  loc_0FE81B:
    BRA code_0FE7F2
}

code_0FE81D {
    COP [97]
    COP [9D] ( #2A )
    COP [9E] ( &code_0FE78A )

  loc_0FE826:
    BRA code_0FE7F2
}

code_0FE828 {
    COP [97]
    COP [9D] ( #2C )
    COP [9E] ( &code_0FE78A )

  loc_0FE831:
    BRA code_0FE7F2
}

code_0FE833 {
    COP [96]
    COP [9D] ( #2C )
    COP [9E] ( &code_0FE78A )

  loc_0FE83C:
    BRA code_0FE7F2
}
---------------------------------------------

code_0FE83E {
    COP [AD] ( #08 )

  loc_0FE841:
    COP [80] ( #2E )
    COP [82]
    COP [80] ( #30 )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    COP [96]
    COP [80] ( #2F )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    COP [96]
    COP [80] ( #30 )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    COP [97]
    COP [80] ( #2F )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    COP [80] ( #30 )
    COP [82]
    COP [96]
    COP [80] ( #30 )
    COP [82]
    COP [80] ( #2F )
    COP [82]
    COP [97]
    COP [80] ( #2F )
    COP [82]
    BRA loc_0FE841
}
---------------------------------------------

code_0FE88E {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE89C
    COP [1B] ( &code_0FE88E, #$0008 )

  loc_0FE89C:
    COP [9A] ( #$0000, &code_0FE8A6, &code_0FE8B0, &code_0FE8B0 )
}

code_0FE8A6 {
    COP [9B] ( #$0000, &code_0FE936, &code_0FE90E, &code_0FE90E )
}

code_0FE8B0 {
    COP [9B] ( #$0000, &code_0FE8BA, &code_0FE8E4, &code_0FE8E4 )
}

code_0FE8BA {
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE8D3
    COP [97]
    COP [AE] ( #$0010, #$FFE0, &code_0FE990 )
    COP [80] ( #43 )
    COP [82]
    BRL code_0FE990

  loc_0FE8D3:
    COP [96]
    COP [AE] ( #$0020, #$FFF0, &code_0FE95D )
    COP [80] ( #45 )
    COP [82]
    BRA code_0FE95D
}

code_0FE8E4 {
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE8FC
    COP [96]
    COP [AE] ( #$0020, #$0010, &code_0FE95D )
    COP [80] ( #44 )
    COP [82]
    BRA code_0FE95D

  loc_0FE8FC:
    COP [97]
    COP [AE] ( #$0010, #$0020, &code_0FE9C3 )
    COP [80] ( #41 )
    COP [82]
    BRL code_0FE9C3
}

code_0FE90E {
    COP [97]
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE927
    COP [AE] ( #$FFF0, #$0020, &code_0FE9C3 )
    COP [80] ( #40 )
    COP [82]
    BRL code_0FE9C3

  loc_0FE927:
    COP [AE] ( #$FFE0, #$0010, &code_0FE95D )
    COP [80] ( #44 )
    COP [82]
    BRA code_0FE95D
}

code_0FE936 {
    COP [97]
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE94E
    COP [AE] ( #$FFE0, #$FFF0, &code_0FE95D )
    COP [80] ( #45 )
    COP [82]
    BRA code_0FE95D

  loc_0FE94E:
    COP [AE] ( #$FFF0, #$FFE0, &code_0FE990 )
    COP [80] ( #42 )
    COP [82]
    BRA code_0FE990
}

code_0FE95D {
    COP [81] ( #3F, #04 )
    COP [83]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #4C )
    COP [82]
    JSR $&code_0FE9F6
    COP [80] ( #4D )
    COP [82]
    COP [80] ( #4E )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #3F, #04 )
    COP [83]
    BRL code_0FE88E
}

code_0FE990 {
    COP [81] ( #3E, #04 )
    COP [83]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #49 )
    COP [82]
    JSR $&code_0FE9F6
    COP [80] ( #4A )
    COP [82]
    COP [80] ( #4B )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #3E, #04 )
    COP [83]
    BRL code_0FE88E
}

code_0FE9C3 {
    COP [81] ( #3D, #04 )
    COP [83]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #46 )
    COP [82]
    JSR $&code_0FE9F6
    COP [80] ( #47 )
    COP [82]
    COP [80] ( #48 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #3D, #04 )
    COP [83]
    BRL code_0FE88E
}

code_0FE9F6 {
    COP [B2] ( @code_0FEA0D, #$0000, #$0010, #$0200 )
    COP [B2] ( @code_0FEA15, #$FFF0, #$0000, #$0200 )
    RTS 
}

code_0FEA0D {
    COP [80] ( #4F )
    COP [82]
    COP [86]
    RTL 
}

code_0FEA15 {
    COP [80] ( #50 )
    COP [82]
    COP [86]
    RTL 
}