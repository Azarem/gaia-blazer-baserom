; The second half of the Seabed Sanctuary actors (file offsets 1019224-1022717, 1024020-1024262 and 1025988-1026164, SNES $1F:8D58-$9AFC, $A014-$A105 and $A7C4-$A873): the Mermaid's Tears hint, the Durean and ghost ship statues, the pearl ride dolphin, the Magic Flair mermaid, the Queen and her epilogue, the Red-Hot Stick mermaid, the west guard and the wave of the scene. The first half is in se_seabed_sanctuary_actors_0F8000, which also explains the shared root patterns (COP 3B captive, COP 14 already free, COP 30 return trip).
; 
; === ROSTER (root: switch, who, what the player gets or sees) ===
; - se_npc_mermaid_tears_hint_0F8D58: switch $A7 (captive). Talk: 'Open the treasure chest.' while the hero has no Mermaid's Tears (item $21); with them: 'The teardrops from a mermaid have the power to turn Magma to stone. Use them at the top of the volcanic island.'; after the volcano is out (flag $0503): 'These teardrops were left by a mermaid when evil invaded this place. Icy teardrops, filled with sorrow, will turn even the hottest Magma to stone.'
; - se_npc_statue_durean_path_0F8E99 ($AB) and se_npc_statue_ghost_ship_path_0F961C ($B9): the statues of the passages to Durean ('Walk downward under the sea and go to the volcanic island, Durean.') and to the ghost ship ('Go [unmapped glyph] along the seabed and you will find a ghost ship.'). Same mechanism as the Blester and Rockbird statues of the first half; the trips go to A07S01 at pixel ($240,$2B0) (Durean, flag $0500) and ($140,$40) (ghost ship, flag $0501).
; - se_npc_dolphin_pearl_ride_0F8F45: switch $C1. The dolphin that carries the hero over the water to the treasure chest of the Big Pearl: 'Stand on my nose.' (flag $0000), then the ride out from tile ($03,$31) and the ride back from tile ($03,$19), each 432 frames, with the pad blocked.
; - se_npc_mermaid_magic_flair_0F905C: switch $B5 (captive). Gives the Magic Flair (item $13) once: 'I will give you the Magic Flair. Magic Flair is useful against monsters that fly and have a large amount of hit points. You know which monsters I am referring to, right?'
; - se_npc_queen_0F911E: switch $B6. The Mermaid Queen, freed when the lair $B6 is cleared. Talk: gives the Blue Stone (item $3C) once and sets flag $1B02 ('Please travel to other regions and release all creatures.'). After the ending (flag $1F02) the same actor runs the epilogue (code_0F913F): Lue and Lala appear.
; - se_npc_mermaid_queen_dream_0F96B9: switch $BD. The mermaid who dreamt of the Queen near a sunken ship; after $B6 she thanks the hero.
; - se_npc_mermaid_coral_reef_pearls_0F9793: switch $C0 (captive). 'The coral reef is home to the dolphins. The pearls made in the reef are their treasure.'
; - se_npc_mermaid_red_hot_stick_0F982F: switch $8E (captive). Gives the Red-Hot Stick (item $34) when the hero has neither it nor the Phoenix (item $18): 'The Phoenix resides on the Stick. Take the Red-Hot Stick and visit the Mountain King.'
; - se_npc_mermaid_guard_west_0F98F5: switch $8A. The west guard of the portal to Lue: with the Thunder Ring (item $24) in the bag she steps aside at once; without it she asks 'Have you seen the Queen of the Mermaids?' (Yes / No): Yes: 'Lue, the dolphin has been captured! Please save him!' and she steps aside; No: 'Okay, wait.' and she shows what the Queen looks like, then the same message.
; - se_npc_statue_arrival_hint_0FA014: switches $B6 and $9D. The statue of the arrival: before the first passage is opened '[the hero] heard a small voice. This is St. Elles Palace in the ocean. No human can live under the sea. Go to the island, Southerta, through the shrine and look for the Bubble Clothing.' (flag $0502); afterwards 'Listen closely to the advice of the 4 mermaid statues.' It removes itself when the Queen is free.
; - se_effect_sanctuary_wave_hdma_0FA7C4: the water shimmer of the Sanctuary (HDMA on PPU register $0F).
; 
; === EVENT FLAGS ===
; $0000 first talk to the pearl ride dolphin, $0500 / $0501 the Durean / ghost ship passage was used (set by the gate actors of se_seabed_of_st_elles_actors), $0502 the arrival statue has spoken, $0503 the volcano of Durean is out, $0903 a statue trip is running (cleared by the gate on return), $1B02 the Blue Stone was given, $1F02 the ending was run, $0002 the west guard has been told 'wait' (No answer).
; 
; === OPEN ===
; The unmapped glyph in the ghost ship statue text and the 'Bubble Clothing' of the arrival statue: see OQ-I036-2 and OQ-I036-3.
---------------------------------------------

?BANK 1F

?INCLUDE 'engine_player_death_and_actor_helpers'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'se_seabed_sanctuary_actors_0F8000'
?INCLUDE 'shared_choice_prompt_texts'
?INCLUDE 'w2_obj_fairy_idle_loop'

!L_choice_result                0003D0
!frame_counter                  0312
!joy_block_mask                 0326
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!player_actor                   039C
!asset_skip_mask                03B4
!return_active                  03FB

---------------------------------------------

; The mermaid that explains the Mermaid's Tears (switch $A7).
; 
; When: placement script; COP 3B captive.
; Sees: the plea until the lair is released; then the puff, she blocks her tiles (COP 15) and stands (animation $06); talk handler code_0F8D81.
; Why: the Tears (item $21) turn the magma of Durean to stone (walkthrough: St. Elles/Seabed Sanctuary - Bubble Armor lists the Mermaid's Tears).
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_tears_hint_0F8D58 {
    COP [3B] ( #$00A7, &code_0F8D6E )
    COP [17] ( &w2_obj_fairy_idle_loop.w2_npc_caged_plea_0FA95A )
    SEP #$20
    LDA #$^engine_player_death_and_actor_helpers.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_player_death_and_actor_helpers.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F8D6E {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F8D81 )
    COP [15]
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

---------------------------------------------
; Talk handler of the Tears mermaid: three texts.
; 
; When: the hero talks.
; Sees: flag $0503 (volcano out): the story of the teardrops. Else item $21 missing: 'Open the treasure chest.'; owned: 'The teardrops from a mermaid have the power to turn Magma to stone. Use them at the top of the volcanic island.'
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0F8D81 {
    COP [07] ( #$8503, &code_0F8D96 ) ; flag $0503 = the volcano of Durean is out (set by se_obj_durean_tears_spot_0FA5FA)
    COP [18] ( #21, &code_0F8D91 ) ; item $21 = Mermaid's Tears
    COP [01] ( &asciistring_0F8D9B )
    RTL 
}

code_0F8D91 {
    COP [01] ( &asciistring_0F8DF9 )
    RTL 
}

code_0F8D96 {
    COP [01] ( &asciistring_0F8E14 )
    RTL 
}

asciistring_0F8D9B |[10]The teardrops from a [N]mermaid have the power[N]to turn Magma to [N]stone- [FIN]Use them at the top of[N]the volcanic island- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|

asciistring_0F8DF9 |[10]Open the treasure [N]chest- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|

asciistring_0F8E14 |[10]These teardrops were [N]left by a mermaid when[N]evil invaded this [N]place- [FIN]Icy teardrops, filled [N]with sorrow, will turn[N]even the hottest Magma[N]to stone- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|
---------------------------------------------

; The mermaid statue of the passage to Durean (switch $AB).
; 
; When: placement script; COP 14 until released.
; Sees: like se_npc_statue_blester_path_0F87A9: the test of the hero on tile ($1C,$22) moves him to ($1C,$24) after the return trip (COP 33 shows the player actors, the pad is unblocked); talk handler code_0F8EC5 warps to A07S01 at pixel ($240,$2B0) unless flag $0500 is set.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_statue_durean_path_0F8E99 {
    COP [14] ( #$00AB, &code_0F8EA0 )
    RTL 
}

code_0F8EA0 {
    COP [30] ( #$00AB, &code_0F8EE9, #1F )
    COP [17] ( &code_0F8EC5 )
    COP [91]
    COP [0D] ( #00, #1C, #22, &code_0F8EB5 )
    RTL 
}

code_0F8EB5 {
    COP [11] ( #00, #1C, #24 )
    COP [33]
    LDA #$AFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

---------------------------------------------
; Talk handler of the Durean statue: 'I will open the passage for you. Walk downward under the sea and go to the volcanic island, Durean.' then the pad is blocked, asset_skip_mask = $0020, flag $0903 is set and COP 10 goes to A07S01 at pixel ($240,$2B0); when flag $0500 is already set the handler ends after the text.
; 
; In: X = D = slot.
; Out: scene change.
; Clobbers: A.

code_0F8EC5 {
    COP [01] ( &asciistring_0F8EF0 )
    COP [07] ( #$8500, &code_0F8EE8 ) ; flag $0500 is set by se_obj_statue_gate_durean_0F9F74 when the passage was used; the statue then does not warp again
    LDA #$EF80
    TSB $joy_block_mask
    LDA #$0020
    STA $asset_skip_mask
    COP [09] ( #$8903 )
    COP [10] ( #$0107, #02, #$0240, #$02B0 ) ; A07S01 at pixel ($240,$2B0): the Durean end of the seabed
}

code_0F8EE8 {
    RTL 
}

code_0F8EE9 {
    COP [01] ( &se_seabed_sanctuary_actors_0F8000.asciistring_0F8B27 )
    COP [86]
    RTL 
}

asciistring_0F8EF0 |[10]I will open the [N]passage for you- [FIN]Walk downward under [N]the sea and go to the [N]volcanic island, [N]Durean- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|
---------------------------------------------

; The dolphin of the Big Pearl ride (switch $C1).
; 
; When: placement script; COP 14 until the lair is released.
; Sees: puff, talk handler code_0F9041 ('Stand on my nose.', sets flag $0000), tiles blocked, animation $10 until flag $0000 is set; then each frame the test of the hero on tile ($03,$31): when he stands there the tiles are freed, the ride actor se_obj_pearl_ride_out_0F8FAB is spawned and the dolphin swims (animation $0D, 27 repeats); then it waits for the hero on tile ($03,$19) and starts se_obj_pearl_ride_back_0F8FF6 (animation $0C, 27 repeats), and starts again.
; Why: the hero rides on the dolphin's nose to the island of the treasure chest (walkthrough: Seabed Sanctuary - The Thunder Ring).
; In: X = D = slot.
; Out: BRL loops.
; Clobbers: A.

se_npc_dolphin_pearl_ride_0F8F45 {
    COP [14] ( #$00C1, &code_0F8F4C )
    RTL 
}

code_0F8F4C {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )

  loc_0F8F51:
    COP [17] ( &code_0F9041 )
    COP [15]

  code_0F8F57:
    COP [80] ( #10 )
    COP [82]
    COP [07] ( #$0000, &code_0F8F57 ) ; waits (animation $10) until the first talk sets flag $0000

  loc_0F8F62:
    COP [0D] ( #00, #03, #31, &code_0F8F71 ) ; the hero on tile ($03,$31) starts the ride out
    COP [80] ( #10 )
    COP [82]
    BRL loc_0F8F62
}

code_0F8F71 {
    COP [16]
    COP [17] ( #$0000 )
    COP [85] ( @se_obj_pearl_ride_out_0F8FAB )
    COP [81] ( #0D, #1B )
    COP [83]
    COP [17] ( &code_0F9041 )
    COP [15]

  loc_0F8F88:
    COP [0D] ( #00, #03, #19, &code_0F8F97 ) ; the hero on tile ($03,$19) starts the ride back
    COP [80] ( #0F )
    COP [82]
    BRL loc_0F8F88
}

code_0F8F97 {
    COP [16]
    COP [17] ( #$0000 )
    COP [85] ( @se_obj_pearl_ride_back_0F8FF6 )
    COP [81] ( #0C, #1B )
    COP [83]
    BRL loc_0F8F51
}

---------------------------------------------
; The ride out: carries the hero for 432 frames.
; 
; When: spawned by the dolphin (COP 85, before it).
; Sees: blocks the pad ($2F80), loads $0025 with $01B0 as a countdown and clears bit $1000 of the hero's $16; every frame the hero's Y is set to the dolphin's Y minus $20 and his $0006 to $FFFF; at zero the bit is set again, the pad released and the actor kills itself.
; Why: the hero is dragged by the dolphin instead of walking.
; In: X = D = slot of the ride actor; $3C is the link toward the tail and holds the spawner, which is the dolphin because the ride actor was spawned before it (COP 85).
; Out: RTL each frame; COP 86 at the end.
; Clobbers: A, Y.

se_obj_pearl_ride_out_0F8FAB {
    LDA #$2F80
    TSB $joy_block_mask
    LDA #$01B0
    STA $0025, X
    LDY $player_actor
    LDA $0016, Y
    AND #$EFFF
    STA $0016, Y
    COP [91]
    LDY $003C, X          ; $3C holds the spawner (COP 85 stores it in the new actor): the ride actor was spawned before the dolphin, so Y is the dolphin
    LDA $0002, Y
    SEC 
    SBC #$0020
    LDY $player_actor
    STA $0002, Y
    LDA #$FFFF
    STA $0006, Y
    DEC $0025, X
    BEQ loc_0F8FE1
    RTL 

  loc_0F8FE1:
    LDY $player_actor
    LDA $0016, Y
    ORA #$1000
    STA $0016, Y
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}

---------------------------------------------
; The ride back: the same as se_obj_pearl_ride_out_0F8FAB, but the hero is put $10 pixels below the dolphin and his $0006 to 1.
; 
; In: X = D = slot of the ride actor.
; Out: RTL each frame; COP 86 at the end.
; Clobbers: A, Y.

se_obj_pearl_ride_back_0F8FF6 {
    LDA #$2F80
    TSB $joy_block_mask
    LDA #$01B0
    STA $0025, X
    LDY $player_actor
    LDA $0016, Y
    AND #$EFFF
    STA $0016, Y
    COP [91]
    LDY $003C, X
    LDA $0002, Y
    CLC 
    ADC #$0010
    LDY $player_actor
    STA $0002, Y
    LDA #$0001
    STA $0006, Y
    DEC $0025, X
    BEQ loc_0F902C
    RTL 

  loc_0F902C:
    LDY $player_actor
    LDA $0016, Y
    ORA #$1000
    STA $0016, Y
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}

---------------------------------------------
; Talk handler of the ride dolphin: 'Stand on my nose.' and sets flag $0000.
; 
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0F9041 {
    COP [01] ( &asciistring_0F904A )
    COP [09] ( #$8000 )
    RTL 
}

asciistring_0F904A |[10]Stand on my nose- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|
---------------------------------------------

; The Magic Flair mermaid (switch $B5).
; 
; When: placement script; COP 3B captive.
; Sees: puff, tiles blocked, animation $02; talk handler code_0F9085.
; Why: she gives the charge spell Magic Flair (walkthrough: Seabed Sanctuary - The Thunder Ring).
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_magic_flair_0F905C {
    COP [3B] ( #$00B5, &code_0F9072 )
    COP [17] ( &w2_obj_fairy_idle_loop.w2_npc_caged_plea_0FA95A )
    SEP #$20
    LDA #$^engine_player_death_and_actor_helpers.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_player_death_and_actor_helpers.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F9072 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F9085 )
    COP [15]
    COP [91]
    COP [80] ( #02 )
    COP [82]
    RTL 
}

---------------------------------------------
; Talk handler of the Magic Flair mermaid: gives item $13 when the hero has none ('I will give you the Magic Flair' with a sound), then always the explanation 'Magic Flair is useful against monsters that fly and have a large amount of hit points. You know which monsters I am referring to, right?'
; 
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0F9085 {
    COP [18] ( #13, &code_0F908F )
    COP [01] ( &asciistring_0F90B5 )
    RTL 
}

code_0F908F {
    COP [01] ( &asciistring_0F9099 )
    BRK #$5E
    COP [0A] ( #13 )
    RTL 
}

asciistring_0F9099 |[10]I will give you [N][03:24]the Magic Flair- [FIN][03:20][JMP:&asciistring_0F90B5+M]|

asciistring_0F90B5 |[10][::]Magic Flair is useful [N]against monsters that [N]fly and have a large [N]amount of hit points- [FIN]You know which [N]monsters I am [N]referring to, right? [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|
---------------------------------------------

; The Mermaid Queen (switch $B6).
; 
; When: placement script; COP 14 until the lair $B6 is released.
; Sees: COP 30 spawns code_0F922E when the hero returns from the lair; the Queen is moved 8 pixels right (COP 9F), runs the epilogue code_0F913F after the ending (flag $1F02) and otherwise blocks her tiles and waits for talk (code_0F9215).
; Why: the Queen is the goal of the Seabed Sanctuary chapter; she gives the Blue Stone.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_queen_0F911E {
    COP [14] ( #$00B6, &code_0F9125 )
    RTL 
}

code_0F9125 {
    COP [30] ( #$00B6, &code_0F922E, #1F )
    COP [9F] ( #$0008 )
    COP [07] ( #$9F02, &code_0F913F ) ; flag $1F02 is set by the ending: from then on the Queen runs the epilogue instead of the normal talk
    COP [15]
    COP [17] ( &code_0F9215 )
    COP [91]
    RTL 
}

---------------------------------------------
; The epilogue of the Queen: the dolphin Lue meets Lala.
; 
; When: flag $1F02 is set (the ending was run): the Queen's root jumps here when the Sanctuary is built.
; Sees: moves the slots $0D and $1A off the map (tile y $C9), blocks the pad, waits 41 frames and shows the Queen's speech ('thank you very much! Peace has returned here, to St. Elles. The dolphin, Lue, used to live with Dr. Leo ... Oh, here comes Lue.'), spawns Lue (se_obj_epilogue_lue_0F91AA) and waits for its flag $0000; Lue's speech ('Phew! ... I decided to return to my home town along with my friends. To tell you the truth, I am to be married. Hey Lala, come in here!'), spawns Lala (se_obj_epilogue_lala_0F91E2) and waits for flag $0001; the last text ('Don't you think she is beautiful? We will be happy together. I wish you luck.') and COP 10 to A04S01 at pixel ($120,$2E0).
; In: X = D = slot of the Queen.
; Out: scene change.
; Clobbers: A.

code_0F913F {
    COP [11] ( #0D, #00, #C9 ) ; moves the actors of slots $0D and $1A off the map (tile y $C9) for the scene
    COP [11] ( #1A, #00, #C9 )
    LDA #$FF80
    TSB $joy_block_mask
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_0F9416 )
    COP [AC] ( @se_obj_epilogue_lue_0F91AA, #$0200, #$0100, #$0050 ) ; spawns Lue at pixel ($0200,$0100) with flags $0050
    COP [05] ( #$0000 )   ; waits until Lue has set flag $0000
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_0F953B )
    COP [03] ( #79 )
    COP [04]
    COP [AC] ( @se_obj_epilogue_lala_0F91E2, #$0200, #$0100, #$0050 )
    COP [05] ( #$0001 )
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_0F95CE )
    COP [03] ( #79 )
    COP [04]
    LDA #$0020
    STA $asset_skip_mask
    COP [10] ( #$0104, #01, #$0120, #$02E0 ) ; A04S01 (the Woods of GreenWood) at pixel ($120,$2E0) after the epilogue
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

---------------------------------------------
; Lue in the epilogue: walks in (animations $0D, $0E with COP 9F steps and flips), stands (animation $11) and sets flag $0000 for the Queen's script.
; 
; In: X = D = slot of the new actor (spawned at pixel ($0200,$0100)).
; Out: RTL.
; Clobbers: A.

se_obj_epilogue_lue_0F91AA {
    COP [81] ( #0D, #04 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [96]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [97]
    COP [81] ( #0D, #06 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    COP [09] ( #$8000 )
    COP [91]
    COP [80] ( #11 )
    COP [82]
    RTL 
}

---------------------------------------------
; Lala in the epilogue: walks in like Lue (animations $0D, $0E, $0D), stands (animation $11) and sets flag $0001.
; 
; In: X = D = slot of the new actor.
; Out: RTL.
; Clobbers: A.

se_obj_epilogue_lala_0F91E2 {
    COP [81] ( #0D, #04 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [96]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [97]
    COP [81] ( #0D, #05 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [80] ( #11 )
    COP [82]
    COP [09] ( #$8001 )
    COP [91]
    COP [80] ( #11 )
    COP [82]
    RTL 
}

---------------------------------------------
; Talk handler of the Queen: gives the Blue Stone.
; 
; When: the hero talks to the Queen.
; Sees: flag $1B02 clear: 'I have heard about you from Lue. You are the one who saved me. Everything started when I saw the jewel that Lue had. One glance at the Blue Stone caused desire and hatred to overwhelm me ... I will give you the Blue Stone.', a sound, COP 0A item $3C and flag $1B02 is set. Set: only 'Please travel to other regions and release all creatures.'
; Why: the Blue Stone is the item of the chapter (walkthrough: St. Elles/Seabed Sanctuary - Conclusion).
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0F9215 {
    COP [07] ( #$9B02, &code_0F9229 )
    COP [01] ( &asciistring_0F9252 )
    BRK #$5E
    COP [0A] ( #3C )      ; item $3C = Blue Stone
    COP [09] ( #$9B02 )   ; flag $1B02: the Blue Stone was given
    RTL 
}

code_0F9229 {
    COP [01] ( &asciistring_0F938C )
    RTL 
}

---------------------------------------------
; One-shot actor for the return trip of the lair $B6.
; 
; When: spawned by COP 30 when the hero comes back from the lair $B6.
; Sees: sets return_active; when the switches $BD or $92 (the dream mermaid and the maid) are free it first shouts 'Queen!'; then 'A beautiful voice came from inside the palace. I am the Mermaid Queen. I know not who you are, but thank you for releasing me. Please return to the palace.', heals the hero (COP 37), clears return_active and kills itself.
; In: X = D = slot of the new actor.
; Out: RTL.
; Clobbers: A.

code_0F922E {
    LDA #$FFFF
    STA $return_active
    COP [14] ( #$00BD, &code_0F9242 )
    COP [14] ( #$0092, &code_0F9242 )
    BRA loc_0F9246
}

code_0F9242 {
    COP [01] ( &asciistring_0F9390 )

  loc_0F9246:
    COP [01] ( &asciistring_0F939F )
    COP [37]
    STZ $return_active
    COP [86]
    RTL 
}

asciistring_0F9252 |[10]I have heard about you[N]from Lue- [FIN]You are the one who [N]saved me- [FIN]Everything started [N]when I saw the jewel [N]that Lue had- [FIN]One glance at the Blue[N]Stone caused desire [N]and hatred to [N]overwhelm me- [FIN]Right after that the [N]creatures disappeared [N]and the monsters took [N]over- [FIN]Maybe because we let [N]bad feeling dominate [N]us we created the [N]monsters ourselves- [FIN]I will give you [03:24]the [N]Blue Stone- [FIN][03:20][::]Please travel to other[N]regions and release [N]all creatures- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|

asciistring_0F938C |[10][JMP:&asciistring_0F9252+M]|

asciistring_0F9390 |[10][0E:1E]Queen! [0E:3C][JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44+M]|

asciistring_0F939F |[10][0E:3C]A beautiful voice came[N]from inside the [N]palace- [FIN]I am the Mermaid [N]Queen- [FIN]I know not who you [N]are, but thank you for[N]releasing me- [FIN]Please return to the [N]palace- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|

asciistring_0F9416 |[10][0F][02:2], [N]thank you very much! [N][0E:3C]Peace has returned [N]here, to St-Elles- [N][0E:5A]The dolphin, Lue, used[N]to live with Dr-Leo- [N][0E:5A]It s strange, whenever[N]he tells me about Dr- [N]Leo and his daughter [N]Lisa- [N][0E:2D]I miss them and [N]sometimes find myself [N]crying- [N][0E:5A]Now Dr-Leo is gone, [N][0E:1E]Lisa must be very [N]lonely- [N][0E:5A]Oh, here comes Lue- He[N]must have heard your [N]voice- [N][0E:78][JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44+M]|

asciistring_0F953B |[10][0F]Phew! [N][0E:5A][02:2], [N]why did you not visit [N]me? [N][0E:5A]I decided to return to[N]my home town along [N]with my friends- [N][0E:5A]To tell you the truth,[N][0E:28]I am to be married- [N][0E:50]Hey Lala, come in [N]here! [0E:78][JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44+M]|

asciistring_0F95CE |[10][0F]Don t you think she is[N]beautiful- [N][0E:5A]We will be happy [N]together- [N][0E:5A][02:2], [N]I wish you luck- [0E:78][JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44+M]|
---------------------------------------------

; The mermaid statue of the passage to the ghost ship (switch $B9).
; 
; When: placement script; COP 14 until released.
; Sees: like the other statues: the hero on tile ($1C,$1C) is moved to ($1C,$1E); the talk handler code_0F9648 warps to A07S01 at pixel ($140,$40) unless flag $0501 is set.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_statue_ghost_ship_path_0F961C {
    COP [14] ( #$00B9, &code_0F9623 )
    RTL 
}

code_0F9623 {
    COP [30] ( #$00B9, &code_0F966C, #1F )
    COP [17] ( &code_0F9648 )
    COP [91]
    COP [0D] ( #00, #1C, #1C, &code_0F9638 )
    RTL 
}

code_0F9638 {
    COP [11] ( #00, #1C, #1E )
    COP [33]
    LDA #$AFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_0F9648 {
    COP [01] ( &asciistring_0F9673 )
    COP [07] ( #$8501, &code_0F966B )
    LDA #$EF80
    TSB $joy_block_mask
    LDA #$0020
    STA $asset_skip_mask
    COP [09] ( #$8903 )
    COP [10] ( #$0107, #02, #$0140, #$0040 )
}

code_0F966B {
    RTL 
}

code_0F966C {
    COP [01] ( &se_seabed_sanctuary_actors_0F8000.asciistring_0F8B27 )
    COP [86]
    RTL 
}

asciistring_0F9673 |[10]I will open the [N]passage for you- [FIN]Go ¦ along the [N]seabed and you will [N]find a ghost ship- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|
---------------------------------------------

; The mermaid who dreamt of the Queen (switch $BD).
; 
; When: placement script; COP 14 until released.
; Sees: flag $1F02 set: gone. Else puff, tiles blocked, animation $08 until the lair $B6 is released; then she unblocks her tiles, makes a small hop (COP 9F +$10 / -$10 around animation $0A three times) and says 'Thank you very much! I can hardly believe that she is really back!'. Before: 'I saw the Queen when I was dreaming. She looked very sad. It was somewhere near a sunken ship. Please save the Queen!!'
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_queen_dream_0F96B9 {
    COP [14] ( #$00BD, &code_0F96C0 )
    RTL 
}

code_0F96C0 {
    COP [07] ( #$9F02, &code_0F9704 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F9707 )
    COP [15]

  loc_0F96D1:
    COP [14] ( #$00B6, &code_0F96DF )
    COP [80] ( #08 )
    COP [82]
    BRL loc_0F96D1
}

code_0F96DF {
    COP [16]
    COP [9F] ( #$0010 )
    COP [81] ( #0A, #03 )
    COP [83]
    COP [9F] ( #$FFF0 )
    COP [97]
    COP [80] ( #08 )
    COP [82]
    COP [15]
    COP [17] ( &code_0F970C )
    COP [91]
    COP [80] ( #08 )
    COP [82]
    RTL 
}

code_0F9704 {
    COP [86]
    RTL 
}

code_0F9707 {
    COP [01] ( &asciistring_0F9711 )
    RTL 
}

code_0F970C {
    COP [01] ( &asciistring_0F976C )
    RTL 
}

asciistring_0F9711 |[10]I saw the Queen when [N]I was dreaming- [N]She looked very sad- [FIN]It was somewhere near [N]a sunken ship- [N]Please save the [N]Queen!! [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|

asciistring_0F976C |[10]Thank you very much! [N]I can hardly believe [N]that she is really [N]back! [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|
---------------------------------------------

; A mermaid of the coral reef (switch $C0).
; 
; When: placement script; COP 3B captive.
; Sees: after release she sways left and right in a loop (animations $0B, $0A, $09 with flips and 8 pixel steps); talk: 'The coral reef is home to the dolphins. The pearls made in the reef are their treasure.'
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_coral_reef_pearls_0F9793 {
    COP [3B] ( #$00C0, &code_0F97A9 )
    COP [17] ( &w2_obj_fairy_idle_loop.w2_npc_caged_plea_0FA95A )
    SEP #$20
    LDA #$^engine_player_death_and_actor_helpers.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_player_death_and_actor_helpers.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F97A9 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F97E2 )
    COP [91]

  loc_0F97B4:
    COP [97]
    COP [81] ( #0B, #05 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #0A, #02 )
    COP [83]
    COP [9F] ( #$FFF8 )
    COP [96]
    COP [81] ( #0B, #05 )
    COP [83]
    COP [9F] ( #$0008 )
    COP [81] ( #09, #02 )
    COP [83]
    COP [9F] ( #$FFF8 )
    BRA loc_0F97B4
}

code_0F97E2 {
    COP [01] ( &asciistring_0F97E7 )
    RTL 
}

asciistring_0F97E7 |[10]The coral reef is home[N]to the dolphins- [FIN]The pearls made in the[N]reef are their [N]treasure- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|
---------------------------------------------

; The Red-Hot Stick mermaid (switch $8E).
; 
; When: placement script; COP 3B captive.
; Sees: puff, tiles blocked, animation $06; talk handler code_0F9858.
; Why: the Stick is one of the three Red-Hot items of the Phoenix (walkthrough: items table; sidequest Defeating Metal Monsters); the walkthrough does not name this mermaid (OQ-I036-4).
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_red_hot_stick_0F982F {
    COP [3B] ( #$008E, &code_0F9845 )
    COP [17] ( &w2_obj_fairy_idle_loop.w2_npc_caged_plea_0FA95A )
    SEP #$20
    LDA #$^engine_player_death_and_actor_helpers.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_player_death_and_actor_helpers.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F9845 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F9858 )
    COP [15]
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

---------------------------------------------
; Talk handler of the Red-Hot Stick mermaid.
; 
; When: the hero talks.
; Sees: Phoenix (item $18) owned: only the reminder 'Take the Red-Hot Stick and visit the Mountain King.' Else Stick (item $34) owned: the same reminder. Else 'Thank you very much for releasing me! I will give you the Red-Hot Stick. The Phoenix resides on the Stick.', a sound, COP 0A item $34 and the reminder.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0F9858 {
    COP [18] ( #18, &code_0F985F ) ; item $18 = Phoenix: when it is owned the Stick is not given again
    BRA loc_0F9864
}

code_0F985F {
    COP [18] ( #34, &code_0F9869 ) ; item $34 = Red-Hot Stick

  loc_0F9864:
    COP [01] ( &asciistring_0F98C6 )
    RTL 
}

code_0F9869 {
    COP [01] ( &asciistring_0F9873 )
    BRK #$5E
    COP [0A] ( #34 )
    RTL 
}

asciistring_0F9873 |[10]Thank you very [N]much for releasing me![FIN]I will give you [03:24]the [N]Red+Hot Stick- [N][03:20]The Phoenix resides on[N]the Stick- [FIN][JMP:&asciistring_0F98C6+M]|

asciistring_0F98C6 |[10][::]Take the Red+Hot Stick[N]and visit the Mountain[N]King- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|
---------------------------------------------

; The west guard (switch $8A).
; 
; When: placement script; COP 14 until released.
; Sees: with the Thunder Ring (item $24) she steps aside at once (code_0F997F). Without it (code_0F9903): when the hero stands on tile ($0A,$27) she also steps aside; else she stands (animation $01) until flag $0002 is set by the answer 'Okay, wait' and then shows the Queen's secret: steps aside, animation $05 and $04, 'This is a secret, the Queen looks like this.' and 'She always sits like this. She looks so mean.' with the animations $19 and $18 and a puff each time, then 'Lue, the dolphin has been captured! Please save him!'. The talk handler is code_0F99A2 while she blocks and code_0F99D1 afterwards.
; Why: the walkthrough says she lets the hero pass regardless of the answer and may tell him how the Queen looks; the ROM does exactly that.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_guard_west_0F98F5 {
    COP [14] ( #$008A, &code_0F98FC )
    RTL 
}

code_0F98FC {
    COP [18] ( #24, &code_0F9903 ) ; item $24 = Thunder Ring: owned, the guard steps aside at once
    BRA code_0F997F
}

code_0F9903 {
    COP [0D] ( #00, #0A, #27, &code_0F997F )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F99A2 )
    COP [15]

  code_0F9915:
    COP [80] ( #01 )
    COP [82]
    COP [07] ( #$0002, &code_0F9915 ) ; waits while flag $0002 is clear; it is set by the answer 'Okay, wait' (code_0F99B6)
    COP [16]
    COP [9F] ( #$FFF8 )
    COP [80] ( #05 )
    COP [82]
    COP [9F] ( #$0008 )
    COP [81] ( #04, #02 )
    COP [83]
    COP [80] ( #00 )
    COP [82]
    COP [01] ( &asciistring_0F9A0F )
    BRK #$4E
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [81] ( #19, #02 )
    COP [83]
    BRK #$4E
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [80] ( #18 )
    COP [82]
    COP [01] ( &asciistring_0F9A3F )
    BRK #$4E
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [80] ( #00 )
    COP [82]
    COP [01] ( &asciistring_0F9A6F )
    LDA #$2F80
    TRB $joy_block_mask
    COP [17] ( &code_0F99D1 )
    COP [15]
    COP [91]
    COP [80] ( #00 )
    COP [82]
    RTL 
}

code_0F997F {
    COP [16]
    COP [17] ( &code_0F99D1 )
    COP [9F] ( #$FFF8 )
    COP [80] ( #05 )
    COP [82]
    COP [9F] ( #$0008 )
    COP [81] ( #04, #02 )
    COP [83]
    COP [15]
    COP [91]
    COP [80] ( #00 )
    COP [82]
    RTL 
}

---------------------------------------------
; Talk handler of the blocking west guard: 'Have you seen the Queen of the Mermaids?' with Yes / No. Yes (menu result 0): 'Lue, the dolphin has been captured! Please save him!' and she steps aside (COP 27 to code_0F997F). No or cancel: 'Okay, wait.', the talk handler is cleared, flag $0002 is set and the pad is blocked: the guard script continues with the Queen's secret.
; 
; In: X = D = slot; the menu result is in L_choice_result ($03D0).
; Out: RTL or yield through COP 27.
; Clobbers: A.

code_0F99A2 {
    COP [01] ( &asciistring_0F99E0 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_0F99B6 )
    LDA $L_choice_result
    BNE code_0F99B6
    BRL loc_0F99C9
}

code_0F99B6 {
    COP [01] ( &asciistring_0F9A00 )
    COP [17] ( #$0000 )
    COP [09] ( #$8002 )
    LDA #$2F80
    TSB $joy_block_mask
    RTL 

  loc_0F99C9:
    COP [01] ( &asciistring_0F9AA7 )
    COP [27] ( &code_0F997F )
}

---------------------------------------------
; Talk handler of the west guard after she has stepped aside: Thunder Ring (item $24) missing: 'Lue, the dolphin has been captured! Please save him!'; owned: 'Lue can leave whenever he wishes, but he never comes out. Maybe he likes that place.'
; 
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0F99D1 {
    COP [18] ( #24, &code_0F99DB )
    COP [01] ( &asciistring_0F9AAB )
    RTL 
}

code_0F99DB {
    COP [01] ( &asciistring_0F9AA7 )
    RTL 
}

asciistring_0F99E0 |[10]Have you seen the [N]Queen of the Mermaids?[END]|

asciistring_0F9A00 |Okay, wait- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|

asciistring_0F9A0F |[10][0A]This█is█a█secret,█the[N]Queen█looks█like█this-[FIN][END]|

asciistring_0F9A3F |[0A]She█always█sits█like[N]this-[N]She█looks█so█mean-[FIN][END]|

asciistring_0F9A6F |[0A]Lue,█the█dolphin█has[N]been█captured![N]Please█save█him![JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|

asciistring_0F9AA7 |[10][JMP:&asciistring_0F9A6F]|

asciistring_0F9AAB |[10]Lue can leave whenever[N]he wishes, but he [N]never comes out- [FIN]Maybe he likes that [N]place- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|
---------------------------------------------

; The statue of the arrival in the Sanctuary (switches $B6 and $9D).
; 
; When: placement script.
; Sees: the Queen free ($B6 set): kills itself. Else the passage of the Rockbird statue ($9D) not yet released: talk handler code_0FA031 ('heard a small voice. This is St. Elles Palace in the ocean. No human can live under the sea. Go to the island, Southerta, through the shrine and look for the Bubble Clothing.', sets flag $0502); released: code_0FA03A ('Listen closely to the advice of the 4 mermaid statues.').
; Why: the first words of the chapter (walkthrough: 'speak with the statue there; the mermaid within will tell you that no human can live under the ocean').
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_statue_arrival_hint_0FA014 {
    COP [14] ( #$00B6, &code_0FA02E )
    COP [14] ( #$009D, &code_0FA027 )
    COP [17] ( &code_0FA031 )
    COP [91]
    RTL 
}

code_0FA027 {
    COP [17] ( &code_0FA03A )
    COP [91]
    RTL 
}

code_0FA02E {
    COP [86]
    RTL 
}

code_0FA031 {
    COP [01] ( &asciistring_0FA03F )
    COP [09] ( #$8502 )
    RTL 
}

code_0FA03A {
    COP [01] ( &asciistring_0FA0D3 )
    RTL 
}

asciistring_0FA03F |[10][02:2] heard [N]a small voice- [FIN]This is St-Elles [N]Palace in the ocean- [FIN]No human can live [N]under the sea- [FIN]Go to the island, [N]Southerta, through the[N]shrine and look for [N]the Bubble Clothing- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|

asciistring_0FA0D3 |[10]Listen closely to the [N]advice of the 4 [N]mermaid statues- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|
---------------------------------------------

; The water shimmer of the Sanctuary: an HDMA wave on PPU register $0F (BG2HOFS; which layer it moves depends on bg_scroll_swap, OQ-I051-7).
; 
; When: runs every frame while the actor lives.
; Sees: builds 14 HDMA table entries of $90 (16 lines each) at $7E7000 that all point at $7E7100; each frame fills 16 words there from word_0FA834 (a +1 / 0 / -1 / 0 wave, index = frame / 4 + scroll_bg1_y / 2) plus scroll_bg1_x / 2, and queues the table for PPU register $0F (the HDMA channel is chosen by the queue) with QueueHdmaIndirect.
; Why: the screen wobbles horizontally like water.
; In: X = D = slot; DP $00 and $02 are scratch.
; Out: RTL; X restored (PHX / PLX), DBR restored.
; Clobbers: A, Y, DP $00 / $02.

se_effect_sanctuary_wave_hdma_0FA7C4 {
    PHX 
    LDX #$0000

  loc_0FA7C8:
    LDA #$0090
    STA $7E7000, X
    LDA #$7100
    STA $7E7001, X
    INX 
    INX 
    INX 
    CPX #$002A
    BNE loc_0FA7C8
    LDA #$0000
    STA $7E7000, X
    PLX 
    COP [91]
    PHX 
    LDA $scroll_bg1_x     ; the wave is built from the BG1 scroll (x / 2 added to the offsets, y / 2 and frame / 4 select the phase)
    LSR 
    STA $00
    LDA $scroll_bg1_y
    LSR 
    STA $02
    LDA $frame_counter
    LSR 
    LSR 
    CLC 
    ADC $02
    AND #$000F
    ASL 
    TAX 
    LDY #$0000
    SEP #$20
    PHB 
    LDA #$7E
    PHA 
    PLB 
    REP #$20

  loc_0FA80E:
    LDA $@word_0FA834, X
    CLC 
    ADC $00
    STA $7100, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0020
    BNE loc_0FA80E
    PLB 
    SEP #$20
    LDA #$0F
    XBA 
    LDA #$7E
    LDY #$7000
    JSL $@lib_system_helpers.QueueHdmaIndirect
    REP #$20
    PLX 
    RTL 
}
---------------------------------------------

word_0FA834 [
  #$0000   ;00
  #$0000   ;01
  #$0000   ;02
  #$0000   ;03
  #$0001   ;04
  #$0001   ;05
  #$0001   ;06
  #$0001   ;07
  #$0000   ;08
  #$0000   ;09
  #$0000   ;0A
  #$0000   ;0B
  #$FFFF   ;0C
  #$FFFF   ;0D
  #$FFFF   ;0E
  #$FFFF   ;0F
  #$0000   ;10
  #$0000   ;11
  #$0000   ;12
  #$0000   ;13
  #$0001   ;14
  #$0001   ;15
  #$0001   ;16
  #$0001   ;17
  #$0000   ;18
  #$0000   ;19
  #$0000   ;1A
  #$0000   ;1B
  #$FFFF   ;1C
  #$FFFF   ;1D
  #$FFFF   ;1E
  #$FFFF   ;1F
]