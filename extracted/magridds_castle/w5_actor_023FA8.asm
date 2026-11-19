?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_023FA8 {
    COP [14] ( #$0159, &code_023FAF ) ; {147368}
    RTL                   ; {147374}
}

code_023FAF {
    COP [30] ( #$0159, &code_023FC9, #04 ) ; {147375}
    COP [85] ( @engine_0026F3.code_00299D ) ; {147382}
    COP [17] ( &code_023FC4 ) ; {147387}
    COP [15]              ; {147391}
    COP [91]              ; {147393}
    RTL                   ; {147395}
}

code_023FC4 {
    COP [01] ( &asciistring_023FDD ) ; {147396}
    RTL                   ; {147400}
}

code_023FC9 {
    COP [18] ( #06, &code_023FD1 ) ; {147401}

  loc_023FCE:
    COP [86]              ; {147406}
    RTL                   ; {147408}
}

code_023FD1 {
    COP [01] ( &asciistring_023FD7 ) ; {147409}
    BRA loc_023FCE        ; {147413}
}

asciistring_023FD7 |[10][0E:3C][JMP:&asciistring_023FDD+M]|

asciistring_023FDD |[10][::]There are many [N]ghosts in the torture [N]room of the basement- [FIN]First, [N]look for the Spirit [N]Sword- [JMP:&w5_shared_02706C.asciistring_0270DF]|