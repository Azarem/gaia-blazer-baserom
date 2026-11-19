?BANK 04

?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_024FD3 {
    COP [14] ( #$016B, &code_024FDA ) ; {151507}
    RTL                   ; {151513}
}

code_024FDA {
    COP [14] ( #$0185, &code_024FE9 ) ; {151514}
    COP [17] ( &code_025015 ) ; {151520}
    COP [15]              ; {151524}
    COP [91]              ; {151526}
    RTL                   ; {151528}
}

code_024FE9 {
    COP [A1] ( #$0010, #$0030 ) ; {151529}
    COP [17] ( &code_02501A ) ; {151535}
    COP [96]              ; {151539}
    COP [80] ( #0E )      ; {151541}
    COP [82]              ; {151544}
    COP [15]              ; {151546}
    COP [91]              ; {151548}
    COP [0D] ( #00, #1C, #33, &code_025006 ) ; {151550}
    RTL                   ; {151557}
}

code_025006 {
    COP [03] ( #05 )      ; {151558}
    COP [04]              ; {151561}
    COP [97]              ; {151563}
    COP [80] ( #0E )      ; {151565}
    COP [82]              ; {151568}
    COP [91]              ; {151570}
    RTL                   ; {151572}
}

code_025015 {
    COP [01] ( &asciistring_02501F ) ; {151573}
    RTL                   ; {151577}
}

code_02501A {
    COP [01] ( &asciistring_025053 ) ; {151578}
    RTL                   ; {151582}
}

asciistring_02501F |[10]This is the [N]soldiers  dormitory- [FIN]I am taking care of [N]them- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025053 |[10]Oh, I was just [N]removing a speck of [N]dust from his eye- [JMP:&w5_shared_02706C.asciistring_0270DF]|