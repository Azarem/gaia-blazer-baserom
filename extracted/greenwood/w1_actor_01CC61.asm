?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_014F02'
?INCLUDE 'w1_shared_01EBC2'

!L_choice_result                0003D0

---------------------------------------------

code_01CC61 {
    COP [14] ( #$004E, &code_01CC68 )
    RTL 
}

code_01CC68 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01CCA1 )
    COP [A4]
    COP [07] ( #$8305, &code_01CC81 )
    COP [91]
    COP [80] ( #21 )
    COP [82]
    RTL 
}

code_01CC81 {
    COP [16]
    COP [17] ( #$0000 )

  code_01CC87:
    COP [03] ( #0A )
    COP [80] ( #21 )
    COP [82]
    COP [0C] ( #00, #00, &code_01CC98 )
    BRL code_01CC87
}

code_01CC98 {
    COP [04]
    COP [01] ( &asciistring_01CD20 )
    BRL code_01CC87
}

code_01CCA1 {
    COP [01] ( &asciistring_01CCC9 )
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_01CCC4 )
    LDA $L_choice_result
    BNE code_01CCC4
    COP [01] ( &asciistring_01CCEE )
    COP [09] ( #$8305 )
    COP [16]
    COP [17] ( #$0000 )
    COP [27] ( &code_01CC87 )
}

code_01CCC4 {
    COP [01] ( &asciistring_01CD16 )
    RTL 
}

asciistring_01CCC9 |[10]Who are you? [N]Are you trying to walk[N]over me!? [END]|

asciistring_01CCEE |You have some nerve! [N]Okay, but don t hurt [N]me- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CD16 |You wimp! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CD20 |[10]Hey, you re hurting [N]me! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|