?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_0251DC {
    COP [14] ( #$0179, &code_0251E3 ) ; {152028}
    RTL                   ; {152034}
}

code_0251E3 {
    COP [30] ( #$0179, &code_02521A, #04 ) ; {152035}
    COP [17] ( &code_025203 ) ; {152042}
    COP [15]              ; {152046}
    COP [91]              ; {152048}
    COP [07] ( #$8604, &code_0251F9 ) ; {152050}
    RTL                   ; {152056}
}

code_0251F9 {
    COP [16]              ; {152057}
    COP [85] ( @engine_0026F3.code_00299D ) ; {152059}
    COP [86]              ; {152064}
    RTL                   ; {152066}
}

code_025203 {
    COP [01] ( &asciistring_025266 ) ; {152067}
    BRK #$4E              ; {152071}
    COP [09] ( #$8604 )   ; {152073}
    SEP #$20              ; {152077}
    LDA $1B82             ; {152079}
    ORA #$10              ; {152082}
    STA $1B82             ; {152084}
    REP #$20              ; {152087}
    RTL                   ; {152089}
}

code_02521A {
    COP [01] ( &asciistring_025221 ) ; {152090}
    COP [86]              ; {152094}
    RTL                   ; {152096}
}

asciistring_025221 |[10][0E:3C]Someone is calling [N][02:2] from the [N]house- [FIN]I know everything [N]about the Magridd [N]Castle- [FIN]I will help you when [N]you come back- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025266 |[10]Even though I don t [N]look like it, [N]I am from the sky just[N]like you- [FIN]I know all of the [N]invisible passages in [N]the Magridd Castle- [FIN]Would you like to walk[N]the basement with me? [FIN]The soul that [N]knows the castle s [N]secret passages joins [N]you! [JMP:&w5_shared_02706C.asciistring_0270DF]|