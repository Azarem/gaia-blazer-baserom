?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

---------------------------------------------

code_023214 {
    COP [14] ( #$0136, &code_02321B )
    RTL 
}

code_02321B {
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_02322E )
    COP [15]
    COP [91]
    COP [80] ( #18 )
    COP [82]
    RTL 
}

code_02322E {
    COP [01] ( &asciistring_023233 )
    RTL 
}

asciistring_023233 |[10]The large machines in [N]the basement were the [N]machines which [N]summoned evil- [FIN]They were made by [N]Dr-Leo- [FIN]When those machines [N]started to move, the [N]cities were destroyed-[JMP:&w4_shared_023F33.asciistring_023FA3]|