; The Demon Falcon, the boss of the airship (file offsets 19438-19850, SNES $00:CBEE-$00:CD8A; lives in bank 00 with the other boss scripts). Scene A13S02 (location $72, the deck of the airship). Walkthrough chapter: docs/walkthrough/07-king-magridds-castle.md ('BOSS: Demon Falcon').
; 
; === WHAT RUNS HERE ===
; MetaMagriddsCastle type $09: attack $1A, defence $14, HP $63 (99), EXP $5000 (BCD), animation bank $08, flags $0000, entry mc_boss_demon_falcon_004BEE. It is the monster of boss lair record $195 (home location $65, lair location $72, tile ($17,$22), RunLairFormation, one monster; the gate word is $018C), not a placed actor: the lair spawns it. The fight is on the deck of the airship, flown from the dock with the Mobile Key (mc_dock_key_wheel_026F57); the walkthrough's 'wind' is the push zones of mc_deck_push_zone_records_02702B.
; boss_actor ($039A) is set to the boss slot; boss_fight_active ($0458) is incremented at the start (the same start as the other bosses, see ll_boss_tin_doll_*). A child actor (mc_boss_demon_falcon_wing_dust_004D09) follows the boss and spawns the dust of its wings.
; 
; === STATE MACHINE ===
; 1. Idle / alert: animation $08; COP 9B with threshold $70 compares the hero's y with the boss's: hero above or within $70 = alert (animation $09, looped), hero at least $70 below = the attack starts (mc_boss_demon_falcon_takeoff_004C0F: animation $0A, flip X, animations $03 and $04).
; 2. Attack choice (loc_004C20): animation $00, then a random value (rng_state+1 and 7): 0-4 (5 in 8) = the swoop: animation $0E, BRK $56, animation $0F for $0D frames, animations $10 and $02, and back to the idle state; 5-7 (3 in 8) = the strafe: animations $01 and $1B, flying sideways until the x position reaches $F0 or $1E0 (the limits of the deck; then animation $04, flip X and the choice again). While strafing, COP 9A with threshold $18 tests the hero's x: within $18 px the boss drops a fire stream (mc_boss_demon_falcon_fire_drop_004C75); otherwise the strafe goes on (mc_boss_demon_falcon_hover_004C6E).
; 3. The fire stream: mc_boss_demon_falcon_fire_stream_004CAA (animations $18-$1A, BRK $65) spawns mc_boss_demon_falcon_fire_fall_004CCF, which starts mc_boss_demon_falcon_fire_trail_004CDF; each trail piece spawns the next 16 px lower (flags $0200: cannot be hit) while the hero is not above it, so a column of fire grows downwards.
; The walkthrough names two attacks: 'Fire Streams - Dodge to the left or right' and 'Diving Attack - Dodge aside', and says 'If you walk upwards anticipating a dive and he strafes instead, just run down and under the fire'. The mapping of the swoop to the dive and of the strafe to the fire is inferred from the code and the strategy text (OQ-I039-11).
; 
; === STATS (walkthrough vs ROM) ===
; EXP 5,000 matches. The walkthrough and enemy-bestiary.md give 90 HP; the ROM has $63 = 99 (DISCREPANCY, OQ-I039-3, which refines OQ-I033-1). The ROM value is what the game uses.
; Walkthrough strategy: 'Given you can't use magic as with all bosses'; 'the wind on the ship will be pushing you back'.
---------------------------------------------

?BANK 00

!rng_state                      0301
!boss_actor                     039A
!random_mod_result              0437
!boss_fight_active              0458

---------------------------------------------

; The Demon Falcon: boss setup and the idle / alert loop.
; 
; When: actor script of meta type $09, spawned by boss lair record $195 on the deck (A13S02).
; Sees: boss_fight_active incremented, boss_actor = the slot, a wing dust child spawned before the boss (COP 85), animation $08, then COP 9B (threshold $70) every round: hero above or within the threshold = mc_boss_demon_falcon_alert_004C08, hero at least $70 below = mc_boss_demon_falcon_takeoff_004C0F.
; Why: the walkthrough: 'this starts another boss fight!' and 'probably the hardest boss in the game'.
; In: X = D = the boss slot (the COP entrance state).
; Out: boss_fight_active, boss_actor; the script never returns (it ends through COP).
; Clobbers: A, Y; boss_actor is read by the dust child.

mc_boss_demon_falcon_004BEE {
    INC $boss_fight_active
    STX $boss_actor
    COP [85] ( @mc_boss_demon_falcon_wing_dust_004D09 )

  loc_004BF9:
    COP [80] ( #08 )
    COP [82]

  loc_004BFE:
    COP [9B] ( #$0070, &mc_boss_demon_falcon_alert_004C08, &mc_boss_demon_falcon_alert_004C08, &mc_boss_demon_falcon_takeoff_004C0F ) ; hero at least $70 px below: start the attack; above or within: the alert pose (both first targets are the same)
}

---------------------------------------------
; The alert pose.
; 
; When: the hero is above the boss or within $70 px vertically.
; Sees: animation $09, then back to the test of the idle loop.
; Why: the boss waits until the hero is low enough.
; In: X = D = the boss.
; Out: loops to loc_004BFE.
; Clobbers: A.

mc_boss_demon_falcon_alert_004C08 {
    COP [80] ( #09 )
    COP [82]
    BRA loc_004BFE
}

---------------------------------------------
; Starts the attack: take-off, then the choice between the swoop and the strafe.
; 
; When: the hero is at least $70 px below the boss.
; Sees: animation $0A, COP 87 (flip X), animations $03 and $04, then loc_004C20: animation $00 for 2 frames, one random draw (COP 1F): values 0-4 give the swoop (animations $0E, BRK $56, $0F for $0D frames, $10, $02, then back to the idle loop); values 5-7 give the strafe (animations $01, $1B and the loop of mc_boss_demon_falcon_hover_004C6E).
; Why: the 5-in-8 / 3-in-8 split is the boss's whole attack pattern; the walkthrough lists 'Fire Streams' and 'Diving Attack' (mapping inferred, OQ-I039-11).
; In: X = D = the boss.
; Out: loops; the x position ($00) is compared with $F0 and $1E0 on the strafe.
; Clobbers: A.

mc_boss_demon_falcon_takeoff_004C0F {
    COP [80] ( #0A )
    COP [82]
    COP [87]
    COP [80] ( #03 )
    COP [82]
    COP [80] ( #04 )
    COP [82]

  loc_004C20:
    COP [81] ( #00, #02 )
    COP [83]
    COP [1F]
    LDA $rng_state+1
    AND #$0007
    CMP #$0005            ; random 0-4 (5 in 8): the swoop; 5-7 (3 in 8): the strafe with fire
    BCS loc_004C4D
    COP [80] ( #0E )
    COP [82]
    BRK #$56
    COP [81] ( #0F, #0D )
    COP [83]
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    BRL loc_004BF9

  loc_004C4D:
    COP [80] ( #01 )
    COP [82]
    COP [80] ( #1B )
    COP [82]

  loc_004C57:
    LDA $0000, X
    CMP #$00F0            ; flight limits x = $F0 and $1E0: turn round (COP 87) and choose again
    BEQ loc_004CA0
    CMP #$01E0
    BEQ loc_004CA0
    COP [9A] ( #$0018, &mc_boss_demon_falcon_hover_004C6E, &mc_boss_demon_falcon_fire_drop_004C75, &mc_boss_demon_falcon_hover_004C6E ) ; hero within $18 px in x: drop a fire stream; otherwise keep strafing
}

---------------------------------------------
; Keeps the boss strafing.
; 
; When: during the strafe, when the hero is left or right of the boss by more than $18 px.
; Sees: animation $1B, then back to the position test (x = $F0 or $1E0 turns the boss round, flip X and animation $04).
; Why: the flight itself comes from the animation frames.
; In: X = D = the boss.
; Out: loops.
; Clobbers: A.

mc_boss_demon_falcon_hover_004C6E {
    COP [80] ( #1B )
    COP [82]
    BRA loc_004C57
}

---------------------------------------------
; The boss drops a fire stream while strafing.
; 
; When: the strafe, hero within $18 px of the boss's x (COP 9A).
; Sees: animation $04, a fire stream spawned at (+8,+8) with flags $0200 (cannot be hit), animation $00, then the strafe goes on.
; Why: 'Fire Streams - Dodge to the left or right' (walkthrough).
; In: X = D = the boss.
; Out: one stream actor.
; Clobbers: A.

mc_boss_demon_falcon_fire_drop_004C75 {
    COP [80] ( #04 )
    COP [82]
    COP [B2] ( @mc_boss_demon_falcon_fire_stream_004CAA, #$0008, #$0008, #$0200 ) ; the fire stream at (+8,+8), flags $0200 (cannot be hit)
    COP [80] ( #00 )
    COP [82]
    BRA mc_boss_demon_falcon_hover_004C6E

  loc_004C8C:
    LDA $0000, X
    CMP #$00F0
    BEQ loc_004CA0
    CMP #$01E0
    BEQ loc_004CA0
    COP [80] ( #1B )
    COP [82]
    BRA loc_004C8C

  loc_004CA0:
    COP [80] ( #04 )
    COP [82]
    COP [87]
    BRL loc_004C20
}

---------------------------------------------
; The fire stream actor.
; 
; When: spawned by mc_boss_demon_falcon_fire_drop_004C75.
; Sees: animations $18, $19, $1A, BRK $65, a fall actor (mc_boss_demon_falcon_fire_fall_004CCF, flags $0200), animations $19 and $18, COP 86.
; Why: the muzzle of the fire; it only starts the fall.
; In: X = D = the child.
; Out: COP 86.
; Clobbers: A.

mc_boss_demon_falcon_fire_stream_004CAA {
    COP [80] ( #18 )
    COP [82]
    COP [80] ( #19 )
    COP [82]
    COP [80] ( #1A )
    COP [82]
    BRK #$65
    COP [B0] ( @mc_boss_demon_falcon_fire_fall_004CCF, #$0200 )
    COP [80] ( #19 )
    COP [82]
    COP [80] ( #18 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; The head of the fire stream.
; 
; When: spawned by mc_boss_demon_falcon_fire_stream_004CAA.
; Sees: animation $17 for 2 frames, the first trail piece (mc_boss_demon_falcon_fire_trail_004CDF, flags $0200), COP 86.
; Why: separates the fall from the muzzle actor.
; In: X = D = the child.
; Out: COP 86.
; Clobbers: A.

mc_boss_demon_falcon_fire_fall_004CCF {
    COP [81] ( #17, #02 )
    COP [83]
    COP [B0] ( @mc_boss_demon_falcon_fire_trail_004CDF, #$0200 )
    COP [86]
    RTL 
}

---------------------------------------------
; One piece of the fire column.
; 
; When: spawned by the fall actor and by the previous trail piece.
; Sees: animation $16, then COP 9B (threshold 0): hero above the piece = the check (stop when bit $8000 of $16 is set); hero within or below = spawn the next piece.
; Why: the column grows 16 px per piece until it passes the hero or is stopped by bit $8000.
; In: X = D = the piece.
; Out: see the two targets.
; Clobbers: A.

mc_boss_demon_falcon_fire_trail_004CDF {
    COP [80] ( #16 )
    COP [82]
    COP [9B] ( #$0000, &mc_boss_demon_falcon_fire_trail_check_004CEE, &mc_boss_demon_falcon_fire_trail_spawn_004CF6, &mc_boss_demon_falcon_fire_trail_spawn_004CF6 )
}

---------------------------------------------
; Stops the column when its $16 bit $8000 is set.
; 
; When: hero above the trail piece.
; Sees: bit $8000 of $16 set = COP 86 through loc_004D06; clear = falls into the spawn.
; Why: the meaning of bit $8000 is not identified (OQ-I039-11).
; In: X = D = the piece.
; Out: COP 86 or the spawn.
; Clobbers: A.

mc_boss_demon_falcon_fire_trail_check_004CEE {
    LDA $0016, X
    BIT #$8000
    BNE loc_004D06
}

---------------------------------------------
; Spawns the next piece of the fire column.
; 
; When: hero within or below the piece, or above it without bit $8000.
; Sees: COP B2 (the trail again, +0,+$10 px, flags $0200), animation $1C, COP 86.
; Why: the column.
; In: X = D = the piece.
; Out: one new piece.
; Clobbers: A.

mc_boss_demon_falcon_fire_trail_spawn_004CF6 {
    COP [B2] ( @mc_boss_demon_falcon_fire_trail_004CDF, #$0000, #$0010, #$0200 ) ; the next piece of the fire column, 16 px lower
    COP [80] ( #1C )
    COP [82]

  loc_004D06:
    COP [86]
    RTL 
}

---------------------------------------------
; The child that follows the boss and puffs dust.
; 
; When: spawned before the boss by COP 85 at the start.
; Sees: stores the low byte of the boss's $25 in its own $30; each round, boss bit $0400 of $16 set = COP 86 (loc_004D5C); the byte unchanged = RTL; changed = it copies the boss x and y-8 and spawns four dust pieces (two of each kind, flags $0300).
; Why: the dust of the wing beats; the boss field $25 is the trigger (its meaning is not identified).
; In: X = D = the child; Y = boss_actor.
; Out: dust pieces.
; Clobbers: A, Y, $30 (own).

mc_boss_demon_falcon_wing_dust_004D09 {
    LDY $boss_actor
    LDA $0025, Y
    AND #$00FF
    STA $0030, X
    COP [91]
    LDY $boss_actor
    LDA $0016, Y
    BIT #$0400
    BNE loc_004D5C
    LDA $0025, Y
    AND #$00FF
    CMP $0030, X
    BNE loc_004D2E
    RTL 

  loc_004D2E:
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    SEC 
    SBC #$0008
    STA $0002, X
    COP [B0] ( @mc_boss_demon_falcon_wing_dust_piece_004D5F, #$0300 )
    COP [B0] ( @mc_boss_demon_falcon_wing_dust_piece_004D5F, #$0300 )
    COP [B0] ( @mc_boss_demon_falcon_wing_dust_piece_004D6B, #$0300 )
    COP [B0] ( @mc_boss_demon_falcon_wing_dust_piece_004D6B, #$0300 )
    BRA mc_boss_demon_falcon_wing_dust_004D09

  loc_004D5C:
    COP [86]
    RTL 
}

---------------------------------------------
; A dust piece, kind one.
; 
; When: spawned by the wing dust child.
; Sees: a random x jitter, animation $14 for 4 frames, COP 86.
; Why: the dust.
; In: X = D = the piece.
; Out: COP 86.
; Clobbers: A.

mc_boss_demon_falcon_wing_dust_piece_004D5F {
    JSR $&mc_boss_demon_falcon_dust_jitter_004D77
    COP [81] ( #14, #04 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; A dust piece, kind two.
; 
; When: spawned by the wing dust child.
; Sees: the same jitter, animation $15 for 4 frames, COP 86.
; Why: the dust.
; In: X = D = the piece.
; Out: COP 86.
; Clobbers: A.

mc_boss_demon_falcon_wing_dust_piece_004D6B {
    JSR $&mc_boss_demon_falcon_dust_jitter_004D77
    COP [81] ( #15, #04 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; Adds a random offset to the dust piece's x.
; 
; When: JSR from both dust pieces.
; Sees: COP 1F, COP 35 #$30 (0-$2F), minus $10, added to the piece's x.
; Why: spreads the dust.
; In: X = D = the piece.
; Out: x ($00) changed; RTS.
; Clobbers: A.

mc_boss_demon_falcon_dust_jitter_004D77 {
    COP [1F]
    COP [35] ( #30 )
    LDA $random_mod_result
    SEC 
    SBC #$0010
    CLC 
    ADC $0000
    STA $0000, X
    RTS 
}