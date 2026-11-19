?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_02195F {
    COP [3B] ( #$00FA, &code_021975 )
    COP [17] ( &w3_shared_022289.code_02229E )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_021975 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_021983 )
    COP [15]
    COP [91]
    RTL 
}

code_021983 {
    COP [01] ( &asciistring_021988 )
    RTL 
}

asciistring_021988 |[10]Can you believe this [N]old man used to be a [N]child just a half a [N]year ago? [FIN]Time is very [N]important- [JMP:&w3_shared_02249A.asciistring_02251E]|