?BANK 03

?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'gw_watching_over_world_return_prompt_texts'
?INCLUDE 'gw_woods_actors_01D045'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!joy_block_mask                 0326
!scroll_bg1_y                   033C
!asset_skip_mask                03B4
!asset_cache_tilemap1           0419
!text_delay                     1B84
!APUIO0                         2140

---------------------------------------------

code_01B98D {
    COP [14] ( #$0056, &code_01B994 )
    RTL 
}

code_01B994 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01BA28 )

  loc_01B99D:
    COP [80] ( #0E )
    COP [82]
    COP [15]
    COP [1B] ( &code_01B9AA, #$0078 )
}

code_01B9AA {
    COP [16]
    COP [9F] ( #$0008 )
    COP [1E] ( #$EFFF )
    COP [81] ( #0F, #04 )
    COP [83]
    COP [1D] ( #$1000 )
    COP [9F] ( #$FFF8 )
    COP [81] ( #11, #03 )
    COP [83]
    COP [9D] ( #11 )
    COP [9E] ( &code_01B9CF )
}

code_01B9CF {
    COP [15]
    COP [1B] ( &code_01B9D7, #$0078 )
}

code_01B9D7 {
    COP [16]
    COP [9F] ( #$0008 )
    COP [81] ( #10, #02 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [80] ( #0E )
    COP [82]
    COP [15]
    COP [1B] ( &code_01B9F4, #$0078 )
}

code_01B9F4 {
    COP [16]
    COP [9F] ( #$0008 )
    COP [81] ( #10, #03 )
    COP [83]
    COP [87]
    COP [9F] ( #$FFF8 )
    COP [81] ( #11, #03 )
    COP [83]
    COP [9D] ( #11 )
    COP [9E] ( &code_01BA13 )
}

code_01BA13 {
    COP [87]
    COP [9F] ( #$0008 )
    COP [80] ( #0F )
    COP [82]
    COP [9F] ( #$FFF8 )
    BRL loc_01B99D

  loc_01BA25:
    COP [91]
    RTL 
}

code_01BA28 {
    COP [01] ( &asciistring_01BA6B )

  loc_01BA2C:
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_01BA64 )
    LDA $L_choice_result
    BNE code_01BA64
    COP [01] ( &asciistring_01BAAA )
    LDA #$0000
    STA $APUIO0
    LDA $text_delay
    PHA 
    LDA #$0005
    STA $text_delay
    COP [01] ( &asciistring_01BAD8 )
    PLA 
    STA $text_delay
    COP [01] ( &asciistring_01BAE1 )
    LDA #$0001
    STA $APUIO0
    COP [01] ( &asciistring_01BB03 )
    RTL 
}

code_01BA64 {
    COP [01] ( &asciistring_01BA8F )
    BRL loc_01BA2C
}

asciistring_01BA6B |[10]This is a restaurant- [N][::]Would you like to see [N]the menu? [END]|

asciistring_01BA8F |Come on! At least [N]take a look- [N][JMP:&asciistring_01BA6B+M]|

asciistring_01BAAA |Great! Let me tell [N]you our special of the[N]day------- [0E:78][END]|

asciistring_01BAD8 |[10]You! [0E:78][END]|

asciistring_01BAE1 |I m just kidding! [N]Please don t be [N]offended- [FIN][END]|

asciistring_01BB03 |[0E:8][10]This restaurant is [N]famous for delicious [N]food and fruit [N]drinks! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01BB3F {
    COP [14] ( #$004A, &code_01BB46 )
    RTL 
}

code_01BB46 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01BC1C )
    COP [15]
    COP [91]
    COP [14] ( #$005D, &code_01BB5A )
    RTL 
}

code_01BB5A {
    COP [14] ( #$003F, &code_01BB61 )
    RTL 
}

code_01BB61 {
    COP [17] ( &code_01BC21 )
    COP [05] ( #$0003 )
    COP [16]
    COP [17] ( #$0000 )
    COP [A1] ( #$0008, #$0008 )
    COP [81] ( #12, #03 )
    COP [83]
    COP [A1] ( #$FFF8, #$FFF8 )
    COP [87]
    COP [81] ( #14, #03 )
    COP [83]
    COP [87]
    COP [A1] ( #$0008, #$0008 )
    COP [81] ( #13, #03 )
    COP [83]
    COP [A1] ( #$FFF8, #$FFF8 )
    COP [81] ( #14, #03 )
    COP [83]
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    BRK #$4E
    COP [80] ( #02 )
    COP [82]
    COP [1B] ( &code_01BBB5, #$003C )
}

code_01BBB5 {
    COP [09] ( #$8004 )
    COP [80] ( #00 )
    COP [82]
    COP [15]
    COP [17] ( &code_01BC21 )
    COP [05] ( #$0006 )
    COP [16]
    COP [17] ( #$0000 )
    COP [81] ( #05, #03 )
    COP [83]
    COP [80] ( #03 )
    COP [82]
    COP [87]
    COP [80] ( #05 )
    COP [82]
    COP [87]
    COP [80] ( #05 )
    COP [82]
    COP [80] ( #04 )
    COP [82]
    COP [81] ( #05, #03 )
    COP [83]
    COP [87]
    COP [81] ( #05, #06 )
    COP [83]
    COP [80] ( #00 )
    COP [82]
    COP [15]
    COP [17] ( &code_01BC26 )
    COP [05] ( #$0007 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    BRK #$4E
    COP [80] ( #12 )
    COP [82]
    COP [17] ( &code_01BC33 )
    COP [91]
    RTL 
}

code_01BC1C {
    COP [01] ( &asciistring_01BC47 )
    RTL 
}

code_01BC21 {
    COP [01] ( &asciistring_01BCBF )
    RTL 
}

code_01BC26 {
    COP [01] ( &gw_woods_actors_01D045.asciistring_01D49D )
    COP [09] ( #$8006 )
    COP [09] ( #$8007 )
    RTL 
}

code_01BC33 {
    COP [07] ( #$8000, &code_01BC42 )
    COP [01] ( &gw_woods_actors_01D045.asciistring_01D4BB )
    COP [17] ( &code_01BC42 )
    RTL 
}

code_01BC42 {
    COP [01] ( &gw_woods_actors_01D045.asciistring_01D4D0 )
    RTL 
}

asciistring_01BC47 |[10]Hello, I am a member [N]of the famous [N]"Woodstin+Trio-ˮ [FIN]We usually have a [N]variety show at this [N]theater, [FIN]but I am missing my [N]two sidekicks- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01BCBF |[10]Hey, don t walk [N]around, you re [N]annoying me- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01BCEC {
    COP [14] ( #$005A, &code_01BCF3 )
    RTL 
}

code_01BCF3 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01BD11 )

  loc_01BCFC:
    COP [81] ( #11, #03 )
    COP [83]
    COP [15]
    COP [1B] ( &code_01BD0A, #$0028 )
}

code_01BD0A {
    COP [16]
    COP [87]
    BRL loc_01BCFC
}

code_01BD11 {
    COP [07] ( #$8402, &code_01BD1D )
    COP [14] ( #$0061, &code_01BD22 )
}

code_01BD1D {
    COP [01] ( &asciistring_01BD27 )
    RTL 
}

code_01BD22 {
    COP [01] ( &asciistring_01BD84 )
    RTL 
}

asciistring_01BD27 |[10]I am guarding the [N]graveyard- [FIN]I hear someone snoring[N]but can t tell from [N]which direction the [N]sound is coming- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01BD84 |[10]I am guarding the [N]graveyard- [FIN]I hear someone snoring[N]but can t tell which [N]direction the sound [N]is coming from- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01BDE5 {
    COP [14] ( #$0037, &code_01BDEC )
    RTL 
}

code_01BDEC {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [AC] ( @code_01BEE5, #$0030, #$0110, #$2040 )
    COP [15]

  loc_01BDFE:
    COP [0C] ( #00, #04, &code_01BE0C )

  code_01BE04:
    COP [80] ( #18 )
    COP [82]
    BRL loc_01BDFE
}

code_01BE0C {
    COP [9B] ( #$0010, &code_01BE04, &code_01BE16, &code_01BE16 )
}

code_01BE16 {
    COP [17] ( #$0000 )
    COP [16]
    COP [A3]
    COP [80] ( #1E )
    COP [82]
    COP [81] ( #1F, #05 )
    COP [83]
    COP [80] ( #20 )
    COP [82]
    COP [87]
    COP [A6]
    COP [15]
    COP [17] ( &code_01BE3B )
    BRL loc_01BDFE
}

code_01BE3B {
    COP [18] ( #18, &code_01BE42 )
    BRA loc_01BE47
}

code_01BE42 {
    COP [18] ( #32, &code_01BE4C )

  loc_01BE47:
    COP [01] ( &asciistring_01BED2 )
    RTL 
}

code_01BE4C {
    COP [01] ( &asciistring_01BE56 )
    BRK #$5E
    COP [0A] ( #32 )
    RTL 
}

asciistring_01BE56 |[10]AHHHH! [N]You scared me! Please [N]don t sneak up behind [N]me- [FIN]Well, I guess it s [N]okay- I have something[N]special for you- [FIN][02:2] received [N][03:24]the Red+Hot Mirror- [03:20][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01BED2 |[10]AHHHH! [N]You scared me! [N][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

code_01BEE5 {
    COP [17] ( &code_01BEF1 )
    COP [91]
    COP [80] ( #23 )
    COP [82]
    RTL 
}

code_01BEF1 {
    COP [01] ( &asciistring_01BEF6 )
    RTL 
}

asciistring_01BEF6 |[10][0A]For█shy█birds,[N]you█better█approach[N]quietly█from█behind-[JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01BF32 {
    COP [14] ( #$0063, &code_01BF39 )
    RTL 
}

code_01BF39 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [AC] ( @code_01C261, #$0030, #$0200, #$2040 )
    COP [17] ( &code_01BFED )
    COP [07] ( #$0306, &code_01BF62 )
    COP [17] ( &code_01C015 )
    COP [AC] ( @code_01C0B0, #$00A0, #$00B0, #$0050 )
}

code_01BF62 {
    COP [15]
    COP [91]
    RTL 
}

code_01BF67 {
    COP [16]
    COP [81] ( #16, #09 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [87]
    COP [80] ( #17 )
    COP [82]
    COP [9F] ( #$0008 )
    COP [80] ( #16 )
    COP [82]
    COP [15]
    COP [17] ( &code_01C009 )
    COP [91]
    RTL 
}

code_01BF8C {
    COP [09] ( #$8002 )

  code_01BF90:
    COP [16]
    COP [80] ( #25 )
    COP [82]
    COP [80] ( #26 )
    COP [82]
    BRK #$4A
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #08 )
    LDA $002E, X
    CLC 
    ADC $scroll_bg1_y
    STA $scroll_bg1_y
    COP [1B] ( &code_01BFB7, #$0002 )
}

code_01BFB7 {
    COP [04]
    LDA #$2F80
    TRB $joy_block_mask
    COP [07] ( #$0002, &code_01BF8C )
    COP [AC] ( @code_01C08A, #$00A0, #$0010, #$0050 )
    COP [1B] ( &code_01BFD6, #$005A )
}

code_01BFD6 {
    COP [80] ( #12 )
    COP [82]
    COP [80] ( #15 )
    COP [82]
    COP [15]
    COP [17] ( &code_01C015 )
    COP [09] ( #$8306 )
    COP [91]
    RTL 
}

code_01BFED {
    COP [14] ( #$006F, &code_01BFF8 )
    COP [01] ( &asciistring_01C01A )
    RTL 
}

code_01BFF8 {
    COP [01] ( &asciistring_01C043 )
    COP [17] ( &code_01C004 )
    COP [27] ( &code_01BF67 )
}

code_01C004 {
    COP [01] ( &asciistring_01C043 )
    RTL 
}

code_01C009 {
    COP [01] ( &asciistring_01C052 )
    COP [17] ( #$0000 )
    COP [27] ( &code_01BF90 )
}

code_01C015 {
    COP [01] ( &asciistring_01C065 )
    RTL 
}

asciistring_01C01A |[10]If you help me [N]cross the river I will[N]give you something- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01C043 |[10]Follow me- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01C052 |[10]Stand back and watch! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01C065 |[10]What did you think? [N]I hope this helped- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

code_01C08A {
    JSL $@shared_actor_helpers_bank3.code_01B161
    STZ $0014, X
    COP [03] ( #28 )
    LDA $0002, X
    CLC 
    ADC #$0004
    STA $0002, X
    COP [04]
    COP [17] ( &code_01C0C4 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.code_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.code_01B17C-1
    PHA 
    RTL 
}

code_01C0B0 {
    JSL $@shared_actor_helpers_bank3.code_01B161
    COP [17] ( &code_01C0C4 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.code_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.code_01B17C-1
    PHA 
    RTL 
}

code_01C0C4 {
    COP [18] ( #40, &code_01C0CE )
    COP [01] ( &asciistring_01C224 )
    RTL 
}

code_01C0CE {
    COP [18] ( #2A, &code_01C118 )
    COP [18] ( #2B, &code_01C118 )
    COP [18] ( #2C, &code_01C118 )
    COP [18] ( #2D, &code_01C118 )
    COP [18] ( #2E, &code_01C118 )
    COP [18] ( #2F, &code_01C118 )
    COP [18] ( #30, &code_01C118 )
    COP [18] ( #31, &code_01C118 )
    COP [01] ( &asciistring_01C1D8 )
    COP [0B] ( #2A )
    COP [0B] ( #2B )
    COP [0B] ( #2C )
    COP [0B] ( #2D )
    COP [0B] ( #2E )
    COP [0B] ( #2F )
    COP [0B] ( #30 )
    COP [0B] ( #31 )
    BRK #$5E
    COP [0A] ( #40 )
    RTL 
}

code_01C118 {
    COP [01] ( &asciistring_01C11D )
    RTL 
}

asciistring_01C11D |[10]The Master s Emblems [N]are all over the [N]world------- [FIN]They are fairly [N]difficult to find- [FIN]Collect all 8 emblems,[N]will not require GEMs [N]when casting magic- [FIN]This will make [N]fighting much easier [N]If you collect all 8, [N]bring them to me- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01C1D8 |[10][02:2], [N]you collected all 8 [N]emblems- [FIN]I will now give you [N][03:24]the Magic Bell- [N][03:20]You have fought well! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01C224 |[10]The Magic Bell [N]enables you to use [N]magic without GEMs- [FIN][02:2], good luck! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

code_01C261 {
    COP [17] ( &code_01C26D )
    COP [91]
    COP [80] ( #23 )
    COP [82]
    RTL 
}

code_01C26D {
    COP [01] ( &asciistring_01C272 )
    RTL 
}

asciistring_01C272 |[10][0A]There█once█was█a█raft[N]made█from█the█bark█of[N]my█branches-[FIN]You█must█find█this[N]raft-█I█believe█it[N]might█be█able[N]help█you█in█some█way-[JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01C2F9 {
    COP [14] ( #$0058, &code_01C300 )
    RTL 
}

code_01C300 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [AC] ( @code_01C372, #$0070, #$02D0, #$2040 )
    COP [17] ( &code_01C335 )
    COP [91]

  loc_01C316:
    COP [81] ( #05, #03 )
    COP [83]
    COP [81] ( #03, #03 )
    COP [83]
    COP [87]
    COP [81] ( #05, #03 )
    COP [83]
    COP [81] ( #04, #03 )
    COP [83]
    COP [87]
    BRL loc_01C316
}

code_01C335 {
    COP [01] ( &asciistring_01C33A )
    RTL 
}

asciistring_01C33A |[10]I hear someone [N]snoring- [N]I cannot tell who is [N]making the noise- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

code_01C372 {
    COP [17] ( &code_01C37E )
    COP [91]
    COP [80] ( #23 )
    COP [82]
    RTL 
}

code_01C37E {
    COP [19] ( #1C, &code_01C397 )
    COP [01] ( &asciistring_01C3A7 )
    STZ $asset_cache_tilemap1
    COP [3C] ( #04 )
    COP [10] ( #$0604, #02, #$0120, #$0040 )
    RTL 
}

code_01C397 {
    COP [01] ( &asciistring_01C39C )
    RTL 
}

asciistring_01C39C |[10][0A]Zzzzz [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01C3A7 |[10][02:2] placed the [N]Dream Rod upon the [N]stump- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01C3CA {
    COP [14] ( #$0046, &code_01C3D1 )
    RTL 
}

code_01C3D1 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [AC] ( @code_01C495, #$0220, #$02E0, #$2040 )
    COP [17] ( &code_01C41C )

  loc_01C3E5:
    COP [80] ( #1D )
    COP [82]
    COP [1B] ( &code_01C3F0, #$0028 )
}

code_01C3F0 {
    COP [87]
    COP [80] ( #1D )
    COP [82]
    COP [1B] ( &code_01C3FD, #$003C )
}

code_01C3FD {
    COP [A3]
    COP [80] ( #1E )
    COP [82]
    COP [81] ( #1F, #04 )
    COP [83]
    COP [87]
    COP [81] ( #1F, #04 )
    COP [83]
    COP [80] ( #20 )
    COP [82]
    COP [A6]
    BRL loc_01C3E5
}

code_01C41C {
    COP [01] ( &asciistring_01C421 )
    RTL 
}

asciistring_01C421 |[10]We tell the trees [N]what is taking place [N]and in turn they give [N]us seeds to eat- [FIN]So I guess you could [N]say we have sort of a [N]give+and+take [N]relationship- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

code_01C495 {
    COP [17] ( &code_01C4A1 )
    COP [91]
    COP [80] ( #23 )
    COP [82]
    RTL 
}

code_01C4A1 {
    COP [01] ( &asciistring_01C4A6 )
    RTL 
}

asciistring_01C4A6 |[10][0A]The█birds█tell█me█many[N]stories-[FIN]I█am█thankful█for[N]them█because█I█can t[N]move█from█this█spot-[FIN]The█birds█tell█me█the[N]Lostside█Marsh█has[N]three█shrines-[FIN]One█is█called█Water,[FIN]another█is█Fire[FIN]and█the█third█is[N]Light-[JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01C57B {
    COP [14] ( #$003C, &code_01C582 )
    RTL 
}

code_01C582 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [AC] ( @code_01C826, #$02B0, #$0200, #$2040 )
    COP [17] ( &code_01C60A )
    COP [15]
    COP [91]
    RTL 
}

code_01C59B {
    COP [16]
    COP [81] ( #11, #06 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #0F, #04 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [80] ( #0E )
    COP [82]
    COP [17] ( &code_01C631 )
    COP [15]
    COP [91]
    RTL 
}

code_01C5BF {
    COP [16]
    COP [17] ( &code_01C62C )
    COP [81] ( #10, #07 )
    COP [83]
    COP [17] ( &code_01C639 )
    COP [15]
    COP [91]
    RTL 
}

code_01C5D4 {
    COP [17] ( #$0000 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [1B] ( &code_01C5E4, #$003C )
}

code_01C5E4 {
    COP [01] ( &asciistring_01C782 )
    COP [80] ( #0C )
    COP [82]
    COP [1B] ( &code_01C5F3, #$001E )
}

code_01C5F3 {
    COP [81] ( #24, #04 )
    COP [83]
    COP [01] ( &asciistring_01C7DF )
    LDA #$2F80
    TRB $joy_block_mask
    COP [17] ( &code_01C62C )
    COP [91]
    RTL 
}

code_01C60A {
    COP [01] ( &asciistring_01C64D )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_01C627 )
    LDA $L_choice_result
    BNE code_01C627
    COP [01] ( &asciistring_01C661 )
    COP [17] ( &code_01C62C )
    COP [27] ( &code_01C59B )
}

code_01C627 {
    COP [01] ( &asciistring_01C675 )
    RTL 
}

code_01C62C {
    COP [01] ( &asciistring_01C683 )
    RTL 
}

code_01C631 {
    COP [01] ( &asciistring_01C6B6 )
    COP [27] ( &code_01C5BF )
}

code_01C639 {
    COP [14] ( #$004A, &code_01C645 )
    COP [01] ( &asciistring_01C738 )
    BRA loc_01C649
}

code_01C645 {
    COP [01] ( &asciistring_01C6F6 )

  loc_01C649:
    COP [27] ( &code_01C5D4 )
}

asciistring_01C64D |[10]Please, come [N]take a walk with me- [END]|

asciistring_01C661 |All right, let s go! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01C675 |Why not!? [N][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01C683 |[10]I have as much fun [N]walking people as they[N]do walking me- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01C6B6 |[10]The island over there [N]is a graveyard- [N]My twin brother is the[N]island guard- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01C6F6 |[10]This is Green Theater-[N]A group called the [N]"Woodstin+Trioˮ is a [N]local favorite here- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01C738 |[10]This place used to be [N]the Green Theater- [FIN]A group called the [N]"Woodstin+Trioˮ used [N]to be a very popular [N]band- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01C782 |[10]Thank you for walking [N]with me- [N]Oh, one more thing--- [FIN]We animals communicate[N]not only with our [N]voices but also--- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01C7DF |[10]If I step like this [N]and wag my tail, it [N]means "thank youˮ- [FIN]Did you already know [N]that? [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

code_01C826 {
    COP [17] ( &code_01C832 )
    COP [91]
    COP [80] ( #23 )
    COP [82]
    RTL 
}

code_01C832 {
    COP [01] ( &asciistring_01C837 )
    RTL 
}

asciistring_01C837 |[10][0A]If█you█find█a[N]particular█mole,█you[N]will█be█able█to[N]see█in█the█dark-[FIN]Make█sure█you█talk█to[N]all█the█moles-[JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01C8A4 {
    COP [14] ( #$0038, &code_01C8AB )
    RTL 
}

code_01C8AB {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [AC] ( @code_01C8F5, #$02A0, #$0160, #$2040 )
    COP [17] ( &code_01C8C9 )
    COP [15]
    COP [91]
    COP [80] ( #18 )
    COP [82]
    RTL 
}

code_01C8C9 {
    COP [01] ( &asciistring_01C8CE )
    RTL 
}

asciistring_01C8CE |[10]Talk with the stump- [N]Please listen [N]carefully- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

code_01C8F5 {
    COP [17] ( &code_01C901 )
    COP [91]
    COP [80] ( #23 )
    COP [82]
    RTL 
}

code_01C901 {
    COP [01] ( &asciistring_01C906 )
    RTL 
}

asciistring_01C906 |[10][0A]This█is█GreenWood-[N]This█land█was[N]developed█by█a█dog[N]named█Turbo-[FIN]He█created█this█town[N]so█animals█could█come[N]here█and█feel█safe-[JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01C98A {
    COP [14] ( #$0061, &code_01C991 )
    RTL 
}

code_01C991 {
    COP [30] ( #$0061, &code_01CA7E, #03 )
    COP [07] ( #$9F02, &code_01C9C0 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [85] ( @code_01CA63 )
    COP [17] ( &code_01CA43 )
    COP [15]
    COP [91]
    COP [07] ( #$0402, &code_01C9BF )
    COP [17] ( &code_01CA5E )
    COP [80] ( #1A )
    COP [82]
}

code_01C9BF {
    RTL 
}

code_01C9C0 {
    LDA #$BFC0
    TSB $joy_block_mask
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [03] ( #65 )
    COP [04]
    COP [01] ( &asciistring_01CBA8 )
    COP [03] ( #79 )
    COP [04]
    COP [A1] ( #$0010, #$FFF0 )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [81] ( #28, #08 )
    COP [83]
    COP [81] ( #27, #10 )
    COP [83]
    COP [03] ( #5B )
    COP [04]
    COP [01] ( &asciistring_01CC05 )
    COP [03] ( #79 )
    COP [04]
    COP [81] ( #24, #04 )
    COP [83]
    COP [03] ( #29 )
    COP [04]
    COP [81] ( #27, #10 )
    COP [83]
    COP [81] ( #28, #08 )
    COP [83]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [03] ( #79 )
    COP [04]
    LDA #$0020
    STA $asset_skip_mask
    COP [10] ( #$0101, #03, #$03B0, #$01D8 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_01CA43 {
    COP [19] ( #1C, &code_01CA59 )
    COP [01] ( &asciistring_01CAB9 )
    COP [3C] ( #04 )
    COP [10] ( #$0504, #03, #$0160, #$01C0 )
    RTL 
}

code_01CA59 {
    COP [01] ( &asciistring_01CAAF )
    RTL 
}

code_01CA5E {
    COP [01] ( &asciistring_01CADE )
    RTL 
}

code_01CA63 {
    COP [91]
    COP [0D] ( #00, #12, #2C, &code_01CA6D )
    RTL 
}

code_01CA6D {
    COP [01] ( &asciistring_01CA85 )
    COP [91]
    COP [0D] ( #00, #12, #2C, &code_01CA7D )
    BRL code_01CA63
}

code_01CA7D {
    RTL 
}

code_01CA7E {
    COP [01] ( &asciistring_01CB73 )
    COP [86]
    RTL 
}

asciistring_01CA85 |[10]Here lies Turbo, [N]builder of GreenWood- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01CAAF |[10]Zzzzz [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01CAB9 |[10][02:2] touched the [N]small bird with the [N]Dream Rod- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01CADE |[10]The rafts will only [N]carry the residents of[N]GreenWood- [FIN]Maybe if you bring [N]something that used to[N]belong to Turbo, they [N]might help you- [FIN]There are some leaves [N]from GreenWood buried [N]with Turbo- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01CB73 |[10][0E:3C]There is a bird [N]sleeping in front of [N]Turbo s grave stone- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01CBA8 |[10][0F]Turbo s grave is [N]standing alone- [N][0E:5A]When [02:2] closed [N]his eyes, he tried to [N]imagine Turbo- [0E:78][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46+M]|

asciistring_01CC05 |[10][0F]Like good sleep comes [N]after hard work, good [N]rest comes after an [N]honest life- [N][0E:5A]I will rest well with [N]Dr-Leo- [0E:78][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46+M]|
---------------------------------------------

code_01CC61 {
    COP [14] ( #$004E, &code_01CC68 )
    RTL 
}

code_01CC68 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01CCA1 )
    COP [A4]
    COP [07] ( #$8305, &code_01CC81 )
    COP [91]
    COP [80] ( #21 )
    COP [82]
    RTL 
}

code_01CC81 {
    COP [16]
    COP [17] ( #$0000 )

  code_01CC87:
    COP [03] ( #0A )
    COP [80] ( #21 )
    COP [82]
    COP [0C] ( #00, #00, &code_01CC98 )
    BRL code_01CC87
}

code_01CC98 {
    COP [04]
    COP [01] ( &asciistring_01CD20 )
    BRL code_01CC87
}

code_01CCA1 {
    COP [01] ( &asciistring_01CCC9 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_01CCC4 )
    LDA $L_choice_result
    BNE code_01CCC4
    COP [01] ( &asciistring_01CCEE )
    COP [09] ( #$8305 )
    COP [16]
    COP [17] ( #$0000 )
    COP [27] ( &code_01CC87 )
}

code_01CCC4 {
    COP [01] ( &asciistring_01CD16 )
    RTL 
}

asciistring_01CCC9 |[10]Who are you? [N]Are you trying to walk[N]over me!? [END]|

asciistring_01CCEE |You have some nerve! [N]Okay, but don t hurt [N]me- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01CD16 |You wimp! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01CD20 |[10]Hey, you re hurting [N]me! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01CD3D {
    COP [14] ( #$005B, &code_01CD44 )
    RTL 
}

code_01CD44 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [A4]
    COP [16]
    COP [91]
    COP [80] ( #21 )
    COP [82]
    RTL 
}
---------------------------------------------

code_01CD55 {
    COP [14] ( #$006F, &code_01CD5C )
    RTL 
}

code_01CD5C {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [A4]
    COP [16]
    COP [91]
    COP [80] ( #21 )
    COP [82]
    RTL 
}
---------------------------------------------

code_01CD6D {
    COP [14] ( #$003D, &code_01CD74 )
    RTL 
}

code_01CD74 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01CDE1 )
    COP [15]
    COP [91]
    RTL 
}

code_01CD82 {
    COP [17] ( &code_01CDE9 )
    COP [16]
    COP [80] ( #0F )
    COP [82]
    COP [9D] ( #0F )
    COP [9E] ( &code_01CD94 )
}

code_01CD94 {
    COP [87]
    COP [81] ( #11, #08 )
    COP [83]
    COP [80] ( #0E )
    COP [82]
    COP [17] ( &code_01CDEE )
    COP [15]
    COP [91]
    RTL 
}

code_01CDAA {
    COP [16]
    COP [17] ( &code_01CDF6 )
    COP [81] ( #10, #06 )
    COP [83]
    COP [81] ( #11, #02 )
    COP [83]
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #0D )
    COP [82]
    COP [17] ( &code_01CDFB )
    COP [15]
    COP [91]
    COP [0D] ( #00, #1D, #09, &code_01CDD6 )
    RTL 
}

code_01CDD6 {
    COP [01] ( &asciistring_01CED5 )
    COP [09] ( #$8001 )
    COP [91]
    RTL 
}

code_01CDE1 {
    COP [01] ( &asciistring_01CE0B )
    COP [27] ( &code_01CD82 )
}

code_01CDE9 {
    COP [01] ( &asciistring_01CE0B )
    RTL 
}

code_01CDEE {
    COP [01] ( &asciistring_01CE48 )
    COP [27] ( &code_01CDAA )
}

code_01CDF6 {
    COP [01] ( &asciistring_01CEA7 )
    RTL 
}

code_01CDFB {
    COP [07] ( #$8001, &code_01CE06 )
    COP [01] ( &asciistring_01CEAB )
    RTL 
}

code_01CE06 {
    COP [01] ( &asciistring_01CEE6 )
    RTL 
}

asciistring_01CE0B |[10]I can tell what [N]something is just by [N]it s smell- [FIN]Allright, let me start[N]doing my job- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01CE48 |[10]From >,[N][0E:3C]I smell fresh air- [FIN]From _, [0E:3C]I smell a [N]mole- [FIN]What is that smell!! [N][::]I smell something [N]strange coming from '-[JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01CEA7 |[10][JMP:&asciistring_01CE48+M]|

asciistring_01CEAB |[10]It s around here [N]somewhere- [N]I smell something [N]really strange! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01CED5 |[10]There is an outhouse- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01CEE6 |[10]Oh, this is our [N]bathroom- [FIN]Thank you for walking [N]with me- [N]I will tell you a [N]secret- [FIN]I can smell some armor[N]north of here- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

code_01CF41 {
    COP [14] ( #$0059, &code_01CF48 )
    RTL 
}

code_01CF48 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01CFB4 )
    COP [15]
    COP [91]
    COP [14] ( #$0056, &code_01CF5C )
    RTL 
}

code_01CF5C {
    COP [17] ( &code_01CFA7 )
    COP [91]
    RTL 
}

code_01CF63 {
    COP [16]
    COP [17] ( &code_01CFAF )

  code_01CF69:
    COP [9C] ( &code_01CF6F, &code_01CF8B )
}

code_01CF6F {
    COP [9A] ( #$0010, &code_01CF79, &code_01CF8B, &code_01CF82 )
}

code_01CF79 {
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRA code_01CF69
}

code_01CF82 {
    COP [96]
    COP [80] ( #05 )
    COP [82]
    BRA code_01CF69
}

code_01CF8B {
    COP [9B] ( #$0010, &code_01CF95, &code_01CFA3, &code_01CF9C )
}

code_01CF95 {
    COP [80] ( #04 )
    COP [82]
    BRA code_01CF69
}

code_01CF9C {
    COP [80] ( #03 )
    COP [82]
    BRA code_01CF69
}

code_01CFA3 {
    COP [27] ( &code_01CF69 )
}

code_01CFA7 {
    COP [01] ( &asciistring_01CFB9 )
    COP [27] ( &code_01CF63 )
}

code_01CFAF {
    COP [01] ( &asciistring_01CFE0 )
    RTL 
}

code_01CFB4 {
    COP [01] ( &asciistring_01D01B )
    RTL 
}

asciistring_01CFB9 |[10]I need to take [N]a walk and work some [N]of this food off- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01CFE0 |[10]"Why am I following [N]you?ˮ [N]Well it s purely [N]coincidence- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D01B |[10]I m starving! This [N]place used to be a [N]restaurant- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|