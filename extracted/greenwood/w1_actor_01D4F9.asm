?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01D4F9 {
    COP [14] ( #$0050, &code_01D500 ) ; {120057}
    RTL                   ; {120063}
}

code_01D500 {
    COP [30] ( #$0050, &code_01D531, #03 ) ; {120064}
    COP [91]              ; {120071}
    COP [0D] ( #00, #17, #0D, &code_01D511 ) ; {120073}
    RTL                   ; {120080}
}

code_01D511 {
    COP [07] ( #$8507, &code_01D52E ) ; {120081}
    COP [1B] ( &code_01D51D, #$0002 ) ; {120087}
}

code_01D51D {
    COP [01] ( &asciistring_01D53A ) ; {120093}
    BRK #$5E              ; {120097}
    COP [0A] ( #3B )      ; {120099}
    COP [09] ( #$8507 )   ; {120102}
    COP [09] ( #$9B01 )   ; {120106}
}

code_01D52E {
    COP [91]              ; {120110}
    RTL                   ; {120112}
}

code_01D531 {
    COP [01] ( &asciistring_01D5CE ) ; {120113}
    COP [37]              ; {120117}
    COP [86]              ; {120119}
    RTL                   ; {120121}
}

asciistring_01D53A |[10]I am the [N]Guardian of the Woods-[FIN]I have been watching [N]the world for a long [N]time- [FIN][02:2], a dog named [N]Turbo has buried [N]something near my [N]roots- [FIN]You will need this [N]Green Stone someday, [N]so please take it- [FIN][02:2] received [N][03:24]the Green Stone- [03:20][JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01D5CE |[10][0E:3C]I am the Guardian of [N]the Woods- Thank you [N]for releasing me- [FIN]I will give you the [N]Green Stone upon your [N]return- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|