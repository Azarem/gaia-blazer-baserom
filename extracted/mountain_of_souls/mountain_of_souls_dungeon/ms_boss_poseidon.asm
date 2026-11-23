; The Poseidon boss fight of the Mountain of Souls (file offsets 17049-18008, SNES $00:C299-$C658): the boss script, his projectiles and splash effects.
; 
; === WHAT RUNS HERE ===
; Meta type $38 of MetaMountainOfSouls (attack 16, defence 12, HP 79, EXP $0400 = 400; the monster of lair record $103 in the room A0BS07, location $44). The script is a loop of rounds; its own $30 counts the rounds left (2 at the start and after each full cycle).
; - Setup: exit_list_ofs is cleared, boss_fight_active is incremented, boss_actor = X, COP 9F adds 8 to X, and engine_003005.RunBossMapPatch is spawned with patch id 2 (written to its $30).
; - One round: Poseidon is submerged ($16 |= $0300: not hittable) and three rise splashes (ms_boss_poseidon_rise_splash_004528) are spawned 21 frames apart; ms_boss_poseidon_spray_spawner_0045F5 sprays water; he surfaces (animation $0A, $0300 cleared). A random side (bit 15 of rng_state+1: clear = left, set = right) gets the triple fireball (ms_boss_poseidon_fireball_triple_004497, two more fireballs spawned by the first) and a spear thrust (ms_boss_poseidon_spear_left_004487 / _right_00448F). A second random side gets another spear thrust, then the pair of homing fireballs (ms_boss_poseidon_fireball_homing_004532 and _004546); he dives ($0300 set again), sprays and plays animation $08 or $09.
; - End of round: when $30 is 1 the round is the last one: he turns toward the room's side (flip by his x >= $F0), four dive splashes follow and animation $15 plays; then $30 is reset to 2 and the cycle restarts. Otherwise a random flip, four dive splashes, animation $14, DEC $30 and the next round.
; - The walkthrough (chapter 5) lists the attacks in order: 'Triple fireball', 'Spear thrust (may do twice)' and 'Double fireball; one or both of these will home in on you'; the script has exactly those, in that order (the fireball and the first spear on one random side, the second spear on another random side, then the homing pair).
; 
; === OPEN ===
; ROM HP 79, the bestiary says 70: OQ-I033-1 (existing). The right-hand triple fireball is spawned with flags $0300 where the left-hand one uses $0200 (the hidden bit $0100 of $16 would make it not count as a hit source): OQ-I037-13. The death of Poseidon (HP 0) and the release of the King (lair $103) are handled by the engine, not by this script; no code here ends the fight.
---------------------------------------------

?BANK 00

?INCLUDE 'engine_003005'

!rng_state                      0301
!boss_actor                     039A
!exit_list_ofs                  03B2
!random_mod_result              0437
!boss_fight_active              0458

---------------------------------------------

; Poseidon: the boss loop (setup, rounds of splash, spray, fireballs, spears, homing fireballs and dives).
; 
; When: placement script of the monster of lair record $103 (type $38, HP 79) in A0BS07.
; Sees: setup (exit_list_ofs = 0, boss_fight_active++, boss_actor = X, X + 8, RunBossMapPatch with patch id 2, own $30 = 2). Round at loc_0042B7: submerge ($16 |= $0300), three rise splashes with 21 frames between, the spray spawner, animation $0A and surface; side by rng_state+1: left (animation $01, triple fireball at (-$16,+$0D), 31 frames, animations $0D, $05, spear_left at (-$13,+$10), animation $06) or right (animation $00, triple fireball at (+$15,+$0F), 31 frames, animations $0B, $02, spear_right at (+$12,+$10), animation $03); second random side: another spear, animation $0E or $0C, $16 |= $0200, two homing fireballs at (-$1C,-$33) or (+$1B,-$33), 41 frames, $16 |= $0300, the spray spawner, animation $08 or $09. loc_004417: $30 = 1 goes to the last round (loc_004455: flip by x >= $F0, four dive splashes, animation $15, BRL loc_0042B1 resets $30 to 2); otherwise random flip, four dive splashes (COP AF with flags $0300), animation $14, DEC $30 and BRL loc_0042B7.
; Why: the walkthrough's three attacks, one after the other, while he alternates between the surface and the water.
; In: X = D = slot of the boss.
; Out: never returns.
; Clobbers: A, Y.

ms_boss_poseidon_004299 {
    STZ $exit_list_ofs
    INC $boss_fight_active
    STX $boss_actor
    COP [9F] ( #$0008 )   ; adds 8 to the actor's X
    COP [85] ( @engine_003005.RunBossMapPatch ) ; spawns the boss map patch actor; its $30 = 2 is the patch id
    LDA #$0002
    STA $0030, Y

  loc_0042B1:
    LDA #$0002            ; own $30 = rounds left in the cycle; reset to 2 here after the last round
    STA $0030, X

  loc_0042B7:
    COP [97]
    LDA $0016, X
    ORA #$0300            ; $0300 = not hittable and not a hit source: Poseidon is under water
    STA $0016, X
    COP [B2] ( @ms_boss_poseidon_rise_splash_004528, #$0010, #$FFF0, #$0300 )
    COP [03] ( #15 )
    COP [04]
    COP [B2] ( @ms_boss_poseidon_rise_splash_004528, #$0008, #$FFFA, #$0300 )
    COP [03] ( #15 )
    COP [04]
    COP [B2] ( @ms_boss_poseidon_rise_splash_004528, #$0014, #$FFF6, #$0300 )
    COP [03] ( #15 )
    COP [04]
    COP [85] ( @ms_boss_poseidon_spray_spawner_0045F5 )
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FCFF
    STA $0016, X
    COP [1F]
    LDA $rng_state+1
    BMI loc_00433D        ; bit 15 of rng_state+1: set = right side, clear = left
    COP [80] ( #01 )
    COP [82]
    COP [B2] ( @ms_boss_poseidon_fireball_triple_004497, #$FFEA, #$000D, #$0200 )
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #0D )
    COP [82]
    COP [80] ( #05 )
    COP [82]
    COP [B2] ( @ms_boss_poseidon_spear_left_004487, #$FFED, #$0010, #$0200 )
    COP [80] ( #06 )
    COP [82]
    BRA loc_00436C

  loc_00433D:
    COP [80] ( #00 )
    COP [82]
    COP [B2] ( @ms_boss_poseidon_fireball_triple_004497, #$0015, #$000F, #$0300 )
    COP [03] ( #1F )
    COP [04]
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    COP [B2] ( @ms_boss_poseidon_spear_right_00448F, #$0012, #$0010, #$0200 )
    COP [80] ( #03 )
    COP [82]

  loc_00436C:
    COP [1F]
    LDA $rng_state+1
    BMI loc_0043C6
    COP [80] ( #05 )
    COP [82]
    COP [B2] ( @ms_boss_poseidon_spear_left_004487, #$FFED, #$0010, #$0200 )
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #0E )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @ms_boss_poseidon_fireball_homing_004532, #$FFE4, #$FFCD, #$0200 ) ; two homing fireballs at the same offset; they steer apart by the hero's position
    COP [B2] ( @ms_boss_poseidon_fireball_homing_004546, #$FFE4, #$FFCD, #$0200 )
    COP [03] ( #29 )
    COP [04]
    LDA $0016, X
    ORA #$0300
    STA $0016, X
    COP [85] ( @ms_boss_poseidon_spray_spawner_0045F5 )
    COP [80] ( #08 )
    COP [82]
    BRA loc_004417

  loc_0043C6:
    COP [80] ( #02 )
    COP [82]
    COP [B2] ( @ms_boss_poseidon_spear_right_00448F, #$0012, #$0010, #$0200 )
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #0C )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @ms_boss_poseidon_fireball_homing_004532, #$001B, #$FFCD, #$0200 )
    COP [B2] ( @ms_boss_poseidon_fireball_homing_004546, #$001B, #$FFCD, #$0200 )
    COP [03] ( #29 )
    COP [04]
    LDA $0016, X
    ORA #$0300
    STA $0016, X
    COP [85] ( @ms_boss_poseidon_spray_spawner_0045F5 )
    COP [80] ( #09 )
    COP [82]

  loc_004417:
    LDA $0030, X
    CMP #$0001            ; the last round of the cycle when $30 = 1
    BEQ loc_004455
    COP [1F]
    LDA $rng_state+1
    BMI loc_00442A
    COP [97]
    BRA loc_00442C

  loc_00442A:
    COP [96]

  loc_00442C:
    COP [AF] ( @ms_boss_poseidon_dive_splash_0044D3, #$0300 )
    COP [AF] ( @ms_boss_poseidon_dive_splash_0044D3, #$0300 )
    COP [AF] ( @ms_boss_poseidon_dive_splash_0044D3, #$0300 )
    COP [AF] ( @ms_boss_poseidon_dive_splash_0044FF, #$0300 )
    COP [80] ( #14 )
    COP [82]
    DEC $0030, X
    BEQ loc_004455
    BRL loc_0042B7

  loc_004455:
    LDA $0000, X
    CMP #$00F0            ; boss x >= $F0: flip X set for the final dive
    BCS loc_004461
    COP [97]
    BRA loc_004463

  loc_004461:
    COP [96]

  loc_004463:
    COP [AF] ( @ms_boss_poseidon_dive_splash_0044D3, #$0300 )
    COP [AF] ( @ms_boss_poseidon_dive_splash_0044D3, #$0300 )
    COP [AF] ( @ms_boss_poseidon_dive_splash_0044D3, #$0300 )
    COP [AF] ( @ms_boss_poseidon_dive_splash_0044FF, #$0300 )
    COP [80] ( #15 )
    COP [82]
    BRL loc_0042B1
}

---------------------------------------------
; The spear thrust to the left.
; 
; When: spawned by the boss (COP B2 with flags $0200).
; Sees: animation $07 and COP 86; the thrust is the animation.
; Why: a hostile hitbox ($0200) lasting one animation.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_boss_poseidon_spear_left_004487 {
    COP [80] ( #07 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; The spear thrust to the right.
; 
; When: spawned by the boss (COP B2 with flags $0200).
; Sees: animation $04 and COP 86.
; Why: see ms_boss_poseidon_spear_left_004487.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_boss_poseidon_spear_right_00448F {
    COP [80] ( #04 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; The triple fireball: this actor plus two siblings.
; 
; When: spawned by the boss (COP B2).
; Sees: drawn in front (COP A3), animation $16 for 6 repeats, sound $4B, then it spawns ms_boss_poseidon_fireball_side_flipped_0044BF and ms_boss_poseidon_fireball_side_0044C1 (COP B0 with flags $0200); it plays animation $12 until it is off screen ($16 bit 15) and dies.
; Why: the walkthrough's three fireballs: the middle one is this actor, the two sides are the siblings.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_boss_poseidon_fireball_triple_004497 {
    COP [A3]
    COP [81] ( #16, #06 )
    COP [83]
    BRK #$4B
    COP [B0] ( @ms_boss_poseidon_fireball_side_flipped_0044BF, #$0200 )
    COP [B0] ( @ms_boss_poseidon_fireball_side_0044C1, #$0200 )

  loc_0044AF:
    COP [80] ( #12 )
    COP [82]
    LDA $0016, X
    BIT #$8000
    BEQ loc_0044AF
    COP [86]
    RTL 
}

---------------------------------------------
; Side fireball with flip X set (falls into ms_boss_poseidon_fireball_side_0044C1).
; 
; When: spawned by the triple fireball.
; Sees: COP 96 (flip X), then the code of the unflipped sibling.
; Why: the two sides fly in mirrored directions.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_boss_poseidon_fireball_side_flipped_0044BF {
    COP [96]
}

---------------------------------------------
; Side fireball.
; 
; When: spawned by the triple fireball.
; Sees: drawn in front (COP A3), animation $13 until it is off screen ($16 bit 15 set), then COP 86.
; Why: see ms_boss_poseidon_fireball_triple_004497.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_boss_poseidon_fireball_side_0044C1 {
    COP [A3]

  loc_0044C3:
    COP [80] ( #13 )
    COP [82]
    LDA $0016, X
    BIT #$8000
    BEQ loc_0044C3
    COP [86]
    RTL 
}

---------------------------------------------
; Splash that follows the boss while he dives.
; 
; When: spawned (COP AF, flags $0300) four times before each dive animation.
; Sees: drawn behind (COP A4), animation $1D, COP 91; each frame: while the boss animation (boss_actor +$1E) is $14 or $15 the splash copies the position of the actor whose slot is in its own +$3E (presumably its spawner, the boss); otherwise it kills itself (COP 86).
; Why: the splash stays on the boss for the length of the dive animation.
; In: X = D = slot of the splash.
; Out: RTL.
; Clobbers: A, Y.

ms_boss_poseidon_dive_splash_0044D3 {
    COP [A4]
    COP [80] ( #1D )
    COP [82]
    COP [91]
    LDY $boss_actor
    LDA $001E, Y
    CMP #$0014
    BEQ loc_0044EC
    CMP #$0015
    BNE loc_0044FC

  loc_0044EC:
    LDY $003E, X
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    RTL 

  loc_0044FC:
    COP [86]
    RTL 
}

---------------------------------------------
; The fourth splash of a dive: the same as ms_boss_poseidon_dive_splash_0044D3.
; 
; When: spawned (COP AF, flags $0300) after three splashes of the 0044D3 kind.
; Sees: it follows boss_actor directly instead of the actor linked at +$3E.
; Why: see ms_boss_poseidon_dive_splash_0044D3.
; In: X = D = slot of the splash.
; Out: RTL.
; Clobbers: A, Y.

ms_boss_poseidon_dive_splash_0044FF {
    COP [A4]
    COP [80] ( #1D )
    COP [82]
    COP [91]
    LDY $boss_actor
    LDA $001E, Y
    CMP #$0014
    BEQ loc_004518
    CMP #$0015
    BNE loc_004525

  loc_004518:
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    RTL 

  loc_004525:
    COP [86]
    RTL 
}

---------------------------------------------
; Splash that marks the rise of the boss.
; 
; When: spawned three times at the start of a round (COP B2, flags $0300).
; Sees: drawn in front (COP A3), animation $0F, COP 86.
; Why: the three splashes at different offsets hide the surfacing.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_boss_poseidon_rise_splash_004528 {
    COP [A3]
    COP [80] ( #0F )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Homing fireball, first of the pair.
; 
; When: spawned by the boss after the second spear (COP B2, flags $0200).
; Sees: drawn in front, animation $16 for 6 repeats, sound $4B, flip X cleared, animation $19 for 2 repeats, then loc_00455D: COP 9B (threshold $20) tests the hero's y. More than $20 away vertically, code_004588 tests x with COP 9A (threshold $18): far in x, animation $19 and the test again; within $18 in x, animations $1A and $18 (10 repeats) and COP 86 (a vertical strike). Within $20 vertically, COP 9A (threshold 0) plays animation $1B (hero to the left) or $1C with flip X (right), then animation $17 for $2A repeats and COP 86 (a horizontal strike).
; Why: the animation is chosen by the hero's position while the fireball flies, so it homes toward him; the motion itself is in the animations (not verified).
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_boss_poseidon_fireball_homing_004532 {
    COP [A3]
    COP [81] ( #16, #06 )
    COP [83]
    BRK #$4B
    COP [97]
    COP [81] ( #19, #02 )
    COP [83]
    BRA loc_00455B
}

---------------------------------------------
; Homing fireball, second of the pair: the same as ms_boss_poseidon_fireball_homing_004532 with flip X set at the start and the mirrored branch (loc_0045A8).
; 
; When: spawned by the boss right after the first one (COP B2, flags $0200).
; Sees: COP 96 instead of COP 97 at the start and the mirrored branch loc_0045AA (animation $1C then COP 97 for a hero to the left, $1B otherwise; the vertical test is the same).
; Why: the pair flies to both sides.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_boss_poseidon_fireball_homing_004546 {
    COP [A3]
    COP [81] ( #16, #06 )
    COP [83]
    BRK #$4B
    COP [96]
    COP [81] ( #19, #02 )
    COP [83]
    BRL loc_0045A8

  loc_00455B:
    COP [97]

  loc_00455D:
    COP [9B] ( #$0020, &code_004588, &code_004567, &code_004588 )
}

code_004567 {
    COP [9A] ( #$0000, &code_004571, &code_004578, &code_004578 )
}

code_004571 {
    COP [80] ( #1B )
    COP [82]
    BRA loc_00457F
}

code_004578 {
    COP [80] ( #1C )
    COP [82]
    COP [96]

  loc_00457F:
    COP [81] ( #17, #2A )
    COP [83]
    COP [86]
    RTL 
}

code_004588 {
    COP [9A] ( #$0018, &code_0045A0, &code_004592, &code_0045A0 )
}

code_004592 {
    COP [80] ( #1A )
    COP [82]
    COP [81] ( #18, #0A )
    COP [83]
    COP [86]
    RTL 
}

code_0045A0 {
    COP [80] ( #19 )
    COP [82]
    BRL loc_00455D

  loc_0045A8:
    COP [96]

  loc_0045AA:
    COP [9B] ( #$0020, &code_0045D5, &code_0045B4, &code_0045D5 )
}

code_0045B4 {
    COP [9A] ( #$0000, &code_0045BE, &code_0045C7, &code_0045C7 )
}

code_0045BE {
    COP [80] ( #1C )
    COP [82]
    COP [97]
    BRA loc_0045CC
}

code_0045C7 {
    COP [80] ( #1B )
    COP [82]

  loc_0045CC:
    COP [81] ( #17, #2A )
    COP [83]
    COP [86]
    RTL 
}

code_0045D5 {
    COP [9A] ( #$0018, &code_0045ED, &code_0045DF, &code_0045ED )
}

code_0045DF {
    COP [80] ( #1A )
    COP [82]
    COP [81] ( #18, #0A )
    COP [83]
    COP [86]
    RTL 
}

code_0045ED {
    COP [80] ( #19 )
    COP [82]
    BRL loc_0045AA
}

---------------------------------------------
; Spawner of the water spray.
; 
; When: spawned (COP 85) at the start of a round and before each dive.
; Sees: a loop of 16 rounds (COP 03 #10 / COP 04): spawns spray A (COP B0, flags $0300), COP 1B 2 frames later spray B, 2 frames later the next round; then COP 86.
; Why: 32 sprays in about 64 frames.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

ms_boss_poseidon_spray_spawner_0045F5 {
    COP [03] ( #10 )
    COP [B0] ( @ms_boss_poseidon_spray_a_004617, #$0300 )
    COP [1B] ( &code_004605, #$0002 )
}

code_004605 {
    COP [B0] ( @ms_boss_poseidon_spray_b_004622, #$0300 )
    COP [1B] ( &code_004612, #$0002 )
}

code_004612 {
    COP [04]
    COP [86]
    RTL 
}

---------------------------------------------
; Water spray, kind A.
; 
; When: spawned by the spray spawner.
; Sees: JSR ms_boss_poseidon_random_near_boss_00462D (random position near the boss, drawn in front), animation $10, COP 86.
; Why: scenery of the splashing.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A, Y.

ms_boss_poseidon_spray_a_004617 {
    JSR $&ms_boss_poseidon_random_near_boss_00462D
    COP [80] ( #10 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Water spray, kind B: the same with animation $11.
; 
; When: spawned by the spray spawner.
; Sees: random position near the boss, animation $11, COP 86.
; Why: see ms_boss_poseidon_spray_a_004617.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A, Y.

ms_boss_poseidon_spray_b_004622 {
    JSR $&ms_boss_poseidon_random_near_boss_00462D
    COP [80] ( #11 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Subroutine: puts the actor at a random position near the boss.
; 
; When: JSR from both spray actors.
; Sees: x = the boss's x + (random modulo $20) - 8, y = the boss's y + (random modulo $10) - $C (COP 1F, COP 35 and random_mod_result), then COP A3 (draw in front).
; Why: the sprays scatter over the boss.
; In: X = the spray, boss_actor read; M = 16.
; Out: RTS.
; Clobbers: A, Y.

ms_boss_poseidon_random_near_boss_00462D {
    LDY $boss_actor
    COP [1F]
    COP [35] ( #20 )
    LDA $random_mod_result
    SEC 
    SBC #$0008
    CLC 
    ADC $0000, Y
    STA $0000, X
    COP [1F]
    COP [35] ( #10 )
    LDA $random_mod_result
    SEC 
    SBC #$000C
    CLC 
    ADC $0002, Y
    STA $0002, X
    COP [A3]
    RTS 
}