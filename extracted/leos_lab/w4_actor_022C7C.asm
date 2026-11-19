?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_022C7C {
    COP [14] ( #$010B, &code_022C83 ) ; {142460}
    RTL                   ; {142466}
}

code_022C83 {
    COP [15]              ; {142467}
    COP [A0] ( #$FFFC )   ; {142469}
    COP [85] ( @engine_0026F3.code_00299D ) ; {142473}
    COP [17] ( &code_022C9A ) ; {142478}
    COP [91]              ; {142482}
    COP [80] ( #03 )      ; {142484}
    COP [82]              ; {142487}
    RTL                   ; {142489}
}

code_022C9A {
    COP [01] ( &asciistring_022C9F ) ; {142490}
    RTL                   ; {142494}
}

asciistring_022C9F |[10]The room on the second[N]floor is Dr-Leo s- [FIN]There were two models [N]of town in his room- [FIN]Many creatures were [N]swallowed into the [N]models- [JMP:&w4_shared_023F33.asciistring_023FA3]|