?BANK 04

?INCLUDE 'lib_014F02'
?INCLUDE 'w5_shared_02706C'

!L_choice_result                0003D0

---------------------------------------------

code_024597 {
    COP [14] ( #$0167, &code_02459E ) ; {148887}
    RTL                   ; {148893}
}

code_02459E {
    COP [30] ( #$0167, &code_024615, #04 ) ; {148894}
    COP [17] ( &code_0245CB ) ; {148901}
    COP [15]              ; {148905}
    COP [80] ( #1B )      ; {148907}
    COP [82]              ; {148910}
    COP [91]              ; {148912}
    RTL                   ; {148914}
}

code_0245B3 {
    COP [80] ( #1C )      ; {148915}
    COP [82]              ; {148918}
    COP [31] ( #12 )      ; {148920}
    COP [03] ( #79 )      ; {148923}
    COP [04]              ; {148926}
    COP [09] ( #$8001 )   ; {148928}

  loc_0245C4:
    COP [80] ( #1D )      ; {148932}
    COP [82]              ; {148935}
    BRA loc_0245C4        ; {148937}
}

code_0245CB {
    COP [07] ( #$8703, &code_0245FF ) ; {148939}
    COP [19] ( #1A, &code_024610 ) ; {148945}
    COP [01] ( &asciistring_02480A ) ; {148950}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_0245FA ) ; {148954}
    LDA $L_choice_result  ; {148961}
    BNE code_0245FA       ; {148965}
    COP [09] ( #$8703 )   ; {148967}
    COP [01] ( &asciistring_02484C ) ; {148971}
    COP [0B] ( #1A )      ; {148975}
    COP [17] ( &code_02460B ) ; {148978}
    COP [27] ( &code_0245B3 ) ; {148982}
}

code_0245FA {
    COP [01] ( &asciistring_024871 ) ; {148986}
    RTL                   ; {148990}
}

code_0245FF {
    COP [01] ( &asciistring_024676 ) ; {148991}
    COP [17] ( &code_02460B ) ; {148995}
    COP [27] ( &code_0245B3 ) ; {148999}
}

code_02460B {
    COP [01] ( &asciistring_02479E ) ; {149003}
    RTL                   ; {149007}
}

code_024610 {
    COP [01] ( &asciistring_0247DE ) ; {149008}
    RTL                   ; {149012}
}

code_024615 {
    COP [01] ( &asciistring_02461C ) ; {149013}
    COP [86]              ; {149017}
    RTL                   ; {149019}
}

asciistring_02461C |[10][0E:3C]A sad sounding voice [N]is coming from the [N]theater- [FIN]Oh, what can I do? [N]I can t play a harp [N]without strings- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024676 |[10][::]Thank you very [N]much for coming- [FIN]Before I play some [N]music let me tell you [N]my story- [FIN]I fell in love just [N]once in my 24 years- [FIN]It was when I visited [N]a mine town, [N]Grass Valley- [FIN]When I was injured, [N]there was a girl who [N]took care of me- [FIN]I couldn t tell her [N]my true feelings [N]though-------- [FIN]The girl s name was [N]something like Lisa- [FIN]The music I am going [N]to play now is a song [N]that I wrote for her- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_02479E |[10]There are no words- [FIN]I hope someday someone[N]will be able to put [N]words to my music- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0247DE |[10]I want to play music, [N]but the harp string [N]is broken- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_02480A |[10]Oh! [N]That is a harp string-[FIN]I promise to use it [N]carefully if you give [N]it to me- [END]|

asciistring_02484C |Thank you very much- [N]Please sit and [N]listen to my music- [FIN][JMP:&asciistring_024676+M]|

asciistring_024871 |It seems important [N]to you- [JMP:&w5_shared_02706C.asciistring_0270DF]|