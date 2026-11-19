?BANK 1F

---------------------------------------------

code_0FC0E5 {
    LDA $0016, X          ; {1032421}
    BIT #$8000            ; {1032424}
    BEQ loc_0FC0F3        ; {1032427}
    COP [1B] ( &code_0FC0E5, #$0010 ) ; {1032429}

  loc_0FC0F3:
    COP [0C] ( #00, #04, &code_0FC100 ) ; {1032435}

  code_0FC0F9:
    COP [80] ( #1D )      ; {1032441}
    COP [82]              ; {1032444}
    BRA code_0FC0E5       ; {1032446}
}

code_0FC100 {
    COP [9C] ( &code_0FC106, &code_0FC12A ) ; {1032448}
}

code_0FC106 {
    COP [9A] ( #$0010, &code_0FC110, &code_0FC11D, &code_0FC11D ) ; {1032454}
}

code_0FC110 {
    COP [23] ( &code_0FC0F9 ) ; {1032464}
    COP [97]              ; {1032468}
    COP [80] ( #20 )      ; {1032470}
    COP [82]              ; {1032473}
    BRA code_0FC0F9       ; {1032475}
}

code_0FC11D {
    COP [24] ( &code_0FC0F9 ) ; {1032477}
    COP [96]              ; {1032481}
    COP [80] ( #20 )      ; {1032483}
    COP [82]              ; {1032486}
    BRA code_0FC0F9       ; {1032488}
}

code_0FC12A {
    COP [9B] ( #$0010, &code_0FC134, &code_0FC141, &code_0FC141 ) ; {1032490}
}

code_0FC134 {
    COP [21] ( &code_0FC0F9 ) ; {1032500}
    COP [97]              ; {1032504}
    COP [80] ( #1F )      ; {1032506}
    COP [82]              ; {1032509}
    BRA code_0FC0F9       ; {1032511}
}

code_0FC141 {
    COP [22] ( &code_0FC0F9 ) ; {1032513}
    COP [97]              ; {1032517}
    COP [80] ( #1E )      ; {1032519}
    COP [82]              ; {1032522}
    BRA code_0FC0F9       ; {1032524}
}