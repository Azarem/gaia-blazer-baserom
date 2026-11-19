?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_025302 {
    COP [14] ( #$018C, &code_025309 ) ; {152322}
    RTL                   ; {152328}
}

code_025309 {
    COP [14] ( #$0195, &code_02531C ) ; {152329}
    COP [85] ( @engine_0026F3.code_00299D ) ; {152335}
    COP [17] ( &code_02534D ) ; {152340}
    COP [15]              ; {152344}
    BRA loc_02532D        ; {152346}
}

code_02531C {
    COP [17] ( &code_025352 ) ; {152348}
    COP [9F] ( #$FFF0 )   ; {152352}
    COP [15]              ; {152356}
    COP [96]              ; {152358}
    COP [80] ( #14 )      ; {152360}
    COP [82]              ; {152363}

  loc_02532D:
    COP [91]              ; {152365}
    COP [0D] ( #00, #25, #0C, &code_025337 ) ; {152367}
    RTL                   ; {152374}
}

code_025337 {
    COP [07] ( #$9A07, &code_02534A ) ; {152375}
    COP [01] ( &asciistring_0253C3 ) ; {152381}
    BRK #$5E              ; {152385}
    COP [0A] ( #31 )      ; {152387}
    COP [09] ( #$9A07 )   ; {152390}
}

code_02534A {
    COP [91]              ; {152394}
    RTL                   ; {152396}
}

code_02534D {
    COP [01] ( &asciistring_025357 ) ; {152397}
    RTL                   ; {152401}
}

code_025352 {
    COP [01] ( &asciistring_025397 ) ; {152402}
    RTL                   ; {152406}
}

asciistring_025357 |[10]If King Magridd [N]doesn t come back, [N]then I will be crowned[N]the next King- [FIN]He, he, he- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025397 |[10]King Magridd is back- [N]Please do not tell [N]anybody what I have [N]said to you- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0253C3 |[10][02:2] found [N][03:24]the Master s Emblem H-[03:20][JMP:&w5_shared_02706C.asciistring_0270DF]|