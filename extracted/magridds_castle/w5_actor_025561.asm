?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'engine_003005'
?INCLUDE 'w3_shared_022289'
?INCLUDE 'w5_shared_02706C'

!joy_block_mask                 0326

---------------------------------------------

code_025561 {
    COP [3B] ( #$0195, &code_025577 ) ; {152929}
    COP [17] ( &w3_shared_022289.code_02229E ) ; {152935}
    SEP #$20              ; {152939}
    LDA #$^engine_003005.code_00305F ; {152941}
    PHA                   ; {152943}
    REP #$20              ; {152944}
    LDA #$&engine_003005.code_00305F-1 ; {152946}
    PHA                   ; {152949}
    RTL                   ; {152950}
}

code_025577 {
    COP [30] ( #$0195, &code_0255E4, #04 ) ; {152951}
    COP [07] ( #$9F02, &code_02559B ) ; {152958}
    COP [85] ( @engine_0026F3.code_00299D ) ; {152964}
    COP [17] ( &code_0255C7 ) ; {152969}
    COP [15]              ; {152973}
    COP [05] ( #$0007 )   ; {152975}
    COP [80] ( #02 )      ; {152979}
    COP [82]              ; {152982}
    COP [91]              ; {152984}
    RTL                   ; {152986}
}

code_02559B {
    LDA #$BFC0            ; {152987}
    TSB $joy_block_mask   ; {152990}
    COP [03] ( #29 )      ; {152993}
    COP [04]              ; {152996}
    COP [01] ( &asciistring_02580C ) ; {152998}
    COP [03] ( #5B )      ; {153002}
    COP [04]              ; {153005}
    LDA #$0020            ; {153007}
    STA $03B4             ; {153010}
    COP [10] ( #$030D, #01, #$00A0, #$0050 ) ; {153013}
    LDA #$BFC0            ; {153022}
    TRB $joy_block_mask   ; {153025}
    COP [91]              ; {153028}
    RTL                   ; {153030}
}

code_0255C7 {
    COP [09] ( #$8007 )   ; {153031}
    COP [07] ( #$9B05, &code_0255DF ) ; {153035}
    COP [01] ( &asciistring_025639 ) ; {153041}
    BRK #$5E              ; {153045}
    COP [0A] ( #3F )      ; {153047}
    COP [09] ( #$9B05 )   ; {153050}
    RTL                   ; {153054}
}

code_0255DF {
    COP [01] ( &asciistring_0257CA ) ; {153055}
    RTL                   ; {153059}
}

code_0255E4 {
    COP [01] ( &asciistring_0255ED ) ; {153060}
    COP [37]              ; {153064}
    COP [86]              ; {153066}
    RTL                   ; {153068}
}

asciistring_0255ED |[10][0E:3C]I knew what was [N]happening- [FIN]I could do nothing to [N]prevent the Queen from[N]passing away- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_025639 |[10]I have failed as [N]a King- [FIN]I ordered people to be[N]loyal to me- [FIN]And killed whomever [N]would not follow me- [FIN]Once you reach the top[N]the only way is down- [FIN]I was just a coward- [N]I made a promise with [N]the evil King [N]Deathtoll- [FIN]Simply because I [N]thought it would [N]impress the Queen- [FIN]But the Queen was [N]captured by her own [N]desire and passed [N]away- [FIN]I must apologize to [N]Dr-Leo- [FIN]I have [03:24]the Black Stone[N][03:20]with me- You must have[N]all 6 of these now- [FIN]Please go to the world[N]of evil and defeat [N]Deathtoll- [FIN]This is all I can do [N]for Dr-Leo- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_0257CA |[10]I finally realized [N]what was happening [N]when the situation was[N]at its worst- [JMP:&w5_shared_02706C.asciistring_0270DF]|

asciistring_02580C |[10][0F]You finally made it! [N][0E:1E]First of all, let me [N]say thank you- [N][0E:5A]I started to think of [N]many things- [N][0E:5A]I know this may sound [N]strange but in the [N]human world, [N][0E:3C]if a person kills one [N]man he is a murderer- [N][0E:28]However, if a person [N]kills 100, [N]then he is praised as [N]a hero- [N][0E:5A]I became a king by [N]this theory, [N]but I always felt [N]lonely- [N][0E:5A]Even if I had many men[N][0E:2D]and beautiful women [N]around me, I felt [N]alone- [N][0E:5A]Now I realize no man [N]can live by himself- [N][0E:8C]I am going to spend [N]all the money I [N]received from [N]Deathtoll to construct[N]and build a great [N]town- [N][0E:5A]This is my way of [N]compensating the [N]people I helped [N]defeat- [N][0E:3C]But, I also want to [N]build a town where [N]people won t have [N]anything to fear- [N][0E:28]and they can begin to [N]believe in themselves-[N][0E:5A][02:2], [N]thank you very much- [N][0E:46]I will build statues [N]of you and Dr-Leo [N]in the center of town-[N][0E:28]I promise to tell [N]every generation about[N]your accomplishments- [0E:78][JMP:&w5_shared_02706C.asciistring_0270DF+M]|