?BANK 04

?INCLUDE 'lib_014F02'
?INCLUDE 'w5_shared_02706C'

!L_choice_result                0003D0

---------------------------------------------

code_024E53 {
    COP [14] ( #$0187, &code_024E5A )
    RTL 
}

code_024E5A {
    COP [91]
    COP [0D] ( #00, #39, #2F, &code_024E70 )
    RTL 
}

code_024E64 {
    COP [91]
    COP [0D] ( #00, #39, #2F, &code_024E6F )
    BRA code_024E5A
}

code_024E6F {
    RTL 
}

code_024E70 {
    COP [01] ( &asciistring_024E9D )
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_024E97 )
    LDA $L_choice_result
    BNE code_024E97
    COP [18] ( #38, &code_024E8C )
    COP [01] ( &asciistring_024F0E )
    BRA code_024E64
}

code_024E8C {
    COP [01] ( &asciistring_024EB9 )
    BRK #$5E
    COP [0A] ( #38 )
    BRA code_024E64
}

code_024E97 {
    COP [01] ( &asciistring_024F27 )
    BRA code_024E64
}

asciistring_024E9D |[10]You want Medical Herbs[N]don t you? [END]|

asciistring_024EB9 |[10]See? [N]I have the ability to [N]read peoples  minds- [FIN]Here I will give you [N]one- [FIN][02:2] received [N][03:24]a Medical Herb- [03:20][JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024F0E |[10]Hey, you already have [N]one- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024F27 |[10]Oh, I guess my ability[N]is not perfect- [JMP:&w5_shared_02706C.asciistring_0270DF]|