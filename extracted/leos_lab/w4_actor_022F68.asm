?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

!joy_block_mask                 0326

---------------------------------------------

code_022F68 {
    COP [14] ( #$0126, &code_022F6F ) ; {143208}
    RTL                   ; {143214}
}

code_022F6F {
    COP [30] ( #$0126, &code_022FF3, #04 ) ; {143215}
    COP [85] ( @engine_0026F3.code_00299D ) ; {143222}
    COP [17] ( &code_022FCD ) ; {143227}
    COP [15]              ; {143231}
    COP [07] ( #$8802, &code_022FC5 ) ; {143233}
    COP [91]              ; {143239}
    COP [0D] ( #00, #09, #0A, &code_022F91 ) ; {143241}
    RTL                   ; {143248}
}

code_022F91 {
    COP [07] ( #$0801, &code_022FC2 ) ; {143249}
    COP [17] ( #$0000 )   ; {143255}
    LDA #$2F80            ; {143259}
    TSB $joy_block_mask   ; {143262}
    COP [80] ( #13 )      ; {143265}
    COP [82]              ; {143268}
    COP [03] ( #1F )      ; {143270}
    COP [04]              ; {143273}
    COP [01] ( &asciistring_02306C ) ; {143275}
    BRK #$5E              ; {143279}
    COP [0A] ( #27 )      ; {143281}
    COP [09] ( #$8802 )   ; {143284}
    LDA #$2F80            ; {143288}
    TRB $joy_block_mask   ; {143291}
    COP [17] ( &code_022FCD ) ; {143294}
}

code_022FC2 {
    COP [91]              ; {143298}
    RTL                   ; {143300}
}

code_022FC5 {
    COP [91]              ; {143301}
    COP [80] ( #13 )      ; {143303}
    COP [82]              ; {143306}
    RTL                   ; {143308}
}

code_022FCD {
    COP [07] ( #$8802, &code_022FEE ) ; {143309}
    COP [19] ( #1C, &code_022FE9 ) ; {143315}
    COP [01] ( &asciistring_023049 ) ; {143320}
    COP [3C] ( #04 )      ; {143324}
    COP [10] ( #$050D, #01, #$00C0, #$0010 ) ; {143327}
    RTL                   ; {143336}
}

code_022FE9 {
    COP [01] ( &asciistring_02303F ) ; {143337}
    RTL                   ; {143341}
}

code_022FEE {
    COP [01] ( &asciistring_0230FA ) ; {143342}
    RTL                   ; {143346}
}

code_022FF3 {
    COP [01] ( &asciistring_022FFA ) ; {143347}
    COP [86]              ; {143351}
    RTL                   ; {143353}
}

asciistring_022FFA |[10][0E:3C]The cat is sleeping- [N]He looks as though he [N]is suffering- [FIN]Uh, uh, Dr-Leo? [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_02303F |[10]Zzzzz [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023049 |[10][02:2] places [N]the Dream Rod on the [N]cat s head- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_02306C |[10]Lately, I always see [N]Dr-Leo in my dreams- [FIN]I was scared when he [N]was taken away- [N]I had been hiding [N]under the table- [FIN]Oh yes, I will give [N]you this- [N]Dr-Leo left this- [FIN][02:2] received [N][03:24]a door key- [03:20][JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_0230FA |[10]There are invisible [N]enemies in the models [N]town- [N]Please be careful- [JMP:&w4_shared_023F33.asciistring_023FA3]|