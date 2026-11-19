?BANK 04

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w4_shared_023E00'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_023E27 {
    COP [14] ( #$0147, &code_023E2E ) ; {146983}
    RTL                   ; {146989}
}

code_023E2E {
    JSL $@w0_shared_01B161.code_01B161 ; {146990}
    COP [17] ( &code_023E42 ) ; {146994}
    SEP #$20              ; {146998}
    LDA #$^w3_shared_022289.code_022289 ; {147000}
    PHA                   ; {147002}
    REP #$20              ; {147003}
    LDA #$&w3_shared_022289.code_022289-1 ; {147005}
    PHA                   ; {147008}
    RTL                   ; {147009}
}

code_023E42 {
    COP [07] ( #$9D02, &w4_shared_023E00.code_023E00 ) ; {147010}
    COP [01] ( &w4_shared_023F33.asciistring_023F33 ) ; {147016}
    COP [38] ( #$0300 )   ; {147020}
    COP [09] ( #$9D02 )   ; {147024}
    BRL w4_shared_023E00.code_023E00 ; {147028}
}