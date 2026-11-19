?BANK 04

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_026DF2'

---------------------------------------------

code_026E9D {
    COP [14] ( #$0163, &code_026EA4 )
    RTL 
}

code_026EA4 {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_026F29 )
    SEP #$20
    LDA #$^w3_shared_022289.code_022289
    PHA 
    REP #$20
    LDA #$&w3_shared_022289.code_022289-1
    PHA 
    RTL 
}
---------------------------------------------

asciistring_026EB8 |[10]The Zantetsu Sword is [N]found in Leo s [N]laboratory- [FIN]And the Spirit Sword [N]in this castle----- [FIN]try to remember where [N]the invincible [N]monsters are- [FIN][END]|
---------------------------------------------

code_026F29 {
    COP [01] ( &asciistring_026EB8 )
    BRL w5_shared_026DF2.code_026E79
}