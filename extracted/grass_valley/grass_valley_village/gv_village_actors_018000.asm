?BANK 03

?INCLUDE 'engine_003005'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!joy_pressed                    0322
!joy_block_mask                 0326
!player_actor                   039C

---------------------------------------------

code_018000 {
    COP [14] ( #$0029, &code_018007 )
    RTL 
}

code_018007 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_018036 )
    COP [15]
    COP [05] ( #$0000 )
    COP [8F]
    COP [80] ( #02 )
    COP [82]
    COP [91]
    LDA $joy_pressed
    AND #$0030
    BNE loc_018028
    RTL 

  loc_018028:
    LDA $joy_pressed
    AND #$0F00
    BNE loc_018031
    RTL 

  loc_018031:
    COP [17] ( &code_01803F )
    RTL 
}

code_018036 {
    COP [01] ( &asciistring_018044 )
    COP [09] ( #$8000 )
    RTL 
}

code_01803F {
    COP [01] ( &asciistring_0180B7 )
    RTL 
}

asciistring_018044 |[10]Hey, you look like you[N]would be good at crab+[N]walking- [N]Try it- [FIN]You don t know how? [N]Just walk while [N]pressing either [N]the L or R button- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0180B7 |[10]See, I knew you could[N]do it! [FIN]This will help you [N]when you are fighting [N]or using magic- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_0180F7 {
    COP [14] ( #$0002, &code_0180FE )
    RTL 
}

code_0180FE {
    COP [30] ( #$0002, &code_018159, #03 )
    COP [14] ( #$0009, &code_018114 )
    COP [17] ( &code_01812B )
    COP [15]
    COP [91]
    RTL 
}

code_018114 {
    COP [07] ( #$9F02, &code_018128 )
    COP [17] ( &code_018160 )
    COP [11] ( #04, #3B, #1E )
    COP [15]
    COP [91]
    RTL 
}

code_018128 {
    COP [86]
    RTL 
}

code_01812B {
    COP [07] ( #$8101, &code_018152 )
    COP [01] ( &asciistring_01816F )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_01814D )
    LDA $L_choice_result
    BNE code_01814D
    COP [09] ( #$8101 )
    COP [01] ( &asciistring_018211 )
    BRL loc_018156
}

code_01814D {
    COP [01] ( &asciistring_0181F8 )
    RTL 
}

code_018152 {
    COP [01] ( &asciistring_018255 )

  loc_018156:
    COP [37]
    RTL 
}

code_018159 {
    COP [01] ( &asciistring_01832D )
    COP [86]
    RTL 
}

code_018160 {
    COP [18] ( #29, &code_01816A )
    COP [01] ( &asciistring_0182E7 )
    RTL 
}

code_01816A {
    COP [01] ( &asciistring_0182AC )
    RTL 
}

asciistring_01816F |[10]My husband used to be [N]the village Chief- [FIN]One day he suddenly [N]disappeared along with[N]the other villagers- [FIN]I feel so lonely---- [N]How about being one of[N]my children? [END]|

asciistring_0181F8 |Well, [N]that s too bad- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018211 |Really?! [N]I will call you [N][02:2] from now on- [FIN]Use the second floor [N]as your own room- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018255 |[10][02:2], [N]you are just walking [N]around doing nothing- [FIN]I am beginning to [N]worry about you- [N]Please, stay here and [N]rest- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0182AC |[10]I feel bad for Lisa, [N]having been separated [N]from her parents- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0182E7 |[10][02:2]! [FIN]Soldiers from Magridd [N]were just here! [N]They kidnapped Lisa! [N]You must rescue her! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01832D |[10]You hear a sigh coming[N]from inside the house-[JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_018353 {
    COP [14] ( #$0006, &code_01835A )
    RTL 
}

code_01835A {
    COP [17] ( &code_018399 )

  code_01835E:
    COP [91]
    COP [20] ( &code_018395 )
    COP [9A] ( #$0000, &code_01836E, &code_018395, &code_018383 )
}

code_01836E {
    COP [23] ( &code_01837B )
    COP [97]
    COP [9D] ( #0B )
    COP [9E] ( &code_01837B )
}

code_01837B {
    COP [80] ( #06 )
    COP [82]
    BRL code_018395
}

code_018383 {
    COP [24] ( &code_018390 )
    COP [96]
    COP [9D] ( #0B )
    COP [9E] ( &code_018390 )
}

code_018390 {
    COP [80] ( #06 )
    COP [82]
}

code_018395 {
    COP [27] ( &code_01835E )
}

code_018399 {
    COP [18] ( #38, &code_0183A3 )
    COP [01] ( &asciistring_018428 )
    RTL 
}

code_0183A3 {
    COP [01] ( &asciistring_0183AD )
    BRK #$5E
    COP [0A] ( #38 )
    RTL 
}

asciistring_0183AD |[10]Hello, may I help you?[FIN]Oh, you are the one [N]who released me! [N]Take whatever you need[N]from my store- [FIN]I only have Medical [N]Herbs though- [FIN][02:2] received [N][03:24]a Medical Herb- [03:20][JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018428 |[10]Hello, may I help you?[FIN]Oh, you are the one [N]who released me! [FIN]Whenever you use your [N]Medical Herb please [N]come back, and I will [N]give you another- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

asciistring_018480 |[02:96][02:80][08:8202]And world your |
---------------------------------------------

code_01848A {
    COP [14] ( #$0007, &code_018491 )
    RTL 
}

code_018491 {
    COP [30] ( #$0007, &code_0184B9, #03 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0184AA )
    COP [15]

  loc_0184A3:
    COP [80] ( #1E )
    COP [82]
    BRA loc_0184A3
}

code_0184AA {
    COP [14] ( #$0009, &code_0184B5 )
    COP [01] ( &asciistring_0184BE )
    RTL 
}

code_0184B5 {
    COP [01] ( &asciistring_018552 )
}

code_0184B9 {
    COP [01] ( &asciistring_01852E )
    RTL 
}

asciistring_0184BE |[10][::]There once was [N]a water mill here [N]before the village was[N]destroyed- [FIN]I hear there is a man [N]in the mill who runs [N]the elevator in the [N]Underground Castle- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01852E |[10][0E:3C][02:2] began [N]to hear a small voice-[FIN][JMP:&asciistring_0184BE+M]|

asciistring_018552 |[10]The village Chief [N]speaks with me every [N]morning- [FIN]Even though I cannot [N]speak, I communicate [N]with him through our [N]thoughts- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_0185B9 {
    COP [14] ( #$0008, &code_0185C0 )
    RTL 
}

code_0185C0 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [91]
    COP [07] ( #$8202, &code_0185D4 )
    COP [17] ( &code_018635 )
    RTL 
}

code_0185D4 {
    COP [17] ( &code_01863E )

  code_0185D8:
    COP [0C] ( #00, #04, &code_01860F )
    COP [07] ( #$8004, &code_0185FD )
    COP [9A] ( #$0000, &code_0185EE, &code_01860F, &code_0185F3 )
}

code_0185EE {
    COP [97]
    BRL loc_0185F5
}

code_0185F3 {
    COP [96]

  loc_0185F5:
    COP [80] ( #02 )
    COP [82]
    BRL loc_018631
}

code_0185FD {
    COP [16]
    COP [9D] ( #04 )
    COP [9E] ( &code_018606 )
}

code_018606 {
    COP [15]
    COP [09] ( #$0004 )
    BRL loc_018631
}

code_01860F {
    COP [07] ( #$8004, &code_01862C )
    COP [16]
    COP [9D] ( #03 )
    COP [9E] ( &code_01861E )
}

code_01861E {
    COP [80] ( #01 )
    COP [82]
    COP [15]
    COP [09] ( #$8004 )
    BRL loc_018631
}

code_01862C {
    COP [80] ( #01 )
    COP [82]

  loc_018631:
    COP [27] ( &code_0185D8 )
}

code_018635 {
    COP [01] ( &asciistring_018643 )
    COP [09] ( #$8202 )
    RTL 
}

code_01863E {
    COP [01] ( &asciistring_018698 )
    RTL 
}

asciistring_018643 |[10]I am the guard of [N]the bridge- [FIN]I guess it is not [N]really necessary to [N]guard such a small [N]bridge, please pass- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018698 |[10]Please pass-[JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_0186A2 {
    COP [14] ( #$000E, &code_0186A9 )
    RTL 
}

code_0186A9 {
    COP [30] ( #$000E, &code_018774, #03 )
    COP [07] ( #$8404, &code_018742 )
    COP [15]
    COP [17] ( &code_018766 )
    COP [05] ( #$0001 )
    COP [16]
    LDA #$2F80
    TSB $joy_block_mask
    COP [96]
    COP [9D] ( #05 )
    COP [9E] ( &code_0186D1 )
}

code_0186D1 {
    COP [9D] ( #04 )
    COP [9E] ( &code_0186D8 )
}

code_0186D8 {
    COP [80] ( #00 )
    COP [82]
    LDA #$2F80
    TRB $joy_block_mask
    COP [15]

  loc_0186E5:
    COP [91]
    COP [0D] ( #00, #26, #17, &code_0186EF )
    RTL 
}

code_0186EF {
    LDA #$2F80
    TSB $joy_block_mask
    LDY $player_actor
    LDA #$0001
    STA $001E, Y
    COP [03] ( #03 )
    COP [04]
    LDA #$2F80
    TRB $joy_block_mask
    COP [01] ( &asciistring_018889 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_018732 )
    LDA $L_choice_result
    BNE code_018732
    COP [01] ( &asciistring_0188A7 )
    BRK #$4F
    COP [09] ( #$8404 )

  loc_018724:
    COP [17] ( &code_01876F )
    COP [91]
    COP [0D] ( #00, #2F, #32, &code_018750 )
    RTL 
}

code_018732 {
    COP [01] ( &shared_actor_helpers_bank3.asciistring_01B988+M )
    COP [91]
    COP [0D] ( #00, #26, #17, &code_018741 )
    BRA loc_0186E5
}

code_018741 {
    RTL 
}

code_018742 {
    COP [11] ( #08, #27, #17 )
    COP [15]
    COP [80] ( #00 )
    COP [82]
    BRA loc_018724
}

code_018750 {
    COP [07] ( #$9A00, &code_018763 )
    COP [01] ( &asciistring_0188FC )
    BRK #$5E
    COP [0A] ( #2A )
    COP [09] ( #$9A00 )
}

code_018763 {
    COP [91]
    RTL 
}

code_018766 {
    COP [01] ( &asciistring_01877B )
    COP [09] ( #$8001 )
    RTL 
}

code_01876F {
    COP [01] ( &asciistring_0187E0 )
    RTL 
}

code_018774 {
    COP [01] ( &asciistring_018836 )
    COP [86]
    RTL 
}

asciistring_01877B |[10]Rotating this wheel [N]will move the elevator[N]in the Underground [N]Castle- [FIN]I am too weak to turn [N]this wheel, will you [N]do it for me? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0187E0 |[10]Oh, no wonder! I was [N]turning it the wrong [N]way! [FIN]By the way, don t you [N]think this water mill [N]is great?! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018836 |[10][0E:3C]A man s voice came [N]from inside the water [N]mill- [FIN]DARN IT! [FIN]This stupid wheel! [N]It s so hard to turn! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018889 |[10]This is the wheel, [N]will you try to turn [N]it? [END]|

asciistring_0188A7 |[02:2] [N]turned the wheel- [FIN]As the wheel started [N]to turn, power was [N]transmitted to the [N]Underground Castle- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0188FC |[10]This is [03:24]the Master s [N]Emblem A- [03:20][JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_01891A {
    COP [14] ( #$000F, &code_018921 )
    RTL 
}

code_018921 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [AC] ( @code_01894A, #$0000, #$0010, #$2000 )
    COP [17] ( &code_018968 )

  loc_018935:
    COP [81] ( #1B, #02 )
    COP [83]
    COP [15]
    COP [81] ( #24, #04 )
    COP [83]
    COP [16]
    COP [87]
    BRL loc_018935
}

code_01894A {
    COP [07] ( #$8103, &code_018965 )
    COP [0D] ( #00, #34, #2C, &code_018958 )
    RTL 
}

code_018958 {
    COP [01] ( &asciistring_018A2B )
    BRK #$5E
    COP [0A] ( #38 )
    COP [09] ( #$8103 )
}

code_018965 {
    COP [86]
    RTL 
}

code_018968 {
    COP [14] ( #$0009, &code_018973 )
    COP [01] ( &asciistring_018978 )
    RTL 
}

code_018973 {
    COP [01] ( &asciistring_0189E0 )
    RTL 
}

asciistring_018978 |[10]I wonder why people [N]live in such small [N]houses? [FIN]Can you believe the [N]village Chief was [N]swallowed up in [FIN]one of the paintings [N]in the house on the [N]hill? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0189E0 |[10]I wonder why people [N]are living in such [N]small houses? [FIN]Can you believe that [N]the village Chief has [N]come back to life? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018A2B |[10]There is [03:24]a Medical [N]Herb [03:20]at the corner of [N]the fence- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_018A59 {
    COP [14] ( #$0010, &code_018A60 )
    RTL 
}

code_018A60 {
    COP [30] ( #$0010, &code_018BC3, #03 )
    COP [07] ( #$9F02, &code_018B28 )
    COP [18] ( #29, &code_018A75 )
    COP [86]
    RTL 
}

code_018A75 {
    COP [A0] ( #$FFF8 )
    COP [14] ( #$0009, &code_018B1C )
    COP [17] ( &code_018B7C )

  code_018A83:
    COP [07] ( #$8302, &code_018B0F )
    COP [07] ( #$8301, &code_018AF5 )
    COP [07] ( #$8207, &code_018AE8 )
    COP [07] ( #$8105, &code_018AE8 )
    COP [07] ( #$8104, &code_018AA9 )
    COP [80] ( #12 )
    COP [82]
    BRL code_018A83
}

code_018AA9 {
    LDA #$AF80
    TSB $joy_block_mask
    COP [80] ( #13 )
    COP [82]
    COP [80] ( #14 )
    COP [82]
    LDA #$AF80
    TRB $joy_block_mask
    COP [01] ( &asciistring_018C34 )
    COP [09] ( #$8105 )
    COP [91]
    COP [0D] ( #00, #37, #1F, &code_018AD8 )
    COP [0D] ( #00, #3A, #20, &code_018AD8 )
    RTL 
}

code_018AD8 {
    COP [01] ( &asciistring_018C5C )
    COP [09] ( #$8207 )
    COP [17] ( &code_018BA2 )
    COP [27] ( &code_018A83 )
}

code_018AE8 {
    COP [80] ( #14 )
    COP [82]
    COP [17] ( &code_018BA2 )
    COP [27] ( &code_018A83 )
}

code_018AF5 {
    COP [80] ( #14 )
    COP [82]
    COP [18] ( #1D, &code_018B07 )
    COP [17] ( &code_018BB0 )
    COP [27] ( &code_018A83 )
}

code_018B07 {
    COP [17] ( &code_018BAB )
    COP [27] ( &code_018A83 )
}

code_018B0F {
    COP [80] ( #14 )
    COP [82]
    COP [17] ( &code_018BB9 )
    COP [27] ( &code_018A83 )
}

code_018B1C {
    COP [80] ( #14 )
    COP [82]
    COP [17] ( &code_018BBE )
    COP [91]
    RTL 
}

code_018B28 {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [A0] ( #$FFF8 )
    COP [07] ( #$9F01, &code_018B5B )
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_018F85 )
    COP [03] ( #79 )
    COP [04]
    COP [3C] ( #04 )
    COP [10] ( #$0302, #01, #$0108, #$0348 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_018B5B {
    COP [34]
    COP [80] ( #13 )
    COP [82]
    COP [03] ( #5B )
    COP [04]
    COP [01] ( &asciistring_018FCD )
    COP [03] ( #F1 )
    COP [04]
    COP [10] ( #$0B00, #01, #$0000, #$0000 )
    COP [91]
    RTL 
}

code_018B7C {
    COP [07] ( #$8104, &code_018B9D )
    COP [19] ( #1C, &code_018B98 )
    COP [01] ( &asciistring_018C02 )
    COP [3C] ( #04 )
    COP [10] ( #$0302, #02, #$0120, #$0320 )
    RTL 
}

code_018B98 {
    COP [01] ( &asciistring_018C26 )
    RTL 
}

code_018B9D {
    COP [01] ( &asciistring_018C34 )
    RTL 
}

code_018BA2 {
    COP [01] ( &asciistring_018C98 )
    COP [09] ( #$8301 )
    RTL 
}

code_018BAB {
    COP [01] ( &asciistring_018D5D )
    RTL 
}

code_018BB0 {
    COP [01] ( &asciistring_018D61 )
    COP [09] ( #$8302 )
    RTL 
}

code_018BB9 {
    COP [01] ( &asciistring_018F15 )
    RTL 
}

code_018BBE {
    COP [01] ( &asciistring_018F19 )
    RTL 
}

code_018BC3 {
    COP [01] ( &asciistring_018BCA )
    COP [86]
    RTL 
}

asciistring_018BCA |[10][0E:3C]You hear some light [N]snoring coming from [N]inside the house- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018C02 |[10][02:2] placed [N]the Dream Rod on the [N]girl s head- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018C26 |[10]Zzzz----- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018C34 |[10]Oh, my! Who are you? [N]Get out of my house! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018C5C |[10]Wait! [N]I m sorry for yelling [N]at you- [FIN]Please come back and [N]listen to my story- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018C98 |[10]I had a very strange [N]dream- It was about my[N]father and someone who[N]looked just like you- [FIN]My father told me to [N]give his paintbrush to[N]you and tell you all I[N]know- [FIN][::]The brush is all [N]I have left from my [N]father- [N]I hid it somewhere- [FIN]When you come back to [N]me with that brush, I [N]will tell you all I [N]know- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018D5D |[10][JMP:&asciistring_018C98+M]|

asciistring_018D61 |[10]Oh! You have found my [N]father s paintbrush- I[N]will now tell you what[N]I know- [FIN]One day, as I returned[N]from shopping I [N]found a note- [FIN]Lisa pulled out the [N]note and began to [N]read- [FIN]"Lisa, I won t be able[N]to see you for a [N]while- [FIN]If you have any [N]problems, please see [N]the village Chief- [FIN]Take care of your [N]friends, [N]Turbo, the dog, [FIN]Lue, the dolphin, [FIN]Nome, the snail, [FIN]and Marie, the doll-ˮ [FIN]The animals mentioned [N]in the letter were [N]once my father s pets-[FIN]I don t understand [N]what he is trying to [N]say though- [FIN][::]I know you re a [N]complete stranger, but[N]will you please search[N]for my father? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018F15 |[10][JMP:&asciistring_018D61+M]|

asciistring_018F19 |[10]Some believe after a [N]person dies, they will[N]return in the form of [N]a different creature- [FIN]If this is true, I [N]wonder what my mother [N]is doing now? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018F85 |[10][0F]Lisa appears to be [N]sleeping- [N][0E:5A][02:2], placed [N]the Dream Rod upon [N]Lisa s head- [0E:78][JMP:&shared_actor_helpers_bank3.asciistring_01B988+M]|

asciistring_018FCD |[10][02:2], [N]promise me you will [N]return someday- [0E:B4][JMP:&shared_actor_helpers_bank3.asciistring_01B988+M]|
---------------------------------------------

code_018FF4 {
    COP [14] ( #$0011, &code_018FFB )
    RTL 
}

code_018FFB {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01900D )
    COP [15]

  loc_019006:
    COP [80] ( #1E )
    COP [82]
    BRA loc_019006
}

code_01900D {
    COP [18] ( #1C, &code_019017 )
    COP [01] ( &asciistring_01901C )
    RTL 
}

code_019017 {
    COP [01] ( &asciistring_019098 )
    RTL 
}

asciistring_01901C |[10]The Dream Rod you [N]possess is a magical [N]stick that enables you[N]to look into dreams- [FIN]Equip this stick when [N]you wish to speak with[N]someone who is [N]sleeping- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_019098 |[10]I have heard of a [N]strange stick that [N]enables anyone who [N]possesses it [FIN]to speak with those [N]that are asleep- It is[N]hidden in the [N]Underground Castle- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_01910C {
    COP [14] ( #$0012, &code_019113 )
    RTL 
}

code_019113 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_019121 )
    COP [15]
    COP [91]
    RTL 
}

code_019121 {
    COP [07] ( #$0107, &code_01912D )
    COP [07] ( #$0003, &code_01913A )
}

code_01912D {
    COP [01] ( &asciistring_01913F )
    COP [09] ( #$8107 )
    COP [09] ( #$8003 )
    RTL 
}

code_01913A {
    COP [01] ( &asciistring_01919A )
    RTL 
}

asciistring_01913F |[10]My name is Gaudi, I am[N]an architect- [FIN]I built all the houses[N]in this town- Come [N]back later, I will [N]show you something- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01919A |[10]What do you think of [N]these walls? [N]I am known to be a [N]fast builder! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_0191D2 {
    COP [3B] ( #$0016, &code_0191E8 )
    COP [17] ( &shared_actor_helpers_bank3.code_01B191 )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0191E8 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01922C )

  code_0191F1:
    COP [91]
    COP [20] ( &code_019228 )
    COP [9A] ( #$0000, &code_019201, &code_019228, &code_019216 )
}

code_019201 {
    COP [23] ( &code_01920E )
    COP [97]
    COP [9D] ( #11 )
    COP [9E] ( &code_01920E )
}

code_01920E {
    COP [80] ( #0C )
    COP [82]
    BRL code_019228
}

code_019216 {
    COP [24] ( &code_019223 )
    COP [96]
    COP [9D] ( #11 )
    COP [9E] ( &code_019223 )
}

code_019223 {
    COP [80] ( #0C )
    COP [82]
}

code_019228 {
    COP [27] ( &code_0191F1 )
}

code_01922C {
    COP [18] ( #19, &code_019236 )
    COP [01] ( &asciistring_01931F )
    RTL 
}

code_019236 {
    COP [01] ( &asciistring_019255 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_019241 )
}

code_019241 {
    COP [12] ( #05, &asciistring_018480 )
    COP [01] ( &asciistring_0192D9 )
    COP [12] ( #05, &code_018353 )
    BRK #$5E
    COP [0A] ( #19 )
    RTL 
}

asciistring_019255 |[10]I am helping my [N]mother-Would you like [N]to buy some goat s [N]food? [FIN]Do you want to know [N]how much it costs? [FIN]Well-------- [N][0E:1E]How about one billion [N]dollars plus tax?! [END]|

asciistring_0192D9 |[10]TEDDY!! [N]I m sorry, I will give[N]it to you for free- [FIN][02:2] received [N][03:24]a bag of goat s food[03:20]!![JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01931F |[10]Oh, you don t need [N]many bags of goat s [N]food, [FIN]return here after you [N]have used the one [N]I have given you- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_019365 {
    COP [14] ( #$0018, &code_01936C )
    RTL 
}

code_01936C {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01937E )
    COP [15]

  loc_019377:
    COP [80] ( #1E )
    COP [82]
    BRA loc_019377
}

code_01937E {
    COP [07] ( #$8104, &code_019389 )
    COP [01] ( &asciistring_01938E )
    RTL 
}

code_019389 {
    COP [01] ( &asciistring_0193FB )
    RTL 
}

asciistring_01938E |[10]I wonder who placed [N]the boundary between [N]dreams and reality? [FIN]Sometimes things that [N]happen in dreams come [N]true in reality- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0193FB |[10]You remember Lisa s, [N]dream right? Have you [N]returned to the place [N]you saw in her dream? [FIN]Things may be [N]different from when [N]you saw her before- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|