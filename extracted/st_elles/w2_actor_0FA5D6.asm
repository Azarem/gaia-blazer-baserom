?BANK 1F

?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0FA5D6 {
    COP [07] ( #$8503, &code_0FA5F7 ) ; {1025494}
    COP [B0] ( @code_0FA5FA, #$2240 ) ; {1025500}

  code_0FA5E3:
    COP [92] ( #19 )      ; {1025507}
    COP [94]              ; {1025510}
    COP [07] ( #$0503, &code_0FA5E3 ) ; {1025512}
    COP [05] ( #$0001 )   ; {1025518}
    COP [92] ( #39 )      ; {1025522}
    COP [94]              ; {1025525}
}

code_0FA5F7 {
    COP [86]              ; {1025527}
    RTL                   ; {1025529}
}

code_0FA5FA {
    LDA $0016, X          ; {1025530}
    AND #$FFEF            ; {1025533}
    STA $0016, X          ; {1025536}
    COP [91]              ; {1025539}
    COP [0D] ( #00, #1F, #21, &code_0FA60D ) ; {1025541}

  code_0FA60C:
    RTL                   ; {1025548}
}

code_0FA60D {
    COP [19] ( #21, &code_0FA60C ) ; {1025549}
    COP [09] ( #$8503 )   ; {1025554}
    COP [0B] ( #21 )      ; {1025558}
    COP [01] ( &asciistring_0FA626 ) ; {1025561}
    BRK #$86              ; {1025565}
    COP [09] ( #$8001 )   ; {1025567}
    COP [86]              ; {1025571}
    RTL                   ; {1025573}
}

asciistring_0FA626 |[10][02:2] poured [N]out the mermaid s [N]tears- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|