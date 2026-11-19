?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_020237 {
    COP [3B] ( #$00EB, &code_02024D )
    COP [17] ( &w3_shared_022289.code_02229E )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_02024D {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_02025B )
    COP [15]
    COP [91]
    RTL 
}

code_02025B {
    COP [01] ( &asciistring_020260 )
    RTL 
}

asciistring_020260 |[10]We were really [N]happy just gazing at [N]each other- [FIN]But I may get old [N]soon- [FIN]Maybe I should search [N]for someone new- [JMP:&w3_shared_02249A.asciistring_02251E]|