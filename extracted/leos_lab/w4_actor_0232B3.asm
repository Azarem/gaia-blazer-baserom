?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'lib_014F02'
?INCLUDE 'w4_shared_023F33'

!L_choice_result                0003D0

---------------------------------------------

code_0232B3 {
    COP [14] ( #$014C, &code_0232BA ) ; {144051}
    RTL                   ; {144057}
}

code_0232BA {
    COP [85] ( @engine_0026F3.code_00299D ) ; {144058}
    COP [17] ( &code_0232CD ) ; {144063}
    COP [15]              ; {144067}
    COP [91]              ; {144069}
    COP [80] ( #07 )      ; {144071}
    COP [82]              ; {144074}
    RTL                   ; {144076}
}

code_0232CD {
    COP [07] ( #$8807, &code_0232FF ) ; {144077}
    COP [18] ( #38, &code_0232FA ) ; {144083}
    COP [01] ( &asciistring_023317 ) ; {144088}
    COP [1A] ( &lib_014F02.asciistring_014F02, #02, &code_0232F5 ) ; {144092}
    LDA $L_choice_result  ; {144099}
    BNE code_0232F5       ; {144103}
    COP [01] ( &asciistring_0233D0 ) ; {144105}
    COP [0B] ( #38 )      ; {144109}
    COP [09] ( #$8807 )   ; {144112}
    RTL                   ; {144116}
}

code_0232F5 {
    COP [01] ( &asciistring_0233B1 ) ; {144117}
    RTL                   ; {144121}
}

code_0232FA {
    COP [01] ( &asciistring_023374 ) ; {144122}
    RTL                   ; {144126}
}

code_0232FF {
    COP [18] ( #38, &code_023309 ) ; {144127}
    COP [01] ( &asciistring_02342E ) ; {144132}
    RTL                   ; {144136}
}

code_023309 {
    COP [01] ( &asciistring_023403 ) ; {144137}
    BRK #$5E              ; {144141}
    COP [0A] ( #38 )      ; {144143}
    COP [09] ( #$0807 )   ; {144146}
    RTL                   ; {144150}
}

asciistring_023317 |[10]If there s nothing in[N]a chest then the chest[N]is good for nothing- [FIN]Would you store your [N]Medical Herbs in my [N]drawer? [END]|

asciistring_023374 |[10]If there s nothing [N]in a chest, [N]a chest doesn t mean [N]anything- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_0233B1 |I am the happiest [N]chest in the world- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_0233D0 |[02:2] put [N]his Medical Herbs [N]in the drawer- [FIN]I am satisfied- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023403 |[10]Are you taking them [N]out? Well, it s okay- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_02342E |[10]You have a Medical [N]Herb- I will give [N]them back to you when [N]you have run out- [JMP:&w4_shared_023F33.asciistring_023FA3]|