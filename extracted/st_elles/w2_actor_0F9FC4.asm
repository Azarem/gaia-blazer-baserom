?BANK 1F

!joy_block_mask                 0326

---------------------------------------------

code_0F9FC4 {
    COP [07] ( #$8501, &code_0F9FD6 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #14, #04, &code_0F9FE0 )
    RTL 
}

code_0F9FD6 {
    COP [80] ( #26 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_0F9FE0 {
    LDA #$EF80
    TSB $joy_block_mask
    COP [34]
    COP [1B] ( &code_0F9FEE, #$0078 )
}

code_0F9FEE {
    BRK #$9C
    COP [81] ( #26, #10 )
    COP [83]
    COP [81] ( #27, #08 )
    COP [83]
    COP [1B] ( &code_0FA002, #$005A )
}

code_0FA002 {
    COP [09] ( #$8501 )
    COP [09] ( #$0903 )
    COP [10] ( #$0106, #01, #$01C0, #$01C0 )
    RTL 
}