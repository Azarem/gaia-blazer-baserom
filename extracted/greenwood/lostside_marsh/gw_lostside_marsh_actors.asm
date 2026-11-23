; The actors of the Lostside marsh and its shrines (file offsets 124027-125395 and 125691-125890, SNES $03:E47B-$E9D2 and $03:EAFB-$EBC1, bank 03; the wave effect of the Woods lies in between): the four fairy gems, the Strange Bottle trigger, the raft system of the marsh (A05S01), the heat of the Fire Shrine bridges and two screen effects. The monsters of the marsh are in gw_lostside_marsh_enemies, the three statue bosses in gw_boss_light_water_fire_statues.
; 
; === THE FAIRY GEMS ===
; A fairy gem is a blue gem with a fairy inside that gives a reward once and then offers to take the hero back to GreenWood. All four share the setup JSL shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161 (animation $07, tiles blocked) and the idle loop cm_npc_fairy_gem_idle_01B17C. Their talk handlers end in gw_fairy_gem_return_prompt_01E4E9: 'Would you like to return to GreenWood?' with the Stay / Go back menu (Go back changes the scene to A04S01 at pixel ($02E0,$01A0)). The text 'I am watching over the world. Please take this. <name> received EXP!' is shared in gw_watching_over_world_return_prompt_texts.
; $3F gw_npc_fairy_gem_exp_150_01E4C3: A05S01 at tile ($03,$06), no switch, visible from the start (meta flags $0050): 150 EXP once (flag $1C05); the walkthrough: 'Speak with the fairy inside to gain 150 EXP.' next to the rafts.
; $40 gw_npc_fairy_gem_exp_180_01E510: A05S03 at ($15,$2C), switch $48 (the Mud Men lair of the second Water Shrine scene): 180 EXP once (flag $1C06).
; $41 gw_npc_fairy_gem_light_arrow_01E540: A05S07 at ($0B,$3C), switch $5E (Lizard Men lair of the third Fire Shrine scene): the Light Arrow Magic (item $12) once (flag $1C07).
; $4D gw_npc_fairy_gem_return_only_01E594: A05S05 at ($03,$0C), switch $53 (the Metal Scorpion lair of the first Fire Shrine scene): 1 EXP at every talk (there is no latch, OQ-I035-17) and the return prompt; the walkthrough names only the fairy of the deepest Fire Shrine floor (the Light Arrow one), not this one.
; 
; === THE RAFTS (A05S01, the marsh between the Fire and the Light Shrine) ===
; Five raft rows sit in PlacementA05S01 (slots $14-$18: types $42, $3A, $3C, $39, $3A). The placer gw_raft_placer_01E5BA runs once when the scene starts, moves the rows to fixed tiles (COP 11) and gives each its script (COP 12) depending on where the hero came in (y below $60, arrival tile ($1C,$20) or ($03,$19)); then it removes itself. The first raft (gw_raft_leaves_check_01E62A) asks for the leaves of GreenWood. A raft is a pair of parts: an entry that waits until the actor is on screen (COP AD, 8 frames) and the body that falls through from it. The body draws behind (COP A4), keeps its tiles free, and when the hero steps into its box (not when he is standing in it already) it spawns a carrier child, blocks its own tiles and plays its animation until a tile test ends the ride; it then hands over to the raft of the opposite direction (the way back): north to south, south to north, west to east, east to west. The carrier child blocks the pad (joy_block_mask $2F80), shifts the hero and his linked actor by two pixels per frame with COP 2F (north (0,-2), south (0,+2), west (-2,0), east (+2,0)), and when flag $0000 is set (the body says the ride is over) shifts once more, clears the flag, releases the pad and kills itself.
; Types: $39 gw_raft_north, $3B gw_raft_south, $3A gw_raft_west, $3C gw_raft_east (the meta type that names the entry in MetaGreenwood; the placer swaps the scripts of the rows, so the type of a row is not the direction it ends up with). Walkthrough: 'only residents of GreenWood are able to ride the rafts connecting the Fire and Light Shrines in the marsh'; 'At the rafts, you'll be allowed to ride (it's irrelevant whether you actually equip the Leaves or not)': the check is COP 18, 'owned', not 'equipped'. Flags: $0401 the leaves were accepted; $0000 the ride-over signal (the same flag number is used by the Woodstin-Trio show in gw_woods_actors_01D045, in another scene). How a ride ends (the COP 22 / 23 / 24 tile tests) was not traced (OQ-I035-6).
; 
; === OTHER ACTORS ===
; $50 gw_trigger_strange_bottle_01E47B: A05S04, a script without a picture that waits for the hero on tile ($0F,$15) and gives the Strange Bottle (item $39) once (flag $0906). $06 gw_effect_fire_bridge_heat_01E98D: the red and dark phases of the bridges of the Fire Shrine, with a damage child. $2B gw_effect_bg2_scroll_01E9C1: drifts the second background upwards. $0C gw_effect_water_ripple_hdma_01EAFB: the ripple of the water, an HDMA effect for the PPU registers $210F and $2110 (fed with the BG1 scroll values; see OQ-I035-16).
; - The strings use the font's hyphen '+' and full stop '-'.
---------------------------------------------

?BANK 03

?INCLUDE 'gw_watching_over_world_return_prompt_texts'
?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!frame_counter                  0312
!joy_block_mask                 0326
!scroll_bg1_y                   033C
!scroll_bg2_y                   0340
!scroll_delta_y                 0384
!player_actor                   039C
!contact_lock                   042D

---------------------------------------------

; The hidden spot where the Strange Bottle lies.
; 
; When: meta type $50, no switch and no picture; placed in A05S04, the third Water Shrine scene (the walkthrough: 'It reveals a hidden path going eastward; if you just head due east from the hall and stand on the stand-out tile ... you'll find a Strange Bottle').
; Sees: nothing until the hero stands on tile ($0F,$15): '<name> found a Strange Bottle.' and the bottle (item $39); afterwards the actor removes itself, and so it does on every later visit once flag $0906 is set.
; Why: the bottle is a hidden item without a chest, so a trigger tile hands it out; flag $0906 stops a second gift.
; In: actor script, X = own slot.
; Out: waits for the tile (COP 91 re-entry), then kills itself (COP 86).
; Clobbers: A.

gw_trigger_strange_bottle_01E47B {
    COP [91]
    COP [0D] ( #00, #0F, #15, &code_01E485 ) ; slot 0 is the hero: the trigger tile ($0F,$15)
    RTL 
}

code_01E485 {
    COP [07] ( #$0906, &code_01E48E )
    COP [86]
    RTL 
}

code_01E48E {
    COP [01] ( &asciistring_01E49E )
    BRK #$5E
    COP [0A] ( #39 )      ; item $39 is the Strange Bottle
    COP [09] ( #$8906 )   ; flag $0906: the bottle was taken
    COP [86]
    RTL 
}

asciistring_01E49E |[10][02:2] found [N][03:24]a Strange Bottle[03:20]-[JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; The first fairy gem of the marsh: 150 EXP.
; 
; When: meta type $3F, no switch (visible from the start); placed at tile ($03,$06) of A05S01, at the end of the rafts. The walkthrough: 'Speak with the fairy inside to gain 150 EXP.! Then go back on the raft to the Light Shrine entrance.'
; Sees: a fairy gem (animation $07). Talked to: 'I am watching over the world. Please take this. <name> received EXP!' and 150 EXP (BCD $0150, COP 38), flag $1C05 set; then the return prompt (gw_fairy_gem_return_prompt_01E4E9). Later talks go to the prompt directly.
; In: actor script, X = own slot; JSL cm_npc_fairy_gem_setup_01B161 sets up the gem.
; Out: a tail jump (RTL with the address of cm_npc_fairy_gem_idle_01B17C pushed) into the shared idle loop.
; Clobbers: A.

gw_npc_fairy_gem_exp_150_01E4C3 {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_01E4D7 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C-1
    PHA 
    RTL 
}

code_01E4D7 {
    COP [07] ( #$9C05, &gw_fairy_gem_return_prompt_01E4E9 )
    COP [01] ( &gw_watching_over_world_return_prompt_texts.asciistring_01EBC2 )
    COP [38] ( #$0150 )   ; BCD: 150 EXP
    COP [09] ( #$9C05 )   ; flag $1C05: the 150 EXP were paid
}
---------------------------------------------

; The question every fairy gem asks after its reward: 'Would you like to return to GreenWood?'
; 
; When: jumped to by the four fairy gems (BRL and COP 07), never run as an actor of its own.
; Sees: the question and the Stay / Go back window. Go back: 'All right, good luck.' and the scene changes to A04S01, the Woods, at pixel ($02E0,$01A0); Stay or cancel: 'Come back to me whenever you feel like returning to GreenWood.'
; Why: the Fairy Gems of the other worlds use the same ChoiceStayGoBackText; this is the GreenWood one.
; In: talk handler, X = the fairy's slot; the choice comes back in $03D0 (index 0 = Stay).
; Out: RTL, or the scene change (INC contact_lock first).
; Clobbers: A.

gw_fairy_gem_return_prompt_01E4E9 {
    COP [01] ( &gw_watching_over_world_return_prompt_texts.asciistring_01EBEA )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceStayGoBackText, #02, &code_01E50B )
    LDA $L_choice_result
    BEQ code_01E50B
    COP [01] ( &gw_watching_over_world_return_prompt_texts.asciistring_01EC09 )
    INC $contact_lock
    COP [10] ( #$0104, #02, #$02E0, #$01A0 ) ; area 4 scene 1: back to the Woods
    RTL 
}

code_01E50B {
    COP [01] ( &gw_watching_over_world_return_prompt_texts.asciistring_01EC1B )
    RTL 
}
---------------------------------------------

; The fairy gem of the second Water Shrine scene: 180 EXP.
; 
; When: meta type $40, switch $48 (lair record $48 in the second Water Shrine scene, Mud Men); placed at tile ($15,$2C) of A05S03 (the walkthrough: 'that lair will spawn a blue fairy gem; speak with the fairy within to earn 180 EXP.! Don't go back to GreenWood, though.').
; Sees: the same speech as gw_npc_fairy_gem_exp_150_01E4C3 with 180 EXP (BCD $0180), flag $1C06, then the return prompt.
; In: actor script, X = own slot.
; Out: tail jump into cm_npc_fairy_gem_idle_01B17C.
; Clobbers: A.

gw_npc_fairy_gem_exp_180_01E510 {
    COP [14] ( #$0048, &code_01E517 )
    RTL 
}

code_01E517 {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_01E52B )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C-1
    PHA 
    RTL 
}

code_01E52B {
    COP [07] ( #$9C06, &gw_fairy_gem_return_prompt_01E4E9 )
    COP [01] ( &gw_watching_over_world_return_prompt_texts.asciistring_01EBC2 )
    COP [38] ( #$0180 )   ; BCD: 180 EXP
    COP [09] ( #$9C06 )
    BRL gw_fairy_gem_return_prompt_01E4E9
}
---------------------------------------------

; The fairy gem of the Light Arrow Magic in the third Fire Shrine scene.
; 
; When: meta type $41, switch $5E (lair record $5E in the third Fire Shrine scene, Lizard Men); placed at tile ($0B,$3C) of A05S07 (the walkthrough: 'defeat the Lizard Men in their lair, then use said lair to release a Fairy Gem ... She will end up giving you the Light Arrow Magic ... After this, she'll offer to return you to GreenWood').
; Sees: 'Here, take this Light Arrow Magic.' and the magic (item $12), flag $1C07 set; then the return prompt.
; In: actor script, X = own slot.
; Out: tail jump into cm_npc_fairy_gem_idle_01B17C.
; Clobbers: A.

gw_npc_fairy_gem_light_arrow_01E540 {
    COP [14] ( #$005E, &code_01E547 )
    RTL 
}

code_01E547 {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_01E55B )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C-1
    PHA 
    RTL 
}

code_01E55B {
    COP [07] ( #$9C07, &gw_fairy_gem_return_prompt_01E4E9 )
    COP [01] ( &asciistring_01E571 )
    BRK #$5E
    COP [0A] ( #12 )      ; item $12 is the Light Arrow Magic
    COP [09] ( #$9C07 )
    BRL gw_fairy_gem_return_prompt_01E4E9
}

asciistring_01E571 |[10]Here, take this [N][03:24]Light Arrow Magic- [03:20][FIN][END]|
---------------------------------------------

; The fairy gem of the first Fire Shrine scene that only offers the way home.
; 
; When: meta type $4D, switch $53 (lair record $53 in the first Fire Shrine scene, Metal Scorpions); placed at tile ($03,$0C) of A05S05; the walkthrough does not describe it.
; Sees: the shared text and 1 EXP at every talk (COP 38 $0001, no latch flag: OQ-I035-17), then the return prompt.
; In: actor script, X = own slot.
; Out: tail jump into cm_npc_fairy_gem_idle_01B17C.
; Clobbers: A.

gw_npc_fairy_gem_return_only_01E594 {
    COP [14] ( #$0053, &code_01E59B )
    RTL 
}

code_01E59B {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_01E5AF )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C-1
    PHA 
    RTL 
}

code_01E5AF {
    COP [01] ( &gw_watching_over_world_return_prompt_texts.asciistring_01EBC2 )
    COP [38] ( #$0001 )   ; 1 EXP at every talk; there is no latch flag here (OQ-I035-17)
    BRL gw_fairy_gem_return_prompt_01E4E9
}
---------------------------------------------

; Moves the five raft rows of the marsh to the places that belong to the hero's entry and gives them their scripts.
; 
; When: meta type $32, no switch, placed in A05S01 (slot $13); runs once at the start of the scene.
; Sees: the rafts lie where the hero can reach them from where he came in.
; Why: the same rows serve both directions of travel between the Fire Shrine and the Light Shrine; the placer chooses the layout. COP 11 sets the tile of the row with the slot number and COP 12 its resume pointer (the script of its direction). With the hero at y >= $0060: arrival tile ($1C,$20): row $16 to ($17,$19) with the west script; arrival tile ($03,$19): row $14 to ($0F,$14) south and row $15 to ($06,$10) east; any other tile: nothing. With the hero above y $0060: row $14 to ($0F,$08) east, $15 to ($1C,$0D) south, $16 to ($17,$19) west, $17 to ($06,$10) east and $18 to ($0F,$14) south.
; In: actor script, X = own slot; reads the player actor via player_actor.
; Out: kills itself (COP 86).
; Clobbers: A, Y.

gw_raft_placer_01E5BA {
    LDY $player_actor
    LDA $0002, Y
    CMP #$0060            ; the hero's y: below $0060 (north of the marsh) or not selects the layout of the rafts
    BCC loc_01E5F5
    COP [0D] ( #00, #1C, #20, &code_01E5D5 ) ; slot 0 is the hero: the arrival tiles ($1C,$20) and ($03,$19)
    COP [0D] ( #00, #03, #19, &code_01E5DF )
    BRA loc_01E627
}

code_01E5D5 {
    COP [11] ( #16, #17, #19 ) ; COP 11 moves a raft row (slot $16) to the tile, COP 12 sets its script
    COP [12] ( #16, &gw_raft_west_01E854 )
}

code_01E5DF {
    COP [11] ( #14, #0F, #14 )
    COP [12] ( #14, &gw_raft_south_01E7D8 )
    COP [11] ( #15, #06, #10 )
    COP [12] ( #15, &gw_raft_east_01E8F0 )
    BRA loc_01E627

  loc_01E5F5:
    COP [11] ( #14, #0F, #08 )
    COP [12] ( #14, &gw_raft_east_01E8F0 )
    COP [11] ( #15, #1C, #0D )
    COP [12] ( #15, &gw_raft_south_01E7D8 )
    COP [11] ( #16, #17, #19 )
    COP [12] ( #16, &gw_raft_west_01E854 )
    COP [11] ( #17, #06, #10 )
    COP [12] ( #17, &gw_raft_east_01E8F0 )
    COP [11] ( #18, #0F, #14 )
    COP [12] ( #18, &gw_raft_south_01E7D8 )

  loc_01E627:
    COP [86]
    RTL 
}
---------------------------------------------

; The first raft: it only carries a visitor who owns the leaves of GreenWood.
; 
; When: meta type $42, placed in A05S01 (slot $14). When flag $0401 is already set it goes straight into the north raft.
; Sees: when the hero touches its box (COP 0C, margin 1) it blocks its two tiles and the pad (joy_block_mask $2F80), plays animations $1A and $30, then tests item $1E: without the leaves '<name> began to hear a small voice. We are rafts made from the branches of trees in GreenWood. If you cannot prove that you are from GreenWood, we will not let you ride.'; with them 'Those are leaves from GreenWood! Turbo's symbol! We will take you to the Light Shrine.', the tiles are freed, flag $0401 is set and the actor continues as the north raft (code_01E682 is a COP 27 jump to gw_raft_north_01E75C).
; Why: the walkthrough: 'only residents of GreenWood are able to ride the rafts ... maybe if you have something of GreenWood'; the check is COP 18 (owned), not equipped.
; In: actor script, X = own slot.
; Out: continues as the north raft; without the leaves the actor loops (COP 91).
; Clobbers: A, joy_block_mask (set, then restored).

gw_raft_leaves_check_01E62A {
    COP [07] ( #$8401, &code_01E682 )
    COP [91]
    COP [0C] ( #00, #01, &code_01E639 )
    RTL 
}

code_01E639 {
    COP [2A] ( #$0000, #$0000 )
    COP [2A] ( #$0010, #$0000 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [81] ( #1A, #02 )
    COP [83]
    COP [1B] ( &code_01E657, #$001E )
}

code_01E657 {
    COP [81] ( #30, #02 )
    COP [83]
    LDA #$2F80
    TRB $joy_block_mask
    COP [18] ( #1E, &code_01E686 ) ; item $1E is the leaves of GreenWood: jumps when they are missing
    COP [01] ( &asciistring_01E712 )
    COP [81] ( #19, #02 )
    COP [83]
    COP [2B] ( #$0000, #$0000 )
    COP [2B] ( #$0010, #$0000 )
    COP [09] ( #$8401 )   ; flag $0401: the rafts accept the hero
}

code_01E682 {
    COP [27] ( &gw_raft_north_01E75C )
}

code_01E686 {
    COP [01] ( &asciistring_01E68D )
    COP [91]
    RTL 
}

asciistring_01E68D |[10][02:2] began to [N]hear a small voice- [FIN]We are rafts made from[N]the branches of trees [N]in GreenWood- [FIN]If you cannot prove [N]that you are from [N]GreenWood, we will not[N]let you ride- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01E712 |[10]Those are leaves from [N]GreenWood! [N]Turbo s symbol! [FIN]We will take you to [N]the Light Shrine- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; Entry of the north raft: wait until the raft is on screen.
; 
; When: meta type $39 and the hand-over from the south raft (COP 27).
; Sees: the raft does nothing until it is on screen; COP AD polls every 8 frames.
; In: actor script, X = own slot.
; Out: falls through into gw_raft_north_01E75C.
; Clobbers: A.

gw_raft_north_entry_01E759 {
    COP [AD] ( #08 )
}
---------------------------------------------

; A raft that carries the hero north.
; 
; When: after the entry (meta type $39) or from the first raft's check.
; Sees: a raft (drawn behind the hero, COP A4) lying in the water; when the hero steps onto it the raft starts to move him two pixels per frame to the north until the ride ends, then it turns into the south raft for the way back.
; Why: the body blocks the tile left of it and frees its own two tiles while waiting; during the ride the tiles swap (own tiles blocked, left tile free) so the carrier and the hero are the only thing that moves. The ride starts only on the frame the hero enters the box (COP 0C twice, the first test returns), so a hero who arrives on the raft does not start it.
; In: actor script, X = own slot.
; Out: spawns the carrier child code_01E7AD (COP 85), loops animation $1A with COP 23, sets flag $0000 (stop signal), then COP 27 to gw_raft_south_entry_01E7D5.
; Clobbers: A.

gw_raft_north_01E75C {
    COP [A4]
    COP [2A] ( #$FFF0, #$0000 )
    COP [2B] ( #$0000, #$0000 )
    COP [2B] ( #$0010, #$0000 )
    COP [91]
    COP [0C] ( #00, #00, &code_01E77B )
    BRL loc_01E77C
}

code_01E77B {
    RTL 

  loc_01E77C:
    COP [91]
    COP [0C] ( #00, #00, &code_01E785 )
    RTL 
}

code_01E785 {
    COP [85] ( @code_01E7AD )
    COP [2B] ( #$FFF0, #$0000 )
    COP [2A] ( #$0000, #$0000 )
    COP [2A] ( #$0010, #$0000 )

  code_01E79C:
    COP [80] ( #1A )
    COP [82]
    COP [23] ( &code_01E79C )
    COP [09] ( #$8000 )   ; flag $0000: tells the carrier that the ride is over
    COP [27] ( &gw_raft_south_entry_01E7D5 )
}

code_01E7AD {
    LDA #$2F80
    TSB $joy_block_mask
    COP [91]
    COP [2F] ( #$0000, #$FFFE ) ; the carrier shifts the hero and his linked actor by (0,-2) every frame
    COP [07] ( #$8000, &code_01E7C2 )
    RTL 
}

code_01E7C2 {
    COP [2F] ( #$0000, #$FFFE )
    COP [09] ( #$0000 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}
---------------------------------------------

; Entry of the south raft: wait until the raft is on screen.
; 
; When: meta type $3B and the hand-over from the north raft.
; In: actor script, X = own slot.
; Out: falls through into gw_raft_south_01E7D8.
; Clobbers: A.

gw_raft_south_entry_01E7D5 {
    COP [AD] ( #08 )
}
---------------------------------------------

; A raft that carries the hero south; the mirror image of gw_raft_north_01E75C.
; 
; When: after the entry (meta type $3B) or as the way back of the north raft.
; Sees: the hero is moved two pixels per frame to the south (carrier child code_01E829); the tile blocks are offset by (0,-16); the animation is $19 and the ride ends with the COP 23 test; the hand-over goes to gw_raft_north_entry_01E759.
; In: actor script, X = own slot.
; Out: as gw_raft_north_01E75C.
; Clobbers: A.

gw_raft_south_01E7D8 {
    COP [A4]
    COP [2A] ( #$FFF0, #$0000 )
    COP [2B] ( #$0000, #$FFF0 )
    COP [2B] ( #$0010, #$FFF0 )
    COP [91]
    COP [0C] ( #00, #00, &code_01E7F7 )
    BRL loc_01E7F8
}

code_01E7F7 {
    RTL 

  loc_01E7F8:
    COP [91]
    COP [0C] ( #00, #00, &code_01E801 )
    RTL 
}

code_01E801 {
    COP [85] ( @code_01E829 )
    COP [2B] ( #$FFF0, #$0000 )
    COP [2A] ( #$0000, #$FFF0 )
    COP [2A] ( #$0010, #$FFF0 )

  code_01E818:
    COP [80] ( #19 )
    COP [82]
    COP [23] ( &code_01E818 )
    COP [09] ( #$8000 )
    COP [27] ( &gw_raft_north_entry_01E759 )
}

code_01E829 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [91]
    COP [2F] ( #$0000, #$0002 )
    COP [07] ( #$8000, &code_01E83E )
    RTL 
}

code_01E83E {
    COP [2F] ( #$0000, #$0002 )
    COP [09] ( #$0000 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}
---------------------------------------------

; Entry of the west raft: wait until the raft is on screen.
; 
; When: meta type $3A and the hand-over from the east raft.
; In: actor script, X = own slot.
; Out: falls through into gw_raft_west_01E854.
; Clobbers: A.

gw_raft_west_entry_01E851 {
    COP [AD] ( #08 )
}
---------------------------------------------

; A raft that carries the hero west.
; 
; When: after the entry (meta type $3A) or as the way back of the east raft.
; Sees: the hero is moved two pixels per frame to the west (carrier child code_01E8C5); the raft blocks and frees its four tiles in a 2 x 2 block; the animation is $1B and the ride ends with a COP 22 test; if the COP 23 test then holds, the raft restarts as west, otherwise it hands over to gw_raft_east_entry_01E8ED.
; In: actor script, X = own slot.
; Out: as gw_raft_north_01E75C.
; Clobbers: A.

gw_raft_west_01E854 {
    COP [A4]
    COP [2A] ( #$0000, #$0010 )
    COP [2B] ( #$0010, #$0000 )
    COP [2B] ( #$0010, #$FFF0 )
    COP [2B] ( #$0000, #$0000 )
    COP [2B] ( #$0000, #$FFF0 )
    COP [91]
    COP [0C] ( #00, #00, &code_01E87F )
    BRL loc_01E880
}

code_01E87F {
    RTL 

  loc_01E880:
    COP [91]
    COP [0C] ( #00, #00, &code_01E889 )
    RTL 
}

code_01E889 {
    COP [85] ( @code_01E8C5 )
    COP [2B] ( #$0000, #$0010 )
    COP [2A] ( #$0010, #$0000 )
    COP [2A] ( #$0010, #$FFF0 )
    COP [2A] ( #$0000, #$0000 )
    COP [2A] ( #$0000, #$FFF0 )

  code_01E8AC:
    COP [80] ( #1B )
    COP [82]
    COP [22] ( &code_01E8AC )
    COP [09] ( #$8000 )
    COP [23] ( &code_01E8C1 )
    COP [27] ( &gw_raft_east_entry_01E8ED )
}

code_01E8C1 {
    COP [27] ( &gw_raft_west_entry_01E851 )
}

code_01E8C5 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [91]
    COP [2F] ( #$FFFE, #$0000 )
    COP [07] ( #$8000, &code_01E8DA )
    RTL 
}

code_01E8DA {
    COP [2F] ( #$FFFE, #$0000 )
    COP [09] ( #$0000 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}
---------------------------------------------

; Entry of the east raft: wait until the raft is on screen.
; 
; When: meta type $3C and the hand-over from the west raft.
; In: actor script, X = own slot.
; Out: falls through into gw_raft_east_01E8F0.
; Clobbers: A.

gw_raft_east_entry_01E8ED {
    COP [AD] ( #08 )
}
---------------------------------------------

; A raft that carries the hero east; the mirror image of gw_raft_west_01E854.
; 
; When: after the entry (meta type $3C) or as the way back of the west raft.
; Sees: the picture is flipped (COP 87); the hero is moved two pixels per frame to the east (carrier child code_01E965); animation $1B; the ride ends with a COP 22 test, then the flip is reverted and, if the COP 24 test holds, the raft restarts as east, otherwise it hands over to gw_raft_west_entry_01E851.
; In: actor script, X = own slot.
; Out: as gw_raft_north_01E75C.
; Clobbers: A.

gw_raft_east_01E8F0 {
    COP [A4]
    COP [87]
    COP [2A] ( #$0000, #$0010 )
    COP [2B] ( #$0000, #$0000 )
    COP [2B] ( #$0000, #$FFF0 )
    COP [2B] ( #$0010, #$0000 )
    COP [2B] ( #$0010, #$FFF0 )
    COP [91]
    COP [0C] ( #00, #00, &code_01E91D )
    BRL loc_01E91E
}

code_01E91D {
    RTL 

  loc_01E91E:
    COP [91]
    COP [0C] ( #00, #00, &code_01E927 )
    RTL 
}

code_01E927 {
    COP [85] ( @code_01E965 )
    COP [2B] ( #$0000, #$0010 )
    COP [2A] ( #$0000, #$0000 )
    COP [2A] ( #$0000, #$FFF0 )
    COP [2A] ( #$0010, #$0000 )
    COP [2A] ( #$0010, #$FFF0 )

  code_01E94A:
    COP [80] ( #1B )
    COP [82]
    COP [22] ( &code_01E94A )
    COP [09] ( #$8000 )
    COP [87]
    COP [24] ( &code_01E961 )
    COP [27] ( &gw_raft_west_entry_01E851 )
}

code_01E961 {
    COP [27] ( &gw_raft_east_entry_01E8ED )
}

code_01E965 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [91]
    COP [2F] ( #$0002, #$0000 )
    COP [07] ( #$8000, &code_01E97A )
    RTL 
}

code_01E97A {
    COP [2F] ( #$0002, #$0000 )
    COP [09] ( #$0000 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}
---------------------------------------------

; The red and dark phases of the Fire Shrine bridges and the damage while they are red.
; 
; When: meta type $06, placed in A05S07 (no switch; the meta entry names the palette lists PaletteAnimLists).
; Sees: the bridges periodically redden and darken (the walkthrough: 'You will end up crossing some bridges in this area that periodically redden and darken. If you walk on them when they are in the former status, you will be damaged. Repeatedly. ... the Ice Armor, which will stop this').
; Why: the root starts animation $3B (COP 92 / COP 94), spawns the damage child code_01E9A6 for $F0 frames and, after a delay of $F0 frames, starts animation $3D and begins again. The child counts $F0 frames; every frame, unless the Ice Armor (item $0A) is equipped (COP 19), it tests whether the player stands on the metatile $80 (IsPlayerOnMetatile) and, if so, deals 1 damage (COP 39).
; In: actor script, X = own slot.
; Out: loops for ever; the child kills itself (COP 86).
; Clobbers: A.

gw_effect_fire_bridge_heat_01E98D {
    COP [92] ( #3B )
    COP [94]
    COP [B0] ( @code_01E9A6, #$2040 )
    COP [1B] ( &code_01E99F, #$00F0 )
}

code_01E99F {
    COP [92] ( #3D )
    COP [94]
    BRA gw_effect_fire_bridge_heat_01E98D
}

code_01E9A6 {
    COP [03] ( #F0 )
    COP [19] ( #0A, &code_01E9B0 ) ; jumps unless the Ice Armor (item $0A) is equipped
    BRA loc_01E9BC
}

code_01E9B0 {
    LDA #$0080
    JSL $@lib_map_index_helpers.IsPlayerOnMetatile ; metatile $80 is the red bridge
    BCC loc_01E9BC
    COP [39] ( #01 )      ; 1 damage per hit on the red bridge; IsPlayerOnMetatile is false while the player is stunned

  loc_01E9BC:
    COP [04]
    COP [86]
    RTL 
}
---------------------------------------------

; Drifts the second background layer upwards by one pixel per frame.
; 
; When: meta type $2B, every frame (no entry point, the script restarts each frame); placed in A05S05, A05S06 and A05S07.
; Sees: a slowly moving background layer.
; Why: as gv_obj_bg2_scroll_drift_01B1F7, with another direction.
; In: actor script, X = own slot, M = 16 bits. Reads scroll_delta_y.
; Out: $02,X += -1 + scroll_delta_y, copied to scroll_bg2_y; RTL.
; Clobbers: A.

gw_effect_bg2_scroll_01E9C1 {
    LDA $0002, X
    SEC 
    SBC #$0001
    CLC 
    ADC $scroll_delta_y
    STA $0002, X
    STA $scroll_bg2_y
    RTL 
}
---------------------------------------------

; The ripple of the water: one pixel of wobble over the lines of the screen.
; 
; When: meta type $0C, placed in A05S01, A05S02 and A05S03 (no switch). The first part runs once (up to the COP 91), the second every frame.
; Sees: the picture ripples with a period of 16 lines and an amplitude of one pixel.
; Why: HDMA tables are rebuilt each frame so the ripple moves: the first half sets up two indirect HDMA tables at $7E7000 and $7E7800, 14 entries each (count $90: 16 lines in repeat mode) that point at $7E7100 and $7E7900 and end with $00; the second half fills 16 values at each block from gw_ripple_offsets_01EB82, starting at the index (frame_counter / 2 + scroll_bg1_y) AND $0F, adding $033A (the x scroll of BG1) to the first and scroll_bg1_y ($033C) to the second, and queues both with QueueHdmaIndirect for the PPU registers $210F and $2110. The loop runs with M = 8, so only the low byte of each table word is written (OQ-I035-17).
; In: actor script, X = own slot.
; Out: two HDMA channels queued.
; Clobbers: A, Y, B; X is saved (PHX / PLX) and DBR restored (PHB / PLB).

gw_effect_water_ripple_hdma_01EAFB {
    PHX 
    LDX #$0000

  loc_01EAFF:
    LDA #$0090
    STA $7E7000, X
    STA $7E7800, X
    LDA #$7100
    STA $7E7001, X
    LDA #$7900
    STA $7E7801, X
    INX 
    INX 
    INX 
    CPX #$002A
    BNE loc_01EAFF
    LDA #$0000
    STA $7E7000, X
    STA $7E7800, X
    PLX 
    COP [91]
    PHX 
    LDA $frame_counter
    LSR 
    CLC 
    ADC $scroll_bg1_y
    AND #$000F
    ASL 
    TAX 
    LDY #$0000
    SEP #$20
    PHB 
    LDA #$7E
    PHA 
    PLB 

  loc_01EB46:
    LDA $@gw_ripple_offsets_01EB82, X
    CLC 
    ADC $033A
    STA $7100, Y
    LDA $@gw_ripple_offsets_01EB82, X
    CLC 
    ADC $033C
    STA $7900, Y
    INX 
    INX 
    INY 
    INY 
    CPY #$0020
    BNE loc_01EB46
    PLB 
    LDA #$0F
    XBA 
    LDA #$7E
    LDY #$7000
    JSL $@lib_system_helpers.QueueHdmaIndirect ; A.high = $0F: the PPU register $210F, bank $7E, table $7000
    LDA #$10
    XBA 
    LDA #$7E
    LDY #$7800
    JSL $@lib_system_helpers.QueueHdmaIndirect ; A.high = $10: the PPU register $2110, bank $7E, table $7800
    REP #$20
    PLX 
    RTL 
}
---------------------------------------------

; The ripple table of gw_effect_water_ripple_hdma_01EAFB: 32 words, two periods of 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, -1, -1, -1, -1.
; 
; When: read by gw_effect_water_ripple_hdma_01EAFB every frame (16 words from a start index that moves with frame_counter / 2).
; In: data, 32 words (index $00-$1F).
; Out: n/a.

gw_ripple_offsets_01EB82 [
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