?BANK 03

?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_019475 {
    COP [14] ( #$001A, &code_01947C )
    RTL 
}

code_01947C {
    COP [30] ( #$001A, &code_019505, #03 )
    COP [AC] ( @code_0194BE, #$0000, #$0010, #$2000 )
    COP [14] ( #$0009, &code_0194B5 )
    COP [17] ( &code_0194FB )

  loc_019498:
    COP [80] ( #03 )
    COP [82]
    COP [87]
    COP [81] ( #05, #02 )
    COP [83]
    COP [80] ( #04 )
    COP [82]
    COP [87]
    COP [81] ( #05, #02 )
    COP [83]
    BRL loc_019498
}

code_0194B5 {
    COP [17] ( &code_019500 )
    COP [15]
    COP [91]
    RTL 
}

code_0194BE {
    COP [20] ( &code_0194C9 )
    COP [0D] ( #00, #30, #04, &code_0194CE )
}

code_0194C9 {
    COP [09] ( #$0006 )
    RTL 
}

code_0194CE {
    COP [19] ( #1D, &code_0194E1 )
    COP [01] ( &asciistring_01954B )
    COP [10] ( #$0103, #01, #$0078, #$03E0 )
    RTL 
}

code_0194E1 {
    COP [07] ( #$8006, &code_0194F5 )
    COP [09] ( #$8006 )
    COP [14] ( #$0009, &code_0194F6 )
    COP [01] ( &asciistring_01956E )
}

code_0194F5 {
    RTL 
}

code_0194F6 {
    COP [01] ( &asciistring_0195A8 )
    RTL 
}

code_0194FB {
    COP [01] ( &asciistring_01950C )
    RTL 
}

code_019500 {
    COP [01] ( &asciistring_0195CB )
    RTL 
}

code_019505 {
    COP [01] ( &asciistring_0195FE )
    COP [86]
    RTL 
}

asciistring_01950C |[10]This was painted by [N]Dr-Leo- A strange [N]face has appeared! [FIN]It s terrifying!! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01954B |[10][0F][02:2] is [N]dragged into the [N]painting! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01956E |[10][0F]There is a picture of [N]the village Chief in [N]the painting, he [N]appears to be sad- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0195A8 |[10][0F]The painting has [N]returned to normal- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0195CB |[10]The face of the [N]village Chief has [N]disappeared!! What was[N]that? [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0195FE |[10][0E:3C]You hear a man [N]screaming inside the [N]house- [FIN]AHHHH!! [N]A GHOST! A GHOST! [JMP:&w0_shared_01B988.asciistring_01B988]|