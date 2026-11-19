?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01C8A4 {
    COP [14] ( #$0038, &code_01C8AB )
    RTL 
}

code_01C8AB {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [AC] ( @code_01C8F5, #$02A0, #$0160, #$2040 )
    COP [17] ( &code_01C8C9 )
    COP [15]
    COP [91]
    COP [80] ( #18 )
    COP [82]
    RTL 
}

code_01C8C9 {
    COP [01] ( &asciistring_01C8CE )
    RTL 
}

asciistring_01C8CE |[10]Talk with the stump- [N]Please listen [N]carefully- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

code_01C8F5 {
    COP [17] ( &code_01C901 )
    COP [91]
    COP [80] ( #23 )
    COP [82]
    RTL 
}

code_01C901 {
    COP [01] ( &asciistring_01C906 )
    RTL 
}

asciistring_01C906 |[10][0A]This█is█GreenWood-[N]This█land█was[N]developed█by█a█dog[N]named█Turbo-[FIN]He█created█this█town[N]so█animals█could█come[N]here█and█feel█safe-[JMP:&w1_shared_01EBC2.asciistring_01EC46]|