; Deathtoll: the Mage, the hand-over between the two forms, the Demon and the ending curtain (file offsets 19851-21331 and 21958-22011, SNES $00:CD8B-$00:D353 and $00:D5C6-$00:D5FB, bank 00; RunEnding and its texts of engine_spawn_lairs_death_drops lie between the two ranges). Scenes A15S01 (location $7C, the building where the Mage is met) and A15S02 (location $7D, the final battle). Walkthrough chapter: docs/walkthrough/08-world-of-evil.md ('The Final Clash!', 'FINAL BOSS, PART ONE - Deathtoll the Mage', 'FINAL BOSS, PART TWO - Deathtoll the Demon').
; 
; === PLACEMENT AND STATS (walkthrough against ROM) ===
; - A15S01 (PlacementA15S01): hero row ($07,$03); row ;01 type $09 (the Mage) at tile ($07,$05), flags $01; row ;02 type $13 (the hand-over actor, meta flags $2050 = hidden) at the same tile.
; - A15S02 (PlacementA15S02): row ;01 type $08 (the BG2 band effect, we_fx_battle_bg2_hofs_bands), row ;02 type $11 (the Demon) at tile ($07,$04). The walkthrough's RAM address of the Demon's HP, $7E08A5, is slot $02 ($0880) + $25, the HP byte of an actor slot, so it is this actor.
; - MetaWorldOfEvil: $09 attack $1A, defence $15, HP $63 (99), EXP 0, flags $0200 (cannot be hit at first); $11 attack $1C, defence $FF, HP $64 (100), EXP 0, flags $0201; $13 flags $2050. The walkthrough gives 'Maximum HP: 100 HP' for each form (200 in enemy-bestiary.md) and 0 EXP: the Mage is 99 in the ROM (DISCREPANCY, OQ-I033-1 refined by OQ-I040-2). The Demon's defence $FF fits 'Each Phoenix will only do 1 ~ 2 points of damage'.
; - There is no lair record for Deathtoll: both forms are placed and both set boss_actor ($039A).
; 
; === THE MAGE (we_boss_deathtoll_mage_004D8B, A15S01) ===
; 1. Waiting: boss_actor = the Mage, $1A bit $0200 set (special immunity class: only the Soul Blade hurts it, like the Wall Tile), x + 8, COP 91; each frame it returns until the hero's y is below $80 (he has walked up into the room).
; 2. Start: RunBossMapPatch is spawned with patch id 4 (OQ-I024-3: whether it closes or opens the room), 4 frames pass, then we_boss_deathtoll_mage_intro_004DBA: pad blocked ($2FC0), sound request $A0, animation 1, map_height_px = $0100, the speech 'The poor creature that repeats transmigration of the soul and cannot die- I will put you in a deep sleep-', pad released, $16 bit $0200 cleared (it can be hit), music track $0D.
; 3. Cycle: animation 4 (it vanishes), a random x (random 0-$9F + $28) and y = $60, animation 1 (it appears, $0200 cleared), animation 2, sound $4B, three orbs spawned at (0,-$12) with flags $0200 (we_boss_deathtoll_mage_orb_a, _b and _c), animation 3, 80 frames of waiting, $0200 set again, animation 4 and round again.
; 4. Orbs: A and B are mirror images (B starts with flip X set); each steers with COP 9A / 9B (threshold $20 in x then y; the speed is in the animation data, the script has no numbers) and ends with a long straight run (animation $06 then $0A for 16 repeats) and COP 86. C steers y first, then x (threshold 0), and ends with animation $07 then $0B for 8 repeats. The walkthrough: 'Magic Orbs - ... The orb with the dark center will move the fastest and the farthest away from Deathtoll while the other two move in opposing directions, somewhat slower. They will home in on your location'. Which orb is the dark one is inferred, C being the one that differs (OQ-I040-4).
; 5. Death: RunBossDeath sets $16 = $0700 on the Mage. we_boss_deathtoll_mage_handover_004F4D sees bit $0400 and takes over boss_actor, so RunBossDeath ends the Mage through FinishEnemyDeath without KillAllOtherActors and without RunEnding (CPX $boss_actor). The hand-over actor then copies the Mage's position, waits 180 frames, becomes visible, spawns the Mage's last speech ('Some people believe being constantly reincarnated means everlasting suffering- Being alive is suffering for some creatures- You will find out what I mean-'), a warp effect actor and COP 10 to A15S02 at pixel ($0078,$00C8). The same trick is used by the greenwood statues.
; 
; === THE DEMON (we_boss_deathtoll_demon_005043, A15S02) ===
; Set-up: boss_actor = the Demon, $1A bit $0200, $0466 = 0, the curtain actor (we_fx_ending_tm_curtain_0055C6), then four actors at fixed positions with flags $0200: the side pieces (animations $11 at ($38,$70) and $10 at ($B8,$70)) and the two scepters (we_boss_deathtoll_demon_scepter_left at ($38,$40) and _right at ($B8,$40)). After 61 frames the wave loop starts:
; 1. Four fire pillars (we_boss_deathtoll_demon_fire_pillar_005101) are spawned 40 frames apart with flags $0301. Each picks a random spot (x $20-$BF, y $B0-$CD), starts with its HP byte (+$25) at $FF, rises (animation $16, then $0300 cleared) and is destroyed once the byte is below $FC (4 or more points of damage); then it adds 1 to the low byte of event_flags, drops a 5-Gem pickup (we_boss_deathtoll_demon_pillar_gem_005170) and ends. The walkthrough: 'Fire Pillars - These must be taken down before Deathtoll can be hurt; a few Phoenixes will work' (Phoenix 1-2 damage each) and 'gather the Gems they drop'.
; 2. The Demon polls the counter every frame (loc_00508A); at 4 it zeroes it, plays animation $14, clears $16 bit $0200 (it can be hit), animation $12, spawns a flame burst (we_boss_deathtoll_demon_flame_burst_0051B6), animation $13, spawns three fireballs at (8,16) with flags $0200 (the walkthrough's 'Flamethrower - After being actually hurt, Deathtoll will fire three fireballs from his mouth'), sets $0200 again, plays animation $15 and starts the next wave.
; 3. The scepters run on their own all fight: each charges (animation $0E x14), fires (animation $0D, sound $4B) one head piece and, after 2 frames, three tail pieces 3 frames apart. The head moves 8 px down and 8 px sideways per step toward the side of the hero (COP 9A, re-tested every step) and records the direction in an event flag ($1906 for the left scepter, $1907 for the right: set = left); the tail pieces read the flag and follow. Because the left scepter is at the left edge and the right one at the right edge the lines cross, as in the walkthrough ('Scepter Lasers - They will criss-cross around the field').
; 
; === SHARED WORDS ===
; boss_actor ($039A); $0466 (0 in the fight; RunEnding increments it, the curtain actor then hides BG1 in the upper 143 lines: 'The World of Evil began to disappear'; the word is also used by gv_front_end, OQ-I034-16 and OQ-I040-3); the low byte of event_flags ($1A5E, the scene flags 0-7 of A15S02) is the pillar counter; flag $0000 of A15S01 is the end of the Mage's speech; flags $1906 and $1907 are the laser directions.
; 
; === OPEN ===
; Sound requests $A0, $4B, $51 and $5D, the side pieces' role, the exact damage window of the Demon (the length of animations $12 and $13), whether the orbs aim at the hero's position when fired or follow him (the script re-tests every step) and the map patch (OQ-I024-3) are open (OQ-I040-4, OQ-I040-7, OQ-I040-11).
---------------------------------------------

?BANK 00

?INCLUDE 'engine_player_death_and_actor_helpers'
?INCLUDE 'lib_system_helpers'

!joy_block_mask                 0326
!map_height_px                  0344
!scene_sprite_attr              0372
!boss_actor                     039A
!player_actor                   039C
!random_mod_result              0437
!event_flags                    1A5E

---------------------------------------------

; Deathtoll the Mage: set-up and the wait for the hero.
; 
; When: placement script (meta type $09, row ;01 of A15S01, slot $01).
; Sees: boss_actor = the Mage, $1A bit $0200 set (special immunity), COP 9F + 8, COP 91; returns every frame while the hero's y is $80 or more. When it is below $80: COP 85 spawns RunBossMapPatch, patch id 4 is written into its $30 (Y), COP 1B waits 4 frames and continues in we_boss_deathtoll_mage_intro_004DBA.
; Why: the walkthrough: the building to the west of the Dazzling Space; part one of the final boss.
; In: X = D = slot $01 (the COP entrance state).
; Out: boss_actor; a map patch actor is spawned.
; Clobbers: A, Y.

we_boss_deathtoll_mage_004D8B {
    STX $boss_actor
    LDA $001A, X
    ORA #$0200            ; $1A bit $0200: special immunity class (only the Soul Blade hurts it, as for the Wall Tile)
    STA $001A, X
    COP [9F] ( #$0008 )
    COP [91]
    LDY $player_actor
    LDA $0002, Y
    CMP #$0080            ; the fight starts when the hero's y is below $80, i.e. he has walked up into the room
    BCC loc_004DA9
    RTL 

  loc_004DA9:
    COP [85] ( @engine_player_death_and_actor_helpers.RunBossMapPatch )
    LDA #$0004            ; patch id 4 (OQ-I024-3: whether the patch closes or opens the room)
    STA $0030, Y
    COP [1B] ( &we_boss_deathtoll_mage_intro_004DBA, #$0004 )
}

---------------------------------------------
; The Mage's entrance and speech, then the first round.
; 
; When: 4 frames after the map patch (COP 1B).
; Sees: pad blocked ($2FC0 in joy_block_mask), sound request $A0, animation 1, map_height_px = $0100, the speech 'The poor creature that repeats transmigration of the soul and cannot die- I will put you in a deep sleep-', pad released, $16 bit $0200 cleared (it can be hit), COP 32 with track $0D, then it jumps into the vanish step of the cycle (loc_004E44).
; Why: 'Deathtoll the Mage' speaks before the fight starts.
; In: X = D = slot $01.
; Out: the cycle: vanish (animation 4), reappear at a random x with y = $60 (animations 1 and 2, sound $4B), three orbs, animation 3, 80 frames of waiting, then we_boss_deathtoll_mage_hide_004E3B.
; Clobbers: A, Y.

we_boss_deathtoll_mage_intro_004DBA {
    LDA #$2FC0
    TSB $joy_block_mask
    BRK #$A0              ; sound request $A0 (OQ-I040-7)
    COP [80] ( #01 )
    COP [82]
    LDA #$0100
    STA $map_height_px    ; map_height_px = $0100: the room's height limit becomes 256 px
    COP [01] ( &asciistring_004EF8 )
    LDA #$2FC0
    TRB $joy_block_mask
    LDA $0016, X
    AND #$FDFF            ; clears $16 bit $0200: the Mage can be hit from now on
    STA $0016, X
    COP [32] ( #0D )      ; music track $0D (the track the airship dock plays for the intruders)
    BRA loc_004E44

  loc_004DE5:
    COP [1F]
    COP [35] ( #A0 )
    LDA $random_mod_result
    CLC 
    ADC #$0028
    STA $0000, X
    LDA #$0060
    STA $0002, X
    COP [80] ( #01 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    BRK #$4B
    COP [B2] ( @we_boss_deathtoll_mage_orb_a_004E4B, #$0000, #$FFEE, #$0200 )
    COP [B2] ( @we_boss_deathtoll_mage_orb_b_004E8A, #$0000, #$FFEE, #$0200 )
    COP [B2] ( @we_boss_deathtoll_mage_orb_c_004EC9, #$0000, #$FFEE, #$0200 )
    COP [80] ( #03 )
    COP [82]
    COP [1B] ( &we_boss_deathtoll_mage_hide_004E3B, #$0050 )
}

---------------------------------------------
; End of a round: the Mage becomes unhittable and vanishes.
; 
; When: 80 frames after the three orbs were spawned.
; Sees: $16 bit $0200 set, then animation 4 (the vanish step loc_004E44) and the next round (loc_004DE5).
; Why: the Mage can only be hit while he is out of his vanish step.
; In: X = D = slot $01.
; Out: loops for ever (the script never returns; it ends through RunBossDeath).
; Clobbers: A.

we_boss_deathtoll_mage_hide_004E3B {
    LDA $0016, X
    ORA #$0200
    STA $0016, X

  loc_004E44:
    COP [80] ( #04 )
    COP [82]
    BRA loc_004DE5
}

---------------------------------------------
; Magic orb A (one of the three).
; 
; When: spawned by the Mage (COP B2 at (0,-$12), flags $0200).
; Sees: COP A3 (draw in front), COP 97 (clear flip X), COP 90 (flip Y from the hero's y) and COP 88 (inverted); then COP 9A with threshold $20: hero at least $20 px left: animation $0A and test again; otherwise we_boss_deathtoll_mage_orb_a_y_check_004E64.
; Why: the walkthrough: 'Magic Orbs ... They will home in on your location'; the movement itself is in the animation data.
; In: X = D = the orb.
; Out: ends in we_boss_deathtoll_mage_orb_a_finish_004E7A.
; Clobbers: A.

we_boss_deathtoll_mage_orb_a_004E4B {
    COP [A3]
    COP [97]
    COP [90]
    COP [88]

  loc_004E53:
    COP [9A] ( #$0020, &we_boss_deathtoll_mage_orb_a_x_loop_004E5D, &we_boss_deathtoll_mage_orb_a_y_check_004E64, &we_boss_deathtoll_mage_orb_a_y_check_004E64 ) ; hero at least $20 px left: animation $0A and test again; otherwise the y check
}

---------------------------------------------
; Orb A, first leg: animation $0A (moving) while the hero is at least $20 px to its left, then the test is repeated.
; 
; When: first target of the COP 9A of we_boss_deathtoll_mage_orb_a_004E4B.
; Sees: animation $0A, then BRA to the test.
; Why: the orb flies until it is level with the hero in x.
; In: X = D = the orb.
; Out: back to the test.
; Clobbers: A.

we_boss_deathtoll_mage_orb_a_x_loop_004E5D {
    COP [80] ( #0A )
    COP [82]
    BRA loc_004E53
}

---------------------------------------------
; Orb A, second leg: animation 5, then the same test on y.
; 
; When: the hero is no longer $20 px or more to the left.
; Sees: animation 5, COP 9B (threshold $20): within $20 px in y: we_boss_deathtoll_mage_orb_a_finish_004E7A; otherwise we_boss_deathtoll_mage_orb_a_y_loop_004E73.
; In: X = D = the orb.
; Out: see above.
; Clobbers: A.

we_boss_deathtoll_mage_orb_a_y_check_004E64 {
    COP [80] ( #05 )
    COP [82]

  loc_004E69:
    COP [9B] ( #$0020, &we_boss_deathtoll_mage_orb_a_y_loop_004E73, &we_boss_deathtoll_mage_orb_a_finish_004E7A, &we_boss_deathtoll_mage_orb_a_y_loop_004E73 )
}

---------------------------------------------
; Orb A, vertical leg: animation 9, then the y test again.
; 
; When: the hero is at least $20 px above or below the orb.
; Sees: animation 9, BRA to the COP 9B test.
; In: X = D = the orb.
; Out: back to the y test.
; Clobbers: A.

we_boss_deathtoll_mage_orb_a_y_loop_004E73 {
    COP [80] ( #09 )
    COP [82]
    BRA loc_004E69
}

---------------------------------------------
; Orb A's last run and end.
; 
; When: the orb is within $20 px of the hero's y.
; Sees: COP 96 (set flip X), animation 6, animation $0A for 16 repeats, COP 86.
; Why: the orb flies on past the hero and ends.
; In: X = D = the orb.
; Out: RTL after the kill.
; Clobbers: A.

we_boss_deathtoll_mage_orb_a_finish_004E7A {
    COP [96]
    COP [80] ( #06 )
    COP [82]
    COP [81] ( #0A, #10 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; Magic orb B: the mirror of orb A.
; 
; When: spawned by the Mage (COP B2 at (0,-$12), flags $0200).
; Sees: COP A3, COP 96 (set flip X), COP 90, COP 88, then COP 9A with threshold $20: hero at least $20 px RIGHT (third target): animation $0A and test again; otherwise we_boss_deathtoll_mage_orb_b_y_check_004EA3.
; Why: the second of the 'opposing directions' of the walkthrough.
; In: X = D = the orb.
; Out: ends in we_boss_deathtoll_mage_orb_b_finish_004EB9.
; Clobbers: A.

we_boss_deathtoll_mage_orb_b_004E8A {
    COP [A3]
    COP [96]
    COP [90]
    COP [88]

  loc_004E92:
    COP [9A] ( #$0020, &we_boss_deathtoll_mage_orb_b_y_check_004EA3, &we_boss_deathtoll_mage_orb_b_y_check_004EA3, &we_boss_deathtoll_mage_orb_b_x_loop_004E9C )
}

---------------------------------------------
; Orb B, first leg: animation $0A while the hero is at least $20 px to its right, then the test is repeated.
; 
; When: third target of the COP 9A of we_boss_deathtoll_mage_orb_b_004E8A.
; Sees: animation $0A, BRA to the test.
; In: X = D = the orb.
; Out: back to the test.
; Clobbers: A.

we_boss_deathtoll_mage_orb_b_x_loop_004E9C {
    COP [80] ( #0A )
    COP [82]
    BRA loc_004E92
}

---------------------------------------------
; Orb B, second leg: animation 5, then the y test (as orb A).
; 
; When: the hero is no longer $20 px or more to the right.
; Sees: animation 5, COP 9B (threshold $20): within: we_boss_deathtoll_mage_orb_b_finish_004EB9; else we_boss_deathtoll_mage_orb_b_y_loop_004EB2.
; In: X = D = the orb.
; Out: see above.
; Clobbers: A.

we_boss_deathtoll_mage_orb_b_y_check_004EA3 {
    COP [80] ( #05 )
    COP [82]

  loc_004EA8:
    COP [9B] ( #$0020, &we_boss_deathtoll_mage_orb_b_y_loop_004EB2, &we_boss_deathtoll_mage_orb_b_finish_004EB9, &we_boss_deathtoll_mage_orb_b_y_loop_004EB2 )
}

---------------------------------------------
; Orb B, vertical leg: animation 9, then the y test again.
; 
; When: the hero is at least $20 px above or below the orb.
; Sees: animation 9, BRA to the COP 9B test.
; In: X = D = the orb.
; Out: back to the y test.
; Clobbers: A.

we_boss_deathtoll_mage_orb_b_y_loop_004EB2 {
    COP [80] ( #09 )
    COP [82]
    BRA loc_004EA8
}

---------------------------------------------
; Orb B's last run and end.
; 
; When: the orb is within $20 px of the hero's y.
; Sees: COP 97 (clear flip X), animation 6, animation $0A for 16 repeats, COP 86.
; In: X = D = the orb.
; Out: RTL after the kill.
; Clobbers: A.

we_boss_deathtoll_mage_orb_b_finish_004EB9 {
    COP [97]
    COP [80] ( #06 )
    COP [82]
    COP [81] ( #0A, #10 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; Magic orb C: the one that differs (y first, then x).
; 
; When: spawned by the Mage (COP B2 at (0,-$12), flags $0200).
; Sees: COP A3, COP 97, then COP 9B with threshold $20: hero at least $20 px below (third target): we_boss_deathtoll_mage_orb_c_y_loop_004ED7 (animation 8, test again); otherwise we_boss_deathtoll_mage_orb_c_x_check_004EDE.
; Why: probably the walkthrough's 'orb with the dark center' (OQ-I040-4).
; In: X = D = the orb.
; Out: ends in we_boss_deathtoll_mage_orb_c_finish_004EEA.
; Clobbers: A.

we_boss_deathtoll_mage_orb_c_004EC9 {
    COP [A3]
    COP [97]

  loc_004ECD:
    COP [9B] ( #$0020, &we_boss_deathtoll_mage_orb_c_x_check_004EDE, &we_boss_deathtoll_mage_orb_c_x_check_004EDE, &we_boss_deathtoll_mage_orb_c_y_loop_004ED7 ) ; hero at least $20 px below: animation 8 and test again; otherwise the x check
}

---------------------------------------------
; Orb C, first leg: animation 8 while the hero is at least $20 px below, then the test is repeated.
; 
; When: third target of the COP 9B of we_boss_deathtoll_mage_orb_c_004EC9.
; Sees: animation 8, BRA to the test.
; In: X = D = the orb.
; Out: back to the test.
; Clobbers: A.

we_boss_deathtoll_mage_orb_c_y_loop_004ED7 {
    COP [80] ( #08 )
    COP [82]
    BRA loc_004ECD
}

---------------------------------------------
; Orb C, second step: choose the side by the hero's x.
; 
; When: the hero is no longer $20 px or more below.
; Sees: COP 9A with threshold 0: hero left or within: we_boss_deathtoll_mage_orb_c_finish_004EEA (no flip); hero right: we_boss_deathtoll_mage_orb_c_flip_x_004EE8.
; In: X = D = the orb.
; Out: see above.
; Clobbers: A.

we_boss_deathtoll_mage_orb_c_x_check_004EDE {
    COP [9A] ( #$0000, &we_boss_deathtoll_mage_orb_c_finish_004EEA, &we_boss_deathtoll_mage_orb_c_finish_004EEA, &we_boss_deathtoll_mage_orb_c_flip_x_004EE8 )
}

---------------------------------------------
; Orb C: sets flip X (hero on the right), then falls into the finish.
; 
; When: third target of the COP 9A of we_boss_deathtoll_mage_orb_c_x_check_004EDE.
; Sees: COP 96.
; In: X = D = the orb.
; Out: falls through.
; Clobbers: none.

we_boss_deathtoll_mage_orb_c_flip_x_004EE8 {
    COP [96]
}

---------------------------------------------
; Orb C's last run and end.
; 
; When: after the x check.
; Sees: animation 7, animation $0B for 8 repeats, COP 86.
; In: X = D = the orb.
; Out: RTL after the kill.
; Clobbers: A.

we_boss_deathtoll_mage_orb_c_finish_004EEA {
    COP [80] ( #07 )
    COP [82]
    COP [81] ( #0B, #08 )
    COP [83]
    COP [86]
    RTL 
}

asciistring_004EF8 |[10]The poor creature that[N]repeats transmigration[N]of the soul and cannot[N]die- [FIN]I will put you in [N]a deep sleep- [12][08:408][END]|
---------------------------------------------

; The hand-over actor between the two forms: waits for the Mage's death.
; 
; When: placement script (meta type $13, row ;02 of A15S01, slot $02, flags $2050).
; Sees: every frame it reads $16 of boss_actor (the Mage); while bit $0400 is clear it returns. When RunBossDeath has set it: boss_actor = this actor (so RunBossDeath ends the Mage without the ending and the clean-up), the Mage's x and y are copied, COP 1B waits 180 frames and the script continues in we_boss_deathtoll_mage_handover_speech_004F6E.
; Why: the second form lives in another scene; this actor carries the fight across. The greenwood statues use the same trick.
; In: X = D = slot $02.
; Out: boss_actor changed.
; Clobbers: A, Y.

we_boss_deathtoll_mage_handover_004F4D {
    LDY $boss_actor
    LDA $0016, Y
    BIT #$0400            ; $16 bit $0400 of the Mage: set by RunBossDeath (the Mage is dying)
    BNE loc_004F59
    RTL 

  loc_004F59:
    STX $boss_actor       ; takes over boss_actor: RunBossDeath then skips the clean-up and RunEnding for the Mage (CPX $boss_actor)
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    COP [1B] ( &we_boss_deathtoll_mage_handover_speech_004F6E, #$00B4 )
}

---------------------------------------------
; The hand-over actor appears, the Mage speaks and the scene changes.
; 
; When: 180 frames after the Mage's death.
; Sees: $16 bit $2000 cleared (visible), COP 85 spawns the speech actor (we_boss_deathtoll_mage_speech_004F9E), then animation $1F is played in a loop (we_boss_deathtoll_mage_handover_wait_speech_004F7C) until flag $0000 is set (COP 08 jumps while it is clear); COP 85 spawns the warp effect, animation $1F for 3 repeats, COP 10 to A15S02 at pixel ($0078,$00C8), COP 91.
; Why: Deathtoll's last words as the Mage; then part two begins.
; In: X = D = slot $02.
; Out: the scene change.
; Clobbers: A, Y.

we_boss_deathtoll_mage_handover_speech_004F6E {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [85] ( @we_boss_deathtoll_mage_speech_004F9E )

; The wait loop of the hand-over actor: animation $1F until the speech is finished.
; 
; When: after the speech actor was spawned.
; Sees: animation $1F, wait, COP 08 on flag $0000: jumps back while the flag is clear.
; In: X = D = slot $02.
; Out: continues when the speech actor has set flag $0000.
; Clobbers: A.

  we_boss_deathtoll_mage_handover_wait_speech_004F7C:
    COP [80] ( #1F )
    COP [82]
    COP [08] ( #$8000, &we_boss_deathtoll_mage_handover_wait_speech_004F7C ) ; COP 08 jumps while flag $0000 is clear: the loop plays animation $1F until the speech ends
    COP [85] ( @we_fx_deathtoll_mage_warp_effect_004FA9 )
    COP [81] ( #1F, #03 )
    COP [83]
    COP [10] ( #$0215, #01, #$0078, #$00C8 ) ; scene change to A15S02 (the final battle) at pixel ($0078,$00C8)
    COP [91]
    RTL 
}

---------------------------------------------
; The Mage's last speech (a helper actor).
; 
; When: spawned (COP 85) by the hand-over actor.
; Sees: COP 01 with the speech 'Some people believe being constantly reincarnated means everlasting suffering- Being alive is suffering for some creatures- You will find out what I mean-', then COP 09 sets flag $0000, COP 86.
; Why: the text runs in its own actor so the hand-over actor can keep animating.
; In: X = D = the helper.
; Out: flag $0000 set.
; Clobbers: A.

we_boss_deathtoll_mage_speech_004F9E {
    COP [01] ( &asciistring_004FB6 )
    COP [09] ( #$8000 )
    COP [86]
    RTL 
}

---------------------------------------------
; The warp effect actor of the hand-over (a colour effect).
; 
; When: spawned (COP 85) by the hand-over actor after the speech.
; Sees: animation table $0D:8000 (PaletteAnimLists), animation $48 started and ticked once, COP 86.
; Why: the same effect as the glow of the Master's stones (we_fx_master_shrine_stone_effect_a_01ECCD).
; In: X = D = the effect.
; Out: RTL after the kill.
; Clobbers: A.

we_fx_deathtoll_mage_warp_effect_004FA9 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #48 )
    COP [94]
    COP [86]
    RTL 
}

asciistring_004FB6 |[10]Some people believe [N]being constantly [N]reincarnated means [N]everlasting suffering-[FIN]Being alive is [N]suffering for some [N]creatures- [FIN]You will find out what[N]I mean- [12][08:408][END]|
---------------------------------------------

; Deathtoll the Demon: set-up and the pillar-and-flame loop.
; 
; When: placement script (meta type $11, row ;02 of A15S02, slot $02, flags $0201).
; Sees: boss_actor = the Demon, $1A bit $0200, $0466 = 0, the curtain actor (COP 85), four actors by COP AC (the side pieces and the two scepters, flags $0200), 61 frames, then loc_0050ED: COP 03 with 4 passes, each spawns a fire pillar (COP B0, flags $0301) and waits 40 frames (we_boss_deathtoll_demon_wave_loop_0050FD). loc_00508A polls the low byte of event_flags every frame; at 4 it is zeroed and the Demon becomes hittable ($0200 cleared, animations $14 and $12), spawns a flame burst, plays animation $13, spawns three fireballs at (8,16), sets $0200 again and plays animation $15; the next wave follows.
; Why: the walkthrough: 'Fire Pillars - These must be taken down before Deathtoll can be hurt', 'Flamethrower - After being actually hurt, Deathtoll will fire three fireballs from his mouth'.
; In: X = D = slot $02 (the COP entrance state).
; Out: boss_actor, event_flags low byte, $0466; never returns (the death goes through RunBossDeath and RunEnding at location $7D).
; Clobbers: A, Y.

we_boss_deathtoll_demon_005043 {
    STX $boss_actor
    LDA $001A, X
    ORA #$0200
    STA $001A, X
    STZ $0466             ; $0466 = 0: the curtain actor keeps every layer on; RunEnding increments it
    COP [85] ( @we_fx_ending_tm_curtain_0055C6 )
    COP [AC] ( @we_boss_deathtoll_demon_side_piece_left_005344, #$0038, #$0070, #$0200 ) ; COP AC: fixed positions; the next three are the right side piece ($B8,$70) and the scepters ($38,$40) and ($B8,$40)
    COP [AC] ( @we_boss_deathtoll_demon_side_piece_right_00534C, #$00B8, #$0070, #$0200 )
    COP [AC] ( @we_boss_deathtoll_demon_scepter_left_0051C4, #$0038, #$0040, #$0200 )
    COP [AC] ( @we_boss_deathtoll_demon_scepter_right_0051F2, #$00B8, #$0040, #$0200 )
    COP [03] ( #3D )
    COP [04]
    BRA loc_0050ED

  loc_00508A:
    COP [91]
    LDA $event_flags
    AND #$00FF
    CMP #$0004            ; all 4 pillars of the wave are destroyed (each adds 1 to the low byte of event_flags)
    BEQ loc_005098
    RTL 

  loc_005098:
    SEP #$20
    STZ $event_flags
    REP #$20
    COP [80] ( #14 )
    COP [82]
    LDA $0016, X
    AND #$FDFF            ; clears $16 bit $0200: the Demon can be hit until it sets the bit again below
    STA $0016, X
    COP [80] ( #12 )
    COP [82]
    COP [B0] ( @we_boss_deathtoll_demon_flame_burst_0051B6, #$0300 )
    COP [80] ( #13 )
    COP [82]
    COP [B2] ( @we_boss_deathtoll_demon_fireball_a_005194, #$0008, #$0010, #$0200 ) ; three fireballs at (8,16) from the Demon, flags $0200 (the walkthrough's Flamethrower)
    COP [B2] ( @we_boss_deathtoll_demon_fireball_b_0051A4, #$0008, #$0010, #$0200 )
    COP [B2] ( @we_boss_deathtoll_demon_fireball_c_0051B2, #$0008, #$0010, #$0200 )
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #15 )
    COP [82]

  loc_0050ED:
    COP [03] ( #04 )
    COP [B0] ( @we_boss_deathtoll_demon_fire_pillar_005101, #$0301 )
    COP [1B] ( &we_boss_deathtoll_demon_wave_loop_0050FD, #$0028 )
}

---------------------------------------------
; The loop end of the pillar spawner.
; 
; When: 40 frames after each pillar was spawned.
; Sees: COP 04 repeats the spawn until its 4 passes are used; then BRA to the counter poll (loc_00508A).
; In: X = D = slot $02.
; Out: yields (COP 04) or continues.
; Clobbers: A.

we_boss_deathtoll_demon_wave_loop_0050FD {
    COP [04]
    BRA loc_00508A
}

---------------------------------------------
; A fire pillar: appears at a random spot and is destroyed by 4 or more points of damage.
; 
; When: spawned by the Demon (COP B0, flags $0301), four per wave.
; Sees: $1A bit $0100 (survives a lethal hit with 1 HP), x = random 0-$9F + $20 and y = random 0-$1D + $B0, the HP byte +$25 = $FF, animation $16 (it rises), $16 bit $0300 cleared (it can be hit); then it loops animation $17 while the HP byte is $FC or more. Below $FC: $16 bit $0300 set again, animation $18 (it breaks), INC of the low byte of event_flags, a 5-Gem pickup spawned (COP B0, flags $4000), COP 86.
; Why: the walkthrough: 'You are going to need to destroy these ... a few Phoenixes will work ... gather the Gems they drop'.
; In: X = D = the pillar.
; Out: event_flags low byte + 1.
; Clobbers: A.

we_boss_deathtoll_demon_fire_pillar_005101 {
    LDA $001A, X
    ORA #$0100            ; $1A bit $0100: survives a lethal hit with 1 HP, so only the script ends the pillar
    STA $001A, X
    COP [1F]
    COP [35] ( #A0 )
    LDA $random_mod_result
    CLC 
    ADC #$0020
    STA $0000, X
    COP [1F]
    COP [35] ( #1E )
    LDA $random_mod_result
    CLC 
    ADC #$00B0
    STA $0002, X
    SEP #$20
    LDA #$FF
    STA $0025, X          ; the HP byte at +$25 starts at $FF
    REP #$20
    COP [80] ( #16 )
    COP [82]
    LDA $0016, X
    AND #$FCFF
    STA $0016, X

  loc_00513F:
    LDA $0025, X
    AND #$00FF
    CMP #$00FC            ; destroyed once the HP byte is below $FC (4 or more points of damage)
    BCC loc_005151
    COP [80] ( #17 )
    COP [82]
    BRA loc_00513F

  loc_005151:
    LDA $0016, X
    ORA #$0300
    STA $0016, X
    COP [80] ( #18 )
    COP [82]
    SEP #$20
    INC $event_flags      ; counts a destroyed pillar in the low byte of event_flags (scene flags 0-7 used as a counter)
    REP #$20
    COP [B0] ( @we_boss_deathtoll_demon_pillar_gem_005170, #$4000 )
    COP [86]
    RTL 
}

---------------------------------------------
; The 5-Gem pickup dropped by a destroyed pillar.
; 
; When: spawned by we_boss_deathtoll_demon_fire_pillar_005101 with flags $4000 (the pickup bit).
; Sees: the same script as RunMediumGemPickup after a set-up: animation table $0E:8000 (COP A8), an absolute read of $0005 stored in $1E, $20 = 0, $1C = scene_sprite_attr, COP A4, animation 05, animation $0A for 4 repeats, COP 86. ApplyGemPickup reads $1E (animation 05 and $0A = 5 Gems).
; Why: the Gems of the walkthrough ('having 0 or 1 Gem(s) meant Game Over'). The read of $0005 is the same unexplained pattern as in ll_effect_model_release_piece_023EF3 (OQ-I040-10); COP 80 overwrites $1E at once.
; In: X = D = the pickup.
; Out: RTL after the kill.
; Clobbers: A.

we_boss_deathtoll_demon_pillar_gem_005170 {
    COP [A8] ( #$8000, #0E )
    LDA $0005             ; absolute read of $0005, not the actor's DP; COP 80 below sets $1E again (OQ-I040-10)
    STA $001E, X
    STZ $0020, X
    LDA $scene_sprite_attr
    STA $001C, X
    COP [A4]
    COP [80] ( #05 )      ; animations 05 and $0A are the 5-Gem pickup (ApplyGemPickup reads $1E)
    COP [82]
    COP [81] ( #0A, #04 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; Fireball A of the Demon's flame attack.
; 
; When: spawned by the Demon (COP B2 at (8,16), flags $0200) after the pillars are down.
; Sees: sound request $51, animation $1A, animation $1C for 8 repeats, COP 86; the movement is in the animation data.
; Why: the walkthrough's three fireballs.
; In: X = D = the fireball.
; Out: RTL after the kill.
; Clobbers: A.

we_boss_deathtoll_demon_fireball_a_005194 {
    BRK #$51
    COP [80] ( #1A )
    COP [82]
    COP [81] ( #1C, #08 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; Fireball B: animation $1B, then animation $1C for 8 repeats, COP 86.
; 
; When: spawned by the Demon with the other two fireballs; fireball C jumps here after setting flip X.
; Sees: no sound of its own.
; In: X = D = the fireball.
; Out: RTL after the kill.
; Clobbers: A.

we_boss_deathtoll_demon_fireball_b_0051A4 {
    COP [80] ( #1B )
    COP [82]
    COP [81] ( #1C, #08 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; Fireball C: the mirror of fireball B (COP 96 sets flip X, then it runs fireball B's script).
; 
; When: spawned by the Demon with the other two fireballs.
; Sees: COP 96, BRA to we_boss_deathtoll_demon_fireball_b_0051A4.
; In: X = D = the fireball.
; Out: see fireball B.
; Clobbers: none.

we_boss_deathtoll_demon_fireball_c_0051B2 {
    COP [96]
    BRA we_boss_deathtoll_demon_fireball_b_0051A4
}

---------------------------------------------
; A flame burst at the Demon when it becomes hittable.
; 
; When: spawned by the Demon (COP B0, flags $0300) between animations $12 and $13.
; Sees: COP A3, COP A0 with -2 (y), animation $19, COP 86.
; Why: the visual of the breath before the fireballs.
; In: X = D = the burst.
; Out: RTL after the kill.
; Clobbers: A.

we_boss_deathtoll_demon_flame_burst_0051B6 {
    COP [A3]
    COP [A0] ( #$FFFE )
    COP [80] ( #19 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; The left scepter: charges and fires a salvo for the whole fight.
; 
; When: spawned by the Demon at ($38,$40), flags $0200.
; Sees: animation $0E for 14 repeats, animation $0D, sound $4B, COP B0 spawns the head (we_boss_deathtoll_demon_laser_left_head_005220, flags $0200) and COP 1B waits 2 frames; we_boss_deathtoll_demon_scepter_left_tails_0051DE then spawns three tail pieces 3 frames apart, and the script starts over.
; Why: the walkthrough: 'Scepter Lasers - They will criss-cross around the field; you have to watch them and move aside'.
; In: X = D = the scepter.
; Out: never returns.
; Clobbers: A, Y.

we_boss_deathtoll_demon_scepter_left_0051C4 {
    COP [81] ( #0E, #0E )
    COP [83]
    COP [80] ( #0D )
    COP [82]
    BRK #$4B
    COP [B0] ( @we_boss_deathtoll_demon_laser_left_head_005220, #$0200 )
    COP [1B] ( &we_boss_deathtoll_demon_scepter_left_tails_0051DE, #$0002 )
}

---------------------------------------------
; The tail pieces of the left scepter's salvo.
; 
; When: 2 frames after the head was spawned.
; Sees: COP 03 with 3 passes; each spawns we_boss_deathtoll_demon_laser_left_tail_00526F (COP B0, flags $0200) and waits 3 frames (COP 1B) before we_boss_deathtoll_demon_scepter_left_next_0051EE repeats.
; In: X = D = the scepter.
; Out: continues in the next step.
; Clobbers: A, Y.

we_boss_deathtoll_demon_scepter_left_tails_0051DE {
    COP [03] ( #03 )
    COP [B0] ( @we_boss_deathtoll_demon_laser_left_tail_00526F, #$0200 )
    COP [1B] ( &we_boss_deathtoll_demon_scepter_left_next_0051EE, #$0003 )
}

---------------------------------------------
; The loop end of the left scepter's tail spawner; after the third pass it restarts the charge (BRA to we_boss_deathtoll_demon_scepter_left_0051C4).
; 
; When: after each tail piece.
; Sees: COP 04, then BRA.
; In: X = D = the scepter.
; Out: yields or loops.
; Clobbers: A.

we_boss_deathtoll_demon_scepter_left_next_0051EE {
    COP [04]
    BRA we_boss_deathtoll_demon_scepter_left_0051C4
}

---------------------------------------------
; The right scepter: the mirror of the left one, spawned at ($B8,$40).
; 
; When: spawned by the Demon, flags $0200.
; Sees: the same script as we_boss_deathtoll_demon_scepter_left_0051C4 with the right head (we_boss_deathtoll_demon_laser_right_head_0052B2) and tails (we_boss_deathtoll_demon_laser_right_tail_005301).
; In: X = D = the scepter.
; Out: never returns.
; Clobbers: A, Y.

we_boss_deathtoll_demon_scepter_right_0051F2 {
    COP [81] ( #0E, #0E )
    COP [83]
    COP [80] ( #0D )
    COP [82]
    BRK #$4B
    COP [B0] ( @we_boss_deathtoll_demon_laser_right_head_0052B2, #$0200 )
    COP [1B] ( &we_boss_deathtoll_demon_scepter_right_tails_00520C, #$0002 )
}

---------------------------------------------
; The tail pieces of the right scepter's salvo (as we_boss_deathtoll_demon_scepter_left_tails_0051DE).
; 
; When: 2 frames after the head was spawned.
; Sees: COP 03 with 3 passes, each spawns we_boss_deathtoll_demon_laser_right_tail_005301 and waits 3 frames.
; In: X = D = the scepter.
; Out: continues in the next step.
; Clobbers: A, Y.

we_boss_deathtoll_demon_scepter_right_tails_00520C {
    COP [03] ( #03 )
    COP [B0] ( @we_boss_deathtoll_demon_laser_right_tail_005301, #$0200 )
    COP [1B] ( &we_boss_deathtoll_demon_scepter_right_next_00521C, #$0003 )
}

---------------------------------------------
; The loop end of the right scepter's tail spawner (COP 04, then BRA to we_boss_deathtoll_demon_scepter_right_0051F2).
; 
; When: after each tail piece.
; Sees: COP 04, then BRA.
; In: X = D = the scepter.
; Out: yields or loops.
; Clobbers: A.

we_boss_deathtoll_demon_scepter_right_next_00521C {
    COP [04]
    BRA we_boss_deathtoll_demon_scepter_right_0051F2
}

---------------------------------------------
; The head of a left-scepter salvo: moves diagonally toward the hero's side.
; 
; When: spawned by the left scepter (flags $0200).
; Sees: $16 bit $8000 (off screen) ends it (COP 86); otherwise animation $0C for 2 repeats and COP 9A (threshold 0): hero to the left: we_boss_deathtoll_demon_laser_left_head_go_left_005238; hero within or right: we_boss_deathtoll_demon_laser_left_head_go_right_005252; each step loops back here.
; Why: the criss-crossing lasers of the walkthrough.
; In: X = D = the piece.
; Out: RTL after the kill.
; Clobbers: A.

we_boss_deathtoll_demon_laser_left_head_005220 {
    LDA $0016, X
    BIT #$8000
    BNE loc_00526C
    COP [81] ( #0C, #02 )
    COP [83]
    COP [9A] ( #$0000, &we_boss_deathtoll_demon_laser_left_head_go_left_005238, &we_boss_deathtoll_demon_laser_left_head_go_right_005252, &we_boss_deathtoll_demon_laser_left_head_go_right_005252 )
}

---------------------------------------------
; One step of a head going left: sets flag $1906 (left), moves (-8,+8), clears flip X, animation $1D for 2 repeats, moves (-8,+8) again and loops to we_boss_deathtoll_demon_laser_left_head_005220.
; 
; When: the hero is left of the head.
; Sees: COP 09 with $9906 (set), COP A1 (-8,+8), COP 97, animation $1D, COP A1 (-8,+8).
; Why: the tail pieces read $1906 to follow.
; In: X = D = the piece.
; Out: back to the head loop.
; Clobbers: A.

we_boss_deathtoll_demon_laser_left_head_go_left_005238 {
    COP [09] ( #$9906 )   ; flag $1906 = direction of the left scepter's head (set = left)
    COP [A1] ( #$FFF8, #$0008 )
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$FFF8, #$0008 )
    BRA we_boss_deathtoll_demon_laser_left_head_005220
}

---------------------------------------------
; One step of a head going right: clears flag $1906, moves (+8,+8), sets flip X, animation $1D for 2 repeats, moves (+8,+8) again and loops.
; 
; When: the hero is within the threshold or right of the head.
; Sees: COP 09 with $1906 (clear), COP A1 (+8,+8), COP 96, animation $1D, COP A1 (+8,+8).
; In: X = D = the piece.
; Out: back to the head loop.
; Clobbers: A.

we_boss_deathtoll_demon_laser_left_head_go_right_005252 {
    COP [09] ( #$1906 )
    COP [A1] ( #$0008, #$0008 )
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$0008, #$0008 )
    BRA we_boss_deathtoll_demon_laser_left_head_005220

  loc_00526C:
    COP [86]
    RTL 
}

---------------------------------------------
; A tail piece of a left-scepter salvo: follows the head's direction.
; 
; When: spawned by the left scepter, three per salvo.
; Sees: $16 bit $8000 ends it; otherwise animation $0C for 2 repeats and COP 07 on flag $1906 (bit 15 clear: jumps when the flag is clear = the head went right) to we_boss_deathtoll_demon_laser_left_tail_go_right_005299; with the flag set it moves (-8,+8), clears flip X, animation $1D for 2 repeats, moves again and loops.
; In: X = D = the piece.
; Out: RTL after the kill.
; Clobbers: A.

we_boss_deathtoll_demon_laser_left_tail_00526F {
    LDA $0016, X
    BIT #$8000
    BNE loc_0052AF
    COP [81] ( #0C, #02 )
    COP [83]
    COP [07] ( #$1906, &we_boss_deathtoll_demon_laser_left_tail_go_right_005299 ) ; bit 15 clear: jumps when $1906 is clear: the tail follows the head to the right
    COP [A1] ( #$FFF8, #$0008 )
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$FFF8, #$0008 )
    BRA we_boss_deathtoll_demon_laser_left_tail_00526F
}

---------------------------------------------
; One step of a tail piece going right: moves (+8,+8), sets flip X, animation $1D for 2 repeats, moves (+8,+8) and loops to we_boss_deathtoll_demon_laser_left_tail_00526F.
; 
; When: flag $1906 is clear.
; Sees: COP A1 (+8,+8), COP 96, animation $1D, COP A1 (+8,+8).
; In: X = D = the piece.
; Out: back to the tail loop.
; Clobbers: A.

we_boss_deathtoll_demon_laser_left_tail_go_right_005299 {
    COP [A1] ( #$0008, #$0008 )
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$0008, #$0008 )
    BRA we_boss_deathtoll_demon_laser_left_tail_00526F

  loc_0052AF:
    COP [86]
    RTL 
}

---------------------------------------------
; The head of a right-scepter salvo (as the left head, with flag $1907).
; 
; When: spawned by the right scepter (flags $0200).
; Sees: $16 bit $8000 ends it; animation $0C for 2 repeats and COP 9A (threshold 0): hero left: we_boss_deathtoll_demon_laser_right_head_go_left_0052CA, else we_boss_deathtoll_demon_laser_right_head_go_right_0052E4.
; In: X = D = the piece.
; Out: RTL after the kill.
; Clobbers: A.

we_boss_deathtoll_demon_laser_right_head_0052B2 {
    LDA $0016, X
    BIT #$8000
    BNE loc_0052FE
    COP [81] ( #0C, #02 )
    COP [83]
    COP [9A] ( #$0000, &we_boss_deathtoll_demon_laser_right_head_go_left_0052CA, &we_boss_deathtoll_demon_laser_right_head_go_right_0052E4, &we_boss_deathtoll_demon_laser_right_head_go_right_0052E4 )
}

---------------------------------------------
; One step of a right head going left: sets flag $1907 (left), moves (-8,+8), clears flip X, animation $1D for 2 repeats, moves again and loops.
; 
; When: the hero is left of the head.
; Sees: COP 09 with $9907, COP A1 (-8,+8), COP 97, animation $1D, COP A1.
; In: X = D = the piece.
; Out: back to the head loop.
; Clobbers: A.

we_boss_deathtoll_demon_laser_right_head_go_left_0052CA {
    COP [09] ( #$9907 )
    COP [A1] ( #$FFF8, #$0008 )
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$FFF8, #$0008 )
    BRA we_boss_deathtoll_demon_laser_right_head_0052B2
}

---------------------------------------------
; One step of a right head going right: clears flag $1907, moves (+8,+8), sets flip X, animation $1D for 2 repeats, moves again and loops.
; 
; When: the hero is within the threshold or right of the head.
; Sees: COP 09 with $1907 (clear), COP A1 (+8,+8), COP 96, animation $1D, COP A1.
; In: X = D = the piece.
; Out: back to the head loop.
; Clobbers: A.

we_boss_deathtoll_demon_laser_right_head_go_right_0052E4 {
    COP [09] ( #$1907 )
    COP [A1] ( #$0008, #$0008 )
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$0008, #$0008 )
    BRA we_boss_deathtoll_demon_laser_right_head_0052B2

  loc_0052FE:
    COP [86]
    RTL 
}

---------------------------------------------
; A tail piece of a right-scepter salvo: follows flag $1907 (as the left tail follows $1906).
; 
; When: spawned by the right scepter, three per salvo.
; Sees: $16 bit $8000 ends it; animation $0C for 2 repeats and COP 07 on flag $1907 (jumps when clear) to we_boss_deathtoll_demon_laser_right_tail_go_right_00532B; with the flag set it moves (-8,+8), clears flip X, animation $1D, moves again and loops.
; In: X = D = the piece.
; Out: RTL after the kill.
; Clobbers: A.

we_boss_deathtoll_demon_laser_right_tail_005301 {
    LDA $0016, X
    BIT #$8000
    BNE loc_005341
    COP [81] ( #0C, #02 )
    COP [83]
    COP [07] ( #$1907, &we_boss_deathtoll_demon_laser_right_tail_go_right_00532B )
    COP [A1] ( #$FFF8, #$0008 )
    COP [97]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$FFF8, #$0008 )
    BRA we_boss_deathtoll_demon_laser_right_tail_005301
}

---------------------------------------------
; One step of a right tail piece going right: moves (+8,+8), sets flip X, animation $1D for 2 repeats, moves again and loops to we_boss_deathtoll_demon_laser_right_tail_005301.
; 
; When: flag $1907 is clear.
; Sees: COP A1 (+8,+8), COP 96, animation $1D, COP A1.
; In: X = D = the piece.
; Out: back to the tail loop.
; Clobbers: A.

we_boss_deathtoll_demon_laser_right_tail_go_right_00532B {
    COP [A1] ( #$0008, #$0008 )
    COP [96]
    COP [81] ( #1D, #02 )
    COP [83]
    COP [A1] ( #$0008, #$0008 )
    BRA we_boss_deathtoll_demon_laser_right_tail_005301

  loc_005341:
    COP [86]
    RTL 
}

---------------------------------------------
; A static piece of the Demon, left (animation $11).
; 
; When: spawned by the Demon at ($38,$70), flags $0200.
; Sees: animation $11 once, COP 91, RTL every frame.
; Why: part of the Demon's body or throne; what it draws is open (OQ-I040-4).
; In: X = D = the piece.
; Out: RTL.
; Clobbers: A.

we_boss_deathtoll_demon_side_piece_left_005344 {
    COP [80] ( #11 )
    COP [82]
    COP [91]
    RTL 
}

---------------------------------------------
; A static piece of the Demon, right (animation $10).
; 
; When: spawned by the Demon at ($B8,$70), flags $0200.
; Sees: animation $10 once, COP 91, RTL every frame.
; In: X = D = the piece.
; Out: RTL.
; Clobbers: A.

we_boss_deathtoll_demon_side_piece_right_00534C {
    COP [80] ( #10 )
    COP [82]
    COP [91]
    RTL 
}
---------------------------------------------

; The main-screen curtain of the final battle and the ending.
; 
; When: spawned (COP 85) by the Demon; it survives RunBossDeath's clean-up through $16 bit $0010.
; Sees: $16 bit $0010 set, COP 91; every frame: $0466 = 0: QueueHdmaDirect for register $2C (TM) with the table at +4 (one line of $17: all layers on); $0466 non-zero (RunEnding has incremented it): the whole table (BG1 off in the first 143 lines).
; Why: during the ending text 'The World of Evil began to disappear' the upper part of the screen loses BG1.
; In: X = D = the actor slot.
; Out: RTL each frame; the HDMA queue is written.
; Clobbers: A, Y.

we_fx_ending_tm_curtain_0055C6 {
    LDA $0016, X
    ORA #$0010            ; $16 bit $0010 is in the keep mask $24D0 of KillAllOtherActors: the curtain survives RunBossDeath
    STA $0016, X
    COP [91]
    SEP #$20
    LDA $0466             ; 0 until RunEnding increments it
    BNE loc_0055E6
    LDA #$2C              ; register $2C = TM (main screen designation)
    XBA 
    LDA #$^we_data_ending_tm_curtain_hdma_0055F5
    LDY #$&we_data_ending_tm_curtain_hdma_0055F5+4
    JSL $@lib_system_helpers.QueueHdmaDirect
    BRA loc_0055F2

  loc_0055E6:
    LDA #$2C
    XBA 
    LDA #$^we_data_ending_tm_curtain_hdma_0055F5
    LDY #$&we_data_ending_tm_curtain_hdma_0055F5 ; the whole table: $16 (BG1 off) for 143 lines, then $17
    JSL $@lib_system_helpers.QueueHdmaDirect

  loc_0055F2:
    REP #$20
    RTL 
}
---------------------------------------------

; The TM HDMA table of the curtain: $7F lines of $16, $10 lines of $16, 1 line of $17, end (0). $16 is BG2, BG3 and sprites (BG1 off), $17 adds BG1. The fight uses the part from +4 (1 line of $17, end).

we_data_ending_tm_curtain_hdma_0055F5 #7F161016011700