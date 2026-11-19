?BANK 03

?INCLUDE 'w0_shared_01ABB9'
?INCLUDE 'w0_shared_01B161'

---------------------------------------------

code_01AC06 {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_01AC1A )
    SEP #$20
    LDA #$^w0_shared_01B161.code_01B17C
    PHA 
    REP #$20
    LDA #$&w0_shared_01B161.code_01B17C-1
    PHA 
    RTL 
}

code_01AC1A {
    COP [07] ( #$9C01, &code_01AC2D )
    COP [01] ( &w0_shared_01ABB9.asciistring_01ABB9 )
    COP [38] ( #$0080 )
    COP [09] ( #$9C01 )
    RTL 
}

code_01AC2D {
    COP [01] ( &w0_shared_01ABB9.asciistring_01ABE0 )
    RTL 
}