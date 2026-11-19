?BANK 03

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w1_shared_01E4E9'

---------------------------------------------

code_01E540 {
    COP [14] ( #$005E, &code_01E547 )
    RTL 
}

code_01E547 {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_01E55B )
    SEP #$20
    LDA #$^w0_shared_01B161.code_01B17C
    PHA 
    REP #$20
    LDA #$&w0_shared_01B161.code_01B17C-1
    PHA 
    RTL 
}

code_01E55B {
    COP [07] ( #$9C07, &w1_shared_01E4E9.code_01E4E9 )
    COP [01] ( &asciistring_01E571 )
    BRK #$5E
    COP [0A] ( #12 )
    COP [09] ( #$9C07 )
    BRL w1_shared_01E4E9.code_01E4E9
}

asciistring_01E571 |[10]Here, take this [N][03:24]Light Arrow Magic- [03:20][FIN][END]|