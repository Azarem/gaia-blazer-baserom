?BANK 04

?INCLUDE 'engine_003005'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'shared_actor_helpers_bank4'

!joy_block_mask                 0326

---------------------------------------------

code_02100B {
    COP [3B] ( #$00D7, &code_021021 )
    COP [17] ( &shared_actor_helpers_bank4.code_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_021021 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02102F )
    COP [15]
    COP [91]
    RTL 
}

code_02102F {
    COP [01] ( &asciistring_021034 )
    RTL 
}

asciistring_021034 |[10]There is a house [N]in the desert to #- [FIN]Mechanical monsters [N]that cannot be [N]defeated by normal [N]swords exist there- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_02108F {
    COP [3B] ( #$00D6, &code_0210A5 )
    COP [17] ( &shared_actor_helpers_bank4.code_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0210A5 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0210B3 )
    COP [15]
    COP [91]
    RTL 
}

code_0210B3 {
    COP [07] ( #$9B03, &code_0210C7 )
    COP [01] ( &asciistring_0210CC )
    BRK #$5E
    COP [0A] ( #3D )
    COP [09] ( #$9B03 )
    RTL 
}

code_0210C7 {
    COP [01] ( &asciistring_021224 )
    RTL 
}

asciistring_0210CC |[10]My name is Nome- [N]I used to live in [N]Dr-Leo s house- [FIN]Dr-Leo was asked by [N]King Magridd to build [N]a machine that would [N]call upon evil- [FIN]Because he refused, he[N]was taken to Magridd [N]Castle- [FIN]He secretly gave us 4 [N]stones and told us to [N]run away- [FIN]Those stones are keys [N]to the World of Evil- [FIN]The other stones are [N]in Dr-Leo s [N]Laboratory and in the [N]Castle of Magridd- [FIN]Here, take this [03:24]Silver[N]Stone [03:20]and hurry to the[N]Laboratory where [N]Dr-Leo was held- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021224 |[10]What is his daughters [N]name? Lisa? [N]I wonder how she is [N]doing? [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_021263 {
    COP [14] ( #$00FF, &code_02126A )
    RTL 
}

code_02126A {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_021289 )
    COP [15]
    COP [91]
    COP [14] ( #$0103, &code_02127E )
    RTL 
}

code_02127E {
    COP [09] ( #$8706 )
    COP [17] ( &code_02128E )
    COP [91]
    RTL 
}

code_021289 {
    COP [01] ( &asciistring_021293 )
    RTL 
}

code_02128E {
    COP [01] ( &asciistring_0212DC )
    RTL 
}

asciistring_021293 |[10]There is a sword [N]called Lucky Blade [N]somewhere in Laynole- [FIN]It is said that [N]monsters will leave [N]larger GEMs- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0212DC |[10]The King has spoken of[N]you- The snail over [N]there is Nome- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_0212FE {
    COP [14] ( #$00D4, &code_021305 )
    RTL 
}

code_021305 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [14] ( #$00EF, &code_021314 )
    BRA loc_02133C
}

code_021314 {
    COP [14] ( #$00F0, &code_02131C )
    BRA loc_02133C
}

code_02131C {
    COP [14] ( #$00E9, &code_021324 )
    BRA loc_021343
}

code_021324 {
    COP [14] ( #$00F2, &code_02132C )
    BRA loc_021343
}

code_02132C {
    COP [17] ( &code_0213BA )
    COP [05] ( #$0001 )
    COP [16]
    COP [17] ( &code_021399 )
    BRA loc_02134A

  loc_02133C:
    COP [17] ( &code_0213B0 )
    COP [91]
    RTL 

  loc_021343:
    COP [17] ( &code_0213B5 )
    COP [91]
    RTL 

  loc_02134A:
    COP [81] ( #1D, #06 )
    COP [83]
    COP [81] ( #1B, #04 )
    COP [83]
    COP [81] ( #1D, #0B )
    COP [83]
    COP [81] ( #1B, #0D )
    COP [83]
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1B, #06 )
    COP [83]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1B, #06 )
    COP [83]
    COP [81] ( #1D, #0E )
    COP [83]
    COP [81] ( #1C, #1D )
    COP [83]
    COP [97]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    BRA loc_02134A

  loc_021396:
    COP [91]
    RTL 
}

code_021399 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0213BF )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

code_0213B0 {
    COP [01] ( &asciistring_0213E9 )
    RTL 
}

code_0213B5 {
    COP [01] ( &asciistring_021409 )
    RTL 
}

code_0213BA {
    COP [01] ( &asciistring_02143E )
    RTL 
}

asciistring_0213BF |[10]I have no time to [N]talk- I think I am [N]going to lose the [N]race- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0213E9 |[10]We are snail jockeys- [N]This snail is called [N]Legend- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021409 |[10]All the jockeys are [N]here, but the race [N]track is not completed[N]yet- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_02143E |[10]I am going to win this[N]race! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_021455 {
    COP [14] ( #$00EF, &code_02145C )
    RTL 
}

code_02145C {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [14] ( #$00D4, &code_02146B )
    BRA loc_021493
}

code_02146B {
    COP [14] ( #$00F0, &code_021473 )
    BRA loc_021493
}

code_021473 {
    COP [14] ( #$00E9, &code_02147B )
    BRA loc_02149A
}

code_02147B {
    COP [14] ( #$00F2, &code_021483 )
    BRA loc_02149A
}

code_021483 {
    COP [17] ( &code_021511 )
    COP [05] ( #$0001 )
    COP [16]
    COP [17] ( &code_0214F0 )
    BRA loc_0214A1

  loc_021493:
    COP [17] ( &code_021507 )
    COP [91]
    RTL 

  loc_02149A:
    COP [17] ( &code_02150C )
    COP [91]
    RTL 

  loc_0214A1:
    COP [81] ( #1D, #06 )
    COP [83]
    COP [81] ( #1B, #02 )
    COP [83]
    COP [81] ( #1D, #0B )
    COP [83]
    COP [81] ( #1B, #0D )
    COP [83]
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1B, #06 )
    COP [83]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1B, #06 )
    COP [83]
    COP [81] ( #1D, #0E )
    COP [83]
    COP [81] ( #1C, #1B )
    COP [83]
    COP [97]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    BRA loc_0214A1

  loc_0214ED:
    COP [91]
    RTL 
}

code_0214F0 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_021516 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

code_021507 {
    COP [01] ( &asciistring_02153D )
    RTL 
}

code_02150C {
    COP [01] ( &asciistring_021569 )
    RTL 
}

code_021511 {
    COP [01] ( &asciistring_02159A )
    RTL 
}

asciistring_021516 |[10]I have no time to [N]talk- I am going to [N]lose the race- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_02153D |[10]We are snail jockeys- [N]This snail is called [N]Flash- [N]I am the fastest! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021569 |[10]All the jockeys are [N]here but the race [N]track is not yet [N]completed- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_02159A |[10]I am going to win this[N]race! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_0215B1 {
    COP [14] ( #$00F0, &code_0215B8 )
    RTL 
}

code_0215B8 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [14] ( #$00D4, &code_0215C7 )
    BRA loc_0215EF
}

code_0215C7 {
    COP [14] ( #$00EF, &code_0215CF )
    BRA loc_0215EF
}

code_0215CF {
    COP [14] ( #$00E9, &code_0215D7 )
    BRA loc_0215F6
}

code_0215D7 {
    COP [14] ( #$00F2, &code_0215DF )
    BRA loc_0215F6
}

code_0215DF {
    COP [17] ( &code_021661 )
    COP [05] ( #$0001 )
    COP [16]
    COP [17] ( &code_021640 )
    BRA loc_0215FD

  loc_0215EF:
    COP [17] ( &code_021657 )
    COP [91]
    RTL 

  loc_0215F6:
    COP [17] ( &code_02165C )
    COP [91]
    RTL 

  loc_0215FD:
    COP [81] ( #1D, #11 )
    COP [83]
    COP [81] ( #1B, #0D )
    COP [83]
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1B, #06 )
    COP [83]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1B, #06 )
    COP [83]
    COP [81] ( #1D, #0E )
    COP [83]
    COP [81] ( #1C, #19 )
    COP [83]
    COP [97]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    BRA loc_0215FD

  loc_02163D:
    COP [91]
    RTL 
}

code_021640 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_021666 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

code_021657 {
    COP [01] ( &asciistring_02168D )
    RTL 
}

code_02165C {
    COP [01] ( &asciistring_0216BE )
    RTL 
}

code_021661 {
    COP [01] ( &asciistring_0216EF )
    RTL 
}

asciistring_021666 |[10]I have no time to [N]talk- I am going to [N]lose the race- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_02168D |[10]We are snail jockeys- [N]We are waiting for the[N]race to start- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0216BE |[10]All the jockeys are [N]here but the race [N]track is not yet [N]completed- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0216EF |[10]We are waiting for the[N]race to start- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_021711 {
    COP [14] ( #$00CB, &code_021718 )
    RTL 
}

code_021718 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02172D )
    COP [15]

  loc_021723:
    COP [AD] ( #08 )
    COP [80] ( #25 )
    COP [82]
    BRA loc_021723
}

code_02172D {
    COP [01] ( &asciistring_021732 )
    RTL 
}

asciistring_021732 |[10]These creatures grow [N]very fast- They become[N]adults within half a [N]year, [FIN]get married, have [N]children and pass away[N]in a year- [FIN]They never feel their [N]lives are too short- [N]They enjoy each [N]moment! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_0217D9 {
    COP [14] ( #$00FE, &code_0217E0 )
    RTL 
}

code_0217E0 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_021824 )
    COP [15]
    COP [91]
    COP [18] ( #04, &code_0217F3 )
    RTL 
}

code_0217F3 {
    COP [0D] ( #00, #37, #24, &code_0217FB )
    RTL 
}

code_0217FB {
    COP [16]
    LDA #$2F80
    TSB $joy_block_mask
    COP [97]
    COP [81] ( #11, #02 )
    COP [83]
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #0C )
    COP [82]
    LDA #$2F80
    TRB $joy_block_mask
    COP [15]
    COP [01] ( &asciistring_021858 )
    COP [91]
    RTL 
}

code_021824 {
    COP [01] ( &asciistring_021829 )
    RTL 
}

asciistring_021829 |[10]This passage leads to [N]the underground lake, [N]Lune- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021858 |[10]Hey, you re not going [N]to the lake with that [N]sword are you? [FIN]You are going to get [N]in trouble- [FIN]Talk to some of the [N]people in town, maybe [N]someone can help you- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_0218BF {
    COP [14] ( #$00FC, &code_0218C6 )
    RTL 
}

code_0218C6 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0218D4 )
    COP [15]
    COP [91]
    RTL 
}

code_0218D4 {
    COP [07] ( #$8707, &code_0218F5 )
    COP [19] ( #1C, &code_0218F0 )
    COP [01] ( &asciistring_021903 )
    COP [3C] ( #04 )
    COP [10] ( #$030B, #01, #$00A0, #$00E0 )
    RTL 
}

code_0218F0 {
    COP [01] ( &asciistring_0218FA )
    RTL 
}

code_0218F5 {
    COP [01] ( &asciistring_021924 )
    RTL 
}

asciistring_0218FA |[10]Zzzz [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021903 |[10][02:2] placed [N]the Dream Rod on the [N]old man- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021924 |[10]Oops! I must have [N]fallen asleep- [FIN]I was dreaming of my [N]childhood- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_02195F {
    COP [3B] ( #$00FA, &code_021975 )
    COP [17] ( &shared_actor_helpers_bank4.code_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_021975 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_021983 )
    COP [15]
    COP [91]
    RTL 
}

code_021983 {
    COP [01] ( &asciistring_021988 )
    RTL 
}

asciistring_021988 |[10]Can you believe this [N]old man used to be a [N]child just a half a [N]year ago? [FIN]Time is very [N]important- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_0219CE {
    COP [14] ( #$00EE, &code_0219D5 )
    RTL 
}

code_0219D5 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0219EA )
    COP [15]

  loc_0219E0:
    COP [AD] ( #08 )
    COP [80] ( #25 )
    COP [82]
    BRA loc_0219E0
}

code_0219EA {
    COP [01] ( &asciistring_0219EF )
    RTL 
}

asciistring_0219EF |[10]There is a prison over[N]there- [FIN]Well--- there are no [N]actual bad people- [N]I guess it is just a [N]punishment room- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_021A4B {
    COP [14] ( #$00E8, &code_021A52 )
    RTL 
}

code_021A52 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_021A60 )
    COP [15]
    COP [91]
    RTL 
}

code_021A60 {
    COP [07] ( #$9A04, &code_021A74 )
    COP [01] ( &asciistring_021A79 )
    BRK #$5E
    COP [0A] ( #2E )
    COP [09] ( #$9A04 )
    RTL 
}

code_021A74 {
    COP [01] ( &asciistring_021AB8 )
    RTL 
}

asciistring_021A79 |[10]How did you get in? [N]Here I will give you [N]this- [FIN][02:2] received [N][03:24]the Master s Emblem E-[03:20][JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021AB8 |[10]How did you get in? [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_021ACA {
    COP [14] ( #$00F2, &code_021AD1 )
    RTL 
}

code_021AD1 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_021B2E )
    COP [15]
    COP [05] ( #$0002 )
    COP [17] ( #$0000 )
    COP [16]
    COP [96]
    COP [81] ( #0B, #03 )
    COP [83]
    COP [81] ( #0A, #13 )
    COP [83]
    COP [97]
    COP [81] ( #0B, #03 )
    COP [83]
    COP [80] ( #07 )
    COP [82]
    COP [15]
    LDA $0016, X
    AND #$FFF7
    STA $0016, X
    COP [17] ( &code_021B57 )
    COP [05] ( #$0001 )
    COP [16]
    COP [96]
    COP [81] ( #0B, #02 )
    COP [83]
    COP [81] ( #09, #04 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    COP [15]
    COP [91]
    RTL 
}

code_021B2E {
    COP [14] ( #$00D4, &code_021B36 )
    BRA loc_021B69
}

code_021B36 {
    COP [14] ( #$00EF, &code_021B3E )
    BRA loc_021B69
}

code_021B3E {
    COP [14] ( #$00F0, &code_021B46 )
    BRA loc_021B69
}

code_021B46 {
    COP [14] ( #$00E9, &code_021B4E )
    BRA loc_021B6E
}

code_021B4E {
    COP [01] ( &asciistring_021B73 )
    COP [09] ( #$8002 )
    RTL 
}

code_021B57 {
    COP [01] ( &asciistring_021BCE )
    COP [09] ( #$8001 )
    COP [17] ( &code_021B64 )
    RTL 
}

code_021B64 {
    COP [01] ( &asciistring_021C18 )
    RTL 

  loc_021B69:
    COP [01] ( &asciistring_021C24 )
    RTL 

  loc_021B6E:
    COP [01] ( &asciistring_021C68 )
    RTL 
}

asciistring_021B73 |[10]All the jockeys [N]are here and the race [N]track is finally [N]finished- [FIN]We are going to start [N]the race- Why don t [N]you come along? [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021BCE |[10]On your mark, [FIN]well everyone s on the[N]mark- [FIN]Okay, are you ready? [FIN]Get set, [N][0E:28]Go! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021C18 |[10]All right! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021C24 |[10]This is the race [N]track- [FIN]Not all the members [N]are ready, so I cannot[N]start the race- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021C68 |[10]This is the race [N]track- [FIN]But the track is not [N]yet completed, so I [N]cannot start the race- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

code_021CB0 {
    COP [14] ( #$00CA, &code_021CB7 )
    RTL 
}

code_021CB7 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [17] ( &code_021CC5 )
    COP [91]
    RTL 
}

code_021CC5 {
    COP [01] ( &asciistring_021CCA )
    RTL 
}

asciistring_021CCA |[10]This is where the [N]Mountain of Souls [N]exists- [FIN]It is quite warm [N]inside the mountain- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|