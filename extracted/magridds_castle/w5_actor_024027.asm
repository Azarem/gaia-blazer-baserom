?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_024027 {
    COP [14] ( #$015A, &code_02402E ) ; {147495}
    RTL                   ; {147501}
}

code_02402E {
    COP [07] ( #$8806, &code_024042 ) ; {147502}
    COP [85] ( @engine_0026F3.code_00299D ) ; {147508}
    COP [17] ( &code_02404B ) ; {147513}
    COP [15]              ; {147517}
    COP [91]              ; {147519}
    RTL                   ; {147521}
}

code_024042 {
    COP [17] ( &code_024054 ) ; {147522}
    COP [15]              ; {147526}
    COP [91]              ; {147528}
    RTL                   ; {147530}
}

code_02404B {
    COP [01] ( &asciistring_024059 ) ; {147531}
    COP [09] ( #$8806 )   ; {147535}
    RTL                   ; {147539}
}

code_024054 {
    COP [01] ( &asciistring_0240AC ) ; {147540}
    RTL                   ; {147544}
}

asciistring_024059 |[10]My uncle is [N]the famous architect [N]Gaudi- [FIN]I know a bit about [N]architecture- [N]I will show you [N]something later- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0240AC |[10]What do you think [N]about the wall? [N]I am known as a [N]"speedˮ architect- [JMP:&w5_shared_02706C.asciistring_0270DF]|