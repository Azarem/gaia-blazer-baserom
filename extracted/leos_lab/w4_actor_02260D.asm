?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_02260D {
    COP [14] ( #$011A, &code_022614 ) ; {140813}
    RTL                   ; {140819}
}

code_022614 {
    COP [07] ( #$8800, &code_02265C ) ; {140820}
    COP [85] ( @engine_0026F3.code_00299D ) ; {140826}
    COP [17] ( &code_022678 ) ; {140831}
    COP [15]              ; {140835}

  loc_022625:
    COP [91]              ; {140837}
    COP [0D] ( #00, #0B, #0D, &code_02262F ) ; {140839}
    RTL                   ; {140846}
}

code_02262F {
    COP [19] ( #27, &code_022645 ) ; {140847}
    COP [01] ( &asciistring_0226AC ) ; {140852}
    COP [09] ( #$8800 )   ; {140856}
    COP [17] ( #$0000 )   ; {140860}
    COP [16]              ; {140864}
    BRL code_02265C       ; {140866}
}

code_022645 {
    COP [01] ( &asciistring_02267D ) ; {140869}
    COP [91]              ; {140873}
    COP [0D] ( #00, #0B, #0D, &code_022654 ) ; {140875}
    BRA loc_022625        ; {140882}
}

code_022654 {
    RTL                   ; {140884}
}

code_022655 {
    BRK #$43              ; {140885}
    COP [80] ( #02 )      ; {140887}
    COP [82]              ; {140890}
}

code_02265C {
    COP [91]              ; {140892}
    COP [0C] ( #00, #02, &code_022665 ) ; {140894}
    RTL                   ; {140900}
}

code_022665 {
    BRK #$43              ; {140901}
    COP [80] ( #01 )      ; {140903}
    COP [82]              ; {140906}
    COP [91]              ; {140908}
    COP [0C] ( #00, #02, &code_022677 ) ; {140910}
    BRL code_022655       ; {140916}
}

code_022677 {
    RTL                   ; {140919}
}

code_022678 {
    COP [01] ( &asciistring_02267D ) ; {140920}
    RTL                   ; {140924}
}

asciistring_02267D |[10]My body is locked- [FIN]There should be a key [N]somewhere in the [N]laboratory- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_0226AC |[10][02:2] used [N]the door key- [JMP:&w4_shared_023F33.asciistring_023FA3]|