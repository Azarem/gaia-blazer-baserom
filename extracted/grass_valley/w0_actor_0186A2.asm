?BANK 03

?INCLUDE 'lib_014F02'
?INCLUDE 'w0_shared_01B988'

!L_choice_result                0003D0
!joy_block_mask                 0326
!player_actor                   039C

---------------------------------------------

code_0186A2 {
    COP [14] ( #$000E, &code_0186A9 )
    RTL 
}

code_0186A9 {
    COP [30] ( #$000E, &code_018774, #03 )
    COP [07] ( #$8404, &code_018742 )
    COP [15]
    COP [17] ( &code_018766 )
    COP [05] ( #$0001 )
    COP [16]
    LDA #$2F80
    TSB $joy_block_mask
    COP [96]
    COP [9D] ( #05 )
    COP [9E] ( &code_0186D1 )
}

code_0186D1 {
    COP [9D] ( #04 )
    COP [9E] ( &code_0186D8 )
}

code_0186D8 {
    COP [80] ( #00 )
    COP [82]
    LDA #$2F80
    TRB $joy_block_mask
    COP [15]

  loc_0186E5:
    COP [91]
    COP [0D] ( #00, #26, #17, &code_0186EF )
    RTL 
}

code_0186EF {
    LDA #$2F80
    TSB $joy_block_mask
    LDY $player_actor
    LDA #$0001
    STA $001E, Y
    COP [03] ( #03 )
    COP [04]
    LDA #$2F80
    TRB $joy_block_mask
    COP [01] ( &asciistring_018889 )
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_018732 )
    LDA $L_choice_result
    BNE code_018732
    COP [01] ( &asciistring_0188A7 )
    BRK #$4F
    COP [09] ( #$8404 )

  loc_018724:
    COP [17] ( &code_01876F )
    COP [91]
    COP [0D] ( #00, #2F, #32, &code_018750 )
    RTL 
}

code_018732 {
    COP [01] ( &w0_shared_01B988.asciistring_01B988+M )
    COP [91]
    COP [0D] ( #00, #26, #17, &code_018741 )
    BRA loc_0186E5
}

code_018741 {
    RTL 
}

code_018742 {
    COP [11] ( #08, #27, #17 )
    COP [15]
    COP [80] ( #00 )
    COP [82]
    BRA loc_018724
}

code_018750 {
    COP [07] ( #$9A00, &code_018763 )
    COP [01] ( &asciistring_0188FC )
    BRK #$5E
    COP [0A] ( #2A )
    COP [09] ( #$9A00 )
}

code_018763 {
    COP [91]
    RTL 
}

code_018766 {
    COP [01] ( &asciistring_01877B )
    COP [09] ( #$8001 )
    RTL 
}

code_01876F {
    COP [01] ( &asciistring_0187E0 )
    RTL 
}

code_018774 {
    COP [01] ( &asciistring_018836 )
    COP [86]
    RTL 
}

asciistring_01877B |[10]Rotating this wheel [N]will move the elevator[N]in the Underground [N]Castle- [FIN]I am too weak to turn [N]this wheel, will you [N]do it for me? [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0187E0 |[10]Oh, no wonder! I was [N]turning it the wrong [N]way! [FIN]By the way, don t you [N]think this water mill [N]is great?! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018836 |[10][0E:3C]A man s voice came [N]from inside the water [N]mill- [FIN]DARN IT! [FIN]This stupid wheel! [N]It s so hard to turn! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018889 |[10]This is the wheel, [N]will you try to turn [N]it? [END]|

asciistring_0188A7 |[02:2] [N]turned the wheel- [FIN]As the wheel started [N]to turn, power was [N]transmitted to the [N]Underground Castle- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0188FC |[10]This is [03:24]the Master s [N]Emblem A- [03:20][JMP:&w0_shared_01B988.asciistring_01B988]|