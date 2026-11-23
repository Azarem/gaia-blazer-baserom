; Two Fairy Gems of the Laboratory Dungeon, their shared return prompt and the fire pit (file offsets 146899-147250 in two ranges, 146899-147078 and 147223-147250, SNES $04:BDD3-$BE86 and $04:BF17-$BF32; the other parts between them belong to ll_town_models_actors). The third Fairy Gem of the area is in ll_town_models_actors.
; 
; === FAIRY GEMS (meta types $2F and $32) ===
; - ll_npc_fairy_exp_300_023DD3: type $2F, tile ($03,$52) of A0ES02, switch $127 (lair record $127: 5 Mini Helicopters (meta type $21) with RunLairSpawnAll, lair in location $57 at tile ($06,$52)), latch flag $1D01.
; - ll_npc_fairy_exp_300_023E57: type $32, tile ($23,$3A) of A0ES03, switch $130 (lair record $130: 6 Mini Helicopters with RunLairRespawn, lair in location $58 at tile ($1C,$3A)), latch flag $1D03.
; Both: COP 14 returns until the lair is released; then the shared fairy setup (shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161: animation table $0E:8000, animation 07, the scene's sprite attribute word, COP 15), the talk handler (COP 17) and a tail jump (RTL with the address pushed) into the shared idle loop shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289 (animation 0C within $18 pixels of the hero, else animation 07). The first talk shows 'I am watching over the world. Please take this. <name> received EXP!', queues 300 EXP (COP 38, BCD $0300) and sets the latch flag; every talk then goes on to ll_fairy_return_prompt_023E00. The walkthrough: 'Defeat them and use the nearby Fairy Gem for 300 EXP.' and 'beat up the Mini Helicopters to make a Fairy Gem appear back to the east. You can backtrack to it for 300 EXP.'
; ll_fairy_return_prompt_023E00 is the question 'Would you like to go back to Dr-Leo's Laboratory?' with the Stay / Go back window (shared_choice_prompt_texts.ChoiceStayGoBackText).
; 
; === FIRE PIT (meta type $2E) ===
; ll_obj_fire_pit_023F17 is placed at tile ($00,$00) of A0ES02 and A0ES03 (no switch): an invisible actor that runs every frame. While the Ice Armor (item $0A) is not worn (COP 19) it tests whether the hero stands on metatile $F3 or $E1 (lib_map_index_helpers.IsPlayerOnMetatile) and hurts him with COP 39 ($04 damage). IsPlayerOnMetatile answers 'no' during hit stun, so the test repeats only after the stun. The walkthrough: '(You might want to equip the Ice Armor to deal with the painful fire.)' Which tiles are $F3 and $E1 on the screen: OQ-I038-1.
; 
; === FLAGS ===
; $1D01 / $1D03: the 300 EXP of the gem of A0ES02 / of A0ES03 has been taken (persistent; $1D02 is the gem of Town Model 1).
---------------------------------------------

?BANK 04

?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'll_watching_over_world_return_prompt_texts'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_actor_helpers_bank4'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!contact_lock                   042D

---------------------------------------------

; The Fairy Gem of A0ES02: 300 EXP once, then the way back to the laboratory.
; 
; When: placement script (type $2F, tile ($03,$52) of A0ES02); COP 14 returns until lair record $127 (5 Mini Helicopters of location $57) is released.
; Sees: the shared fairy setup (JSL shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161), the talk handler code_023DEE (flag $1D01 clear: 'I am watching over the world. Please take this. <name> received EXP!', 300 EXP, flag $1D01 set; then the prompt ll_fairy_return_prompt_023E00, which a set flag reaches at once).
; Why: the dungeon's fairy gives EXP once and an exit to the laboratory (walkthrough: 'use the nearby Fairy Gem for 300 EXP').
; In: X = D = slot $04 of A0ES02.
; Out: a tail jump (RTL with the address pushed) into the shared idle loop.
; Clobbers: A.

ll_npc_fairy_exp_300_023DD3 {
    COP [14] ( #$0127, &code_023DDA )
    RTL 
}

code_023DDA {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_023DEE )
    SEP #$20
    LDA #$^shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289-1
    PHA 
    RTL 
}

code_023DEE {
    COP [07] ( #$9D01, &ll_fairy_return_prompt_023E00 ) ; flag $1D01 (persistent): the 300 EXP of this gem has been taken; bit 15 set = jump when set
    COP [01] ( &ll_watching_over_world_return_prompt_texts.asciistring_023F33 )
    COP [38] ( #$0300 )   ; 300 EXP (BCD) queued
    COP [09] ( #$9D01 )
}
---------------------------------------------

; The question every Fairy Gem of the laboratory asks after its reward: 'Would you like to go back to Dr-Leo's Laboratory?'
; 
; When: reached by BRL or COP 07 from the talk handler of the three gems; it is not an actor of its own.
; Sees: the question and the Stay / Go back window (cancel counts as Stay). Go back: 'Good luck.' and the scene changes to area $0D scene $01 (A0DS01) at pixel ($0188,$0190); Stay (code_023E22): 'Come back to me when you wish to return.'
; Why: the same prompt as the fairies of the other worlds (compare gw_fairy_gem_return_prompt_01E4E9).
; In: talk handler, X = the gem's slot.
; Out: RTL, or the scene change (INC contact_lock before it).
; Clobbers: A.

ll_fairy_return_prompt_023E00 {
    COP [01] ( &ll_watching_over_world_return_prompt_texts.asciistring_023F59 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceStayGoBackText, #02, &code_023E22 )
    LDA $L_choice_result
    BEQ code_023E22
    COP [01] ( &ll_watching_over_world_return_prompt_texts.asciistring_023F7D )
    INC $contact_lock
    COP [10] ( #$010D, #00, #$0188, #$0190 ) ; area $0D scene $01: A0DS01 (laboratory 1) at pixel ($0188,$0190)
    RTL 
}

code_023E22 {
    COP [01] ( &ll_watching_over_world_return_prompt_texts.asciistring_023F8B )
    RTL 
}
---------------------------------------------

; The Fairy Gem of A0ES03: the same script with latch flag $1D03.
; 
; When: placement script (type $32, tile ($23,$3A) of A0ES03); COP 14 returns until lair record $130 (6 Mini Helicopters of location $58) is released.
; Sees: as ll_npc_fairy_exp_300_023DD3, talk handler code_023E72 with flag $1D03, ending in BRL ll_fairy_return_prompt_023E00.
; Why: see there (walkthrough: 'beat up the Mini Helicopters to make a Fairy Gem appear back to the east. You can backtrack to it for 300 EXP').
; In: X = D = slot $0F of A0ES03.
; Out: a tail jump into the shared idle loop.
; Clobbers: A.

ll_npc_fairy_exp_300_023E57 {
    COP [14] ( #$0130, &code_023E5E )
    RTL 
}

code_023E5E {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_023E72 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289-1
    PHA 
    RTL 
}

code_023E72 {
    COP [07] ( #$9D03, &ll_fairy_return_prompt_023E00 ) ; flag $1D03: the 300 EXP of this gem has been taken
    COP [01] ( &ll_watching_over_world_return_prompt_texts.asciistring_023F33 )
    COP [38] ( #$0300 )
    COP [09] ( #$9D03 )
    BRL ll_fairy_return_prompt_023E00
}
---------------------------------------------

; The floor hazard of the dungeon: 4 damage on the fire metatiles unless the Ice Armor is worn.
; 
; When: placement script (type $2E, tile ($00,$00) of A0ES02 and A0ES03); no switch; runs every frame (RTL without COP 91).
; Sees: COP 19 on item $0A (Ice Armor): worn, nothing happens; not worn: code_023F1D tests metatile $F3 and then $E1 under the hero (IsPlayerOnMetatile) and on either hurts him with COP 39 (4 damage).
; Why: the walkthrough: 'You might want to equip the Ice Armor to deal with the painful fire.'
; In: X = D = slot of the actor ($03 in A0ES02, $04 in A0ES03).
; Out: RTL.
; Clobbers: A.

ll_obj_fire_pit_023F17 {
    COP [19] ( #0A, &code_023F1D ) ; item $0A = the Ice Armor: the fire only hurts while it is not worn
    RTL 
}

code_023F1D {
    LDA #$00F3
    JSL $@lib_map_index_helpers.IsPlayerOnMetatile
    BCS loc_023F2F
    LDA #$00E1
    JSL $@lib_map_index_helpers.IsPlayerOnMetatile
    BCC loc_023F32

  loc_023F2F:
    COP [39] ( #04 )      ; 4 damage; the hit stun makes IsPlayerOnMetatile answer 'no', so the next hit comes after the stun

  loc_023F32:
    RTL 
}