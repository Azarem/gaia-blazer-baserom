?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_022AFB {
    COP [14] ( #$0139, &code_022B02 )
    RTL 
}

code_022B02 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_022B15 )
    COP [15]
    COP [91]
    COP [80] ( #03 )
    COP [82]
    RTL 
}

code_022B15 {
    COP [01] ( &asciistring_022B1A )
    RTL 
}

asciistring_022B1A |[10]If the soul of the [N]Great Door joins you, [FIN]you will be able to [N]see the invisible [N]enemies in the models [N]of town- [FIN]Listen to what the cat[N]says- [JMP:&w4_shared_023F33.asciistring_023FA3]|