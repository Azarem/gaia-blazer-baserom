?BANK 04

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w3_shared_021EFB'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w3_shared_02249A'

---------------------------------------------

code_021ECE {
    COP [14] ( #$00EC, &code_021ED5 ) ; {138958}
    RTL                   ; {138964}
}

code_021ED5 {
    JSL $@w0_shared_01B161.code_01B161 ; {138965}
    COP [17] ( &code_021EE9 ) ; {138969}
    SEP #$20              ; {138973}
    LDA #$^w3_shared_022289.code_022289 ; {138975}
    PHA                   ; {138977}
    REP #$20              ; {138978}
    LDA #$&w3_shared_022289.code_022289-1 ; {138980}
    PHA                   ; {138983}
    RTL                   ; {138984}
}

code_021EE9 {
    COP [07] ( #$9E00, &w3_shared_021EFB.code_021EFB ) ; {138985}
    COP [01] ( &w3_shared_02249A.asciistring_02249A ) ; {138991}
    COP [38] ( #$0300 )   ; {138995}
    COP [09] ( #$9E00 )   ; {138999}
}