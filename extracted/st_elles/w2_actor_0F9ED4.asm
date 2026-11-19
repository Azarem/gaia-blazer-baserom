?BANK 1F

!joy_block_mask                 0326

---------------------------------------------

code_0F9ED4 {
    COP [07] ( #$8406, &code_0F9EE6 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #5B, #24, &code_0F9EF0 )
    RTL 
}

code_0F9EE6 {
    COP [80] ( #26 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_0F9EF0 {
    LDA #$EF80
    TSB $joy_block_mask
    COP [34]
    COP [1B] ( &code_0F9EFE, #$0078 )
}

code_0F9EFE {
    BRK #$9C
    COP [81] ( #26, #10 )
    COP [83]
    COP [81] ( #27, #08 )
    COP [83]
    COP [1B] ( &code_0F9F12, #$005A )
}

code_0F9F12 {
    COP [09] ( #$8406 )
    COP [09] ( #$0903 )
    COP [10] ( #$0106, #01, #$0220, #$0220 )
    RTL 
}