?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_019F7A {
    COP [14] ( #$002F, &code_019F81 ) ; {106362}
    RTL                   ; {106368}
}

code_019F81 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {106369}
    COP [17] ( &code_019F94 ) ; {106374}
    COP [15]              ; {106378}
    COP [91]              ; {106380}
    COP [80] ( #24 )      ; {106382}
    COP [82]              ; {106385}
    RTL                   ; {106387}
}

code_019F94 {
    COP [01] ( &asciistring_019F99 ) ; {106388}
    RTL                   ; {106392}
}

asciistring_019F99 |[10]I don t know if there [N]is such a thing as [N]reincarnation- [FIN]Even though I can t [N]communicate with my [N]husband, I enjoy his [N]company- [JMP:&w0_shared_01B988.asciistring_01B988]|