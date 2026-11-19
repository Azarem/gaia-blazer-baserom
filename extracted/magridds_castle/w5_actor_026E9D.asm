?BANK 04

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_026DF2'

---------------------------------------------

code_026E9D {
    COP [14] ( #$0163, &code_026EA4 ) ; {159389}
    RTL                   ; {159395}
}

code_026EA4 {
    JSL $@w0_shared_01B161.code_01B161 ; {159396}
    COP [17] ( &code_026F29 ) ; {159400}
    SEP #$20              ; {159404}
    LDA #$^w3_shared_022289.code_022289 ; {159406}
    PHA                   ; {159408}
    REP #$20              ; {159409}
    LDA #$&w3_shared_022289.code_022289-1 ; {159411}
    PHA                   ; {159414}
    RTL                   ; {159415}
}
---------------------------------------------

asciistring_026EB8 |[10]The Zantetsu Sword is [N]found in Leo s [N]laboratory- [FIN]And the Spirit Sword [N]in this castle----- [FIN]try to remember where [N]the invincible [N]monsters are- [FIN][END]|
---------------------------------------------

code_026F29 {
    COP [01] ( &asciistring_026EB8 ) ; {159529}
    BRL w5_shared_026DF2.code_026E79 ; {159533}
}