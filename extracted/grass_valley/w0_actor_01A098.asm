?BANK 03

?INCLUDE 'engine_0026F3'
?INCLUDE 'w0_shared_01B988'

!joy_block_mask                 0326

---------------------------------------------

code_01A098 {
    COP [14] ( #$0009, &code_01A09F ) ; {106648}
    RTL                   ; {106654}
}

code_01A09F {
    COP [30] ( #$0009, &code_01A139, #03 ) ; {106655}
    COP [11] ( #01, #04, #08 ) ; {106662}
    COP [85] ( @engine_0026F3.code_00299D ) ; {106667}
    COP [17] ( &code_01A11F ) ; {106672}
    COP [15]              ; {106676}
    COP [91]              ; {106678}
    COP [07] ( #$9B00, &code_01A0C5 ) ; {106680}
    COP [18] ( #3A, &code_01A0C5 ) ; {106686}
    BRA loc_01A0C6        ; {106691}
}

code_01A0C5 {
    RTL                   ; {106693}

  loc_01A0C6:
    LDA #$2F80            ; {106694}
    TSB $joy_block_mask   ; {106697}
    COP [17] ( #$0000 )   ; {106700}
    COP [31] ( #00 )      ; {106704}
    COP [85] ( @code_01A105 ) ; {106707}
    COP [03] ( #F1 )      ; {106712}
    COP [04]              ; {106715}
    COP [01] ( &asciistring_01A2C4 ) ; {106717}
    COP [09] ( #$9B00 )   ; {106721}
    LDA #$2F80            ; {106725}
    TSB $joy_block_mask   ; {106728}
    COP [85] ( @code_01A112 ) ; {106731}
    COP [32] ( #02 )      ; {106736}
    COP [03] ( #3D )      ; {106739}
    COP [04]              ; {106742}
    LDA #$2F80            ; {106744}
    TRB $joy_block_mask   ; {106747}
    COP [17] ( &code_01A11F ) ; {106750}
    COP [91]              ; {106754}
    RTL                   ; {106756}
}

code_01A105 {
    COP [A8] ( #$8000, #0D ) ; {106757}
    COP [92] ( #45 )      ; {106762}
    COP [94]              ; {106765}
    COP [86]              ; {106767}
    RTL                   ; {106769}
}

code_01A112 {
    COP [A8] ( #$8000, #0D ) ; {106770}
    COP [92] ( #46 )      ; {106775}
    COP [94]              ; {106778}
    COP [86]              ; {106780}
    RTL                   ; {106782}
}

code_01A11F {
    COP [07] ( #$9B00, &code_01A12A ) ; {106783}
    COP [18] ( #3A, &code_01A12F ) ; {106789}
}

code_01A12A {
    COP [01] ( &asciistring_01A272 ) ; {106794}
    RTL                   ; {106798}
}

code_01A12F {
    COP [01] ( &asciistring_01A191 ) ; {106799}
    BRK #$5E              ; {106803}
    COP [0A] ( #3A )      ; {106805}
    RTL                   ; {106808}
}

code_01A139 {
    COP [01] ( &asciistring_01A142 ) ; {106809}
    COP [37]              ; {106813}
    COP [86]              ; {106815}
    RTL                   ; {106817}
}

asciistring_01A142 |[10][0E:3C]Welcome to my room- [N]I finally feel like [N]myself again- [FIN]I have something to [N]tell you- [N]Please come back to [N]my house- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01A191 |[10]I feel as though I [N]have been surrounded [N]by darkness- [FIN]In that darkness I [N]heard my best friend [N]Leo- [FIN]He told me to give [N]this Brown Stone to a [N]person named [02:2]-[FIN]I don t know what the [N]Brown Stone looks like[N]but this is a stone [FIN]that I received from [N]him the day before he [N]disappeared- [FIN][02:2], received [N][03:24]the Brown Stone- [03:20][JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01A272 |[10]Dr-Leo has only a [N]daughter named Lisa- [FIN]I will ask my wife to [N]look after her until [N]Dr-Leo returns- [JMP:&w0_shared_01B988.asciistring_01B988]|

asciistring_01A2C4 |[10]Suddenly the Master s [N]voice came thundering [N]down from the heavens-[FIN]"The Brown Stone you [N]have is a key to open [N]the World of Evil- [FIN]This is where [N]Deathtoll lives! [FIN]Come back to me with [N]the stone-ˮ [JMP:&w0_shared_01B988.asciistring_01B988]|