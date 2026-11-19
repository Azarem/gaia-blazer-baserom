?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_025080 {
    COP [14] ( #$0182, &code_025087 ) ; {151680}
    RTL                   ; {151686}
}

code_025087 {
    COP [07] ( #$8805, &code_0250B5 ) ; {151687}
    COP [85] ( @engine_0026F3.code_00299D ) ; {151693}
    COP [17] ( &code_0250B8 ) ; {151698}
    COP [15]              ; {151702}
    COP [05] ( #$0700 )   ; {151704}
    COP [17] ( &code_0250CB ) ; {151708}
    COP [16]              ; {151712}
    COP [97]              ; {151714}
    COP [80] ( #17 )      ; {151716}
    COP [82]              ; {151719}
    COP [96]              ; {151721}
    COP [80] ( #14 )      ; {151723}
    COP [82]              ; {151726}
    COP [15]              ; {151728}
    COP [91]              ; {151730}
    RTL                   ; {151732}
}

code_0250B5 {
    COP [86]              ; {151733}
    RTL                   ; {151735}
}

code_0250B8 {
    COP [19] ( #29, &code_0250C6 ) ; {151736}
    COP [01] ( &asciistring_025133 ) ; {151741}
    COP [09] ( #$8700 )   ; {151745}
    RTL                   ; {151749}
}

code_0250C6 {
    COP [01] ( &asciistring_0250D0 ) ; {151750}
    RTL                   ; {151754}
}

code_0250CB {
    COP [01] ( &asciistring_02512F ) ; {151755}
    RTL                   ; {151759}
}

asciistring_0250D0 |[10]This tower is [N]connected to the [N]airship s dock at the [N]top floor- [FIN]Anyone without a VIP [N]card cannot get in- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_02512F |[10][JMP:&asciistring_025133+M]|

asciistring_025133 |[10]Oh, that is the VIP [N]card- [N]I am very sorry- [N][::]Please come in- [JMP:&w5_shared_02706C.asciistring_0270DF]|