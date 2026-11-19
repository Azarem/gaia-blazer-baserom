?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_02312F {
    COP [14] ( #$013E, &code_023136 ) ; {143663}
    RTL                   ; {143669}
}

code_023136 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {143670}
    COP [17] ( &code_023144 ) ; {143675}
    COP [15]              ; {143679}
    COP [91]              ; {143681}
    RTL                   ; {143683}
}

code_023144 {
    COP [01] ( &asciistring_023149 ) ; {143684}
    RTL                   ; {143688}
}

asciistring_023149 |[10]Use magic to defeat [N]the enemies which you [N]cannot reach- [JMP:&w4_shared_023F33.asciistring_023FA3]|