; Sixteen actors of the Grass Valley village scenes: the painting in the house on the hill, two animations of the water mill, the boys of the secret hut and the secret passage, the tulip that sits on the Clubhouse Pass, the lonely goat, the gourmet goat, the old man and his goat, the tulip that hints at hidden items, the village Chief, his rocking chair, the voice at the Underground Castle entrance and two fairies. File offsets 103541-109617 (SNES $03:9475-$AC31, bank 03; the Chief's room and the fairies are placed in other scenes, so the file is not contiguous with its scenes). The first half of the village is in gv_village_actors_018000, which also explains how an NPC actor works (COP 14 on the lair switch, appear handler, COP 17 talk handler).
; 
; === ROSTER ===
; Type $17 gv_obj_leos_painting_019475: the painting of the hill house, switch $1A (record $1A frees 'an old man'); its hidden helper lets the hero enter the painting with Leo's Brush.
; Types $18 / $19 gv_obj_water_mill_anim_1C_019644 / gv_obj_water_mill_anim_1D_019656: switch $0E (the water mill keeper), animations $1C / $1D start when flag $0404 (the wheel turned) is set.
; Type $1A gv_npc_boy_secret_hut_019668: switch $23, name 2 'a boy' (the boy who hid the pass).
; Type $1B gv_npc_tulip_clubhouse_pass_0197DA: switch $22, name $0B 'tulip'; the Clubhouse Pass lies under it.
; Type $1C gv_npc_boy_secret_passage_0198A6: switch $25, name 2 'a boy', guards the Child's secret passage and the Strange Bottle tile.
; Type $1D gv_npc_lonely_goat_guide_019A2C: switch $1D, name $0A 'a lonely goat', walks the hero round the village.
; Type $1E gv_npc_gourmet_goat_019CDE: switch $15, name 9 'a goat', wants the tool shop's goat food.
; Type $33 gv_npc_old_man_pet_goat_019EF4: switch $28, name 0 'an old man'.
; Type $34 gv_npc_goat_reincarnation_019F7A: switch $2F, name 9 'a goat'.
; Type $35 gv_npc_tulip_hidden_item_hint_01A004: switch $2E, name $0B 'tulip'.
; Type $36 gv_npc_village_chief_01A098: switch $09 (the Metal Mantis lair), name $15 'The village Chief', the Brown Stone and the Master's voice (Chief's room, A01S04).
; Type $58 gv_obj_chief_rocking_chair_01A34B: the chair of the Chief's room, removed once the Chief is back.
; Type $59 gv_npc_castle_entrance_voice_01AA26: the small voice at the Underground Castle entrance, no switch.
; Type $37 gv_npc_fairy_recover_sword_01AB4F: switch $2C, a fairy in a gem that gives the Recover Sword.
; Type $38 gv_npc_fairy_exp_80_01AC06: the fairy of the treasure room (A01S03), gives 80 EXP once.
; 
; === EVENT FLAGS AND ITEMS USED (flag word: byte x 256 + bit) ===
; $0006 the hero stands before the painting (cleared when he leaves the tile). $0005 the boy of the hut was spoken to. $0206 the Clubhouse Pass was taken from under the tulip. $0200 the boy of the passage saw the pass (set before he steps aside), $0201 he stands aside. $0904 the Strange Bottle was taken. $0102 the lonely goat has finished its tour. $0205 the gourmet goat has been fed. $1B00 the Master's voice about the Brown Stone was heard. $0905 the entrance voice has spoken. $1C00 the Recover Sword was given, $1C01 the 80 EXP were given. $0404 the water mill wheel was turned (gv_village_actors_018000). Items: $1D Leo's Brush, $1B a pass (the Clubhouse Pass: removed when the boy accepts it), $19 Goat's Food, $3A Brown Stone, $39 Strange Bottle, $07 the Recover Sword, $1C Dream Rod.
; 
; === NOTES ===
; - The ROM prints 'Recover Sword' (asciistring_01AB83); the walkthrough (items.md, chapter 6) says 'Recovery Sword' (OQ-I034-3).
; - The fairies share their setup and idle loop with the other fairies of the game (shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161 / cm_npc_fairy_gem_idle_01B17C: gem animation 7, turn to the hero within 24 pixels).
; - The strings of the tool shop texts are in gv_village_actors_018000; the fairy texts of this file are in gv_watching_over_world_texts.
---------------------------------------------

?BANK 03

?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'gv_watching_over_world_texts'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!joy_pressed                    0322
!joy_block_mask                 0326

---------------------------------------------

; The painting of the house on the hill: it shows a strange face and, with Leo's Brush, takes the hero in.
; 
; When: meta type $17; hidden until switch $1A (lair record $1A frees 'an old man' to his home tile ($3A,$0B)).
; Sees: the painting animates (animations 3 and 4, flipped each round); talk: 'This was painted by Dr-Leo. A strange face has appeared! It's terrifying!!'; after the Chief is back (switch $09) 'The face of the village Chief has disappeared!! What was that?'. On the return trip after freeing record $1A a child shows 'You hear a man screaming inside the house. AHHHH!! A GHOST! A GHOST!'. A hidden helper (COP AC, flags $2000) watches tile ($30,$04) in front of the painting: with Leo's Brush ($1D) equipped '<name> is dragged into the painting!' and the scene changes to area 3 scene 1 (Leo's Paintings 1); without it 'There is a picture of the village Chief in the painting, he appears to be sad' (once per visit, flag $0006), or 'The painting has returned to normal' after the Chief's return.
; Why: the walkthrough: to enter the painting you must 'touch it with something owned by the artist' (the goat tells it, gv_npc_gourmet_goat_019CDE).
; In: actor script, X = own slot.
; Out: RTL after COP 14; the appear handler loops the two animations for ever.
; Clobbers: A.

gv_obj_leos_painting_019475 {
    COP [14] ( #$001A, &code_01947C )
    RTL 
}

code_01947C {
    COP [30] ( #$001A, &code_019505, #03 )
    COP [AC] ( @code_0194BE, #$0000, #$0010, #$2000 ) ; hidden helper (flags $2000) placed at the top of the map: it only watches tile ($30,$04) in front of the painting
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
    COP [0D] ( #00, #30, #04, &code_0194CE ) ; slot 0 is the hero: his tile ($30,$04) in front of the painting
}

code_0194C9 {
    COP [09] ( #$0006 )
    RTL 
}

code_0194CE {
    COP [19] ( #1D, &code_0194E1 ) ; item $1D is Leo's Brush: not equipped jumps to the 'sad face' texts, equipped drags the hero into the painting
    COP [01] ( &asciistring_01954B )
    COP [10] ( #$0103, #01, #$0078, #$03E0 ) ; area 3 scene 1: Leo's Paintings 1
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

; The first moving part of the water mill: animation $1C, started when the wheel is turned.
; 
; When: meta type $18; registered on switch $0E (the water mill keeper).
; Sees: nothing until the hero has turned the wheel (flag $0404, set by gv_npc_water_mill_keeper_0186A2); then animation $1C plays for ever.
; Why: the mill only moves once the elevator is powered.
; In: actor script, X = own slot.
; Out: RTL until switch $0E is set; then COP 05 waits for the flag and animation $1C repeats.
; Clobbers: A.

gv_obj_water_mill_anim_1C_019644 {
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

; The second moving part of the water mill: animation $1D, started when the wheel is turned.
; 
; When: meta type $19; registered on switch $0E.
; Sees: as gv_obj_water_mill_anim_1C_019644, with animation $1D (what it draws is not identified, OQ-I034-4).
; Why: the mill is two actors, one per animation.
; In: actor script, X = own slot.
; Out: RTL until switch $0E is set; then COP 05 waits for flag $0404 and animation $1D repeats.
; Clobbers: A.

gv_obj_water_mill_anim_1D_019656 {
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

; The boy of the secret hut, the owner of the Clubhouse Pass.
; 
; When: meta type $1A; hidden until switch $23 (lair record $23 frees name 2 'a boy' to his home tile ($36,$3C); the walkthrough: 'defeat the Monster Blocks ... release a boy').
; Sees: talk 'This is our secret hut. We have hidden treasure near here.' (flag $0005). When the hero steps on tile ($38,$3A) he says 'Oh! You scared me!'; after the tulip lair (switch $22) is released and the hero comes to tile ($3C,$37) the boy runs off (animations $0F, $11, $10, $11) and later says 'Were you following me? I will not tell you where our treasure is.' Once the pass has been taken (flag $0206): with the pass ($1B) in the inventory 'Oh! That's my pass! Well, okay, I'll give it to you.', without it 'Was the pass helpful?'.
; Why: the boy hid the pass under a tulip (gv_npc_tulip_hidden_item_hint_01A004: 'A boy may have hidden something under one').
; In: actor script, X = own slot.
; Out: RTL after COP 14; block tiles, talk handler code_0196FD, then the tile watch.
; Clobbers: A.

gv_npc_boy_secret_hut_019668 {
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

; The tulip that can be pushed aside to uncover the Clubhouse Pass.
; 
; When: meta type $1B; hidden until switch $22 (lair record $22 frees name $0B 'tulip' to its home tile ($2E,$39)).
; Sees: with the Dream Rod ($1C) equipped '<name> placed the Dream Rod on the tulip's petal' and the hero enters the tulip's dream (area 3 scene 4, gv_leos_paintings_actors); otherwise 'Zzzz'. Standing at tile ($2F,$36), east of it, and pressing Left moves the tulip one tile west (animation $20 for 16 repeats); on the tile it left ($2E,$36) the hero reads 'There is a pass' and receives the Clubhouse Pass ($1B, sound $5E, flag $0206). The walkthrough: 'face it from the east, then use L/R and the D-Pad to move it. On the spot that it was on, you'll find the Clubhouse Pass.'
; Why: the pass is not in a chest; the push is the puzzle.
; In: actor script, X = own slot. Input is locked ($2F80) while the tulip slides.
; Out: RTL after COP 14; the loop code_0197F6 yields every frame until Left is pressed.
; Clobbers: A.

gv_npc_tulip_clubhouse_pass_0197DA {
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
    AND #$0200            ; Left newly pressed while the hero stands east of the tulip: push it one tile west
    BEQ loc_019843
    COP [0D] ( #00, #2F, #36, &code_01980B )
    BRL loc_019843
}

code_01980B {
    COP [04]
    COP [16]
    LDA #$2F80
    TSB $joy_block_mask
    COP [81] ( #20, #10 ) ; animation $20 for 16 repeats: the tulip slides to the west
    COP [83]
    LDA #$2F80
    TRB $joy_block_mask
    COP [15]
    COP [07] ( #$8206, &code_019840 )
    COP [91]
    COP [0D] ( #00, #2E, #36, &code_019833 ) ; tile ($2E,$36) is the tulip's old tile: the Clubhouse Pass is under it
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
    COP [10] ( #$0403, #00, #$0078, #$0070 ) ; area 3 scene 4: the tulip's dream
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

; The boy who guards the Child's secret passage and stands near the Strange Bottle.
; 
; When: meta type $1C; hidden until switch $25 (lair record $25 frees name 2 'a boy' to his home tile ($2D,$12) after the Leo's Paintings 4 lair; the walkthrough: 'The switch beneath their lair will release a boy').
; Sees: without the pass: 'This is our secret passage. I cannot let you through without a pass.' With the pass ($1B) equipped: 'Oh, the pass! Where did you find it? You can go inside now.' (the pass is removed, flag $0200), then 'Would you please move over a little so I can let you pass?'; when the hero is within 2 pixels he steps aside (animations $0F, $11, $0E, flip), blocks his new tiles and sets flag $0201; next time he is already moved (COP 11 puts him on tile ($2C,$13)) and says 'I am tired of playing hide and seek. I must find something else to do.' On tile ($28,$0B) the hero finds 'There is a strange bottle' once (Strange Bottle $39, flag $0904). The walkthrough: 'speak with the boy there. He'll permit you inside' and 'walk on the tile pictured to find a Strange Bottle'.
; Why: the boy's own tiles are the door; moving him opens the passage.
; In: actor script, X = own slot (slot $14 = itself).
; Out: RTL after COP 14.
; Clobbers: A.

gv_npc_boy_secret_passage_0198A6 {
    COP [14] ( #$0025, &code_0198AD )
    RTL 
}

code_0198AD {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01991A )
    COP [91]
    COP [07] ( #$0201, &code_0198C8 )
    COP [11] ( #14, #2C, #13 ) ; slot $14 is this actor: it moves itself to tile ($2C,$13), where it stands once the passage is open
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
    COP [0D] ( #00, #28, #0B, &code_019905 ) ; tile ($28,$0B): the Strange Bottle, given once (flag $0904)
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
    COP [0B] ( #1B )      ; the pass is taken away when the boy accepts it
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

; The lonely goat, who shows the hero round the village.
; 
; When: meta type $1D; hidden until switch $1D (lair record $1D frees name $0A 'a lonely goat' to its home tile ($3B,$2D); the walkthrough: 'releasing a lonely goat').
; Sees: first talk: 'You are the one who set me free, right? Come, I shall show you around. Please follow me.' Each talk starts a short walk (steps of 8 pixels with animations $1A / $1B) and the next text: 'This is the home of Dr-Leo the inventor and his daughter, Lisa ... soldiers came and took Dr-Leo away', then 'The house at the top of this cliff contains a painting by Dr-Leo ... The World of Evil', then 'This is a house people constructed for the goats ... I did see something on the ground near the corner of the fence' (the herb of the pen; flag $0102 stops the tour). While it walks it answers 'This is all I will tell you. Please follow me.'
; Why: a guided tour needs the goat to move, so the walk is unblocked tile by tile (COP 16 / COP 15).
; In: actor script, X = own slot (slot $15 = itself, moved to tile ($32,$2A) by COP 11 on the first appearance).
; Out: RTL after COP 14.
; Clobbers: A.

gv_npc_lonely_goat_guide_019A2C {
    COP [14] ( #$001D, &code_019A33 )
    RTL 
}

code_019A33 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [07] ( #$0102, &code_019A46 )
    COP [11] ( #15, #32, #2A ) ; slot $15 is this goat: first appearance puts it on tile ($32,$2A) and skips the tour text
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

; The gourmet goat: it tells how to enter the painting in exchange for the tool shop's goat food.
; 
; When: meta type $1E; hidden until switch $15 (lair record $15 frees name 9 'a goat' to its home tile ($27,$26)).
; Sees: without Goat's Food ($19): 'I am known among my friends as something of a Gourmet Goat. I will only eat food sold at the tool shop.' With it: 'Oh! You have some food from the tool shop! I promise to tell you a secret if you will give me the food.' (Yes / No). No: 'Oh come on!, Please!!' and the question again. Yes: 'Thank you! I will tell you a secret. If you wish to get inside the painting, you must equip an item which used to belong to the painter and touch the painting.' (the food is removed, flag $0205); the goat then walks off (a series of 8 and 16 pixel steps) and afterwards answers 'I love food from the tool shop!' / 'Hey, give me my food!'.
; Why: the walkthrough: 'if you hand over the Goat Food, you'll learn that to enter the painting in the house atop the hill, you must touch it with something owned by the artist.'
; In: actor script, X = own slot.
; Out: RTL after COP 14; COP 05 waits for flag $0205.
; Clobbers: A.

gv_npc_gourmet_goat_019CDE {
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

; An old man who keeps a goat as a pet.
; 
; When: meta type $33; hidden until switch $28 (lair record $28 frees name 0 'an old man' to his home tile ($13,$2C)).
; Sees: 'Since losing my wife to an illness, I noticed a goat hanging around my place. I was so lonely I decided to keep the goat as a pet.' He blocks his tiles and stands still.
; Why: story texture; with the goat of gv_npc_goat_reincarnation_019F7A it is a pair.
; In: actor script, X = own slot.
; Out: RTL after COP 14.
; Clobbers: A.

gv_npc_old_man_pet_goat_019EF4 {
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

; A goat that speaks of reincarnation and its 'husband'.
; 
; When: meta type $34; hidden until switch $2F (lair record $2F frees name 9 'a goat' to its home tile ($16,$28)).
; Sees: 'I don't know if there is such a thing as reincarnation. Even though I can't communicate with my husband, I enjoy his company.' It plays animation $24 once (a still pose).
; Why: the pair with the old man of gv_npc_old_man_pet_goat_019EF4 (the goat is presumably his wife, OQ-I034-5).
; In: actor script, X = own slot.
; Out: RTL after COP 14.
; Clobbers: A.

gv_npc_goat_reincarnation_019F7A {
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

; A tulip that tells where hidden items lie.
; 
; When: meta type $35; hidden until switch $2E (lair record $2E frees name $0B 'tulip' to its home tile ($30,$32)).
; Sees: 'Be sure to check underneath all of the tulips. A boy may have hidden something under one. He thought that no one was watching, but I saw him!'
; Why: the hint for the Clubhouse Pass under gv_npc_tulip_clubhouse_pass_0197DA.
; In: actor script, X = own slot.
; Out: RTL after COP 14; the appear handler loops animation $1E.
; Clobbers: A.

gv_npc_tulip_hidden_item_hint_01A004 {
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

; The village Chief, back in his room after the Metal Mantis: he gives the Brown Stone.
; 
; When: meta type $36 (scene A01S04, the Chief's room); hidden until switch $09 (lair record $09: the Metal Mantis lair of Leo's Paintings, home location 04 tile ($06,$07), name $15 'The village Chief').
; Sees: on the return trip (COP 30, record $09) 'Welcome to my room. I finally feel like myself again. I have something to tell you. Please come back to my house.' and a full heal (COP 37). Later: with the Brown Stone ($3A) missing 'I feel as though I have been surrounded by darkness. In that darkness I heard my best friend Leo. He told me to give this Brown Stone to a person named <name> ...' and the hero receives the stone (sound $5E); afterwards 'Dr-Leo has only a daughter named Lisa. I will ask my wife to look after her until Dr-Leo returns.' When the hero enters with the Brown Stone and flag $1B00 clear the Master's voice speaks: 'The Brown Stone you have is a key to open the World of Evil. This is where Deathtoll lives! Come back to me with the stone.' (flag $1B00; music fades through COP 31 / COP 32 and two effect actors, animations $45 and $46, are spawned).
; Why: the Chief carries the stone from Leo and the voice is a one-time cutscene gated by the flag.
; In: actor script, X = own slot (slot 1 = itself, moved to tile ($04,$08) by COP 11). Input locked ($2F80) during the cutscene.
; Out: RTL after COP 14.
; Clobbers: A.

gv_npc_village_chief_01A098 {
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
    COP [07] ( #$9B00, &code_01A0C5 ) ; flag $1B00 set (the Master's voice was heard) or no Brown Stone: no cutscene
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
    COP [09] ( #$9B00 )   ; flag $1B00: the Master's voice plays once
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

; The Chief's chair in his room.
; 
; When: meta type $58 (scene A01S04); present from the start.
; Sees: animation $23; talk: 'This is the room of the village Chief. He used to sit and rock here for hours. I wonder when he is going to come back?'; it removes itself once switch $09 (the Chief's return) is set.
; Why: the chair gives way to the Chief himself (gv_npc_village_chief_01A098). That it is a rocking chair follows from the text only.
; In: actor script, X = own slot.
; Out: COP 14 jumps to the RTL that kills the actor; otherwise one animation step and RTL.
; Clobbers: A.

gv_obj_chief_rocking_chair_01A34B {
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

; The small voice at the entrance of the Underground Castle.
; 
; When: meta type $59, in the village scene near the stairs south-west of the start; no switch.
; Sees: when the hero comes within 2 pixels '<name> heard a small voice. There are many creatures being held in the Underground Castle. If you can release those creatures, the village will be reconstructed.' once (flag $0905); afterwards, and as a talk handler, 'There are many creatures being held in the Underground Castle ...'; after the Chief's return (switch $09) 'Thank you for saving the villagers. They are now taking care of me. No creature likes to live alone. We have to help each other.' It plays animation $1E.
; Why: the walkthrough: 'as you reach the entrance of the Underground Castle dungeon, you'll hear a voice'.
; In: actor script, X = own slot; the hidden helper (COP B0, flags $2000) is the proximity trigger.
; Out: block tiles, COP 14 on switch $09 chooses the talk handler.
; Clobbers: A.

gv_npc_castle_entrance_voice_01AA26 {
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

; A fairy in a gem that gives the Recover Sword.
; 
; When: meta type $37 in the village scene (tile ($27,$05)), switch $2C (lair record $2C frees name $0C 'ivy' in Leo's Paintings 4); the walkthrough (chapter 6): 'vines leading up to a Fairy Gem. The Fairy within will give you the Recovery Sword.'
; Sees: 'I am watching over this world. Please take this sword. <name> received the Recover Sword.' once (item $07, flag $1C00, sound $5E); afterwards 'Alright, continue on. Good luck!'.
; Why: the fairy setup is the shared one (shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161, idle loop cm_npc_fairy_gem_idle_01B17C, which the root enters through a pushed return address).
; In: actor script, X = own slot.
; Out: RTL after COP 14 until the switch is set.
; Clobbers: A.

gv_npc_fairy_recover_sword_01AB4F {
    COP [14] ( #$002C, &code_01AB56 )
    RTL 
}

code_01AB56 {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_01AB6A )
    SEP #$20              ; RTL trick: the return address of the shared fairy idle loop cm_npc_fairy_gem_idle_01B17C is pushed, so the root continues there
    LDA #$^shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C-1
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

; The fairy of the treasure room: 80 EXP, once.
; 
; When: meta type $38 in the treasure room (A01S03, tile ($07,$04)); no switch.
; Sees: 'I am watching over the world. Please take this. <name> received EXP!' and 80 EXP (COP 38, flag $1C01); afterwards 'Alright, continue on. Good luck!'. The walkthrough: 'Speak with the fairy within for a simple 80 EXP.'
; Why: the same shared fairy setup as gv_npc_fairy_recover_sword_01AB4F.
; In: actor script, X = own slot.
; Out: code_01AC1A is the talk handler; the root continues in shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C.
; Clobbers: A.

gv_npc_fairy_exp_80_01AC06 {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_01AC1A )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C-1
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