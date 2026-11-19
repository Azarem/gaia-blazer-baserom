?BANK 1F

?INCLUDE 'w0_shared_01B161'
?INCLUDE 'w2_shared_0FA46D'
?INCLUDE 'w2_shared_0FA945'

---------------------------------------------

code_0FA494 {
    COP [14] ( #$007F, &code_0FA49B ) ; {1025172}
    RTL                   ; {1025178}
}

code_0FA49B {
    JSL $@w0_shared_01B161.code_01B161 ; {1025179}
    COP [17] ( &code_0FA4AF ) ; {1025183}
    SEP #$20              ; {1025187}
    LDA #$^w2_shared_0FA945.code_0FA945 ; {1025189}
    PHA                   ; {1025191}
    REP #$20              ; {1025192}
    LDA #$&w2_shared_0FA945.code_0FA945-1 ; {1025194}
    PHA                   ; {1025197}
    RTL                   ; {1025198}
}

code_0FA4AF {
    COP [07] ( #$9D06, &w2_shared_0FA46D.code_0FA46D ) ; {1025199}
    COP [01] ( &w2_shared_0FA945.asciistring_0FA9C5 ) ; {1025205}
    COP [38] ( #$0300 )   ; {1025209}
    COP [09] ( #$9D06 )   ; {1025213}
    BRL w2_shared_0FA46D.code_0FA46D ; {1025217}
}