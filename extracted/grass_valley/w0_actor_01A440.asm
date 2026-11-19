?BANK 03

?INCLUDE 'lib_014F15'
?INCLUDE 'w0_actor_01A440_part2'

!joy_block_mask                 0326

---------------------------------------------

code_01A440 {
    COP [14] ( #$0010, &code_01A447 )
    RTL 
}

code_01A447 {
    COP [07] ( #$9F02, &code_01A491 )
    COP [17] ( &code_01A4DF )
    COP [15]
    COP [91]
    COP [14] ( #$0032, &code_01A45C )
    RTL 
}

code_01A45C {
    COP [01] ( &w0_actor_01A440_part2.asciistring_01A521 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [81] ( #21, #02 )
    COP [83]
    COP [80] ( #22 )
    COP [82]
    LDA #$2F80
    TRB $joy_block_mask
    COP [01] ( &w0_actor_01A440_part2.asciistring_01A59F )
    COP [17] ( &code_01A4E4 )
    COP [91]
    COP [0D] ( #00, #12, #35, &code_01A489 )
    RTL 
}

code_01A489 {
    COP [80] ( #1F )
    COP [82]
    COP [91]
    RTL 
}

code_01A491 {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [9F] ( #$0018 )
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &w0_actor_01A440_part2.asciistring_01A604 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [1A] ( &lib_014F15.asciistring_014F15, #01, &code_01A4B1 )
}

code_01A4B1 {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [01] ( &w0_actor_01A440_part2.asciistring_01A77E )
    COP [03] ( #B5 )
    COP [04]
    COP [09] ( #$9F01 )
    LDA #$0003
    STA $031E
    COP [3C] ( #04 )
    COP [10] ( #$0101, #01, #$03B0, #$01D8 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_01A4DF {
    COP [01] ( &w0_actor_01A440_part2.asciistring_01A50A )
    RTL 
}

code_01A4E4 {
    COP [01] ( &w0_actor_01A440_part2.asciistring_01A5E9 )
    COP [09] ( #$8104 )
    COP [3C] ( #04 )
    COP [10] ( #$0101, #03, #$03B0, #$01E0 )
    RTL 
}