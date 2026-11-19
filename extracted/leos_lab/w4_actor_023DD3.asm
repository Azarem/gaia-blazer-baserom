?BANK 04

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w4_shared_023E00'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_023DD3 {
    COP [14] ( #$0127, &code_023DDA ) ; {146899}
    RTL                   ; {146905}
}

code_023DDA {
    JSL $@w0_shared_01B161.code_01B161 ; {146906}
    COP [17] ( &code_023DEE ) ; {146910}
    SEP #$20              ; {146914}
    LDA #$^w3_shared_022289.code_022289 ; {146916}
    PHA                   ; {146918}
    REP #$20              ; {146919}
    LDA #$&w3_shared_022289.code_022289-1 ; {146921}
    PHA                   ; {146924}
    RTL                   ; {146925}
}

code_023DEE {
    COP [07] ( #$9D01, &w4_shared_023E00.code_023E00 ) ; {146926}
    COP [01] ( &w4_shared_023F33.asciistring_023F33 ) ; {146932}
    COP [38] ( #$0300 )   ; {146936}
    COP [09] ( #$9D01 )   ; {146940}
}