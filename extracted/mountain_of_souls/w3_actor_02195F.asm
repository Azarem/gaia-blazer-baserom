?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_02195F {
    COP [3B] ( #$00FA, &code_021975 ) ; {137567}
    COP [17] ( &w3_shared_022289.code_02229E ) ; {137573}
    SEP #$20              ; {137577}
    LDA #$^engine_003005.code_00305F ; {137579}
    PHA                   ; {137581}
    REP #$20              ; {137582}
    LDA #$&engine_003005.code_00305F-1 ; {137584}
    PHA                   ; {137587}
    RTL                   ; {137588}
}

code_021975 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {137589}
    COP [17] ( &code_021983 ) ; {137594}
    COP [15]              ; {137598}
    COP [91]              ; {137600}
    RTL                   ; {137602}
}

code_021983 {
    COP [01] ( &asciistring_021988 ) ; {137603}
    RTL                   ; {137607}
}

asciistring_021988 |[10]Can you believe this [N]old man used to be a [N]child just a half a [N]year ago? [FIN]Time is very [N]important- [JMP:&w3_shared_02249A.asciistring_02251E]|