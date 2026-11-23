?BANK 1F

---------------------------------------------

code_0FB680 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB68E
    COP [1B] ( &code_0FB680, #$0010 )

  loc_0FB68E:
    COP [80] ( #12 )
    COP [82]
    BRA code_0FB680
}
---------------------------------------------

code_0FB6F8 {
    COP [A5] ( &code_0FB702, &code_0FB767, &code_0FB7CC, &code_0FB833 )
}

code_0FB702 {
    COP [A0] ( #$0004 )

  code_0FB706:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB714

  code_0FB70E:
    COP [1B] ( &code_0FB706, #$0004 )

  loc_0FB714:
    COP [9B] ( #$0000, &code_0FB70E, &code_0FB71E, &code_0FB71E )
}

code_0FB71E {
    COP [9A] ( #$0040, &code_0FB70E, &code_0FB728, &code_0FB70E )
}

code_0FB728 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #13 )
    COP [82]
    COP [85] ( @code_0FB74A )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [1B] ( &code_0FB706, #$003C )
}

code_0FB74A {
    LDA #$0200
    STA $0016, X
    COP [A0] ( #$0008 )
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #14 )
    COP [82]
    COP [81] ( #17, #20 )
    COP [83]
    COP [86]
    RTL 
}

code_0FB767 {
    COP [9F] ( #$FFFC )

  code_0FB76B:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB779

  code_0FB773:
    COP [1B] ( &code_0FB76B, #$0004 )

  loc_0FB779:
    COP [9A] ( #$0000, &code_0FB783, &code_0FB783, &code_0FB773 )
}

code_0FB783 {
    COP [9B] ( #$0040, &code_0FB773, &code_0FB78D, &code_0FB773 )
}

code_0FB78D {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #13 )
    COP [82]
    COP [85] ( @code_0FB7AF )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [1B] ( &code_0FB76B, #$003C )
}

code_0FB7AF {
    LDA #$0200
    STA $0016, X
    COP [9F] ( #$FFF8 )
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #16 )
    COP [82]
    COP [81] ( #19, #20 )
    COP [83]
    COP [86]
    RTL 
}

code_0FB7CC {
    COP [9F] ( #$0004 )
    COP [96]

  code_0FB7D2:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB7E0

  code_0FB7DA:
    COP [1B] ( &code_0FB7D2, #$0004 )

  loc_0FB7E0:
    COP [9A] ( #$0000, &code_0FB7DA, &code_0FB7EA, &code_0FB7EA )
}

code_0FB7EA {
    COP [9B] ( #$0040, &code_0FB7DA, &code_0FB7F4, &code_0FB7DA )
}

code_0FB7F4 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #13 )
    COP [82]
    COP [85] ( @code_0FB816 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [1B] ( &code_0FB7D2, #$003C )
}

code_0FB816 {
    LDA #$0200
    STA $0016, X
    COP [9F] ( #$0008 )
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #16 )
    COP [82]
    COP [81] ( #19, #20 )
    COP [83]
    COP [86]
    RTL 
}

code_0FB833 {
    COP [A0] ( #$FFFC )

  code_0FB837:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB845

  code_0FB83F:
    COP [1B] ( &code_0FB837, #$0004 )

  loc_0FB845:
    COP [9B] ( #$0000, &code_0FB84F, &code_0FB84F, &code_0FB83F )
}

code_0FB84F {
    COP [9A] ( #$0040, &code_0FB83F, &code_0FB859, &code_0FB83F )
}

code_0FB859 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #13 )
    COP [82]
    COP [85] ( @code_0FB87B )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [1B] ( &code_0FB837, #$003C )
}

code_0FB87B {
    LDA #$0200
    STA $0016, X
    COP [A0] ( #$FFF0 )
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #15 )
    COP [82]
    COP [81] ( #18, #20 )
    COP [83]
    COP [86]
    RTL 
}