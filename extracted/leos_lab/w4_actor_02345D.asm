?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_02345D {
    COP [14] ( #$0153, &code_023464 )
    RTL 
}

code_023464 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_023477 )
    COP [15]
    COP [91]
    COP [80] ( #15 )
    COP [82]
    RTL 
}

code_023477 {
    COP [01] ( &asciistring_02347C )
    RTL 
}

asciistring_02347C |[10]This room belongs to a[N]doll named Marie- [FIN]She told me many [N]things about foreign [N]towns- [FIN]A girl named Lisa took[N]care of Marie- [JMP:&w4_shared_023F33.asciistring_023FA3]|