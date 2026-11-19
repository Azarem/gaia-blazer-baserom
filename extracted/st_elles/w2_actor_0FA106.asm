?BANK 1F

?INCLUDE 'w2_shared_0FA945'

!joy_block_mask                 0326

---------------------------------------------

code_0FA106 {
    COP [17] ( &code_0FA159 ) ; {1024262}
    COP [15]              ; {1024266}

  code_0FA10C:
    COP [80] ( #10 )      ; {1024268}
    COP [82]              ; {1024271}
    COP [07] ( #$0506, &code_0FA10C ) ; {1024273}
    COP [16]              ; {1024279}
    LDA #$2F80            ; {1024281}
    TSB $joy_block_mask   ; {1024284}
    COP [81] ( #0D, #04 ) ; {1024287}
    COP [83]              ; {1024291}
    LDA #$2F80            ; {1024293}
    TRB $joy_block_mask   ; {1024296}
    COP [15]              ; {1024299}

  loc_0FA12D:
    COP [14] ( #$0079, &code_0FA13A ) ; {1024301}
    COP [80] ( #10 )      ; {1024307}
    COP [82]              ; {1024310}
    BRA loc_0FA12D        ; {1024312}
}

code_0FA13A {
    LDA #$2F80            ; {1024314}
    TSB $joy_block_mask   ; {1024317}
    COP [81] ( #10, #02 ) ; {1024320}
    COP [83]              ; {1024324}
    LDA #$2F80            ; {1024326}
    TRB $joy_block_mask   ; {1024329}
    COP [3C] ( #04 )      ; {1024332}
    COP [10] ( #$0307, #02, #$0040, #$0080 ) ; {1024335}
    RTL                   ; {1024344}
}

code_0FA159 {
    COP [19] ( #20, &code_0FA16E ) ; {1024345}
    COP [01] ( &asciistring_0FA1E9 ) ; {1024350}
    COP [0B] ( #20 )      ; {1024354}
    COP [17] ( &code_0FA17F ) ; {1024357}
    COP [09] ( #$8506 )   ; {1024361}
    RTL                   ; {1024365}
}

code_0FA16E {
    COP [01] ( &asciistring_0FA184 ) ; {1024366}
    COP [3C] ( #04 )      ; {1024370}
    COP [10] ( #$0307, #00, #$0040, #$0070 ) ; {1024373}
    RTL                   ; {1024382}
}

code_0FA17F {
    COP [01] ( &asciistring_0FA237 ) ; {1024383}
    RTL                   ; {1024387}
}

asciistring_0FA184 |[10]I used to live [N]here- [FIN]I am trying to [N]remember something but[N]I cannot- [FIN]When I close my eyes, [N]I see something like [N]a ball, shiny and [N]black---- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0FA1E9 |[10]That Pearl! [FIN]Yes, I was going to [N]present that Pearl- [FIN][::]This is the Coral [N]Reef- I have missed [N]this place- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0FA237 |[10][JMP:&asciistring_0FA1E9+M]|