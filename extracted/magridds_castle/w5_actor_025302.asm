?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_025302 {
    COP [14] ( #$018C, &code_025309 )
    RTL 
}

code_025309 {
    COP [14] ( #$0195, &code_02531C )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_02534D )
    COP [15]
    BRA loc_02532D
}

code_02531C {
    COP [17] ( &code_025352 )
    COP [9F] ( #$FFF0 )
    COP [15]
    COP [96]
    COP [80] ( #14 )
    COP [82]

  loc_02532D:
    COP [91]
    COP [0D] ( #00, #25, #0C, &code_025337 )
    RTL 
}

code_025337 {
    COP [07] ( #$9A07, &code_02534A )
    COP [01] ( &asciistring_0253C3 )
    BRK #$5E
    COP [0A] ( #31 )
    COP [09] ( #$9A07 )
}

code_02534A {
    COP [91]
    RTL 
}

code_02534D {
    COP [01] ( &asciistring_025357 )
    RTL 
}

code_025352 {
    COP [01] ( &asciistring_025397 )
    RTL 
}

asciistring_025357 |[10]If King Magridd [N]doesn t come back, [N]then I will be crowned[N]the next King- [FIN]He, he, he- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025397 |[10]King Magridd is back- [N]Please do not tell [N]anybody what I have [N]said to you- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0253C3 |[10][02:2] found [N][03:24]the Master s Emblem H-[03:20][JMP:&w5_shared_02706C.asciistring_0270DF]|