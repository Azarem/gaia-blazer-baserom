?BANK 1F

---------------------------------------------

code_0FBD12 {
    COP [A5] ( &code_0FBD1C, &code_0FBD23, &code_0FBD2A, &code_0FBD33 )
}

code_0FBD1C {
    COP [80] ( #08 )
    COP [82]
    BRA loc_0FBD38
}

code_0FBD23 {
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FBD38
}

code_0FBD2A {
    COP [96]
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FBD38
}

code_0FBD33 {
    COP [80] ( #09 )
    COP [82]

  loc_0FBD38:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FBD41, &code_0FBDC2 )
}

code_0FBD41 {
    COP [9A] ( #$0000, &code_0FBD4B, &code_0FBD86, &code_0FBD86 )
}

code_0FBD4B {
    COP [97]
    COP [80] ( #0A )
    COP [82]

  code_0FBD52:
    COP [80] ( #0D )
    COP [82]
    COP [9A] ( #$0000, &code_0FBD52, &code_0FBD61, &code_0FBD61 )
}

code_0FBD61 {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @code_0FBE44, #$FFF8, #$0008, #$0200 )
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #0A, #02 )
    COP [83]
    BRA loc_0FBD38
}

code_0FBD86 {
    COP [96]
    COP [80] ( #0A )
    COP [82]

  code_0FBD8D:
    COP [80] ( #0D )
    COP [82]
    COP [9A] ( #$0000, &code_0FBD9C, &code_0FBD9C, &code_0FBD8D )
}

code_0FBD9C {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @code_0FBE44, #$FFF8, #$0008, #$0200 )
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #0A, #02 )
    COP [83]
    BRL loc_0FBD38
}

code_0FBDC2 {
    COP [9B] ( #$0000, &code_0FBDCC, &code_0FBE08, &code_0FBE08 )
}

code_0FBDCC {
    COP [97]
    COP [80] ( #09 )
    COP [82]

  code_0FBDD3:
    COP [80] ( #0C )
    COP [82]
    COP [9B] ( #$0000, &code_0FBDD3, &code_0FBDE2, &code_0FBDE2 )
}

code_0FBDE2 {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @code_0FBE44, #$FFF8, #$0008, #$0200 )
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #09, #02 )
    COP [83]
    BRL loc_0FBD38
}

code_0FBE08 {
    COP [97]
    COP [80] ( #08 )
    COP [82]

  code_0FBE0F:
    COP [80] ( #0B )
    COP [82]
    COP [9B] ( #$0000, &code_0FBE1E, &code_0FBE1E, &code_0FBE0F )
}

code_0FBE1E {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @code_0FBE44, #$FFF8, #$0008, #$0200 )
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #08, #02 )
    COP [83]
    BRL loc_0FBD38
}

code_0FBE44 {
    COP [A3]
    COP [97]
    COP [99]
    COP [81] ( #10, #08 )
    COP [83]
    BRK #$4B
    COP [9C] ( &code_0FBE58, &code_0FBE62 )
}

code_0FBE58 {
    COP [9A] ( #$0000, &code_0FBE78, &code_0FBE76, &code_0FBE76 )
}

code_0FBE62 {
    COP [9B] ( #$0000, &code_0FBE6C, &code_0FBE6E, &code_0FBE6E )
}

code_0FBE6C {
    COP [98]
}

code_0FBE6E {
    COP [81] ( #0E, #20 )
    COP [83]
    BRA loc_0FBE7E
}

code_0FBE76 {
    COP [96]
}

code_0FBE78 {
    COP [81] ( #0F, #20 )
    COP [83]

  loc_0FBE7E:
    COP [86]
    RTL 
}