?BANK 1F

---------------------------------------------

code_0FAA49 {
    LDA $0016, X          ; {1026633}
    BIT #$8000            ; {1026636}
    BEQ loc_0FAA57        ; {1026639}

  code_0FAA51:
    COP [1B] ( &code_0FAA49, #$0008 ) ; {1026641}

  loc_0FAA57:
    COP [9A] ( #$0010, &code_0FAA61, &code_0FAA73, &code_0FAA6A ) ; {1026647}
}

code_0FAA61 {
    COP [97]              ; {1026657}
    COP [80] ( #05 )      ; {1026659}
    COP [82]              ; {1026662}
    BRA code_0FAA73       ; {1026664}
}

code_0FAA6A {
    COP [96]              ; {1026666}
    COP [80] ( #05 )      ; {1026668}
    COP [82]              ; {1026671}
    BRA code_0FAA73       ; {1026673}
}

code_0FAA73 {
    COP [9B] ( #$0010, &code_0FAA7D, &code_0FAA51, &code_0FAA86 ) ; {1026675}
}

code_0FAA7D {
    COP [97]              ; {1026685}
    COP [80] ( #04 )      ; {1026687}
    COP [82]              ; {1026690}
    BRA code_0FAA49       ; {1026692}
}

code_0FAA86 {
    COP [97]              ; {1026694}
    COP [80] ( #03 )      ; {1026696}
    COP [82]              ; {1026699}
    BRA code_0FAA49       ; {1026701}
}