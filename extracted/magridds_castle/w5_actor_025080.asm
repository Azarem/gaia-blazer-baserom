?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_025080 {
    COP [14] ( #$0182, &code_025087 )
    RTL 
}

code_025087 {
    COP [07] ( #$8805, &code_0250B5 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0250B8 )
    COP [15]
    COP [05] ( #$0700 )
    COP [17] ( &code_0250CB )
    COP [16]
    COP [97]
    COP [80] ( #17 )
    COP [82]
    COP [96]
    COP [80] ( #14 )
    COP [82]
    COP [15]
    COP [91]
    RTL 
}

code_0250B5 {
    COP [86]
    RTL 
}

code_0250B8 {
    COP [19] ( #29, &code_0250C6 )
    COP [01] ( &asciistring_025133 )
    COP [09] ( #$8700 )
    RTL 
}

code_0250C6 {
    COP [01] ( &asciistring_0250D0 )
    RTL 
}

code_0250CB {
    COP [01] ( &asciistring_02512F )
    RTL 
}

asciistring_0250D0 |[10]This tower is [N]connected to the [N]airship s dock at the [N]top floor- [FIN]Anyone without a VIP [N]card cannot get in- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_02512F |[10][JMP:&asciistring_025133+M]|

asciistring_025133 |[10]Oh, that is the VIP [N]card- [N]I am very sorry- [N][::]Please come in- [JMP:&w5_shared_02706C.asciistring_0270DF]|