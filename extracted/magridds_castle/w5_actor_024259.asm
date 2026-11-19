?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

!joy_block_mask                 0326

---------------------------------------------

code_024259 {
    COP [14] ( #$0161, &code_024260 ) ; {148057}
    RTL                   ; {148063}
}

code_024260 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {148064}
    COP [07] ( #$8804, &code_0242AE ) ; {148069}
    COP [17] ( &code_0242BC ) ; {148075}
    COP [15]              ; {148079}
    COP [91]              ; {148081}
    COP [0D] ( #00, #02, #1F, &code_02427B ) ; {148083}
    RTL                   ; {148090}
}

code_02427B {
    COP [07] ( #$0803, &code_0242B9 ) ; {148091}
    COP [17] ( #$0000 )   ; {148097}
    LDA #$2F80            ; {148101}
    TSB $joy_block_mask   ; {148104}
    COP [03] ( #1F )      ; {148107}
    COP [04]              ; {148110}
    COP [80] ( #2C )      ; {148112}
    COP [82]              ; {148115}
    COP [2B] ( #$FFF0, #$0000 ) ; {148117}
    COP [01] ( &asciistring_024316 ) ; {148123}
    BRK #$5E              ; {148127}
    COP [0A] ( #0F )      ; {148129}
    COP [09] ( #$8804 )   ; {148132}
    LDA #$2F80            ; {148136}
    TRB $joy_block_mask   ; {148139}
}

code_0242AE {
    COP [80] ( #12 )      ; {148142}
    COP [82]              ; {148145}
    COP [17] ( &code_0242DD ) ; {148147}
    COP [15]              ; {148151}
}

code_0242B9 {
    COP [91]              ; {148153}
    RTL                   ; {148155}
}

code_0242BC {
    COP [07] ( #$8804, &code_0242DD ) ; {148156}
    COP [19] ( #1C, &code_0242D8 ) ; {148162}
    COP [01] ( &asciistring_0242EB ) ; {148167}
    COP [3C] ( #04 )      ; {148171}
    COP [10] ( #$0313, #01, #$0150, #$01A0 ) ; {148174}
    RTL                   ; {148183}
}

code_0242D8 {
    COP [01] ( &asciistring_0242E2 ) ; {148184}
    RTL                   ; {148188}
}

code_0242DD {
    COP [01] ( &asciistring_0243E7 ) ; {148189}
    RTL                   ; {148193}
}

asciistring_0242E2 |[10]Zzzz [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0242EB |[10][02:2] placed the [N]Dream Rod upon the [N]soldier s head- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_024316 |[10]Oops! I was sleeping- [FIN]Lately I have been [N]having the same dream [N]as Dr-Leo- [FIN]If I would have [N]released Dr-Leo, [N]the world would not be[N]like this- [FIN]I don t know who to [N]obey anymore! [FIN]There are many thorns [N]in the basement of [N]Magridd Castle- [FIN]You must take this [N]armor with you- [FIN][02:2] received [N][03:24]the Elemental Mail- [03:20][JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0243E7 |[10]I have a feeling that [N]you will change the [N]world- [N]Good luck! [JMP:&w5_shared_02706C.asciistring_0270DF]|