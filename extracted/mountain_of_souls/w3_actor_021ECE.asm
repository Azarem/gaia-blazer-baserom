?BANK 04

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w3_shared_021EFB'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021ECE {
    COP [14] ( #$00EC, &code_021ED5 )
    RTL 
}

code_021ED5 {
    JSL $@w0_shared_01B161.code_01B161
    COP [17] ( &code_021EE9 )
    SEP #$20
    LDA #$^w3_shared_022289.code_022289
    PHA 
    REP #$20
    LDA #$&w3_shared_022289.code_022289-1
    PHA 
    RTL 
}

code_021EE9 {
    COP [07] ( #$9E00, &w3_shared_021EFB.code_021EFB )
    COP [01] ( &w3_shared_02249A.asciistring_02249A )
    COP [38] ( #$0300 )
    COP [09] ( #$9E00 )
}