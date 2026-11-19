?BANK 04

?INCLUDE 'engine_0026F3'
?INCLUDE 'w3_shared_02249A'

!joy_block_mask                 0326

---------------------------------------------

code_020563 {
    COP [14] ( #$0103, &code_02056A )
    RTL 
}

code_02056A {
    COP [30] ( #$0103, &code_02067F, #04 )
    COP [07] ( #$9F02, &code_0205F2 )
    COP [07] ( #$8A01, &code_0205D2 )
    COP [85] ( @engine_0026F3.code_00299D )
    COP [17] ( &code_02062D )
    COP [15]
    COP [18] ( #18, &code_02058F )
    BRA loc_0205EF
}

code_02058F {
    COP [05] ( #$0004 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [05] ( #$0005 )
    COP [01] ( &asciistring_0209D4 )
    BRK #$5E
    COP [0A] ( #18 )
    COP [0B] ( #32 )
    COP [0B] ( #33 )
    COP [0B] ( #34 )
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &asciistring_02092A )
    COP [09] ( #$8A00 )
    COP [09] ( #$8A01 )
    LDA #$0020
    STA $03B4
    COP [10] ( #$0314, #01, #$00F8, #$0128 )
    COP [91]
    RTL 
}

code_0205D2 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [09] ( #$0A01 )
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_0209F2 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [17] ( &code_02062D )

  loc_0205EF:
    COP [91]
    RTL 
}

code_0205F2 {
    COP [11] ( #0A, #00, #C9 )
    COP [11] ( #0B, #00, #C9 )
    COP [11] ( #12, #11, #37 )
    LDA #$BFC0
    TSB $joy_block_mask
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_020AF6 )
    COP [03] ( #5B )
    COP [04]
    LDA #$0020
    STA $03B4
    COP [10] ( #$0106, #01, #$01F8, #$0060 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_02062D {
    COP [07] ( #$0705, &code_020676 )
    COP [18] ( #18, &code_02063D )
    COP [01] ( &asciistring_0208B1 )
    RTL 
}

code_02063D {
    COP [18] ( #32, &code_020671 )
    COP [18] ( #33, &code_020671 )
    COP [18] ( #34, &code_020671 )
    COP [14] ( #$00E1, &code_020654 )
    BRA loc_02066C
}

code_020654 {
    COP [14] ( #$00E6, &code_02065C )
    BRA loc_02066C
}

code_02065C {
    COP [01] ( &asciistring_020904 )
    COP [17] ( #$0000 )
    COP [31] ( #00 )
    COP [09] ( #$8004 )
    RTL 

  loc_02066C:
    COP [01] ( &asciistring_020A83 )
    RTL 
}

code_020671 {
    COP [01] ( &asciistring_0207CF )
    RTL 
}

code_020676 {
    COP [01] ( &asciistring_0206AC )
    COP [09] ( #$8705 )
    RTL 
}

code_02067F {
    COP [14] ( #$00E1, &code_02068D )
    COP [14] ( #$00E6, &code_02068D )
    BRA loc_020691
}

code_02068D {
    COP [01] ( &asciistring_020696 )

  loc_020691:
    COP [37]
    COP [86]
    RTL 
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