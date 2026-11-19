?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_024AF4 {
    COP [14] ( #$016D, &code_024AFB )
    RTL 
}

code_024AFB {
    COP [07] ( #$8805, &code_024B29 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_024B2C )
    COP [15]
    COP [05] ( #$0607 )
    COP [17] ( &code_024B3F )
    COP [16]
    COP [96]
    COP [80] ( #17 )
    COP [82]
    COP [97]
    COP [80] ( #14 )
    COP [82]
    COP [15]
    COP [91]
    RTL 
}

code_024B29 {
    COP [86]
    RTL 
}

code_024B2C {
    COP [19] ( #28, &code_024B3A )
    COP [01] ( &asciistring_024B98 )
    COP [09] ( #$8607 )
    RTL 
}

code_024B3A {
    COP [01] ( &asciistring_024B44 )
    RTL 
}

code_024B3F {
    COP [01] ( &asciistring_024B94 )
    RTL 
}

asciistring_024B44 |[10]The top floor of this [N]tower is a prison- [FIN]Anyone who does not [N]have the Platinum Card[N]cannot enter- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024B94 |[10][JMP:&asciistring_024B98+M]|

asciistring_024B98 |[10]Oh, that is the [N]Platinum Card, I am [N]sorry- [FIN][::]Please go inside- [JMP:&w5_shared_02706C.asciistring_0270DF]|