?BANK 04

?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021DF9 {
    COP [15]
    COP [17] ( &code_021E1A )
    COP [91]
    COP [0D] ( #00, #1C, #31, &code_021E09 )
    RTL 
}

code_021E09 {
    COP [01] ( &asciistring_021E64 )
    COP [3C] ( #04 )
    COP [10] ( #$010A, #01, #$0120, #$02C0 )
    RTL 
}

code_021E1A {
    COP [01] ( &asciistring_021E1F )
    RTL 
}

asciistring_021E1F |[10]This is my [N]hometown- [FIN]The mountain winds [N]carried my spores and [N]now we live there- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_021E64 |[10]Make sure you don t [N]walk around in a dream[N]or you will get lost- [JMP:&w3_shared_02249A.asciistring_02251E]|