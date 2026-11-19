?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_022523 {
    COP [14] ( #$0137, &code_02252A )
    RTL 
}

code_02252A {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [A2] ( #30 )
    COP [17] ( &code_02254C )
    COP [91]
    COP [80] ( #08 )
    COP [82]
    RTL 
}

code_022540 {
    COP [17] ( &code_022554 )
    COP [91]
    COP [80] ( #05 )
    COP [82]
    RTL 
}

code_02254C {
    COP [01] ( &asciistring_022559 )
    COP [27] ( &code_022540 )
}

code_022554 {
    COP [01] ( &asciistring_022596 )
    RTL 
}

asciistring_022559 |[10]My back hurts because [N]I have been sitting [N]too long- [FIN]I should get up and [N]exercise- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022596 |[10]It scares people when [N]we move- [N]But we are just [N]exercising- [JMP:&w4_shared_023F33.asciistring_023FA3]|