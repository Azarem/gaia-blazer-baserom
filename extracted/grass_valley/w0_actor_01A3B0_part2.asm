?BANK 03

?INCLUDE 'w0_shared_01AD1B'
?INCLUDE 'w0_shared_01B161'

---------------------------------------------

code_01AD42 {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_01AD56 )
    SEP #$20
    LDA #$^w0_shared_01B161.code_01B17C
    PHA 
    REP #$20
    LDA #$&w0_shared_01B161.code_01B17C-1
    PHA 
    RTL 
}

code_01AD56 {
    COP [01] ( &asciistring_01AD5D )
    BRL w0_shared_01AD1B.code_01AD1B
}

asciistring_01AD5D |[10]The monsters running [N]all over in Dr-Leo s [N]paintings [FIN]cannot be defeated [N]unless you have a [N]special sword- [FIN]You must find the [N]special sword that can[N]destroy metal- [FIN]Return here once you [N]have found the sword- [FIN][END]|