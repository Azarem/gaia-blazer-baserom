; The shared actor helpers of bank 00: a colour-cycle loop, the flight of the enemy aimed shot and the Master of the shrines (file offsets 10728-10731, 11623-11967 and 30316-31318, SNES $00:A9E8-$A9EB, $00:AD67-$AEBF and $00:F66C-$FA56; bank 00).
; 
; === WHAT RUNS HERE ===
; - cm_fx_palette_cycle_loop_0029E8: the one-command script of the 65 meta entries that only cycle palette entries (COP 94 every frame over a colour list of PaletteAnimLists).
; - cm_enemy_aimed_shot_body_002D67 and cm_enemy_aimed_shot_mover_002D96: the flight of an enemy shot. Eight shot scripts (the Blue Torch, Fire Man and Fire Bat fireballs, the statues of the castle dungeon and the towers, the Bouncing Ball, the pop-up turret of the World of Evil, the Tin Doll) set Y to their flight animation, push the address of the body and RTL into it. The body spawns the invisible mover just before the shot (COP 85); the mover fixes a direction once, from the hero's position at that moment, and drags the shot along a straight line. The Purple Flower's bee (gw_lostside_marsh_enemies) spawns the mover on its own.
; - cm_npc_master_*: the Master of the shrine scenes of Up Above (A00S01-A00S07, one meta type per world: $55, $4C, $51, $3D, $2D, $36, $10; flags $2040). He has no sprite and speaks as 'A voice came from above' (the ROM never names him; the walkthrough calls him the Master). The walkthrough: the northern square of Up Above 'will allow you to save your adventure, as well as move on later in the game' (01-in-the-beginning.md), and the shrine fully restores the hero's health on arrival.
; 
; === HOW THE MASTER WORKS ===
; The root heals the hero (COP 37) and falls into the poll loop, which every frame tests the hero's tile (COP 0D with slot 0): tile (7,4) opens the menu, tile (7,6) is the arrival tile (comfort after a death, then the one-time stone hint). The menu is Record / Quit, or Record / Move / Quit once event flag $1B00 is set. Record saves through lib_save_system.SaveGameToSlot behind a blocked pad and asks whether to continue; answering No ends the session in the 'Rest well' scene (puff, hero hidden, music fade, pad blocked and never freed). Move leaves for scene 9 of area 0, the hub of Up Above (A00S09), where the map walker starts on the stop of the current world (cm_data_master_move_hub_positions_0076D3). Quit and every cancelled menu go to the farewell, which waits until the hero steps off the menu tile before the poll starts again.
; 
; === EVENT FLAGS AND SHARED STATE ===
; $1B00: the Master's voice about the Brown Stone was heard (set in Grass Valley, gv_village_actors_019475); adds Move to the menu and enables the stone hint. $0602: the stone hint was told (set once, used nowhere else). joy_block_mask ($0326): the Record blocks $7FC0 while it saves (TSB, then TRB), the Rest well scene blocks $7F80 and never frees it. player_died ($043F): set when the hero died; the arrival branch clears it after the comfort text.
; 
; === OPEN ===
; OQ-I041-1 what the player sees after 'Rest well', OQ-I041-2 the Move start stops in the emulator, OQ-I041-3 the aimed-shot directions in the emulator, OQ-I041-4 that the menu tile is the walkthrough's northern square, OQ-I041-5 the low-byte divisor of the ratio, OQ-I041-6 the sound ids $66 and $8E and the music track $13. Which scene effect each colour-cycle type is: OQ-I033-6.
---------------------------------------------

?BANK 00

?INCLUDE 'lib_arithmetic'
?INCLUDE 'lib_save_system'
?INCLUDE 'shared_choice_prompt_texts'

!L_choice_result                0003D0
!scene_next                     0318
!joy_block_mask                 0326
!scene_sprite_attr              0372
!player_x                       0374
!player_y                       0376
!warp_dest_x                    037C
!warp_dest_y                    037E
!world_index                    03BA
!player_died                    043F

---------------------------------------------

; The script of the colour-cycle props.
; 
; When: the root of 65 meta entries (placed by the scene placement lists; also used directly by one World of Evil script). Each entry gives an animation id that selects one colour list of PaletteAnimLists.
; Sees: no sprite of its own; palette entries step through shades or the backdrop is faded through the colour-math registers (which effect each type is: OQ-I033-6).
; Why: cycling colours is cheaper than redrawing tiles, and one two-instruction script serves every prop of this kind.
; In: actor script, X = own slot.
; Out: COP 94 steps the colour list each frame and yields; the branch restarts it. Never ends.
; Clobbers: A, Y.

cm_fx_palette_cycle_loop_0029E8 {
    COP [94]
    BRA cm_fx_palette_cycle_loop_0029E8
}
---------------------------------------------

; The body of an enemy shot: it flies toward where the hero was when it was fired.
; 
; When: entered by RTL from eight shot scripts (they push this address minus 1 and RTL, so it runs as the shot's own script), with Y = the flight animation id: Blue Torch fireball $1F, Fire Man fireball $28, Fire Bat fireball $2A, castle dungeon statue 5, castle tower statue $20, Bouncing Ball energy circle $10, World of Evil pop-up turret $2E, Tin Doll fireball 3. The callers set flags $0200 (cannot be hit).
; Sees: the shot flies in a straight line toward the hero's position at the moment it was fired and disappears when it leaves the screen.
; Why: one shared body gives every projectile the same flight; the callers only choose the animation and the sound.
; In: X = D = the shot; Y = animation id.
; Out: $1E = Y, $20 = 0; the invisible mover cm_enemy_aimed_shot_mover_002D96 is spawned just before the shot (COP 85), so the shot's $3E is the mover. The shot then plays its animation in a loop (COP 82) while it is on screen; off screen it stores its flags word into the mover's $30, which makes the mover end, kills itself (COP 86) and returns. When no actor slot is free (Y = $06AA, the pool-full value of PopFreeSlot) it kills itself at once.
; Clobbers: A, Y.

cm_enemy_aimed_shot_body_002D67 {
    TYA                   ; Y = the flight animation id of the caller (it pushed this address and RTLed here)
    STA $001E, X
    STZ $0020, X
    COP [85] ( @cm_enemy_aimed_shot_mover_002D96 ) ; the invisible mover is spawned just before the shot: afterwards the shot's $3E is the mover
    CPY #$06AA            ; $06AA: PopFreeSlot's pool-full value, no mover could be made
    BEQ cm_enemy_aimed_shot_body_end_002D93
    SEP #$20
    LDA #$00
    STA $0036, X
    REP #$20
    COP [91]

; The wait loop of the shot: one animation pass per round (COP 82) while the shot is on screen ($16 bit $8000 clear).
; 
; When: after the mover was spawned.
; Sees: the flying animation.
; Why: the shot only animates; the mover moves it.
; In: X = own slot.
; Out: when the shot is off screen it hands its flags word to the mover ($30 of the mover) and falls into cm_enemy_aimed_shot_body_end_002D93.
; Clobbers: A, Y.

  cm_enemy_aimed_shot_body_wait_002D83:
    COP [82]
    LDA $0016, X
    BIT #$8000
    BEQ cm_enemy_aimed_shot_body_wait_002D83
    LDY $003E, X          ; the mover (the actor linked just before the shot)
    STA $0030, Y          ; the flags word (never a link) goes into the mover's $30: the mover ends itself

; The end of the shot: COP 86 removes it and RTL returns to the scheduler. Reached when no mover could be spawned or the shot left the screen.

  cm_enemy_aimed_shot_body_end_002D93:
    COP [86]
    RTL 
}

---------------------------------------------
; The invisible mover of an aimed shot: it fixes a direction once and drags the shot along a straight line.
; 
; When: spawned (COP 85) by cm_enemy_aimed_shot_body_002D67, and by the Purple Flower's bee, which spawns a new one every wing cycle.
; Sees: nothing (a spawned actor is hidden, $16 bit $2000); the shot or bee it carries moves toward the hero's position at launch.
; Why: the shot's own script is busy animating, so a second actor does the moving; it copies its x and y to the shot every frame.
; In: X = D = the mover, spawned just before the shot, so its $3C is the shot; its position is the shot's.
; Out: $30 = the shot's slot. dx = hero x - x and dy = hero y - y give one of eight cases by their signs and by which of |dx|, |dy| is larger (equal counts as dy): the larger axis moves one pixel per frame and every N-th frame the other axis moves one pixel too, with N = floor(major / minor) (cm_enemy_aimed_shot_ratio_*; $10 = frame counter, $12 = reload value). The direction is not recomputed. The mover ends (COP 86) when its next link $3C no longer equals $30: the shot was removed, wrote its flags into $30, or a newer mover was spawned before the bee.
; Clobbers: A, Y; dp $16 and $18 hold |dx| and |dy|.

cm_enemy_aimed_shot_mover_002D96 {
    LDA $003C, X          ; $3C of a before-spawned actor = its spawner: $30 keeps the shot's slot to notice when it is gone
    STA $0030, X
    LDA $player_x         ; dx = hero x - own x: the signs and the larger of |dx| and |dy| pick one of the eight cases below, once
    SEC 
    SBC $0000, X
    BMI cm_enemy_aimed_shot_mover_dx_left_002DC4
    STA $16
    LDA $player_y
    SEC 
    SBC $0002, X
    BMI cm_enemy_aimed_shot_mover_dy_up_002DB8
    STA $18
    CMP $16
    BCS cm_enemy_aimed_shot_mover_major_down_minor_right_002E23
    BRA cm_enemy_aimed_shot_mover_major_right_minor_down_002E11

; dx >= 0 and dy < 0 (the hero is up and to the right): |dy| goes to $18 and is compared with |dx|; |dy| >= |dx| selects cm_enemy_aimed_shot_mover_major_up_minor_right_002DEA, otherwise cm_enemy_aimed_shot_mover_major_right_minor_up_002DFF.

  cm_enemy_aimed_shot_mover_dy_up_002DB8:
    EOR #$FFFF
    INC 
    STA $18
    CMP $16
    BCS cm_enemy_aimed_shot_mover_major_up_minor_right_002DEA
    BRA cm_enemy_aimed_shot_mover_major_right_minor_up_002DFF

; dx < 0 (the hero is to the left): |dx| goes to $16 and dy is computed. dy < 0 continues at cm_enemy_aimed_shot_mover_dx_left_dy_up_002DDB; otherwise |dy| >= |dx| selects cm_enemy_aimed_shot_mover_major_down_minor_left_002E35, else cm_enemy_aimed_shot_mover_major_left_minor_down_002E47.

  cm_enemy_aimed_shot_mover_dx_left_002DC4:
    EOR #$FFFF
    INC 
    STA $16
    LDA $player_y
    SEC 
    SBC $0002, X
    BMI cm_enemy_aimed_shot_mover_dx_left_dy_up_002DDB
    STA $18
    CMP $16
    BCS cm_enemy_aimed_shot_mover_major_down_minor_left_002E35
    BRA cm_enemy_aimed_shot_mover_major_left_minor_down_002E47

; dx < 0 and dy < 0 (the hero is up and to the left): |dy| goes to $18; |dy| < |dx| goes through cm_enemy_aimed_shot_mover_jump_major_left_minor_up_002DE8 to the left-major case, otherwise to cm_enemy_aimed_shot_mover_major_up_minor_left_002E6B.

  cm_enemy_aimed_shot_mover_dx_left_dy_up_002DDB:
    EOR #$FFFF
    INC 
    STA $18
    CMP $16
    BCC cm_enemy_aimed_shot_mover_jump_major_left_minor_up_002DE8
    BRL cm_enemy_aimed_shot_mover_major_up_minor_left_002E6B

; A one-instruction stub: the BCC above ends here and the BRA goes on to cm_enemy_aimed_shot_mover_major_left_minor_up_002E59.

  cm_enemy_aimed_shot_mover_jump_major_left_minor_up_002DE8:
    BRA cm_enemy_aimed_shot_mover_major_left_minor_up_002E59

; Case up and right, |dy| >= |dx|: y - 1 every frame, x + 1 every N-th frame.
; 
; When: chosen once by the sign tests at the start of the mover.
; Sees: the shot flies up, bending to the right.
; Why: the first pass computes N (cm_enemy_aimed_shot_ratio_y_major_002E9C); COP 91 then makes the step below the re-entry point, so every later frame only steps and follows the shot.
; In: X = D = the mover; $16 = |dx|, $18 = |dy|.
; Out: moves $00 / $02 of the mover; ends in cm_enemy_aimed_shot_mover_follow_002E83.
; Clobbers: A, Y.

  cm_enemy_aimed_shot_mover_major_up_minor_right_002DEA:
    JSR $&cm_enemy_aimed_shot_ratio_y_major_002E9C ; the ratio N is computed once; COP 91 makes the step below the re-entry point
    COP [91]
    DEC $0002, X
    DEC $0010, X
    BEQ cm_enemy_aimed_shot_mover_minor_right_002DFA
    BRL cm_enemy_aimed_shot_mover_follow_002E83

; The minor step of the up-and-right case: x + 1, then the counter is reloaded (cm_enemy_aimed_shot_mover_reload_002E7D).

  cm_enemy_aimed_shot_mover_minor_right_002DFA:
    INC $0000, X
    BRA cm_enemy_aimed_shot_mover_reload_002E7D

; Case up and right, |dx| > |dy|: x + 1 every frame, y - 1 every N-th frame (N from cm_enemy_aimed_shot_ratio_x_major_002EA4; the pattern is the same as in cm_enemy_aimed_shot_mover_major_up_minor_right_002DEA).

  cm_enemy_aimed_shot_mover_major_right_minor_up_002DFF:
    JSR $&cm_enemy_aimed_shot_ratio_x_major_002EA4
    COP [91]
    INC $0000, X
    DEC $0010, X
    BNE cm_enemy_aimed_shot_mover_follow_002E83
    DEC $0002, X
    BRA cm_enemy_aimed_shot_mover_reload_002E7D

; Case down and right, |dx| > |dy|: x + 1 every frame, y + 1 every N-th frame (N from cm_enemy_aimed_shot_ratio_x_major_002EA4).

  cm_enemy_aimed_shot_mover_major_right_minor_down_002E11:
    JSR $&cm_enemy_aimed_shot_ratio_x_major_002EA4
    COP [91]
    INC $0000, X
    DEC $0010, X
    BNE cm_enemy_aimed_shot_mover_follow_002E83
    INC $0002, X
    BRA cm_enemy_aimed_shot_mover_reload_002E7D

; Case down and right, |dy| >= |dx|: y + 1 every frame, x + 1 every N-th frame (N from cm_enemy_aimed_shot_ratio_y_major_002E9C).

  cm_enemy_aimed_shot_mover_major_down_minor_right_002E23:
    JSR $&cm_enemy_aimed_shot_ratio_y_major_002E9C
    COP [91]
    INC $0002, X
    DEC $0010, X
    BNE cm_enemy_aimed_shot_mover_follow_002E83
    INC $0000, X
    BRA cm_enemy_aimed_shot_mover_reload_002E7D

; Case down and left, |dy| >= |dx|: y + 1 every frame, x - 1 every N-th frame (N from cm_enemy_aimed_shot_ratio_y_major_002E9C).

  cm_enemy_aimed_shot_mover_major_down_minor_left_002E35:
    JSR $&cm_enemy_aimed_shot_ratio_y_major_002E9C
    COP [91]
    INC $0002, X
    DEC $0010, X
    BNE cm_enemy_aimed_shot_mover_follow_002E83
    DEC $0000, X
    BRA cm_enemy_aimed_shot_mover_reload_002E7D

; Case down and left, |dx| > |dy|: x - 1 every frame, y + 1 every N-th frame (N from cm_enemy_aimed_shot_ratio_x_major_002EA4).

  cm_enemy_aimed_shot_mover_major_left_minor_down_002E47:
    JSR $&cm_enemy_aimed_shot_ratio_x_major_002EA4
    COP [91]
    DEC $0000, X
    DEC $0010, X
    BNE cm_enemy_aimed_shot_mover_follow_002E83
    INC $0002, X
    BRA cm_enemy_aimed_shot_mover_reload_002E7D

; Case up and left, |dx| > |dy|: x - 1 every frame, y - 1 every N-th frame (N from cm_enemy_aimed_shot_ratio_x_major_002EA4).

  cm_enemy_aimed_shot_mover_major_left_minor_up_002E59:
    JSR $&cm_enemy_aimed_shot_ratio_x_major_002EA4
    COP [91]
    DEC $0000, X
    DEC $0010, X
    BNE cm_enemy_aimed_shot_mover_follow_002E83
    DEC $0002, X
    BRA cm_enemy_aimed_shot_mover_reload_002E7D

; Case up and left, |dy| >= |dx|: y - 1 every frame, x - 1 every N-th frame (N from cm_enemy_aimed_shot_ratio_y_major_002E9C).

  cm_enemy_aimed_shot_mover_major_up_minor_left_002E6B:
    JSR $&cm_enemy_aimed_shot_ratio_y_major_002E9C
    COP [91]
    DEC $0002, X
    DEC $0010, X
    BNE cm_enemy_aimed_shot_mover_follow_002E83
    DEC $0000, X
    BRA cm_enemy_aimed_shot_mover_reload_002E7D

; Reloads the frame counter $10 from $12 after a minor step and falls into cm_enemy_aimed_shot_mover_follow_002E83.

  cm_enemy_aimed_shot_mover_reload_002E7D:
    LDA $0012, X
    STA $0010, X

; Ends every frame of the mover: while $3C is still the shot ($30) its x and y are copied to the shot and the script yields (RTL; the entry saved by COP 91 repeats the step next frame). Otherwise the shot is gone and the mover ends.

  cm_enemy_aimed_shot_mover_follow_002E83:
    LDA $003C, X          ; the shot still right behind the mover ($3C = $30)? copy x and y to it; otherwise the mover ends
    CMP $0030, X
    BNE cm_enemy_aimed_shot_mover_end_002E99
    TAY 
    LDA $0000, X
    STA $0000, Y
    LDA $0002, X
    STA $0002, Y
    RTL 

; The end of the mover: COP 86 removes it, RTL.

  cm_enemy_aimed_shot_mover_end_002E99:
    COP [86]
    RTL 
}

---------------------------------------------
; The step ratio when the y distance is the larger one.
; 
; When: JSR from the four y-major cases of the mover, once per mover, before COP 91.
; Sees: n/a.
; Why: a straight line on the pixel grid needs the number of major-axis steps between two minor-axis steps.
; In: dp $18 = |dy| (major), dp $16 = |dx| (minor); only its low byte is used as the divisor; X = the mover.
; Out: $10 and $12 of the mover = N = floor(major / minor), at least 1 (a minor distance of 0 counts as 1); M = 16.
; Clobbers: A, Y.

cm_enemy_aimed_shot_ratio_y_major_002E9C {
    SEP #$20
    LDY $18               ; Y = major distance, A = minor distance (low byte): N = major / minor
    LDA $16
    BRA cm_enemy_aimed_shot_ratio_divisor_002EAA
}

---------------------------------------------
; The step ratio when the x distance is the larger one: the same as cm_enemy_aimed_shot_ratio_y_major_002E9C with the roles of $16 (|dx|, major) and $18 (|dy|, minor) swapped.

cm_enemy_aimed_shot_ratio_x_major_002EA4 {
    SEP #$20
    LDY $16
    LDA $18

; Joint part of both ratio entries: a minor distance (low byte) of 0 becomes 1 before the division.

  cm_enemy_aimed_shot_ratio_divisor_002EAA:
    BNE cm_enemy_aimed_shot_ratio_divide_002EAD
    INC 

; Divides the major distance (Y) by the minor distance (A, 8 bits) with the hardware divider (lib_arithmetic.DivideWordByByte); only the low byte of the quotient is kept.

  cm_enemy_aimed_shot_ratio_divide_002EAD:
    JSL $@lib_arithmetic.DivideWordByByte
    REP #$20
    AND #$00FF
    BNE cm_enemy_aimed_shot_ratio_store_002EB9
    INC 

; Stores N in both counters, $10 (running) and $12 (reload); a quotient of 0 became 1 just before. RTS.

  cm_enemy_aimed_shot_ratio_store_002EB9:
    STA $0010, X
    STA $0012, X
    RTS 
}
---------------------------------------------

; The Master of a shrine scene: heals the hero on arrival and opens his menu on the northern square.
; 
; When: the root of the Master actor of each shrine scene of Up Above (A00S01-A00S07; one meta type per world, flags $2040), started with the scene.
; Sees: the hero's health is restored to full on arrival (walkthrough 01-in-the-beginning.md); the Master has no sprite, he only speaks, as 'A voice came from above-'.
; Why: the shrine is where the walkthrough says to heal and save.
; In: actor script, X = own slot.
; Out: COP 37 heals the hero; falls into cm_npc_master_shrine_poll_00766E.
; Clobbers: A, Y.

cm_npc_master_shrine_menu_00766C {
    COP [37]              ; the hero's health is restored to full on arrival

; The Master's poll loop: each frame it looks for the hero on one of two tiles.
; 
; When: every frame while the hero is in the shrine scene (COP 91 makes this the re-entry point).
; Sees: nothing until the hero stands on tile (7,4), which this note takes for the walkthrough's northern square (OQ-I041-4), or on tile (7,6), the arrival tile.
; Why: the menu opens by position, not by a button.
; In: X = own slot.
; Out: COP 0D (slot 0 = the hero) jumps to cm_npc_master_greeting_00767F on (7,4) and to cm_npc_master_arrival_007765 on (7,6); otherwise RTL.
; Clobbers: A, Y.

  cm_npc_master_shrine_poll_00766E:
    COP [91]
    COP [0D] ( #00, #07, #04, &cm_npc_master_greeting_00767F ) ; slot 0 = the hero on tile (7,4): the menu
    COP [0D] ( #00, #07, #06, &cm_npc_master_arrival_007765 ) ; the hero on tile (7,6), the arrival tile: death comfort or stone hint
    RTL 
}

---------------------------------------------
; The Master's greeting and the Record / Quit menu.
; 
; When: the hero stands on tile (7,4).
; Sees: 'A voice came from above-' and, after the key, '<name>, how can I help you?'; with flag $1B00 clear the window ChoiceRecordQuitText (Record / Quit).
; Why: saving is always offered; flag $1B00 (the Brown Stone was handed over in Grass Valley) adds Move.
; In: X = own slot.
; Out: flag $1B00 set: jump to cm_npc_master_greeting_with_move_00769C. Otherwise COP 1A (2 options, cancel = farewell): index 0 Record goes to cm_npc_master_record_0076EF, any other answer to cm_npc_master_greeting_quit_007699.
; Clobbers: A.

cm_npc_master_greeting_00767F {
    COP [01] ( &asciistring_0077B0 )
    COP [07] ( #$9B00, &cm_npc_master_greeting_with_move_00769C ) ; flag $1B00 set (the Brown Stone was handed over): the menu with Move
    COP [1A] ( &shared_choice_prompt_texts.ChoiceRecordQuitText, #02, &cm_npc_master_farewell_007754 )
    LDA $L_choice_result
    BNE cm_npc_master_greeting_quit_007699
    BRL cm_npc_master_record_0076EF

; The Quit answer of the two-option menu: BRL to the farewell cm_npc_master_farewell_007754.

  cm_npc_master_greeting_quit_007699:
    BRL cm_npc_master_farewell_007754
}

---------------------------------------------
; The Record / Move / Quit menu.
; 
; When: the greeting found flag $1B00 set.
; Sees: the window ChoiceRecordMoveQuitText after the same greeting.
; Why: Move is added once the Grass Valley chief has handed over the Brown Stone.
; In: X = own slot.
; Out: COP 1A (3 options, cancel = farewell): index 0 Record goes to cm_npc_master_record_0076EF, 1 Move to cm_npc_master_move_to_hub_0076B2, 2 Quit to the farewell.
; Clobbers: A.

cm_npc_master_greeting_with_move_00769C {
    COP [1A] ( &shared_choice_prompt_texts.ChoiceRecordMoveQuitText, #03, &cm_npc_master_farewell_007754 )
    LDA $L_choice_result
    BNE cm_npc_master_greeting_move_or_quit_0076AC
    BRL cm_npc_master_record_0076EF

; Splits the answers that are not Record: index 1 is Move, any other answer is Quit (the farewell).

  cm_npc_master_greeting_move_or_quit_0076AC:
    DEC 
    BEQ cm_npc_master_move_to_hub_0076B2
    BRL cm_npc_master_farewell_007754

; The Move answer: the hero leaves for the Up Above hub.
; 
; When: the hero chose Move (possible once flag $1B00 is set).
; Sees: the dialogue window closes (asciistring_007866) and the scene changes to area 0 scene 9, the hub (A00S09), where the map walker gv_obj_up_above_map_walker_006E28 stands on the stop of the current world. From the hub the hero walks to a stop and presses B to enter that stop's shrine scene (stop k leads to scene k + 1).
; Why: the walkthrough's 'move on later in the game' (01-in-the-beginning.md).
; In: X = own slot; world_index.
; Out: scene_next = $0009; warp_dest_x and warp_dest_y = the pair of cm_data_master_move_hub_positions_0076D3 for the current world (SpawnPlacementList places the player at warp_dest_y + 16). X is saved around the table read.
; Clobbers: A.

  cm_npc_master_move_to_hub_0076B2:
    COP [01] ( &asciistring_007866 )
    PHX 
    LDA #$0009            ; scene 9 of area 0: the Up Above hub (A00S09)
    STA $scene_next
    LDA $world_index      ; x 4: one (x, y) pair of 2 words per world
    ASL 
    ASL 
    TAX 
    LDA $@cm_data_master_move_hub_positions_0076D3, X
    STA $warp_dest_x
    LDA $@cm_data_master_move_hub_positions_0076D3+2, X
    STA $warp_dest_y
    PLX 
    RTL 
}
---------------------------------------------

; The start position in the hub for each world: 7 entries of 2 words (x, y).
; 
; When: read by cm_npc_master_move_to_hub_0076B2 with world_index x 4.
; Sees: n/a.
; Why: Move starts the map walker on the stop of the world the hero is in. The walker adds 16 to y and tests X $70 / $30 / $1B0 / $170, then Y $170 / $70: world 0 ($70,$A0) is stop 0, world 1 ($30,$160) stop 1, world 2 ($F0,$160) stop 2, world 3 ($F0,$60) stop 3, world 4 ($1B0,$140) stop 4, world 5 ($170,$60) stop 5, world 6 ($F0,$20) stop 6 (the remaining case).
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

cm_data_master_move_hub_positions_0076D3 [
  unk4 < #$0070, #$00A0 >   ;00
  unk4 < #$0030, #$0160 >   ;01
  unk4 < #$00F0, #$0160 >   ;02
  unk4 < #$00F0, #$0060 >   ;03
  unk4 < #$01B0, #$0140 >   ;04
  unk4 < #$0170, #$0060 >   ;05
  unk4 < #$00F0, #$0020 >   ;06
]
---------------------------------------------

; The Record path, with the 'Rest well' ending of the continue question.
; 
; When: the hero chose Record.
; Sees: 'I will record all you have accomplished- Is this okay?' with Yes / No. No (or cancel) is the farewell. Yes: a sound (BRK $66), the game is saved (lib_save_system.SaveGameToSlot) while the pad is blocked for 61 frames, then 'Finished recording- Do you wish to continue?'. Yes is the farewell. No: 'Rest well, there is still much to be done-', the pad is blocked, 31 frames later a sound (BRK $8E), the appear puff (cm_fx_master_hero_puff_007798) on the hero's place, the hero is hidden (COP 34), 61 frames later the music fades to track $13 and the script ends in COP 91 and RTL.
; Why: Record is the save point of the game; the second question lets the player stop playing. Nothing here gives the pad back after Rest well, so the session ends there (a static reading: OQ-I041-1; the ids of the sounds and the track: OQ-I041-6).
; In: X = own slot; the save slot is the file chosen at the title.
; Out: choice_result: Yes = 0, No = 1. X is saved around the save call. joy_block_mask is blocked with $7FC0 (and freed again) during the save, and with $7F80 at Rest well (never freed).
; Clobbers: A, Y.

cm_npc_master_record_0076EF {
    COP [01] ( &asciistring_0077D4 )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &cm_npc_master_farewell_007754 )
    LDA $L_choice_result
    DEC 
    BEQ cm_npc_master_farewell_007754
    BRK #$66              ; sound request $66 before the save (OQ-I041-6)
    PHX 
    JSL $@lib_save_system.SaveGameToSlot
    PLX 
    LDA #$7FC0            ; block the pad while the save runs (freed again by the TRB below)
    TSB $joy_block_mask
    COP [03] ( #3D )      ; wait 61 frames ($3D)
    COP [04]
    LDA #$7FC0
    TRB $joy_block_mask
    COP [01] ( &asciistring_0077FA )
    COP [1A] ( &shared_choice_prompt_texts.ChoiceYesNoText, #02, &cm_npc_master_farewell_007754 )
    LDA $L_choice_result
    BEQ cm_npc_master_farewell_007754
    COP [01] ( &asciistring_007825 )
    LDA #$7F80            ; blocks the pad; nothing in this script frees it again (OQ-I041-1)
    TSB $joy_block_mask
    COP [03] ( #1F )
    COP [04]
    BRK #$8E
    COP [AC] ( @cm_fx_master_hero_puff_007798, #$0070, #$0050, #$0050 ) ; the appear puff on the hero's place: x $70, y $50, flags $50
    COP [34]
    COP [03] ( #3D )
    COP [04]
    COP [31] ( #13 )      ; fade the music into track $13 (OQ-I041-6)
    COP [91]
    RTL 
}

---------------------------------------------
; The Master's farewell and the wait for the hero to leave the menu tile.
; 
; When: Quit, No and every cancelled menu, and after a finished Record when the player continues.
; Sees: '<name>, you are doing well- Do not give up-'.
; Why: while the hero still stands on tile (7,4) the poll would open the menu again at once, so the script yields until he steps off.
; In: X = own slot.
; Out: COP 91 makes this the re-entry point; while the hero is on (7,4) it jumps to cm_npc_master_farewell_wait_007764, otherwise back to cm_npc_master_shrine_poll_00766E.
; Clobbers: A, Y.

cm_npc_master_farewell_007754 {
    COP [01] ( &asciistring_007848 )
    COP [91]
    COP [0D] ( #00, #07, #04, &cm_npc_master_farewell_wait_007764 ) ; the hero still on the menu tile: yield, so the menu does not reopen at once
    BRL cm_npc_master_shrine_poll_00766E
}

---------------------------------------------
; A single RTL: the yield used while the hero stands on the menu tile.

cm_npc_master_farewell_wait_007764 {
    RTL 
}

---------------------------------------------
; The hero is on the arrival tile (7,6).
; 
; When: the poll found the hero on tile (7,6).
; Sees: after a death the comfort text; otherwise the one-time stone hint.
; Why: the hero reappears here after a game over, and arrives here from every other scene of the world.
; In: X = own slot.
; Out: player_died set: it is cleared and COP 1B waits 2 frames before cm_npc_master_death_comfort_007773; otherwise it falls into cm_npc_master_stone_hint_00777B.
; Clobbers: A.

cm_npc_master_arrival_007765 {
    LDA $player_died      ; set by MarkPlayerDead: the hero comes back after a game over
    BEQ cm_npc_master_stone_hint_00777B
    STZ $player_died
    COP [1B] ( &cm_npc_master_death_comfort_007773, #$0002 )
}

---------------------------------------------
; The comfort text after a death: 'A voice came from above- Do not rush, but be patient- You must continue making steady progress-'. Then COP 27 yields back to the poll.

cm_npc_master_death_comfort_007773 {
    COP [01] ( &asciistring_00786A )
    COP [27] ( &cm_npc_master_shrine_poll_00766E )

; The one-time hint after the Brown Stone.
; 
; When: the hero arrives on tile (7,6) with flag $1B00 set and flag $0602 clear.
; Sees: 'The Brown Stone you received is one of 6 stones in this world- When all six of these stones are gathered, the gate leading to the World of Evil shall be opened- Now, you must go to GreenWood where the next stone awaits you-'.
; Why: it tells the player where the next stone is, once.
; In: X = own slot.
; Out: flag $0602 is set 3 frames before the text; if it was set already, or $1B00 is clear, the script goes to cm_npc_master_poll_again_007794.
; Clobbers: A.

  cm_npc_master_stone_hint_00777B:
    COP [07] ( #$8602, &cm_npc_master_poll_again_007794 ) ; flag $0602 set: the stone hint was told already
    COP [07] ( #$1B00, &cm_npc_master_poll_again_007794 ) ; flag $1B00 clear: the Brown Stone is not handed over yet, nothing to say
    COP [03] ( #03 )
    COP [04]
    COP [09] ( #$8602 )   ; the hint is told once
    COP [01] ( &asciistring_0078BB )
}

---------------------------------------------
; COP 27 yields and jumps back to the poll cm_npc_master_shrine_poll_00766E.

cm_npc_master_poll_again_007794 {
    COP [27] ( &cm_npc_master_shrine_poll_00766E )
}

---------------------------------------------
; The puff that replaces the hero at the 'Rest well' ending.
; 
; When: spawned (COP AC at pixel (112,80), flags $0050) by cm_npc_master_record_0076EF.
; Sees: animation 2 of table $0E:8000, an appear puff, once, drawn in front.
; Why: the hero is hidden (COP 34) as the puff plays, so he seems to vanish.
; In: X = D = the puff.
; Out: COP 86 at the end, RTL.
; Clobbers: A.

cm_fx_master_hero_puff_007798 {
    COP [A8] ( #$8000, #0E )
    LDA $scene_sprite_attr
    STA $001C, X
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #02 )
    COP [82]
    COP [86]
    RTL 
}

asciistring_0077B0 |[10]A voice came from [N]above- [FIN][JMP:&asciistring_0077C1+M]|

asciistring_0077C1 |[10][::][02:2], [N]how can I help you? [END]|

asciistring_0077D4 |I will record all [N]you have accomplished-[N]Is this okay? [END]|

asciistring_0077FA |Finished recording- [FIN]Do you wish to [N]continue? [END]|

asciistring_007825 |Rest well, there is [N]still much to be done-[JMP:&asciistring_007A52]|

asciistring_007848 |[02:2][N]you are doing well- [N]Do not give up- [JMP:&asciistring_007A52]|

asciistring_007866 |[08:448][END]|

asciistring_00786A |[10]A voice came from [N]above- [FIN]"Do not rush, but be [N]patient- You must [N]continue making steady[N]progress-ˮ [JMP:&asciistring_007A52]|

asciistring_0078BB |[10]A voice came from [N]above- [FIN]"The Brown Stone you [N]received is one of 6 [N]stones in this world- [FIN]When all six of these [N]stones are gathered, [FIN]the gate leading to [N]the World of Evil [N]shall be opened- [FIN]Now, you must go to [N]GreenWood where the [N]next stone awaits [N]you-ˮ [JMP:&asciistring_007A52]|
---------------------------------------------

; The common tail of the Master's farewell strings.
; 
; When: jumped to by [JMP] from the Rest well text (asciistring_007825), the farewell (asciistring_007848), the comfort (asciistring_00786A) and the stone hint (asciistring_0078BB).
; Sees: the box waits for a key ([12]) and is erased ([08:408]).
; Why: one tail for all four strings.
; In: n/a (data). Out: n/a.
; Clobbers: n/a.

asciistring_007A52 |[12][08:408][END]|