; The monsters and wall objects of the castle dungeon (file offsets 1039944-1041426, SNES $1F:DE48-$1F:E412, bank 1F; meta types $0A-$10 of MetaMagriddsCastle). Scenes: A11S01 the torture chamber (location $66), A11S02 and A11S03 the basements (locations $67 and $68). Walkthrough chapters: docs/walkthrough/07-king-magridds-castle.md (Castle Dungeon Part 1 and 2) and enemy-bestiary.md. The scripted actors of the dungeon are in mc_castle_dungeon_actors.asm.
; 
; === WHAT RUNS HERE ===
; Placed by PlacementA11S01-03 (the last byte of a row is the type; the flag byte is the facing: $01 none, $41 flip X, $81 flip Y, $C1 both): $0A wall spears, $0B statue shooters, $0E Green Snakes and $0F wall props. Lair monsters (never placed): $0C Bouncing Ball, $0D Wraithe and $10 Skeleton Soldier (the 'Skeleton Soldiers' of the walkthrough's lair at the torture chamber). All scripts are tile and animation driven: the only explicit pursuit is COP 9A / 9B (distance to the hero in x / y) and COP 21-24 (tile above / below / left / right is occupied).
; 
; === ROSTER (type: attack, defence, HP, EXP (BCD), animation bank, flags) ===
; - $0A wall spear (0FDE48): $15, $00, 5, 800, bank $00, $0001. Walkthrough: 'Avoid the spears protruding from the walls'. It sets the immunity class $0200 (only the Soul Blade hurts it, see CheckImmunityClass).
; - $0B statue shooter (0FDE71): $12, $00, 1, 0, bank $02, $2200. Walkthrough: 'the fireball-blasting statue' / 'fire-blasting statues'. Four facings, one set of labels each.
; - $0C Bouncing Ball (0FDFC3): $12, $08, 20, 900, bank $0A, $0000. Bestiary: 20 HP / 900 EXP, 'Ramming; energy circles'.
; - $0D Wraithe (0FE045): $14, $0A, 22, 700, bank $15, $0000. Bestiary: 22 HP / 700 EXP, 'Ramming into you', Spirit monster (needs the Spirit Sword; the script sets the class bit $0800 of $1A).
; - $0E Green Snake (0FE14E): $14, $0A, 16, 600, bank $1D, $1000. Bestiary: 16 HP / 600 EXP, 'Lunges'. Walkthrough: 'the trio of Green Snakes ... a free 1,800 EXP.' (3 x 600).
; - $0F wall prop (0FE22C): the hero's stats ($01, $02, $03), bank $23, flags $0210: a static animation (OQ-I039-6).
; - $10 Skeleton Soldier (0FE236): $13, $0B, 23, 750, bank $3C, $1200. Not in enemy-bestiary.md; the chapter table lists it (OQ-I039-5).
; 
; === FLAGS AND SHARED BEHAVIOUR ===
; $16 bit $8000 = off screen (COP AD waits for it to clear), $16 bit $0200 = cannot be hit, $16 bit $2000 = hidden / inactive (statues and Wraithes toggle it). Projectiles are run by shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67 (the script pushes its address and RTLs into it, with the parameter in Y).
---------------------------------------------

?BANK 1F

?INCLUDE 'shared_actor_helpers_bank0'

!rng_state                      0301

---------------------------------------------

; The wall spear (meta type $0A).
; 
; When: placed in A11S03 (the second basement), six rows; runs from scene load.
; Sees: sets the immunity class $0200 in $1A, then COP A5 by the facing: none or flip Y = mc_obj_wall_spear_anim_01_0FDE5B, flip X or both = mc_obj_wall_spear_anim_00_flip_0FDE65 (flip, then animation $00); both loop an animation and wait for the actor to be on screen (COP AD #$10).
; Why: the walkthrough: 'Avoid the spears protruding from the walls'. Its contact does the damage (attack $15); the animation is the thrust.
; In: X = D = the slot.
; Out: $1A bit $0200 set; never returns.
; Clobbers: A.

mc_obj_wall_spear_0FDE48 {
    LDA $001A, X
    ORA #$0200            ; $1A bit $0200: special immunity class (only the Soul Blade hurts it)
    STA $001A, X
    COP [A5] ( &mc_obj_wall_spear_anim_01_0FDE5B, &mc_obj_wall_spear_anim_00_flip_0FDE65, &mc_obj_wall_spear_anim_01_0FDE5B, &mc_obj_wall_spear_anim_00_flip_0FDE65 )
}

mc_obj_wall_spear_anim_01_0FDE5B {
    COP [80] ( #01 )
    COP [82]
    COP [AD] ( #10 )
    BRA mc_obj_wall_spear_anim_01_0FDE5B
}

mc_obj_wall_spear_anim_00_flip_0FDE65 {
    COP [96]

  loc_0FDE67:
    COP [80] ( #00 )
    COP [82]
    COP [AD] ( #10 )
    BRA loc_0FDE67
}
---------------------------------------------

; The fire-blasting statue (meta type $0B).
; 
; When: placed in A11S01-A11S03 (two to three per scene); runs from scene load.
; Sees: COP A5 by the facing: none = mc_obj_statue_shooter_down_poll_0FDE7B, flip X = left, flip Y = right, both = up; each direction has its own copy of the loop (poll, wait, aim, gate, fire).
; Why: the walkthrough: 'the fireball-blasting statue', 'dodging the fire-blasting statues'. The facing comes from the placement flag byte.
; In: X = D = the slot.
; Out: the shooters never return.
; Clobbers: A.

mc_obj_statue_shooter_0FDE71 {
    COP [A5] ( &mc_obj_statue_shooter_down_poll_0FDE7B, &mc_obj_statue_shooter_left_poll_0FDEC7, &mc_obj_statue_shooter_right_poll_0FDF13, &mc_obj_statue_shooter_up_poll_0FDF61 )
}

---------------------------------------------
; Shoots down: the loop of the statue that faces south (no flip).
; 
; When: from the root; after each shot it comes back here through mc_obj_statue_shooter_down_wait_0FDE83 (a COP 1B delay of $78 frames).
; Sees: $16 bit $8000 set (off screen) = wait; otherwise COP 0C tests the hero inside the statue's box widened by 7 px; when so, mc_obj_statue_shooter_down_aim_0FDE91 (COP 9B, threshold $10) lets the shot go only when the hero is at least $10 px below (third target), then the gate (COP 28: tile under the statue occupied) and mc_obj_statue_shooter_down_fire_0FDEA3: $2000 cleared, animation $02, a fireball at (0,+$10) with flags $0200, $2000 set again.
; Why: the left, right and up copies (0FDEC7, 0FDF13, 0FDF61) are the same with COP 9A / 9B and the fireball at (-$10,0), (+$10,0) and (0,-$10), animations $04, $04 (flip X first on the right) and $03.
; In: X = D = the statue.
; Out: one fireball per round trip; RTL by yields (COP 1B, COP 27).
; Clobbers: A.

mc_obj_statue_shooter_down_poll_0FDE7B {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDE89

  mc_obj_statue_shooter_down_wait_0FDE83:
    COP [1B] ( &mc_obj_statue_shooter_down_poll_0FDE7B, #$0078 ) ; wait $78 frames, then poll again

  loc_0FDE89:
    COP [0C] ( #00, #07, &mc_obj_statue_shooter_down_aim_0FDE91 ) ; the hero inside the statue's box widened by 7 px
    BRA mc_obj_statue_shooter_down_wait_0FDE83
}

mc_obj_statue_shooter_down_aim_0FDE91 {
    COP [9B] ( #$0010, &mc_obj_statue_shooter_down_wait_0FDE83, &mc_obj_statue_shooter_down_wait_0FDE83, &mc_obj_statue_shooter_down_gate_0FDE9B )
}

mc_obj_statue_shooter_down_gate_0FDE9B {
    COP [28] ( &mc_obj_statue_shooter_down_fire_0FDEA3 )
    COP [27] ( &mc_obj_statue_shooter_down_wait_0FDE83 )
}

mc_obj_statue_shooter_down_fire_0FDEA3 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    COP [B2] ( @mc_obj_statue_shooter_fireball_0FDFAD, #$0000, #$0010, #$0200 ) ; the fireball at (0,+$10), flags $0200 (cannot be hit)
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA mc_obj_statue_shooter_down_wait_0FDE83
}

---------------------------------------------
; Shoots left (flip X): same loop as the down statue.
; 
; When: root, facing flip X.
; Sees: COP 9A threshold $10: the shot goes when the hero is left of the statue (first target), animation $04, fireball at (-$10,0).
; Why: see mc_obj_statue_shooter_down_poll_0FDE7B.
; In: X = D = the statue.
; Out: fireballs.
; Clobbers: A.

mc_obj_statue_shooter_left_poll_0FDEC7 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDED5

  mc_obj_statue_shooter_left_wait_0FDECF:
    COP [1B] ( &mc_obj_statue_shooter_left_poll_0FDEC7, #$0078 )

  loc_0FDED5:
    COP [0C] ( #00, #07, &mc_obj_statue_shooter_left_aim_0FDEDD )
    BRA mc_obj_statue_shooter_left_wait_0FDECF
}

mc_obj_statue_shooter_left_aim_0FDEDD {
    COP [9A] ( #$0010, &mc_obj_statue_shooter_left_gate_0FDEE7, &mc_obj_statue_shooter_left_wait_0FDECF, &mc_obj_statue_shooter_left_wait_0FDECF )
}

mc_obj_statue_shooter_left_gate_0FDEE7 {
    COP [28] ( &mc_obj_statue_shooter_left_fire_0FDEEF )
    COP [27] ( &mc_obj_statue_shooter_left_wait_0FDECF )
}

mc_obj_statue_shooter_left_fire_0FDEEF {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #04 )
    COP [82]
    COP [B2] ( @mc_obj_statue_shooter_fireball_0FDFAD, #$FFF0, #$0000, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA mc_obj_statue_shooter_left_wait_0FDECF
}

---------------------------------------------
; Shoots right (flip Y): same loop as the down statue.
; 
; When: root, facing flip Y.
; Sees: COP 9A threshold $10: the shot goes when the hero is right of the statue (third target); the fire code first flips (COP 96), animation $04, fireball at (+$10,0).
; Why: see mc_obj_statue_shooter_down_poll_0FDE7B.
; In: X = D = the statue.
; Out: fireballs.
; Clobbers: A.

mc_obj_statue_shooter_right_poll_0FDF13 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDF21

  mc_obj_statue_shooter_right_wait_0FDF1B:
    COP [1B] ( &mc_obj_statue_shooter_right_poll_0FDF13, #$0078 )

  loc_0FDF21:
    COP [0C] ( #00, #07, &mc_obj_statue_shooter_right_aim_0FDF29 )
    BRA mc_obj_statue_shooter_right_wait_0FDF1B
}

mc_obj_statue_shooter_right_aim_0FDF29 {
    COP [9A] ( #$0010, &mc_obj_statue_shooter_right_wait_0FDF1B, &mc_obj_statue_shooter_right_wait_0FDF1B, &mc_obj_statue_shooter_right_gate_0FDF33 )
}

mc_obj_statue_shooter_right_gate_0FDF33 {
    COP [28] ( &mc_obj_statue_shooter_right_fire_0FDF3B )
    COP [27] ( &mc_obj_statue_shooter_right_wait_0FDF1B )
}

mc_obj_statue_shooter_right_fire_0FDF3B {
    COP [96]
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #04 )
    COP [82]
    COP [B2] ( @mc_obj_statue_shooter_fireball_0FDFAD, #$0010, #$0000, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA mc_obj_statue_shooter_right_wait_0FDF1B
}

---------------------------------------------
; Shoots up (both flips): same loop as the down statue.
; 
; When: root, facing both.
; Sees: COP 9B threshold $10: the shot goes when the hero is above the statue (first target), animation $03, fireball at (0,-$10).
; Why: see mc_obj_statue_shooter_down_poll_0FDE7B.
; In: X = D = the statue.
; Out: fireballs.
; Clobbers: A.

mc_obj_statue_shooter_up_poll_0FDF61 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDF6F

  mc_obj_statue_shooter_up_wait_0FDF69:
    COP [1B] ( &mc_obj_statue_shooter_up_poll_0FDF61, #$0078 )

  loc_0FDF6F:
    COP [0C] ( #00, #07, &mc_obj_statue_shooter_up_aim_0FDF77 )
    BRA mc_obj_statue_shooter_up_wait_0FDF69
}

mc_obj_statue_shooter_up_aim_0FDF77 {
    COP [9B] ( #$0010, &mc_obj_statue_shooter_up_gate_0FDF81, &mc_obj_statue_shooter_up_wait_0FDF69, &mc_obj_statue_shooter_up_wait_0FDF69 )
}

mc_obj_statue_shooter_up_gate_0FDF81 {
    COP [28] ( &mc_obj_statue_shooter_up_fire_0FDF89 )
    COP [27] ( &mc_obj_statue_shooter_up_wait_0FDF69 )
}

mc_obj_statue_shooter_up_fire_0FDF89 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #03 )
    COP [82]
    COP [B2] ( @mc_obj_statue_shooter_fireball_0FDFAD, #$0000, #$FFF0, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA mc_obj_statue_shooter_up_wait_0FDF69
}

---------------------------------------------
; The statue's fireball.
; 
; When: spawned by a fire label of the statue (flags $0200: cannot be hit).
; Sees: COP A3, BRK $64 (the shot sound), Y = 5 and a jump into the shared projectile mover shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67 by a pushed RTL address.
; Why: the mover does the flight and the contact; this label only gives the parameter.
; In: X = D = the fireball; Y is set to 5.
; Out: RTL into cm_enemy_aimed_shot_body_002D67.
; Clobbers: A, Y.

mc_obj_statue_shooter_fireball_0FDFAD {
    COP [A3]
    BRK #$64
    LDY #$0005            ; parameter of the shared projectile mover
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67-1
    PHA 
    RTL 
}
---------------------------------------------

; The Bouncing Ball (meta type $0C).
; 
; When: spawned by a lair in A11S01-A11S03 (not placed).
; Sees: waits until on screen (COP AD #8); when the hero is inside its box widened by 4 px (COP 0C) it turns to him (mc_enemy_bouncing_ball_aim_x_0FDFD3 flips by the hero's x, COP 9B threshold $28 picks animation $0E above, $0D / $0C level, $0B below), then animation $0A twice and, when the hero is still inside the box widened by 2 px, animation $0F four times and the energy circle (mc_enemy_bouncing_ball_energy_circle_0FE032, flags $0200); otherwise animation $0A idles.
; Why: bestiary: 'Ramming; energy circles'; 20 HP / 900 EXP in the ROM and the bestiary.
; In: X = D = the slot.
; Out: loops; one energy circle per attack.
; Clobbers: A.

mc_enemy_bouncing_ball_0FDFC3 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #04, &mc_enemy_bouncing_ball_aim_x_0FDFD3 )
    COP [80] ( #0A )
    COP [82]
    BRA mc_enemy_bouncing_ball_0FDFC3
}

mc_enemy_bouncing_ball_aim_x_0FDFD3 {
    COP [9A] ( #$0000, &mc_enemy_bouncing_ball_unflip_0FDFE1, &mc_enemy_bouncing_ball_flip_0FDFDD, &mc_enemy_bouncing_ball_flip_0FDFDD )
}

mc_enemy_bouncing_ball_flip_0FDFDD {
    COP [96]
    BRA loc_0FDFE3
}

mc_enemy_bouncing_ball_unflip_0FDFE1 {
    COP [97]

  loc_0FDFE3:
    COP [9B] ( #$0028, &mc_enemy_bouncing_ball_anim_0E_0FDFF7, &mc_enemy_bouncing_ball_row_mid_0FDFED, &mc_enemy_bouncing_ball_anim_0B_0FE00C )
}

mc_enemy_bouncing_ball_row_mid_0FDFED {
    COP [9B] ( #$0000, &mc_enemy_bouncing_ball_anim_0D_0FDFFE, &mc_enemy_bouncing_ball_anim_0C_0FE005, &mc_enemy_bouncing_ball_anim_0C_0FE005 )
}

mc_enemy_bouncing_ball_anim_0E_0FDFF7 {
    COP [80] ( #0E )
    COP [82]
    BRA loc_0FE011
}

mc_enemy_bouncing_ball_anim_0D_0FDFFE {
    COP [80] ( #0D )
    COP [82]
    BRA loc_0FE011
}

mc_enemy_bouncing_ball_anim_0C_0FE005 {
    COP [80] ( #0C )
    COP [82]
    BRA loc_0FE011
}

mc_enemy_bouncing_ball_anim_0B_0FE00C {
    COP [80] ( #0B )
    COP [82]

  loc_0FE011:
    COP [81] ( #0A, #02 )
    COP [83]
    COP [0C] ( #00, #02, &mc_enemy_bouncing_ball_0FDFC3 )
    COP [81] ( #0F, #04 )
    COP [83]
    COP [B0] ( @mc_enemy_bouncing_ball_energy_circle_0FE032, #$0200 )
    COP [81] ( #0A, #02 )
    COP [83]
    BRA mc_enemy_bouncing_ball_0FDFC3
}

---------------------------------------------
; The Bouncing Ball's energy circle.
; 
; When: spawned by the Bouncing Ball (flags $0200).
; Sees: COP A3, BRK $64, Y = $10 and the jump into shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67.
; Why: same trick as the statue's fireball with a faster parameter.
; In: X = D = the projectile; Y is set to $10.
; Out: RTL into cm_enemy_aimed_shot_body_002D67.
; Clobbers: A, Y.

mc_enemy_bouncing_ball_energy_circle_0FE032 {
    COP [A3]
    BRK #$64
    LDY #$0010
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67-1
    PHA 
    RTL 
}
---------------------------------------------

; The Wraithe (meta type $0D), the Spirit monster.
; 
; When: spawned by lairs in A11S01-A11S03 (not placed).
; Sees: sets the immunity class $0800 in $1A (only the Spirit Sword hurts it), waits until on screen and COP 9B threshold 8: hero above = it rises (animation $19, $16 at the end), within = mc_enemy_wraithe_x_aim_0FE0CC, below = it sinks (animation $18, $15 at the end); then a random draw (COP 1F, bit 7 of rng_state+1): half of the rounds it fades (see mc_enemy_wraithe_fade_roll_0FE104).
; Why: bestiary: 'Ramming into you', 22 HP / 700 EXP, Spirit monster (walkthrough: 'Spirit-type enemies').
; In: X = D = the slot.
; Out: loops.
; Clobbers: A.

mc_enemy_wraithe_0FE045 {
    LDA $001A, X
    ORA #$0800            ; $1A bit $0800: spirit immunity class (only the Spirit Sword hurts it)
    STA $001A, X
    COP [AD] ( #08 )

  loc_0FE051:
    COP [9B] ( #$0008, &mc_enemy_wraithe_up_0FE05B, &mc_enemy_wraithe_x_aim_0FE0CC, &mc_enemy_wraithe_down_0FE073 )
}

mc_enemy_wraithe_up_0FE05B {
    COP [97]

  mc_enemy_wraithe_up_loop_0FE05D:
    COP [80] ( #19 )
    COP [82]
    COP [9B] ( #$0018, &mc_enemy_wraithe_up_loop_0FE05D, &mc_enemy_wraithe_up_end_0FE06C, &mc_enemy_wraithe_down_0FE073 )
}

mc_enemy_wraithe_up_end_0FE06C {
    COP [80] ( #16 )
    COP [82]
    BRA loc_0FE089
}

mc_enemy_wraithe_down_0FE073 {
    COP [97]

  mc_enemy_wraithe_down_loop_0FE075:
    COP [80] ( #18 )
    COP [82]
    COP [9B] ( #$0018, &mc_enemy_wraithe_up_0FE05B, &mc_enemy_wraithe_down_end_0FE084, &mc_enemy_wraithe_down_loop_0FE075 )
}

mc_enemy_wraithe_down_end_0FE084 {
    COP [80] ( #15 )
    COP [82]

  loc_0FE089:
    COP [1F]
    LDA $rng_state+1
    BPL mc_enemy_wraithe_x_aim_0FE0CC
    LDA $0016, X          ; $16 bit $0200 set = invulnerable (faded out): fade in; clear = fade out
    BIT #$0200
    BEQ loc_0FE0B3
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    BRK #$60
    COP [80] ( #1C )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    BRA mc_enemy_wraithe_x_aim_0FE0CC

  loc_0FE0B3:
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    BRK #$60
    COP [80] ( #1B )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
}

---------------------------------------------
; The Wraithe's horizontal approach.
; 
; When: from the vertical step of mc_enemy_wraithe_0FE045.
; Sees: COP 9A threshold 8: hero left = mc_enemy_wraithe_left_0FE0D6 (COP 97, animation $1A loop until within $18), within = mc_enemy_wraithe_fade_roll_0FE104, right = mc_enemy_wraithe_right_0FE0EE (COP 96, animation $1A loop); the ends play animation $17.
; Why: the ramming approach, one axis at a time.
; In: X = D = the slot.
; Out: continues in the fade roll.
; Clobbers: A.

mc_enemy_wraithe_x_aim_0FE0CC {
    COP [9A] ( #$0008, &mc_enemy_wraithe_left_0FE0D6, &mc_enemy_wraithe_fade_roll_0FE104, &mc_enemy_wraithe_right_0FE0EE )
}

mc_enemy_wraithe_left_0FE0D6 {
    COP [97]

  mc_enemy_wraithe_left_loop_0FE0D8:
    COP [80] ( #1A )
    COP [82]
    COP [9A] ( #$0018, &mc_enemy_wraithe_left_loop_0FE0D8, &mc_enemy_wraithe_left_end_0FE0E7, &mc_enemy_wraithe_right_0FE0EE )
}

mc_enemy_wraithe_left_end_0FE0E7 {
    COP [80] ( #17 )
    COP [82]
    BRA mc_enemy_wraithe_fade_roll_0FE104
}

mc_enemy_wraithe_right_0FE0EE {
    COP [96]

  mc_enemy_wraithe_right_loop_0FE0F0:
    COP [80] ( #1A )
    COP [82]
    COP [9A] ( #$0018, &mc_enemy_wraithe_left_0FE0D6, &mc_enemy_wraithe_right_end_0FE0FF, &mc_enemy_wraithe_right_loop_0FE0F0 )
}

mc_enemy_wraithe_right_end_0FE0FF {
    COP [80] ( #17 )
    COP [82]
}

---------------------------------------------
; The Wraithe's fade in and out.
; 
; When: after each approach step.
; Sees: a random draw; bit 7 clear returns to the vertical step; set toggles the ghost state: $16 bit $0200 set (invulnerable) = fade in (clear $2000, BRK $60, animation $1C, clear $0200); clear = fade out (set $0200, BRK $60, animation $1B, set $2000: hidden).
; Why: the Wraithe vanishes and reappears while it floats towards the hero.
; In: X = D = the slot.
; Out: $16 bits $0200 / $2000 toggled.
; Clobbers: A.

mc_enemy_wraithe_fade_roll_0FE104 {
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE10E
    BRL loc_0FE051

  loc_0FE10E:
    LDA $0016, X
    BIT #$0200
    BEQ loc_0FE132
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    BRK #$60
    COP [80] ( #1C )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    BRL loc_0FE051

  loc_0FE132:
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    BRK #$60
    COP [80] ( #1B )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRL loc_0FE051
}
---------------------------------------------

; The Green Snake (meta type $0E).
; 
; When: placed in A11S01-A11S03 (four, four and three); runs from scene load.
; Sees: COP A5 by the facing picks the first animation ($1D, $1F, $1F flipped, $1E) and the first axis: mc_enemy_green_snake_chase_a_0FE178 (rows) or mc_enemy_green_snake_chase_b_0FE1A9 (columns).
; Why: bestiary: 'Lunges', 16 HP / 600 EXP; walkthrough: 'the trio of Green Snakes to the west'.
; In: X = D = the slot.
; Out: loops.
; Clobbers: A.

mc_enemy_green_snake_0FE14E {
    COP [A5] ( &mc_enemy_green_snake_start_1D_0FE158, &mc_enemy_green_snake_start_1F_0FE161, &mc_enemy_green_snake_start_1F_flip_0FE168, &mc_enemy_green_snake_start_1E_0FE171 )
}

mc_enemy_green_snake_start_1D_0FE158 {
    COP [96]
    COP [80] ( #1D )
    COP [82]
    BRA mc_enemy_green_snake_chase_b_0FE1A9
}

mc_enemy_green_snake_start_1F_0FE161 {
    COP [80] ( #1F )
    COP [82]
    BRA mc_enemy_green_snake_chase_a_0FE178
}

mc_enemy_green_snake_start_1F_flip_0FE168 {
    COP [96]
    COP [80] ( #1F )
    COP [82]
    BRA mc_enemy_green_snake_chase_a_0FE178
}

mc_enemy_green_snake_start_1E_0FE171 {
    COP [80] ( #1E )
    COP [82]
    BRA mc_enemy_green_snake_chase_b_0FE1A9

; The snake's row chase.
; 
; When: from the root or after a column step.
; Sees: COP AD (on screen), COP 9B threshold 8: level with the hero in y = COP 9A threshold 0 picks slither left or right; not level and the hero is within $20 in x = flip by the old facing and slither; otherwise a 8 frame delay (COP 1B) and again. The chase_b copy does the same for the other axis.
; Why: one axis at a time; the slither labels move while COP 21-24 finds the tile free and animate with $22, $22, $21 and $20.
; In: X = D = the slot.
; Out: loops.
; Clobbers: A.

  mc_enemy_green_snake_chase_a_0FE178:
    COP [AD] ( #08 )
    COP [9B] ( #$0008, &mc_enemy_green_snake_not_aligned_y_0FE18F, &mc_enemy_green_snake_aligned_y_0FE185, &mc_enemy_green_snake_not_aligned_y_0FE18F )
}

mc_enemy_green_snake_aligned_y_0FE185 {
    COP [9A] ( #$0000, &mc_enemy_green_snake_slither_left_0FE1DA, &mc_enemy_green_snake_slither_right_0FE1EE, &mc_enemy_green_snake_slither_right_0FE1EE )
}

mc_enemy_green_snake_not_aligned_y_0FE18F {
    COP [9A] ( #$0020, &mc_enemy_green_snake_not_aligned_y_wait_0FE1A3, &mc_enemy_green_snake_not_aligned_y_flip_0FE199, &mc_enemy_green_snake_not_aligned_y_wait_0FE1A3 )
}

mc_enemy_green_snake_not_aligned_y_flip_0FE199 {
    COP [A5] ( &mc_enemy_green_snake_slither_right_0FE1EE, &mc_enemy_green_snake_slither_left_0FE1DA, &mc_enemy_green_snake_slither_right_0FE1EE, &mc_enemy_green_snake_slither_left_0FE1DA )
}

mc_enemy_green_snake_not_aligned_y_wait_0FE1A3 {
    COP [1B] ( &mc_enemy_green_snake_chase_a_0FE178, #$0008 )

  mc_enemy_green_snake_chase_b_0FE1A9:
    COP [AD] ( #08 )
    COP [9A] ( #$0008, &mc_enemy_green_snake_not_aligned_x_0FE1C0, &mc_enemy_green_snake_aligned_x_0FE1B6, &mc_enemy_green_snake_not_aligned_x_0FE1C0 )
}

mc_enemy_green_snake_aligned_x_0FE1B6 {
    COP [9B] ( #$0000, &mc_enemy_green_snake_slither_up_0FE203, &mc_enemy_green_snake_slither_down_0FE217, &mc_enemy_green_snake_slither_down_0FE217 )
}

mc_enemy_green_snake_not_aligned_x_0FE1C0 {
    COP [9B] ( #$0020, &mc_enemy_green_snake_not_aligned_x_wait_0FE1D4, &mc_enemy_green_snake_not_aligned_x_flip_0FE1CA, &mc_enemy_green_snake_not_aligned_x_wait_0FE1D4 )
}

mc_enemy_green_snake_not_aligned_x_flip_0FE1CA {
    COP [A5] ( &mc_enemy_green_snake_slither_down_0FE217, &mc_enemy_green_snake_slither_up_0FE203, &mc_enemy_green_snake_slither_down_0FE217, &mc_enemy_green_snake_slither_up_0FE203 )
}

mc_enemy_green_snake_not_aligned_x_wait_0FE1D4 {
    COP [1B] ( &mc_enemy_green_snake_chase_b_0FE1A9, #$0008 )
}

mc_enemy_green_snake_slither_left_0FE1DA {
    COP [97]

  loc_0FE1DC:
    COP [23] ( &mc_enemy_green_snake_slither_left_stop_0FE1E7 )
    COP [80] ( #22 )
    COP [82]
    BRA loc_0FE1DC
}

mc_enemy_green_snake_slither_left_stop_0FE1E7 {
    COP [80] ( #1F )
    COP [82]
    BRA mc_enemy_green_snake_chase_a_0FE178
}

mc_enemy_green_snake_slither_right_0FE1EE {
    COP [96]

  loc_0FE1F0:
    COP [24] ( &mc_enemy_green_snake_slither_right_stop_0FE1FB )
    COP [80] ( #22 )
    COP [82]
    BRA loc_0FE1F0
}

mc_enemy_green_snake_slither_right_stop_0FE1FB {
    COP [80] ( #1F )
    COP [82]
    BRL mc_enemy_green_snake_chase_a_0FE178
}

mc_enemy_green_snake_slither_up_0FE203 {
    COP [97]

  loc_0FE205:
    COP [21] ( &mc_enemy_green_snake_slither_up_stop_0FE210 )
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FE205
}

mc_enemy_green_snake_slither_up_stop_0FE210 {
    COP [80] ( #1E )
    COP [82]
    BRA mc_enemy_green_snake_chase_b_0FE1A9
}

mc_enemy_green_snake_slither_down_0FE217 {
    COP [96]

  loc_0FE219:
    COP [22] ( &mc_enemy_green_snake_slither_down_stop_0FE224 )
    COP [80] ( #20 )
    COP [82]
    BRA loc_0FE219
}

mc_enemy_green_snake_slither_down_stop_0FE224 {
    COP [80] ( #1D )
    COP [82]
    BRL mc_enemy_green_snake_chase_b_0FE1A9
}
---------------------------------------------

; A wall prop (meta type $0F).
; 
; When: placed in A11S01 (five props along y $04).
; Sees: animation $23 and a wait until on screen (COP AD #8), forever.
; Why: a static decoration with the hero's stat bytes; its identity is by placement only (OQ-I039-6).
; In: X = D = the slot.
; Out: loops.
; Clobbers: A.

mc_obj_wall_prop_0FE22C {
    COP [80] ( #23 )
    COP [82]
    COP [AD] ( #08 )
    BRA mc_obj_wall_prop_0FE22C
}
---------------------------------------------

; The Skeleton Soldier (meta type $10).
; 
; When: spawned by lairs of the torture chamber (A11S01) and the basements (not placed).
; Sees: waits on screen (COP AD #$10) lying down (animation $3C); when the hero is inside its box widened by 2 px it rises (mc_enemy_skeleton_soldier_rise_0FE246: animation $3D, $16 bit $0200 cleared = it can be hit now) and then walks and slashes. When a walk step finds a blocked tile it collapses (mc_enemy_skeleton_soldier_blocked_pause_0FE3BF: $0200 set, animation $3E, a 60 frame delay and back to the first state).
; Why: the walkthrough: 'several Skeleton Soldiers laying on the floor; get in the center of them and blast 'em with the Light Arrow'. 23 HP / 750 EXP in the ROM; the walkthrough's chapter table lists the Skeleton Soldier (OQ-I039-5).
; In: X = D = the slot.
; Out: loops.
; Clobbers: A.

mc_enemy_skeleton_soldier_0FE236 {
    COP [AD] ( #10 )
    COP [0C] ( #00, #02, &mc_enemy_skeleton_soldier_rise_0FE246 )
    COP [80] ( #3C )
    COP [82]
    BRA mc_enemy_skeleton_soldier_0FE236
}

---------------------------------------------
; The Skeleton Soldier's hunt loop.
; 
; When: after it has risen.
; Sees: COP 9B threshold 0 picks above (mc_enemy_skeleton_soldier_aim_up_0FE25E) or below (aim_down); inside, COP 9B threshold $18 walks (COP 21 / 22 tile test, animations $2D up, $25 down) or, when level in y, tests COP 9A threshold $28: close = a slash, far = the face animation ($2C / $24). Then the same for x (aim_left, aim_right: animations $35 walking, $34 facing).
; Why: it goes after the hero one axis at a time and slashes when aligned.
; In: X = D = the slot.
; Out: loops back to loc_0FE254.
; Clobbers: A.

mc_enemy_skeleton_soldier_rise_0FE246 {
    COP [80] ( #3D )
    COP [82]
    LDA $0016, X          ; clears $16 bit $0200 in the next two instructions: it can be hit once it has risen
    AND #$FDFF
    STA $0016, X

  loc_0FE254:
    COP [9B] ( #$0000, &mc_enemy_skeleton_soldier_aim_up_0FE25E, &mc_enemy_skeleton_soldier_aim_down_0FE286, &mc_enemy_skeleton_soldier_aim_down_0FE286 )
}

mc_enemy_skeleton_soldier_aim_up_0FE25E {
    COP [97]
    COP [9B] ( #$0018, &mc_enemy_skeleton_soldier_walk_up_0FE26A, &mc_enemy_skeleton_soldier_up_row_0FE275, &mc_enemy_skeleton_soldier_walk_up_0FE26A )
}

mc_enemy_skeleton_soldier_walk_up_0FE26A {
    COP [21] ( &mc_enemy_skeleton_soldier_blocked_pause_0FE3BF )
    COP [80] ( #2D )
    COP [82]
    BRA loc_0FE254
}

mc_enemy_skeleton_soldier_up_row_0FE275 {
    COP [9A] ( #$0028, &mc_enemy_skeleton_soldier_up_face_0FE27F, &mc_enemy_skeleton_soldier_slash_x_a_0FE345, &mc_enemy_skeleton_soldier_up_face_0FE27F )
}

mc_enemy_skeleton_soldier_up_face_0FE27F {
    COP [80] ( #2C )
    COP [82]
    BRA loc_0FE2AC
}

mc_enemy_skeleton_soldier_aim_down_0FE286 {
    COP [97]
    COP [9B] ( #$0018, &mc_enemy_skeleton_soldier_walk_down_0FE292, &mc_enemy_skeleton_soldier_down_row_0FE29D, &mc_enemy_skeleton_soldier_walk_down_0FE292 )
}

mc_enemy_skeleton_soldier_walk_down_0FE292 {
    COP [22] ( &mc_enemy_skeleton_soldier_blocked_pause_0FE3BF )
    COP [80] ( #25 )
    COP [82]
    BRA loc_0FE254
}

mc_enemy_skeleton_soldier_down_row_0FE29D {
    COP [9A] ( #$0028, &mc_enemy_skeleton_soldier_down_face_0FE2A7, &mc_enemy_skeleton_soldier_slash_x_b_0FE382, &mc_enemy_skeleton_soldier_down_face_0FE2A7 )
}

mc_enemy_skeleton_soldier_down_face_0FE2A7 {
    COP [80] ( #24 )
    COP [82]

  loc_0FE2AC:
    COP [9A] ( #$0000, &mc_enemy_skeleton_soldier_aim_left_0FE2B6, &mc_enemy_skeleton_soldier_aim_right_0FE2DF, &mc_enemy_skeleton_soldier_aim_right_0FE2DF )
}

mc_enemy_skeleton_soldier_aim_left_0FE2B6 {
    COP [97]
    COP [9A] ( #$0018, &mc_enemy_skeleton_soldier_walk_left_0FE2C2, &mc_enemy_skeleton_soldier_left_row_0FE2CD, &mc_enemy_skeleton_soldier_walk_left_0FE2C2 )
}

mc_enemy_skeleton_soldier_walk_left_0FE2C2 {
    COP [23] ( &mc_enemy_skeleton_soldier_blocked_pause_0FE3BF )
    COP [80] ( #35 )
    COP [82]
    BRA loc_0FE2AC
}

mc_enemy_skeleton_soldier_left_row_0FE2CD {
    COP [9B] ( #$0028, &mc_enemy_skeleton_soldier_left_face_0FE2D7, &mc_enemy_skeleton_soldier_slash_y_0FE308, &mc_enemy_skeleton_soldier_left_face_0FE2D7 )
}

mc_enemy_skeleton_soldier_left_face_0FE2D7 {
    COP [80] ( #34 )
    COP [82]
    BRL loc_0FE254
}

mc_enemy_skeleton_soldier_aim_right_0FE2DF {
    COP [96]
    COP [9A] ( #$0018, &mc_enemy_skeleton_soldier_walk_right_0FE2EB, &mc_enemy_skeleton_soldier_right_row_0FE2F6, &mc_enemy_skeleton_soldier_walk_right_0FE2EB )
}

mc_enemy_skeleton_soldier_walk_right_0FE2EB {
    COP [24] ( &mc_enemy_skeleton_soldier_blocked_pause_0FE3BF )
    COP [80] ( #35 )
    COP [82]
    BRA loc_0FE2AC
}

mc_enemy_skeleton_soldier_right_row_0FE2F6 {
    COP [9B] ( #$0028, &mc_enemy_skeleton_soldier_right_face_0FE300, &mc_enemy_skeleton_soldier_slash_y_0FE308, &mc_enemy_skeleton_soldier_right_face_0FE300 )
}

mc_enemy_skeleton_soldier_right_face_0FE300 {
    COP [80] ( #34 )
    COP [82]
    BRL loc_0FE254
}

---------------------------------------------
; The slash when the soldier is level with the hero in x.
; 
; When: from the left or right row test.
; Sees: COP 9B threshold $10 picks one of three slash animations ($37, $38, $36); each spawns a hit child (flags $0200) that plays the same slash animation ($3A, $3B, $39) with BRK $41 as the sound.
; Why: the hit box is a separate child actor so that it lasts exactly one animation.
; In: X = D = the slot.
; Out: one hit child per slash.
; Clobbers: A.

mc_enemy_skeleton_soldier_slash_y_0FE308 {
    COP [9B] ( #$0010, &mc_enemy_skeleton_soldier_slash_anim_37_0FE312, &mc_enemy_skeleton_soldier_slash_anim_38_0FE323, &mc_enemy_skeleton_soldier_slash_anim_36_0FE334 )
}

mc_enemy_skeleton_soldier_slash_anim_37_0FE312 {
    COP [B0] ( @mc_enemy_skeleton_soldier_slash_hit_anim_3A_0FE404, #$0200 )
    BRK #$41
    COP [80] ( #37 )
    COP [82]
    BRL loc_0FE254
}

mc_enemy_skeleton_soldier_slash_anim_38_0FE323 {
    COP [B0] ( @mc_enemy_skeleton_soldier_slash_hit_anim_3B_0FE40B, #$0200 )
    BRK #$41
    COP [80] ( #38 )
    COP [82]
    BRL loc_0FE254
}

mc_enemy_skeleton_soldier_slash_anim_36_0FE334 {
    COP [B0] ( @mc_enemy_skeleton_soldier_slash_hit_anim_39_0FE3FD, #$0200 )
    BRK #$41
    COP [80] ( #36 )
    COP [82]
    BRL loc_0FE254
}

---------------------------------------------
; The slash when the soldier faces up and the hero is close.
; 
; When: from the up row test.
; Sees: COP 9A threshold $10 picks one of three animations ($2E, $30, $2F) and a hit child that plays $2E, $30 or $2F; the down row copy (mc_enemy_skeleton_soldier_slash_x_b_0FE382) uses $26, $28, $27 with hit children $29, $2B, $2A.
; Why: same trick as the y slash.
; In: X = D = the slot.
; Out: one hit child per slash.
; Clobbers: A.

mc_enemy_skeleton_soldier_slash_x_a_0FE345 {
    COP [9A] ( #$0010, &mc_enemy_skeleton_soldier_slash_anim_2E_0FE34F, &mc_enemy_skeleton_soldier_slash_anim_30_0FE360, &mc_enemy_skeleton_soldier_slash_anim_2F_0FE371 )
}

mc_enemy_skeleton_soldier_slash_anim_2E_0FE34F {
    COP [B0] ( @mc_enemy_skeleton_soldier_slash_hit_anim_2E_0FE3E8, #$0200 )
    BRK #$41
    COP [80] ( #2E )
    COP [82]
    BRL loc_0FE2AC
}

mc_enemy_skeleton_soldier_slash_anim_30_0FE360 {
    COP [B0] ( @mc_enemy_skeleton_soldier_slash_hit_anim_30_0FE3F6, #$0200 )
    BRK #$41
    COP [80] ( #30 )
    COP [82]
    BRL loc_0FE2AC
}

mc_enemy_skeleton_soldier_slash_anim_2F_0FE371 {
    COP [B0] ( @mc_enemy_skeleton_soldier_slash_hit_anim_2F_0FE3EF, #$0200 )
    BRK #$41
    COP [80] ( #2F )
    COP [82]
    BRL loc_0FE2AC
}

mc_enemy_skeleton_soldier_slash_x_b_0FE382 {
    COP [9A] ( #$0010, &mc_enemy_skeleton_soldier_slash_anim_26_0FE38C, &mc_enemy_skeleton_soldier_slash_anim_28_0FE39D, &mc_enemy_skeleton_soldier_slash_anim_27_0FE3AE )
}

mc_enemy_skeleton_soldier_slash_anim_26_0FE38C {
    COP [B0] ( @mc_enemy_skeleton_soldier_slash_hit_anim_29_0FE3D3, #$0200 )
    BRK #$41
    COP [80] ( #26 )
    COP [82]
    BRL loc_0FE2AC
}

mc_enemy_skeleton_soldier_slash_anim_28_0FE39D {
    COP [B0] ( @mc_enemy_skeleton_soldier_slash_hit_anim_2B_0FE3E1, #$0200 )
    BRK #$41
    COP [80] ( #28 )
    COP [82]
    BRL loc_0FE2AC
}

mc_enemy_skeleton_soldier_slash_anim_27_0FE3AE {
    COP [B0] ( @mc_enemy_skeleton_soldier_slash_hit_anim_2A_0FE3DA, #$0200 )
    BRK #$41
    COP [80] ( #27 )
    COP [82]
    BRL loc_0FE2AC
}

---------------------------------------------
; The Skeleton Soldier falls apart when a tile blocks it.
; 
; When: a walk step (COP 21-24) found the next tile occupied.
; Sees: $16 bit $0200 set, animation $3E, then COP 1B with 60 frames back to the first state (lying down).
; Why: the bones re-form after a pause.
; In: X = D = the slot.
; Out: restarts mc_enemy_skeleton_soldier_0FE236.
; Clobbers: A.

mc_enemy_skeleton_soldier_blocked_pause_0FE3BF {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #3E )
    COP [82]
    COP [1B] ( &mc_enemy_skeleton_soldier_0FE236, #$003C )
}

mc_enemy_skeleton_soldier_slash_hit_anim_29_0FE3D3 {
    COP [80] ( #29 )
    COP [82]
    BRA loc_0FE410
}

mc_enemy_skeleton_soldier_slash_hit_anim_2A_0FE3DA {
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FE410
}

mc_enemy_skeleton_soldier_slash_hit_anim_2B_0FE3E1 {
    COP [80] ( #2B )
    COP [82]
    BRA loc_0FE410
}

mc_enemy_skeleton_soldier_slash_hit_anim_2E_0FE3E8 {
    COP [80] ( #2E )
    COP [82]
    BRA loc_0FE410
}

mc_enemy_skeleton_soldier_slash_hit_anim_2F_0FE3EF {
    COP [80] ( #2F )
    COP [82]
    BRA loc_0FE410
}

mc_enemy_skeleton_soldier_slash_hit_anim_30_0FE3F6 {
    COP [80] ( #30 )
    COP [82]
    BRA loc_0FE410
}

mc_enemy_skeleton_soldier_slash_hit_anim_39_0FE3FD {
    COP [80] ( #39 )
    COP [82]
    BRA loc_0FE410
}

---------------------------------------------
; A slash hit child (representative).
; 
; When: spawned by a slash of the Skeleton Soldier with flags $0200.
; Sees: plays one animation (here $3A), then COP 86; its siblings play $29, $2A, $2B, $2E, $2F, $30, $39 and $3B.
; Why: the sword's hit box lives for one animation.
; In: X = D = the child.
; Out: COP 86.
; Clobbers: A.

mc_enemy_skeleton_soldier_slash_hit_anim_3A_0FE404 {
    COP [80] ( #3A )
    COP [82]
    BRA loc_0FE410
}

mc_enemy_skeleton_soldier_slash_hit_anim_3B_0FE40B {
    COP [80] ( #3B )
    COP [82]

  loc_0FE410:
    COP [86]
    RTL 
}