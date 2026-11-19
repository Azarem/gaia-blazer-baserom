?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_022523 {
    COP [14] ( #$0137, &code_02252A ) ; {140579}
    RTL                   ; {140585}
}

code_02252A {
    COP [85] ( @engine_0026F3.code_00299D ) ; {140586}
    COP [15]              ; {140591}
    COP [A2] ( #30 )      ; {140593}
    COP [17] ( &code_02254C ) ; {140596}
    COP [91]              ; {140600}
    COP [80] ( #08 )      ; {140602}
    COP [82]              ; {140605}
    RTL                   ; {140607}
}

code_022540 {
    COP [17] ( &code_022554 ) ; {140608}
    COP [91]              ; {140612}
    COP [80] ( #05 )      ; {140614}
    COP [82]              ; {140617}
    RTL                   ; {140619}
}

code_02254C {
    COP [01] ( &asciistring_022559 ) ; {140620}
    COP [27] ( &code_022540 ) ; {140624}
}

code_022554 {
    COP [01] ( &asciistring_022596 ) ; {140628}
    RTL                   ; {140632}
}

asciistring_022559 |[10]My back hurts because [N]I have been sitting [N]too long- [FIN]I should get up and [N]exercise- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022596 |[10]It scares people when [N]we move- [N]But we are just [N]exercising- [JMP:&w4_shared_023F33.asciistring_023FA3]|