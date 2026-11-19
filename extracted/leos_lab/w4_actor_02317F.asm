?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_02317F {
    COP [14] ( #$014D, &code_023186 )
    RTL 
}

code_023186 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_023199 )
    COP [15]
    COP [91]
    COP [80] ( #03 )
    COP [82]
    RTL 
}

code_023199 {
    COP [18] ( #26, &code_0231A3 )
    COP [01] ( &asciistring_023200 )
    RTL 
}

code_0231A3 {
    COP [01] ( &asciistring_0231AD )
    BRK #$5E
    COP [0A] ( #26 )
    RTL 
}

asciistring_0231AD |[10]I am an Actinidia- [N]Take some of my leaves[N]if you want- [FIN]OUCH! [FIN][02:2] received [N][03:24]Actinidia leaves- [03:20][JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023200 |[10]I am happy to help [N]you- [JMP:&w4_shared_023F33.asciistring_023FA3]|