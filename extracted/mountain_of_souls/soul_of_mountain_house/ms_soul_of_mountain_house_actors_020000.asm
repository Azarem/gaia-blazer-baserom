?BANK 04

?INCLUDE 'engine_003005'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'shared_actor_helpers_bank4'

!joy_block_mask                 0326
!player_actor                   039C
!asset_skip_mask                03B4
!return_active                  03FB

---------------------------------------------

code_020000 {
    COP [14] ( #$00C9, &code_020007 )
    RTL 
}

code_020007 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_020052 )
    COP [15]
    COP [05] ( #$0000 )
    COP [16]
    COP [17] ( #$0000 )
    COP [97]
    COP [81] ( #11, #02 )
    COP [83]
    COP [81] ( #10, #02 )
    COP [83]
    COP [81] ( #11, #06 )
    COP [83]
    COP [81] ( #10, #03 )
    COP [83]
    COP [96]
    COP [80] ( #0E )
    COP [82]
    COP [17] ( &code_02005B )
    COP [91]
    COP [0D] ( #00, #0A, #07, &code_02004B )
    RTL 
}

code_02004B {
    COP [01] ( &asciistring_0200B8 )
    COP [91]
    RTL 
}

code_020052 {
    COP [01] ( &asciistring_020060 )
    COP [09] ( #$8000 )
    RTL 
}

code_02005B {
    COP [01] ( &asciistring_020095 )
    RTL 
}

asciistring_020060 |[10]My, my, it is rare to [N]see someone new- [N]Please come into my [N]room- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020095 |[10]Please, sit right in [N]front of me- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0200B8 |[10]I have so many [N]questions about human [N]beings- [FIN]Would you like to [N]discuss them with me? [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_0200F5 {
    COP [14] ( #$00D3, &code_0200FC )
    RTL 
}

code_0200FC {
    COP [17] ( &code_020119 )
    COP [14] ( #$00EA, &code_02010F )
    LDA $0016, X
    AND #$FFF7
    STA $0016, X
}

code_02010F {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [91]
    RTL 
}

code_020119 {
    COP [01] ( &asciistring_02011E )
    RTL 
}

asciistring_02011E |[10]My wife was able to [N]use magic at one time- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_020143 {
    COP [3B] ( #$00EA, &code_020159 )
    COP [17] ( &shared_actor_helpers_bank4.code_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_020159 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02019A )
    COP [15]
    COP [91]
    RTL 
}

code_020167 {
    COP [B2] ( @engine_spawn_lairs_death_drops.RunAppearPuff, #$0000, #$0010, #$0040 )
    BRK #$4E
    LDY $player_actor
    LDA #$0100
    STA $0000, Y
    COP [03] ( #E1 )
    COP [04]
    BRK #$4E
    LDY $player_actor
    LDA #$0020
    STA $0000, Y
    LDA #$01A0
    STA $0002, Y
    COP [01] ( &asciistring_0201C8 )
    COP [91]
    RTL 
}

code_02019A {
    COP [01] ( &asciistring_0201A2 )
    COP [27] ( &code_020167 )
}

asciistring_0201A2 |[10]Oh honey, I can still [N]use magic- [FIN]Look! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0201C8 |[10]You see? [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_0201D2 {
    COP [14] ( #$00CC, &code_0201D9 )
    RTL 
}

code_0201D9 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0201E7 )
    COP [15]
    COP [91]
    RTL 
}

code_0201E7 {
    COP [14] ( #$00EB, &code_0201F2 )
    COP [01] ( &asciistring_02021F )
    RTL 
}

code_0201F2 {
    COP [01] ( &asciistring_0201F7 )
    RTL 
}

asciistring_0201F7 |[10]We were really [N]happy just gazing at [N]each other- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_02021F |[10]Please save my [N]girlfriend- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_020237 {
    COP [3B] ( #$00EB, &code_02024D )
    COP [17] ( &shared_actor_helpers_bank4.code_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_02024D {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02025B )
    COP [15]
    COP [91]
    RTL 
}

code_02025B {
    COP [01] ( &asciistring_020260 )
    RTL 
}

asciistring_020260 |[10]We were really [N]happy just gazing at [N]each other- [FIN]But I may get old [N]soon- [FIN]Maybe I should search [N]for someone new- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_0202BA {
    COP [14] ( #$00F8, &code_0202C1 )
    RTL 
}

code_0202C1 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0202CF )
    COP [15]
    COP [91]
    RTL 
}

code_0202CF {
    COP [01] ( &asciistring_0202D4 )
    RTL 
}

asciistring_0202D4 |[10]Make sure you search [N]Laynole very [N]carefully- [FIN]If you move too fast [N]you may overlook [N]things--- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_02032B {
    COP [14] ( #$00E1, &code_020332 )
    RTL 
}

code_020332 {
    COP [17] ( &code_0203B4 )
    COP [14] ( #$0103, &code_02035A )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [91]
    COP [14] ( #$0103, &code_02034C )
    RTL 
}

code_02034C {
    COP [80] ( #17 )
    COP [82]
    COP [81] ( #15, #08 )
    COP [83]
    COP [91]
    RTL 
}

code_02035A {
    COP [11] ( #0A, #11, #37 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [15]
    COP [05] ( #$0004 )
    COP [81] ( #28, #02 )
    COP [83]
    COP [81] ( #27, #02 )
    COP [83]
    COP [81] ( #28, #02 )
    COP [83]
    COP [81] ( #27, #02 )
    COP [83]
    COP [81] ( #28, #02 )
    COP [83]
    COP [85] ( @code_020445 )
    COP [81] ( #29, #04 )
    COP [83]
    COP [81] ( #2A, #08 )
    COP [83]
    COP [81] ( #2B, #10 )
    COP [83]
    COP [09] ( #$8005 )
    COP [80] ( #14 )
    COP [82]
    COP [91]
    RTL 
}

code_0203B4 {
    COP [14] ( #$0103, &code_0203BF )
    COP [01] ( &asciistring_0203CE )
    RTL 
}

code_0203BF {
    COP [18] ( #18, &code_0203C9 )
    COP [01] ( &asciistring_020427 )
    RTL 
}

code_0203C9 {
    COP [01] ( &asciistring_0203DF )
    RTL 
}

asciistring_0203CE |[10]Please save the King! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0203DF |[10]I am a magician- [FIN]If you collect the [N]Master s three [N]symbols, I will call [N]the Phoenix- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020427 |[10]Oh Phoenix, please [N]protect [02:2]- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

code_020445 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #49 )
    COP [94]
    COP [86]
    RTL 
}
---------------------------------------------

code_020452 {
    COP [14] ( #$00E6, &code_020459 )
    RTL 
}

code_020459 {
    COP [17] ( &code_0204D2 )
    COP [14] ( #$0103, &code_020481 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [91]
    COP [14] ( #$0103, &code_020473 )
    RTL 
}

code_020473 {
    COP [80] ( #17 )
    COP [82]
    COP [81] ( #15, #08 )
    COP [83]
    COP [91]
    RTL 
}

code_020481 {
    COP [11] ( #0B, #0F, #37 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [15]
    COP [05] ( #$0004 )
    COP [81] ( #28, #02 )
    COP [83]
    COP [81] ( #27, #02 )
    COP [83]
    COP [81] ( #28, #02 )
    COP [83]
    COP [81] ( #27, #02 )
    COP [83]
    COP [81] ( #28, #02 )
    COP [83]
    COP [81] ( #29, #04 )
    COP [83]
    COP [81] ( #2A, #08 )
    COP [83]
    COP [81] ( #2B, #10 )
    COP [83]
    COP [80] ( #14 )
    COP [82]
    COP [91]
    RTL 
}

code_0204D2 {
    COP [14] ( #$0103, &code_0204DD )
    COP [01] ( &asciistring_0204EC )
    RTL 
}

code_0204DD {
    COP [18] ( #18, &code_0204E7 )
    COP [01] ( &asciistring_020545 )
    RTL 
}

code_0204E7 {
    COP [01] ( &asciistring_0204FD )
    RTL 
}

asciistring_0204EC |[10]Please save the King! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0204FD |[10]I am a magician- [FIN]If you collect the [N]Master s three [N]symbols, I will call [N]the Phoenix- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020545 |[10]Oh Phoenix, please [N]protect [02:2]- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_020563 {
    COP [14] ( #$0103, &code_02056A )
    RTL 
}

code_02056A {
    COP [30] ( #$0103, &code_02067F, #04 )
    COP [07] ( #$9F02, &code_0205F2 )
    COP [07] ( #$8A01, &code_0205D2 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
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
    STA $asset_skip_mask
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
    STA $asset_skip_mask
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

asciistring_020696 |[10][0E:1E]King, are you okay? [0E:3C][JMP:&shared_actor_helpers_bank4.asciistring_02251E+M]|

asciistring_0206AC |[10]You saved me? Thank [N]you very much- [FIN][JMP:&asciistring_020742]|

asciistring_0206C6 |By the way, the prison[N]guard has not yet been[N]released- [FIN]Release him and do not[N]forget to visit those [N]around him- [FIN][::]I believe you will [N]find what you are [N]looking for- [FIN][JMP:&asciistring_0207D3]|

asciistring_020742 |I treated the snail, [N]Nome, very poorly- [FIN]I would not trust all [N]of the things Nome was[N]saying- [FIN]He told me monsters [N]would invade our town-[N]I put him in prison- [FIN]See Nome- [N][JMP:&asciistring_0206C6+M]|

asciistring_0207CF |[10][JMP:&asciistring_0207D3+M]|

asciistring_0207D3 |By the way, [N][::]have you heard [N]of the Phoenix? [FIN]Whoever collects the [N]Master s three [N]symbols, [FIN]The Red+Hot Mirror, [FIN]The Red+Hot Ball and [FIN]The Red+Hot Stick, [FIN]shall have the Phoenix[N]help them- [FIN]That person will [N]inherit the strongest [N]power- [FIN]If you collect them [N]all bring them to me- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0208B1 |[10]The power of the [N]Phoenix is tremendous-[FIN]I fear that without [N]it s power you will [N]not defeat Deathtoll- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020904 |[10]You made it! [N][02:2], I shall [N]call the Phoenix- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_02092A |[10][0F]High above in the sky,[N]a beautiful voice [N]could be heard--- [FIN][0F]I am the Phoenix- [N]I live on the Mountain[N]of Souls- [FIN]I will help you revive[N]the world and protect [N]the peace- [FIN]As soon as I was [N]called, Deathtoll [N]moved into position- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0209D4 |[10][02:2] received [N][03:24]Magic of Phoenix!! [03:20][JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0209F2 |[10][02:2], [N]return to the world of[N]evil with the Phoenix-[FIN]If you equip SoulBlade[N]and Soul Armor the [N]Phoenix will be able [N]to help you- [FIN]This is the final [N]battle, the battle [N]with Deathtoll- [FIN]Please come back [N]alive- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020A83 |[10]Yes, you have [N]collected the three [N]symbols, but--- [FIN]I need two very old [N]magicians to help call[N]the Phoenix- [FIN]Find them and return [N]to me- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020AF6 |[10][0F]Oh, you re back! [N][0E:5A]Well, I wasn t [N]worried, but---- [N][0E:28]Nome was really [N]worried about you- [N][0E:3C]Nome, [N]say something- [N][0E:78][10]--------- [N][0E:5A][0A]The█King█is█such█a[N]thoughtless█man-[N][0E:5A][10][0A]Dr-Leo has passed [N]away- [0E:28]I miss him very [N]much- [N][0E:5A]There are creatures [N]that only get one year[N]to live- [N][0E:5A]The value of life [N]depends on the number [N]of days spent with [N]fulfillment- [N][0E:5A]Maybe Dr-Leo s life [N]was more fulfilled [N]than many others- [N][0E:78][JMP:&shared_actor_helpers_bank4.asciistring_02251E+M]|
---------------------------------------------

code_020C53 {
    COP [14] ( #$00F6, &code_020C5A )
    RTL 
}

code_020C5A {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_020C6F )
    COP [15]

  loc_020C65:
    COP [AD] ( #08 )
    COP [80] ( #25 )
    COP [82]
    BRA loc_020C65
}

code_020C6F {
    COP [01] ( &asciistring_020C74 )
    RTL 
}

asciistring_020C74 |[10]I ll tell you a [N]secret- [FIN]If you see a sleeping [N]mushroom, return to [N]the same place you saw[N]in it s dream- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_020CC6 {
    COP [14] ( #$00E9, &code_020CCD )
    RTL 
}

code_020CCD {
    COP [30] ( #$00E9, &code_020D65, #04 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [1B] ( &code_020CDF, #$0002 )
}

code_020CDF {
    COP [07] ( #$0007, &code_020D14 )
    LDA #$FFFF
    STA $return_active
    COP [80] ( #04 )
    COP [82]
    COP [03] ( #03 )
    COP [97]
    COP [81] ( #05, #02 )
    COP [83]
    COP [96]
    COP [81] ( #05, #02 )
    COP [83]
    COP [04]
    COP [97]
    COP [80] ( #05 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    COP [91]
    RTL 
}

code_020D14 {
    COP [17] ( &code_020D51 )
    COP [15]
    COP [05] ( #$0003 )
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [96]
    COP [80] ( #02 )
    COP [82]
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_020EB9 )
    COP [16]
    COP [80] ( #26 )
    COP [82]
    COP [09] ( #$0003 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}

code_020D51 {
    COP [18] ( #22, &code_020D5B )
    COP [01] ( &asciistring_020E72 )
    RTL 
}

code_020D5B {
    COP [01] ( &asciistring_020DDC )
    BRK #$5E
    COP [0A] ( #22 )
    RTL 
}

code_020D65 {
    COP [09] ( #$8007 )
    COP [01] ( &asciistring_020D73 )
    STZ $return_active
    COP [86]
    RTL 
}

asciistring_020D73 |[10][0E:28]Hooray! I am back! [N]I am back! [0E:B4][N]Thank you very much- [FIN]I will give you these [N]Mushroom Shoes if you [N]return to me- [FIN]You will be able to [N]walk on ice! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020DDC |[10]I will give you my [N]Mushroom Shoes- [FIN]There is snail goo on [N]the bottom of these [N]shoes- [FIN]If you wear these you [N]will not slip on the [N]ice- [FIN]You will still slip on[N]the slopes though- [FIN][02:2], received [N][03:24]Mushroom Shoes- [03:20][JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020E72 |[10]How do you like my [N]Mushroom Shoes? [FIN]My people make [N]clothing and shoes [N]from mushrooms- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020EB9 |[10]This snail always [N]wants me to walk with [N]it- [FIN]Where shall we go [N]today? [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_020EE9 {
    COP [3B] ( #$00F7, &code_020EFF )
    COP [17] ( &shared_actor_helpers_bank4.code_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_020EFF {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_020F51 )
    COP [15]
    COP [05] ( #$0003 )
    COP [05] ( #$8003 )
    COP [80] ( #18 )
    COP [82]
    COP [17] ( &code_020F5A )
    COP [91]
    RTL 
}

code_020F1E {
    COP [16]

  loc_020F20:
    COP [80] ( #1C )
    COP [82]
    COP [97]
    COP [81] ( #1D, #07 )
    COP [83]
    COP [81] ( #1B, #0B )
    COP [83]
    COP [96]
    COP [81] ( #1D, #09 )
    COP [83]
    COP [81] ( #1C, #06 )
    COP [83]
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1C, #04 )
    COP [83]
    BRA loc_020F20
}

code_020F51 {
    COP [01] ( &asciistring_020F6B )
    COP [09] ( #$8003 )
    RTL 
}

code_020F5A {
    COP [01] ( &asciistring_020F7B )
    COP [17] ( &code_020F66 )
    COP [27] ( &code_020F1E )
}

code_020F66 {
    COP [01] ( &asciistring_020F88 )
    RTL 
}

asciistring_020F6B |[10]Week, week! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020F7B |[10]Let s go! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020F88 |[10]This is our vehicle- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_020F9B {
    COP [3B] ( #$00DD, &code_020FB1 )
    COP [17] ( &shared_actor_helpers_bank4.code_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_020FB1 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_020FC4 )
    COP [15]
    COP [80] ( #25 )
    COP [82]
    COP [91]
    RTL 
}

code_020FC4 {
    COP [19] ( #1C, &code_020FDA )
    COP [01] ( &asciistring_020FE9 )
    COP [3C] ( #04 )
    COP [10] ( #$060B, #01, #$0200, #$02F0 )
    RTL 
}

code_020FDA {
    COP [01] ( &asciistring_020FDF )
    RTL 
}

asciistring_020FDF |[10]Zzzzz [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020FE9 |[10][02:2] placed [N]the Dream Rod on the [N]mushroom- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|