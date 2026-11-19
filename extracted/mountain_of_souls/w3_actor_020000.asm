?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_020000 {
    COP [14] ( #$00C9, &code_020007 ) ; {131072}
    RTL                   ; {131078}
}

code_020007 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {131079}
    COP [17] ( &code_020052 ) ; {131084}
    COP [15]              ; {131088}
    COP [05] ( #$0000 )   ; {131090}
    COP [16]              ; {131094}
    COP [17] ( #$0000 )   ; {131096}
    COP [97]              ; {131100}
    COP [81] ( #11, #02 ) ; {131102}
    COP [83]              ; {131106}
    COP [81] ( #10, #02 ) ; {131108}
    COP [83]              ; {131112}
    COP [81] ( #11, #06 ) ; {131114}
    COP [83]              ; {131118}
    COP [81] ( #10, #03 ) ; {131120}
    COP [83]              ; {131124}
    COP [96]              ; {131126}
    COP [80] ( #0E )      ; {131128}
    COP [82]              ; {131131}
    COP [17] ( &code_02005B ) ; {131133}
    COP [91]              ; {131137}
    COP [0D] ( #00, #0A, #07, &code_02004B ) ; {131139}
    RTL                   ; {131146}
}

code_02004B {
    COP [01] ( &asciistring_0200B8 ) ; {131147}
    COP [91]              ; {131151}
    RTL                   ; {131153}
}

code_020052 {
    COP [01] ( &asciistring_020060 ) ; {131154}
    COP [09] ( #$8000 )   ; {131158}
    RTL                   ; {131162}
}

code_02005B {
    COP [01] ( &asciistring_020095 ) ; {131163}
    RTL                   ; {131167}
}

asciistring_020060 |[10]My, my, it is rare to [N]see someone new- [N]Please come into my [N]room- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020095 |[10]Please, sit right in [N]front of me- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0200B8 |[10]I have so many [N]questions about human [N]beings- [FIN]Would you like to [N]discuss them with me? [JMP:&w3_shared_02249A.asciistring_02251E]|