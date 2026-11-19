?BANK 1F

---------------------------------------------

code_0FAFAD {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAFBB
    COP [1B] ( &code_0FAFAD, #$0008 )

  loc_0FAFBB:
    COP [97]
    COP [80] ( #22 )
    COP [82]
    COP [9B] ( #$0010, &code_0FAFCC, &code_0FAFD6, &code_0FAFCC )
}

code_0FAFCC {
    COP [9A] ( #$0010, &code_0FAFAD, &code_0FAFF6, &code_0FAFAD )
}

code_0FAFD6 {
    COP [9A] ( #$0000, &code_0FAFE0, &code_0FAFEA, &code_0FAFEA )
}

code_0FAFE0 {
    COP [80] ( #23 )
    COP [82]
    LDA #$0029
    BRA loc_0FB014
}

code_0FAFEA {
    COP [80] ( #23 )
    COP [82]
    COP [96]
    LDA #$0029
    BRA loc_0FB014
}

code_0FAFF6 {
    COP [9B] ( #$0000, &code_0FB000, &code_0FB00A, &code_0FB00A )
}

code_0FB000 {
    COP [80] ( #23 )
    COP [82]
    LDA #$0028
    BRA loc_0FB014
}

code_0FB00A {
    COP [80] ( #23 )
    COP [82]
    LDA #$0027
    BRA loc_0FB014

  loc_0FB014:
    PHA 
    COP [84] ( @code_0FB02F )
    PLA 
    STA $001E, Y
    LDA #$0000
    STA $0020, Y
    COP [97]
    COP [81] ( #22, #04 )
    COP [83]
    BRL code_0FAFAD
}

code_0FB02F {
    LDA #$0200
    STA $0016, X
    COP [A2] ( #30 )
    COP [A3]
    COP [A0] ( #$FFFC )
    BRK #$64
    COP [91]

  loc_0FB042:
    COP [82]
    COP [1C] ( #$8000, &code_0FB04C )
    BRA loc_0FB042
}

code_0FB04C {
    COP [86]
    RTL 
}