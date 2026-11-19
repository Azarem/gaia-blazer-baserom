?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_0251DC {
    COP [14] ( #$0179, &code_0251E3 )
    RTL 
}

code_0251E3 {
    COP [30] ( #$0179, &code_02521A, #04 )
    COP [17] ( &code_025203 )
    COP [15]
    COP [91]
    COP [07] ( #$8604, &code_0251F9 )
    RTL 
}

code_0251F9 {
    COP [16]
    COP [85] ( @engine_0026F3.code_00299D )
    COP [86]
    RTL 
}

code_025203 {
    COP [01] ( &asciistring_025266 )
    BRK #$4E
    COP [09] ( #$8604 )
    SEP #$20
    LDA $1B82
    ORA #$10
    STA $1B82
    REP #$20
    RTL 
}

code_02521A {
    COP [01] ( &asciistring_025221 )
    COP [86]
    RTL 
}

asciistring_025221 |[10][0E:3C]Someone is calling [N][02:2] from the [N]house- [FIN]I know everything [N]about the Magridd [N]Castle- [FIN]I will help you when [N]you come back- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025266 |[10]Even though I don t [N]look like it, [N]I am from the sky just[N]like you- [FIN]I know all of the [N]invisible passages in [N]the Magridd Castle- [FIN]Would you like to walk[N]the basement with me? [FIN]The soul that [N]knows the castle s [N]secret passages joins [N]you! [JMP:&w5_shared_02706C.asciistring_0270DF]|