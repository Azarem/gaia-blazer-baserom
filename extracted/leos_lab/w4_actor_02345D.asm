?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_02345D {
    COP [14] ( #$0153, &code_023464 ) ; {144477}
    RTL                   ; {144483}
}

code_023464 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {144484}
    COP [17] ( &code_023477 ) ; {144489}
    COP [15]              ; {144493}
    COP [91]              ; {144495}
    COP [80] ( #15 )      ; {144497}
    COP [82]              ; {144500}
    RTL                   ; {144502}
}

code_023477 {
    COP [01] ( &asciistring_02347C ) ; {144503}
    RTL                   ; {144507}
}

asciistring_02347C |[10]This room belongs to a[N]doll named Marie- [FIN]She told me many [N]things about foreign [N]towns- [FIN]A girl named Lisa took[N]care of Marie- [JMP:&w4_shared_023F33.asciistring_023FA3]|