?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_0198A6 {
    COP [14] ( #$0025, &code_0198AD ) ; {104614}
    RTL                   ; {104620}
}

code_0198AD {
    COP [85] ( @engine_0026F3.code_00299D ) ; {104621}
    COP [17] ( &code_01991A ) ; {104626}
    COP [91]              ; {104630}
    COP [07] ( #$0201, &code_0198C8 ) ; {104632}
    COP [11] ( #14, #2C, #13 ) ; {104638}
    COP [15]              ; {104643}
    BRL loc_0198F7        ; {104645}
}

code_0198C8 {
    COP [15]              ; {104648}
    COP [05] ( #$0200 )   ; {104650}
    COP [17] ( &code_019930 ) ; {104654}
    COP [91]              ; {104658}
    COP [0C] ( #00, #02, &code_0198DD ) ; {104660}
    BRL loc_0198DE        ; {104666}
}

code_0198DD {
    RTL                   ; {104669}

  loc_0198DE:
    COP [16]              ; {104670}
    COP [80] ( #0F )      ; {104672}
    COP [82]              ; {104675}
    COP [80] ( #11 )      ; {104677}
    COP [82]              ; {104680}
    COP [87]              ; {104682}
    COP [80] ( #0E )      ; {104684}
    COP [82]              ; {104687}
    COP [15]              ; {104689}
    COP [09] ( #$8201 )   ; {104691}

  loc_0198F7:
    COP [17] ( &code_019935 ) ; {104695}
    COP [91]              ; {104699}
    COP [0D] ( #00, #28, #0B, &code_019905 ) ; {104701}
    RTL                   ; {104708}
}

code_019905 {
    COP [07] ( #$0904, &code_01990C ) ; {104709}
    RTL                   ; {104715}
}

code_01990C {
    COP [01] ( &asciistring_0199DC ) ; {104716}
    BRK #$5E              ; {104720}
    COP [0A] ( #39 )      ; {104722}
    COP [09] ( #$8904 )   ; {104725}
    RTL                   ; {104729}
}

code_01991A {
    COP [19] ( #1B, &code_01992B ) ; {104730}
    COP [09] ( #$8200 )   ; {104735}
    COP [01] ( &asciistring_01997B ) ; {104739}
    COP [0B] ( #1B )      ; {104743}
    RTL                   ; {104746}
}

code_01992B {
    COP [01] ( &asciistring_01993A ) ; {104747}
    RTL                   ; {104751}
}

code_019930 {
    COP [01] ( &asciistring_0199AE ) ; {104752}
    RTL                   ; {104756}
}

code_019935 {
    COP [01] ( &asciistring_0199F1 ) ; {104757}
    RTL                   ; {104761}
}

asciistring_01993A |[10]This is our secret [N]passage- I cannot let [N]you through without [N]a pass- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01997B |[10]Oh, the pass! Where [N]did you find it? [N]You can go inside now-[JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0199AE |[10]Would you please move [N]over a little so I can[N]let you pass? [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0199DC |[10]There is [03:24]a strange [N]bottle- [03:20][JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0199F1 |[10]I am tired of playing [N]hide and seek- I must [N]find something else to[N]do- [JMP:&w0_shared_01B988.asciistring_01B988]|