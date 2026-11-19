?BANK 03

?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_019668 {
    COP [14] ( #$0023, &code_01966F ) ; {104040}
    RTL                   ; {104046}
}

code_01966F {
    COP [15]              ; {104047}
    COP [17] ( &code_0196FD ) ; {104049}
    COP [91]              ; {104053}
    COP [0D] ( #00, #38, #3A, &code_01967F ) ; {104055}
    RTL                   ; {104062}
}

code_01967F {
    COP [07] ( #$8206, &code_0196F6 ) ; {104063}
    COP [01] ( &asciistring_01971A ) ; {104069}
    COP [91]              ; {104073}
    COP [14] ( #$0022, &code_019692 ) ; {104075}
    RTL                   ; {104081}
}

code_019692 {
    COP [0D] ( #00, #3C, #37, &code_01969A ) ; {104082}
    RTL                   ; {104089}
}

code_01969A {
    COP [17] ( #$0000 )   ; {104090}
    COP [16]              ; {104094}
    COP [80] ( #0F )      ; {104096}
    COP [82]              ; {104099}
    COP [9D] ( #0F )      ; {104101}
    COP [9E] ( &code_0196AC ) ; {104104}
}

code_0196AC {
    COP [80] ( #11 )      ; {104108}
    COP [82]              ; {104111}
    COP [9D] ( #11 )      ; {104113}
    COP [9E] ( &code_0196B8 ) ; {104116}
}

code_0196B8 {
    COP [81] ( #10, #02 ) ; {104120}
    COP [83]              ; {104124}
    COP [9D] ( #10 )      ; {104126}
    COP [9E] ( &code_0196C5 ) ; {104129}
}

code_0196C5 {
    COP [81] ( #11, #03 ) ; {104133}
    COP [83]              ; {104137}
    COP [9D] ( #10 )      ; {104139}
    COP [9E] ( &code_0196D2 ) ; {104142}
}

code_0196D2 {
    COP [97]              ; {104146}
    COP [80] ( #0E )      ; {104148}
    COP [82]              ; {104151}
    COP [15]              ; {104153}
    COP [17] ( &code_019706 ) ; {104155}
    COP [91]              ; {104159}
    COP [0C] ( #00, #02, &code_0196E8 ) ; {104161}
    RTL                   ; {104167}
}

code_0196E8 {
    COP [96]              ; {104168}
    COP [80] ( #0C )      ; {104170}
    COP [82]              ; {104173}
    COP [01] ( &asciistring_01975F ) ; {104175}
    COP [91]              ; {104179}
    RTL                   ; {104181}
}

code_0196F6 {
    COP [17] ( &code_01970B ) ; {104182}
    COP [91]              ; {104186}
    RTL                   ; {104188}
}

code_0196FD {
    COP [01] ( &asciistring_019728 ) ; {104189}
    COP [09] ( #$8005 )   ; {104193}
    RTL                   ; {104197}
}

code_019706 {
    COP [01] ( &asciistring_01975F ) ; {104198}
    RTL                   ; {104202}
}

code_01970B {
    COP [18] ( #1B, &code_019715 ) ; {104203}
    COP [01] ( &asciistring_019793 ) ; {104208}
    RTL                   ; {104212}
}

code_019715 {
    COP [01] ( &asciistring_0197C3 ) ; {104213}
    RTL                   ; {104217}
}

asciistring_01971A |[10]Oh! You scared me! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019728 |[10]This is our secret [N]hut- We have hidden [N]treasure near here- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01975F |[10]Were you following me?[N]I will not tell you [N]where our treasure is-[JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019793 |[10]Oh! That s my pass! [N]Well, okay, I ll give [N]it to you- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0197C3 |[10]Was the pass helpful? [JMP:&w0_shared_01B988.asciistring_01B988]|