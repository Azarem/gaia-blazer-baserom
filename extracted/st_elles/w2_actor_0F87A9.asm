?BANK 1F

?INCLUDE 'w2_shared_0F8B27'
?INCLUDE 'w2_shared_0FA945'

!joy_block_mask                 0326

---------------------------------------------

code_0F87A9 {
    COP [14] ( #$008D, &code_0F87B0 ) ; {1017769}
    RTL                   ; {1017775}
}

code_0F87B0 {
    COP [30] ( #$008D, &code_0F87F9, #1F ) ; {1017776}
    COP [17] ( &code_0F87D5 ) ; {1017783}
    COP [91]              ; {1017787}
    COP [0D] ( #00, #22, #1C, &code_0F87C5 ) ; {1017789}
    RTL                   ; {1017796}
}

code_0F87C5 {
    COP [11] ( #00, #23, #1E ) ; {1017797}
    COP [33]              ; {1017802}
    LDA #$EF80            ; {1017804}
    TRB $joy_block_mask   ; {1017807}
    COP [91]              ; {1017810}
    RTL                   ; {1017812}
}

code_0F87D5 {
    COP [01] ( &asciistring_0F8800 ) ; {1017813}
    COP [07] ( #$8407, &code_0F87F8 ) ; {1017817}
    LDA #$EF80            ; {1017823}
    TSB $joy_block_mask   ; {1017826}
    LDA #$0020            ; {1017829}
    STA $03B4             ; {1017832}
    COP [09] ( #$8903 )   ; {1017835}
    COP [10] ( #$0107, #02, #$06A0, #$0040 ) ; {1017839}
}

code_0F87F8 {
    RTL                   ; {1017848}
}

code_0F87F9 {
    COP [01] ( &w2_shared_0F8B27.asciistring_0F8B27 ) ; {1017849}
    COP [86]              ; {1017853}
    RTL                   ; {1017855}
}

asciistring_0F8800 |[10]I will open a passage [N]for you- [FIN]Travel up the seabed [N]to reach the island of[N]rain, Blester- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|