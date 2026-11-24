; The actors of the Up Above scenes of world 0 (bank 00, file offsets 28200-29340 and 31099 onwards): the map walker and its helpers, the scenery and boss markers of the hub scene A00S09 (unnamed_0f, OQ-I001-6), and the name entry voice of the first scene A00S01.
; 
; === THE NAME ENTRY ===
; gv_obj_name_entry_voice_00797B (type $54, placed in A00S01): once (event flag $1F06), 'A voice came from above. "My follower, since you will be able to speak with all living things, you should have a name. Please choose a name for yourself."', the name entry screen (COP 3A) and '<name>,------- What an interesting name. Allright, go and save the world for all creatures.' The walkthrough: 'You'll begin by speaking with "the Master" ... You will then get to pick a name for yourself.'
; 
; === THE HUB (A00S09) ===
; gv_obj_up_above_map_walker_006E28 (type $53) is the player actor of the hub: it walks a path of seven stops with the pad (walk animations $01-$03, $1E-$2F); on stop k (k = 0 ... 6) B (joy_pressed $8000) plays BRK $98 and starts COP 10 to area 0 scene k+1 (A00S01-A00S07, the shrine scenes of areas-and-scenes.md) at ($70,$50). The stops are linked Down / Right / Up as the path bends: 0 Down to 1, 1 Right to 2, 2 Up to 3, 3 Right to 4, 4 Up to 5, 5 Up to 6, and the opposite pad direction goes back (6 goes back with Right). Every forward step is a gate, opened by the event flag $1B00 ... $1B05 of the same number; gv_obj_up_above_path_markers_007141 draws a pair of marker sprites for every gate flag that is set. gv_obj_up_above_camera_follow_00708E copies the walker's position to the player variables and aims the camera at it. The walker is replaced by the post-ending cut scene gv_obj_up_above_post_ending_007264 when event flag $1F04 is set and $1F05 is clear ($1F04 is set by we_obj_master_shrine_event in the World of Evil, $1F05 at the end of that cut scene).
; The scenery actors are the meta types $40-$52 (19 entries) and the backdrop type $3D. Types $40, $43 and $46 (gv_obj_up_above_scenery_gated_0070B3) stay while event flag $1F05 is set or neither flag is, and disappear while $1F04 alone is set; types $41, $42, $44, $45, $4A, $4B and $4E have no script of their own (RTL only, $42 draws in front), types $47-$49 and $50-$52 play one fixed animation ($04, $05, $30 and $31, $32, $33), and the three boss markers ($4C, $4D, $4F) play an animation once a lair switch is set: $4C switch $00B6 (animation $18), $4D switch $0009 (the Metal Mantis lair, animation $14), $4F switch $012F (animation $12).
; 
; === NOTES ===
; - What the hub shows and when the game sends the player there is not confirmed (OQ-I034-14); the descriptions follow the scripts.
; - Event flags: $1F04 / $1F05 post-ending steps, $1F06 the name was chosen, $1B00-$1B05 the six gates of the walker path.
---------------------------------------------

?BANK 00

?INCLUDE 'lib_map_scroll_and_redraw'
?INCLUDE 'shared_actor_helpers_bank0'

!joy_pressed                    0322
!joy_block_mask                 0326
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!player_actor                   039C
!asset_cache_gfx2               040D
!asset_cache_gfx3               0410
!reload_menu_gfx                0454

---------------------------------------------

; The walker on the Up Above path (the hub's player actor).
; 
; When: meta type $53 in A00S09; runs from the first frame.
; Sees: a figure that steps between seven stops with the pad; B on a stop warps to that stop's shrine scene.
; Why: it stores its own slot in player_actor (STX), so the engine reads it as the player; its start stop is chosen from its X and Y (X $70 stop 0, $30 stop 1, $1B0 stop 4, $170 stop 5; Y $170 stop 2, $70 stop 3; anything else stop 6).
; In: actor script, X = own slot. M = 16 bits.
; Out: with flag $1F05 set, or with neither flag, it runs code_006E34: reload_menu_gfx + 1, spawns the markers and the camera follower, joy_block_mask |= $3080, asset caches cleared, then the stop loops; with $1F04 set it branches to gv_obj_up_above_post_ending_007264. Stop k warps with COP 10 (area 0, scene k+1, arrival animation 0, x $70, y $50). Gates: stop 0 Down needs flag $1B00, 1 Right $1B01, 2 Up $1B02, 3 Right $1B03, 4 Up $1B04, 5 Up $1B05 (COP 08 keeps the walker on the stop while the flag is clear).
; Clobbers: A.

gv_obj_up_above_map_walker_006E28 {
    COP [07] ( #$9F05, &code_006E34 ) ; event flag $1F05: set by code_007279 at the end of the post-ending step
    COP [07] ( #$9F04, &gv_obj_up_above_post_ending_007264 ) ; event flag $1F04: set by we_obj_master_shrine_event in the World of Evil; the post-ending cut scene replaces the walker
}

code_006E34 {
    INC $reload_menu_gfx
    COP [85] ( @gv_obj_up_above_path_markers_007141 )
    LDA #$3080
    TSB $joy_block_mask
    COP [A3]
    STX $player_actor
    STZ $asset_cache_gfx2
    STZ $asset_cache_gfx3
    COP [85] ( @gv_obj_up_above_camera_follow_00708E )
    LDA $0000, X
    CMP #$0070
    BEQ code_006EA0
    CMP #$0030
    BNE loc_006E62
    BRL code_006EDE

  loc_006E62:
    CMP #$01B0
    BNE loc_006E6A
    BRL code_006FD4

  loc_006E6A:
    CMP #$0170
    BNE loc_006E72
    BRL code_007026

  loc_006E72:
    LDA $0002, X
    CMP #$0170
    BNE loc_006E7D
    BRL code_006F30

  loc_006E7D:
    CMP #$0070
    BNE loc_006E85
    BRL code_006F82

  loc_006E85:
    BRL loc_007073

  loc_006E88:
    LDA $joy_pressed
    BIT #$0400
    BNE loc_006EA7
    BIT #$8000
    BEQ code_006EA0
    BRK #$98
    COP [10] ( #$0100, #00, #$0070, #$0050 )

  code_006EA0:
    COP [80] ( #10 )
    COP [82]
    BRA loc_006E88

  loc_006EA7:
    COP [08] ( #$9B00, &code_006EA0 )
    COP [80] ( #01 )
    COP [82]
    BRK #$96
    COP [80] ( #24 )
    COP [82]
    COP [80] ( #2F )
    COP [82]
    BRL code_006EDE

  loc_006EC1:
    LDA $joy_pressed
    BIT #$0800
    BNE loc_006EE5
    BIT #$0100
    BNE loc_006EF9
    BIT #$8000
    BEQ code_006EDE
    BRK #$98
    COP [10] ( #$0200, #00, #$0070, #$0050 )

  code_006EDE:
    COP [80] ( #02 )
    COP [82]
    BRA loc_006EC1

  loc_006EE5:
    COP [80] ( #03 )
    COP [82]
    BRK #$96
    COP [80] ( #25 )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    BRL code_006EA0

  loc_006EF9:
    COP [08] ( #$9B01, &code_006EDE )
    COP [80] ( #03 )
    COP [82]
    BRK #$96
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #2F )
    COP [82]
    BRL code_006F30

  loc_006F13:
    LDA $joy_pressed
    BIT #$0200
    BNE loc_006F37
    BIT #$0800
    BNE loc_006F4B
    BIT #$8000
    BEQ code_006F30
    BRK #$98
    COP [10] ( #$0300, #00, #$0070, #$0050 )

  code_006F30:
    COP [80] ( #02 )
    COP [82]
    BRA loc_006F13

  loc_006F37:
    COP [80] ( #03 )
    COP [82]
    BRK #$96
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #2F )
    COP [82]
    BRL loc_006EC1

  loc_006F4B:
    COP [08] ( #$9B02, &code_006F30 )
    COP [80] ( #03 )
    COP [82]
    BRK #$96
    COP [80] ( #29 )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    BRL loc_006F65

  loc_006F65:
    LDA $joy_pressed
    BIT #$0400
    BNE loc_006F89
    BIT #$0100
    BNE loc_006F9D
    BIT #$8000
    BEQ code_006F82
    BRK #$98
    COP [10] ( #$0400, #00, #$0070, #$0050 )

  code_006F82:
    COP [80] ( #10 )
    COP [82]
    BRA loc_006F65

  loc_006F89:
    COP [80] ( #01 )
    COP [82]
    BRK #$96
    COP [80] ( #28 )
    COP [82]
    COP [80] ( #2F )
    COP [82]
    BRL loc_006F13

  loc_006F9D:
    COP [08] ( #$9B03, &code_006F82 )
    COP [80] ( #01 )
    COP [82]
    BRK #$96
    COP [80] ( #2A )
    COP [82]
    COP [80] ( #2F )
    COP [82]
    BRL loc_006FB7

  loc_006FB7:
    LDA $joy_pressed
    BIT #$0200
    BNE loc_006FDB
    BIT #$0800
    BNE loc_006FEF
    BIT #$8000
    BEQ code_006FD4
    BRK #$98
    COP [10] ( #$0500, #00, #$0070, #$0050 )

  code_006FD4:
    COP [80] ( #02 )
    COP [82]
    BRA loc_006FB7

  loc_006FDB:
    COP [80] ( #03 )
    COP [82]
    BRK #$96
    COP [80] ( #2B )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    BRL loc_006F65

  loc_006FEF:
    COP [08] ( #$9B04, &code_006FD4 )
    COP [80] ( #03 )
    COP [82]
    BRK #$96
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    BRL loc_007009

  loc_007009:
    LDA $joy_pressed
    BIT #$0400
    BNE loc_00702D
    BIT #$0800
    BNE loc_007041
    BIT #$8000
    BEQ code_007026
    BRK #$98
    COP [10] ( #$0600, #00, #$0070, #$0050 )

  code_007026:
    COP [80] ( #10 )
    COP [82]
    BRA loc_007009

  loc_00702D:
    COP [80] ( #01 )
    COP [82]
    BRK #$96
    COP [80] ( #2D )
    COP [82]
    COP [80] ( #2F )
    COP [82]
    BRL loc_006FB7

  loc_007041:
    COP [08] ( #$9B05, &code_007026 )
    COP [80] ( #01 )
    COP [82]
    BRK #$96
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    BRL loc_00705B

  loc_00705B:
    LDA $joy_pressed
    BIT #$0100
    BNE loc_00707A
    BIT #$8000
    BEQ loc_007073
    BRK #$98
    COP [10] ( #$0700, #00, #$0070, #$0050 )

  loc_007073:
    COP [80] ( #10 )
    COP [82]
    BRA loc_00705B

  loc_00707A:
    COP [80] ( #01 )
    COP [82]
    BRK #$96
    COP [80] ( #1E )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    BRL loc_007009
}

---------------------------------------------
; Copies the walker's position and aims the camera.
; 
; When: spawned by the walker; runs every frame (no entry point).
; Sees: the camera follows the walker.
; Why: the engine's player variables (player_x / y, player_tile_x / y) are read from the player actor, which here is the walker.
; In: actor script, X = own slot; player_actor = the walker.
; Out: player_x = X, player_tile_x = X / 16, player_y = Y, player_tile_y = Y / 16 - 1; lib_map_scroll_and_redraw.AimCameraAtPlayer; X is saved with PHX / PLX.
; Clobbers: A, Y.

gv_obj_up_above_camera_follow_00708E {
    LDY $player_actor
    LDA $0000, Y
    STA $player_x
    LSR 
    LSR 
    LSR 
    LSR 
    STA $player_tile_x
    LDA $0002, Y
    STA $player_y
    LSR 
    LSR 
    LSR 
    LSR 
    DEC 
    STA $player_tile_y
    PHX 
    JSL $@lib_map_scroll_and_redraw.AimCameraAtPlayer
    PLX 
    RTL 
}
---------------------------------------------

; Scenery that disappears in the first post-ending phase (types $40, $43, $46).
; 
; When: meta types $40, $43 and $46 (code_0070C9 and code_0070CD branch here) in A00S09.
; Sees: a hub decoration that is gone while event flag $1F04 is set and $1F05 is clear.
; Why: the hub is redrawn between the two post-ending steps (OQ-I034-14).
; In: actor script, X = own slot.
; Out: with $1F05 set it stays (COP 91); with $1F04 set it kills itself (COP 86); with neither flag it falls through to the stay branch code_0070BF.
; Clobbers: A.

gv_obj_up_above_scenery_gated_0070B3 {
    COP [07] ( #$9F05, &code_0070BF )
    COP [07] ( #$9F04, &code_0070C2 )
}

code_0070BF {
    COP [91]
    RTL 
}

code_0070C2 {
    COP [86]
    RTL 
}

---------------------------------------------
; Scenery type $41: no script (RTL).
; 
; When: meta type $41 in A00S09.
; Sees: a static hub decoration.
; Why: its look comes from the meta row.
; In: n/a.
; Out: RTL.
; Clobbers: none.

code_0070C5 {
    RTL 
}

---------------------------------------------
; Scenery type $42: drawn in front (COP A3).
; 
; When: meta type $42 in A00S09.
; Sees: a static decoration in front of the walker.
; Why: COP A3 sets the draw-in-front bit.
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: none.

code_0070C6 {
    COP [A3]
    RTL 
}

---------------------------------------------
; Scenery type $43: the flag-gated scenery.
; 
; When: meta type $43 in A00S09.
; Sees: as gv_obj_up_above_scenery_gated_0070B3.
; Why: BRA to the shared code.
; In: actor script, X = own slot.
; Out: see gv_obj_up_above_scenery_gated_0070B3.
; Clobbers: A.

code_0070C9 {
    BRA gv_obj_up_above_scenery_gated_0070B3

; Scenery type $44: no script (RTL).
; 
; When: meta type $44 in A00S09.
; Sees: a static decoration.
; Why: its look comes from the meta row.
; In: n/a.
; Out: RTL.
; Clobbers: none.

  code_0070CB:
    RTL 
}

---------------------------------------------
; Scenery type $45: no script (RTL).
; 
; When: meta type $45 in A00S09.
; Sees: a static decoration.
; Why: its look comes from the meta row.
; In: n/a.
; Out: RTL.
; Clobbers: none.

code_0070CC {
    RTL 
}

---------------------------------------------
; Scenery type $46: the flag-gated scenery.
; 
; When: meta type $46 in A00S09.
; Sees: as gv_obj_up_above_scenery_gated_0070B3.
; Why: BRA to the shared code.
; In: actor script, X = own slot.
; Out: see gv_obj_up_above_scenery_gated_0070B3.
; Clobbers: A.

code_0070CD {
    BRA gv_obj_up_above_scenery_gated_0070B3

; Scenery type $47: animation $04.
; 
; When: meta type $47 in A00S09.
; Sees: a decoration with a fixed animation.
; Why: COP 80 / COP 82 play animation $04 once and the actor ends its script.
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A.

  code_0070CF:
    COP [80] ( #04 )
    COP [82]
    RTL 
}
---------------------------------------------

; Scenery type $48: animation $05.
; 
; When: meta type $48 in A00S09.
; Sees: a decoration with a fixed animation.
; Why: COP 80 / COP 82 play animation $05.
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A.

code_0070D5 {
    COP [80] ( #05 )
    COP [82]
    RTL 
}
---------------------------------------------

; Scenery type $49: animation $30.
; 
; When: meta type $49 in A00S09.
; Sees: a decoration with a fixed animation.
; Why: COP 80 / COP 82 play animation $30.
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A.

code_0070DB {
    COP [80] ( #30 )
    COP [82]
    RTL 
}
---------------------------------------------

; Scenery type $4A: no script (RTL).
; 
; When: meta type $4A in A00S09.
; Sees: a static decoration.
; Why: its look comes from the meta row.
; In: n/a.
; Out: RTL.
; Clobbers: none.

code_0070E1 {
    RTL 
}
---------------------------------------------

; Scenery type $4B: no script (RTL).
; 
; When: meta type $4B in A00S09.
; Sees: a static decoration.
; Why: its look comes from the meta row.
; In: n/a.
; Out: RTL.
; Clobbers: none.

code_0070E2 {
    RTL 
}
---------------------------------------------

; Marker for lair switch $00B6.
; 
; When: meta type $4C in A00S09; COP 14 tests switch $00B6.
; Sees: a decoration that plays animation $18 once the switch is set.
; Why: the hub marks released lairs; what the animation draws and which lair $00B6 is are open (OQ-I034-14).
; In: actor script, X = own slot.
; Out: COP 91 and RTL; with the switch set animation $18 is played once.
; Clobbers: A.

gv_obj_up_above_boss_marker_0070E3 {
    COP [14] ( #$00B6, &code_0070EC )
    COP [91]
    RTL 
}

code_0070EC {
    COP [80] ( #18 )
    COP [82]
    COP [91]
    RTL 
}
---------------------------------------------

; Marker for lair switch $0009 (the Metal Mantis lair, gv_village_actors_018000).
; 
; When: meta type $4D in A00S09; COP 14 tests switch $0009.
; Sees: a decoration that plays animation $14 once the switch is set.
; Why: see gv_obj_up_above_boss_marker_0070E3.
; In: actor script, X = own slot.
; Out: RTL; with the switch set animation $14 is played once (COP 91, RTL).
; Clobbers: A.

gv_obj_up_above_boss_marker_0070F4 {
    COP [14] ( #$0009, &code_0070FB )
    RTL 
}

code_0070FB {
    COP [80] ( #14 )
    COP [82]
    COP [91]
    RTL 
}
---------------------------------------------

; Scenery type $4E: no script (RTL).
; 
; When: meta type $4E in A00S09.
; Sees: a static decoration.
; Why: its look comes from the meta row.
; In: n/a.
; Out: RTL.
; Clobbers: none.

code_007103 {
    RTL 
}
---------------------------------------------

; Marker for lair switch $012F.
; 
; When: meta type $4F in A00S09; COP 14 tests switch $012F.
; Sees: a decoration that plays animation $12 once the switch is set.
; Why: see gv_obj_up_above_boss_marker_0070E3.
; In: actor script, X = own slot.
; Out: COP 91 and RTL; with the switch set animation $12 is played once.
; Clobbers: A.

gv_obj_up_above_boss_marker_007104 {
    COP [14] ( #$012F, &code_00710D )
    COP [91]
    RTL 
}

code_00710D {
    COP [80] ( #12 )
    COP [82]
    COP [91]
    RTL 
}
---------------------------------------------

; Scenery type $50: animation $31.
; 
; When: meta type $50 in A00S09.
; Sees: a decoration with a fixed animation.
; Why: COP 80 / COP 82 play animation $31.
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A.

code_007115 {
    COP [80] ( #31 )
    COP [82]
    RTL 
}
---------------------------------------------

; Scenery type $51: animation $32.
; 
; When: meta type $51 in A00S09.
; Sees: a decoration with a fixed animation.
; Why: COP 80 / COP 82 play animation $32.
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A.

code_00711B {
    COP [80] ( #32 )
    COP [82]
    RTL 
}
---------------------------------------------

; Scenery type $52: animation $33.
; 
; When: meta type $52 in A00S09.
; Sees: a decoration with a fixed animation.
; Why: COP 80 / COP 82 play animation $33.
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A.

code_007121 {
    COP [80] ( #33 )
    COP [82]
    RTL 
}
---------------------------------------------

; The animated backdrop of the hub (type $3D).
; 
; When: meta type $3D in A00S09.
; Sees: a looping animation $2D; while event flag $1F04 is set and $1F05 is clear it loops animation $4B instead.
; Why: the backdrop changes in the first post-ending step.
; In: actor script, X = own slot.
; Out: loops for ever (COP 92 / COP 94 animation ticks): $1F05 set: $2D; $1F04 set: $4B; neither flag: $2D.
; Clobbers: A.

gv_obj_up_above_backdrop_007127 {
    COP [07] ( #$9F05, &code_007133 )
    COP [07] ( #$9F04, &code_00713A )
}

code_007133 {
    COP [92] ( #2D )
    COP [94]
    BRA code_007133
}

code_00713A {
    COP [92] ( #4B )
    COP [94]
    BRA code_00713A
}
---------------------------------------------

; Draws a pair of marker sprites for every gate flag that is set.
; 
; When: spawned by the walker at its start.
; Sees: marker sprites (COP AC at the given x, y, flags $0040): for flag $1B00 at (x $70, y $D0) and ($30, $150); $1B01 ($40, $160) and ($E0, $160); $1B02 ($F0, $150) and ($F0, $80); $1B03 ($100, $70) and ($1A0, $140); $1B04 ($1B0, $130) and ($170, $90); $1B05 ($170, $50) and ($100, $30).
; Why: the gates open with the same flags as the path (the walker reads $1B00-$1B05).
; In: actor script, X = own slot.
; Out: one COP AC pair per set flag, then COP 86.
; Clobbers: A, Y.

gv_obj_up_above_path_markers_007141 {
    COP [07] ( #$9B00, &code_007149 )
    BRA loc_00716F
}

code_007149 {
    COP [AC] ( @code_007161, #$0070, #$00D0, #$0040 )
    COP [AC] ( @code_007169, #$0030, #$0150, #$0040 )
    BRA loc_00716F
}

---------------------------------------------
; Marker for gate $1B00 (first of the pair): animation $0E, mirrored (COP 96).
; 
; When: spawned by gv_obj_up_above_path_markers_007141 at (x $70, y $D0).
; Sees: a marker sprite.
; Why: its animation id is passed in A to the shared tail loc_007254.
; In: actor script, X = own slot.
; Out: animation set, COP 91, COP 82, then a loop (COP 1B, $FF frames) that keeps it alive.
; Clobbers: A.

code_007161 {
    COP [96]
    LDA #$000E
    BRL loc_007254
}

---------------------------------------------
; Marker for gate $1B00 (second of the pair): animation $0B.
; 
; When: spawned by gv_obj_up_above_path_markers_007141 at (x $30, y $150).
; Sees: a marker sprite.
; Why: see code_007161.
; In: actor script, X = own slot.
; Out: shared tail loc_007254.
; Clobbers: A.

code_007169 {
    LDA #$000B
    BRL loc_007254

  loc_00716F:
    COP [07] ( #$9B01, &code_007177 )
    BRA loc_00719D
}

code_007177 {
    COP [AC] ( @code_00718F, #$0040, #$0160, #$0040 )
    COP [AC] ( @code_007195, #$00E0, #$0160, #$0040 )
    BRA loc_00719D
}

---------------------------------------------
; Marker for gate $1B01 (first of the pair): animation $08.
; 
; When: spawned by gv_obj_up_above_path_markers_007141 at (x $40, y $160).
; Sees: a marker sprite.
; Why: see code_007161.
; In: actor script, X = own slot.
; Out: shared tail loc_007254.
; Clobbers: A.

code_00718F {
    LDA #$0008
    BRL loc_007254
}

---------------------------------------------
; Marker for gate $1B01 (second of the pair): animation $08, mirrored.
; 
; When: spawned by gv_obj_up_above_path_markers_007141 at (x $E0, y $160).
; Sees: a marker sprite.
; Why: see code_007161.
; In: actor script, X = own slot.
; Out: shared tail loc_007254.
; Clobbers: A.

code_007195 {
    COP [96]
    LDA #$0008
    BRL loc_007254

  loc_00719D:
    COP [07] ( #$9B02, &code_0071A5 )
    BRA loc_0071CB
}

code_0071A5 {
    COP [AC] ( @code_0071BD, #$00F0, #$0150, #$0040 )
    COP [AC] ( @code_0071C3, #$00F0, #$0080, #$0040 )
    BRA loc_0071CB
}

---------------------------------------------
; Marker for gate $1B02 (first of the pair): animation $07.
; 
; When: spawned by gv_obj_up_above_path_markers_007141 at (x $F0, y $150).
; Sees: a marker sprite.
; Why: see code_007161.
; In: actor script, X = own slot.
; Out: shared tail loc_007254.
; Clobbers: A.

code_0071BD {
    LDA #$0007
    BRL loc_007254
}

---------------------------------------------
; Marker for gate $1B02 (second of the pair): animation $07, flipped vertically (COP 98).
; 
; When: spawned by gv_obj_up_above_path_markers_007141 at (x $F0, y $80).
; Sees: a marker sprite.
; Why: see code_007161.
; In: actor script, X = own slot.
; Out: shared tail loc_007254.
; Clobbers: A.

code_0071C3 {
    COP [98]
    LDA #$0007
    BRL loc_007254

  loc_0071CB:
    COP [07] ( #$9B03, &code_0071D3 )
    BRA loc_0071F7
}

code_0071D3 {
    COP [AC] ( @code_0071EB, #$0100, #$0070, #$0040 )
    COP [AC] ( @code_0071F1, #$01A0, #$0140, #$0040 )
    BRA loc_0071F7
}

---------------------------------------------
; Marker for gate $1B03 (first of the pair): animation $0C.
; 
; When: spawned by gv_obj_up_above_path_markers_007141 at (x $100, y $70).
; Sees: a marker sprite.
; Why: see code_007161.
; In: actor script, X = own slot.
; Out: shared tail loc_007254.
; Clobbers: A.

code_0071EB {
    LDA #$000C
    BRL loc_007254
}

---------------------------------------------
; Marker for gate $1B03 (second of the pair): animation $0F.
; 
; When: spawned by gv_obj_up_above_path_markers_007141 at (x $1A0, y $140).
; Sees: a marker sprite.
; Why: see code_007161.
; In: actor script, X = own slot.
; Out: shared tail loc_007254.
; Clobbers: A.

code_0071F1 {
    LDA #$000F
    BRL loc_007254

  loc_0071F7:
    COP [07] ( #$9B04, &code_0071FF )
    BRA loc_007225
}

code_0071FF {
    COP [AC] ( @code_007217, #$01B0, #$0130, #$0040 )
    COP [AC] ( @code_00721F, #$0170, #$0090, #$0040 )
    BRA loc_007225
}

---------------------------------------------
; Marker for gate $1B04 (first of the pair): animation $0B, mirrored.
; 
; When: spawned by gv_obj_up_above_path_markers_007141 at (x $1B0, y $130).
; Sees: a marker sprite.
; Why: see code_007161.
; In: actor script, X = own slot.
; Out: shared tail loc_007254.
; Clobbers: A.

code_007217 {
    COP [96]
    LDA #$000B
    BRL loc_007254
}

---------------------------------------------
; Marker for gate $1B04 (second of the pair): animation $0E.
; 
; When: spawned by gv_obj_up_above_path_markers_007141 at (x $170, y $90).
; Sees: a marker sprite.
; Why: see code_007161.
; In: actor script, X = own slot.
; Out: shared tail loc_007254.
; Clobbers: A.

code_00721F {
    LDA #$000E
    BRL loc_007254

  loc_007225:
    COP [07] ( #$9B05, &code_00722D )
    BRA loc_007243
}

code_00722D {
    COP [AC] ( @code_007246, #$0170, #$0050, #$0040 )
    COP [AC] ( @code_00724E, #$0100, #$0030, #$0040 )

  loc_007243:
    COP [86]
    RTL 
}

---------------------------------------------
; Marker for gate $1B05 (first of the pair): animation $0A, mirrored.
; 
; When: spawned by gv_obj_up_above_path_markers_007141 at (x $170, y $50).
; Sees: a marker sprite.
; Why: see code_007161.
; In: actor script, X = own slot.
; Out: shared tail loc_007254.
; Clobbers: A.

code_007246 {
    COP [96]
    LDA #$000A
    BRL loc_007254
}

---------------------------------------------
; Marker for gate $1B05 (second of the pair): animation $09.
; 
; When: spawned by gv_obj_up_above_path_markers_007141 at (x $100, y $30).
; Sees: a marker sprite.
; Why: see code_007161.
; In: actor script, X = own slot.
; Out: shared tail loc_007254.
; Clobbers: A.

code_00724E {
    LDA #$0009
    BRL loc_007254

  loc_007254:
    STA $001E, X
    STZ $0020, X
    COP [91]
    COP [82]

  code_00725E:
    COP [1B] ( &code_00725E, #$00FF )
}

---------------------------------------------
; The first post-ending step in the hub.
; 
; When: the walker branches here when event flag $1F04 is set and $1F05 is clear.
; Sees: the pad is blocked, the player is hidden (COP 34), the sound BRK $86 plays and $01A4 (420) frames pass.
; Why: a short cut scene replaces the walker; what it shows is open (OQ-I034-14).
; In: actor script, X = own slot.
; Out: joy_block_mask |= $BF80; spawns gv_obj_up_above_post_ending_child_007290; after $01A4 frames code_007279 sets reload_menu_gfx + 1, clears the asset caches, sets event flag $1F05 and starts COP 10 to area 0 scene 7 at ($70,$60).
; Clobbers: A.

gv_obj_up_above_post_ending_007264 {
    LDA #$BF80
    TSB $joy_block_mask
    COP [85] ( @gv_obj_up_above_post_ending_child_007290 )
    COP [34]
    BRK #$86
    COP [1B] ( &code_007279, #$01A4 )
}

code_007279 {
    INC $reload_menu_gfx
    STZ $asset_cache_gfx2
    STZ $asset_cache_gfx3
    COP [09] ( #$9F05 )
    COP [10] ( #$0700, #00, #$0070, #$0060 )
    RTL 
}

---------------------------------------------
; Helper of the post-ending step: plays an animation and ends.
; 
; When: spawned by gv_obj_up_above_post_ending_007264.
; Sees: animation $44 (COP 92 / COP 94) with the table $8000 / $0D set by COP A8 (CopA8_SetAnimationTable), then the actor ends (COP 86).
; Why: it is the visible part of the cut scene.
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A.

gv_obj_up_above_post_ending_child_007290 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #44 )
    COP [94]
    COP [86]
    RTL 
}
---------------------------------------------

; The voice of the Master and the name entry.
; 
; When: meta type $54 in A00S01 (first scene); runs once because event flag $1F06 is set on the first run.
; Sees: 'A voice came from above ... Please choose a name for yourself.', the name entry screen, then 'What an interesting name. Allright, go and save the world for all creatures.'
; Why: the hero's name is entered here (COP 3A); later dialogue prints it with [02:2].
; In: actor script, X = own slot.
; Out: COP 1B waits 2 frames, then the first text, COP 3A, the second text and COP 86.
; Clobbers: A.

gv_obj_name_entry_voice_00797B {
    COP [07] ( #$9F06, &code_007995 ) ; event flag $1F06: the name was chosen (set on the first run)
    COP [09] ( #$9F06 )
    COP [1B] ( &code_00798B, #$0002 )
}

code_00798B {
    COP [01] ( &asciistring_007998 )
    COP [3A]
    COP [01] ( &asciistring_007A06 )
}

code_007995 {
    COP [86]
    RTL 
}

asciistring_007998 |[10]A voice came from [N]above- [FIN]"My follower, since [N]you will be able to [N]speak with all living [N]things, [FIN]you should have a [N]name- Please choose a [N]name for yourself- [JMP:&shared_actor_helpers_bank0.asciistring_007A52]|

asciistring_007A06 |[10][02:2],------- [N]What an interesting [N]name- [FIN]Allright, go and save [N]the world for all [N]creatures- [JMP:&shared_actor_helpers_bank0.asciistring_007A52]|