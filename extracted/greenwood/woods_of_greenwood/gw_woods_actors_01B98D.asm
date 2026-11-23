; Fifteen of the animals that live in the Woods of GreenWood (area 4, scene A04S01 'woods', location $15) and the objects that speak next to them (file offsets 113037-118853, SNES $03:B98D-$D044, bank 03). The dialogue strings of each root follow its code; the other half of the Woods is in gw_woods_actors_01D045.
; 
; === HOW ONE ANIMAL WORKS ===
; The meta types $0D-$1B of MetaGreenwood (WorldMetaPointers) name the roots below; PlacementA04S01 puts them into the scene (flags byte $41 / $01: bit 6 flips X). A root is COP 14 ( switch, &appear ) followed by RTL: the switch is the lair record that frees the animal (data_lair_records: +9 is the name index into NpcNameStrings, +B the lair location, +15 the meta type of the monsters). While the switch bit in $1ADE is clear the actor stays hidden ($16 bit $2000) and only waits. After the lair is cleared COP 14 jumps to the appear handler, which spawns engine_spawn_lairs_death_drops.RunAppearPuff, registers the talk handler with COP 17 and blocks its tiles with COP 15. Many animals also spawn a second actor with COP AC ( entry, x, y, $2040 ) at a fixed pixel position: a tree, a stump or a grave stone that speaks a hint (animation $23, text printed with the code [0A]); its code sits behind the animal's text (code_01BEE5, code_01C261, code_01C372, code_01C495, code_01C826, code_01C8F5, code_01CA63). The deer of the Master's Emblems spawns a fairy gem instead (code_01C08A / code_01C0B0). Most strings end with [JMP gw_watching_over_world_return_prompt_texts.asciistring_01EC46], the dialogue box erase.
; 
; === ROSTER (type, switch, creature = name index of the lair record, lair) ===
; $0D gw_npc_dog_restaurant_01B98D: switch $56, 'a dog' (Fire Shrine, Ghost Heads), the restaurant joke.
; $0E gw_npc_deer_woodstin_trio_01BB3F: switch $4A, 'a deer' (Water Shrine, Stone Statues), one of the three Woodstin-Trio members.
; $0F gw_npc_dog_graveyard_guard_01BCEC: switch $5A, 'a dog' (Fire Shrine, Ghost Heads), guards the graveyard.
; $10 gw_npc_bird_shy_red_hot_mirror_01BDE5: switch $37, 'a bird' (Light Shrine, Spirit Balls), the Red-Hot Mirror.
; $11 gw_npc_deer_master_emblems_01BF32: switch $63, 'a deer' (Fire Shrine, Lizard Men), the head-butt, the fairy gem and the Magic Bell.
; $12 gw_npc_squirrel_stump_circler_01C2F9: switch $58, 'a squirrel' (Fire Shrine, Lizard Men), circles the sleeping stump (Dream Rod).
; $13 gw_npc_bird_trees_and_seeds_01C3CA: switch $46, 'a bird' (Water Shrine, Walking Plants).
; $14 gw_npc_dog_walk_01C57B: switch $3C, 'a dog' (Lostside exterior, Mud Men), takes the hero for a walk.
; $15 gw_npc_bird_stump_hint_01C8A4: switch $38, 'a bird' (Lostside exterior, Mud Men), sends the hero to the stump.
; $16 gw_npc_bird_turbo_grave_01C98A: switch $61, 'a bird' (Fire Shrine, Lizard Men), sleeps at Turbo's grave (Dream Rod).
; $17 gw_npc_crocodile_walk_over_01CC61: switch $4E, 'a crocodile' (Water Shrine, Walking Plants), lets the hero walk over him.
; $18 gw_npc_crocodile_bridge_01CD3D: switch $5B, 'a crocodile' (Fire Shrine, Lizard Men), a silent stepping stone.
; $19 gw_npc_crocodile_bridge_01CD55: switch $6F, 'a crocodile' (Light Shrine, Lizard Men), a silent stepping stone.
; $1A gw_npc_dog_smell_01CD6D: switch $3D, 'a dog' (Lostside exterior, Mud Men), the nose that finds the outhouse.
; $1B gw_npc_squirrel_restaurant_01CF41: switch $59, 'a squirrel' (Fire Shrine, Ghost Heads), the hungry squirrel.
; The animals of the second half (gw_woods_actors_01D045) are the Woodstin-Trio squirrel Billy, the trio dog, the Guardian of the Woods, the moles, the squirrels of the exchange store and the dream birds.
; 
; === EVENT FLAGS USED ===
; $0305 the crocodile asked: the hero said Yes, the crocodile's tiles are open for walking. $0306 the deer's head-butt is done (the fairy gem appears at once on the next visit). $0002 the head-butt repeats once (second pass marker). $0402 set by Turbo's ghost in the Bird's Dream (gw_woods_actors_01D045): the guard dog's text and the bird's exit. $1F02 set by RunEnding: the post-ending epilogue at Turbo's grave. $0003-$0007 are the hand-over between the three Woodstin-Trio actors (this file's deer and gw_woods_actors_01D045's squirrel and dog): the deer waits with COP 05 on $0003 and sets $0004; see gw_npc_squirrel_billy_01D045. $0001 the outhouse tile was reached (the smelling dog). Inventory entries tested: $18 Phoenix, $32 Red-Hot Mirror, $1C Dream Rod, $40 Magic Bell, $2A-$31 Master's Emblems A-H.
; 
; === NOTES ===
; - The walkthrough calls the lead of the trio Billy and the deer and the dog his band; the ROM text calls the group 'Woodstin-Trio' (the walkthrough spells it the same way). 'Tiki' appears only in the text of Turbo's ghost (gw_woods_actors_01D045), the walkthrough does not name that bird (OQ-I035-9).
; - Which of the three birds that speak of Turbo is 'Tiki' is not decided by the ROM: the ghost says Tiki 'may tell you how to use the raft', which fits the grave bird gw_npc_bird_turbo_grave_01C98A ('the rafts will only carry the residents of GreenWood').
---------------------------------------------

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

; The dog of the GreenWood restaurant: paces in front of it and offers the menu.
; 
; When: meta type $0D, switch $56 (name $17 'a dog'; lair record $56 in the first Fire Shrine scene, Ghost Heads). Placed at tile ($05,$0E) of A04S01, in the far west of the Woods.
; Sees: a dog that paces east and west with 120 frames at every stop (animations $0E-$11). Talked to: 'This is a restaurant. Would you like to see the menu?' with a Yes / No menu (No: 'Come on! At least take a look.' and the question again); Yes: 'Great! Let me tell you our special of the day ...', a pause, 'You!', a longer pause, 'I'm just kidding! Please don't be offended.' and 'This restaurant is famous for delicious food and fruit drinks!' (walkthrough: 'the special happens to be a delicious... SOUL BLAZER! The canine admits it was a joke').
; Why: the joke is timed with text_delay (saved, set to 5 for the pauses, restored) and a write of 0 and later 1 to APUIO0 around the punch line (OQ-I035-3).
; In: actor script, X = own slot (the talk handler code_01BA28 runs inside the hero's text box).
; Out: loops for ever.
; Clobbers: A.

gw_npc_dog_restaurant_01B98D {
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
    STA $APUIO0           ; APUIO0 = 0 for the pause of the joke (restored to 1 after the punch line; effect on the music not traced, OQ-I035-3)
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

; The deer, one of the three animals of the Woodstin-Trio, who waits for his two band mates.
; 
; When: meta type $0E, switch $4A (name $0F 'a deer'; lair record $4A in the second Water Shrine scene, Stone Statues). Placed at tile ($1D,$10) of A04S01, on the theater stage.
; Sees: first 'Hello, I am a member of the famous Woodstin-Trio. We usually have a variety show at this theater, but I am missing my two sidekicks.' When both other members are free (switches $5D and $3F, tested with COP 14) he waits for flag $0003 (Billy: 'let's start the show'), dances (animations $12-$14, a puff and the sound BRK $4E), sets flag $0004 and plays animation $00, the look Billy's type $1C has (walkthrough: 'he'll first transform his buddies into squirrels like him'). The second round is the guessing game: after flag $0007 he puffs back (animation $12) and answers 'I hope you liked our show' when Billy was chosen (flag $0000) or 'Too bad, almost' otherwise. While the show runs the talk text is 'Hey, don't walk around, you're annoying me.'
; Why: the three actors are synchronised only through event flags $0003-$0007 (COP 05 waits, COP 09 sets); the guessing game is the walkthrough's 'you'll be tasked with finding the real lead member (Billy) ... you gain Medical Herbs for winning' (OQ-I035-5: the flag protocol was read, not run).
; In: actor script, X = own slot.
; Out: ends in the return talk handler code_01BC33.
; Clobbers: A.

gw_npc_deer_woodstin_trio_01BB3F {
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

; The dog that guards the graveyard island.
; 
; When: meta type $0F, switch $5A (name $17 'a dog'; lair record $5A in the second Fire Shrine scene, Ghost Heads). Placed at tile ($1B,$2D) of A04S01.
; Sees: a dog that plays animation $11 (3 repeats) and turns round (COP 87) every 40 frames, and says 'I am guarding the graveyard. I hear someone snoring but can't tell from which direction the sound is coming.' (two worded variants, chosen by flag $0402 and by switch $61, the sleeping bird). The walking dog says that this guard is his twin brother ('My twin brother is the island guard', gw_npc_dog_walk_01C57B).
; Why: the hint to the sleeping bird, who is entered with the Dream Rod (gw_npc_bird_turbo_grave_01C98A).
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

gw_npc_dog_graveyard_guard_01BCEC {
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

; The shy bird who gives the Red-Hot Mirror when approached from behind.
; 
; When: meta type $10, switch $37 (name $16 'a bird'; lair record $37 in the second Light Shrine scene, a Spirit Ball formation, so the bird is freed late). Placed at tile ($04,$11) of A04S01.
; Sees: a bird (animation $18) that ignores the hero until he is within 4 tiles (COP 0C); COP 9B (threshold $10) then sends it back to idle while the hero is at least $10 above (north of) it, otherwise into the startle sequence; the startle clears the talk handler and the tiles, plays animations $1E-$20 with a flip and then registers the talk handler: 'AHHHH! You scared me! Please don't sneak up behind me. Well, I guess it's okay. I have something special for you.' and 'received the Red-Hot Mirror' (item $32). The tree next to him says 'For shy birds, you better approach quietly from behind.'
; Why: the talk handler exists only after the startle sequence, so the hero has to walk up to the bird first (walkthrough chapter 7: 'Walk towards it ... and speak with it when you're next to it. Do not run into it'; chapter 8 names the bird's lair, the Light Shrine Spirit Balls). The gift is made only while the Phoenix (item $18) and the Mirror (item $32) are both missing, otherwise the bird only says 'AHHHH! You scared me!'. The Mirror is one of the three Red-Hot items of the Phoenix. The walkthrough says the bird flies off east of the theater when the hero first nears it; the script has no movement, so that is presumably the animation data (OQ-I035-4).
; In: actor script, X = own slot; spawns the tree actor code_01BEE5 at pixel ($30,$110).
; Out: loops for ever.
; Clobbers: A.

gw_npc_bird_shy_red_hot_mirror_01BDE5 {
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
    COP [18] ( #18, &code_01BE42 ) ; item $18 is the Phoenix magic: once it is owned the Red-Hot Mirror (item $32) is not given again
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

; The deer on the western island: asks for help across the river, head-butts a tree and releases the fairy gem of the Master's Emblems.
; 
; When: meta type $11, switch $63 (name $0F 'a deer'; lair record $63 in the third Fire Shrine scene, Lizard Men). Placed at tile ($06,$1D) of A04S01.
; Sees: while crocodile $6F is not free: 'If you help me cross the river I will give you something.' After it: 'Follow me.', the deer steps aside (animations $16 / $17) and says 'Stand back and watch!'; the screen shakes twice (BRK $4A, the tree actor code_01C261 spawned at pixel ($30,$200) says 'There once was a raft made from the bark of my branches. You must find this raft.'), and after 90 frames a fairy gem appears (code_01C08A at pixel ($A0,$10)). Later visits: 'What did you think? I hope this helped.' and the fairy gem is spawned at once (code_01C0B0). The fairy gem: with all eight Master's Emblems (items $2A-$31, tested with COP 18) it takes them and gives the Magic Bell ($40) ('you collected all 8 emblems. I will now give you the Magic Bell'); without all: 'The Master's Emblems are all over the world ... Collect all 8 emblems, you will not require GEMs when casting magic.'; with the Bell: 'The Magic Bell enables you to use magic without GEMs.' (walkthrough: 'speak with the fairy within to learn of the Master's Emblems'; the Magic Bell is in the sidequests).
; Why: flag $0306 remembers that the head-butt happened, flag $0002 repeats the shake once.
; In: actor script, X = own slot (it uses the loop counter in $2E as the shake amount: COP 03 / COP 04).
; Out: ends in the follow loop code_01BF67.
; Clobbers: A, joy_block_mask (blocked during the shake, restored).

gw_npc_deer_master_emblems_01BF32 {
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
    LDA $002E, X          ; $2E is the loop counter of COP 03 (8 down to 1), added to the BG1 scroll: the screen shakes with the head-butt
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
    COP [AC] ( @code_01C08A, #$00A0, #$0010, #$0050 ) ; spawns the fairy gem (code_01C08A) at pixel ($A0,$10); it waits 90 frames first (COP 1B)
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
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    STZ $0014, X
    COP [03] ( #28 )
    LDA $0002, X
    CLC 
    ADC #$0004
    STA $0002, X
    COP [04]
    COP [17] ( &code_01C0C4 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C-1
    PHA 
    RTL 
}

code_01C0B0 {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_01C0C4 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank3.cm_npc_fairy_gem_idle_01B17C-1
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
    COP [0B] ( #2A )      ; all eight Master's Emblems (items $2A-$31) are taken away ...
    COP [0B] ( #2B )
    COP [0B] ( #2C )
    COP [0B] ( #2D )
    COP [0B] ( #2E )
    COP [0B] ( #2F )
    COP [0B] ( #30 )
    COP [0B] ( #31 )
    BRK #$5E
    COP [0A] ( #40 )      ; ... for the Magic Bell (item $40)
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

; The squirrel who circles a sleeping tree stump and cannot find who is snoring.
; 
; When: meta type $12, switch $58 (name $0E 'a squirrel'; lair record $58 in the second Fire Shrine scene, Lizard Men). Placed at tile ($06,$2A) of A04S01.
; Sees: a squirrel that runs round (animations $05, $03, $04 mirrored) and says 'I hear someone snoring. I cannot tell who is making the noise.' The stump (code_01C372, spawned at pixel ($70,$2D0)) answers 'Zzzzz'; with the Dream Rod (item $1C equipped) the text 'placed the Dream Rod upon the stump' appears and the scene changes to A04S06, the Stump's Dream.
; Why: the walkthrough: 'The squirrel is funnily circling the tree to find the snoring - the tree stump he is circling is actually asleep. Equip the Dream Rod and speak with the stump.'
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A, asset_cache_tilemap1 (the stump zeroes it before the scene change).

gw_npc_squirrel_stump_circler_01C2F9 {
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
    COP [10] ( #$0604, #02, #$0120, #$0040 ) ; area 4 scene 6: the Stump's Dream; COP 3C 4 set the transition type
    RTL 
}

code_01C397 {
    COP [01] ( &asciistring_01C39C )
    RTL 
}

asciistring_01C39C |[10][0A]Zzzzz [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|

asciistring_01C3A7 |[10][02:2] placed the [N]Dream Rod upon the [N]stump- [JMP:&gw_watching_over_world_return_prompt_texts.asciistring_01EC46]|
---------------------------------------------

; A bird who explains how the animals and the trees help each other, next to a tree that tells of the three shrines.
; 
; When: meta type $13, switch $46 (name $16 'a bird'; lair record $46 in the second Water Shrine scene, Walking Plants). Placed at tile ($22,$2A) of A04S01.
; Sees: a bird that turns round every 40 and 60 frames and dances (animations $1D-$20): 'We tell the trees what is taking place and in turn they give us seeds to eat. So I guess you could say we have sort of a give-and-take relationship.' The tree (code_01C495, pixel ($220,$2E0)): 'The birds tell me many stories ... the Lostside Marsh has three shrines. One is called Water, another is Fire and the third is Light.'
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

gw_npc_bird_trees_and_seeds_01C3CA {
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

; The dog who asks to be taken for a walk and follows the hero.
; 
; When: meta type $14, switch $3C (name $17 'a dog'; lair record $3C in the Lostside exterior, Mud Men). Placed at tile ($2C,$21) of A04S01.
; Sees: 'Please, come take a walk with me.' with a Yes / No menu (No: 'Why not!?'); Yes: 'All right, let's go!' and the dog takes a few steps (animations $11, $0F, $10). Every further talk gives the next piece: 'The island over there is a graveyard. My twin brother is the island guard.', then the Green Theater ('This is Green Theater. A group called the Woodstin-Trio is a local favorite here', or 'This place used to be the Green Theater' while switch $4A is not free), then the thanks and the tail wag ('If I step like this and wag my tail, it means thank you. Did you already know that?'). The tree (code_01C826, pixel ($2B0,$200)) says 'If you find a particular mole, you will be able to see in the dark. Make sure you talk to all the moles.' (the Soul of Light).
; Why: the 'walk' is a chain of talk handlers that replace each other with COP 17 and COP 27; the hero is frozen during the thanks with joy_block_mask ($2F80).
; In: actor script, X = own slot.
; Out: ends with the talk handler code_01C62C ('I have as much fun walking people as they do walking me').
; Clobbers: A, joy_block_mask (set and restored).

gw_npc_dog_walk_01C57B {
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

; A bird who sends the hero to the stump next to him.
; 
; When: meta type $15, switch $38 (name $16 'a bird'; lair record $38 in the Lostside exterior, Mud Men). Placed at tile ($2B,$16) of A04S01.
; Sees: 'Talk with the stump. Please listen carefully.' The stump (code_01C8F5, pixel ($2A0,$160)) says 'This is GreenWood. This land was developed by a dog named Turbo. He created this town so animals could come here and feel safe.' (walkthrough: 'you can speak with the bird, then tree stump nearby ... a dog named Turbo').
; In: actor script, X = own slot.
; Out: waits in animation $18 for ever.
; Clobbers: A.

gw_npc_bird_stump_hint_01C8A4 {
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

; The bird who sleeps at Turbo's grave: the Dream Rod enters his dream; after the ending it plays the epilogue with Turbo's ghost.
; 
; When: meta type $16, switch $61 (name $16 'a bird'; lair record $61 in the third Fire Shrine scene, Lizard Men). Placed at tile ($11,$2D) of A04S01.
; Sees: a sleeping bird (animation $1A). Talked to with the Dream Rod (item $1C): 'placed the Dream Rod upon the small bird' and the scene changes to A04S05, the Bird's Dream (COP 3C 4). Without the rod: 'Zzzzz'. When the dream was done the bird says 'The rafts will only carry the residents of GreenWood. Maybe if you bring something that used to belong to Turbo, they might help you. There are some leaves from GreenWood buried with Turbo.' The gravestone (code_01CA63, tile test ($12,$2C)) says 'Here lies Turbo, builder of GreenWood.' When the hero returns from the dream a one-shot text actor (COP 30) says 'There is a bird sleeping in front of Turbo's grave stone.'
; Epilogue: with event flag $1F02 (RunEnding) the hero is frozen and a scene of Turbo's ghost follows: 'Turbo's grave is standing alone. When <name> closed his eyes, he tried to imagine Turbo.' and 'Like good sleep comes after hard work, good rest comes after an honest life. I will rest well with Dr. Leo.'; the scene then changes to area 1 scene 1 (Grass Valley village) at ($3B0,$1D8).
; Why: the walkthrough: 'go to the bird asleep near the flowered grave of Turbo. Touch him with the Dream Rod to enter his dream.'
; In: actor script, X = own slot.
; Out: waits in animation $1A.
; Clobbers: A, joy_block_mask (the epilogue sets $BFC0 and restores it), asset_skip_mask.

gw_npc_bird_turbo_grave_01C98A {
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
    COP [10] ( #$0101, #03, #$03B0, #$01D8 ) ; area 1 scene 1: the Grass Valley village, the end of the epilogue (RunEnding set flag $1F02)
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_01CA43 {
    COP [19] ( #1C, &code_01CA59 )
    COP [01] ( &asciistring_01CAB9 )
    COP [3C] ( #04 )
    COP [10] ( #$0504, #03, #$0160, #$01C0 ) ; area 4 scene 5: the Bird's Dream
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
    COP [0D] ( #00, #12, #2C, &code_01CA6D ) ; slot 0 is the hero: tile ($12,$2C) is the spot in front of the grave stone
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

; The crocodile who lets the hero walk over him: the stepping stone to the graveyard.
; 
; When: meta type $17, switch $4E (name $10 'a crocodile'; lair record $4E in the third Water Shrine scene, Walking Plants). Placed at tile ($19,$21) of A04S01.
; Sees: a crocodile (animation $21) drawn behind (COP A4). Talked to: 'Who are you? Are you trying to walk over me!?' with a Yes / No menu; Yes: 'You have some nerve! Okay, but don't hurt me.', flag $0305 is set and COP 16 frees the tiles under him, so the hero can cross; No: 'You wimp!'. When he is hurt afterwards (the hero in his box, COP 0C): 'Hey, you're hurting me!' (walkthrough: 'if you speak with the crocodile and say Yes, you'll be permitted to walk over him').
; In: actor script, X = own slot (the loop counter $2E counts ten frames between the hurt texts).
; Out: loops.
; Clobbers: A.

gw_npc_crocodile_walk_over_01CC61 {
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
    COP [09] ( #$8305 )   ; flag $0305: the hero said Yes, the crocodile can be walked over
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

; A silent crocodile that serves as stepping stone.
; 
; When: meta type $18, switch $5B (name $10 'a crocodile'; lair record $5B in the second Fire Shrine scene, Lizard Men).
; Sees: a crocodile (animation $21) drawn behind; COP 16 frees the tiles under him; no talk handler.
; Why: the same shape as gw_npc_crocodile_walk_over_01CC61 without the question; the walkthrough: 'cross the backs of the crocodiles to reach the GreenWood graveyard'.
; In: actor script, X = own slot.
; Out: returns after the appear (RTL).
; Clobbers: A.

gw_npc_crocodile_bridge_01CD3D {
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

; A silent crocodile that serves as stepping stone.
; 
; When: meta type $19, switch $6F (name $10 'a crocodile'; lair record $6F in the second Light Shrine scene, Lizard Men). Its switch is also the condition of the deer gw_npc_deer_master_emblems_01BF32 ('help me cross the river').
; Sees: as gw_npc_crocodile_bridge_01CD3D.
; In: actor script, X = own slot.
; Out: returns after the appear (RTL).
; Clobbers: A.

gw_npc_crocodile_bridge_01CD55 {
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

; The dog who knows everything by its smell and leads the hero to the outhouse.
; 
; When: meta type $1A, switch $3D (name $17 'a dog'; lair record $3D in the Lostside exterior, Mud Men). Placed at tile ($0A,$15) of A04S01.
; Sees: 'I can tell what something is just by its smell. Allright, let me start doing my job.', then the dog takes a few steps (animations $0D-$11) and names the smells ('From (direction glyph), I smell fresh air. From (direction glyph), I smell a mole. What is that smell!! I smell something strange coming from (direction glyph).'). When the hero stands on tile ($1D,$09) (the outhouse tile) the dog says 'There is an outhouse.' and sets flag $0001; afterwards 'Oh, this is our bathroom. Thank you for walking with me. I will tell you a secret. I can smell some armor north of here.' (walkthrough: 'The dog will hint that there is some armor to the north'); before the flag: 'It's around here somewhere. I smell something really strange!'
; Why: each talk replaces the talk handler (COP 17, COP 27), as with gw_npc_dog_walk_01C57B.
; In: actor script, X = own slot.
; Out: ends in the follow loop code_01CDAA.
; Clobbers: A.

gw_npc_dog_smell_01CD6D {
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
    COP [0D] ( #00, #1D, #09, &code_01CDD6 ) ; the hero (slot 0) stands on tile ($1D,$09): the outhouse tile of the walkthrough
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

; The hungry squirrel: complains while the restaurant is closed and walks around once the dog has opened it.
; 
; When: meta type $1B, switch $59 (name $0E 'a squirrel'; lair record $59 in the second Fire Shrine scene, Ghost Heads). Placed at tile ($11,$12) of A04S01.
; Sees: before switch $56 (the restaurant dog) is free: 'I'm starving! This place used to be a restaurant.' After it: 'I need to take a walk and work some of this food off.'; the next talk answers 'Why am I following you? Well it's purely coincidence.' and the squirrel turns towards the hero (COP 9C / 9A / 9B with threshold $10 choose animation $05, $04 or $03 and the flip).
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

gw_npc_squirrel_restaurant_01CF41 {
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