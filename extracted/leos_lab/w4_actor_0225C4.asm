?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_0225C4 {
    COP [14] ( #$0112, &code_0225CB )
    RTL 
}

code_0225CB {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0225FA )
    BRL loc_0225DE

  loc_0225D7:
    BRK #$43
    COP [80] ( #02 )
    COP [82]

  loc_0225DE:
    COP [91]
    COP [0C] ( #00, #02, &code_0225E7 )
    RTL 
}

code_0225E7 {
    BRK #$43
    COP [80] ( #01 )
    COP [82]
    COP [91]
    COP [0C] ( #00, #02, &code_0225F9 )
    BRL loc_0225D7
}

code_0225F9 {
    RTL 
}

code_0225FA {
    COP [01] ( &asciistring_0225FF )
    RTL 
}

asciistring_0225FF |[10]--------- [JMP:&w4_shared_023F33.asciistring_023FA3]|