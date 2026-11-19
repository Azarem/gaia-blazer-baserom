?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_02515B {
    COP [3B] ( #$0186, &code_025171 ) ; {151899}
    COP [17] ( &w3_shared_022289.code_02229E ) ; {151905}
    SEP #$20              ; {151909}
    LDA #$^engine_003005.code_00305F ; {151911}
    PHA                   ; {151913}
    REP #$20              ; {151914}
    LDA #$&engine_003005.code_00305F-1 ; {151916}
    PHA                   ; {151919}
    RTL                   ; {151920}
}

code_025171 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {151921}
    COP [17] ( &code_02517F ) ; {151926}
    COP [15]              ; {151930}
    COP [91]              ; {151932}
    RTL                   ; {151934}
}

code_02517F {
    COP [01] ( &asciistring_025184 ) ; {151935}
    RTL                   ; {151939}
}

asciistring_025184 |[10]I find a great [N]many things wandering [N]around- [FIN]I have seen something [N]shiny around the [N]castle- [FIN]But I did not pick up-[JMP:&w5_shared_02706C.asciistring_0270DF]|