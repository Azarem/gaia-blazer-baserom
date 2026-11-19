?BANK 03

?INCLUDE 'w0_shared_01AD1B'
?INCLUDE 'w0_shared_01B161'

---------------------------------------------

code_01ADF8 {
    JSL $@w0_shared_01B161.code_01B161 ; {110072}
    COP [17] ( &code_01AE0C ) ; {110076}
    SEP #$20              ; {110080}
    LDA #$^w0_shared_01B161.code_01B17C ; {110082}
    PHA                   ; {110084}
    REP #$20              ; {110085}
    LDA #$&w0_shared_01B161.code_01B17C-1 ; {110087}
    PHA                   ; {110090}
    RTL                   ; {110091}
}

code_01AE0C {
    COP [01] ( &asciistring_01AE13 ) ; {110092}
    BRL w0_shared_01AD1B.code_01AD1B ; {110096}
}

asciistring_01AE13 |[10]This is the heart [N]of the Underground [N]Castle- [FIN]You may meet many [N]monsters that cannot [N]be defeated with that [N]sword- [FIN]You will be able to [N]save those creatures [N]once you return with [N]the correct sword- [FIN][END]|