?BANK 1F

?INCLUDE 'w2_shared_0FA945'

!joy_block_mask                 0326

---------------------------------------------

code_0FA106 {
    COP [17] ( &code_0FA159 )
    COP [15]

  code_0FA10C:
    COP [80] ( #10 )
    COP [82]
    COP [07] ( #$0506, &code_0FA10C )
    COP [16]
    LDA #$2F80
    TSB $joy_block_mask
    COP [81] ( #0D, #04 )
    COP [83]
    LDA #$2F80
    TRB $joy_block_mask
    COP [15]

  loc_0FA12D:
    COP [14] ( #$0079, &code_0FA13A )
    COP [80] ( #10 )
    COP [82]
    BRA loc_0FA12D
}

code_0FA13A {
    LDA #$2F80
    TSB $joy_block_mask
    COP [81] ( #10, #02 )
    COP [83]
    LDA #$2F80
    TRB $joy_block_mask
    COP [3C] ( #04 )
    COP [10] ( #$0307, #02, #$0040, #$0080 )
    RTL 
}

code_0FA159 {
    COP [19] ( #20, &code_0FA16E )
    COP [01] ( &asciistring_0FA1E9 )
    COP [0B] ( #20 )
    COP [17] ( &code_0FA17F )
    COP [09] ( #$8506 )
    RTL 
}

code_0FA16E {
    COP [01] ( &asciistring_0FA184 )
    COP [3C] ( #04 )
    COP [10] ( #$0307, #00, #$0040, #$0070 )
    RTL 
}

code_0FA17F {
    COP [01] ( &asciistring_0FA237 )
    RTL 
}

asciistring_0FA184 |[10]I used to live [N]here- [FIN]I am trying to [N]remember something but[N]I cannot- [FIN]When I close my eyes, [N]I see something like [N]a ball, shiny and [N]black---- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0FA1E9 |[10]That Pearl! [FIN]Yes, I was going to [N]present that Pearl- [FIN][::]This is the Coral [N]Reef- I have missed [N]this place- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0FA237 |[10][JMP:&asciistring_0FA1E9+M]|