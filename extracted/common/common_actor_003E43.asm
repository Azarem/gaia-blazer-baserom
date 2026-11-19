?BANK 00

!player_actor                   039C

---------------------------------------------

code_003E43 {
    INC $0458
    STX $039A

  code_003E49:
    COP [A3]
    COP [AD] ( #08 )
    COP [0C] ( #00, #04, &code_003E5A )
    COP [1B] ( &code_003E49, #$0008 )
}

code_003E5A {
    COP [80] ( #00 )
    COP [82]
    COP [85] ( @code_00409B )
    COP [B0] ( @code_003EC0, #$0200 )
    COP [AF] ( @code_003F3F, #$0201 )
    COP [AF] ( @code_003FEC, #$0201 )

  loc_003E79:
    COP [03] ( #04 )
    COP [97]
    COP [80] ( #01 )
    COP [82]
    COP [96]
    COP [80] ( #01 )
    COP [82]
    COP [04]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1E )
    COP [82]
    COP [09] ( #$8000 )
    COP [05] ( #$8000 )
    COP [80] ( #1F )
    COP [82]
    LDY $player_actor
    LDA $0000, Y
    CMP #$0080
    BCS loc_003EB7
    COP [97]
    COP [80] ( #21 )
    COP [82]
    BRA loc_003E79

  loc_003EB7:
    COP [96]
    COP [80] ( #21 )
    COP [82]
    BRA loc_003E79
}

code_003EC0 {
    COP [A3]

  loc_003EC2:
    COP [80] ( #22 )
    COP [82]
    COP [05] ( #$0000 )
    COP [80] ( #03 )
    COP [82]
    COP [AF] ( @code_003EE8, #$0200 )
    COP [1B] ( &code_003EDD, #$0018 )
}

code_003EDD {
    COP [80] ( #04 )
    COP [82]
    COP [09] ( #$0000 )
    BRA loc_003EC2
}

code_003EE8 {
    COP [A3]
    COP [A1] ( #$0008, #$FFFC )
    COP [80] ( #18 )
    COP [82]
    BRK #$51
    COP [B0] ( @code_003F14, #$0200 )
    COP [B0] ( @code_003F1D, #$0200 )
    COP [B0] ( @code_003F26, #$0200 )
    COP [80] ( #17 )
    COP [82]
    COP [86]
    RTL 
}

code_003F14 {
    COP [A3]
    COP [80] ( #16 )
    COP [82]
    BRA loc_003F2F
}

code_003F1D {
    COP [A3]
    COP [80] ( #15 )
    COP [82]
    BRA loc_003F2F
}

code_003F26 {
    COP [A3]
    COP [96]
    COP [80] ( #15 )
    COP [82]

  loc_003F2F:
    COP [80] ( #14 )
    COP [82]
    COP [1C] ( #$8000, &code_003F3C )
    BRA loc_003F2F
}

code_003F3C {
    COP [86]
    RTL 
}

code_003F3F {
    COP [A3]
    LDA $001A, X
    ORA #$0100
    STA $001A, X

  code_003F4A:
    COP [99]
    COP [97]
    LDA #$0030
    STA $0000, X
    LDA #$0070
    STA $0002, X
    COP [81] ( #25, #14 )
    COP [83]
    SEP #$20
    LDA #$63
    STA $0025, X
    REP #$20
    LDA $0016, X
    AND #$FCFF
    STA $0016, X

  loc_003F72:
    LDA $0025, X
    AND #$00FF
    CMP #$005A
    BCC loc_003FD7
    COP [9C] ( &code_003F83, &code_003FAD )
}

code_003F83 {
    COP [9A] ( #$0000, &code_003F8D, &code_003F9D, &code_003F9D )
}

code_003F8D {
    COP [97]
    COP [99]
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #29 )
    COP [82]
    BRA loc_003F72
}

code_003F9D {
    COP [96]
    COP [99]
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #12 )
    COP [82]
    BRA loc_003F72
}

code_003FAD {
    COP [9B] ( #$0000, &code_003FB7, &code_003FC7, &code_003FC7 )
}

code_003FB7 {
    COP [97]
    COP [98]
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    BRA loc_003F72
}

code_003FC7 {
    COP [97]
    COP [99]
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #28 )
    COP [82]
    BRA loc_003F72

  loc_003FD7:
    LDA $0016, X
    ORA #$0300
    STA $0016, X
    COP [81] ( #25, #14 )
    COP [83]
    COP [1B] ( &code_003F4A, #$012C )
}

code_003FEC {
    COP [A3]
    COP [96]
    LDA $001A, X
    ORA #$0100
    STA $001A, X

  code_003FF9:
    COP [99]
    COP [97]
    LDA #$00B0
    STA $0000, X
    LDA #$0070
    STA $0002, X
    COP [81] ( #0E, #14 )
    COP [83]
    SEP #$20
    LDA #$63
    STA $0025, X
    REP #$20
    LDA $0016, X
    AND #$FCFF
    STA $0016, X

  loc_004021:
    LDA $0025, X
    AND #$00FF
    CMP #$005A
    BCC loc_004086
    COP [9C] ( &code_004032, &code_00405C )
}

code_004032 {
    COP [9A] ( #$0000, &code_00403C, &code_00404C, &code_00404C )
}

code_00403C {
    COP [97]
    COP [99]
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #12 )
    COP [82]
    BRA loc_004021
}

code_00404C {
    COP [96]
    COP [99]
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #29 )
    COP [82]
    BRA loc_004021
}

code_00405C {
    COP [9B] ( #$0000, &code_004066, &code_004076, &code_004076 )
}

code_004066 {
    COP [97]
    COP [98]
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #28 )
    COP [82]
    BRA loc_004021
}

code_004076 {
    COP [97]
    COP [99]
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    BRA loc_004021

  loc_004086:
    LDA $0016, X
    ORA #$0300
    STA $0016, X
    COP [81] ( #0E, #14 )
    COP [83]
    COP [1B] ( &code_003FF9, #$012C )
}

code_00409B {
    LDA $003C, X
    STA $0002, X
    TAY 
    LDA $003C, Y
    STA $0000, X
    COP [91]
    PHX 
    COP [07] ( #$8000, &code_0040C4 )
    LDA $0000, X
    LDY $0002, X
    TAX 
    LDA $0000, X
    STA $0000, Y
    LDA $0002, X
    STA $0002, Y
}

code_0040C4 {
    PLX 
    PHX 
    LDA $0000, X
    LDY $0002, X
    TAX 
    LDA $0026, X
    STA $0026, Y
    LDA $0016, X
    BIT #$0400
    BNE loc_0040ED
    AND #$0800
    PHA 
    LDA $0016, Y
    AND #$F7FF
    ORA $01, S
    STA $0016, Y
    PLA 
    PLX 
    RTL 

  loc_0040ED:
    TYX 
    LDA #$&code_0040FB
    STA $0018, X
    STZ $0014, X
    PLX 
    COP [86]
    RTL 
}
---------------------------------------------

code_0040FB {
    STZ $0004, X
    STZ $0006, X
    RTL 
}