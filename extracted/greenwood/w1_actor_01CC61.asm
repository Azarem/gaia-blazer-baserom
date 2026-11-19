?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_014F02'
?INCLUDE 'w1_shared_01EBC2'

!L_choice_result                0003D0

---------------------------------------------

code_01CC61 {
    COP [14] ( #$004E, &code_01CC68 ) ; {117857}
    RTL                   ; {117863}
}

code_01CC68 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {117864}
    COP [17] ( &code_01CCA1 ) ; {117869}
    COP [A4]              ; {117873}
    COP [07] ( #$8305, &code_01CC81 ) ; {117875}
    COP [91]              ; {117881}
    COP [80] ( #21 )      ; {117883}
    COP [82]              ; {117886}
    RTL                   ; {117888}
}

code_01CC81 {
    COP [16]              ; {117889}
    COP [17] ( #$0000 )   ; {117891}

  code_01CC87:
    COP [03] ( #0A )      ; {117895}
    COP [80] ( #21 )      ; {117898}
    COP [82]              ; {117901}
    COP [0C] ( #00, #00, &code_01CC98 ) ; {117903}
    BRL code_01CC87       ; {117909}
}

code_01CC98 {
    COP [04]              ; {117912}
    COP [01] ( &asciistring_01CD20 ) ; {117914}
    BRL code_01CC87       ; {117918}
}

code_01CCA1 {
    COP [01] ( &asciistring_01CCC9 ) ; {117921}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_01CCC4 ) ; {117925}
    LDA $L_choice_result  ; {117932}
    BNE code_01CCC4       ; {117936}
    COP [01] ( &asciistring_01CCEE ) ; {117938}
    COP [09] ( #$8305 )   ; {117942}
    COP [16]              ; {117946}
    COP [17] ( #$0000 )   ; {117948}
    COP [27] ( &code_01CC87 ) ; {117952}
}

code_01CCC4 {
    COP [01] ( &asciistring_01CD16 ) ; {117956}
    RTL                   ; {117960}
}

asciistring_01CCC9 |[10]Who are you? [N]Are you trying to walk[N]over me!? [END]|

asciistring_01CCEE |You have some nerve! [N]Okay, but don t hurt [N]me- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CD16 |You wimp! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CD20 |[10]Hey, you re hurting [N]me! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|