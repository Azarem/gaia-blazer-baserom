?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8D58 {
    COP [3B] ( #$00A7, &code_0F8D6E ) ; {1019224}
    COP [17] ( &w2_shared_0FA945.code_0FA95A ) ; {1019230}
    SEP #$20              ; {1019234}
    LDA #$^engine_003005.code_00305F ; {1019236}
    PHA                   ; {1019238}
    REP #$20              ; {1019239}
    LDA #$&engine_003005.code_00305F-1 ; {1019241}
    PHA                   ; {1019244}
    RTL                   ; {1019245}
}

code_0F8D6E {
    COP [85] ( @engine_0026F3.code_00299D ) ; {1019246}
    COP [17] ( &code_0F8D81 ) ; {1019251}
    COP [15]              ; {1019255}
    COP [91]              ; {1019257}
    COP [80] ( #06 )      ; {1019259}
    COP [82]              ; {1019262}
    RTL                   ; {1019264}
}

code_0F8D81 {
    COP [07] ( #$8503, &code_0F8D96 ) ; {1019265}
    COP [18] ( #21, &code_0F8D91 ) ; {1019271}
    COP [01] ( &asciistring_0F8D9B ) ; {1019276}
    RTL                   ; {1019280}
}

code_0F8D91 {
    COP [01] ( &asciistring_0F8DF9 ) ; {1019281}
    RTL                   ; {1019285}
}

code_0F8D96 {
    COP [01] ( &asciistring_0F8E14 ) ; {1019286}
    RTL                   ; {1019290}
}

asciistring_0F8D9B |[10]The teardrops from a [N]mermaid have the power[N]to turn Magma to [N]stone- [FIN]Use them at the top of[N]the volcanic island- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8DF9 |[10]Open the treasure [N]chest- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8E14 |[10]These teardrops were [N]left by a mermaid when[N]evil invaded this [N]place- [FIN]Icy teardrops, filled [N]with sorrow, will turn[N]even the hottest Magma[N]to stone- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|