?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_02100B {
    COP [3B] ( #$00D7, &code_021021 ) ; {135179}
    COP [17] ( &w3_shared_022289.code_02229E ) ; {135185}
    SEP #$20              ; {135189}
    LDA #$^engine_003005.code_00305F ; {135191}
    PHA                   ; {135193}
    REP #$20              ; {135194}
    LDA #$&engine_003005.code_00305F-1 ; {135196}
    PHA                   ; {135199}
    RTL                   ; {135200}
}

code_021021 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {135201}
    COP [17] ( &code_02102F ) ; {135206}
    COP [15]              ; {135210}
    COP [91]              ; {135212}
    RTL                   ; {135214}
}

code_02102F {
    COP [01] ( &asciistring_021034 ) ; {135215}
    RTL                   ; {135219}
}

asciistring_021034 |[10]There is a house [N]in the desert to #- [FIN]Mechanical monsters [N]that cannot be [N]defeated by normal [N]swords exist there- [JMP:&w3_shared_02249A.asciistring_02251E]|