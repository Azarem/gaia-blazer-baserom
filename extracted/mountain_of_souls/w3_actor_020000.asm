?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_020000 {
    COP [14] ( #$00C9, &code_020007 )
    RTL 
}

code_020007 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_020052 )
    COP [15]
    COP [05] ( #$0000 )
    COP [16]
    COP [17] ( #$0000 )
    COP [97]
    COP [81] ( #11, #02 )
    COP [83]
    COP [81] ( #10, #02 )
    COP [83]
    COP [81] ( #11, #06 )
    COP [83]
    COP [81] ( #10, #03 )
    COP [83]
    COP [96]
    COP [80] ( #0E )
    COP [82]
    COP [17] ( &code_02005B )
    COP [91]
    COP [0D] ( #00, #0A, #07, &code_02004B )
    RTL 
}

code_02004B {
    COP [01] ( &asciistring_0200B8 )
    COP [91]
    RTL 
}

code_020052 {
    COP [01] ( &asciistring_020060 )
    COP [09] ( #$8000 )
    RTL 
}

code_02005B {
    COP [01] ( &asciistring_020095 )
    RTL 
}

asciistring_020060 |[10]My, my, it is rare to [N]see someone new- [N]Please come into my [N]room- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020095 |[10]Please, sit right in [N]front of me- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0200B8 |[10]I have so many [N]questions about human [N]beings- [FIN]Would you like to [N]discuss them with me? [JMP:&w3_shared_02249A.asciistring_02251E]|