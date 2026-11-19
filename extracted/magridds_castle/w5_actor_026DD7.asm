?BANK 04

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_026DF2'

---------------------------------------------

code_026DD7 {
    COP [14] ( #$0184, &code_026DDE )
    RTL 
}

code_026DDE {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &w5_shared_026DF2.code_026E75 )
    SEP #$20
    LDA #$^w3_shared_022289.code_022289
    PHA 
    REP #$20
    LDA #$&w3_shared_022289.code_022289-1
    PHA 
    RTL 
}