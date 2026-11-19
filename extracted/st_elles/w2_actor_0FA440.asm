?BANK 1F

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w2_shared_0FA46D'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0FA440 {
    COP [14] ( #$00A6, &code_0FA447 ) ; {1025088}
    RTL                   ; {1025094}
}

code_0FA447 {
    JSL $@w0_shared_01B161.code_01B161 ; {1025095}
    COP [17] ( &code_0FA45B ) ; {1025099}
    SEP #$20              ; {1025103}
    LDA #$^w2_shared_0FA945.code_0FA945 ; {1025105}
    PHA                   ; {1025107}
    REP #$20              ; {1025108}
    LDA #$&w2_shared_0FA945.code_0FA945-1 ; {1025110}
    PHA                   ; {1025113}
    RTL                   ; {1025114}
}

code_0FA45B {
    COP [07] ( #$9D00, &w2_shared_0FA46D.code_0FA46D ) ; {1025115}
    COP [01] ( &w2_shared_0FA945.asciistring_0FA9C5 ) ; {1025121}
    COP [38] ( #$0200 )   ; {1025125}
    COP [09] ( #$9D00 )   ; {1025129}
}