?BANK 1F

?INCLUDE 'w2_shared_0F8B27'
?INCLUDE 'w2_shared_0FA945'

!joy_block_mask                 0326

---------------------------------------------

code_0F961C {
    COP [14] ( #$00B9, &code_0F9623 ) ; {1021468}
    RTL                   ; {1021474}
}

code_0F9623 {
    COP [30] ( #$00B9, &code_0F966C, #1F ) ; {1021475}
    COP [17] ( &code_0F9648 ) ; {1021482}
    COP [91]              ; {1021486}
    COP [0D] ( #00, #1C, #1C, &code_0F9638 ) ; {1021488}
    RTL                   ; {1021495}
}

code_0F9638 {
    COP [11] ( #00, #1C, #1E ) ; {1021496}
    COP [33]              ; {1021501}
    LDA #$AFC0            ; {1021503}
    TRB $joy_block_mask   ; {1021506}
    COP [91]              ; {1021509}
    RTL                   ; {1021511}
}

code_0F9648 {
    COP [01] ( &asciistring_0F9673 ) ; {1021512}
    COP [07] ( #$8501, &code_0F966B ) ; {1021516}
    LDA #$EF80            ; {1021522}
    TSB $joy_block_mask   ; {1021525}
    LDA #$0020            ; {1021528}
    STA $03B4             ; {1021531}
    COP [09] ( #$8903 )   ; {1021534}
    COP [10] ( #$0107, #02, #$0140, #$0040 ) ; {1021538}
}

code_0F966B {
    RTL                   ; {1021547}
}

code_0F966C {
    COP [01] ( &w2_shared_0F8B27.asciistring_0F8B27 ) ; {1021548}
    COP [86]              ; {1021552}
    RTL                   ; {1021554}
}

asciistring_0F9673 |[10]I will open the [N]passage for you- [FIN]Go ¦ along the [N]seabed and you will [N]find a ghost ship- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|