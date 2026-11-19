?BANK 04

?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_026D80 {
    COP [14] ( #$0195, &code_026D8C ) ; {159104}
    COP [3B] ( #$0195, &code_026D9E ) ; {159110}
}

code_026D8C {
    LDA $0016, X          ; {159116}
    AND #$FFEF            ; {159119}
    STA $0016, X          ; {159122}
    COP [91]              ; {159125}
    COP [0D] ( #00, #17, #0F, &code_026D9F ) ; {159127}
}

code_026D9E {
    RTL                   ; {159134}
}

code_026D9F {
    COP [01] ( &asciistring_026DB6 ) ; {159135}
    COP [09] ( #$8900 )   ; {159139}
    STZ $0419             ; {159143}
    BRK #$91              ; {159146}
    COP [10] ( #$0113, #01, #$0170, #$00F0 ) ; {159148}
    RTL                   ; {159157}
}

asciistring_026DB6 |[10][02:2] drove [N]the Airship back to [N]the dock- [JMP:&w5_shared_02706C.asciistring_0270DF]|