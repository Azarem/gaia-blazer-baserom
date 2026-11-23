; The scripted actors of the castle dungeon scenes (file offsets 158198-159555): the harp string on the fallen body in the torture chamber (A11S01, location $66), the fairy of the basement (A11S02, location $67) and the floor spikes of the second basement (A11S03, location $68). The enemies of the dungeon are in mc_castle_dungeon_enemies.asm. Walkthrough chapter: docs/walkthrough/07-king-magridds-castle.md (Castle Dungeon Part 1).
; 
; === WHAT RUNS HERE ===
; Placement types: $3A (A11S01, tile $00,$00: an invisible pick-up trigger), $38 (A11S02, tile $16,$11: the fairy) and $35 (A11S03: the floor spikes; no tile, the test is on the hero). The fairy is released by lair record $163; the harp string and the spikes need no lair.
; 
; === FLAGS AND ITEMS ===
; $0702: the harp string has been taken (the singer in the castle town needs it; item $1A). Item $0F = the Elemental Mail: with it equipped the floor spikes do nothing (the Elemental Mail soldier hints at the 'thorns in the basement').
; 
; === DIALOGUE AND RESULT ===
; The body: 'The body is holding something. <name> found "harp string".' The fairy: 'The Zantetsu Sword is found in Leo's laboratory. And the Spirit Sword in this castle. Try to remember where the invincible monsters are.' then the return prompt of mc_return_prompt_and_chest_hint_texts. Walkthrough: the harp string by running into the fallen skeleton; the walkthrough does not describe the fairy (OQ-I039-10). The walkthrough on the Elemental Armor: it 'will only protect you from floor spikes we'll later find in the castle's dungeons'.
---------------------------------------------

?BANK 04

?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'mc_return_prompt_and_chest_hint_texts'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_actor_helpers_bank4'

---------------------------------------------

; The harp string on the fallen body (A11S01).
; 
; When: placement script (type $3A, tile $00,$00).
; Sees: flag $0702 set: COP 86 (already taken); otherwise COP 91 waits for the hero on tile ($28,$05): 'The body is holding something. <name> found "harp string".', BRK $5E, item $1A, flag $0702 set and the actor ends.
; Why: the walkthrough: 'run into the fallen skeleton to get a Harp String'; the singer in the castle town needs it.
; In: X = D = the slot.
; Out: item $1A given, flag $0702 set.
; Clobbers: A.

mc_obj_harp_string_pickup_0269F6 {
    COP [07] ( #$8702, &code_026A13 )
    COP [91]
    COP [0D] ( #00, #28, #05, &code_026A06 ) ; the hero stands on tile ($28,$05)
    RTL 
}

code_026A06 {
    COP [01] ( &asciistring_026A16 )
    BRK #$5E
    COP [0A] ( #1A )      ; item $1A = the Harp string
    COP [09] ( #$8702 )   ; flag $0702: the string has been taken (read by the singer)
}

code_026A13 {
    COP [86]
    RTL 
}

asciistring_026A16 |[10]The body is holding [N]something- [FIN][02:2] found [N]"[03:24]harp string-[03:20]ˮ [JMP:&mc_return_prompt_and_chest_hint_texts.asciistring_0270DF]|
---------------------------------------------

; The fairy of the second basement (A11S02).
; 
; When: placement script (type $38, tile ($16,$11)); COP 14 returns until lair record $163 is released.
; Sees: the fairy setup (shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161), the talk handler mc_npc_fairy_dungeon_hint_text_026F29 and a jump to the shared idle code (shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289) by a pushed RTL address.
; Why: the hint and the way out of the dungeon.
; In: X = D = the slot.
; Out: RTL into shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289.
; Clobbers: A.

mc_npc_fairy_dungeon_hint_026E9D {
    COP [14] ( #$0163, &code_026EA4 )
    RTL 
}

code_026EA4 {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &mc_npc_fairy_dungeon_hint_text_026F29 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289-1
    PHA 
    RTL 
}
---------------------------------------------

asciistring_026EB8 |[10]The Zantetsu Sword is [N]found in Leo s [N]laboratory- [FIN]And the Spirit Sword [N]in this castle----- [FIN]try to remember where [N]the invincible [N]monsters are- [FIN][END]|
---------------------------------------------

; The fairy's talk handler.
; 
; When: COP 17 handler of mc_npc_fairy_dungeon_hint_026E9D.
; Sees: the text 'The Zantetsu Sword is found in Leo's laboratory. And the Spirit Sword in this castle. Try to remember where the invincible monsters are.', then a BRL to the 'return to the outside of Magridd Castle?' prompt (mc_fairy_return_prompt_026E79).
; Why: the hint; the walkthrough says the Spirit Sword defeats 'Spirit-type enemies' (Castle Dungeon Part 1).
; In: X = D = the fairy.
; Out: the prompt decides whether the hero is moved to the castle town.
; Clobbers: A.

mc_npc_fairy_dungeon_hint_text_026F29 {
    COP [01] ( &asciistring_026EB8 )
    BRL mc_return_prompt_and_chest_hint_texts.mc_fairy_return_prompt_026E79
}
---------------------------------------------

; The floor spikes of the second basement (A11S03).
; 
; When: placement script (type $35), every frame.
; Sees: item $0F (Elemental Mail) equipped: nothing; not equipped: mc_obj_floor_spikes_check_026F36.
; Why: the walkthrough: the Elemental Armor 'will only protect you from floor spikes we'll later find in the castle's dungeons'; the Elemental Mail soldier calls them thorns.
; In: X = D = the slot.
; Out: RTL.
; Clobbers: A.

mc_obj_floor_spikes_026F30 {
    COP [19] ( #0F, &mc_obj_floor_spikes_check_026F36 ) ; item $0F (Elemental Mail) not equipped: test the spikes; equipped: no damage
    RTL 
}

---------------------------------------------
; Hurts the hero on a spike metatile.
; 
; When: from mc_obj_floor_spikes_026F30 when the Elemental Mail is not equipped.
; Sees: IsPlayerOnMetatile with metatile $88; on a hit COP 39 #3 (3 points of damage with the knock-back of Cop39_DamagePlayer).
; Why: the damage floor; the knock-back gives the hero a few frames before the next test.
; In: X = D = the slot.
; Out: the hero's HP, $0332 and $16 are changed on a hit; carry is used as the answer.
; Clobbers: A.

mc_obj_floor_spikes_check_026F36 {
    LDA #$0088            ; metatile $88 = the spikes
    JSL $@lib_map_index_helpers.IsPlayerOnMetatile
    BCS loc_026F40
    RTL 

  loc_026F40:
    COP [39] ( #03 )
    RTL 
}