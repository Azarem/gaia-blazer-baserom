?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_02317F {
    COP [14] ( #$014D, &code_023186 ) ; {143743}
    RTL                   ; {143749}
}

code_023186 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {143750}
    COP [17] ( &code_023199 ) ; {143755}
    COP [15]              ; {143759}
    COP [91]              ; {143761}
    COP [80] ( #03 )      ; {143763}
    COP [82]              ; {143766}
    RTL                   ; {143768}
}

code_023199 {
    COP [18] ( #26, &code_0231A3 ) ; {143769}
    COP [01] ( &asciistring_023200 ) ; {143774}
    RTL                   ; {143778}
}

code_0231A3 {
    COP [01] ( &asciistring_0231AD ) ; {143779}
    BRK #$5E              ; {143783}
    COP [0A] ( #26 )      ; {143785}
    RTL                   ; {143788}
}

asciistring_0231AD |[10]I am an Actinidia- [N]Take some of my leaves[N]if you want- [FIN]OUCH! [FIN][02:2] received [N][03:24]Actinidia leaves- [03:20][JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023200 |[10]I am happy to help [N]you- [JMP:&w4_shared_023F33.asciistring_023FA3]|