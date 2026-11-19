?BANK 04

?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_0253E2 {
    COP [14] ( #$018D, &code_0253E9 )
    RTL 
}

code_0253E9 {
    COP [17] ( &code_0253F2 )
    COP [15]
    COP [91]
    RTL 
}

code_0253F2 {
    COP [14] ( #$0195, &code_0253FD )
    COP [01] ( &asciistring_025402 )
    RTL 
}

code_0253FD {
    COP [01] ( &asciistring_025438 )
    RTL 
}

asciistring_025402 |[10]The key to the airship[N]has been stolen! [N]I don t know what is [N]going to happen- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025438 |[10]There appears to be a [N]fight on the airship s[N]dock- [FIN]It seems some of my [N]friends have passed [N]away- [FIN]I hate being a [N]soldier- [JMP:&w5_shared_02706C.asciistring_0270DF]|