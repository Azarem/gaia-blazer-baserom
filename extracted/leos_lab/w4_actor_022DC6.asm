?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_022DC6 {
    COP [14] ( #$0120, &code_022DCD ) ; {142790}
    RTL                   ; {142796}
}

code_022DCD {
    COP [85] ( @engine_0026F3.code_00299D ) ; {142797}
    COP [17] ( &code_022DFC ) ; {142802}
    BRL loc_022DE0        ; {142806}

  loc_022DD9:
    BRK #$43              ; {142809}
    COP [80] ( #02 )      ; {142811}
    COP [82]              ; {142814}

  loc_022DE0:
    COP [91]              ; {142816}
    COP [0C] ( #00, #02, &code_022DE9 ) ; {142818}
    RTL                   ; {142824}
}

code_022DE9 {
    BRK #$43              ; {142825}
    COP [80] ( #01 )      ; {142827}
    COP [82]              ; {142830}
    COP [91]              ; {142832}
    COP [0C] ( #00, #02, &code_022DFB ) ; {142834}
    BRL loc_022DD9        ; {142840}
}

code_022DFB {
    RTL                   ; {142843}
}

code_022DFC {
    COP [01] ( &asciistring_022E01 ) ; {142844}
    RTL                   ; {142848}
}

asciistring_022E01 |[10]---------- [JMP:&w4_shared_023F33.asciistring_023FA3]|