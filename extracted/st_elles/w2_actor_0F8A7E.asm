?BANK 1F

?INCLUDE 'w2_shared_0F8B27'
?INCLUDE 'w2_shared_0FA945'

!joy_block_mask                 0326

---------------------------------------------

code_0F8A7E {
    COP [14] ( #$009D, &code_0F8A85 )
    RTL 
}

code_0F8A85 {
    COP [30] ( #$009D, &code_0F8ACE, #1F )
    COP [17] ( &code_0F8AAA )
    COP [91]
    COP [0D] ( #00, #22, #22, &code_0F8A9A )
    RTL 
}

code_0F8A9A {
    COP [11] ( #00, #23, #24 )
    COP [33]
    LDA #$AFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_0F8AAA {
    COP [01] ( &asciistring_0F8AD5 )
    COP [07] ( #$8406, &code_0F8ACD )
    LDA #$EF80
    TSB $joy_block_mask
    LDA #$0020
    STA $03B4
    COP [09] ( #$8903 )
    COP [10] ( #$0107, #02, #$05B0, #$0240 )
}

code_0F8ACD {
    RTL 
}

code_0F8ACE {
    COP [01] ( &w2_shared_0F8B27.asciistring_0F8B27 )
    COP [86]
    RTL 
}

asciistring_0F8AD5 |[10]I will open a passage [N]for you- [FIN]Proceed right along [N]the seabed to the [N]shore reef, Rockbird- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|