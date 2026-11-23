; Nine monsters of the Mountain of Souls and their projectiles (file offsets 1034031-1036245 and 1036571-1036916, SNES $1F:C72F-$CFD5 and $1F:D11B-$D274): Green Lizard, Undead Caribou, Yeti, Fire Bat, the snowball, Purple Wizard, Red Wizard, Cave Bat and Green Blob. The Ice Maker and the Ice Crystal lie between the two ranges in their own files.
; 
; === ROSTER (meta type of MetaMountainOfSouls: attack / defence / HP / EXP; lair records that spawn it) ===
; - $2D ms_enemy_green_lizard_0FC72F: 9 / 6 / 8 / 65; lairs $CA, $D3, $D4, $EB, $EC. A burrowing patroller that emerges when the hero is near.
; - $2E ms_enemy_undead_caribou_0FC845: 11 / 6 / 25 / 70; lair $EA. Wakes up, walks to the hero and throws its head.
; - $2F ms_enemy_yeti_0FC8FE: 10 / 3 / 20 / 80; lairs $C9, $E9. Chases the hero (clubs).
; - $30 ms_enemy_fire_bat_0FC9BC: 9 / 5 / 14 / 85; lairs $CB, $CC. Flaps and shoots fireballs.
; - $31 ms_enemy_snowball_0FCA35: 10 / 4 / 40 / 2000; no lair, placed in A0BS02 (5 times) and A0CS01 (2 times). Rolls toward the hero; no bestiary row (OQ-I033-3), the name is the walkthrough's ('dodge the snowballs').
; - $32 ms_enemy_purple_wizard_0FCBDF: 14 / 5 / 17 / 85; lairs $F6, $F7, $F8, $FC. Teleports 4 tiles from the hero and fires one bolt.
; - $33 ms_enemy_red_wizard_0FCDBA: 14 / 4 / 20 / 100; lairs $D6, $D7, $FF. The same at 2 tiles with three fireballs.
; - $36 ms_enemy_cave_bat_0FD11B: 13 / 6 / 14 / 75; lairs $E6, $E8, $F2, $FA, $FE. Flies after the hero.
; - $37 ms_enemy_green_blob_0FD1E5: 12 / 6 / 12 / 80; lairs $D9, $DD, $E1, $EE, $EF, $F0. Bounces, half of its hops toward the hero.
; HP is a hex byte (the bestiary agrees: 8, 25, 20, 14, 17, 20, 14, 12); EXP is BCD. The lair assignments are those of the lair records with home location $3D, $41 or $45 listed in the Soul of Mountain House notes.
; 
; === CONVENTIONS OF THE SCRIPTS ===
; - COP AD (#08) waits while the actor is off screen. COP 0C (slot 0, margin) jumps when the hero lies inside the actor's box widened by the margin (the 'near' test). COP 9A / 9B / 9C steer by the hero's position relative to the actor (9A on x, 9B on y: left or above / within / right or below; 9C picks the dominant axis). COP A5 jumps by the flip state set by the lair at spawn (none / flip X / flip Y / both), so the four monsters of one lair start in different directions.
; - The motion itself is in the animations (COP 80 / 82, COP 81 / 83); the scripts only choose the animation and its flip. Projectiles are short-lived actors: $16 = $0200 makes the actor a hostile hitbox, $0300 also hides it from hits; draw priority with COP A3 / A4 / A2.
; - Only the Green Lizard moves the actor itself (COP 9F / A0 add to X / Y).
; 
; === OPEN ===
; The lair monsters differ from the walkthrough in places: the lairs of $CB and $CC (North slope, Aurora's Ridge) spawn type $30 (Fire Bat stats, fireballs) where the walkthrough says Cave Bats; Nome's lair $D6 holds Red Wizards where the walkthrough says lizards (OQ-I037-2). The matching of types to monsters is inferred from HP and EXP (see MetaMountainOfSouls).
---------------------------------------------

?BANK 1F

?INCLUDE 'shared_actor_helpers_bank0'

!rng_state                      0301
!map_width_px                   0342
!map_height_px                  0344
!player_x                       0374
!player_y                       0376

---------------------------------------------

; Green Lizard: patrols a line while burrowed and surfaces when the hero is near.
; 
; When: lair monster (type $2D, HP 8); drawn behind the ground (COP A4).
; Sees: COP A5 picks the patrol by flip state at spawn: none south (code_0FC766), flip X west (code_0FC7BC), flip Y east (code_0FC791), both north (code_0FC73B). Each patrol loops: COP AD, COP 0C with margin 2 (hero near: code_0FC7E7), a tile test ahead (COP 21 / 22 / 23 / 24; a wall turns it around), then two steps of animation $09 with a dust puff each (ms_effect_green_lizard_dust_0FC835) and 8 pixels of X or Y (COP 9F / A0).
; Why: the walkthrough: 'remember, they are easily camouflaged when burrowing'.
; In: X = D = slot.
; Out: never returns.
; Clobbers: A.

ms_enemy_green_lizard_0FC72F {
    COP [A4]
    COP [A5] ( &code_0FC766, &code_0FC7BC, &code_0FC791, &code_0FC73B ) ; patrol by flip state at spawn: none south, flip X west, flip Y east, both north
}

code_0FC73B {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC7E7 ) ; hero within the box widened by 2: surface (code_0FC7E7)
    COP [21] ( &code_0FC773 )

  code_0FC748:
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @ms_effect_green_lizard_dust_0FC835 )
    COP [A0] ( #$FFF8 )   ; adds -8 to Y: one step north
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @ms_effect_green_lizard_dust_0FC835 )
    COP [A0] ( #$FFF8 )
    BRA code_0FC73B
}

code_0FC766 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC7E7 )
    COP [22] ( &code_0FC748 )
}

code_0FC773 {
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @ms_effect_green_lizard_dust_0FC835 )
    COP [A0] ( #$0008 )
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @ms_effect_green_lizard_dust_0FC835 )
    COP [A0] ( #$0008 )
    BRA code_0FC766
}

code_0FC791 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC7E7 )
    COP [24] ( &code_0FC7C9 )

  code_0FC79E:
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @ms_effect_green_lizard_dust_0FC835 )
    COP [9F] ( #$0008 )
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @ms_effect_green_lizard_dust_0FC835 )
    COP [9F] ( #$0008 )
    BRA code_0FC791
}

code_0FC7BC {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC7E7 )
    COP [23] ( &code_0FC79E )
}

code_0FC7C9 {
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @ms_effect_green_lizard_dust_0FC835 )
    COP [9F] ( #$FFF8 )
    COP [80] ( #09 )
    COP [82]
    COP [85] ( @ms_effect_green_lizard_dust_0FC835 )
    COP [9F] ( #$FFF8 )
    BRA code_0FC7BC
}

---------------------------------------------
; The Lizard surfaces and keeps facing the hero.
; 
; When: COP 0C found the hero inside the box (margin 2).
; Sees: COP A7 (no longer drawn behind), animation $0B, $16 = $1000, then a loop: COP AD, COP 9C picks the dominant axis; on x COP 9A (threshold $10) sets flip X and plays animation $0E; on y COP 9B (threshold $10) plays animation $0D or $0C.
; Why: the surfaced lizard turns to the hero and does not patrol again.
; In: X = D = slot.
; Out: never returns (BRA loop).
; Clobbers: A.

code_0FC7E7 {
    COP [A7]
    COP [80] ( #0B )
    COP [82]
    LDA #$1000
    STA $0016, X

  loc_0FC7F4:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FC7FD, &code_0FC819 )
}

code_0FC7FD {
    COP [9A] ( #$0010, &code_0FC807, &code_0FC810, &code_0FC810 )
}

code_0FC807 {
    COP [97]
    COP [80] ( #0E )
    COP [82]
    BRA loc_0FC7F4
}

code_0FC810 {
    COP [96]
    COP [80] ( #0E )
    COP [82]
    BRA loc_0FC7F4
}

code_0FC819 {
    COP [9B] ( #$0010, &code_0FC823, &code_0FC82C, &code_0FC82C )
}

code_0FC823 {
    COP [97]
    COP [80] ( #0D )
    COP [82]
    BRA loc_0FC7F4
}

code_0FC82C {
    COP [97]
    COP [80] ( #0C )
    COP [82]
    BRA loc_0FC7F4
}

---------------------------------------------
; The dust puff a burrowed lizard leaves.
; 
; When: spawned by every step of the lizard (COP 85).
; Sees: $16 = $0300, drawn behind (COP A4), animation $0A, then COP 86.
; Why: shows where the lizard is under the ground.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_effect_green_lizard_dust_0FC835 {
    LDA #$0300
    STA $0016, X
    COP [A4]
    COP [80] ( #0A )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

; Undead Caribou: waits until the hero is near, then walks to him and throws its head.
; 
; When: lair monster (type $2E, HP 25).
; Sees: COP AD, COP 0C (margin 2): near, code_0FC854; else COP 1B retries in 8 frames. code_0FC854 plays animations $29 and $1F (waking up), then loops: animation $20 and a steer with COP 9A (threshold $18) / 9B: walking animations $24 (hero left), $23 (right), $22 (above), $21 (below), each after a tile test (a wall waits 8 frames with COP 1B); then animation $25 and COP 0C with margin 4: near, code_0FC8D5.
; Why: Undead Caribou, 'head-throwing' in the bestiary.
; In: X = D = slot.
; Out: never returns.
; Clobbers: A.

ms_enemy_undead_caribou_0FC845 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #02, &code_0FC854 )
    COP [1B] ( &ms_enemy_undead_caribou_0FC845, #$0008 )
}

code_0FC854 {
    COP [80] ( #29 )
    COP [82]
    COP [80] ( #1F )
    COP [82]

  loc_0FC85E:
    COP [AD] ( #08 )
    COP [80] ( #20 )
    COP [82]
    COP [9A] ( #$0018, &code_0FC884, &code_0FC870, &code_0FC895 )
}

code_0FC870 {
    COP [9B] ( #$0000, &code_0FC8A6, &code_0FC8B7, &code_0FC8B7 )

  code_0FC87A:
    COP [9A] ( #$0000, &code_0FC884, &code_0FC895, &code_0FC895 )
}

code_0FC884 {
    COP [23] ( &code_0FC88F )
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FC8C8
}

code_0FC88F {
    COP [1B] ( &code_0FC870, #$0008 )
}

code_0FC895 {
    COP [24] ( &code_0FC8A0 )
    COP [80] ( #23 )
    COP [82]
    BRA loc_0FC8C8
}

code_0FC8A0 {
    COP [1B] ( &code_0FC870, #$0008 )
}

code_0FC8A6 {
    COP [21] ( &code_0FC8B1 )
    COP [80] ( #22 )
    COP [82]
    BRA loc_0FC8C8
}

code_0FC8B1 {
    COP [1B] ( &code_0FC87A, #$0008 )
}

code_0FC8B7 {
    COP [22] ( &code_0FC8C2 )
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FC8C8
}

code_0FC8C2 {
    COP [1B] ( &code_0FC87A, #$0008 )

  loc_0FC8C8:
    COP [80] ( #25 )
    COP [82]
    COP [0C] ( #00, #04, &code_0FC8D5 )
    BRA loc_0FC85E
}

---------------------------------------------
; The Caribou throws its head.
; 
; When: the hero is within margin 4 of the walking caribou.
; Sees: spawns ms_enemy_undead_caribou_head_0FC8F0 (COP 85), sets $16 = $0200, plays animation $27 with the body, clears $16 and plays $1F, then returns to the walking loop.
; Why: the head is a separate hitbox actor.
; In: X = D = slot.
; Out: BRL back to the loop.
; Clobbers: A.

code_0FC8D5 {
    COP [85] ( @ms_enemy_undead_caribou_head_0FC8F0 )
    LDA #$0200
    STA $0016, X
    COP [80] ( #27 )
    COP [82]
    STZ $0016, X
    COP [80] ( #1F )
    COP [82]
    BRL loc_0FC85E
}

---------------------------------------------
; The thrown head of the Undead Caribou.
; 
; When: spawned by code_0FC8D5.
; Sees: $16 = $0200 (hostile hitbox), animation $26, then COP 86; the flight is part of the animation (not verified).
; Why: see code_0FC8D5.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_enemy_undead_caribou_head_0FC8F0 {
    LDA #$0200
    STA $0016, X
    COP [80] ( #26 )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

; Yeti: chases the hero.
; 
; When: lair monster (type $2F, HP 20).
; Sees: off screen ($16 bit 15 set) it waits 4 frames (COP 1B). Otherwise two mirrored chase loops steer with COP 9B / 9A (threshold 8, then 0): the first loop (here) handles the vertical difference first (animation $04 when the hero is above, $03 below, $08 with flip X for the sides), the second (code_0FC95C) the horizontal one first (animation $05 for the sides, $07 above, $06 below); every move is preceded by a tile test (COP 21 / 22 / 23 / 24 or COP AE on a tile type) and a blocked move waits 4 frames.
; Why: Yeti with a club (bestiary).
; In: X = D = slot.
; Out: never returns.
; Clobbers: A.

ms_enemy_yeti_0FC8FE {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC90C

  code_0FC906:
    COP [1B] ( &ms_enemy_yeti_0FC8FE, #$0004 )

  loc_0FC90C:
    COP [9B] ( #$0008, &code_0FC916, &code_0FC930, &code_0FC923 )
}

code_0FC916 {
    COP [21] ( &code_0FC964 )
    COP [97]
    COP [80] ( #04 )
    COP [82]
    BRA ms_enemy_yeti_0FC8FE
}

code_0FC923 {
    COP [22] ( &code_0FC964 )
    COP [97]
    COP [80] ( #03 )
    COP [82]
    BRA ms_enemy_yeti_0FC8FE
}

code_0FC930 {
    COP [9A] ( #$0000, &code_0FC93A, &code_0FC94B, &code_0FC94B )
}

code_0FC93A {
    COP [AE] ( #$FFF0, #$0000, &code_0FC964 )
    COP [97]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FC95C
}

code_0FC94B {
    COP [AE] ( #$0010, #$0000, &code_0FC964 )
    COP [96]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FC95C

  code_0FC95C:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC96A
}

code_0FC964 {
    COP [1B] ( &code_0FC95C, #$0004 )

  loc_0FC96A:
    COP [9A] ( #$0008, &code_0FC974, &code_0FC98E, &code_0FC981 )
}

code_0FC974 {
    COP [23] ( &code_0FC906 )
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FC95C
}

code_0FC981 {
    COP [24] ( &code_0FC906 )
    COP [96]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FC95C
}

code_0FC98E {
    COP [9B] ( #$0000, &code_0FC998, &code_0FC9AA, &code_0FC9AA )
}

code_0FC998 {
    COP [AE] ( #$0000, #$FFF0, &code_0FC906 )
    COP [97]
    COP [80] ( #07 )
    COP [82]
    BRL ms_enemy_yeti_0FC8FE
}

code_0FC9AA {
    COP [AE] ( #$0000, #$0010, &code_0FC906 )
    COP [97]
    COP [80] ( #06 )
    COP [82]
    BRL ms_enemy_yeti_0FC8FE
}
---------------------------------------------

; Fire Bat (type $30): flaps and shoots fireballs, turning to the hero when he is close.
; 
; When: lair monster (type $30, HP 14); the lairs $CB and $CC.
; Sees: COP A5 picks the starting flap (animation $0F or $10, flipped for two of the four flips). Each cycle: COP AD, then 8 frames of animation $33 with COP 0C (margin 3): if the hero is close the bat faces him (COP 8F, COP 9B: animation $10 or $0F) and the cycle restarts; otherwise animation $11 and a fireball (ms_enemy_fire_bat_fireball_0FCA1F through COP B0 with flags $0200).
; Why: Fire Bat, 'fireballs; moving' in the bestiary.
; In: X = D = slot.
; Out: never returns.
; Clobbers: A.

ms_enemy_fire_bat_0FC9BC {
    COP [A5] ( &code_0FC9C6, &code_0FC9CF, &code_0FC9D6, &code_0FC9DD )
}

code_0FC9C6 {
    COP [96]
    COP [80] ( #0F )
    COP [82]
    BRA loc_0FC9E4
}

code_0FC9CF {
    COP [80] ( #10 )
    COP [82]
    BRA loc_0FC9E4
}

code_0FC9D6 {
    COP [80] ( #0F )
    COP [82]
    BRA loc_0FC9E4
}

code_0FC9DD {
    COP [96]
    COP [80] ( #10 )
    COP [82]

  loc_0FC9E4:
    COP [AD] ( #08 )
    COP [03] ( #08 )
    COP [80] ( #33 )
    COP [82]
    COP [0C] ( #00, #03, &code_0FCA05 )
    COP [04]
    COP [80] ( #11 )
    COP [82]
    COP [B0] ( @ms_enemy_fire_bat_fireball_0FCA1F, #$0200 )
    BRA loc_0FC9E4
}

code_0FCA05 {
    COP [8F]
    COP [9B] ( #$0000, &code_0FCA11, &code_0FCA18, &code_0FCA18 )
}

code_0FCA11 {
    COP [80] ( #10 )
    COP [82]
    BRA loc_0FC9E4
}

code_0FCA18 {
    COP [80] ( #0F )
    COP [82]
    BRA loc_0FC9E4
}

---------------------------------------------
; The fireball of the Fire Bat.
; 
; When: spawned by the bat (COP B0).
; Sees: drawn in front (COP A3), priority $30 (COP A2), sound $64, then Y = $2A and a jump into shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67, the shared projectile code.
; Why: the shared code moves the fireball.
; In: X = D = slot of the new actor.
; Out: RTL into the shared routine.
; Clobbers: A, Y.

ms_enemy_fire_bat_fireball_0FCA1F {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$64
    LDY #$002A
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67-1
    PHA 
    RTL 
}
---------------------------------------------

; The snowball: waits until the hero is near and rolls toward him.
; 
; When: placed directly (type $31, HP 40, EXP 2000); A0BS02 five times and A0CS01 twice.
; Sees: sets bit $0200 of $1A, then COP A5 picks one of four variants by flip state (code_0FCA48, code_0FCAAD, code_0FCB12, code_0FCB77) that differ only in their animation sets ($2F / $14 / $13 / $12, $30 / $17 / $16 / $15, $31 / $1A / $19 / $18, $32 / $1D / $1C / $1B). The first three wait for the hero (COP 0C with margin 5), steer by COP 9C / 9A / 9B and roll at most 5 steps (counter in $2C), stopping at a wall (COP 21 / 22 / 23 / 24); the fourth rolls until a wall and then breaks (code_0FCBD7: animation $1E, COP 86).
; Why: the walkthrough: 'take great care around the snowball', 'dodge the snowballs'.
; In: X = D = slot.
; Out: never returns; the fourth variant ends with RTL.
; Clobbers: A.

ms_enemy_snowball_0FCA35 {
    LDA $001A, X
    ORA #$0200
    STA $001A, X
    COP [A5] ( &code_0FCA48, &code_0FCAAD, &code_0FCB12, &code_0FCB77 )
}

code_0FCA48 {
    LDA #$0005
    STA $002C, X

  loc_0FCA4E:
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FCA5E )

  code_0FCA57:
    COP [80] ( #2F )
    COP [82]
    BRA loc_0FCA4E
}

code_0FCA5E {
    COP [9C] ( &code_0FCA64, &code_0FCA88 )
}

code_0FCA64 {
    COP [9A] ( #$0010, &code_0FCA6E, &code_0FCA79, &code_0FCA79 )
}

code_0FCA6E {
    COP [23] ( &code_0FCA57 )
    COP [80] ( #14 )
    COP [82]
    BRA loc_0FCAA8
}

code_0FCA79 {
    COP [24] ( &code_0FCA57 )
    COP [96]
    COP [80] ( #14 )
    COP [82]
    COP [97]
    BRA loc_0FCAA8
}

code_0FCA88 {
    COP [9B] ( #$0010, &code_0FCA92, &code_0FCA9D, &code_0FCA9D )
}

code_0FCA92 {
    COP [21] ( &code_0FCA57 )
    COP [80] ( #13 )
    COP [82]
    BRA loc_0FCAA8
}

code_0FCA9D {
    COP [22] ( &code_0FCA57 )
    COP [80] ( #12 )
    COP [82]
    BRA loc_0FCAA8

  loc_0FCAA8:
    DEC $002C, X
    BNE loc_0FCA4E
}

code_0FCAAD {
    LDA #$0005
    STA $002C, X

  loc_0FCAB3:
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FCAC3 )

  code_0FCABC:
    COP [80] ( #30 )
    COP [82]
    BRA loc_0FCAB3
}

code_0FCAC3 {
    COP [9C] ( &code_0FCAC9, &code_0FCAED )
}

code_0FCAC9 {
    COP [9A] ( #$0010, &code_0FCAD3, &code_0FCADE, &code_0FCADE )
}

code_0FCAD3 {
    COP [23] ( &code_0FCABC )
    COP [80] ( #17 )
    COP [82]
    BRA loc_0FCB0D
}

code_0FCADE {
    COP [24] ( &code_0FCABC )
    COP [96]
    COP [80] ( #17 )
    COP [82]
    COP [97]
    BRA loc_0FCB0D
}

code_0FCAED {
    COP [9B] ( #$0010, &code_0FCAF7, &code_0FCB02, &code_0FCB02 )
}

code_0FCAF7 {
    COP [21] ( &code_0FCABC )
    COP [80] ( #16 )
    COP [82]
    BRA loc_0FCB0D
}

code_0FCB02 {
    COP [22] ( &code_0FCABC )
    COP [80] ( #15 )
    COP [82]
    BRA loc_0FCB0D

  loc_0FCB0D:
    DEC $002C, X
    BNE loc_0FCAB3
}

code_0FCB12 {
    LDA #$0005
    STA $002C, X

  loc_0FCB18:
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FCB28 )

  code_0FCB21:
    COP [80] ( #31 )
    COP [82]
    BRA loc_0FCB18
}

code_0FCB28 {
    COP [9C] ( &code_0FCB2E, &code_0FCB52 )
}

code_0FCB2E {
    COP [9A] ( #$0010, &code_0FCB38, &code_0FCB43, &code_0FCB43 )
}

code_0FCB38 {
    COP [23] ( &code_0FCB21 )
    COP [80] ( #1A )
    COP [82]
    BRA loc_0FCB72
}

code_0FCB43 {
    COP [24] ( &code_0FCB21 )
    COP [96]
    COP [80] ( #1A )
    COP [82]
    COP [97]
    BRA loc_0FCB72
}

code_0FCB52 {
    COP [9B] ( #$0010, &code_0FCB5C, &code_0FCB67, &code_0FCB67 )
}

code_0FCB5C {
    COP [21] ( &code_0FCB21 )
    COP [80] ( #19 )
    COP [82]
    BRA loc_0FCB72
}

code_0FCB67 {
    COP [22] ( &code_0FCB21 )
    COP [80] ( #18 )
    COP [82]
    BRA loc_0FCB72

  loc_0FCB72:
    DEC $002C, X
    BNE loc_0FCB18
}

code_0FCB77 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FCB87 )
    COP [80] ( #32 )
    COP [82]
    BRA code_0FCB77
}

code_0FCB87 {
    COP [9C] ( &code_0FCB8D, &code_0FCBB1 )
}

code_0FCB8D {
    COP [9A] ( #$0010, &code_0FCB97, &code_0FCBA2, &code_0FCBA2 )
}

code_0FCB97 {
    COP [23] ( &code_0FCBD7 )
    COP [80] ( #1D )
    COP [82]
    BRA loc_0FCBD1
}

code_0FCBA2 {
    COP [24] ( &code_0FCBD7 )
    COP [96]
    COP [80] ( #1D )
    COP [82]
    COP [97]
    BRA loc_0FCBD1
}

code_0FCBB1 {
    COP [9B] ( #$0010, &code_0FCBBB, &code_0FCBC6, &code_0FCBC6 )
}

code_0FCBBB {
    COP [21] ( &code_0FCBD7 )
    COP [80] ( #1C )
    COP [82]
    BRA loc_0FCBD1
}

code_0FCBC6 {
    COP [22] ( &code_0FCBD7 )
    COP [80] ( #1B )
    COP [82]
    BRA loc_0FCBD1

  loc_0FCBD1:
    COP [1B] ( &code_0FCB77, #$0001 )
}

code_0FCBD7 {
    COP [80] ( #1E )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

; Purple Wizard: teleports next to the hero and fires one bolt.
; 
; When: lair monster (type $32, HP 17); the lairs $F6, $F7, $F8, $FC.
; Sees: palette 0 (COP AA). While on screen it tests COP 0C (margin 5) every 16 frames; when the hero is near it vanishes (code_0FCD52). code_0FCBF6 then draws rng_state+1 & 3: 0 puts it 4 tiles ($40 pixels) above the hero (X = hero's, Y - $40 aligned to 16), 1 below, 2 to the right, 3 to the left; a position off the map or on a solid tile (COP 28) aborts to code_0FCD69 (wait $20 frames, retry). It then unhides, plays the appear animation $0A, becomes hittable again, faces the hero, plays the cast animation four times and spawns the bolt for that side (ms_enemy_purple_wizard_bolt_0FCD7A above, _0FCD6F below, _0FCD83 right, _0FCD8E left), then vanishes again.
; Why: the 'Purple Wizard' of the bestiary, 'projectile magic'.
; In: X = D = slot.
; Out: never returns.
; Clobbers: A.

ms_enemy_purple_wizard_0FCBDF {
    COP [AA] ( #00 )

  code_0FCBE2:
    LDA $0016, X
    BIT #$8000            ; bit 15 of $16 = off screen: the near test is skipped
    BNE loc_0FCBF0
    COP [0C] ( #00, #05, &code_0FCD52 ) ; hero inside the box widened by 5: vanish and start the teleport cycle

  loc_0FCBF0:
    COP [1B] ( &code_0FCBE2, #$0010 )

  code_0FCBF6:
    COP [1F]
    LDA $rng_state+1      ; side of the teleport: rng_state+1 & 3 (0 above, 1 below, 2 right, 3 left)
    AND #$0003
    BEQ loc_0FCC0F
    DEC 
    BEQ loc_0FCC5F
    DEC 
    BNE loc_0FCC09
    BRL loc_0FCCB2

  loc_0FCC09:
    DEC 
    BNE loc_0FCC0F
    BRL loc_0FCD04

  loc_0FCC0F:
    LDA $player_x
    STA $0000, X
    LDA $player_y
    SEC 
    SBC #$0040            ; 4 tiles above the hero ($40 pixels); the Red Wizard uses $20
    BPL loc_0FCC21
    BRL code_0FCD69

  loc_0FCC21:
    AND #$FFF0
    STA $0002, X
    COP [28] ( &code_0FCD69 ) ; COP 28: the tile here is occupied: no teleport, wait $20 frames and retry
    LDA $0016, X
    AND #$DFFF            ; clears bit $2000 of $16: shown again
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF            ; clears bit $0200 of $16: hittable again
    STA $0016, X
    COP [80] ( #00 )
    COP [82]
    COP [81] ( #03, #04 )
    COP [83]
    COP [85] ( @ms_enemy_purple_wizard_bolt_0FCD7A )
    COP [80] ( #04 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    BRL code_0FCD52

  loc_0FCC5F:
    LDA $player_x
    STA $0000, X
    LDA $player_y
    CLC 
    ADC #$0040
    CMP $map_height_px
    BCC loc_0FCC74
    BRL code_0FCD69

  loc_0FCC74:
    AND #$FFF0
    STA $0002, X
    COP [28] ( &code_0FCD69 )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #01 )
    COP [82]
    COP [81] ( #05, #04 )
    COP [83]
    COP [85] ( @ms_enemy_purple_wizard_bolt_0FCD6F )
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    BRL code_0FCD52

  loc_0FCCB2:
    LDA $player_x
    CLC 
    ADC #$0040
    CMP $map_width_px
    BCC loc_0FCCC1
    BRL code_0FCD69

  loc_0FCCC1:
    AND #$FFF0
    STA $0000, X
    LDA $player_y
    STA $0002, X
    COP [28] ( &code_0FCD69 )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    COP [81] ( #07, #04 )
    COP [83]
    COP [85] ( @ms_enemy_purple_wizard_bolt_0FCD83 )
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    BRA code_0FCD52

  loc_0FCD04:
    LDA $player_x
    SEC 
    SBC #$0040
    BMI code_0FCD69
    AND #$FFF0
    STA $0000, X
    LDA $player_y
    STA $0002, X
    COP [28] ( &code_0FCD69 )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [96]
    COP [80] ( #02 )
    COP [82]
    COP [81] ( #07, #04 )
    COP [83]
    COP [85] ( @ms_enemy_purple_wizard_bolt_0FCD8E )
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    COP [97]
}

---------------------------------------------
; The wizard vanishes and waits.
; 
; When: the end of every teleport cycle, and the first time the hero comes near.
; Sees: $16 bit $0200 set, animation $09 (disappear), $16 bit $2000 set (hidden), then code_0FCD69: COP 1B resumes at code_0FCBF6 after $20 frames.
; Why: the wizard cannot be hit while he is away.
; In: X = D = slot.
; Out: COP 1B.
; Clobbers: A.

code_0FCD52 {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #09 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
}

code_0FCD69 {
    COP [1B] ( &code_0FCBF6, #$0020 )
}

---------------------------------------------
; Purple Wizard bolt for a wizard standing below the hero.
; 
; When: spawned by the wizard (COP 85).
; Sees: COP A1 shifts it by (+2,-8); the shared tail sets animation $0C (bolts $0B and $0D for the other sides), $16 = $0200, palette 0, draws in front, priority $30, repeat count $10, sound $52, COP 91, COP 83 (the animation runs 16 times), COP 86.
; Why: the bolt is an animated hitbox; its motion is in the animation (not verified).
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_enemy_purple_wizard_bolt_0FCD6F {
    COP [A1] ( #$0002, #$FFF8 )
    LDA #$000C
    BRA loc_0FCD97
}

---------------------------------------------
; Purple Wizard bolt for a wizard standing above the hero.
; 
; When: spawned by the wizard (COP 85).
; Sees: COP 9F adds $FFFF to X, animation $0B, then the shared tail (see ms_enemy_purple_wizard_bolt_0FCD6F).
; Why: see ms_enemy_purple_wizard_bolt_0FCD6F.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_enemy_purple_wizard_bolt_0FCD7A {
    COP [9F] ( #$FFFF )
    LDA #$000B
    BRA loc_0FCD97
}

---------------------------------------------
; Purple Wizard bolt for a wizard standing to the right of the hero.
; 
; When: spawned by the wizard (COP 85).
; Sees: COP A1 shifts it by (-9,-4), animation $0D, then the shared tail.
; Why: see ms_enemy_purple_wizard_bolt_0FCD6F.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_enemy_purple_wizard_bolt_0FCD83 {
    COP [A1] ( #$FFF7, #$FFFC )
    LDA #$000D
    BRA loc_0FCD97
}

---------------------------------------------
; Purple Wizard bolt for a wizard standing to the left of the hero.
; 
; When: spawned by the wizard (COP 85) after COP 96 (flip X).
; Sees: COP A1 shifts it by (+9,-4), animation $0D, then the shared tail.
; Why: see ms_enemy_purple_wizard_bolt_0FCD6F.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_enemy_purple_wizard_bolt_0FCD8E {
    COP [A1] ( #$0009, #$FFFC )
    LDA #$000D

  loc_0FCD97:
    STA $001E, X
    STZ $0020, X
    LDA #$0200
    STA $0016, X
    COP [AA] ( #00 )
    COP [A3]
    COP [A2] ( #30 )
    LDA #$0010
    STA $002A, X
    BRK #$52
    COP [91]
    COP [83]
    COP [86]
    RTL 
}
---------------------------------------------

; Red Wizard: the Purple Wizard's script at 2 tiles with three fireballs.
; 
; When: lair monster (type $33, HP 20); the lairs $D6, $D7, $FF.
; Sees: palette 2 (COP AA). The same cycle as ms_enemy_purple_wizard_0FCBDF (near test with margin 5, code_0FCDD1 picks the side with rng_state+1 & 3, the teleport distance is $20 pixels = 2 tiles, vanish via code_0FCF55 and wait $20 frames via code_0FCF6C) but each side spawns three fireballs: above _0FCF87, _0FCF8E, _0FCF95; below _0FCF72, _0FCF79, _0FCFA3; right _0FCF95, _0FCF9C, _0FCFA3; left _0FCF79, _0FCF80, _0FCF87.
; Why: the 'Red Wizard' of the bestiary, 'fireball magic'.
; In: X = D = slot.
; Out: never returns.
; Clobbers: A.

ms_enemy_red_wizard_0FCDBA {
    COP [AA] ( #02 )

  code_0FCDBD:
    LDA $0016, X
    BIT #$8000
    BNE loc_0FCDCB
    COP [0C] ( #00, #05, &code_0FCF55 )

  loc_0FCDCB:
    COP [1B] ( &code_0FCDBD, #$0010 )

  code_0FCDD1:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FCDEA
    DEC 
    BEQ loc_0FCE44
    DEC 
    BNE loc_0FCDE4
    BRL loc_0FCEA1

  loc_0FCDE4:
    DEC 
    BNE loc_0FCDEA
    BRL loc_0FCEFD

  loc_0FCDEA:
    LDA $player_x
    STA $0000, X
    LDA $player_y
    SEC 
    SBC #$0020
    BPL loc_0FCDFC
    BRL code_0FCF6C

  loc_0FCDFC:
    AND #$FFF0
    STA $0002, X
    COP [28] ( &code_0FCF6C )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #00 )
    COP [82]
    COP [81] ( #03, #04 )
    COP [83]
    COP [85] ( @ms_enemy_red_wizard_fireball_0FCF87 )
    COP [85] ( @ms_enemy_red_wizard_fireball_0FCF8E )
    COP [85] ( @ms_enemy_red_wizard_fireball_0FCF95 )
    COP [80] ( #04 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    BRL code_0FCF55

  loc_0FCE44:
    LDA $player_x
    STA $0000, X
    LDA $player_y
    CLC 
    ADC #$0020
    CMP $map_height_px
    BCC loc_0FCE59
    BRL code_0FCF6C

  loc_0FCE59:
    AND #$FFF0
    STA $0002, X
    COP [28] ( &code_0FCF6C )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #01 )
    COP [82]
    COP [81] ( #05, #04 )
    COP [83]
    COP [85] ( @ms_enemy_red_wizard_fireball_0FCF72 )
    COP [85] ( @ms_enemy_red_wizard_fireball_0FCF79 )
    COP [85] ( @ms_enemy_red_wizard_fireball_0FCFA3 )
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    BRL code_0FCF55

  loc_0FCEA1:
    LDA $player_x
    CLC 
    ADC #$0020
    CMP $map_width_px
    BCC loc_0FCEB0
    BRL code_0FCF6C

  loc_0FCEB0:
    AND #$FFF0
    STA $0000, X
    LDA $player_y
    STA $0002, X
    COP [28] ( &code_0FCF6C )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    COP [81] ( #07, #04 )
    COP [83]
    COP [85] ( @ms_enemy_red_wizard_fireball_0FCF95 )
    COP [85] ( @ms_enemy_red_wizard_fireball_0FCF9C )
    COP [85] ( @ms_enemy_red_wizard_fireball_0FCFA3 )
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    BRA code_0FCF55

  loc_0FCEFD:
    LDA $player_x
    SEC 
    SBC #$0020
    BMI code_0FCF6C
    AND #$FFF0
    STA $0000, X
    LDA $player_y
    STA $0002, X
    COP [28] ( &code_0FCF6C )
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [96]
    COP [80] ( #02 )
    COP [82]
    COP [81] ( #07, #04 )
    COP [83]
    COP [85] ( @ms_enemy_red_wizard_fireball_0FCF79 )
    COP [85] ( @ms_enemy_red_wizard_fireball_0FCF80 )
    COP [85] ( @ms_enemy_red_wizard_fireball_0FCF87 )
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    COP [97]
}

code_0FCF55 {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #09 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
}

code_0FCF6C {
    COP [1B] ( &code_0FCDD1, #$0020 )
}

---------------------------------------------
; Red Wizard fireball (flip X clear, animation $11).
; 
; When: spawned by the Red Wizard (COP 85).
; Sees: sets the animation id, hostile $16 = $0200, palette 0, draw in front, priority $30, repeat count 4, sound $52, COP 91, COP 83 (4 loops), then animation $15 and animation $2F eight times (the burst) and COP 86; the eight fireballs differ only in flip X and animation: $0F72 clear / $11, $0F79 flipped / $14, $0F80 flipped / $12, $0F87 flipped / $13, $0F8E clear / $10, $0F95 clear / $13, $0F9C clear / $12, $0FA3 clear / $14.
; Why: three of them are spawned together, which makes the fan.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_enemy_red_wizard_fireball_0FCF72 {
    COP [97]
    LDA #$0011
    BRA loc_0FCFA8
}

ms_enemy_red_wizard_fireball_0FCF79 {
    COP [96]
    LDA #$0014
    BRA loc_0FCFA8
}

ms_enemy_red_wizard_fireball_0FCF80 {
    COP [96]
    LDA #$0012
    BRA loc_0FCFA8
}

ms_enemy_red_wizard_fireball_0FCF87 {
    COP [96]
    LDA #$0013
    BRA loc_0FCFA8
}

ms_enemy_red_wizard_fireball_0FCF8E {
    COP [97]
    LDA #$0010
    BRA loc_0FCFA8
}

ms_enemy_red_wizard_fireball_0FCF95 {
    COP [97]
    LDA #$0013
    BRA loc_0FCFA8
}

ms_enemy_red_wizard_fireball_0FCF9C {
    COP [97]
    LDA #$0012
    BRA loc_0FCFA8
}

ms_enemy_red_wizard_fireball_0FCFA3 {
    COP [97]
    LDA #$0014

  loc_0FCFA8:
    STA $001E, X
    STZ $0020, X
    LDA #$0200
    STA $0016, X
    COP [AA] ( #00 )
    COP [A3]
    COP [A2] ( #30 )
    LDA #$0004
    STA $002A, X
    BRK #$52
    COP [91]
    COP [83]
    COP [80] ( #15 )
    COP [82]
    COP [81] ( #2F, #08 )
    COP [83]
    COP [86]
    RTL 
}
---------------------------------------------

; Cave Bat: flies toward the hero.
; 
; When: lair monster (type $36, HP 14); the lairs $E6, $E8, $F2, $FA, $FE.
; Sees: drawn in front (COP A3), COP 1B starts it at once; COP AD; then nested COP 9B / 9A tests (threshold 0) pick one of nine relations to the hero, each with a flying animation from $24-$2A and the matching flip (code_0FD129, code_0FD132, ...); after the animation the loop restarts.
; Why: Cave Bat, 'flying around' in the bestiary.
; In: X = D = slot.
; Out: never returns.
; Clobbers: A.

ms_enemy_cave_bat_0FD11B {
    COP [A3]
    COP [1B] ( &code_0FD123, #$0000 )
}

code_0FD123 {
    COP [AD] ( #08 )
    BRL loc_0FD195

  code_0FD129:
    COP [97]
    COP [80] ( #29 )
    COP [82]
    BRA loc_0FD195

  code_0FD132:
    COP [96]
    COP [80] ( #26 )
    COP [82]
    BRA loc_0FD1A9

  code_0FD13B:
    COP [96]
    COP [80] ( #25 )
    COP [82]
    BRA loc_0FD195

  code_0FD144:
    COP [96]
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FD1A9

  code_0FD14D:
    COP [96]
    COP [80] ( #27 )
    COP [82]
    BRA loc_0FD1BD

  code_0FD156:
    COP [96]
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FD1A9

  code_0FD15F:
    COP [97]
    COP [80] ( #28 )
    COP [82]
    BRA loc_0FD1BD

  code_0FD168:
    COP [97]
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FD1D1

  code_0FD171:
    COP [97]
    COP [80] ( #27 )
    COP [82]
    BRA loc_0FD1BD

  code_0FD17A:
    COP [97]
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FD1D1

  code_0FD183:
    COP [97]
    COP [80] ( #25 )
    COP [82]
    BRA loc_0FD195

  code_0FD18C:
    COP [97]
    COP [80] ( #26 )
    COP [82]
    BRA loc_0FD1D1

  loc_0FD195:
    COP [9B] ( #$0000, &code_0FD129, &code_0FD19F, &code_0FD19F )
}

code_0FD19F {
    COP [9A] ( #$0000, &code_0FD18C, &code_0FD132, &code_0FD132 )

  loc_0FD1A9:
    COP [9A] ( #$0000, &code_0FD1B3, &code_0FD1B3, &code_0FD144 )
}

code_0FD1B3 {
    COP [9B] ( #$0000, &code_0FD13B, &code_0FD14D, &code_0FD14D )

  loc_0FD1BD:
    COP [9B] ( #$0000, &code_0FD1C7, &code_0FD1C7, &code_0FD15F )
}

code_0FD1C7 {
    COP [9A] ( #$0000, &code_0FD168, &code_0FD168, &code_0FD156 )

  loc_0FD1D1:
    COP [9A] ( #$0000, &code_0FD17A, &code_0FD1DB, &code_0FD1DB )
}

code_0FD1DB {
    COP [9B] ( #$0000, &code_0FD183, &code_0FD183, &code_0FD171 )
}
---------------------------------------------

; Green Blob: idles until the hero is near, then hops.
; 
; When: lair monster (type $37, HP 12); the lairs $D9, $DD, $E1, $EE, $EF, $F0.
; Sees: COP AD; COP 0C with margin 5: far, animation $2B (idle); near, code_0FD1F5: COP 1F advances the random state; if bit 15 of rng_state+1 is clear the hop direction is random (rng & 3 picks one of the four hops), otherwise it hops toward the hero (COP 9A / 9B). A hop is animation $2C, then $2E (up or down) or $2D (sideways, flipped as needed), then $2C.
; Why: Green Blob, 'bouncing around' in the bestiary.
; In: X = D = slot.
; Out: never returns.
; Clobbers: A.

ms_enemy_green_blob_0FD1E5 {
    COP [AD] ( #08 )
    COP [0C] ( #00, #05, &code_0FD1F5 )
    COP [80] ( #2B )
    COP [82]
    BRA ms_enemy_green_blob_0FD1E5
}

code_0FD1F5 {
    COP [1F]
    LDA $rng_state+1
    BPL loc_0FD21A        ; rng_state+1 positive: random hop; negative: hop toward the hero (9A / 9B)
    COP [9A] ( #$0000, &code_0FD206, &code_0FD210, &code_0FD210 )
}

code_0FD206 {
    COP [9B] ( #$0000, &code_0FD261, &code_0FD24E, &code_0FD24E )
}

code_0FD210 {
    COP [9B] ( #$0000, &code_0FD228, &code_0FD23B, &code_0FD23B )

  loc_0FD21A:
    AND #$0003
    BEQ code_0FD228
    DEC 
    BEQ code_0FD23B
    DEC 
    BEQ code_0FD24E
    DEC 
    BEQ code_0FD261
}

code_0FD228 {
    COP [96]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRA ms_enemy_green_blob_0FD1E5
}

code_0FD23B {
    COP [96]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #2D )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRA ms_enemy_green_blob_0FD1E5
}

code_0FD24E {
    COP [97]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #2D )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRA ms_enemy_green_blob_0FD1E5
}

code_0FD261 {
    COP [97]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #2E )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRL ms_enemy_green_blob_0FD1E5
}