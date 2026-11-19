?BANK 04

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_026DF2'

---------------------------------------------

code_026DD7 {
    COP [14] ( #$0184, &code_026DDE ) ; {159191}
    RTL                   ; {159197}
}

code_026DDE {
    JSL $@w0_shared_01B161.code_01B161 ; {159198}
    COP [17] ( &w5_shared_026DF2.code_026E75 ) ; {159202}
    SEP #$20              ; {159206}
    LDA #$^w3_shared_022289.code_022289 ; {159208}
    PHA                   ; {159210}
    REP #$20              ; {159211}
    LDA #$&w3_shared_022289.code_022289-1 ; {159213}
    PHA                   ; {159216}
    RTL                   ; {159217}
}