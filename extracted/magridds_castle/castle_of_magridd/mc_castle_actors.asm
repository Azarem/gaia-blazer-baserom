?BANK 04

?INCLUDE 'engine_003005'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'mc_return_prompt_and_chest_hint_texts'
?INCLUDE 'shared_actor_helpers_bank4'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!joy_block_mask                 0326
!asset_skip_mask                03B4
!souls_flags                    1B82

---------------------------------------------

code_023FA8 {
    COP [14] ( #$0159, &code_023FAF )
    RTL 
}

code_023FAF {
    COP [30] ( #$0159, &code_023FC9, #04 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_023FC4 )
    COP [15]
    COP [91]
    RTL 
}

code_023FC4 {
    COP [01] ( &asciistring_023FDD )
    RTL 
}

code_023FC9 {
    COP [18] ( #06, &code_023FD1 )

  loc_023FCE:
    COP [86]
    RTL 
}

code_023FD1 {
    COP [01] ( &asciistring_023FD7 )
    BRA loc_023FCE
}

asciistring_023FD7 |[10][0E:3C][JMP:&asciistring_023FDD+M]|

asciistring_023FDD |[10][::]There are many [N]ghosts in the torture [N]room of the basement- [FIN]First, [N]look for the Spirit [N]Sword- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_024027 {
    COP [14] ( #$015A, &code_02402E )
    RTL 
}

code_02402E {
    COP [07] ( #$8806, &code_024042 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02404B )
    COP [15]
    COP [91]
    RTL 
}

code_024042 {
    COP [17] ( &code_024054 )
    COP [15]
    COP [91]
    RTL 
}

code_02404B {
    COP [01] ( &asciistring_024059 )
    COP [09] ( #$8806 )
    RTL 
}

code_024054 {
    COP [01] ( &asciistring_0240AC )
    RTL 
}

asciistring_024059 |[10]My uncle is [N]the famous architect [N]Gaudi- [FIN]I know a bit about [N]architecture- [N]I will show you [N]something later- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0240AC |[10]What do you think [N]about the wall? [N]I am known as a [N]"speedˮ architect- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_0240E4 {
    RTL 
}
---------------------------------------------

code_0240E5 {
    COP [14] ( #$015F, &code_0240EC )
    RTL 
}

code_0240EC {
    COP [30] ( #$015F, &code_024111, #04 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_024101 )
    COP [15]
    COP [91]
    RTL 
}

code_024101 {
    COP [14] ( #$0195, &code_02410C )
    COP [01] ( &asciistring_024194 )
    RTL 
}

code_02410C {
    COP [01] ( &asciistring_0241F2 )
    RTL 
}

code_024111 {
    COP [01] ( &asciistring_024118 )
    COP [86]
    RTL 
}

asciistring_024118 |[10][0E:3C]Thank you very much- [FIN]There are many thorns [N]in the basement- [FIN]If you free the [N]soldier right in front[N]of where I have been [N]captured, [FIN]you will receive [N]the Elemental Mail- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024194 |[10]This is King Magridd s[N]Castle- [FIN]The King is the [N]greatest man in the [N]world- [FIN][0A]I█must█say█that█or[N]I█will█be█punished-[JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0241F2 |[10]This is the Castle of [N]King Magridd- [FIN]The King is the [N]greatest man in the [N]world- [FIN]I don t have to say [N]that anymore, because [N]the King really did [N]become a good man- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_024259 {
    COP [14] ( #$0161, &code_024260 )
    RTL 
}

code_024260 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [07] ( #$8804, &code_0242AE )
    COP [17] ( &code_0242BC )
    COP [15]
    COP [91]
    COP [0D] ( #00, #02, #1F, &code_02427B )
    RTL 
}

code_02427B {
    COP [07] ( #$0803, &code_0242B9 )
    COP [17] ( #$0000 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #2C )
    COP [82]
    COP [2B] ( #$FFF0, #$0000 )
    COP [01] ( &asciistring_024316 )
    BRK #$5E
    COP [0A] ( #0F )
    COP [09] ( #$8804 )
    LDA #$2F80
    TRB $joy_block_mask
}

code_0242AE {
    COP [80] ( #12 )
    COP [82]
    COP [17] ( &code_0242DD )
    COP [15]
}

code_0242B9 {
    COP [91]
    RTL 
}

code_0242BC {
    COP [07] ( #$8804, &code_0242DD )
    COP [19] ( #1C, &code_0242D8 )
    COP [01] ( &asciistring_0242EB )
    COP [3C] ( #04 )
    COP [10] ( #$0313, #01, #$0150, #$01A0 )
    RTL 
}

code_0242D8 {
    COP [01] ( &asciistring_0242E2 )
    RTL 
}

code_0242DD {
    COP [01] ( &asciistring_0243E7 )
    RTL 
}

asciistring_0242E2 |[10]Zzzz [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0242EB |[10][02:2] placed the [N]Dream Rod upon the [N]soldier s head- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024316 |[10]Oops! I was sleeping- [FIN]Lately I have been [N]having the same dream [N]as Dr-Leo- [FIN]If I would have [N]released Dr-Leo, [N]the world would not be[N]like this- [FIN]I don t know who to [N]obey anymore! [FIN]There are many thorns [N]in the basement of [N]Magridd Castle- [FIN]You must take this [N]armor with you- [FIN][02:2] received [N][03:24]the Elemental Mail- [03:20][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0243E7 |[10]I have a feeling that [N]you will change the [N]world- [N]Good luck! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_024416 {
    COP [14] ( #$0162, &code_02441D )
    RTL 
}

code_02441D {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0244C5 )

  loc_024426:
    COP [97]
    COP [81] ( #17, #08 )
    COP [83]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #13 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #12 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [81] ( #15, #0B )
    COP [83]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #12 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [96]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [81] ( #17, #10 )
    COP [83]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #13 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [81] ( #16, #0B )
    COP [83]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #13 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [97]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [81] ( #17, #08 )
    COP [83]
    BRL loc_024426
}

code_0244C5 {
    COP [01] ( &asciistring_0244CA )
    RTL 
}

asciistring_0244CA |[10]I am guarding [N]the castle- [N]Don t talk to me- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_0244EF {
    COP [14] ( #$0166, &code_0244F6 )
    RTL 
}

code_0244F6 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_024504 )
    COP [15]
    COP [91]
    RTL 
}

code_024504 {
    COP [14] ( #$0195, &code_02450F )
    COP [01] ( &asciistring_024514 )
    RTL 
}

code_02450F {
    COP [01] ( &asciistring_024575 )
    RTL 
}

asciistring_024514 |[10]This is King [N]Magridd s Castle- [FIN]Our King is the [N]greatest man in the [N]world- [FIN][0A]I█must█say█this█or[N]I█will█be█punished-[JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024575 |[10]I think he is in shock[N]after losing the [N]Queen- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_024597 {
    COP [14] ( #$0167, &code_02459E )
    RTL 
}

code_02459E {
    COP [30] ( #$0167, &code_024615, #04 )
    COP [17] ( &code_0245CB )
    COP [15]
    COP [80] ( #1B )
    COP [82]
    COP [91]
    RTL 
}

code_0245B3 {
    COP [80] ( #1C )
    COP [82]
    COP [31] ( #12 )
    COP [03] ( #79 )
    COP [04]
    COP [09] ( #$8001 )

  loc_0245C4:
    COP [80] ( #1D )
    COP [82]
    BRA loc_0245C4
}

code_0245CB {
    COP [07] ( #$8703, &code_0245FF )
    COP [19] ( #1A, &code_024610 )
    COP [01] ( &asciistring_02480A )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_0245FA )
    LDA $L_choice_result
    BNE code_0245FA
    COP [09] ( #$8703 )
    COP [01] ( &asciistring_02484C )
    COP [0B] ( #1A )
    COP [17] ( &code_02460B )
    COP [27] ( &code_0245B3 )
}

code_0245FA {
    COP [01] ( &asciistring_024871 )
    RTL 
}

code_0245FF {
    COP [01] ( &asciistring_024676 )
    COP [17] ( &code_02460B )
    COP [27] ( &code_0245B3 )
}

code_02460B {
    COP [01] ( &asciistring_02479E )
    RTL 
}

code_024610 {
    COP [01] ( &asciistring_0247DE )
    RTL 
}

code_024615 {
    COP [01] ( &asciistring_02461C )
    COP [86]
    RTL 
}

asciistring_02461C |[10][0E:3C]A sad sounding voice [N]is coming from the [N]theater- [FIN]Oh, what can I do? [N]I can t play a harp [N]without strings- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024676 |[10][::]Thank you very [N]much for coming- [FIN]Before I play some [N]music let me tell you [N]my story- [FIN]I fell in love just [N]once in my 24 years- [FIN]It was when I visited [N]a mine town, [N]Grass Valley- [FIN]When I was injured, [N]there was a girl who [N]took care of me- [FIN]I couldn t tell her [N]my true feelings [N]though-------- [FIN]The girl s name was [N]something like Lisa- [FIN]The music I am going [N]to play now is a song [N]that I wrote for her- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_02479E |[10]There are no words- [FIN]I hope someday someone[N]will be able to put [N]words to my music- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0247DE |[10]I want to play music, [N]but the harp string [N]is broken- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_02480A |[10]Oh! [N]That is a harp string-[FIN]I promise to use it [N]carefully if you give [N]it to me- [END]|

asciistring_02484C |Thank you very much- [N]Please sit and [N]listen to my music- [FIN][JMP:&asciistring_024676+M]|

asciistring_024871 |It seems important [N]to you- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_02488E {
    COP [3B] ( #$0168, &code_0248A4 )
    COP [17] ( &shared_actor_helpers_bank4.code_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0248A4 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0248B2 )
    COP [15]
    COP [91]
    RTL 
}

code_0248B2 {
    COP [14] ( #$0195, &code_0248BD )
    COP [01] ( &asciistring_0248C2 )
    RTL 
}

code_0248BD {
    COP [01] ( &asciistring_024904 )
    RTL 
}

asciistring_0248C2 |[10]One of the soldiers [N]betrayed the King! [N]He is trying to [N]escape with Dr-Leo- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024904 |[10]The Queen passed away?[FIN]King Magridd must be [N]in shock! [FIN]He did everything he [N]could to save the [N]Queen- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_02494A {
    COP [14] ( #$017F, &code_024951 )
    RTL 
}

code_024951 {
    COP [30] ( #$017F, &code_0249D1, #04 )
    COP [07] ( #$8805, &code_024978 )
    COP [17] ( &code_02499F )
    COP [15]

  loc_024964:
    COP [07] ( #$8000, &code_024971 )
    COP [80] ( #0C )
    COP [82]
    BRA loc_024964
}

code_024971 {
    COP [80] ( #0D )
    COP [82]
    BRA loc_024964
}

code_024978 {
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [18] ( #37, &code_024989 )
    COP [86]
    RTL 
}

code_024989 {
    COP [91]
    COP [0D] ( #00, #36, #17, &code_024993 )
    RTL 
}

code_024993 {
    COP [01] ( &asciistring_024AB6 )
    BRK #$5E
    COP [0A] ( #37 )
    COP [91]
    RTL 
}

code_02499F {
    COP [18] ( #29, &code_0249A9 )
    COP [01] ( &asciistring_024A76 )
    RTL 
}

code_0249A9 {
    COP [01] ( &asciistring_024A21 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_0249C8 )
    LDA $L_choice_result
    BNE code_0249C8
    COP [01] ( &asciistring_024A47 )
    BRK #$5E
    COP [0A] ( #29 )
    COP [09] ( #$0000 )
    RTL 
}

code_0249C8 {
    COP [01] ( &asciistring_024AA8 )
    COP [09] ( #$8000 )
    RTL 
}

code_0249D1 {
    COP [01] ( &asciistring_0249D8 )
    COP [86]
    RTL 
}

asciistring_0249D8 |[10][0E:3C]I do not know who you [N]are, but thank you [N]very much for [N]releasing me- [FIN]I will give you a gift[N]if you come back- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024A21 |[10]I am the wife of King [N]Magridd- Do you think [N]I am pretty? [END]|

asciistring_024A47 |This is my present to [N]you- [FIN]The Queen put [N]something in [N][02:2] S pocket- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024A76 |[10]Do you like it? [N]You may go wherever [N]you want within the [N]Magridd Castle- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024AA8 |[10]--------- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024AB6 |[10][02:2] found [03:24]the [N]Invulnerable Bracelet [N][03:20]where the Queen was [N]standing- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_024AF4 {
    COP [14] ( #$016D, &code_024AFB )
    RTL 
}

code_024AFB {
    COP [07] ( #$8805, &code_024B29 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_024B2C )
    COP [15]
    COP [05] ( #$0607 )
    COP [17] ( &code_024B3F )
    COP [16]
    COP [96]
    COP [80] ( #17 )
    COP [82]
    COP [97]
    COP [80] ( #14 )
    COP [82]
    COP [15]
    COP [91]
    RTL 
}

code_024B29 {
    COP [86]
    RTL 
}

code_024B2C {
    COP [19] ( #28, &code_024B3A )
    COP [01] ( &asciistring_024B98 )
    COP [09] ( #$8607 )
    RTL 
}

code_024B3A {
    COP [01] ( &asciistring_024B44 )
    RTL 
}

code_024B3F {
    COP [01] ( &asciistring_024B94 )
    RTL 
}

asciistring_024B44 |[10]The top floor of this [N]tower is a prison- [FIN]Anyone who does not [N]have the Platinum Card[N]cannot enter- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024B94 |[10][JMP:&asciistring_024B98+M]|

asciistring_024B98 |[10]Oh, that is the [N]Platinum Card, I am [N]sorry- [FIN][::]Please go inside- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_024BC8 {
    COP [3B] ( #$0170, &code_024BDE )
    COP [17] ( &shared_actor_helpers_bank4.code_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_024BDE {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [07] ( #$8805, &code_024C20 )
    COP [17] ( &code_024C23 )
    COP [18] ( #28, &code_024BF8 )
    COP [17] ( &code_024C2D )
    BRA loc_024BFF
}

code_024BF8 {
    COP [B0] ( @code_024C32, #$2000 )

  loc_024BFF:
    COP [15]
    COP [05] ( #$0001 )
    COP [16]
    COP [17] ( #$0000 )
    COP [81] ( #17, #02 )
    COP [83]
    COP [81] ( #16, #03 )
    COP [83]
    COP [17] ( &code_024C28 )
    COP [15]
    COP [91]
    RTL 
}

code_024C20 {
    COP [86]
    RTL 
}

code_024C23 {
    COP [01] ( &asciistring_024C48 )
    RTL 
}

code_024C28 {
    COP [01] ( &asciistring_024CDF )
    RTL 
}

code_024C2D {
    COP [01] ( &asciistring_024D1B )
    RTL 
}

code_024C32 {
    COP [91]
    COP [0D] ( #00, #0B, #30, &code_024C3C )
    RTL 
}

code_024C3C {
    COP [01] ( &asciistring_024D45 )
    BRK #$5E
    COP [0A] ( #28 )
    COP [86]
    RTL 
}

asciistring_024C48 |[10]I am a guard- [N]But I am tired of my [N]job- [N]I came here to relax- [FIN][0F]While listening to the[N]guard, [02:2] sees a[N]card under the guard s[N]feet- [FIN]But [02:2] can t [N]get it because the [N]guard is standing on [N]it- [0F][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024CDF |[10]I love listening to [N]music from the front [N]row- [FIN]Please do not bother [N]me- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024D1B |[10]I am a guard, [N]I am tired of my job- [N]I came here to relax- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024D45 |[10][02:2] found [N][03:24]a card- [03:20][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_024D59 {
    COP [14] ( #$0172, &code_024D60 )
    RTL 
}

code_024D60 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_024D6E )
    COP [15]
    COP [91]
    RTL 
}

code_024D6E {
    COP [01] ( &asciistring_024D73 )
    RTL 
}

asciistring_024D73 |[10]I have a friend who [N]once disobeyed King [N]Magridd- He wanted to [N]save Dr-Leo- [FIN]He was taken to the [N]torture room in the [N]first basement and [N]never came back- [FIN]"This harp string is a[N]birthday present from [N]my friend- [FIN]I am able to play [N]great music with this [N]string-ˮ [FIN]He always told me I [N]could- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_024E53 {
    COP [14] ( #$0187, &code_024E5A )
    RTL 
}

code_024E5A {
    COP [91]
    COP [0D] ( #00, #39, #2F, &code_024E70 )
    RTL 
}

code_024E64 {
    COP [91]
    COP [0D] ( #00, #39, #2F, &code_024E6F )
    BRA code_024E5A
}

code_024E6F {
    RTL 
}

code_024E70 {
    COP [01] ( &asciistring_024E9D )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_024E97 )
    LDA $L_choice_result
    BNE code_024E97
    COP [18] ( #38, &code_024E8C )
    COP [01] ( &asciistring_024F0E )
    BRA code_024E64
}

code_024E8C {
    COP [01] ( &asciistring_024EB9 )
    BRK #$5E
    COP [0A] ( #38 )
    BRA code_024E64
}

code_024E97 {
    COP [01] ( &asciistring_024F27 )
    BRA code_024E64
}

asciistring_024E9D |[10]You want Medical Herbs[N]don t you? [END]|

asciistring_024EB9 |[10]See? [N]I have the ability to [N]read peoples  minds- [FIN]Here I will give you [N]one- [FIN][02:2] received [N][03:24]a Medical Herb- [03:20][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024F0E |[10]Hey, you already have [N]one- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024F27 |[10]Oh, I guess my ability[N]is not perfect- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_024F4A {
    COP [3B] ( #$017E, &code_024F60 )
    COP [17] ( &shared_actor_helpers_bank4.code_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_024F60 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_024F6E )
    COP [15]
    COP [91]
    RTL 
}

code_024F6E {
    COP [01] ( &asciistring_024F73 )
    RTL 
}

asciistring_024F73 |[10]Music is really [N]strange- [FIN]The same music [N]sometimes sounds very [N]wonderful when I am [N]happy [FIN]and sad when I am [N]depressed- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_024FD3 {
    COP [14] ( #$016B, &code_024FDA )
    RTL 
}

code_024FDA {
    COP [14] ( #$0185, &code_024FE9 )
    COP [17] ( &code_025015 )
    COP [15]
    COP [91]
    RTL 
}

code_024FE9 {
    COP [A1] ( #$0010, #$0030 )
    COP [17] ( &code_02501A )
    COP [96]
    COP [80] ( #0E )
    COP [82]
    COP [15]
    COP [91]
    COP [0D] ( #00, #1C, #33, &code_025006 )
    RTL 
}

code_025006 {
    COP [03] ( #05 )
    COP [04]
    COP [97]
    COP [80] ( #0E )
    COP [82]
    COP [91]
    RTL 
}

code_025015 {
    COP [01] ( &asciistring_02501F )
    RTL 
}

code_02501A {
    COP [01] ( &asciistring_025053 )
    RTL 
}

asciistring_02501F |[10]This is the [N]soldiers  dormitory- [FIN]I am taking care of [N]them- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025053 |[10]Oh, I was just [N]removing a speck of [N]dust from his eye- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_025080 {
    COP [14] ( #$0182, &code_025087 )
    RTL 
}

code_025087 {
    COP [07] ( #$8805, &code_0250B5 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0250B8 )
    COP [15]
    COP [05] ( #$0700 )
    COP [17] ( &code_0250CB )
    COP [16]
    COP [97]
    COP [80] ( #17 )
    COP [82]
    COP [96]
    COP [80] ( #14 )
    COP [82]
    COP [15]
    COP [91]
    RTL 
}

code_0250B5 {
    COP [86]
    RTL 
}

code_0250B8 {
    COP [19] ( #29, &code_0250C6 )
    COP [01] ( &asciistring_025133 )
    COP [09] ( #$8700 )
    RTL 
}

code_0250C6 {
    COP [01] ( &asciistring_0250D0 )
    RTL 
}

code_0250CB {
    COP [01] ( &asciistring_02512F )
    RTL 
}

asciistring_0250D0 |[10]This tower is [N]connected to the [N]airship s dock at the [N]top floor- [FIN]Anyone without a VIP [N]card cannot get in- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_02512F |[10][JMP:&asciistring_025133+M]|

asciistring_025133 |[10]Oh, that is the VIP [N]card- [N]I am very sorry- [N][::]Please come in- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_02515B {
    COP [3B] ( #$0186, &code_025171 )
    COP [17] ( &shared_actor_helpers_bank4.code_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_025171 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02517F )
    COP [15]
    COP [91]
    RTL 
}

code_02517F {
    COP [01] ( &asciistring_025184 )
    RTL 
}

asciistring_025184 |[10]I find a great [N]many things wandering [N]around- [FIN]I have seen something [N]shiny around the [N]castle- [FIN]But I did not pick up-[JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_0251DC {
    COP [14] ( #$0179, &code_0251E3 )
    RTL 
}

code_0251E3 {
    COP [30] ( #$0179, &code_02521A, #04 )
    COP [17] ( &code_025203 )
    COP [15]
    COP [91]
    COP [07] ( #$8604, &code_0251F9 )
    RTL 
}

code_0251F9 {
    COP [16]
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [86]
    RTL 
}

code_025203 {
    COP [01] ( &asciistring_025266 )
    BRK #$4E
    COP [09] ( #$8604 )
    SEP #$20
    LDA $souls_flags
    ORA #$10
    STA $souls_flags
    REP #$20
    RTL 
}

code_02521A {
    COP [01] ( &asciistring_025221 )
    COP [86]
    RTL 
}

asciistring_025221 |[10][0E:3C]Someone is calling [N][02:2] from the [N]house- [FIN]I know everything [N]about the Magridd [N]Castle- [FIN]I will help you when [N]you come back- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025266 |[10]Even though I don t [N]look like it, [N]I am from the sky just[N]like you- [FIN]I know all of the [N]invisible passages in [N]the Magridd Castle- [FIN]Would you like to walk[N]the basement with me? [FIN]The soul that [N]knows the castle s [N]secret passages joins [N]you! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_025302 {
    COP [14] ( #$018C, &code_025309 )
    RTL 
}

code_025309 {
    COP [14] ( #$0195, &code_02531C )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02534D )
    COP [15]
    BRA loc_02532D
}

code_02531C {
    COP [17] ( &code_025352 )
    COP [9F] ( #$FFF0 )
    COP [15]
    COP [96]
    COP [80] ( #14 )
    COP [82]

  loc_02532D:
    COP [91]
    COP [0D] ( #00, #25, #0C, &code_025337 )
    RTL 
}

code_025337 {
    COP [07] ( #$9A07, &code_02534A )
    COP [01] ( &asciistring_0253C3 )
    BRK #$5E
    COP [0A] ( #31 )
    COP [09] ( #$9A07 )
}

code_02534A {
    COP [91]
    RTL 
}

code_02534D {
    COP [01] ( &asciistring_025357 )
    RTL 
}

code_025352 {
    COP [01] ( &asciistring_025397 )
    RTL 
}

asciistring_025357 |[10]If King Magridd [N]doesn t come back, [N]then I will be crowned[N]the next King- [FIN]He, he, he- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025397 |[10]King Magridd is back- [N]Please do not tell [N]anybody what I have [N]said to you- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0253C3 |[10][02:2] found [N][03:24]the Master s Emblem H-[03:20][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_0253E2 {
    COP [14] ( #$018D, &code_0253E9 )
    RTL 
}

code_0253E9 {
    COP [17] ( &code_0253F2 )
    COP [15]
    COP [91]
    RTL 
}

code_0253F2 {
    COP [14] ( #$0195, &code_0253FD )
    COP [01] ( &asciistring_025402 )
    RTL 
}

code_0253FD {
    COP [01] ( &asciistring_025438 )
    RTL 
}

asciistring_025402 |[10]The key to the airship[N]has been stolen! [N]I don t know what is [N]going to happen- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025438 |[10]There appears to be a [N]fight on the airship s[N]dock- [FIN]It seems some of my [N]friends have passed [N]away- [FIN]I hate being a [N]soldier- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_0254A2 {
    COP [3B] ( #$018F, &code_0254B8 )
    COP [17] ( &shared_actor_helpers_bank4.code_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0254B8 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0254C6 )
    COP [15]
    COP [91]
    RTL 
}

code_0254C6 {
    COP [01] ( &asciistring_0254CB )
    RTL 
}

asciistring_0254CB |[10]Don t you think that [N]she s a nice girl- [N]She seems to know what[N]people want- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_025502 {
    COP [14] ( #$0192, &code_025509 )
    RTL 
}

code_025509 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_025517 )
    COP [15]
    COP [91]
    RTL 
}

code_025517 {
    COP [01] ( &asciistring_02551C )
    RTL 
}

asciistring_02551C |[10]Phew! You scared me! [FIN]Don t sneak up behind [N]me- I almost fell into[N]the river- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

code_025561 {
    COP [3B] ( #$0195, &code_025577 )
    COP [17] ( &shared_actor_helpers_bank4.code_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_025577 {
    COP [30] ( #$0195, &code_0255E4, #04 )
    COP [07] ( #$9F02, &code_02559B )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0255C7 )
    COP [15]
    COP [05] ( #$0007 )
    COP [80] ( #02 )
    COP [82]
    COP [91]
    RTL 
}

code_02559B {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_02580C )
    COP [03] ( #5B )
    COP [04]
    LDA #$0020
    STA $asset_skip_mask
    COP [10] ( #$030D, #01, #$00A0, #$0050 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_0255C7 {
    COP [09] ( #$8007 )
    COP [07] ( #$9B05, &code_0255DF )
    COP [01] ( &asciistring_025639 )
    BRK #$5E
    COP [0A] ( #3F )
    COP [09] ( #$9B05 )
    RTL 
}

code_0255DF {
    COP [01] ( &asciistring_0257CA )
    RTL 
}

code_0255E4 {
    COP [01] ( &asciistring_0255ED )
    COP [37]
    COP [86]
    RTL 
}

asciistring_0255ED |[10][0E:3C]I knew what was [N]happening- [FIN]I could do nothing to [N]prevent the Queen from[N]passing away- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025639 |[10]I have failed as [N]a King- [FIN]I ordered people to be[N]loyal to me- [FIN]And killed whomever [N]would not follow me- [FIN]Once you reach the top[N]the only way is down- [FIN]I was just a coward- [N]I made a promise with [N]the evil King [N]Deathtoll- [FIN]Simply because I [N]thought it would [N]impress the Queen- [FIN]But the Queen was [N]captured by her own [N]desire and passed [N]away- [FIN]I must apologize to [N]Dr-Leo- [FIN]I have [03:24]the Black Stone[N][03:20]with me- You must have[N]all 6 of these now- [FIN]Please go to the world[N]of evil and defeat [N]Deathtoll- [FIN]This is all I can do [N]for Dr-Leo- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0257CA |[10]I finally realized [N]what was happening [N]when the situation was[N]at its worst- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_02580C |[10][0F]You finally made it! [N][0E:1E]First of all, let me [N]say thank you- [N][0E:5A]I started to think of [N]many things- [N][0E:5A]I know this may sound [N]strange but in the [N]human world, [N][0E:3C]if a person kills one [N]man he is a murderer- [N][0E:28]However, if a person [N]kills 100, [N]then he is praised as [N]a hero- [N][0E:5A]I became a king by [N]this theory, [N]but I always felt [N]lonely- [N][0E:5A]Even if I had many men[N][0E:2D]and beautiful women [N]around me, I felt [N]alone- [N][0E:5A]Now I realize no man [N]can live by himself- [N][0E:8C]I am going to spend [N]all the money I [N]received from [N]Deathtoll to construct[N]and build a great [N]town- [N][0E:5A]This is my way of [N]compensating the [N]people I helped [N]defeat- [N][0E:3C]But, I also want to [N]build a town where [N]people won t have [N]anything to fear- [N][0E:28]and they can begin to [N]believe in themselves-[N][0E:5A][02:2], [N]thank you very much- [N][0E:46]I will build statues [N]of you and Dr-Leo [N]in the center of town-[N][0E:28]I promise to tell [N]every generation about[N]your accomplishments- [0E:78][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF+M]|
---------------------------------------------

code_025AAA {
    COP [3B] ( #$0185, &code_025AC0 )
    COP [17] ( &shared_actor_helpers_bank4.code_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_025AC0 {
    COP [A1] ( #$FFE0, #$0020 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_025AF1 )
    COP [97]
    COP [80] ( #14 )
    COP [82]
    COP [15]
    COP [91]
    COP [0D] ( #00, #1C, #33, &code_025AE2 )
    RTL 
}

code_025AE2 {
    COP [03] ( #05 )
    COP [04]
    COP [96]
    COP [80] ( #14 )
    COP [82]
    COP [91]
    RTL 
}

code_025AF1 {
    COP [01] ( &asciistring_025AF6 )
    RTL 
}

asciistring_025AF6 |[10]She was removing some [N]dust from my eye- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|