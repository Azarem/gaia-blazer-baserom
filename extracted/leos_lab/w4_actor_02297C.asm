?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_02297C {
    COP [14] ( #$011B, &code_022983 ) ; {141692}
    RTL                   ; {141698}
}

code_022983 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {141699}
    COP [17] ( &code_022994 ) ; {141704}
    COP [91]              ; {141708}
    COP [80] ( #15 )      ; {141710}
    COP [82]              ; {141713}
    RTL                   ; {141715}
}

code_022994 {
    COP [01] ( &asciistring_022999 ) ; {141716}
    RTL                   ; {141720}
}

asciistring_022999 |[10]Doors are usually [N]quiet, but there are [N]some talkative ones- [FIN]Try and talk to all of[N]them- [JMP:&w4_shared_023F33.asciistring_023FA3]|