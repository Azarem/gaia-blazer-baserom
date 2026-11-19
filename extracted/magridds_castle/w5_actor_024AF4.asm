?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_024AF4 {
    COP [14] ( #$016D, &code_024AFB ) ; {150260}
    RTL                   ; {150266}
}

code_024AFB {
    COP [07] ( #$8805, &code_024B29 ) ; {150267}
    COP [85] ( @engine_0026F3.code_00299D ) ; {150273}
    COP [17] ( &code_024B2C ) ; {150278}
    COP [15]              ; {150282}
    COP [05] ( #$0607 )   ; {150284}
    COP [17] ( &code_024B3F ) ; {150288}
    COP [16]              ; {150292}
    COP [96]              ; {150294}
    COP [80] ( #17 )      ; {150296}
    COP [82]              ; {150299}
    COP [97]              ; {150301}
    COP [80] ( #14 )      ; {150303}
    COP [82]              ; {150306}
    COP [15]              ; {150308}
    COP [91]              ; {150310}
    RTL                   ; {150312}
}

code_024B29 {
    COP [86]              ; {150313}
    RTL                   ; {150315}
}

code_024B2C {
    COP [19] ( #28, &code_024B3A ) ; {150316}
    COP [01] ( &asciistring_024B98 ) ; {150321}
    COP [09] ( #$8607 )   ; {150325}
    RTL                   ; {150329}
}

code_024B3A {
    COP [01] ( &asciistring_024B44 ) ; {150330}
    RTL                   ; {150334}
}

code_024B3F {
    COP [01] ( &asciistring_024B94 ) ; {150335}
    RTL                   ; {150339}
}

asciistring_024B44 |[10]The top floor of this [N]tower is a prison- [FIN]Anyone who does not [N]have the Platinum Card[N]cannot enter- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024B94 |[10][JMP:&asciistring_024B98+M]|

asciistring_024B98 |[10]Oh, that is the [N]Platinum Card, I am [N]sorry- [FIN][::]Please go inside- [JMP:&w5_shared_02706C.asciistring_0270DF]|