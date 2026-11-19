?BANK 04

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w4_shared_023E00'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_023E57 {
    COP [14] ( #$0130, &code_023E5E ) ; {147031}
    RTL                   ; {147037}
}

code_023E5E {
    JSL $@w0_shared_01B161.code_01B161 ; {147038}
    COP [17] ( &code_023E72 ) ; {147042}
    SEP #$20              ; {147046}
    LDA #$^w3_shared_022289.code_022289 ; {147048}
    PHA                   ; {147050}
    REP #$20              ; {147051}
    LDA #$&w3_shared_022289.code_022289-1 ; {147053}
    PHA                   ; {147056}
    RTL                   ; {147057}
}

code_023E72 {
    COP [07] ( #$9D03, &w4_shared_023E00.code_023E00 ) ; {147058}
    COP [01] ( &w4_shared_023F33.asciistring_023F33 ) ; {147064}
    COP [38] ( #$0300 )   ; {147068}
    COP [09] ( #$9D03 )   ; {147072}
    BRL w4_shared_023E00.code_023E00 ; {147076}
}