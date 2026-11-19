?BANK 1F

!joy_block_mask                 0326

---------------------------------------------

code_0F9F24 {
    COP [07] ( #$8407, &code_0F9F36 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #6A, #04, &code_0F9F40 )
    RTL 
}

code_0F9F36 {
    COP [80] ( #26 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_0F9F40 {
    LDA #$EF80
    TSB $joy_block_mask
    COP [34]
    COP [1B] ( &code_0F9F4E, #$0078 )
}

code_0F9F4E {
    BRK #$9C
    COP [81] ( #26, #10 )
    COP [83]
    COP [81] ( #27, #08 )
    COP [83]
    COP [1B] ( &code_0F9F62, #$005A )
}

code_0F9F62 {
    COP [09] ( #$8407 )
    COP [09] ( #$0903 )
    COP [10] ( #$0106, #01, #$0220, #$01C0 )
    RTL 
}