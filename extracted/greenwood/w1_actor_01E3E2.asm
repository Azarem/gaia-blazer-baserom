?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E3E2 {
    COP [A1] ( #$007C, #$FFFA ) ; {123874}
    COP [80] ( #1F )      ; {123880}
    COP [82]              ; {123883}
    COP [80] ( #20 )      ; {123885}
    COP [82]              ; {123888}
    COP [80] ( #1D )      ; {123890}
    COP [82]              ; {123893}
    COP [1B] ( &code_01E3FD, #$0028 ) ; {123895}
}

code_01E3FD {
    COP [87]              ; {123901}
    COP [80] ( #1D )      ; {123903}
    COP [82]              ; {123906}
    COP [15]              ; {123908}
    COP [17] ( &code_01E412 ) ; {123910}
    COP [91]              ; {123914}
    COP [80] ( #1A )      ; {123916}
    COP [82]              ; {123919}
    RTL                   ; {123921}
}

code_01E412 {
    COP [01] ( &asciistring_01E426 ) ; {123922}
    STZ $0419             ; {123926}
    COP [3C] ( #04 )      ; {123929}
    COP [10] ( #$0104, #00, #$0070, #$02A0 ) ; {123932}
    RTL                   ; {123941}
}

asciistring_01E426 |[10]Even though I am only [N]a stump in real life, [N]I often dream [FIN]that I am a bird and [N]can fly wherever I [N]wish- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|