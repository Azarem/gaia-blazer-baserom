?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021263 {
    COP [14] ( #$00FF, &code_02126A ) ; {135779}
    RTL                   ; {135785}
}

code_02126A {
    COP [85] ( @engine_0026F3.code_00299D ) ; {135786}
    COP [17] ( &code_021289 ) ; {135791}
    COP [15]              ; {135795}
    COP [91]              ; {135797}
    COP [14] ( #$0103, &code_02127E ) ; {135799}
    RTL                   ; {135805}
}

code_02127E {
    COP [09] ( #$8706 )   ; {135806}
    COP [17] ( &code_02128E ) ; {135810}
    COP [91]              ; {135814}
    RTL                   ; {135816}
}

code_021289 {
    COP [01] ( &asciistring_021293 ) ; {135817}
    RTL                   ; {135821}
}

code_02128E {
    COP [01] ( &asciistring_0212DC ) ; {135822}
    RTL                   ; {135826}
}

asciistring_021293 |[10]There is a sword [N]called Lucky Blade [N]somewhere in Laynole- [FIN]It is said that [N]monsters will leave [N]larger GEMs- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0212DC |[10]The King has spoken of[N]you- The snail over [N]there is Nome- [JMP:&w3_shared_02249A.asciistring_02251E]|