?BANK 1F

---------------------------------------------

code_0FAC7A {
    LDA $0016, X          ; {1027194}
    BIT #$8000            ; {1027197}
    BEQ loc_0FAC88        ; {1027200}
    COP [1B] ( &code_0FAC7A, #$0020 ) ; {1027202}

  loc_0FAC88:
    COP [0C] ( #00, #05, &code_0FAC95 ) ; {1027208}
    COP [80] ( #2E )      ; {1027214}
    COP [82]              ; {1027217}
    BRA code_0FAC7A       ; {1027219}
}

code_0FAC95 {
    COP [80] ( #2F )      ; {1027221}
    COP [82]              ; {1027224}

  loc_0FAC9A:
    COP [9C] ( &code_0FACA0, &code_0FACC0 ) ; {1027226}
}

code_0FACA0 {
    COP [9A] ( #$0000, &code_0FACAA, &code_0FACDC, &code_0FACB5 ) ; {1027232}
}

code_0FACAA {
    COP [97]              ; {1027242}
    COP [9D] ( #33 )      ; {1027244}
    COP [9E] ( &code_0FACC0 ) ; {1027247}

  loc_0FACB3:
    BRA code_0FACDC       ; {1027251}
}

code_0FACB5 {
    COP [96]              ; {1027253}
    COP [9D] ( #33 )      ; {1027255}
    COP [9E] ( &code_0FACC0 ) ; {1027258}

  loc_0FACBE:
    BRA code_0FACDC       ; {1027262}
}

code_0FACC0 {
    COP [9B] ( #$0000, &code_0FACCA, &code_0FACDC, &code_0FACD3 ) ; {1027264}
}

code_0FACCA {
    COP [9D] ( #32 )      ; {1027274}
    COP [9E] ( &code_0FACA0 ) ; {1027277}

  loc_0FACD1:
    BRA code_0FACDC       ; {1027281}
}

code_0FACD3 {
    COP [9D] ( #31 )      ; {1027283}
    COP [9E] ( &code_0FACA0 ) ; {1027286}

  loc_0FACDA:
    BRA code_0FACDC       ; {1027290}
}

code_0FACDC {
    LDA $0016, X          ; {1027292}
    BIT #$8000            ; {1027295}
    BNE loc_0FACEB        ; {1027298}
    COP [80] ( #30 )      ; {1027300}
    COP [82]              ; {1027303}
    BRA loc_0FAC9A        ; {1027305}

  loc_0FACEB:
    COP [80] ( #2E )      ; {1027307}
    COP [82]              ; {1027310}
    BRA code_0FAC7A       ; {1027312}
}