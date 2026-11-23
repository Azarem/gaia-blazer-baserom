; The first half of the Seabed Sanctuary actors (file offsets 1015808-1019224, SNES $1F:8000-$8D57): the freed mermaids and angelfish of the Seabed Sanctuary (world 2, St. Elles), the three statues of the first passages, the Bubble Armor mermaid and the east guard. The second half is in se_seabed_sanctuary_actors_0F8D58.
; 
; === WHAT RUNS HERE ===
; Every root is a placement script of a creature that the player frees from a Monster Lair of the seabed: the script is started when the scene is built and decides on the lair record (the switch number) what the actor does. All released creatures have home location $29 (the Seabed Sanctuary) in LairRecords.
; - COP 3B (switch, &code) is the 'captive' root ($7C Servas, $83 the jumping angelfish, $C2 Anna, $A5 Kanna, $8B Nanna, $BE the angelfish of the reef): while the lair is not released the actor shows the plea of w2_shared_0FA945 (w2_npc_caged_plea, the talk handler is set by COP 17) and waits in HoldActorUntilReleased; when the lair is cleared and released it continues at &code with the appear puff.
; - COP 14 (switch, &code) is the 'already free' root ($B1 Soul of Shield, $84, $86, $99, $8D, $AD, $92, $95, $9B, $9D, $A1, $A4): the actor does nothing (RTL) until switch $n of $1ADE is set, then continues at &code.
; - COP 30 (switch, &code, $1F) in the statue roots and in the Soul of Shield root: when the player came back from a lair trip through this record (return_active and return_record) a one-shot actor is spawned at &code instead of the normal behaviour: the text 'hears a small voice' (statues) or the promise of the Soul of Shield.
; - All talk handlers are set with COP 17 (own $30) and run when the player talks; most end with RTL, the texts end with a [JMP] into asciistring_0FAA44 of w2_shared_0FA945 (the common end of a dialogue).
; 
; === ROSTER (root: switch, who, what the player gets or sees) ===
; - se_npc_dolphin_servas_dream_0F8000: switch $7C. Servas the dolphin, napping. Equipped Dream Rod (item $1C): 'placed the Dream Rod on the dolphin's nose' and the player enters Servas's dream (A09S02, the ghost ship). Without the rod: 'Zzzzz'. After the dream (flag $0704): 'I always have the same dream. Isn't that strange!'.
; - se_npc_angelfish_soul_of_shield_0F80A4: switch $B1. The angelfish that is the Soul of Shield: talks, then sets bit $04 of souls_flags. On the return trip it only promises help against the Magma Rain.
; - se_npc_angelfish_jumper_0F8209: switch $83. Jumps out of the water in a loop; talking: 'Please don't talk to me while I'm jumping, I will not be able to breathe.'; after release 'I didn't know the world under water looked different from the world above.'
; - se_npc_mermaid_medical_herb_0F82DD: switch $84. Offers a Medical Herb (item $38) through a Yes / No menu and gives it only when the hero has none ('Come back to me when you don't have one.'); with one in the bag: 'Medical herbs are really rare, I can't give you many.'
; - se_npc_angelfish_best_jumper_0F83AD: switch $86. 'I am the best jumper! I'll show you.' and she jumps once (flag $0007).
; - se_npc_mermaid_dance_teacher_0F8446: switch $99, with the dancers Anna ($C2), Kanna ($A5) and Nanna ($8B). When the three are free she dances and the player may join (flag $0003 starts the three dancers).
; - se_npc_statue_blester_path_0F87A9 / se_npc_statue_rockbird_path_0F8A7E (and in the second half the Durean and ghost ship statues): the four mermaid statues of the Sanctuary. Talking: 'I will open a passage for you' and the hero is moved to the seabed scene A07S01 (flag $0903 marks the trip).
; - se_npc_angelfish_coral_reef_creek_0F8850 ($AD) and se_npc_angelfish_coral_reef_monsters_0F88CC ($BE): hints: the creek passage of the coral reef, and the dangerous monsters of the reef ('make sure to use magic there').
; - se_npc_mermaid_queens_maid_0F8941 ($92): 'This used to be the Queen's palace. I am the Queen's maid.' After the Queen's lair ($B6) is cleared she moves aside; after the ending (flag $1F02) she is gone.
; - se_npc_mermaid_servas_friend_0F89CF ($95): 'Servas is the name of my friend the dolphin.'
; - se_npc_dolphin_four_statues_0F8A0E ($9B): 'There used to be 4 mermaid statues in this place. Those statues prevented all creatures from getting lost.'
; - se_npc_mermaid_bubble_armor_0F8B6A ($A1): gives the Bubble Armor (item $0B) once; afterwards she heals the hero when he is hurt. se_obj_tears_chest_opener_0F8C9A is a helper that opens the chest of the Mermaid's Tears.
; - se_npc_mermaid_guard_east_0F8CCB ($A4): the east guard of the Queen's palace: 'Sorry, I have orders from the Queen not to let anyone pass.'
; 
; === EVENT FLAGS ===
; $0003 dance start (set by the teacher), $0007 the best jumper jumps, $0405 the Bubble Armor was given, $0406 / $0407 / $0500 / $0501 the passage of the Rockbird / Blester / Durean / ghost ship statue was used (set by the gate actors in se_seabed_of_st_elles_actors, never cleared by a script), $0503 the volcano of Durean is out, $0704 Servas has had the dream, $0701 the Soul of Shield has joined, $0903 a statue trip is running, $1F02 the ending was run, $0A02 the chest of the Mermaid's Tears is open.
; 
; === OPEN ===
; The Magma Rain, the Soul of Shield and the Bubble Armor are named by the walkthrough chapter 4; the texts above are the ROM spelling (apostrophes and full stops are printed as a space and a dash in the extracted strings).
---------------------------------------------

?BANK 1F

?INCLUDE 'engine_003005'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'shared_choice_prompt_texts'
?INCLUDE 'w2_shared_0FA945'

!L_choice_result                0003D0
!joy_block_mask                 0326
!asset_skip_mask                03B4
!souls_flags                    1B82
!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

; Servas the dolphin of the Sanctuary (switch $7C): the entrance to Servas's dream.
; 
; When: placement script, started when the Seabed Sanctuary is built.
; Sees: COP 3B: while lair record $7C is not released he shows the plea of w2_shared_0FA945 and is held by HoldActorUntilReleased; once released, the appear puff, the body blocks its tiles (COP 15), animation $11 in a loop, the talk handler is code_0F8029.
; Why: the dream is the way to the ghost ship, so the dolphin is the captive of a lair first.
; In: X = D = actor slot (COP entry).
; Out: RTL back to the dispatcher; the actor stays in HoldActorUntilReleased until the release.
; Clobbers: A, P (X kept).

se_npc_dolphin_servas_dream_0F8000 {
    COP [3B] ( #$007C, &code_0F8016 )
    COP [17] ( &w2_shared_0FA945.w2_npc_caged_plea_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F8016 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [17] ( &code_0F8029 )

  loc_0F8021:
    COP [80] ( #11 )
    COP [82]
    BRL loc_0F8021
}

---------------------------------------------
; Talk handler of Servas: three cases.
; 
; When: the player talks to the dolphin.
; Sees: flag $0704 set: 'I always have the same dream. Isn't that strange!'. Dream Rod (item $1C) not equipped: 'Zzzzz'. Dream Rod equipped: '[the hero] placed the Dream Rod on the dolphin's nose', transition type 4 and COP 10 to A09S02 (the dream on the ghost ship) at pixel ($78,$410).
; Why: the rod must be equipped, not only owned (COP 19), which is the walkthrough instruction 'equip the Dream Rod and speak with the dude'.
; In: X = D = slot (called through $30).
; Out: RTL.
; Clobbers: A.

code_0F8029 {
    COP [07] ( #$8704, &code_0F804A ) ; flag $0704 is set by the son in Servas's dream (se_npc_servas_son_0FA23B): afterwards the dolphin only repeats that he always has the same dream
    COP [19] ( #1C, &code_0F8045 )
    COP [01] ( &asciistring_0F8059 )
    COP [3C] ( #04 )
    COP [10] ( #$0209, #01, #$0078, #$0410 ) ; A09S02, the dream (the ghost ship before it sank), arrival pixel ($78,$410); transition type 4 was set by COP 3C
    RTL 
}

code_0F8045 {
    COP [01] ( &asciistring_0F804F )
    RTL 
}

code_0F804A {
    COP [01] ( &asciistring_0F8080 )
    RTL 
}

asciistring_0F804F |[10]Zzzzz [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8059 |[10][02:2] placed [N]the Dream Rod on [N]the dolphin s nose- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8080 |[10]I always have the same[N]dream- Isn t that [N]strange! [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; The angelfish that is the Soul of Shield (switch $B1).
; 
; When: placement script of the scene.
; Sees: COP 14: nothing until switch $B1 is set; then COP 30 spawns code_0F8108 when the hero returned from its lair; otherwise the creature swims (animations $13 / $14 with a flip), talk handler code_0F80DC. Flag $0701 set: the puff and the actor ends (code_0F80D4).
; Why: the Soul of Shield joins the hero here and protects against the Magma Rain (text of the promise).
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_angelfish_soul_of_shield_0F80A4 {
    COP [14] ( #$00B1, &code_0F80AB )
    RTL 
}

code_0F80AB {
    COP [30] ( #$00B1, &code_0F8108, #1F )
    COP [07] ( #$8701, &code_0F80D4 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F80DC )

  loc_0F80C1:
    COP [81] ( #14, #02 )
    COP [83]
    COP [87]
    COP [81] ( #13, #02 )
    COP [83]
    COP [87]
    BRL loc_0F80C1
}

code_0F80D4 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [86]
    RTL 
}

---------------------------------------------
; Talk handler of the Soul of Shield: the speech and the join.
; 
; When: the hero talks to the free angelfish.
; Sees: the angelfish says it comes from the sky like the hero, will protect from the Magma and asks to protect all creatures; the last page: 'The creature that enables you to avoid Magma has joined you.' Then bit $04 of souls_flags is set, flag $0701 is set, a sound (BRK #$4E) plays and the actor leaves through code_0F80D4 (puff and kill).
; Why: the souls_flags bit is what the game tests for the Soul of Shield.
; In: X = D = slot (via $30); the text is shown with $16 bit $0010 cleared (the actor is not blocking) and restored afterwards.
; Out: sets souls_flags (SEP #$20 and REP #$20 around it); continues in code_0F80D4 through COP 27.
; Clobbers: A.

code_0F80DC {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0F814A )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    SEP #$20
    LDA $souls_flags
    ORA #$04              ; souls_flags bit $04 = Soul of Shield
    STA $souls_flags
    REP #$20
    COP [09] ( #$8701 )
    BRK #$4E
    COP [27] ( &code_0F80D4 )
}

---------------------------------------------
; One-shot actor for the return trip of the lair $B1.
; 
; When: spawned by COP 30 when the hero returns from lair $B1.
; Sees: 'I have the power to stop the Magma Rain. I will help you if you return to me.' (with the 60 frame pause of [0E:3C]) and the actor kills itself.
; In: X = D = slot of the new actor.
; Out: RTL.
; Clobbers: A.

code_0F8108 {
    COP [01] ( &asciistring_0F810F )
    COP [86]
    RTL 
}

asciistring_0F810F |[10][0E:3C]I have the power to [N]stop the Magma Rain- [N]I will help you if you[N]return to me- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F814A |[10]Even though I don t [N]look like it, I am [N]from the sky just like[N]you- [FIN]I will protect you [N]from the Magma- [FIN]Please try and protect[N]all creatures- [FIN]Let s work together so[N]we may revive the [N]world! [FIN]The creature that [N]enables you to avoid [N]Magma has joined you- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; The jumping angelfish (switch $83).
; 
; When: placement script.
; Sees: COP 3B captive plea until release; then a loop: drawn in front (COP A3), animation $12, a splash actor (se_effect_jump_splash_0F824F) at the start and at the end of the jump (animation $1F), draw order restored (COP A6), animation $12 twice and a horizontal flip. The talk handler is code_0F826B ('Please don't talk to me while I'm jumping...') until the first jump is over and code_0F8266 ('I didn't know the world under water looked different...') afterwards.
; Why: purely decorative life of the Sanctuary; the splash marks where it leaves and re-enters the water.
; In: X = D = slot.
; Out: RTL (the loop yields in COP 82 / 83 / 87).
; Clobbers: A.

se_npc_angelfish_jumper_0F8209 {
    COP [3B] ( #$0083, &code_0F821F )
    COP [17] ( &w2_shared_0FA945.w2_npc_caged_plea_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F821F {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F826B )
    COP [80] ( #12 )
    COP [82]

  loc_0F822D:
    COP [A3]
    COP [84] ( @se_effect_jump_splash_0F824F )
    COP [80] ( #1F )
    COP [82]
    COP [84] ( @se_effect_jump_splash_0F824F )
    COP [A6]
    COP [17] ( &code_0F8266 )
    COP [81] ( #12, #02 )
    COP [83]
    COP [87]
    BRL loc_0F822D
}

---------------------------------------------
; The splash of a jump: a short effect actor.
; 
; When: spawned (COP 84) at the start and the end of the angelfish jump.
; Sees: sets $16 = $0310 (drawn in front, not blocking), animation $2A, plays it once and kills itself.
; In: X = D = slot of the new effect.
; Out: RTL after COP 86.
; Clobbers: A.

se_effect_jump_splash_0F824F {
    LDA #$0310
    STA $0016, X
    LDA #$002A
    STA $001E, X
    STZ $0020, X
    COP [80] ( #2A )
    COP [82]
    COP [86]
    RTL 
}

code_0F8266 {
    COP [01] ( &asciistring_0F8270 )
    RTL 
}

code_0F826B {
    COP [01] ( &asciistring_0F82A8 )
    RTL 
}

asciistring_0F8270 |[10]I didn t know the [N]world under water [N]looked different from [N]the world above- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F82A8 |[10]Please don t talk to [N]me while I m jumping, [N]I will not be able to [N]breathe- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; The herb mermaid (switch $84).
; 
; When: placement script; COP 14 until the lair record $84 is released.
; Sees: standing with animation $06; talk handler code_0F82F2.
; Why: a one-herb-at-a-time source of the Medical Herb (item $38) in the Sanctuary.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_medical_herb_0F82DD {
    COP [14] ( #$0084, &code_0F82E4 )
    RTL 
}

code_0F82E4 {
    COP [17] ( &code_0F82F2 )
    COP [15]
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

---------------------------------------------
; Talk handler of the herb mermaid: Yes / No menu.
; 
; When: the hero talks.
; Sees: 'Hello, I have some Medical Herbs made from seaweed. Would you like one?' with the Yes / No menu. No (or cancel): 'Come see me when you need another.' Yes: COP 18 tests item $38; when the hero has none the farewell 'Come back to me when you don't have one.' is shown, a sound (BRK #$5E) plays and COP 0A gives the herb; when he already has one: 'Medical herbs are really rare, I can't give you many.'
; Why: the herb is only given when the hero carries none.
; In: X = D = slot; the menu result is in L_choice_result ($03D0).
; Out: RTL.
; Clobbers: A.

code_0F82F2 {
    COP [01] ( &asciistring_0F831C )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &code_0F8317 )
    LDA $L_choice_result
    BNE code_0F8317
    COP [18] ( #38, &code_0F830D )
    COP [01] ( &asciistring_0F836C )
    RTL 
}

code_0F830D {
    COP [01] ( &asciistring_0F8355 )
    BRK #$5E
    COP [0A] ( #38 )
    RTL 
}

code_0F8317 {
    COP [01] ( &asciistring_0F8395 )
    RTL 
}

asciistring_0F831C |[10]Hello, I have some [N]Medical Herbs made [N]from seaweed- [N]Would you like one? [END]|

asciistring_0F8355 |[10]Come back to me [N]when you don t have [N]one- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F836C |[10]Medical herbs are [N]really rare- [N]I can t give you many-[JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8395 |[10]Come see me when you [N]need another- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; The 'best jumper' angelfish (switch $86).
; 
; When: placement script; COP 14 until released.
; Sees: swims with animations $13 / $14 (4 repeats each); the talk handler code_0F841B sets flag $0007; the loop then notices the flag and runs code_0F83D6, the jump.
; Why: a visual joke: the fish promises to show the jump and does it.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_angelfish_best_jumper_0F83AD {
    COP [14] ( #$0086, &code_0F83B4 )
    RTL 
}

code_0F83B4 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F841B )

  loc_0F83BD:
    COP [81] ( #13, #04 )
    COP [83]
    COP [07] ( #$8007, &code_0F83D6 ) ; flag $0007 is set by the talk handler code_0F841B: the angelfish then does one show jump (code_0F83D6) and clears it

  loc_0F83C9:
    COP [87]
    COP [81] ( #14, #04 )
    COP [83]
    COP [87]
    BRL loc_0F83BD
}

---------------------------------------------
; The show jump of the best jumper.
; 
; When: flag $0007 is set by the talk handler.
; Sees: clears the talk handler, waits $3D frames (loop count of COP 03 / 04), sound BRK #$56, priority $30 and drawn in front, splash, animation $15, splash again, priority $20, clears flag $0007 and sets the talk handler again.
; In: X = D = slot.
; Out: BRA back into the swim loop.
; Clobbers: A.

code_0F83D6 {
    COP [17] ( #$0000 )
    COP [03] ( #3D )
    COP [04]
    BRK #$56
    COP [A2] ( #30 )
    COP [A3]
    COP [84] ( @se_effect_jump_splash_0F8404 )
    COP [80] ( #15 )
    COP [82]
    COP [84] ( @se_effect_jump_splash_0F8404 )
    COP [A6]
    COP [A2] ( #20 )
    COP [09] ( #$0007 )
    COP [17] ( &code_0F841B )
    BRA loc_0F83C9
}

se_effect_jump_splash_0F8404 {
    LDA #$0310
    STA $0016, X
    LDA #$002A
    STA $001E, X
    STZ $0020, X
    COP [80] ( #2A )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Talk handler of the best jumper: 'I am the best jumper! I'll show you.' and flag $0007 is set (the show jump).
; 
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0F841B {
    COP [01] ( &asciistring_0F8424 )
    COP [09] ( #$8007 )
    RTL 
}

asciistring_0F8424 |[10]I am the best jumper! [N]I ll show you- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; The dance teacher (switch $99).
; 
; When: placement script; COP 14 until the lair $99 is released.
; Sees: the appear puff; COP 14 on the three students $C2, $A5 and $8B (any missing: the hint code_0F848E; all three free: code_0F8493); she blocks her tiles and stands (animation $06).
; Why: the three dancers must be freed before she dances.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_dance_teacher_0F8446 {
    COP [14] ( #$0099, &code_0F844D )
    RTL 
}

code_0F844D {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [14] ( #$00C2, &code_0F845B ) ; the teacher counts her students by their switches: $C2 Anna, $A5 Kanna, $8B Nanna; any one missing leaves her with the hint text
    BRL loc_0F8474
}

code_0F845B {
    COP [14] ( #$00A5, &code_0F8464 )
    BRL loc_0F8474
}

code_0F8464 {
    COP [14] ( #$008B, &code_0F846D )
    BRL loc_0F8474
}

code_0F846D {
    COP [17] ( &code_0F8493 )
    BRL loc_0F8478

  loc_0F8474:
    COP [17] ( &code_0F848E )

  loc_0F8478:
    COP [15]
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

---------------------------------------------
; The dance of the teacher: sets flag $0003 (the three students start dancing), animation $06 and ends. Talk handler set by code_0F8493 through COP 27.
; 
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_dance_teacher_dancing_0F8482 {
    COP [09] ( #$8003 )   ; flag $0003 starts the three dancers: they wait for it in a COP 07 loop
    COP [91]
    COP [80] ( #06 )
    COP [82]
    RTL 
}

code_0F848E {
    COP [01] ( &asciistring_0F849B )
    RTL 
}

---------------------------------------------
; Talk handler of the teacher when all three students are free.
; 
; When: the hero talks to the teacher with $C2, $A5 and $8B released.
; Sees: 'Thank you very much. Three of my students came back. I was going to show you our dance. I think it will be more fun if you join us. I will show you the easiest dance, just move like they do.' then COP 27 continues in se_npc_mermaid_dance_teacher_dancing_0F8482.
; In: X = D = slot.
; Out: yields (COP 27) into the dance actor.
; Clobbers: A.

code_0F8493 {
    COP [01] ( &asciistring_0F84F1 )
    COP [27] ( &se_npc_mermaid_dance_teacher_dancing_0F8482 )
}

asciistring_0F849B |[10]Mermaids have to be [N]very good at dancing- [FIN]If three of my [N]students return, I [N]will show you our [N]great dance- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F84F1 |[10]Thank you very much- [N]Three of my students [N]came back- [FIN]I was going to show [N]you our dance-I think [N]it will be more fun if[N]you join us- [FIN]I will show you the [N]easiest dance, just [N]move like they do- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; Anna, one of the Queen's dancers (switch $C2).
; 
; When: placement script (COP 3B captive).
; Sees: after release waits (animation $01) while flag $0003 is clear, then dances: animations $03 and $04 in a loop. The talk handler: 'My name is Anna. I am one of the Queen's dancers.'
; Why: the flag is set by the teacher.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_anna_0F8577 {
    COP [3B] ( #$00C2, &code_0F858D )
    COP [17] ( &w2_shared_0FA945.w2_npc_caged_plea_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F858D {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F85B2 )
    COP [15]

  code_0F8598:
    COP [80] ( #01 )
    COP [82]
    COP [07] ( #$0003, &code_0F8598 )
    COP [16]

  loc_0F85A5:
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #04 )
    COP [82]
    BRL loc_0F85A5
}

code_0F85B2 {
    COP [01] ( &asciistring_0F85B7 )
    RTL 
}

asciistring_0F85B7 |[10]My name is Anna- [N]I am one of the [N]Queen s dancers- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; Kanna, one of the Queen's dancers (switch $A5).
; 
; When: placement script (COP 3B captive).
; Sees: same dance as Anna. Talk handler code_0F861C: before the volcano of Durean is out she tells the secret: 'No armor will protect you against the Magma off the volcanic island, Durean. You must find a way to stop the volcano.' With flag $0503 set: 'You have seized the volcano, right? You are a very brave person.'
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_kanna_0F85E1 {
    COP [3B] ( #$00A5, &code_0F85F7 )
    COP [17] ( &w2_shared_0FA945.w2_npc_caged_plea_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F85F7 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F861C )
    COP [15]

  code_0F8602:
    COP [80] ( #01 )
    COP [82]
    COP [07] ( #$0003, &code_0F8602 )
    COP [16]

  loc_0F860F:
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #04 )
    COP [82]
    BRL loc_0F860F
}

code_0F861C {
    COP [07] ( #$8503, &code_0F8627 ) ; flag $0503 = the volcano of Durean is out (set by se_obj_durean_tears_spot_0FA5FA)
    COP [01] ( &asciistring_0F862C )
    RTL 
}

code_0F8627 {
    COP [01] ( &asciistring_0F86E3 )
    RTL 
}

asciistring_0F862C |[10]My name is Kanna- [N]I am one of the [N]Queen s dancers- [FIN]As a reward for saving[N]us I will tell you a [N]secret- [FIN]No armor will protect [N]you against the Magma [N]off the volcanic [N]island, Durean- [FIN]You must find a way to[N]stop the volcano- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F86E3 |[10]My name is Kanna- [N]I am one of the [N]Queen s dancers- [FIN]You have seized the [N]volcano, right? [N]You are a very brave [N]person- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; Nanna, one of the Queen's dancers (switch $8B).
; 
; When: placement script (COP 3B captive).
; Sees: same dance as Anna; talk handler: 'My name is Nanna. I am one of the Queen's dancers.'
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_nanna_0F873E {
    COP [3B] ( #$008B, &code_0F8754 )
    COP [17] ( &w2_shared_0FA945.w2_npc_caged_plea_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F8754 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F8779 )
    COP [15]

  code_0F875F:
    COP [80] ( #01 )
    COP [82]
    COP [07] ( #$0003, &code_0F875F )
    COP [16]

  loc_0F876C:
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #04 )
    COP [82]
    BRL loc_0F876C
}

code_0F8779 {
    COP [01] ( &asciistring_0F877E )
    RTL 
}

asciistring_0F877E |[10]My name is Nanna- [N]I am one of the [N]Queen s dancers- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; The mermaid statue of the passage to Blester (switch $8D).
; 
; When: placement script; COP 14 until the lair $8D is released.
; Sees: COP 30 spawns code_0F87F9 when the hero returns from the lair; each frame it tests whether the hero (slot 0) stands on tile ($22,$1C) (COP 91 then COP 0D); if so code_0F87C5 moves him to tile ($23,$1E), shows the player actors again (COP 33) and unblocks the pad. Talk handler code_0F87D5.
; Why: the gate on the seabed side (se_obj_statue_gate_blester_0F9F24) returns the hero to pixel ($220,$1C0), which is tile ($22,$1C), with the player actors hidden and the pad blocked; code_0F87C5 undoes both and steps him off the statue.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_statue_blester_path_0F87A9 {
    COP [14] ( #$008D, &code_0F87B0 )
    RTL 
}

code_0F87B0 {
    COP [30] ( #$008D, &code_0F87F9, #1F )
    COP [17] ( &code_0F87D5 )
    COP [91]
    COP [0D] ( #00, #22, #1C, &code_0F87C5 )
    RTL 
}

code_0F87C5 {
    COP [11] ( #00, #23, #1E )
    COP [33]
    LDA #$EF80
    TRB $joy_block_mask
    COP [91]
    RTL 
}

---------------------------------------------
; Talk handler of the Blester statue: the passage.
; 
; When: the hero talks to the statue.
; Sees: 'I will open a passage for you. Travel up the seabed to reach the island of rain, Blester.' If flag $0407 is set the script ends. Otherwise the pad is blocked (joy_block_mask), asset_skip_mask = $0020, flag $0903 is set and COP 10 moves the hero to A07S01 at pixel ($6A0,$40).
; Why: flag $0407 is set by the gate on the seabed side; see se_obj_statue_gate_blester_0F9F24.
; In: X = D = slot.
; Out: the scene change.
; Clobbers: A.

code_0F87D5 {
    COP [01] ( &asciistring_0F8800 )
    COP [07] ( #$8407, &code_0F87F8 ) ; flag $0407 is set by the gate on the seabed side once the passage was used; the statue then does not warp again
    LDA #$EF80
    TSB $joy_block_mask
    LDA #$0020
    STA $asset_skip_mask
    COP [09] ( #$8903 )
    COP [10] ( #$0107, #02, #$06A0, #$0040 )
}

code_0F87F8 {
    RTL 
}

---------------------------------------------
; One-shot actor for the return trip of the statue lair: 'hears a small voice. I will open the passage for you, return to me.' and kills itself.
; 
; In: X = D = slot of the new actor.
; Out: RTL.
; Clobbers: A.

code_0F87F9 {
    COP [01] ( &asciistring_0F8B27 )
    COP [86]
    RTL 
}

asciistring_0F8800 |[10]I will open a passage [N]for you- [FIN]Travel up the seabed [N]to reach the island of[N]rain, Blester- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; Hint angelfish of the creek (switch $AD).
; 
; When: placement script; COP 14 until released.
; Sees: swims with animation $12 (4 repeats); talk: 'If you travel the coral reef you will find a passage to a small creek.'
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_angelfish_coral_reef_creek_0F8850 {
    COP [14] ( #$00AD, &code_0F8857 )
    RTL 
}

code_0F8857 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F886A )

  loc_0F8860:
    COP [81] ( #12, #04 )
    COP [83]
    COP [87]
    BRA loc_0F8860
}

code_0F886A {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [01] ( &asciistring_0F8881 )
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    RTL 
}

asciistring_0F8881 |[10][0A]If█you█travel[N]the█coral█reef█you[N]will█find█a█passage█to[N]a█small█creek-[JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; Hint angelfish of the coral reef (switch $BE).
; 
; When: placement script (COP 3B captive).
; Sees: swims like the creek angelfish; talk: 'The coral reef hides many dangerous monsters. Make sure to use magic there.'
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_angelfish_coral_reef_monsters_0F88CC {
    COP [3B] ( #$00BE, &code_0F88E2 )
    COP [17] ( &w2_shared_0FA945.w2_npc_caged_plea_0FA95A )
    SEP #$20
    LDA #$^engine_003005.HoldActorUntilReleased
    PHA 
    REP #$20
    LDA #$&engine_003005.HoldActorUntilReleased-1
    PHA 
    RTL 
}

code_0F88E2 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F88F5 )

  loc_0F88EB:
    COP [81] ( #12, #04 )
    COP [83]
    COP [87]
    BRA loc_0F88EB
}

code_0F88F5 {
    COP [01] ( &asciistring_0F88FA )
    RTL 
}

asciistring_0F88FA |[10]The coral reef [N]hides many dangerous [N]monsters- Make sure [N]to use magic there- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; The Queen's maid (switch $92).
; 
; When: placement script; COP 14 until released.
; Sees: flag $1F02 (ending) set: kills itself. Otherwise the puff and animation $08 until switch $B6 (the lair of the Queen's boss) is set; then she unblocks her tiles, turns, walks (animation $0A) and stands again (talk handler code_0F898C: 'I am glad you came back.'). Before: 'This used to be the Queen's palace. I am the Queen's maid.'
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_queens_maid_0F8941 {
    COP [14] ( #$0092, &code_0F8948 )
    RTL 
}

code_0F8948 {
    COP [07] ( #$9F02, &code_0F8984 ) ; flag $1F02 is set by the ending: afterwards the maid is gone
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [17] ( &code_0F8987 )
    COP [15]

  loc_0F8959:
    COP [14] ( #$00B6, &code_0F8967 ) ; switch $B6 = the lair of the Queen's boss; once released the maid unblocks her place and walks away
    COP [80] ( #08 )
    COP [82]
    BRL loc_0F8959
}

code_0F8967 {
    COP [16]
    COP [81] ( #0A, #03 )
    COP [83]
    COP [96]
    COP [80] ( #08 )
    COP [82]
    COP [15]
    COP [17] ( &code_0F898C )
    COP [91]
    COP [80] ( #08 )
    COP [82]
    RTL 
}

code_0F8984 {
    COP [86]
    RTL 
}

code_0F8987 {
    COP [01] ( &asciistring_0F8991 )
    RTL 
}

code_0F898C {
    COP [01] ( &asciistring_0F89BB )
    RTL 
}

asciistring_0F8991 |[10]This used to be the [N]Queen s palace- I am [N]the Queen s maid- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F89BB |[10]I am glad you came [N]back- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; A mermaid friend of Servas (switch $95): stands (animation $06) and says 'Servas is the name of my friend the dolphin.'
; 
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_servas_friend_0F89CF {
    COP [14] ( #$0095, &code_0F89D6 )
    RTL 
}

code_0F89D6 {
    COP [17] ( &code_0F89E4 )
    COP [15]

  loc_0F89DC:
    COP [80] ( #06 )
    COP [82]
    BRL loc_0F89DC
}

code_0F89E4 {
    COP [01] ( &asciistring_0F89E9 )
    RTL 
}

asciistring_0F89E9 |[10]Servas is the name of [N]my friend the dolphin-[JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; A dolphin telling the story of the statues (switch $9B): 'There used to be 4 mermaid statues in this place. Those statues prevented all creatures from getting lost.'
; 
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_dolphin_four_statues_0F8A0E {
    COP [14] ( #$009B, &code_0F8A15 )
    RTL 
}

code_0F8A15 {
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [17] ( &code_0F8A28 )
    COP [91]
    COP [80] ( #11 )
    COP [82]
    RTL 
}

code_0F8A28 {
    COP [01] ( &asciistring_0F8A2D )
    RTL 
}

asciistring_0F8A2D |[10]There used to be [N]4 mermaid statues in [N]this place- [FIN]Those statues [N]prevented all [N]creatures from getting[N]lost- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; The mermaid statue of the passage to Rockbird (switch $9D).
; 
; When: placement script; COP 14 until released.
; Sees: like the Blester statue (se_npc_statue_blester_path_0F87A9) but its tile is ($22,$22); the trip goes to A07S01 at pixel ($5B0,$240) and is guarded by flag $0406. Talk: 'I will open a passage for you. Proceed right along the seabed to the shore reef, Rockbird.'
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_statue_rockbird_path_0F8A7E {
    COP [14] ( #$009D, &code_0F8A85 )
    RTL 
}

code_0F8A85 {
    COP [30] ( #$009D, &code_0F8ACE, #1F )
    COP [17] ( &code_0F8AAA )
    COP [91]
    COP [0D] ( #00, #22, #22, &code_0F8A9A )
    RTL 
}

code_0F8A9A {
    COP [11] ( #00, #23, #24 )
    COP [33]
    LDA #$AFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

code_0F8AAA {
    COP [01] ( &asciistring_0F8AD5 )
    COP [07] ( #$8406, &code_0F8ACD )
    LDA #$EF80
    TSB $joy_block_mask
    LDA #$0020
    STA $asset_skip_mask
    COP [09] ( #$8903 )
    COP [10] ( #$0107, #02, #$05B0, #$0240 )
}

code_0F8ACD {
    RTL 
}

code_0F8ACE {
    COP [01] ( &asciistring_0F8B27 )
    COP [86]
    RTL 
}

asciistring_0F8AD5 |[10]I will open a passage [N]for you- [FIN]Proceed right along [N]the seabed to the [N]shore reef, Rockbird- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

asciistring_0F8B27 |[10][0E:3C][02:2] hears [N]a small voice- [FIN]I will open the [N]passage for you, [N]return to me- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|
---------------------------------------------

; The Bubble Armor mermaid (switch $A1).
; 
; When: placement script; COP 14 until released.
; Sees: COP 30 spawns code_0F8BB5 on the return trip ('You hear a mermaid. Is there anyone who needs to use the Bubble Armor?'); COP B0 spawns the chest helper; she stands (animation $08). Talk handler code_0F8B8D.
; Why: the armor lets the hero walk freely underwater (walkthrough: Seabed Sanctuary - Bubble Armor).
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_bubble_armor_0F8B6A {
    COP [14] ( #$00A1, &code_0F8B71 )
    RTL 
}

code_0F8B71 {
    COP [30] ( #$00A1, &code_0F8BB5, #1F )
    COP [B0] ( @se_obj_tears_chest_opener_0F8C9A, #$2000 )
    COP [17] ( &code_0F8B8D )
    COP [15]
    COP [91]
    COP [80] ( #08 )
    COP [82]
    RTL 
}

---------------------------------------------
; Talk handler of the Bubble Armor mermaid.
; 
; When: the hero talks.
; Sees: flag $0405 not set: it is set, 'Oh! I have not had a human guest in a long time. I know you can't breathe under water, so please take this. [the hero] received the Bubble Armor.' with a sound and COP 0A item $0B. Already set: code_0F8BA1.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0F8B8D {
    COP [07] ( #$8405, &code_0F8BA1 )
    COP [09] ( #$8405 )
    COP [01] ( &asciistring_0F8BF7 )
    BRK #$5E
    COP [0A] ( #0B )
    RTL 
}

---------------------------------------------
; Second talk of the Bubble Armor mermaid: the healer.
; 
; When: flag $0405 is set.
; Sees: HP below the maximum: 'Have you been hurt?' and COP 37 heals to full; at full HP: 'If you get hurt, return to me and I will heal you.'
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0F8BA1 {
    LDA $player_hp
    CMP $player_max_hp
    BEQ loc_0F8BB0
    COP [01] ( &asciistring_0F8C60 )
    COP [37]
    RTL 

  loc_0F8BB0:
    COP [01] ( &asciistring_0F8C75 )
    RTL 
}

code_0F8BB5 {
    COP [01] ( &asciistring_0F8BBC )
    COP [86]
    RTL 
}

asciistring_0F8BBC |[10][0E:3C]You hear a mermaid-[FIN]Is there anyone who [N]needs to use the [N]Bubble Armor? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8BF7 |[10]Oh! I have not had a [N]human guest in a long [N]time- [FIN]I know you can t [N]breathe under water, [N]so please take this- [FIN][02:2] received [N][03:24]Bubble Armor- [03:20][JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8C60 |[10]Have you been hurt? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8C75 |[10]If you get hurt, [N]return to me and I [N]will heal you- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

---------------------------------------------
; Helper that opens the chest of the Mermaid's Tears.
; 
; When: spawned by the Bubble Armor mermaid (COP B0); runs every frame in the scene.
; Sees: flag $0A02 set: kills itself. Item $21 (Mermaid's Tears) owned: writes metatile $FC (the open chest) at the map tile of pixel ($02A0,$0B80) and sets flag $0A02.
; Why: the chest of the Tears then shows as open; the opening of the chest itself is done elsewhere (not traced).
; In: X = D = slot; $16 / $18 are used as pixel position scratch (PixelToMapIndex).
; Out: RTL.
; Clobbers: A, Y.

se_obj_tears_chest_opener_0F8C9A {
    COP [07] ( #$8A02, &code_0F8CC8 )
    COP [91]
    COP [18] ( #21, &code_0F8CA9 )
    BRA loc_0F8CAA
}

code_0F8CA9 {
    RTL 

  loc_0F8CAA:
    LDA #$02A0
    STA $16
    LDA #$0B80
    STA $18
    PHX 
    JSL $@lib_map_index_helpers.PixelToMapIndex
    SEP #$20
    LDA #$FC              ; metatile $FC = the open chest
    STA $7E8000, X
    REP #$20
    PLX 
    COP [09] ( #$8A02 )
}

code_0F8CC8 {
    COP [86]
    RTL 
}
---------------------------------------------

; The east guard of the Queen's palace (switch $A4).
; 
; When: placement script; COP 14 until released.
; Sees: moves slot $13 to tile ($35,$26), the puff, blocks her tiles; looks at the hero when he is inside its box widened by 2 (COP 0C), animation $01 when he is above or level (COP 9B on the vertical difference), $00 when he is below. Talk handler code_0F8D02: 'Sorry, I have orders from the Queen not to let anyone pass.'; when the hero stands on tile ($35,$26): 'How did you get here?'
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_npc_mermaid_guard_east_0F8CCB {
    COP [14] ( #$00A4, &code_0F8CD2 )
    RTL 
}

code_0F8CD2 {
    COP [17] ( &code_0F8D02 )
    COP [11] ( #13, #35, #26 )
    COP [85] ( @engine_spawn_lairs_death_drops.RunAppearPuff )
    COP [15]
    COP [91]

  loc_0F8CE4:
    COP [0C] ( #00, #02, &code_0F8CF1 )

  code_0F8CEA:
    COP [80] ( #01 )
    COP [82]
    BRA loc_0F8CE4
}

code_0F8CF1 {
    COP [9B] ( #$0000, &code_0F8CEA, &code_0F8CEA, &code_0F8CFB )
}

code_0F8CFB {
    COP [80] ( #00 )
    COP [82]
    BRA loc_0F8CE4
}

code_0F8D02 {
    COP [0D] ( #00, #35, #26, &code_0F8D0E )
    COP [01] ( &asciistring_0F8D13 )
    RTL 
}

code_0F8D0E {
    COP [01] ( &asciistring_0F8D44 )
    RTL 
}

asciistring_0F8D13 |[10]Sorry, I have orders [N]from the Queen not to [N]let anyone pass- [JMP:&w2_shared_0FA945.asciistring_0FAA44]|

asciistring_0F8D44 |[10]How did you get here? [JMP:&w2_shared_0FA945.asciistring_0FAA44]|