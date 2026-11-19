?BANK 04

?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_023A36 {
    COP [07] ( #$8600, &code_023A4C )
    COP [17] ( &code_023A68 )
    COP [15]
    COP [91]
    RTL 
}

code_023A45 {
    BRK #$43
    COP [80] ( #02 )
    COP [82]
}

code_023A4C {
    COP [91]
    COP [0C] ( #00, #02, &code_023A55 )
    RTL 
}

code_023A55 {
    BRK #$43
    COP [80] ( #01 )
    COP [82]
    COP [91]
    COP [0C] ( #00, #02, &code_023A67 )
    BRL code_023A45
}

code_023A67 {
    RTL 
}

code_023A68 {
    COP [01] ( &asciistring_023A7A )
    COP [09] ( #$8600 )
    COP [16]
    COP [17] ( #$0000 )
    COP [27] ( &code_023A4C )
}

asciistring_023A7A |[10]This is Dr-Leo s [N]laboratory- [FIN]There are machines [N]lurking around here [N]which only the [N]powerful [FIN]Zantetsu Sword can [N]defeat- [FIN]First of all, talk to [N]a certain door to get [N]you into the room- [JMP:&w4_shared_023F33.asciistring_023FA3]|