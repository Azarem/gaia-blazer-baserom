?BANK 1F

---------------------------------------------

code_0FB898 {
    LDA $0016, X          ; {1030296}
    BIT #$8000            ; {1030299}
    BEQ loc_0FB8A6        ; {1030302}

  code_0FB8A0:
    COP [1B] ( &code_0FB898, #$0010 ) ; {1030304}

  loc_0FB8A6:
    COP [9A] ( #$0010, &code_0FB8B0, &code_0FB8C2, &code_0FB8B9 ) ; {1030310}
}

code_0FB8B0 {
    COP [97]              ; {1030320}
    COP [80] ( #0B )      ; {1030322}
    COP [82]              ; {1030325}
    BRA code_0FB8C2       ; {1030327}
}

code_0FB8B9 {
    COP [96]              ; {1030329}
    COP [80] ( #0B )      ; {1030331}
    COP [82]              ; {1030334}
    BRA code_0FB8C2       ; {1030336}
}

code_0FB8C2 {
    COP [9B] ( #$0010, &code_0FB8CC, &code_0FB8A0, &code_0FB8D5 ) ; {1030338}
}

code_0FB8CC {
    COP [97]              ; {1030348}
    COP [80] ( #07 )      ; {1030350}
    COP [82]              ; {1030353}
    BRA code_0FB898       ; {1030355}
}

code_0FB8D5 {
    COP [97]              ; {1030357}
    COP [80] ( #03 )      ; {1030359}
    COP [82]              ; {1030362}
    BRA code_0FB898       ; {1030364}
}