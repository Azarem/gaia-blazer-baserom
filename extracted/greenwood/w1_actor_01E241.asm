?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E241 {
    COP [15]
    COP [17] ( &code_01E24A )
    COP [91]
    RTL 
}

code_01E24A {
    COP [07] ( #$8402, &code_01E255 )
    COP [01] ( &asciistring_01E266 )
    RTL 
}

code_01E255 {
    COP [01] ( &asciistring_01E2EA )
    COP [3C] ( #04 )
    COP [10] ( #$0104, #02, #$0120, #$02D0 )
    RTL 
}

asciistring_01E266 |[10]Turbo refused to give [N]his life to the evil [N]one, Deathtoll- [FIN]He fought Deathtoll [N]trying to save [N]GreenWood and all [N]it s animals, [FIN]but he was defeated- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

asciistring_01E2EA |[10]Turbo, wait! [JMP:&w1_shared_01EBC2.asciistring_01EC46]|