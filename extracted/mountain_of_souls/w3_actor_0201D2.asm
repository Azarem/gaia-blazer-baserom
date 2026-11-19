?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_0201D2 {
    COP [14] ( #$00CC, &code_0201D9 ) ; {131538}
    RTL                   ; {131544}
}

code_0201D9 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {131545}
    COP [17] ( &code_0201E7 ) ; {131550}
    COP [15]              ; {131554}
    COP [91]              ; {131556}
    RTL                   ; {131558}
}

code_0201E7 {
    COP [14] ( #$00EB, &code_0201F2 ) ; {131559}
    COP [01] ( &asciistring_02021F ) ; {131565}
    RTL                   ; {131569}
}

code_0201F2 {
    COP [01] ( &asciistring_0201F7 ) ; {131570}
    RTL                   ; {131574}
}

asciistring_0201F7 |[10]We were really [N]happy just gazing at [N]each other- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_02021F |[10]Please save my [N]girlfriend- [JMP:&w3_shared_02249A.asciistring_02251E]|