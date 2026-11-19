?BANK 03

?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01E3E2 {
    COP [A1] ( #$007C, #$FFFA )
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    COP [1B] ( &code_01E3FD, #$0028 )
}

code_01E3FD {
    COP [87]
    COP [80] ( #1D )
    COP [82]
    COP [15]
    COP [17] ( &code_01E412 )
    COP [91]
    COP [80] ( #1A )
    COP [82]
    RTL 
}

code_01E412 {
    COP [01] ( &asciistring_01E426 )
    STZ $0419
    COP [3C] ( #04 )
    COP [10] ( #$0104, #00, #$0070, #$02A0 )
    RTL 
}

asciistring_01E426 |[10]Even though I am only [N]a stump in real life, [N]I often dream [FIN]that I am a bird and [N]can fly wherever I [N]wish- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|