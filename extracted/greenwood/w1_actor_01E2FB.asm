?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E2FB {
    COP [14] ( #$0074, &code_01E302 ) ; {123643}
    RTL                   ; {123649}
}

code_01E302 {
    COP [81] ( #27, #0F ) ; {123650}
    COP [83]              ; {123654}
    COP [81] ( #28, #08 ) ; {123656}
    COP [83]              ; {123660}
    COP [15]              ; {123662}
    COP [17] ( &code_01E337 ) ; {123664}
    COP [91]              ; {123668}
    RTL                   ; {123670}
}

code_01E317 {
    COP [17] ( #$0000 )   ; {123671}
    COP [1B] ( &code_01E321, #$003C ) ; {123675}
}

code_01E321 {
    COP [81] ( #28, #08 ) ; {123681}
    COP [83]              ; {123685}
    COP [81] ( #27, #0F ) ; {123687}
    COP [83]              ; {123691}
    COP [80] ( #23 )      ; {123693}
    COP [82]              ; {123696}
    COP [16]              ; {123698}
    COP [91]              ; {123700}
    RTL                   ; {123702}
}

code_01E337 {
    COP [01] ( &asciistring_01E343 ) ; {123703}
    COP [09] ( #$8402 )   ; {123707}
    COP [27] ( &code_01E317 ) ; {123711}
}

asciistring_01E343 |[10][02:2], go to [N]the Light Shrine and [N]release the Guardian [N]of the Woods- [FIN]You will find what you[N]are looking for- [FIN]There is a bird, Tiki,[N]that may tell you how [N]to use the raft- [FIN]You must protect [N]GreenWood now that [N]I am gone- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|