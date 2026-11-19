?BANK 1F

?INCLUDE 'w2_shared_0F8B27'
?INCLUDE 'w2_shared_0FA945'

!joy_block_mask                 0326

---------------------------------------------

code_0F87A9 {
    COP [14] ( #$008D, &code_0F87B0 )
    RTL 
}

code_0F87B0 {
    COP [30] ( #$008D, &code_0F87F9, #1F )
    COP [17] ( &code_0F87D5 )
    COP [91]
    COP [0D] ( #00, #22, #1C, &code_0F87C5 )
    RTL 
}

code_0F87C5 {
    COP [11] ( #00, #23, #1E )
    COP [33]
    LDA #$EF80
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_0F87D5 {
    COP [01] ( &asciistring_0F8800 )
    COP [07] ( #$8407, &code_0F87F8 )
    LDA #$EF80
    TSB $joy_block_mask
    LDA #$0020
    STA $03B4
    COP [09] ( #$8903 )
    COP [10] ( #$0107, #02, #$06A0, #$0040 )
}

code_0F87F8 {
    RTL 
}

code_0F87F9 {
    COP [01] ( &w2_shared_0F8B27.asciistring_0F8B27 )
    COP [86]
    RTL 
}

asciistring_0F8800 |[10]I will open a passage [N]for you- [FIN]Travel up the seabed [N]to reach the island of[N]rain, Blester- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|