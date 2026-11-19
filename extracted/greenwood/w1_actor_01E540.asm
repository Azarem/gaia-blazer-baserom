?BANK 03

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w1_shared_01E4E9'

---------------------------------------------

code_01E540 {
    COP [14] ( #$005E, &code_01E547 ) ; {124224}
    RTL                   ; {124230}
}

code_01E547 {
    JSL $@w0_shared_01B161.code_01B161 ; {124231}
    COP [17] ( &code_01E55B ) ; {124235}
    SEP #$20              ; {124239}
    LDA #$^w0_shared_01B161.code_01B17C ; {124241}
    PHA                   ; {124243}
    REP #$20              ; {124244}
    LDA #$&w0_shared_01B161.code_01B17C-1 ; {124246}
    PHA                   ; {124249}
    RTL                   ; {124250}
}

code_01E55B {
    COP [07] ( #$9C07, &w1_shared_01E4E9.code_01E4E9 ) ; {124251}
    COP [01] ( &asciistring_01E571 ) ; {124257}
    BRK #$5E              ; {124261}
    COP [0A] ( #12 )      ; {124263}
    COP [09] ( #$9C07 )   ; {124266}
    BRL w1_shared_01E4E9.code_01E4E9 ; {124270}
}

asciistring_01E571 |[10]Here, take this [N][03:24]Light Arrow Magic- [03:20][FIN][END]|