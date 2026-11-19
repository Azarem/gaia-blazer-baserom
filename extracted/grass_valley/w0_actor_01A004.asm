?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_01A004 {
    COP [14] ( #$002E, &code_01A00B ) ; {106500}
    RTL                   ; {106506}
}

code_01A00B {
    COP [85] ( @engine_0026F3.code_00299D ) ; {106507}
    COP [17] ( &code_01A01D ) ; {106512}
    COP [15]              ; {106516}

  loc_01A016:
    COP [80] ( #1E )      ; {106518}
    COP [82]              ; {106521}
    BRA loc_01A016        ; {106523}
}

code_01A01D {
    COP [01] ( &asciistring_01A022 ) ; {106525}
    RTL                   ; {106529}
}

asciistring_01A022 |[10]Be sure to check [N]underneath all of the [N]tulip s- [FIN]A boy may have hidden [N]something under one- [FIN]He thought that no one[N]was watching, but I [N]saw him! [JMP:&w0_shared_01B988.asciistring_01B988]|