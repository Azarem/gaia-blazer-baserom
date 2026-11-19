?BANK 04

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w4_shared_023E00'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_023E57 {
    COP [14] ( #$0130, &code_023E5E )
    RTL 
}

code_023E5E {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_023E72 )
    SEP #$20
    LDA #$^w3_shared_022289.code_022289
    PHA 
    REP #$20
    LDA #$&w3_shared_022289.code_022289-1
    PHA 
    RTL 
}

code_023E72 {
    COP [07] ( #$9D03, &w4_shared_023E00.code_023E00 )
    COP [01] ( &w4_shared_023F33.asciistring_023F33 )
    COP [38] ( #$0300 )
    COP [09] ( #$9D03 )
    BRL w4_shared_023E00.code_023E00
}