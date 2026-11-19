?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E2FB {
    COP [14] ( #$0074, &code_01E302 )
    RTL 
}

code_01E302 {
    COP [81] ( #27, #0F )
    COP [83]
    COP [81] ( #28, #08 )
    COP [83]
    COP [15]
    COP [17] ( &code_01E337 )
    COP [91]
    RTL 
}

code_01E317 {
    COP [17] ( #$0000 )
    COP [1B] ( &code_01E321, #$003C )
}

code_01E321 {
    COP [81] ( #28, #08 )
    COP [83]
    COP [81] ( #27, #0F )
    COP [83]
    COP [80] ( #23 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_01E337 {
    COP [01] ( &asciistring_01E343 )
    COP [09] ( #$8402 )
    COP [27] ( &code_01E317 )
}

asciistring_01E343 |[10][02:2], go to [N]the Light Shrine and [N]release the Guardian [N]of the Woods- [FIN]You will find what you[N]are looking for- [FIN]There is a bird, Tiki,[N]that may tell you how [N]to use the raft- [FIN]You must protect [N]GreenWood now that [N]I am gone- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|