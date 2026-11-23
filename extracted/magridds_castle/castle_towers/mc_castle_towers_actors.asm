; The scripted actors of the castle towers (file offsets 159191-159558): the prison fairy (A12S03, location $6C) and the BG2 scroll of the corridor to the dock (A12S07, location $70). The tower enemies are in mc_castle_towers_enemies.asm. Walkthrough chapter: docs/walkthrough/07-king-magridds-castle.md (the towers and the Left Tower prison).
; 
; === WHAT RUNS HERE ===
; Placement types: $37 (A12S03, tile $0B,$13: the fairy of the prison, released by lair record $184) and $08 (A12S07: the corridor scroll). The fairy gives the chest hint and the return prompt.
; 
; === DIALOGUE AND RESULT ===
; 'There are many treasure chests hidden in the basements and towers. If a soldier, the one who knows a lot about the Magridd castle joins you, then the treasures will be found easily.', then the prompt 'Would you like to return to the outside of Magridd Castle?'.
---------------------------------------------

?BANK 04

?INCLUDE 'mc_return_prompt_and_chest_hint_texts'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_actor_helpers_bank4'

!bg2_offset_x                   038A

---------------------------------------------

; The fairy of the prison (A12S03).
; 
; When: placement script (type $37, tile ($0B,$13)); COP 14 returns until lair record $184 is released.
; Sees: the fairy setup (shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161), the talk handler mc_fairy_chest_hint_then_prompt_026E75 and a jump to the shared idle code by a pushed RTL address.
; Why: the hint for the treasure chests and the way out.
; In: X = D = the slot.
; Out: RTL into shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289.
; Clobbers: A.

mc_npc_fairy_chest_hint_026DD7 {
    COP [14] ( #$0184, &code_026DDE )
    RTL 
}

code_026DDE {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &mc_return_prompt_and_chest_hint_texts.mc_fairy_chest_hint_then_prompt_026E75 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289-1
    PHA 
    RTL 
}
---------------------------------------------

; Scrolls the second background of the dock corridor.
; 
; When: placement script (type $08 of A12S07), every frame.
; Sees: DEC bg2_offset_x.
; Why: the moving sky outside the corridor to the airship dock.
; In: X = D = the slot.
; Out: bg2_offset_x changed.
; Clobbers: A.

mc_towers_bg2_scroll_x_026F44 {
    DEC $bg2_offset_x
    RTL 
}