?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_023214 {
    COP [14] ( #$0136, &code_02321B ) ; {143892}
    RTL                   ; {143898}
}

code_02321B {
    COP [85] ( @engine_0026F3.code_00299D ) ; {143899}
    COP [17] ( &code_02322E ) ; {143904}
    COP [15]              ; {143908}
    COP [91]              ; {143910}
    COP [80] ( #18 )      ; {143912}
    COP [82]              ; {143915}
    RTL                   ; {143917}
}

code_02322E {
    COP [01] ( &asciistring_023233 ) ; {143918}
    RTL                   ; {143922}
}

asciistring_023233 |[10]The large machines in [N]the basement were the [N]machines which [N]summoned evil- [FIN]They were made by [N]Dr-Leo- [FIN]When those machines [N]started to move, the [N]cities were destroyed-[JMP:&w4_shared_023F33.asciistring_023FA3]|