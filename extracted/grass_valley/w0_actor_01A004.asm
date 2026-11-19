?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01A004 {
    COP [14] ( #$002E, &code_01A00B )
    RTL 
}

code_01A00B {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01A01D )
    COP [15]

  loc_01A016:
    COP [80] ( #1E )
    COP [82]
    BRA loc_01A016
}

code_01A01D {
    COP [01] ( &asciistring_01A022 )
    RTL 
}

asciistring_01A022 |[10]Be sure to check [N]underneath all of the [N]tulip s- [FIN]A boy may have hidden [N]something under one- [FIN]He thought that no one[N]was watching, but I [N]saw him! [JMP:&w0_shared_01B988.asciistring_01B988]|