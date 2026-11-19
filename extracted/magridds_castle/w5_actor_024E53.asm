?BANK 04

?INCLUDE 'lib_014F02'
?INCLUDE 'w5_shared_02706C'

!L_choice_result                0003D0

---------------------------------------------

code_024E53 {
    COP [14] ( #$0187, &code_024E5A ) ; {151123}
    RTL                   ; {151129}
}

code_024E5A {
    COP [91]              ; {151130}
    COP [0D] ( #00, #39, #2F, &code_024E70 ) ; {151132}
    RTL                   ; {151139}
}

code_024E64 {
    COP [91]              ; {151140}
    COP [0D] ( #00, #39, #2F, &code_024E6F ) ; {151142}
    BRA code_024E5A       ; {151149}
}

code_024E6F {
    RTL                   ; {151151}
}

code_024E70 {
    COP [01] ( &asciistring_024E9D ) ; {151152}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_024E97 ) ; {151156}
    LDA $L_choice_result  ; {151163}
    BNE code_024E97       ; {151167}
    COP [18] ( #38, &code_024E8C ) ; {151169}
    COP [01] ( &asciistring_024F0E ) ; {151174}
    BRA code_024E64       ; {151178}
}

code_024E8C {
    COP [01] ( &asciistring_024EB9 ) ; {151180}
    BRK #$5E              ; {151184}
    COP [0A] ( #38 )      ; {151186}
    BRA code_024E64       ; {151189}
}

code_024E97 {
    COP [01] ( &asciistring_024F27 ) ; {151191}
    BRA code_024E64       ; {151195}
}

asciistring_024E9D |[10]You want Medical Herbs[N]don t you? [END]|

asciistring_024EB9 |[10]See? [N]I have the ability to [N]read peoples  minds- [FIN]Here I will give you [N]one- [FIN][02:2] received [N][03:24]a Medical Herb- [03:20][JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024F0E |[10]Hey, you already have [N]one- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024F27 |[10]Oh, I guess my ability[N]is not perfect- [JMP:&w5_shared_02706C.asciistring_0270DF]|