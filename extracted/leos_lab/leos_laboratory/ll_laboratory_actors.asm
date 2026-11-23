; The NPCs, doors, models and dream actors of Leo's Laboratory (file offsets 140579-146898, SNES $04:A523-$BDD2): the five scenes of area $0D (A0DS01 laboratory 1, A0DS02 laboratory 2, A0DS03 the attic, A0DS04 the mice nest, A0DS05 the cat's dream). Walkthrough chapter: docs/walkthrough/06-dr-leos-lab.md.
; 
; === WHAT RUNS HERE ===
; The laboratory holds one NPC for each lair of the Laboratory Dungeon and the Town Models that frees somebody: the lair record (LairRecords) has the home location ($51 laboratory 1, $52 laboratory 2, $53 attic, $54 mice nest) and the byte at +9 says who ($27 a great door, $28 a cat, $29 a plant, $2A a mouse, $2B a chest of drawers, $2C a doll, $2D the doll Marie, $2E a model of town). PlacementA0DSnn rows are the actors: the row index is the actor slot and the last byte is the meta type (MetaLeosLab: $05-$1C, $2B, $2C, $33-$36) that picks the script.
; - COP 14 (switch, &code) roots: RTL every frame until the lair with that record number is released; then the script continues at &code. Every NPC then spawns a puff (COP 85 RunAppearPuff), sets a talk handler (COP 17), usually blocks its own tiles (COP 15) and keeps its entry with COP 91. The switch number is the lair record index (checked for every root below).
; - COP 30 (switch, &code, $04) in the door $12, the sleeping cat $13 and Marie $19: when the hero came home through that lair record (return_active, return_record) a one-shot actor is spawned at &code that shows one line and kills itself (the three ll_npc_*_arrival_text_* actors).
; - Doors ($06, $07, $11, $12, $33): the 'door' swings open (animation 01) with BRK #$43 when the hero touches its box (COP 0C, margin 2) and closes (animation 02, BRK #$43) when he leaves; the speaking doors talk through the talk handler.
; - Every text ends with [JMP] into ll_watching_over_world_return_prompt_texts.asciistring_023FA3, the common end of a dialogue. The ROM prints an apostrophe as a space and a full stop as a dash ('Dr-Leo s', 'Laboratory-'); the notes quote the text as meant. The silent doors' texts are rows of dashes ('---------'), i.e. a row of full stops.
; 
; === ROSTER (root: type, tile, switch and lair, what is said or given) ===
; Laboratory 1 (A0DS01):
; - ll_npc_drawers_exercise_022523: $05, ($1D,$16), switch $137 (a chest of drawers; Toy lair type $27 in the Town Model $5B). 'My back hurts because I have been sitting too long. I should get up and exercise.' then, always: 'It scares people when we move. But we are just exercising.' (animation 05).
; - ll_npc_door_silent_0225C4: $06, ($16,$0F), switch $112 (a great door; Sweeper Bot lair in the basement $56). A door that says only a row of full stops and swings.
; - ll_npc_door_locked_key_02260D: $07, ($0B,$0F), switch $11A (a great door; Mini Race Car lair, basement $56). 'My body is locked. There should be a key somewhere in the laboratory.' With the door key equipped and the hero at tile ($0B,$0D): '<name> used the door key.', flag $0800 set, the door opens.
; - ll_npc_mouse_cats_scared_0226C0: $08, ($02,$04), switch $129 (a mouse; Mini Bulldozer lair, basement $57). 'Would you please take the cats out of the room? I am too scared to move around with them in here.' When both cats are out: 'Thank you very much. Now I can walk around the room freely. Let me give you something. Please come inside.' (no item is given by this script; OQ-I038-10).
; - ll_npc_cat_follower_a_022794: $09, ($0C,$05), switch $114 (a cat; Mini Bulldozer lair, basement $56). 'We don't really like to chase rats. Cats just have to eat in order to live.' With the Leaves equipped he follows the hero to tile ($16,$10) ('What a pleasant smell.').
; - ll_npc_cat_follower_b_022886: $0A, ($10,$09), switch $10D (a cat; Sweeper Bot lair, basement $56). 'This is Dr-Leo's Laboratory. This house has a second floor and an attic.' The same follow script ('What a good smell.').
; - ll_npc_cat_door_hint_02297C: $0B, ($08,$14), switch $11B (a cat; Sweeper Bot lair, basement $56). 'Doors are usually quiet, but there are some talkative ones. Try and talk to all of them.' He stays (animation 15).
; - ll_npc_drawers_mystic_armor_0229DF: $0C, ($02,$10), switch $10C (a chest of drawers; Mini Race Car lair, basement $56). 'Take the Mystic Armor from my drawer.' (item $0D) or 'My body is made from the trees in GreenWood.'; pushed to the side (the hero presses Left at tile ($04,$10)) it shows Master's Emblem G (item $30, flag $1A06).
; - ll_npc_plant_door_soul_hint_022AFB: $0D, ($0D,$10), switch $139 (a plant; Toy lair type $26, Town Model $5B). 'If the soul of the Great Door joins you, you will be able to see the invisible enemies in the models of town. Listen to what the cat says.'
; - ll_npc_plant_medical_herb_022B80: $0E, ($1A,$09), switch $109 (a plant; Mini Bulldozer lair, basement $56). 'Would you like a Medical Herb?' Yes: 'Take any leaves that you want from my body. OUCH! <name> received a Medical Herb.' (item $38), or 'Medical Herbs are part of my body. I cannot give many at one time.' when he already has one; No: 'Oh, really? Come and ask me when you are in trouble.'
; - ll_npc_plant_models_story_022C7C: $0F, ($01,$07), switch $10B (a plant; Sweeper Bot lair, basement $56). 'The room on the second floor is Dr-Leo's. There were two models of town in his room. Many creatures were swallowed into the models.'
; - ll_npc_door_entrance_talk_023A36: $33, ($16,$15), no switch. 'This is Dr-Leo's laboratory. There are machines lurking around here which only the powerful Zantetsu Sword can defeat. First of all, talk to a certain door to get you into the room.' After the first talk (flag $0600) it only swings.
; Laboratory 2 (A0DS02):
; - ll_npc_mouse_purify_022D05: $10, ($14,$05), switch $14A (a mouse; Catapult lair, Town Model $5B). 'I am a devout mouse, stand here and you will be purified.' On tile ($14,$05) with Up pressed: '<name> felt his body and mind become purified.' and a full heal.
; - ll_npc_door_silent_022DC6: $11, ($0A,$19), switch $120 (a great door; Mini Bulldozer lair, basement $57). Silent, swings.
; - ll_npc_door_soul_of_detection_022E10: $12, ($14,$19), switch $142 (a great door; Toy Soldier lair, Town Model $5B). 'Even though I don't look like it, I am from the sky just like you. Let me join you. The soul that enables you to see invisible enemies in model towns joins you.' souls_flags bit $08, flag $0603; the door then vanishes (animation 1F).
; - ll_npc_cat_dream_key_022F68: $13, ($09,$09), switch $126 (a cat; Ball Worm lair, basement $57). With the Dream Rod equipped the hero is sent into the cat's dream (A0DS05); afterwards the cat gives the door key (item $27).
; - ll_npc_mouse_magic_hint_02312F: $14, ($06,$04), switch $13E (a mouse; Toy lair type $26, Town Model $5B). 'Use magic to defeat the enemies which you cannot reach.'
; - ll_npc_plant_actinidia_02317F: $15, ($0C,$04), switch $14D (a plant; Toy Soldier lair, Town Model $5C). 'I am an Actinidia. Take some of my leaves if you want. OUCH! <name> received Actinidia leaves.' (item $26 'Leaves') or 'I am happy to help you.'
; - ll_npc_doll_machines_story_023214: $16, ($10,$04), switch $136 (a doll; Ball Worm lair, basement $58). 'The large machines in the basement were the machines which summoned evil. They were made by Dr-Leo. When those machines started to move, the cities were destroyed.'
; - ll_obj_model_town_1_0239BA / ll_obj_model_town_2_0239F8: $2B ($02,$0F) switch $11E and $2C ($05,$0F) switch $145 (a model of town). '<name> is swallowed into the model.' and the scene changes to the Town Model 1 (A0FS01) or 2 (A0FS02) at pixel ($01F8,$03E0).
; Attic (A0DS03):
; - ll_npc_drawers_herb_storage_0232B3: $17, ($0D,$03), switch $14C (a chest of drawers; Toy lair type $26, Town Model $5C). The herb store: 'Would you store your Medical Herbs in my drawer?' takes the Medical Herb (flag $0807) and gives it back when the hero has none.
; - ll_npc_cat_marie_room_02345D: $18, ($06,$03, flipped), switch $153 (a cat; Toy Soldier lair, Town Model $5C). 'This room belongs to a doll named Marie. She told me many things about foreign towns. A girl named Lisa took care of Marie.'
; - ll_npc_marie_purple_stone_0234EC: $19, ($0A,$03), switch $12F (the doll Marie; the Tin Doll's lair, location $59). Gives the Purple Stone (item $3E, flag $1B04); after the ending (flag $1F02) she holds the closing monologue and the scene changes to the Soul of Mountain House (A0AS01).
; Mice nest (A0DS04): ll_npc_mouse_weak_timid_0237A7 ($1A, ($08,$09), switch $152), ll_npc_mouse_born_plant_02382D ($1B, ($0B,$0B), switch $13B) dance and talk; ll_npc_mouse_spark_bomb_0238A7 ($1C, ($13,$05), switch $13C) gives the Spark Bomb (item $15) once both cats are out of the laboratory.
; The cat's dream (A0DS05): ll_dream_scene_023B0B ($34, ($0C,$06)), ll_dream_actor_a_023D6B ($35, ($0E,$06)) and ll_dream_actor_b_023D84 ($36, ($16,$0F)).
; 
; === FLAGS (event flag word: low byte = bit, bits 8-14 = byte; bytes 0-4 are scene-local, from byte 5 persistent) ===
; $0605 / $0606: cat A / cat B has been led out of the kitchen (tile ($16,$10)); read by the mouse $08, the Spark Bomb mouse $1C and the cats themselves. $0002: scene flag, the mouse $08 may walk (both cats out and she has thanked the hero). $0800: the key door is open. $0603: the Soul of Detection has been given. $0801: the cat's dream has been seen (set by ll_dream_scene_023B0B, read by ll_npc_cat_dream_key_022F68); $0802: the door key has been given. $1A06: Master's Emblem G taken. $0807: Medical Herb stored in the attic drawer. $0600: the entrance door has been talked to. $1B04: Purple Stone given. $1F02: the ending ran (RunEnding). In the dream scene the scene flags $0000-$0003 hand the lines from one actor to the next (OQ-I038-6).
; 
; === ITEMS GIVEN OR TESTED ===
; $26 Leaves (equipped: the cats follow), $27 a door key, $0D Mystic Armor, $30 Emblem G (the text says Master's Emblem G), $38 Medical Herb, $15 Spark Bomb, $3E Purple Stone, $1C Dream Rod (equipped test). BRK #$5E is the jingle before each COP 0A, BRK #$4E the one of the soul.
---------------------------------------------

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

; The chest of drawers that exercises: it complains about its back.
; 
; When: placement script (type $05, tile ($1D,$16) of A0DS01); COP 14 returns until lair record $137 (a chest of drawers; Toy lair, Town Model $5B) is released.
; Sees: puff, blocked tiles, priority $30, talk handler code_02254C ('My back hurts because I have been sitting too long. I should get up and exercise.'), animation 08. After the first talk code_02254C yields into code_022540: new handler code_022554 ('It scares people when we move. But we are just exercising.') and animation 05 (the exercise). The walkthrough: 'You can speak with the chest of drawers downstairs for a rather odd scene with it'.
; Why: a joke NPC; no item.
; In: X = D = slot $01.
; Out: RTL.
; Clobbers: A.

ll_npc_drawers_exercise_022523 {
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

; A great door that cannot speak: it swings and answers with full stops.
; 
; When: placement script (type $06, tile ($16,$0F) of A0DS01); COP 14 returns until lair record $112 (a great door; Sweeper Bot lair, basement $56) is released.
; Sees: puff, talk handler code_0225FA (the row of full stops), then the swing loop: with the hero inside the box (COP 0C, margin 2) code_0225E7 plays animation 01 with BRK #$43; when he leaves loc_0225D7 plays animation 02 with BRK #$43.
; Why: the laboratory's doors open for the hero; the speaking doors are the ones with text.
; In: X = D = slot $02.
; Out: RTL.
; Clobbers: A.

ll_npc_door_silent_0225C4 {
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

; The locked door: it opens when the hero stands in front of it with the door key equipped.
; 
; When: placement script (type $07, tile ($0B,$0F) of A0DS01); COP 14 returns until lair record $11A (a great door; Mini Race Car lair, basement $56) is released. With flag $0800 set it goes straight to the swing loop code_02265C.
; Sees: puff, talk handler code_022678 ('My body is locked. There should be a key somewhere in the laboratory.'), blocked tiles. loc_022625 tests every frame (COP 0D) whether the hero stands at tile ($0B,$0D); then code_02262F: key ($27) not equipped (COP 19) shows the same text again, equipped shows '<name> used the door key.', sets flag $0800, clears the talk handler (COP 17 $0000), frees the tiles and starts the swing. The walkthrough: 'Go back to the first floor with it equipped ... just run into the door; don't use B'.
; Why: the first-floor door that leads to the rooms of the lab.
; In: X = D = slot $03.
; Out: RTL.
; Clobbers: A.

ll_npc_door_locked_key_02260D {
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

; The mouse of the first floor who is afraid of the two cats.
; 
; When: placement script (type $08, tile ($02,$04) of A0DS01); COP 14 returns until lair record $129 (a mouse; Mini Bulldozer lair, basement $57) is released.
; Sees: puff, talk handler code_0226F7. Flag $0605 clear, or $0606 clear: 'Would you please take the cats out of the room?'; both set: code_022708 'Thank you very much ... Please come inside.' and flag $0002. The body: with $0605 clear, or $0606 clear, code_0226DC blocks the mouse's tiles and COP 05 waits for flag $0002, then unblocks them; code_0226E4 plays animation 0F with flip X set and animation 0C with flip X clear, blocks the tiles again and keeps the entry. With both cats already out at load the mouse goes straight to code_0226E4.
; Why: the two cats (ll_npc_cat_follower_a_022794 and _b) must be taken out first; the mouse then stops blocking.
; In: X = D = slot $04.
; Out: RTL.
; Clobbers: A.

ll_npc_mouse_cats_scared_0226C0 {
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
    COP [05] ( #$0002 )   ; scene flag $0002 is set by the talk handler once both cats are out; only then does the mouse free her tiles
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

; The first cat: with the Leaves equipped he follows the hero out of the kitchen.
; 
; When: placement script (type $09, tile ($0C,$05) of A0DS01, slot $05); COP 14 returns until lair record $114 (a cat; Mini Bulldozer lair, basement $56) is released.
; Sees: with flag $0605 set (already led out) code_022817 puts him on tile ($14,$11) (COP 11 on slot 5) and he sits (animation 13). Otherwise he blocks his tiles and loops: Leaves ($26) not equipped (COP 19) animation 13 and again; equipped and the hero touching (COP 0C, margin 2): code_0227BE sets the handler 'What a pleasant smell.' and the follow loop code_0227C4 walks toward the hero (COP 9C picks the axis, COP 9A / 9B with threshold $10 pick animation 12 with flip X, 11 or 10) until he is at tile ($16,$10) (COP 0D on slot 5): code_022809 sets flag $0605 and he sits there.
; Why: the walkthrough: 'make both follow you southeast and outside the kitchen'; the two cats end up in the hall and the mouse $08 and $1C notice.
; In: X = D = slot $05.
; Out: RTL.
; Clobbers: A.

ll_npc_cat_follower_a_022794 {
    COP [14] ( #$0114, &code_02279B )
    RTL 
}

code_02279B {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02282A )
    COP [07] ( #$8605, &code_022817 )
    COP [15]

  loc_0227AC:
    COP [19] ( #26, &code_0227B7 ) ; jumps to the idle animation unless the Leaves (item $26) are equipped
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
    COP [0D] ( #05, #16, #10, &code_022809 ) ; slot 5 is this cat itself: it has reached tile ($16,$10), the way out of the kitchen
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
    COP [11] ( #05, #14, #11 ) ; flag $0605 already set: the cat is put on tile ($14,$11) at once

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

; The second cat: the same follow script with slot $06, flag $0606 and its own texts.
; 
; When: placement script (type $0A, tile ($10,$09) of A0DS01, slot $06); COP 14 returns until lair record $10D (a cat; Sweeper Bot lair, basement $56) is released.
; Sees: talk handler code_022923 ('This is Dr-Leo's Laboratory. This house has a second floor and an attic.'); idle animation 14; when he follows (Leaves equipped, hero touching) he first flips (COP 96), plays animation 1A and sets the handler code_022928 ('What a good smell.'); the follow loop code_0228BB is the one of the first cat (target tile ($16,$10), flag $0606). With $0606 set at load, code_022910 moves slot 6 to tile ($18,$11).
; Why: see the first cat.
; In: X = D = slot $06.
; Out: RTL.
; Clobbers: A.

ll_npc_cat_follower_b_022886 {
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
    COP [0D] ( #06, #16, #10, &code_022902 ) ; slot 6 is this cat: it has reached tile ($16,$10)
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
    COP [11] ( #06, #18, #11 ) ; flag $0606 already set: the cat is put on tile ($18,$11) at once

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

; The third cat: he only talks and tells the hero to talk to the doors.
; 
; When: placement script (type $0B, tile ($08,$14) of A0DS01); COP 14 returns until lair record $11B (a cat; Sweeper Bot lair, basement $56) is released.
; Sees: puff, talk handler code_022994 ('Doors are usually quiet, but there are some talkative ones. Try and talk to all of them.'), animation 15, no blocked tiles.
; Why: the hint towards the speaking door ll_npc_door_soul_of_detection_022E10; the walkthrough's cats are the two that follow the Leaves.
; In: X = D = slot $07.
; Out: RTL.
; Clobbers: A.

ll_npc_cat_door_hint_02297C {
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

; The chest of drawers of the first floor: it gives the Mystic Armor and can be pushed aside to show Master's Emblem G.
; 
; When: placement script (type $0C, tile ($02,$10) of A0DS01); COP 14 returns until lair record $10C (a chest of drawers; Mini Race Car lair, basement $56) is released.
; Sees: puff, talk handler code_022A69: Mystic Armor ($0D) missing (COP 18) shows 'Take the Mystic Armor from my drawer.' and code_022A48 (input blocked with $2F80, animations 1B and 1C, '<name> received the Mystic Armor', item $0D); owned: 'My body is made from the trees in GreenWood.' The loop code_0229F1 (animation 08) waits for a new Left press (joy_pressed $0200) with the hero at tile ($04,$10): code_022A0C blocks the pad, frees the tiles, plays animation 1D 16 times (the slide), blocks the tiles again and, with the hero at tile ($03,$10), code_022A32 shows '<name> found Master's Emblem G' once (item $30, flag $1A06). The walkthrough: 'get on the chest's right side. Face north and hold R, then move left to push aside the chest of drawers' (OQ-I038-7).
; Why: a reward hidden by a pushable object.
; In: X = D = slot $08.
; Out: RTL.
; Clobbers: A.

ll_npc_drawers_mystic_armor_0229DF {
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
    LDA $joy_pressed      ; joy_pressed bit $0200 = Left newly pressed (the push)
    AND #$0200
    BEQ loc_022A2E
    COP [0D] ( #00, #04, #10, &code_022A0C ) ; the hero must stand at tile ($04,$10), east of the drawers
    BRA loc_022A2E
}

code_022A0C {
    COP [04]
    LDA #$2F80            ; $2F80 = Select, the four directions and A: the pad is blocked during the slide
    TSB $joy_block_mask
    COP [16]
    COP [81] ( #1D, #10 ) ; the slide of the drawers: animation $1D, 16 repeats
    COP [83]
    COP [15]
    LDA #$2F80
    TRB $joy_block_mask
    COP [91]
    COP [0D] ( #00, #03, #10, &code_022A32 ) ; the hero has to be at tile ($03,$10) after the slide (OQ-I038-7)
    RTL 

  loc_022A2E:
    COP [27] ( &code_0229F1 )
}

code_022A32 {
    COP [07] ( #$9A06, &code_022A45 )
    COP [01] ( &asciistring_022ADC )
    BRK #$5E
    COP [0A] ( #30 )
    COP [09] ( #$9A06 )   ; flag $1A06: Master's Emblem G has been taken (persistent)
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
    COP [18] ( #0D, &code_022A73 ) ; COP 18 jumps while the Mystic Armor (item $0D) is missing: the offer
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

; A plant that tells the hero about the soul of the Great Door.
; 
; When: placement script (type $0D, tile ($0D,$10) of A0DS01); COP 14 returns until lair record $139 (a plant; Toy lair type $26, Town Model $5B) is released.
; Sees: puff, blocked tiles, talk handler code_022B15 ('If the soul of the Great Door joins you, you will be able to see the invisible enemies in the models of town. Listen to what the cat says.'), animation 03.
; Why: points to the Soul of Detection ($08 of souls_flags) and to the cat $0B.
; In: X = D = slot $09.
; Out: RTL.
; Clobbers: A.

ll_npc_plant_door_soul_hint_022AFB {
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

; The plant of the kitchen that gives a Medical Herb whenever the hero has none.
; 
; When: placement script (type $0E, tile ($1A,$09) of A0DS01); COP 14 returns until lair record $109 (a plant; Mini Bulldozer lair, basement $56) is released.
; Sees: blocked tiles, y moved up by 4 (COP A0), puff, animation 03. Talk handler code_022B9E: 'Would you like a Medical Herb?' with Yes / No (COP 1A). Yes (choice 0) and no Medical Herb ($38 missing, COP 18): code_022BB9 shows 'Take any leaves that you want from my body. OUCH! <name> received a Medical Herb.' with BRK #$5E and item $38; yes with a herb: 'Medical Herbs are part of my body. I cannot give many at one time.'; No: code_022BC3 'Oh, really? Come and ask me when you are in trouble.'. The walkthrough: 'a Medical Herb from the plant in the lab kitchen'.
; Why: an endless herb source that never lets the hero hold two.
; In: X = D = slot $0A.
; Out: RTL.
; Clobbers: A.

ll_npc_plant_medical_herb_022B80 {
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
    COP [18] ( #38, &code_022BB9 ) ; COP 18 jumps while no Medical Herb ($38) is owned: only then is one given
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

; A plant that tells where Dr-Leo's models are.
; 
; When: placement script (type $0F, tile ($01,$07) of A0DS01); COP 14 returns until lair record $10B (a plant; Sweeper Bot lair, basement $56) is released.
; Sees: blocked tiles, y moved up by 4, puff, animation 03, talk handler code_022C9A ('The room on the second floor is Dr-Leo's. There were two models of town in his room. Many creatures were swallowed into the models.').
; Why: the hint to the models of laboratory 2 (ll_obj_model_town_1_0239BA and _2).
; In: X = D = slot $0B.
; Out: RTL.
; Clobbers: A.

ll_npc_plant_models_story_022C7C {
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

; The devout mouse: standing on his tile and pressing Up heals the hero.
; 
; When: placement script (type $10, tile ($14,$05) of A0DS02); COP 14 returns until lair record $14A (a mouse; Catapult lair, Town Model $5B) is released.
; Sees: puff, blocked tiles, talk handler code_022D63 ('I am a devout mouse, stand here and you will be purified.', sets scene flag $0000). The body waits for the flag (COP 05) with the tiles freed, turns (COP 9A picks code_022D27 or code_022D37: animations 0F and 0C with the flip X set in the two orders), blocks his tiles again and tests every frame whether the hero is at tile ($14,$05) (COP 0D): code_022D51 needs a new Up press (joy_pressed $0800) and then shows '<name> felt his body and mind become purified.' with COP 37 (full heal).
; Why: a free healing spot in laboratory 2.
; In: X = D = slot $01.
; Out: RTL.
; Clobbers: A.

ll_npc_mouse_purify_022D05 {
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
    COP [0D] ( #00, #14, #05, &code_022D51 ) ; the hero must stand on tile ($14,$05), where the mouse used to sit
    RTL 
}

code_022D51 {
    LDA $joy_pressed
    AND #$0800            ; joy_pressed bit $0800 = Up newly pressed
    BNE loc_022D5A
    RTL 

  loc_022D5A:
    COP [01] ( &asciistring_022D98 )
    COP [37]              ; heal_pending = max HP - HP (full heal)
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

; The second silent great door (laboratory 2): swings, answers with full stops.
; 
; When: placement script (type $11, tile ($0A,$19) of A0DS02); COP 14 returns until lair record $120 (a great door; Mini Bulldozer lair, basement $57) is released.
; Sees: puff, talk handler code_022DFC (a row of full stops), swing loop (animation 01 / 02 with BRK #$43) as in ll_npc_door_silent_0225C4.
; Why: see there.
; In: X = D = slot $02.
; Out: RTL.
; Clobbers: A.

ll_npc_door_silent_022DC6 {
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

; The speaking door that gives the Soul of Detection and then vanishes.
; 
; When: placement script (type $12, tile ($14,$19) of A0DS02); COP 14 returns until lair record $142 (a great door; Toy Soldier lair, Town Model $5B) is released. COP 30 spawns ll_npc_door_arrival_text_022E7E when the hero came home through that record. With flag $0603 set the door is already gone (code_022E53).
; Sees: puff, talk handler code_022E60: 'Even though I don't look like it, I am from the sky just like you. Let me join you. The soul that enables you to see invisible enemies in model towns joins you.', flag $0603, BRK #$4E and souls_flags |= $08 (the Soul of Detection), handler cleared, then code_022E53: puff, animation 1F (the door is gone). Before the talk it swings like the other doors (loc_022E30 / code_022E40). The walkthrough: 'the door will claim to be from the sky ... Soul of Detection ... note how the door disappears'.
; Why: the soul that shows the invisible enemies of the Town Models.
; In: X = D = slot $03.
; Out: RTL.
; Clobbers: A.

ll_npc_door_soul_of_detection_022E10 {
    COP [14] ( #$0142, &code_022E17 )
    RTL 
}

code_022E17 {
    COP [30] ( #$0142, &ll_npc_door_arrival_text_022E7E, #04 ) ; one-shot arrival text when the hero came home through lair record $142
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
    ORA #$08              ; souls_flags bit $08 = the Soul of Detection (wram map)
    STA $souls_flags
    REP #$20
    COP [17] ( #$0000 )
    COP [27] ( &code_022E53 )
}

---------------------------------------------
; One-shot actor: the door's line when the hero arrives through its lair.
; 
; When: spawned by COP 30 in ll_npc_door_soul_of_detection_022E10 when return_record is $142.
; Sees: '<name> hears the door speaking to itself. I can see------ I can see machines throwing bombs inside the model towns.' (after a pause of $3C frames), then COP 86.
; Why: the first words of the door, shown while the release scene runs (OQ-I038-11).
; In: X = the new actor.
; Out: RTL after the kill.
; Clobbers: A.

ll_npc_door_arrival_text_022E7E {
    COP [01] ( &asciistring_022E85 )
    COP [86]
    RTL 
}

asciistring_022E85 |[10][0E:3C][02:2] hears [N]the door [N]speaking to itself- [FIN]I can see------ [FIN]I can see machines [N]throwing bombs inside [N]the model towns- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_022EEE |[10]Even though I don t [N]look like it, I am [N]from the sky just like[N]you- [FIN]Let me join you- [FIN]The soul that enables [N]you to see invisible [N]enemies in model towns[N]joins you- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

; The sleeping cat: the Dream Rod sends the hero into the cat's dream, the key follows.
; 
; When: placement script (type $13, tile ($09,$09) of A0DS02, slot $04); COP 14 returns until lair record $126 (a cat; Ball Worm lair, basement $57) is released. COP 30 spawns ll_npc_cat_arrival_text_022FF3 on arrival through that record.
; Sees: puff, talk handler code_022FCD: key already given (flag $0802): 'There are invisible enemies in the models town. Please be careful.'; Dream Rod ($1C) not equipped: 'Zzzzz'; equipped: '<name> places the Dream Rod on the cat's head.', COP 3C ($04) and the scene change to A0DS05 (the cat's dream) at pixel ($00C0,$0010). Back from the dream (flag $0801 set by ll_dream_scene_023B0B) the hero standing at tile ($09,$0A), just south of the cat, triggers code_022F91: input blocked ($2F80), animation 13, a pause of $1F frames, 'Lately, I always see Dr-Leo in my dreams ... Oh yes, I will give you this ... <name> received a door key.', item $27, flag $0802, the talk handler restored. The walkthrough: 'Speak to him with the Dream Rod equipped; after the scene, you'll receive a Door Key.'
; Why: the key of the locked door ll_npc_door_locked_key_02260D.
; In: X = D = slot $04.
; Out: RTL.
; Clobbers: A.

ll_npc_cat_dream_key_022F68 {
    COP [14] ( #$0126, &code_022F6F )
    RTL 
}

code_022F6F {
    COP [30] ( #$0126, &ll_npc_cat_arrival_text_022FF3, #04 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_022FCD )
    COP [15]
    COP [07] ( #$8802, &code_022FC5 )
    COP [91]
    COP [0D] ( #00, #09, #0A, &code_022F91 ) ; the hero must stand at tile ($09,$0A), just south of the cat
    RTL 
}

code_022F91 {
    COP [07] ( #$0801, &code_022FC2 ) ; bit 15 clear: jumps (and does nothing) while flag $0801, set by the dream, is still clear
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
    COP [10] ( #$050D, #01, #$00C0, #$0010 ) ; area $0D scene $05: the cat's dream (A0DS05) at pixel ($00C0,$0010)
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

---------------------------------------------
; One-shot actor: the cat's line when the hero arrives through its lair.
; 
; When: spawned by COP 30 in ll_npc_cat_dream_key_022F68 when return_record is $126.
; Sees: '<name> The cat is sleeping. He looks as though he is suffering. Uh, uh, Dr-Leo?' (after a pause of $3C frames), then COP 86.
; Why: the hint to use the Dream Rod.
; In: X = the new actor.
; Out: RTL after the kill.
; Clobbers: A.

ll_npc_cat_arrival_text_022FF3 {
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

; A mouse that tells the hero to use magic against unreachable enemies.
; 
; When: placement script (type $14, tile ($06,$04) of A0DS02); COP 14 returns until lair record $13E (a mouse; Toy lair type $26, Town Model $5B) is released.
; Sees: puff, blocked tiles, talk handler code_023144 ('Use magic to defeat the enemies which you cannot reach.').
; Why: the Town Models' catapults and spike launchers sit out of sword reach.
; In: X = D = slot $05.
; Out: RTL.
; Clobbers: A.

ll_npc_mouse_magic_hint_02312F {
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

; The Actinidia plant: it gives the Leaves that make the cats follow.
; 
; When: placement script (type $15, tile ($0C,$04) of A0DS02); COP 14 returns until lair record $14D (a plant; Toy Soldier lair, Town Model $5C) is released.
; Sees: puff, blocked tiles, animation 03, talk handler code_023199: Leaves ($26) missing (COP 18) shows code_0231A3 'I am an Actinidia. Take some of my leaves if you want. OUCH! <name> received Actinidia leaves.' with BRK #$5E and item $26; owned: 'I am happy to help you.'
; Why: the Leaves ($26, equipped) are what the cats $09 and $0A follow.
; In: X = D = slot $06.
; Out: RTL.
; Clobbers: A.

ll_npc_plant_actinidia_02317F {
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

; A doll that tells what the machines of the basement were.
; 
; When: placement script (type $16, tile ($10,$04) of A0DS02); COP 14 returns until lair record $136 (a doll; Ball Worm lair, basement $58) is released.
; Sees: puff, blocked tiles, animation 18, talk handler code_02322E ('The large machines in the basement were the machines which summoned evil. They were made by Dr-Leo. When those machines started to move, the cities were destroyed.'). The walkthrough: 'That one will release a doll back in the lab'.
; Why: backstory of the dungeon.
; In: X = D = slot $07.
; Out: RTL.
; Clobbers: A.

ll_npc_doll_machines_story_023214 {
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

; The attic drawers that keep a Medical Herb for the hero.
; 
; When: placement script (type $17, tile ($0D,$03) of A0DS03); COP 14 returns until lair record $14C (a chest of drawers; Toy lair type $26, Town Model $5C) is released.
; Sees: puff, blocked tiles, animation 07, talk handler code_0232CD. Flag $0807 clear: no herb owned (COP 18 on $38): 'If there's nothing in a chest, a chest doesn't mean anything.'; with a herb: 'If there's nothing in a chest then the chest is good for nothing. Would you store your Medical Herbs in my drawer?' Yes: '<name> put his Medical Herbs in the drawer. I am satisfied.', COP 0B removes the herb, flag $0807 set; No: 'I am the happiest chest in the world.' With $0807 set (code_0232FF): no herb owned: 'Are you taking them out? Well, it's okay.', item $38 and the flag cleared; with a herb: 'You have a Medical Herb. I will give them back to you when you have run out.' The walkthrough calls it the 'Herb-storage chest'.
; Why: a safe place for the one herb the hero can hold (the kitchen plant never gives a second one).
; In: X = D = slot $01.
; Out: RTL.
; Clobbers: A.

ll_npc_drawers_herb_storage_0232B3 {
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
    COP [18] ( #38, &code_0232FA ) ; COP 18 jumps when no herb is owned: the 'nothing to store' text
    COP [01] ( &asciistring_023317 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_0232F5 )
    LDA $L_choice_result
    BNE code_0232F5
    COP [01] ( &asciistring_0233D0 )
    COP [0B] ( #38 )      ; removes the Medical Herb from the inventory
    COP [09] ( #$8807 )   ; flag $0807 = a herb is stored in the drawer (persistent)
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
    COP [09] ( #$0807 )   ; flag $0807 cleared again: the herb has been taken out
    RTL 
}

asciistring_023317 |[10]If there s nothing in[N]a chest then the chest[N]is good for nothing- [FIN]Would you store your [N]Medical Herbs in my [N]drawer? [END]|

asciistring_023374 |[10]If there s nothing [N]in a chest, [N]a chest doesn t mean [N]anything- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_0233B1 |I am the happiest [N]chest in the world- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_0233D0 |[02:2] put [N]his Medical Herbs [N]in the drawer- [FIN]I am satisfied- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_023403 |[10]Are you taking them [N]out? Well, it s okay- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_02342E |[10]You have a Medical [N]Herb- I will give [N]them back to you when [N]you have run out- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

; The cat of Marie's room.
; 
; When: placement script (type $18, tile ($06,$03) of A0DS03, flipped, slot $02); COP 14 returns until lair record $153 (a cat; Toy Soldier lair, Town Model $5C) is released.
; Sees: puff, blocked tiles, animation 15, talk handler code_023477 ('This room belongs to a doll named Marie. She told me many things about foreign towns. A girl named Lisa took care of Marie.').
; Why: backstory (Lisa and Marie).
; In: X = D = slot $02.
; Out: RTL.
; Clobbers: A.

ll_npc_cat_marie_room_02345D {
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

; The doll Marie: she gives the Purple Stone, and after the ending she closes the epilogue.
; 
; When: placement script (type $19, tile ($0A,$03) of A0DS03, slot $03); COP 14 returns until lair record $12F (the doll Marie; the Tin Doll's lair, location $59) is released. COP 30 spawns ll_npc_marie_arrival_text_023558 on arrival through that record. With flag $1F02 set (RunEnding ran) the script goes to ll_npc_marie_epilogue_scene_023513.
; Sees: puff, blocked tiles, animation 18, talk handler code_02353F: flag $1B04 clear: 'Nobody can break a promise that is made with Evil. There will be no revival of the world unless Deathtoll is defeated. Dr-Leo must be somewhere in the Magridd Castle. Here, take this stone from my pocket and go to the Magridd Castle.' with BRK #$5E, item $3E (Purple Stone) and flag $1B04; set: code_023553 'I wonder how Lisa is, I want to see her after the world is revived.' The walkthrough: 'Speak with the doll and you'll receive the Purple Stone'.
; Why: the last of the stones; the epilogue branch is part of the ending chain.
; In: X = D = slot $03.
; Out: RTL.
; Clobbers: A.

ll_npc_marie_purple_stone_0234EC {
    COP [14] ( #$012F, &code_0234F3 )
    RTL 
}

code_0234F3 {
    COP [30] ( #$012F, &ll_npc_marie_arrival_text_023558, #04 )
    COP [07] ( #$9F02, &ll_npc_marie_epilogue_scene_023513 ) ; flag $1F02 is set by RunEnding: the epilogue scene
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02353F )
    COP [15]
    COP [91]
    COP [80] ( #18 )
    COP [82]
    RTL 
}

---------------------------------------------
; Marie's closing monologue in the ending, then the scene change to the Soul of Mountain House.
; 
; When: jumped to by ll_npc_marie_purple_stone_0234EC with event flag $1F02 (set by RunEnding) set.
; Sees: the pad blocked (joy_block_mask |= $BFC0), a pause of $29 frames, the monologue ('<name>, you made it. Dr-Leo can pass away peacefully. We tools, exist to be used by human beings. ... The tools Dr-Leo used must have been happy.', with [0E:n] delays of $3C, $5A and $78 frames between the lines), a pause of $5B frames, asset_skip_mask = $0020, then COP 10 to area $0A scene 1 (the Soul of Mountain House, A0AS01) at pixel ($0100,$0380); the mask is cleared and the entry kept.
; Why: one link of the ending's tour through the worlds (OQ-I038-9).
; In: X = D = slot $03.
; Out: RTL.
; Clobbers: A.

ll_npc_marie_epilogue_scene_023513 {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_023675 )
    COP [03] ( #5B )
    COP [04]
    LDA #$0020
    STA $asset_skip_mask
    COP [10] ( #$010A, #01, #$0100, #$0380 ) ; area $0A scene 1: the Soul of Mountain House (A0AS01) at pixel ($0100,$0380)
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_02353F {
    COP [07] ( #$9B04, &code_023553 )
    COP [01] ( &asciistring_0235AC )
    BRK #$5E
    COP [0A] ( #3E )      ; item $3E = the Purple Stone
    COP [09] ( #$9B04 )   ; flag $1B04: the Purple Stone has been given
    RTL 
}

code_023553 {
    COP [01] ( &asciistring_023644 )
    RTL 
}

---------------------------------------------
; One-shot actor: Marie's line when the hero arrives through her lair.
; 
; When: spawned by COP 30 in ll_npc_marie_purple_stone_0234EC when return_record is $12F.
; Sees: '<name> I am Marie, the doll. I have a Purple Stone in my pocket. Take this with you and save Dr-Leo.' (after a pause of $3C frames), COP 37 (full heal) and COP 86.
; Why: the release scene of the boss lair; the stone itself is given later by the attic script.
; In: X = the new actor.
; Out: RTL after the kill.
; Clobbers: A.

ll_npc_marie_arrival_text_023558 {
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

; A dancing mouse of the nest: 'We are weak and timid animals'.
; 
; When: placement script (type $1A, tile ($08,$09) of A0DS04); COP 14 returns until lair record $152 (a mouse; Toy Soldier lair, Town Model $5C) is released.
; Sees: puff, talk handler code_0237DB ('We are weak and timid animals. Don't you think it's unfair the weaker creatures are defeated first?'). The body plays animation 1E (8 times) and then loops: 0D (2), flip X set, 0F (3), 0E (2), flip X clear, 0F (3), with COP 81 / 83. The mouse does not block its tiles.
; Why: ambience; the line is the mice's complaint about the order of the Monster Lairs.
; In: X = D = slot $01.
; Out: RTL (every step yields in COP 83).
; Clobbers: A.

ll_npc_mouse_weak_timid_0237A7 {
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

; The second dancing mouse: 'I would have liked to have been born a plant'.
; 
; When: placement script (type $1B, tile ($0B,$0B) of A0DS04); COP 14 returns until lair record $13B (a mouse; Toy Soldier lair, Town Model $5B) is released.
; Sees: puff, talk handler code_023861 ('I would have liked to have been born a plant. I would not fear anything.'); animation 1E (8 times), then the dance loop with the flips in the other order (0E, flip X set, 0F, 0D, flip X clear, 0F).
; Why: ambience.
; In: X = D = slot $02.
; Out: RTL.
; Clobbers: A.

ll_npc_mouse_born_plant_02382D {
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

; The mouse that gives the Spark Bomb once both cats are out of the laboratory.
; 
; When: placement script (type $1C, tile ($13,$05) of A0DS04); COP 14 returns until lair record $13C (a mouse; Toy lair type $26, Town Model $5B) is released.
; Sees: puff, blocked tiles; the loop alternates animation 0C and, with the hero within the box widened by 4 (COP 0C), animation 1E. Talk handler code_0238D3: flag $0605 clear or $0606 clear: 'We cannot walk around outside because of the cats.'; both set: Spark Bomb ($15) missing (COP 18): 'Thank you for getting rid of the cats. Take this magic, the Magic of Spark Bomb. <name> received Spark Bomb.' with BRK #$5E and item $15; owned: 'It is not easy to hit the enemies with Spark Bomb, but if you do, it works very well.'
; Why: the reward for leading both cats (flags set by ll_npc_cat_follower_a_022794 and _b) out of the laboratory.
; In: X = D = slot $03.
; Out: RTL.
; Clobbers: A.

ll_npc_mouse_spark_bomb_0238A7 {
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

; Model of town 1 (laboratory 2): talking to it swallows the hero.
; 
; When: placement script (type $2B, tile ($02,$0F) of A0DS02); COP 14 returns until lair record $11E (a model of town; Sweeper Bot lair, basement $57) is released.
; Sees: talk handler code_0239C8 (the hero's name and 'is swallowed into the model.') and COP 10 to area $0F scene 1 (A0FS01, Town Model 1) at pixel ($01F8,$03E0).
; Why: the entry of the Town Models.
; In: X = D = slot $08.
; Out: RTL.
; Clobbers: A.

ll_obj_model_town_1_0239BA {
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
    COP [10] ( #$010F, #01, #$01F8, #$03E0 ) ; area $0F scene 1: Town Model 1 (A0FS01) at pixel ($01F8,$03E0)
    RTL 
}

asciistring_0239D6 |[10][0F][02:2] is [N]swallowed into the [N]model- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

; Model of town 2 (laboratory 2): the same, for the second model.
; 
; When: placement script (type $2C, tile ($05,$0F) of A0DS02); COP 14 returns until lair record $145 (a model of town; Toy Soldier lair, Town Model $5B) is released.
; Sees: talk handler code_023A06: as in ll_obj_model_town_1_0239BA, COP 10 to area $0F scene 2 (A0FS02, Town Model 2) at pixel ($01F8,$03E0).
; Why: the entry of the second Town Model.
; In: X = D = slot $09.
; Out: RTL.
; Clobbers: A.

ll_obj_model_town_2_0239F8 {
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

; The door at the entrance of laboratory 1: it blocks until the hero has talked to it once.
; 
; When: placement script (type $33, tile ($16,$15) of A0DS01); no switch.
; Sees: with flag $0600 set it goes straight to the swing loop code_023A4C. Otherwise talk handler code_023A68 ('This is Dr-Leo's laboratory. There are machines lurking around here which only the powerful Zantetsu Sword can defeat. First of all, talk to a certain door to get you into the room.'), sets $0600, frees its tiles, clears the handler and starts the swing (animation 01 / 02 with BRK #$43).
; Why: the door lets the hero in only after the intro; the Zantetsu hint matches the walkthrough's note on the metal enemies (Mini Race Car, Mini Bulldozer, Mini Helicopter).
; In: X = D = slot $0C.
; Out: RTL.
; Clobbers: A.

ll_npc_door_entrance_talk_023A36 {
    COP [07] ( #$8600, &code_023A4C ) ; flag $0600 set after the first talk: the door then only swings
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

; The script of the cat's dream: it shows the four texts and hands over to the two walking actors.
; 
; When: placement script (type $34, tile ($0C,$06) of A0DS05); no switch; the scene is entered with the Dream Rod from ll_npc_cat_dream_key_022F68.
; Sees: input blocked ($2F80), a pause of 3 frames, COP 34 hides the player actors, a pause of $29 frames, text A ('Dr-Leo, King Magridd wishes to see you at once!'), a pause of $15, flip X set, animation 23, text B (the long plea about Deathtoll and the trees), flag $0000 set; wait for flag $0001 (set by ll_dream_actor_b_023D84); text C ('Dr-Leo, you love your daughter Lisa don't you? If you obey, she will remain safe. We will be waiting for you outside in the airship. Come out when you are ready.'), flag $0002 set; wait for flag $0003 (set by ll_dream_actor_a_023D6B); animation 1F, text D ('Please forgive me! The world will go to ruin sooner or later. But I can do nothing more. Oh, Master! Please help me.'), flag $0801 set (the dream has been seen), input released, COP 3C ($04) and COP 10 back to A0DS02 at pixel ($0090,$00A0).
; Why: the dream is Dr-Leo being taken away by King Magridd's men; the speakers are not named by the script (OQ-I038-6).
; In: X = D = slot $02 of A0DS05.
; Out: RTL after the scene change.
; Clobbers: A.

ll_dream_scene_023B0B {
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #02 )
    COP [04]
    COP [34]              ; COP 34 hides the three player actors for the dream
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_023B65 )
    COP [03] ( #15 )
    COP [04]
    COP [96]
    COP [80] ( #23 )
    COP [82]
    COP [01] ( &asciistring_023B88 )
    COP [09] ( #$8000 )   ; flag $0000 is set here and read by ll_dream_actor_b_023D84
    COP [05] ( #$0001 )   ; waits until flag $0001 is set by ll_dream_actor_b_023D84
    COP [01] ( &asciistring_023C8F )
    COP [09] ( #$8002 )
    COP [05] ( #$0003 )   ; waits until flag $0003 is set by ll_dream_actor_a_023D6B
    COP [80] ( #1F )
    COP [82]
    COP [01] ( &asciistring_023D13 )
    COP [09] ( #$8801 )   ; flag $0801: the dream has been seen (read by ll_npc_cat_dream_key_022F68)
    LDA #$2F80
    TRB $joy_block_mask
    COP [3C] ( #04 )
    COP [10] ( #$020D, #01, #$0090, #$00A0 ) ; back to area $0D scene $02 (A0DS02) at pixel ($0090,$00A0)
    RTL 
}

asciistring_023B65 |[10]Dr-Leo, King Magridd [N]wishes to see you at [N]once! [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_023B88 |[10]Are you going to allow[N]him to make a deal [N]with Deathtoll? [FIN]King Magridd knows [N]nothing about the [N]value of human lives! [FIN]No matter how small, [N]all creatures have a [N]right to exist in this[N]world- [FIN]If the trees in this [N]world were cut in [N]half, [FIN]the oxygen would [N]decrease and many of [N]us would die- [FIN][10]We do what King [N]Magridd tells us to [N]do- [FIN]King Magridd makes all[N]of the decisions for [N]us- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_023C8F |[10]Dr-Leo, you love your[N]daughter Lisa don t [N]you? [FIN]If you obey, she will [N]remain safe- [FIN]We will be waiting for[N]you outside in the [N]airship- [FIN]Come out when you are [N]ready- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|

asciistring_023D13 |[10]Please forgive me! [FIN]The world will go to [N]ruin sooner or later- [FIN]But I can do nothing [N]more- [FIN]Oh, Master! Please [N]help me- [JMP:&ll_watching_over_world_return_prompt_texts.asciistring_023FA3]|
---------------------------------------------

; A walker of the dream: leaves after text C.
; 
; When: placement script (type $35, tile ($0E,$06) of A0DS05).
; Sees: waits for flag $0002 (COP 05), flips X, plays animation 17 (4 times) and animation 15 (5 times), sets flag $0003 and ends (COP 86).
; Why: lets ll_dream_scene_023B0B continue with text D.
; In: X = D = slot $03 of A0DS05.
; Out: RTL after the kill.
; Clobbers: A.

ll_dream_actor_a_023D6B {
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

; The other walker of the dream: says 'Hey, it's time to go' and leaves.
; 
; When: placement script (type $36, tile ($16,$0F) of A0DS05).
; Sees: waits for flag $0000 (set after text B), BRK #$43, animation 16 (4 times), flip X cleared, animation 17 (3 times), 'Hey, it's time to go.' (asciistring_023DBC), a pause of $1F frames, flag $0001 set (releases text C), waits for flag $0002, flips X, animation 17 (3 times), animation 15 (5 times), BRK #$43 and ends.
; Why: the coming and going of the dream.
; In: X = D = slot $04 of A0DS05.
; Out: RTL after the kill.
; Clobbers: A.

ll_dream_actor_b_023D84 {
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