?BANK 03

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w1_shared_01E4E9'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E594 {
    COP [14] ( #$0053, &code_01E59B )
    RTL 
}

code_01E59B {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_01E5AF )
    SEP #$20
    LDA #$^w0_shared_01B161.code_01B17C
    PHA 
    REP #$20
    LDA #$&w0_shared_01B161.code_01B17C-1
    PHA 
    RTL 
}

code_01E5AF {
    COP [01] ( &w1_shared_01EBC2.asciistring_01EBC2 )
    COP [38] ( #$0001 )
    BRL w1_shared_01E4E9.code_01E4E9
}