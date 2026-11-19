?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w1_shared_01EBC2'

---------------------------------------------

code_01C8A4 {
    COP [14] ( #$0038, &code_01C8AB ) ; {116900}
    RTL                   ; {116906}
}

code_01C8AB {
    COP [85] ( @engine_0026F3.code_00299D ) ; {116907}
    COP [AC] ( @code_01C8F5, #$02A0, #$0160, #$2040 ) ; {116912}
    COP [17] ( &code_01C8C9 ) ; {116923}
    COP [15]              ; {116927}
    COP [91]              ; {116929}
    COP [80] ( #18 )      ; {116931}
    COP [82]              ; {116934}
    RTL                   ; {116936}
}

code_01C8C9 {
    COP [01] ( &asciistring_01C8CE ) ; {116937}
    RTL                   ; {116941}
}

asciistring_01C8CE |[10]Talk with the stump- [N]Please listen [N]carefully- [JMP:&w1_shared_01EBC2.asciistring_01EC46]|

code_01C8F5 {
    COP [17] ( &code_01C901 ) ; {116981}
    COP [91]              ; {116985}
    COP [80] ( #23 )      ; {116987}
    COP [82]              ; {116990}
    RTL                   ; {116992}
}

code_01C901 {
    COP [01] ( &asciistring_01C906 ) ; {116993}
    RTL                   ; {116997}
}

asciistring_01C906 |[10][0A]This█is█GreenWood-[N]This█land█was[N]developed█by█a█dog[N]named█Turbo-[FIN]He█created█this█town[N]so█animals█could█come[N]here█and█feel█safe-[JMP:&w1_shared_01EBC2.asciistring_01EC46]|