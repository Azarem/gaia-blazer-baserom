?BANK 1F

?INCLUDE 'w2_shared_0F8B27'
?INCLUDE 'w2_shared_0FA945'

!joy_block_mask                 0326

---------------------------------------------

code_0F961C {
    COP [14] ( #$00B9, &code_0F9623 )
    RTL 
}

code_0F9623 {
    COP [30] ( #$00B9, &code_0F966C, #1F )
    COP [17] ( &code_0F9648 )
    COP [91]
    COP [0D] ( #00, #1C, #1C, &code_0F9638 )
    RTL 
}

code_0F9638 {
    COP [11] ( #00, #1C, #1E )
    COP [33]
    LDA #$AFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_0F9648 {
    COP [01] ( &asciistring_0F9673 )
    COP [07] ( #$8501, &code_0F966B )
    LDA #$EF80
    TSB $joy_block_mask
    LDA #$0020
    STA $03B4
    COP [09] ( #$8903 )
    COP [10] ( #$0107, #02, #$0140, #$0040 )
}

code_0F966B {
    RTL 
}

code_0F966C {
    COP [01] ( &w2_shared_0F8B27.asciistring_0F8B27 )
    COP [86]
    RTL 
}

asciistring_0F9673 |[10]I will open the [N]passage for you- [FIN]Go ¦ along the [N]seabed and you will [N]find a ghost ship- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|