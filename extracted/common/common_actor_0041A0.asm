?BANK 00

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