?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

!joy_block_mask                 0326
!return_active                  03FB

---------------------------------------------

code_020CC6 {
    COP [14] ( #$00E9, &code_020CCD ) ; {134342}
    RTL                   ; {134348}
}

code_020CCD {
    COP [30] ( #$00E9, &code_020D65, #04 ) ; {134349}
    COP [85] ( @engine_0026F3.code_00299D ) ; {134356}
    COP [1B] ( &code_020CDF, #$0002 ) ; {134361}
}

code_020CDF {
    COP [07] ( #$0007, &code_020D14 ) ; {134367}
    LDA #$FFFF            ; {134373}
    STA $return_active    ; {134376}
    COP [80] ( #04 )      ; {134379}
    COP [82]              ; {134382}
    COP [03] ( #03 )      ; {134384}
    COP [97]              ; {134387}
    COP [81] ( #05, #02 ) ; {134389}
    COP [83]              ; {134393}
    COP [96]              ; {134395}
    COP [81] ( #05, #02 ) ; {134397}
    COP [83]              ; {134401}
    COP [04]              ; {134403}
    COP [97]              ; {134405}
    COP [80] ( #05 )      ; {134407}
    COP [82]              ; {134410}
    COP [80] ( #01 )      ; {134412}
    COP [82]              ; {134415}
    COP [91]              ; {134417}
    RTL                   ; {134419}
}

code_020D14 {
    COP [17] ( &code_020D51 ) ; {134420}
    COP [15]              ; {134424}
    COP [05] ( #$0003 )   ; {134426}
    LDA $0016, X          ; {134430}
    AND #$FFEF            ; {134433}
    STA $0016, X          ; {134436}
    COP [96]              ; {134439}
    COP [80] ( #02 )      ; {134441}
    COP [82]              ; {134444}
    LDA #$2F80            ; {134446}
    TSB $joy_block_mask   ; {134449}
    COP [03] ( #1F )      ; {134452}
    COP [04]              ; {134455}
    COP [01] ( &asciistring_020EB9 ) ; {134457}
    COP [16]              ; {134461}
    COP [80] ( #26 )      ; {134463}
    COP [82]              ; {134466}
    COP [09] ( #$0003 )   ; {134468}
    LDA #$2F80            ; {134472}
    TRB $joy_block_mask   ; {134475}
    COP [86]              ; {134478}
    RTL                   ; {134480}
}

code_020D51 {
    COP [18] ( #22, &code_020D5B ) ; {134481}
    COP [01] ( &asciistring_020E72 ) ; {134486}
    RTL                   ; {134490}
}

code_020D5B {
    COP [01] ( &asciistring_020DDC ) ; {134491}
    BRK #$5E              ; {134495}
    COP [0A] ( #22 )      ; {134497}
    RTL                   ; {134500}
}

code_020D65 {
    COP [09] ( #$8007 )   ; {134501}
    COP [01] ( &asciistring_020D73 ) ; {134505}
    STZ $return_active    ; {134509}
    COP [86]              ; {134512}
    RTL                   ; {134514}
}

asciistring_020D73 |[10][0E:28]Hooray! I am back! [N]I am back! [0E:B4][N]Thank you very much- [FIN]I will give you these [N]Mushroom Shoes if you [N]return to me- [FIN]You will be able to [N]walk on ice! [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020DDC |[10]I will give you my [N]Mushroom Shoes- [FIN]There is snail goo on [N]the bottom of these [N]shoes- [FIN]If you wear these you [N]will not slip on the [N]ice- [FIN]You will still slip on[N]the slopes though- [FIN][02:2], received [N][03:24]Mushroom Shoes- [03:20][JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020E72 |[10]How do you like my [N]Mushroom Shoes? [FIN]My people make [N]clothing and shoes [N]from mushrooms- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020EB9 |[10]This snail always [N]wants me to walk with [N]it- [FIN]Where shall we go [N]today? [JMP:&w3_shared_02249A.asciistring_02251E]|