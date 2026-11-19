?BANK 1F

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w2_shared_0FA46D'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0FA4C4 {
    COP [14] ( #$007A, &code_0FA4CB )
    RTL 
}

code_0FA4CB {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_0FA4DF )
    SEP #$20
    LDA #$^w2_shared_0FA945.code_0FA945
    PHA 
    REP #$20
    LDA #$&w2_shared_0FA945.code_0FA945-1
    PHA 
    RTL 
}

code_0FA4DF {
    COP [07] ( #$9D07, &w2_shared_0FA46D.code_0FA46D )
    COP [01] ( &w2_shared_0FA945.asciistring_0FA9C5 )
    COP [38] ( #$0250 )
    COP [09] ( #$9D07 )
    BRL w2_shared_0FA46D.code_0FA46D
}