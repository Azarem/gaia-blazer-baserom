?BANK 04

?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_026D80 {
    COP [14] ( #$0195, &code_026D8C )
    COP [3B] ( #$0195, &code_026D9E )
}

code_026D8C {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [91]
    COP [0D] ( #00, #17, #0F, &code_026D9F )
}

code_026D9E {
    RTL 
}

code_026D9F {
    COP [01] ( &asciistring_026DB6 )
    COP [09] ( #$8900 )
    STZ $0419
    BRK #$91
    COP [10] ( #$0113, #01, #$0170, #$00F0 )
    RTL 
}

asciistring_026DB6 |[10][02:2] drove [N]the Airship back to [N]the dock- [JMP:&w5_shared_02706C.asciistring_0270DF]|