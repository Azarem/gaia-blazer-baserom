?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E47B {
    COP [91]              ; {124027}
    COP [0D] ( #00, #0F, #15, &code_01E485 ) ; {124029}
    RTL                   ; {124036}
}

code_01E485 {
    COP [07] ( #$0906, &code_01E48E ) ; {124037}
    COP [86]              ; {124043}
    RTL                   ; {124045}
}

code_01E48E {
    COP [01] ( &asciistring_01E49E ) ; {124046}
    BRK #$5E              ; {124050}
    COP [0A] ( #39 )      ; {124052}
    COP [09] ( #$8906 )   ; {124055}
    COP [86]              ; {124059}
    RTL                   ; {124061}
}

asciistring_01E49E |[10][02:2] found [N][03:24]a Strange Bottle[03:20]-[JMP:&w1_shared_01EBC2.asciistring_01EC46]|