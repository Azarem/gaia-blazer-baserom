?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E47B {
    COP [91]
    COP [0D] ( #00, #0F, #15, &code_01E485 )
    RTL 
}

code_01E485 {
    COP [07] ( #$0906, &code_01E48E )
    COP [86]
    RTL 
}

code_01E48E {
    COP [01] ( &asciistring_01E49E )
    BRK #$5E
    COP [0A] ( #39 )
    COP [09] ( #$8906 )
    COP [86]
    RTL 
}

asciistring_01E49E |[10][02:2] found [N][03:24]a Strange Bottle[03:20]-[JMP:&w1_shared_01EBC2.asciistring_01EC46]|