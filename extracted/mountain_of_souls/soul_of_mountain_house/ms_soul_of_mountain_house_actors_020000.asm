; The first thirteen NPC roots of the Soul of Mountain House (file offsets 131072-135178, SNES $04:8000-$900A): grandpas, grandmas, a boy, a girl, a mushroom, a snail and the King who has the Phoenix called. The other roots of the house are in ms_soul_of_mountain_house_actors_02100B.
; 
; === WHAT RUNS HERE ===
; The house (location $3D, scene A0AS01) holds one NPC for each lair of the Mountain of Souls that frees somebody: the lair record (LairRecords) has home location $3D and the byte at +9 says who ($1E boy, $1F girl, $20 grandpa, $21 grandma, $22 snail, $23 the King, $24 mushroom, $25 Nome). PlacementA0AS01 rows $04-$1E are the NPCs; the row index is the actor slot and the last byte is the meta type ($12-$2C, MetaMountainOfSouls) that picks the script. The roots here are types $12-$1E.
; - COP 14 (switch, &code) roots ($12, $13, $15, $17, $18, $19, $1A, $1B, $1C): RTL every frame until the lair with that switch number is released; then the script continues at &code (appear puff, COP 15 blocks the NPC's tiles, COP 17 sets the talk handler, COP 91 keeps the entry).
; - COP 3B (switch, &code) roots ($14, $16, $1D, $1E): the same, but before the release the actor is a captive: the talk handler is the shared plea shared_actor_helpers_bank4.cm_npc_captive_plea_02229E (one of three pleas picked by rng_state: 'Ouch---- it hurts! Somebody please help me!', 'I want to return to my real form-', ...) and the script ends in engine_player_death_and_actor_helpers.HoldActorUntilReleased.
; - COP 30 (switch, &code, $04) in the King $1A and the boy $1C: when the hero came home through that lair record (return_active and return_record) a one-shot actor is spawned at &code, then the normal script goes on.
; - Every text ends with [JMP] into shared_actor_helpers_bank4.asciistring_02251E, the common end of a dialogue. The ROM prints an apostrophe as a space and a full stop as a dash ('Master s', 'rare to see someone new-'); the notes quote the text as meant.
; 
; === ROSTER (root: type, placement tile, lair switch and lair, what is said or given) ===
; - ms_npc_grandpa_room_invite_020000: $12, ($0F,$0C), $C9 (North slope $3E, Yetis). 'My, my, it is rare to see someone new. Please come into my room.' He then walks to his seat; at tile ($0A,$07): 'I have so many questions about human beings. Would you like to discuss them with me?'
; - ms_npc_grandpa_wife_magic_0200F5: $13, ($05,$18), $D3 (Aurora's Ridge $3F, Green Lizards): 'My wife was able to use magic at one time.'
; - ms_npc_grandma_magic_demo_020143: $14, ($02,$18), $EA (top of Snow Mountain $45, Undead Caribou), captive: 'Oh honey, I can still use magic. Look!' then a short demonstration with the hero moved; 'You see?'
; - ms_npc_boy_girlfriend_0201D2: $15, ($07,$25), $CC (Aurora's Ridge, Fire Bat type $30): 'Please save my girlfriend.'; once the girl $EB is free: 'We were really happy just gazing at each other.'
; - ms_npc_girl_new_love_020237: $16, ($04,$25), $EB (top of Snow Mountain, Green Lizards), captive: 'We were really happy just gazing at each other. But I may get old soon. Maybe I should search for someone new.'
; - ms_npc_grandpa_search_laynole_0202BA: $17, ($06,$2F), $F8 (Laynole $47, Purple Wizards): 'Make sure you search Laynole very carefully. If you move too fast you may overlook things.'
; - ms_npc_grandma_phoenix_east_02032B ($18, ($0A,$32), $E1: Lune lake $42, Green Blobs) and ms_npc_grandma_phoenix_west_020452 ($19, ($07,$32), $E6: Lune lake, Cave Bats): the two old magicians of the Phoenix call. Before the King is free 'Please save the King!'; afterwards 'I am a magician. If you collect the Master s three symbols, I will call the Phoenix.' and, with the Phoenix magic, 'Oh Phoenix, please protect <name>.' Once the King is free they stand next to him, at tiles ($11,$37) and ($0F,$37).
; - ms_npc_king_phoenix_020563: $1A, ($10,$35), $103 (Poseidon's room $44, Poseidon itself): thanks, the Phoenix explanation, the call, the farewell and the epilogue (see the part note).
; - ms_npc_mushroom_dream_secret_020C53: $1B, ($12,$1B), $F6 (the ice hill $46, Purple Wizards): 'I'll tell you a secret. If you see a sleeping mushroom, return to the same place you saw in its dream.'
; - ms_npc_boy_mushroom_shoes_020CC6: $1C, ($1E,$19), $E9 (top of Snow Mountain, Yetis): gives the Mushroom Shoes (item $22): 'There is snail goo on the bottom of these shoes. If you wear these you will not slip on the ice. You will still slip on the slopes though.' (the walkthrough: speak with the person at the pond).
; - ms_npc_snail_vehicle_020EE9: $1D, ($1F,$19), $F7 (the ice hill, Purple Wizards), captive: 'Week, week!', then 'Let's go!' and a walking loop; afterwards 'This is our vehicle.'
; - ms_npc_mushroom_dream_rod_020F9B: $1E, ($12,$2B), $DD (Lune lake, Green Blobs), captive: with the Dream Rod (item $1C) equipped '<name> placed the Dream Rod on the mushroom.' and the hero enters the mushroom's dream (area $0B scene $06, A0BS06); without it 'Zzzzz'.
; 
; === EVENT FLAGS ===
; Scene flags $0000-$0007 are set and read inside this scene only: $0000 the grandpa $C9 has welcomed the hero; $0003 the snail has spoken (set by its first talk handler, waited and then cleared by the boy $E9 and the snail); $0004 the Phoenix call starts (set by the King, waited by the King and both grandmas); $0005 the grandmas are done (set by the east grandma, waited by the King); $0007 the boy's 'Hooray' one-shot has run. Persistent: $0705 the King has thanked the hero once; $0A00 and $0A01 set by the King at the call ($0A01 is cleared again when the farewell is spoken; no script reads $0A00, OQ-I037-4); $1F02 the ending ran (the King then plays the epilogue). Items: $18 Phoenix magic (given), $22 Mushroom Shoes (given), $32 Red-Hot Mirror, $33 Red-Hot Ball and $34 Red-Hot Stick (tested, then taken by the call), $1C Dream Rod (must be equipped).
; 
; === OPEN ===
; The walkthrough (chapter 5) says elderly women call the Phoenix and chapter 8 the King; in the ROM the King orders the call (code_02065C) and both grandmas must be free, which the three-item rule of chapter 5 does not mention (OQ-I037-1). The meaning of the actor flag bits $0008 / $0010 cleared by some roots is not documented (OQ-I037-5).
---------------------------------------------

?BANK 04

?INCLUDE 'engine_player_death_and_actor_helpers'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'shared_actor_helpers_bank4'

!joy_block_mask                 0326
!player_actor                   039C
!asset_skip_mask                03B4
!return_active                  03FB

---------------------------------------------

; Grandpa $C9: welcomes the hero, walks to his seat and asks his question.
; 
; When: placement script (type $12); COP 14 returns until lair record $C9 (North slope, Yetis) is released.
; Sees: puff, blocked tiles, talk handler code_020052 ('Please come into my room', sets scene flag $0000). The script waits for the flag (COP 05), unblocks the tiles, plays a short walk (animations $11 / $10 with flip X changing, COP 81 / 83), faces left (animation $0E), sets the talk handler code_02005B ('Please, sit right in front of me.') and, with COP 91, tests every frame with COP 0D whether the hero is at tile ($0A,$07): then code_02004B shows the question about human beings.
; Why: a scripted welcome.
; In: X = D = slot $04.
; Out: RTL (COP 91 repeats the test).
; Clobbers: A.

ms_npc_grandpa_room_invite_020000 {
    COP [14] ( #$00C9, &code_020007 )
    RTL 
}

code_020007 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_020052 )
    COP [15]
    COP [05] ( #$0000 )   ; flag $0000 is set by the talk handler code_020052 (the welcome); only then does he walk to his seat
    COP [16]
    COP [17] ( #$0000 )
    COP [97]
    COP [81] ( #11, #02 )
    COP [83]
    COP [81] ( #10, #02 )
    COP [83]
    COP [81] ( #11, #06 )
    COP [83]
    COP [81] ( #10, #03 )
    COP [83]
    COP [96]
    COP [80] ( #0E )
    COP [82]
    COP [17] ( &code_02005B )
    COP [91]
    COP [0D] ( #00, #0A, #07, &code_02004B )
    RTL 
}

code_02004B {
    COP [01] ( &asciistring_0200B8 )
    COP [91]
    RTL 
}

code_020052 {
    COP [01] ( &asciistring_020060 )
    COP [09] ( #$8000 )
    RTL 
}

code_02005B {
    COP [01] ( &asciistring_020095 )
    RTL 
}

asciistring_020060 |[10]My, my, it is rare to [N]see someone new- [N]Please come into my [N]room- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020095 |[10]Please, sit right in [N]front of me- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0200B8 |[10]I have so many [N]questions about human [N]beings- [FIN]Would you like to [N]discuss them with me? [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Grandpa $D3: remembers that his wife could use magic.
; 
; When: placement script (type $13); COP 14 until lair record $D3 (Aurora's Ridge, Green Lizards).
; Sees: talk handler code_020119 ('My wife was able to use magic at one time.'). While lair $EA (the wife) is not yet released, bit $0008 of $16 is cleared first (meaning: OQ-I037-5); then the common code_02010F: puff, blocked tiles, entry here.
; Why: his wife is the grandma $EA of ms_npc_grandma_magic_demo_020143.
; In: X = D = slot $05.
; Out: RTL.
; Clobbers: A.

ms_npc_grandpa_wife_magic_0200F5 {
    COP [14] ( #$00D3, &code_0200FC )
    RTL 
}

code_0200FC {
    COP [17] ( &code_020119 )
    COP [14] ( #$00EA, &code_02010F )
    LDA $0016, X
    AND #$FFF7
    STA $0016, X
}

code_02010F {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [91]
    RTL 
}

code_020119 {
    COP [01] ( &asciistring_02011E )
    RTL 
}

asciistring_02011E |[10]My wife was able to [N]use magic at one time- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Grandma $EA: shows her magic to the hero.
; 
; When: placement script (type $14); COP 3B captive until lair record $EA (top of Snow Mountain, Undead Caribou).
; Sees: before the release the shared plea; after it code_020159 (puff, talk handler code_02019A, blocked tiles). The talk handler says 'Oh honey, I can still use magic. Look!' and COP 27 continues at code_020167: a puff is spawned relative to her (COP B2), sound $4E, the hero's x is written to $0100 and the script waits 225 frames (COP 03 / 04), sound $4E again, the hero is put at ($0020,$01A0) and 'You see?' is shown.
; Why: the hero is moved by the magic; the position is written straight into player_actor.
; In: X = D = slot $06.
; Out: RTL.
; Clobbers: A, Y.

ms_npc_grandma_magic_demo_020143 {
    COP [3B] ( #$00EA, &code_020159 )
    COP [17] ( &shared_actor_helpers_bank4.cm_npc_captive_plea_02229E )
    SEP #$20
    LDA #$^engine_player_death_and_actor_helpers.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_player_death_and_actor_helpers.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_020159 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02019A )
    COP [15]
    COP [91]
    RTL 
}

code_020167 {
    COP [B2] ( @engine_spawn_lairs_death_drops.RunAppearPuff, #$0000, #$0010, #$0040 )
    BRK #$4E
    LDY $player_actor
    LDA #$0100
    STA $0000, Y          ; the hero's x is written directly: the magic moves him
    COP [03] ( #E1 )
    COP [04]
    BRK #$4E
    LDY $player_actor
    LDA #$0020
    STA $0000, Y
    LDA #$01A0
    STA $0002, Y
    COP [01] ( &asciistring_0201C8 )
    COP [91]
    RTL 
}

code_02019A {
    COP [01] ( &asciistring_0201A2 )
    COP [27] ( &code_020167 )
}

asciistring_0201A2 |[10]Oh honey, I can still [N]use magic- [FIN]Look! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0201C8 |[10]You see? [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Boy $CC: asks the hero to save his girlfriend.
; 
; When: placement script (type $15); COP 14 until lair record $CC (Aurora's Ridge, Fire Bat lair).
; Sees: puff, blocked tiles; talk handler code_0201E7: COP 14 on lair $EB (the girl): free, code_0201F2 'We were really happy just gazing at each other.'; not free, 'Please save my girlfriend.'
; Why: the couple with ms_npc_girl_new_love_020237.
; In: X = D = slot $07.
; Out: RTL.
; Clobbers: A.

ms_npc_boy_girlfriend_0201D2 {
    COP [14] ( #$00CC, &code_0201D9 )
    RTL 
}

code_0201D9 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0201E7 )
    COP [15]
    COP [91]
    RTL 
}

code_0201E7 {
    COP [14] ( #$00EB, &code_0201F2 )
    COP [01] ( &asciistring_02021F )
    RTL 
}

code_0201F2 {
    COP [01] ( &asciistring_0201F7 )
    RTL 
}

asciistring_0201F7 |[10]We were really [N]happy just gazing at [N]each other- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_02021F |[10]Please save my [N]girlfriend- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Girl $EB: the girlfriend of the boy $CC.
; 
; When: placement script (type $16); COP 3B captive until lair record $EB (top of Snow Mountain, Green Lizards).
; Sees: plea, then after the release code_02024D (puff, talk handler code_02025B: 'We were really happy just gazing at each other. But I may get old soon. Maybe I should search for someone new.').
; Why: a joke on the short lives of the Mountain's people (compare the snail and mushroom lines).
; In: X = D = slot $08.
; Out: RTL.
; Clobbers: A.

ms_npc_girl_new_love_020237 {
    COP [3B] ( #$00EB, &code_02024D )
    COP [17] ( &shared_actor_helpers_bank4.cm_npc_captive_plea_02229E )
    SEP #$20
    LDA #$^engine_player_death_and_actor_helpers.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_player_death_and_actor_helpers.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_02024D {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02025B )
    COP [15]
    COP [91]
    RTL 
}

code_02025B {
    COP [01] ( &asciistring_020260 )
    RTL 
}

asciistring_020260 |[10]We were really [N]happy just gazing at [N]each other- [FIN]But I may get old [N]soon- [FIN]Maybe I should search [N]for someone new- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Grandpa $F8: a hint for Laynole.
; 
; When: placement script (type $17); COP 14 until lair record $F8 (Laynole, Purple Wizards).
; Sees: puff, blocked tiles, talk handler code_0202CF: 'Make sure you search Laynole very carefully. If you move too fast you may overlook things.'
; Why: Laynole holds the Master's Emblem E (walkthrough chapter 5) among other things; the hint is the game's own.
; In: X = D = slot $09.
; Out: RTL.
; Clobbers: A.

ms_npc_grandpa_search_laynole_0202BA {
    COP [14] ( #$00F8, &code_0202C1 )
    RTL 
}

code_0202C1 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0202CF )
    COP [15]
    COP [91]
    RTL 
}

code_0202CF {
    COP [01] ( &asciistring_0202D4 )
    RTL 
}

asciistring_0202D4 |[10]Make sure you search [N]Laynole very [N]carefully- [FIN]If you move too fast [N]you may overlook [N]things--- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Grandma $E1: the first old magician of the Phoenix call, and the only one who sets flag $0005.
; 
; When: placement script (type $18, slot $0A); COP 14 until lair record $E1 (Lune lake, Green Blobs).
; Sees: talk handler code_0203B4 (King not free: 'Please save the King!'; free, code_0203BF: Phoenix magic (item $18) missing 'I am a magician. If you collect the Master s three symbols, I will call the Phoenix.', owned 'Oh Phoenix, please protect <name>.'). If the King (switch $103) is already free, code_02035A moves slot $0A to tile ($11,$37), puffs, clears bit $0010 of $16, blocks the tiles and waits for flag $0004; then she raises her arms (animations $28 / $27 alternating, five steps of two frames), spawns ms_effect_phoenix_flame_020445, plays animations $29, $2A and $2B, sets flag $0005 and stands (animation $14). If the King is not free: puff, blocked tiles and entry; when the King is freed while the scene runs, code_02034C plays animations $17 and $15.
; Why: the call needs both grandmas; the King waits for flag $0005.
; In: X = D = slot $0A.
; Out: RTL (COP 91 at the end).
; Clobbers: A.

ms_npc_grandma_phoenix_east_02032B {
    COP [14] ( #$00E1, &code_020332 )
    RTL 
}

code_020332 {
    COP [17] ( &code_0203B4 )
    COP [14] ( #$0103, &code_02035A )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [91]
    COP [14] ( #$0103, &code_02034C )
    RTL 
}

code_02034C {
    COP [80] ( #17 )
    COP [82]
    COP [81] ( #15, #08 )
    COP [83]
    COP [91]
    RTL 
}

code_02035A {
    COP [11] ( #0A, #11, #37 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [15]
    COP [05] ( #$0004 )   ; flag $0004 is set by the King (code_02065C) when the call begins
    COP [81] ( #28, #02 )
    COP [83]
    COP [81] ( #27, #02 )
    COP [83]
    COP [81] ( #28, #02 )
    COP [83]
    COP [81] ( #27, #02 )
    COP [83]
    COP [81] ( #28, #02 )
    COP [83]
    COP [85] ( @ms_effect_phoenix_flame_020445 )
    COP [81] ( #29, #04 )
    COP [83]
    COP [81] ( #2A, #08 )
    COP [83]
    COP [81] ( #2B, #10 )
    COP [83]
    COP [09] ( #$8005 )   ; flag $0005 tells the King that the grandmas are done; only the east grandma sets it
    COP [80] ( #14 )
    COP [82]
    COP [91]
    RTL 
}

code_0203B4 {
    COP [14] ( #$0103, &code_0203BF )
    COP [01] ( &asciistring_0203CE )
    RTL 
}

code_0203BF {
    COP [18] ( #18, &code_0203C9 )
    COP [01] ( &asciistring_020427 )
    RTL 
}

code_0203C9 {
    COP [01] ( &asciistring_0203DF )
    RTL 
}

asciistring_0203CE |[10]Please save the King! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0203DF |[10]I am a magician- [FIN]If you collect the [N]Master s three [N]symbols, I will call [N]the Phoenix- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020427 |[10]Oh Phoenix, please [N]protect [02:2]- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

---------------------------------------------
; The flame of the Phoenix call.
; 
; When: spawned (COP 85) by the east grandma at the end of her arm-raising.
; Sees: COP A8 sets the animation table ($8000, byte $0D), animation $49 runs once (COP 92 starts it, COP 94 waits for its end), then the actor kills itself (COP 86).
; Why: the visible part of the call before the Phoenix voice.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_effect_phoenix_flame_020445 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #49 )
    COP [94]
    COP [86]
    RTL 
}
---------------------------------------------

; Grandma $E6: the second old magician of the Phoenix call.
; 
; When: placement script (type $19, slot $0B); COP 14 until lair record $E6 (Lune lake, Cave Bats).
; Sees: the same texts (code_0204D2, code_0204DD, code_0204E7) and the same arm-raising routine (code_020481, tile ($0F,$37), animations $28 / $27 then $29, $2A, $2B, then $14) as ms_npc_grandma_phoenix_east_02032B, but no flame actor and no flag: only the east grandma sets $0005. code_020473 is the reaction when the King is freed during the scene.
; Why: see ms_npc_grandma_phoenix_east_02032B.
; In: X = D = slot $0B.
; Out: RTL.
; Clobbers: A.

ms_npc_grandma_phoenix_west_020452 {
    COP [14] ( #$00E6, &code_020459 )
    RTL 
}

code_020459 {
    COP [17] ( &code_0204D2 )
    COP [14] ( #$0103, &code_020481 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [91]
    COP [14] ( #$0103, &code_020473 )
    RTL 
}

code_020473 {
    COP [80] ( #17 )
    COP [82]
    COP [81] ( #15, #08 )
    COP [83]
    COP [91]
    RTL 
}

code_020481 {
    COP [11] ( #0B, #0F, #37 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [15]
    COP [05] ( #$0004 )
    COP [81] ( #28, #02 )
    COP [83]
    COP [81] ( #27, #02 )
    COP [83]
    COP [81] ( #28, #02 )
    COP [83]
    COP [81] ( #27, #02 )
    COP [83]
    COP [81] ( #28, #02 )
    COP [83]
    COP [81] ( #29, #04 )
    COP [83]
    COP [81] ( #2A, #08 )
    COP [83]
    COP [81] ( #2B, #10 )
    COP [83]
    COP [80] ( #14 )
    COP [82]
    COP [91]
    RTL 
}

code_0204D2 {
    COP [14] ( #$0103, &code_0204DD )
    COP [01] ( &asciistring_0204EC )
    RTL 
}

code_0204DD {
    COP [18] ( #18, &code_0204E7 )
    COP [01] ( &asciistring_020545 )
    RTL 
}

code_0204E7 {
    COP [01] ( &asciistring_0204FD )
    RTL 
}

asciistring_0204EC |[10]Please save the King! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0204FD |[10]I am a magician- [FIN]If you collect the [N]Master s three [N]symbols, I will call [N]the Phoenix- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020545 |[10]Oh Phoenix, please [N]protect [02:2]- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; The King (switch $103): thanks, hints, the Phoenix call, the farewell and the epilogue.
; 
; When: placement script (type $1A, slot $0C, tile ($10,$35)); COP 14 returns until lair record $103 (Poseidon) is released.
; Sees: code_02056A: COP 30 spawns ms_obj_king_return_heal_02067F when the hero comes home through that lair. Flag $1F02 set (the ending ran): code_0205F2, the epilogue. Flag $0A01 set (the Phoenix has been called): code_0205D2, the farewell. Otherwise puff, talk handler code_02062D, blocked tiles; COP 18 on the Phoenix magic: missing, code_02058F waits for the call; owned, the actor only waits (COP 91).
; Why: one actor serves the whole last stage of the Mountain: rescue, call, farewell, ending.
; In: X = D = slot $0C.
; Out: RTL.
; Clobbers: A.

ms_npc_king_phoenix_020563 {
    COP [14] ( #$0103, &code_02056A )
    RTL 
}

code_02056A {
    COP [30] ( #$0103, &ms_obj_king_return_heal_02067F, #04 ) ; returned from lair $103 (Poseidon): spawns the one-shot that heals the hero
    COP [07] ( #$9F02, &code_0205F2 ) ; bit 15 set: jumps when flag $1F02 (the ending ran) is set
    COP [07] ( #$8A01, &code_0205D2 ) ; bit 15 set: jumps when flag $0A01 (the Phoenix was called) is set; the farewell clears it
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_02062D )
    COP [15]
    COP [18] ( #18, &code_02058F ) ; item $18 = the Phoenix magic; jumps when it is missing, i.e. the call has not happened yet
    BRA loc_0205EF
}

---------------------------------------------
; The King's part of the call: the Phoenix magic and the way to the World of Evil.
; 
; When: the script waits here (COP 05 on flag $0004) whenever the Phoenix magic is missing.
; Sees: after flag $0004 input is blocked ($2F80 in joy_block_mask), then it waits for flag $0005 (the grandmas). Text '<name> received Magic of Phoenix!!', sound $5E, item $18 given (COP 0A), items $32, $33 and $34 taken (COP 0B), 61 frames of wait, the voice of the Phoenix ('I am the Phoenix. I live on the Mountain of Souls. I will help you revive the world and protect the peace. As soon as I was called, Deathtoll moved into position.'), flags $0A00 and $0A01 set, asset_skip_mask = $20 and COP 10 sends the hero to area $14 scene $03 (the World of Evil) at pixel ($00F8,$0128).
; Why: the call is the bridge to the World of Evil chapter.
; In: X = D = slot $0C.
; Out: RTL (input stays blocked; the area change resets it).
; Clobbers: A.

code_02058F {
    COP [05] ( #$0004 )
    LDA #$2F80
    TSB $joy_block_mask
    COP [05] ( #$0005 )
    COP [01] ( &asciistring_0209D4 )
    BRK #$5E
    COP [0A] ( #18 )
    COP [0B] ( #32 )      ; the three Red-Hot items ($32 Mirror, $33 Ball, $34 Stick) are taken for the call
    COP [0B] ( #33 )
    COP [0B] ( #34 )
    COP [03] ( #3D )
    COP [04]
    COP [01] ( &asciistring_02092A )
    COP [09] ( #$8A00 )   ; flag $0A00 is set here; it is bit number $50 of three FlagMapPatchTable rows at location $7B that ApplyFlagMapPatches reads at scene load
    COP [09] ( #$8A01 )
    LDA #$0020
    STA $asset_skip_mask
    COP [10] ( #$0314, #01, #$00F8, #$0128 ) ; area $14 scene $03 = the World of Evil (low byte is the area, high byte the scene)
    COP [91]
    RTL 
}

---------------------------------------------
; The King's farewell, once.
; 
; When: the script restarts with flag $0A01 set (the hero is back in the house after the call).
; Sees: input blocked, flag $0A01 cleared, 41 frames of wait, '<name>, return to the world of evil with the Phoenix. If you equip SoulBlade and Soul Armor the Phoenix will be able to help you. This is the final battle, the battle with Deathtoll. Please come back alive.', input released and the talk handler code_02062D set again.
; Why: the hint is given once because clearing $0A01 makes the branch fail afterwards.
; In: X = D = slot $0C.
; Out: RTL.
; Clobbers: A.

code_0205D2 {
    LDA #$2F80
    TSB $joy_block_mask
    COP [09] ( #$0A01 )
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_0209F2 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [17] ( &code_02062D )

  loc_0205EF:
    COP [91]
    RTL 
}

---------------------------------------------
; The epilogue of the ending, in the house.
; 
; When: flag $1F02 (set when the ending ran) is set and the script restarts.
; Sees: the two grandmas (slots $0A, $0B) are moved to tile ($00,$C9) and Nome (slot $12) to tile ($11,$37); input blocked ($BFC0 in joy_block_mask); 41 frames; the epilogue text ('Oh, you're back! Well, I wasn't worried, but---- Nome was really worried about you. Nome, say something. ... The King is such a thoughtless man. Dr-Leo has passed away. I miss him very much. There are creatures that only get one year to live. The value of life depends on the number of days spent with fulfillment. Maybe Dr-Leo's life was more fulfilled than many others.', with waits [0E:n]); 91 frames; asset_skip_mask = $20; COP 10 to area $06 scene $01 at pixel ($01F8,$0060); input released.
; Why: the closing scene of the house after the ending flag; what area $06 scene $01 is: OQ-I037-6.
; In: X = D = slot $0C.
; Out: RTL.
; Clobbers: A.

code_0205F2 {
    COP [11] ( #0A, #00, #C9 )
    COP [11] ( #0B, #00, #C9 )
    COP [11] ( #12, #11, #37 )
    LDA #$BFC0
    TSB $joy_block_mask
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_020AF6 )
    COP [03] ( #5B )
    COP [04]
    LDA #$0020
    STA $asset_skip_mask
    COP [10] ( #$0106, #01, #$01F8, #$0060 )
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

---------------------------------------------
; Talk handler of the King.
; 
; When: the hero talks to the King.
; Sees: flag $0705 clear (first talk): code_020676 shows 'You saved me? Thank you very much.', the apology about Nome ('I treated the snail, Nome, very poorly. ... I put him in prison. See Nome.'), the hint 'By the way, the prison guard has not yet been released. Release him and do not forget to visit those around him.' and the explanation of the Phoenix and the three Red-Hot items, and sets flag $0705. Later: Phoenix magic owned, 'The power of the Phoenix is tremendous. I fear that without it s power you will not defeat Deathtoll.' Magic missing (code_02063D): any of items $32, $33, $34 missing, code_020671 repeats the Phoenix explanation; all three present but lair $E1 or $E6 not released, 'Yes, you have collected the three symbols, but--- I need two very old magicians to help call the Phoenix. Find them and return to me.'; all conditions met: code_02065C.
; Why: the three items and the two grandmas are the conditions of the call.
; In: X = D = slot $0C.
; Out: RTL.
; Clobbers: A.

code_02062D {
    COP [07] ( #$0705, &code_020676 ) ; bit 15 clear: jumps when flag $0705 is clear, i.e. for the first thanks
    COP [18] ( #18, &code_02063D )
    COP [01] ( &asciistring_0208B1 )
    RTL 
}

code_02063D {
    COP [18] ( #32, &code_020671 )
    COP [18] ( #33, &code_020671 )
    COP [18] ( #34, &code_020671 )
    COP [14] ( #$00E1, &code_020654 )
    BRA loc_02066C
}

code_020654 {
    COP [14] ( #$00E6, &code_02065C )
    BRA loc_02066C
}

---------------------------------------------
; The King orders the call.
; 
; When: the hero talks to the King with items $32, $33, $34, both grandmas free and the Phoenix magic not yet owned.
; Sees: 'You made it! <name>, I shall call the Phoenix.', the talk handler is cleared (COP 17 with 0), COP 31 (music, byte $00) and flag $0004 is set; the grandmas start their arms and the King's own script (code_02058F) continues.
; In: X = D = slot $0C.
; Out: RTL.
; Clobbers: A.

code_02065C {
    COP [01] ( &asciistring_020904 )
    COP [17] ( #$0000 )
    COP [31] ( #00 )
    COP [09] ( #$8004 )
    RTL 

  loc_02066C:
    COP [01] ( &asciistring_020A83 )
    RTL 
}

code_020671 {
    COP [01] ( &asciistring_0207CF )
    RTL 
}

code_020676 {
    COP [01] ( &asciistring_0206AC )
    COP [09] ( #$8705 )
    RTL 
}

---------------------------------------------
; One-shot actor: the King's welcome after Poseidon, and a full heal.
; 
; When: spawned by COP 30 of the King when the hero comes home through lair record $103.
; Sees: if lair $E1 or $E6 is released, 'King, are you okay?' is shown (with waits); then COP 37 heals the hero and the actor kills itself (COP 86).
; Why: the heal comes after the Poseidon fight whether or not the text shows.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_obj_king_return_heal_02067F {
    COP [14] ( #$00E1, &code_02068D )
    COP [14] ( #$00E6, &code_02068D )
    BRA loc_020691
}

code_02068D {
    COP [01] ( &asciistring_020696 )

  loc_020691:
    COP [37]
    COP [86]
    RTL 
}

asciistring_020696 |[10][0E:1E]King, are you okay? [0E:3C][JMP:&shared_actor_helpers_bank4.asciistring_02251E+M]|

asciistring_0206AC |[10]You saved me? Thank [N]you very much- [FIN][JMP:&asciistring_020742]|

asciistring_0206C6 |By the way, the prison[N]guard has not yet been[N]released- [FIN]Release him and do not[N]forget to visit those [N]around him- [FIN][::]I believe you will [N]find what you are [N]looking for- [FIN][JMP:&asciistring_0207D3]|

asciistring_020742 |I treated the snail, [N]Nome, very poorly- [FIN]I would not trust all [N]of the things Nome was[N]saying- [FIN]He told me monsters [N]would invade our town-[N]I put him in prison- [FIN]See Nome- [N][JMP:&asciistring_0206C6+M]|

asciistring_0207CF |[10][JMP:&asciistring_0207D3+M]|

asciistring_0207D3 |By the way, [N][::]have you heard [N]of the Phoenix? [FIN]Whoever collects the [N]Master s three [N]symbols, [FIN]The Red+Hot Mirror, [FIN]The Red+Hot Ball and [FIN]The Red+Hot Stick, [FIN]shall have the Phoenix[N]help them- [FIN]That person will [N]inherit the strongest [N]power- [FIN]If you collect them [N]all bring them to me- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0208B1 |[10]The power of the [N]Phoenix is tremendous-[FIN]I fear that without [N]it s power you will [N]not defeat Deathtoll- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020904 |[10]You made it! [N][02:2], I shall [N]call the Phoenix- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_02092A |[10][0F]High above in the sky,[N]a beautiful voice [N]could be heard--- [FIN][0F]I am the Phoenix- [N]I live on the Mountain[N]of Souls- [FIN]I will help you revive[N]the world and protect [N]the peace- [FIN]As soon as I was [N]called, Deathtoll [N]moved into position- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0209D4 |[10][02:2] received [N][03:24]Magic of Phoenix!! [03:20][JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_0209F2 |[10][02:2], [N]return to the world of[N]evil with the Phoenix-[FIN]If you equip SoulBlade[N]and Soul Armor the [N]Phoenix will be able [N]to help you- [FIN]This is the final [N]battle, the battle [N]with Deathtoll- [FIN]Please come back [N]alive- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020A83 |[10]Yes, you have [N]collected the three [N]symbols, but--- [FIN]I need two very old [N]magicians to help call[N]the Phoenix- [FIN]Find them and return [N]to me- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020AF6 |[10][0F]Oh, you re back! [N][0E:5A]Well, I wasn t [N]worried, but---- [N][0E:28]Nome was really [N]worried about you- [N][0E:3C]Nome, [N]say something- [N][0E:78][10]--------- [N][0E:5A][0A]The█King█is█such█a[N]thoughtless█man-[N][0E:5A][10][0A]Dr-Leo has passed [N]away- [0E:28]I miss him very [N]much- [N][0E:5A]There are creatures [N]that only get one year[N]to live- [N][0E:5A]The value of life [N]depends on the number [N]of days spent with [N]fulfillment- [N][0E:5A]Maybe Dr-Leo s life [N]was more fulfilled [N]than many others- [N][0E:78][JMP:&shared_actor_helpers_bank4.asciistring_02251E+M]|
---------------------------------------------

; Mushroom $F6: tells the secret of the dreams.
; 
; When: placement script (type $1B, tile ($12,$1B)); COP 14 until lair record $F6 (the ice hill, Purple Wizards).
; Sees: puff, talk handler code_020C6F ('I'll tell you a secret. If you see a sleeping mushroom, return to the same place you saw in its dream.'), blocked tiles; then a loop of COP AD (wait until on screen) and animation $25.
; Why: a hint for the mushroom's dream (Dream Rod, walkthrough chapter 5).
; In: X = D = slot $0D.
; Out: loops for ever.
; Clobbers: A.

ms_npc_mushroom_dream_secret_020C53 {
    COP [14] ( #$00F6, &code_020C5A )
    RTL 
}

code_020C5A {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_020C6F )
    COP [15]

  loc_020C65:
    COP [AD] ( #08 )
    COP [80] ( #25 )
    COP [82]
    BRA loc_020C65
}

code_020C6F {
    COP [01] ( &asciistring_020C74 )
    RTL 
}

asciistring_020C74 |[10]I ll tell you a [N]secret- [FIN]If you see a sleeping [N]mushroom, return to [N]the same place you saw[N]in it s dream- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Boy $E9: gives the Mushroom Shoes.
; 
; When: placement script (type $1C, tile ($1E,$19)); COP 14 until lair record $E9 (top of Snow Mountain, Yetis).
; Sees: code_020CCD: COP 30 spawns ms_obj_boy_hooray_scene_020D65 when the hero comes home through that lair; puff; after two frames code_020CDF: scene flag $0007 set (the one-shot ran) falls through to a jump-for-joy (return_active is written with $FFFF, animations $04 / $05 with flip X, three frames of wait, animation $01). Flag clear (the normal visit) jumps to code_020D14: talk handler code_020D51, blocked tiles, wait for flag $0003 (the snail has spoken), then the boy unblocks, turns (animation $02), blocks input, waits 31 frames, says 'This snail always wants me to walk with it. Where shall we go today?', unblocks, clears flag $0003 and kills himself (COP 86).
; Why: the shoes are the key to the ice puzzles of the top of Snow Mountain.
; In: X = D = slot $0E.
; Out: RTL.
; Clobbers: A.

ms_npc_boy_mushroom_shoes_020CC6 {
    COP [14] ( #$00E9, &code_020CCD )
    RTL 
}

code_020CCD {
    COP [30] ( #$00E9, &ms_obj_boy_hooray_scene_020D65, #04 ) ; returned from lair $E9: spawns the one-shot with the 'Hooray' text
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [1B] ( &code_020CDF, #$0002 )
}

code_020CDF {
    COP [07] ( #$0007, &code_020D14 ) ; bit 15 clear: jumps when flag $0007 is clear (the one-shot has not run): the normal visit
    LDA #$FFFF
    STA $return_active
    COP [80] ( #04 )
    COP [82]
    COP [03] ( #03 )
    COP [97]
    COP [81] ( #05, #02 )
    COP [83]
    COP [96]
    COP [81] ( #05, #02 )
    COP [83]
    COP [04]
    COP [97]
    COP [80] ( #05 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    COP [91]
    RTL 
}

code_020D14 {
    COP [17] ( &code_020D51 )
    COP [15]
    COP [05] ( #$0003 )   ; flag $0003 is set by the snail's first talk handler (code_020F51)
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [96]
    COP [80] ( #02 )
    COP [82]
    LDA #$2F80
    TSB $joy_block_mask
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_020EB9 )
    COP [16]
    COP [80] ( #26 )
    COP [82]
    COP [09] ( #$0003 )
    LDA #$2F80
    TRB $joy_block_mask
    COP [86]
    RTL 
}

---------------------------------------------
; Talk handler of the boy $E9: the Mushroom Shoes.
; 
; When: the hero talks to the boy.
; Sees: COP 18 on item $22: missing, code_020D5B shows 'I will give you my Mushroom Shoes. There is snail goo on the bottom of these shoes. If you wear these you will not slip on the ice. You will still slip on the slopes though. <name>, received Mushroom Shoes', sound $5E and gives item $22 (COP 0A). Owned: 'How do you like my Mushroom Shoes? My people make clothing and shoes from mushrooms.'
; Why: the text says the push zones of the slopes (ms_obj_push_zone_setup_02220D) are not stopped by the shoes.
; In: X = D = slot $0E.
; Out: RTL.
; Clobbers: A.

code_020D51 {
    COP [18] ( #22, &code_020D5B )
    COP [01] ( &asciistring_020E72 )
    RTL 
}

code_020D5B {
    COP [01] ( &asciistring_020DDC )
    BRK #$5E
    COP [0A] ( #22 )
    RTL 
}

---------------------------------------------
; One-shot actor: the boy's thanks after the lair.
; 
; When: spawned by COP 30 of the boy when the hero returns through lair record $E9.
; Sees: scene flag $0007 is set, the text 'Hooray! I am back! I am back! Thank you very much. I will give you these Mushroom Shoes if you return to me. You will be able to walk on ice!' is shown, return_active is cleared (STZ) and the actor kills itself.
; Why: the text announces the gift of the boy's talk handler.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_obj_boy_hooray_scene_020D65 {
    COP [09] ( #$8007 )
    COP [01] ( &asciistring_020D73 )
    STZ $return_active
    COP [86]
    RTL 
}

asciistring_020D73 |[10][0E:28]Hooray! I am back! [N]I am back! [0E:B4][N]Thank you very much- [FIN]I will give you these [N]Mushroom Shoes if you [N]return to me- [FIN]You will be able to [N]walk on ice! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020DDC |[10]I will give you my [N]Mushroom Shoes- [FIN]There is snail goo on [N]the bottom of these [N]shoes- [FIN]If you wear these you [N]will not slip on the [N]ice- [FIN]You will still slip on[N]the slopes though- [FIN][02:2], received [N][03:24]Mushroom Shoes- [03:20][JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020E72 |[10]How do you like my [N]Mushroom Shoes? [FIN]My people make [N]clothing and shoes [N]from mushrooms- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020EB9 |[10]This snail always [N]wants me to walk with [N]it- [FIN]Where shall we go [N]today? [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Snail $F7: the boy's snail.
; 
; When: placement script (type $1D, tile ($1F,$19)); COP 3B captive until lair record $F7 (the ice hill, Purple Wizards).
; Sees: plea; after the release code_020EFF: puff, talk handler code_020F51 ('Week, week!', sets scene flag $0003), blocked tiles; the script waits for flag $0003 to be set and then cleared (the boy answers), plays animation $18 and sets the talk handler code_020F5A ('Let's go!', then the handler becomes code_020F66 'This is our vehicle.') whose COP 27 continues at code_020F1E, a walking loop (animations $1C, $1D, $1B with flip X) for ever.
; Why: the snail starts the little scene in which the boy answers and leaves.
; In: X = D = slot $0F.
; Out: loops for ever.
; Clobbers: A.

ms_npc_snail_vehicle_020EE9 {
    COP [3B] ( #$00F7, &code_020EFF )
    COP [17] ( &shared_actor_helpers_bank4.cm_npc_captive_plea_02229E )
    SEP #$20
    LDA #$^engine_player_death_and_actor_helpers.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_player_death_and_actor_helpers.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_020EFF {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_020F51 )
    COP [15]
    COP [05] ( #$0003 )
    COP [05] ( #$8003 )
    COP [80] ( #18 )
    COP [82]
    COP [17] ( &code_020F5A )
    COP [91]
    RTL 
}

code_020F1E {
    COP [16]

  loc_020F20:
    COP [80] ( #1C )
    COP [82]
    COP [97]
    COP [81] ( #1D, #07 )
    COP [83]
    COP [81] ( #1B, #0B )
    COP [83]
    COP [96]
    COP [81] ( #1D, #09 )
    COP [83]
    COP [81] ( #1C, #06 )
    COP [83]
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [81] ( #1C, #04 )
    COP [83]
    BRA loc_020F20
}

code_020F51 {
    COP [01] ( &asciistring_020F6B )
    COP [09] ( #$8003 )
    RTL 
}

code_020F5A {
    COP [01] ( &asciistring_020F7B )
    COP [17] ( &code_020F66 )
    COP [27] ( &code_020F1E )
}

code_020F66 {
    COP [01] ( &asciistring_020F88 )
    RTL 
}

asciistring_020F6B |[10]Week, week! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020F7B |[10]Let s go! [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020F88 |[10]This is our vehicle- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|
---------------------------------------------

; Mushroom $DD: the sleeping mushroom whose dream is entered with the Dream Rod.
; 
; When: placement script (type $1E, tile ($12,$2B)); COP 3B captive until lair record $DD (Lune lake, Green Blobs).
; Sees: plea; after the release code_020FB1: puff, talk handler code_020FC4, blocked tiles, animation $25. The handler uses COP 19 on item $1C (must be equipped): not equipped, 'Zzzzz'; equipped, '<name> placed the Dream Rod on the mushroom.', transition type 4 (COP 3C) and COP 10 to area $0B scene $06 (the mushroom's dream, A0BS06) at pixel ($0200,$02F0).
; Why: the walkthrough: speak with the mushroom in the westernmost cell while the Dream Rod is equipped.
; In: X = D = slot $10.
; Out: RTL.
; Clobbers: A.

ms_npc_mushroom_dream_rod_020F9B {
    COP [3B] ( #$00DD, &code_020FB1 )
    COP [17] ( &shared_actor_helpers_bank4.cm_npc_captive_plea_02229E )
    SEP #$20
    LDA #$^engine_player_death_and_actor_helpers.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_player_death_and_actor_helpers.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_020FB1 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_020FC4 )
    COP [15]
    COP [80] ( #25 )
    COP [82]
    COP [91]
    RTL 
}

code_020FC4 {
    COP [19] ( #1C, &code_020FDA ) ; item $1C = the Dream Rod; jumps when it is not equipped
    COP [01] ( &asciistring_020FE9 )
    COP [3C] ( #04 )
    COP [10] ( #$060B, #01, #$0200, #$02F0 )
    RTL 
}

code_020FDA {
    COP [01] ( &asciistring_020FDF )
    RTL 
}

asciistring_020FDF |[10]Zzzzz [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|

asciistring_020FE9 |[10][02:2] placed [N]the Dream Rod on the [N]mushroom- [JMP:&shared_actor_helpers_bank4.asciistring_02251E]|