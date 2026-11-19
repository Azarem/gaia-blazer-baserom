?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_0226C0 {
    COP [14] ( #$0129, &code_0226C7 )
    RTL 
}

code_0226C7 {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_0226F7 )
    COP [07] ( #$0605, &code_0226DC )
    COP [07] ( #$8606, &code_0226E4 )
}

code_0226DC {
    COP [15]
    COP [05] ( #$0002 )
    COP [16]
}

code_0226E4 {
    COP [96]
    COP [80] ( #0F )
    COP [82]
    COP [97]
    COP [80] ( #0C )
    COP [82]
    COP [15]
    COP [91]
    RTL 
}

code_0226F7 {
    COP [07] ( #$0605, &code_022703 )
    COP [07] ( #$8606, &code_022708 )
}

code_022703 {
    COP [01] ( &asciistring_022711 )
    RTL 
}

code_022708 {
    COP [01] ( &asciistring_022750 )
    COP [09] ( #$8002 )
    RTL 
}

asciistring_022711 |[10]Would you please take [N]the cats out of the [N]room? [FIN]I am too scared to [N]move around with them [N]in here- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_022750 |[10]Thank you very much- [N]Now I can walk around [N]the room freely- [FIN]Let me give you [N]something- [N]Please come inside- [JMP:&w4_shared_023F33.asciistring_023FA3]|