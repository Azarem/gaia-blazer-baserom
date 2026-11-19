?BANK 04

?INCLUDE 'lib_014F02'
?INCLUDE 'w5_shared_02706C'

!L_choice_result                0003D0

---------------------------------------------

code_02494A {
    COP [14] ( #$017F, &code_024951 ) ; {149834}
    RTL                   ; {149840}
}

code_024951 {
    COP [30] ( #$017F, &code_0249D1, #04 ) ; {149841}
    COP [07] ( #$8805, &code_024978 ) ; {149848}
    COP [17] ( &code_02499F ) ; {149854}
    COP [15]              ; {149858}

  loc_024964:
    COP [07] ( #$8000, &code_024971 ) ; {149860}
    COP [80] ( #0C )      ; {149866}
    COP [82]              ; {149869}
    BRA loc_024964        ; {149871}
}

code_024971 {
    COP [80] ( #0D )      ; {149873}
    COP [82]              ; {149876}
    BRA loc_024964        ; {149878}
}

code_024978 {
    LDA $0016, X          ; {149880}
    ORA #$2000            ; {149883}
    STA $0016, X          ; {149886}
    COP [18] ( #37, &code_024989 ) ; {149889}
    COP [86]              ; {149894}
    RTL                   ; {149896}
}

code_024989 {
    COP [91]              ; {149897}
    COP [0D] ( #00, #36, #17, &code_024993 ) ; {149899}
    RTL                   ; {149906}
}

code_024993 {
    COP [01] ( &asciistring_024AB6 ) ; {149907}
    BRK #$5E              ; {149911}
    COP [0A] ( #37 )      ; {149913}
    COP [91]              ; {149916}
    RTL                   ; {149918}
}

code_02499F {
    COP [18] ( #29, &code_0249A9 ) ; {149919}
    COP [01] ( &asciistring_024A76 ) ; {149924}
    RTL                   ; {149928}
}

code_0249A9 {
    COP [01] ( &asciistring_024A21 ) ; {149929}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_0249C8 ) ; {149933}
    LDA $L_choice_result  ; {149940}
    BNE code_0249C8       ; {149944}
    COP [01] ( &asciistring_024A47 ) ; {149946}
    BRK #$5E              ; {149950}
    COP [0A] ( #29 )      ; {149952}
    COP [09] ( #$0000 )   ; {149955}
    RTL                   ; {149959}
}

code_0249C8 {
    COP [01] ( &asciistring_024AA8 ) ; {149960}
    COP [09] ( #$8000 )   ; {149964}
    RTL                   ; {149968}
}

code_0249D1 {
    COP [01] ( &asciistring_0249D8 ) ; {149969}
    COP [86]              ; {149973}
    RTL                   ; {149975}
}

asciistring_0249D8 |[10][0E:3C]I do not know who you [N]are, but thank you [N]very much for [N]releasing me- [FIN]I will give you a gift[N]if you come back- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024A21 |[10]I am the wife of King [N]Magridd- Do you think [N]I am pretty? [END]|

asciistring_024A47 |This is my present to [N]you- [FIN]The Queen put [N]something in [N][02:2] S pocket- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024A76 |[10]Do you like it? [N]You may go wherever [N]you want within the [N]Magridd Castle- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024AA8 |[10]--------- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024AB6 |[10][02:2] found [03:24]the [N]Invulnerable Bracelet [N][03:20]where the Queen was [N]standing- [JMP:&w5_shared_02706C.asciistring_0270DF]|