?BANK 1F

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w2_shared_0FA46D'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0FA4C4 {
    COP [14] ( #$007A, &code_0FA4CB ) ; {1025220}
    RTL                   ; {1025226}
}

code_0FA4CB {
    JSL $@w0_shared_01B161.code_01B161 ; {1025227}
    COP [17] ( &code_0FA4DF ) ; {1025231}
    SEP #$20              ; {1025235}
    LDA #$^w2_shared_0FA945.code_0FA945 ; {1025237}
    PHA                   ; {1025239}
    REP #$20              ; {1025240}
    LDA #$&w2_shared_0FA945.code_0FA945-1 ; {1025242}
    PHA                   ; {1025245}
    RTL                   ; {1025246}
}

code_0FA4DF {
    COP [07] ( #$9D07, &w2_shared_0FA46D.code_0FA46D ) ; {1025247}
    COP [01] ( &w2_shared_0FA945.asciistring_0FA9C5 ) ; {1025253}
    COP [38] ( #$0250 )   ; {1025257}
    COP [09] ( #$9D07 )   ; {1025261}
    BRL w2_shared_0FA46D.code_0FA46D ; {1025265}
}