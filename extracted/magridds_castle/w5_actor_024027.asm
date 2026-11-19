?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_024027 {
    COP [14] ( #$015A, &code_02402E )
    RTL 
}

code_02402E {
    COP [07] ( #$8806, &code_024042 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_02404B )
    COP [15]
    COP [91]
    RTL 
}

code_024042 {
    COP [17] ( &code_024054 )
    COP [15]
    COP [91]
    RTL 
}

code_02404B {
    COP [01] ( &asciistring_024059 )
    COP [09] ( #$8806 )
    RTL 
}

code_024054 {
    COP [01] ( &asciistring_0240AC )
    RTL 
}

asciistring_024059 |[10]My uncle is [N]the famous architect [N]Gaudi- [FIN]I know a bit about [N]architecture- [N]I will show you [N]something later- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0240AC |[10]What do you think [N]about the wall? [N]I am known as a [N]"speedˮ architect- [JMP:&w5_shared_02706C.asciistring_0270DF]|