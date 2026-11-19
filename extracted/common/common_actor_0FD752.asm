?BANK 1F

---------------------------------------------

code_0FD752 {
    COP [A5] ( &code_0FD75C, &code_0FD81C, &code_0FD7DC, &code_0FD79C )
}

code_0FD75C {
    JSR $&code_0FD85C
    COP [24] ( &code_0FD76B )
    COP [81] ( #2F, #04 )
    COP [83]
    BRA code_0FD75C
}

code_0FD76B {
    COP [1B] ( &code_0FD771, #$0000 )
}

code_0FD771 {
    COP [AD] ( #08 )
    COP [22] ( &code_0FD7CD )
    COP [81] ( #2C, #04 )
    COP [83]

  loc_0FD77E:
    JSR $&code_0FD85C
    COP [23] ( &code_0FD78D )
    COP [81] ( #2E, #04 )
    COP [83]
    BRA loc_0FD77E
}

code_0FD78D {
    COP [AD] ( #08 )
    COP [22] ( &code_0FD7AB )
    COP [81] ( #2C, #04 )
    COP [83]
    BRA code_0FD75C
}

code_0FD79C {
    JSR $&code_0FD85C
    COP [23] ( &code_0FD7AB )
    COP [81] ( #2E, #04 )
    COP [83]
    BRA code_0FD79C
}

code_0FD7AB {
    COP [1B] ( &code_0FD7B1, #$0000 )
}

code_0FD7B1 {
    COP [AD] ( #08 )
    COP [21] ( &code_0FD78D )
    COP [81] ( #2D, #04 )
    COP [83]

  loc_0FD7BE:
    JSR $&code_0FD85C
    COP [24] ( &code_0FD7CD )
    COP [81] ( #2F, #04 )
    COP [83]
    BRA loc_0FD7BE
}

code_0FD7CD {
    COP [AD] ( #08 )
    COP [21] ( &code_0FD76B )
    COP [81] ( #2D, #04 )
    COP [83]
    BRA code_0FD79C
}

code_0FD7DC {
    JSR $&code_0FD85C
    COP [22] ( &code_0FD7EB )
    COP [81] ( #2C, #04 )
    COP [83]
    BRA code_0FD7DC
}

code_0FD7EB {
    COP [1B] ( &code_0FD7F1, #$0000 )
}

code_0FD7F1 {
    COP [AD] ( #08 )
    COP [24] ( &code_0FD84D )
    COP [81] ( #2F, #04 )
    COP [83]

  loc_0FD7FE:
    JSR $&code_0FD85C
    COP [21] ( &code_0FD80D )
    COP [81] ( #2D, #04 )
    COP [83]
    BRA loc_0FD7FE
}

code_0FD80D {
    COP [AD] ( #08 )
    COP [24] ( &code_0FD82B )
    COP [81] ( #2F, #04 )
    COP [83]
    BRA code_0FD7DC
}

code_0FD81C {
    JSR $&code_0FD85C
    COP [21] ( &code_0FD82B )
    COP [81] ( #2D, #04 )
    COP [83]
    BRA code_0FD81C
}

code_0FD82B {
    COP [1B] ( &code_0FD831, #$0000 )
}

code_0FD831 {
    COP [AD] ( #08 )
    COP [23] ( &code_0FD80D )
    COP [81] ( #2E, #04 )
    COP [83]

  loc_0FD83E:
    JSR $&code_0FD85C
    COP [22] ( &code_0FD84D )
    COP [81] ( #2C, #04 )
    COP [83]
    BRA loc_0FD83E
}

code_0FD84D {
    COP [AD] ( #08 )
    COP [23] ( &code_0FD7EB )
    COP [81] ( #2E, #04 )
    COP [83]
    BRA code_0FD81C
}

code_0FD85C {
    COP [0C] ( #00, #02, &code_0FD863 )
    RTS 
}

code_0FD863 {
    PLA 
    STA $0030, X
    COP [80] ( #30 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    BRK #$56
    COP [B2] ( @code_0FD8E8, #$0000, #$0008, #$0200 )
    COP [B2] ( @code_0FD8FE, #$0010, #$FFF8, #$0200 )
    COP [B2] ( @code_0FD916, #$0000, #$FFE8, #$0200 )
    COP [B2] ( @code_0FD92A, #$FFF0, #$FFF8, #$0200 )
    COP [1B] ( &code_0FD8A9, #$0001 )
}

code_0FD8A9 {
    COP [B2] ( @code_0FD8F2, #$0010, #$0008, #$0200 )
    COP [B2] ( @code_0FD90A, #$0010, #$FFE8, #$0200 )
    COP [B2] ( @code_0FD920, #$FFF0, #$FFE8, #$0200 )
    COP [B2] ( @code_0FD934, #$FFF0, #$0008, #$0200 )
    COP [80] ( #31 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    LDA $0030, X
    PHA 
    RTS 
}

code_0FD8E8 {
    COP [A3]
    COP [81] ( #32, #03 )
    COP [83]
    BRA loc_0FD93C
}

code_0FD8F2 {
    COP [A3]
    COP [96]
    COP [81] ( #35, #03 )
    COP [83]
    BRA loc_0FD93C
}

code_0FD8FE {
    COP [A3]
    COP [96]
    COP [81] ( #34, #03 )
    COP [83]
    BRA loc_0FD93C
}

code_0FD90A {
    COP [A3]
    COP [96]
    COP [81] ( #36, #03 )
    COP [83]
    BRA loc_0FD93C
}

code_0FD916 {
    COP [A3]
    COP [81] ( #33, #03 )
    COP [83]
    BRA loc_0FD93C
}

code_0FD920 {
    COP [A3]
    COP [81] ( #36, #03 )
    COP [83]
    BRA loc_0FD93C
}

code_0FD92A {
    COP [A3]
    COP [81] ( #34, #03 )
    COP [83]
    BRA loc_0FD93C
}

code_0FD934 {
    COP [A3]
    COP [81] ( #35, #03 )
    COP [83]

  loc_0FD93C:
    COP [80] ( #37 )
    COP [82]
    COP [86]
    RTL 
}