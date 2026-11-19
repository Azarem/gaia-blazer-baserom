?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_02032B {
    COP [14] ( #$00E1, &code_020332 ) ; {131883}
    RTL                   ; {131889}
}

code_020332 {
    COP [17] ( &code_0203B4 ) ; {131890}
    COP [14] ( #$0103, &code_02035A ) ; {131894}
    COP [85] ( @engine_0026F3.code_00299D ) ; {131900}
    COP [15]              ; {131905}
    COP [91]              ; {131907}
    COP [14] ( #$0103, &code_02034C ) ; {131909}
    RTL                   ; {131915}
}

code_02034C {
    COP [80] ( #17 )      ; {131916}
    COP [82]              ; {131919}
    COP [81] ( #15, #08 ) ; {131921}
    COP [83]              ; {131925}
    COP [91]              ; {131927}
    RTL                   ; {131929}
}

code_02035A {
    COP [11] ( #0A, #11, #37 ) ; {131930}
    COP [85] ( @engine_0026F3.code_00299D ) ; {131935}
    LDA $0016, X          ; {131940}
    AND #$FFEF            ; {131943}
    STA $0016, X          ; {131946}
    COP [15]              ; {131949}
    COP [05] ( #$0004 )   ; {131951}
    COP [81] ( #28, #02 ) ; {131955}
    COP [83]              ; {131959}
    COP [81] ( #27, #02 ) ; {131961}
    COP [83]              ; {131965}
    COP [81] ( #28, #02 ) ; {131967}
    COP [83]              ; {131971}
    COP [81] ( #27, #02 ) ; {131973}
    COP [83]              ; {131977}
    COP [81] ( #28, #02 ) ; {131979}
    COP [83]              ; {131983}
    COP [85] ( @code_020445 ) ; {131985}
    COP [81] ( #29, #04 ) ; {131990}
    COP [83]              ; {131994}
    COP [81] ( #2A, #08 ) ; {131996}
    COP [83]              ; {132000}
    COP [81] ( #2B, #10 ) ; {132002}
    COP [83]              ; {132006}
    COP [09] ( #$8005 )   ; {132008}
    COP [80] ( #14 )      ; {132012}
    COP [82]              ; {132015}
    COP [91]              ; {132017}
    RTL                   ; {132019}
}

code_0203B4 {
    COP [14] ( #$0103, &code_0203BF ) ; {132020}
    COP [01] ( &asciistring_0203CE ) ; {132026}
    RTL                   ; {132030}
}

code_0203BF {
    COP [18] ( #18, &code_0203C9 ) ; {132031}
    COP [01] ( &asciistring_020427 ) ; {132036}
    RTL                   ; {132040}
}

code_0203C9 {
    COP [01] ( &asciistring_0203DF ) ; {132041}
    RTL                   ; {132045}
}

asciistring_0203CE |[10]Please save the King! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0203DF |[10]I am a magician- [FIN]If you collect the [N]Master s three [N]symbols, I will call [N]the Phoenix- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020427 |[10]Oh Phoenix, please [N]protect [02:2]- [JMP:&w3_shared_02249A.asciistring_02251E]|

code_020445 {
    COP [A8] ( #$8000, #0D ) ; {132165}
    COP [92] ( #49 )      ; {132170}
    COP [94]              ; {132173}
    COP [86]              ; {132175}
    RTL                   ; {132177}
}