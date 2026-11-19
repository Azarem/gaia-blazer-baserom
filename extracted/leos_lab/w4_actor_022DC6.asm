?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_022DC6 {
    COP [14] ( #$0120, &code_022DCD )
    RTL 
}

code_022DCD {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_022DFC )
    BRL loc_022DE0

  loc_022DD9:
    BRK #$43
    COP [80] ( #02 )
    COP [82]

  loc_022DE0:
    COP [91]
    COP [0C] ( #00, #02, &code_022DE9 )
    RTL 
}

code_022DE9 {
    BRK #$43
    COP [80] ( #01 )
    COP [82]
    COP [91]
    COP [0C] ( #00, #02, &code_022DFB )
    BRL loc_022DD9
}

code_022DFB {
    RTL 
}

code_022DFC {
    COP [01] ( &asciistring_022E01 )
    RTL 
}

asciistring_022E01 |[10]---------- [JMP:&w4_shared_023F33.asciistring_023FA3]|