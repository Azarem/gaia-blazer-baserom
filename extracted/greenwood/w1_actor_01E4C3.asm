?BANK 03

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w1_shared_01E4E9'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E4C3 {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_01E4D7 )
    SEP #$20
    LDA #$^w0_shared_01B161.code_01B17C
    PHA 
    REP #$20
    LDA #$&w0_shared_01B161.code_01B17C-1
    PHA 
    RTL 
}

code_01E4D7 {
    COP [07] ( #$9C05, &w1_shared_01E4E9.code_01E4E9 )
    COP [01] ( &w1_shared_01EBC2.asciistring_01EBC2 )
    COP [38] ( #$0150 )
    COP [09] ( #$9C05 )
}