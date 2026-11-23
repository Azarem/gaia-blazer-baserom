?BANK 00

---------------------------------------------

code_004102 {
    COP [14] ( #$00B6, &code_00419D )

  loc_004108:
    COP [AD] ( #08 )
    COP [0C] ( #00, #03, &code_004118 )
    COP [80] ( #1A )
    COP [82]
    BRA loc_004108
}

code_004118 {
    BRK #$A1
    COP [B0] ( @code_004281, #$0200 )
    COP [B0] ( @code_004289, #$0200 )
    COP [B0] ( @code_004291, #$0200 )
    STZ $0016, X
    COP [80] ( #0B )
    COP [82]

  loc_004137:
    COP [AD] ( #08 )
    COP [0C] ( #00, #04, &code_004147 )

  code_004140:
    COP [80] ( #2A )
    COP [82]
    BRA loc_004137
}

code_004147 {
    COP [9C] ( &code_00414D, &code_004175 )
}

code_00414D {
    COP [9A] ( #$0010, &code_004157, &code_004166, &code_004166 )
}

code_004157 {
    COP [23] ( &code_004140 )
    COP [97]
    COP [99]
    COP [80] ( #0D )
    COP [82]
    BRA code_004140
}

code_004166 {
    COP [24] ( &code_004140 )
    COP [96]
    COP [99]
    COP [80] ( #0D )
    COP [82]
    BRA code_004140
}

code_004175 {
    COP [9B] ( #$0010, &code_00417F, &code_00418E, &code_00418E )
}

code_00417F {
    COP [21] ( &code_004140 )
    COP [97]
    COP [98]
    COP [80] ( #0C )
    COP [82]
    BRA code_004140
}

code_00418E {
    COP [22] ( &code_004140 )
    COP [97]
    COP [99]
    COP [80] ( #0C )
    COP [82]
    BRA code_004140
}

code_00419D {
    COP [86]
    RTL 
}
---------------------------------------------

code_0041A0 {
    COP [14] ( #$00B6, &code_004245 )
    COP [A0] ( #$FFF8 )
    LDA $001A, X
    ORA #$0100
    STA $001A, X

  loc_0041B3:
    COP [AD] ( #08 )
    COP [9B] ( #$0040, &code_0041C0, &code_0041C7, &code_0041C0 )
}

code_0041C0 {
    COP [80] ( #23 )
    COP [82]
    BRA loc_0041B3
}

code_0041C7 {
    COP [AD] ( #08 )
    COP [80] ( #05 )
    COP [82]
    SEP #$20
    LDA #$63
    STA $0025, X
    REP #$20
    LDA $0016, X
    AND #$FDFF
    STA $0016, X

  loc_0041E1:
    COP [03] ( #0F )
    LDA $0025, X
    AND #$00FF
    CMP #$0063
    BCC loc_004218
    COP [9B] ( #$0010, &code_0041F9, &code_004200, &code_0041F9 )
}

code_0041F9 {
    COP [80] ( #06 )
    COP [82]
    COP [04]
}

code_004200 {
    COP [80] ( #07 )
    COP [82]
    COP [B0] ( @code_004231, #$0200 )
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    BRA loc_0041E1

  loc_004218:
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #09 )
    COP [82]
    COP [80] ( #23 )
    COP [82]
    COP [1B] ( &code_0041C7, #$012C )
}

code_004231 {
    COP [8F]
    BRK #$5B

  loc_004235:
    COP [80] ( #13 )
    COP [82]
    COP [1C] ( #$8000, &code_004242 )
    BRA loc_004235
}

code_004242 {
    COP [86]
    RTL 
}

code_004245 {
    COP [86]
    RTL 
}
---------------------------------------------

code_004248 {
    COP [A4]
    COP [16]
    COP [14] ( #$00B6, &code_00427E )

  code_004252:
    COP [9B] ( #$0030, &code_004262, &code_00425C, &code_00425C )
}

code_00425C {
    COP [1B] ( &code_004252, #$0008 )
}

code_004262 {
    BRK #$A1
    COP [B0] ( @code_004281, #$0200 )
    COP [B0] ( @code_004289, #$0200 )
    COP [B0] ( @code_004291, #$0200 )
    COP [15]
    COP [86]
    RTL 
}

code_00427E {
    COP [91]
    RTL 
}
---------------------------------------------

code_004281 {
    COP [80] ( #1B )
    COP [82]
    COP [86]
    RTL 
}

code_004289 {
    COP [80] ( #1C )
    COP [82]
    COP [86]
    RTL 
}

code_004291 {
    COP [80] ( #1D )
    COP [82]
    COP [86]
    RTL 
}