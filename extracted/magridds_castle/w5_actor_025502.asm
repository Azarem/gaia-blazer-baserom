?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_025502 {
    COP [14] ( #$0192, &code_025509 ) ; {152834}
    RTL                   ; {152840}
}

code_025509 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {152841}
    COP [17] ( &code_025517 ) ; {152846}
    COP [15]              ; {152850}
    COP [91]              ; {152852}
    RTL                   ; {152854}
}

code_025517 {
    COP [01] ( &asciistring_02551C ) ; {152855}
    RTL                   ; {152859}
}

asciistring_02551C |[10]Phew! You scared me! [FIN]Don t sneak up behind [N]me- I almost fell into[N]the river- [JMP:&w5_shared_02706C.asciistring_0270DF]|