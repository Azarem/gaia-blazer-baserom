?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_0226C0 {
    COP [14] ( #$0129, &code_0226C7 ) ; {140992}
    RTL                   ; {140998}
}

code_0226C7 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {140999}
    COP [17] ( &code_0226F7 ) ; {141004}
    COP [07] ( #$0605, &code_0226DC ) ; {141008}
    COP [07] ( #$8606, &code_0226E4 ) ; {141014}
}

code_0226DC {
    COP [15]              ; {141020}
    COP [05] ( #$0002 )   ; {141022}
    COP [16]              ; {141026}
}

code_0226E4 {
    COP [96]              ; {141028}
    COP [80] ( #0F )      ; {141030}
    COP [82]              ; {141033}
    COP [97]              ; {141035}
    COP [80] ( #0C )      ; {141037}
    COP [82]              ; {141040}
    COP [15]              ; {141042}
    COP [91]              ; {141044}
    RTL                   ; {141046}
}

code_0226F7 {
    COP [07] ( #$0605, &code_022703 ) ; {141047}
    COP [07] ( #$8606, &code_022708 ) ; {141053}
}

code_022703 {
    COP [01] ( &asciistring_022711 ) ; {141059}
    RTL                   ; {141063}
}

code_022708 {
    COP [01] ( &asciistring_022750 ) ; {141064}
    COP [09] ( #$8002 )   ; {141068}
    RTL                   ; {141072}
}

asciistring_022711 |[10]Would you please take [N]the cats out of the [N]room? [FIN]I am too scared to [N]move around with them [N]in here- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022750 |[10]Thank you very much- [N]Now I can walk around [N]the room freely- [FIN]Let me give you [N]something- [N]Please come inside- [JMP:&w4_shared_023F33.asciistring_023FA3]|