?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w4_shared_023F33'

!joy_block_mask                 0326

---------------------------------------------

code_022F68 {
    COP [14] ( #$0126, &code_022F6F )
    RTL 
}

code_022F6F {
    COP [30] ( #$0126, &code_022FF3, #04 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_022FCD )
    COP [15]
    COP [07] ( #$8802, &code_022FC5 )
    COP [91]
    COP [0D] ( #00, #09, #0A, &code_022F91 )
    RTL 
}

code_022F91 {
    COP [07] ( #$0801, &code_022FC2 )
    COP [17] ( #$0000 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [80] ( #13 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_02306C )
    BRK #$5E
    COP [0A] ( #27 )
    COP [09] ( #$8802 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [17] ( &code_022FCD )
}

code_022FC2 {
    COP [91]
    RTL 
}

code_022FC5 {
    COP [91]
    COP [80] ( #13 )
    COP [82]
    RTL 
}

code_022FCD {
    COP [07] ( #$8802, &code_022FEE )
    COP [19] ( #1C, &code_022FE9 )
    COP [01] ( &asciistring_023049 )
    COP [3C] ( #04 )
    COP [10] ( #$050D, #01, #$00C0, #$0010 )
    RTL 
}

code_022FE9 {
    COP [01] ( &asciistring_02303F )
    RTL 
}

code_022FEE {
    COP [01] ( &asciistring_0230FA )
    RTL 
}

code_022FF3 {
    COP [01] ( &asciistring_022FFA )
    COP [86]
    RTL 
}

asciistring_022FFA |[10][0E:3C]The cat is sleeping- [N]He looks as though he [N]is suffering- [FIN]Uh, uh, Dr-Leo? [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_02303F |[10]Zzzzz [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_023049 |[10][02:2] places [N]the Dream Rod on the [N]cat s head- [JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_02306C |[10]Lately, I always see [N]Dr-Leo in my dreams- [FIN]I was scared when he [N]was taken away- [N]I had been hiding [N]under the table- [FIN]Oh yes, I will give [N]you this- [N]Dr-Leo left this- [FIN][02:2] received [N][03:24]a door key- [03:20][JMP:&w4_shared_023F33.asciistring_023FA3]|

asciistring_0230FA |[10]There are invisible [N]enemies in the models [N]town- [N]Please be careful- [JMP:&w4_shared_023F33.asciistring_023FA3]|