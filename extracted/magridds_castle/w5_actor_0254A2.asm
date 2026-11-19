?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_0254A2 {
    COP [3B] ( #$018F, &code_0254B8 )
    COP [17] ( &w3_shared_022289.code_02229E )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_0254B8 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0254C6 )
    COP [15]
    COP [91]
    RTL 
}

code_0254C6 {
    COP [01] ( &asciistring_0254CB )
    RTL 
}

asciistring_0254CB |[10]Don t you think that [N]she s a nice girl- [N]She seems to know what[N]people want- [JMP:&w5_shared_02706C.asciistring_0270DF]|