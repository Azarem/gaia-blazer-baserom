?BANK 1F

---------------------------------------------

code_0FAEE5 {
    LDA $001A, X          ; {1027813}
    ORA #$0400            ; {1027816}
    STA $001A, X          ; {1027819}
    COP [A5] ( &code_0FAF32, &code_0FAF20, &code_0FAEF8, &code_0FAF0E ) ; {1027822}
}

code_0FAEF8 {
    COP [21] ( &code_0FAEFE ) ; {1027832}
    BRA loc_0FAF18        ; {1027836}
}

code_0FAEFE {
    COP [24] ( &code_0FAF32 ) ; {1027838}

  loc_0FAF02:
    COP [96]              ; {1027842}
    COP [81] ( #21, #02 ) ; {1027844}
    COP [83]              ; {1027848}
    COP [97]              ; {1027850}
    BRA code_0FAEF8       ; {1027852}
}

code_0FAF0E {
    COP [23] ( &code_0FAF14 ) ; {1027854}
    BRA loc_0FAF2A        ; {1027858}
}

code_0FAF14 {
    COP [21] ( &code_0FAEF8 ) ; {1027860}

  loc_0FAF18:
    COP [81] ( #20, #02 ) ; {1027864}
    COP [83]              ; {1027868}
    BRA code_0FAF0E       ; {1027870}
}

code_0FAF20 {
    COP [22] ( &code_0FAF26 ) ; {1027872}
    BRA loc_0FAF3C        ; {1027876}
}

code_0FAF26 {
    COP [23] ( &code_0FAF0E ) ; {1027878}

  loc_0FAF2A:
    COP [81] ( #21, #02 ) ; {1027882}
    COP [83]              ; {1027886}
    BRA code_0FAF20       ; {1027888}
}

code_0FAF32 {
    COP [24] ( &code_0FAF38 ) ; {1027890}
    BRA loc_0FAF02        ; {1027894}
}

code_0FAF38 {
    COP [22] ( &code_0FAF20 ) ; {1027896}

  loc_0FAF3C:
    COP [81] ( #1F, #02 ) ; {1027900}
    COP [83]              ; {1027904}
    BRA code_0FAF32       ; {1027906}
}