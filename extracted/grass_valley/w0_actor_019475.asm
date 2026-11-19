?BANK 03

?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_019475 {
    COP [14] ( #$001A, &code_01947C ) ; {103541}
    RTL                   ; {103547}
}

code_01947C {
    COP [30] ( #$001A, &code_019505, #03 ) ; {103548}
    COP [AC] ( @code_0194BE, #$0000, #$0010, #$2000 ) ; {103555}
    COP [14] ( #$0009, &code_0194B5 ) ; {103566}
    COP [17] ( &code_0194FB ) ; {103572}

  loc_019498:
    COP [80] ( #03 )      ; {103576}
    COP [82]              ; {103579}
    COP [87]              ; {103581}
    COP [81] ( #05, #02 ) ; {103583}
    COP [83]              ; {103587}
    COP [80] ( #04 )      ; {103589}
    COP [82]              ; {103592}
    COP [87]              ; {103594}
    COP [81] ( #05, #02 ) ; {103596}
    COP [83]              ; {103600}
    BRL loc_019498        ; {103602}
}

code_0194B5 {
    COP [17] ( &code_019500 ) ; {103605}
    COP [15]              ; {103609}
    COP [91]              ; {103611}
    RTL                   ; {103613}
}

code_0194BE {
    COP [20] ( &code_0194C9 ) ; {103614}
    COP [0D] ( #00, #30, #04, &code_0194CE ) ; {103618}
}

code_0194C9 {
    COP [09] ( #$0006 )   ; {103625}
    RTL                   ; {103629}
}

code_0194CE {
    COP [19] ( #1D, &code_0194E1 ) ; {103630}
    COP [01] ( &asciistring_01954B ) ; {103635}
    COP [10] ( #$0103, #01, #$0078, #$03E0 ) ; {103639}
    RTL                   ; {103648}
}

code_0194E1 {
    COP [07] ( #$8006, &code_0194F5 ) ; {103649}
    COP [09] ( #$8006 )   ; {103655}
    COP [14] ( #$0009, &code_0194F6 ) ; {103659}
    COP [01] ( &asciistring_01956E ) ; {103665}
}

code_0194F5 {
    RTL                   ; {103669}
}

code_0194F6 {
    COP [01] ( &asciistring_0195A8 ) ; {103670}
    RTL                   ; {103674}
}

code_0194FB {
    COP [01] ( &asciistring_01950C ) ; {103675}
    RTL                   ; {103679}
}

code_019500 {
    COP [01] ( &asciistring_0195CB ) ; {103680}
    RTL                   ; {103684}
}

code_019505 {
    COP [01] ( &asciistring_0195FE ) ; {103685}
    COP [86]              ; {103689}
    RTL                   ; {103691}
}

asciistring_01950C |[10]This was painted by [N]Dr-Leo- A strange [N]face has appeared! [FIN]It s terrifying!! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01954B |[10][0F][02:2] is [N]dragged into the [N]painting! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01956E |[10][0F]There is a picture of [N]the village Chief in [N]the painting, he [N]appears to be sad- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0195A8 |[10][0F]The painting has [N]returned to normal- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0195CB |[10]The face of the [N]village Chief has [N]disappeared!! What was[N]that? [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0195FE |[10][0E:3C]You hear a man [N]screaming inside the [N]house- [FIN]AHHHH!! [N]A GHOST! A GHOST! [JMP:&w0_shared_01B988.asciistring_01B988]|