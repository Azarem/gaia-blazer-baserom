?BANK 03

!frame_counter                  0312

---------------------------------------------

code_01EECA {
    COP [92] ( #37 )
    COP [94]
    COP [03] ( #60 )
    COP [07] ( #$8A01, &code_01EEEA )
    COP [19] ( #10, &code_01EEDF )
    BRA code_01EEEA
}

code_01EEDF {
    LDA $frame_counter
    AND #$0007
    BNE code_01EEEA
    COP [39] ( #01 )
}

code_01EEEA {
    COP [04]
    COP [92] ( #4F )
    COP [94]
    BRA code_01EECA
}