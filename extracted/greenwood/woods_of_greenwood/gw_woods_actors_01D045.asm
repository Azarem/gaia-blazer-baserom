; The second half of the GreenWood animals (file offsets 118853-124027 and 125395-125691, SNES $03:D045-$E47A and $03:E9D3-$EAFA, bank 03; the marsh actors lie in between): the squirrel and the dog of the Woodstin-Trio, the Guardian of the Woods, the Phoenix bird, the five moles of the mole hole, the three squirrels of the tree hollows and Turbo's raft, the actors of the two dream rooms and the wave effect of the Woods. The first half (the restaurant, the deer of the trio, the other dogs, birds and crocodiles) is gw_woods_actors_01B98D. How a freed animal works (COP 14 / COP 3B switch, appear puff, talk handler, hint objects) is described in that block's note.
; 
; === ROSTER (meta type, scene, switch = lair record, creature, lair of the record) ===
; $1C gw_npc_squirrel_billy_01D045: A04S01, switch $5D, 'a squirrel' (third Fire Shrine scene, Ghost Heads, gate $4A): Billy, the leader of the Woodstin-Trio.
; $1D gw_npc_dog_woodstin_trio_01D2F3: A04S01, switch $3F, 'a dog' (Lostside marsh, Mud Men, gate $4A): the trio's second sidekick.
; $1E gw_npc_guardian_of_the_woods_01D4F9: A04S01, switch $50, the Guardian of the Woods (the boss lair of the Light, Water and Fire Statues, location $22).
; $1F gw_actor_empty_01D614: A04S01, no switch, an actor that only returns.
; $20 gw_npc_bird_phoenix_hint_01D615: A04S01, switch $64, 'a bird' (third Fire Shrine scene, Metal Scorpions, formation of 10).
; $21-$26 the moles of the mole hole (A04S02) and Monmo (A04S01): $21 gw_npc_mole_soul_of_light_01D6AB switch $49 (second Water Shrine scene, Mud Men), $22 gw_npc_mole_ghost_ribbon_01D8C8 switch $51 (third Water Shrine scene, Stone Statues), $23 gw_npc_mole_digger_01D98E switch $62 (third Fire Shrine scene, Fire Men), $24 gw_npc_mole_prankster_01DB3F switch $5C (third Fire Shrine scene, Fire Men), $25 gw_npc_mole_roommate_bracelet_01DBE5 switch $40 (Lostside marsh, Mud Men), $26 gw_npc_mole_monmo_01DDB7 switch $72 (second Light Shrine scene, Fire Men).
; $27 gw_npc_squirrel_turbo_raft_01DF73: A04S03, switch $4F, 'a squirrel' (third Water Shrine scene, Stone Statues).
; $28 gw_npc_squirrel_exchanger_01E005 and $29 gw_npc_squirrel_master_emblem_c_01E1C0: A04S04, switches $43 ('a squirrel', first Water Shrine scene, Walking Plants) and $41 ('a squirrel', first Light Shrine scene, Fire Men).
; $4E gw_npc_mole_light_return_voice_01D857 and $4F gw_npc_squirrel_exchanger_return_voice_01E134: A04S01, off the map at ($00,$C8), switches $49 and $43: the voices from the holes that speak when the hero comes back.
; $43 gw_npc_bird_birds_dream_01E241 and $44 gw_npc_turbo_ghost_01E2FB: A04S05, the Bird's Dream (switch $74, a record without lair); $45 gw_npc_bird_stumps_dream_01E3E2: A04S06, the Stump's Dream.
; $46 gw_effect_wave_hdma_01E9D3: the wave effect of the Woods, placed in A04S01 and A04S06.
; 
; === THE SHOW OF THE WOODSTIN-TRIO (Billy, the deer of gw_woods_actors_01B98D and the dog) ===
; The three actors never talk to each other except through the event flags $0000-$0007 of byte 0 of event_flags ($1A5E). COP 05 waits until a flag is set, COP 09 sets or clears it. Billy and the dog use COP 3B: while their lair is not released they are held (talk handler shared_actor_helpers_bank3.cm_npc_captive_plea_01B191, 'Please, someone help me!', then engine_player_death_and_actor_helpers.HoldActorUntilReleased); the deer uses COP 14.
; Round 1 (the transformation, walkthrough: 'speak with the one in the lead and he'll first transform his buddies into squirrels like him'): the hero talks to Billy: 'The band is back together, so let's start the show!', flag $0003 is set. The deer waits for $0003, dances, plays animation $00 (the squirrel look) and sets $0004. The dog waits for $0004, dances, sets $0005. Billy waits for $0005, clears it and offers the game. The text routines for the three are code_01D0E3 (Billy), code_01BC21 (deer) and code_01D3EA (dog).
; Round 2 (the guessing game): Billy's second talk: 'you must try and guess the real squirrel, me ... Here we go!' sets flag $0006. The deer and the dog wait for $0006 and start to shuffle (animations $03-$05, flips); Billy clears $0006 in the middle of his own shuffle (118951). Afterwards each of the three has a talk handler that says 'Okay, let's see if I really am Billy': the deer and the dog set $0006 and $0007 (a wrong pick), Billy sets $0000 and $0007 (the right pick; walkthrough: 'he is always the rightmost squirrel'). Flag $0007 releases the other two waits: the deer and the dog puff back (animation $0C) and say 'Too bad, almost' or, when $0000 is set, 'I hope you liked our show'; Billy says 'Too bad, but please try again soon' when $0006 is set, otherwise 'You're right!! Okay, I will give you a present' and gives the Medical Herb (item $38). Leaving and re-entering the scene starts the show again (the walkthrough: 'you play as much as desired (just leave and re-enter the area to play again)'). The flags are plain event flags; no run of the protocol was traced in the emulator (OQ-I035-5), and the boss of the Lostside marsh clears the whole of event_flags byte 0 (OQ-I035-8).
; 
; === THE MOLE HOLE (A04S02) ===
; Five moles live in the hole: $21 (the Soul of Light) at tile ($18,$14), $22 (the ghost of the mole who loved Monmo) at ($0E,$19), $23 (the digger) at ($0A,$0C), $24 (the prankster) at ($04,$0D) and $25 (the roommate) at ($0E,$1D). The sixth mole, Monmo, lives in the Woods at ($29,$0E) (type $26). The walkthrough: the Soul of Light joins the hero (souls_flags bit $02, flag $0303; he lights the dark rooms of the Lostside shrines); Monmo has to be led to her hole at tile ($0E,$1F); the Mole's Ribbon is in the chest next to the hole she enters; the ghost takes the ribbon (item $1F) and vanishes (flag $0403); the roommate then gives the Shield Bracelet (item $36); the leaves of GreenWood (item $1E) are under the dog bones at tile ($19,$19), a pickup that the Soul of Light's root spawns (code_01D803). Flags: $0303 the Soul of Light has joined, $0304 the leaves were taken, $0307 Monmo is at her hole (the digger's hint text changes), $0400 the digger told the story, $0403 the ghost has gone, $0907 set by the digger's entry when $0307 and $0400 are clear and the hero holds the ribbon (no reader found, OQ-I035-6). COP 07 with bit 15 of its operand clear jumps when the flag is clear: the digger tests $0307 and $0400 that way.
; 
; === THE HOLLOWS (A04S03, A04S04) AND THE DREAM ROOMS (A04S05, A04S06) ===
; Turbo's raft squirrel (A04S03) tells that Turbo used branches to make the raft; the exchanger squirrel gives the Psycho Sword (item $02) for the Delicious Seeds (item $25) that the hero holds as the equipped item; the emblem squirrel gives the Master's Emblem C (item $2C, flag $1A02). The Bird's Dream and the Stump's Dream are entered with the Dream Rod from the Woods (gw_woods_actors_01B98D); Turbo's ghost sets flag $0402, the bird then lets the hero out.
; 
; === OTHER FLAGS ===
; $0507 the Guardian has given the Green Stone; $1B01 set at the same moment (read by gv_up_above_actors_and_name_entry, OQ-I035-7); $0402 the ghost has spoken (read by the bird, the guard dog and the grave bird in gw_woods_actors_01B98D); $1A02 the emblem was given.
; 
; === NOTES ===
; - The extracted text prints the font's hyphen as '+', so 'Woodstin+Trio' is the walkthrough's 'Woodstin-Trio'. 'Tiki' (the bird of the raft) is named only by Turbo's ghost (OQ-I035-9).
; - gw_effect_wave_hdma_01E9D3 writes two HDMA tables for the registers $210D and $210E, the values coming from scroll_bg2_x / y ($033E, $0340); the table gw_wave_offsets_01EA7B follows the code (OQ-I035-16).
---------------------------------------------

?BANK 03

?INCLUDE 'engine_player_death_and_actor_helpers'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'gw_watching_over_world_return_prompt_texts'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'shared_actor_helpers_bank3'

!frame_counter                  0312
!scroll_bg2_x                   033E
!scroll_bg2_y                   0340
!scroll_delta_x                 0382
!scroll_delta_y                 0384
!asset_cache_tilemap1           0419
!souls_flags                    1B82

---------------------------------------------

; Billy, the leader of the Woodstin-Trio, on the theater stage; held in a cage until his lair is cleared.
; 
; When: meta type $1C, switch $5D (name $0E 'a squirrel'; lair record $5D in the third Fire Shrine scene, Ghost Heads, formation 7; gate switch $4A, the deer). Placed at tile ($20,$12) of A04S01. While the lair is not cleared COP 3B holds him: 'Please, someone help me!' (shared_actor_helpers_bank3.cm_npc_captive_plea_01B191), then HoldActorUntilReleased.
; Sees: after the release a puff and a squirrel; talked to: 'I am Billy, leader of the Woodstin-Trio. Our show is really exciting!' Once the deer and the dog are free (COP 14 $4A and $3F) he says 'The band is back together, so let's start the show!' and the other two transform; after the dance he explains the guessing game and shuffles (animations $05, $03, $04 with flips); the hero talks to the squirrel he thinks is Billy. A right guess: 'You're right!! Okay, I will give you a present' and a Medical Herb; a wrong one: 'Too bad, but please try again soon' (walkthrough: 'You gain Medical Herbs for winning').
; Why: the whole show is driven by flags $0003-$0007 (block note), Billy being the master of the protocol.
; In: actor script, X = own slot.
; Out: loops in his talk handlers (code_01D12F at the end: 'I hope you liked our show').
; Clobbers: A.

gw_npc_squirrel_billy_01D045 {
    COP [3B] ( #$005D, &code_01D05B )
    COP [17] ( &shared_actor_helpers_bank3.cm_npc_captive_plea_01B191 )
    SEP #$20
    LDA #$^engine_player_death_and_actor_helpers.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_player_death_and_actor_helpers.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_01D05B {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [17] ( &code_01D0DE )
    COP [91]
    COP [14] ( #$004A, &code_01D06F )
    RTL 
}

code_01D06F {
    COP [14] ( #$003F, &code_01D076 )
    RTL 
}

code_01D076 {
    COP [17] ( &code_01D0E3 )
    COP [05] ( #$0005 )   ; waits (until set) for flag $0005, set by the dog after its dance, then clears it
    COP [09] ( #$0005 )
    COP [16]
    COP [81] ( #04, #02 )
    COP [83]
    COP [80] ( #00 )
    COP [82]
    COP [17] ( &code_01D0F0 )
    COP [15]
    RTL 
}

code_01D096 {
    COP [16]
    COP [17] ( #$0000 )
    COP [81] ( #05, #03 )
    COP [83]
    COP [80] ( #03 )
    COP [82]
    COP [09] ( #$0006 )
    COP [87]
    COP [81] ( #05, #06 )
    COP [83]
    COP [80] ( #04 )
    COP [82]
    COP [87]
    COP [81] ( #05, #03 )
    COP [83]
    COP [87]
    COP [81] ( #05, #03 )
    COP [83]
    COP [80] ( #00 )
    COP [82]
    COP [15]
    COP [17] ( &code_01D101 )
    COP [05] ( #$0007 )
    COP [17] ( &code_01D10E )
    COP [91]
    RTL 
}

code_01D0DE {
    COP [01] ( &asciistring_01D134 )
    RTL 
}

code_01D0E3 {
    COP [01] ( &asciistring_01D174 )
    COP [17] ( #$0000 )
    COP [09] ( #$8003 )   ; flag $0003 starts the show: the deer waits for it
    RTL 
}

code_01D0F0 {
    COP [01] ( &asciistring_01D1E5 )
    COP [09] ( #$8006 )   ; flag $0006 set: the deer and the dog start to shuffle (Billy clears it again at 118951)
    COP [27] ( &code_01D096 )
    COP [01] ( &asciistring_01D291 )
    RTL 
}

code_01D101 {
    COP [01] ( &asciistring_01D49D )
    COP [09] ( #$8000 )   ; flag $0000: the right pick, the real Billy was chosen
    COP [09] ( #$8007 )   ; flag $0007: a pick was made, the reveal starts for all three
    RTL 
}

code_01D10E {
    COP [07] ( #$8006, &code_01D126 )
    COP [09] ( #$8006 )
    COP [01] ( &asciistring_01D291 )
    BRK #$5E
    COP [0A] ( #38 )      ; item $38 is the Medical Herb
    COP [17] ( &code_01D12F )
    RTL 
}

code_01D126 {
    COP [01] ( &asciistring_01D2D3 )
    COP [17] ( &code_01D12F )
    RTL 
}

code_01D12F {
    COP [01] ( &asciistring_01D4D0 )
    RTL 
}

asciistring_01D134 |[10]I am Billy, leader of [N]the "Woodstin+Trioˮ, -[N]Our show is really [N]exciting! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D174 |[10]The band is back [N]together, so let s [N]start the show! [FIN]Even though you are [N]our only audience we [N]will try our best- [FIN]Please watch the two [N]other guys- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D1E5 |[10]How did you like it? [FIN]For our next number [N]you must try and guess[N]the real squirrel, me-[FIN]We will move around [N]and if you choose [N]correctly, you will [N]win a prize- [FIN]Please talk with whom [N]you think the real [N]squirrel is- [FIN]Here we go! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D291 |[10]You re right!! [N]Okay, I will give you [N]a present- [FIN][02:2] received [N][03:24]the Medical Herb- [03:20][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D2D3 |[10]Too bad, but please [N]try again soon- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The dog of the Woodstin-Trio; caged like Billy until his lair is cleared.
; 
; When: meta type $1D, switch $3F (name $17 'a dog'; lair record $3F in the Lostside marsh, Mud Men, gate $4A). Placed at tile ($22,$10) of A04S01; held by COP 3B until the release.
; Sees: 'I am a member of the Woodstin-Trio. We put on a variety show in this theater. I need my other two band members to start the show.' When the squirrel and the deer are free he waits for the deer's flag $0004, dances (COP A1 moves of 8 pixels, animations $0C-$0E), puffs, plays animation $02 and, after 60 frames, animation $00 (the squirrel look), then sets flag $0005 for Billy. While the show runs: 'Hey, don't walk around here.' In round 2 it waits for $0006, shuffles and, when talked to, says 'Okay, let's see if I really am Billy' and sets $0006 and $0007; after $0007 it puffs back (animation $0C) and says 'Too bad, almost' or, if $0000 is set, 'I hope you liked our show'.
; Why: see the block note, the show of the Woodstin-Trio.
; In: actor script, X = own slot.
; Out: ends in code_01D3FC.
; Clobbers: A.

gw_npc_dog_woodstin_trio_01D2F3 {
    COP [3B] ( #$003F, &code_01D309 )
    COP [17] ( &shared_actor_helpers_bank3.cm_npc_captive_plea_01B191 )
    SEP #$20
    LDA #$^engine_player_death_and_actor_helpers.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_player_death_and_actor_helpers.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_01D309 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01D3E5 )
    COP [15]
    COP [91]
    COP [14] ( #$005D, &code_01D31D )
    RTL 
}

code_01D31D {
    COP [14] ( #$004A, &code_01D324 )
    RTL 
}

code_01D324 {
    COP [17] ( &code_01D3EA )
    COP [05] ( #$0004 )   ; waits for flag $0004 from the deer; sets $0005 at 119676 and waits for $0006 (119691) and $0007 (119758)
    COP [16]
    COP [17] ( #$0000 )
    COP [A1] ( #$0008, #$0008 )
    COP [81] ( #0C, #03 )
    COP [83]
    COP [A1] ( #$FFF8, #$FFF8 )
    COP [87]
    COP [81] ( #0E, #03 )
    COP [83]
    COP [87]
    COP [A1] ( #$0008, #$0008 )
    COP [81] ( #0D, #03 )
    COP [83]
    COP [A1] ( #$FFF8, #$FFF8 )
    COP [81] ( #0E, #03 )
    COP [83]
    COP [9F] ( #$0010 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    BRK #$4E
    COP [80] ( #02 )
    COP [82]
    COP [1B] ( &code_01D37C, #$003C )
}

code_01D37C {
    COP [09] ( #$8005 )
    COP [80] ( #00 )
    COP [82]
    COP [15]
    COP [17] ( &code_01D3EA )
    COP [05] ( #$0006 )
    COP [16]
    COP [17] ( #$0000 )
    COP [80] ( #03 )
    COP [82]
    COP [81] ( #05, #06 )
    COP [83]
    COP [80] ( #04 )
    COP [82]
    COP [87]
    COP [81] ( #05, #03 )
    COP [83]
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #05 )
    COP [82]
    COP [87]
    COP [80] ( #05 )
    COP [82]
    COP [80] ( #04 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    COP [15]
    COP [17] ( &code_01D3EF )
    COP [05] ( #$0007 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    BRK #$4E
    COP [80] ( #0C )
    COP [82]
    COP [17] ( &code_01D3FC )
    COP [91]
    RTL 
}

code_01D3E5 {
    COP [01] ( &asciistring_01D410 )
    RTL 
}

code_01D3EA {
    COP [01] ( &asciistring_01D481 )
    RTL 
}

code_01D3EF {
    COP [01] ( &asciistring_01D49D )
    COP [09] ( #$8006 )
    COP [09] ( #$8007 )
    RTL 
}

code_01D3FC {
    COP [07] ( #$8000, &code_01D40B )
    COP [01] ( &asciistring_01D4BB )
    COP [17] ( &code_01D40B )
    RTL 
}

code_01D40B {
    COP [01] ( &asciistring_01D4D0 )
    RTL 
}

asciistring_01D410 |[10]I am a member of the [N]"Woodstin+Trio-ˮ [N]We put on a variety [N]show in this theater- [FIN]I need my other two [N]band members to start [N]the show- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D481 |[10]Hey, don t walk around[N]here- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

asciistring_01D49D |[10]Okay, let s see if [N]I really am Billy- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D4BB |[10]Too bad, almost- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D4D0 |[10]I hope you liked [N]our show- [N]See you later- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The Guardian of the Woods: an invisible actor with a tile trigger that gives the Green Stone once the boss lair of the three statues is cleared.
; 
; When: meta type $1E, switch $50 (name $12 'Wood's guardian'; lair record $50, the boss lair in the Tomb of a stone statue, location $22). Placed off the map at ($00,$C8) of A04S01; no animation is set, he is only a script.
; Sees: when the hero walks onto tile ($17,$0D) (COP 0D slot 0) after a short pause: 'I am the Guardian of the Woods. I have been watching the world for a long time. <name>, a dog named Turbo has buried something near my roots. You will need this Green Stone someday, so please take it.' and 'received the Green Stone' (item $3B). Flag $0507 makes it once-only. When the hero returns from the boss room a one-shot text actor (COP 30) says 'I am the Guardian of the Woods. Thank you for releasing me. I will give you the Green Stone upon your return.' (walkthrough: 'Once you exit, you will be told that Turbo ... buried the Green Stone near the roots of the Guardian; you quickly then retrieve it').
; Why: flag $1B01 is set together with the stone (OQ-I035-7).
; In: actor script, X = own slot.
; Out: waits for the tile (COP 91 re-entry).
; Clobbers: A.

gw_npc_guardian_of_the_woods_01D4F9 {
    COP [14] ( #$0050, &code_01D500 )
    RTL 
}

code_01D500 {
    COP [30] ( #$0050, &code_01D531, #03 )
    COP [91]
    COP [0D] ( #00, #17, #0D, &code_01D511 ) ; slot 0 is the hero: the trigger tile ($17,$0D)
    RTL 
}

code_01D511 {
    COP [07] ( #$8507, &code_01D52E )
    COP [1B] ( &code_01D51D, #$0002 )
}

code_01D51D {
    COP [01] ( &asciistring_01D53A )
    BRK #$5E
    COP [0A] ( #3B )      ; item $3B is the Green Stone
    COP [09] ( #$8507 )
    COP [09] ( #$9B01 )   ; flag $1B01 = the Green Stone was given (flags $1B00-$1B05 pair with stones $3A-$3F); gv_up_above_actors_and_name_entry reads $1B00-$1B05 for its path markers
}

code_01D52E {
    COP [91]
    RTL 
}

code_01D531 {
    COP [01] ( &asciistring_01D5CE )
    COP [37]
    COP [86]
    RTL 
}

asciistring_01D53A |[10]I am the [N]Guardian of the Woods-[FIN]I have been watching [N]the world for a long [N]time- [FIN][02:2], a dog named [N]Turbo has buried [N]something near my [N]roots- [FIN]You will need this [N]Green Stone someday, [N]so please take it- [FIN][02:2] received [N][03:24]the Green Stone- [03:20][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D5CE |[10][0E:3C]I am the Guardian of [N]the Woods- Thank you [N]for releasing me- [FIN]I will give you the [N]Green Stone upon your [N]return- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; An actor that only returns.
; 
; When: meta type $1F, placed at tile ($0D,$04) of A04S01.
; Sees: nothing; the one instruction is RTL.
; Why: the meta type slot exists in MetaGreenwood and is placed, but nothing is drawn or run (possibly a cut feature; the walkthrough does not mention anything at this spot).
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: nothing.

gw_actor_empty_01D614 {
    RTL 
}
---------------------------------------------

; A bird in the far northeast of the Woods who hints at the Phoenix.
; 
; When: meta type $20, switch $64 (name $16 'a bird'; lair record $64 in the third Fire Shrine scene, 10 Metal Scorpions, formation $08; the walkthrough calls the scorpions invulnerable at first). Placed at tile ($29,$04) of A04S01, flipped.
; Sees: a bird that hops between animation $1D and its mirror image every 40 frames; talked to: 'I heard of the Phoenix's magic when I visited the Soul of the Mountain. If you collect the three symbols, you should visit the Mountain King.'
; Why: the hint toward the Phoenix quest (docs/walkthrough/items.md: the Red-Hot Mirror is one of three items needed for the Phoenix; the shy bird of gw_woods_actors_01B98D gives it).
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

gw_npc_bird_phoenix_hint_01D615 {
    COP [14] ( #$0064, &code_01D61C )
    RTL 
}

code_01D61C {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01D635 )

  loc_01D625:
    COP [80] ( #1D )
    COP [82]
    COP [1B] ( &code_01D630, #$0028 )
}

code_01D630 {
    COP [87]
    BRL loc_01D625
}

code_01D635 {
    COP [01] ( &asciistring_01D63A )
    RTL 
}

asciistring_01D63A |[10]I heard of the [N]Phoenix s magic when I[N]visited the Soul of [N]the Mountain- [FIN]If you collect the [N]three symbols, you [N]should visit the [N]Mountain King- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The first mole of the mole hole: he joins the hero as the Soul of Light and spawns the leaves under the dog bones.
; 
; When: meta type $21, switch $49 (name $13 'a mole'; lair record $49 in the second Water Shrine scene, Mud Men). Placed at tile ($18,$14) of A04S02, flipped (walkthrough: 'Go into the hole just north of him and speak with the mole at the end of the path').
; Sees: when the switch is set a puff and the mole; talked to: 'Even though I don't look like it, I am from the sky just like you. I light up the darkness. You cheer up everyone. Let's work together to revive the world.' and 'The creature who lights up darkness joined <name>!' (souls_flags bit $02, flag $0303). Afterwards, unless the squirrel $4F and the mole $51 are both free, 'By the way why don't we go to the second basement of the Water Shrine? You will now be able to see monsters which you could not see without me.' On later visits (flag $0303 set) the root frees its tiles, puffs and removes itself (COP 86).
; Why: the root spawns code_01D803 with COP 85 when it appears: the leaves pickup, so that the leaves of GreenWood lie under the dog bones of the mole hole.
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A, souls_flags.

gw_npc_mole_soul_of_light_01D6AB {
    COP [14] ( #$0049, &code_01D6B2 )
    RTL 
}

code_01D6B2 {
    COP [85] ( @code_01D803 )
    COP [17] ( &code_01D6D0 )
    COP [15]
    COP [91]
    COP [07] ( #$8303, &code_01D6C6 )
    RTL 
}

code_01D6C6 {
    COP [16]
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [86]
    RTL 
}

code_01D6D0 {
    COP [01] ( &asciistring_01D6F9 )
    SEP #$20
    LDA $souls_flags
    ORA #$02              ; souls_flags bit $02: the Soul of Light has joined
    STA $souls_flags
    REP #$20
    COP [09] ( #$8303 )
    BRK #$4E
    COP [14] ( #$004F, &code_01D6EE )
    BRA loc_01D6F4
}

code_01D6EE {
    COP [14] ( #$0051, &code_01D6F8 )

  loc_01D6F4:
    COP [01] ( &asciistring_01D7A2 )
}

code_01D6F8 {
    RTL 
}

asciistring_01D6F9 |[10]Even though I [N]don t look like it, [N]I am from the sky [N]just like you- [FIN]I light up the [N]darkness- [N]You cheer up everyone-[FIN]Let s work together to[N]revive the world- [FIN]The creature who [N]lights up darkness [N]joined [02:2]! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D7A2 |[10][0E:3C]By the way why don t [N]we go to the second [N]basement of the Water [N]Shrine? [FIN]You will now be able [N]to see monsters which [N]you could not see [N]without me- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

code_01D803 {
    COP [07] ( #$0304, &code_01D80C )
    COP [86]
    RTL 
}

code_01D80C {
    COP [91]
    COP [0D] ( #00, #19, #19, &code_01D816 ) ; the hero's tile ($19,$19): the dog bones with the leaves of GreenWood
    RTL 
}

code_01D816 {
    COP [01] ( &asciistring_01D826 )
    BRK #$5E
    COP [0A] ( #1E )
    COP [09] ( #$8304 )
    COP [91]
    RTL 
}

asciistring_01D826 |[10][03:24]The leaves of [N]GreenWood [03:20]are found [N]under the dog bones! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The voice from the Soul of Light's hole, a one-shot text actor for the hero's return to the Woods.
; 
; When: meta type $4E, switch $49. Placed off the map at ($00,$C8) of A04S01. COP 30 plays the text when the hero arrives through the lair record's release scene.
; Sees: 'A voice is calling <name> from the hole. I am the creature who brings light to darkness. I will help you upon your return.' (the hero went to the shrine before taking the mole along, walkthrough: 'You don't need him right now, though').
; In: actor script, X = own slot.
; Out: kills itself (COP 86).
; Clobbers: A.

gw_npc_mole_light_return_voice_01D857 {
    COP [14] ( #$0049, &code_01D85E )
    RTL 
}

code_01D85E {
    COP [30] ( #$0049, &code_01D868, #03 )
    COP [91]
    RTL 
}

code_01D868 {
    COP [01] ( &asciistring_01D86F )
    COP [86]
    RTL 
}

asciistring_01D86F |[10][0E:3C]A voice is calling [N][02:2] from [N]the hole- [FIN]I am the creature who [N]brings light to [N]darkness- I will help [N]you upon your return- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The ghost of a mole who loved Monmo; he blocks the way until he gets the Mole's Ribbon.
; 
; When: meta type $22, switch $51 (name $13 'a mole'; lair record $51 in the third Water Shrine scene, Stone Statues). Placed at tile ($0E,$19) of A04S02.
; Sees: if the hero does not wear the Mole's Ribbon (item $1F, COP 19): 'You must bring me something that once belonged to Monmo.' With the ribbon: 'Th-that's Monmo's ribbon! Al-allright, I will move if you give that to me.' The ribbon is taken (COP 0B), flag $0403 is set and the mole flickers 32 times (animation $07 with the hide bit $2000 of $16 cleared and set again) and vanishes, which clears the path; on later visits flag $0403 removes him at once.
; Why: walkthrough: 'equip the Mole's Ribbon, then speak with him. The ghostly mole will then take the ribbon in surprise before fading off to the afterlife.'
; In: actor script, X = own slot.
; Out: kills itself (COP 86 at code_01D905).
; Clobbers: A.

gw_npc_mole_ghost_ribbon_01D8C8 {
    COP [14] ( #$0051, &code_01D8CF )
    RTL 
}

code_01D8CF {
    COP [07] ( #$8403, &code_01D905 )
    COP [15]
    COP [17] ( &code_01D908 )
    COP [91]
    RTL 
}

code_01D8DE {
    COP [17] ( #$0000 )
    COP [03] ( #20 )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #07 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [80] ( #07 )
    COP [82]
    COP [04]
    COP [16]
}

code_01D905 {
    COP [86]
    RTL 
}

code_01D908 {
    COP [19] ( #1F, &code_01D91C ) ; jumps unless the Mole's Ribbon (item $1F) is equipped
    COP [01] ( &asciistring_01D94B )
    COP [0B] ( #1F )
    COP [09] ( #$8403 )   ; flag $0403: the ghost is gone for good
    COP [27] ( &code_01D8DE )
}

code_01D91C {
    COP [01] ( &asciistring_01D921 )
    RTL 
}

asciistring_01D921 |[10]You must bring [N]me something that once[N]belonged to Monmo- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01D94B |[10]Th-- that s Monmo s [N]ribbon! [FIN]Al-- allright, I will [N]move if you give that [N]to me- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The digger mole, who tells the story of the female mole and of the dog bones.
; 
; When: meta type $23, switch $62 (name $13 'a mole'; lair record $62 in the third Fire Shrine scene, Fire Men). Placed at tile ($0A,$0C) of A04S02.
; Sees: first 'I am always digging in the ground, sometimes I dig up strange things. I just dug up some dog bones to ... I got scared and re-buried them.' Once Monmo is at her hole (flag $0307 set) the handler is 'What? Did a female mole come by here? No, I am living down here alone. Oh, I think I have heard this story. There once was a cute female mole living around here. But she was taken away by evil creatures. I am scared.', and when the prankster mole $5C is free the story also sets flag $0400. With $0307 clear and $0400 set the handler would be 'I became so scared I dug a tunnel to the house next door.'; I found no way to reach that combination (OQ-I035-6).
; Why: the walkthrough: 'Speak with the other mole nearby to get some background on this'. The dog bones are the pile that hides the leaves (code_01D803). With $0307 and $0400 both clear and the Mole's Ribbon (item $1F) in the bag the entry sets flag $0907; I found no reader for it (OQ-I035-6).
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A.

gw_npc_mole_digger_01D98E {
    COP [14] ( #$0062, &code_01D995 )
    RTL 
}

code_01D995 {
    COP [15]
    COP [17] ( &code_01D9BB )
    COP [07] ( #$0307, &code_01D9A5 )
    COP [17] ( &code_01D9C0 )
}

code_01D9A5 {
    COP [07] ( #$0400, &code_01D9AF )
    COP [17] ( &code_01D9D9 )
}

code_01D9AF {
    COP [91]
    COP [18] ( #1F, &code_01D9BA )
    COP [09] ( #$8907 )   ; flag $0907 is set when $0307 and $0400 are clear and the ribbon is in the bag; it is bit number $4F of a FlagMapPatchTable row at location $16 that ApplyFlagMapPatches reads at scene load
}

code_01D9BA {
    RTL 
}

code_01D9BB {
    COP [01] ( &asciistring_01D9DE )
    RTL 
}

code_01D9C0 {
    COP [01] ( &asciistring_01DA4D )
    COP [17] ( &code_01D9D4 )
    COP [14] ( #$005C, &code_01D9CF )
    RTL 
}

code_01D9CF {
    COP [09] ( #$8400 )
    RTL 
}

code_01D9D4 {
    COP [01] ( &asciistring_01DB09 )
    RTL 
}

code_01D9D9 {
    COP [01] ( &asciistring_01DB0D )
    RTL 
}

asciistring_01D9DE |[10]I am always digging in[N]the ground, sometimes [N]I dig up strange [N]things- [FIN]I just dug up some dog[N]bones to #- [FIN]I got scared and re+ [N]buried them- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01DA4D |[10]What? Did a female [N]mole come by here? [FIN]No, I am living down [N]here alone- [FIN]Oh, I think I have [N]heard this story----- [FIN]There once was a cute [N]female mole living [N]around here- [FIN]But she was taken away[N]by evil creatures- [FIN][::]I am scared----- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01DB09 |[10][JMP:&asciistring_01DA4D+M]|

asciistring_01DB0D |[10]I became so scared I [N]dug a tunnel to the [N]house next door- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The prankster mole who jumps out at two tiles of the mole hole and cries 'BOO!'.
; 
; When: meta type $24, switch $5C (name $13 'a mole'; lair record $5C in the third Fire Shrine scene, Fire Men). Placed at tile ($04,$0D) of A04S02, flipped.
; Sees: nothing until the hero walks on tile ($05,$0B) or ($05,$0F): the mole jumps out (COP 2A, animation $0B, then animation $07 or $06 for 16 repeats, chosen by COP 9B from the side the hero stands on) and says 'BOO! ... Come on! Aren't you surprised?'; afterwards 'Phew!'. The tiles ($0E,$0D) and ($0D,$12) only re-arm the check (COP 91); the walkthrough does not mention this mole.
; Why: a joke without effect on the game.
; In: actor script, X = own slot.
; Out: waits for the tiles; after the scare its talk handler says 'Phew!'.
; Clobbers: A.

gw_npc_mole_prankster_01DB3F {
    COP [14] ( #$005C, &code_01DB46 )
    RTL 
}

code_01DB46 {
    COP [17] ( #$0000 )
    COP [91]
    COP [0D] ( #00, #05, #0B, &code_01DB69 ) ; slot 0 is the hero: the scare tiles ($05,$0B) and ($05,$0F); the tiles ($0E,$0D) and ($0D,$12) only re-arm
    COP [0D] ( #00, #05, #0F, &code_01DB69 )
    COP [0D] ( #00, #0E, #0D, &code_01DBA5 )
    COP [0D] ( #00, #0D, #12, &code_01DBA5 )
    RTL 
}

code_01DB69 {
    COP [2A] ( #$0010, #$0000 )
    COP [9B] ( #$0000, &code_01DB79, &code_01DB79, &code_01DB87 )
}

code_01DB79 {
    COP [80] ( #0B )
    COP [82]
    COP [81] ( #07, #10 )
    COP [83]
    BRL loc_01DB92
}

code_01DB87 {
    COP [80] ( #0B )
    COP [82]
    COP [81] ( #06, #10 )
    COP [83]

  loc_01DB92:
    COP [01] ( &asciistring_01DBAD )
    COP [16]
    COP [87]
    COP [80] ( #0B )
    COP [82]
    COP [15]
    COP [17] ( &code_01DBA8 )
}

code_01DBA5 {
    COP [91]
    RTL 
}

code_01DBA8 {
    COP [01] ( &asciistring_01DBDB )
    RTL 
}

asciistring_01DBAD |[10]BOO! [FIN]----------- [FIN]Come on! Aren t you [N]suprised? [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01DBDB |[10]Phew! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The roommate of the ghost mole: he gives the Shield Bracelet.
; 
; When: meta type $25, switch $40 (name $13 'a mole'; lair record $40 in the Lostside marsh, Mud Men). Placed at tile ($0E,$1D) of A04S02.
; Sees: while the ghost mole $51 is still there: 'My roommate has disappeared. Will you look for him?' After it: 'I didn't know that he was a ghost. Both of us fell in love with Monmo. One day, Monmo was captured by evil. He tried to rescue her but never came back. Suddenly he appeared, I had no idea what happened to him. Anyways, take this bracelet and revive GreenWood. I know those two moles would have liked to live here in peace.' and 'received Shield Bracelet!' (item $36); if the hero already has it: 'I am a bit jealous that he won Monmo's heart. But I hope they are happy now.'
; Why: the walkthrough: 'Speak with the mole further south for a little background and to earn the Shield Bracelet, an item halving the damage enemies deal out to you'.
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A.

gw_npc_mole_roommate_bracelet_01DBE5 {
    COP [14] ( #$0040, &code_01DBEC )
    RTL 
}

code_01DBEC {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [17] ( &code_01DBFA )
    COP [91]
    RTL 
}

code_01DBFA {
    COP [14] ( #$0051, &code_01DC05 )
    COP [01] ( &asciistring_01DD41 )
    RTL 
}

code_01DC05 {
    COP [18] ( #36, &code_01DC0F )
    COP [01] ( &asciistring_01DD72 )
    RTL 
}

code_01DC0F {
    COP [01] ( &asciistring_01DC19 )
    BRK #$5E
    COP [0A] ( #36 )      ; item $36 is the Shield Bracelet
    RTL 
}

asciistring_01DC19 |[10]I didn t know that he [N]was a ghost- [FIN]Both of us fell in [N]love with Monmo- [FIN]One day, Monmo was [N]captured by evil- He [N]tried to rescue her [N]but never came back- [FIN]Suddenly he appeared, [N]I had no idea what [N]happened to him- [FIN]Anyways, take this [N]bracelet and revive [N]GreenWood- [FIN]I know those two moles[N]would have liked to [N]live here in peace- [FIN][02:2] received [N][03:24]Shield Bracelet! [03:20][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01DD41 |[10]My roommate has [N]disappeared- Will you [N]look for him? [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01DD72 |[10]I am a bit jealous [N]that he won Monmo s [N]heart- [FIN]But I hope they are [N]happy now- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; Monmo the mole, who has to be led to her hole in the Woods and then goes home.
; 
; When: meta type $26, switch $72 (name $13 'a mole'; lair record $72 in the second Light Shrine scene, Fire Men; home tile ($29,$10)). Placed at tile ($29,$0E) of A04S01. When flag $0307 is already set the root removes her at once.
; Sees: 'My name is Monmo the mole. This place is so bright I cannot see. Would you please lead me to my house? I will follow you. Please take to the hole that leads to my home. Allright, talk to me when I am standing in the right place.' Then she follows the hero: COP 9C picks the axis, COP 9A / 9B (threshold $10) the direction, animations $09, $0A or $0B and the flip (COP 96 / COP 97); the script has no move command, so the steps come from the animation data (OQ-I035-4). Talked to while following: 'Please don't walk so fast, I can't keep up with you.' When her own tile (COP 0D with slot $16, her own row) is ($0E,$1F), the hole: 'I'll give you a present. Could you wait here?', COP 16 frees her tiles, flag $0307 is set and the root removes her (COP 86).
; Why: the walkthrough: 'You need to bring Monmo to the hole that is her home ... speak to Monmo while she's on that hole ... Monmo's actions are delayed so she'll be on the hole'; the present is the chest with the Mole's Ribbon.
; In: actor script, X = own slot.
; Out: waits in the follow loop (code_01DDDC), then kills herself.
; Clobbers: A.

gw_npc_mole_monmo_01DDB7 {
    COP [14] ( #$0072, &code_01DDBE )
    RTL 
}

code_01DDBE {
    COP [07] ( #$8307, &code_01DE5D )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01DE60 )
    COP [15]
    COP [91]
    RTL 
}

code_01DDD2 {
    COP [17] ( &code_01DE68 )
    COP [16]

  code_01DDD8:
    COP [27] ( &code_01DDDC )
}

code_01DDDC {
    COP [0D] ( #16, #0E, #1F, &code_01DE49 ) ; slot $16 is Monmo's own placement row: her own tile ($0E,$1F) is the hole
    COP [9C] ( &code_01DDE9, &code_01DE1B )
}

code_01DDE9 {
    COP [9A] ( #$0010, &code_01DDF3, &code_01DE1B, &code_01DE12 )
}

code_01DDF3 {
    COP [14] ( #$0056, &code_01DE09 )
    LDA $0000, X
    CMP #$0120
    BCS code_01DE09
    LDA $0002, X
    CMP #$0170
    BCC code_01DDD8
}

code_01DE09 {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    BRA code_01DDDC
}

code_01DE12 {
    COP [96]
    COP [80] ( #0B )
    COP [82]
    BRA code_01DDDC
}

code_01DE1B {
    COP [9B] ( #$0010, &code_01DE25, &code_01DDD8, &code_01DE42 )
}

code_01DE25 {
    COP [14] ( #$0056, &code_01DE3B )
    LDA $0002, X
    CMP #$0170
    BCS code_01DE3B
    LDA $0000, X
    CMP #$0120
    BCC code_01DDD8
}

code_01DE3B {
    COP [80] ( #0A )
    COP [82]
    BRA code_01DDDC
}

code_01DE42 {
    COP [80] ( #09 )
    COP [82]
    BRA code_01DDDC
}

code_01DE49 {
    COP [17] ( &code_01DE6D )
    COP [15]
    COP [80] ( #06 )
    COP [82]
    COP [91]
    RTL 
}

code_01DE57 {
    COP [16]
    COP [09] ( #$8307 )
}

code_01DE5D {
    COP [86]
    RTL 
}

code_01DE60 {
    COP [01] ( &asciistring_01DE75 )
    COP [27] ( &code_01DDD2 )
}

code_01DE68 {
    COP [01] ( &asciistring_01DF22 )
    RTL 
}

code_01DE6D {
    COP [01] ( &asciistring_01DF4C )
    COP [27] ( &code_01DE57 )
}

asciistring_01DE75 |[10]My name is Monmo the [N]mole- [FIN]This place is so [N]bright I cannot see- [FIN]Would you please lead [N]me to my house? I will[N]follow you- [FIN]Please take to the [N]hole that leads to my [N]home- [FIN]Allright, talk to me [N]when I am standing in [N]the right place- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01DF22 |[10]Please don t walk so [N]fast, I can t keep up [N]with you- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01DF4C |[10]I ll give you [N]a present- [N]Could you wait here? [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The squirrel in the tree hollow who tells of Turbo, Dr. Leo and the raft.
; 
; When: meta type $27, switch $4F (name $0E 'a squirrel'; lair record $4F in the third Water Shrine scene, a Stone Statues formation). Placed at tile ($07,$04) of A04S03, flipped.
; Sees: after a puff: 'Turbo, the dog, used to live with a human named Dr. Leo. Turbo learned a great many things from him. He used branches from the trees to make a tool called a raft.'
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A.

gw_npc_squirrel_turbo_raft_01DF73 {
    COP [14] ( #$004F, &code_01DF7A )
    RTL 
}

code_01DF7A {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01DF88 )
    COP [15]
    COP [91]
    RTL 
}

code_01DF88 {
    COP [01] ( &asciistring_01DF8D )
    RTL 
}

asciistring_01DF8D |[10]Turbo, the dog, [N]used to live with a [N]human named Dr-Leo- [FIN]Turbo learned a great [N]many things from him- [FIN]He used branches from [N]the trees to make a [N]tool called a raft- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The squirrel of the exchange store: the Psycho Sword for the Delicious Seeds.
; 
; When: meta type $28, switch $43 (name $0E 'a squirrel'; lair record $43 in the first Water Shrine scene, Walking Plants). Placed at tile ($08,$07) of A04S04.
; Sees: with the Psycho Sword already owned (COP 18 #02): 'Those seeds were very good!' Without the seeds (item $25): 'Welcome to the squirrel's exchange store. I am hungry, if you can bring me something to eat, I will trade you something.' With the seeds owned but not equipped (COP 19): 'Ah, I smell some delicious seeds. You have some don't you?' With the seeds equipped: 'I will exchange this sword with you for the seeds.', the seeds are taken (COP 0B) and 'received the Psycho Sword' (item $02).
; Why: the walkthrough: 'equip the Delicious Seeds and you can speak with the squirrel to receive the Psycho Sword'; the Seeds are in the Water Shrine chest.
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A.

gw_npc_squirrel_exchanger_01E005 {
    COP [14] ( #$0043, &code_01E00C )
    RTL 
}

code_01E00C {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01E01A )
    COP [15]
    COP [91]
    RTL 
}

code_01E01A {
    COP [18] ( #02, &code_01E024 )
    COP [01] ( &asciistring_01E11B )
    RTL 
}

code_01E024 {
    COP [18] ( #25, &code_01E03B )
    COP [19] ( #25, &code_01E040 ) ; jumps unless the Delicious Seeds (item $25) are equipped
    COP [01] ( &asciistring_01E0DD )
    COP [0B] ( #25 )
    BRK #$5E
    COP [0A] ( #02 )
    RTL 
}

code_01E03B {
    COP [01] ( &asciistring_01E045 )
    RTL 
}

code_01E040 {
    COP [01] ( &asciistring_01E0A5 )
    RTL 
}

asciistring_01E045 |[10]Welcome to the [N]squirrel s exchange [N]store- [FIN]I am hungry, if [N]you can bring me [N]something to eat, [FIN]I will trade you [N]something- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01E0A5 |[10]Ah, I smell some [N]delicious seeds- You [N]have some don t you? [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01E0DD |[10]I will exchange this [N]sword with you for the[N]seeds- [FIN][02:2] received [N][03:24]the Psycho Sword- [03:20][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01E11B |[10]Those seeds were very [N]good! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The small voice from the exchange store's hole, a one-shot text actor for the hero's return.
; 
; When: meta type $4F, switch $43. Placed off the map at ($00,$C8) of A04S01. COP 30 plays the text when the hero comes back through the lair record's release scene.
; Sees: 'A small voice is coming from a hole. Oh, I am starving. If someone can bring me something to eat I will exchange this powerful sword with them.'
; In: actor script, X = own slot.
; Out: kills itself (COP 86).
; Clobbers: A.

gw_npc_squirrel_exchanger_return_voice_01E134 {
    COP [14] ( #$0043, &code_01E13B )
    RTL 
}

code_01E13B {
    COP [30] ( #$0043, &code_01E145, #03 )
    COP [91]
    RTL 
}

code_01E145 {
    COP [01] ( &asciistring_01E14C )
    COP [86]
    RTL 
}

asciistring_01E14C |[10][0E:3C]A small voice is [N]coming from a hole- [FIN]Oh, I am starving----[FIN]If someone can bring [N]me something to eat [FIN]I will exchange this [N]powerful sword with [N]them----- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The squirrel in the northeast hollow who gives the Master's Emblem C.
; 
; When: meta type $29, switch $41 (name $0E 'a squirrel'; lair record $41 in the first Light Shrine scene, Fire Men). Placed at tile ($0D,$05) of A04S04.
; Sees: 'Thank you for releasing me. I will give you this.' and 'received the Master's Emblem C' (item $2C); flag $1A02 makes it once-only; afterwards 'Thank you for releasing me.' (walkthrough: 'Go into the easternmost tree hollow ... Speak with the northeastern squirrel in there to receive the Master's Emblem C').
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A.

gw_npc_squirrel_master_emblem_c_01E1C0 {
    COP [14] ( #$0041, &code_01E1C7 )
    RTL 
}

code_01E1C7 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01E1D5 )
    COP [15]
    COP [91]
    RTL 
}

code_01E1D5 {
    COP [07] ( #$9A02, &code_01E1E9 )
    COP [01] ( &asciistring_01E1EE )
    BRK #$5E
    COP [0A] ( #2C )      ; item $2C is the Master's Emblem C
    COP [09] ( #$9A02 )
    RTL 
}

code_01E1E9 {
    COP [01] ( &asciistring_01E22B )
    RTL 
}

asciistring_01E1EE |[10]Thank you for [N]releasing me- I will [N]give you this- [FIN][02:2] received [N][03:24]the Master s Emblem C-[03:20][JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01E22B |[10]Thank you for [N]releasing me- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The bird of the Bird's Dream: tells how Turbo died and lets the hero out after Turbo's ghost has spoken.
; 
; When: meta type $43, placed at tile ($19,$1B) of A04S05 (the dream entered with the Dream Rod at the sleeping bird of gw_woods_actors_01B98D).
; Sees: 'Turbo refused to give his life to the evil one, Deathtoll. He fought Deathtoll trying to save GreenWood and all it's animals, but he was defeated.' When flag $0402 (set by the ghost) is set: 'Turbo, wait!' and the scene changes back to A04S01 at pixel ($0120,$02D0) (walkthrough: 'speak with Turbo's ghost. Then go ahead and speak with the bird again to leave the dream').
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A.

gw_npc_bird_birds_dream_01E241 {
    COP [15]
    COP [17] ( &code_01E24A )
    COP [91]
    RTL 
}

code_01E24A {
    COP [07] ( #$8402, &code_01E255 )
    COP [01] ( &asciistring_01E266 )
    RTL 
}

code_01E255 {
    COP [01] ( &asciistring_01E2EA )
    COP [3C] ( #04 )
    COP [10] ( #$0104, #02, #$0120, #$02D0 ) ; area 4 scene 1: back to the Woods next to Turbo's grave
    RTL 
}

asciistring_01E266 |[10]Turbo refused to give [N]his life to the evil [N]one, Deathtoll- [FIN]He fought Deathtoll [N]trying to save [N]GreenWood and all [N]it s animals, [FIN]but he was defeated- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01E2EA |[10]Turbo, wait! [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The ghost of Turbo in the Bird's Dream.
; 
; When: meta type $44, switch $74 (a record without lair, only the dream room), tile ($19,$19) of A04S05.
; Sees: a pulsing ghost (animations $27 and $28); talked to: '<name>, go to the Light Shrine and release the Guardian of the Woods. You will find what you are looking for. There is a bird, Tiki, that may tell you how to use the raft. You must protect GreenWood now that I am gone.' Flag $0402 is set; after 60 frames he fades out (animations $28, $27, $23) and frees his tiles.
; Why: this is the walkthrough's 'use the monster lair nearby and speak with Turbo's ghost'; 'Tiki' is not named in the walkthrough (OQ-I035-9).
; In: actor script, X = own slot.
; Out: waits in the talk handler.
; Clobbers: A.

gw_npc_turbo_ghost_01E2FB {
    COP [14] ( #$0074, &code_01E302 )
    RTL 
}

code_01E302 {
    COP [81] ( #27, #0F )
    COP [83]
    COP [81] ( #28, #08 )
    COP [83]
    COP [15]
    COP [17] ( &code_01E337 )
    COP [91]
    RTL 
}

code_01E317 {
    COP [17] ( #$0000 )
    COP [1B] ( &code_01E321, #$003C )
}

code_01E321 {
    COP [81] ( #28, #08 )
    COP [83]
    COP [81] ( #27, #0F )
    COP [83]
    COP [80] ( #23 )
    COP [82]
    COP [16]
    COP [91]
    RTL 
}

code_01E337 {
    COP [01] ( &asciistring_01E343 )
    COP [09] ( #$8402 )   ; flag $0402: Turbo's ghost has spoken; the bird in the Woods and the dream bird test it
    COP [27] ( &code_01E317 )
}

asciistring_01E343 |[10][02:2], go to [N]the Light Shrine and [N]release the Guardian [N]of the Woods- [FIN]You will find what you[N]are looking for- [FIN]There is a bird, Tiki,[N]that may tell you how [N]to use the raft- [FIN]You must protect [N]GreenWood now that [N]I am gone- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The bird of the Stump's Dream: the stump dreams of being a bird.
; 
; When: meta type $45, tile ($0C,$04) of A04S06 (entered with the Dream Rod at the stump of gw_woods_actors_01B98D).
; Sees: the bird moves by (124, -6) at once (COP A1), plays animations $1F, $20 and $1D, turns after 40 frames and sits (animation $1A); talked to: 'Even though I am only a stump in real life, I often dream that I am a bird and can fly wherever I wish.' The scene then changes back to A04S01 at pixel ($0070,$02A0), next to the stump.
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A, asset_cache_tilemap1 (zeroed before the scene change).

gw_npc_bird_stumps_dream_01E3E2 {
    COP [A1] ( #$007C, #$FFFA )
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    COP [1B] ( &code_01E3FD, #$0028 )
}

code_01E3FD {
    COP [87]
    COP [80] ( #1D )
    COP [82]
    COP [15]
    COP [17] ( &code_01E412 )
    COP [91]
    COP [80] ( #1A )
    COP [82]
    RTL 
}

code_01E412 {
    COP [01] ( &asciistring_01E426 )
    STZ $asset_cache_tilemap1
    COP [3C] ( #04 )
    COP [10] ( #$0104, #00, #$0070, #$02A0 ) ; area 4 scene 1: back to the Woods next to the stump
    RTL 
}

asciistring_01E426 |[10]Even though I am only [N]a stump in real life, [N]I often dream [FIN]that I am a bird and [N]can fly wherever I [N]wish- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The wave effect of the Woods: a ripple of four pixels across the lines of the screen.
; 
; When: meta type $46, placed in A04S01 and A04S06 (no switch). The first part runs once (until the COP 91), the second part every frame.
; Sees: the picture waves slowly in the x and y direction with a period of 32 lines.
; Why: HDMA tables are rebuilt every frame so the wave moves: the first half sets up two indirect HDMA tables at $7E7000 and $7E7800, seven entries each (count $A0: 32 lines in repeat mode) that point at $7E7100 and $7E7900 and end with $00; the second half moves the scroll values stored at $00,X / $02,X (+1 and the camera delta) and copies them to scroll_bg2_x / y, then fills 32 words at each of the two data blocks from gw_wave_offsets_01EA7B, starting at the index (frame_counter / 4 + scroll_bg2_y) AND $1F, adding scroll_bg2_x ($033E) to the x block and scroll_bg2_y ($0340) to the y block, and queues both tables with QueueHdmaIndirect for the PPU registers $210D and $210E.
; In: actor script, X = own slot, M = 16 bits (switches to 8 bits for the queue calls).
; Out: two HDMA channels queued; the actor's x and y fields grow by one pixel plus the camera delta per frame.
; Clobbers: A (B too), Y; X is saved (PHX / PLX) and DBR restored (PHB / PLB).

gw_effect_wave_hdma_01E9D3 {
    PHX 
    LDX #$0000

  loc_01E9D7:
    LDA #$00A0
    STA $7E7000, X
    STA $7E7800, X
    LDA #$7100
    STA $7E7001, X
    LDA #$7900
    STA $7E7801, X
    INX 
    INX 
    INX 
    CPX #$0015
    BNE loc_01E9D7
    LDA #$0000
    STA $7E7000, X
    STA $7E7800, X
    PLX 
    COP [91]
    LDA $0000, X
    INC 
    CLC 
    ADC $scroll_delta_x
    STA $0000, X
    STA $scroll_bg2_x
    LDA $0002, X
    INC 
    CLC 
    ADC $scroll_delta_y
    STA $0002, X
    STA $scroll_bg2_y
    PHX 
    LDA $frame_counter
    LSR 
    LSR 
    CLC 
    ADC $scroll_bg2_y
    AND #$001F
    ASL 
    TAX 
    LDY #$0000
    PHB 
    SEP #$20
    LDA #$7E
    PHA 
    PLB 
    REP #$20

  loc_01EA3D:
    LDA $@gw_wave_offsets_01EA7B, X
    CLC 
    ADC $033E
    STA $7100, Y
    LDA $@gw_wave_offsets_01EA7B, X
    CLC 
    ADC $0340
    STA $7900, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0040
    BNE loc_01EA3D
    PLB 
    SEP #$20
    LDA #$0D
    XBA 
    LDA #$7E
    LDY #$7000
    JSL $@lib_system_helpers.QueueHdmaIndirect ; A.high = $0D: the PPU register $210D, bank $7E, table $7000
    LDA #$0E
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaIndirect ; A.high = $0E: the PPU register $210E, bank $7E, table $7800
    REP #$20
    PLX 
    RTL 
}
---------------------------------------------

; The wave table of gw_effect_wave_hdma_01E9D3: 64 words, two periods of a ripple.
; 
; When: read by gw_effect_wave_hdma_01E9D3 every frame (32 words from a start index that moves with frame_counter / 4).
; Sees: the offsets run 0, 1, 2, 2, 3, 3, 4 (peak of four, five times) then back through 0 to -4 and again: the lines of the screen are shifted by up to four pixels.
; In: data, 64 words (index $00-$3F).
; Out: n/a.

gw_wave_offsets_01EA7B [
  #$0000   ;00
  #$0001   ;01
  #$0002   ;02
  #$0002   ;03
  #$0003   ;04
  #$0003   ;05
  #$0004   ;06
  #$0004   ;07
  #$0004   ;08
  #$0004   ;09
  #$0004   ;0A
  #$0003   ;0B
  #$0003   ;0C
  #$0002   ;0D
  #$0002   ;0E
  #$0001   ;0F
  #$0000   ;10
  #$FFFF   ;11
  #$FFFE   ;12
  #$FFFE   ;13
  #$FFFD   ;14
  #$FFFD   ;15
  #$FFFC   ;16
  #$FFFC   ;17
  #$FFFC   ;18
  #$FFFC   ;19
  #$FFFC   ;1A
  #$FFFD   ;1B
  #$FFFD   ;1C
  #$FFFE   ;1D
  #$FFFE   ;1E
  #$FFFF   ;1F
  #$0000   ;20
  #$0001   ;21
  #$0002   ;22
  #$0002   ;23
  #$0003   ;24
  #$0003   ;25
  #$0004   ;26
  #$0004   ;27
  #$0004   ;28
  #$0004   ;29
  #$0004   ;2A
  #$0003   ;2B
  #$0003   ;2C
  #$0002   ;2D
  #$0002   ;2E
  #$0001   ;2F
  #$0000   ;30
  #$FFFF   ;31
  #$FFFE   ;32
  #$FFFE   ;33
  #$FFFD   ;34
  #$FFFD   ;35
  #$FFFC   ;36
  #$FFFC   ;37
  #$FFFC   ;38
  #$FFFC   ;39
  #$FFFC   ;3A
  #$FFFD   ;3B
  #$FFFD   ;3C
  #$FFFE   ;3D
  #$FFFE   ;3E
  #$FFFF   ;3F
]