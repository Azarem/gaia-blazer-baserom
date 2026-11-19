?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_0218BF {
    COP [14] ( #$00FC, &code_0218C6 )
    RTL 
}

code_0218C6 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0218D4 )
    COP [15]
    COP [91]
    RTL 
}

code_0218D4 {
    COP [07] ( #$8707, &code_0218F5 )
    COP [19] ( #1C, &code_0218F0 )
    COP [01] ( &asciistring_021903 )
    COP [3C] ( #04 )
    COP [10] ( #$030B, #01, #$00A0, #$00E0 )
    RTL 
}

code_0218F0 {
    COP [01] ( &asciistring_0218FA )
    RTL 
}

code_0218F5 {
    COP [01] ( &asciistring_021924 )
    RTL 
}

asciistring_0218FA |[10]Zzzz [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021903 |[10][02:2] placed [N]the Dream Rod on the [N]old man- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021924 |[10]Oops! I must have [N]fallen asleep- [FIN]I was dreaming of my [N]childhood- [JMP:&w3_shared_02249A.asciistring_02251E]|