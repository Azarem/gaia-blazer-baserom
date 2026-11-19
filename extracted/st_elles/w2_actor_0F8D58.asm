?BANK 1F

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0F8D58 {
    COP [3B] ( #$00A7, &code_0F8D6E )
    COP [17] ( &w2_shared_0FA945.code_0FA95A )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_0F8D6E {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0F8D81 )
    COP [15]
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

code_0F8D81 {
    COP [07] ( #$8503, &code_0F8D96 )
    COP [18] ( #21, &code_0F8D91 )
    COP [01] ( &asciistring_0F8D9B )
    RTL 
}

code_0F8D91 {
    COP [01] ( &asciistring_0F8DF9 )
    RTL 
}

code_0F8D96 {
    COP [01] ( &asciistring_0F8E14 )
    RTL 
}

asciistring_0F8D9B |[10]The teardrops from a [N]mermaid have the power[N]to turn Magma to [N]stone- [FIN]Use them at the top of[N]the volcanic island- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8DF9 |[10]Open the treasure [N]chest- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8E14 |[10]These teardrops were [N]left by a mermaid when[N]evil invaded this [N]place- [FIN]Icy teardrops, filled [N]with sorrow, will turn[N]even the hottest Magma[N]to stone- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|