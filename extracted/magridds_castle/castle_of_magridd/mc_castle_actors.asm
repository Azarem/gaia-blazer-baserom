; The soldiers, maids, singers, the Queen and King Magridd of the castle town (file offsets 147368-154393, SNES $04:BFA8-$04:DB19): the actors of scene A10S01 (location $65, 'Castle of King Magridd'). Walkthrough chapter: docs/walkthrough/07-king-magridds-castle.md.
; 
; === WHAT RUNS HERE ===
; Every actor here is placed by PlacementA10S01 (meta types $18-$30 of MetaMagriddsCastle; the last byte of each row; flags byte $41 = flip X, $01 = none) and is released by a lair of the castle's dungeon or towers: COP 14 / COP 3B on the switch = the LairRecords row with that number (+9 = who: $2F a soldier, $30 a maid, $31 a singer, $32 King Magridd, $34 the Queen; +B = the lair's location; +10 = its monsters). Until the lair is cleared the actor only RTLs (COP 14) or is frozen by shared_actor_helpers_bank4.cm_npc_captive_plea_02229E + engine_003005.HoldActorUntilReleased (COP 3B). Then: puff (RunAppearPuff), blocked tiles (COP 15), a talk handler (COP 17) and COP 91.
; 
; === ROSTER (type, tile, switch = lair record: home, lair, monsters) ===
; - $18 ghost hint (23FA8): ($13,$06), $159: soldier, lair $66 tile ($0C,$07), 4 Skeleton Soldiers ($10).
; - $19 Gaudi's nephew (24027): ($11,$20), $15A: soldier, lair $66 ($19,$13), 3 Wraithes ($0D).
; - $1A inert placeholder (240E4): ($2A,$05), flip X; the script only returns.
; - $1B Elemental Mail hint (240E5): ($1D,$13), $15F: soldier, lair $67 ($0A,$0F), 6 Wraithes.
; - $1C the sleeping soldier (24259): ($01,$1E), $161: soldier, lair $67 ($04,$1D), 2 Wraithes. Gives the Elemental Mail.
; - $1D patrolling guard (24416): ($1F,$20), $162: soldier, lair $67 ($0F,$1D), 2 Wraithes.
; - $1E soldier in shock (244EF): ($21,$13), $166: soldier, lair $67 ($23,$0B), 2 Bouncing Balls ($0C).
; - $1F the theater singer (24597): ($08,$27), $167: singer, lair $67 ($23,$19), 3 Wraithes. Needs the Harp string.
; - $20 traitor warning (2488E): ($05,$2C), $168 (frozen until released; gate word $0167): soldier, lair $67 ($2B,$0F), 4 Skeleton Soldiers.
; - $21 the Queen (2494A): ($36,$17), $17F: Queen, lair $6B ($16,$15), 4 Red Knights ($12). Gives the VIP Card, later the Super Bracelet.
; - $22 Left Tower gate guard (24AF4): ($02,$09), $16D: soldier, lair $68 ($22,$17), 2 Bouncing Balls. Wants the Platinum Card.
; - $23 theater guard (24BC8): ($0B,$30), $170 (frozen; gate $0167): soldier, lair $68 ($30,$1D), 6 Wraithes. Stands on the Platinum Card.
; - $24 the singer's friend (24D59): ($3C,$37), $172: singer, lair $68 ($39,$2F), 4 Wraithes.
; - $25 Medical Herb maid (24E53): ($3B,$2F), $187: maid, lair $6D ($16,$1B), 4 Chess Knights ($17).
; - $26 music listener (24F4A): ($09,$2C), $17E (frozen; gate $0167): maid, lair $6B ($09,$0B), 2 Bronze Robots ($16).
; - $27 dormitory maid (24FD3): ($1A,$2C), $16B: maid, lair $68 ($0F,$1E), 5 Wraithes; walks to the soldier of $185 once that one is released.
; - $28 Right Tower gate guard (25080): ($3D,$09), $182: soldier, lair $6C ($0D,$09), 2 Red Knights. Wants the VIP Card.
; - $29 shiny hint (2515B): ($2A,$2D), $186 (frozen; gate $0179): soldier, lair $6D ($04,$09), 2 Red Knights.
; - $2A Soul of Reality soldier (251DC): ($23,$2F) flip X, $179: soldier, lair $6A ($1A,$07), 3 Red Knights.
; - $2B Emblem H soldier (25302): ($1F,$0D), $18C: soldier, lair $6D ($0F,$10), 4 Chess Knights.
; - $2C airship key stolen (253E2): ($09,$17), $18D: soldier, lair $6E ($0E,$13), 1 Bronze Robot.
; - $2D herb maid fan (254A2): ($3A,$2A) flip X, $18F (frozen; gate $0187): soldier, lair $6E ($1A,$17), 5 Chess Knights.
; - $2E river scare (25502): ($28,$12), $192: soldier, lair $6F ($17,$0A), 2 Red Knights.
; - $2F King Magridd (25561): ($1F,$03), $195 (frozen; gate $018C): King, lair $72 tile ($17,$22), the Demon Falcon (meta type $09).
; - $30 dust in the eye (25AAA): ($1E,$2D), $185 (frozen; gate $016B): soldier, lair $6C ($19,$19), 3 Bronze Robots.
; The lair locations are $66 the torture chamber, $67 and $68 'Basement of the castle', $6A and $6B the left tower, $6C 'A prison', $6D-$6F the right tower, $72 the deck of an airship.
; 
; === FLAGS ===
; $0805: the dock scene has played (set by mc_dock_dr_leo_025E61 after the Mobile Key is handed over); the Queen, both gate guards and the dock soldiers read it and go away or change. $0803: the soldier's dream is over (set by mc_dream_soldier_dialogue_026A4E), read by the sleeper; $0804: the Elemental Mail has been given; $0806: Gaudi's nephew has made his first speech; $0703: the singer has her string; $0001: the performance has started (the theater guard waits for it); $0607 and $0700: the Platinum Card / VIP Card gate has been opened; $1A07: Emblem H taken; $1B05: Black Stone given; $1F02: the ending is playing. Switch $0195 (King Magridd released) changes the speech of most soldiers.
; 
; === ITEMS (ItemNameList) ===
; $06 Spirit Sword, $0F Elemental Mail, $1A Harp string, $1C Dream Rod, $28 Platinum Card, $29 the VIP Card, $31 Emblem H, $37 Super Bracelet (the speech says 'Invulnerable Bracelet'), $38 Medical Herb, $3F Black Stone.
; 
; === DIALOGUE AND RESULT ===
; Hints (basement ghosts, the Spirit Sword, thorns in the basement, the singer's string) and rewards (Elemental Mail from the sleeper after the Dream Rod; VIP Card from the Queen when the answer to 'Do you think I am pretty?' is Yes; the Platinum Card on the theater floor once the singer plays; a Medical Herb when the hero has none; Emblem H from the soldier who dreams of being king; the Soul of Reality joining from the soldier of $179; the Super Bracelet on the Queen's former tile; the Black Stone and the ending from King Magridd). Arrival children (COP 30, run once when the hero comes home through that lair record) are named *_arrival_*.
; Every text ends with a jump to mc_return_prompt_and_chest_hint_texts.asciistring_0270DF (window clear and wait).
---------------------------------------------

?BANK 04

?INCLUDE 'engine_003005'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'mc_return_prompt_and_chest_hint_texts'
?INCLUDE 'shared_actor_helpers_bank4'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!joy_block_mask                 0326
!asset_skip_mask                03B4
!souls_flags                    1B82

---------------------------------------------

; The soldier who talks about the ghosts in the torture chamber (switch $159).
; 
; When: placement script (type $18, tile ($13,$06) of A10S01); COP 14 returns until lair record $159 (4 Skeleton Soldiers of location $66) is released. COP 30 spawns the arrival child on a return through that record.
; Sees: puff, blocked tiles, talk handler code_023FC4: 'There are many ghosts in the torture room of the basement. First, look for the Spirit Sword.' The walkthrough (Castle Dungeon Part 1): 'Shatter the Skeleton Soldiers' ranks to be able to release another (human) soldier'.
; Why: pointer to the Spirit Sword that the Spirit monsters (Wraithes) need.
; In: X = D = slot $02 of A10S01.
; Out: RTL; COP 91 resume at the talk handler.
; Clobbers: A.

mc_npc_soldier_ghost_hint_023FA8 {
    COP [14] ( #$0159, &code_023FAF )
    RTL 
}

code_023FAF {
    COP [30] ( #$0159, &mc_npc_soldier_ghost_hint_arrival_023FC9, #04 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_023FC4 )
    COP [15]
    COP [91]
    RTL 
}

code_023FC4 {
    COP [01] ( &asciistring_023FDD )
    RTL 
}

---------------------------------------------
; The arrival child of the ghost soldier.
; 
; When: spawned by COP 30 when the hero comes back through lair record $159.
; Sees: COP 18 on item $06 (Spirit Sword): missing, the same text as the talk handler; owned, the child ends at once (COP 86).
; Why: tell a hero who has no Spirit Sword yet where to start.
; In: X = D = the child.
; Out: RTL after COP 86.
; Clobbers: A.

mc_npc_soldier_ghost_hint_arrival_023FC9 {
    COP [18] ( #06, &code_023FD1 )

  loc_023FCE:
    COP [86]
    RTL 
}

code_023FD1 {
    COP [01] ( &asciistring_023FD7 )
    BRA loc_023FCE
}

asciistring_023FD7 |[10][0E:3C][JMP:&asciistring_023FDD+M]|

asciistring_023FDD |[10][::]There are many [N]ghosts in the torture [N]room of the basement- [FIN]First, [N]look for the Spirit [N]Sword- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; The soldier who is the nephew of the architect Gaudi (switch $15A).
; 
; When: placement script (type $19, tile ($11,$20)); COP 14 returns until lair record $15A (3 Wraithes of location $66) is released.
; Sees: with flag $0806 clear, puff, blocked tiles and the first speech ('My uncle is the famous architect Gaudi. I know a bit about architecture. I will show you something later.'), which sets flag $0806; afterwards the second text 'What do you think about the wall? I am known as a "speed" architect.'
; Why: flavour only; the walkthrough does not mention him and he gives nothing.
; In: X = D = slot $03.
; Out: RTL.
; Clobbers: A.

mc_npc_soldier_gaudi_nephew_024027 {
    COP [14] ( #$015A, &code_02402E )
    RTL 
}

code_02402E {
    COP [07] ( #$8806, &code_024042 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02404B )
    COP [15]
    COP [91]
    RTL 
}

code_024042 {
    COP [17] ( &code_024054 )
    COP [15]
    COP [91]
    RTL 
}

code_02404B {
    COP [01] ( &asciistring_024059 )
    COP [09] ( #$8806 )
    RTL 
}

code_024054 {
    COP [01] ( &asciistring_0240AC )
    RTL 
}

asciistring_024059 |[10]My uncle is [N]the famous architect [N]Gaudi- [FIN]I know a bit about [N]architecture- [N]I will show you [N]something later- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0240AC |[10]What do you think [N]about the wall? [N]I am known as a [N]"speedˮ architect- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; A placed actor that does nothing.
; 
; When: placement script (type $1A, tile ($2A,$05) of A10S01, flip X); no lair, no switch.
; Sees: nothing: it returns every frame.
; Why: unknown (a removed NPC left in the placement and meta list), OQ-I039-4.
; In: X = D = slot $04.
; Out: RTL.
; Clobbers: none.

mc_npc_inert_placeholder_0240E4 {
    RTL 
}
---------------------------------------------

; The soldier who tells where the Elemental Mail is (switch $15F).
; 
; When: placement script (type $1B, tile ($1D,$13)); COP 14 returns until lair record $15F (6 Wraithes of location $67) is released; COP 30 spawns the arrival child on a return through it.
; Sees: puff, blocked tiles and the talk handler code_024101: switch $195 (King Magridd) clear: 'This is King Magridd's Castle. The King is the greatest man in the world. I must say that or I will be punished.'; set: 'I don't have to say that anymore, because the King really did become a good man.'
; Why: the soldiers speak by force until the King is freed.
; In: X = D = slot $05.
; Out: RTL.
; Clobbers: A.

mc_npc_soldier_elemental_hint_0240E5 {
    COP [14] ( #$015F, &code_0240EC )
    RTL 
}

code_0240EC {
    COP [30] ( #$015F, &mc_npc_soldier_elemental_hint_arrival_024111, #04 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_024101 )
    COP [15]
    COP [91]
    RTL 
}

code_024101 {
    COP [14] ( #$0195, &code_02410C )
    COP [01] ( &asciistring_024194 )
    RTL 
}

code_02410C {
    COP [01] ( &asciistring_0241F2 )
    RTL 
}

---------------------------------------------
; The arrival child of the Elemental Mail soldier.
; 
; When: spawned by COP 30 on a return through lair record $15F.
; Sees: 'Thank you very much. There are many thorns in the basement. If you free the soldier right in front of where I have been captured, you will receive the Elemental Mail.' then the child ends.
; Why: the walkthrough only names the sleeper; this hint links the two.
; In: X = D = the child.
; Out: RTL after COP 86.
; Clobbers: A.

mc_npc_soldier_elemental_hint_arrival_024111 {
    COP [01] ( &asciistring_024118 )
    COP [86]
    RTL 
}

asciistring_024118 |[10][0E:3C]Thank you very much- [FIN]There are many thorns [N]in the basement- [FIN]If you free the [N]soldier right in front[N]of where I have been [N]captured, [FIN]you will receive [N]the Elemental Mail- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024194 |[10]This is King Magridd s[N]Castle- [FIN]The King is the [N]greatest man in the [N]world- [FIN][0A]I█must█say█that█or[N]I█will█be█punished-[JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0241F2 |[10]This is the Castle of [N]King Magridd- [FIN]The King is the [N]greatest man in the [N]world- [FIN]I don t have to say [N]that anymore, because [N]the King really did [N]become a good man- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; The sleeping soldier who gives the Elemental Mail (switch $161).
; 
; When: placement script (type $1C, tile ($01,$1E)); COP 14 returns until lair record $161 (2 Wraithes of location $67) is released.
; Sees: puff, animation $12 (lying), blocked tiles. Talking with the Dream Rod ($1C) equipped: '<name> placed the Dream Rod upon the soldier's head.' and a scene change to the soldier's dream (A13S03). Back in the town with flag $0803 set and the hero on tile ($02,$1F): the wake-up ('Oops! I was sleeping. Lately I have been having the same dream as Dr-Leo...'), the Elemental Mail and flag $0804. Without the rod: 'Zzzz'. Afterwards: 'I have a feeling that you will change the world.'
; Why: the walkthrough: 'Equip the Dream Rod and then speak with him. After a rather thought-provoking scene, you will be given the Elemental Armor.' The ROM item name is Elemental Mail (OQ-I039-1).
; In: X = D = slot $07.
; Out: the buttons are blocked with $joy_block_mask during the wake-up and released at the end.
; Clobbers: A.

mc_npc_soldier_elemental_mail_024259 {
    COP [14] ( #$0161, &code_024260 )
    RTL 
}

code_024260 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [07] ( #$8804, &code_0242AE ) ; flag $0804 (persistent): the Elemental Mail has been given; bit 15 set = jump when set
    COP [17] ( &code_0242BC )
    COP [15]
    COP [91]
    COP [0D] ( #00, #02, #1F, &code_02427B )
    RTL 
}

code_02427B {
    COP [07] ( #$0803, &code_0242B9 ) ; flag $0803 (set at the end of the soldier's dream): clear = skip, set = the sleeper wakes up now
    COP [17] ( #$0000 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #2C )
    COP [82]
    COP [2B] ( #$FFF0, #$0000 )
    COP [01] ( &asciistring_024316 )
    BRK #$5E
    COP [0A] ( #0F )      ; item $0F = the Elemental Mail
    COP [09] ( #$8804 )
    LDA #$2F80
    TRB $joy_block_mask
}

code_0242AE {
    COP [80] ( #12 )
    COP [82]
    COP [17] ( &code_0242DD )
    COP [15]
}

code_0242B9 {
    COP [91]
    RTL 
}

code_0242BC {
    COP [07] ( #$8804, &code_0242DD )
    COP [19] ( #1C, &code_0242D8 ) ; item $1C = the Dream Rod; jumps when it is not equipped
    COP [01] ( &asciistring_0242EB )
    COP [3C] ( #04 )
    COP [10] ( #$0313, #01, #$0150, #$01A0 ) ; area $13 scene $03: A13S03 (a soldier's dream) at pixel ($0150,$01A0)
    RTL 
}

code_0242D8 {
    COP [01] ( &asciistring_0242E2 )
    RTL 
}

code_0242DD {
    COP [01] ( &asciistring_0243E7 )
    RTL 
}

asciistring_0242E2 |[10]Zzzz [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0242EB |[10][02:2] placed the [N]Dream Rod upon the [N]soldier s head- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024316 |[10]Oops! I was sleeping- [FIN]Lately I have been [N]having the same dream [N]as Dr-Leo- [FIN]If I would have [N]released Dr-Leo, [N]the world would not be[N]like this- [FIN]I don t know who to [N]obey anymore! [FIN]There are many thorns [N]in the basement of [N]Magridd Castle- [FIN]You must take this [N]armor with you- [FIN][02:2] received [N][03:24]the Elemental Mail- [03:20][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0243E7 |[10]I have a feeling that [N]you will change the [N]world- [N]Good luck! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; The castle guard who paces back and forth (switch $162).
; 
; When: placement script (type $1D, tile ($1F,$20)); COP 14 returns until lair record $162 (2 Wraithes of location $67) is released.
; Sees: animations $17-$12 in a fixed walk cycle ($1F frames each), flipped now and then; talk: 'I am guarding the castle. Don't talk to me.'
; Why: ambience.
; In: X = D = slot $08.
; Out: endless loop (BRL to the cycle start).
; Clobbers: A.

mc_npc_soldier_guard_patrol_024416 {
    COP [14] ( #$0162, &code_02441D )
    RTL 
}

code_02441D {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0244C5 )

  loc_024426:
    COP [97]
    COP [81] ( #17, #08 )
    COP [83]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #13 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #12 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [81] ( #15, #0B )
    COP [83]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #12 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [96]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [81] ( #17, #10 )
    COP [83]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #13 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [81] ( #16, #0B )
    COP [83]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #13 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [97]
    COP [80] ( #14 )
    COP [82]
    COP [03] ( #1F )
    COP [04]
    COP [81] ( #17, #08 )
    COP [83]
    BRL loc_024426
}

code_0244C5 {
    COP [01] ( &asciistring_0244CA )
    RTL 
}

asciistring_0244CA |[10]I am guarding [N]the castle- [N]Don t talk to me- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; A soldier whose speech depends on the King (switch $166).
; 
; When: placement script (type $1E, tile ($21,$13)); COP 14 returns until lair record $166 (2 Bouncing Balls of location $67) is released.
; Sees: puff, blocked tiles, talk: switch $195 clear: 'This is King Magridd's Castle. Our King is the greatest man in the world. I must say this or I will be punished.'; set: 'I think he is in shock after losing the Queen.'
; In: X = D = slot $09.
; Out: RTL.
; Clobbers: A.

mc_npc_soldier_king_shock_0244EF {
    COP [14] ( #$0166, &code_0244F6 )
    RTL 
}

code_0244F6 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_024504 )
    COP [15]
    COP [91]
    RTL 
}

code_024504 {
    COP [14] ( #$0195, &code_02450F )
    COP [01] ( &asciistring_024514 )
    RTL 
}

code_02450F {
    COP [01] ( &asciistring_024575 )
    RTL 
}

asciistring_024514 |[10]This is King [N]Magridd s Castle- [FIN]Our King is the [N]greatest man in the [N]world- [FIN][0A]I█must█say█this█or[N]I█will█be█punished-[JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024575 |[10]I think he is in shock[N]after losing the [N]Queen- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; The singer of the theater: she needs a harp string, then plays (switch $167).
; 
; When: placement script (type $1F, tile ($08,$27)); COP 14 returns until lair record $167 (3 Wraithes of location $67) is released; COP 30 spawns the arrival child on a return through it.
; Sees: animation $1B; talk handler code_0245CB: flag $0703 set: the story ('Thank you very much for coming. Before I play some music let me tell you my story. I fell in love just once in my 24 years ... a mine town, Grass Valley ... The girl's name was something like Lisa. The music I am going to play now is a song that I wrote for her.') and the play sequence; no Harp string equipped ($1A): 'I want to play music, but the harp string is broken.'; with it: 'Oh! That is a harp string. I promise to use it carefully if you give it to me.' and the Yes / No menu (L_choice_result). Yes: flag $0703, 'Thank you very much. Please sit and listen to my music.' and the item is taken (COP 0B). No: 'It seems important to you.'
; Why: the song that Lisa's admirer wrote; the walkthrough: 'Also go north and run into the fallen skeleton to get a Harp String', then 'speak with the singer'.
; In: X = D = slot $0A.
; Out: after the play sequence mc_npc_singer_theater_play_0245B3 loops forever.
; Clobbers: A.

mc_npc_singer_theater_harp_024597 {
    COP [14] ( #$0167, &code_02459E )
    RTL 
}

code_02459E {
    COP [30] ( #$0167, &mc_npc_singer_theater_arrival_024615, #04 )
    COP [17] ( &code_0245CB )
    COP [15]
    COP [80] ( #1B )
    COP [82]
    COP [91]
    RTL 
}

---------------------------------------------
; The singer plays.
; 
; When: entered from the talk handler (COP 27) once the string is handed over or flag $0703 was already set.
; Sees: animation $1C, the music of track $12 (COP 31, a fade and load), a COP 03 / 04 loop of $79 frames, flag $0001 set (the theater guard waits for it), then animation $1D forever.
; Why: the performance is what makes the theater guard move to the front row (mc_npc_soldier_theater_guard_024BC8) and free the Platinum Card.
; In: X = D = slot $0A.
; Out: never returns.
; Clobbers: A.

mc_npc_singer_theater_play_0245B3 {
    COP [80] ( #1C )
    COP [82]
    COP [31] ( #12 )      ; track $12 of MusicPointerTable (fade and load)
    COP [03] ( #79 )
    COP [04]
    COP [09] ( #$8001 )   ; flag $0001: the performance has started; the theater guard waits for it

  loc_0245C4:
    COP [80] ( #1D )
    COP [82]
    BRA loc_0245C4
}

code_0245CB {
    COP [07] ( #$8703, &code_0245FF )
    COP [19] ( #1A, &code_024610 ) ; item $1A = the Harp string; jumps when it is not equipped
    COP [01] ( &asciistring_02480A )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_0245FA )
    LDA $L_choice_result
    BNE code_0245FA
    COP [09] ( #$8703 )
    COP [01] ( &asciistring_02484C )
    COP [0B] ( #1A )
    COP [17] ( &code_02460B )
    COP [27] ( &mc_npc_singer_theater_play_0245B3 )
}

code_0245FA {
    COP [01] ( &asciistring_024871 )
    RTL 
}

code_0245FF {
    COP [01] ( &asciistring_024676 )
    COP [17] ( &code_02460B )
    COP [27] ( &mc_npc_singer_theater_play_0245B3 )
}

code_02460B {
    COP [01] ( &asciistring_02479E )
    RTL 
}

code_024610 {
    COP [01] ( &asciistring_0247DE )
    RTL 
}

---------------------------------------------
; The arrival child of the singer.
; 
; When: spawned by COP 30 on a return through lair record $167.
; Sees: 'A sad sounding voice is coming from the theater. Oh, what can I do? I can't play a harp without strings.' then the child ends.
; Why: hints at the harp string (Castle Dungeon Part 1).
; In: X = D = the child.
; Out: RTL after COP 86.
; Clobbers: A.

mc_npc_singer_theater_arrival_024615 {
    COP [01] ( &asciistring_02461C )
    COP [86]
    RTL 
}

asciistring_02461C |[10][0E:3C]A sad sounding voice [N]is coming from the [N]theater- [FIN]Oh, what can I do? [N]I can t play a harp [N]without strings- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024676 |[10][::]Thank you very [N]much for coming- [FIN]Before I play some [N]music let me tell you [N]my story- [FIN]I fell in love just [N]once in my 24 years- [FIN]It was when I visited [N]a mine town, [N]Grass Valley- [FIN]When I was injured, [N]there was a girl who [N]took care of me- [FIN]I couldn t tell her [N]my true feelings [N]though-------- [FIN]The girl s name was [N]something like Lisa- [FIN]The music I am going [N]to play now is a song [N]that I wrote for her- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_02479E |[10]There are no words- [FIN]I hope someday someone[N]will be able to put [N]words to my music- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0247DE |[10]I want to play music, [N]but the harp string [N]is broken- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_02480A |[10]Oh! [N]That is a harp string-[FIN]I promise to use it [N]carefully if you give [N]it to me- [END]|

asciistring_02484C |Thank you very much- [N]Please sit and [N]listen to my music- [FIN][JMP:&asciistring_024676+M]|

asciistring_024871 |It seems important [N]to you- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; A soldier who warns about a traitor (switch $168).
; 
; When: placement script (type $20, tile ($05,$2C)); COP 3B holds the actor (cm_npc_captive_plea_02229E + HoldActorUntilReleased) until lair record $168 (4 Skeleton Soldiers of location $67, gate word $0167) is released.
; Sees: puff, blocked tiles, talk: switch $195 clear: 'One of the soldiers betrayed the King! He is trying to escape with Dr-Leo.'; set: 'The Queen passed away? King Magridd must be in shock! He did everything he could to save the Queen.'
; In: X = D = slot $0B.
; Out: RTL.
; Clobbers: A.

mc_npc_soldier_traitor_warning_02488E {
    COP [3B] ( #$0168, &code_0248A4 )
    COP [17] ( &shared_actor_helpers_bank4.cm_npc_captive_plea_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0248A4 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0248B2 )
    COP [15]
    COP [91]
    RTL 
}

code_0248B2 {
    COP [14] ( #$0195, &code_0248BD )
    COP [01] ( &asciistring_0248C2 )
    RTL 
}

code_0248BD {
    COP [01] ( &asciistring_024904 )
    RTL 
}

asciistring_0248C2 |[10]One of the soldiers [N]betrayed the King! [N]He is trying to [N]escape with Dr-Leo- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024904 |[10]The Queen passed away?[FIN]King Magridd must be [N]in shock! [FIN]He did everything he [N]could to save the [N]Queen- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; Queen Magridd: the VIP Card, later the Super Bracelet (switch $17F).
; 
; When: placement script (type $21, tile ($36,$17)); COP 14 returns until lair record $17F (4 Red Knights of location $6B) is released; COP 30 spawns the arrival child.
; Sees: with flag $0805 clear: animation $0C, or $0D when flag $0000 is set, talk handler code_02499F: VIP Card ($29) missing: 'I am the wife of King Magridd. Do you think I am pretty?' with the Yes / No menu; Yes: 'This is my present to you. The Queen put something in <name>'s pocket.', BRK $5E, item $29 and flag $0000 cleared; No (or cancel): '---------' and flag $0000 set (the idle loop then plays animation $0D instead of $0C); owned: 'Do you like it? You may go wherever you want within the Magridd Castle.' After the dock scene (flag $0805) she is gone (mc_npc_queen_gone_bracelet_024978).
; Why: walkthrough: 'If you think she is pretty, she'll hand over a VIP Card, letting you go into the Right Tower'.
; In: X = D = slot $0C.
; Out: RTL.
; Clobbers: A.

mc_npc_queen_vip_card_02494A {
    COP [14] ( #$017F, &code_024951 )
    RTL 
}

code_024951 {
    COP [30] ( #$017F, &mc_npc_queen_arrival_0249D1, #04 )
    COP [07] ( #$8805, &mc_npc_queen_gone_bracelet_024978 )
    COP [17] ( &code_02499F )
    COP [15]

  loc_024964:
    COP [07] ( #$8000, &code_024971 )
    COP [80] ( #0C )
    COP [82]
    BRA loc_024964
}

code_024971 {
    COP [80] ( #0D )
    COP [82]
    BRA loc_024964
}

---------------------------------------------
; The Queen's tile after she is gone: the Super Bracelet.
; 
; When: flag $0805 set (the dock scene played).
; Sees: the Queen is hidden ($16 bit $2000); if the Super Bracelet ($37) is missing the actor stays; when the hero stands on tile ($36,$17): '<name> found the Invulnerable Bracelet where the Queen was standing.' with BRK $5E and item $37. Otherwise the actor ends.
; Why: walkthrough: 'stand to the west of the stool ... you will receive the Invulnerable Bracelet ... or, rather, the Super Bracelet'; the ROM text and the item list disagree (OQ-I039-2).
; In: X = D = the Queen's slot.
; Out: RTL.
; Clobbers: A.

mc_npc_queen_gone_bracelet_024978 {
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [18] ( #37, &code_024989 ) ; item $37 = the Super Bracelet; jumps when the hero has it
    COP [86]
    RTL 
}

code_024989 {
    COP [91]
    COP [0D] ( #00, #36, #17, &code_024993 )
    RTL 
}

code_024993 {
    COP [01] ( &asciistring_024AB6 )
    BRK #$5E
    COP [0A] ( #37 )
    COP [91]
    RTL 
}

code_02499F {
    COP [18] ( #29, &code_0249A9 ) ; item $29 = the VIP Card; jumps when the hero has none
    COP [01] ( &asciistring_024A76 )
    RTL 
}

code_0249A9 {
    COP [01] ( &asciistring_024A21 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_0249C8 )
    LDA $L_choice_result
    BNE code_0249C8
    COP [01] ( &asciistring_024A47 )
    BRK #$5E
    COP [0A] ( #29 )
    COP [09] ( #$0000 )
    RTL 
}

code_0249C8 {
    COP [01] ( &asciistring_024AA8 )
    COP [09] ( #$8000 )
    RTL 
}

---------------------------------------------
; The arrival child of the Queen.
; 
; When: spawned by COP 30 on a return through lair record $17F.
; Sees: 'I do not know who you are, but thank you very much for releasing me. I will give you a gift if you come back.' then the child ends.
; In: X = D = the child.
; Out: RTL after COP 86.
; Clobbers: A.

mc_npc_queen_arrival_0249D1 {
    COP [01] ( &asciistring_0249D8 )
    COP [86]
    RTL 
}

asciistring_0249D8 |[10][0E:3C]I do not know who you [N]are, but thank you [N]very much for [N]releasing me- [FIN]I will give you a gift[N]if you come back- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024A21 |[10]I am the wife of King [N]Magridd- Do you think [N]I am pretty? [END]|

asciistring_024A47 |This is my present to [N]you- [FIN]The Queen put [N]something in [N][02:2] S pocket- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024A76 |[10]Do you like it? [N]You may go wherever [N]you want within the [N]Magridd Castle- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024AA8 |[10]--------- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024AB6 |[10][02:2] found [03:24]the [N]Invulnerable Bracelet [N][03:20]where the Queen was [N]standing- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; The guard of the Left Tower prison floor (switch $16D).
; 
; When: placement script (type $22, tile ($02,$09)); COP 14 returns until lair record $16D (2 Bouncing Balls of location $68) is released. Flag $0805 set: the guard ends at once.
; Sees: puff, blocked tiles. Without the Platinum Card equipped ($28): 'The top floor of this tower is a prison. Anyone who does not have the Platinum Card cannot enter.' With it: 'Oh, that is the Platinum Card, I am sorry. Please go inside.' and flag $0607; the guard then unblocks his tiles (COP 16) and steps aside (animations $17, $14).
; Why: walkthrough: 'Once in, re-equip whatever item you were holding before the Platinum Card'.
; In: X = D = slot $0D.
; Out: RTL.
; Clobbers: A.

mc_npc_soldier_platinum_gate_guard_024AF4 {
    COP [14] ( #$016D, &code_024AFB )
    RTL 
}

code_024AFB {
    COP [07] ( #$8805, &code_024B29 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_024B2C )
    COP [15]
    COP [05] ( #$0607 )
    COP [17] ( &code_024B3F )
    COP [16]
    COP [96]
    COP [80] ( #17 )
    COP [82]
    COP [97]
    COP [80] ( #14 )
    COP [82]
    COP [15]
    COP [91]
    RTL 
}

code_024B29 {
    COP [86]
    RTL 
}

code_024B2C {
    COP [19] ( #28, &code_024B3A ) ; item $28 = the Platinum Card; jumps unless it is equipped
    COP [01] ( &asciistring_024B98 )
    COP [09] ( #$8607 )
    RTL 
}

code_024B3A {
    COP [01] ( &asciistring_024B44 )
    RTL 
}

code_024B3F {
    COP [01] ( &asciistring_024B94 )
    RTL 
}

asciistring_024B44 |[10]The top floor of this [N]tower is a prison- [FIN]Anyone who does not [N]have the Platinum Card[N]cannot enter- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024B94 |[10][JMP:&asciistring_024B98+M]|

asciistring_024B98 |[10]Oh, that is the [N]Platinum Card, I am [N]sorry- [FIN][::]Please go inside- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; The guard who stands on the Platinum Card (switch $170).
; 
; When: placement script (type $23, tile ($0B,$30)); COP 3B holds the actor until lair record $170 (6 Wraithes of location $68, gate word $0167) is released. Flag $0805 set: the guard ends.
; Sees: before the performance: 'I am a guard. But I am tired of my job. I came here to relax.' and the narration that a card lies under his feet. With the card ($28) not owned the guard spawns mc_obj_platinum_card_pickup_024C32; in both cases he waits for flag $0001 (the singer plays), unblocks his tiles (COP 16), plays animations $17 and $16 (he leaves the spot) and then says 'I love listening to music from the front row. Please do not bother me.'
; Why: walkthrough: the guard stands on the shiny card until the singer plays.
; In: X = D = slot $0E.
; Out: RTL.
; Clobbers: A.

mc_npc_soldier_theater_guard_024BC8 {
    COP [3B] ( #$0170, &code_024BDE )
    COP [17] ( &shared_actor_helpers_bank4.cm_npc_captive_plea_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_024BDE {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [07] ( #$8805, &code_024C20 )
    COP [17] ( &code_024C23 )
    COP [18] ( #28, &code_024BF8 )
    COP [17] ( &code_024C2D )
    BRA loc_024BFF
}

code_024BF8 {
    COP [B0] ( @mc_obj_platinum_card_pickup_024C32, #$2000 )

  loc_024BFF:
    COP [15]
    COP [05] ( #$0001 )
    COP [16]
    COP [17] ( #$0000 )
    COP [81] ( #17, #02 )
    COP [83]
    COP [81] ( #16, #03 )
    COP [83]
    COP [17] ( &code_024C28 )
    COP [15]
    COP [91]
    RTL 
}

code_024C20 {
    COP [86]
    RTL 
}

code_024C23 {
    COP [01] ( &asciistring_024C48 )
    RTL 
}

code_024C28 {
    COP [01] ( &asciistring_024CDF )
    RTL 
}

code_024C2D {
    COP [01] ( &asciistring_024D1B )
    RTL 
}

---------------------------------------------
; The Platinum Card on the theater floor.
; 
; When: spawned (COP B0, flags $2000) by the theater guard while the card is missing.
; Sees: when the hero (slot 0) stands on tile ($0B,$30): '<name> found a card.' with BRK $5E and item $28.
; In: X = D = the spawned actor.
; Out: ends after the item.
; Clobbers: A.

mc_obj_platinum_card_pickup_024C32 {
    COP [91]
    COP [0D] ( #00, #0B, #30, &code_024C3C )
    RTL 
}

code_024C3C {
    COP [01] ( &asciistring_024D45 )
    BRK #$5E
    COP [0A] ( #28 )      ; item $28 = the Platinum Card
    COP [86]
    RTL 
}

asciistring_024C48 |[10]I am a guard- [N]But I am tired of my [N]job- [N]I came here to relax- [FIN][0F]While listening to the[N]guard, [02:2] sees a[N]card under the guard s[N]feet- [FIN]But [02:2] can t [N]get it because the [N]guard is standing on [N]it- [0F][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024CDF |[10]I love listening to [N]music from the front [N]row- [FIN]Please do not bother [N]me- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024D1B |[10]I am a guard, [N]I am tired of my job- [N]I came here to relax- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024D45 |[10][02:2] found [N][03:24]a card- [03:20][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; The singer who tells about her friend (switch $172).
; 
; When: placement script (type $24, tile ($3C,$37)); COP 14 returns until lair record $172 (4 Wraithes of location $68) is released.
; Sees: the story: 'I have a friend who once disobeyed King Magridd, he wanted to save Dr-Leo. He was taken to the torture room in the first basement and never came back. This harp string is a birthday present from my friend. I am able to play great music with this string.'
; Why: it explains where the Harp string came from (the skeleton in the torture chamber).
; In: X = D = slot $0F.
; Out: RTL.
; Clobbers: A.

mc_npc_singer_friend_story_024D59 {
    COP [14] ( #$0172, &code_024D60 )
    RTL 
}

code_024D60 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_024D6E )
    COP [15]
    COP [91]
    RTL 
}

code_024D6E {
    COP [01] ( &asciistring_024D73 )
    RTL 
}

asciistring_024D73 |[10]I have a friend who [N]once disobeyed King [N]Magridd- He wanted to [N]save Dr-Leo- [FIN]He was taken to the [N]torture room in the [N]first basement and [N]never came back- [FIN]"This harp string is a[N]birthday present from [N]my friend- [FIN]I am able to play [N]great music with this [N]string-ˮ [FIN]He always told me I [N]could- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; The maid who reads minds and gives a Medical Herb (switch $187).
; 
; When: placement script (type $25, tile ($3B,$2F)); COP 14 returns until lair record $187 (4 Chess Knights of location $6D) is released.
; Sees: the hero on tile ($39,$2F): 'You want Medical Herbs, don't you?' with the Yes / No menu; Yes and no herb ($38): 'See? I have the ability to read peoples' minds. Here I will give you one.' with BRK $5E and item $38; Yes with one owned: 'Hey, you already have one.'; No: 'Oh, I guess my ability is not perfect.'
; Why: a free herb whenever the hero has none.
; In: X = D = slot $10.
; Out: loops to the tile test (code_024E64).
; Clobbers: A.

mc_npc_maid_medical_herb_024E53 {
    COP [14] ( #$0187, &code_024E5A )
    RTL 
}

code_024E5A {
    COP [91]
    COP [0D] ( #00, #39, #2F, &code_024E70 )
    RTL 
}

code_024E64 {
    COP [91]
    COP [0D] ( #00, #39, #2F, &code_024E6F )
    BRA code_024E5A
}

code_024E6F {
    RTL 
}

code_024E70 {
    COP [01] ( &asciistring_024E9D )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_024E97 )
    LDA $L_choice_result
    BNE code_024E97
    COP [18] ( #38, &code_024E8C ) ; item $38 = Medical Herb; jumps when the hero has none
    COP [01] ( &asciistring_024F0E )
    BRA code_024E64
}

code_024E8C {
    COP [01] ( &asciistring_024EB9 )
    BRK #$5E
    COP [0A] ( #38 )
    BRA code_024E64
}

code_024E97 {
    COP [01] ( &asciistring_024F27 )
    BRA code_024E64
}

asciistring_024E9D |[10]You want Medical Herbs[N]don t you? [END]|

asciistring_024EB9 |[10]See? [N]I have the ability to [N]read peoples  minds- [FIN]Here I will give you [N]one- [FIN][02:2] received [N][03:24]a Medical Herb- [03:20][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024F0E |[10]Hey, you already have [N]one- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_024F27 |[10]Oh, I guess my ability[N]is not perfect- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; A maid who thinks about music (switch $17E).
; 
; When: placement script (type $26, tile ($09,$2C)); COP 3B holds her until lair record $17E (2 Bronze Robots of location $6B, gate word $0167) is released.
; Sees: puff, blocked tiles, talk: 'Music is really strange. The same music sometimes sounds very wonderful when I am happy and sad when I am depressed.'
; Why: the walkthrough: 'The southern one has some more Red Knights while the northern one has some Bronze Robots. Respectively, you'll release Queen Magridd and a maid.'
; In: X = D = slot $11.
; Out: RTL.
; Clobbers: A.

mc_npc_maid_music_listener_024F4A {
    COP [3B] ( #$017E, &code_024F60 )
    COP [17] ( &shared_actor_helpers_bank4.cm_npc_captive_plea_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_024F60 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_024F6E )
    COP [15]
    COP [91]
    RTL 
}

code_024F6E {
    COP [01] ( &asciistring_024F73 )
    RTL 
}

asciistring_024F73 |[10]Music is really [N]strange- [FIN]The same music [N]sometimes sounds very [N]wonderful when I am [N]happy [FIN]and sad when I am [N]depressed- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; The maid of the soldiers' dormitory (switch $16B).
; 
; When: placement script (type $27, tile ($1A,$2C)); COP 14 returns until lair record $16B (5 Wraithes of location $68) is released.
; Sees: talk: 'This is the soldiers' dormitory. I am taking care of them.' Once the soldier of switch $185 is released (COP 14) she moves by (+$10,+$30) next to him, faces him and, when the hero is on tile ($1C,$33), says 'Oh, I was just removing a speck of dust from his eye.' and waits a moment.
; Why: a small joke with mc_npc_soldier_dust_in_eye_025AAA.
; In: X = D = slot $12.
; Out: RTL.
; Clobbers: A.

mc_npc_maid_dormitory_dust_024FD3 {
    COP [14] ( #$016B, &code_024FDA )
    RTL 
}

code_024FDA {
    COP [14] ( #$0185, &code_024FE9 )
    COP [17] ( &code_025015 )
    COP [15]
    COP [91]
    RTL 
}

code_024FE9 {
    COP [A1] ( #$0010, #$0030 )
    COP [17] ( &code_02501A )
    COP [96]
    COP [80] ( #0E )
    COP [82]
    COP [15]
    COP [91]
    COP [0D] ( #00, #1C, #33, &code_025006 )
    RTL 
}

code_025006 {
    COP [03] ( #05 )
    COP [04]
    COP [97]
    COP [80] ( #0E )
    COP [82]
    COP [91]
    RTL 
}

code_025015 {
    COP [01] ( &asciistring_02501F )
    RTL 
}

code_02501A {
    COP [01] ( &asciistring_025053 )
    RTL 
}

asciistring_02501F |[10]This is the [N]soldiers  dormitory- [FIN]I am taking care of [N]them- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025053 |[10]Oh, I was just [N]removing a speck of [N]dust from his eye- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; The guard of the Right Tower (switch $182).
; 
; When: placement script (type $28, tile ($3D,$09)); COP 14 returns until lair record $182 (2 Red Knights of location $6C) is released. Flag $0805 set: the guard ends.
; Sees: without the VIP Card equipped ($29): 'This tower is connected to the airship's dock at the top floor. Anyone without a VIP card cannot get in.'; with it: 'Oh, that is the VIP card. I am very sorry. Please come in.' and flag $0700; the guard then unblocks his tiles and steps aside (animations $17, $14).
; Why: walkthrough: 'you need to equip the VIP Card to enter'.
; In: X = D = slot $13.
; Out: RTL.
; Clobbers: A.

mc_npc_soldier_vip_gate_guard_025080 {
    COP [14] ( #$0182, &code_025087 )
    RTL 
}

code_025087 {
    COP [07] ( #$8805, &code_0250B5 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0250B8 )
    COP [15]
    COP [05] ( #$0700 )
    COP [17] ( &code_0250CB )
    COP [16]
    COP [97]
    COP [80] ( #17 )
    COP [82]
    COP [96]
    COP [80] ( #14 )
    COP [82]
    COP [15]
    COP [91]
    RTL 
}

code_0250B5 {
    COP [86]
    RTL 
}

code_0250B8 {
    COP [19] ( #29, &code_0250C6 ) ; item $29 = the VIP Card; jumps unless it is equipped
    COP [01] ( &asciistring_025133 )
    COP [09] ( #$8700 )
    RTL 
}

code_0250C6 {
    COP [01] ( &asciistring_0250D0 )
    RTL 
}

code_0250CB {
    COP [01] ( &asciistring_02512F )
    RTL 
}

asciistring_0250D0 |[10]This tower is [N]connected to the [N]airship s dock at the [N]top floor- [FIN]Anyone without a VIP [N]card cannot get in- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_02512F |[10][JMP:&asciistring_025133+M]|

asciistring_025133 |[10]Oh, that is the VIP [N]card- [N]I am very sorry- [N][::]Please come in- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; A soldier who saw something shiny (switch $186).
; 
; When: placement script (type $29, tile ($2A,$2D)); COP 3B holds him until lair record $186 (2 Red Knights of location $6D, gate word $0179) is released.
; Sees: talk: 'I find a great many things wandering around. I have seen something shiny around the castle. But I did not pick up.'
; Why: a hint at the Super Bracelet / the Platinum Card on the floor.
; In: X = D = slot $14.
; Out: RTL.
; Clobbers: A.

mc_npc_soldier_shiny_hint_02515B {
    COP [3B] ( #$0186, &code_025171 )
    COP [17] ( &shared_actor_helpers_bank4.cm_npc_captive_plea_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_025171 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02517F )
    COP [15]
    COP [91]
    RTL 
}

code_02517F {
    COP [01] ( &asciistring_025184 )
    RTL 
}

asciistring_025184 |[10]I find a great [N]many things wandering [N]around- [FIN]I have seen something [N]shiny around the [N]castle- [FIN]But I did not pick up-[JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; The soldier who is the Soul of Reality (switch $179).
; 
; When: placement script (type $2A, tile ($23,$2F), flip X); COP 14 returns until lair record $179 (3 Red Knights of location $6A) is released; COP 30 spawns the arrival child.
; Sees: with flag $0604 clear: talk handler code_025203: 'Even though I don't look like it, I am from the sky just like you. I know all of the invisible passages in the Magridd Castle. Would you like to walk the basement with me? The soul that knows the castle's secret passages joins you!', BRK $4E, flag $0604 set and souls_flags |= $10. With $0604 set: the actor puffs and ends.
; Why: walkthrough: 'You wouldn't otherwise be able to find this without the Soul of Reality.' (the invisible Emblem B).
; In: X = D = slot $15.
; Out: RTL.
; Clobbers: A.

mc_npc_soldier_soul_of_reality_0251DC {
    COP [14] ( #$0179, &code_0251E3 )
    RTL 
}

code_0251E3 {
    COP [30] ( #$0179, &mc_npc_soldier_soul_of_reality_arrival_02521A, #04 )
    COP [17] ( &code_025203 )
    COP [15]
    COP [91]
    COP [07] ( #$8604, &code_0251F9 )
    RTL 
}

code_0251F9 {
    COP [16]
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [86]
    RTL 
}

code_025203 {
    COP [01] ( &asciistring_025266 )
    BRK #$4E
    COP [09] ( #$8604 )
    SEP #$20
    LDA $souls_flags
    ORA #$10              ; souls_flags bit $10 = the Soul of Reality
    STA $souls_flags
    REP #$20
    RTL 
}

---------------------------------------------
; The arrival child of the Soul of Reality soldier.
; 
; When: spawned by COP 30 on a return through lair record $179.
; Sees: 'Someone is calling <name> from the house. I know everything about the Magridd Castle. I will help you when you come back.' then the child ends.
; In: X = D = the child.
; Out: RTL after COP 86.
; Clobbers: A.

mc_npc_soldier_soul_of_reality_arrival_02521A {
    COP [01] ( &asciistring_025221 )
    COP [86]
    RTL 
}

asciistring_025221 |[10][0E:3C]Someone is calling [N][02:2] from the [N]house- [FIN]I know everything [N]about the Magridd [N]Castle- [FIN]I will help you when [N]you come back- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025266 |[10]Even though I don t [N]look like it, [N]I am from the sky just[N]like you- [FIN]I know all of the [N]invisible passages in [N]the Magridd Castle- [FIN]Would you like to walk[N]the basement with me? [FIN]The soul that [N]knows the castle s [N]secret passages joins [N]you! [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; The soldier who wants to be king and drops Emblem H (switch $18C).
; 
; When: placement script (type $2B, tile ($1F,$0D)); COP 14 returns until lair record $18C (4 Chess Knights of location $6D) is released.
; Sees: switch $195 clear: 'If King Magridd doesn't come back, then I will be crowned the next King. He, he, he.'; set: he moves left by $10 and says 'King Magridd is back. Please do not tell anybody what I have said to you.' When the hero stands on tile ($25,$0C) and flag $1A07 is clear: '<name> found the Master's Emblem H.', BRK $5E, item $31 (Emblem H), flag $1A07.
; Why: walkthrough chapter: the Master's Emblem H of the castle.
; In: X = D = slot $16.
; Out: RTL.
; Clobbers: A.

mc_npc_soldier_emblem_h_025302 {
    COP [14] ( #$018C, &code_025309 )
    RTL 
}

code_025309 {
    COP [14] ( #$0195, &code_02531C )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02534D )
    COP [15]
    BRA loc_02532D
}

code_02531C {
    COP [17] ( &code_025352 )
    COP [9F] ( #$FFF0 )
    COP [15]
    COP [96]
    COP [80] ( #14 )
    COP [82]

  loc_02532D:
    COP [91]
    COP [0D] ( #00, #25, #0C, &code_025337 )
    RTL 
}

code_025337 {
    COP [07] ( #$9A07, &code_02534A ) ; flag $1A07 (persistent): Emblem H taken; bit 15 set = jump when set
    COP [01] ( &asciistring_0253C3 )
    BRK #$5E
    COP [0A] ( #31 )      ; item $31 = Emblem H
    COP [09] ( #$9A07 )
}

code_02534A {
    COP [91]
    RTL 
}

code_02534D {
    COP [01] ( &asciistring_025357 )
    RTL 
}

code_025352 {
    COP [01] ( &asciistring_025397 )
    RTL 
}

asciistring_025357 |[10]If King Magridd [N]doesn t come back, [N]then I will be crowned[N]the next King- [FIN]He, he, he- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025397 |[10]King Magridd is back- [N]Please do not tell [N]anybody what I have [N]said to you- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0253C3 |[10][02:2] found [N][03:24]the Master s Emblem H-[03:20][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; A soldier who knows about the stolen airship key (switch $18D).
; 
; When: placement script (type $2C, tile ($09,$17)); COP 14 returns until lair record $18D (1 Bronze Robot of location $6E) is released.
; Sees: switch $195 clear: 'The key to the airship has been stolen! I don't know what is going to happen.'; set: 'There appears to be a fight on the airship's dock. It seems some of my friends have passed away. I hate being a soldier.'
; Why: foreshadows the dock scene (Dr. Leo hands the Mobile Key to the traitors).
; In: X = D = slot $17.
; Out: RTL.
; Clobbers: A.

mc_npc_soldier_airship_key_stolen_0253E2 {
    COP [14] ( #$018D, &code_0253E9 )
    RTL 
}

code_0253E9 {
    COP [17] ( &code_0253F2 )
    COP [15]
    COP [91]
    RTL 
}

code_0253F2 {
    COP [14] ( #$0195, &code_0253FD )
    COP [01] ( &asciistring_025402 )
    RTL 
}

code_0253FD {
    COP [01] ( &asciistring_025438 )
    RTL 
}

asciistring_025402 |[10]The key to the airship[N]has been stolen! [N]I don t know what is [N]going to happen- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025438 |[10]There appears to be a [N]fight on the airship s[N]dock- [FIN]It seems some of my [N]friends have passed [N]away- [FIN]I hate being a [N]soldier- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; A soldier who admires the Medical Herb maid (switch $18F).
; 
; When: placement script (type $2D, tile ($3A,$2A), flip X); COP 3B holds him until lair record $18F (5 Chess Knights of location $6E, gate word $0187) is released.
; Sees: talk: 'Don't you think that she's a nice girl? She seems to know what people want.'
; In: X = D = slot $18.
; Out: RTL.
; Clobbers: A.

mc_npc_soldier_herb_maid_fan_0254A2 {
    COP [3B] ( #$018F, &code_0254B8 )
    COP [17] ( &shared_actor_helpers_bank4.cm_npc_captive_plea_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0254B8 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0254C6 )
    COP [15]
    COP [91]
    RTL 
}

code_0254C6 {
    COP [01] ( &asciistring_0254CB )
    RTL 
}

asciistring_0254CB |[10]Don t you think that [N]she s a nice girl- [N]She seems to know what[N]people want- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; A soldier who almost fell into the river (switch $192).
; 
; When: placement script (type $2E, tile ($28,$12)); COP 14 returns until lair record $192 (2 Red Knights of location $6F) is released.
; Sees: talk: 'Phew! You scared me! Don't sneak up behind me. I almost fell into the river.'
; In: X = D = slot $19.
; Out: RTL.
; Clobbers: A.

mc_npc_soldier_river_scare_025502 {
    COP [14] ( #$0192, &code_025509 )
    RTL 
}

code_025509 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_025517 )
    COP [15]
    COP [91]
    RTL 
}

code_025517 {
    COP [01] ( &asciistring_02551C )
    RTL 
}

asciistring_02551C |[10]Phew! You scared me! [FIN]Don t sneak up behind [N]me- I almost fell into[N]the river- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; King Magridd: the Black Stone and the ending (switch $195).
; 
; When: placement script (type $2F, tile ($1F,$03)); COP 3B holds him until lair record $195 (the Demon Falcon of location $72; gate word $018C) is released; COP 30 spawns the arrival child on a return through it.
; Sees: with flag $1F02 clear: puff, blocked tiles, a wait for flag $0007 (a scratch flag of the scene that the talk handler also sets), animation $02 and the talk handler, which shows (flag $1B05 clear) 'I have failed as a King. I ordered people to be loyal to me. And killed whomever would not follow me ... I made a promise with the evil King Deathtoll ... Simply because I thought it would impress the Queen ... I have the Black Stone with me. You must have all 6 of these now. Please go to the world of evil and defeat Deathtoll.', BRK $5E, item $3F (Black Stone), flag $1B05; afterwards 'I finally realized what was happening when the situation was at its worst.' With flag $1F02 set (RunEnding ran): the buttons are blocked, the long speech 'You finally made it! First of all, let me say thank you ... I will build statues of you and Dr-Leo in the center of town. I promise to tell every generation about your accomplishments.' and the scene change to A0DS03.
; Why: walkthrough: 'go to the stern of the ship to activate the monster lair and release King Magridd'.
; In: X = D = slot $1A.
; Out: RTL.
; Clobbers: A.

mc_npc_king_magridd_025561 {
    COP [3B] ( #$0195, &code_025577 )
    COP [17] ( &shared_actor_helpers_bank4.cm_npc_captive_plea_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_025577 {
    COP [30] ( #$0195, &mc_npc_king_magridd_arrival_0255E4, #04 )
    COP [07] ( #$9F02, &code_02559B ) ; flag $1F02: RunEnding ran (the ending is playing)
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0255C7 )
    COP [15]
    COP [05] ( #$0007 )
    COP [80] ( #02 )
    COP [82]
    COP [91]
    RTL 
}

code_02559B {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_02580C )
    COP [03] ( #5B )
    COP [04]
    LDA #$0020
    STA $asset_skip_mask
    COP [10] ( #$030D, #01, #$00A0, #$0050 ) ; area $0D scene $03: A0DS03 (the attic of Leo's Laboratory) at pixel ($00A0,$0050)
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_0255C7 {
    COP [09] ( #$8007 )
    COP [07] ( #$9B05, &code_0255DF ) ; flag $1B05 (persistent): the Black Stone has been given; bit 15 set = jump when set
    COP [01] ( &asciistring_025639 )
    BRK #$5E
    COP [0A] ( #3F )      ; item $3F = the Black Stone
    COP [09] ( #$9B05 )
    RTL 
}

code_0255DF {
    COP [01] ( &asciistring_0257CA )
    RTL 
}

---------------------------------------------
; The arrival child of King Magridd.
; 
; When: spawned by COP 30 on a return through lair record $195.
; Sees: 'I knew what was happening. I could do nothing to prevent the Queen from passing away.', COP 37 heals the hero to full, then the child ends.
; In: X = D = the child.
; Out: RTL after COP 86.
; Clobbers: A.

mc_npc_king_magridd_arrival_0255E4 {
    COP [01] ( &asciistring_0255ED )
    COP [37]
    COP [86]
    RTL 
}

asciistring_0255ED |[10][0E:3C]I knew what was [N]happening- [FIN]I could do nothing to [N]prevent the Queen from[N]passing away- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_025639 |[10]I have failed as [N]a King- [FIN]I ordered people to be[N]loyal to me- [FIN]And killed whomever [N]would not follow me- [FIN]Once you reach the top[N]the only way is down- [FIN]I was just a coward- [N]I made a promise with [N]the evil King [N]Deathtoll- [FIN]Simply because I [N]thought it would [N]impress the Queen- [FIN]But the Queen was [N]captured by her own [N]desire and passed [N]away- [FIN]I must apologize to [N]Dr-Leo- [FIN]I have [03:24]the Black Stone[N][03:20]with me- You must have[N]all 6 of these now- [FIN]Please go to the world[N]of evil and defeat [N]Deathtoll- [FIN]This is all I can do [N]for Dr-Leo- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_0257CA |[10]I finally realized [N]what was happening [N]when the situation was[N]at its worst- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|

asciistring_02580C |[10][0F]You finally made it! [N][0E:1E]First of all, let me [N]say thank you- [N][0E:5A]I started to think of [N]many things- [N][0E:5A]I know this may sound [N]strange but in the [N]human world, [N][0E:3C]if a person kills one [N]man he is a murderer- [N][0E:28]However, if a person [N]kills 100, [N]then he is praised as [N]a hero- [N][0E:5A]I became a king by [N]this theory, [N]but I always felt [N]lonely- [N][0E:5A]Even if I had many men[N][0E:2D]and beautiful women [N]around me, I felt [N]alone- [N][0E:5A]Now I realize no man [N]can live by himself- [N][0E:8C]I am going to spend [N]all the money I [N]received from [N]Deathtoll to construct[N]and build a great [N]town- [N][0E:5A]This is my way of [N]compensating the [N]people I helped [N]defeat- [N][0E:3C]But, I also want to [N]build a town where [N]people won t have [N]anything to fear- [N][0E:28]and they can begin to [N]believe in themselves-[N][0E:5A][02:2], [N]thank you very much- [N][0E:46]I will build statues [N]of you and Dr-Leo [N]in the center of town-[N][0E:28]I promise to tell [N]every generation about[N]your accomplishments- [0E:78][JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF+M]|
---------------------------------------------

; The soldier with a speck of dust in his eye (switch $185).
; 
; When: placement script (type $30, tile ($1E,$2D)); COP 3B holds him until lair record $185 (3 Bronze Robots of location $6C, gate word $016B) is released.
; Sees: the actor moves by (-$20,+$20), puffs, plays animation $14; when the hero is on tile ($1C,$33) he waits 5 frames and flips (COP 96); talk: 'She was removing some dust from my eye.'
; Why: the other half of the joke of mc_npc_maid_dormitory_dust_024FD3.
; In: X = D = slot $1B.
; Out: RTL.
; Clobbers: A.

mc_npc_soldier_dust_in_eye_025AAA {
    COP [3B] ( #$0185, &code_025AC0 )
    COP [17] ( &shared_actor_helpers_bank4.cm_npc_captive_plea_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_025AC0 {
    COP [A1] ( #$FFE0, #$0020 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_025AF1 )
    COP [97]
    COP [80] ( #14 )
    COP [82]
    COP [15]
    COP [91]
    COP [0D] ( #00, #1C, #33, &code_025AE2 )
    RTL 
}

code_025AE2 {
    COP [03] ( #05 )
    COP [04]
    COP [96]
    COP [80] ( #14 )
    COP [82]
    COP [91]
    RTL 
}

code_025AF1 {
    COP [01] ( &asciistring_025AF6 )
    RTL 
}

asciistring_025AF6 |[10]She was removing some [N]dust from my eye- [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|