?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_02100B {
    COP [3B] ( #$00D7, &code_021021 )
    COP [17] ( &w3_shared_022289.code_02229E )
    SEP #$20
    LDA #$^engine_003005.code_00305F
    PHA 
    REP #$20
    LDA #$&engine_003005.code_00305F-1
    PHA 
    RTL 
}

code_021021 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_02102F )
    COP [15]
    COP [91]
    RTL 
}

code_02102F {
    COP [01] ( &asciistring_021034 )
    RTL 
}

asciistring_021034 |[10]There is a house [N]in the desert to #- [FIN]Mechanical monsters [N]that cannot be [N]defeated by normal [N]swords exist there- [JMP:&w3_shared_02249A.asciistring_02251E]|