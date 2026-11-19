?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_025B1A {
    COP [14] ( #$016E, &code_025B21 )
    RTL 
}

code_025B21 {
    COP [30] ( #$016E, &code_025B98, #04 )
    COP [07] ( #$8805, &code_025B81 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [15]
    COP [17] ( &code_025B93 )
    COP [05] ( #$0000 )
    COP [09] ( #$0000 )
    COP [16]
    COP [97]
    COP [81] ( #17, #02 )
    COP [83]
    COP [01] ( &asciistring_025C7E )
    COP [32] ( #00 )
    COP [B2] ( @code_025B84, #$0080, #$0000, #$0200 )
    BRK #$5B
    COP [05] ( #$0001 )
    BRK #$04
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    COP [97]
    COP [80] ( #27 )
    COP [82]
    COP [81] ( #28, #08 )
    COP [83]
    COP [81] ( #29, #08 )
    COP [83]
}

code_025B81 {
    COP [86]
    RTL 
}

code_025B84 {
    COP [97]
    COP [81] ( #25, #10 )
    COP [83]
    COP [09] ( #$8001 )
    COP [86]
    RTL 
}

code_025B93 {
    COP [01] ( &asciistring_025C65 )
    RTL 
}

code_025B98 {
    COP [14] ( #$0183, &code_025BA3 )
    COP [01] ( &asciistring_025BB3 )
    RTL 
}

code_025BA3 {
    COP [14] ( #$0181, &code_025BAE )
    COP [01] ( &asciistring_025BEB )
    RTL 
}

code_025BAE {
    COP [01] ( &asciistring_025C22 )
    RTL 
}

asciistring_025BB3 |[10][0E:3C]Please save Dr-Leo- [N]He must be in the [N]prison of the left [N]tower!! [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025BEB |[10][0E:3C]Please save my friend![N]He must be in the same[N]prison that Dr-Leo [N]is in- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025C22 |[10][0E:3C]Please come to the [N]airship dock as soon [N]as possible- [FIN]Dr-Leo is waiting for [N]you- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025C65 |[10]Are you [02:2]? [FIN]Please see to Dr-Leo- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025C7E |[10]Doctor, we can finally[N]start our ship- [JMP:&w5_shared_02706C.asciistring_0270DF]|