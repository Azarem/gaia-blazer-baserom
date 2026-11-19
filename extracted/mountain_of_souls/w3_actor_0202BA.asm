?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_0202BA {
    COP [14] ( #$00F8, &code_0202C1 )
    RTL 
}

code_0202C1 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0202CF )
    COP [15]
    COP [91]
    RTL 
}

code_0202CF {
    COP [01] ( &asciistring_0202D4 )
    RTL 
}

asciistring_0202D4 |[10]Make sure you search [N]Laynole very [N]carefully- [FIN]If you move too fast [N]you may overlook [N]things--- [JMP:&w3_shared_02249A.asciistring_02251E]|