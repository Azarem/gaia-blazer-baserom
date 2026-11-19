?BANK 04

?INCLUDE 'lib_014F02'
?INCLUDE 'w5_shared_02706C'

!L_choice_result                0003D0

---------------------------------------------

code_02494A {
    COP [14] ( #$017F, &code_024951 )
    RTL 
}

code_024951 {
    COP [30] ( #$017F, &code_0249D1, #04 )
    COP [07] ( #$8805, &code_024978 )
    COP [17] ( &code_02499F )
    COP [15]

  loc_024964:
    COP [07] ( #$8000, &code_024971 )
    COP [80] ( #0C )
    COP [82]
    BRA loc_024964
}

code_024971 {
    COP [80] ( #0D )
    COP [82]
    BRA loc_024964
}

code_024978 {
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [18] ( #37, &code_024989 )
    COP [86]
    RTL 
}

code_024989 {
    COP [91]
    COP [0D] ( #00, #36, #17, &code_024993 )
    RTL 
}

code_024993 {
    COP [01] ( &asciistring_024AB6 )
    BRK #$5E
    COP [0A] ( #37 )
    COP [91]
    RTL 
}

code_02499F {
    COP [18] ( #29, &code_0249A9 )
    COP [01] ( &asciistring_024A76 )
    RTL 
}

code_0249A9 {
    COP [01] ( &asciistring_024A21 )
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_0249C8 )
    LDA $L_choice_result
    BNE code_0249C8
    COP [01] ( &asciistring_024A47 )
    BRK #$5E
    COP [0A] ( #29 )
    COP [09] ( #$0000 )
    RTL 
}

code_0249C8 {
    COP [01] ( &asciistring_024AA8 )
    COP [09] ( #$8000 )
    RTL 
}

code_0249D1 {
    COP [01] ( &asciistring_0249D8 )
    COP [86]
    RTL 
}

asciistring_0249D8 |[10][0E:3C]I do not know who you [N]are, but thank you [N]very much for [N]releasing me- [FIN]I will give you a gift[N]if you come back- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024A21 |[10]I am the wife of King [N]Magridd- Do you think [N]I am pretty? [END]|

asciistring_024A47 |This is my present to [N]you- [FIN]The Queen put [N]something in [N][02:2] S pocket- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024A76 |[10]Do you like it? [N]You may go wherever [N]you want within the [N]Magridd Castle- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024AA8 |[10]--------- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024AB6 |[10][02:2] found [03:24]the [N]Invulnerable Bracelet [N][03:20]where the Queen was [N]standing- [JMP:&w5_shared_02706C.asciistring_0270DF]|