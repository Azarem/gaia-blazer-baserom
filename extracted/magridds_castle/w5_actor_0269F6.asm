?BANK 04

?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_0269F6 {
    COP [07] ( #$8702, &code_026A13 ) ; {158198}
    COP [91]              ; {158204}
    COP [0D] ( #00, #28, #05, &code_026A06 ) ; {158206}
    RTL                   ; {158213}
}

code_026A06 {
    COP [01] ( &asciistring_026A16 ) ; {158214}
    BRK #$5E              ; {158218}
    COP [0A] ( #1A )      ; {158220}
    COP [09] ( #$8702 )   ; {158223}
}

code_026A13 {
    COP [86]              ; {158227}
    RTL                   ; {158229}
}

asciistring_026A16 |[10]The body is holding [N]something- [FIN][02:2] found [N]"[03:24]harp string-[03:20]ˮ [JMP:&w5_shared_02706C.asciistring_0270DF]|