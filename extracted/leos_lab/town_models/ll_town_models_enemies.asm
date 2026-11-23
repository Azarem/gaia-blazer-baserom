; The enemies of the Town Models (file offsets 1038660-1039943, SNES $1F:D944-$DE47, bank 1F): the Toy Soldier ($25), the spear thruster ($26), the lunger ($27), the Catapult ($28) and the Spike Launcher ($29), with their hitboxes, boulders and spikes.
; 
; === ROSTER ===
; Stats from MetaLeosLab (attack, defence, HP binary, EXP BCD) against docs/walkthrough/enemy-bestiary.md: Toy Soldier $25 16 HP / 165 EXP ('Rushing you'); $26 20 HP / 170 EXP, no bestiary row; $27 24 HP / 175 EXP (the bestiary's Toy Calvary: 29 HP / 175 EXP, 'Spear lunges'); Catapult $28 30 HP / 180 EXP ('Flinging boulders'); Spike Launcher $29 36 HP / 160 EXP ('Throwing spikes'). None is metal.
; - DISCREPANCY: the bestiary's Toy Calvary (29 HP, 175 EXP) matches $27 by EXP and by 'spear lunges', but the ROM has 24 HP; the ROM type $26 (20 HP, 170 EXP) has no bestiary row at all (OQ-I038-3). The names ll_enemy_toy_spear / ll_enemy_toy_lunge describe what the scripts do; neither is called Toy Calvary until the question is answered.
; The lairs of Town Model 1 spawn these types (lair $147: 6 Toy Soldiers; lair $143: 5 of type $27); the walkthrough lists Toy Soldiers, Toy Calvary, Catapults and Spike Launchers in the model towns.
; 
; === SHARED PATTERNS ===
; The Soldier, the thruster and the lunger share one chase: while $16 bit $8000 is set (off screen) the script waits 4 frames (COP 1B); on screen COP 9B / 9A (threshold 8) pick a vertical or a horizontal step with a tile test (COP 21-24) and animations $00-$08; when the hero is within the threshold on one axis they attack (rush, thrust or lunge). The Catapult and the Spike Launcher never move. $16 bit $0100 is 'not a hit source' (cannot hurt), $0200 'not a hit target' (cannot be hit), $1000 moves with tile collision; COP B2 spawns the child with the flags given.
; 
; === OPEN ===
; Which spike or boulder belongs to which direction is read from the spawn offsets and the animation ids, not from the sprite pictures (OQ-I038-5).
---------------------------------------------

?BANK 1F

---------------------------------------------

; The Toy Soldier: chases the hero in steps and rushes when aligned.
; 
; When: meta type $25 (16 HP, 165 EXP); spawned by lairs; runs every frame.
; Sees: off screen it waits 4 frames; on screen COP 9B (threshold 8) chooses a step up (animation $04) or down ($03), COP 9A a sideways step (animation $05, flip by COP 96 / 97), each blocked by the tile test (COP 21-24); when the hero is within the threshold on an axis it plays the rush animations ($00 down, $01 up, $02 sideways, 2 repeats).
; Why: 'Rushing you' (bestiary).
; In: actor script, X = D = own slot.
; Out: loops forever.
; Clobbers: A.

ll_enemy_toy_soldier_0FD944 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FD952

  code_0FD94C:
    COP [1B] ( &ll_enemy_toy_soldier_0FD944, #$0004 )

  loc_0FD952:
    COP [9B] ( #$0008, &code_0FD95C, &code_0FD976, &code_0FD969 )
}

code_0FD95C {
    COP [21] ( &code_0FD99C )
    COP [97]
    COP [80] ( #04 )
    COP [82]
    BRA ll_enemy_toy_soldier_0FD944
}

code_0FD969 {
    COP [22] ( &code_0FD99C )
    COP [97]
    COP [80] ( #03 )
    COP [82]
    BRA ll_enemy_toy_soldier_0FD944
}

code_0FD976 {
    COP [9A] ( #$0000, &code_0FD980, &code_0FD98A, &code_0FD98A )
}

code_0FD980 {
    COP [97]
    COP [81] ( #02, #02 )
    COP [83]
    BRA code_0FD994
}

code_0FD98A {
    COP [96]
    COP [81] ( #02, #02 )
    COP [83]
    BRA code_0FD994

  code_0FD994:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FD9A2
}

code_0FD99C {
    COP [1B] ( &code_0FD994, #$0004 )

  loc_0FD9A2:
    COP [9A] ( #$0008, &code_0FD9AC, &code_0FD9C6, &code_0FD9B9 )
}

code_0FD9AC {
    COP [23] ( &code_0FD94C )
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FD994
}

code_0FD9B9 {
    COP [24] ( &code_0FD94C )
    COP [96]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FD994
}

code_0FD9C6 {
    COP [9B] ( #$0000, &code_0FD9D0, &code_0FD9DB, &code_0FD9DB )
}

code_0FD9D0 {
    COP [97]
    COP [81] ( #01, #02 )
    COP [83]
    BRL ll_enemy_toy_soldier_0FD944
}

code_0FD9DB {
    COP [97]
    COP [81] ( #00, #02 )
    COP [83]
    BRL ll_enemy_toy_soldier_0FD944
}
---------------------------------------------

; The thruster: the Soldier's chase with a spear stab and a hitbox child.
; 
; When: meta type $26 (20 HP, 170 EXP); spawned by lairs; runs every frame.
; Sees: the same chase as the Toy Soldier (animations $06-$08 for the steps); when aligned it plays a stab pose (animation $0D side, $0B up, $09 down), spawns a hitbox actor with COP B2 (flags $0200) in front of it and plays the recovery ($0E, $0C, $0A).
; Why: the stab is the attack; the hitbox gives it reach. The type has no bestiary row (OQ-I038-3).
; In: actor script, X = D = own slot.
; Out: loops forever.
; Clobbers: A, Y (the child).

ll_enemy_toy_spear_0FD9E6 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FD9F4

  code_0FD9EE:
    COP [1B] ( &ll_enemy_toy_spear_0FD9E6, #$0004 )

  loc_0FD9F4:
    COP [9B] ( #$0008, &code_0FD9FE, &code_0FDA18, &code_0FDA0B )
}

code_0FD9FE {
    COP [21] ( &code_0FDA5C )
    COP [97]
    COP [80] ( #07 )
    COP [82]
    BRA ll_enemy_toy_spear_0FD9E6
}

code_0FDA0B {
    COP [22] ( &code_0FDA5C )
    COP [97]
    COP [80] ( #06 )
    COP [82]
    BRA ll_enemy_toy_spear_0FD9E6
}

code_0FDA18 {
    COP [9A] ( #$0000, &code_0FDA22, &code_0FDA3B, &code_0FDA3B )
}

code_0FDA22 {
    COP [97]
    COP [80] ( #0D )
    COP [82]
    COP [B2] ( @ll_enemy_toy_spear_hitbox_0FDAC4, #$FFF8, #$0000, #$0200 )
    COP [80] ( #0E )
    COP [82]
    BRA code_0FDA54
}

code_0FDA3B {
    COP [96]
    COP [80] ( #0D )
    COP [82]
    COP [B2] ( @ll_enemy_toy_spear_hitbox_0FDACE, #$0008, #$0000, #$0200 )
    COP [80] ( #0E )
    COP [82]
    BRA code_0FDA54

  code_0FDA54:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDA62
}

code_0FDA5C {
    COP [1B] ( &code_0FDA54, #$0004 )

  loc_0FDA62:
    COP [9A] ( #$0008, &code_0FDA6C, &code_0FDA86, &code_0FDA79 )
}

code_0FDA6C {
    COP [23] ( &code_0FD9EE )
    COP [97]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FDA54
}

code_0FDA79 {
    COP [24] ( &code_0FD9EE )
    COP [96]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FDA54
}

code_0FDA86 {
    COP [9B] ( #$0000, &code_0FDA90, &code_0FDAAA, &code_0FDAAA )
}

code_0FDA90 {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    COP [B2] ( @ll_enemy_toy_spear_hitbox_0FDAD8, #$0002, #$FFF8, #$0200 )
    COP [80] ( #0C )
    COP [82]
    BRL ll_enemy_toy_spear_0FD9E6
}

code_0FDAAA {
    COP [97]
    COP [80] ( #09 )
    COP [82]
    COP [B2] ( @ll_enemy_toy_spear_hitbox_0FDAE2, #$FFFD, #$0008, #$0200 )
    COP [80] ( #0A )
    COP [82]
    BRL ll_enemy_toy_spear_0FD9E6
}

---------------------------------------------
; The stab hitbox to the left of the thruster.
; 
; When: spawned by ll_enemy_toy_spear_0FD9E6 at (-8,0) with flags $0200 (hurts, cannot be hit).
; Sees: sound BRK #$5B, animation $11 with 8 repeats, COP 86.
; Why: the reach of the spear.
; In: X = D = the hitbox.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_toy_spear_hitbox_0FDAC4 {
    BRK #$5B
    COP [81] ( #11, #08 )
    COP [83]
    BRA loc_0FDAEA
}

---------------------------------------------
; The stab hitbox to the right of the thruster.
; 
; When: spawned by ll_enemy_toy_spear_0FD9E6 at (8,0), flags $0200.
; Sees: as ll_enemy_toy_spear_hitbox_0FDAC4 (animation $11).
; Why: see there.
; In: X = D = the hitbox.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_toy_spear_hitbox_0FDACE {
    BRK #$5B
    COP [81] ( #11, #08 )
    COP [83]
    BRA loc_0FDAEA
}

---------------------------------------------
; The stab hitbox above the thruster.
; 
; When: spawned by ll_enemy_toy_spear_0FD9E6 at (2,-8), flags $0200.
; Sees: sound BRK #$5B, animation $10 with 8 repeats, COP 86.
; Why: see ll_enemy_toy_spear_hitbox_0FDAC4.
; In: X = D = the hitbox.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_toy_spear_hitbox_0FDAD8 {
    BRK #$5B
    COP [81] ( #10, #08 )
    COP [83]
    BRA loc_0FDAEA
}

---------------------------------------------
; The stab hitbox below the thruster.
; 
; When: spawned by ll_enemy_toy_spear_0FD9E6 at (-3,8), flags $0200.
; Sees: sound BRK #$5B, animation $0F with 8 repeats, COP 86.
; Why: see ll_enemy_toy_spear_hitbox_0FDAC4.
; In: X = D = the hitbox.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_toy_spear_hitbox_0FDAE2 {
    BRK #$5B
    COP [81] ( #0F, #08 )
    COP [83]

  loc_0FDAEA:
    COP [86]
    RTL 
}
---------------------------------------------

; The lunger: the Soldier's chase with a spear lunge that moves with tile collision.
; 
; When: meta type $27 (24 HP, 175 EXP); spawned by lairs (lair $143); runs every frame.
; Sees: the same chase as the Toy Soldier (animations $12-$16, $1A for the steps); when aligned it sets $16 bit $1000 (moves with tile collision) and plays three animations in a row ($1B-$1D sideways, $17-$19 up, $13-$15 down), then clears the bit.
; Why: 'Spear lunges' (bestiary, Toy Calvary: OQ-I038-3).
; In: actor script, X = D = own slot.
; Out: loops forever.
; Clobbers: A.

ll_enemy_toy_lunge_0FDAED {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDAFB

  code_0FDAF5:
    COP [1B] ( &ll_enemy_toy_lunge_0FDAED, #$0004 )

  loc_0FDAFB:
    COP [9B] ( #$0008, &code_0FDB05, &code_0FDB1F, &code_0FDB12 )
}

code_0FDB05 {
    COP [21] ( &code_0FDB7B )
    COP [97]
    COP [80] ( #16 )
    COP [82]
    BRA ll_enemy_toy_lunge_0FDAED
}

code_0FDB12 {
    COP [22] ( &code_0FDB7B )
    COP [97]
    COP [80] ( #12 )
    COP [82]
    BRA ll_enemy_toy_lunge_0FDAED
}

code_0FDB1F {
    COP [9A] ( #$0000, &code_0FDB29, &code_0FDB4E, &code_0FDB4E )
}

code_0FDB29 {
    COP [97]
    LDA $0016, X
    ORA #$1000            ; $16 bit $1000: the actor moves with tile collision during the lunge (cleared again at 1039174)
    STA $0016, X
    COP [80] ( #1B )
    COP [82]
    COP [80] ( #1C )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    LDA $0016, X
    AND #$EFFF            ; lunge over: back to a walker without tile collision
    STA $0016, X
    BRA code_0FDB73
}

code_0FDB4E {
    COP [96]
    LDA $0016, X
    ORA #$1000
    STA $0016, X
    COP [80] ( #1B )
    COP [82]
    COP [80] ( #1C )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    LDA $0016, X
    AND #$EFFF
    STA $0016, X
    BRA code_0FDB73

  code_0FDB73:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDB81
}

code_0FDB7B {
    COP [1B] ( &code_0FDB73, #$0004 )

  loc_0FDB81:
    COP [9A] ( #$0008, &code_0FDB8B, &code_0FDBA5, &code_0FDB98 )
}

code_0FDB8B {
    COP [23] ( &code_0FDAF5 )
    COP [97]
    COP [80] ( #1A )
    COP [82]
    BRA code_0FDB73
}

code_0FDB98 {
    COP [24] ( &code_0FDAF5 )
    COP [96]
    COP [80] ( #1A )
    COP [82]
    BRA code_0FDB73
}

code_0FDBA5 {
    COP [9B] ( #$0000, &code_0FDBAF, &code_0FDBD5, &code_0FDBD5 )
}

code_0FDBAF {
    COP [97]
    LDA $0016, X
    ORA #$1000
    STA $0016, X
    COP [80] ( #17 )
    COP [82]
    COP [80] ( #18 )
    COP [82]
    COP [80] ( #19 )
    COP [82]
    LDA $0016, X
    AND #$EFFF
    STA $0016, X
    BRL ll_enemy_toy_lunge_0FDAED
}

code_0FDBD5 {
    COP [97]
    LDA $0016, X
    ORA #$1000
    STA $0016, X
    COP [80] ( #13 )
    COP [82]
    COP [80] ( #14 )
    COP [82]
    COP [80] ( #15 )
    COP [82]
    LDA $0016, X
    AND #$EFFF
    STA $0016, X
    BRL ll_enemy_toy_lunge_0FDAED
}
---------------------------------------------

; The Catapult: a fixed thrower that fires a boulder at the hero from a distance.
; 
; When: meta type $28 (30 HP, 180 EXP); runs every frame.
; Sees: priority $20; off screen it waits $20 frames; on screen COP 9A / 9B (threshold $10) test whether the hero is in line; when he is it plays the throw (wind-up, COP B2 for the boulder at (-8,-8), (8,-8), (0,-$10) or (0,-8) with flags $0300, release, rest) for left, right, up and down (animations $27/$29/$26, $23/$25/$22, $1F/$21/$1E).
; Why: 'Flinging boulders' (bestiary); the walkthrough: get just north of them and thrust.
; In: actor script, X = D = own slot.
; Out: loops forever.
; Clobbers: A, Y (the child).

ll_enemy_catapult_0FDBFB {
    COP [A2] ( #20 )

  code_0FDBFE:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FDC0C

  code_0FDC06:
    COP [1B] ( &code_0FDBFE, #$0020 )

  loc_0FDC0C:
    COP [9A] ( #$0010, &code_0FDC16, &code_0FDC20, &code_0FDC16 )
}

code_0FDC16 {
    COP [9B] ( #$0010, &code_0FDC06, &code_0FDC2A, &code_0FDC06 )
}

code_0FDC20 {
    COP [9B] ( #$0000, &code_0FDC70, &code_0FDC8F, &code_0FDC8F )
}

code_0FDC2A {
    COP [9A] ( #$0000, &code_0FDC34, &code_0FDC52, &code_0FDC52 )
}

code_0FDC34 {
    COP [97]
    COP [80] ( #27 )
    COP [82]
    COP [B2] ( @ll_enemy_catapult_boulder_0FDCAE, #$FFF8, #$FFF8, #$0300 )
    COP [80] ( #29 )
    COP [82]
    COP [80] ( #26 )
    COP [82]
    BRA code_0FDC06
}

code_0FDC52 {
    COP [96]
    COP [80] ( #27 )
    COP [82]
    COP [B2] ( @ll_enemy_catapult_boulder_0FDCBB, #$0008, #$FFF8, #$0300 )
    COP [80] ( #29 )
    COP [82]
    COP [80] ( #26 )
    COP [82]
    BRA code_0FDC06
}

code_0FDC70 {
    COP [97]
    COP [80] ( #23 )
    COP [82]
    COP [B2] ( @ll_enemy_catapult_boulder_0FDCC8, #$0000, #$FFF0, #$0300 )
    COP [80] ( #25 )
    COP [82]
    COP [80] ( #22 )
    COP [82]
    BRL code_0FDC06
}

code_0FDC8F {
    COP [97]
    COP [80] ( #1F )
    COP [82]
    COP [B2] ( @ll_enemy_catapult_boulder_0FDCD5, #$0000, #$FFF8, #$0300 )
    COP [80] ( #21 )
    COP [82]
    COP [80] ( #1E )
    COP [82]
    BRL code_0FDC06
}

---------------------------------------------
; A boulder thrown to the left: draws in front, sound BRK #$52, animation $28, then the landing (loc_0FDCE0).
; 
; When: spawned by ll_enemy_catapult_0FDBFB at (-8,-8) with flags $0300 (neither hurts nor can be hit while it flies).
; Sees: flip cleared, COP A3, sound, animation $28; at loc_0FDCE0: clears $16 bit $0100, priority $30, moves by (-8,8), sound BRK #$61, animation $2A, COP 86.
; Why: the boulder only hurts once it has landed.
; In: X = D = the boulder.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_catapult_boulder_0FDCAE {
    COP [97]
    COP [A3]
    BRK #$52
    COP [80] ( #28 )
    COP [82]
    BRA loc_0FDCE0
}

---------------------------------------------
; A boulder thrown to the right: as ll_enemy_catapult_boulder_0FDCAE with the flip set.
; 
; When: spawned by ll_enemy_catapult_0FDBFB at (8,-8), flags $0300.
; Sees: COP 96, animation $28, then the same landing.
; Why: see there.
; In: X = D = the boulder.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_catapult_boulder_0FDCBB {
    COP [96]
    COP [A3]
    BRK #$52
    COP [80] ( #28 )
    COP [82]
    BRA loc_0FDCE0
}

---------------------------------------------
; A boulder thrown up: as ll_enemy_catapult_boulder_0FDCAE with animation $24.
; 
; When: spawned by ll_enemy_catapult_0FDBFB at (0,-$10), flags $0300.
; Sees: flip cleared, animation $24, then the same landing.
; Why: see there.
; In: X = D = the boulder.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_catapult_boulder_0FDCC8 {
    COP [97]
    COP [A3]
    BRK #$52
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FDCE0
}

---------------------------------------------
; A boulder thrown down: as ll_enemy_catapult_boulder_0FDCAE with animation $20.
; 
; When: spawned by ll_enemy_catapult_0FDBFB at (0,-8), flags $0300.
; Sees: flip cleared, animation $20, then the same landing.
; Why: see there.
; In: X = D = the boulder.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_catapult_boulder_0FDCD5 {
    COP [97]
    COP [A3]
    BRK #$52
    COP [80] ( #20 )
    COP [82]

  loc_0FDCE0:
    LDA $0016, X
    AND #$FEFF            ; clears $0100 (not a hit source): from the landing on the boulder hurts
    STA $0016, X
    COP [A2] ( #30 )
    COP [A1] ( #$FFF8, #$0008 ) ; the landing frame is shifted by (-8,8)
    BRK #$61
    COP [80] ( #2A )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

; The Spike Launcher: a fixed turret in one of four facings that throws spikes.
; 
; When: meta type $29 (36 HP, 160 EXP); placed or spawned by lairs; runs every frame.
; Sees: priority $20; COP A5 picks one of four states from the flip bits: none tests the tile below (COP 22) and throws its spike at (0,-6); flip X tests the tile to the left (COP 23) and throws at (-5,-7); flip Y the tile to the right (COP 24) at ($12,-7); both the tile above (COP 21) at (0,-$1A). Each waits while off screen (COP AD, 8 frames), plays a twirl (animations $2B-$32) and throws (COP B2, flags $0200), then rests in animation $2B or $2C with 8 repeats. When the tile ahead is occupied it turns first (the twirl) and throws the opposite spike instead.
; Why: 'Throwing spikes' (bestiary).
; In: actor script, X = D = own slot.
; Out: loops forever.
; Clobbers: A, Y (the child).

ll_enemy_spike_launcher_0FDCFC {
    COP [A2] ( #20 )
    COP [A5] ( &code_0FDD09, &code_0FDDD9, &code_0FDD94, &code_0FDD4E )
}

code_0FDD09 {
    COP [AD] ( #08 )
    COP [22] ( &code_0FDD33 )
    COP [81] ( #2D, #04 )
    COP [83]
    COP [22] ( &code_0FDD33 )
    COP [81] ( #2D, #04 )
    COP [83]

  loc_0FDD20:
    COP [B2] ( @ll_enemy_spike_launcher_spike_0FDE3B, #$0000, #$FFFA, #$0200 )
    COP [81] ( #2B, #08 )
    COP [83]
    BRA code_0FDD09
}

code_0FDD33 {
    COP [80] ( #2B )
    COP [82]
    COP [80] ( #32 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #31 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    BRA loc_0FDD65
}

code_0FDD4E {
    COP [AD] ( #08 )
    COP [21] ( &code_0FDD78 )
    COP [81] ( #2E, #04 )
    COP [83]
    COP [21] ( &code_0FDD78 )
    COP [81] ( #2E, #04 )
    COP [83]

  loc_0FDD65:
    COP [B2] ( @ll_enemy_spike_launcher_spike_0FDE2E, #$0000, #$FFE6, #$0200 )
    COP [81] ( #2B, #08 )
    COP [83]
    BRA code_0FDD4E
}

code_0FDD78 {
    COP [80] ( #2B )
    COP [82]
    COP [80] ( #32 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #31 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    BRL loc_0FDD20
}

code_0FDD94 {
    COP [AD] ( #08 )
    COP [24] ( &code_0FDDBE )
    COP [81] ( #30, #04 )
    COP [83]
    COP [24] ( &code_0FDDBE )
    COP [81] ( #30, #04 )
    COP [83]

  loc_0FDDAB:
    COP [B2] ( @ll_enemy_spike_launcher_spike_0FDE1F, #$0012, #$FFF9, #$0200 )
    COP [81] ( #2C, #08 )
    COP [83]
    BRA code_0FDD94
}

code_0FDDBE {
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #32 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    COP [80] ( #31 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRA loc_0FDDF0
}

code_0FDDD9 {
    COP [AD] ( #08 )
    COP [23] ( &code_0FDE03 )
    COP [81] ( #2F, #04 )
    COP [83]
    COP [23] ( &code_0FDE03 )
    COP [81] ( #2F, #04 )
    COP [83]

  loc_0FDDF0:
    COP [B2] ( @ll_enemy_spike_launcher_spike_0FDE21, #$FFFB, #$FFF9, #$0200 )
    COP [81] ( #2C, #08 )
    COP [83]
    BRA code_0FDDD9
}

code_0FDE03 {
    COP [80] ( #2C )
    COP [82]
    COP [80] ( #32 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    COP [80] ( #31 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    BRL loc_0FDDAB
}

---------------------------------------------
; A spike thrown to the right: the flip is set here and the script continues in ll_enemy_spike_launcher_spike_0FDE21.
; 
; When: spawned by the flip-Y state of ll_enemy_spike_launcher_0FDCFC at ($12,-7), flags $0200.
; Sees: COP 96, then the left spike's body: COP A3, priority $30, animation $35, COP 86.
; Why: the spike differs from the left one only in the flip.
; In: X = D = the spike.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_spike_launcher_spike_0FDE1F {
    COP [96]
}

---------------------------------------------
; A spike thrown to the left.
; 
; When: spawned by the flip-X state of ll_enemy_spike_launcher_0FDCFC at (-5,-7), flags $0200.
; Sees: COP A3 (in front), priority $30, animation $35, COP 86.
; Why: see ll_enemy_spike_launcher_spike_0FDE1F.
; In: X = D = the spike.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_spike_launcher_spike_0FDE21 {
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #35 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; A spike thrown up.
; 
; When: spawned by the state 'both' of ll_enemy_spike_launcher_0FDCFC at (0,-$1A), flags $0200.
; Sees: COP A3, priority $30, animation $34, COP 86.
; Why: see ll_enemy_spike_launcher_spike_0FDE1F.
; In: X = D = the spike.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_spike_launcher_spike_0FDE2E {
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #34 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; A spike thrown down.
; 
; When: spawned by the state 'none' of ll_enemy_spike_launcher_0FDCFC at (0,-6), flags $0200.
; Sees: COP A3, priority $30, animation $33, COP 86.
; Why: see ll_enemy_spike_launcher_spike_0FDE1F.
; In: X = D = the spike.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_spike_launcher_spike_0FDE3B {
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #33 )
    COP [82]
    COP [86]
    RTL 
}