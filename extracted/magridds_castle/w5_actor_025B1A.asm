?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w5_shared_02706C'

---------------------------------------------

code_025B1A {
    COP [14] ( #$016E, &code_025B21 ) ; {154394}
    RTL                   ; {154400}
}

code_025B21 {
    COP [30] ( #$016E, &code_025B98, #04 ) ; {154401}
    COP [07] ( #$8805, &code_025B81 ) ; {154408}
    COP [85] ( @engine_0026F3.code_00299D ) ; {154414}
    COP [15]              ; {154419}
    COP [17] ( &code_025B93 ) ; {154421}
    COP [05] ( #$0000 )   ; {154425}
    COP [09] ( #$0000 )   ; {154429}
    COP [16]              ; {154433}
    COP [97]              ; {154435}
    COP [81] ( #17, #02 ) ; {154437}
    COP [83]              ; {154441}
    COP [01] ( &asciistring_025C7E ) ; {154443}
    COP [32] ( #00 )      ; {154447}
    COP [B2] ( @code_025B84, #$0080, #$0000, #$0200 ) ; {154450}
    BRK #$5B              ; {154461}
    COP [05] ( #$0001 )   ; {154463}
    BRK #$04              ; {154467}
    LDA $0016, X          ; {154469}
    ORA #$0010            ; {154472}
    STA $0016, X          ; {154475}
    COP [97]              ; {154478}
    COP [80] ( #27 )      ; {154480}
    COP [82]              ; {154483}
    COP [81] ( #28, #08 ) ; {154485}
    COP [83]              ; {154489}
    COP [81] ( #29, #08 ) ; {154491}
    COP [83]              ; {154495}
}

code_025B81 {
    COP [86]              ; {154497}
    RTL                   ; {154499}
}

code_025B84 {
    COP [97]              ; {154500}
    COP [81] ( #25, #10 ) ; {154502}
    COP [83]              ; {154506}
    COP [09] ( #$8001 )   ; {154508}
    COP [86]              ; {154512}
    RTL                   ; {154514}
}

code_025B93 {
    COP [01] ( &asciistring_025C65 ) ; {154515}
    RTL                   ; {154519}
}

code_025B98 {
    COP [14] ( #$0183, &code_025BA3 ) ; {154520}
    COP [01] ( &asciistring_025BB3 ) ; {154526}
    RTL                   ; {154530}
}

code_025BA3 {
    COP [14] ( #$0181, &code_025BAE ) ; {154531}
    COP [01] ( &asciistring_025BEB ) ; {154537}
    RTL                   ; {154541}
}

code_025BAE {
    COP [01] ( &asciistring_025C22 ) ; {154542}
    RTL                   ; {154546}
}

asciistring_025BB3 |[10][0E:3C]Please save Dr-Leo- [N]He must be in the [N]prison of the left [N]tower!! [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025BEB |[10][0E:3C]Please save my friend![N]He must be in the same[N]prison that Dr-Leo [N]is in- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025C22 |[10][0E:3C]Please come to the [N]airship dock as soon [N]as possible- [FIN]Dr-Leo is waiting for [N]you- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025C65 |[10]Are you [02:2]? [FIN]Please see to Dr-Leo- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025C7E |[10]Doctor, we can finally[N]start our ship- [JMP:&w5_shared_02706C.asciistring_0270DF]|