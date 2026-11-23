; The Tin Doll, the boss of the Laboratory Dungeon, with its fireballs, its 'flower' and the meteor rain (file offsets 18009-19437, SNES $00:C659-$CBED, bank 00).
; 
; === ROLE ===
; Meta type $1E, spawned by lair record $12F (RunLairFormation, one monster, lair in location $59 at tile ($16,$17)); it has no placement row. MetaLeosLab: attack $16, defence $0F, HP $59 (89), EXP $0800. The release frees the doll Marie (record +9 names her), who then gives the Purple Stone (ll_npc_marie_purple_stone_0234EC). The script starts the fight like the other bosses: exit_list_ofs = 0, boss_fight_active + 1, boss_actor = X, and spawns engine_003005.RunBossMapPatch with patch id 3 (it blocks the pad while the map changes).
; - DISCREPANCY: the bestiary gives 80 HP (ROM: 89; OQ-I033-1) and Metal = No, but the script sets $1A bit $0400, the class that only the Zantetsu Sword hurts, in its start routine (OQ-I038-2).
; 
; === STATE MACHINE (static reading) ===
; The doll walks in four directions (animations: up $0A / $0B, down $08 / $09, left $06 / $07, right $04 / $05; the second of each pair is used while flag 0 is set). Actor fields: $00 x, $02 y, $25 the current HP byte (the engine's damage routine subtracts from it), $30 the HP at the last re-sync. Each walking state first compares $25 with $30 and, when they differ (the doll was hit), sets flag 0; then it tests contact with the hero (COP 0C, slot 0, margin 2); then COP 9A / 9B (threshold $28) compare the hero's position and either keep the direction or turn (turn animations $0C-$13). The four states are ll_boss_tin_doll_go_top_00477D / go_bottom_0047C4 / go_left_00480B / go_right_004842; at the top row (y = $A0) and the bottom row (y = $1A0) a short turn decision (threshold $20) is made, at the left and right ends (x = $70, x = $160) it leaves (see below).
; CONTACT: the first contact after a teleport (flag 1 clear) is the 'flower' attack: the doll sets flag 1, becomes untouchable ($16 bit $0200) and spawns ll_boss_tin_doll_flower_004B1C above itself (animations $16, $17, $14), which in turn spawns ll_boss_tin_doll_meteor_launcher_004B36: twelve meteors, one every 12 frames, each landing near the hero (ll_boss_tin_doll_meteor_004B63). With flag 1 set a contact is the FIRE attack (ll_boss_tin_doll_fire_*): one fireball in the direction the doll faces (animations $18-$1B), then a 17-frame pause, then a fireball at the hero's side, then back to walking. The four contact_* states and four fire_* states exist once per direction (up, left, right, down).
; LEAVING: at x = $70 or x = $160 the doll sets $16 bits $0300 (cannot hurt, cannot be hit), plays animation $11 or $12, sound BRK #$5F and the sinking animations $22 and $23, waits $3D frames (COP 03 / 04), then reappears at x = $30 (left end) or x = $1A0 (right end) on a random one of five rows (y = $A0, $E0, $120, $160, $1A0; ll_boss_tin_doll_random_row_004AEB), re-syncs $30 with $25, clears flags 0 and 1 and the bits $0300 and walks back in.
; 
; === WALKTHROUGH ===
; docs/walkthrough/06-dr-leos-lab.md: Meteor Rain ('used after possessing a flower'), Fireball ('used when you're close'), Tackle ('the boss moves around a lot'), Flower Possession ('If you accidentally lure the boss near a flower, he'll take control of it'). The script has no reference to a flower of the scene: the 'flower' is the child sprite above the doll (OQ-I038-13).
; 
; === OPEN ===
; What the second animation of each walking pair (flag 0) shows and why the doll re-enters at x = $30 / $1A0 are read from the code, not from the pictures (OQ-I038-4).
---------------------------------------------

?BANK 00

?INCLUDE 'engine_003005'
?INCLUDE 'shared_actor_helpers_bank0'

!rng_state                      0301
!player_x                       0374
!player_y                       0376
!boss_actor                     039A
!exit_list_ofs                  03B2
!boss_fight_active              0458

---------------------------------------------

; The Tin Doll: start of the fight and the walking state loops.
; 
; When: meta type $1E, spawned by lair record $12F; runs every frame.
; Sees: clears exit_list_ofs, boss_fight_active + 1, boss_actor = X, sets $1A bit $0400 (metal class), spawns RunBossMapPatch (COP 85) with patch id 3 and enters ll_boss_tin_doll_go_top_00477D. The walking loops loc_004679 (moving up), loc_0046BF (left), loc_004700 (right) and loc_004741 (down) compare $25 with $30 (flag 0 when they differ), call COP 0C for the contact and turn by COP 9A / 9B (threshold $28).
; Why: the boss is a chaser that turns toward the hero, attacks on contact and leaves the field at its ends.
; In: actor script, X = D = the boss slot.
; Out: loops until it dies (the engine's boss death takes over).
; Clobbers: A, Y.

ll_boss_tin_doll_004659 {
    STZ $exit_list_ofs
    INC $boss_fight_active
    STX $boss_actor
    LDA $001A, X
    ORA #$0400            ; $1A bit $0400: metal class, hurt only by the Zantetsu Sword (the bestiary says Metal = No: OQ-I038-2)
    STA $001A, X
    COP [85] ( @engine_003005.RunBossMapPatch )
    LDA #$0003            ; patch id 3: written to $30 of the RunBossMapPatch actor that COP 85 just spawned (Y)
    STA $0030, Y
    BRL ll_boss_tin_doll_go_top_00477D

  loc_004679:
    LDA $0025, X
    AND #$00FF
    CMP $0030, X          ; $25 is the current HP byte, $30 the HP at the last re-sync: they differ once the doll has been hit
    BEQ loc_004688
    COP [09] ( #$8000 )   ; flag 0 set: the doll was hit since the last re-sync, the walking animations switch to the second of each pair

  loc_004688:
    COP [0C] ( #00, #02, &ll_boss_tin_doll_contact_0046A8 ) ; contact with the hero (slot 0, margin 2): the flower attack first, the fireball after
    COP [9A] ( #$0028, &code_004698, &ll_boss_tin_doll_go_top_00477D, &code_0046A0 )
}

code_004698 {
    COP [80] ( #10 )
    COP [82]
    BRL ll_boss_tin_doll_go_left_00480B
}

code_0046A0 {
    COP [80] ( #0D )
    COP [82]
    BRL ll_boss_tin_doll_go_right_004842
}

---------------------------------------------
; Contact while moving up: the flower attack the first time, the fireball after.
; 
; When: COP 0C in loc_004679 (margin 2 to the hero).
; Sees: flag 1 set: jump to ll_boss_tin_doll_fire_004879. Otherwise animations $10 and $11, flag 1 set and the flower attack (loc_004A01: $0200, animation $16, the flower child at (0,-$10), animations $17 and $14, $0200 cleared), then it walks on in loc_004741.
; Why: see the block note.
; In: X = D = the boss.
; Out: continues in a walking state.
; Clobbers: A, Y.

ll_boss_tin_doll_contact_0046A8 {
    COP [07] ( #$8001, &ll_boss_tin_doll_fire_004879 ) ; flag 1 set: the flower attack has been used since the last teleport, so fire instead
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    COP [09] ( #$8001 )   ; flag 1 set (cleared again at each reappearance)
    BRL loc_004A01

  loc_0046BF:
    LDA $0025, X
    AND #$00FF
    CMP $0030, X
    BEQ loc_0046CE
    COP [09] ( #$8000 )

  loc_0046CE:
    COP [0C] ( #00, #02, &ll_boss_tin_doll_contact_0046EE )
    COP [9B] ( #$0028, &code_0046DE, &ll_boss_tin_doll_go_left_00480B, &code_0046E6 )
}

code_0046DE {
    COP [80] ( #0C )
    COP [82]
    BRL ll_boss_tin_doll_go_top_00477D
}

code_0046E6 {
    COP [80] ( #11 )
    COP [82]
    BRL ll_boss_tin_doll_go_bottom_0047C4
}

---------------------------------------------
; Contact while moving left: as ll_boss_tin_doll_contact_0046A8 (animation $11 before the flower, fire in ll_boss_tin_doll_fire_0048DB).
; 
; When: COP 0C in loc_0046BF.
; Sees: flag 1 set: fire; else animation $11, flag 1, the flower attack.
; Why: see there.
; In: X = D = the boss.
; Out: continues in a walking state.
; Clobbers: A, Y.

ll_boss_tin_doll_contact_0046EE {
    COP [07] ( #$8001, &ll_boss_tin_doll_fire_0048DB )
    COP [80] ( #11 )
    COP [82]
    COP [09] ( #$8001 )
    BRL loc_004A01

  loc_004700:
    LDA $0025, X
    AND #$00FF
    CMP $0030, X
    BEQ loc_00470F
    COP [09] ( #$8000 )

  loc_00470F:
    COP [0C] ( #00, #02, &ll_boss_tin_doll_contact_00472F )
    COP [9B] ( #$0028, &code_00471F, &ll_boss_tin_doll_go_right_004842, &code_004727 )
}

code_00471F {
    COP [80] ( #0F )
    COP [82]
    BRL ll_boss_tin_doll_go_top_00477D
}

code_004727 {
    COP [80] ( #12 )
    COP [82]
    BRL ll_boss_tin_doll_go_bottom_0047C4
}

---------------------------------------------
; Contact while moving right: as ll_boss_tin_doll_contact_0046A8 (animation $12 before the flower, fire in ll_boss_tin_doll_fire_00493D).
; 
; When: COP 0C in loc_004700.
; Sees: flag 1 set: fire; else animation $12, flag 1, the flower attack.
; Why: see there.
; In: X = D = the boss.
; Out: continues in a walking state.
; Clobbers: A, Y.

ll_boss_tin_doll_contact_00472F {
    COP [07] ( #$8001, &ll_boss_tin_doll_fire_00493D )
    COP [80] ( #12 )
    COP [82]
    COP [09] ( #$8001 )
    BRL loc_004A01

  loc_004741:
    LDA $0025, X
    AND #$00FF
    CMP $0030, X
    BEQ loc_004750
    COP [09] ( #$8000 )

  loc_004750:
    COP [0C] ( #00, #02, &ll_boss_tin_doll_contact_004770 )
    COP [9A] ( #$0028, &code_004760, &ll_boss_tin_doll_go_bottom_0047C4, &code_004768 )
}

code_004760 {
    COP [80] ( #13 )
    COP [82]
    BRL ll_boss_tin_doll_go_left_00480B
}

code_004768 {
    COP [80] ( #0E )
    COP [82]
    BRL ll_boss_tin_doll_go_right_004842
}

---------------------------------------------
; Contact while moving down: as ll_boss_tin_doll_contact_0046A8 without a pose (fire in ll_boss_tin_doll_fire_00499F).
; 
; When: COP 0C in loc_004741.
; Sees: flag 1 set: fire; else flag 1 set and the flower attack.
; Why: see there.
; In: X = D = the boss.
; Out: continues in a walking state.
; Clobbers: A, Y.

ll_boss_tin_doll_contact_004770 {
    COP [07] ( #$8001, &ll_boss_tin_doll_fire_00499F )
    COP [09] ( #$8001 )
    BRL loc_004A01
}

---------------------------------------------
; Walking up: steps in animation $0A (flag 0 clear) or $0B until the top row, then a turn decision.
; 
; When: entered from the walking loops and the attack states.
; Sees: at y = $A0 COP 9A (threshold $20) turns left (animation $10, then loc_0046BF), turns around when the hero is in line (animations $10 and $11, then loc_004741 moving down) or turns right (animation $0D, loc_004700); above the top row it plays $0A / $0B with 4 repeats and re-enters loc_004679.
; Why: the doll patrols the border of the room and turns at the top.
; In: X = D = the boss.
; Out: continues in a walking loop.
; Clobbers: A.

ll_boss_tin_doll_go_top_00477D {
    LDA $0002, X
    CMP #$00A0            ; top row of the walk: y = $A0 (the bottom row is $1A0, left end x = $70, right end x = $160)
    BEQ loc_00479D
    COP [07] ( #$8000, &code_004794 )
    COP [81] ( #0A, #04 )
    COP [83]
    BRL loc_004679
}

code_004794 {
    COP [81] ( #0B, #04 )
    COP [83]
    BRL loc_004679

  loc_00479D:
    COP [9A] ( #$0020, &code_0047A7, &code_0047AF, &code_0047BC )
}

code_0047A7 {
    COP [80] ( #10 )
    COP [82]
    BRL loc_0046BF
}

code_0047AF {
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    BRL loc_004741
}

code_0047BC {
    COP [80] ( #0D )
    COP [82]
    BRL loc_004700
}

---------------------------------------------
; Walking down: steps in animation $08 / $09 until the bottom row (y = $1A0), then a turn decision.
; 
; When: entered from the walking loops and the attack states.
; Sees: at y = $1A0 COP 9A (threshold $20) turns left (animation $13, loc_0046BF), turns around when the hero is in line (animations $0E and $0F, then loc_004679 moving up) or turns right (animation $0E, loc_004700); otherwise it plays $08 / $09 with 4 repeats and re-enters loc_004741.
; Why: see ll_boss_tin_doll_go_top_00477D.
; In: X = D = the boss.
; Out: continues in a walking loop.
; Clobbers: A.

ll_boss_tin_doll_go_bottom_0047C4 {
    LDA $0002, X
    CMP #$01A0
    BEQ loc_0047E4
    COP [07] ( #$8000, &code_0047DB )
    COP [81] ( #08, #04 )
    COP [83]
    BRL loc_004741
}

code_0047DB {
    COP [81] ( #09, #04 )
    COP [83]
    BRL loc_004741

  loc_0047E4:
    COP [9A] ( #$0020, &code_0047EE, &code_0047F6, &code_004803 )
}

code_0047EE {
    COP [80] ( #13 )
    COP [82]
    BRL loc_0046BF
}

code_0047F6 {
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #0F )
    COP [82]
    BRL loc_004679
}

code_004803 {
    COP [80] ( #0E )
    COP [82]
    BRL loc_004700
}

---------------------------------------------
; Walking left: steps in animation $06 / $07; at x = $70 the doll leaves the field.
; 
; When: entered from the walking loops and the fire states.
; Sees: at x = $70 it sets $16 bits $0300, plays $07 with 4 repeats and goes to loc_004A31 (animation $11, sound BRK #$5F, the sinking animations $22 and $23, a wait of $3D frames, then the reappearance in loc_004A67 at x = $30 on a random row, walking right); before that it plays $06 / $07 and re-enters loc_0046BF.
; Why: the doll vanishes and returns from the side of the field.
; In: X = D = the boss.
; Out: continues in a walking loop.
; Clobbers: A.

ll_boss_tin_doll_go_left_00480B {
    COP [07] ( #$8000, &code_004821 )
    LDA $0000, X
    CMP #$0070
    BEQ loc_004830
    COP [80] ( #06 )
    COP [82]
    BRL loc_0046BF
}

code_004821 {
    LDA $0000, X
    CMP #$0070
    BEQ loc_004830
    COP [80] ( #07 )
    COP [82]
    BRA code_004821

  loc_004830:
    LDA $0016, X
    ORA #$0300            ; $0300: cannot hurt and cannot be hit while the doll leaves the field
    STA $0016, X
    COP [81] ( #07, #04 )
    COP [83]
    BRL loc_004A31
}

---------------------------------------------
; Walking right: steps in animation $04 / $05; at x = $160 the doll leaves the field.
; 
; When: entered from the walking loops and the fire states.
; Sees: at x = $160 it sets $16 bits $0300, plays $05 with 4 repeats and goes to loc_004A4C (animation $12, sound BRK #$5F, the sinking animations, a wait of $3D frames, then loc_004AA9: the reappearance at x = $1A0 on a random row, walking left).
; Why: see ll_boss_tin_doll_go_left_00480B.
; In: X = D = the boss.
; Out: continues in a walking loop.
; Clobbers: A.

ll_boss_tin_doll_go_right_004842 {
    COP [07] ( #$8000, &code_004858 )
    LDA $0000, X
    CMP #$0160
    BEQ loc_004867
    COP [80] ( #04 )
    COP [82]
    BRL loc_004700
}

code_004858 {
    LDA $0000, X
    CMP #$0160
    BEQ loc_004867
    COP [80] ( #05 )
    COP [82]
    BRA code_004858

  loc_004867:
    LDA $0016, X
    ORA #$0300
    STA $0016, X
    COP [81] ( #05, #04 )
    COP [83]
    BRL loc_004A4C
}

---------------------------------------------
; The fire attack while facing up.
; 
; When: contact with flag 1 set, moving up.
; Sees: animation $1A, a fireball at (8,-$20) (ll_boss_tin_doll_fireball_004BAB), a 17-frame pause (COP 03 / 04), then COP 9A (threshold $20): hero to the left: animations $10 and $19 and a fireball at (-2,-$20), then go_left; in line: animation $1A and another up fireball, then go_top; to the right: animations $0D and $18 and a fireball at ($12,-$20), then go_right.
; Why: the fireball follows the hero's side.
; In: X = D = the boss.
; Out: continues in a walking state.
; Clobbers: A, Y.

ll_boss_tin_doll_fire_004879 {
    COP [80] ( #1A )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BAB, #$0008, #$FFE0, #$0200 )
    COP [03] ( #11 )
    COP [04]
    COP [9A] ( #$0020, &code_004898, &code_0048B0, &code_0048C3 )
}

code_004898 {
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #19 )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BC1, #$FFFE, #$FFE0, #$0200 )
    BRL ll_boss_tin_doll_go_left_00480B
}

code_0048B0 {
    COP [80] ( #1A )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BAB, #$0008, #$FFE0, #$0200 )
    BRL ll_boss_tin_doll_go_top_00477D
}

code_0048C3 {
    COP [80] ( #0D )
    COP [82]
    COP [80] ( #18 )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BB6, #$0012, #$FFE0, #$0200 )
    BRL ll_boss_tin_doll_go_right_004842
}

---------------------------------------------
; The fire attack while facing left.
; 
; When: contact with flag 1 set, moving left.
; Sees: animation $19, a fireball at (-2,-$20) (ll_boss_tin_doll_fireball_004BC1), a 17-frame pause, then COP 9B (threshold $20): hero above: animations $0C and $1A and an up fireball, go_top; in line: animation $19 and a left fireball, go_left; below: animations $12 and $1B and a down fireball at (8,-$1E), go_bottom.
; Why: see ll_boss_tin_doll_fire_004879.
; In: X = D = the boss.
; Out: continues in a walking state.
; Clobbers: A, Y.

ll_boss_tin_doll_fire_0048DB {
    COP [80] ( #19 )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BC1, #$FFFE, #$FFE0, #$0200 )
    COP [03] ( #11 )
    COP [04]
    COP [9B] ( #$0020, &code_0048FA, &code_004912, &code_004925 )
}

code_0048FA {
    COP [80] ( #0C )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BAB, #$0008, #$FFE0, #$0200 )
    BRL ll_boss_tin_doll_go_top_00477D
}

code_004912 {
    COP [80] ( #19 )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BC1, #$FFFE, #$FFE0, #$0200 )
    BRL ll_boss_tin_doll_go_left_00480B
}

code_004925 {
    COP [80] ( #12 )
    COP [82]
    COP [80] ( #1B )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BCC, #$0008, #$FFE2, #$0200 )
    BRL ll_boss_tin_doll_go_bottom_0047C4
}

---------------------------------------------
; The fire attack while facing right.
; 
; When: contact with flag 1 set, moving right.
; Sees: animation $18, a fireball at ($12,-$20) (ll_boss_tin_doll_fireball_004BB6), a 17-frame pause, then COP 9B (threshold $20): hero above: animations $0F and $1A and an up fireball, go_top; in line: animation $18 and a right fireball, go_right; below: animations $12 and $1B and a down fireball, go_bottom.
; Why: see ll_boss_tin_doll_fire_004879.
; In: X = D = the boss.
; Out: continues in a walking state.
; Clobbers: A, Y.

ll_boss_tin_doll_fire_00493D {
    COP [80] ( #18 )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BB6, #$0012, #$FFE0, #$0200 )
    COP [03] ( #11 )
    COP [04]
    COP [9B] ( #$0020, &code_00495C, &code_004974, &code_004987 )
}

code_00495C {
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BAB, #$0008, #$FFE0, #$0200 )
    BRL ll_boss_tin_doll_go_top_00477D
}

code_004974 {
    COP [80] ( #18 )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BB6, #$0012, #$FFE0, #$0200 )
    BRL ll_boss_tin_doll_go_right_004842
}

code_004987 {
    COP [80] ( #12 )
    COP [82]
    COP [80] ( #1B )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BCC, #$0008, #$FFE2, #$0200 )
    BRL ll_boss_tin_doll_go_bottom_0047C4
}

---------------------------------------------
; The fire attack while facing down.
; 
; When: contact with flag 1 set, moving down.
; Sees: animation $1B, a fireball at (8,-$1E) (ll_boss_tin_doll_fireball_004BCC), a 17-frame pause, then COP 9A (threshold $20): hero to the left: animations $13 and $19 and a left fireball, go_left; in line: animation $1B and a down fireball, go_bottom; to the right: animations $0E and $18 and a right fireball, go_right.
; Why: see ll_boss_tin_doll_fire_004879.
; In: X = D = the boss.
; Out: continues in a walking state.
; Clobbers: A, Y.

ll_boss_tin_doll_fire_00499F {
    COP [80] ( #1B )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BCC, #$0008, #$FFE2, #$0200 )
    COP [03] ( #11 )
    COP [04]
    COP [9A] ( #$0020, &code_0049BE, &code_0049D6, &code_0049E9 )
}

code_0049BE {
    COP [80] ( #13 )
    COP [82]
    COP [80] ( #19 )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BC1, #$FFFE, #$FFE0, #$0200 )
    BRL ll_boss_tin_doll_go_left_00480B
}

code_0049D6 {
    COP [80] ( #1B )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BCC, #$0008, #$FFE2, #$0200 )
    BRL ll_boss_tin_doll_go_bottom_0047C4
}

code_0049E9 {
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #18 )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_fireball_004BB6, #$0012, #$FFE0, #$0200 )
    BRL ll_boss_tin_doll_go_right_004842

  loc_004A01:
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #16 )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_flower_004B1C, #$0000, #$FFF0, #$0200 )
    COP [80] ( #17 )
    COP [82]
    COP [81] ( #14, #02 )
    COP [83]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    BRL loc_004741

  loc_004A31:
    COP [80] ( #11 )
    COP [82]
    BRK #$5F
    COP [81] ( #22, #10 )
    COP [83]
    COP [81] ( #23, #08 )
    COP [83]
    COP [03] ( #3D )      ; stays out of sight for $3D frames
    COP [04]
    BRL loc_004A67

  loc_004A4C:
    COP [80] ( #12 )
    COP [82]
    BRK #$5F
    COP [81] ( #22, #10 )
    COP [83]
    COP [81] ( #23, #08 )
    COP [83]
    COP [03] ( #3D )
    COP [04]
    BRL loc_004AA9

  loc_004A67:
    JSR $&ll_boss_tin_doll_random_row_004AEB
    STA $0002, X
    LDA #$0030            ; reappears at x = $30 (the right-hand case uses $01A0 at 19119)
    STA $0000, X
    BRK #$5F
    COP [81] ( #23, #08 )
    COP [83]
    COP [81] ( #22, #10 )
    COP [83]
    LDA $0025, X
    AND #$00FF
    STA $0030, X          ; re-sync: $30 = the current HP, so flag 0 stays clear until the next hit
    COP [09] ( #$0000 )
    COP [09] ( #$0001 )
    LDA $0016, X
    AND #$FCFF            ; clears the $0300 bits: hurts and can be hit again
    STA $0016, X
    COP [80] ( #0E )
    COP [82]
    COP [81] ( #04, #04 )
    COP [83]
    BRL loc_004700

  loc_004AA9:
    JSR $&ll_boss_tin_doll_random_row_004AEB
    STA $0002, X
    LDA #$01A0
    STA $0000, X
    BRK #$5F
    COP [81] ( #23, #08 )
    COP [83]
    COP [81] ( #22, #10 )
    COP [83]
    LDA $0025, X
    AND #$00FF
    STA $0030, X
    COP [09] ( #$0000 )
    COP [09] ( #$0001 )
    LDA $0016, X
    AND #$FCFF
    STA $0016, X
    COP [80] ( #13 )
    COP [82]
    COP [81] ( #06, #04 )
    COP [83]
    BRL loc_0046BF
}

---------------------------------------------
; Picks the row of the reappearance.
; 
; When: JSR from loc_004A67 and loc_004AA9 after the doll has sunk.
; Sees: advances the random generator (COP 1F), takes the high byte of rng_state + 1 and subtracts $33 up to four times: below $33 gives y = $A0, below $66 $E0, below $99 $120, below $CC $160, otherwise $1A0.
; Why: five equally likely rows (a band of $33 of the 256 values each).
; In: X = D = the boss.
; Out: A = the new y.
; Clobbers: A, Y.

ll_boss_tin_doll_random_row_004AEB {
    COP [1F]
    LDA $rng_state+1
    AND #$00FF
    LDY #$00A0
    SEC 
    SBC #$0033            ; five bands of $33 over the random byte: rows $A0, $E0, $120, $160, $1A0
    BMI loc_004B1A
    LDY #$00E0
    SEC 
    SBC #$0033
    BMI loc_004B1A
    LDY #$0120
    SEC 
    SBC #$0033
    BMI loc_004B1A
    LDY #$0160
    SEC 
    SBC #$0033
    BMI loc_004B1A
    LDY #$01A0

  loc_004B1A:
    TYA 
    RTS 
}

---------------------------------------------
; The 'flower' that the doll spawns above itself: animation $20, the meteor launcher, animation $21 and gone.
; 
; When: spawned by the flower attack (loc_004A01) at (0,-$10) with flags $0200.
; Sees: COP A3 (in front), animation $20, the launcher at (8,-8) with flags $0300, animation $21, COP 86.
; Why: the walkthrough's 'flower possession'; the script has no real flower of the scene (OQ-I038-13).
; In: X = D = the child.
; Out: RTL after the kill.
; Clobbers: A, Y (the child).

ll_boss_tin_doll_flower_004B1C {
    COP [A3]
    COP [80] ( #20 )
    COP [82]
    COP [B2] ( @ll_boss_tin_doll_meteor_launcher_004B36, #$0008, #$FFF8, #$0300 )
    COP [80] ( #21 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; The meteor rain: it rises off the screen and drops twelve meteors.
; 
; When: spawned by ll_boss_tin_doll_flower_004B1C.
; Sees: sound BRK #$61, animation $1C, animation $1D repeated until its y is negative (it moves up off the top), animation $1D, then COP 03 (#$0C): sound BRK #$52, COP B0 for a meteor, a delay of $0C frames (COP 1B), COP 04 for the next of 12; then COP 86.
; Why: 'Meteor Rain' of the walkthrough: twelve meteors, one every 12 frames.
; In: X = D = the launcher.
; Out: RTL after the kill.
; Clobbers: A, Y (the meteors).

ll_boss_tin_doll_meteor_launcher_004B36 {
    BRK #$61
    COP [80] ( #1C )
    COP [82]

  loc_004B3D:
    COP [80] ( #1D )
    COP [82]
    LDA $0002, X
    BPL loc_004B3D        ; loops while y is non-negative: the launcher rises until it is off the top of the screen
    COP [80] ( #1D )
    COP [82]
    COP [03] ( #0C )      ; twelve meteors (loop count), one every $0C frames
    BRK #$52
    COP [B0] ( @ll_boss_tin_doll_meteor_004B63, #$0300 )
    COP [1B] ( &code_004B5E, #$000C )
}

code_004B5E {
    COP [04]
    COP [86]
    RTL 
}

---------------------------------------------
; One meteor: appears above a random spot near the hero and falls.
; 
; When: spawned by ll_boss_tin_doll_meteor_launcher_004B36 (COP B0).
; Sees: x = the hero's x + a random value in [-$40,$3F], y = the hero's y - $FF + a random value in [-$40,$3F] (two COP 1F draws), animation $1E repeated $10 times (the fall), flags $0200 (hurts, cannot be hit), sound BRK #$5A, COP A4 (behind), shifted by (-8,-8), animation $1F (the impact), COP 86.
; Why: random meteors that cannot be killed ('dodge randomly').
; In: X = D = the meteor.
; Out: RTL after the kill.
; Clobbers: A.

ll_boss_tin_doll_meteor_004B63 {
    COP [1F]
    LDA $rng_state+1
    AND #$007F
    SEC 
    SBC #$0040
    CLC 
    ADC $player_x         ; x = the hero's x plus a random value in [-$40,$3F]
    STA $0000, X
    COP [1F]
    LDA $rng_state+1
    AND #$007F
    SEC 
    SBC #$0040
    CLC 
    ADC $player_y
    SEC 
    SBC #$00FF            ; y = the hero's y - $FF plus a random value: the meteor starts far above the screen
    STA $0002, X
    COP [81] ( #1E, #10 )
    COP [83]
    LDA #$0200
    STA $0016, X
    BRK #$5A
    COP [A4]
    COP [A1] ( #$FFF8, #$FFF8 )
    COP [80] ( #1F )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; The fireball thrown up.
; 
; When: spawned by the fire states at (8,-$20) with flags $0200.
; Sees: sound BRK #$5D, COP 97, animation $02, then loc_004BD7: COP A3, animation $03 with 3 repeats, Y = 3 and a tail jump into the shared projectile body shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67.
; Why: the four fireballs differ only in flip and animation ($02 up, $00 left or right, $01 down).
; In: X = D = the fireball.
; Out: the shared body flies it and kills it.
; Clobbers: A, Y.

ll_boss_tin_doll_fireball_004BAB {
    BRK #$5D
    COP [97]
    COP [80] ( #02 )
    COP [82]
    BRA loc_004BD7
}

---------------------------------------------
; The fireball thrown to the right: as ll_boss_tin_doll_fireball_004BAB with COP 96 (flip set) and animation $00.
; 
; When: spawned by the fire states at ($12,-$20), flags $0200.
; Sees: sound BRK #$5D, COP 96, animation $00, then the shared end.
; Why: see there.
; In: X = D = the fireball.
; Out: the shared body flies it and kills it.
; Clobbers: A, Y.

ll_boss_tin_doll_fireball_004BB6 {
    BRK #$5D
    COP [96]
    COP [80] ( #00 )
    COP [82]
    BRA loc_004BD7
}

---------------------------------------------
; The fireball thrown to the left: as ll_boss_tin_doll_fireball_004BAB with animation $00 and the flip cleared.
; 
; When: spawned by the fire states at (-2,-$20), flags $0200.
; Sees: sound BRK #$5D, COP 97, animation $00, then the shared end.
; Why: see there.
; In: X = D = the fireball.
; Out: the shared body flies it and kills it.
; Clobbers: A, Y.

ll_boss_tin_doll_fireball_004BC1 {
    BRK #$5D
    COP [97]
    COP [80] ( #00 )
    COP [82]
    BRA loc_004BD7
}

---------------------------------------------
; The fireball thrown down: as ll_boss_tin_doll_fireball_004BAB with animation $01 and COP A3 first.
; 
; When: spawned by the fire states at (8,-$1E), flags $0200.
; Sees: sound BRK #$5D, COP A3, COP 97, animation $01, then the shared end.
; Why: see there.
; In: X = D = the fireball.
; Out: the shared body flies it and kills it.
; Clobbers: A, Y.

ll_boss_tin_doll_fireball_004BCC {
    BRK #$5D
    COP [A3]
    COP [97]
    COP [80] ( #01 )
    COP [82]

  loc_004BD7:
    COP [A3]
    COP [81] ( #03, #03 )
    COP [83]
    LDY #$0003            ; Y = 3: the animation id handed to the shared projectile body cm_enemy_aimed_shot_body_002D67 (tail jump below)
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67-1
    PHA 
    RTL 
}