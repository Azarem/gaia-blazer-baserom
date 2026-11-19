?BANK 04

?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_0253E2 {
    COP [14] ( #$018D, &code_0253E9 ) ; {152546}
    RTL                   ; {152552}
}

code_0253E9 {
    COP [17] ( &code_0253F2 ) ; {152553}
    COP [15]              ; {152557}
    COP [91]              ; {152559}
    RTL                   ; {152561}
}

code_0253F2 {
    COP [14] ( #$0195, &code_0253FD ) ; {152562}
    COP [01] ( &asciistring_025402 ) ; {152568}
    RTL                   ; {152572}
}

code_0253FD {
    COP [01] ( &asciistring_025438 ) ; {152573}
    RTL                   ; {152577}
}

asciistring_025402 |[10]The key to the airship[N]has been stolen! [N]I don t know what is [N]going to happen- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025438 |[10]There appears to be a [N]fight on the airship s[N]dock- [FIN]It seems some of my [N]friends have passed [N]away- [FIN]I hate being a [N]soldier- [JMP:&w5_shared_02706C.asciistring_0270DF]|