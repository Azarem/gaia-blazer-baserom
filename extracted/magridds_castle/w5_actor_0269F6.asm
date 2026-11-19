?BANK 04

?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_0269F6 {
    COP [07] ( #$8702, &code_026A13 )
    COP [91]
    COP [0D] ( #00, #28, #05, &code_026A06 )
    RTL 
}

code_026A06 {
    COP [01] ( &asciistring_026A16 )
    BRK #$5E
    COP [0A] ( #1A )
    COP [09] ( #$8702 )
}

code_026A13 {
    COP [86]
    RTL 
}

asciistring_026A16 |[10]The body is holding [N]something- [FIN][02:2] found [N]"[03:24]harp string-[03:20]ˮ [JMP:&w5_shared_02706C.asciistring_0270DF]|