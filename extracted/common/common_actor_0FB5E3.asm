?BANK 1F

---------------------------------------------

code_0FB5E3 {
    LDA $001A, X
    ORA #$0800
    STA $001A, X

  code_0FB5EC:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB5FA
    COP [1B] ( &code_0FB5EC, #$0010 )

  loc_0FB5FA:
    COP [A5] ( &code_0FB604, &code_0FB623, &code_0FB642, &code_0FB661 )
}

code_0FB604 {
    COP [97]
    COP [80] ( #0F )
    COP [82]

  loc_0FB60B:
    COP [AE] ( #$FFF0, #$FFF0, &code_0FB661 )
    COP [AE] ( #$0000, #$FFE0, &code_0FB623 )
    COP [81] ( #11, #04 )
    COP [83]
    BRA loc_0FB60B
}

code_0FB623 {
    COP [97]
    COP [80] ( #0F )
    COP [82]

  loc_0FB62A:
    COP [AE] ( #$FFF0, #$0000, &code_0FB642 )
    COP [AE] ( #$0000, #$0010, &code_0FB604 )
    COP [81] ( #10, #04 )
    COP [83]
    BRA loc_0FB62A
}

code_0FB642 {
    COP [96]
    COP [80] ( #0F )
    COP [82]

  loc_0FB649:
    COP [AE] ( #$0020, #$0000, &code_0FB623 )
    COP [AE] ( #$0010, #$0010, &code_0FB661 )
    COP [81] ( #10, #04 )
    COP [83]
    BRA loc_0FB649
}

code_0FB661 {
    COP [96]
    COP [80] ( #0F )
    COP [82]

  loc_0FB668:
    COP [AE] ( #$0010, #$FFE0, &code_0FB642 )
    COP [AE] ( #$0020, #$FFF0, &code_0FB604 )
    COP [81] ( #11, #04 )
    COP [83]
    BRA loc_0FB668
}