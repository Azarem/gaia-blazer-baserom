; The enemies and hazards of the St. Elles island scenes (world 2; file offsets 1031973-1034031, SNES $1F:BF25-$C732): the Lightning Pyramid ($38), the Durean vent ($39) with its lava bomb, the Walking Tree ($3A), the Monster Rock ($3B), the Purple Fish ($3C), the Ape ($3D), the Metal Ape ($3E) and the Tornadic Eagle ($3F), each with its projectiles.
; 
; === ROSTER (meta type: attack / defence / HP / EXP; bestiary row) ===
; - $38 Lightning Pyramid: 0 / 0 / 0 / 0, flags $2000. The 'yellow pyramid' of the walkthrough; placed, not in a lair.
; - $39 Durean vent: 7 / 0 / 1 / 0, flags $2000. Placed on Durean; throws the lava bombs.
; - $3A Walking Tree: 6 / 2 / 10 / 22 (bestiary: 10 HP, 22 EXP, 'Projectiles'). Lair records $99, $9B, $9E, $A2, $A8, $AB, $B0, $B1.
; - $3B Monster Rock: 8 / 3 / 20 / 24 (20 HP, 24 EXP, 'Tackling'). Lair records $7D, $8B, $8C, $93, $A0, $A3, $A9, $AA, $B5, $BA, $BF, $C3.
; - $3C Purple Fish: 7 / 2 / 8 / 20 (8 HP, 20 EXP, 'Bubble projectiles'), flags $2000. Placed, not in a lair.
; - $3D Ape: 7 / 2 / 12 / 23 (12 HP, 23 EXP, 'Rock-throwing; moving'). Lair records $89, $8D, $8F, $90, $92, $95, $97, $98, $9A, $9C, $9D, $A1, $A4, $A5, $A7, $AC, $AE, $AF, $B2, $B3, $BC, $BD, $BE.
; - $3E Metal Ape: 9 / 1 / 30 / 35 (30 HP, 35 EXP, 'Metal? Yes'). Lair records $8E and $B9 ('the Metal Ape lair will have to wait until we get the Zantetsu Sword').
; - $3F Tornadic Eagle: 7 / 0 / 21 / 28 (21 HP, 28 EXP, 'Flying; tornadoes'). Lair records $8A, $91, $94, $96, $9F, $B4, $B8 and the three proximity lairs $A6, $BB and $C0.
; 
; === FLAG BITS USED ===
; - $16 bit $0200 (the 'unexplained' bit of OQ-I005-14) is part of the engine's target mask $EEC0, so an actor with it cannot be hit by sword or projectile; bit $0100 keeps an actor from being a hit source ($0D00); $0080 is a hit source, $0020 a projectile, $0002 deflects hits. The bolts and flashes of the pyramid use $02A0 (unhittable hit-source projectile), the seeds, bubbles and tornado $0200, the rocks $0202.
; - $1A bit $0400 is the metal immunity class (only the Zantetsu Sword hurts): the Metal Ape sets it for good.
; - The lava bomb has $16 = $0301 while it flies; DestroyHazardsNearOrb (engine_player_death_and_actor_helpers, the Soul of Shield) bursts exactly such actors near the orb. This confirms the link the engine note called inferred: the Durean bombs are the $0301 actors.
; 
; === OPEN ===
; - The Purple Fish treats a non-zero tile_type_map byte under it as 'in the water' and zero as dry land (inferred from the walkthrough: the fish dries up and lies down when the water is gone; OQ-I036-10).
; - The Lightning Pyramid damage: the bolt sets $30 = $00FF; ApplyProjectileHit reads $30 first and $FF skips the boss, class and Phoenix tests, so the bolt kills any enemy as the walkthrough says ('zapping any enemy nearby to death - even if they are metal enemies').
---------------------------------------------

?BANK 1F

?INCLUDE 'lib_map_index_helpers'

!rng_state                      0301
!player_x                       0374
!player_y                       0376
!tile_type_map                  7F8000

---------------------------------------------

; The Lightning Pyramid: strikes enemies near it while the hero wears the Thunder Ring.
; 
; When: meta type $38; placed in the pyramid scene (the trio of Ape lairs).
; Sees: off screen it waits 32 frames per pass; COP 19 sends it back to the wait while item $24 (the Thunder Ring) is not equipped; with the ring on and the hero inside its box widened by 2 (COP 0C) it spawns se_obj_pyramid_lightning_0FBF4B and waits 180 frames.
; Why: walkthrough: 'equip the Thunder Ring and get near the yellow pyramid ... zapping any enemy nearby to death'.
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_obj_lightning_pyramid_0FBF25 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FBF33

  code_0FBF2D:
    COP [1B] ( &se_obj_lightning_pyramid_0FBF25, #$0020 )

  loc_0FBF33:
    COP [19] ( #24, &code_0FBF2D ) ; COP 19 jumps back to the wait when item $24 (the Thunder Ring) is not equipped
    COP [0C] ( #00, #02, &code_0FBF40 )
    BRA code_0FBF2D
}

code_0FBF40 {
    COP [85] ( @se_obj_pyramid_lightning_0FBF4B )
    COP [1B] ( &se_obj_lightning_pyramid_0FBF25, #$00B4 )
}

---------------------------------------------
; The lightning bolt of the pyramid.
; 
; When: spawned (COP 85) by se_obj_lightning_pyramid_0FBF25.
; Sees: $16 = $02A0 and $30 = $00FF; drawn in front, priority $30, sound $90; it moves up $B0 pixels, plays animation 0 and spawns a flash (se_obj_pyramid_lightning_flash_0FBF88), moves down $80 and repeats, then moves (-$18, +$48), plays animation 2 and kills itself.
; Why: the bolt and the flashes are the hits that kill the enemies around the pyramid.
; In: X = D = slot of the new actor; RTL after COP 86.
; Out: RTL.
; Clobbers: A.

se_obj_pyramid_lightning_0FBF4B {
    LDA #$02A0
    STA $0016, X          ; $16 = $02A0: unhittable ($0200), hit source ($0080), projectile ($0020)
    LDA #$00FF
    STA $0030, X          ; $30 = $FF: the damage of the bolt (the walkthrough: it kills metal enemies too; the reading of $30 as damage is inferred)
    COP [A3]
    COP [A2] ( #30 )
    BRK #$90
    COP [A0] ( #$FF50 )
    COP [80] ( #00 )
    COP [82]
    COP [85] ( @se_obj_pyramid_lightning_flash_0FBF88 )
    COP [A0] ( #$0080 )
    COP [80] ( #00 )
    COP [82]
    COP [85] ( @se_obj_pyramid_lightning_flash_0FBF88 )
    COP [A1] ( #$FFE8, #$0048 )
    COP [80] ( #02 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; One flash of the lightning bolt.
; 
; When: spawned twice by se_obj_pyramid_lightning_0FBF4B.
; Sees: $30 = $00FF, $16 = $02A0; drawn in front, priority $30; animation 1, then it kills itself.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_obj_pyramid_lightning_flash_0FBF88 {
    LDA #$00FF
    STA $0030, X
    LDA #$02A0
    STA $0016, X
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #01 )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

; A vent of Durean: starts the lava bomb timer.
; 
; When: meta type $39; placed on Durean.
; Sees: sets its resume address $18 to se_obj_durean_vent_tick_0FBFB7 and its wait $14 to $7F + (rng_state+1 AND $7F) frames (COP 1F steps the generator), then returns (RTL) until the wait is over.
; Why: the volcano 'spewing out lava bombs everywhere'.
; In: actor script, X = own slot.
; Out: RTL.
; Clobbers: A.

se_obj_durean_vent_0FBFA1 {
    LDA #$&se_obj_durean_vent_tick_0FBFB7
    STA $0018, X

  loc_0FBFA7:
    COP [1F]
    LDA $rng_state+1
    AND #$007F
    CLC 
    ADC #$007F
    STA $0014, X
    RTL 
}
---------------------------------------------

; Tick of the vent: throws one lava bomb unless the volcano is out.
; 
; When: the wait of se_obj_durean_vent_0FBFA1 is over.
; Sees: COP 07 with event flag $0503 set jumps to code_0FBFC4 (kill); otherwise COP 85 spawns se_obj_lava_bomb_0FBFC7 and the timer restarts.
; Why: equipping the Mermaid's Tears at the top of the island sets flag $0503 (se_st_elles_coast_actors): 'this will extinguish the fire on the island and stop the rain of fireballs'.
; In: actor script, X = own slot.
; Out: the next wait or the actor is removed.
; Clobbers: A.

se_obj_durean_vent_tick_0FBFB7 {
    COP [07] ( #$8503, &code_0FBFC4 ) ; event flag $0503 set (the Mermaid's Tears equipped at the rock): the vent removes itself
    COP [85] ( @se_obj_lava_bomb_0FBFC7 )
    BRA loc_0FBFA7
}

code_0FBFC4 {
    COP [86]
    RTL 
}

---------------------------------------------
; A lava bomb: flies out of the screen, then falls near the hero.
; 
; When: spawned (COP 85) by the vent.
; Sees: $16 = $0301 (the value the Soul of Shield looks for); drawn in front, sound $50; animation 3 loops until $16 bit $8000 is set (COP 1C: it left the screen); then x = hero x + (rng AND $7F) - $40 and y = hero y + (rng AND $7F) - $40 - $E0 (above the screen), animation 4 seven times (the fall), $16 = $0200, animation 5 (the burst) and COP 86.
; Why: walkthrough: 'if you have the Soul of Shield, you should be fine'; the orb bursts every $0301 actor within $30 pixels.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_obj_lava_bomb_0FBFC7 {
    LDA #$0301
    STA $0016, X          ; $16 = $0301: the exact value that DestroyHazardsNearOrb (the Soul of Shield) bursts near the orb
    COP [A3]
    BRK #$50

  loc_0FBFD1:
    COP [80] ( #03 )
    COP [82]
    COP [1C] ( #$8000, &code_0FBFDE ) ; COP 1C jumps when $16 bit $8000 is set: the bomb has left the screen
    BRA loc_0FBFD1
}

code_0FBFDE {
    COP [1F]
    LDA $rng_state+1
    AND #$007F
    SEC 
    SBC #$0040
    CLC 
    ADC $player_x
    STA $0000, X
    COP [1F]
    LDA $rng_state+1
    AND #$007F
    SEC 
    SBC #$0040
    CLC 
    ADC $player_y
    SEC 
    SBC #$00E0
    STA $0002, X
    COP [81] ( #04, #07 )
    COP [83]
    LDA #$0200
    STA $0016, X          ; the fall is over: $16 = $0200, no longer $0301, for the landing burst
    COP [A6]
    COP [80] ( #05 )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

; The Walking Tree: stands and throws seeds in four directions.
; 
; When: meta type $3A; spawned by the Walking Tree lairs.
; Sees: off screen it waits 16 frames per pass; otherwise a random value (COP 1F, AND 3) picks a throw: animation 9 (flip X clear), 8, $0A with flip X set or $0A with flip X clear, then animations 6 and 7 and COP 85 spawns the seed of the direction (se_enemy_tree_seed_0FC0B4, 0FC0B9 or 0FC0BE), animation 6 and again.
; Why: walkthrough: 'they like to line up rather conveniently' (Light Arrow magic kills them in one hit at level 8).
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_enemy_walking_tree_0FC01E {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC02C
    COP [1B] ( &se_enemy_walking_tree_0FC01E, #$0010 )

  loc_0FC02C:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FC03F
    DEC 
    BEQ loc_0FC05C
    DEC 
    BEQ loc_0FC079
    DEC 
    BEQ loc_0FC096

  loc_0FC03F:
    COP [97]
    COP [80] ( #09 )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #07 )
    COP [82]
    COP [85] ( @se_enemy_tree_seed_0FC0B4 )
    COP [80] ( #06 )
    COP [82]
    BRA se_enemy_walking_tree_0FC01E

  loc_0FC05C:
    COP [97]
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #07 )
    COP [82]
    COP [85] ( @se_enemy_tree_seed_0FC0B9 )
    COP [80] ( #06 )
    COP [82]
    BRA se_enemy_walking_tree_0FC01E

  loc_0FC079:
    COP [96]
    COP [80] ( #0A )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #07 )
    COP [82]
    COP [85] ( @se_enemy_tree_seed_0FC0BE )
    COP [80] ( #06 )
    COP [82]
    BRA se_enemy_walking_tree_0FC01E

  loc_0FC096:
    COP [97]
    COP [80] ( #0A )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    COP [80] ( #07 )
    COP [82]
    COP [85] ( @se_enemy_tree_seed_0FC0BE )
    COP [80] ( #06 )
    COP [82]
    BRL se_enemy_walking_tree_0FC01E
}

---------------------------------------------
; Seed of the Walking Tree, animation $0C; falls through to loc_0FC0C1 of se_enemy_tree_seed_0FC0BE.
; 
; When: spawned by se_enemy_walking_tree_0FC01E.
; Sees: animation id $0C is stored in $1E, then the shared setup runs: $20 = 0, repeat count $2A = 6, $16 = $0200, Y - 8, drawn in front, priority $30, sound $5B, COP 91 and six animation loops, then COP 86.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_tree_seed_0FC0B4 {
    LDA #$000C
    BRA loc_0FC0C1
}

---------------------------------------------
; Seed of the Walking Tree, animation $0B; shares the setup with se_enemy_tree_seed_0FC0BE.
; 
; When: spawned by se_enemy_walking_tree_0FC01E.
; Sees: animation id $0B, then the shared setup (see se_enemy_tree_seed_0FC0B4).
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_tree_seed_0FC0B9 {
    LDA #$000B
    BRA loc_0FC0C1
}

---------------------------------------------
; Seed of the Walking Tree, animation $0D; holds the setup shared by the three seeds.
; 
; When: spawned by se_enemy_walking_tree_0FC01E (twice as often as the others: two of the four throws).
; Sees: animation id $0D; shared setup at loc_0FC0C1 as described at se_enemy_tree_seed_0FC0B4.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_tree_seed_0FC0BE {
    LDA #$000D

  loc_0FC0C1:
    STA $001E, X
    STZ $0020, X
    LDA #$0006
    STA $002A, X
    LDA #$0200
    STA $0016, X
    COP [A0] ( #$FFF8 )
    COP [A3]
    COP [A2] ( #30 )
    BRK #$5B
    COP [91]
    COP [83]
    COP [86]
    RTL 
}
---------------------------------------------

; The Monster Rock: sits still and tackles when the hero is close.
; 
; When: meta type $3B; spawned by the Monster Rock lairs.
; Sees: off screen it waits 16 frames per pass; with the hero outside its box widened by 4 (COP 0C) it plays animation $1D; otherwise COP 9C picks the axis and COP 9A / 9B (threshold $10) the side: it moves by animation $20 (sideways, flip by the side), $1F (up) or $1E (down), and a tile test (COP 23 / 24 / 21 / 22) stops it at a wall.
; Why: walkthrough: 'a dull gray rock ... easy enough to beat, but hard to find to the unattentive' and 'Tackling'.
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_enemy_monster_rock_0FC0E5 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC0F3
    COP [1B] ( &se_enemy_monster_rock_0FC0E5, #$0010 )

  loc_0FC0F3:
    COP [0C] ( #00, #04, &code_0FC100 )

  code_0FC0F9:
    COP [80] ( #1D )
    COP [82]
    BRA se_enemy_monster_rock_0FC0E5
}

code_0FC100 {
    COP [9C] ( &code_0FC106, &code_0FC12A )
}

code_0FC106 {
    COP [9A] ( #$0010, &code_0FC110, &code_0FC11D, &code_0FC11D )
}

code_0FC110 {
    COP [23] ( &code_0FC0F9 )
    COP [97]
    COP [80] ( #20 )
    COP [82]
    BRA code_0FC0F9
}

code_0FC11D {
    COP [24] ( &code_0FC0F9 )
    COP [96]
    COP [80] ( #20 )
    COP [82]
    BRA code_0FC0F9
}

code_0FC12A {
    COP [9B] ( #$0010, &code_0FC134, &code_0FC141, &code_0FC141 )
}

code_0FC134 {
    COP [21] ( &code_0FC0F9 )
    COP [97]
    COP [80] ( #1F )
    COP [82]
    BRA code_0FC0F9
}

code_0FC141 {
    COP [22] ( &code_0FC0F9 )
    COP [97]
    COP [80] ( #1E )
    COP [82]
    BRA code_0FC0F9
}
---------------------------------------------

; The Purple Fish: jumps out of the water at the hero and spits a bubble; lies down when the water is gone.
; 
; When: meta type $3C; placed (no lair), starts hidden ($2000).
; Sees: at spawn $30 = the tile_type_map index of the tile $10 above its position (PixelToMapIndex); then, with that byte non-zero ('water', inferred), it waits 8 frames while off screen and acts when the hero is within $60 pixels vertically: COP 9A picks the side, it clears $2000, spawns a splash, plays animation $2C, spawns a bubble (left or right) and a second splash, plays $2D, sets $2000 again, waits $78 frames (COP 03) and tests the tile again. With a zero byte (dry land) it clears $2000 and flops by animation $31, turning (COP 87) at walls.
; Why: walkthrough: 'fish flying out of the water' and 'you may even get a Purple Fish to lay down on it uselessly'.
; In: actor script, X = own slot; PixelToMapIndex returns the index in X.
; Out: loops for ever.
; Clobbers: A.

se_enemy_purple_fish_0FC14E {
    PHX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    TXA 
    PLX 
    STA $0030, X          ; $30 = tile_type_map index of the tile $10 above the fish (PixelToMapIndex returned it in X)

  code_0FC166:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC174

  code_0FC16E:
    COP [1B] ( &code_0FC166, #$0008 )

  loc_0FC174:
    PHX 
    LDA $0030, X
    TAX 
    LDA $tile_type_map, X ; non-zero = water (inferred), zero = dry land: the fish lies down and flops
    PLX 
    AND #$00FF
    BNE loc_0FC186
    BRL loc_0FC26E

  loc_0FC186:
    COP [9B] ( #$0060, &code_0FC16E, &code_0FC190, &code_0FC16E )
}

code_0FC190 {
    COP [9A] ( #$0000, &code_0FC19A, &code_0FC1C7, &code_0FC1C7 )
}

code_0FC19A {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [85] ( @se_enemy_fish_splash_0FC20D )
    COP [80] ( #2C )
    COP [82]
    COP [85] ( @se_enemy_fish_bubble_left_0FC223 )
    COP [80] ( #2D )
    COP [82]
    COP [85] ( @se_enemy_fish_splash_0FC20D )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    BRA loc_0FC1F6
}

code_0FC1C7 {
    COP [96]
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [85] ( @se_enemy_fish_splash_0FC20D )
    COP [80] ( #2C )
    COP [82]
    COP [85] ( @se_enemy_fish_bubble_right_0FC229 )
    COP [80] ( #2D )
    COP [82]
    COP [85] ( @se_enemy_fish_splash_0FC20D )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [97]

  loc_0FC1F6:
    COP [03] ( #78 )
    PHX 
    LDA $0030, X
    TAX 
    LDA $tile_type_map, X
    PLX 
    AND #$00FF
    BEQ loc_0FC26E
    COP [04]
    BRL code_0FC166
}

---------------------------------------------
; Splash of the Purple Fish.
; 
; When: spawned twice per jump by se_enemy_purple_fish_0FC14E.
; Sees: COP 28 jumps to code_0FC213 when the tile under it is non-zero (water, inferred); there $16 = $0300, drawn behind and animation $2E play; otherwise the splash just disappears.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_fish_splash_0FC20D {
    COP [28] ( &code_0FC213 ) ; COP 28 jumps when the tile under the splash is non-zero; otherwise the splash vanishes
    BRA loc_0FC220
}

code_0FC213 {
    LDA #$0300
    STA $0016, X
    COP [A4]
    COP [80] ( #2E )
    COP [82]

  loc_0FC220:
    COP [86]
    RTL 
}

---------------------------------------------
; Bubble of the Purple Fish, thrown to the left (x - 8); shares the body with se_enemy_fish_bubble_right_0FC229.
; 
; When: spawned by se_enemy_purple_fish_0FC14E when the hero is left of it.
; Sees: COP 9F adds -8 to x, then loc_0FC22D: $16 = $0200, drawn in front, priority $30, sound $5B, COP 9B ($20) picks animation $33 (hero above) / $32 (level) / $34 (below) ten times, then animation $39 and COP 86.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_fish_bubble_left_0FC223 {
    COP [9F] ( #$FFF8 )
    BRA loc_0FC22D
}

---------------------------------------------
; Bubble of the Purple Fish, thrown to the right (x + 8); runs the shared body at loc_0FC22D of se_enemy_fish_bubble_left_0FC223.
; 
; When: spawned by se_enemy_purple_fish_0FC14E when the hero is right of it.
; Sees: COP 9F adds +8 to x and falls into the shared body.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_fish_bubble_right_0FC229 {
    COP [9F] ( #$0008 )

  loc_0FC22D:
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [A2] ( #30 )
    BRK #$5B
    COP [9B] ( #$0020, &code_0FC244, &code_0FC252, &code_0FC260 )
}

code_0FC244 {
    COP [81] ( #33, #0A )
    COP [83]
    COP [80] ( #39 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC252 {
    COP [81] ( #32, #0A )
    COP [83]
    COP [80] ( #39 )
    COP [82]
    COP [86]
    RTL 
}

code_0FC260 {
    COP [81] ( #34, #0A )
    COP [83]
    COP [80] ( #39 )
    COP [82]
    COP [86]
    RTL 

  loc_0FC26E:
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    LDA $001C, X
    ASL 
    BMI loc_0FC283
    COP [23] ( &code_0FC289 )
    BRA loc_0FC28E

  loc_0FC283:
    COP [24] ( &code_0FC289 )
    BRA loc_0FC28E
}

code_0FC289 {
    COP [87]
    BRL code_0FC166

  loc_0FC28E:
    COP [80] ( #31 )
    COP [82]
    BRL code_0FC166
}
---------------------------------------------

; The Ape: turns toward the hero and throws rocks in the four directions.
; 
; When: meta type $3D; spawned by the Ape lairs.
; Sees: palette 2 (COP AA); off screen it waits 8 frames per pass; COP 9A / 9B (threshold $10) tell where the hero is: above or below it plays the wind-up animations ($0F, $15 or $0E, $14) and spawns se_enemy_ape_rock_up_0FC39C or se_enemy_ape_rock_down_0FC3B9; left or right it plays $10 / $16 (flip X set or clear) and spawns se_enemy_ape_rock_left_0FC362 or se_enemy_ape_rock_right_0FC37F; with the hero level it turns by animation $13, $12 or $11 first.
; Why: walkthrough: 'Rock-throwing; moving' and 'their tendency to group up' (magic works well).
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_enemy_ape_0FC296 {
    COP [AA] ( #02 )

  code_0FC299:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC2A7

  code_0FC2A1:
    COP [1B] ( &code_0FC299, #$0008 )

  loc_0FC2A7:
    COP [9A] ( #$0010, &code_0FC2B1, &code_0FC2C3, &code_0FC2BA )
}

code_0FC2B1 {
    COP [97]
    COP [80] ( #13 )
    COP [82]
    BRA code_0FC303
}

code_0FC2BA {
    COP [96]
    COP [80] ( #13 )
    COP [82]
    BRA code_0FC303
}

code_0FC2C3 {
    COP [9B] ( #$0010, &code_0FC2CD, &code_0FC303, &code_0FC2E8 )
}

code_0FC2CD {
    COP [97]
    COP [81] ( #0F, #02 )
    COP [83]
    COP [81] ( #15, #02 )
    COP [83]
    COP [85] ( @se_enemy_ape_rock_up_0FC39C )
    COP [81] ( #0F, #02 )
    COP [83]
    BRA code_0FC303
}

code_0FC2E8 {
    COP [97]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [81] ( #14, #02 )
    COP [83]
    COP [85] ( @se_enemy_ape_rock_down_0FC3B9 )
    COP [81] ( #0E, #02 )
    COP [83]
    BRA code_0FC303
}

code_0FC303 {
    COP [9B] ( #$0010, &code_0FC30D, &code_0FC320, &code_0FC316 )
}

code_0FC30D {
    COP [97]
    COP [80] ( #12 )
    COP [82]
    BRA code_0FC299
}

code_0FC316 {
    COP [97]
    COP [80] ( #11 )
    COP [82]
    BRL code_0FC299
}

code_0FC320 {
    COP [9A] ( #$0010, &code_0FC32A, &code_0FC2A1, &code_0FC346 )
}

code_0FC32A {
    COP [97]
    COP [81] ( #10, #02 )
    COP [83]
    COP [81] ( #16, #02 )
    COP [83]
    COP [85] ( @se_enemy_ape_rock_left_0FC362 )
    COP [81] ( #10, #02 )
    COP [83]
    BRL code_0FC2A1
}

code_0FC346 {
    COP [96]
    COP [81] ( #10, #02 )
    COP [83]
    COP [81] ( #16, #02 )
    COP [83]
    COP [85] ( @se_enemy_ape_rock_right_0FC37F )
    COP [81] ( #10, #02 )
    COP [83]
    BRL code_0FC2A1
}

---------------------------------------------
; Rock of the Ape thrown to the left.
; 
; When: spawned (COP 85) by the Ape.
; Sees: se_enemy_ape_rock_init_0FC3D6 sets it up, animation $1B (launch), then animation $37 repeats while COP 23 finds the tile to the left free; at a wall animation $38 (burst) and COP 86.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_ape_rock_left_0FC362 {
    JSR $&se_enemy_ape_rock_init_0FC3D6
    COP [80] ( #1B )
    COP [82]
    COP [A6]

  loc_0FC36C:
    COP [23] ( &code_0FC377 )
    COP [80] ( #37 )
    COP [82]
    BRA loc_0FC36C
}

code_0FC377 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Rock of the Ape thrown to the right.
; 
; When: spawned (COP 85) by the Ape.
; Sees: as se_enemy_ape_rock_left_0FC362 with COP 24 (tile to the right).
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_ape_rock_right_0FC37F {
    JSR $&se_enemy_ape_rock_init_0FC3D6
    COP [80] ( #1B )
    COP [82]
    COP [A6]

  loc_0FC389:
    COP [24] ( &code_0FC394 )
    COP [80] ( #37 )
    COP [82]
    BRA loc_0FC389
}

code_0FC394 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Rock of the Ape thrown upward.
; 
; When: spawned (COP 85) by the Ape.
; Sees: animation $19 (launch), then animation $36 repeats while COP 21 finds the tile above free; then $38 and COP 86.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_ape_rock_up_0FC39C {
    JSR $&se_enemy_ape_rock_init_0FC3D6
    COP [80] ( #19 )
    COP [82]
    COP [A6]

  loc_0FC3A6:
    COP [21] ( &code_0FC3B1 )
    COP [80] ( #36 )
    COP [82]
    BRA loc_0FC3A6
}

code_0FC3B1 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Rock of the Ape thrown downward.
; 
; When: spawned (COP 85) by the Ape.
; Sees: animation $17 (launch), then animation $35 repeats while COP 22 finds the tile below free; then $38 and COP 86.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_ape_rock_down_0FC3B9 {
    JSR $&se_enemy_ape_rock_init_0FC3D6
    COP [80] ( #17 )
    COP [82]
    COP [A6]

  loc_0FC3C3:
    COP [22] ( &code_0FC3CE )
    COP [80] ( #35 )
    COP [82]
    BRA loc_0FC3C3
}

code_0FC3CE {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Shared setup of the four Ape rocks (a subroutine).
; 
; When: JSR from each se_enemy_ape_rock_* script.
; Sees: $16 = $0202 (unhittable, deflects hits), palette 2, drawn in front, Y - $12, sound $61.
; In: X = slot of the rock.
; Out: RTS.
; Clobbers: A.

se_enemy_ape_rock_init_0FC3D6 {
    LDA #$0202
    STA $0016, X          ; $16 = $0202: unhittable ($0200) and deflects hits ($0002)
    COP [AA] ( #02 )
    COP [A3]
    COP [A0] ( #$FFEE )
    BRK #$61
    RTS 
}
---------------------------------------------

; The Metal Ape: an Ape that only the Zantetsu Sword hurts.
; 
; When: meta type $3E; spawned by lair records $8E and $B9.
; Sees: ORs $0400 into its $1A for good (metal class), palette 4 (COP AA); then the same script as se_enemy_ape_0FC296 with its own rocks (se_enemy_metal_ape_rock_*).
; Why: bestiary: 'Metal? Yes'; walkthrough: 'the Metal Ape lair will have to wait until we get the Zantetsu Sword'.
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_enemy_metal_ape_0FC3E8 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X          ; $1A bit $0400 for good: only the Zantetsu Sword hurts the Metal Ape
    COP [AA] ( #04 )

  code_0FC3F4:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FC402

  code_0FC3FC:
    COP [1B] ( &code_0FC3F4, #$0008 )

  loc_0FC402:
    COP [9A] ( #$0010, &code_0FC40C, &code_0FC41E, &code_0FC415 )
}

code_0FC40C {
    COP [97]
    COP [80] ( #13 )
    COP [82]
    BRA code_0FC458
}

code_0FC415 {
    COP [96]
    COP [80] ( #13 )
    COP [82]
    BRA code_0FC458
}

code_0FC41E {
    COP [9B] ( #$0010, &code_0FC428, &code_0FC458, &code_0FC440 )
}

code_0FC428 {
    COP [97]
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #15 )
    COP [82]
    COP [85] ( @se_enemy_metal_ape_rock_up_0FC4EA )
    COP [80] ( #0F )
    COP [82]
    BRA code_0FC458
}

code_0FC440 {
    COP [97]
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #14 )
    COP [82]
    COP [85] ( @se_enemy_metal_ape_rock_down_0FC507 )
    COP [80] ( #0E )
    COP [82]
    BRA code_0FC458
}

code_0FC458 {
    COP [9B] ( #$0010, &code_0FC462, &code_0FC474, &code_0FC46B )
}

code_0FC462 {
    COP [97]
    COP [80] ( #12 )
    COP [82]
    BRA code_0FC3F4
}

code_0FC46B {
    COP [97]
    COP [80] ( #11 )
    COP [82]
    BRA code_0FC3F4
}

code_0FC474 {
    COP [9A] ( #$0010, &code_0FC47E, &code_0FC3FC, &code_0FC497 )
}

code_0FC47E {
    COP [97]
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #16 )
    COP [82]
    COP [85] ( @se_enemy_metal_ape_rock_left_0FC4B0 )
    COP [80] ( #10 )
    COP [82]
    BRL code_0FC3FC
}

code_0FC497 {
    COP [96]
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #16 )
    COP [82]
    COP [85] ( @se_enemy_metal_ape_rock_right_0FC4CD )
    COP [80] ( #10 )
    COP [82]
    BRL code_0FC3FC
}

---------------------------------------------
; Rock of the Metal Ape thrown to the left; same flight as se_enemy_ape_rock_left_0FC362 with the setup se_enemy_metal_ape_rock_init_0FC524.
; 
; When: spawned (COP 85) by the Metal Ape.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_metal_ape_rock_left_0FC4B0 {
    JSR $&se_enemy_metal_ape_rock_init_0FC524
    COP [80] ( #1B )
    COP [82]
    COP [A6]

  loc_0FC4BA:
    COP [23] ( &code_0FC4C5 )
    COP [80] ( #37 )
    COP [82]
    BRA loc_0FC4BA
}

code_0FC4C5 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Rock of the Metal Ape thrown to the right; same flight as se_enemy_ape_rock_right_0FC37F.
; 
; When: spawned (COP 85) by the Metal Ape.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_metal_ape_rock_right_0FC4CD {
    JSR $&se_enemy_metal_ape_rock_init_0FC524
    COP [80] ( #1B )
    COP [82]
    COP [A6]

  loc_0FC4D7:
    COP [24] ( &code_0FC4E2 )
    COP [80] ( #37 )
    COP [82]
    BRA loc_0FC4D7
}

code_0FC4E2 {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Rock of the Metal Ape thrown upward; same flight as se_enemy_ape_rock_up_0FC39C.
; 
; When: spawned (COP 85) by the Metal Ape.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_metal_ape_rock_up_0FC4EA {
    JSR $&se_enemy_metal_ape_rock_init_0FC524
    COP [80] ( #19 )
    COP [82]
    COP [A6]

  loc_0FC4F4:
    COP [21] ( &code_0FC4FF )
    COP [80] ( #36 )
    COP [82]
    BRA loc_0FC4F4
}

code_0FC4FF {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Rock of the Metal Ape thrown downward; same flight as se_enemy_ape_rock_down_0FC3B9.
; 
; When: spawned (COP 85) by the Metal Ape.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_metal_ape_rock_down_0FC507 {
    JSR $&se_enemy_metal_ape_rock_init_0FC524
    COP [80] ( #17 )
    COP [82]
    COP [A6]

  loc_0FC511:
    COP [22] ( &code_0FC51C )
    COP [80] ( #35 )
    COP [82]
    BRA loc_0FC511
}

code_0FC51C {
    COP [80] ( #38 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Shared setup of the four Metal Ape rocks (a subroutine); like se_enemy_ape_rock_init_0FC3D6 with palette 4.
; 
; When: JSR from each se_enemy_metal_ape_rock_* script.
; Sees: $16 = $0202, palette 4, drawn in front, Y - $12, sound $61.
; In: X = slot of the rock.
; Out: RTS.
; Clobbers: A.

se_enemy_metal_ape_rock_init_0FC524 {
    LDA #$0202
    STA $0016, X
    COP [AA] ( #04 )
    COP [A3]
    COP [A0] ( #$FFEE )
    BRK #$61
    RTS 
}
---------------------------------------------

; The Tornadic Eagle: flies at the hero in eight directions and blows a tornado when it is on top of him.
; 
; When: meta type $3F; spawned by the Eagle lairs (three of them proximity lairs: $A6, $BB, $C0).
; Sees: drawn in front, priority $30; every 16 frames it tests the hero inside its box widened by $10 (COP 0C); then COP 9A / 9B (threshold $18) pick one of eight directions and it flies four animation repeats there (animations $21-$25 with flip X and Y), and when the hero is inside the box widened by 4 it first plays animations $26-$28 and spawns se_enemy_eagle_tornado_0FC6D7.
; Why: walkthrough: 'Flying; tornadoes'; 'a bit of a douche due to its speed'.
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_enemy_tornadic_eagle_0FC536 {
    COP [A3]
    COP [A2] ( #30 )

  code_0FC53B:
    COP [0C] ( #00, #10, &code_0FC547 )
    COP [1B] ( &code_0FC53B, #$0010 )
}

code_0FC547 {
    COP [9A] ( #$0018, &code_0FC551, &code_0FC619, &code_0FC55B )
}

code_0FC551 {
    COP [9B] ( #$0018, &code_0FC5BF, &code_0FC6AA, &code_0FC5EC )
}

code_0FC55B {
    COP [9B] ( #$0018, &code_0FC565, &code_0FC67D, &code_0FC592 )
}

code_0FC565 {
    COP [96]
    COP [81] ( #25, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC575 ) ; hero inside the box widened by 4: attack with a tornado, otherwise just fly
    BRA loc_0FC589
}

code_0FC575 {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @se_enemy_eagle_tornado_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC589:
    COP [81] ( #25, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC592 {
    COP [96]
    COP [81] ( #24, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC5A2 )
    BRA loc_0FC5B6
}

code_0FC5A2 {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @se_enemy_eagle_tornado_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC5B6:
    COP [81] ( #24, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC5BF {
    COP [97]
    COP [81] ( #25, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC5CF )
    BRA loc_0FC5E3
}

code_0FC5CF {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @se_enemy_eagle_tornado_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC5E3:
    COP [81] ( #25, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC5EC {
    COP [97]
    COP [81] ( #24, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC5FC )
    BRA loc_0FC610
}

code_0FC5FC {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @se_enemy_eagle_tornado_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC610:
    COP [81] ( #24, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC619 {
    COP [9B] ( #$0000, &code_0FC650, &code_0FC650, &code_0FC623 )
}

code_0FC623 {
    COP [97]
    COP [81] ( #21, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC633 )
    BRA loc_0FC647
}

code_0FC633 {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @se_enemy_eagle_tornado_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC647:
    COP [81] ( #21, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC650 {
    COP [97]
    COP [81] ( #22, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC660 )
    BRA loc_0FC674
}

code_0FC660 {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @se_enemy_eagle_tornado_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC674:
    COP [81] ( #22, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC67D {
    COP [96]
    COP [81] ( #23, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC68D )
    BRA loc_0FC6A1
}

code_0FC68D {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @se_enemy_eagle_tornado_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC6A1:
    COP [81] ( #23, #04 )
    COP [83]
    BRL code_0FC53B
}

code_0FC6AA {
    COP [97]
    COP [81] ( #23, #04 )
    COP [83]
    COP [0C] ( #00, #04, &code_0FC6BA )
    BRA loc_0FC6CE
}

code_0FC6BA {
    COP [80] ( #26 )
    COP [82]
    COP [85] ( @se_enemy_eagle_tornado_0FC6D7 )
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #28 )
    COP [82]

  loc_0FC6CE:
    COP [81] ( #23, #04 )
    COP [83]
    BRL code_0FC53B
}

---------------------------------------------
; The tornado of the Tornadic Eagle.
; 
; When: spawned (COP 85) by the eagle.
; Sees: $16 = $0200, Y + $1C, sound $56, animation $29; then COP 9A / 9B (threshold 0) pick the side by the hero's position and it plays animation $2A or $2B eight times (flip X and Y chosen by the side) and COP 86.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_eagle_tornado_0FC6D7 {
    LDA #$0200
    STA $0016, X
    COP [A0] ( #$001C )
    BRK #$56
    COP [80] ( #29 )
    COP [82]
    COP [9A] ( #$0000, &code_0FC6F2, &code_0FC6FC, &code_0FC6FC )
}

code_0FC6F2 {
    COP [9B] ( #$0000, &code_0FC706, &code_0FC710, &code_0FC710 )
}

code_0FC6FC {
    COP [9B] ( #$0000, &code_0FC71A, &code_0FC724, &code_0FC724 )
}

code_0FC706 {
    COP [97]
    COP [81] ( #2B, #08 )
    COP [83]
    BRA loc_0FC72C
}

code_0FC710 {
    COP [97]
    COP [81] ( #2A, #08 )
    COP [83]
    BRA loc_0FC72C
}

code_0FC71A {
    COP [96]
    COP [81] ( #2B, #08 )
    COP [83]
    BRA loc_0FC72C
}

code_0FC724 {
    COP [96]
    COP [81] ( #2A, #08 )
    COP [83]

  loc_0FC72C:
    COP [86]
    RTL 
}