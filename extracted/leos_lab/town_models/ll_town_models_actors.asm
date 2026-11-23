; The third Fairy Gem of the laboratory and the effect of one building-removal lair of Town Model 1 (file offsets 146983-147222 in two ranges, 146983-147030 and 147079-147222, SNES $04:BE27-$BE56 and $04:BE87-$BF16; the fairy gem of A0ES03 lies between them and belongs to ll_laboratory_dungeon_actors).
; 
; === ROSTER ===
; - ll_npc_fairy_exp_300_023E27: type $30, tile ($3B,$0B) of A0FS01, switch $147 (lair record $147: 6 Toy Soldiers (meta type $25) with RunLairRespawn, lair in location $5B at tile ($38,$0B)), latch flag $1D02. The same script as the two gems of ll_laboratory_dungeon_actors (talk handler code_023E42, 300 EXP once, then ll_laboratory_dungeon_actors.ll_fairy_return_prompt_023E00). The walkthrough: 'the lair will spawn a Fairy Gem you can use to get 300 EXP'.
; - ll_effect_model_release_023E87: type $31, tile ($23,$24) of A0FS01, switch $143 (lair record $143: 5 monsters of meta type $27 (ll_enemy_toy_lunge) with RunLairRespawn, lair in location $5B at tile ($26,$26); it frees no NPC but opens a path: its release rectangle is 9 x 7 metatiles from ($22,$23) on layer 3, staged from ($22,$43)). The root spawns eight ll_effect_model_release_piece_023EF3 actors once (flag $1B07).
; 
; === FLAGS ===
; $1D02: the 300 EXP of the gem of Town Model 1 has been taken. $1B07: the effect of lair $143 has played (persistent), so it plays only once.
---------------------------------------------

?BANK 04

?INCLUDE 'll_laboratory_dungeon_actors'
?INCLUDE 'll_watching_over_world_return_prompt_texts'
?INCLUDE 'shared_actor_helpers_bank3'
?INCLUDE 'shared_actor_helpers_bank4'

!scene_sprite_attr              0372

---------------------------------------------

; The Fairy Gem of Town Model 1: 300 EXP once, then the way back to the laboratory.
; 
; When: placement script (type $30, tile ($3B,$0B) of A0FS01); COP 14 returns until lair record $147 (6 Toy Soldiers of location $5B) is released.
; Sees: as ll_npc_fairy_exp_300_023DD3: the shared fairy setup, talk handler code_023E42 with latch flag $1D02, then BRL to ll_laboratory_dungeon_actors.ll_fairy_return_prompt_023E00.
; Why: see there (walkthrough: 'the lair will spawn a Fairy Gem you can use to get 300 EXP').
; In: X = D = slot $0B of A0FS01.
; Out: a tail jump into the shared idle loop.
; Clobbers: A.

ll_npc_fairy_exp_300_023E27 {
    COP [14] ( #$0147, &code_023E2E )
    RTL 
}

code_023E2E {
    JSL $@shared_actor_helpers_bank3.cm_npc_fairy_gem_setup_01B161
    COP [17] ( &code_023E42 )
    SEP #$20
    LDA #$^shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank4.cm_npc_fairy_gem_idle_022289-1
    PHA 
    RTL 
}

code_023E42 {
    COP [07] ( #$9D02, &ll_laboratory_dungeon_actors.ll_fairy_return_prompt_023E00 ) ; flag $1D02: the 300 EXP of this gem has been taken
    COP [01] ( &ll_watching_over_world_return_prompt_texts.asciistring_023F33 )
    COP [38] ( #$0300 )
    COP [09] ( #$9D02 )
    BRL ll_laboratory_dungeon_actors.ll_fairy_return_prompt_023E00
}
---------------------------------------------

; The effect that plays once when lair record $143 of Town Model 1 is released.
; 
; When: placement script (type $31, tile ($23,$24) of A0FS01); COP 14 returns until lair record $143 is released.
; Sees: with flag $1B07 set it ends at once (code_023EF0, COP 86). Otherwise it sets $1B07 and spawns eight pieces with COP B2 at the offsets (0,0), ($20,0), ($40,0), ($60,0), (0,$40), ($20,$40), ($40,$40), ($60,$40), flags $4000, then kills itself.
; Why: the lair opens a path by changing a map rectangle; the pieces animate over its area (what they draw: OQ-I038-8).
; In: X = D = slot $0A of A0FS01.
; Out: RTL after the kill.
; Clobbers: A, Y.

ll_effect_model_release_023E87 {
    COP [14] ( #$0143, &code_023E8E )
    RTL 
}

code_023E8E {
    COP [07] ( #$9B07, &code_023EF0 ) ; flag $1B07 (persistent): the effect has played already; bit 15 set = jump when set
    COP [09] ( #$9B07 )
    COP [B2] ( @ll_effect_model_release_piece_023EF3, #$0000, #$0000, #$4000 ) ; eight pieces: a 4 x 2 grid in steps of 32 x 64 pixels from the actor, flags $4000
    COP [B2] ( @ll_effect_model_release_piece_023EF3, #$0020, #$0000, #$4000 )
    COP [B2] ( @ll_effect_model_release_piece_023EF3, #$0040, #$0000, #$4000 )
    COP [B2] ( @ll_effect_model_release_piece_023EF3, #$0060, #$0000, #$4000 )
    COP [B2] ( @ll_effect_model_release_piece_023EF3, #$0000, #$0040, #$4000 )
    COP [B2] ( @ll_effect_model_release_piece_023EF3, #$0020, #$0040, #$4000 )
    COP [B2] ( @ll_effect_model_release_piece_023EF3, #$0040, #$0040, #$4000 )
    COP [B2] ( @ll_effect_model_release_piece_023EF3, #$0060, #$0040, #$4000 )
}

code_023EF0 {
    COP [86]
    RTL 
}

---------------------------------------------
; One piece of the release effect: plays animation 05 once and animation 0A sixty times and ends.
; 
; When: spawned eight times (COP B2) by ll_effect_model_release_023E87.
; Sees: animation table $0E:8000 (COP A8), the animation id from an absolute read of $0005 (not the piece's DP; OQ-I038-8), the scene's sprite attribute word, COP A4, animation 05, then animation 0A with 60 repeats, COP 86.
; Why: the visual of the opened path.
; In: X = D = the piece.
; Out: RTL after the kill.
; Clobbers: A.

ll_effect_model_release_piece_023EF3 {
    COP [A8] ( #$8000, #0E )
    LDA $0005             ; an absolute read of $0005, not the piece's own DP (OQ-I038-8)
    STA $001E, X
    STZ $0020, X
    LDA $scene_sprite_attr
    STA $001C, X
    COP [A4]
    COP [80] ( #05 )
    COP [82]
    COP [81] ( #0A, #3C ) ; animation $0A, $3C repeats, then the piece ends
    COP [83]
    COP [86]
    RTL 
}