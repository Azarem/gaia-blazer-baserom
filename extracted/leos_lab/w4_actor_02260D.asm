?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_02260D {
    COP [14] ( #$011A, &code_022614 )
    RTL 
}

code_022614 {
    COP [07] ( #$8800, &code_02265C )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_022678 )
    COP [15]

  loc_022625:
    COP [91]
    COP [0D] ( #00, #0B, #0D, &code_02262F )
    RTL 
}

code_02262F {
    COP [19] ( #27, &code_022645 )
    COP [01] ( &asciistring_0226AC )
    COP [09] ( #$8800 )
    COP [17] ( #$0000 )
    COP [16]
    BRL code_02265C
}

code_022645 {
    COP [01] ( &asciistring_02267D )
    COP [91]
    COP [0D] ( #00, #0B, #0D, &code_022654 )
    BRA loc_022625
}

code_022654 {
    RTL 
}

code_022655 {
    BRK #$43
    COP [80] ( #02 )
    COP [82]
}

code_02265C {
    COP [91]
    COP [0C] ( #00, #02, &code_022665 )
    RTL 
}

code_022665 {
    BRK #$43
    COP [80] ( #01 )
    COP [82]
    COP [91]
    COP [0C] ( #00, #02, &code_022677 )
    BRL code_022655
}

code_022677 {
    RTL 
}

code_022678 {
    COP [01] ( &asciistring_02267D )
    RTL 
}

asciistring_02267D |[10]My body is locked- [FIN]There should be a key [N]somewhere in the [N]laboratory- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_0226AC |[10][02:2] used [N]the door key- [JMP:&w4_shared_023F33.asciistring_023FA3]|