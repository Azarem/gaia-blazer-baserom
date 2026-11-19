?BANK 03

?INCLUDE 'w0_shared_01AD1B'
?INCLUDE 'w0_shared_01B161'

---------------------------------------------

code_01AD42 {
    JSL $@w0_shared_01B161.code_01B161 ; {109890}
    COP [17] ( &code_01AD56 ) ; {109894}
    SEP #$20              ; {109898}
    LDA #$^w0_shared_01B161.code_01B17C ; {109900}
    PHA                   ; {109902}
    REP #$20              ; {109903}
    LDA #$&w0_shared_01B161.code_01B17C-1 ; {109905}
    PHA                   ; {109908}
    RTL                   ; {109909}
}

code_01AD56 {
    COP [01] ( &asciistring_01AD5D ) ; {109910}
    BRL w0_shared_01AD1B.code_01AD1B ; {109914}
}

asciistring_01AD5D |[10]The monsters running [N]all over in Dr-Leo s [N]paintings [FIN]cannot be defeated [N]unless you have a [N]special sword- [FIN]You must find the [N]special sword that can[N]destroy metal- [FIN]Return here once you [N]have found the sword- [FIN][END]|