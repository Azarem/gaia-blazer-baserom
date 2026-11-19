?BANK 1F

!joy_block_mask                 0326

---------------------------------------------

code_0F9F74 {
    COP [07] ( #$8500, &code_0F9F86 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #24, #2B, &code_0F9F90 )
    RTL 
}

code_0F9F86 {
    COP [80] ( #26 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_0F9F90 {
    LDA #$EF80
    TSB $joy_block_mask
    COP [34]
    COP [1B] ( &code_0F9F9E, #$0078 )
}

code_0F9F9E {
    BRK #$9C
    COP [81] ( #26, #10 )
    COP [83]
    COP [81] ( #27, #08 )
    COP [83]
    COP [1B] ( &code_0F9FB2, #$005A )
}

code_0F9FB2 {
    COP [09] ( #$8500 )
    COP [09] ( #$0903 )
    COP [10] ( #$0106, #01, #$01C0, #$0220 )
    RTL 
}