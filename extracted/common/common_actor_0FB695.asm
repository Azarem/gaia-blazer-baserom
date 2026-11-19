?BANK 1F

---------------------------------------------

code_0FB695 {
    LDA $0016, X          ; {1029781}
    BIT #$8000            ; {1029784}
    BEQ loc_0FB6A3        ; {1029787}
    COP [1B] ( &code_0FB695, #$0010 ) ; {1029789}

  loc_0FB6A3:
    COP [0C] ( #00, #06, &code_0FB6B0 ) ; {1029795}
    COP [80] ( #1A )      ; {1029801}
    COP [82]              ; {1029804}
    BRA code_0FB695       ; {1029806}
}

code_0FB6B0 {
    COP [80] ( #1B )      ; {1029808}
    COP [82]              ; {1029811}
    COP [A3]              ; {1029813}
    COP [A2] ( #30 )      ; {1029815}

  loc_0FB6BA:
    COP [9C] ( &code_0FB6C0, &code_0FB6DC ) ; {1029818}
}

code_0FB6C0 {
    COP [9A] ( #$0000, &code_0FB6CA, &code_0FB6D3, &code_0FB6D3 ) ; {1029824}
}

code_0FB6CA {
    COP [97]              ; {1029834}
    COP [80] ( #1E )      ; {1029836}
    COP [82]              ; {1029839}
    BRA loc_0FB6BA        ; {1029841}
}

code_0FB6D3 {
    COP [96]              ; {1029843}
    COP [80] ( #1E )      ; {1029845}
    COP [82]              ; {1029848}
    BRA loc_0FB6BA        ; {1029850}
}

code_0FB6DC {
    COP [9B] ( #$0000, &code_0FB6E6, &code_0FB6EF, &code_0FB6EF ) ; {1029852}
}

code_0FB6E6 {
    COP [97]              ; {1029862}
    COP [80] ( #1D )      ; {1029864}
    COP [82]              ; {1029867}
    BRA loc_0FB6BA        ; {1029869}
}

code_0FB6EF {
    COP [97]              ; {1029871}
    COP [80] ( #1C )      ; {1029873}
    COP [82]              ; {1029876}
    BRA loc_0FB6BA        ; {1029878}
}