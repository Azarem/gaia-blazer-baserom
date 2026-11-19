?BANK 03

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w1_shared_01E4E9'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E510 {
    COP [14] ( #$0048, &code_01E517 ) ; {124176}
    RTL                   ; {124182}
}

code_01E517 {
    JSL $@w0_shared_01B161.code_01B161 ; {124183}
    COP [17] ( &code_01E52B ) ; {124187}
    SEP #$20              ; {124191}
    LDA #$^w0_shared_01B161.code_01B17C ; {124193}
    PHA                   ; {124195}
    REP #$20              ; {124196}
    LDA #$&w0_shared_01B161.code_01B17C-1 ; {124198}
    PHA                   ; {124201}
    RTL                   ; {124202}
}

code_01E52B {
    COP [07] ( #$9C06, &w1_shared_01E4E9.code_01E4E9 ) ; {124203}
    COP [01] ( &w1_shared_01EBC2.asciistring_01EBC2 ) ; {124209}
    COP [38] ( #$0180 )   ; {124213}
    COP [09] ( #$9C06 )   ; {124217}
    BRL w1_shared_01E4E9.code_01E4E9 ; {124221}
}