; The Master's event in the shrine of the World of Evil (file offsets 126027-126572 and 126661-126665, SNES $03:EC4B-$03:EE6C and $03:EEC5-$03:EEC9, bank 03; the code of we_evil_world_actors lies between the two ranges). Scene A00S07 (location $78, the Master's Shrine of the World of Evil, reached from the Up Above hub A00S09). Walkthrough chapter: docs/walkthrough/08-world-of-evil.md ('You'll start in the Master's Shrine, as usual. As try exiting to the south, note that the barrier surrounding the World of Evil - protecting Deathtoll - will be eradicated by the power of the six Colored Stones').
; 
; === WHAT RUNS HERE ===
; MetaWorldOfEvil type $12 (flags $2040), placed once in PlacementA00S07 (row ;02, tile (0,0), flags $01) beside type $10, the shared Master menu actor shared_actor_helpers_bank0.cm_npc_master_shrine_menu_00766C (row ;01). The hero row is tile ($07,$06). The root we_obj_master_shrine_event_01EC4B tests every frame whether the hero (slot 0) stands on tile ($07,$06), which is pixel ($0070,$0060). Three visits end on that tile and each runs one branch of we_obj_master_shrine_stones_scene_01EC55:
; 1. Neither $1F02 nor $1F05 set (the first visit with the six stones): the stones scene. The walker of the hub warps the hero in at ($0070,$0050), one tile north, so he reaches the tile by walking south (the walkthrough: 'try exiting to the south'). The pad is blocked, the narration 'The 6 stones started to shine and were swallowed into the aurora-' is shown, the six stones are taken (items $3A Brown, $3B Green, $3C Blue, $3D Silver, $3E Purple, $3F Black Stone), flag $1F04 is set, two palette-cycle effect actors are spawned, the music fades out, 241 frames pass and COP 10 sends the hero to the hub A00S09 at pixel ($00D0,$0050). The hub then runs its barrier step (gv_obj_up_above_post_ending_007264, flags $1F04 set and $1F05 clear), sets $1F05 and warps the hero back to this tile at ($0070,$0060).
; 2. $1F05 set and $1F03 clear (the return from the hub step): the gate speech (we_obj_master_shrine_gate_open_speech_01ECB1), which sets $1F03. With $1F03 set the actor just kills itself.
; 3. $1F02 set (the ending ran; RunEnding warps the hero to A00S07 at ($0070,$0060)): the farewell (we_obj_master_shrine_farewell_01ECE7) and COP 10 to the castle town A10S01.
; 
; === EVENT FLAGS ===
; $1F02 the ending ran (set by RunEnding); $1F03 the gate speech was said (only this actor reads it); $1F04 the six stones were swallowed (set here, read by the hub scripts); $1F05 the hub barrier step is done (set by the hub, read here and by the hub).
; 
; === TEXTS ===
; asciistring_01ED13 (narration of the stones), asciistring_01ED46 (the gate speech: '<name>, the gate to the World of Evil finally opened- But you need the Phoenix's help to defeat Deathtoll- When the Phoenix joins you, the palace of Deathtoll will appear in the World of Evil- <name>, try to find the three symbols-'), asciistring_01EE04 (the farewell: '<name>, you made it! All the creatures have been saved every last one thanks to you! Why don't you go and see the world and all its creatures-'). asciistring_01EEC5 is the shared window-close ending of the three ([JMP] target).
; 
; === OPEN ===
; The hub parts of grass_valley are named 'post_ending' although $1F04 and $1F05 belong to this barrier step before the World of Evil, not to the ending (OQ-I040-1). What the two effect animations ($48 and $4A of PaletteAnimLists) look like, and which scene follows the farewell in the castle town, is open (OQ-I040-9).
---------------------------------------------

?BANK 03

!joy_block_mask                 0326
!asset_skip_mask                03B4

---------------------------------------------

; The Master's event trigger: waits for the hero on tile ($07,$06).
; 
; When: placement script (meta type $12, row ;02 of A00S07, slot $02); runs from the scene load.
; Sees: COP 91 sets the re-entry point to this script, COP 0D (slot 0, tile $07,$06) jumps to we_obj_master_shrine_stones_scene_01EC55 when the hero stands on that tile; otherwise RTL.
; Why: all three visits of the shrine (stones, gate speech, farewell) start from this tile; the walkthrough: 'As try exiting to the south ...'.
; In: X = D = slot $02 (the COP entrance state).
; Out: RTL every frame until the hero is on the tile.
; Clobbers: none.

we_obj_master_shrine_event_01EC4B {
    COP [91]
    COP [0D] ( #00, #07, #06, &we_obj_master_shrine_stones_scene_01EC55 ) ; each frame: is the hero (slot 0) on tile ($07,$06)? then the event runs
    RTL 
}

---------------------------------------------
; The branch point of the event and the first visit (the six stones).
; 
; When: the hero stands on tile ($07,$06) (COP 0D of the root).
; Sees: flag $1F02 set: we_obj_master_shrine_farewell_01ECE7; flag $1F05 set: we_obj_master_shrine_gate_check_01ECA8. Otherwise the pad is blocked ($7FC0 in joy_block_mask), 3 frames pass, the narration 'The 6 stones started to shine and were swallowed into the aurora-' is shown, the six stones are taken (COP 0B items $3A-$3F), asset_skip_mask = $20, flag $1F04 is set, two effect actors are spawned (COP 85), the music fades out (COP 31, track $00), 241 frames pass and COP 10 goes to the hub A00S09 at pixel ($00D0,$0050).
; Why: the walkthrough: 'the barrier surrounding the World of Evil ... will be eradicated by the power of the six Colored Stones'; the hub shows the next step while $1F04 is set and $1F05 clear.
; In: X = D = slot $02.
; Out: flag $1F04 set, the six stones gone, the scene change (the pad block ends with it).
; Clobbers: A.

we_obj_master_shrine_stones_scene_01EC55 {
    COP [07] ( #$9F02, &we_obj_master_shrine_farewell_01ECE7 ) ; bit 15 set: jumps when flag $1F02 (the ending ran) is set: the farewell
    COP [07] ( #$9F05, &we_obj_master_shrine_gate_check_01ECA8 ) ; jumps when flag $1F05 (the hub step is done) is set: the gate branch
    LDA #$7FC0
    TSB $joy_block_mask
    COP [03] ( #03 )
    COP [04]
    COP [01] ( &asciistring_01ED13 )
    COP [0B] ( #3A )      ; items $3A-$3F are the six stones (Brown, Green, Blue, Silver, Purple, Black); there is no test, they are taken
    COP [0B] ( #3B )
    COP [0B] ( #3C )
    COP [0B] ( #3D )
    COP [0B] ( #3E )
    COP [0B] ( #3F )
    LDA #$0020            ; bit $20 of asset_skip_mask: the next scene load skips the music command
    STA $asset_skip_mask
    COP [09] ( #$9F04 )   ; flag $1F04: the hub shows its barrier step until flag $1F05 is set
    COP [85] ( @we_fx_master_shrine_stone_effect_a_01ECCD )
    COP [85] ( @we_fx_master_shrine_stone_effect_b_01ECDA )
    COP [31] ( #00 )
    COP [03] ( #F1 )
    COP [04]
    COP [10] ( #$0900, #00, #$00D0, #$0050 ) ; scene change to A00S09 (the hub) at pixel ($00D0,$0050)
    RTL 
}

---------------------------------------------
; Return from the hub: the gate speech only once.
; 
; When: branch of we_obj_master_shrine_stones_scene_01EC55 for flag $1F05 set (the hub step has run and put the hero back on tile $07,$06).
; Sees: COP 07 with operand $1F03 (bit 15 clear) jumps when that flag is clear, to the speech; with $1F03 set the actor ends (COP 86).
; Why: the speech must not repeat when the hero walks over the tile again.
; In: X = D = slot $02.
; Out: the speech, or COP 86 and RTL.
; Clobbers: none.

we_obj_master_shrine_gate_check_01ECA8 {
    COP [07] ( #$1F03, &we_obj_master_shrine_gate_open_speech_01ECB1 ) ; operand $1F03 has bit 15 clear: jumps when the flag is CLEAR, so the speech is said once
    COP [86]
    RTL 
}

---------------------------------------------
; The Master tells the hero that the gate has opened and points to the Phoenix.
; 
; When: flag $1F05 set and $1F03 clear on tile ($07,$06).
; Sees: the pad is blocked ($7FC0), 31 frames pass, the speech '<name>, the gate to the World of Evil finally opened- But you need the Phoenix's help to defeat Deathtoll- When the Phoenix joins you, the palace of Deathtoll will appear in the World of Evil- <name>, try to find the three symbols-', flag $1F03 set, pad released, COP 86.
; Why: the hint toward the Phoenix quest (walkthrough chapter 8, 'Summoning the Phoenix!': the three symbols are the three Red-Hot items).
; In: X = D = slot $02.
; Out: flag $1F03 set; the actor ends.
; Clobbers: A.

we_obj_master_shrine_gate_open_speech_01ECB1 {
    LDA #$7FC0
    TSB $joy_block_mask
    COP [03] ( #1F )
    COP [04]
    COP [01] ( &asciistring_01ED46 )
    COP [09] ( #$9F03 )
    LDA #$7FC0
    TRB $joy_block_mask
    COP [86]
    RTL 
}

---------------------------------------------
; One of the two effect actors of the stones scene (animation $48).
; 
; When: spawned (COP 85) by we_obj_master_shrine_stones_scene_01EC55 after the stones were taken.
; Sees: animation table $0D:8000 (COP A8, PaletteAnimLists), animation $48 started and ticked once (COP 92 / COP 94), then COP 86.
; Why: the glow of the swallowed stones; animation $48 is a palette-cycle list, so it is a colour effect, not a sprite (what it looks like is OQ-I040-9).
; In: X = D = the effect.
; Out: RTL after the kill.
; Clobbers: A.

we_fx_master_shrine_stone_effect_a_01ECCD {
    COP [A8] ( #$8000, #0D ) ; animation table $0D:8000 is PaletteAnimLists: animation $48 is a palette-cycle list
    COP [92] ( #48 )
    COP [94]
    COP [86]
    RTL 
}

---------------------------------------------
; The second effect actor of the stones scene (animation $4A).
; 
; When: spawned (COP 85) right after we_fx_master_shrine_stone_effect_a_01ECCD.
; Sees: the same as that actor with animation $4A.
; Why: as the first one.
; In: X = D = the effect.
; Out: RTL after the kill.
; Clobbers: A.

we_fx_master_shrine_stone_effect_b_01ECDA {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #4A )
    COP [94]
    COP [86]
    RTL 
}

---------------------------------------------
; The Master's farewell after the ending.
; 
; When: flag $1F02 (the ending ran) is set and the hero stands on tile ($07,$06), where RunEnding put him.
; Sees: the pad is blocked ($BFC0), 41 frames pass, the speech '<name>, you made it! All the creatures have been saved every last one thanks to you! Why don't you go and see the world and all its creatures-' (with timed pauses), 61 frames, asset_skip_mask = $20, COP 10 to the castle town A10S01 at pixel ($01F0,$0050), the pad released, COP 91.
; Why: the epilogue starts in the castle town; the other towns run their epilogues from flag $1F02 as well.
; In: X = D = slot $02.
; Out: the scene change.
; Clobbers: A.

we_obj_master_shrine_farewell_01ECE7 {
    LDA #$BFC0
    TSB $joy_block_mask
    COP [03] ( #29 )
    COP [04]
    COP [01] ( &asciistring_01EE04 )
    COP [03] ( #3D )
    COP [04]
    LDA #$0020
    STA $asset_skip_mask
    COP [10] ( #$0110, #01, #$01F0, #$0050 ) ; scene change to A10S01 (the castle town) at pixel ($01F0,$0050)
    LDA #$BFC0
    TRB $joy_block_mask
    COP [91]
    RTL 
}

asciistring_01ED13 |[10]The 6 stones started [N]to shine and were [N]swallowed into the [N]aurora- [JMP:&asciistring_01EEC5]|

asciistring_01ED46 |[10][02:2], the gate to [N]the World of Evil [N]finally opened- [FIN]But you need the [N]Phoenix s help to [N]defeat Deathtoll- [FIN]When the Phoenix joins[N]you, [N]the palace of [N]Deathtoll will appear [N]in the World of Evil- [FIN][02:2], [N]try to find the three [N]symbols- [JMP:&asciistring_01EEC5]|

asciistring_01EE04 |[10][0F][02:2], [N][0E:1E]you made it! [N][0E:5A]All the creatures have[N]been saved every last [N]one thanks to you! [N][0E:5A]Why don t you go and [N]see the world and all [N]it s creatures- [0E:78][JMP:&asciistring_01EEC5+M]|
---------------------------------------------

asciistring_01EEC5 |[12][::][08:408][END]|