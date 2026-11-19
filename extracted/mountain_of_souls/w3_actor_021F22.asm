?BANK 04

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w3_shared_021EFB'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021F22 {
    COP [14] ( #$00D9, &code_021F29 ) ; {139042}
    RTL                   ; {139048}
}

code_021F29 {
    JSL $@w0_shared_01B161.code_01B161 ; {139049}
    COP [17] ( &code_021F3D ) ; {139053}
    SEP #$20              ; {139057}
    LDA #$^w3_shared_022289.code_022289 ; {139059}
    PHA                   ; {139061}
    REP #$20              ; {139062}
    LDA #$&w3_shared_022289.code_022289-1 ; {139064}
    PHA                   ; {139067}
    RTL                   ; {139068}
}

code_021F3D {
    COP [07] ( #$9D05, &w3_shared_021EFB.code_021EFB ) ; {139069}
    COP [01] ( &w3_shared_02249A.asciistring_02249A ) ; {139075}
    COP [38] ( #$0400 )   ; {139079}
    COP [09] ( #$9D05 )   ; {139083}
    BRL w3_shared_021EFB.code_021EFB ; {139087}
}