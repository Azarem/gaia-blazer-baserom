?BANK 03

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w1_shared_01E4E9'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E4C3 {
    JSL $@w0_shared_01B161.code_01B161 ; {124099}
    COP [17] ( &code_01E4D7 ) ; {124103}
    SEP #$20              ; {124107}
    LDA #$^w0_shared_01B161.code_01B17C ; {124109}
    PHA                   ; {124111}
    REP #$20              ; {124112}
    LDA #$&w0_shared_01B161.code_01B17C-1 ; {124114}
    PHA                   ; {124117}
    RTL                   ; {124118}
}

code_01E4D7 {
    COP [07] ( #$9C05, &w1_shared_01E4E9.code_01E4E9 ) ; {124119}
    COP [01] ( &w1_shared_01EBC2.asciistring_01EBC2 ) ; {124125}
    COP [38] ( #$0150 )   ; {124129}
    COP [09] ( #$9C05 )   ; {124133}
}