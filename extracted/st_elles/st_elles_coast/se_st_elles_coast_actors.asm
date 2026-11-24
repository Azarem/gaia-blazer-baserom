; The actors of the St. Elles coast scenes that stand apart from the seabed (file offsets 1025088-1025172, 1025268-1025436, 1025471-1025611 and 1025953-1025988, SNES $1F:A440-$A493, $A4F4-$A59B, $A5BF-$A64A and $A7A1-$A7C3): the 200 EXP fairy gem, the shared return prompt of all fairies, the pyramid hint fairy, the hot coals, the volcano of Durean with the spot where the Mermaid's Tears are poured, and the BG2 scroll follower.
; 
; === ROSTER ===
; - se_npc_fairy_exp_200_0FA440: switch $A6, flag $1D00. A fairy gem that pays 200 EXP once ('I am watching over the world. Here, take this. [the hero] received EXP!'), then asks the return prompt.
; - se_npc_fairy_return_prompt_0FA46D: shared tail of every fairy of the chapter (the 300 and 250 EXP fairies of se_seabed_of_st_elles_actors jump here too): 'Would you like to return to the Seabed Palace?' with a Stay / Go back menu: Go back: 'Allright, good luck.' and COP 10 to A06S01 at pixel ($1F8,$200); Stay: 'Visit me again when you are ready.'
; - se_npc_fairy_pyramid_hint_0FA4F4: switch $B8 (meta type $54). The fairy of the lightning pyramids: 'The monuments on this island are lightning pyramids. If you wear the Thunder Ring and touch them, the Master will send down lightning to destroy the monsters.' then the return prompt.
; - se_obj_durean_hot_coals_0FA5BF: meta type $55. The hot coals of the volcanic island: standing on metatile $47 costs 4 HP per check, with no armor test, until flag $0503 (the volcano is out) is set.
; - se_obj_durean_volcano_0FA5D6: meta type $07. The crater of Durean: spawns the spot where the Tears are poured and animates the smoking crater until flag $0503; then it shows the extinguished frame and ends.
; - se_obj_durean_tears_spot_0FA5FA: spawned by the volcano. When the hero stands on tile ($1F,$21) with the Mermaid's Tears (item $21) equipped: flag $0503 is set, the Tears are used up and '[the hero] poured out the mermaid's tears.' is shown (walkthrough: the Mermaid's Tears turn the magma of Durean to stone).
; - se_effect_bg2_scroll_follow_0FA7A1: meta type $2F, a scroll actor for BG2.
; 
; === EVENT FLAGS ===
; $1D00 the 200 EXP were paid, $0503 the volcano of Durean is out (read by Kanna, the Tears mermaid, the vents and the hot coals), $0001 the pour text has been shown (read by the volcano).
; 
; === OPEN ===
; The tile $47 of the coals resolves part of OQ-I031-2: the scene is Durean and the walkthrough names the coals; see OQ-I036-6.
---------------------------------------------

?BANK 1F

?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_choice_prompt_texts'
?INCLUDE 'w2_obj_fairy_idle_loop'

!L_choice_result                0003D0
!scroll_bg2_x                   033E
!scroll_bg2_y                   0340
!scroll_delta_x                 0382
!scroll_delta_y                 0384
!contact_lock                   042D

---------------------------------------------

; A fairy gem that pays 200 EXP (switch $A6, flag $1D00).
; 
; When: placement script; COP 14 until the lair $A6 is released.
; Sees: JSL cm_npc_fairy_gem_setup_01B161 (the shared fairy setup), talk handler code_0FA45B, then the idle loop of w2_obj_fairy_idle_loop through a pushed return address.
; In: X = D = slot.
; Out: RTL into w2_obj_fairy_idle_loop_0FA945.
; Clobbers: A, Y.

se_npc_fairy_exp_200_0FA440 {
    COP [14] ( #$00A6, &code_0FA447 )
    RTL 
}

code_0FA447 {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_0FA45B )
    SEP #$20
    LDA #$^w2_obj_fairy_idle_loop.w2_obj_fairy_idle_loop_0FA945
    PHA 
    REP #$20
    LDA #$&w2_obj_fairy_idle_loop.w2_obj_fairy_idle_loop_0FA945-1
    PHA 
    RTL 
}

---------------------------------------------
; Talk handler of the 200 EXP fairy: when flag $1D00 is clear the text 'I am watching over the world. Here, take this.' is shown, 200 EXP are queued (COP 38, BCD $0200) and the flag is set; the handler then runs on into se_npc_fairy_return_prompt_0FA46D.
; 
; In: X = D = slot.
; Out: falls into the return prompt.
; Clobbers: A.

code_0FA45B {
    COP [07] ( #$9D00, &se_npc_fairy_return_prompt_0FA46D ) ; flag $1D00: the 200 EXP were already paid
    COP [01] ( &w2_obj_fairy_idle_loop.asciistring_0FA9C5 )
    COP [38] ( #$0200 )   ; 200 EXP in BCD
    COP [09] ( #$9D00 )
}
---------------------------------------------

; The return prompt that ends every fairy talk.
; 
; When: after the EXP text of a fairy and on every later talk (the fairy handlers branch here when their flag is set).
; Sees: 'Would you like to return to the Seabed Palace?' and the Stay / Go back menu (L_choice_result $03D0). Result 0 (or cancel): 'Visit me again when you are ready.' Otherwise: 'Allright, good luck.', contact_lock is incremented and COP 10 goes to A06S01 at pixel ($1F8,$200).
; Why: the fairies are shortcuts back to the Sanctuary from the far dungeons (walkthrough: 'use the lair to make a shortcut back to the start').
; In: X = D = slot of the fairy.
; Out: RTL.
; Clobbers: A.

se_npc_fairy_return_prompt_0FA46D {
    COP [01] ( &w2_obj_fairy_idle_loop.asciistring_0FA9F0 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceStayGoBackText, #02, &code_0FA48F )
    LDA $L_choice_result
    BEQ code_0FA48F       ; menu result 0 (the first entry of ChoiceStayGoBackText, stay) or cancel: 'Visit me again'
    COP [01] ( &w2_obj_fairy_idle_loop.asciistring_0FAA15 )
    INC $contact_lock
    COP [10] ( #$0106, #00, #$01F8, #$0200 ) ; A06S01 at pixel ($1F8,$200): back to the Sanctuary
    RTL 
}

code_0FA48F {
    COP [01] ( &w2_obj_fairy_idle_loop.asciistring_0FAA29 )
    RTL 
}
---------------------------------------------

; The fairy of the lightning pyramids (switch $B8, meta type $54).
; 
; When: placement script; COP 14 until the lair $B8 is released.
; Sees: JSL cm_npc_fairy_gem_setup_01B161, talk handler code_0FA50F (the pyramid text, then the return prompt), then the idle loop of w2_obj_fairy_idle_loop.
; Why: tells the player how to use the pyramids: wear the Thunder Ring and touch them (se_obj_lightning_pyramid_0FBF25).
; In: X = D = slot.
; Out: RTL into w2_obj_fairy_idle_loop_0FA945.
; Clobbers: A, Y.

se_npc_fairy_pyramid_hint_0FA4F4 {
    COP [14] ( #$00B8, &code_0FA4FB )
    RTL 
}

code_0FA4FB {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_0FA50F )
    SEP #$20
    LDA #$^w2_obj_fairy_idle_loop.w2_obj_fairy_idle_loop_0FA945
    PHA 
    REP #$20
    LDA #$&w2_obj_fairy_idle_loop.w2_obj_fairy_idle_loop_0FA945-1
    PHA 
    RTL 
}

code_0FA50F {
    COP [01] ( &asciistring_0FA516 )
    BRL se_npc_fairy_return_prompt_0FA46D
}

asciistring_0FA516 |[10]The monuments on this [N]island are lightning [N]pyramids- [FIN]If you wear the [N]Thunder Ring and touch[N]them, [FIN]the Master will send [N]down lightning to [N]destroy the monsters- [FIN][END]|
---------------------------------------------

; The hot coals of Durean (meta type $55).
; 
; When: runs every frame in the Durean scene.
; Sees: flag $0503 set: kills itself. Else IsPlayerOnMetatile for metatile $47; on a hit COP 39 takes 4 HP (no armor test, no hit-stun check beyond the helper's own).
; Why: the coals hurt whatever armor is worn (walkthrough: 'Stand near but not on the coals').
; In: X = D = slot.
; Out: RTL.
; Clobbers: A, Y.

se_obj_durean_hot_coals_0FA5BF {
    COP [07] ( #$8503, &code_0FA5D3 )
    LDA #$0047            ; metatile $47 = the hot coals of Durean
    JSL $@lib_map_index_helpers.IsPlayerOnMetatile
    BCS loc_0FA5CF
    RTL 

  loc_0FA5CF:
    COP [39] ( #04 )      ; 4 HP of damage per check; no armor is tested
    RTL 
}

code_0FA5D3 {
    COP [86]
    RTL 
}
---------------------------------------------

; The crater of the volcano of Durean (meta type $07).
; 
; When: placement script of the Durean scene.
; Sees: flag $0503 set: kills itself. Else spawns the pour spot (COP B0 with flags $2240) and loops animation $19 with COP 94 while the flag is clear; once it is set it waits for flag $0001 (the pour text), starts animation $39 (the extinguished crater) and ends.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_obj_durean_volcano_0FA5D6 {
    COP [07] ( #$8503, &code_0FA5F7 )
    COP [B0] ( @se_obj_durean_tears_spot_0FA5FA, #$2240 ) ; spawns the pour spot with flags $2240

  code_0FA5E3:
    COP [92] ( #19 )
    COP [94]
    COP [07] ( #$0503, &code_0FA5E3 ) ; loops back to the smoking animation while flag $0503 is clear
    COP [05] ( #$0001 )   ; waits for flag $0001, set by the pour spot after its text
    COP [92] ( #39 )
    COP [94]
}

code_0FA5F7 {
    COP [86]
    RTL 
}

---------------------------------------------
; The spot on top of the volcanic island where the Mermaid's Tears are poured.
; 
; When: spawned by the crater; runs every frame.
; Sees: clears bit $0010 of its own $16 and waits (COP 91 and COP 0D) for the hero on tile ($1F,$21); code_0FA60D then requires the Tears (item $21) to be equipped.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_obj_durean_tears_spot_0FA5FA {
    LDA $0016, X
    AND #$FFEF
    STA $0016, X
    COP [91]
    COP [0D] ( #00, #1F, #21, &code_0FA60D )

  code_0FA60C:
    RTL 
}

---------------------------------------------
; The pouring of the Mermaid's Tears.
; 
; When: the hero stands on tile ($1F,$21).
; Sees: item $21 not equipped: nothing. Equipped: flag $0503 is set, COP 0B uses the item up, '[the hero] poured out the mermaid's tears.' is shown, a sound (BRK #$86) plays, flag $0001 is set and the spot kills itself.
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

code_0FA60D {
    COP [19] ( #21, &code_0FA60C )
    COP [09] ( #$8503 )   ; flag $0503 = the volcano is out; read by Kanna, the Tears mermaid, the vents and the coals
    COP [0B] ( #21 )      ; the Mermaid's Tears are used up
    COP [01] ( &asciistring_0FA626 )
    BRK #$86
    COP [09] ( #$8001 )
    COP [86]
    RTL 
}

asciistring_0FA626 |[10][02:2] poured [N]out the mermaid s [N]tears- [JMP:&w2_obj_fairy_idle_loop.asciistring_0FAA44]|
---------------------------------------------

; The BG2 scroller (meta type $2F).
; 
; When: runs every frame.
; Sees: moves its own position by (+2, -6) plus the camera delta (scroll_delta_x / scroll_delta_y) and writes it into scroll_bg2_x and scroll_bg2_y, so BG2 drifts diagonally by itself while following the camera. The scene using it is not named in the data (OQ-I036-7).
; In: X = D = slot.
; Out: RTL.
; Clobbers: A.

se_effect_bg2_scroll_follow_0FA7A1 {
    LDA $0000, X
    CLC 
    ADC #$0002
    CLC 
    ADC $scroll_delta_x
    STA $0000, X
    STA $scroll_bg2_x     ; the BG2 scroll is the actor's own position
    LDA $0002, X
    SEC 
    SBC #$0006
    CLC 
    ADC $scroll_delta_y
    STA $0002, X
    STA $scroll_bg2_y
    RTL 
}