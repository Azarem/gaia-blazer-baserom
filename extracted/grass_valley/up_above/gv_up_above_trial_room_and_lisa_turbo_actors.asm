; The Magician of the Trial Room (area 0 scene 8) and the closing scene with Lisa and Turbo (area 0 scene $0D) (bank 03, the Magician starts at file offset 108460, Lisa's scene at 111418).
; 
; === THE TRIAL ROOM ===
; gv_npc_magician_01A7AC (meta type $32, switch $00 = the first lair record, placed at tile ($0C,$05) of A00S08). The walkthrough: 'the monster lair nearby will lose its shield, revealing a green switch. Step on it ... a man appears nearby. Go to him and speak with him (B Button) to receive a brief speech and the Soul of Magician.' and 'you also get the Flame Ball Magic'. Talk: 'I used to live up in the sky just like you. Now, I am living on Earth, away from the Master. All the creatures that have been captured by Deathtoll are sealed away in monster lairs. Just as you have set me free, you must free everyone ... Here, take this. <name> received the Flame Ball Magic.' (COP 0A item $11 = Flame Ball), then 'Now I will join you. I am a magician so I can use all types magic ... I need GEMs in order to use magic ... We must go to the Grass Valley Shrine.' It sets souls_flags to 1 (the walkthrough: 'the Soul of Magician') and event flag $0504; the Magician then leaves in a puff of smoke.
; 
; === THE CLOSING SCENE ===
; gv_npc_lisa_epilogue_01B33A (type $5D, tile ($2C,$29)) runs in two passes of area 0 scene $0D. First pass: the screen shows only text (TM = BG3); the Master speaks to the hero: 'My follower, tell me what is on your mind ... being attracted to a human means that you have not yet established yourself as a heavenly creature. A year has now passed, but your feelings have not changed. Maybe you should try living as a human being ... Once you go down to earth you will lose all memory.' Then COP 10 reloads the same scene (arrival animation 2, x $02F0, y $0290 = tile ($2F,$29)); COP 0D finds the hero on that tile and selects the second pass: Lisa speaks to Turbo ('Hey, Turbo, I feel something strange in the air today. What's wrong with me?'), the hero appears in a puff, '<name>? Is that you? Oh, my! I knew you would come back! What is wrong? Don't you remember me?' with a Yes / No menu (Yes, index 0: 'No, I can't believe this' and then the long text; No: the long text only), 'It's okay ... It's me, Lisa, Daughter of Dr-Leo the inventor! ... We can create many new and wonderful memories together!', 'Okay, let me introduce myself. I am Lisa, and the goat behind me is Turbo', 'Come on Turbo, say hello', 'BLEEEET!', 'He looks like a dog I used to have. That is why I call him Turbo. Come, I will show you around.' and 'Hurry up Turbo!'. Lisa then sets event flag $0000 (Turbo moves, gv_npc_turbo_01B967), the pad is overridden to hold Right ($0100) while the hero walks, and after a wait of $014A frames gv_obj_the_end_text_01B508 prints THE END (gv_epilogue_texts) while Lisa's actor ramps coldata_buffer ($E0 | n, n = 0 ... $1F, one step per 2 frames).
; 
; === NOTES ===
; - The village uses the same flag number $0000 for 'set after the crab-walk lesson was spoken' (gv_village_actors_018000); the meaning of the low flags $0000-$0007 is OQ-I034-2.
; - The walkthrough chapters do not describe the closing scene; the texts are quoted from the ROM (the extracted strings show an apostrophe as a space, 'can t', and a period as '-').
---------------------------------------------

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

; The Magician of the Trial Room.
; 
; When: meta type $32 in A00S08; registered under switch $00 and hidden until the Trial Room lair is released.
; Sees: a man who appears next to the lair after the switch; the speech and 'Now I will join you' (see the block note), the sound BRK $5E and the Flame Ball Magic; afterwards he vanishes in a puff.
; Why: COP 14 on switch $00 keeps the script hidden (RTL) until the lair is released; the walkthrough ties this man to the first Soul and the first magic.
; In: actor script, X = own slot (COP 9F moves it 8 pixels right, COP 85 spawns RunAppearPuff, COP 17 sets the talk handler, COP 15 blocks its tiles).
; Out: waits at COP 05 for event flag $0504; talk handler code_01A7DC gives item $11, sets souls_flags = 1 and the flag, BRK $0E; then COP 16 frees the tiles, a second puff is spawned and COP 86 kills the actor.
; Clobbers: A.

gv_npc_magician_01A7AC {
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
    COP [0A] ( #11 )      ; item $11 = Flame Ball (lib_menus.ItemName11)
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

; Lisa and the Master in the closing scene (two passes).
; 
; When: meta type $5D in A00S0D, on the first and on the second visit of the scene (the hero's tile selects the pass).
; Sees: see the block note; the pad is blocked (joy_block_mask |= $3FC0) except while the Yes / No menu is open.
; Why: the first pass shows only BG3 (TM = $04) with the Master's text, the second the meeting with Lisa and Turbo; the hero's tile tells them apart.
; In: actor script, X = own slot; sets BG3SC = $59, scroll_bg3_x / y = 0.
; Out: pass 1 ends in COP 10 to $0D00 (arrival animation 2, x $02F0, y $0290); pass 2 spawns gv_obj_the_end_text_01B508 and ramps coldata_buffer.
; Clobbers: A, Y.

gv_npc_lisa_epilogue_01B33A {
    REP #$20
    LDA #$0059
    STA $BG3SC
    STZ $scroll_bg3_x
    STZ $scroll_bg3_y
    LDA #$3FC0
    TSB $joy_block_mask
    COP [0D] ( #00, #2F, #29, &code_01B38A ) ; hero at tile ($2F,$29) = second pass of the scene (after the reload below)
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
    COP [10] ( #$0D00, #02, #$02F0, #$0290 ) ; reloads this scene (area 0, scene $0D): arrival animation 2, hero at ($02F0,$0290)
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
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_01B438 ) ; index 0 = Yes: 'No, I can't believe this' plus the long text; index 1 = No: the long text only
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
    COP [09] ( #$8000 )   ; event flag $0000: Turbo starts to run (gv_npc_turbo_01B967)
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
    COP [85] ( @gv_obj_the_end_text_01B508 )
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

---------------------------------------------
; Prints THE END.
; 
; When: spawned by gv_npc_lisa_epilogue_01B33A (COP 85) at the end of the closing scene.
; Sees: the words THE END, which then scroll.
; Why: the text is printed by PrintTextString and moved by decrementing scroll_bg3_x.
; In: actor script, X = own slot.
; Out: vram_upload_flags |= 2, a wait of 2 frames, scroll_bg3_x = $FF, THE END printed (gv_epilogue_texts.TheEndText), then scroll_bg3_x is decremented once per frame for $FF frames.
; Clobbers: A, Y.

gv_obj_the_end_text_01B508 {
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

; Turbo, Lisa's goat.
; 
; When: meta type $5E in A00S0D (tile ($2A,$29)).
; Sees: a goat that plays animation $24 until Lisa sets event flag $0000, then animation $1B four times, $24 once and $1B eight times; the lines 'BLEEEET!' and 'Hurry up Turbo!' are printed by Lisa's actor.
; Why: the actor has no other behaviour; the flag is the cue.
; In: actor script, X = own slot.
; Out: COP 91 and RTL after the sequence; the goat stays on screen.
; Clobbers: A.

gv_npc_turbo_01B967 {
    COP [07] ( #$8000, &code_01B974 )
    COP [80] ( #24 )
    COP [82]
    BRA gv_npc_turbo_01B967
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