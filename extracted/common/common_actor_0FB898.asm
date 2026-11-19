?BANK 1F

---------------------------------------------

code_0FB898 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB8A6

  code_0FB8A0:
    COP [1B] ( &code_0FB898, #$0010 )

  loc_0FB8A6:
    COP [9A] ( #$0010, &code_0FB8B0, &code_0FB8C2, &code_0FB8B9 )
}

code_0FB8B0 {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    BRA code_0FB8C2
}

code_0FB8B9 {
    COP [96]
    COP [80] ( #0B )
    COP [82]
    BRA code_0FB8C2
}

code_0FB8C2 {
    COP [9B] ( #$0010, &code_0FB8CC, &code_0FB8A0, &code_0FB8D5 )
}

code_0FB8CC {
    COP [97]
    COP [80] ( #07 )
    COP [82]
    BRA code_0FB898
}

code_0FB8D5 {
    COP [97]
    COP [80] ( #03 )
    COP [82]
    BRA code_0FB898
}