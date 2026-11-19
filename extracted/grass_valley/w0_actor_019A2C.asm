?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_019A2C {
    COP [14] ( #$001D, &code_019A33 ) ; {105004}
    RTL                   ; {105010}
}

code_019A33 {
    COP [85] ( @engine_0026F3.code_00299D ) ; {105011}
    COP [07] ( #$0102, &code_019A46 ) ; {105016}
    COP [11] ( #15, #32, #2A ) ; {105022}
    BRL loc_019AD6        ; {105027}
}

code_019A46 {
    COP [17] ( &code_019AE4 ) ; {105030}
    COP [15]              ; {105034}
    COP [91]              ; {105036}
    RTL                   ; {105038}
}

code_019A4F {
    COP [16]              ; {105039}
    COP [17] ( &code_019B05 ) ; {105041}
    COP [81] ( #1B, #02 ) ; {105045}
    COP [83]              ; {105049}
    COP [9F] ( #$0008 )   ; {105051}
    COP [81] ( #1A, #03 ) ; {105055}
    COP [83]              ; {105059}
    COP [9F] ( #$FFF8 )   ; {105061}
    COP [81] ( #1B, #02 ) ; {105065}
    COP [83]              ; {105069}
    COP [9F] ( #$0008 )   ; {105071}
    COP [81] ( #1A, #02 ) ; {105075}
    COP [83]              ; {105079}
    COP [87]              ; {105081}
    COP [9F] ( #$FFF8 )   ; {105083}
    COP [80] ( #18 )      ; {105087}
    COP [82]              ; {105090}
    COP [17] ( &code_019AEC ) ; {105092}
    COP [15]              ; {105096}
    COP [91]              ; {105098}
    RTL                   ; {105100}
}

code_019A8D {
    COP [16]              ; {105101}
    COP [17] ( &code_019B05 ) ; {105103}
    COP [81] ( #1A, #04 ) ; {105107}
    COP [83]              ; {105111}
    COP [9F] ( #$FFF8 )   ; {105113}
    COP [81] ( #1B, #03 ) ; {105117}
    COP [83]              ; {105121}
    COP [9F] ( #$0008 )   ; {105123}
    COP [80] ( #1A )      ; {105127}
    COP [82]              ; {105130}
    COP [17] ( &code_019AF4 ) ; {105132}
    COP [15]              ; {105136}
    COP [91]              ; {105138}
    RTL                   ; {105140}
}

code_019AB5 {
    COP [16]              ; {105141}
    COP [17] ( &code_019B05 ) ; {105143}
    COP [87]              ; {105147}
    COP [9F] ( #$0008 )   ; {105149}
    COP [81] ( #1B, #04 ) ; {105153}
    COP [83]              ; {105157}
    COP [9F] ( #$0008 )   ; {105159}
    COP [81] ( #19, #0A ) ; {105163}
    COP [83]              ; {105167}
    COP [80] ( #18 )      ; {105169}
    COP [82]              ; {105172}

  loc_019AD6:
    COP [15]              ; {105174}
    COP [17] ( &code_019AFC ) ; {105176}
    COP [91]              ; {105180}
    COP [80] ( #24 )      ; {105182}
    COP [82]              ; {105185}
    RTL                   ; {105187}
}

code_019AE4 {
    COP [01] ( &asciistring_019B0A ) ; {105188}
    COP [27] ( &code_019A4F ) ; {105192}
}

code_019AEC {
    COP [01] ( &asciistring_019B52 ) ; {105196}
    COP [27] ( &code_019A8D ) ; {105200}
}

code_019AF4 {
    COP [01] ( &asciistring_019BF2 ) ; {105204}
    COP [27] ( &code_019AB5 ) ; {105208}
}

code_019AFC {
    COP [01] ( &asciistring_019C56 ) ; {105212}
    COP [09] ( #$8102 )   ; {105216}
    RTL                   ; {105220}
}

code_019B05 {
    COP [01] ( &asciistring_019CC1 ) ; {105221}
    RTL                   ; {105225}
}

asciistring_019B0A |[10]You are the one who [N]set me free, right? [FIN]Come, I shall show you[N]around- Please follow [N]me- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019B52 |[10]This is the home of [N]Dr-Leo the inventor [N]and his daughter, [N]Lisa- [FIN]Dr-Leo was a great [N]painter as well as an [N]inventor- [FIN]One day, many soldiers[N]came and took Dr-Leo [N]away- Lisa has not [N]been the same since- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019BF2 |[10]The house at the top [N]of this cliff contains[N]a painting by Dr-Leo-[FIN]I think the title of [N]the painting is [N]something like [N]"The World of Evil-ˮ [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019C56 |[10]This is a house people[N]constructed for the [N]goats- I am not [N]terribly fond of it- [FIN]I did see something on[N]the ground near the [N]corner of the fence- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019CC1 |[10]This is all I will [N]tell you- Please [N]follow me- [JMP:&w0_shared_01B988.asciistring_01B988]|