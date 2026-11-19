?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_0254A2 {
    COP [3B] ( #$018F, &code_0254B8 ) ; {152738}
    COP [17] ( &w3_shared_022289.code_02229E ) ; {152744}
    SEP #$20              ; {152748}
    LDA #$^engine_003005.code_00305F ; {152750}
    PHA                   ; {152752}
    REP #$20              ; {152753}
    LDA #$&engine_003005.code_00305F-1 ; {152755}
    PHA                   ; {152758}
    RTL                   ; {152759}
}

code_0254B8 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {152760}
    COP [17] ( &code_0254C6 ) ; {152765}
    COP [15]              ; {152769}
    COP [91]              ; {152771}
    RTL                   ; {152773}
}

code_0254C6 {
    COP [01] ( &asciistring_0254CB ) ; {152774}
    RTL                   ; {152778}
}

asciistring_0254CB |[10]Don t you think that [N]she s a nice girl- [N]She seems to know what[N]people want- [JMP:&w5_shared_02706C.asciistring_0270DF]|