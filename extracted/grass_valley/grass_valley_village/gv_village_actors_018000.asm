; Twelve freed creatures of the Grass Valley village (area 1, the village scene A01S01 'highlands'): the crab-walk old man, the old woman, the tool shop owner, a tulip by the water mill, the bridge guard, the water mill keeper, a goat, Lisa, a tulip that explains the Dream Rod, the architect Gaudi, the tool shop owner's son and a tulip that talks about dreams. File offsets 98304-103540, SNES $03:8000-$9474, bank 03. The dialogue strings of each NPC follow its code; the second half of the village is in gv_village_actors_019475.
; 
; === HOW ONE NPC WORKS ===
; The meta types $0B-$18 of MetaGrassValley (WorldMetaPointers) name the twelve roots below, and PlacementA01S01 puts them into the village scene (it also holds the types $19-$1E and $33-$35 of gv_village_actors_019475). The slot of an actor is its row number in the placement list; scripts use it as the slot byte of COP 0C / 0D / 11 / 12 (slot 0 is the hero, slot 4 the old woman, slot 5 the tool shop owner, slot 8 the water mill keeper).
; A root is COP 14 ( switch, &appear ) followed by RTL. The switch is the lair record that frees the NPC (data_lair_records: +9 is the name index into NpcNameStrings, +2 / +3 the home tile, +B the lair location; the walkthrough chapter 2 lists the lairs). While the switch bit in $1ADE is clear the actor stays hidden ($16 bit $2000 from the placement) and only waits; once the lair is released COP 14 clears the bit and jumps to the appear handler. That handler spawns the appear puff (engine_spawn_lairs_death_drops.RunAppearPuff), registers the talk handler with COP 17 (the word goes to $30; the engine runs it when the hero talks to the actor) and blocks the actor's tiles with COP 15. A talk handler picks its string with event flags (COP 07 / COP 09) or the inventory (COP 18 / COP 19 test an item entry) and ends with RTL. COP 30 ( record, &child, #03 ) spawns a one-shot text actor when the hero enters the scene on the return trip after freeing that NPC. Most strings end with [JMP shared_actor_helpers_bank3.asciistring_01B988], the dialogue box erase.
; 
; === ROSTER ===
; Type $0B gv_npc_old_man_crab_walk_018000: switch $29, name 0 'an old man', crab-walk lesson.
; Type $0C gv_npc_old_woman_0180F7: switch $02, name 1 'an old woman', adopts the hero and heals him.
; Type $0D gv_npc_tool_shop_owner_018353: switch $06, name 8 'tool shop owner', gives a Medical Herb.
; Type $0E gv_npc_tulip_water_mill_01848A: switch $07, name $0B 'tulip', tells of the water mill.
; Type $0F gv_npc_bridge_guard_0185B9: switch $08, name 5 'The bridge guard'.
; Type $10 gv_npc_water_mill_keeper_0186A2: switch $0E, name $0D 'The water mill keeper', the wheel and Master's Emblem A.
; Type $11 gv_npc_goat_pen_01891A: switch $0F, name 9 'a goat', the hidden Medical Herb of the pen.
; Type $12 gv_npc_lisa_018A59: switch $10, name 3 'Lisa', the Dream Rod, her story, the ending.
; Type $13 gv_npc_tulip_dream_rod_018FF4: switch $11, name $0B 'tulip', explains the Dream Rod.
; Type $14 gv_npc_architect_gaudi_01910C: switch $12, name 6 'an architect'.
; Type $15 gv_npc_tool_shop_son_0191D2: switch $16 (COP 3B), name 7 'tool shop owner s son', goat food.
; Type $16 gv_npc_tulip_dream_boundary_019365: switch $18, name $0B 'tulip'. (Type $17 starts gv_village_actors_019475.)
; 
; === EVENT FLAGS USED (flag word: byte x 256 + bit) ===
; $0000 set after the crab-walk lesson was spoken (the old man then starts watching the pad). $0101 the old woman's offer was accepted. $0202 the bridge guard spoke once. $0004 the bridge guard is standing aside. $0404 the wheel of the water mill was turned (the Underground Castle elevator waits for it, gv_underground_castle_actors; gv_village_actors_019475 waits on it too). $1A00 Master's Emblem A taken. $0103 the Medical Herb of the goat pen taken. $0107 / $0003 the architect has introduced himself. $0104, $0105, $0207, $0301, $0302 the steps of Lisa's story (see her part note). $1F02 set by RunEnding when Deathtoll is defeated; $1F01 set by Lisa's dream (gv_underground_castle_actors). Inventory entries tested: $38 Medical Herb, $29 the VIP Card (Castle of King Magridd, walkthrough chapter 7: from then on Lisa is gone and the old woman speaks of the kidnapping), $1C Dream Rod, $1D Leo's Brush, $19 Goat's Food.
; 
; === NOTES ===
; - asciistring_018480 (file offset 98432) is not text: its bytes are COP 96, COP 80 ( #08 ), COP 82 (flip, animation 8, wait). The architect's neighbour, the tool shop son, writes its address into the resume pointer of slot 5 (COP 12 ( #05, &asciistring_018480 )) so the tool shop owner plays that animation, and restores her root afterwards (OQ-I034-1).
; - The word 'Teddy' in the son's text ('TEDDY!! I m sorry, I will give it to you for free') is kept as printed; the walkthrough does not name the boy.
---------------------------------------------

?BANK 03

?INCLUDE 'engine_player_death_and_actor_helpers'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!joy_pressed                    0322
!joy_block_mask                 0326
!player_actor                   039C

---------------------------------------------

; The old man of the village who teaches the crab walk (hold L or R while walking).
; 
; When: meta type $0B in the village scene; hidden until switch $29 (lair record $29: the lair in location 05, the Underground Castle, frees NPC name 0 'an old man' to his home tile ($04,$33) in the village).
; Sees: after the release he appears in a puff, faces the hero and talks: first 'Hey, you look like you would be good at crab walking. Try it! You don't know how? Just walk while pressing either the L or R button.'; once the hero has pressed L or R together with a d-pad direction he answers 'See, I knew you could do it! This will help you when you are fighting or using magic.' (walkthrough chapter 2: 'a man who will tell you how to crab-walk').
; Why: the second text rewards the first try, so the actor watches the pad itself after the first talk (flag $0000 set by the first text).
; In: actor script, X = own slot (M = X = 16 bits). COP 14 switch $29.
; Out: switch clear: RTL, the actor stays hidden. Switch set: code_018007 (appear puff, talk handler code_018036, block tiles, wait for flag $0000, face the hero, animation 2, then the per-frame pad test).
; Clobbers: A.

gv_npc_old_man_crab_walk_018000 {
    COP [14] ( #$0029, &code_018007 )
    RTL 
}

code_018007 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_018036 )
    COP [15]
    COP [05] ( #$0000 )   ; waits until the first talk (code_018036) has set flag $0000: the old man only watches the pad after the lesson
    COP [8F]
    COP [80] ( #02 )
    COP [82]
    COP [91]
    LDA $joy_pressed
    AND #$0030            ; L or R ($0030) newly pressed ...
    BNE loc_018028
    RTL 

  loc_018028:
    LDA $joy_pressed
    AND #$0F00            ; ... together with a d-pad direction in the same frame: the crab walk was tried, switch to the praise text
    BNE loc_018031
    RTL 

  loc_018031:
    COP [17] ( &code_01803F )
    RTL 
}

code_018036 {
    COP [01] ( &asciistring_018044 )
    COP [09] ( #$8000 )
    RTL 
}

code_01803F {
    COP [01] ( &asciistring_0180B7 )
    RTL 
}

asciistring_018044 |[10]Hey, you look like you[N]would be good at crab+[N]walking- [N]Try it- [FIN]You don t know how? [N]Just walk while [N]pressing either [N]the L or R button- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0180B7 |[10]See, I knew you could[N]do it! [FIN]This will help you [N]when you are fighting [N]or using magic- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

; The old woman whose house heals the hero: she offers to adopt him.
; 
; When: meta type $0C; hidden until switch $02 (lair record $02, lair in location 05, frees name 1 'an old woman' to her home tile ($0A,$1A)).
; Sees: before the Chief's return: 'My husband used to be the village Chief ... One day he suddenly disappeared along with the other villagers. I feel so lonely. How about being one of my children?' with a Yes / No menu; Yes: 'Really?! I will call you <name> from now on. Use the second floor as your own room.'; later visits: '<name>, you are just walking around doing nothing. I am beginning to worry about you. Please, stay here and rest.' The hero is healed to full after the Yes and after every later talk (COP 37; the walkthrough: 'heal up in the house to the west'). After the Metal Mantis lair (switch $09) is released she moves herself to tile ($3B,$1E) and says 'I feel bad for Lisa, having been separated from her parents'; once the hero owns the VIP Card: '<name>! Soldiers from Magridd were just here! They kidnapped Lisa! You must rescue her!'. When the ending flag $1F02 is set she removes herself.
; Why: one actor serves the three stages of the story (before the Chief, after the Chief, after the kidnapping); the stage is chosen by switch $09, flag $1F02 and the VIP Card.
; In: actor script, X = own slot. Flag $0101 = the offer was accepted.
; Out: RTL after COP 14; on the return trip after freeing her (COP 30, record $02) a child shows 'You hear a sigh coming from inside the house-' and kills itself.
; Clobbers: A.

gv_npc_old_woman_0180F7 {
    COP [14] ( #$0002, &code_0180FE )
    RTL 
}

code_0180FE {
    COP [30] ( #$0002, &code_018159, #03 )
    COP [14] ( #$0009, &code_018114 )
    COP [17] ( &code_01812B )
    COP [15]
    COP [91]
    RTL 
}

code_018114 {
    COP [07] ( #$9F02, &code_018128 )
    COP [17] ( &code_018160 )
    COP [11] ( #04, #3B, #1E )
    COP [15]
    COP [91]
    RTL 
}

code_018128 {
    COP [86]
    RTL 
}

code_01812B {
    COP [07] ( #$8101, &code_018152 )
    COP [01] ( &asciistring_01816F )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_01814D )
    LDA $L_choice_result
    BNE code_01814D
    COP [09] ( #$8101 )
    COP [01] ( &asciistring_018211 )
    BRL loc_018156
}

code_01814D {
    COP [01] ( &asciistring_0181F8 )
    RTL 
}

code_018152 {
    COP [01] ( &asciistring_018255 )

  loc_018156:
    COP [37]
    RTL 
}

code_018159 {
    COP [01] ( &asciistring_01832D )
    COP [86]
    RTL 
}

code_018160 {
    COP [18] ( #29, &code_01816A ) ; inventory entry $29 is the VIP Card (Castle of King Magridd): once the hero holds it, Lisa has been kidnapped
    COP [01] ( &asciistring_0182E7 )
    RTL 
}

code_01816A {
    COP [01] ( &asciistring_0182AC )
    RTL 
}

asciistring_01816F |[10]My husband used to be [N]the village Chief- [FIN]One day he suddenly [N]disappeared along with[N]the other villagers- [FIN]I feel so lonely---- [N]How about being one of[N]my children? [END]|

asciistring_0181F8 |Well, [N]that s too bad- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018211 |Really?! [N]I will call you [N][02:2] from now on- [FIN]Use the second floor [N]as your own room- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018255 |[10][02:2], [N]you are just walking [N]around doing nothing- [FIN]I am beginning to [N]worry about you- [N]Please, stay here and [N]rest- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0182AC |[10]I feel bad for Lisa, [N]having been separated [N]from her parents- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0182E7 |[10][02:2]! [FIN]Soldiers from Magridd [N]were just here! [N]They kidnapped Lisa! [N]You must rescue her! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01832D |[10]You hear a sigh coming[N]from inside the house-[JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

; The tool shop owner (the woman on the left): gives a free Medical Herb.
; 
; When: meta type $0D; hidden until switch $06 (lair record $06 frees name 8 'tool shop owner' to her home tile ($16,$1C); the walkthrough: 'The switch beneath the lair will release the tool shop's owner').
; Sees: she turns towards the hero when he stands on her left or right (flip, animation $0B, idle animation 6). Without a Medical Herb: 'Hello, may I help you? Oh, you are the one who released me! Take whatever you need from my store. I only have Medical Herbs though.' and '<name> received a Medical Herb' (sound $5E, COP 0A $38). With one: 'Whenever you use your Medical Herb please come back, and I will give you another.' (walkthrough chapter 2: 'speak with the woman on the left to get another Medical Herb if you need it').
; Why: an infinite herb supply that is not a treasure: the test is the inventory entry $38, not a flag.
; In: actor script, X = own slot.
; Out: talk handler code_018399; the loop code_01835E runs while the hero is on the 16-pixel grid.
; Clobbers: A.

gv_npc_tool_shop_owner_018353 {
    COP [14] ( #$0006, &code_01835A )
    RTL 
}

code_01835A {
    COP [17] ( &code_018399 )

  code_01835E:
    COP [91]
    COP [20] ( &code_018395 )
    COP [9A] ( #$0000, &code_01836E, &code_018395, &code_018383 )
}

code_01836E {
    COP [23] ( &code_01837B )
    COP [97]
    COP [9D] ( #0B )
    COP [9E] ( &code_01837B )
}

code_01837B {
    COP [80] ( #06 )
    COP [82]
    BRL code_018395
}

code_018383 {
    COP [24] ( &code_018390 )
    COP [96]
    COP [9D] ( #0B )
    COP [9E] ( &code_018390 )
}

code_018390 {
    COP [80] ( #06 )
    COP [82]
}

code_018395 {
    COP [27] ( &code_01835E )
}

code_018399 {
    COP [18] ( #38, &code_0183A3 )
    COP [01] ( &asciistring_018428 )
    RTL 
}

code_0183A3 {
    COP [01] ( &asciistring_0183AD )
    BRK #$5E
    COP [0A] ( #38 )
    RTL 
}

asciistring_0183AD |[10]Hello, may I help you?[FIN]Oh, you are the one [N]who released me! [N]Take whatever you need[N]from my store- [FIN]I only have Medical [N]Herbs though- [FIN][02:2] received [N][03:24]a Medical Herb- [03:20][JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018428 |[10]Hello, may I help you?[FIN]Oh, you are the one [N]who released me! [FIN]Whenever you use your [N]Medical Herb please [N]come back, and I will [N]give you another- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

asciistring_018480 |[02:96][02:80][08:8202]And world your |
---------------------------------------------

; A tulip near the water mill that tells of the mill and, later, of the Chief.
; 
; When: meta type $0E; hidden until switch $07 (lair record $07 frees name $0B 'tulip' to its home tile ($0B,$1D); the walkthrough: 'trigger the switch beneath it to release a tulip').
; Sees: on the return trip (COP 30, record $07) '<name> began to hear a small voice' and the story; at rest it plays animation $1E forever. Talk: before the Metal Mantis lair (switch $09) 'There once was a water mill here before the village was destroyed. I hear there is a man in the mill who runs the elevator in the Underground Castle.'; after it 'The village Chief speaks with me every morning. Even though I cannot speak, I communicate with him through our thoughts.'
; Why: the flower only changes its text with the story stage (switch $09).
; In: actor script, X = own slot.
; Out: RTL after COP 14; the appear handler never returns (loop of COP 80 / 82).
; Clobbers: A.

gv_npc_tulip_water_mill_01848A {
    COP [14] ( #$0007, &code_018491 )
    RTL 
}

code_018491 {
    COP [30] ( #$0007, &code_0184B9, #03 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0184AA )
    COP [15]

  loc_0184A3:
    COP [80] ( #1E )
    COP [82]
    BRA loc_0184A3
}

code_0184AA {
    COP [14] ( #$0009, &code_0184B5 )
    COP [01] ( &asciistring_0184BE )
    RTL 
}

code_0184B5 {
    COP [01] ( &asciistring_018552 )
}

code_0184B9 {
    COP [01] ( &asciistring_01852E )
    RTL 
}

asciistring_0184BE |[10][::]There once was [N]a water mill here [N]before the village was[N]destroyed- [FIN]I hear there is a man [N]in the mill who runs [N]the elevator in the [N]Underground Castle- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01852E |[10][0E:3C][02:2] began [N]to hear a small voice-[FIN][JMP:&asciistring_0184BE+M]|

asciistring_018552 |[10]The village Chief [N]speaks with me every [N]morning- [FIN]Even though I cannot [N]speak, I communicate [N]with him through our [N]thoughts- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

; The bridge guard, who steps aside when the hero comes close.
; 
; When: meta type $0F; hidden until switch $08 (lair record $08 frees name 5 'The bridge guard' to his home tile ($1C,$1F); the walkthrough: 'release the bridge guard (and the bridge)').
; Sees: first talk: 'I am the guard of the bridge. I guess it is not really necessary to guard such a small bridge, please pass.'; later: 'Please pass.' When the hero comes within 4 pixels of the guard's box (COP 0C, slot 0 = the hero) the guard unblocks its tiles, plays animation 3 (stepping aside), blocks the new tiles and sets flag $0004; when the hero leaves it walks back (animation 4), blocks again and clears the flag.
; Why: the guard is a solid actor; moving the blocked tiles is what lets the hero cross (flag $0202 only chooses the text).
; In: actor script, X = own slot.
; Out: talk handler code_018635 (sets flag $0202) or code_01863E; the loop code_0185D8 never returns.
; Clobbers: A.

gv_npc_bridge_guard_0185B9 {
    COP [14] ( #$0008, &code_0185C0 )
    RTL 
}

code_0185C0 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [91]
    COP [07] ( #$8202, &code_0185D4 )
    COP [17] ( &code_018635 )
    RTL 
}

code_0185D4 {
    COP [17] ( &code_01863E )

  code_0185D8:
    COP [0C] ( #00, #04, &code_01860F )
    COP [07] ( #$8004, &code_0185FD )
    COP [9A] ( #$0000, &code_0185EE, &code_01860F, &code_0185F3 )
}

code_0185EE {
    COP [97]
    BRL loc_0185F5
}

code_0185F3 {
    COP [96]

  loc_0185F5:
    COP [80] ( #02 )
    COP [82]
    BRL loc_018631
}

code_0185FD {
    COP [16]
    COP [9D] ( #04 )
    COP [9E] ( &code_018606 )
}

code_018606 {
    COP [15]
    COP [09] ( #$0004 )
    BRL loc_018631
}

code_01860F {
    COP [07] ( #$8004, &code_01862C )
    COP [16]
    COP [9D] ( #03 )
    COP [9E] ( &code_01861E )
}

code_01861E {
    COP [80] ( #01 )
    COP [82]
    COP [15]
    COP [09] ( #$8004 )
    BRL loc_018631
}

code_01862C {
    COP [80] ( #01 )
    COP [82]

  loc_018631:
    COP [27] ( &code_0185D8 )
}

code_018635 {
    COP [01] ( &asciistring_018643 )
    COP [09] ( #$8202 )
    RTL 
}

code_01863E {
    COP [01] ( &asciistring_018698 )
    RTL 
}

asciistring_018643 |[10]I am the guard of [N]the bridge- [FIN]I guess it is not [N]really necessary to [N]guard such a small [N]bridge, please pass- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018698 |[10]Please pass-[JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

; The keeper of the water mill: he asks the hero to turn the wheel that powers the Underground Castle elevator.
; 
; When: meta type $10; hidden until switch $0E (lair record $0E frees name $0D 'The water mill keeper' to his home tile ($26,$1C); the walkthrough: 'trigger the switch beneath the latter to release the water mill keeper').
; Sees: 'Rotating this wheel will move the elevator in the Underground Castle. I am too weak to turn this wheel, will you do it for me?' (flag $0001); he works at the wheel (flip, animations 5 and 4, input locked meanwhile). When the hero stands on tile ($26,$17) beside the wheel he is asked 'This is the wheel, will you try to turn it?' (Yes / No); Yes: '<name> turned the wheel. As the wheel started to turn, power was transmitted to the Underground Castle.' (sound $4F), flag $0404 set, and the keeper moves himself to tile ($27,$17): 'Oh, no wonder! I was turning it the wrong way! By the way, don't you think this water mill is great?!' When the hero then steps on tile ($2F,$32) the text 'This is the Master's Emblem A' is shown once and Emblem A ($2A) is given (flag $1A00). On the return trip after freeing him (COP 30, record $0E) a child shows 'A man's voice came from inside the water mill. DARN IT! This stupid wheel! It's so hard to turn!'.
; Why: the one actor owns the wheel puzzle and the Emblem; flag $0404 is what the Underground Castle elevator (gv_underground_castle_actors) waits for.
; In: actor script, X = own slot (slot 8 = itself); COP 11 ( #08 ) moves it, COP 0D ( #00 ) tests the hero's tile.
; Out: RTL after COP 14; before the wheel is turned the loop code_0186E5 waits for the hero's tile; after it the loop code_018724 waits for the Emblem tile.
; Clobbers: A, Y (= player_actor while the hero's animation is set).

gv_npc_water_mill_keeper_0186A2 {
    COP [14] ( #$000E, &code_0186A9 )
    RTL 
}

code_0186A9 {
    COP [30] ( #$000E, &code_018774, #03 )
    COP [07] ( #$8404, &code_018742 ) ; flag $0404: the wheel was turned (the elevator in the Underground Castle waits for it)
    COP [15]
    COP [17] ( &code_018766 )
    COP [05] ( #$0001 )
    COP [16]
    LDA #$2F80
    TSB $joy_block_mask
    COP [96]
    COP [9D] ( #05 )
    COP [9E] ( &code_0186D1 )
}

code_0186D1 {
    COP [9D] ( #04 )
    COP [9E] ( &code_0186D8 )
}

code_0186D8 {
    COP [80] ( #00 )
    COP [82]
    LDA #$2F80
    TRB $joy_block_mask
    COP [15]

  loc_0186E5:
    COP [91]
    COP [0D] ( #00, #26, #17, &code_0186EF ) ; slot 0 is the hero: his tile in front of the wheel starts the prompt
    RTL 
}

code_0186EF {
    LDA #$2F80
    TSB $joy_block_mask
    LDY $player_actor
    LDA #$0001
    STA $001E, Y
    COP [03] ( #03 )
    COP [04]
    LDA #$2F80
    TRB $joy_block_mask
    COP [01] ( &asciistring_018889 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_018732 )
    LDA $L_choice_result
    BNE code_018732
    COP [01] ( &asciistring_0188A7 )
    BRK #$4F
    COP [09] ( #$8404 )

  loc_018724:
    COP [17] ( &code_01876F )
    COP [91]
    COP [0D] ( #00, #2F, #32, &code_018750 ) ; tile ($2F,$32): the hidden Master's Emblem A of the water mill
    RTL 
}

code_018732 {
    COP [01] ( &shared_actor_helpers_bank3.asciistring_01B988+M )
    COP [91]
    COP [0D] ( #00, #26, #17, &code_018741 )
    BRA loc_0186E5
}

code_018741 {
    RTL 
}

code_018742 {
    COP [11] ( #08, #27, #17 )
    COP [15]
    COP [80] ( #00 )
    COP [82]
    BRA loc_018724
}

code_018750 {
    COP [07] ( #$9A00, &code_018763 )
    COP [01] ( &asciistring_0188FC )
    BRK #$5E
    COP [0A] ( #2A )
    COP [09] ( #$9A00 )
}

code_018763 {
    COP [91]
    RTL 
}

code_018766 {
    COP [01] ( &asciistring_01877B )
    COP [09] ( #$8001 )
    RTL 
}

code_01876F {
    COP [01] ( &asciistring_0187E0 )
    RTL 
}

code_018774 {
    COP [01] ( &asciistring_018836 )
    COP [86]
    RTL 
}

asciistring_01877B |[10]Rotating this wheel [N]will move the elevator[N]in the Underground [N]Castle- [FIN]I am too weak to turn [N]this wheel, will you [N]do it for me? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0187E0 |[10]Oh, no wonder! I was [N]turning it the wrong [N]way! [FIN]By the way, don t you [N]think this water mill [N]is great?! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018836 |[10][0E:3C]A man s voice came [N]from inside the water [N]mill- [FIN]DARN IT! [FIN]This stupid wheel! [N]It s so hard to turn! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018889 |[10]This is the wheel, [N]will you try to turn [N]it? [END]|

asciistring_0188A7 |[02:2] [N]turned the wheel- [FIN]As the wheel started [N]to turn, power was [N]transmitted to the [N]Underground Castle- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0188FC |[10]This is [03:24]the Master s [N]Emblem A- [03:20][JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

; The goat of the goat pen; its pen holds a hidden Medical Herb.
; 
; When: meta type $11; hidden until switch $0F (lair record $0F frees name 9 'a goat' to its home tile ($29,$29) after the Flies lairs; the walkthrough: 'release a goat').
; Sees: the goat grazes (animations $1B twice and $24 four times, then flips); talk: 'I wonder why people live in such small houses? Can you believe the village Chief was swallowed up in one of the paintings in the house on the hill?'; after the Metal Mantis lair (switch $09) 'Can you believe that the village Chief has come back to life?'. A helper actor (spawned by COP AC, flags $2000: hidden) waits for the hero on tile ($34,$2C), the south-east corner of the pen: once, '<name>: There is a Medical Herb at the corner of the fence' (sound $5E, COP 0A $38, flag $0103).
; Why: the herb is a free refill, not a treasure; the helper is a separate actor because the herb tile is not the goat's tile.
; In: actor script, X = own slot.
; Out: RTL after COP 14; the appear handler loops the grazing animations.
; Clobbers: A.

gv_npc_goat_pen_01891A {
    COP [14] ( #$000F, &code_018921 )
    RTL 
}

code_018921 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [AC] ( @code_01894A, #$0000, #$0010, #$2000 )
    COP [17] ( &code_018968 )

  loc_018935:
    COP [81] ( #1B, #02 )
    COP [83]
    COP [15]
    COP [81] ( #24, #04 )
    COP [83]
    COP [16]
    COP [87]
    BRL loc_018935
}

code_01894A {
    COP [07] ( #$8103, &code_018965 )
    COP [0D] ( #00, #34, #2C, &code_018958 ) ; tile ($34,$2C): the south-east corner of the goat pen, where the Medical Herb lies
    RTL 
}

code_018958 {
    COP [01] ( &asciistring_018A2B )
    BRK #$5E
    COP [0A] ( #38 )
    COP [09] ( #$8103 )
}

code_018965 {
    COP [86]
    RTL 
}

code_018968 {
    COP [14] ( #$0009, &code_018973 )
    COP [01] ( &asciistring_018978 )
    RTL 
}

code_018973 {
    COP [01] ( &asciistring_0189E0 )
    RTL 
}

asciistring_018978 |[10]I wonder why people [N]live in such small [N]houses? [FIN]Can you believe the [N]village Chief was [N]swallowed up in [FIN]one of the paintings [N]in the house on the [N]hill? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0189E0 |[10]I wonder why people [N]are living in such [N]small houses? [FIN]Can you believe that [N]the village Chief has [N]come back to life? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018A2B |[10]There is [03:24]a Medical [N]Herb [03:20]at the corner of [N]the fence- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

; Lisa, the girl who sleeps in her house, and the end of the game.
; 
; When: meta type $12; hidden until switch $10 (lair record $10 frees name 3 'Lisa' to her home tile ($3A,$24); the walkthrough: 'use the monster lairs to release Lisa and a tulip').
; Sees: on the return trip (COP 30, record $10) 'You hear some light snoring coming from inside the house'. Talking to her: without the Dream Rod equipped 'Zzzz'; with it '<name> placed the Dream Rod on the girl's head' and the hero enters Lisa's dream (area 2 scene 3, gv_underground_castle_actors). Back awake she shouts 'Oh, my! Who are you? Get out of my house!' (flag $0104), then calls 'Wait! I'm sorry for yelling at you. Please come back and listen to my story' (flags $0105, $0207) and tells of her strange dream, that her father wants the hero to have his paintbrush and that she will talk when he returns with it (flag $0301); with Leo's Brush ($1D) she reads her father's note about the pets Turbo, Lue, Nome and Marie and asks the hero to search for her father (flag $0302). After the Metal Mantis lair (switch $09) she only says that some believe a dead person returns as another creature. Once the hero owns the VIP Card she removes herself (kidnapped).
; Ending: with the ending flag $1F02 set (RunEnding) the hero is locked and moved up 8 pixels; without $1F01 the Dream Rod text 'Lisa appears to be sleeping' and the warp into her dream follow; with $1F01 (set by her dream) '<name>, promise me you will return someday.' is shown and the scene changes to area 0 scene $0B, the ending (gv_front_end).
; Why: one actor holds Lisa's whole story, driven by the flag chain $0104 -> $0105 -> $0207 -> $0301 -> $0302.
; In: actor script, X = own slot (the hero's $1E is set to 1 by the dream entry).
; Out: RTL after COP 14; the loop code_018A83 picks the stage from the flags.
; Clobbers: A, Y; joy_block_mask bits are set and cleared in pairs.

gv_npc_lisa_018A59 {
    COP [14] ( #$0010, &code_018A60 )
    RTL 
}

code_018A60 {
    COP [30] ( #$0010, &code_018BC3, #03 )
    COP [07] ( #$9F02, &code_018B28 ) ; event flag $1F02 is set by RunEnding (Deathtoll defeated): the post-ending Lisa
    COP [18] ( #29, &code_018A75 )
    COP [86]
    RTL 
}

code_018A75 {
    COP [A0] ( #$FFF8 )
    COP [14] ( #$0009, &code_018B1C )
    COP [17] ( &code_018B7C )

  code_018A83:
    COP [07] ( #$8302, &code_018B0F )
    COP [07] ( #$8301, &code_018AF5 )
    COP [07] ( #$8207, &code_018AE8 )
    COP [07] ( #$8105, &code_018AE8 )
    COP [07] ( #$8104, &code_018AA9 )
    COP [80] ( #12 )
    COP [82]
    BRL code_018A83
}

code_018AA9 {
    LDA #$AF80
    TSB $joy_block_mask
    COP [80] ( #13 )
    COP [82]
    COP [80] ( #14 )
    COP [82]
    LDA #$AF80
    TRB $joy_block_mask
    COP [01] ( &asciistring_018C34 )
    COP [09] ( #$8105 )
    COP [91]
    COP [0D] ( #00, #37, #1F, &code_018AD8 )
    COP [0D] ( #00, #3A, #20, &code_018AD8 )
    RTL 
}

code_018AD8 {
    COP [01] ( &asciistring_018C5C )
    COP [09] ( #$8207 )
    COP [17] ( &code_018BA2 )
    COP [27] ( &code_018A83 )
}

code_018AE8 {
    COP [80] ( #14 )
    COP [82]
    COP [17] ( &code_018BA2 )
    COP [27] ( &code_018A83 )
}

code_018AF5 {
    COP [80] ( #14 )
    COP [82]
    COP [18] ( #1D, &code_018B07 )
    COP [17] ( &code_018BB0 )
    COP [27] ( &code_018A83 )
}

code_018B07 {
    COP [17] ( &code_018BAB )
    COP [27] ( &code_018A83 )
}

code_018B0F {
    COP [80] ( #14 )
    COP [82]
    COP [17] ( &code_018BB9 )
    COP [27] ( &code_018A83 )
}

code_018B1C {
    COP [80] ( #14 )
    COP [82]
    COP [17] ( &code_018BBE )
    COP [91]
    RTL 
}

code_018B28 {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [A0] ( #$FFF8 )
    COP [07] ( #$9F01, &code_018B5B ) ; event flag $1F01 is set by Lisa's dream (gv_underground_castle_actors): the dream is over, the epilogue follows
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_018F85 )
    COP [03] ( #79 )
    COP [04]
    COP [3C] ( #04 )
    COP [10] ( #$0302, #01, #$0108, #$0348 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_018B5B {
    COP [34]
    COP [80] ( #13 )
    COP [82]
    COP [03] ( #5B )
    COP [04]
    COP [01] ( &asciistring_018FCD )
    COP [03] ( #F1 )
    COP [04]
    COP [10] ( #$0B00, #01, #$0000, #$0000 ) ; area 0 scene $0B: the ending (PlacementA00S0B, type $57)
    COP [91]
    RTL 
}

code_018B7C {
    COP [07] ( #$8104, &code_018B9D )
    COP [19] ( #1C, &code_018B98 )
    COP [01] ( &asciistring_018C02 )
    COP [3C] ( #04 )
    COP [10] ( #$0302, #02, #$0120, #$0320 )
    RTL 
}

code_018B98 {
    COP [01] ( &asciistring_018C26 )
    RTL 
}

code_018B9D {
    COP [01] ( &asciistring_018C34 )
    RTL 
}

code_018BA2 {
    COP [01] ( &asciistring_018C98 )
    COP [09] ( #$8301 )
    RTL 
}

code_018BAB {
    COP [01] ( &asciistring_018D5D )
    RTL 
}

code_018BB0 {
    COP [01] ( &asciistring_018D61 )
    COP [09] ( #$8302 )
    RTL 
}

code_018BB9 {
    COP [01] ( &asciistring_018F15 )
    RTL 
}

code_018BBE {
    COP [01] ( &asciistring_018F19 )
    RTL 
}

code_018BC3 {
    COP [01] ( &asciistring_018BCA )
    COP [86]
    RTL 
}

asciistring_018BCA |[10][0E:3C]You hear some light [N]snoring coming from [N]inside the house- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018C02 |[10][02:2] placed [N]the Dream Rod on the [N]girl s head- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018C26 |[10]Zzzz----- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018C34 |[10]Oh, my! Who are you? [N]Get out of my house! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018C5C |[10]Wait! [N]I m sorry for yelling [N]at you- [FIN]Please come back and [N]listen to my story- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018C98 |[10]I had a very strange [N]dream- It was about my[N]father and someone who[N]looked just like you- [FIN]My father told me to [N]give his paintbrush to[N]you and tell you all I[N]know- [FIN][::]The brush is all [N]I have left from my [N]father- [N]I hid it somewhere- [FIN]When you come back to [N]me with that brush, I [N]will tell you all I [N]know- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018D5D |[10][JMP:&asciistring_018C98+M]|

asciistring_018D61 |[10]Oh! You have found my [N]father s paintbrush- I[N]will now tell you what[N]I know- [FIN]One day, as I returned[N]from shopping I [N]found a note- [FIN]Lisa pulled out the [N]note and began to [N]read- [FIN]"Lisa, I won t be able[N]to see you for a [N]while- [FIN]If you have any [N]problems, please see [N]the village Chief- [FIN]Take care of your [N]friends, [N]Turbo, the dog, [FIN]Lue, the dolphin, [FIN]Nome, the snail, [FIN]and Marie, the doll-ˮ [FIN]The animals mentioned [N]in the letter were [N]once my father s pets-[FIN]I don t understand [N]what he is trying to [N]say though- [FIN][::]I know you re a [N]complete stranger, but[N]will you please search[N]for my father? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018F15 |[10][JMP:&asciistring_018D61+M]|

asciistring_018F19 |[10]Some believe after a [N]person dies, they will[N]return in the form of [N]a different creature- [FIN]If this is true, I [N]wonder what my mother [N]is doing now? [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_018F85 |[10][0F]Lisa appears to be [N]sleeping- [N][0E:5A][02:2], placed [N]the Dream Rod upon [N]Lisa s head- [0E:78][JMP:&shared_actor_helpers_bank3.asciistring_01B988+M]|

asciistring_018FCD |[10][02:2], [N]promise me you will [N]return someday- [0E:B4][JMP:&shared_actor_helpers_bank3.asciistring_01B988+M]|
---------------------------------------------

; A tulip in the village that explains the Dream Rod.
; 
; When: meta type $13; hidden until switch $11 (lair record $11 frees name $0B 'tulip' to its home tile ($16,$33); the walkthrough: 'go up the vine nearby. The tulip here will speak of the Dream Rod').
; Sees: with the Dream Rod ($1C) in the inventory 'The Dream Rod you possess is a magical stick that enables you to look into dreams. Equip this stick when you wish to speak with someone who is sleeping.'; without it 'I have heard of a strange stick that enables anyone who possesses it to speak with those that are asleep. It is hidden in the Underground Castle.'
; Why: the inventory entry, not a flag, chooses the text.
; In: actor script, X = own slot.
; Out: RTL after COP 14; the appear handler loops animation $1E.
; Clobbers: A.

gv_npc_tulip_dream_rod_018FF4 {
    COP [14] ( #$0011, &code_018FFB )
    RTL 
}

code_018FFB {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01900D )
    COP [15]

  loc_019006:
    COP [80] ( #1E )
    COP [82]
    BRA loc_019006
}

code_01900D {
    COP [18] ( #1C, &code_019017 )
    COP [01] ( &asciistring_01901C )
    RTL 
}

code_019017 {
    COP [01] ( &asciistring_019098 )
    RTL 
}

asciistring_01901C |[10]The Dream Rod you [N]possess is a magical [N]stick that enables you[N]to look into dreams- [FIN]Equip this stick when [N]you wish to speak with[N]someone who is [N]sleeping- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_019098 |[10]I have heard of a [N]strange stick that [N]enables anyone who [N]possesses it [FIN]to speak with those [N]that are asleep- It is[N]hidden in the [N]Underground Castle- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

; Gaudi, the architect who built the houses of the village.
; 
; When: meta type $14; hidden until switch $12 (lair record $12 frees name 6 'an architect' to his home tile ($39,$14); the walkthrough: 'The switch under the lair releases an architect').
; Sees: first talk 'My name is Gaudi, I am an architect. I built all the houses in this town. Come back later, I will show you something.' (flags $0107 and $0003 set); a later talk 'What do you think of these walls? I am known to be a fast builder!'.
; Why: the text depends on flag $0107 (introduced) and $0003 (introduced during this visit; the code falls through to the introduction while $0003 is set, so the second text appears on a later visit, OQ-I034-2).
; In: actor script, X = own slot.
; Out: RTL after COP 14.
; Clobbers: A.

gv_npc_architect_gaudi_01910C {
    COP [14] ( #$0012, &code_019113 )
    RTL 
}

code_019113 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_019121 )
    COP [15]
    COP [91]
    RTL 
}

code_019121 {
    COP [07] ( #$0107, &code_01912D )
    COP [07] ( #$0003, &code_01913A )
}

code_01912D {
    COP [01] ( &asciistring_01913F )
    COP [09] ( #$8107 )
    COP [09] ( #$8003 )
    RTL 
}

code_01913A {
    COP [01] ( &asciistring_01919A )
    RTL 
}

asciistring_01913F |[10]My name is Gaudi, I am[N]an architect- [FIN]I built all the houses[N]in this town- Come [N]back later, I will [N]show you something- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01919A |[10]What do you think of [N]these walls? [N]I am known to be a [N]fast builder! [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

; The tool shop owner's son, who sells goat food for a billion dollars and then gives it away.
; 
; When: meta type $15, COP 3B on switch $16 (lair record $16 frees name 7 'tool shop owner s son' to his home tile ($18,$17); the walkthrough: 'use the resultant switches to release the son of the owner of the tool shop').
; Sees: if the hero has no Goat's Food ($19): 'I am helping my mother. Would you like to buy some goat's food? Do you want to know how much it costs? Well. How about one billion dollars plus tax?!' (a Yes / No menu whose answer does not matter: both lead on); then 'TEDDY!! I'm sorry, I will give it to you for free. <name> received a bag of goat's food!' (sound $5E, COP 0A $19), and the tool shop owner (slot 5) is made to play a short animation. With the food: 'Oh, you don't need many bags of goat's food, return here after you have used the one I have given you.'
; Why: COP 3B is the 'hold' variant of COP 14: while the lair is not released the actor's talk handler is the shared shared_actor_helpers_bank3.cm_npc_captive_plea_01B191 and the root continues in engine_player_death_and_actor_helpers.HoldActorUntilReleased (through the pushed return address); the walkthrough: the food is infinitely available, so it is no treasure.
; In: actor script, X = own slot.
; Out: after the release: appear puff, talk handler code_01922C, then a loop that turns the actor towards the hero (flip, animation $11 or $0C).
; Clobbers: A.

gv_npc_tool_shop_son_0191D2 {
    COP [3B] ( #$0016, &code_0191E8 )
    COP [17] ( &shared_actor_helpers_bank3.cm_npc_captive_plea_01B191 )
    SEP #$20
    LDA #$^engine_player_death_and_actor_helpers.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_player_death_and_actor_helpers.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0191E8 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01922C )

  code_0191F1:
    COP [91]
    COP [20] ( &code_019228 )
    COP [9A] ( #$0000, &code_019201, &code_019228, &code_019216 )
}

code_019201 {
    COP [23] ( &code_01920E )
    COP [97]
    COP [9D] ( #11 )
    COP [9E] ( &code_01920E )
}

code_01920E {
    COP [80] ( #0C )
    COP [82]
    BRL code_019228
}

code_019216 {
    COP [24] ( &code_019223 )
    COP [96]
    COP [9D] ( #11 )
    COP [9E] ( &code_019223 )
}

code_019223 {
    COP [80] ( #0C )
    COP [82]
}

code_019228 {
    COP [27] ( &code_0191F1 )
}

code_01922C {
    COP [18] ( #19, &code_019236 )
    COP [01] ( &asciistring_01931F )
    RTL 
}

code_019236 {
    COP [01] ( &asciistring_019255 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_019241 )
}

code_019241 {
    COP [12] ( #05, &asciistring_018480 ) ; slot 5 (the tool shop owner) resumes at asciistring_018480, which is code (OQ-I034-1)
    COP [01] ( &asciistring_0192D9 )
    COP [12] ( #05, &gv_npc_tool_shop_owner_018353 )
    BRK #$5E
    COP [0A] ( #19 )
    RTL 
}

asciistring_019255 |[10]I am helping my [N]mother-Would you like [N]to buy some goat s [N]food? [FIN]Do you want to know [N]how much it costs? [FIN]Well-------- [N][0E:1E]How about one billion [N]dollars plus tax?! [END]|

asciistring_0192D9 |[10]TEDDY!! [N]I m sorry, I will give[N]it to you for free- [FIN][02:2] received [N][03:24]a bag of goat s food[03:20]!![JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_01931F |[10]Oh, you don t need [N]many bags of goat s [N]food, [FIN]return here after you [N]have used the one [N]I have given you- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|
---------------------------------------------

; A tulip that muses on the boundary between dreams and reality.
; 
; When: meta type $16; hidden until switch $18 (lair record $18 frees name $0B 'tulip' to its home tile ($2C,$0A)).
; Sees: 'I wonder who placed the boundary between dreams and reality? Sometimes things that happen in dreams come true in reality.'; once flag $0104 (Lisa's dream was visited) is set: 'You remember Lisa's dream right? Have you returned to the place you saw in her dream? Things may be different from when you saw her before.'
; Why: a hint for the painting in the dream; the text changes with flag $0104.
; In: actor script, X = own slot.
; Out: RTL after COP 14; the appear handler loops animation $1E.
; Clobbers: A.

gv_npc_tulip_dream_boundary_019365 {
    COP [14] ( #$0018, &code_01936C )
    RTL 
}

code_01936C {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_01937E )
    COP [15]

  loc_019377:
    COP [80] ( #1E )
    COP [82]
    BRA loc_019377
}

code_01937E {
    COP [07] ( #$8104, &code_019389 )
    COP [01] ( &asciistring_01938E )
    RTL 
}

code_019389 {
    COP [01] ( &asciistring_0193FB )
    RTL 
}

asciistring_01938E |[10]I wonder who placed [N]the boundary between [N]dreams and reality? [FIN]Sometimes things that [N]happen in dreams come [N]true in reality- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|

asciistring_0193FB |[10]You remember Lisa s, [N]dream right? Have you [N]returned to the place [N]you saw in her dream? [FIN]Things may be [N]different from when [N]you saw her before- [JMP:&shared_actor_helpers_bank3.asciistring_01B988]|