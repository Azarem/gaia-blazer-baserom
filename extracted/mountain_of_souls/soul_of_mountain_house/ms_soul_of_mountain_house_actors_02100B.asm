; The last fourteen NPC roots of the Soul of Mountain House (file offsets 135179-138515, SNES $04:900B-$9D13, meta types $1F-$2C): the boy and Nome in the prison, three grandpas and an old man, the snail race (three jockeys and the girl who starts it), two mushrooms, two snails and a girl. The first thirteen roots are in ms_soul_of_mountain_house_actors_020000; the roster, the flag scheme and the COP 14 / COP 3B convention are described there.
; 
; === WHAT RUNS HERE ===
; Same convention as ms_soul_of_mountain_house_actors_020000: a COP 14 (switch, &code) root returns every frame until that lair is released, a COP 3B root is a captive (shared plea as talk handler, ends in HoldActorUntilReleased) until then. PlacementA0AS01 rows $11-$1E (slot = row index) hold the meta types $1F-$2C; the lair of each is a record in LairRecords with home location $3D.
; - The prison (captives, COP 3B): the boy $D7 (type $1F), Nome $D6 ($20) and the snail $FA ($28) wait for their lairs (Red Wizards in the passage to Lune $41 for D6 and D7, Cave Bats of Laynole $47 for FA).
; - The race: three snail jockeys (type $22 Legend, switch $D4; $23 Flash, $EF; $24, $F0) and the starter girl ($2B, $F2) need each other and the boy $E9 (the track builder from the other file). Nobody races before all five lairs are released: the jockeys' talk handlers check the other jockeys, then $E9, then $F2 with COP 14; the starter checks the three jockeys and $E9.
; - Quest givers: Nome gives the Silver Stone, the snail $E8 gives the Master's Emblem E, the old man $FC is the Dream Rod target of A0BS03, the grandpa $FE refuses to let the hero past without the Lucky Blade, the grandpa $FF names the Lucky Blade.
; 
; === ROSTER (root: type, placement tile, lair switch and lair, what is said or given) ===
; - ms_npc_boy_leo_lab_hint_02100B: $1F, ($19,$2D), $D7 (passage to Lune $41, Red Wizards), captive in the centre cell: 'There is a house in the desert to #-. Mechanical monsters that cannot be defeated by normal swords exist there.' (the walkthrough: Dr. Leo's lab lies to the southeast; the ROM prints a '#' for the direction, OQ-I037-3).
; - ms_npc_snail_nome_silver_stone_02108F: $20, ($21,$2D), $D6 (passage to Lune, Red Wizards), captive: Nome tells of Dr. Leo and gives the Silver Stone (item $3D, flag $1B03).
; - ms_npc_grandpa_lucky_blade_021263: $21, ($21,$30), $FF (Laynole, Red Wizards): 'There is a sword called Lucky Blade somewhere in Laynole. It is said that monsters will leave larger GEMs.'; once the King is free: 'The King has spoken of you. The snail over there is Nome.'
; - ms_npc_snail_jockey_legend_0212FE ($22, ($2F,$06), $D4: Aurora's Ridge $3F, Green Lizards), ms_npc_snail_jockey_flash_021455 ($23, ($2F,$08), $EF: ice hill $46, Green Blobs) and ms_npc_snail_jockey_third_0215B1 ($24, ($2F,$0A), $F0: ice hill, Green Blobs): 'We are snail jockeys. This snail is called Legend.' / '... called Flash. I am the fastest!' / '... We are waiting for the race to start.'; when the track is ready: 'All the jockeys are here, but the race track is not completed yet.'; during the race: 'I have no time to talk. I think I am going to lose the race.' (Legend; Flash and the third: 'I am going to lose the race').
; - ms_npc_girl_race_starter_021ACA: $2B, ($2D,$1F), $F2 (ice hill, Cave Bats): 'This is the race track. Not all the members are ready, so I cannot start the race.' / '... the track is not yet completed ...'; when ready 'All the jockeys are here and the race track is finally finished. We are going to start the race. Why don't you come along?'; then 'On your mark, well everyone's on the mark. Okay, are you ready? Get set, Go!' and 'All right!'.
; - ms_npc_mushroom_short_lives_021711: $25, ($3B,$0D), $CB (North slope $3E, Fire Bat type $30): 'These creatures grow very fast. They become adults within half a year, get married, have children and pass away in a year. They never feel their lives are too short. They enjoy each moment!'
; - ms_npc_grandpa_lune_gate_0217D9: $26, ($39,$21), $FE (Laynole, Cave Bats): 'This passage leads to the underground lake, Lune.'; without the Lucky Blade (item $04) and at tile ($37,$24): 'Hey, you re not going to the lake with that sword are you? You are going to get in trouble. Talk to some of the people in town, maybe someone can help you.'
; - ms_npc_grandpa_dream_rod_0218BF: $27, ($33,$38), $FC (Laynole, Purple Wizards): with the Dream Rod (item $1C) equipped the hero enters his dream (area $0B scene $03, A0BS03); afterwards 'Oops! I must have fallen asleep. I was dreaming of my childhood.' (the walkthrough: the old man tells of the 50 Gems, the Magic Armor and the Medical Herb of Aurora's Ridge).
; - ms_npc_snail_old_man_child_02195F: $28, ($34,$38), $FA (Laynole, Cave Bats), captive: 'Can you believe this old man used to be a child just a half a year ago? Time is very important.'
; - ms_npc_mushroom_prison_0219CE: $29, ($20,$3D), $EE (ice hill, Green Blobs): 'There is a prison over there. Well--- there are no actual bad people. I guess it is just a punishment room.'
; - ms_npc_snail_master_emblem_e_021A4B: $2A, ($28,$19), $E8 (Lune lake $42, Cave Bats): gives the Master's Emblem E (item $2E, flag $1A04): 'How did you get in? Here I will give you this-'; afterwards 'How did you get in?'
; - ms_npc_girl_mountain_warm_021CB0: $2C, ($20,$09), $CA (North slope, Green Lizards): 'This is where the Mountain of Souls exists. It is quite warm inside the mountain.'
; 
; === EVENT FLAGS ===
; Scene flags: $0001 the race starts (set by the starter's 'Go!' handler, waited by the three jockeys), $0002 'all ready' (set by the starter's talk handler, waited by the starter). Persistent: $1B03 Nome has given the Silver Stone; $1A04 the Master's Emblem E was given; $0706 set by the grandpa $FF once the King is free (no reader found, OQ-I037-4); $0707 the old man's dream was seen (set in ms_dungeon_actors, read by the old man $FC). Items: $3D Silver Stone and $2E Master's Emblem E (given), $04 Lucky Blade (tested), $1C Dream Rod (must be equipped).
; 
; === OPEN ===
; The walkthrough names only Nome and the King; the other NPCs were identified from the lair records, the placement rows and the texts. Meaning of bits $0008 and $0010 of $16 that the race actors toggle (OQ-I037-5). What the race loops show on screen is not verified at runtime.
---------------------------------------------

?BANK 04

?INCLUDE 'engine_003005'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'shared_actor_helpers_bank4'

!joy_block_mask                 0326

---------------------------------------------

; Boy $D7: a captive who hints at the lab in the desert.
; 
; When: placement script (type $1F, slot $11); COP 3B captive until lair record $D7 (passage to Lune, Red Wizards).
; Sees: plea before the release; after it code_021021 (puff, talk handler code_02102F, blocked tiles, entry) with the text 'There is a house in the desert to #-. Mechanical monsters that cannot be defeated by normal swords exist there.'
; Why: the walkthrough sends the hero to Dr. Leo's lab after Nome; the ROM text prints a '#' for the compass word (OQ-I037-3).
; In: X = D = slot $11.
; Out: RTL.
; Clobbers: A.

ms_npc_boy_leo_lab_hint_02100B {
    COP [3B] ( #$00D7, &code_021021 )
    COP [17] ( &shared_actor_helpers_bank4.cm_npc_captive_plea_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_021021 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02102F )
    COP [15]
    COP [91]
    RTL 
}

code_02102F {
    COP [01] ( &asciistring_021034 )
    RTL 
}

asciistring_021034 |[10]There is a house [N]in the desert to #- [FIN]Mechanical monsters [N]that cannot be [N]defeated by normal [N]swords exist there- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Nome: gives the Silver Stone.
; 
; When: placement script (type $20, slot $12); COP 3B captive until lair record $D6 (passage to Lune, Red Wizards).
; Sees: plea; after the release code_0210A5 (puff, talk handler code_0210B3, blocked tiles). The handler: flag $1B03 set (stone given) jumps to code_0210C7, 'What is his daughters name? Lisa? I wonder how she is doing?'; otherwise Nome's story (Dr. Leo refused King Magridd's machine that would call upon evil, was taken to Magridd Castle, gave four stones as keys to the World of Evil, the others are in Dr. Leo's Laboratory and the Castle of Magridd), sound $5E, item $3D given (COP 0A) and flag $1B03 set.
; Why: the Silver Stone opens the quest for Dr. Leo's lab (walkthrough chapter 8).
; In: X = D = slot $12.
; Out: RTL.
; Clobbers: A.

ms_npc_snail_nome_silver_stone_02108F {
    COP [3B] ( #$00D6, &code_0210A5 )
    COP [17] ( &shared_actor_helpers_bank4.cm_npc_captive_plea_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0210A5 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0210B3 )
    COP [15]
    COP [91]
    RTL 
}

code_0210B3 {
    COP [07] ( #$9B03, &code_0210C7 ) ; bit 15 set: jumps when flag $1B03 (Silver Stone given) is set
    COP [01] ( &asciistring_0210CC )
    BRK #$5E
    COP [0A] ( #3D )      ; item $3D = Silver Stone
    COP [09] ( #$9B03 )
    RTL 
}

code_0210C7 {
    COP [01] ( &asciistring_021224 )
    RTL 
}

asciistring_0210CC |[10]My name is Nome- [N]I used to live in [N]Dr-Leo s house- [FIN]Dr-Leo was asked by [N]King Magridd to build [N]a machine that would [N]call upon evil- [FIN]Because he refused, he[N]was taken to Magridd [N]Castle- [FIN]He secretly gave us 4 [N]stones and told us to [N]run away- [FIN]Those stones are keys [N]to the World of Evil- [FIN]The other stones are [N]in Dr-Leo s [N]Laboratory and in the [N]Castle of Magridd- [FIN]Here, take this [03:24]Silver[N]Stone [03:20]and hurry to the[N]Laboratory where [N]Dr-Leo was held- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021224 |[10]What is his daughters [N]name? Lisa? [N]I wonder how she is [N]doing? [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Grandpa $FF: names the Lucky Blade.
; 
; When: placement script (type $21, slot $13); COP 14 until lair record $FF (Laynole, Red Wizards).
; Sees: code_02126A: puff, talk handler code_021289 ('There is a sword called Lucky Blade somewhere in Laynole. It is said that monsters will leave larger GEMs.'), blocked tiles, then COP 14 on lair $103 each frame: when the King is free code_02127E sets flag $0706 and the talk handler code_02128E ('The King has spoken of you. The snail over there is Nome.').
; Why: the hint for the Lucky Blade (a walkthrough item of chapter 5); the second text points to Nome after the Poseidon fight.
; In: X = D = slot $13.
; Out: RTL.
; Clobbers: A.

ms_npc_grandpa_lucky_blade_021263 {
    COP [14] ( #$00FF, &code_02126A )
    RTL 
}

code_02126A {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_021289 )
    COP [15]
    COP [91]
    COP [14] ( #$0103, &code_02127E )
    RTL 
}

code_02127E {
    COP [09] ( #$8706 )   ; flag $0706 is set once the King is free; no script that reads it was found (OQ-I037-4)
    COP [17] ( &code_02128E )
    COP [91]
    RTL 
}

code_021289 {
    COP [01] ( &asciistring_021293 )
    RTL 
}

code_02128E {
    COP [01] ( &asciistring_0212DC )
    RTL 
}

asciistring_021293 |[10]There is a sword [N]called Lucky Blade [N]somewhere in Laynole- [FIN]It is said that [N]monsters will leave [N]larger GEMs- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0212DC |[10]The King has spoken of[N]you- The snail over [N]there is Nome- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Snail jockey Legend (lair $D4): waits for the other jockeys, the boy $E9 and the starter, then races.
; 
; When: placement script (type $22, slot $14); COP 14 until lair record $D4 (Aurora's Ridge, Green Lizards).
; Sees: code_021305: puff, blocked tiles, then COP 14 on $EF, $F0 (the other jockeys), $E9 (the boy) and $F2 (the starter). A missing jockey: talk handler code_0213B0 ('We are snail jockeys. This snail is called Legend.'); a missing $E9 or $F2: code_0213B5 ('All the jockeys are here, but the race track is not completed yet.'). All released (code_02132C): talk handler code_0213BA ('I am going to win this race!'), wait for flag $0001, unblock the tiles, talk handler code_021399 and the race loop loc_02134A (animations $1D, $1B, $1C, $1A with flip X set for part of the loop and cleared for the rest, no exit). code_021399 clears bit $0010 of $16 while it shows 'I have no time to talk. I think I am going to lose the race.' and sets it again.
; Why: the three jockeys and the starter run the little race of the Mountain.
; In: X = D = slot $14.
; Out: loops for ever once the race has started; otherwise RTL.
; Clobbers: A.

ms_npc_snail_jockey_legend_0212FE {
    COP [14] ( #$00D4, &code_021305 )
    RTL 
}

code_021305 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [14] ( #$00EF, &code_021314 ) ; the other jockey ($EF); the chain goes on with $F0, then the boy $E9 and the starter $F2: all must be released for the race
    BRA loc_02133C
}

code_021314 {
    COP [14] ( #$00F0, &code_02131C )
    BRA loc_02133C
}

code_02131C {
    COP [14] ( #$00E9, &code_021324 )
    BRA loc_021343
}

code_021324 {
    COP [14] ( #$00F2, &code_02132C )
    BRA loc_021343
}

code_02132C {
    COP [17] ( &code_0213BA )
    COP [05] ( #$0001 )   ; flag $0001 is set by the starter's 'Go!' handler (code_021B57)
    COP [16]
    COP [17] ( &code_021399 )
    BRA loc_02134A

  loc_02133C:
    COP [17] ( &code_0213B0 )
    COP [91]
    RTL 

  loc_021343:
    COP [17] ( &code_0213B5 )
    COP [91]
    RTL 

  loc_02134A:
    COP [81] ( #1D, #06 )
    COP [83]
    COP [81] ( #1B, #04 )
    COP [83]
    COP [81] ( #1D, #0B )
    COP [83]
    COP [81] ( #1B, #0D )
    COP [83]
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1B, #06 )
    COP [83]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1B, #06 )
    COP [83]
    COP [81] ( #1D, #0E )
    COP [83]
    COP [81] ( #1C, #1D )
    COP [83]
    COP [97]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    BRA loc_02134A

  loc_021396:
    COP [91]
    RTL 
}

code_021399 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0213BF )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

code_0213B0 {
    COP [01] ( &asciistring_0213E9 )
    RTL 
}

code_0213B5 {
    COP [01] ( &asciistring_021409 )
    RTL 
}

code_0213BA {
    COP [01] ( &asciistring_02143E )
    RTL 
}

asciistring_0213BF |[10]I have no time to [N]talk- I think I am [N]going to lose the [N]race- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0213E9 |[10]We are snail jockeys- [N]This snail is called [N]Legend- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021409 |[10]All the jockeys are [N]here, but the race [N]track is not completed[N]yet- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_02143E |[10]I am going to win this[N]race! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Snail jockey Flash (lair $EF): the same script as ms_npc_snail_jockey_legend_0212FE with the roles of $D4 and $EF exchanged.
; 
; When: placement script (type $23, slot $15); COP 14 until lair record $EF (ice hill, Green Blobs).
; Sees: the chain code_02146B, code_021473, code_02147B tests $D4, $F0, $E9, $F2. Texts: 'We are snail jockeys. This snail is called Flash. I am the fastest!' (code_021507), 'All the jockeys are here but the race track is not yet completed.' (code_02150C), 'I am going to win this race!' (code_021511), race talk code_0214F0 ('I have no time to talk. I am going to lose the race.'); the race loop is loc_0214A1 with slightly different frame counts.
; Why: see ms_npc_snail_jockey_legend_0212FE.
; In: X = D = slot $15.
; Out: loops for ever once the race has started; otherwise RTL.
; Clobbers: A.

ms_npc_snail_jockey_flash_021455 {
    COP [14] ( #$00EF, &code_02145C )
    RTL 
}

code_02145C {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [14] ( #$00D4, &code_02146B )
    BRA loc_021493
}

code_02146B {
    COP [14] ( #$00F0, &code_021473 )
    BRA loc_021493
}

code_021473 {
    COP [14] ( #$00E9, &code_02147B )
    BRA loc_02149A
}

code_02147B {
    COP [14] ( #$00F2, &code_021483 )
    BRA loc_02149A
}

code_021483 {
    COP [17] ( &code_021511 )
    COP [05] ( #$0001 )
    COP [16]
    COP [17] ( &code_0214F0 )
    BRA loc_0214A1

  loc_021493:
    COP [17] ( &code_021507 )
    COP [91]
    RTL 

  loc_02149A:
    COP [17] ( &code_02150C )
    COP [91]
    RTL 

  loc_0214A1:
    COP [81] ( #1D, #06 )
    COP [83]
    COP [81] ( #1B, #02 )
    COP [83]
    COP [81] ( #1D, #0B )
    COP [83]
    COP [81] ( #1B, #0D )
    COP [83]
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1B, #06 )
    COP [83]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1B, #06 )
    COP [83]
    COP [81] ( #1D, #0E )
    COP [83]
    COP [81] ( #1C, #1B )
    COP [83]
    COP [97]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    BRA loc_0214A1

  loc_0214ED:
    COP [91]
    RTL 
}

code_0214F0 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_021516 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

code_021507 {
    COP [01] ( &asciistring_02153D )
    RTL 
}

code_02150C {
    COP [01] ( &asciistring_021569 )
    RTL 
}

code_021511 {
    COP [01] ( &asciistring_02159A )
    RTL 
}

asciistring_021516 |[10]I have no time to [N]talk- I am going to [N]lose the race- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_02153D |[10]We are snail jockeys- [N]This snail is called [N]Flash- [N]I am the fastest! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021569 |[10]All the jockeys are [N]here but the race [N]track is not yet [N]completed- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_02159A |[10]I am going to win this[N]race! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; The third snail jockey (lair $F0): the same pattern; its texts do not name the snail.
; 
; When: placement script (type $24, slot $16); COP 14 until lair record $F0 (ice hill, Green Blobs).
; Sees: the chain code_0215C7, code_0215CF, code_0215D7 tests $D4, $EF, $E9, $F2. Texts: 'We are snail jockeys. We are waiting for the race to start.' (code_021657), 'All the jockeys are here but the race track is not yet completed.' (code_02165C), 'We are waiting for the race to start.' (code_021661), race talk code_021640 ('I have no time to talk. I am going to lose the race.'); the race loop is loc_0215FD.
; Why: see ms_npc_snail_jockey_legend_0212FE.
; In: X = D = slot $16.
; Out: loops for ever once the race has started; otherwise RTL.
; Clobbers: A.

ms_npc_snail_jockey_third_0215B1 {
    COP [14] ( #$00F0, &code_0215B8 )
    RTL 
}

code_0215B8 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [14] ( #$00D4, &code_0215C7 )
    BRA loc_0215EF
}

code_0215C7 {
    COP [14] ( #$00EF, &code_0215CF )
    BRA loc_0215EF
}

code_0215CF {
    COP [14] ( #$00E9, &code_0215D7 )
    BRA loc_0215F6
}

code_0215D7 {
    COP [14] ( #$00F2, &code_0215DF )
    BRA loc_0215F6
}

code_0215DF {
    COP [17] ( &code_021661 )
    COP [05] ( #$0001 )
    COP [16]
    COP [17] ( &code_021640 )
    BRA loc_0215FD

  loc_0215EF:
    COP [17] ( &code_021657 )
    COP [91]
    RTL 

  loc_0215F6:
    COP [17] ( &code_02165C )
    COP [91]
    RTL 

  loc_0215FD:
    COP [81] ( #1D, #11 )
    COP [83]
    COP [81] ( #1B, #0D )
    COP [83]
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1B, #06 )
    COP [83]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1B, #06 )
    COP [83]
    COP [81] ( #1D, #0E )
    COP [83]
    COP [81] ( #1C, #19 )
    COP [83]
    COP [97]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    BRA loc_0215FD

  loc_02163D:
    COP [91]
    RTL 
}

code_021640 {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_021666 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

code_021657 {
    COP [01] ( &asciistring_02168D )
    RTL 
}

code_02165C {
    COP [01] ( &asciistring_0216BE )
    RTL 
}

code_021661 {
    COP [01] ( &asciistring_0216EF )
    RTL 
}

asciistring_021666 |[10]I have no time to [N]talk- I am going to [N]lose the race- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_02168D |[10]We are snail jockeys- [N]We are waiting for the[N]race to start- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0216BE |[10]All the jockeys are [N]here but the race [N]track is not yet [N]completed- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0216EF |[10]We are waiting for the[N]race to start- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Mushroom $CB: talks about the short lives of the mushroom people.
; 
; When: placement script (type $25, slot $17, tile ($3B,$0D)); COP 14 until lair record $CB (North slope).
; Sees: puff, talk handler code_02172D ('These creatures grow very fast. They become adults within half a year, get married, have children and pass away in a year. They never feel their lives are too short. They enjoy each moment!'), blocked tiles; then a loop of COP AD (wait until on screen) and animation $25.
; Why: flavour; the same theme as the girl $EB and the snail $FA.
; In: X = D = slot $17.
; Out: loops for ever.
; Clobbers: A.

ms_npc_mushroom_short_lives_021711 {
    COP [14] ( #$00CB, &code_021718 )
    RTL 
}

code_021718 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02172D )
    COP [15]

  loc_021723:
    COP [AD] ( #08 )
    COP [80] ( #25 )
    COP [82]
    BRA loc_021723
}

code_02172D {
    COP [01] ( &asciistring_021732 )
    RTL 
}

asciistring_021732 |[10]These creatures grow [N]very fast- They become[N]adults within half a [N]year, [FIN]get married, have [N]children and pass away[N]in a year- [FIN]They never feel their [N]lives are too short- [N]They enjoy each [N]moment! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Grandpa $FE: the guard of the way to Lune.
; 
; When: placement script (type $26, slot $18); COP 14 until lair record $FE (Laynole, Cave Bats).
; Sees: code_0217E0: puff, talk handler code_021824 ('This passage leads to the underground lake, Lune.'), blocked tiles, COP 18 on item $04 (the Lucky Blade): owned, the script only returns. Missing: code_0217F3 tests with COP 0D whether the hero stands at tile ($37,$24); then code_0217FB unblocks the tiles, blocks input, plays animations $11, $0F and $0C, unblocks input, blocks the tiles again and shows 'Hey, you re not going to the lake with that sword are you? You are going to get in trouble. Talk to some of the people in town, maybe someone can help you.'
; Why: the text implies that the hero's current sword is not enough for the lake; the grandpa warns at the passage until the Lucky Blade is owned.
; In: X = D = slot $18.
; Out: RTL.
; Clobbers: A.

ms_npc_grandpa_lune_gate_0217D9 {
    COP [14] ( #$00FE, &code_0217E0 )
    RTL 
}

code_0217E0 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_021824 )
    COP [15]
    COP [91]
    COP [18] ( #04, &code_0217F3 ) ; item $04 = Lucky Blade; jumps when it is missing: only then does the grandpa stop the hero
    RTL 
}

code_0217F3 {
    COP [0D] ( #00, #37, #24, &code_0217FB ) ; jumps when the hero stands at tile ($37,$24) in front of the passage
    RTL 
}

code_0217FB {
    COP [16]
    LDA #$2F80
    TSB $joy_block_mask
    COP [97]
    COP [81] ( #11, #02 )
    COP [83]
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #0C )
    COP [82]
    LDA #$2F80
    TRB $joy_block_mask
    COP [15]
    COP [01] ( &asciistring_021858 )
    COP [91]
    RTL 
}

code_021824 {
    COP [01] ( &asciistring_021829 )
    RTL 
}

asciistring_021829 |[10]This passage leads to [N]the underground lake, [N]Lune- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021858 |[10]Hey, you re not going [N]to the lake with that [N]sword are you? [FIN]You are going to get [N]in trouble- [FIN]Talk to some of the [N]people in town, maybe [N]someone can help you- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Old man $FC: the dream of A0BS03.
; 
; When: placement script (type $27, slot $19, tile ($33,$38)); COP 14 until lair record $FC (Laynole, Purple Wizards).
; Sees: puff, blocked tiles; talk handler code_0218D4: flag $0707 set (the dream was seen) shows code_0218F5 'Oops! I must have fallen asleep. I was dreaming of my childhood.'; else COP 19 on item $1C (must be equipped): missing 'Zzzz'; equipped '<name> placed the Dream Rod on the old man.', transition type 4 and COP 10 to area $0B scene $03 (A0BS03, the old man's dream) at pixel ($00A0,$00E0).
; Why: the walkthrough: speak to him with the Dream Rod to learn about the Gems, Magic Armor and Medical Herb of Aurora's Ridge.
; In: X = D = slot $19.
; Out: RTL.
; Clobbers: A.

ms_npc_grandpa_dream_rod_0218BF {
    COP [14] ( #$00FC, &code_0218C6 )
    RTL 
}

code_0218C6 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0218D4 )
    COP [15]
    COP [91]
    RTL 
}

code_0218D4 {
    COP [07] ( #$8707, &code_0218F5 ) ; bit 15 set: jumps when flag $0707 (the old man's dream was seen, set in ms_dungeon_actors) is set
    COP [19] ( #1C, &code_0218F0 ) ; item $1C = Dream Rod; jumps when it is not equipped
    COP [01] ( &asciistring_021903 )
    COP [3C] ( #04 )
    COP [10] ( #$030B, #01, #$00A0, #$00E0 ) ; area $0B scene $03 = the old man's dream (A0BS03)
    RTL 
}

code_0218F0 {
    COP [01] ( &asciistring_0218FA )
    RTL 
}

code_0218F5 {
    COP [01] ( &asciistring_021924 )
    RTL 
}

asciistring_0218FA |[10]Zzzz [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021903 |[10][02:2] placed [N]the Dream Rod on the [N]old man- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021924 |[10]Oops! I must have [N]fallen asleep- [FIN]I was dreaming of my [N]childhood- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Snail $FA: a captive that comments on the old man $FC.
; 
; When: placement script (type $28, slot $1A, tile ($34,$38)); COP 3B captive until lair record $FA (Laynole, Cave Bats).
; Sees: plea; after the release code_021975 (puff, talk handler code_021983, blocked tiles): 'Can you believe this old man used to be a child just a half a year ago? Time is very important.'
; Why: flavour; it stands next to the old man.
; In: X = D = slot $1A.
; Out: RTL.
; Clobbers: A.

ms_npc_snail_old_man_child_02195F {
    COP [3B] ( #$00FA, &code_021975 )
    COP [17] ( &shared_actor_helpers_bank4.cm_npc_captive_plea_02229E )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_021975 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_021983 )
    COP [15]
    COP [91]
    RTL 
}

code_021983 {
    COP [01] ( &asciistring_021988 )
    RTL 
}

asciistring_021988 |[10]Can you believe this [N]old man used to be a [N]child just a half a [N]year ago? [FIN]Time is very [N]important- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Mushroom $EE: tells about the prison.
; 
; When: placement script (type $29, slot $1B, tile ($20,$3D)); COP 14 until lair record $EE (ice hill, Green Blobs).
; Sees: puff, talk handler code_0219EA ('There is a prison over there. Well--- there are no actual bad people. I guess it is just a punishment room.'), blocked tiles; a loop of COP AD and animation $25.
; Why: flavour; it points to the prison where the boy $D7, Nome and the mushroom $DD wait.
; In: X = D = slot $1B.
; Out: loops for ever.
; Clobbers: A.

ms_npc_mushroom_prison_0219CE {
    COP [14] ( #$00EE, &code_0219D5 )
    RTL 
}

code_0219D5 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0219EA )
    COP [15]

  loc_0219E0:
    COP [AD] ( #08 )
    COP [80] ( #25 )
    COP [82]
    BRA loc_0219E0
}

code_0219EA {
    COP [01] ( &asciistring_0219EF )
    RTL 
}

asciistring_0219EF |[10]There is a prison over[N]there- [FIN]Well--- there are no [N]actual bad people- [N]I guess it is just a [N]punishment room- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Snail $E8: gives the Master's Emblem E.
; 
; When: placement script (type $2A, slot $1C, tile ($28,$19)); COP 14 until lair record $E8 (Lune lake, Cave Bats; the walkthrough: the snail in the small room south of the Master's Shrine).
; Sees: puff, talk handler code_021A60, blocked tiles. Flag $1A04 set (emblem given) jumps to code_021A74, 'How did you get in?'; otherwise 'How did you get in? Here I will give you this-' + 'received the Master s Emblem E-', sound $5E, item $2E given (COP 0A) and flag $1A04 set.
; Why: one of the Master's Emblems of the Mountain.
; In: X = D = slot $1C.
; Out: RTL.
; Clobbers: A.

ms_npc_snail_master_emblem_e_021A4B {
    COP [14] ( #$00E8, &code_021A52 )
    RTL 
}

code_021A52 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_021A60 )
    COP [15]
    COP [91]
    RTL 
}

code_021A60 {
    COP [07] ( #$9A04, &code_021A74 ) ; bit 15 set: jumps when flag $1A04 (Emblem E given) is set
    COP [01] ( &asciistring_021A79 )
    BRK #$5E
    COP [0A] ( #2E )      ; item $2E = Master's Emblem E
    COP [09] ( #$9A04 )
    RTL 
}

code_021A74 {
    COP [01] ( &asciistring_021AB8 )
    RTL 
}

asciistring_021A79 |[10]How did you get in? [N]Here I will give you [N]this- [FIN][02:2] received [N][03:24]the Master s Emblem E-[03:20][JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021AB8 |[10]How did you get in? [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Girl $F2: the starter of the snail race.
; 
; When: placement script (type $2B, slot $1D, tile ($2D,$1F)); COP 14 until lair record $F2 (ice hill, Cave Bats).
; Sees: puff, talk handler code_021B2E, blocked tiles, then the script waits for flag $0002 (COP 05). The handler (COP 14 on $D4, $EF, $F0, then $E9): a missing jockey, loc_021B69 'This is the race track. Not all the members are ready, so I cannot start the race.'; a missing $E9, loc_021B6E 'This is the race track. But the track is not yet completed, so I cannot start the race.'; all released, code_021B4E 'All the jockeys are here and the race track is finally finished. We are going to start the race. Why don't you come along?' and flag $0002 set. The script then clears the talk handler, unblocks the tiles, plays animations $0B, $0A, $0B, $07 with flip X, blocks the tiles, clears bit $0008 of $16 and sets the talk handler code_021B57: 'On your mark, well everyone s on the mark. Okay, are you ready? Get set, Go!' which sets flag $0001 and the new handler code_021B64 ('All right!'). On flag $0001 she plays animations $0B, $09 and $08 and stands.
; Why: flags $0002 and $0001 sequence the race: all ready, then start; the jockeys wait for $0001.
; In: X = D = slot $1D.
; Out: RTL.
; Clobbers: A.

ms_npc_girl_race_starter_021ACA {
    COP [14] ( #$00F2, &code_021AD1 )
    RTL 
}

code_021AD1 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_021B2E )
    COP [15]
    COP [05] ( #$0002 )   ; flag $0002 is set by the starter's own talk handler code_021B4E ('all ready')
    COP [17] ( #$0000 )
    COP [16]
    COP [96]
    COP [81] ( #0B, #03 )
    COP [83]
    COP [81] ( #0A, #13 )
    COP [83]
    COP [97]
    COP [81] ( #0B, #03 )
    COP [83]
    COP [80] ( #07 )
    COP [82]
    COP [15]
    LDA $0016, X
    AND #$FFF7
    STA $0016, X
    COP [17] ( &code_021B57 )
    COP [05] ( #$0001 )   ; flag $0001 is set by her 'Go!' handler code_021B57; the three jockeys wait for it
    COP [16]
    COP [96]
    COP [81] ( #0B, #02 )
    COP [83]
    COP [81] ( #09, #04 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    COP [15]
    COP [91]
    RTL 
}

code_021B2E {
    COP [14] ( #$00D4, &code_021B36 )
    BRA loc_021B69
}

code_021B36 {
    COP [14] ( #$00EF, &code_021B3E )
    BRA loc_021B69
}

code_021B3E {
    COP [14] ( #$00F0, &code_021B46 )
    BRA loc_021B69
}

code_021B46 {
    COP [14] ( #$00E9, &code_021B4E )
    BRA loc_021B6E
}

code_021B4E {
    COP [01] ( &asciistring_021B73 )
    COP [09] ( #$8002 )
    RTL 
}

code_021B57 {
    COP [01] ( &asciistring_021BCE )
    COP [09] ( #$8001 )
    COP [17] ( &code_021B64 )
    RTL 
}

code_021B64 {
    COP [01] ( &asciistring_021C18 )
    RTL 

  loc_021B69:
    COP [01] ( &asciistring_021C24 )
    RTL 

  loc_021B6E:
    COP [01] ( &asciistring_021C68 )
    RTL 
}

asciistring_021B73 |[10]All the jockeys [N]are here and the race [N]track is finally [N]finished- [FIN]We are going to start [N]the race- Why don t [N]you come along? [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021BCE |[10]On your mark, [FIN]well everyone s on the[N]mark- [FIN]Okay, are you ready? [FIN]Get set, [N][0E:28]Go! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021C18 |[10]All right! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021C24 |[10]This is the race [N]track- [FIN]Not all the members [N]are ready, so I cannot[N]start the race- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_021C68 |[10]This is the race [N]track- [FIN]But the track is not [N]yet completed, so I [N]cannot start the race- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Girl $CA: a comment about the mountain.
; 
; When: placement script (type $2C, slot $1E, tile ($20,$09)); COP 14 until lair record $CA (North slope, Green Lizards).
; Sees: puff, blocked tiles, talk handler code_021CC5 ('This is where the Mountain of Souls exists. It is quite warm inside the mountain.').
; Why: flavour.
; In: X = D = slot $1E.
; Out: RTL.
; Clobbers: A.

ms_npc_girl_mountain_warm_021CB0 {
    COP [14] ( #$00CA, &code_021CB7 )
    RTL 
}

code_021CB7 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [17] ( &code_021CC5 )
    COP [91]
    RTL 
}

code_021CC5 {
    COP [01] ( &asciistring_021CCA )
    RTL 
}

asciistring_021CCA |[10]This is where the [N]Mountain of Souls [N]exists- [FIN]It is quite warm [N]inside the mountain- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|