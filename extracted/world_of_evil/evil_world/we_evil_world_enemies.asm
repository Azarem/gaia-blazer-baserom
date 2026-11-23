?BANK 1F

?INCLUDE 'data_engine_tables'
?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'shared_actor_helpers_bank0'

!tile_type_map                  7F8000

---------------------------------------------

code_0FEA1D {
    COP [AD] ( #08 )
    COP [9B] ( #$0000, &code_0FEA2A, &code_0FEA48, &code_0FEA48 )
}

code_0FEA2A {
    COP [97]
    COP [9B] ( #$0018, &code_0FEA36, &code_0FEAE9, &code_0FEA36 )
}

code_0FEA36 {
    COP [21] ( &code_0FEA41 )
    COP [80] ( #04 )
    COP [82]
    BRA code_0FEA1D
}

code_0FEA41 {
    COP [80] ( #01 )
    COP [82]
    BRA code_0FEA1D
}

code_0FEA48 {
    COP [97]
    COP [9B] ( #$0018, &code_0FEA54, &code_0FEB23, &code_0FEA54 )
}

code_0FEA54 {
    COP [22] ( &code_0FEA5F )
    COP [80] ( #03 )
    COP [82]
    BRA code_0FEA1D
}

code_0FEA5F {
    COP [80] ( #00 )
    COP [82]
    BRA code_0FEA1D

  loc_0FEA66:
    COP [AD] ( #08 )
    COP [9A] ( #$0000, &code_0FEA73, &code_0FEA91, &code_0FEA91 )
}

code_0FEA73 {
    COP [9A] ( #$0018, &code_0FEA7D, &code_0FEAAF, &code_0FEA7D )
}

code_0FEA7D {
    COP [97]
    COP [23] ( &code_0FEA8A )
    COP [80] ( #05 )
    COP [82]
    BRA loc_0FEA66
}

code_0FEA8A {
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FEA66
}

code_0FEA91 {
    COP [9A] ( #$0018, &code_0FEA9B, &code_0FEAAF, &code_0FEA9B )
}

code_0FEA9B {
    COP [96]
    COP [24] ( &code_0FEAA8 )
    COP [80] ( #05 )
    COP [82]
    BRA loc_0FEA66
}

code_0FEAA8 {
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FEA66
}

code_0FEAAF {
    COP [9B] ( #$0000, &code_0FEAB9, &code_0FEAD1, &code_0FEAD1 )
}

code_0FEAB9 {
    COP [80] ( #0E )
    COP [82]
    COP [B2] ( @code_0FEB7B, #$FFF8, #$FFE8, #$0200 )
    COP [80] ( #0F )
    COP [82]
    BRL code_0FEA1D
}

code_0FEAD1 {
    COP [80] ( #10 )
    COP [82]
    COP [B2] ( @code_0FEB88, #$FFF8, #$0008, #$0200 )
    COP [80] ( #11 )
    COP [82]
    BRL code_0FEA1D
}

code_0FEAE9 {
    COP [9A] ( #$0000, &code_0FEAF3, &code_0FEB0B, &code_0FEB0B )
}

code_0FEAF3 {
    COP [80] ( #0C )
    COP [82]
    COP [B2] ( @code_0FEB5D, #$FFF8, #$0008, #$0200 )
    COP [80] ( #0D )
    COP [82]
    BRL loc_0FEA66
}

code_0FEB0B {
    COP [80] ( #0A )
    COP [82]
    COP [B2] ( @code_0FEB6C, #$0018, #$0008, #$0200 )
    COP [80] ( #0B )
    COP [82]
    BRL loc_0FEA66
}

code_0FEB23 {
    COP [9A] ( #$0000, &code_0FEB2D, &code_0FEB45, &code_0FEB45 )
}

code_0FEB2D {
    COP [80] ( #06 )
    COP [82]
    COP [B2] ( @code_0FEB5D, #$FFF8, #$0008, #$0200 )
    COP [80] ( #07 )
    COP [82]
    BRL loc_0FEA66
}

code_0FEB45 {
    COP [80] ( #08 )
    COP [82]
    COP [B2] ( @code_0FEB6C, #$0018, #$0008, #$0200 )
    COP [80] ( #09 )
    COP [82]
    BRL loc_0FEA66
}

code_0FEB5D {
    COP [A3]
    COP [97]
    BRK #$52
    COP [81] ( #14, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0FEB6C {
    COP [A3]
    COP [96]
    BRK #$52
    COP [81] ( #14, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0FEB7B {
    COP [A3]
    BRK #$52
    COP [81] ( #13, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0FEB88 {
    COP [A3]
    BRK #$52
    COP [81] ( #12, #08 )
    COP [83]
    COP [86]
    RTL 
}
---------------------------------------------

code_0FEB95 {
    COP [AD] ( #10 )

  loc_0FEB98:
    COP [9A] ( #$0018, &code_0FEBA2, &code_0FEBB6, &code_0FEBAC )
}

code_0FEBA2 {
    COP [9B] ( #$0018, &code_0FEBC4, &code_0FECA3, &code_0FEBFD )
}

code_0FEBAC {
    COP [9B] ( #$0018, &code_0FEBC0, &code_0FEC9F, &code_0FEBF9 )
}

code_0FEBB6 {
    COP [9B] ( #$0000, &code_0FEC69, &code_0FEC33, &code_0FEC33 )
}

code_0FEBC0 {
    COP [96]
    BRA loc_0FEBC6
}

code_0FEBC4 {
    COP [97]

  loc_0FEBC6:
    COP [80] ( #26 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #27 )
    COP [82]
    COP [81] ( #28, #04 )
    COP [83]
    COP [80] ( #27 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #19 )
    COP [82]
    BRA loc_0FEB98
}

code_0FEBF9 {
    COP [96]
    BRA loc_0FEBFF
}

code_0FEBFD {
    COP [97]

  loc_0FEBFF:
    COP [80] ( #23 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #24 )
    COP [82]
    COP [81] ( #25, #04 )
    COP [83]
    COP [80] ( #24 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #23 )
    COP [82]
    COP [80] ( #18 )
    COP [82]
    BRL loc_0FEB98
}

code_0FEC33 {
    COP [97]
    COP [80] ( #1A )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #1B )
    COP [82]
    COP [81] ( #1C, #04 )
    COP [83]
    COP [80] ( #1B )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #1A )
    COP [82]
    COP [80] ( #15 )
    COP [82]
    BRL loc_0FEB98
}

code_0FEC69 {
    COP [97]
    COP [80] ( #1D )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #1E )
    COP [82]
    COP [81] ( #1F, #04 )
    COP [83]
    COP [80] ( #1E )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #16 )
    COP [82]
    BRL loc_0FEB98
}

code_0FEC9F {
    COP [96]
    BRA loc_0FECA5
}

code_0FECA3 {
    COP [97]

  loc_0FECA5:
    COP [80] ( #20 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #21 )
    COP [82]
    COP [81] ( #22, #04 )
    COP [83]
    COP [80] ( #21 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #17 )
    COP [82]
    BRL loc_0FEB98
}
---------------------------------------------

code_0FECD9 {
    LDA $001A, X
    ORA #$0200
    STA $001A, X
    COP [A5] ( &code_0FECEC, &code_0FECF9, &code_0FED06, &code_0FED06 )
}

code_0FECEC {
    COP [99]

  loc_0FECEE:
    COP [22] ( &code_0FECF9 )
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FECEE
}

code_0FECF9 {
    COP [98]

  loc_0FECFB:
    COP [21] ( &code_0FECEC )
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FECFB
}

code_0FED06 {
    COP [86]
    RTL 
}
---------------------------------------------

code_0FED09 {
    PHX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    TXA 
    PLX 
    STA $0030, X
    COP [A1] ( #$0008, #$FFF1 )

  code_0FED27:
    COP [AD] ( #10 )
    PHX 
    LDA $0030, X
    TAX 
    LDA $tile_type_map, X
    PLX 
    AND #$00FF
    BEQ loc_0FED6E
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #2C )
    COP [82]
    COP [A0] ( #$0008 )
    COP [B2] ( @code_0FED71, #$0000, #$0000, #$0200 )
    COP [80] ( #2D )
    COP [82]
    COP [A0] ( #$FFF8 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [1B] ( &code_0FED27, #$0078 )

  loc_0FED6E:
    COP [86]
    RTL 
}

code_0FED71 {
    COP [A3]
    BRK #$64
    COP [80] ( #2B )
    COP [82]
    COP [81] ( #2E, #04 )
    COP [83]
    LDY #$002E
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.code_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.code_002D67-1
    PHA 
    RTL 
}
---------------------------------------------

code_0FED8F {
    COP [A5] ( &code_0FED99, &code_0FEDC8, &code_0FEDF7, &code_0FEE26 )
}

code_0FED99 {
    COP [AD] ( #10 )
    COP [1B] ( &code_0FEDA2, #$0078 )
}

code_0FEDA2 {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @code_0FEE55, #$0200 )
    LDA $0030, X
    CLC 
    ADC $0000, Y
    STA $0000, Y
    JSR $&code_0FEE5D
    COP [1B] ( &code_0FEDC4, #$0001 )
}

code_0FEDC4 {
    COP [04]
    BRA code_0FED99
}

code_0FEDC8 {
    COP [AD] ( #10 )
    COP [1B] ( &code_0FEDD1, #$0078 )
}

code_0FEDD1 {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @code_0FEE55, #$0200 )
    LDA $0000, Y
    SEC 
    SBC $0030, X
    STA $0000, Y
    JSR $&code_0FEE5D
    COP [1B] ( &code_0FEDF3, #$0001 )
}

code_0FEDF3 {
    COP [04]
    BRA code_0FEDC8
}

code_0FEDF7 {
    COP [AD] ( #10 )
    COP [1B] ( &code_0FEE00, #$0078 )
}

code_0FEE00 {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @code_0FEE55, #$0200 )
    LDA $0030, X
    CLC 
    ADC $0000, Y
    STA $0000, Y
    JSR $&code_0FEE83
    COP [1B] ( &code_0FEE22, #$0001 )
}

code_0FEE22 {
    COP [04]
    BRA code_0FEDF7
}

code_0FEE26 {
    COP [AD] ( #10 )
    COP [1B] ( &code_0FEE2F, #$0078 )
}

code_0FEE2F {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @code_0FEE55, #$0200 )
    LDA $0000, Y
    SEC 
    SBC $0030, X
    STA $0000, Y
    JSR $&code_0FEE83
    COP [1B] ( &code_0FEE51, #$0001 )
}

code_0FEE51 {
    COP [04]
    BRA code_0FEE26
}

code_0FEE55 {
    COP [80] ( #29 )
    COP [82]
    COP [86]
    RTL 
}

code_0FEE5D {
    PHY 
    LDY $0030, X
    LDA $&data_engine_tables.SineTable+10, Y
    PLY 
    AND #$00FF
    LSR 
    EOR #$FFFF
    INC 
    CLC 
    ADC $0002, Y
    CLC 
    ADC #$0008
    STA $0002, Y
    LDA $0030, X
    CLC 
    ADC #$0010
    STA $0030, X
    RTS 
}

code_0FEE83 {
    PHY 
    LDY $0030, X
    LDA $&data_engine_tables.SineTable+10, Y
    PLY 
    AND #$00FF
    LSR 
    CLC 
    ADC $0002, Y
    SEC 
    SBC #$0008
    STA $0002, Y
    LDA $0030, X
    CLC 
    ADC #$0010
    STA $0030, X
    RTS 
}
---------------------------------------------

code_0FEEA5 {
    RTL 
}