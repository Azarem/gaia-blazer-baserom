?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

!joy_block_mask                 0326

---------------------------------------------

code_01A098 {
    COP [14] ( #$0009, &code_01A09F )
    RTL 
}

code_01A09F {
    COP [30] ( #$0009, &code_01A139, #03 )
    COP [11] ( #01, #04, #08 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01A11F )
    COP [15]
    COP [91]
    COP [07] ( #$9B00, &code_01A0C5 )
    COP [18] ( #3A, &code_01A0C5 )
    BRA loc_01A0C6
}

code_01A0C5 {
    RTL 

  loc_01A0C6:
    LDA #$2F80
    TSB $joy_block_mask
    COP [17] ( #$0000 )
    COP [31] ( #00 )
    COP [85] ( @code_01A105 )
    COP [03] ( #F1 )
    COP [04]
    COP [01] ( &asciistring_01A2C4 )
    COP [09] ( #$9B00 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [85] ( @code_01A112 )
    COP [32] ( #02 )
    COP [03] ( #3D )
    COP [04]
    LDA #$2F80
    TRB $joy_block_mask
    COP [17] ( &code_01A11F )
    COP [91]
    RTL 
}

code_01A105 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #45 )
    COP [94]
    COP [86]
    RTL 
}

code_01A112 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #46 )
    COP [94]
    COP [86]
    RTL 
}

code_01A11F {
    COP [07] ( #$9B00, &code_01A12A )
    COP [18] ( #3A, &code_01A12F )
}

code_01A12A {
    COP [01] ( &asciistring_01A272 )
    RTL 
}

code_01A12F {
    COP [01] ( &asciistring_01A191 )
    BRK #$5E
    COP [0A] ( #3A )
    RTL 
}

code_01A139 {
    COP [01] ( &asciistring_01A142 )
    COP [37]
    COP [86]
    RTL 
}

asciistring_01A142 |[10][0E:3C]Welcome to my room- [N]I finally feel like [N]myself again- [FIN]I have something to [N]tell you- [N]Please come back to [N]my house- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01A191 |[10]I feel as though I [N]have been surrounded [N]by darkness- [FIN]In that darkness I [N]heard my best friend [N]Leo- [FIN]He told me to give [N]this Brown Stone to a [N]person named [02:2]-[FIN]I don t know what the [N]Brown Stone looks like[N]but this is a stone [FIN]that I received from [N]him the day before he [N]disappeared- [FIN][02:2], received [N][03:24]the Brown Stone- [03:20][JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01A272 |[10]Dr-Leo has only a [N]daughter named Lisa- [FIN]I will ask my wife to [N]look after her until [N]Dr-Leo returns- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01A2C4 |[10]Suddenly the Master s [N]voice came thundering [N]down from the heavens-[FIN]"The Brown Stone you [N]have is a key to open [N]the World of Evil- [FIN]This is where [N]Deathtoll lives! [FIN]Come back to me with [N]the stone-ˮ [JMP:&w0_shared_01B988.asciistring_01B988]|