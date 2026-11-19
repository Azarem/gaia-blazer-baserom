?BANK 1F

?INCLUDE 'w2_shared_0F8B27'
?INCLUDE 'w2_shared_0FA945'

!joy_block_mask                 0326

---------------------------------------------

code_0F8A7E {
    COP [14] ( #$009D, &code_0F8A85 ) ; {1018494}
    RTL                   ; {1018500}
}

code_0F8A85 {
    COP [30] ( #$009D, &code_0F8ACE, #1F ) ; {1018501}
    COP [17] ( &code_0F8AAA ) ; {1018508}
    COP [91]              ; {1018512}
    COP [0D] ( #00, #22, #22, &code_0F8A9A ) ; {1018514}
    RTL                   ; {1018521}
}

code_0F8A9A {
    COP [11] ( #00, #23, #24 ) ; {1018522}
    COP [33]              ; {1018527}
    LDA #$AFC0            ; {1018529}
    TRB $joy_block_mask   ; {1018532}
    COP [91]              ; {1018535}
    RTL                   ; {1018537}
}

code_0F8AAA {
    COP [01] ( &asciistring_0F8AD5 ) ; {1018538}
    COP [07] ( #$8406, &code_0F8ACD ) ; {1018542}
    LDA #$EF80            ; {1018548}
    TSB $joy_block_mask   ; {1018551}
    LDA #$0020            ; {1018554}
    STA $03B4             ; {1018557}
    COP [09] ( #$8903 )   ; {1018560}
    COP [10] ( #$0107, #02, #$05B0, #$0240 ) ; {1018564}
}

code_0F8ACD {
    RTL                   ; {1018573}
}

code_0F8ACE {
    COP [01] ( &w2_shared_0F8B27.asciistring_0F8B27 ) ; {1018574}
    COP [86]              ; {1018578}
    RTL                   ; {1018580}
}

asciistring_0F8AD5 |[10]I will open a passage [N]for you- [FIN]Proceed right along [N]the seabed to the [N]shore reef, Rockbird- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|