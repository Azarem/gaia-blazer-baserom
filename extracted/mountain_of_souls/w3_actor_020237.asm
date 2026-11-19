?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_020237 {
    COP [3B] ( #$00EB, &code_02024D ) ; {131639}
    COP [17] ( &w3_shared_022289.code_02229E ) ; {131645}
    SEP #$20              ; {131649}
    LDA #$^engine_003005.code_00305F ; {131651}
    PHA                   ; {131653}
    REP #$20              ; {131654}
    LDA #$&engine_003005.code_00305F-1 ; {131656}
    PHA                   ; {131659}
    RTL                   ; {131660}
}

code_02024D {
    COP [85] ( @engine_0026F3.code_00299D ) ; {131661}
    COP [17] ( &code_02025B ) ; {131666}
    COP [15]              ; {131670}
    COP [91]              ; {131672}
    RTL                   ; {131674}
}

code_02025B {
    COP [01] ( &asciistring_020260 ) ; {131675}
    RTL                   ; {131679}
}

asciistring_020260 |[10]We were really [N]happy just gazing at [N]each other- [FIN]But I may get old [N]soon- [FIN]Maybe I should search [N]for someone new- [JMP:&w3_shared_02249A.asciistring_02251E]|