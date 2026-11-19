?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021A4B {
    COP [14] ( #$00E8, &code_021A52 ) ; {137803}
    RTL                   ; {137809}
}

code_021A52 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {137810}
    COP [17] ( &code_021A60 ) ; {137815}
    COP [15]              ; {137819}
    COP [91]              ; {137821}
    RTL                   ; {137823}
}

code_021A60 {
    COP [07] ( #$9A04, &code_021A74 ) ; {137824}
    COP [01] ( &asciistring_021A79 ) ; {137830}
    BRK #$5E              ; {137834}
    COP [0A] ( #2E )      ; {137836}
    COP [09] ( #$9A04 )   ; {137839}
    RTL                   ; {137843}
}

code_021A74 {
    COP [01] ( &asciistring_021AB8 ) ; {137844}
    RTL                   ; {137848}
}

asciistring_021A79 |[10]How did you get in? [N]Here I will give you [N]this- [FIN][02:2] received [N][03:24]the Master s Emblem E-[03:20][JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021AB8 |[10]How did you get in? [JMP:&w3_shared_02249A.asciistring_02251E]|