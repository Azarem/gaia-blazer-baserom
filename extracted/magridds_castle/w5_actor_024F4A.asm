?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_024F4A {
    COP [3B] ( #$017E, &code_024F60 ) ; {151370}
    COP [17] ( &w3_shared_022289.code_02229E ) ; {151376}
    SEP #$20              ; {151380}
    LDA #$^engine_003005.code_00305F ; {151382}
    PHA                   ; {151384}
    REP #$20              ; {151385}
    LDA #$&engine_003005.code_00305F-1 ; {151387}
    PHA                   ; {151390}
    RTL                   ; {151391}
}

code_024F60 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {151392}
    COP [17] ( &code_024F6E ) ; {151397}
    COP [15]              ; {151401}
    COP [91]              ; {151403}
    RTL                   ; {151405}
}

code_024F6E {
    COP [01] ( &asciistring_024F73 ) ; {151406}
    RTL                   ; {151410}
}

asciistring_024F73 |[10]Music is really [N]strange- [FIN]The same music [N]sometimes sounds very [N]wonderful when I am [N]happy [FIN]and sad when I am [N]depressed- [JMP:&w5_shared_02706C.asciistring_0270DF]|