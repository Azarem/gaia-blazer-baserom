?BANK 04

?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_023A36 {
    COP [07] ( #$8600, &code_023A4C ) ; {145974}
    COP [17] ( &code_023A68 ) ; {145980}
    COP [15]              ; {145984}
    COP [91]              ; {145986}
    RTL                   ; {145988}
}

code_023A45 {
    BRK #$43              ; {145989}
    COP [80] ( #02 )      ; {145991}
    COP [82]              ; {145994}
}

code_023A4C {
    COP [91]              ; {145996}
    COP [0C] ( #00, #02, &code_023A55 ) ; {145998}
    RTL                   ; {146004}
}

code_023A55 {
    BRK #$43              ; {146005}
    COP [80] ( #01 )      ; {146007}
    COP [82]              ; {146010}
    COP [91]              ; {146012}
    COP [0C] ( #00, #02, &code_023A67 ) ; {146014}
    BRL code_023A45       ; {146020}
}

code_023A67 {
    RTL                   ; {146023}
}

code_023A68 {
    COP [01] ( &asciistring_023A7A ) ; {146024}
    COP [09] ( #$8600 )   ; {146028}
    COP [16]              ; {146032}
    COP [17] ( #$0000 )   ; {146034}
    COP [27] ( &code_023A4C ) ; {146038}
}

asciistring_023A7A |[10]This is Dr-Leo s [N]laboratory- [FIN]There are machines [N]lurking around here [N]which only the [N]powerful [FIN]Zantetsu Sword can [N]defeat- [FIN]First of all, talk to [N]a certain door to get [N]you into the room- [JMP:&w4_shared_023F33.asciistring_023FA3]|