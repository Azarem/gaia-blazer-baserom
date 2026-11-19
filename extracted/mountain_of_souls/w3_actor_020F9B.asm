?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_020F9B {
    COP [3B] ( #$00DD, &code_020FB1 )
    COP [17] ( &w3_shared_022289.code_02229E )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_020FB1 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_020FC4 )
    COP [15]
    COP [80] ( #25 )
    COP [82]
    COP [91]
    RTL 
}

code_020FC4 {
    COP [19] ( #1C, &code_020FDA )
    COP [01] ( &asciistring_020FE9 )
    COP [3C] ( #04 )
    COP [10] ( #$060B, #01, #$0200, #$02F0 )
    RTL 
}

code_020FDA {
    COP [01] ( &asciistring_020FDF )
    RTL 
}

asciistring_020FDF |[10]Zzzzz [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020FE9 |[10][02:2] placed [N]the Dream Rod on the [N]mushroom- [JMP:&w3_shared_02249A.asciistring_02251E]|