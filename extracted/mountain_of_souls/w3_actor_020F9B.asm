?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_020F9B {
    COP [3B] ( #$00DD, &code_020FB1 ) ; {135067}
    COP [17] ( &w3_shared_022289.code_02229E ) ; {135073}
    SEP #$20              ; {135077}
    LDA #$^engine_003005.code_00305F ; {135079}
    PHA                   ; {135081}
    REP #$20              ; {135082}
    LDA #$&engine_003005.code_00305F-1 ; {135084}
    PHA                   ; {135087}
    RTL                   ; {135088}
}

code_020FB1 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {135089}
    COP [17] ( &code_020FC4 ) ; {135094}
    COP [15]              ; {135098}
    COP [80] ( #25 )      ; {135100}
    COP [82]              ; {135103}
    COP [91]              ; {135105}
    RTL                   ; {135107}
}

code_020FC4 {
    COP [19] ( #1C, &code_020FDA ) ; {135108}
    COP [01] ( &asciistring_020FE9 ) ; {135113}
    COP [3C] ( #04 )      ; {135117}
    COP [10] ( #$060B, #01, #$0200, #$02F0 ) ; {135120}
    RTL                   ; {135129}
}

code_020FDA {
    COP [01] ( &asciistring_020FDF ) ; {135130}
    RTL                   ; {135134}
}

asciistring_020FDF |[10]Zzzzz [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020FE9 |[10][02:2] placed [N]the Dream Rod on the [N]mushroom- [JMP:&w3_shared_02249A.asciistring_02251E]|