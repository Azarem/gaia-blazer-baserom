?BANK 03

?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'gv_watching_over_world_texts'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!joy_pressed                    0322
!joy_block_mask                 0326

---------------------------------------------

code_019475 {
    COP [14] ( #$001A, &code_01947C )
    RTL 
}

code_01947C {
    COP [30] ( #$001A, &code_019505, #03 )
    COP [AC] ( @code_0194BE, #$0000, #$0010, #$2000 )
    COP [14] ( #$0009, &code_0194B5 )
    COP [17] ( &code_0194FB )

  loc_019498:
    COP [80] ( #03 )
    COP [82]
    COP [87]
    COP [81] ( #05, #02 )
    COP [83]
    COP [80] ( #04 )
    COP [82]
    COP [87]
    COP [81] ( #05, #02 )
    COP [83]
    BRL loc_019498
}

code_0194B5 {
    COP [17] ( &code_019500 )
    COP [15]
    COP [91]
    RTL 
}

code_0194BE {
    COP [20] ( &code_0194C9 )
    COP [0D] ( #00, #30, #04, &code_0194CE )
}

code_0194C9 {
    COP [09] ( #$0006 )
    RTL 
}

code_0194CE {
    COP [19] ( #1D, &code_0194E1 )
    COP [01] ( &asciistring_01954B )
    COP [10] ( #$0103, #01, #$0078, #$03E0 )
    RTL 
}

code_0194E1 {
    COP [07] ( #$8006, &code_0194F5 )
    COP [09] ( #$8006 )
    COP [14] ( #$0009, &code_0194F6 )
    COP [01] ( &asciistring_01956E )
}

code_0194F5 {
    RTL 
}

code_0194F6 {
    COP [01] ( &asciistring_0195A8 )
    RTL 
}

code_0194FB {
    COP [01] ( &asciistring_01950C )
    RTL 
}

code_019500 {
    COP [01] ( &asciistring_0195CB )
    RTL 
}

code_019505 {
    COP [01] ( &asciistring_0195FE )
    COP [86]
    RTL 
}

asciistring_01950C |[10]This was painted by [N]Dr-Leo- A strange [N]face has appeared! [FIN]It s terrifying!! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01954B |[10][0F][02:2] is [N]dragged into the [N]painting! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01956E |[10][0F]There is a picture of [N]the village Chief in [N]the painting, he [N]appears to be sad- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0195A8 |[10][0F]The painting has [N]returned to normal- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0195CB |[10]The face of the [N]village Chief has [N]disappeared!! What was[N]that? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0195FE |[10][0E:3C]You hear a man [N]screaming inside the [N]house- [FIN]AHHHH!! [N]A GHOST! A GHOST! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_019644 {
    COP [14] ( #$000E, &code_01964B )
    RTL 
}

code_01964B {
    COP [05] ( #$0404 )
    COP [80] ( #1C )
    COP [82]
    BRA code_01964B
}
---------------------------------------------

code_019656 {
    COP [14] ( #$000E, &code_01965D )
    RTL 
}

code_01965D {
    COP [05] ( #$0404 )
    COP [80] ( #1D )
    COP [82]
    BRA code_01965D
}
---------------------------------------------

code_019668 {
    COP [14] ( #$0023, &code_01966F )
    RTL 
}

code_01966F {
    COP [15]
    COP [17] ( &code_0196FD )
    COP [91]
    COP [0D] ( #00, #38, #3A, &code_01967F )
    RTL 
}

code_01967F {
    COP [07] ( #$8206, &code_0196F6 )
    COP [01] ( &asciistring_01971A )
    COP [91]
    COP [14] ( #$0022, &code_019692 )
    RTL 
}

code_019692 {
    COP [0D] ( #00, #3C, #37, &code_01969A )
    RTL 
}

code_01969A {
    COP [17] ( #$0000 )
    COP [16]
    COP [80] ( #0F )
    COP [82]
    COP [9D] ( #0F )
    COP [9E] ( &code_0196AC )
}

code_0196AC {
    COP [80] ( #11 )
    COP [82]
    COP [9D] ( #11 )
    COP [9E] ( &code_0196B8 )
}

code_0196B8 {
    COP [81] ( #10, #02 )
    COP [83]
    COP [9D] ( #10 )
    COP [9E] ( &code_0196C5 )
}

code_0196C5 {
    COP [81] ( #11, #03 )
    COP [83]
    COP [9D] ( #10 )
    COP [9E] ( &code_0196D2 )
}

code_0196D2 {
    COP [97]
    COP [80] ( #0E )
    COP [82]
    COP [15]
    COP [17] ( &code_019706 )
    COP [91]
    COP [0C] ( #00, #02, &code_0196E8 )
    RTL 
}

code_0196E8 {
    COP [96]
    COP [80] ( #0C )
    COP [82]
    COP [01] ( &asciistring_01975F )
    COP [91]
    RTL 
}

code_0196F6 {
    COP [17] ( &code_01970B )
    COP [91]
    RTL 
}

code_0196FD {
    COP [01] ( &asciistring_019728 )
    COP [09] ( #$8005 )
    RTL 
}

code_019706 {
    COP [01] ( &asciistring_01975F )
    RTL 
}

code_01970B {
    COP [18] ( #1B, &code_019715 )
    COP [01] ( &asciistring_019793 )
    RTL 
}

code_019715 {
    COP [01] ( &asciistring_0197C3 )
    RTL 
}

asciistring_01971A |[10]Oh! You scared me! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_019728 |[10]This is our secret [N]hut- We have hidden [N]treasure near here- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01975F |[10]Were you following me?[N]I will not tell you [N]where our treasure is-[JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_019793 |[10]Oh! That s my pass! [N]Well, okay, I ll give [N]it to you- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0197C3 |[10]Was the pass helpful? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_0197DA {
    COP [14] ( #$0022, &code_0197E1 )
    RTL 
}

code_0197E1 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_019847 )
    COP [15]
    COP [91]
    COP [0D] ( #00, #2F, #36, &code_0197F6 )
    RTL 
}

code_0197F6 {
    COP [03] ( #28 )
    LDA $joy_pressed
    AND #$0200
    BEQ loc_019843
    COP [0D] ( #00, #2F, #36, &code_01980B )
    BRL loc_019843
}

code_01980B {
    COP [04]
    COP [16]
    LDA #$2F80
    TSB $joy_block_mask
    COP [81] ( #20, #10 )
    COP [83]
    LDA #$2F80
    TRB $joy_block_mask
    COP [15]
    COP [07] ( #$8206, &code_019840 )
    COP [91]
    COP [0D] ( #00, #2E, #36, &code_019833 )
    RTL 
}

code_019833 {
    COP [01] ( &asciistring_01986F )
    BRK #$5E
    COP [0A] ( #1B )
    COP [09] ( #$8206 )
}

code_019840 {
    COP [91]
    RTL 

  loc_019843:
    COP [27] ( &code_0197F6 )
}

code_019847 {
    COP [19] ( #1C, &code_01985D )
    COP [01] ( &asciistring_019880 )
    COP [3C] ( #04 )
    COP [10] ( #$0403, #00, #$0078, #$0070 )
    RTL 
}

code_01985D {
    COP [01] ( &asciistring_019862 )
    RTL 
}

asciistring_019862 |[10]Zzzz---- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01986F |[10]There is [03:24]a pass- [03:20][JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_019880 |[10][02:2] placed [N]the Dream Rod on the [N]tulip s petal- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_0198A6 {
    COP [14] ( #$0025, &code_0198AD )
    RTL 
}

code_0198AD {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01991A )
    COP [91]
    COP [07] ( #$0201, &code_0198C8 )
    COP [11] ( #14, #2C, #13 )
    COP [15]
    BRL loc_0198F7
}

code_0198C8 {
    COP [15]
    COP [05] ( #$0200 )
    COP [17] ( &code_019930 )
    COP [91]
    COP [0C] ( #00, #02, &code_0198DD )
    BRL loc_0198DE
}

code_0198DD {
    RTL 

  loc_0198DE:
    COP [16]
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    COP [87]
    COP [80] ( #0E )
    COP [82]
    COP [15]
    COP [09] ( #$8201 )

  loc_0198F7:
    COP [17] ( &code_019935 )
    COP [91]
    COP [0D] ( #00, #28, #0B, &code_019905 )
    RTL 
}

code_019905 {
    COP [07] ( #$0904, &code_01990C )
    RTL 
}

code_01990C {
    COP [01] ( &asciistring_0199DC )
    BRK #$5E
    COP [0A] ( #39 )
    COP [09] ( #$8904 )
    RTL 
}

code_01991A {
    COP [19] ( #1B, &code_01992B )
    COP [09] ( #$8200 )
    COP [01] ( &asciistring_01997B )
    COP [0B] ( #1B )
    RTL 
}

code_01992B {
    COP [01] ( &asciistring_01993A )
    RTL 
}

code_019930 {
    COP [01] ( &asciistring_0199AE )
    RTL 
}

code_019935 {
    COP [01] ( &asciistring_0199F1 )
    RTL 
}

asciistring_01993A |[10]This is our secret [N]passage- I cannot let [N]you through without [N]a pass- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01997B |[10]Oh, the pass! Where [N]did you find it? [N]You can go inside now-[JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0199AE |[10]Would you please move [N]over a little so I can[N]let you pass? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0199DC |[10]There is [03:24]a strange [N]bottle- [03:20][JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0199F1 |[10]I am tired of playing [N]hide and seek- I must [N]find something else to[N]do- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_019A2C {
    COP [14] ( #$001D, &code_019A33 )
    RTL 
}

code_019A33 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [07] ( #$0102, &code_019A46 )
    COP [11] ( #15, #32, #2A )
    BRL loc_019AD6
}

code_019A46 {
    COP [17] ( &code_019AE4 )
    COP [15]
    COP [91]
    RTL 
}

code_019A4F {
    COP [16]
    COP [17] ( &code_019B05 )
    COP [81] ( #1B, #02 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #1A, #03 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [81] ( #1B, #02 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #1A, #02 )
    COP [83]
    COP [87]
    COP [9F] ( #$FFF8 )
    COP [80] ( #18 )
    COP [82]
    COP [17] ( &code_019AEC )
    COP [15]
    COP [91]
    RTL 
}

code_019A8D {
    COP [16]
    COP [17] ( &code_019B05 )
    COP [81] ( #1A, #04 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [81] ( #1B, #03 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [80] ( #1A )
    COP [82]
    COP [17] ( &code_019AF4 )
    COP [15]
    COP [91]
    RTL 
}

code_019AB5 {
    COP [16]
    COP [17] ( &code_019B05 )
    COP [87]
    COP [9F] ( #$0008 )
    COP [81] ( #1B, #04 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #19, #0A )
    COP [83]
    COP [80] ( #18 )
    COP [82]

  loc_019AD6:
    COP [15]
    COP [17] ( &code_019AFC )
    COP [91]
    COP [80] ( #24 )
    COP [82]
    RTL 
}

code_019AE4 {
    COP [01] ( &asciistring_019B0A )
    COP [27] ( &code_019A4F )
}

code_019AEC {
    COP [01] ( &asciistring_019B52 )
    COP [27] ( &code_019A8D )
}

code_019AF4 {
    COP [01] ( &asciistring_019BF2 )
    COP [27] ( &code_019AB5 )
}

code_019AFC {
    COP [01] ( &asciistring_019C56 )
    COP [09] ( #$8102 )
    RTL 
}

code_019B05 {
    COP [01] ( &asciistring_019CC1 )
    RTL 
}

asciistring_019B0A |[10]You are the one who [N]set me free, right? [FIN]Come, I shall show you[N]around- Please follow [N]me- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_019B52 |[10]This is the home of [N]Dr-Leo the inventor [N]and his daughter, [N]Lisa- [FIN]Dr-Leo was a great [N]painter as well as an [N]inventor- [FIN]One day, many soldiers[N]came and took Dr-Leo [N]away- Lisa has not [N]been the same since- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_019BF2 |[10]The house at the top [N]of this cliff contains[N]a painting by Dr-Leo-[FIN]I think the title of [N]the painting is [N]something like [N]"The World of Evil-ˮ [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_019C56 |[10]This is a house people[N]constructed for the [N]goats- I am not [N]terribly fond of it- [FIN]I did see something on[N]the ground near the [N]corner of the fence- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_019CC1 |[10]This is all I will [N]tell you- Please [N]follow me- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_019CDE {
    COP [14] ( #$0015, &code_019CE5 )
    RTL 
}

code_019CE5 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_019D3B )
    COP [15]
    COP [05] ( #$0205 )
    COP [17] ( &code_019D69 )
    COP [16]
    COP [9F] ( #$0008 )
    COP [81] ( #19, #02 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [87]
    COP [81] ( #1B, #04 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #1A, #05 )
    COP [83]
    COP [87]
    COP [9F] ( #$FFF8 )
    COP [81] ( #1B, #0E )
    COP [83]
    COP [9F] ( #$0010 )
    COP [81] ( #1A, #04 )
    COP [83]
    COP [17] ( &code_019D6E )
    COP [09] ( #$0205 )
    COP [91]
    RTL 
}

code_019D3B {
    COP [18] ( #19, &code_019D64 )
    COP [01] ( &asciistring_019DCA )

  loc_019D44:
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_019D51 )
    LDA $L_choice_result
    BEQ loc_019D58
}

code_019D51 {
    COP [01] ( &asciistring_019EB1 )
    BRL loc_019D44

  loc_019D58:
    COP [01] ( &asciistring_019E0E )
    COP [0B] ( #19 )
    COP [09] ( #$8205 )
    RTL 
}

code_019D64 {
    COP [01] ( &asciistring_019D73 )
    RTL 
}

code_019D69 {
    COP [01] ( &asciistring_019EC5 )
    RTL 
}

code_019D6E {
    COP [01] ( &asciistring_019EE2 )
    RTL 
}

asciistring_019D73 |[10]I am known among my [N]friends as something [N]of a Gourmet Goat- [FIN]I will only eat food [N]sold at the tool shop- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_019DCA |[10]Oh! You have some food[N]from the tool shop! [FIN]I promise to tell you [N]a secret if you will [N]give me the food- [END]|

asciistring_019E0E |Thank you! I will [N]tell you a secret- [FIN]If you wish to get [N]inside the painting, [N]you must equip an item[N]which [FIN]used to belong to the [N]painter and touch the [N]painting- [FIN]Well, I have other [N]things to attend to so[N]I will see you later! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_019EB1 |Oh come on!, [N]Please!! [END]|

asciistring_019EC5 |[10]I love food from the [N]tool shop! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_019EE2 |[10]Hey, give me my food! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_019EF4 {
    COP [14] ( #$0028, &code_019EFB )
    RTL 
}

code_019EFB {
    COP [17] ( &code_019F04 )
    COP [15]
    COP [91]
    RTL 
}

code_019F04 {
    COP [01] ( &asciistring_019F09 )
    RTL 
}

asciistring_019F09 |[10]Since losing my wife [N]to an illness, I [N]noticed a goat hanging[N]around my place- [FIN]I was so lonely [N]I decided to keep the [N]goat as a pet- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_019F7A {
    COP [14] ( #$002F, &code_019F81 )
    RTL 
}

code_019F81 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_019F94 )
    COP [15]
    COP [91]
    COP [80] ( #24 )
    COP [82]
    RTL 
}

code_019F94 {
    COP [01] ( &asciistring_019F99 )
    RTL 
}

asciistring_019F99 |[10]I don t know if there [N]is such a thing as [N]reincarnation- [FIN]Even though I can t [N]communicate with my [N]husband, I enjoy his [N]company- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_01A004 {
    COP [14] ( #$002E, &code_01A00B )
    RTL 
}

code_01A00B {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01A01D )
    COP [15]

  loc_01A016:
    COP [80] ( #1E )
    COP [82]
    BRA loc_01A016
}

code_01A01D {
    COP [01] ( &asciistring_01A022 )
    RTL 
}

asciistring_01A022 |[10]Be sure to check [N]underneath all of the [N]tulip s- [FIN]A boy may have hidden [N]something under one- [FIN]He thought that no one[N]was watching, but I [N]saw him! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_01A098 {
    COP [14] ( #$0009, &code_01A09F )
    RTL 
}

code_01A09F {
    COP [30] ( #$0009, &code_01A139, #03 )
    COP [11] ( #01, #04, #08 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01A11F )
    COP [15]
    COP [91]
    COP [07] ( #$9B00, &code_01A0C5 )
    COP [18] ( #3A, &code_01A0C5 )
    BRA loc_01A0C6
}

code_01A0C5 {
    RTL 

  loc_01A0C6:
    LDA #$2F80
    TSB $joy_block_mask
    COP [17] ( #$0000 )
    COP [31] ( #00 )
    COP [85] ( @code_01A105 )
    COP [03] ( #F1 )
    COP [04]
    COP [01] ( &asciistring_01A2C4 )
    COP [09] ( #$9B00 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [85] ( @code_01A112 )
    COP [32] ( #02 )
    COP [03] ( #3D )
    COP [04]
    LDA #$2F80
    TRB $joy_block_mask
    COP [17] ( &code_01A11F )
    COP [91]
    RTL 
}

code_01A105 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #45 )
    COP [94]
    COP [86]
    RTL 
}

code_01A112 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #46 )
    COP [94]
    COP [86]
    RTL 
}

code_01A11F {
    COP [07] ( #$9B00, &code_01A12A )
    COP [18] ( #3A, &code_01A12F )
}

code_01A12A {
    COP [01] ( &asciistring_01A272 )
    RTL 
}

code_01A12F {
    COP [01] ( &asciistring_01A191 )
    BRK #$5E
    COP [0A] ( #3A )
    RTL 
}

code_01A139 {
    COP [01] ( &asciistring_01A142 )
    COP [37]
    COP [86]
    RTL 
}

asciistring_01A142 |[10][0E:3C]Welcome to my room- [N]I finally feel like [N]myself again- [FIN]I have something to [N]tell you- [N]Please come back to [N]my house- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01A191 |[10]I feel as though I [N]have been surrounded [N]by darkness- [FIN]In that darkness I [N]heard my best friend [N]Leo- [FIN]He told me to give [N]this Brown Stone to a [N]person named [02:2]-[FIN]I don t know what the [N]Brown Stone looks like[N]but this is a stone [FIN]that I received from [N]him the day before he [N]disappeared- [FIN][02:2], received [N][03:24]the Brown Stone- [03:20][JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01A272 |[10]Dr-Leo has only a [N]daughter named Lisa- [FIN]I will ask my wife to [N]look after her until [N]Dr-Leo returns- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01A2C4 |[10]Suddenly the Master s [N]voice came thundering [N]down from the heavens-[FIN]"The Brown Stone you [N]have is a key to open [N]the World of Evil- [FIN]This is where [N]Deathtoll lives! [FIN]Come back to me with [N]the stone-ˮ [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_01A34B {
    COP [15]
    COP [17] ( &code_01A362 )
    COP [91]
    COP [14] ( #$0009, &code_01A35F )
    COP [80] ( #23 )
    COP [82]
    RTL 
}

code_01A35F {
    COP [86]
    RTL 
}

code_01A362 {
    COP [01] ( &asciistring_01A367 )
    RTL 
}

asciistring_01A367 |[10]This is the room of [N]the village Chief- He [N]used to sit and rock [N]here for hours- [FIN]I wonder when he is [N]going to come back? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_01AA26 {
    COP [07] ( #$8905, &code_01AA33 )
    COP [B0] ( @code_01AA4C, #$2000 )
}

code_01AA33 {
    COP [15]
    COP [14] ( #$0009, &code_01AA41 )
    COP [17] ( &code_01AA60 )
    BRA loc_01AA45
}

code_01AA41 {
    COP [17] ( &code_01AA65 )

  loc_01AA45:
    COP [80] ( #1E )
    COP [82]
    BRA loc_01AA45
}

code_01AA4C {
    COP [91]
    COP [0C] ( #00, #02, &code_01AA55 )
    RTL 
}

code_01AA55 {
    COP [01] ( &asciistring_01AAC9 )
    COP [09] ( #$8905 )
    COP [86]
    RTL 
}

code_01AA60 {
    COP [01] ( &asciistring_01AA6A )
    RTL 
}

code_01AA65 {
    COP [01] ( &asciistring_01AAE6 )
    RTL 
}

asciistring_01AA6A |[10][::]There are many [N]creatures being held [N]in the Underground [N]Castle- [FIN]If you can release [N]those creatures, [N]the village will be [N]reconstructed- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01AAC9 |[10][02:2] heard a [N]small voice- [FIN][JMP:&asciistring_01AA6A+M]|

asciistring_01AAE6 |[10]Thank you for saving [N]the villagers- [FIN]They are now taking [N]care of me- [FIN]No creature likes to [N]live alone- We have to[N]help each other- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_01AB4F {
    COP [14] ( #$002C, &code_01AB56 )
    RTL 
}

code_01AB56 {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_01AB6A )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.code_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.code_01B17C-1
    PHA 
    RTL 
}

code_01AB6A {
    COP [07] ( #$9C00, &code_01AB7E )
    COP [01] ( &asciistring_01AB83 )
    BRK #$5E
    COP [0A] ( #07 )
    COP [09] ( #$9C00 )
    RTL 
}

code_01AB7E {
    COP [01] ( &gv_watching_over_world_texts.asciistring_01ABE0 )
    RTL 
}

asciistring_01AB83 |[10]I am watching over [N]this world- Please [N]take this sword- [FIN][02:2] received [N][03:24]the Recover Sword- [03:20][JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_01AC06 {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_01AC1A )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.code_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.code_01B17C-1
    PHA 
    RTL 
}

code_01AC1A {
    COP [07] ( #$9C01, &code_01AC2D )
    COP [01] ( &gv_watching_over_world_texts.asciistring_01ABB9 )
    COP [38] ( #$0080 )
    COP [09] ( #$9C01 )
    RTL 
}

code_01AC2D {
    COP [01] ( &gv_watching_over_world_texts.asciistring_01ABE0 )
    RTL 
}