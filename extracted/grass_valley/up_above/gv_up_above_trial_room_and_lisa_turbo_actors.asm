?BANK 03

?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'gv_epilogue_texts'
?INCLUDE 'lib_text_render'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!joy_block_mask                 0326
!map_width_px                   0342
!scroll_bg3_x                   0386
!scroll_bg3_y                   0388
!player_actor                   039C
!asset_skip_mask                03B4
!vram_upload_flags              03B8
!asset_cache_tilemap1           0419
!joy_override                   0468
!souls_flags                    1B82
!text_delay                     1B84
!BG3SC                          2109
!TM                             212C
!coldata_buffer                 7F0200

---------------------------------------------

code_01A7AC {
    COP [14] ( #$0000, &code_01A7B3 )
    RTL 
}

code_01A7B3 {
    COP [9F] ( #$0008 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01A7DC )
    COP [15]
    COP [2A] ( #$0010, #$0000 )
    COP [05] ( #$0504 )
    COP [16]
    COP [2B] ( #$0010, #$0000 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [86]
    RTL 
}

code_01A7DC {
    COP [01] ( &asciistring_01A7F9 )
    BRK #$5E
    COP [0A] ( #11 )
    COP [01] ( &asciistring_01A913 )
    SEP #$20
    LDA #$01
    STA $souls_flags
    REP #$20
    COP [09] ( #$8504 )
    BRK #$0E
    RTL 
}

asciistring_01A7F9 |[10]I used to live up [N]in the sky just like [N]you- [FIN]Now, I am living on [N]Earth, away from the [N]Master- [FIN]All the creatures that[N]have been captured by [N]Deathtoll are sealed [N]away in monster lairs-[FIN]Just as you have set [N]me free, you must free[N]everyone- [FIN]Even the release of a [N]small tree or [N]creature, they will [N]aid you in your quest-[FIN]Here, take this- [FIN][02:2] received [N][03:24]the Flame Ball Magic- [03:20][FIN][END]|

asciistring_01A913 |[10]Now I will join you- I[N]am a magician so I can[N]use all types magic- [FIN]I will use my skill to[N]help you- [FIN]Remember this, I need [N]GEMs in order to use [N]magic- [FIN]When you set me free, [N]the monsters left some[N]small spheres of gold-[FIN]This is what a GEM [N]looks like- Alright, [N]let s work together to[N]revive the world! [FIN]We must go to the [N]Grass Valley Shrine- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

code_01B33A {
    REP #$20
    LDA #$0059
    STA $BG3SC
    STZ $scroll_bg3_x
    STZ $scroll_bg3_y
    LDA #$3FC0
    TSB $joy_block_mask
    COP [0D] ( #00, #2F, #29, &code_01B38A )
    LDA #$0007
    STA $text_delay
    SEP #$20
    LDA #$04
    STA $TM
    REP #$20
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &asciistring_01B52D )
    COP [03] ( #79 )
    COP [04]
    STZ $asset_cache_tilemap1
    LDA #$0020
    STA $asset_skip_mask
    COP [3C] ( #04 )
    COP [10] ( #$0D00, #02, #$02F0, #$0290 )
    COP [91]
    RTL 
}

code_01B38A {
    COP [91]
    COP [34]
    LDA #$0005
    STA $text_delay
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &asciistring_01B67F )
    COP [03] ( #79 )
    COP [04]
    COP [AC] ( @engine_spawn_lairs_death_drops.RunAppearPuff, #$02F0, #$02A0, #$0040 )
    BRK #$96
    COP [33]
    LDA #$3FC0
    TSB $joy_block_mask
    COP [03] ( #1F )
    COP [04]
    COP [03] ( #02 )
    LDA #$0003
    LDY $player_actor
    STA $001E, Y
    COP [1B] ( &code_01B3CE, #$0010 )
}

code_01B3CE {
    LDA #$0002
    LDY $player_actor
    STA $001E, Y
    COP [1B] ( &code_01B3DD, #$0010 )
}

code_01B3DD {
    COP [04]
    COP [03] ( #5B )
    COP [04]
    COP [96]
    COP [80] ( #25 )
    COP [82]
    COP [03] ( #3D )
    COP [04]
    COP [32] ( #11 )
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &asciistring_01B6C1 )
    LDA #$0001
    STA $text_delay
    COP [01] ( &asciistring_01B6C9 )
    LDA #$0005
    STA $text_delay
    COP [01] ( &asciistring_01B6D5 )
    COP [03] ( #5B )
    COP [04]
    COP [01] ( &asciistring_01B6FF )
    LDA #$3FC0
    TRB $joy_block_mask
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_01B438 )
    LDA #$3FC0
    TSB $joy_block_mask
    LDA $L_choice_result
    BNE code_01B438
    COP [01] ( &asciistring_01B723 )
    BRA loc_01B442
}

code_01B438 {
    LDA #$3FC0
    TSB $joy_block_mask
    COP [01] ( &asciistring_01B73B )

  loc_01B442:
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &asciistring_01B880 )
    COP [97]
    COP [80] ( #25 )
    COP [82]
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_01B8CA )
    LDA #$0002
    STA $text_delay
    COP [01] ( &asciistring_01B8E8 )
    LDA #$0005
    STA $text_delay
    COP [96]
    COP [80] ( #25 )
    COP [82]
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_01B8F8 )
    LDA #$0380
    STA $map_width_px
    COP [81] ( #26, #04 )
    COP [83]
    COP [97]
    COP [80] ( #25 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_01B951 )
    COP [96]
    COP [80] ( #25 )
    COP [82]
    LDY $player_actor
    LDA $0016, Y
    AND #$EFFF
    STA $0016, Y
    LDA #$0100
    STA $joy_override
    COP [09] ( #$8000 )
    COP [80] ( #26 )
    COP [82]
    LDA #$0000
    STA $joy_override
    COP [81] ( #26, #02 )
    COP [83]
    LDA #$0100
    STA $joy_override
    COP [81] ( #26, #08 )
    COP [83]
    COP [1B] ( &code_01B4D7, #$014A )
}

code_01B4D7 {
    LDA #$0000
    STA $joy_override
    COP [85] ( @code_01B508 )
    COP [03] ( #BF )
    COP [04]
    STZ $0030, X
    COP [03] ( #20 )
    SEP #$20
    LDA $0030, X
    ORA #$E0
    STA $coldata_buffer
    REP #$20
    INC $0030, X
    COP [1B] ( &code_01B503, #$0002 )
}

code_01B503 {
    COP [04]
    COP [91]
    RTL 
}

code_01B508 {
    LDA #$0002
    TSB $vram_upload_flags
    COP [03] ( #02 )
    COP [04]
    LDA #$00FF
    STA $scroll_bg3_x
    PHX 
    LDY #$&gv_epilogue_texts.TheEndText
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [03] ( #FF )
    DEC $scroll_bg3_x
    COP [04]
    COP [91]
    RTL 
}

asciistring_01B52D |[10]My follower, [N][0E:28]tell me what is on [N]your mind- [N][0E:5A]I do not know what has[N]happened between you [N]and that girl- [N][0E:5A]However, being [N]attracted to a human [N]means that you have [N]not yet established [N]yourself as a heavenly[N]creature- [N][0E:5A]A year has now passed,[N]but your feelings have[N]not changed- [N][0E:5A]Maybe you should try [N]living as a human [N]being- [N]Learning how they [N]live- [N][0E:5A]Be warned though- Once[N]you go down to earth [N]you will lose all [N]memory- [N][0E:78][JMP:&shared_actor_helpers_bank3.asciistring_01B988+M]|

asciistring_01B67F |[10]Hey, [0E:28]Turbo,[N][0E:5A]I feel something [N]strange in the air [N]today- [N][0E:3C]What s wrong with me? [N][0E:5A][JMP:&shared_actor_helpers_bank3.asciistring_01B988+M]|

asciistring_01B6C1 |[10][02:2]? [0E:5A][END]|

asciistring_01B6C9 |Is that you? [0E:B4][END]|

asciistring_01B6D5 |Oh, my-----![N][0E:5A]I knew you would come [N]back! [N][0E:5A][JMP:&shared_actor_helpers_bank3.asciistring_01B988+M]|

asciistring_01B6FF |[10]What is wrong? [N][0E:28]Don t you remember me?[END]|

asciistring_01B723 |No, I can t believe [N]this- [N][0E:78][JMP:&asciistring_01B73B+M]|

asciistring_01B73B |It s okay- [N][0E:28]You don t have to [N]worry-[N][0E:3C]I can tell by the look[N]in your eyes-[N][0E:5A][::]It s me, [N]Lisa----- [0E:28]Daughter of [N]Dr-Leo the inventor! [N][0E:5A]Please! [N][0E:28]Don t you remember me?[N][0E:B4]Well, okay- [N][0E:5A]You have never lied to[N]me- [N][0E:5A]It s just hard to [N]believe you lost all [N]your memory- [N][0E:5A]All right, I won t ask[N]you again- [N][0E:5A]I guess I have to [N]change my way of [N]thinking- [N][0E:5A]We can create many new[N]and wonderful memories[N]together! [N][0E:78][JMP:&shared_actor_helpers_bank3.asciistring_01B988+M]|

asciistring_01B880 |[10]Okay, let me introduce[N]myself- [N][0E:5A]I am Lisa, [N][0E:5A]and the goat behind [N]me is Turbo- [N][0E:5A][JMP:&shared_actor_helpers_bank3.asciistring_01B988+M]|

asciistring_01B8CA |[10]Come on Turbo, [N][0E:28]say "helloˮ- [N][0E:5A][END]|

asciistring_01B8E8 |[10]BLEEEET! [N][0E:5A][JMP:&shared_actor_helpers_bank3.asciistring_01B988+M]|

asciistring_01B8F8 |[10]He looks like a dog I[N]used to have- [N][0E:5A]That is [N]why I call him Turbo- [N][0E:5A]Come, I will show you [N]around- [N][0E:78][JMP:&shared_actor_helpers_bank3.asciistring_01B988+M]|

asciistring_01B951 |[10]Hurry up Turbo! [0E:78][JMP:&shared_actor_helpers_bank3.asciistring_01B988+M]|
---------------------------------------------

code_01B967 {
    COP [07] ( #$8000, &code_01B974 )
    COP [80] ( #24 )
    COP [82]
    BRA code_01B967
}

code_01B974 {
    COP [81] ( #1B, #04 )
    COP [83]
    COP [80] ( #24 )
    COP [82]
    COP [81] ( #1B, #08 )
    COP [83]
    COP [91]
    RTL 
}