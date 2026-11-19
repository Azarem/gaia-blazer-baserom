?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_024F4A {
    COP [3B] ( #$017E, &code_024F60 )
    COP [17] ( &w3_shared_022289.code_02229E )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_024F60 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_024F6E )
    COP [15]
    COP [91]
    RTL 
}

code_024F6E {
    COP [01] ( &asciistring_024F73 )
    RTL 
}

asciistring_024F73 |[10]Music is really [N]strange- [FIN]The same music [N]sometimes sounds very [N]wonderful when I am [N]happy [FIN]and sad when I am [N]depressed- [JMP:&w5_shared_02706C.asciistring_0270DF]|