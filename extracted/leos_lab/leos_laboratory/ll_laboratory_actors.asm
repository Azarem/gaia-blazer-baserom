?BANK 04

?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'll_watching_over_world_return_prompt_texts'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!joy_pressed                    0322
!joy_block_mask                 0326
!asset_skip_mask                03B4
!souls_flags                    1B82

---------------------------------------------

code_022523 {
    COP [14] ( #$0137, &code_02252A )
    RTL 
}

code_02252A {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [A2] ( #30 )
    COP [17] ( &code_02254C )
    COP [91]
    COP [80] ( #08 )
    COP [82]
    RTL 
}

code_022540 {
    COP [17] ( &code_022554 )
    COP [91]
    COP [80] ( #05 )
    COP [82]
    RTL 
}

code_02254C {
    COP [01] ( &asciistring_022559 )
    COP [27] ( &code_022540 )
}

code_022554 {
    COP [01] ( &asciistring_022596 )
    RTL 
}

asciistring_022559 |[10]My back hurts because [N]I have been sitting [N]too long- [FIN]I should get up and [N]exercise- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_022596 |[10]It scares people when [N]we move- [N]But we are just [N]exercising- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_0225C4 {
    COP [14] ( #$0112, &code_0225CB )
    RTL 
}

code_0225CB {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0225FA )
    BRL loc_0225DE

  loc_0225D7:
    BRK #$43
    COP [80] ( #02 )
    COP [82]

  loc_0225DE:
    COP [91]
    COP [0C] ( #00, #02, &code_0225E7 )
    RTL 
}

code_0225E7 {
    BRK #$43
    COP [80] ( #01 )
    COP [82]
    COP [91]
    COP [0C] ( #00, #02, &code_0225F9 )
    BRL loc_0225D7
}

code_0225F9 {
    RTL 
}

code_0225FA {
    COP [01] ( &asciistring_0225FF )
    RTL 
}

asciistring_0225FF |[10]--------- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_02260D {
    COP [14] ( #$011A, &code_022614 )
    RTL 
}

code_022614 {
    COP [07] ( #$8800, &code_02265C )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_022678 )
    COP [15]

  loc_022625:
    COP [91]
    COP [0D] ( #00, #0B, #0D, &code_02262F )
    RTL 
}

code_02262F {
    COP [19] ( #27, &code_022645 )
    COP [01] ( &asciistring_0226AC )
    COP [09] ( #$8800 )
    COP [17] ( #$0000 )
    COP [16]
    BRL code_02265C
}

code_022645 {
    COP [01] ( &asciistring_02267D )
    COP [91]
    COP [0D] ( #00, #0B, #0D, &code_022654 )
    BRA loc_022625
}

code_022654 {
    RTL 
}

code_022655 {
    BRK #$43
    COP [80] ( #02 )
    COP [82]
}

code_02265C {
    COP [91]
    COP [0C] ( #00, #02, &code_022665 )
    RTL 
}

code_022665 {
    BRK #$43
    COP [80] ( #01 )
    COP [82]
    COP [91]
    COP [0C] ( #00, #02, &code_022677 )
    BRL code_022655
}

code_022677 {
    RTL 
}

code_022678 {
    COP [01] ( &asciistring_02267D )
    RTL 
}

asciistring_02267D |[10]My body is locked- [FIN]There should be a key [N]somewhere in the [N]laboratory- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_0226AC |[10][02:2] used [N]the door key- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_0226C0 {
    COP [14] ( #$0129, &code_0226C7 )
    RTL 
}

code_0226C7 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0226F7 )
    COP [07] ( #$0605, &code_0226DC )
    COP [07] ( #$8606, &code_0226E4 )
}

code_0226DC {
    COP [15]
    COP [05] ( #$0002 )
    COP [16]
}

code_0226E4 {
    COP [96]
    COP [80] ( #0F )
    COP [82]
    COP [97]
    COP [80] ( #0C )
    COP [82]
    COP [15]
    COP [91]
    RTL 
}

code_0226F7 {
    COP [07] ( #$0605, &code_022703 )
    COP [07] ( #$8606, &code_022708 )
}

code_022703 {
    COP [01] ( &asciistring_022711 )
    RTL 
}

code_022708 {
    COP [01] ( &asciistring_022750 )
    COP [09] ( #$8002 )
    RTL 
}

asciistring_022711 |[10]Would you please take [N]the cats out of the [N]room? [FIN]I am too scared to [N]move around with them [N]in here- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_022750 |[10]Thank you very much- [N]Now I can walk around [N]the room freely- [FIN]Let me give you [N]something- [N]Please come inside- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_022794 {
    COP [14] ( #$0114, &code_02279B )
    RTL 
}

code_02279B {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02282A )
    COP [07] ( #$8605, &code_022817 )
    COP [15]

  loc_0227AC:
    COP [19] ( #26, &code_0227B7 )
    COP [0C] ( #00, #02, &code_0227BE )
}

code_0227B7 {
    COP [80] ( #13 )
    COP [82]
    BRA loc_0227AC
}

code_0227BE {
    COP [91]
    COP [17] ( &code_02282F )

  code_0227C4:
    COP [0D] ( #05, #16, #10, &code_022809 )
    COP [9C] ( &code_0227D1, &code_0227ED )
}

code_0227D1 {
    COP [9A] ( #$0010, &code_0227DB, &code_0227ED, &code_0227E4 )
}

code_0227DB {
    COP [97]
    COP [80] ( #12 )
    COP [82]
    BRA code_0227C4
}

code_0227E4 {
    COP [96]
    COP [80] ( #12 )
    COP [82]
    BRA code_0227C4
}

code_0227ED {
    COP [9B] ( #$0010, &code_0227F7, &code_022805, &code_0227FE )
}

code_0227F7 {
    COP [80] ( #11 )
    COP [82]
    BRA code_0227C4
}

code_0227FE {
    COP [80] ( #10 )
    COP [82]
    BRA code_0227C4
}

code_022805 {
    COP [27] ( &code_0227C4 )
}

code_022809 {
    COP [97]
    COP [81] ( #12, #02 )
    COP [83]
    COP [09] ( #$8605 )
    BRA loc_02281C
}

code_022817 {
    COP [11] ( #05, #14, #11 )

  loc_02281C:
    COP [17] ( &code_02282F )
    COP [15]
    COP [91]
    COP [80] ( #13 )
    COP [82]
    RTL 
}

code_02282A {
    COP [01] ( &asciistring_022834 )
    RTL 
}

code_02282F {
    COP [01] ( &asciistring_02286C )
    RTL 
}

asciistring_022834 |[10]We don t really [N]like to chase rats- [FIN]Cats just have to eat [N]in order to live- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_02286C |[10]What a pleasant smell- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_022886 {
    COP [14] ( #$010D, &code_02288D )
    RTL 
}

code_02288D {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_022923 )
    COP [07] ( #$8606, &code_022910 )

  loc_02289C:
    COP [19] ( #26, &code_0228A7 )
    COP [0C] ( #00, #02, &code_0228AE )
}

code_0228A7 {
    COP [80] ( #14 )
    COP [82]
    BRA loc_02289C
}

code_0228AE {
    COP [91]
    COP [96]
    COP [80] ( #1A )
    COP [82]
    COP [17] ( &code_022928 )

  code_0228BB:
    COP [91]
    COP [0D] ( #06, #16, #10, &code_022902 )
    COP [9C] ( &code_0228CA, &code_0228E6 )
}

code_0228CA {
    COP [9A] ( #$0010, &code_0228D4, &code_0228E6, &code_0228DD )
}

code_0228D4 {
    COP [97]
    COP [80] ( #12 )
    COP [82]
    BRA code_0228BB
}

code_0228DD {
    COP [96]
    COP [80] ( #12 )
    COP [82]
    BRA code_0228BB
}

code_0228E6 {
    COP [9B] ( #$0010, &code_0228F0, &code_0228FE, &code_0228F7 )
}

code_0228F0 {
    COP [80] ( #11 )
    COP [82]
    BRA code_0228BB
}

code_0228F7 {
    COP [80] ( #10 )
    COP [82]
    BRA code_0228BB
}

code_0228FE {
    COP [27] ( &code_0228BB )
}

code_022902 {
    COP [96]
    COP [81] ( #12, #02 )
    COP [83]
    COP [09] ( #$8606 )
    BRA loc_022915
}

code_022910 {
    COP [11] ( #06, #18, #11 )

  loc_022915:
    COP [17] ( &code_022928 )
    COP [15]
    COP [91]
    COP [80] ( #13 )
    COP [82]
    RTL 
}

code_022923 {
    COP [01] ( &asciistring_02292D )
    RTL 
}

code_022928 {
    COP [01] ( &asciistring_02296A )
    RTL 
}

asciistring_02292D |[10]This is Dr-Leo s [N]Laboratory- [FIN]This house has a [N]second floor and an [N]attic- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_02296A |[10]What a good smell- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_02297C {
    COP [14] ( #$011B, &code_022983 )
    RTL 
}

code_022983 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_022994 )
    COP [91]
    COP [80] ( #15 )
    COP [82]
    RTL 
}

code_022994 {
    COP [01] ( &asciistring_022999 )
    RTL 
}

asciistring_022999 |[10]Doors are usually [N]quiet, but there are [N]some talkative ones- [FIN]Try and talk to all of[N]them- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_0229DF {
    COP [14] ( #$010C, &code_0229E6 )
    RTL 
}

code_0229E6 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_022A69 )
    COP [15]

  code_0229F1:
    COP [91]
    COP [03] ( #02 )
    COP [80] ( #08 )
    COP [82]
    LDA $joy_pressed
    AND #$0200
    BEQ loc_022A2E
    COP [0D] ( #00, #04, #10, &code_022A0C )
    BRA loc_022A2E
}

code_022A0C {
    COP [04]
    LDA #$2F80
    TSB $joy_block_mask
    COP [16]
    COP [81] ( #1D, #10 )
    COP [83]
    COP [15]
    LDA #$2F80
    TRB $joy_block_mask
    COP [91]
    COP [0D] ( #00, #03, #10, &code_022A32 )
    RTL 

  loc_022A2E:
    COP [27] ( &code_0229F1 )
}

code_022A32 {
    COP [07] ( #$9A06, &code_022A45 )
    COP [01] ( &asciistring_022ADC )
    BRK #$5E
    COP [0A] ( #30 )
    COP [09] ( #$9A06 )
}

code_022A45 {
    COP [91]
    RTL 
}

code_022A48 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [80] ( #1B )
    COP [82]
    COP [01] ( &asciistring_022A9D )
    BRK #$5E
    COP [0A] ( #0D )
    COP [80] ( #1C )
    COP [82]
    LDA #$2F80
    TRB $joy_block_mask
    BRA code_0229F1
}

code_022A69 {
    COP [18] ( #0D, &code_022A73 )
    COP [01] ( &asciistring_022AB8 )
    RTL 
}

code_022A73 {
    COP [01] ( &asciistring_022A7B )
    COP [27] ( &code_022A48 )
}

asciistring_022A7B |[10]Take the Mystic Armor [N]from my drawer- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_022A9D |[10][02:2] received [N][03:24]Mystic Armor- [03:20][JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_022AB8 |[10]My body is made from [N]the trees in [N]GreenWood- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_022ADC |[10][02:2] found [N][03:24]Master s Emblem G- [03:20][JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_022AFB {
    COP [14] ( #$0139, &code_022B02 )
    RTL 
}

code_022B02 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_022B15 )
    COP [15]
    COP [91]
    COP [80] ( #03 )
    COP [82]
    RTL 
}

code_022B15 {
    COP [01] ( &asciistring_022B1A )
    RTL 
}

asciistring_022B1A |[10]If the soul of the [N]Great Door joins you, [FIN]you will be able to [N]see the invisible [N]enemies in the models [N]of town- [FIN]Listen to what the cat[N]says- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_022B80 {
    COP [14] ( #$0109, &code_022B87 )
    RTL 
}

code_022B87 {
    COP [15]
    COP [17] ( &code_022B9E )
    COP [A0] ( #$FFFC )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [91]
    COP [80] ( #03 )
    COP [82]
    RTL 
}

code_022B9E {
    COP [01] ( &asciistring_022BC8 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_022BC3 )
    LDA $L_choice_result
    BNE code_022BC3
    COP [18] ( #38, &code_022BB9 )
    COP [01] ( &asciistring_022C21 )
    RTL 
}

code_022BB9 {
    COP [01] ( &asciistring_022BE2 )
    BRK #$5E
    COP [0A] ( #38 )
    RTL 
}

code_022BC3 {
    COP [01] ( &asciistring_022C55 )
    RTL 
}

asciistring_022BC8 |[10]Would you like [N]a Medical Herb? [END]|

asciistring_022BE2 |[10]Take any leaves that [N]you want from my body-[FIN]OUCH! [FIN][02:2] received [N][03:24]a Medical Herb- [03:20][JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_022C21 |[10]Medical Herbs are part[N]of my body- I cannot [N]give many at one time-[JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_022C55 |[10]Oh, really? Come and [N]ask me when you are in[N]trouble- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_022C7C {
    COP [14] ( #$010B, &code_022C83 )
    RTL 
}

code_022C83 {
    COP [15]
    COP [A0] ( #$FFFC )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_022C9A )
    COP [91]
    COP [80] ( #03 )
    COP [82]
    RTL 
}

code_022C9A {
    COP [01] ( &asciistring_022C9F )
    RTL 
}

asciistring_022C9F |[10]The room on the second[N]floor is Dr-Leo s- [FIN]There were two models [N]of town in his room- [FIN]Many creatures were [N]swallowed into the [N]models- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_022D05 {
    COP [14] ( #$014A, &code_022D0C )
    RTL 
}

code_022D0C {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_022D63 )
    COP [15]
    COP [05] ( #$0000 )
    COP [16]
    COP [9A] ( #$0000, &code_022D27, &code_022D27, &code_022D37 )
}

code_022D27 {
    COP [96]
    COP [80] ( #0F )
    COP [82]
    COP [97]
    COP [80] ( #0C )
    COP [82]
    BRA loc_022D45
}

code_022D37 {
    COP [97]
    COP [80] ( #0F )
    COP [82]
    COP [96]
    COP [80] ( #0C )
    COP [82]

  loc_022D45:
    COP [15]
    COP [91]
    COP [0D] ( #00, #14, #05, &code_022D51 )
    RTL 
}

code_022D51 {
    LDA $joy_pressed
    AND #$0800
    BNE loc_022D5A
    RTL 

  loc_022D5A:
    COP [01] ( &asciistring_022D98 )
    COP [37]
    COP [91]
    RTL 
}

code_022D63 {
    COP [01] ( &asciistring_022D6C )
    COP [09] ( #$8000 )
    RTL 
}

asciistring_022D6C |[10]I am a devout mouse, [N]stand here and you [N]will be purified- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_022D98 |[10][02:2], [N]felt his body and mind[N]become purified- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_022DC6 {
    COP [14] ( #$0120, &code_022DCD )
    RTL 
}

code_022DCD {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_022DFC )
    BRL loc_022DE0

  loc_022DD9:
    BRK #$43
    COP [80] ( #02 )
    COP [82]

  loc_022DE0:
    COP [91]
    COP [0C] ( #00, #02, &code_022DE9 )
    RTL 
}

code_022DE9 {
    BRK #$43
    COP [80] ( #01 )
    COP [82]
    COP [91]
    COP [0C] ( #00, #02, &code_022DFB )
    BRL loc_022DD9
}

code_022DFB {
    RTL 
}

code_022DFC {
    COP [01] ( &asciistring_022E01 )
    RTL 
}

asciistring_022E01 |[10]---------- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_022E10 {
    COP [14] ( #$0142, &code_022E17 )
    RTL 
}

code_022E17 {
    COP [30] ( #$0142, &code_022E7E, #04 )
    COP [07] ( #$8603, &code_022E53 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_022E60 )
    BRL loc_022E37

  loc_022E30:
    BRK #$43
    COP [80] ( #02 )
    COP [82]

  loc_022E37:
    COP [91]
    COP [0C] ( #00, #02, &code_022E40 )
    RTL 
}

code_022E40 {
    BRK #$43
    COP [80] ( #01 )
    COP [82]
    COP [91]
    COP [0C] ( #00, #02, &code_022E52 )
    BRL loc_022E30
}

code_022E52 {
    RTL 
}

code_022E53 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [80] ( #1F )
    COP [82]
    COP [91]
    RTL 
}

code_022E60 {
    COP [01] ( &asciistring_022EEE )
    COP [09] ( #$8603 )
    BRK #$4E
    SEP #$20
    LDA $souls_flags
    ORA #$08
    STA $souls_flags
    REP #$20
    COP [17] ( #$0000 )
    COP [27] ( &code_022E53 )
}

code_022E7E {
    COP [01] ( &asciistring_022E85 )
    COP [86]
    RTL 
}

asciistring_022E85 |[10][0E:3C][02:2] hears [N]the door [N]speaking to itself- [FIN]I can see------ [FIN]I can see machines [N]throwing bombs inside [N]the model towns- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_022EEE |[10]Even though I don t [N]look like it, I am [N]from the sky just like[N]you- [FIN]Let me join you- [FIN]The soul that enables [N]you to see invisible [N]enemies in model towns[N]joins you- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_022F68 {
    COP [14] ( #$0126, &code_022F6F )
    RTL 
}

code_022F6F {
    COP [30] ( #$0126, &code_022FF3, #04 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_022FCD )
    COP [15]
    COP [07] ( #$8802, &code_022FC5 )
    COP [91]
    COP [0D] ( #00, #09, #0A, &code_022F91 )
    RTL 
}

code_022F91 {
    COP [07] ( #$0801, &code_022FC2 )
    COP [17] ( #$0000 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [80] ( #13 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_02306C )
    BRK #$5E
    COP [0A] ( #27 )
    COP [09] ( #$8802 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [17] ( &code_022FCD )
}

code_022FC2 {
    COP [91]
    RTL 
}

code_022FC5 {
    COP [91]
    COP [80] ( #13 )
    COP [82]
    RTL 
}

code_022FCD {
    COP [07] ( #$8802, &code_022FEE )
    COP [19] ( #1C, &code_022FE9 )
    COP [01] ( &asciistring_023049 )
    COP [3C] ( #04 )
    COP [10] ( #$050D, #01, #$00C0, #$0010 )
    RTL 
}

code_022FE9 {
    COP [01] ( &asciistring_02303F )
    RTL 
}

code_022FEE {
    COP [01] ( &asciistring_0230FA )
    RTL 
}

code_022FF3 {
    COP [01] ( &asciistring_022FFA )
    COP [86]
    RTL 
}

asciistring_022FFA |[10][0E:3C]The cat is sleeping- [N]He looks as though he [N]is suffering- [FIN]Uh, uh, Dr-Leo? [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_02303F |[10]Zzzzz [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_023049 |[10][02:2] places [N]the Dream Rod on the [N]cat s head- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_02306C |[10]Lately, I always see [N]Dr-Leo in my dreams- [FIN]I was scared when he [N]was taken away- [N]I had been hiding [N]under the table- [FIN]Oh yes, I will give [N]you this- [N]Dr-Leo left this- [FIN][02:2] received [N][03:24]a door key- [03:20][JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_0230FA |[10]There are invisible [N]enemies in the models [N]town- [N]Please be careful- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_02312F {
    COP [14] ( #$013E, &code_023136 )
    RTL 
}

code_023136 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_023144 )
    COP [15]
    COP [91]
    RTL 
}

code_023144 {
    COP [01] ( &asciistring_023149 )
    RTL 
}

asciistring_023149 |[10]Use magic to defeat [N]the enemies which you [N]cannot reach- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_02317F {
    COP [14] ( #$014D, &code_023186 )
    RTL 
}

code_023186 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_023199 )
    COP [15]
    COP [91]
    COP [80] ( #03 )
    COP [82]
    RTL 
}

code_023199 {
    COP [18] ( #26, &code_0231A3 )
    COP [01] ( &asciistring_023200 )
    RTL 
}

code_0231A3 {
    COP [01] ( &asciistring_0231AD )
    BRK #$5E
    COP [0A] ( #26 )
    RTL 
}

asciistring_0231AD |[10]I am an Actinidia- [N]Take some of my leaves[N]if you want- [FIN]OUCH! [FIN][02:2] received [N][03:24]Actinidia leaves- [03:20][JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_023200 |[10]I am happy to help [N]you- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_023214 {
    COP [14] ( #$0136, &code_02321B )
    RTL 
}

code_02321B {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02322E )
    COP [15]
    COP [91]
    COP [80] ( #18 )
    COP [82]
    RTL 
}

code_02322E {
    COP [01] ( &asciistring_023233 )
    RTL 
}

asciistring_023233 |[10]The large machines in [N]the basement were the [N]machines which [N]summoned evil- [FIN]They were made by [N]Dr-Leo- [FIN]When those machines [N]started to move, the [N]cities were destroyed-[JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_0232B3 {
    COP [14] ( #$014C, &code_0232BA )
    RTL 
}

code_0232BA {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0232CD )
    COP [15]
    COP [91]
    COP [80] ( #07 )
    COP [82]
    RTL 
}

code_0232CD {
    COP [07] ( #$8807, &code_0232FF )
    COP [18] ( #38, &code_0232FA )
    COP [01] ( &asciistring_023317 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_0232F5 )
    LDA $L_choice_result
    BNE code_0232F5
    COP [01] ( &asciistring_0233D0 )
    COP [0B] ( #38 )
    COP [09] ( #$8807 )
    RTL 
}

code_0232F5 {
    COP [01] ( &asciistring_0233B1 )
    RTL 
}

code_0232FA {
    COP [01] ( &asciistring_023374 )
    RTL 
}

code_0232FF {
    COP [18] ( #38, &code_023309 )
    COP [01] ( &asciistring_02342E )
    RTL 
}

code_023309 {
    COP [01] ( &asciistring_023403 )
    BRK #$5E
    COP [0A] ( #38 )
    COP [09] ( #$0807 )
    RTL 
}

asciistring_023317 |[10]If there s nothing in[N]a chest then the chest[N]is good for nothing- [FIN]Would you store your [N]Medical Herbs in my [N]drawer? [END]|

asciistring_023374 |[10]If there s nothing [N]in a chest, [N]a chest doesn t mean [N]anything- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_0233B1 |I am the happiest [N]chest in the world- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_0233D0 |[02:2] put [N]his Medical Herbs [N]in the drawer- [FIN]I am satisfied- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_023403 |[10]Are you taking them [N]out? Well, it s okay- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_02342E |[10]You have a Medical [N]Herb- I will give [N]them back to you when [N]you have run out- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_02345D {
    COP [14] ( #$0153, &code_023464 )
    RTL 
}

code_023464 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_023477 )
    COP [15]
    COP [91]
    COP [80] ( #15 )
    COP [82]
    RTL 
}

code_023477 {
    COP [01] ( &asciistring_02347C )
    RTL 
}

asciistring_02347C |[10]This room belongs to a[N]doll named Marie- [FIN]She told me many [N]things about foreign [N]towns- [FIN]A girl named Lisa took[N]care of Marie- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_0234EC {
    COP [14] ( #$012F, &code_0234F3 )
    RTL 
}

code_0234F3 {
    COP [30] ( #$012F, &code_023558, #04 )
    COP [07] ( #$9F02, &code_023513 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02353F )
    COP [15]
    COP [91]
    COP [80] ( #18 )
    COP [82]
    RTL 
}

code_023513 {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_023675 )
    COP [03] ( #5B )
    COP [04]
    LDA #$0020
    STA $asset_skip_mask
    COP [10] ( #$010A, #01, #$0100, #$0380 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_02353F {
    COP [07] ( #$9B04, &code_023553 )
    COP [01] ( &asciistring_0235AC )
    BRK #$5E
    COP [0A] ( #3E )
    COP [09] ( #$9B04 )
    RTL 
}

code_023553 {
    COP [01] ( &asciistring_023644 )
    RTL 
}

code_023558 {
    COP [01] ( &asciistring_023561 )
    COP [37]
    COP [86]
    RTL 
}

asciistring_023561 |[10][0E:3C]I am Marie, the doll- [N]I have [03:24]a Purple Stone [N][03:20]in my pocket- [FIN]Take this with you and[N]save Dr-Leo- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_0235AC |[10]Nobody can break a [N]promise that is made [N]with Evil- [FIN]There will be no [N]revival of the world [N]unless Deathtoll is [N]defeated- [FIN]Dr-Leo must be [N]somewhere in the [N]Magridd Castle- [FIN]Here, take this stone [N]from my pocket and go [N]to the Magridd Castle- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_023644 |[10]I wonder how Lisa is, [N]I want to see her [N]after the world is [N]revived- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_023675 |[10][0F][02:2], [N]you made it- [N][0E:3C]Dr-Leo can pass away [N]peacefully- [N][0E:5A]We tools, exist to be [N]used by human beings- [N][0E:5A]We are happy if we re [N]helpful to the humans-[N][0E:3C]And we hurt if they [N]use us in the wrong [N]way- [N][0E:5A]Even though we would [N]like to tell them not [N]to use us the wrong [N]way, we cannot- [N][0E:3C]This is very painful- [N][0E:5A]But Dr-Leo understood[N]our feelings- [N][0E:5A]The tools Dr-Leo used[N]must have been happy- [0E:78][JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3+M]|
---------------------------------------------

code_0237A7 {
    COP [14] ( #$0152, &code_0237AE )
    RTL 
}

code_0237AE {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0237DB )
    COP [81] ( #1E, #08 )
    COP [83]

  loc_0237BD:
    COP [81] ( #0D, #02 )
    COP [83]
    COP [96]
    COP [81] ( #0F, #03 )
    COP [83]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [97]
    COP [81] ( #0F, #03 )
    COP [83]
    BRA loc_0237BD
}

code_0237DB {
    COP [01] ( &asciistring_0237E0 )
    RTL 
}

asciistring_0237E0 |[10]We are weak and timid [N]animals- [FIN]Don t you think it s [N]unfair the weaker [N]creatures are defeated[N]first? [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_02382D {
    COP [14] ( #$013B, &code_023834 )
    RTL 
}

code_023834 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_023861 )
    COP [81] ( #1E, #08 )
    COP [83]

  loc_023843:
    COP [81] ( #0E, #02 )
    COP [83]
    COP [97]
    COP [81] ( #0F, #03 )
    COP [83]
    COP [81] ( #0D, #02 )
    COP [83]
    COP [96]
    COP [81] ( #0F, #03 )
    COP [83]
    BRA loc_023843
}

code_023861 {
    COP [01] ( &asciistring_023866 )
    RTL 
}

asciistring_023866 |[10]I would have liked to [N]have been born a [N]plant- [FIN]I would not fear [N]anything- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_0238A7 {
    COP [14] ( #$013C, &code_0238AE )
    RTL 
}

code_0238AE {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0238D3 )
    COP [15]

  loc_0238B9:
    COP [0C] ( #00, #04, &code_0238C6 )
    COP [80] ( #0C )
    COP [82]
    BRA loc_0238B9
}

code_0238C6 {
    COP [80] ( #1E )
    COP [82]
    COP [0C] ( #00, #04, &code_0238C6 )
    BRA loc_0238B9
}

code_0238D3 {
    COP [07] ( #$0605, &code_0238DF )
    COP [07] ( #$8606, &code_0238E4 )
}

code_0238DF {
    COP [01] ( &asciistring_0238F8 )
    RTL 
}

code_0238E4 {
    COP [18] ( #15, &code_0238EE )
    COP [01] ( &asciistring_023976 )
    RTL 
}

code_0238EE {
    COP [01] ( &asciistring_023921 )
    BRK #$5E
    COP [0A] ( #15 )
    RTL 
}

asciistring_0238F8 |[10]We cannot walk [N]around outside because[N]of the cats- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_023921 |[10]Thank you for getting [N]rid of the cats- [FIN]Take this magic, the [N]Magic of Spark Bomb- [FIN][02:2] received [N][03:24]Spark Bomb- [03:20][JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_023976 |[10]It is not easy to hit [N]the enemies with Spark[N]Bomb, but if you do, [N]it works very well- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_0239BA {
    COP [14] ( #$011E, &code_0239C1 )
    RTL 
}

code_0239C1 {
    COP [17] ( &code_0239C8 )
    COP [91]
    RTL 
}

code_0239C8 {
    COP [01] ( &asciistring_0239D6 )
    COP [10] ( #$010F, #01, #$01F8, #$03E0 )
    RTL 
}

asciistring_0239D6 |[10][0F][02:2] is [N]swallowed into the [N]model- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_0239F8 {
    COP [14] ( #$0145, &code_0239FF )
    RTL 
}

code_0239FF {
    COP [17] ( &code_023A06 )
    COP [91]
    RTL 
}

code_023A06 {
    COP [01] ( &asciistring_023A14 )
    COP [10] ( #$020F, #01, #$01F8, #$03E0 )
    RTL 
}

asciistring_023A14 |[10][0F][02:2] is [N]swallowed into the [N]model- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_023A36 {
    COP [07] ( #$8600, &code_023A4C )
    COP [17] ( &code_023A68 )
    COP [15]
    COP [91]
    RTL 
}

code_023A45 {
    BRK #$43
    COP [80] ( #02 )
    COP [82]
}

code_023A4C {
    COP [91]
    COP [0C] ( #00, #02, &code_023A55 )
    RTL 
}

code_023A55 {
    BRK #$43
    COP [80] ( #01 )
    COP [82]
    COP [91]
    COP [0C] ( #00, #02, &code_023A67 )
    BRL code_023A45
}

code_023A67 {
    RTL 
}

code_023A68 {
    COP [01] ( &asciistring_023A7A )
    COP [09] ( #$8600 )
    COP [16]
    COP [17] ( #$0000 )
    COP [27] ( &code_023A4C )
}

asciistring_023A7A |[10]This is Dr-Leo s [N]laboratory- [FIN]There are machines [N]lurking around here [N]which only the [N]powerful [FIN]Zantetsu Sword can [N]defeat- [FIN]First of all, talk to [N]a certain door to get [N]you into the room- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_023B0B {
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #02 )
    COP [04]
    COP [34]
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_023B65 )
    COP [03] ( #15 )
    COP [04]
    COP [96]
    COP [80] ( #23 )
    COP [82]
    COP [01] ( &asciistring_023B88 )
    COP [09] ( #$8000 )
    COP [05] ( #$0001 )
    COP [01] ( &asciistring_023C8F )
    COP [09] ( #$8002 )
    COP [05] ( #$0003 )
    COP [80] ( #1F )
    COP [82]
    COP [01] ( &asciistring_023D13 )
    COP [09] ( #$8801 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [3C] ( #04 )
    COP [10] ( #$020D, #01, #$0090, #$00A0 )
    RTL 
}

asciistring_023B65 |[10]Dr-Leo, King Magridd [N]wishes to see you at [N]once! [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_023B88 |[10]Are you going to allow[N]him to make a deal [N]with Deathtoll? [FIN]King Magridd knows [N]nothing about the [N]value of human lives! [FIN]No matter how small, [N]all creatures have a [N]right to exist in this[N]world- [FIN]If the trees in this [N]world were cut in [N]half, [FIN]the oxygen would [N]decrease and many of [N]us would die- [FIN][10]We do what King [N]Magridd tells us to [N]do- [FIN]King Magridd makes all[N]of the decisions for [N]us- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_023C8F |[10]Dr-Leo, you love your[N]daughter Lisa don t [N]you? [FIN]If you obey, she will [N]remain safe- [FIN]We will be waiting for[N]you outside in the [N]airship- [FIN]Come out when you are [N]ready- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_023D13 |[10]Please forgive me! [FIN]The world will go to [N]ruin sooner or later- [FIN]But I can do nothing [N]more- [FIN]Oh, Master! Please [N]help me- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

code_023D6B {
    COP [05] ( #$0002 )
    COP [96]
    COP [81] ( #17, #04 )
    COP [83]
    COP [81] ( #15, #05 )
    COP [83]
    COP [09] ( #$8003 )
    COP [86]
    RTL 
}
---------------------------------------------

code_023D84 {
    COP [05] ( #$0000 )
    BRK #$43
    COP [81] ( #16, #04 )
    COP [83]
    COP [97]
    COP [81] ( #17, #03 )
    COP [83]
    COP [01] ( &asciistring_023DBC )
    COP [03] ( #1F )
    COP [04]
    COP [09] ( #$8001 )
    COP [05] ( #$0002 )
    COP [96]
    COP [81] ( #17, #03 )
    COP [83]
    COP [81] ( #15, #05 )
    COP [83]
    BRK #$43
    COP [86]
    RTL 
}

asciistring_023DBC |[10]Hey, it s time to go- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|