?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

!joy_block_mask                 0326

---------------------------------------------

code_020563 {
    COP [14] ( #$0103, &code_02056A ) ; {132451}
    RTL                   ; {132457}
}

code_02056A {
    COP [30] ( #$0103, &code_02067F, #04 ) ; {132458}
    COP [07] ( #$9F02, &code_0205F2 ) ; {132465}
    COP [07] ( #$8A01, &code_0205D2 ) ; {132471}
    COP [85] ( @engine_0026F3.code_00299D ) ; {132477}
    COP [17] ( &code_02062D ) ; {132482}
    COP [15]              ; {132486}
    COP [18] ( #18, &code_02058F ) ; {132488}
    BRA loc_0205EF        ; {132493}
}

code_02058F {
    COP [05] ( #$0004 )   ; {132495}
    LDA #$2F80            ; {132499}
    TSB $joy_block_mask   ; {132502}
    COP [05] ( #$0005 )   ; {132505}
    COP [01] ( &asciistring_0209D4 ) ; {132509}
    BRK #$5E              ; {132513}
    COP [0A] ( #18 )      ; {132515}
    COP [0B] ( #32 )      ; {132518}
    COP [0B] ( #33 )      ; {132521}
    COP [0B] ( #34 )      ; {132524}
    COP [03] ( #3D )      ; {132527}
    COP [04]              ; {132530}
    COP [01] ( &asciistring_02092A ) ; {132532}
    COP [09] ( #$8A00 )   ; {132536}
    COP [09] ( #$8A01 )   ; {132540}
    LDA #$0020            ; {132544}
    STA $03B4             ; {132547}
    COP [10] ( #$0314, #01, #$00F8, #$0128 ) ; {132550}
    COP [91]              ; {132559}
    RTL                   ; {132561}
}

code_0205D2 {
    LDA #$2F80            ; {132562}
    TSB $joy_block_mask   ; {132565}
    COP [09] ( #$0A01 )   ; {132568}
    COP [03] ( #29 )      ; {132572}
    COP [04]              ; {132575}
    COP [01] ( &asciistring_0209F2 ) ; {132577}
    LDA #$2F80            ; {132581}
    TRB $joy_block_mask   ; {132584}
    COP [17] ( &code_02062D ) ; {132587}

  loc_0205EF:
    COP [91]              ; {132591}
    RTL                   ; {132593}
}

code_0205F2 {
    COP [11] ( #0A, #00, #C9 ) ; {132594}
    COP [11] ( #0B, #00, #C9 ) ; {132599}
    COP [11] ( #12, #11, #37 ) ; {132604}
    LDA #$BFC0            ; {132609}
    TSB $joy_block_mask   ; {132612}
    COP [03] ( #29 )      ; {132615}
    COP [04]              ; {132618}
    COP [01] ( &asciistring_020AF6 ) ; {132620}
    COP [03] ( #5B )      ; {132624}
    COP [04]              ; {132627}
    LDA #$0020            ; {132629}
    STA $03B4             ; {132632}
    COP [10] ( #$0106, #01, #$01F8, #$0060 ) ; {132635}
    LDA #$BFC0            ; {132644}
    TRB $joy_block_mask   ; {132647}
    COP [91]              ; {132650}
    RTL                   ; {132652}
}

code_02062D {
    COP [07] ( #$0705, &code_020676 ) ; {132653}
    COP [18] ( #18, &code_02063D ) ; {132659}
    COP [01] ( &asciistring_0208B1 ) ; {132664}
    RTL                   ; {132668}
}

code_02063D {
    COP [18] ( #32, &code_020671 ) ; {132669}
    COP [18] ( #33, &code_020671 ) ; {132674}
    COP [18] ( #34, &code_020671 ) ; {132679}
    COP [14] ( #$00E1, &code_020654 ) ; {132684}
    BRA loc_02066C        ; {132690}
}

code_020654 {
    COP [14] ( #$00E6, &code_02065C ) ; {132692}
    BRA loc_02066C        ; {132698}
}

code_02065C {
    COP [01] ( &asciistring_020904 ) ; {132700}
    COP [17] ( #$0000 )   ; {132704}
    COP [31] ( #00 )      ; {132708}
    COP [09] ( #$8004 )   ; {132711}
    RTL                   ; {132715}

  loc_02066C:
    COP [01] ( &asciistring_020A83 ) ; {132716}
    RTL                   ; {132720}
}

code_020671 {
    COP [01] ( &asciistring_0207CF ) ; {132721}
    RTL                   ; {132725}
}

code_020676 {
    COP [01] ( &asciistring_0206AC ) ; {132726}
    COP [09] ( #$8705 )   ; {132730}
    RTL                   ; {132734}
}

code_02067F {
    COP [14] ( #$00E1, &code_02068D ) ; {132735}
    COP [14] ( #$00E6, &code_02068D ) ; {132741}
    BRA loc_020691        ; {132747}
}

code_02068D {
    COP [01] ( &asciistring_020696 ) ; {132749}

  loc_020691:
    COP [37]              ; {132753}
    COP [86]              ; {132755}
    RTL                   ; {132757}
}

asciistring_020696 |[10][0E:1E]King, are you okay? [0E:3C][JMP:&w3_shared_02249A.asciistring_02251E+M]|

asciistring_0206AC |[10]You saved me? Thank [N]you very much- [FIN][JMP:&asciistring_020742]|

asciistring_0206C6 |By the way, the prison[N]guard has not yet been[N]released- [FIN]Release him and do not[N]forget to visit those [N]around him- [FIN][::]I believe you will [N]find what you are [N]looking for- [FIN][JMP:&asciistring_0207D3]|

asciistring_020742 |I treated the snail, [N]Nome, very poorly- [FIN]I would not trust all [N]of the things Nome was[N]saying- [FIN]He told me monsters [N]would invade our town-[N]I put him in prison- [FIN]See Nome- [N][JMP:&asciistring_0206C6+M]|

asciistring_0207CF |[10][JMP:&asciistring_0207D3+M]|

asciistring_0207D3 |By the way, [N][::]have you heard [N]of the Phoenix? [FIN]Whoever collects the [N]Master s three [N]symbols, [FIN]The Red+Hot Mirror, [FIN]The Red+Hot Ball and [FIN]The Red+Hot Stick, [FIN]shall have the Phoenix[N]help them- [FIN]That person will [N]inherit the strongest [N]power- [FIN]If you collect them [N]all bring them to me- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0208B1 |[10]The power of the [N]Phoenix is tremendous-[FIN]I fear that without [N]it s power you will [N]not defeat Deathtoll- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020904 |[10]You made it! [N][02:2], I shall [N]call the Phoenix- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_02092A |[10][0F]High above in the sky,[N]a beautiful voice [N]could be heard--- [FIN][0F]I am the Phoenix- [N]I live on the Mountain[N]of Souls- [FIN]I will help you revive[N]the world and protect [N]the peace- [FIN]As soon as I was [N]called, Deathtoll [N]moved into position- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0209D4 |[10][02:2] received [N][03:24]Magic of Phoenix!! [03:20][JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_0209F2 |[10][02:2], [N]return to the world of[N]evil with the Phoenix-[FIN]If you equip SoulBlade[N]and Soul Armor the [N]Phoenix will be able [N]to help you- [FIN]This is the final [N]battle, the battle [N]with Deathtoll- [FIN]Please come back [N]alive- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020A83 |[10]Yes, you have [N]collected the three [N]symbols, but--- [FIN]I need two very old [N]magicians to help call[N]the Phoenix- [FIN]Find them and return [N]to me- [JMP:&w3_shared_02249A.asciistring_02251E]|

asciistring_020AF6 |[10][0F]Oh, you re back! [N][0E:5A]Well, I wasn t [N]worried, but---- [N][0E:28]Nome was really [N]worried about you- [N][0E:3C]Nome, [N]say something- [N][0E:78][10]--------- [N][0E:5A][0A]The█King█is█such█a[N]thoughtless█man-[N][0E:5A][10][0A]Dr-Leo has passed [N]away- [0E:28]I miss him very [N]much- [N][0E:5A]There are creatures [N]that only get one year[N]to live- [N][0E:5A]The value of life [N]depends on the number [N]of days spent with [N]fulfillment- [N][0E:5A]Maybe Dr-Leo s life [N]was more fulfilled [N]than many others- [N][0E:78][JMP:&w3_shared_02249A.asciistring_02251E+M]|