?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_02312F {
    COP [14] ( #$013E, &code_023136 )
    RTL 
}

code_023136 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_023144 )
    COP [15]
    COP [91]
    RTL 
}

code_023144 {
    COP [01] ( &asciistring_023149 )
    RTL 
}

asciistring_023149 |[10]Use magic to defeat [N]the enemies which you [N]cannot reach- [JMP:&w4_shared_023F33.asciistring_023FA3]|