?BANK 1F

?INCLUDE 'w2_shared_0F8B27'
?INCLUDE 'w2_shared_0FA945'

!joy_block_mask                 0326

---------------------------------------------

code_0F8E99 {
    COP [14] ( #$00AB, &code_0F8EA0 )
    RTL 
}

code_0F8EA0 {
    COP [30] ( #$00AB, &code_0F8EE9, #1F )
    COP [17] ( &code_0F8EC5 )
    COP [91]
    COP [0D] ( #00, #1C, #22, &code_0F8EB5 )
    RTL 
}

code_0F8EB5 {
    COP [11] ( #00, #1C, #24 )
    COP [33]
    LDA #$AFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_0F8EC5 {
    COP [01] ( &asciistring_0F8EF0 )
    COP [07] ( #$8500, &code_0F8EE8 )
    LDA #$EF80
    TSB $joy_block_mask
    LDA #$0020
    STA $03B4
    COP [09] ( #$8903 )
    COP [10] ( #$0107, #02, #$0240, #$02B0 )
}

code_0F8EE8 {
    RTL 
}

code_0F8EE9 {
    COP [01] ( &w2_shared_0F8B27.asciistring_0F8B27 )
    COP [86]
    RTL 
}

asciistring_0F8EF0 |[10]I will open the [N]passage for you- [FIN]Walk downward under [N]the sea and go to the [N]volcanic island, [N]Durean- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|