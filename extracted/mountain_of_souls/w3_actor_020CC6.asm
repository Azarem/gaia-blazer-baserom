?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

!joy_block_mask                 0326
!return_active                  03FB

---------------------------------------------

code_020CC6 {
    COP [14] ( #$00E9, &code_020CCD )
    RTL 
}

code_020CCD {
    COP [30] ( #$00E9, &code_020D65, #04 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [1B] ( &code_020CDF, #$0002 )
}

code_020CDF {
    COP [07] ( #$0007, &code_020D14 )
    LDA #$FFFF
    STA $return_active
    COP [80] ( #04 )
    COP [82]
    COP [03] ( #03 )
    COP [97]
    COP [81] ( #05, #02 )
    COP [83]
    COP [96]
    COP [81] ( #05, #02 )
    COP [83]
    COP [04]
    COP [97]
    COP [80] ( #05 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    COP [91]
    RTL 
}

code_020D14 {
    COP [17] ( &code_020D51 )
    COP [15]
    COP [05] ( #$0003 )
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [96]
    COP [80] ( #02 )
    COP [82]
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_020EB9 )
    COP [16]
    COP [80] ( #26 )
    COP [82]
    COP [09] ( #$0003 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}

code_020D51 {
    COP [18] ( #22, &code_020D5B )
    COP [01] ( &asciistring_020E72 )
    RTL 
}

code_020D5B {
    COP [01] ( &asciistring_020DDC )
    BRK #$5E
    COP [0A] ( #22 )
    RTL 
}

code_020D65 {
    COP [09] ( #$8007 )
    COP [01] ( &asciistring_020D73 )
    STZ $return_active
    COP [86]
    RTL 
}

asciistring_020D73 |[10][0E:28]Hooray! I am back! [N]I am back! [0E:B4][N]Thank you very much- [FIN]I will give you these [N]Mushroom Shoes if you [N]return to me- [FIN]You will be able to [N]walk on ice! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020DDC |[10]I will give you my [N]Mushroom Shoes- [FIN]There is snail goo on [N]the bottom of these [N]shoes- [FIN]If you wear these you [N]will not slip on the [N]ice- [FIN]You will still slip on[N]the slopes though- [FIN][02:2], received [N][03:24]Mushroom Shoes- [03:20][JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020E72 |[10]How do you like my [N]Mushroom Shoes? [FIN]My people make [N]clothing and shoes [N]from mushrooms- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020EB9 |[10]This snail always [N]wants me to walk with [N]it- [FIN]Where shall we go [N]today? [JMP:&w3_shared_02249A.asciistring_02251E]|