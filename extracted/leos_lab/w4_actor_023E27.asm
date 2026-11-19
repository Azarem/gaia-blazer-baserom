?BANK 04

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w4_shared_023E00'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_023E27 {
    COP [14] ( #$0147, &code_023E2E )
    RTL 
}

code_023E2E {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_023E42 )
    SEP #$20
    LDA #$^w3_shared_022289.code_022289
    PHA 
    REP #$20
    LDA #$&w3_shared_022289.code_022289-1
    PHA 
    RTL 
}

code_023E42 {
    COP [07] ( #$9D02, &w4_shared_023E00.code_023E00 )
    COP [01] ( &w4_shared_023F33.asciistring_023F33 )
    COP [38] ( #$0300 )
    COP [09] ( #$9D02 )
    BRL w4_shared_023E00.code_023E00
}