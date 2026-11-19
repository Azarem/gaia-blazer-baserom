?BANK 03

!frame_counter                  0312

---------------------------------------------

code_01EECA {
    COP [92] ( #37 )      ; {126666}
    COP [94]              ; {126669}
    COP [03] ( #60 )      ; {126671}
    COP [07] ( #$8A01, &code_01EEEA ) ; {126674}
    COP [19] ( #10, &code_01EEDF ) ; {126680}
    BRA code_01EEEA       ; {126685}
}

code_01EEDF {
    LDA $frame_counter    ; {126687}
    AND #$0007            ; {126690}
    BNE code_01EEEA       ; {126693}
    COP [39] ( #01 )      ; {126695}
}

code_01EEEA {
    COP [04]              ; {126698}
    COP [92] ( #4F )      ; {126700}
    COP [94]              ; {126703}
    BRA code_01EECA       ; {126705}
}