?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01CD6D {
    COP [14] ( #$003D, &code_01CD74 ) ; {118125}
    RTL                   ; {118131}
}

code_01CD74 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {118132}
    COP [17] ( &code_01CDE1 ) ; {118137}
    COP [15]              ; {118141}
    COP [91]              ; {118143}
    RTL                   ; {118145}
}

code_01CD82 {
    COP [17] ( &code_01CDE9 ) ; {118146}
    COP [16]              ; {118150}
    COP [80] ( #0F )      ; {118152}
    COP [82]              ; {118155}
    COP [9D] ( #0F )      ; {118157}
    COP [9E] ( &code_01CD94 ) ; {118160}
}

code_01CD94 {
    COP [87]              ; {118164}
    COP [81] ( #11, #08 ) ; {118166}
    COP [83]              ; {118170}
    COP [80] ( #0E )      ; {118172}
    COP [82]              ; {118175}
    COP [17] ( &code_01CDEE ) ; {118177}
    COP [15]              ; {118181}
    COP [91]              ; {118183}
    RTL                   ; {118185}
}

code_01CDAA {
    COP [16]              ; {118186}
    COP [17] ( &code_01CDF6 ) ; {118188}
    COP [81] ( #10, #06 ) ; {118192}
    COP [83]              ; {118196}
    COP [81] ( #11, #02 ) ; {118198}
    COP [83]              ; {118202}
    COP [80] ( #10 )      ; {118204}
    COP [82]              ; {118207}
    COP [80] ( #0D )      ; {118209}
    COP [82]              ; {118212}
    COP [17] ( &code_01CDFB ) ; {118214}
    COP [15]              ; {118218}
    COP [91]              ; {118220}
    COP [0D] ( #00, #1D, #09, &code_01CDD6 ) ; {118222}
    RTL                   ; {118229}
}

code_01CDD6 {
    COP [01] ( &asciistring_01CED5 ) ; {118230}
    COP [09] ( #$8001 )   ; {118234}
    COP [91]              ; {118238}
    RTL                   ; {118240}
}

code_01CDE1 {
    COP [01] ( &asciistring_01CE0B ) ; {118241}
    COP [27] ( &code_01CD82 ) ; {118245}
}

code_01CDE9 {
    COP [01] ( &asciistring_01CE0B ) ; {118249}
    RTL                   ; {118253}
}

code_01CDEE {
    COP [01] ( &asciistring_01CE48 ) ; {118254}
    COP [27] ( &code_01CDAA ) ; {118258}
}

code_01CDF6 {
    COP [01] ( &asciistring_01CEA7 ) ; {118262}
    RTL                   ; {118266}
}

code_01CDFB {
    COP [07] ( #$8001, &code_01CE06 ) ; {118267}
    COP [01] ( &asciistring_01CEAB ) ; {118273}
    RTL                   ; {118277}
}

code_01CE06 {
    COP [01] ( &asciistring_01CEE6 ) ; {118278}
    RTL                   ; {118282}
}

asciistring_01CE0B |[10]I can tell what [N]something is just by [N]it s smell- [FIN]Allright, let me start[N]doing my job- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CE48 |[10]From >,[N][0E:3C]I smell fresh air- [FIN]From _, [0E:3C]I smell a [N]mole- [FIN]What is that smell!! [N][::]I smell something [N]strange coming from '-[JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CEA7 |[10][JMP:&asciistring_01CE48+M]|

asciistring_01CEAB |[10]It s around here [N]somewhere- [N]I smell something [N]really strange! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CED5 |[10]There is an outhouse- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01CEE6 |[10]Oh, this is our [N]bathroom- [FIN]Thank you for walking [N]with me- [N]I will tell you a [N]secret- [FIN]I can smell some armor[N]north of here- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|