?BANK 03

?INCLUDE 'lib_014F02'
?INCLUDE 'w0_shared_01B988'

!L_choice_result                0003D0
!joy_block_mask                 0326
!player_actor                   039C

---------------------------------------------

code_0186A2 {
    COP [14] ( #$000E, &code_0186A9 ) ; {100002}
    RTL                   ; {100008}
}

code_0186A9 {
    COP [30] ( #$000E, &code_018774, #03 ) ; {100009}
    COP [07] ( #$8404, &code_018742 ) ; {100016}
    COP [15]              ; {100022}
    COP [17] ( &code_018766 ) ; {100024}
    COP [05] ( #$0001 )   ; {100028}
    COP [16]              ; {100032}
    LDA #$2F80            ; {100034}
    TSB $joy_block_mask   ; {100037}
    COP [96]              ; {100040}
    COP [9D] ( #05 )      ; {100042}
    COP [9E] ( &code_0186D1 ) ; {100045}
}

code_0186D1 {
    COP [9D] ( #04 )      ; {100049}
    COP [9E] ( &code_0186D8 ) ; {100052}
}

code_0186D8 {
    COP [80] ( #00 )      ; {100056}
    COP [82]              ; {100059}
    LDA #$2F80            ; {100061}
    TRB $joy_block_mask   ; {100064}
    COP [15]              ; {100067}

  loc_0186E5:
    COP [91]              ; {100069}
    COP [0D] ( #00, #26, #17, &code_0186EF ) ; {100071}
    RTL                   ; {100078}
}

code_0186EF {
    LDA #$2F80            ; {100079}
    TSB $joy_block_mask   ; {100082}
    LDY $player_actor     ; {100085}
    LDA #$0001            ; {100088}
    STA $001E, Y          ; {100091}
    COP [03] ( #03 )      ; {100094}
    COP [04]              ; {100097}
    LDA #$2F80            ; {100099}
    TRB $joy_block_mask   ; {100102}
    COP [01] ( &asciistring_018889 ) ; {100105}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_018732 ) ; {100109}
    LDA $L_choice_result  ; {100116}
    BNE code_018732       ; {100120}
    COP [01] ( &asciistring_0188A7 ) ; {100122}
    BRK #$4F              ; {100126}
    COP [09] ( #$8404 )   ; {100128}

  loc_018724:
    COP [17] ( &code_01876F ) ; {100132}
    COP [91]              ; {100136}
    COP [0D] ( #00, #2F, #32, &code_018750 ) ; {100138}
    RTL                   ; {100145}
}

code_018732 {
    COP [01] ( &w0_shared_01B988.asciistring_01B988+M ) ; {100146}
    COP [91]              ; {100150}
    COP [0D] ( #00, #26, #17, &code_018741 ) ; {100152}
    BRA loc_0186E5        ; {100159}
}

code_018741 {
    RTL                   ; {100161}
}

code_018742 {
    COP [11] ( #08, #27, #17 ) ; {100162}
    COP [15]              ; {100167}
    COP [80] ( #00 )      ; {100169}
    COP [82]              ; {100172}
    BRA loc_018724        ; {100174}
}

code_018750 {
    COP [07] ( #$9A00, &code_018763 ) ; {100176}
    COP [01] ( &asciistring_0188FC ) ; {100182}
    BRK #$5E              ; {100186}
    COP [0A] ( #2A )      ; {100188}
    COP [09] ( #$9A00 )   ; {100191}
}

code_018763 {
    COP [91]              ; {100195}
    RTL                   ; {100197}
}

code_018766 {
    COP [01] ( &asciistring_01877B ) ; {100198}
    COP [09] ( #$8001 )   ; {100202}
    RTL                   ; {100206}
}

code_01876F {
    COP [01] ( &asciistring_0187E0 ) ; {100207}
    RTL                   ; {100211}
}

code_018774 {
    COP [01] ( &asciistring_018836 ) ; {100212}
    COP [86]              ; {100216}
    RTL                   ; {100218}
}

asciistring_01877B |[10]Rotating this wheel [N]will move the elevator[N]in the Underground [N]Castle- [FIN]I am too weak to turn [N]this wheel, will you [N]do it for me? [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0187E0 |[10]Oh, no wonder! I was [N]turning it the wrong [N]way! [FIN]By the way, don t you [N]think this water mill [N]is great?! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018836 |[10][0E:3C]A man s voice came [N]from inside the water [N]mill- [FIN]DARN IT! [FIN]This stupid wheel! [N]It s so hard to turn! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_018889 |[10]This is the wheel, [N]will you try to turn [N]it? [END]|

asciistring_0188A7 |[02:2] [N]turned the wheel- [FIN]As the wheel started [N]to turn, power was [N]transmitted to the [N]Underground Castle- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0188FC |[10]This is [03:24]the Master s [N]Emblem A- [03:20][JMP:&w0_shared_01B988.asciistring_01B988]|