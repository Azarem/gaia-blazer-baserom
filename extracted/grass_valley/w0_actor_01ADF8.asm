?BANK 03

?INCLUDE 'w0_shared_01AD1B'
?INCLUDE 'w0_shared_01B161'

---------------------------------------------

code_01ADF8 {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_01AE0C )
    SEP #$20
    LDA #$^w0_shared_01B161.code_01B17C
    PHA 
    REP #$20
    LDA #$&w0_shared_01B161.code_01B17C-1
    PHA 
    RTL 
}

code_01AE0C {
    COP [01] ( &asciistring_01AE13 )
    BRL w0_shared_01AD1B.code_01AD1B
}

asciistring_01AE13 |[10]This is the heart [N]of the Underground [N]Castle- [FIN]You may meet many [N]monsters that cannot [N]be defeated with that [N]sword- [FIN]You will be able to [N]save those creatures [N]once you return with [N]the correct sword- [FIN][END]|