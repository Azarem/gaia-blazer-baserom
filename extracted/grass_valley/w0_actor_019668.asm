?BANK 03

?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_019668 {
    COP [14] ( #$0023, &code_01966F )
    RTL 
}

code_01966F {
    COP [15]
    COP [17] ( &code_0196FD )
    COP [91]
    COP [0D] ( #00, #38, #3A, &code_01967F )
    RTL 
}

code_01967F {
    COP [07] ( #$8206, &code_0196F6 )
    COP [01] ( &asciistring_01971A )
    COP [91]
    COP [14] ( #$0022, &code_019692 )
    RTL 
}

code_019692 {
    COP [0D] ( #00, #3C, #37, &code_01969A )
    RTL 
}

code_01969A {
    COP [17] ( #$0000 )
    COP [16]
    COP [80] ( #0F )
    COP [82]
    COP [9D] ( #0F )
    COP [9E] ( &code_0196AC )
}

code_0196AC {
    COP [80] ( #11 )
    COP [82]
    COP [9D] ( #11 )
    COP [9E] ( &code_0196B8 )
}

code_0196B8 {
    COP [81] ( #10, #02 )
    COP [83]
    COP [9D] ( #10 )
    COP [9E] ( &code_0196C5 )
}

code_0196C5 {
    COP [81] ( #11, #03 )
    COP [83]
    COP [9D] ( #10 )
    COP [9E] ( &code_0196D2 )
}

code_0196D2 {
    COP [97]
    COP [80] ( #0E )
    COP [82]
    COP [15]
    COP [17] ( &code_019706 )
    COP [91]
    COP [0C] ( #00, #02, &code_0196E8 )
    RTL 
}

code_0196E8 {
    COP [96]
    COP [80] ( #0C )
    COP [82]
    COP [01] ( &asciistring_01975F )
    COP [91]
    RTL 
}

code_0196F6 {
    COP [17] ( &code_01970B )
    COP [91]
    RTL 
}

code_0196FD {
    COP [01] ( &asciistring_019728 )
    COP [09] ( #$8005 )
    RTL 
}

code_019706 {
    COP [01] ( &asciistring_01975F )
    RTL 
}

code_01970B {
    COP [18] ( #1B, &code_019715 )
    COP [01] ( &asciistring_019793 )
    RTL 
}

code_019715 {
    COP [01] ( &asciistring_0197C3 )
    RTL 
}

asciistring_01971A |[10]Oh! You scared me! [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019728 |[10]This is our secret [N]hut- We have hidden [N]treasure near here- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01975F |[10]Were you following me?[N]I will not tell you [N]where our treasure is-[JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_019793 |[10]Oh! That s my pass! [N]Well, okay, I ll give [N]it to you- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0197C3 |[10]Was the pass helpful? [JMP:&w0_shared_01B988.asciistring_01B988]|