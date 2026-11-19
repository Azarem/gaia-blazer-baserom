?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_02488E {
    COP [3B] ( #$0168, &code_0248A4 )
    COP [17] ( &w3_shared_022289.code_02229E )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_0248A4 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0248B2 )
    COP [15]
    COP [91]
    RTL 
}

code_0248B2 {
    COP [14] ( #$0195, &code_0248BD )
    COP [01] ( &asciistring_0248C2 )
    RTL 
}

code_0248BD {
    COP [01] ( &asciistring_024904 )
    RTL 
}

asciistring_0248C2 |[10]One of the soldiers [N]betrayed the King! [N]He is trying to [N]escape with Dr-Leo- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024904 |[10]The Queen passed away?[FIN]King Magridd must be [N]in shock! [FIN]He did everything he [N]could to save the [N]Queen- [JMP:&w5_shared_02706C.asciistring_0270DF]|