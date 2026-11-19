?BANK 1F

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w2_shared_0FA46D'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0FA440 {
    COP [14] ( #$00A6, &code_0FA447 )
    RTL 
}

code_0FA447 {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_0FA45B )
    SEP #$20
    LDA #$^w2_shared_0FA945.code_0FA945
    PHA 
    REP #$20
    LDA #$&w2_shared_0FA945.code_0FA945-1
    PHA 
    RTL 
}

code_0FA45B {
    COP [07] ( #$9D00, &w2_shared_0FA46D.code_0FA46D )
    COP [01] ( &w2_shared_0FA945.asciistring_0FA9C5 )
    COP [38] ( #$0200 )
    COP [09] ( #$9D00 )
}