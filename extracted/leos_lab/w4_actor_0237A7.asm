?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_0237A7 {
    COP [14] ( #$0152, &code_0237AE )
    RTL 
}

code_0237AE {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0237DB )
    COP [81] ( #1E, #08 )
    COP [83]

  loc_0237BD:
    COP [81] ( #0D, #02 )
    COP [83]
    COP [96]
    COP [81] ( #0F, #03 )
    COP [83]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [97]
    COP [81] ( #0F, #03 )
    COP [83]
    BRA loc_0237BD
}

code_0237DB {
    COP [01] ( &asciistring_0237E0 )
    RTL 
}

asciistring_0237E0 |[10]We are weak and timid [N]animals- [FIN]Don t you think it s [N]unfair the weaker [N]creatures are defeated[N]first? [JMP:&w4_shared_023F33.asciistring_023FA3]|