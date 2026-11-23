; The airship dock scene, the soldier's dream and the airship deck pieces of King Magridd's castle (the first script starts at file offset 154394, SNES $04:DB1A; the file is interleaved with the dungeon, tower and text files, so its scripts are not contiguous). Scenes: A13S01 the dock (location $71, the top of the right tower), A13S02 the deck of the airship (location $72, the boss arena of mc_boss_demon_falcon_004BEE), A13S03 the soldier's dream (location $73). Walkthrough chapter: docs/walkthrough/07-king-magridds-castle.md ('Dr. Leo', the Mobile Key, the Demon Falcon).
; 
; === WHAT RUNS HERE ===
; A13S01 (PlacementA13S01): $31 soldier (tile $23,$18, released by lair record $16E), $32 soldier (tile $1A,$18, flip X, record $181), $33 Dr. Leo (tile $1B,$18, record $183) and the key wheel $05. A13S02: $03, $06 (fast BG2 scroll), $34 (return to the dock) and $39 (push zones). A13S03: $3B the dreamer (tile $13,$18), $3C and $3D (tiles $13,$19 and $17,$0F), and $07 the BG2 scroll. All script work is done by the actors: the cutscene is a chain of flags between them.
; 
; === THE DOCK SCENE (flags) ===
; $0000: Dr. Leo has been talked to (set by his talk handler code_025FE4; the soldier $31 starts and clears it); later set three times by the strikes of intruder b (mc_dock_scene_actor_end_anim_25_07_025E54), each pushing the soldier $32 back. $0001: the shot has hit (set by mc_dock_soldier_start_ship_shot_025B84); Leo and the other soldier wake up. $0002: the leader of the four scene actors has finished (set by mc_dock_scene_actor_d_025E26). $0003: releases the four scene actors. $0005: the outburst of the soldier $32 is over. $0006: the explosion chain has ended (set by mc_dock_explosion_chain_02699C). $0007: the escort has walked in (set by mc_dock_scene_escort_026961, cleared and set again by Leo). $0805: the whole scene is done (set after the Mobile Key is handed over; read by the castle town actors). $0901: Leo has made his farewell speech. $0902: Lisa has asked her question. $0900: the airship has come back from the deck (set by mc_deck_airship_return_026D80; read by the key wheel, Leo and Lisa). $1F05: when set, Leo's script ends at once (COP 86); it is set outside this file.
; 
; === ITEMS, MUSIC, SCENES ===
; Item $23 = the Mobile Key ('Key to Airship. Plug into a keyhole located somewhere on the ship', DescMobileKey) is given by Leo at tile ($1E,$18) and needed by the key wheel at tile ($17,$0F). COP 32 / COP 31 are music changes: track $00 (stop) before the shot, $0D for the intruders, $13 after the explosions. COP 10 words: $0110 = area $10 scene $01 (the castle town A10S01), $0113 = A13S01 dock, $0213 = A13S02 deck.
; 
; === DIALOGUE AND RESULT ===
; Before the scene the soldiers $16E and $181 ask the hero to free Dr. Leo from the prison of the left tower (arrival children). When both are free Leo says: 'You are <name>. Birds from GreenWood told me of you. The stones you have collected are keys to open the gate to the World of Evil ... King Magridd holds the last stone. We have to free him to get the last stone. Go then to the World of Evil and defeat Deathtoll.' Then the soldier says 'Doctor, we can finally start our ship' and is shot; the intruders enter (the text addresses 'Queen Magridd' and says 'You destroyed the world!', OQ-I039-7); Leo is held and Lisa is brought in ('Daddy! I knew I would see you, but not like this'); Leo gives in ('I cannot sacrifice peoples lives anymore. But please, release Lisa'); the hero walks up behind him and receives the Mobile Key ('Here, take this and get on the airship. Please take care of Lisa.'); the explosions end the scene. Walkthrough: 'Walk up behind him to get the Mobile Key' and 'Head to the wheel at the front ... to use the Mobile Key if you have it equipped'. After the deck boss the hero is returned to the dock; Leo ('I am going to sleep. When a scientist with my knowledge is needed, I will be back.') and Lisa ('Are you a real human being like me?', with a Yes / No prompt) say goodbye.
; The dream (A13S03) is the dreaming soldier's monologue about his research ('I have been haunted by a monster called research. ... Tools are there to make peoples lives easier'), then 'Please, let me off somewhere!' and 'Dr-Leo, you may be right. But I must take you to Magridd castle ...'. It ends with flag $0803 and a scene change back to the castle town, where the sleeper wakes up and gives the Elemental Mail (OQ-I039-1).
; Every text ends with a jump to mc_return_prompt_and_chest_hint_texts.asciistring_0270DF (window clear and wait).
---------------------------------------------

?BANK 04

?INCLUDE 'engine_scheduler_sprites_combat_collision'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'mc_return_prompt_and_chest_hint_texts'
?INCLUDE 'shared_choice_prompt_texts'

!joy_block_mask                 0326
!scroll_bg2_x                   033E
!scroll_bg2_y                   0340
!map2_width_px                  0346
!map2_height_px                 0348
!ratio_x_bg2                    034E
!ratio_y_bg2                    0350
!scene_sprite_attr              0372
!bg2_offset_x                   038A
!bg2_offset_y                   038C
!player_actor                   039C
!push_zone_list                 03D8
!push_zone_bank                 03DA
!asset_cache_tilemap1           0419
!random_mod_result              0437
!text_delay                     1B84
!cgram_buffer                   7F0000

---------------------------------------------

; The soldier at the dock who starts the ship (switch $16E).
; 
; When: placement script (type $31, tile ($23,$18) of A13S01); COP 14 returns until lair record $16E is released. COP 30 spawns the arrival child on a return through it.
; Sees: unless flag $0805 is set (then he ends) puff, blocked tiles and the talk handler 'Are you <name>? Please see to Dr-Leo.'; after Dr. Leo has been talked to (flag $0000) he turns (COP 97), says 'Doctor, we can finally start our ship.', stops the music, spawns the shot, waits for flag $0001, falls (BRK $04, animations $27-$29) and stays down.
; Why: the start of the dock cutscene; the soldier is the first casualty.
; In: X = D = the soldier slot.
; Out: RTL; the last animation ends the script with COP 83 (the actor keeps its last frame).
; Clobbers: A.

mc_dock_soldier_start_ship_025B1A {
    COP [14] ( #$016E, &code_025B21 )
    RTL 
}

code_025B21 {
    COP [30] ( #$016E, &mc_dock_soldier_start_ship_arrival_025B98, #04 )
    COP [07] ( #$8805, &code_025B81 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [17] ( &code_025B93 )
    COP [05] ( #$0000 )
    COP [09] ( #$0000 )
    COP [16]
    COP [97]
    COP [81] ( #17, #02 )
    COP [83]
    COP [01] ( &asciistring_025C7E )
    COP [32] ( #00 )
    COP [B2] ( @mc_dock_soldier_start_ship_shot_025B84, #$0080, #$0000, #$0200 ) ; the shot: +$80 px, flags $0200 (cannot be hit)
    BRK #$5B
    COP [05] ( #$0001 )   ; waits for flag $0001 (set by the shot when its animation ends)
    BRK #$04
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    COP [97]
    COP [80] ( #27 )
    COP [82]
    COP [81] ( #28, #08 )
    COP [83]
    COP [81] ( #29, #08 )
    COP [83]
}

code_025B81 {
    COP [86]
    RTL 
}

---------------------------------------------
; The shot that hits the soldier.
; 
; When: spawned by mc_dock_soldier_start_ship_025B1A, at +$80 px, flags $0200 (cannot be hit).
; Sees: animation $25 for $10 frames, then flag $0001 set.
; Why: the delay and signal of the hit; the other actors wait for flag $0001.
; In: X = D = the child.
; Out: flag $0001 set; COP 86 ends the child.
; Clobbers: A.

mc_dock_soldier_start_ship_shot_025B84 {
    COP [97]
    COP [81] ( #25, #10 )
    COP [83]
    COP [09] ( #$8001 )
    COP [86]
    RTL 
}

code_025B93 {
    COP [01] ( &asciistring_025C65 )
    RTL 
}

---------------------------------------------
; The arrival child of the dock soldier: where to find Dr. Leo.
; 
; When: spawned by COP 30 on a return through lair record $16E.
; Sees: switch $183 (Leo's lair) clear: 'Please save Dr-Leo. He must be in the prison of the left tower!!'; set but $181 clear: 'Please save my friend! He must be in the same prison that Dr-Leo is in.'; both set: 'Please come to the airship dock as soon as possible. Dr-Leo is waiting for you.'
; Why: the walkthrough (Right Tower): 'The end result is releasing two soldiers, Dr. Leo, and a Fairy Gem'; this is the in-game pointer to the prison.
; In: X = D = the child.
; Out: RTL after COP 86.
; Clobbers: A.

mc_dock_soldier_start_ship_arrival_025B98 {
    COP [14] ( #$0183, &code_025BA3 )
    COP [01] ( &asciistring_025BB3 )
    RTL 
}

code_025BA3 {
    COP [14] ( #$0181, &code_025BAE )
    COP [01] ( &asciistring_025BEB )
    RTL 
}

code_025BAE {
    COP [01] ( &asciistring_025C22 )
    RTL 
}

asciistring_025BB3 |[10][0E:3C]Please save Dr-Leo- [N]He must be in the [N]prison of the left [N]tower!! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025BEB |[10][0E:3C]Please save my friend![N]He must be in the same[N]prison that Dr-Leo [N]is in- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025C22 |[10][0E:3C]Please come to the [N]airship dock as soon [N]as possible- [FIN]Dr-Leo is waiting for [N]you- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025C65 |[10]Are you [02:2]? [FIN]Please see to Dr-Leo- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025C7E |[10]Doctor, we can finally[N]start our ship- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; The second dock soldier who shouts and brings in the intruders (switch $181).
; 
; When: placement script (type $32, tile ($1A,$18), flip X); COP 14 returns until lair record $181 is released.
; Sees: unless flag $0805 (then he ends): puff, a wait for flag $0001, a $65 frame loop, animation $2A and the shout 'Dok!!', music track $0D, four scene actors spawned at +$80 / +$90 px (flags $0040), a wait for flag $0002, the exchange 'You are Queen Magridd! You destroyed the world! Didn't you realize?!' / 'Shut up wimp! Defeat him!', flag $0003 (releases the four), then three rounds (COP 03 / 04) of: wait for flag $0000 (the strike of intruder b), clear it, move 2 px (the actor's $00 -= 2) with BRK $44; then his fall (animations $27-$29) and flag $0005.
; Why: the cutscene climax; the speaker identities are not fixed by the data (OQ-I039-7).
; In: X = D = the soldier slot.
; Out: flag $0005 set at the end.
; Clobbers: A, the actor's $00 (x position).

mc_dock_soldier_outburst_025CA6 {
    COP [14] ( #$0181, &code_025CAD )
    RTL 
}

code_025CAD {
    COP [07] ( #$8805, &code_025D40 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [05] ( #$0001 )
    COP [03] ( #65 )
    COP [04]
    COP [16]
    COP [96]
    COP [81] ( #2A, #02 )
    COP [83]
    COP [01] ( &asciistring_025D43 )
    COP [32] ( #0D )
    COP [B2] ( @mc_dock_scene_actor_a_025DA5, #$0080, #$FFF0, #$0040 )
    COP [B2] ( @mc_dock_scene_actor_b_025DCE, #$0080, #$0000, #$0040 )
    COP [B2] ( @mc_dock_scene_actor_c_025DFD, #$0080, #$0010, #$0040 )
    COP [B2] ( @mc_dock_scene_actor_d_025E26, #$0090, #$0000, #$0040 )
    COP [05] ( #$0002 )   ; waits for flag $0002 (set by scene actor d)
    COP [01] ( &asciistring_025D4D )
    COP [09] ( #$8003 )   ; flag $0003 releases the four scene actors
    COP [03] ( #03 )
    COP [05] ( #$0000 )
    COP [09] ( #$0000 )
    LDA $0000, X
    SEC 
    SBC #$0002
    STA $0000, X
    BRK #$44
    COP [04]
    COP [05] ( #$0004 )
    COP [96]
    COP [80] ( #27 )
    COP [82]
    COP [81] ( #28, #08 )
    COP [83]
    COP [81] ( #29, #08 )
    COP [83]
    COP [09] ( #$8005 )
}

code_025D40 {
    COP [86]
    RTL 
}

asciistring_025D43 |[10]Dok!! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025D4D |[10]You are Queen Magridd![FIN]You destroyed the [N]world! [N]Didn t you realize?! [FIN][10]Shut up wimp! [FIN]Defeat him! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

---------------------------------------------
; One of the four intruders (a).
; 
; When: spawned by mc_dock_soldier_outburst_025CA6 (+$80,-$10 px, flags $0040).
; Sees: animation $17, a wait for flag $0003, then three rounds (COP 03 / 04) of animation $24, a child that plays animation $25 for $20 frames, and animation $2B; then a wait for flag $0006 and COP 86.
; Why: the intruders strike a pose; their identity is not fixed (OQ-I039-7).
; In: X = D = the child slot.
; Out: COP 86 ends it when the explosions are over.
; Clobbers: A.

mc_dock_scene_actor_a_025DA5 {
    COP [97]
    COP [81] ( #17, #02 )
    COP [83]
    COP [05] ( #$0003 )
    COP [03] ( #03 )
    COP [80] ( #24 )
    COP [82]
    COP [B0] ( @mc_dock_scene_actor_end_anim_25_20_025E4B, #$0040 )
    COP [80] ( #2B )
    COP [82]
    COP [04]
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

---------------------------------------------
; The second intruder (b); also plays the strike sound.
; 
; When: spawned by mc_dock_soldier_outburst_025CA6 (+$80, 0).
; Sees: the same three rounds as intruder a but with the end child mc_dock_scene_actor_end_anim_25_07_025E54 and BRK $1B in each round, then flag $0004 and the wait for flag $0006.
; Why: part of the cutscene staging.
; In: X = D = the child slot.
; Out: flag $0004 set, COP 86 at the end.
; Clobbers: A.

mc_dock_scene_actor_b_025DCE {
    COP [97]
    COP [81] ( #17, #02 )
    COP [83]
    COP [05] ( #$0003 )
    COP [03] ( #03 )
    COP [80] ( #24 )
    COP [82]
    COP [B0] ( @mc_dock_scene_actor_end_anim_25_07_025E54, #$0040 )
    BRK #$1B
    COP [80] ( #2B )
    COP [82]
    COP [04]
    COP [09] ( #$8004 )
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

---------------------------------------------
; The third intruder (c).
; 
; When: spawned by mc_dock_soldier_outburst_025CA6 (+$80,+$10).
; Sees: as intruder a (end child animation $25 for $20 frames).
; Why: cutscene staging.
; In: X = D = the child slot.
; Out: COP 86 when flag $0006 is set.
; Clobbers: A.

mc_dock_scene_actor_c_025DFD {
    COP [97]
    COP [81] ( #17, #02 )
    COP [83]
    COP [05] ( #$0003 )
    COP [03] ( #03 )
    COP [80] ( #24 )
    COP [82]
    COP [B0] ( @mc_dock_scene_actor_end_anim_25_20_025E4B, #$0040 )
    COP [80] ( #2B )
    COP [82]
    COP [04]
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

---------------------------------------------
; The fourth intruder (d), the one who speaks first.
; 
; When: spawned by mc_dock_soldier_outburst_025CA6 (+$90, 0).
; Sees: a $51 frame wait, COP AA (palette $00), animation $1A for 2 frames, animation $11, a $3D frame loop, then flag $0002 (the outburst script goes on) and a wait for flag $0006.
; Why: the speaker whose text is shown by the outburst actor.
; In: X = D = the child slot.
; Out: flag $0002 set, COP 86 at the end.
; Clobbers: A.

mc_dock_scene_actor_d_025E26 {
    COP [03] ( #51 )
    COP [04]
    COP [AA] ( #00 )
    COP [97]
    COP [81] ( #1A, #02 )
    COP [83]
    COP [80] ( #11 )
    COP [82]
    COP [03] ( #3D )
    COP [04]
    COP [09] ( #$8002 )
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

---------------------------------------------
; A short child that plays animation $25 for $20 frames.
; 
; When: spawned by intruder a and c (flags $0040).
; Sees: the animation, then COP 86.
; Why: a one-off effect (the strike).
; In: X = D = the child slot.
; Out: COP 86.
; Clobbers: A.

mc_dock_scene_actor_end_anim_25_20_025E4B {
    COP [81] ( #25, #20 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; A short child that plays animation $25 for 7 frames, then sets flag $0000.
; 
; When: spawned by intruder b (flags $0040).
; Sees: the animation, flag $0000 set, then COP 86.
; Why: each strike sets flag $0000, which releases one round of the outburst soldier's wait (three strikes).
; In: X = D = the child slot.
; Out: flag $0000 set.
; Clobbers: A.

mc_dock_scene_actor_end_anim_25_07_025E54 {
    COP [81] ( #25, #07 )
    COP [83]
    COP [09] ( #$8000 )
    COP [86]
    RTL 
}
---------------------------------------------

; Dr. Leo at the dock (switch $183).
; 
; When: placement script (type $33, tile ($1B,$18), A13S01); COP 14 returns until lair record $183 (the prison of the right tower, location $6C) is released. COP 30 spawns the arrival child on a return through that record.
; Sees: flag $1F05 set: COP 86; flag $0805 set: mc_dock_dr_leo_lisa_spawner_025FAF; otherwise puff, blocked tiles and, when the soldiers of $16E and $181 are both free, the talk handler code_025FE4 (the speech), then mc_dock_dr_leo_hostage_scene_025E98; if one is still captive the talk handler is code_025FDF ('I am Dr-Leo. I will save the story for later. Please save the two soldiers who promised to come with me.').
; Why: the quest giver of the last chapter of the castle.
; In: X = D = the slot of Leo.
; Out: RTL.
; Clobbers: A.

mc_dock_dr_leo_025E61 {
    COP [14] ( #$0183, &code_025E68 )
    RTL 
}

code_025E68 {
    COP [30] ( #$0183, &mc_dock_dr_leo_arrival_02601D, #04 )
    COP [07] ( #$9F05, &code_025FDC )
    COP [07] ( #$8805, &mc_dock_dr_leo_lisa_spawner_025FAF )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [14] ( #$016E, &code_025E8B )
    BRL loc_025E91
}

code_025E8B {
    COP [14] ( #$0181, &mc_dock_dr_leo_hostage_scene_025E98 )

  loc_025E91:
    COP [17] ( &code_025FDF )
    COP [91]
    RTL 
}

---------------------------------------------
; The dock cutscene seen from Dr. Leo's side.
; 
; When: entered from mc_dock_dr_leo_025E61 once both soldiers are free; after the talk handler code_025FE4 (the speech) the buttons are blocked and flag $0000 is set.
; Sees: a wait for flag $0001 (the shot), animation $23, the hero's animation set to $03 (SetActorAnimFrame on the player actor, with X saved), a wait for flag $0005, 'You took everything away from me. You are dirtier than evil!', 'Dr-Leo, you talk too much. Life is never easy. Look!', 'Hey, keep walking', the escort and Lisa spawned at -$90 / -$A0 px, the exchange with the intruder (flags $0007 handshakes), the whisper '<name>, stay behind me', the buttons freed, and the hero walking up to tile ($1E,$18), which goes on in mc_dock_dr_leo_key_handover_025F43.
; Why: the story of the dock; the walkthrough only summarises it.
; In: X = D = Leo; $joy_block_mask is changed (TRB then TSB the mask $6FC0).
; Out: RTL.
; Clobbers: A, X is saved around the player animation call.

mc_dock_dr_leo_hostage_scene_025E98 {
    COP [17] ( &code_025FE4 )
    COP [05] ( #$0001 )
    COP [96]
    COP [80] ( #23 )
    COP [82]
    PHX 
    LDX $player_actor
    LDA #$0003
    STA $001E, X
    STZ $0020, X
    JSL $@engine_scheduler_sprites_combat_collision.SetActorAnimFrame
    PLX 
    COP [05] ( #$0005 )   ; waits for flag $0005 (set at the end of the outburst script)
    COP [16]
    COP [81] ( #26, #02 )
    COP [83]
    COP [80] ( #23 )
    COP [82]
    COP [15]
    COP [01] ( &asciistring_026240 )
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_02626D )
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &asciistring_0262A0 )
    COP [B2] ( @mc_dock_lisa_arrives_0266E8, #$0040, #$FF70, #$0040 )
    COP [B2] ( @mc_dock_scene_escort_026961, #$0040, #$FF60, #$0040 )
    COP [05] ( #$0007 )   ; waits for flag $0007 (set by the escort)
    COP [01] ( &asciistring_0262B9 )
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_0262ED )
    COP [03] ( #5B )
    COP [04]
    LDA #$0004
    STA $text_delay
    COP [01] ( &asciistring_026382 )
    LDA #$0003
    STA $text_delay
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_026458 )
    COP [09] ( #$0007 )   ; clears flag $0007 so the escort can set it again at the end of its walk
    COP [05] ( #$0007 )
    COP [01] ( &asciistring_02648E )
    LDA #$6FC0
    TRB $joy_block_mask
    COP [91]
    COP [0D] ( #00, #1E, #18, &mc_dock_dr_leo_key_handover_025F43 ) ; the hero stands on tile ($1E,$18), behind Leo
    RTL 
}

---------------------------------------------
; Leo gives the Mobile Key and the explosions end the scene.
; 
; When: the hero stands on tile ($1E,$18) behind Leo (COP 0D from mc_dock_dr_leo_hostage_scene_025E98).
; Sees: the buttons blocked, 'Here, take this and get on the airship. Please take care of Lisa.', BRK $5E, item $23 (Mobile Key), 'I will not run away. Just take me wherever you want.', 'Lisa, please forgive me', the explosion chain, a wait for flag $0006, music track $13, a $79 frame loop, flag $0805 set, buttons freed, and the later talk handler code_025FF7 (Leo's farewell, flag $0901).
; Why: the Mobile Key opens the airship's wheel (walkthrough).
; In: X = D = Leo.
; Out: flag $0805 set; the talk handler is installed.
; Clobbers: A.

mc_dock_dr_leo_key_handover_025F43 {
    LDA #$6FC0
    TSB $joy_block_mask
    COP [01] ( &asciistring_0264C3 )
    BRK #$5E
    COP [0A] ( #23 )      ; item $23 = the Mobile Key
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_026509 )
    COP [16]
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #23 )
    COP [82]
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &asciistring_026533 )
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #23 )
    COP [82]
    COP [B0] ( @mc_dock_explosion_chain_02699C, #$0300 )
    COP [03] ( #3D )
    COP [04]
    COP [80] ( #22 )
    COP [82]
    COP [15]
    COP [05] ( #$0006 )   ; waits for flag $0006 (the explosion chain is over)
    COP [03] ( #15 )
    COP [04]
    COP [31] ( #13 )
    COP [03] ( #79 )
    COP [04]
    COP [09] ( #$8805 )   ; flag $0805: the dock scene is done
    LDA #$6FC0
    TRB $joy_block_mask

  loc_025FA8:
    COP [17] ( &code_025FF7 )
    COP [91]
    RTL 
}

---------------------------------------------
; Leo's state after the scene: spawns Lisa.
; 
; When: flag $0805 is set when Leo's script starts.
; Sees: with flag $0900 clear Lisa is spawned at ($0230,$0180) as mc_dock_lisa_crying_0266FC; with it set (the airship came back) as mc_dock_lisa_question_02670A at ($0220,$0190); then Leo moves +$80 px, flips, animation $22 and the talk handler code_025FF7: before the farewell flag $0901 the speech 'I think I was born in the wrong generation ... Lisa, be happy', after it '--------'.
; Why: the dock looks different before and after the airship ride.
; In: X = D = Leo.
; Out: RTL.
; Clobbers: A.

mc_dock_dr_leo_lisa_spawner_025FAF {
    COP [07] ( #$8900, &code_025FC2 )
    COP [AC] ( @mc_dock_lisa_crying_0266FC, #$0230, #$0180, #$0040 )
    BRA loc_025FCD
}

code_025FC2 {
    COP [AC] ( @mc_dock_lisa_question_02670A, #$0220, #$0190, #$0040 )

  loc_025FCD:
    COP [9F] ( #$0080 )
    COP [96]
    COP [80] ( #22 )
    COP [82]
    COP [15]
    BRA loc_025FA8
}

code_025FDC {
    COP [86]
    RTL 
}

code_025FDF {
    COP [01] ( &asciistring_0260F6 )
    RTL 
}

code_025FE4 {
    COP [01] ( &asciistring_026144 )
    LDA #$6FC0
    TSB $joy_block_mask
    COP [09] ( #$8000 )
    COP [17] ( #$0000 )
    RTL 
}

code_025FF7 {
    COP [07] ( #$8900, &code_026018 )
    COP [07] ( #$8901, &code_026018 )
    LDA #$0004
    STA $text_delay
    COP [01] ( &asciistring_026551 )
    LDA #$0003
    STA $text_delay
    COP [09] ( #$8901 )
    RTL 
}

code_026018 {
    COP [01] ( &asciistring_0266DB )
    RTL 
}

---------------------------------------------
; The arrival child of Dr. Leo.
; 
; When: spawned by COP 30 on a return through lair record $183.
; Sees: switch $181 clear or $16E clear: 'I am Dr-Leo. I will save the story for later. Please save the two soldiers who promised to come with me.'; both set: 'I am Dr-Leo. I have been watching from the darkness. I am going to retrieve the Black Stone, go to the World of Evil and defeat Deathtoll. I hope you will come with me. The airship dock is at the top floor of the right tower. I will be waiting for you.'
; Why: the walkthrough: 'go southwest and speak with the soldier if you want, then go west to find Dr. Leo'.
; In: X = D = the child.
; Out: RTL after COP 86.
; Clobbers: A.

mc_dock_dr_leo_arrival_02601D {
    COP [14] ( #$0181, &code_026025 )
    BRA loc_02602B
}

code_026025 {
    COP [14] ( #$016E, &code_026032 )

  loc_02602B:
    COP [01] ( &asciistring_0260F0 )
    COP [86]
    RTL 
}

code_026032 {
    COP [01] ( &asciistring_026039 )
    COP [86]
    RTL 
}

asciistring_026039 |[10][0E:3C]I am Dr-Leo- [N]I have been watching [N]from the darkness- [FIN]I am going to retrieve[N]the Black Stone, go [N]to the World of Evil [N]and defeat Deathtoll- [FIN]I hope you will come [N]with me- [FIN]The airship dock is at[N]the top floor of the [N]right tower- [FIN]I will be waiting for [N]you- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0260F0 |[10][0E:3C][JMP:&asciistring_0260F6+M]|

asciistring_0260F6 |[10][::]I am Dr-Leo- [N]I will save the story [N]for later- [FIN]Please save the two [N]soldiers who promised [N]to come with me- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026144 |[10]You are [02:2]- [N]Birds from GreenWood [N]told me of you- [FIN]The stones you have [N]collected are keys to [N]open the gate to the [N]World of Evil- [FIN]They are the Origins [N]of Power for machines [N]that beckon evil- [FIN]King Magridd holds the[N]last stone- [FIN]We have to free him to[N]get the last stone- [FIN]Go then to the World [N]of Evil and defeat [N]Deathtoll- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

asciistring_026240 |[10]You took everything [N]away from me- [FIN]You are dirtier than [N]evil! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_02626D |[10]Dr-Leo, you talk too [N]much- [FIN]Life is never easy- [N]Look! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0262A0 |[10]Hey, keep walking- [0E:28][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF+M]|

asciistring_0262B9 |[10]Daddy! [FIN]Daddy! I knew [N]I would see you, [N]but not like this---- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0262ED |[10]Dr-Leo, [N]you will still do what[N]I say? [FIN][10]You-------- [FIN]As you said, I made a [N]machine to call [N]Deathtoll! [FIN]Lisa has nothing to do[N]with this- [FIN][10]Shut up! [FIN]Dr-Leo, you still [N]have to work for us- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026382 |[10]All right- [FIN]I cannot sacrifice [N]peoples  lives [N]anymore- [FIN]But please, release [N]Lisa- [FIN]She is the most [N]precious thing in this[N]world- [FIN]Even if I could not [N]see her, she would [N]still be my [N]motivation- [FIN]I can endure anything [N]by just imagining her [N]face- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026458 |[10]You are an honest man-[FIN]All right, Dr-Leo- [N]Leave Lisa alone- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_02648E |[10][0F]Leo whispered in [N][02:2] s ears- [0F][FIN][0A][02:2],[N]stay█behind█me----[JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0264C3 |[10][0A]Here,█take█this█and[N]get█on█the█airship-[FIN]Please█take█care█of[N]Lisa-[JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026509 |[10]I will not run away- [N]Just take me wherever [N]you want- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026533 |[10][0F]Lisa, [N][0E:3C]please forgive me- [N][0E:50][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF+M]|

asciistring_026551 |[10][02:2], I think [N]I was born in the [N]wrong generation- [FIN]Scientists are [N]supposed to invent [N]machines in order to [N]make people happy- [FIN]But an unexpected [N]scientist may ruin the[N]culture- [FIN]Some people believe [N]happiness comes [N]quickly, [FIN]I think it comes with [N]patientce- [FIN]Lisa, I am sorry for [N]leaving you- [FIN]I am not passing away,[N]rather, [N]I am going to sleep- [FIN]When a scientist with [N]my knowledge is [N]needed, I will be [N]back- [FIN][0A]Lisa,█be█happy-[N]But█don t█rush[N]yourself-[N][0E:28]Yes,█gradually--------[JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0266DB |[10]-------- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

---------------------------------------------
; Lisa as she is brought into the dock scene.
; 
; When: spawned by mc_dock_dr_leo_hostage_scene_025E98 at -$90 px; the code falls through into mc_dock_lisa_crying_0266FC.
; Sees: animation $09 for 3 frames, animation $03, a wait for flag $0006 (the explosions), animation $09.
; Why: named from the text of its talk handler ('Lisa just keeps crying'); the identity of the walker is by flow, not by a name field (OQ-I039-7).
; In: X = D = the child.
; Out: continues as mc_dock_lisa_crying_0266FC.
; Clobbers: A.

mc_dock_lisa_arrives_0266E8 {
    COP [81] ( #09, #03 )
    COP [83]
    COP [80] ( #03 )
    COP [82]
    COP [05] ( #$0006 )
    COP [80] ( #09 )
    COP [82]
}

---------------------------------------------
; Lisa after the scene and before the airship ride.
; 
; When: entered from mc_dock_lisa_arrives_0266E8, or spawned by mc_dock_dr_leo_lisa_spawner_025FAF at ($0230,$0180) while flag $0900 is clear.
; Sees: animation $03, blocked tiles, the talk handler 'Lisa just keeps crying.'
; Why: ambience.
; In: X = D = the actor.
; Out: RTL; COP 91 resumes at the talk handler.
; Clobbers: A.

mc_dock_lisa_crying_0266FC {
    COP [80] ( #03 )
    COP [82]
    COP [15]
    COP [17] ( &code_026736 )
    COP [91]
    RTL 
}

---------------------------------------------
; Lisa after the airship ride (flag $0900 set).
; 
; When: spawned by mc_dock_dr_leo_lisa_spawner_025FAF at ($0220,$0190).
; Sees: flag $0902 set: the farewell only ('I would say goodbye, but I know I am going to cry. Please leave while my back is turned.'). Otherwise the talk handler asks 'Hello. Thank you for staying with me while my father passed away ... Ever since you saved me at Grass Valley ... Are you a real human being like me?' with ChoiceYesNoText; both answers lead to 'I see ... I feel like you are far away ... You are going to fight Deathtoll, right?' and flag $0902.
; Why: the walkthrough: 'Speak with Lisa and respond to her question as desired.' There is no branch in the ROM: both answers show the same text.
; In: X = D = the actor; L_choice_result is not read.
; Out: flag $0902 set after the answer.
; Clobbers: A.

mc_dock_lisa_question_02670A {
    COP [07] ( #$8902, &code_026723 )
    COP [97]
    COP [80] ( #08 )
    COP [82]
    COP [15]
    COP [17] ( &code_02673B )
    COP [05] ( #$0902 )
    COP [16]
}

code_026723 {
    COP [17] ( &code_026753 )
    COP [80] ( #09 )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [15]
    COP [91]
    RTL 
}

code_026736 {
    COP [01] ( &asciistring_026758 )
    RTL 
}

code_02673B {
    COP [01] ( &asciistring_026772 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_026746 )
}

code_026746 {
    COP [01] ( &asciistring_026874 )
    COP [17] ( &code_026753 )
    COP [09] ( #$8902 )
    RTL 
}

code_026753 {
    COP [01] ( &asciistring_026921 )
    RTL 
}

asciistring_026758 |[10][0F]Lisa just keeps [N]crying- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026772 |[10]Hello- Thank you for [N]staying with me while [N]my father passed away-[FIN]I didn t think I would[N]see him again- [FIN]But because of you I [N]was finally able to [N]see him again- [FIN]Ever since you saved [N]me at Grass Valley, [N]I imagined you [N]fighting monsters [N]whenever I closed my [N]eyes- [FIN]By the way, [N]I would like you to [N]answer my questions- [FIN]Are you a real human [N]being like me? [END]|

asciistring_026874 |I see --------- [FIN]I feel like you are [N]far away even though [N]you are right in front[N]of me- [FIN]I feel like you are [N]watching us from the [N]sky- [FIN]I don t know how to [N]express the way I [N]feel- [FIN]But that is okay, [N]I, I love--- [FIN]You are going to fight[N]Deathtoll, right? [FIN][JMP:&asciistring_026921+M]|

asciistring_026921 |[10][::]I would say goodbye, [N]but I know I am going [N]to cry- [FIN]Please leave while my [N]back is turned- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

---------------------------------------------
; The walker behind Lisa (spawned with her).
; 
; When: spawned by mc_dock_dr_leo_hostage_scene_025E98 at -$A0 px, flags $0040.
; Sees: animations $15 and $12, flag $0007 set (Leo waits for it), then it waits until Leo clears the flag, sets the actor bit $1000 in $16, flips, walks (animation $17), flag $0007 again, waits for flag $0006 and ends.
; Why: speaks 'Hey, keep walking' in the cutscene; named by position only (OQ-I039-7).
; In: X = D = the child.
; Out: COP 86.
; Clobbers: A.

mc_dock_scene_escort_026961 {
    COP [81] ( #15, #03 )
    COP [83]
    COP [80] ( #12 )
    COP [82]
    COP [09] ( #$8007 )
    COP [05] ( #$8007 )
    LDA $0016, X
    ORA #$1000
    STA $0016, X
    COP [96]
    COP [80] ( #17 )
    COP [82]
    COP [81] ( #15, #03 )
    COP [83]
    COP [97]
    COP [80] ( #17 )
    COP [82]
    COP [09] ( #$8007 )
    COP [05] ( #$0006 )
    COP [86]
    RTL 
}

---------------------------------------------
; The chain of explosions at the end of the dock scene.
; 
; When: spawned by mc_dock_dr_leo_key_handover_025F43 with flags $0300.
; Sees: a COP 03 / 04 loop of $40 rounds, each spawning mc_dock_explosion_0269B5 and waiting 2 frames (COP 1B); at the end flag $0006 is set and the actor ends.
; Why: the finale of the scene; flag $0006 releases every waiting actor.
; In: X = D = the child.
; Out: flag $0006 set.
; Clobbers: A.

mc_dock_explosion_chain_02699C {
    COP [03] ( #40 )
    COP [B0] ( @mc_dock_explosion_0269B5, #$0300 ) ; one explosion per round; with COP 1B (2 frames) and the $40 round loop it runs about 128 frames
    COP [1B] ( &code_0269AC, #$0002 )
}

code_0269AC {
    COP [04]
    COP [09] ( #$8006 )
    COP [86]
    RTL 
}

---------------------------------------------
; One explosion sprite.
; 
; When: spawned by mc_dock_explosion_chain_02699C.
; Sees: animation table $0E (COP A8), the scene sprite attribute copied into $1C, a random offset of up to +-$20 px (mc_dock_explosion_jitter_0269CF), BRK $85 and animation $00, then COP 86.
; Why: the burst effect.
; In: X = D = the child.
; Out: COP 86.
; Clobbers: A.

mc_dock_explosion_0269B5 {
    COP [A8] ( #$8000, #0E )
    COP [A3]
    LDA $scene_sprite_attr
    STA $001C, X
    JSR $&mc_dock_explosion_jitter_0269CF
    BRK #$85
    COP [80] ( #00 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Moves the explosion by a random offset in x and y.
; 
; When: JSR from mc_dock_explosion_0269B5.
; Sees: two times COP 1F / COP 35 #$40 and a subtract of $20, added to the actor's x and y.
; Why: spreads the explosions.
; In: X = D = the explosion.
; Out: x ($00) and y ($02) changed; RTS.
; Clobbers: A.

mc_dock_explosion_jitter_0269CF {
    COP [1F]
    COP [35] ( #40 )      ; random 0-$3F minus $20 = an offset of up to +-$20 px
    LDA $random_mod_result
    SEC 
    SBC #$0020
    CLC 
    ADC $0000, X
    STA $0000, X
    COP [1F]
    COP [35] ( #40 )
    LDA $random_mod_result
    SEC 
    SBC #$0020
    CLC 
    ADC $0002, X
    STA $0002, X
    RTS 
}
---------------------------------------------

; The dreamer's monologue (A13S03).
; 
; When: placement script (type $3B, tile ($13,$18)); runs once when the scene loads (the hero was sent here by the sleeper's Dream Rod text in the castle town).
; Sees: CGRAM colour 0 set to $2C81 in the buffer, COP 34, the buttons blocked, animation $23, 'I have been haunted by a monster called research ... I don't want to believe this beautiful world will be destroyed.', animation $1F, 'Please, let me off somewhere!', flag $0000, a wait for flag $0001, 'Dr-Leo, you may be right. But I must take you to Magridd castle and make sure you do not escape ...', flag $0803, COP 3C, a scene change to the castle town at the sleeper's bed, and the buttons freed.
; Why: the walkthrough: 'After a rather thought-provoking scene, you will be given the Elemental Armor' (OQ-I039-1); the dream is the soldier's.
; In: X = D = the slot of the dreamer; $joy_block_mask is changed.
; Out: flag $0803 set; the scene changes.
; Clobbers: A.

mc_dream_soldier_dialogue_026A4E {
    LDA #$2C81
    STA $cgram_buffer
    COP [03] ( #02 )
    COP [04]
    COP [34]
    LDA #$6FC0
    TSB $joy_block_mask
    COP [80] ( #23 )
    COP [82]
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &asciistring_026AA6 )
    COP [80] ( #1F )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_026C9D )
    COP [09] ( #$8000 )
    COP [05] ( #$0001 )
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_026CBE )
    COP [09] ( #$8803 )   ; flag $0803: the dream is over (read by the sleeper in the castle town)
    COP [3C] ( #04 )
    COP [10] ( #$0110, #01, #$0020, #$01F0 ) ; scene change to A10S01 (castle town) at pixel ($0020,$01F0), the sleeper's tile ($02,$1F)
    LDA #$6FC0
    TRB $joy_block_mask
    RTL 
}

asciistring_026AA6 |[10]I have been haunted by[N]a monster called [N]"research-ˮ [FIN]I would not pay [N]attention to my wife [N]and daughter- [FIN]Still I didn t [N]understand- [FIN]I was praised as a [N]genius, scientist and [N]even the King often [N]gave me orders- [FIN]I kept inventing [N]things, Water Mill, [N]Elevator, and even [N]this Airship- [FIN]Finally I invented [N]a machine to call upon[N]evil, only to [N]realize something- [FIN]Tools are there to [N]make peoples  lives [N]easier- [FIN]But when tools start [N]to use people, [FIN]their culture will [N]decline and they will [N]become unhappy- [FIN]When I get to the [N]World of Evil, [N]Deathtoll will be [N]called- [FIN]I don t want to [N]believe this beautiful[N]world will be [N]destroyed- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026C9D |[10]Please, let me off [N]somewhere! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_026CBE |[10]Dr-Leo, [N]you may be right- [FIN]But I must take you to[N]Magridd castle and [N]make sure you do not [N]escape- [FIN]I have to worry about [N]the present, [N]not tomorrow- [FIN]I must do my job or be[N]punished- [FIN]Please try to [N]understand this- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; A dream actor that answers the first text.
; 
; When: placement script (type $3C, tile ($13,$19) of A13S03).
; Sees: animation $14, a wait for flag $0000, animation $13 and flag $0001, then COP 91.
; Why: lets the dreamer's second text start.
; In: X = D = the slot.
; Out: flag $0001 set.
; Clobbers: A.

mc_dream_actor_a_026D61 {
    COP [80] ( #14 )
    COP [82]
    COP [05] ( #$0000 )
    COP [80] ( #13 )
    COP [82]
    COP [09] ( #$8001 )
    COP [91]
    RTL 
}
---------------------------------------------

; A dream actor that only shows a pose.
; 
; When: placement script (type $3D, tile ($17,$0F) of A13S03).
; Sees: blocked tiles, animation $13, COP 91.
; Why: a prop of the dream.
; In: X = D = the slot.
; Out: RTL.
; Clobbers: A.

mc_dream_actor_b_026D76 {
    COP [15]
    COP [80] ( #13 )
    COP [82]
    COP [91]
    RTL 
}
---------------------------------------------

; Returns the hero from the airship deck to the dock after the boss.
; 
; When: placement script (type $34 of A13S02); COP 14 returns until switch $195 (the Demon Falcon lair) is released; COP 3B holds the actor until then.
; Sees: the actor bit $0010 cleared, then the hero standing on tile ($17,$0F): '<name> drove the Airship back to the dock.', flag $0900 set, BRK $91 and a scene change to A13S01 at ($0170,$00F0).
; Why: the way back after the fight; flag $0900 changes the key wheel, Leo and Lisa.
; In: X = D = the slot.
; Out: flag $0900 set; the scene changes.
; Clobbers: A.

mc_deck_airship_return_026D80 {
    COP [14] ( #$0195, &code_026D8C )
    COP [3B] ( #$0195, &code_026D9E )
}

code_026D8C {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [91]
    COP [0D] ( #00, #17, #0F, &code_026D9F )
}

code_026D9E {
    RTL 
}

code_026D9F {
    COP [01] ( &asciistring_026DB6 )
    COP [09] ( #$8900 )   ; flag $0900: the airship has come back (read by the key wheel, Leo and Lisa)
    STZ $asset_cache_tilemap1
    BRK #$91
    COP [10] ( #$0113, #01, #$0170, #$00F0 ) ; scene change to A13S01 (dock) at pixel ($0170,$00F0), the wheel tile ($17,$0F)
    RTL 
}

asciistring_026DB6 |[10][02:2] drove [N]the Airship back to [N]the dock- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; Scrolls the deck's second background by -8 px per frame.
; 
; When: placement script (type $06 of A13S02), every frame.
; Sees: bg2_offset_y -= 8.
; Why: the clouds of the flight.
; In: X = D = the slot.
; Out: bg2_offset_y changed.
; Clobbers: A.

mc_deck_bg2_scroll_y_fast_026F48 {
    LDA $bg2_offset_y
    SEC 
    SBC #$0008
    STA $bg2_offset_y
    RTL 
}
---------------------------------------------

; Scrolls the dream's second background by -1 px per frame.
; 
; When: placement script (type $07 of A13S03), every frame.
; Sees: DEC bg2_offset_y.
; Why: slow background of the dream.
; In: X = D = the slot.
; Out: bg2_offset_y changed.
; Clobbers: A.

mc_dream_bg2_scroll_y_026F53 {
    DEC $bg2_offset_y
    RTL 
}
---------------------------------------------

; The key wheel of the airship (dock, A13S01).
; 
; When: placement script (type $05).
; Sees: flag $0900 set (already flown) or the Mobile Key not equipped (COP 19 on item $23): it only returns; otherwise when the hero stands on tile ($17,$0F) the take-off is started (mc_dock_key_wheel_start_026F6A).
; Why: the walkthrough: 'Head to the wheel at the front (north side (bow)) of it to use the Mobile Key if you have it equipped. And, yes, you must use it.' (the walkthrough's 'another boss fight' follows).
; In: X = D = the slot.
; Out: RTL.
; Clobbers: A.

mc_dock_key_wheel_026F57 {
    COP [07] ( #$8900, &code_026F69 ) ; flag $0900 set: the wheel is dead after the flight
    COP [19] ( #23, &code_026F69 ) ; item $23 (Mobile Key) not equipped: no take-off
    COP [0D] ( #00, #17, #0F, &mc_dock_key_wheel_start_026F6A )
}

code_026F69 {
    RTL 
}

---------------------------------------------
; Starts the take-off sequence.
; 
; When: the hero is on the wheel tile with the Mobile Key.
; Sees: the buttons blocked (mask $2F80) and a 2 frame delay into mc_dock_takeoff_scroll_026F76 (COP 1B).
; Why: gives the engine two frames before the scene scrolls.
; In: X = D = the wheel.
; Out: the resume pointer is set.
; Clobbers: A.

mc_dock_key_wheel_start_026F6A {
    LDA #$2F80
    TSB $joy_block_mask
    COP [1B] ( &mc_dock_takeoff_scroll_026F76, #$0002 )
}

---------------------------------------------
; The take-off: the background scrolls sideways.
; 
; When: after mc_dock_key_wheel_start_026F6A.
; Sees: 'plugged in the starting key.', BRK $4F, then bg2_offset_x is decremented every frame until scroll_bg2_x is 0 (BRK $4A) and a $46 frame delay into mc_dock_takeoff_zoom_026FA1.
; Why: the ship lifting off.
; In: X = D = the wheel.
; Out: the actor stays alive while scrolling.
; Clobbers: A.

mc_dock_takeoff_scroll_026F76 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_026FF9 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    BRK #$4F
    COP [91]
    LDA $scroll_bg2_x
    BEQ loc_026F99
    DEC $bg2_offset_x
    RTL 

  loc_026F99:
    BRK #$4A
    COP [1B] ( &mc_dock_takeoff_zoom_026FA1, #$0046 )
}

---------------------------------------------
; The take-off: the background scrolls up and the ship flies away.
; 
; When: after mc_dock_takeoff_scroll_026F76.
; Sees: BRK $91; bg2_offset_y is decremented every frame until scroll_bg2_y is 0; then the BG2 ratios are cleared, the map size is $200 px and a 16 step loop scrolls bg2_y with growing speed ($30 counts 2 to $10) before the scene changes to A13S02 at ($0170,$00F0).
; Why: the flight to the boss arena.
; In: X = D = the wheel.
; Out: the scene changes.
; Clobbers: A, $30 (own).

mc_dock_takeoff_zoom_026FA1 {
    BRK #$91
    COP [91]
    LDA $scroll_bg2_y
    BEQ loc_026FAE
    DEC $bg2_offset_y
    RTL 

  loc_026FAE:
    STZ $ratio_x_bg2
    STZ $ratio_y_bg2
    LDA #$0200
    STA $map2_width_px
    STA $map2_height_px
    LDA #$0002
    STA $0030, X

  loc_026FC3:
    COP [03] ( #10 )
    LDA $scroll_bg2_y
    SEC 
    SBC $0030, X
    STA $scroll_bg2_y
    COP [04]
    INC $0030, X
    LDA $0030, X
    CMP #$0010
    BCC loc_026FC3
    STZ $asset_cache_tilemap1
    COP [10] ( #$0213, #01, #$0170, #$00F0 ) ; scene change to A13S02 (the airship deck) at pixel ($0170,$00F0)
    COP [03] ( #10 )
    LDA $scroll_bg2_y
    SEC 
    SBC $0030, X
    STA $scroll_bg2_y
    COP [04]
    RTL 
}

asciistring_026FF9 |[10][02:2] plugged [N]in the starting key- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; Picks the push zone table of the airship deck.
; 
; When: placement script (type $39 of A13S02), once at scene load.
; Sees: push_zone_list = mc_deck_push_zone_records_02702B, push_zone_bank = bank 4, then COP 86.
; Why: the hero slides south on the deck in the marked rectangles.
; In: X = D = the slot, M = 8 bits for the bank byte.
; Out: push_zone_list and push_zone_bank set.
; Clobbers: A, Y.

mc_deck_push_zones_027019 {
    SEP #$20
    LDY #$&mc_deck_push_zone_records_02702B
    STY $push_zone_list
    LDA #$^mc_deck_push_zone_records_02702B
    STA $push_zone_bank
    REP #$20
    COP [86]
    RTL 
}
---------------------------------------------

; The push zones of the airship deck: eight records.
; 
; When: read by ScanPushZones via push_zone_list.
; Sees: rectangles x $16-$19 / y $06-$0D, $15-$17 / $0D-$14, $18-$1A / $0D-$14, $17-$18 / $10-$14, $13-$1C / $14-$1E, $13-$16 / $1E-$23, $19-$1C / $1E-$23, $16-$19 / $23-$29, all with dx = 0, dy = +1.
; Why: the hero is moved south on the deck.
; In: n/a (data, 6-byte records).
; Out: n/a.
; Clobbers: n/a.

mc_deck_push_zone_records_02702B [
  unk16 < #16, #19, #06, #0D, #$0000, #$0001 >   ;00
  unk16 < #15, #17, #0D, #14, #$0000, #$0001 >   ;01
  unk16 < #18, #1A, #0D, #14, #$0000, #$0001 >   ;02
  unk16 < #17, #18, #10, #14, #$0000, #$0001 >   ;03
  unk16 < #13, #1C, #14, #1E, #$0000, #$0001 >   ;04
  unk16 < #13, #16, #1E, #23, #$0000, #$0001 >   ;05
  unk16 < #19, #1C, #1E, #23, #$0000, #$0001 >   ;06
  unk16 < #16, #19, #23, #29, #$0000, #$0001 >   ;07
]