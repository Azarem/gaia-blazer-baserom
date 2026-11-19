?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

---------------------------------------------

code_0198A6 {
    COP [14] ( #$0025, &code_0198AD )
    RTL 
}

code_0198AD {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_01991A )
    COP [91]
    COP [07] ( #$0201, &code_0198C8 )
    COP [11] ( #14, #2C, #13 )
    COP [15]
    BRL loc_0198F7
}

code_0198C8 {
    COP [15]
    COP [05] ( #$0200 )
    COP [17] ( &code_019930 )
    COP [91]
    COP [0C] ( #00, #02, &code_0198DD )
    BRL loc_0198DE
}

code_0198DD {
    RTL 

  loc_0198DE:
    COP [16]
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    COP [87]
    COP [80] ( #0E )
    COP [82]
    COP [15]
    COP [09] ( #$8201 )

  loc_0198F7:
    COP [17] ( &code_019935 )
    COP [91]
    COP [0D] ( #00, #28, #0B, &code_019905 )
    RTL 
}

code_019905 {
    COP [07] ( #$0904, &code_01990C )
    RTL 
}

code_01990C {
    COP [01] ( &asciistring_0199DC )
    BRK #$5E
    COP [0A] ( #39 )
    COP [09] ( #$8904 )
    RTL 
}

code_01991A {
    COP [19] ( #1B, &code_01992B )
    COP [09] ( #$8200 )
    COP [01] ( &asciistring_01997B )
    COP [0B] ( #1B )
    RTL 
}

code_01992B {
    COP [01] ( &asciistring_01993A )
    RTL 
}

code_019930 {
    COP [01] ( &asciistring_0199AE )
    RTL 
}

code_019935 {
    COP [01] ( &asciistring_0199F1 )
    RTL 
}

asciistring_01993A |[10]This is our secret [N]passage- I cannot let [N]you through without [N]a pass- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01997B |[10]Oh, the pass! Where [N]did you find it? [N]You can go inside now-[JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0199AE |[10]Would you please move [N]over a little so I can[N]let you pass? [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0199DC |[10]There is [03:24]a strange [N]bottle- [03:20][JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_0199F1 |[10]I am tired of playing [N]hide and seek- I must [N]find something else to[N]do- [JMP:&w0_shared_01B988.asciistring_01B988]|