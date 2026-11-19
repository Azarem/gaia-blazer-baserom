?BANK 1F

?INCLUDE 'meta_tables_008000'

---------------------------------------------

code_0FB0F5 {
    COP [A5] ( &code_0FB0FF, &code_0FB172, &code_0FB1E5, &code_0FB25A )
}

code_0FB0FF {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB10D

  code_0FB107:
    COP [1B] ( &code_0FB0FF, #$0008 )

  loc_0FB10D:
    COP [9A] ( #$0030, &code_0FB107, &code_0FB117, &code_0FB107 )
}

code_0FB117 {
    COP [9B] ( #$0000, &code_0FB107, &code_0FB107, &code_0FB121 )
}

code_0FB121 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #03 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #00 )
    COP [82]
    COP [B2] ( @code_0FB2DB, #$0000, #$000C, #$0200 )
    COP [80] ( #09 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #04 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    JSR $&code_0FB2CD
    COP [1B] ( &code_0FB0FF, #$0078 )
}

code_0FB172 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB180

  code_0FB17A:
    COP [1B] ( &code_0FB172, #$0008 )

  loc_0FB180:
    COP [9B] ( #$0030, &code_0FB17A, &code_0FB18A, &code_0FB17A )
}

code_0FB18A {
    COP [9A] ( #$0000, &code_0FB194, &code_0FB17A, &code_0FB17A )
}

code_0FB194 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #07 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    COP [B2] ( @code_0FB2E8, #$FFF0, #$0000, #$0200 )
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #08 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    JSR $&code_0FB2CD
    COP [1B] ( &code_0FB172, #$0078 )
}

code_0FB1E5 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB1F3

  code_0FB1ED:
    COP [1B] ( &code_0FB1E5, #$0008 )

  loc_0FB1F3:
    COP [9B] ( #$0030, &code_0FB1ED, &code_0FB1FD, &code_0FB1ED )
}

code_0FB1FD {
    COP [9A] ( #$0000, &code_0FB1ED, &code_0FB1ED, &code_0FB207 )
}

code_0FB207 {
    COP [96]
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #07 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    COP [B2] ( @code_0FB2E8, #$0020, #$0000, #$0200 )
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #08 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    JSR $&code_0FB2CD
    COP [1B] ( &code_0FB1E5, #$0078 )
}

code_0FB25A {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB268

  code_0FB262:
    COP [1B] ( &code_0FB25A, #$0008 )

  loc_0FB268:
    COP [9A] ( #$0030, &code_0FB262, &code_0FB272, &code_0FB262 )
}

code_0FB272 {
    COP [9B] ( #$0000, &code_0FB27C, &code_0FB262, &code_0FB262 )
}

code_0FB27C {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #05 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #01 )
    COP [82]
    COP [B2] ( @code_0FB2F5, #$0000, #$FFE0, #$0200 )
    COP [80] ( #0A )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #06 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    JSR $&code_0FB2CD
    COP [1B] ( &code_0FB25A, #$0078 )
}

code_0FB2CD {
    SEP #$20
    LDY $0038, X
    LDA $&meta_tables_008000+2, Y
    STA $0025, X
    REP #$20
    RTS 
}

code_0FB2DB {
    COP [A3]
    BRK #$5B
    COP [81] ( #16, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0FB2E8 {
    COP [A3]
    BRK #$5B
    COP [81] ( #18, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0FB2F5 {
    COP [A3]
    BRK #$5B
    COP [81] ( #17, #08 )
    COP [83]
    COP [86]
    RTL 
}