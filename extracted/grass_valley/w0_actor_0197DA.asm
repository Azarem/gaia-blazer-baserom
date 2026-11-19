?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

!joy_pressed                    0322
!joy_block_mask                 0326

---------------------------------------------

code_0197DA {
    COP [14] ( #$0022, &code_0197E1 )
    RTL 
}

code_0197E1 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_019847 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #2F, #36, &code_0197F6 )
    RTL 
}

code_0197F6 {
    COP [03] ( #28 )
    LDA $joy_pressed
    AND #$0200
    BEQ loc_019843
    COP [0D] ( #00, #2F, #36, &code_01980B )
    BRL loc_019843
}

code_01980B {
    COP [04]
    COP [16]
    LDA #$2F80
    TSB $joy_block_mask
    COP [81] ( #20, #10 )
    COP [83]
    LDA #$2F80
    TRB $joy_block_mask
    COP [15]
    COP [07] ( #$8206, &code_019840 )
    COP [91]
    COP [0D] ( #00, #2E, #36, &code_019833 )
    RTL 
}

code_019833 {
    COP [01] ( &asciistring_01986F )
    BRK #$5E
    COP [0A] ( #1B )
    COP [09] ( #$8206 )
}

code_019840 {
    COP [91]
    RTL 

  loc_019843:
    COP [27] ( &code_0197F6 )
}

code_019847 {
    COP [19] ( #1C, &code_01985D )
    COP [01] ( &asciistring_019880 )
    COP [3C] ( #04 )
    COP [10] ( #$0403, #00, #$0078, #$0070 )
    RTL 
}

code_01985D {
    COP [01] ( &asciistring_019862 )
    RTL 
}

asciistring_019862 |[10]Zzzz---- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01986F |[10]There is [03:24]a pass- [03:20][JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019880 |[10][02:2] placed [N]the Dream Rod on the [N]tulip s petal- [JMP:&w0_shared_01B988.asciistring_01B988]|