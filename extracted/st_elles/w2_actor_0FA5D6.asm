?BANK 1F

?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0FA5D6 {
    COP [07] ( #$8503, &code_0FA5F7 )
    COP [B0] ( @code_0FA5FA, #$2240 )

  code_0FA5E3:
    COP [92] ( #19 )
    COP [94]
    COP [07] ( #$0503, &code_0FA5E3 )
    COP [05] ( #$0001 )
    COP [92] ( #39 )
    COP [94]
}

code_0FA5F7 {
    COP [86]
    RTL 
}

code_0FA5FA {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [91]
    COP [0D] ( #00, #1F, #21, &code_0FA60D )

  code_0FA60C:
    RTL 
}

code_0FA60D {
    COP [19] ( #21, &code_0FA60C )
    COP [09] ( #$8503 )
    COP [0B] ( #21 )
    COP [01] ( &asciistring_0FA626 )
    BRK #$86
    COP [09] ( #$8001 )
    COP [86]
    RTL 
}

asciistring_0FA626 |[10][02:2] poured [N]out the mermaid s [N]tears- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|