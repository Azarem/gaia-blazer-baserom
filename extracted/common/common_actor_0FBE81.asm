?BANK 1F

---------------------------------------------

code_0FBE81 {
    LDA $0025, X
    AND #$00FF
    STA $0030, X

  loc_0FBE8A:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FBE93, &code_0FBED3 )
}

code_0FBE93 {
    COP [9A] ( #$0000, &code_0FBE9D, &code_0FBEB8, &code_0FBEB8 )
}

code_0FBE9D {
    COP [97]
    COP [81] ( #16, #08 )
    COP [83]
    JSR $&code_0FBF13
    BCC loc_0FBE8A
    COP [81] ( #19, #04 )
    COP [83]
    COP [81] ( #13, #10 )
    COP [83]
    BRA loc_0FBE8A
}

code_0FBEB8 {
    COP [96]
    COP [81] ( #16, #08 )
    COP [83]
    JSR $&code_0FBF13
    BCC loc_0FBE8A
    COP [81] ( #19, #04 )
    COP [83]
    COP [81] ( #13, #10 )
    COP [83]
    BRA loc_0FBE8A
}

code_0FBED3 {
    COP [9B] ( #$0000, &code_0FBEDD, &code_0FBEF8, &code_0FBEF8 )
}

code_0FBEDD {
    COP [97]
    COP [81] ( #15, #08 )
    COP [83]
    JSR $&code_0FBF13
    BCC loc_0FBE8A
    COP [81] ( #18, #04 )
    COP [83]
    COP [81] ( #12, #10 )
    COP [83]
    BRA loc_0FBE8A
}

code_0FBEF8 {
    COP [97]
    COP [81] ( #14, #08 )
    COP [83]
    JSR $&code_0FBF13
    BCC loc_0FBE8A
    COP [81] ( #17, #04 )
    COP [83]
    COP [80] ( #11 )
    COP [82]
    BRL loc_0FBE8A
}

code_0FBF13 {
    LDA $0025, X
    AND #$00FF
    CMP $0030, X
    BEQ loc_0FBF23
    STA $0030, X
    SEC 
    RTS 

  loc_0FBF23:
    CLC 
    RTS 
}