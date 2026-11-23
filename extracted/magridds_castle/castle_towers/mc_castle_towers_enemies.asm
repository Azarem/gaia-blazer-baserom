; The monsters and wall objects of the castle towers (file offsets 1041427-1042972, SNES $1F:E413-$1F:EA1C, bank 1F; meta types $11-$17 of MetaMagriddsCastle). Scenes: A12S01-A12S02 the left tower (locations $6A, $6B), A12S04-A12S06 the right tower (locations $6D-$6F) and A12S07 the corridor to the dock (location $70). Walkthrough chapters: docs/walkthrough/07-king-magridds-castle.md (the towers) and enemy-bestiary.md. The scripted actors of the towers are in mc_castle_towers_actors.asm.
; 
; === WHAT RUNS HERE ===
; Placed by PlacementA12S01-07 (the last byte of a row is the type; the flag byte is the facing: $01 none, $41 flip X, $81 flip Y, $C1 both): $13 static props (A12S02, eight), $14 statue shooters (A12S01: twelve in a lattice, A12S04: six, A12S05: two, A12S06: six) and $15 Mimics (A12S05, A12S06 and A12S07: two each). Lair monsters (never placed): $11 Purple Knight, $12 Red Knight, $16 Bronze Robot and $17 Chess Knight. Like the dungeon, all movement is tile and animation driven (COP 9A / 9B distance to the hero, COP 21-24 and COP AE tile tests).
; 
; === ROSTER (type: attack, defence, HP, EXP (BCD), animation bank, flags) ===
; - $11 Purple Knight (0FE413): $16, $0A, 30, 750, bank $00, $1000, palette $0 (COP AA). Bestiary: 30 HP / 750 EXP, 'Sword slashes'.
; - $12 Red Knight (0FE4F2): $17, $0B, 36, 950, bank $00, $1000, palette $2. Bestiary: 36 HP / 950 EXP, 'Swords; projectiles'.
; - $13 static prop (0FE610): the hero's stats ($01, $02, $03), bank $1C, flags $0210: a static animation (OQ-I039-6).
; - $14 statue shooter (0FE61A): $12, $00, 0, 0, bank $1D, $2200. Walkthrough: 'fire-blasting statues'. The lattice of twelve in A12S01 is not described by the walkthrough (OQ-I039-8).
; - $15 Mimic (0FE76C): $18, $0C, 25, 1000, bank $25, $1200. Bestiary: 25 HP / 1,000 EXP, 'Lunges'. Walkthrough: 'The northeast and southwest chests are Mimics'.
; - $16 Bronze Robot (0FE83E): $15, $0B, 20, 800, bank $2D, $0000. Bestiary: 20 HP / 800 EXP, 'Moving slowly'.
; - $17 Chess Knight (0FE88E): $17, $0D, 28, 850, bank $3D, $0000. Bestiary: 28 HP / 850 EXP, 'Spike rings'.
; 
; === FLAGS AND SHARED BEHAVIOUR ===
; $16 bit $8000 = off screen (COP AD waits for it to clear), $16 bit $0200 = cannot be hit, $16 bit $2000 = hidden / inactive (statues and the Mimic). The statue copies are the dungeon's with other animations ($1D, $1F, $1F flipped, $1E) and the projectile parameter $20 (the dungeon statue uses 5). Projectiles run in shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67.
---------------------------------------------

?BANK 1F

?INCLUDE 'shared_actor_helpers_bank0'

!rng_state                      0301

---------------------------------------------

; The Purple Knight (meta type $11).
; 
; When: spawned by lairs of the left tower and the right tower (not placed).
; Sees: palette $0 (COP AA), then it waits until on screen (COP AD #8) and goes after the hero one axis at a time: COP 9B threshold 0 picks above (aim_up) or below (aim_down); inside, COP 9B threshold $18 walks (COP 21 / 22 tile test, animations $08 up and $06 down; $02 or $00 when blocked) or strikes when level (animation $0D up, $0C down); then the same on x (COP 9A, walking animation $0A, blocked $04, strike $0E). A strike plays the sword sound (BRK $41) and spawns a hit child (flags $0200) that plays one animation ($19, $1A or $1B) and ends.
; Why: bestiary: 'Sword slashes'; 30 HP / 750 EXP in the ROM and the bestiary.
; In: X = D = the slot.
; Out: loops.
; Clobbers: A.

mc_enemy_purple_knight_0FE413 {
    COP [AA] ( #00 )      ; palette $0 (the red knight uses $2)

  loc_0FE416:
    COP [AD] ( #08 )
    COP [9B] ( #$0000, &mc_enemy_purple_knight_aim_up_0FE423, &mc_enemy_purple_knight_aim_down_0FE441, &mc_enemy_purple_knight_aim_down_0FE441 )
}

mc_enemy_purple_knight_aim_up_0FE423 {
    COP [97]
    COP [9B] ( #$0018, &mc_enemy_purple_knight_walk_up_0FE42F, &mc_enemy_purple_knight_strike_anim_0D_0FE4C0, &mc_enemy_purple_knight_walk_up_0FE42F )
}

mc_enemy_purple_knight_walk_up_0FE42F {
    COP [21] ( &mc_enemy_purple_knight_blocked_up_0FE43A )
    COP [80] ( #08 )
    COP [82]
    BRA loc_0FE416
}

mc_enemy_purple_knight_blocked_up_0FE43A {
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FE416
}

mc_enemy_purple_knight_aim_down_0FE441 {
    COP [97]
    COP [9B] ( #$0018, &mc_enemy_purple_knight_walk_down_0FE44D, &mc_enemy_purple_knight_strike_anim_0C_0FE4A8, &mc_enemy_purple_knight_walk_down_0FE44D )
}

mc_enemy_purple_knight_walk_down_0FE44D {
    COP [22] ( &mc_enemy_purple_knight_blocked_down_0FE458 )
    COP [80] ( #06 )
    COP [82]
    BRA loc_0FE416
}

mc_enemy_purple_knight_blocked_down_0FE458 {
    COP [80] ( #00 )
    COP [82]
    BRA loc_0FE416

  loc_0FE45F:
    COP [AD] ( #08 )
    COP [9A] ( #$0000, &mc_enemy_purple_knight_aim_left_0FE46C, &mc_enemy_purple_knight_aim_right_0FE48A, &mc_enemy_purple_knight_aim_right_0FE48A )
}

mc_enemy_purple_knight_aim_left_0FE46C {
    COP [9A] ( #$0018, &mc_enemy_purple_knight_walk_left_0FE476, &mc_enemy_purple_knight_strike_anim_0E_0FE4D9, &mc_enemy_purple_knight_walk_left_0FE476 )
}

mc_enemy_purple_knight_walk_left_0FE476 {
    COP [97]
    COP [23] ( &mc_enemy_purple_knight_blocked_left_0FE483 )
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FE45F
}

mc_enemy_purple_knight_blocked_left_0FE483 {
    COP [80] ( #04 )
    COP [82]
    BRA loc_0FE45F
}

mc_enemy_purple_knight_aim_right_0FE48A {
    COP [9A] ( #$0018, &mc_enemy_purple_knight_walk_right_0FE494, &mc_enemy_purple_knight_strike_anim_0E_0FE4D9, &mc_enemy_purple_knight_walk_right_0FE494 )
}

mc_enemy_purple_knight_walk_right_0FE494 {
    COP [96]
    COP [24] ( &mc_enemy_purple_knight_blocked_right_0FE4A1 )
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FE45F
}

mc_enemy_purple_knight_blocked_right_0FE4A1 {
    COP [80] ( #04 )
    COP [82]
    BRA loc_0FE45F
}

mc_enemy_purple_knight_strike_anim_0C_0FE4A8 {
    BRK #$41
    COP [80] ( #0C )
    COP [82]
    COP [B0] ( @mc_enemy_purple_knight_strike_hit_anim_19_0FE4B8, #$0200 )
    BRA loc_0FE45F
}

mc_enemy_purple_knight_strike_hit_anim_19_0FE4B8 {
    COP [80] ( #19 )
    COP [82]
    COP [86]
    RTL 
}

mc_enemy_purple_knight_strike_anim_0D_0FE4C0 {
    BRK #$41
    COP [80] ( #0D )
    COP [82]
    COP [B0] ( @mc_enemy_purple_knight_strike_hit_anim_1A_0FE4D1, #$0200 )
    BRL loc_0FE45F
}

mc_enemy_purple_knight_strike_hit_anim_1A_0FE4D1 {
    COP [80] ( #1A )
    COP [82]
    COP [86]
    RTL 
}

mc_enemy_purple_knight_strike_anim_0E_0FE4D9 {
    BRK #$41
    COP [80] ( #0E )
    COP [82]
    COP [B0] ( @mc_enemy_purple_knight_strike_hit_anim_1B_0FE4EA, #$0200 )
    BRL loc_0FE416
}

mc_enemy_purple_knight_strike_hit_anim_1B_0FE4EA {
    COP [80] ( #1B )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

; The Red Knight (meta type $12).
; 
; When: spawned by lairs of the towers (not placed).
; Sees: palette $2 (COP AA); the same chase as the Purple Knight (animations $08 / $06 walking up / down, $0A sideways), but when level it throws (BRK $52, animation $0F, $11 or $13 and a shot child with flags $0200; then animation $10, $12 or $14) instead of slashing. The shot child (mc_enemy_red_knight_shot_0FE59C and its copies) turns by the hero's side (COP 9A / 9B, COP 96) and plays one animation ($15, $16, $17 or $18).
; Why: bestiary: 'Swords; projectiles'; 36 HP / 950 EXP in the ROM and the bestiary.
; In: X = D = the slot.
; Out: loops; one shot actor per throw.
; Clobbers: A.

mc_enemy_red_knight_0FE4F2 {
    COP [AA] ( #02 )

  loc_0FE4F5:
    COP [AD] ( #08 )
    COP [9B] ( #$0000, &mc_enemy_red_knight_aim_up_0FE502, &mc_enemy_red_knight_aim_down_0FE520, &mc_enemy_red_knight_aim_down_0FE520 )
}

mc_enemy_red_knight_aim_up_0FE502 {
    COP [97]
    COP [9B] ( #$0018, &mc_enemy_red_knight_walk_up_0FE50E, &mc_enemy_red_knight_throw_anim_11_0FE5B2, &mc_enemy_red_knight_walk_up_0FE50E )
}

mc_enemy_red_knight_walk_up_0FE50E {
    COP [21] ( &mc_enemy_red_knight_blocked_up_0FE519 )
    COP [80] ( #08 )
    COP [82]
    BRA loc_0FE4F5
}

mc_enemy_red_knight_blocked_up_0FE519 {
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FE4F5
}

mc_enemy_red_knight_aim_down_0FE520 {
    COP [97]
    COP [9B] ( #$0018, &mc_enemy_red_knight_walk_down_0FE52C, &mc_enemy_red_knight_throw_anim_0F_0FE587, &mc_enemy_red_knight_walk_down_0FE52C )
}

mc_enemy_red_knight_walk_down_0FE52C {
    COP [22] ( &mc_enemy_red_knight_blocked_down_0FE537 )
    COP [80] ( #06 )
    COP [82]
    BRA loc_0FE4F5
}

mc_enemy_red_knight_blocked_down_0FE537 {
    COP [80] ( #00 )
    COP [82]
    BRA loc_0FE4F5

  loc_0FE53E:
    COP [AD] ( #08 )
    COP [9A] ( #$0000, &mc_enemy_red_knight_aim_left_0FE54B, &mc_enemy_red_knight_aim_right_0FE569, &mc_enemy_red_knight_aim_right_0FE569 )
}

mc_enemy_red_knight_aim_left_0FE54B {
    COP [9A] ( #$0018, &mc_enemy_red_knight_walk_left_0FE555, &mc_enemy_red_knight_throw_anim_13_0FE5DE, &mc_enemy_red_knight_walk_left_0FE555 )
}

mc_enemy_red_knight_walk_left_0FE555 {
    COP [97]
    COP [23] ( &mc_enemy_red_knight_blocked_left_0FE562 )
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FE53E
}

mc_enemy_red_knight_blocked_left_0FE562 {
    COP [80] ( #04 )
    COP [82]
    BRA loc_0FE53E
}

mc_enemy_red_knight_aim_right_0FE569 {
    COP [9A] ( #$0018, &mc_enemy_red_knight_walk_right_0FE573, &mc_enemy_red_knight_throw_anim_13_0FE5DE, &mc_enemy_red_knight_walk_right_0FE573 )
}

mc_enemy_red_knight_walk_right_0FE573 {
    COP [96]
    COP [24] ( &mc_enemy_red_knight_blocked_right_0FE580 )
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FE53E
}

mc_enemy_red_knight_blocked_right_0FE580 {
    COP [80] ( #04 )
    COP [82]
    BRA loc_0FE53E
}

mc_enemy_red_knight_throw_anim_0F_0FE587 {
    BRK #$52
    COP [80] ( #0F )
    COP [82]
    COP [B0] ( @mc_enemy_red_knight_shot_0FE59C, #$0200 )
    COP [80] ( #10 )
    COP [82]
    BRA loc_0FE53E
}

mc_enemy_red_knight_shot_0FE59C {
    COP [A3]
    COP [9A] ( #$0000, &mc_enemy_red_knight_shot_anim_15_0FE5AA, &mc_enemy_red_knight_shot_flip_0FE5A8, &mc_enemy_red_knight_shot_flip_0FE5A8 )
}

mc_enemy_red_knight_shot_flip_0FE5A8 {
    COP [96]
}

mc_enemy_red_knight_shot_anim_15_0FE5AA {
    COP [80] ( #15 )
    COP [82]
    COP [86]
    RTL 
}

mc_enemy_red_knight_throw_anim_11_0FE5B2 {
    BRK #$52
    COP [80] ( #11 )
    COP [82]
    COP [B0] ( @mc_enemy_red_knight_shot_0FE5C8, #$0200 )
    COP [80] ( #12 )
    COP [82]
    BRL loc_0FE53E
}

mc_enemy_red_knight_shot_0FE5C8 {
    COP [A3]
    COP [9A] ( #$0000, &mc_enemy_red_knight_shot_anim_18_0FE5D6, &mc_enemy_red_knight_shot_flip_0FE5D4, &mc_enemy_red_knight_shot_flip_0FE5D4 )
}

mc_enemy_red_knight_shot_flip_0FE5D4 {
    COP [96]
}

mc_enemy_red_knight_shot_anim_18_0FE5D6 {
    COP [80] ( #18 )
    COP [82]
    COP [86]
    RTL 
}

mc_enemy_red_knight_throw_anim_13_0FE5DE {
    BRK #$52
    COP [80] ( #13 )
    COP [82]
    COP [B0] ( @mc_enemy_red_knight_shot_0FE5F4, #$0200 )
    COP [80] ( #14 )
    COP [82]
    BRL loc_0FE4F5
}

mc_enemy_red_knight_shot_0FE5F4 {
    COP [A3]
    COP [9B] ( #$0000, &mc_enemy_red_knight_shot_anim_17_0FE600, &mc_enemy_red_knight_shot_anim_16_0FE608, &mc_enemy_red_knight_shot_anim_16_0FE608 )
}

mc_enemy_red_knight_shot_anim_17_0FE600 {
    COP [80] ( #17 )
    COP [82]
    COP [86]
    RTL 
}

mc_enemy_red_knight_shot_anim_16_0FE608 {
    COP [80] ( #16 )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

; A static tower prop (meta type $13).
; 
; When: placed in A12S02 (eight).
; Sees: animation $1C and a wait until on screen (COP AD #8), forever.
; Why: a decoration with the hero's stat bytes; its identity is by placement only (OQ-I039-6).
; In: X = D = the slot.
; Out: loops.
; Clobbers: A.

mc_obj_static_prop_0FE610 {
    COP [80] ( #1C )
    COP [82]
    COP [AD] ( #08 )
    BRA mc_obj_static_prop_0FE610
}
---------------------------------------------

; The fire-blasting statue of the towers (meta type $14).
; 
; When: placed in A12S01 (twelve), A12S04 (six), A12S05 (two) and A12S06 (six); runs from scene load.
; Sees: COP A5 by the facing: none = mc_obj_statue_shooter_down_poll_0FE624, flip X = left (0FE670), flip Y = right (0FE6BC), both = up (0FE70A); the loop is the one of the dungeon statue (mc_obj_statue_shooter_0FDE71) with animations $1D (down), $1F (left, right) and $1E (up) and the faster fireball.
; Why: the walkthrough: 'Four chests (and two fire-blasting statues) will be released' in the right tower.
; In: X = D = the slot.
; Out: never returns.
; Clobbers: A.

mc_obj_statue_shooter_0FE61A {
    COP [A5] ( &mc_obj_statue_shooter_down_poll_0FE624, &mc_obj_statue_shooter_left_poll_0FE670, &mc_obj_statue_shooter_right_poll_0FE6BC, &mc_obj_statue_shooter_up_poll_0FE70A )
}

---------------------------------------------
; Shoots down: the tower statue's loop for the south facing.
; 
; When: from the root; a delay of $78 frames after each round (COP 1B).
; Sees: off screen = wait; the hero inside the box widened by 7 px, COP 9B threshold $10 (hero at least $10 below), the gate (COP 28) and then animation $1D and a fireball at (0,+$10) with flags $0200; the left, right and up copies fire at (-$10,0), (+$10,0) and (0,-$10).
; Why: see mc_obj_statue_shooter_down_poll_0FDE7B.
; In: X = D = the statue.
; Out: fireballs.
; Clobbers: A.

mc_obj_statue_shooter_down_poll_0FE624 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE632

  mc_obj_statue_shooter_down_wait_0FE62C:
    COP [1B] ( &mc_obj_statue_shooter_down_poll_0FE624, #$0078 )

  loc_0FE632:
    COP [0C] ( #00, #07, &mc_obj_statue_shooter_down_aim_0FE63A )
    BRA mc_obj_statue_shooter_down_wait_0FE62C
}

mc_obj_statue_shooter_down_aim_0FE63A {
    COP [9B] ( #$0010, &mc_obj_statue_shooter_down_wait_0FE62C, &mc_obj_statue_shooter_down_wait_0FE62C, &mc_obj_statue_shooter_down_gate_0FE644 )
}

mc_obj_statue_shooter_down_gate_0FE644 {
    COP [28] ( &mc_obj_statue_shooter_down_fire_0FE64C )
    COP [27] ( &mc_obj_statue_shooter_down_wait_0FE62C )
}

mc_obj_statue_shooter_down_fire_0FE64C {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #1D )
    COP [82]
    COP [B2] ( @mc_obj_statue_shooter_fireball_0FE756, #$0000, #$0010, #$0200 ) ; the fireball at (0,+$10), flags $0200 (cannot be hit)
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA mc_obj_statue_shooter_down_wait_0FE62C
}

mc_obj_statue_shooter_left_poll_0FE670 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE67E

  mc_obj_statue_shooter_left_wait_0FE678:
    COP [1B] ( &mc_obj_statue_shooter_left_poll_0FE670, #$0078 )

  loc_0FE67E:
    COP [0C] ( #00, #07, &mc_obj_statue_shooter_left_aim_0FE686 )
    BRA mc_obj_statue_shooter_left_wait_0FE678
}

mc_obj_statue_shooter_left_aim_0FE686 {
    COP [9A] ( #$0010, &mc_obj_statue_shooter_left_gate_0FE690, &mc_obj_statue_shooter_left_wait_0FE678, &mc_obj_statue_shooter_left_wait_0FE678 )
}

mc_obj_statue_shooter_left_gate_0FE690 {
    COP [28] ( &mc_obj_statue_shooter_left_fire_0FE698 )
    COP [27] ( &mc_obj_statue_shooter_left_wait_0FE678 )
}

mc_obj_statue_shooter_left_fire_0FE698 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #1F )
    COP [82]
    COP [B2] ( @mc_obj_statue_shooter_fireball_0FE756, #$FFF0, #$0000, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA mc_obj_statue_shooter_left_wait_0FE678
}

mc_obj_statue_shooter_right_poll_0FE6BC {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE6CA

  mc_obj_statue_shooter_right_wait_0FE6C4:
    COP [1B] ( &mc_obj_statue_shooter_right_poll_0FE6BC, #$0078 )

  loc_0FE6CA:
    COP [0C] ( #00, #07, &mc_obj_statue_shooter_right_aim_0FE6D2 )
    BRA mc_obj_statue_shooter_right_wait_0FE6C4
}

mc_obj_statue_shooter_right_aim_0FE6D2 {
    COP [9A] ( #$0010, &mc_obj_statue_shooter_right_wait_0FE6C4, &mc_obj_statue_shooter_right_wait_0FE6C4, &mc_obj_statue_shooter_right_gate_0FE6DC )
}

mc_obj_statue_shooter_right_gate_0FE6DC {
    COP [28] ( &mc_obj_statue_shooter_right_fire_0FE6E4 )
    COP [27] ( &mc_obj_statue_shooter_right_wait_0FE6C4 )
}

mc_obj_statue_shooter_right_fire_0FE6E4 {
    COP [96]
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #1F )
    COP [82]
    COP [B2] ( @mc_obj_statue_shooter_fireball_0FE756, #$0010, #$0000, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA mc_obj_statue_shooter_right_wait_0FE6C4
}

mc_obj_statue_shooter_up_poll_0FE70A {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE718

  mc_obj_statue_shooter_up_wait_0FE712:
    COP [1B] ( &mc_obj_statue_shooter_up_poll_0FE70A, #$0078 )

  loc_0FE718:
    COP [0C] ( #00, #07, &mc_obj_statue_shooter_up_aim_0FE720 )
    BRA mc_obj_statue_shooter_up_wait_0FE712
}

mc_obj_statue_shooter_up_aim_0FE720 {
    COP [9B] ( #$0010, &mc_obj_statue_shooter_up_gate_0FE72A, &mc_obj_statue_shooter_up_wait_0FE712, &mc_obj_statue_shooter_up_wait_0FE712 )
}

mc_obj_statue_shooter_up_gate_0FE72A {
    COP [28] ( &mc_obj_statue_shooter_up_fire_0FE732 )
    COP [27] ( &mc_obj_statue_shooter_up_wait_0FE712 )
}

mc_obj_statue_shooter_up_fire_0FE732 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #1E )
    COP [82]
    COP [B2] ( @mc_obj_statue_shooter_fireball_0FE756, #$0000, #$FFF0, #$0200 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA mc_obj_statue_shooter_up_wait_0FE712
}

---------------------------------------------
; The tower statue's fireball.
; 
; When: spawned by a fire label of the tower statue (flags $0200).
; Sees: COP A3, BRK $64, Y = $20 and the jump into shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67.
; Why: same trick as the dungeon fireball with another parameter.
; In: X = D = the fireball; Y is set to $20.
; Out: RTL into cm_enemy_aimed_shot_body_002D67.
; Clobbers: A, Y.

mc_obj_statue_shooter_fireball_0FE756 {
    COP [A3]
    BRK #$64
    LDY #$0020            ; parameter of the shared projectile mover (the dungeon statue uses 5)
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67-1
    PHA 
    RTL 
}
---------------------------------------------

; The Mimic (meta type $15), a chest that bites.
; 
; When: placed in A12S05, A12S06 and A12S07 (two each).
; Sees: starts hidden ($16 bit $2000) and retries every 8 frames while COP 28 finds the tile under it occupied; once the tile is free it appears as a chest (mc_enemy_mimic_chest_idle_0FE78A): blocked tiles, $16 bit $0200 set, a loop of $32 rounds that tests the hero inside the box widened by 1 px (COP 0C) with animation $25; at the end animation $29, unblock and a random pose ($28, $27, $26 or flipped $28). When the hero touches the box it is revealed (mc_enemy_mimic_reveal_0FE7E1: animation $25 for 10 frames, unblock, $0200 cleared) and chases (every 8 frames COP 9C picks the nearer axis; lunge animations $2B, $2A, $2C) until a tile blocks it and it falls back into the chest.
; Why: the walkthrough: 'The northeast and southwest chests are Mimics'; bestiary: 'Lunges', 25 HP / 1,000 EXP.
; In: X = D = the slot.
; Out: loops.
; Clobbers: A.

mc_enemy_mimic_0FE76C {
    LDA $0016, X          ; the Mimic starts hidden ($16 bit $2000)
    ORA #$2000
    STA $0016, X

  mc_enemy_mimic_wait_floor_0FE775:
    COP [28] ( &mc_enemy_mimic_wait_floor_retry_0FE77B ) ; tile under the Mimic occupied: retry in 8 frames; free: appear
    BRA loc_0FE781
}

mc_enemy_mimic_wait_floor_retry_0FE77B {
    COP [1B] ( &mc_enemy_mimic_wait_floor_0FE775, #$0008 )

  loc_0FE781:
    LDA $0016, X
    AND #$DFFF
    STA $0016, X

  mc_enemy_mimic_chest_idle_0FE78A:
    COP [AD] ( #08 )
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [15]
    COP [97]
    COP [03] ( #32 )
    COP [0C] ( #00, #01, &mc_enemy_mimic_reveal_0FE7E1 ) ; the hero inside the box widened by 1 px: reveal
    COP [80] ( #25 )
    COP [82]
    COP [04]
    COP [80] ( #29 )
    COP [82]
    COP [16]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FE7CC
    DEC 
    BEQ loc_0FE7D3
    DEC 
    BEQ loc_0FE7DA
    COP [96]

  loc_0FE7CC:
    COP [80] ( #28 )
    COP [82]
    BRA mc_enemy_mimic_chest_idle_0FE78A

  loc_0FE7D3:
    COP [80] ( #27 )
    COP [82]
    BRA mc_enemy_mimic_chest_idle_0FE78A

  loc_0FE7DA:
    COP [80] ( #26 )
    COP [82]
    BRA mc_enemy_mimic_chest_idle_0FE78A
}

mc_enemy_mimic_reveal_0FE7E1 {
    COP [81] ( #25, #0A )
    COP [83]
    COP [16]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X

  mc_enemy_mimic_chase_0FE7F2:
    COP [1B] ( &mc_enemy_mimic_chase_axis_0FE7F8, #$0008 )
}

---------------------------------------------
; The Mimic's lunge direction.
; 
; When: every 8 frames while revealed.
; Sees: COP 9C jumps to mc_enemy_mimic_chase_x_0FE7FE when the x distance is larger, else to mc_enemy_mimic_chase_y_0FE808; each uses threshold 8 (COP 9A / 9B) and then a lunge label that plays the lunge animation with COP 9D / COP 9E until blocked (then back to the chest pose).
; Why: one axis at a time.
; In: X = D = the Mimic.
; Out: loops.
; Clobbers: A.

mc_enemy_mimic_chase_axis_0FE7F8 {
    COP [9C] ( &mc_enemy_mimic_chase_x_0FE7FE, &mc_enemy_mimic_chase_y_0FE808 )
}

mc_enemy_mimic_chase_x_0FE7FE {
    COP [9A] ( #$0008, &mc_enemy_mimic_lunge_anim_2C_0FE828, &mc_enemy_mimic_chase_y_0FE808, &mc_enemy_mimic_lunge_anim_2C_flip_0FE833 )
}

mc_enemy_mimic_chase_y_0FE808 {
    COP [9B] ( #$0008, &mc_enemy_mimic_lunge_anim_2B_0FE812, &mc_enemy_mimic_chase_0FE7F2, &mc_enemy_mimic_lunge_anim_2A_0FE81D )
}

mc_enemy_mimic_lunge_anim_2B_0FE812 {
    COP [97]
    COP [9D] ( #2B )
    COP [9E] ( &mc_enemy_mimic_chest_idle_0FE78A )

  loc_0FE81B:
    BRA mc_enemy_mimic_chase_0FE7F2
}

mc_enemy_mimic_lunge_anim_2A_0FE81D {
    COP [97]
    COP [9D] ( #2A )
    COP [9E] ( &mc_enemy_mimic_chest_idle_0FE78A )

  loc_0FE826:
    BRA mc_enemy_mimic_chase_0FE7F2
}

mc_enemy_mimic_lunge_anim_2C_0FE828 {
    COP [97]
    COP [9D] ( #2C )
    COP [9E] ( &mc_enemy_mimic_chest_idle_0FE78A )

  loc_0FE831:
    BRA mc_enemy_mimic_chase_0FE7F2
}

mc_enemy_mimic_lunge_anim_2C_flip_0FE833 {
    COP [96]
    COP [9D] ( #2C )
    COP [9E] ( &mc_enemy_mimic_chest_idle_0FE78A )

  loc_0FE83C:
    BRA mc_enemy_mimic_chase_0FE7F2
}
---------------------------------------------

; The Bronze Robot (meta type $16).
; 
; When: spawned by lairs of the right tower (not placed).
; Sees: waits until on screen and then plays a fixed loop of the animations $2E, $2F and $30 with flips (COP 96 / 97) between them; there is no chase.
; Why: bestiary: 'Moving slowly'; 20 HP / 800 EXP. The movement comes from the animation frames.
; In: X = D = the slot.
; Out: loops.
; Clobbers: A.

mc_enemy_bronze_robot_0FE83E {
    COP [AD] ( #08 )

  loc_0FE841:
    COP [80] ( #2E )
    COP [82]
    COP [80] ( #30 )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    COP [96]
    COP [80] ( #2F )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    COP [96]
    COP [80] ( #30 )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    COP [97]
    COP [80] ( #2F )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    COP [80] ( #30 )
    COP [82]
    COP [96]
    COP [80] ( #30 )
    COP [82]
    COP [80] ( #2F )
    COP [82]
    COP [97]
    COP [80] ( #2F )
    COP [82]
    BRA loc_0FE841
}
---------------------------------------------

; The Chess Knight (meta type $17).
; 
; When: spawned by lairs of the right tower (not placed).
; Sees: waits until on screen (a retry every 8 frames), compares the hero's x then y (COP 9A / 9B threshold 0) to pick a quadrant label (up_left, up_right, down_left, down_right); each draws a random number and picks one of two knight moves: COP AE tests the tile at (dx,dy) ((+$10,-$20), (+$20,-$10), (+$20,+$10), (+$10,+$20), (-$10,+$20), (-$20,+$10), (-$20,-$10), (-$10,-$20)); a blocked tile skips the move animation ($40-$45) and goes straight to the spike ring.
; Why: bestiary: 'Spike rings'; 28 HP / 850 EXP. The walkthrough: 'they're best dealt with through magic because their spikes surround them'.
; In: X = D = the slot.
; Out: loops.
; Clobbers: A.

mc_enemy_chess_knight_0FE88E {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FE89C
    COP [1B] ( &mc_enemy_chess_knight_0FE88E, #$0008 )

  loc_0FE89C:
    COP [9A] ( #$0000, &mc_enemy_chess_knight_aim_left_0FE8A6, &mc_enemy_chess_knight_aim_right_0FE8B0, &mc_enemy_chess_knight_aim_right_0FE8B0 )
}

mc_enemy_chess_knight_aim_left_0FE8A6 {
    COP [9B] ( #$0000, &mc_enemy_chess_knight_up_left_0FE936, &mc_enemy_chess_knight_down_left_0FE90E, &mc_enemy_chess_knight_down_left_0FE90E )
}

mc_enemy_chess_knight_aim_right_0FE8B0 {
    COP [9B] ( #$0000, &mc_enemy_chess_knight_up_right_0FE8BA, &mc_enemy_chess_knight_down_right_0FE8E4, &mc_enemy_chess_knight_down_right_0FE8E4 )
}

mc_enemy_chess_knight_up_right_0FE8BA {
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE8D3
    COP [97]
    COP [AE] ( #$0010, #$FFE0, &mc_enemy_chess_knight_spike_ring_b_0FE990 ) ; tile at (+$10,-$20) occupied: skip the move animation and ring at once
    COP [80] ( #43 )
    COP [82]
    BRL mc_enemy_chess_knight_spike_ring_b_0FE990

  loc_0FE8D3:
    COP [96]
    COP [AE] ( #$0020, #$FFF0, &mc_enemy_chess_knight_spike_ring_a_0FE95D )
    COP [80] ( #45 )
    COP [82]
    BRA mc_enemy_chess_knight_spike_ring_a_0FE95D
}

mc_enemy_chess_knight_down_right_0FE8E4 {
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE8FC
    COP [96]
    COP [AE] ( #$0020, #$0010, &mc_enemy_chess_knight_spike_ring_a_0FE95D )
    COP [80] ( #44 )
    COP [82]
    BRA mc_enemy_chess_knight_spike_ring_a_0FE95D

  loc_0FE8FC:
    COP [97]
    COP [AE] ( #$0010, #$0020, &mc_enemy_chess_knight_spike_ring_c_0FE9C3 )
    COP [80] ( #41 )
    COP [82]
    BRL mc_enemy_chess_knight_spike_ring_c_0FE9C3
}

mc_enemy_chess_knight_down_left_0FE90E {
    COP [97]
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE927
    COP [AE] ( #$FFF0, #$0020, &mc_enemy_chess_knight_spike_ring_c_0FE9C3 )
    COP [80] ( #40 )
    COP [82]
    BRL mc_enemy_chess_knight_spike_ring_c_0FE9C3

  loc_0FE927:
    COP [AE] ( #$FFE0, #$0010, &mc_enemy_chess_knight_spike_ring_a_0FE95D )
    COP [80] ( #44 )
    COP [82]
    BRA mc_enemy_chess_knight_spike_ring_a_0FE95D
}

mc_enemy_chess_knight_up_left_0FE936 {
    COP [97]
    COP [1F]
    LDA $rng_state+1
    BMI loc_0FE94E
    COP [AE] ( #$FFE0, #$FFF0, &mc_enemy_chess_knight_spike_ring_a_0FE95D )
    COP [80] ( #45 )
    COP [82]
    BRA mc_enemy_chess_knight_spike_ring_a_0FE95D

  loc_0FE94E:
    COP [AE] ( #$FFF0, #$FFE0, &mc_enemy_chess_knight_spike_ring_b_0FE990 )
    COP [80] ( #42 )
    COP [82]
    BRA mc_enemy_chess_knight_spike_ring_b_0FE990
}

---------------------------------------------
; The Chess Knight's spike ring (variant a).
; 
; When: after a move of two tiles across and one tile up or down (dx = +-$20).
; Sees: the landing animation $3F (4 repeats), $16 bit $0200 set (cannot be hit), animations $4C, $4D, $4E with the spikes spawned in between (mc_enemy_chess_knight_spike_spawn_0FE9F6), $0200 cleared, animation $3F again, then back to the start. The variants b (after a move of one tile across and two up; landing $3E, ring $49-$4B) and c (one across and two down; landing $3D, ring $46-$48) are the same.
; Why: the knight is untouchable while the ring is out; the spikes are two pieces.
; In: X = D = the slot.
; Out: loops back to mc_enemy_chess_knight_0FE88E.
; Clobbers: A.

mc_enemy_chess_knight_spike_ring_a_0FE95D {
    COP [81] ( #3F, #04 )
    COP [83]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #4C )
    COP [82]
    JSR $&mc_enemy_chess_knight_spike_spawn_0FE9F6
    COP [80] ( #4D )
    COP [82]
    COP [80] ( #4E )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #3F, #04 )
    COP [83]
    BRL mc_enemy_chess_knight_0FE88E
}

mc_enemy_chess_knight_spike_ring_b_0FE990 {
    COP [81] ( #3E, #04 )
    COP [83]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #49 )
    COP [82]
    JSR $&mc_enemy_chess_knight_spike_spawn_0FE9F6
    COP [80] ( #4A )
    COP [82]
    COP [80] ( #4B )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #3E, #04 )
    COP [83]
    BRL mc_enemy_chess_knight_0FE88E
}

mc_enemy_chess_knight_spike_ring_c_0FE9C3 {
    COP [81] ( #3D, #04 )
    COP [83]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #46 )
    COP [82]
    JSR $&mc_enemy_chess_knight_spike_spawn_0FE9F6
    COP [80] ( #47 )
    COP [82]
    COP [80] ( #48 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #3D, #04 )
    COP [83]
    BRL mc_enemy_chess_knight_0FE88E
}

---------------------------------------------
; Spawns the two spike pieces of the ring.
; 
; When: JSR from the three spike ring labels.
; Sees: two COP B2 spawns with flags $0200: animation $4F at (0,+$10) and animation $50 at (-$10,0); each piece plays its animation and ends.
; Why: the spikes around the knight (the walkthrough: 'their spikes surround them').
; In: X = D = the knight.
; Out: two children; RTS.
; Clobbers: A.

mc_enemy_chess_knight_spike_spawn_0FE9F6 {
    COP [B2] ( @mc_enemy_chess_knight_spike_piece_anim_4F_0FEA0D, #$0000, #$0010, #$0200 )
    COP [B2] ( @mc_enemy_chess_knight_spike_piece_anim_50_0FEA15, #$FFF0, #$0000, #$0200 )
    RTS 
}

mc_enemy_chess_knight_spike_piece_anim_4F_0FEA0D {
    COP [80] ( #4F )
    COP [82]
    COP [86]
    RTL 
}

mc_enemy_chess_knight_spike_piece_anim_50_0FEA15 {
    COP [80] ( #50 )
    COP [82]
    COP [86]
    RTL 
}