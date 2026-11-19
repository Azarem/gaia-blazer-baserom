?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021263 {
    COP [14] ( #$00FF, &code_02126A )
    RTL 
}

code_02126A {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_021289 )
    COP [15]
    COP [91]
    COP [14] ( #$0103, &code_02127E )
    RTL 
}

code_02127E {
    COP [09] ( #$8706 )
    COP [17] ( &code_02128E )
    COP [91]
    RTL 
}

code_021289 {
    COP [01] ( &asciistring_021293 )
    RTL 
}

code_02128E {
    COP [01] ( &asciistring_0212DC )
    RTL 
}

asciistring_021293 |[10]There is a sword [N]called Lucky Blade [N]somewhere in Laynole- [FIN]It is said that [N]monsters will leave [N]larger GEMs- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0212DC |[10]The King has spoken of[N]you- The snail over [N]there is Nome- [JMP:&w3_shared_02249A.asciistring_02251E]|