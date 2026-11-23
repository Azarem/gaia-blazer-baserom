; The monsters and fixed hazards of the three outdoor areas of the World of Evil: the Purple Bull, the Firefly, the Wall Tile, the pop-up turret, the arc jet and an empty hazard type (file offsets 1042973-1044133, SNES $1F:EA1D-$1F:EEA5, bank 1F; 1,161 bytes). Scenes A14S01 (location $79), A14S02 ($7A) and A14S03 ($7B, the 'Dazzling Space'). Walkthrough chapter: docs/walkthrough/08-world-of-evil.md and enemy-bestiary.md.
; 
; === WHAT RUNS HERE ===
; One script per meta type $0A-$0F of MetaWorldOfEvil (row = type x 14; the stats are the first bytes of the row):
; - $0A Purple Bull, we_enemy_purple_bull_0FEA1D: attack $19, defence $0C, 45 HP, 2,700 EXP, flags $1000. A lair monster (lair records $197, $198, $19A, $19D, $1A0, $1A1, $1A2). The bestiary gives 23 HP: OQ-I033-2.
; - $0B Firefly, we_enemy_firefly_0FEB95: attack $18, defence $0C, 23 HP, 3,000 EXP, first animation $15. A lair monster (lair records $196, $199, $19B, $19C, $19E, $19F, $1A3).
; - $0C Wall Tile, we_enemy_wall_tile_0FECD9: attack $1D, defence 1, 10 HP, 4,000 EXP, animation $2A. Placed 16 times: A14S02 rows ;0A-;10 (7) and A14S03 rows ;07-;0F (9).
; - $0D pop-up turret, we_enemy_popup_turret_0FED09: attack $19, defence 0, 1 HP, no EXP, animation $2C, flags $2300. Placed 17 times: A14S01 rows ;10-;19 (10), A14S02 rows ;11-;12 (2), A14S03 rows ;10-;14 (5).
; - $0E arc jet, we_enemy_arc_jet_0FED8F: same stats as the turret, animation $29, flags $2000. Placed twice, A14S02 rows ;08-;09.
; - $0F static hazard, we_enemy_static_hazard_0FEEA5: the same row as the arc jet, but the script is a single RTL. Placed 12 times: A14S01 rows ;06-;0F (10), A14S02 rows ;06-;07 (2).
; Row byte +2 of a placement is the flip state (flags $01, $41, $81, $C1) that COP A5 reads in the Wall Tile and the arc jet.
; 
; === THE PURPLE BULL ===
; Two alternating modes. Row mode (we_enemy_purple_bull_0FEA1D): COP 9B on the vertical distance (threshold 0, then $18) walks the Bull up or down (animations 4 / 3, 1 / 0 when a tile test COP 21 / 22 says the way is blocked) until it is within $18 px of the hero's row; it then looks left or right (COP 9A) and fires a shot sideways (animations $0A-$0D and $06-$09 for the upper and lower variants). Column mode (loc_0FEA66): the same with COP 9A on the horizontal distance (COP 23 / 24 for the tile tests, animations 5 and 2), and the shot goes up or down (animations $0E-$11). After a sideways shot the script enters column mode, after a vertical one row mode. The four shot actors (spawned by COP B2 with flags $0200: they cannot be hit) play a single animation ($14 left and right, $13 up, $12 down) after BRK $52 and delete themselves; the script has no move command (OQ-I040-12).
; 
; === THE FIREFLY ===
; Waits until it is on screen (COP AD $10), then COP 9A / COP 9B (threshold $18, 0 in the hero's column) pick one of eight dash directions toward the hero. Every dash is the same sequence with its own animation set: face left or right (COP 96 / 97), a wind-up animation, $16 bit $0200 set (cannot be hit), the dash animation four times (COP 81), $0200 cleared, a rest animation, and a jump back to the direction test. Animations (wind-up, dash, rest): north-east / north-west $26-$28 and $19, south-east / south-west $23-$25 and $18, south $1A-$1C and $15, north $1D-$1F and $16, east / west $20-$22 and $17.
; 
; === THE WALL TILE ===
; Sets $1A bit $0200 (special immunity class: only the Soul Blade hurts it; the walkthrough: 'No; need Soul Blade'), then COP A5 jumps on the placement's flip state: none to we_enemy_wall_tile_slide_down_0FECEC, flip X to we_enemy_wall_tile_slide_up_0FECF9, flip Y or both to we_enemy_wall_tile_remove_0FED06 (the placements use only none and flip X). Each slide label sets or clears flip Y (COP 98 / 99), plays animation $2A in a loop and, when the tile in its direction is occupied (COP 22 below, COP 21 above), turns into the other: the tile bounces vertically between walls (the walkthrough: 'wait for a wall tile to come bouncing by'). Which flip state moves which way is OQ-I040-13.
; 
; === THE POP-UP TURRET, THE ARC JET AND THE STATIC HAZARD ===
; Turret: at spawn it stores the map index of the tile 16 px above its placement point in $30 and shifts itself by (+8, -15). Every 120 frames, while that tile's type in tile_type_map is not 0 and the turret is on screen, it unhides (clears $16 bit $2000), plays animation $2C, fires a shot (COP B2, flags $0200, which ends in the shared homing mover with Y = $2E), plays animation $2D and hides again; flag $0300 keeps it unhittable. When the tile type is 0 it deletes itself. The walkthrough speaks of lairs that 'open small alcoves in the fire walls'; that the tile type becomes 0 when a lair opens such a wall is inferred (OQ-I040-4).
; Arc jet: COP A5 on the flip state picks one of four directions (none up-right, X up-left, Y down-right, both down-left). Every 120 frames, once on screen, it plays BRK $5D and spawns 7 flames one frame apart (COP 03 with 7 passes, COP B0, flags $0200, animation $29). Flame n sits 16 x n px away in x (to the right or the left) and its y follows half of SineTable+$10 indexed by that distance, up or down: the flames form an arc.
; Static hazard: no behaviour. Its row has the arc jet's stats and animation $29 but flags $2000; what the 12 placements are for is OQ-I040-4.
; 
; === OPEN ===
; - Purple Bull HP 45 against the bestiary's 23: OQ-I033-2.
; - The purpose of types $0D, $0E and $0F, which the walkthrough does not name: OQ-I040-4.
; - The sounds $52, $5D and $64: OQ-I040-7.
; - How the Bull and turret shots move: OQ-I040-12. Wall Tile directions: OQ-I040-13.
; - Which walkthrough lair is which of the lair records $196-$1A3: OQ-I040-14.
---------------------------------------------

?BANK 1F

?INCLUDE 'data_engine_tables'
?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'shared_actor_helpers_bank0'

!tile_type_map                  7F8000

---------------------------------------------

; The Purple Bull: entry of the script, row mode.
; 
; When: meta type $0A of the World of Evil (attack $19, defence $0C, 45 HP, 2,700 EXP, flags $1000); lair monster of A14S01-03.
; Sees: COP AD (wait until on screen, $08), then COP 9B on the vertical distance with threshold 0: hero above goes to we_enemy_purple_bull_row_up, within or below to we_enemy_purple_bull_row_down.
; Why: the first half of the cycle: line up with the hero's row, fire sideways, then line up with the column (loc_0FEA66).
; In: actor script, X = own slot.
; Out: jumps to a row branch; the actor loops until it is killed.
; Clobbers: none (COP only).

we_enemy_purple_bull_0FEA1D {
    COP [AD] ( #08 )
    COP [9B] ( #$0000, &we_enemy_purple_bull_row_up_0FEA2A, &we_enemy_purple_bull_row_down_0FEA48, &we_enemy_purple_bull_row_down_0FEA48 ) ; threshold 0: hero above goes to row_up, within or below to row_down
}

---------------------------------------------
; The Bull in row mode, hero above.
; 
; When: the hero is above the Bull.
; Sees: COP 97 (faces left), then COP 9B with threshold $18: at least $18 px above or below goes to we_enemy_purple_bull_walk_up, within $18 px to we_enemy_purple_bull_side_shot_upper.
; Why: walk up until the hero's row is reached, then fire.
; In: actor script, X = own slot.
; Out: jumps on.
; Clobbers: none (COP only).

we_enemy_purple_bull_row_up_0FEA2A {
    COP [97]
    COP [9B] ( #$0018, &we_enemy_purple_bull_walk_up_0FEA36, &we_enemy_purple_bull_side_shot_upper_0FEAE9, &we_enemy_purple_bull_walk_up_0FEA36 )
}

---------------------------------------------
; One step of the Bull's walk up.
; 
; When: the hero is more than $18 px above.
; Sees: COP 21 (tile above occupied goes to we_enemy_purple_bull_blocked_up), animation 4, COP 82 (wait), back to the entry.
; Why: re-evaluate after every step.
; In: actor script, X = own slot.
; Out: BRA to we_enemy_purple_bull_0FEA1D.
; Clobbers: none (COP only).

we_enemy_purple_bull_walk_up_0FEA36 {
    COP [21] ( &we_enemy_purple_bull_blocked_up_0FEA41 )
    COP [80] ( #04 )
    COP [82]
    BRA we_enemy_purple_bull_0FEA1D
}

---------------------------------------------
; The Bull stands still because the way up is blocked.
; 
; When: COP 21 found the tile above occupied.
; Sees: animation 1, COP 82, back to the entry.
; Why: the idle pose that faces the wall.
; In: actor script, X = own slot.
; Out: BRA to we_enemy_purple_bull_0FEA1D.
; Clobbers: none (COP only).

we_enemy_purple_bull_blocked_up_0FEA41 {
    COP [80] ( #01 )
    COP [82]
    BRA we_enemy_purple_bull_0FEA1D
}

---------------------------------------------
; The Bull in row mode, hero level with it or below.
; 
; When: the hero is within the Bull's row or below it.
; Sees: COP 97, then COP 9B with threshold $18: at least $18 px above or below goes to we_enemy_purple_bull_walk_down, within $18 px to we_enemy_purple_bull_side_shot_lower.
; Why: mirror of we_enemy_purple_bull_row_up with the lower shot.
; In: actor script, X = own slot.
; Out: jumps on.
; Clobbers: none (COP only).

we_enemy_purple_bull_row_down_0FEA48 {
    COP [97]
    COP [9B] ( #$0018, &we_enemy_purple_bull_walk_down_0FEA54, &we_enemy_purple_bull_side_shot_lower_0FEB23, &we_enemy_purple_bull_walk_down_0FEA54 )
}

---------------------------------------------
; One step of the Bull's walk down.
; 
; When: the hero is more than $18 px away vertically.
; Sees: COP 22 (tile below occupied goes to we_enemy_purple_bull_blocked_down), animation 3, COP 82, back to the entry.
; Why: re-evaluate after every step.
; In: actor script, X = own slot.
; Out: BRA to we_enemy_purple_bull_0FEA1D.
; Clobbers: none (COP only).

we_enemy_purple_bull_walk_down_0FEA54 {
    COP [22] ( &we_enemy_purple_bull_blocked_down_0FEA5F )
    COP [80] ( #03 )
    COP [82]
    BRA we_enemy_purple_bull_0FEA1D
}

---------------------------------------------
; The Bull stands still because the way down is blocked.
; 
; When: COP 22 found the tile below occupied.
; Sees: animation 0, COP 82, back to the entry. The label that follows in the file, loc_0FEA66, is the entry of column mode.
; Why: the idle pose that faces the wall.
; In: actor script, X = own slot.
; Out: BRA to we_enemy_purple_bull_0FEA1D.
; Clobbers: none (COP only).

we_enemy_purple_bull_blocked_down_0FEA5F {
    COP [80] ( #00 )
    COP [82]
    BRA we_enemy_purple_bull_0FEA1D

  loc_0FEA66:
    COP [AD] ( #08 )      ; column mode: the Bull walks sideways to the hero's column, then fires up or down
    COP [9A] ( #$0000, &we_enemy_purple_bull_column_left_0FEA73, &we_enemy_purple_bull_column_right_0FEA91, &we_enemy_purple_bull_column_right_0FEA91 )
}

---------------------------------------------
; The Bull in column mode, hero to the left.
; 
; When: loc_0FEA66 found the hero left of the Bull (COP 9A, threshold 0).
; Sees: COP 9A with threshold $18: at least $18 px away goes to we_enemy_purple_bull_walk_left, within goes to we_enemy_purple_bull_vertical_shot.
; Why: walk sideways until the hero's column is reached, then fire up or down.
; In: actor script, X = own slot.
; Out: jumps on.
; Clobbers: none (COP only).

we_enemy_purple_bull_column_left_0FEA73 {
    COP [9A] ( #$0018, &we_enemy_purple_bull_walk_left_0FEA7D, &we_enemy_purple_bull_vertical_shot_0FEAAF, &we_enemy_purple_bull_walk_left_0FEA7D )
}

---------------------------------------------
; One step of the Bull's walk to the left.
; 
; When: the hero is more than $18 px to the left.
; Sees: COP 97 (faces left), COP 23 (tile left occupied goes to we_enemy_purple_bull_blocked_left), animation 5, COP 82, back to loc_0FEA66.
; Why: re-evaluate after every step.
; In: actor script, X = own slot.
; Out: BRA to loc_0FEA66.
; Clobbers: none (COP only).

we_enemy_purple_bull_walk_left_0FEA7D {
    COP [97]
    COP [23] ( &we_enemy_purple_bull_blocked_left_0FEA8A )
    COP [80] ( #05 )
    COP [82]
    BRA loc_0FEA66
}

---------------------------------------------
; The Bull stands still because the way left is blocked.
; 
; When: COP 23 found the tile to the left occupied.
; Sees: animation 2, COP 82, back to loc_0FEA66.
; Why: the idle pose.
; In: actor script, X = own slot.
; Out: BRA to loc_0FEA66.
; Clobbers: none (COP only).

we_enemy_purple_bull_blocked_left_0FEA8A {
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FEA66
}

---------------------------------------------
; The Bull in column mode, hero level with it or to the right.
; 
; When: loc_0FEA66 found the hero within or right of the Bull.
; Sees: COP 9A with threshold $18: at least $18 px away goes to we_enemy_purple_bull_walk_right, within goes to we_enemy_purple_bull_vertical_shot.
; Why: mirror of we_enemy_purple_bull_column_left.
; In: actor script, X = own slot.
; Out: jumps on.
; Clobbers: none (COP only).

we_enemy_purple_bull_column_right_0FEA91 {
    COP [9A] ( #$0018, &we_enemy_purple_bull_walk_right_0FEA9B, &we_enemy_purple_bull_vertical_shot_0FEAAF, &we_enemy_purple_bull_walk_right_0FEA9B )
}

---------------------------------------------
; One step of the Bull's walk to the right.
; 
; When: the hero is more than $18 px to the right.
; Sees: COP 96 (faces right), COP 24 (tile right occupied goes to we_enemy_purple_bull_blocked_right), animation 5, COP 82, back to loc_0FEA66.
; Why: re-evaluate after every step.
; In: actor script, X = own slot.
; Out: BRA to loc_0FEA66.
; Clobbers: none (COP only).

we_enemy_purple_bull_walk_right_0FEA9B {
    COP [96]
    COP [24] ( &we_enemy_purple_bull_blocked_right_0FEAA8 )
    COP [80] ( #05 )
    COP [82]
    BRA loc_0FEA66
}

---------------------------------------------
; The Bull stands still because the way right is blocked.
; 
; When: COP 24 found the tile to the right occupied.
; Sees: animation 2, COP 82, back to loc_0FEA66.
; Why: the idle pose.
; In: actor script, X = own slot.
; Out: BRA to loc_0FEA66.
; Clobbers: none (COP only).

we_enemy_purple_bull_blocked_right_0FEAA8 {
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FEA66
}

---------------------------------------------
; The Bull is in the hero's column and picks the vertical shot.
; 
; When: column mode reached the hero's column.
; Sees: COP 9B with threshold 0: hero above goes to we_enemy_purple_bull_vertical_shot_up, within or below to we_enemy_purple_bull_vertical_shot_down.
; Why: fire toward the hero.
; In: actor script, X = own slot.
; Out: jumps on.
; Clobbers: none (COP only).

we_enemy_purple_bull_vertical_shot_0FEAAF {
    COP [9B] ( #$0000, &we_enemy_purple_bull_vertical_shot_up_0FEAB9, &we_enemy_purple_bull_vertical_shot_down_0FEAD1, &we_enemy_purple_bull_vertical_shot_down_0FEAD1 )
}

---------------------------------------------
; The Bull fires up.
; 
; When: the hero is above in the Bull's column.
; Sees: animation $0E, COP B2 spawning we_enemy_purple_bull_shot_up at (-8,-$18) with flags $0200, animation $0F, then BRL to the entry (row mode).
; Why: the wind-up and recovery animations around the shot.
; In: actor script, X = own slot.
; Out: BRL to we_enemy_purple_bull_0FEA1D.
; Clobbers: Y (the new actor).

we_enemy_purple_bull_vertical_shot_up_0FEAB9 {
    COP [80] ( #0E )
    COP [82]
    COP [B2] ( @we_enemy_purple_bull_shot_up_0FEB7B, #$FFF8, #$FFE8, #$0200 ) ; the shot: offset (-8,-$18) from the Bull, flags $0200 (cannot be hit)
    COP [80] ( #0F )
    COP [82]
    BRL we_enemy_purple_bull_0FEA1D
}

---------------------------------------------
; The Bull fires down.
; 
; When: the hero is level with or below the Bull in its column.
; Sees: animation $10, COP B2 spawning we_enemy_purple_bull_shot_down at (-8,8) with flags $0200, animation $11, then BRL to the entry.
; Why: the wind-up and recovery animations around the shot.
; In: actor script, X = own slot.
; Out: BRL to we_enemy_purple_bull_0FEA1D.
; Clobbers: Y (the new actor).

we_enemy_purple_bull_vertical_shot_down_0FEAD1 {
    COP [80] ( #10 )
    COP [82]
    COP [B2] ( @we_enemy_purple_bull_shot_down_0FEB88, #$FFF8, #$0008, #$0200 )
    COP [80] ( #11 )
    COP [82]
    BRL we_enemy_purple_bull_0FEA1D
}

---------------------------------------------
; The Bull has reached the hero's row from below and picks the sideways shot.
; 
; When: we_enemy_purple_bull_row_up found the hero within $18 px vertically.
; Sees: COP 9A with threshold 0: hero left goes to we_enemy_purple_bull_side_shot_upper_left, within or right to we_enemy_purple_bull_side_shot_upper_right.
; Why: fire toward the hero.
; In: actor script, X = own slot.
; Out: jumps on.
; Clobbers: none (COP only).

we_enemy_purple_bull_side_shot_upper_0FEAE9 {
    COP [9A] ( #$0000, &we_enemy_purple_bull_side_shot_upper_left_0FEAF3, &we_enemy_purple_bull_side_shot_upper_right_0FEB0B, &we_enemy_purple_bull_side_shot_upper_right_0FEB0B )
}

---------------------------------------------
; The Bull fires left (upper variant).
; 
; When: hero to the left, row reached from the upper side.
; Sees: animation $0C, COP B2 spawning we_enemy_purple_bull_shot_left at (-8,8) with flags $0200, animation $0D, BRL to loc_0FEA66 (column mode).
; Why: the wind-up and recovery animations around the shot.
; In: actor script, X = own slot.
; Out: BRL to loc_0FEA66.
; Clobbers: Y (the new actor).

we_enemy_purple_bull_side_shot_upper_left_0FEAF3 {
    COP [80] ( #0C )
    COP [82]
    COP [B2] ( @we_enemy_purple_bull_shot_left_0FEB5D, #$FFF8, #$0008, #$0200 )
    COP [80] ( #0D )
    COP [82]
    BRL loc_0FEA66
}

---------------------------------------------
; The Bull fires right (upper variant).
; 
; When: hero within or to the right, row reached from the upper side.
; Sees: animation $0A, COP B2 spawning we_enemy_purple_bull_shot_right at ($18,8) with flags $0200, animation $0B, BRL to loc_0FEA66.
; Why: the wind-up and recovery animations around the shot.
; In: actor script, X = own slot.
; Out: BRL to loc_0FEA66.
; Clobbers: Y (the new actor).

we_enemy_purple_bull_side_shot_upper_right_0FEB0B {
    COP [80] ( #0A )
    COP [82]
    COP [B2] ( @we_enemy_purple_bull_shot_right_0FEB6C, #$0018, #$0008, #$0200 )
    COP [80] ( #0B )
    COP [82]
    BRL loc_0FEA66
}

---------------------------------------------
; The Bull has reached the hero's row from above and picks the sideways shot.
; 
; When: we_enemy_purple_bull_row_down found the hero within $18 px vertically.
; Sees: COP 9A with threshold 0: hero left goes to we_enemy_purple_bull_side_shot_lower_left, within or right to we_enemy_purple_bull_side_shot_lower_right.
; Why: fire toward the hero.
; In: actor script, X = own slot.
; Out: jumps on.
; Clobbers: none (COP only).

we_enemy_purple_bull_side_shot_lower_0FEB23 {
    COP [9A] ( #$0000, &we_enemy_purple_bull_side_shot_lower_left_0FEB2D, &we_enemy_purple_bull_side_shot_lower_right_0FEB45, &we_enemy_purple_bull_side_shot_lower_right_0FEB45 )
}

---------------------------------------------
; The Bull fires left (lower variant).
; 
; When: hero to the left, row reached from the lower side.
; Sees: animation 6, COP B2 spawning we_enemy_purple_bull_shot_left at (-8,8) with flags $0200, animation 7, BRL to loc_0FEA66.
; Why: the wind-up and recovery animations around the shot.
; In: actor script, X = own slot.
; Out: BRL to loc_0FEA66.
; Clobbers: Y (the new actor).

we_enemy_purple_bull_side_shot_lower_left_0FEB2D {
    COP [80] ( #06 )
    COP [82]
    COP [B2] ( @we_enemy_purple_bull_shot_left_0FEB5D, #$FFF8, #$0008, #$0200 )
    COP [80] ( #07 )
    COP [82]
    BRL loc_0FEA66
}

---------------------------------------------
; The Bull fires right (lower variant).
; 
; When: hero within or to the right, row reached from the lower side.
; Sees: animation 8, COP B2 spawning we_enemy_purple_bull_shot_right at ($18,8) with flags $0200, animation 9, BRL to loc_0FEA66.
; Why: the wind-up and recovery animations around the shot.
; In: actor script, X = own slot.
; Out: BRL to loc_0FEA66.
; Clobbers: Y (the new actor).

we_enemy_purple_bull_side_shot_lower_right_0FEB45 {
    COP [80] ( #08 )
    COP [82]
    COP [B2] ( @we_enemy_purple_bull_shot_right_0FEB6C, #$0018, #$0008, #$0200 )
    COP [80] ( #09 )
    COP [82]
    BRL loc_0FEA66
}

---------------------------------------------
; The Bull's shot to the left (the walkthrough's 'energy waves').
; 
; When: spawned by the two left-firing labels (flags $0200: cannot be hit).
; Sees: COP A3 (drawn in front), COP 97 (faces left), BRK $52, animation $14 repeated 8 times (COP 81 / 83), then COP 86 (delete).
; Why: the script has no move command, so the flight is in the animation data or elsewhere (OQ-I040-12).
; In: X = D = the shot.
; Out: RTL after the delete.
; Clobbers: none (COP only).

we_enemy_purple_bull_shot_left_0FEB5D {
    COP [A3]
    COP [97]
    BRK #$52
    COP [81] ( #14, #08 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; The Bull's shot to the right.
; 
; When: spawned by the two right-firing labels (flags $0200).
; Sees: COP A3, COP 96 (faces right), BRK $52, animation $14 repeated 8 times, COP 86.
; Why: mirror of we_enemy_purple_bull_shot_left.
; In: X = D = the shot.
; Out: RTL after the delete.
; Clobbers: none (COP only).

we_enemy_purple_bull_shot_right_0FEB6C {
    COP [A3]
    COP [96]
    BRK #$52
    COP [81] ( #14, #08 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; The Bull's shot upward.
; 
; When: spawned by we_enemy_purple_bull_vertical_shot_up (flags $0200).
; Sees: COP A3, BRK $52, animation $13 repeated 8 times, COP 86.
; Why: as the sideways shots, with the vertical animation.
; In: X = D = the shot.
; Out: RTL after the delete.
; Clobbers: none (COP only).

we_enemy_purple_bull_shot_up_0FEB7B {
    COP [A3]
    BRK #$52
    COP [81] ( #13, #08 )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; The Bull's shot downward.
; 
; When: spawned by we_enemy_purple_bull_vertical_shot_down (flags $0200).
; Sees: COP A3, BRK $52, animation $12 repeated 8 times, COP 86.
; Why: as the sideways shots, with the vertical animation.
; In: X = D = the shot.
; Out: RTL after the delete.
; Clobbers: none (COP only).

we_enemy_purple_bull_shot_down_0FEB88 {
    COP [A3]
    BRK #$52
    COP [81] ( #12, #08 )
    COP [83]
    COP [86]
    RTL 
}
---------------------------------------------

; The Firefly: waits for the hero, then dashes at him.
; 
; When: meta type $0B (attack $18, defence $0C, 23 HP, 3,000 EXP); lair monster of A14S01-03. The bestiary: 'running around fast'.
; Sees: COP AD (wait until on screen, $10); loc_0FEB98 is the decision point every dash returns to: COP 9A on the horizontal distance with threshold $18: hero left goes to we_enemy_firefly_hero_left, within to we_enemy_firefly_hero_in_column, right to we_enemy_firefly_hero_right.
; Why: the Firefly always dashes after a short rest, so it never stands still near the hero.
; In: actor script, X = own slot.
; Out: jumps on; loops until it is killed.
; Clobbers: none (COP only).

we_enemy_firefly_0FEB95 {
    COP [AD] ( #10 )

  loc_0FEB98:
    COP [9A] ( #$0018, &we_enemy_firefly_hero_left_0FEBA2, &we_enemy_firefly_hero_in_column_0FEBB6, &we_enemy_firefly_hero_right_0FEBAC )
}

---------------------------------------------
; The Firefly picks a dash to the left half.
; 
; When: the hero is at least $18 px to its left.
; Sees: COP 9B on the vertical distance (threshold $18): above goes to we_enemy_firefly_dash_nw, within to we_enemy_firefly_dash_w, below to we_enemy_firefly_dash_sw.
; Why: eight dash directions in all.
; In: actor script, X = own slot.
; Out: jumps on.
; Clobbers: none (COP only).

we_enemy_firefly_hero_left_0FEBA2 {
    COP [9B] ( #$0018, &we_enemy_firefly_dash_nw_0FEBC4, &we_enemy_firefly_dash_w_0FECA3, &we_enemy_firefly_dash_sw_0FEBFD )
}

---------------------------------------------
; The Firefly picks a dash to the right half.
; 
; When: the hero is at least $18 px to its right.
; Sees: COP 9B (threshold $18): above goes to we_enemy_firefly_dash_ne, within to we_enemy_firefly_dash_e, below to we_enemy_firefly_dash_se.
; Why: mirror of we_enemy_firefly_hero_left.
; In: actor script, X = own slot.
; Out: jumps on.
; Clobbers: none (COP only).

we_enemy_firefly_hero_right_0FEBAC {
    COP [9B] ( #$0018, &we_enemy_firefly_dash_ne_0FEBC0, &we_enemy_firefly_dash_e_0FEC9F, &we_enemy_firefly_dash_se_0FEBF9 )
}

---------------------------------------------
; The Firefly picks a dash straight up or down.
; 
; When: the hero is within $18 px of its column.
; Sees: COP 9B with threshold 0: above goes to we_enemy_firefly_dash_n, within or below to we_enemy_firefly_dash_s.
; Why: the two vertical dashes.
; In: actor script, X = own slot.
; Out: jumps on.
; Clobbers: none (COP only).

we_enemy_firefly_hero_in_column_0FEBB6 {
    COP [9B] ( #$0000, &we_enemy_firefly_dash_n_0FEC69, &we_enemy_firefly_dash_s_0FEC33, &we_enemy_firefly_dash_s_0FEC33 )
}

---------------------------------------------
; The Firefly dashes north-east.
; 
; When: the hero is up and to the right.
; Sees: COP 96 (faces right), then falls into the shared sequence of we_enemy_firefly_dash_nw at loc_0FEBC6.
; Why: the two diagonal dashes share one body.
; In: actor script, X = own slot.
; Out: BRA to loc_0FEBC6.
; Clobbers: none (COP only).

we_enemy_firefly_dash_ne_0FEBC0 {
    COP [96]
    BRA loc_0FEBC6
}

---------------------------------------------
; The Firefly dashes north-west (and north-east through loc_0FEBC6).
; 
; When: the hero is up and to the left.
; Sees: COP 97 (faces left); at loc_0FEBC6: animation $26, $16 bit $0200 set (cannot be hit), animation $27, animation $28 four times, animation $27, bit $0200 cleared, animation $26, rest animation $19, then back to loc_0FEB98.
; Why: the dash is invulnerable; the hero can hit the Firefly only before and after it.
; In: actor script, X = own slot.
; Out: BRA to loc_0FEB98.
; Clobbers: A.

we_enemy_firefly_dash_nw_0FEBC4 {
    COP [97]

  loc_0FEBC6:
    COP [80] ( #26 )
    COP [82]
    LDA $0016, X
    ORA #$0200            ; $16 bit $0200: it cannot be hit during the dash
    STA $0016, X
    COP [80] ( #27 )
    COP [82]
    COP [81] ( #28, #04 )
    COP [83]
    COP [80] ( #27 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #19 )
    COP [82]
    BRA loc_0FEB98
}

---------------------------------------------
; The Firefly dashes south-east.
; 
; When: the hero is down and to the right.
; Sees: COP 96 (faces right), then falls into the shared sequence at loc_0FEBFF.
; Why: the two south-east / south-west dashes share one body.
; In: actor script, X = own slot.
; Out: BRA to loc_0FEBFF.
; Clobbers: none (COP only).

we_enemy_firefly_dash_se_0FEBF9 {
    COP [96]
    BRA loc_0FEBFF
}

---------------------------------------------
; The Firefly dashes south-west (and south-east through loc_0FEBFF).
; 
; When: the hero is down and to the left.
; Sees: COP 97; at loc_0FEBFF: animation $23, bit $0200 set, animation $24, animation $25 four times, animation $24, bit cleared, animation $23, rest animation $18, back to loc_0FEB98.
; Why: as the north-west dash.
; In: actor script, X = own slot.
; Out: BRL to loc_0FEB98.
; Clobbers: A.

we_enemy_firefly_dash_sw_0FEBFD {
    COP [97]

  loc_0FEBFF:
    COP [80] ( #23 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #24 )
    COP [82]
    COP [81] ( #25, #04 )
    COP [83]
    COP [80] ( #24 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #23 )
    COP [82]
    COP [80] ( #18 )
    COP [82]
    BRL loc_0FEB98
}

---------------------------------------------
; The Firefly dashes straight south.
; 
; When: the hero is in its column, level with it or below.
; Sees: COP 97, animation $1A, bit $0200 set, animation $1B, animation $1C four times, animation $1B, bit cleared, animation $1A, rest animation $15, back to loc_0FEB98.
; Why: as the north-west dash.
; In: actor script, X = own slot.
; Out: BRL to loc_0FEB98.
; Clobbers: A.

we_enemy_firefly_dash_s_0FEC33 {
    COP [97]
    COP [80] ( #1A )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #1B )
    COP [82]
    COP [81] ( #1C, #04 )
    COP [83]
    COP [80] ( #1B )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #1A )
    COP [82]
    COP [80] ( #15 )
    COP [82]
    BRL loc_0FEB98
}

---------------------------------------------
; The Firefly dashes straight north.
; 
; When: the hero is in its column, above it.
; Sees: COP 97, animation $1D, bit $0200 set, animation $1E, animation $1F four times, animation $1E, bit cleared, animation $1D, rest animation $16, back to loc_0FEB98.
; Why: as the north-west dash.
; In: actor script, X = own slot.
; Out: BRL to loc_0FEB98.
; Clobbers: A.

we_enemy_firefly_dash_n_0FEC69 {
    COP [97]
    COP [80] ( #1D )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #1E )
    COP [82]
    COP [81] ( #1F, #04 )
    COP [83]
    COP [80] ( #1E )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #16 )
    COP [82]
    BRL loc_0FEB98
}

---------------------------------------------
; The Firefly dashes east.
; 
; When: the hero is to the right, within $18 px vertically.
; Sees: COP 96 (faces right), then falls into the shared sequence at loc_0FECA5.
; Why: east and west share one body.
; In: actor script, X = own slot.
; Out: BRA to loc_0FECA5.
; Clobbers: none (COP only).

we_enemy_firefly_dash_e_0FEC9F {
    COP [96]
    BRA loc_0FECA5
}

---------------------------------------------
; The Firefly dashes west (and east through loc_0FECA5).
; 
; When: the hero is to the left, within $18 px vertically.
; Sees: COP 97; at loc_0FECA5: animation $20, bit $0200 set, animation $21, animation $22 four times, animation $21, bit cleared, animation $20, rest animation $17, back to loc_0FEB98.
; Why: as the north-west dash.
; In: actor script, X = own slot.
; Out: BRL to loc_0FEB98.
; Clobbers: A.

we_enemy_firefly_dash_w_0FECA3 {
    COP [97]

  loc_0FECA5:
    COP [80] ( #20 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #21 )
    COP [82]
    COP [81] ( #22, #04 )
    COP [83]
    COP [80] ( #21 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #17 )
    COP [82]
    BRL loc_0FEB98
}
---------------------------------------------

; The Wall Tile: a bouncing wall that only the Soul Blade hurts.
; 
; When: meta type $0C (attack $1D, defence 1, 10 HP, 4,000 EXP); placed 16 times in A14S02 and A14S03. The bestiary: 'Moving; need Soul Blade'.
; Sees: $1A bit $0200 set (special immunity class), then COP A5 on the placement's flip state: none to we_enemy_wall_tile_slide_down, flip X to we_enemy_wall_tile_slide_up, flip Y or both to we_enemy_wall_tile_remove.
; Why: the flip bits of the placement choose the starting direction (OQ-I040-13).
; In: actor script, X = own slot.
; Out: jumps on.
; Clobbers: A.

we_enemy_wall_tile_0FECD9 {
    LDA $001A, X
    ORA #$0200            ; $1A bit $0200: special immunity class (only the Soul Blade hurts it)
    STA $001A, X
    COP [A5] ( &we_enemy_wall_tile_slide_down_0FECEC, &we_enemy_wall_tile_slide_up_0FECF9, &we_enemy_wall_tile_remove_0FED06, &we_enemy_wall_tile_remove_0FED06 ) ; flip state of the placement: none down, X up, Y or both delete (unused)
}

---------------------------------------------
; The Wall Tile moves down until the tile below is occupied.
; 
; When: flip state none, or the upward slide hit a wall.
; Sees: COP 99 (clears flip Y), then at loc_0FECEE a loop: COP 22 (tile below occupied goes to we_enemy_wall_tile_slide_up), animation $2A, COP 82, repeat.
; Why: the motion is part of animation $2A with the flip state; the script only tests for walls.
; In: actor script, X = own slot.
; Out: jumps to we_enemy_wall_tile_slide_up at the wall.
; Clobbers: none (COP only).

we_enemy_wall_tile_slide_down_0FECEC {
    COP [99]

  loc_0FECEE:
    COP [22] ( &we_enemy_wall_tile_slide_up_0FECF9 )
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FECEE
}

---------------------------------------------
; The Wall Tile moves up until the tile above is occupied.
; 
; When: flip state X, or the downward slide hit a wall.
; Sees: COP 98 (sets flip Y), then at loc_0FECFB a loop: COP 21 (tile above occupied goes to we_enemy_wall_tile_slide_down), animation $2A, COP 82, repeat.
; Why: mirror of we_enemy_wall_tile_slide_down.
; In: actor script, X = own slot.
; Out: jumps to we_enemy_wall_tile_slide_down at the wall.
; Clobbers: none (COP only).

we_enemy_wall_tile_slide_up_0FECF9 {
    COP [98]

  loc_0FECFB:
    COP [21] ( &we_enemy_wall_tile_slide_down_0FECEC )
    COP [80] ( #2A )
    COP [82]
    BRA loc_0FECFB
}

---------------------------------------------
; Deletes a Wall Tile with an unused flip state.
; 
; When: COP A5 found flip Y or both; no placement uses them.
; Sees: COP 86 (delete), RTL.
; Why: the fourth and third cases of the COP A5 table need a target.
; In: X = D = the actor.
; Out: RTL.
; Clobbers: none (COP only).

we_enemy_wall_tile_remove_0FED06 {
    COP [86]
    RTL 
}
---------------------------------------------

; The pop-up turret: a hidden gun in a wall that shows itself to fire.
; 
; When: meta type $0D (attack $19, defence 0, 1 HP, flags $2300); placed 17 times in A14S01-03.
; Sees: the placement point (x, y - $10) is turned into a map index by lib_map_index_helpers.PixelToMapIndex and stored in $30; COP A1 shifts the actor by (+8,-15); falls into we_enemy_popup_turret_loop_0FED27.
; Why: the stored index lets the loop test whether the wall tile is still there.
; In: actor script, X = own slot.
; Out: falls through.
; Clobbers: A, Y.

we_enemy_popup_turret_0FED09 {
    PHX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex ; map index of the tile 16 px above the placement point
    TXA 
    PLX 
    STA $0030, X
    COP [A1] ( #$0008, #$FFF1 )

; The turret's cycle.
; 
; When: every 120 frames while the wall tile exists.
; Sees: COP AD ($10, wait until on screen); the tile type in tile_type_map at the index in $30: 0 deletes the actor; otherwise $16 bit $2000 cleared (visible), animation $2C, COP A0 (+8), a shot spawned by COP B2 (we_enemy_popup_turret_shot, flags $0200), animation $2D, COP A0 (-8), $2000 set (hidden), COP 1B with $78 frames back to the loop.
; Why: the turret fires while the tile is non-zero and goes away once it is 0 (inferred: the lair has opened the wall, OQ-I040-4).
; In: actor script, X = own slot.
; Out: never returns.
; Clobbers: A.

  we_enemy_popup_turret_loop_0FED27:
    COP [AD] ( #10 )
    PHX 
    LDA $0030, X
    TAX 
    LDA $tile_type_map, X ; tile type of that tile: 0 deletes the turret (inferred: the wall has opened, OQ-I040-4)
    PLX 
    AND #$00FF
    BEQ loc_0FED6E
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #2C )
    COP [82]
    COP [A0] ( #$0008 )
    COP [B2] ( @we_enemy_popup_turret_shot_0FED71, #$0000, #$0000, #$0200 )
    COP [80] ( #2D )
    COP [82]
    COP [A0] ( #$FFF8 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [1B] ( &we_enemy_popup_turret_loop_0FED27, #$0078 ) ; 120 frames ($78), then the loop starts again

  loc_0FED6E:
    COP [86]
    RTL 
}

---------------------------------------------
; The turret's shot.
; 
; When: spawned by we_enemy_popup_turret_loop (flags $0200).
; Sees: COP A3, BRK $64, animation $2B, animation $2E four times, then Y = $2E and a jump into the shared projectile mover shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67 by a pushed RTL address.
; Why: the mover does the flight and the contact; this label gives the parameter.
; In: X = D = the shot.
; Out: RTL into cm_enemy_aimed_shot_body_002D67.
; Clobbers: A, Y.

we_enemy_popup_turret_shot_0FED71 {
    COP [A3]
    BRK #$64
    COP [80] ( #2B )
    COP [82]
    COP [81] ( #2E, #04 )
    COP [83]
    LDY #$002E
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67-1
    PHA 
    RTL                   ; RTL jumps to cm_enemy_aimed_shot_body_002D67 (shared projectile mover) with Y = $2E
}
---------------------------------------------

; The arc jet: picks its direction from the flip state.
; 
; When: meta type $0E (animation $29, flags $2000: hidden); placed twice in A14S02.
; Sees: COP A5 on the placement's flip state: none to we_enemy_arc_jet_up_right, X to we_enemy_arc_jet_up_left, Y to we_enemy_arc_jet_down_right, both to we_enemy_arc_jet_down_left.
; Why: one script, four mirror images.
; In: actor script, X = own slot.
; Out: jumps on.
; Clobbers: none (COP only).

we_enemy_arc_jet_0FED8F {
    COP [A5] ( &we_enemy_arc_jet_up_right_0FED99, &we_enemy_arc_jet_up_left_0FEDC8, &we_enemy_arc_jet_down_right_0FEDF7, &we_enemy_arc_jet_down_left_0FEE26 )
}

---------------------------------------------
; The up-right jet waits for its next burst.
; 
; When: after the placement and after each burst.
; Sees: COP AD ($10, until on screen), COP 1B with $78 frames to we_enemy_arc_jet_up_right_burst.
; Why: a burst every 120 frames.
; In: actor script, X = own slot.
; Out: COP 1B (delay then jump).
; Clobbers: none (COP only).

we_enemy_arc_jet_up_right_0FED99 {
    COP [AD] ( #10 )
    COP [1B] ( &we_enemy_arc_jet_up_right_burst_0FEDA2, #$0078 )
}

---------------------------------------------
; One burst of the up-right jet.
; 
; When: 120 frames after the wait.
; Sees: $30 = 0, BRK $5D, COP 03 with 7 passes: COP B0 spawns we_enemy_arc_jet_flame (flags $0200), x of the flame = x + $30, we_enemy_arc_jet_place_up sets its y and adds $10 to $30, COP 1B with 1 frame to we_enemy_arc_jet_up_right_next.
; Why: seven flames one frame apart, 16 px further each time, on an arc.
; In: actor script, X = own slot.
; Out: COP 1B.
; Clobbers: A, Y (the new flame).

we_enemy_arc_jet_up_right_burst_0FEDA2 {
    STZ $0030, X          ; $30 = running distance: the x offset and the sine index of the next flame (0, $10 ... $60)
    BRK #$5D
    COP [03] ( #07 )      ; 7 flames per burst, one per frame
    COP [B0] ( @we_enemy_arc_jet_flame_0FEE55, #$0200 )
    LDA $0030, X
    CLC 
    ADC $0000, Y
    STA $0000, Y
    JSR $&we_enemy_arc_jet_place_up_0FEE5D
    COP [1B] ( &we_enemy_arc_jet_up_right_next_0FEDC4, #$0001 )
}

---------------------------------------------
; End of one flame pass of the up-right jet.
; 
; When: after each flame.
; Sees: COP 04 (ends the pass of the COP 03 loop), then BRA to we_enemy_arc_jet_up_right.
; Why: the COP 03 loop closes here; after the 7th pass the jet waits again.
; In: actor script, X = own slot.
; Out: BRA.
; Clobbers: none (COP only).

we_enemy_arc_jet_up_right_next_0FEDC4 {
    COP [04]
    BRA we_enemy_arc_jet_up_right_0FED99
}

---------------------------------------------
; The up-left jet waits for its next burst.
; 
; When: after the placement and after each burst.
; Sees: COP AD ($10), COP 1B with $78 frames to we_enemy_arc_jet_up_left_burst.
; Why: mirror of we_enemy_arc_jet_up_right.
; In: actor script, X = own slot.
; Out: COP 1B.
; Clobbers: none (COP only).

we_enemy_arc_jet_up_left_0FEDC8 {
    COP [AD] ( #10 )
    COP [1B] ( &we_enemy_arc_jet_up_left_burst_0FEDD1, #$0078 )
}

---------------------------------------------
; One burst of the up-left jet.
; 
; When: 120 frames after the wait.
; Sees: as we_enemy_arc_jet_up_right_burst, but x of the flame = x - $30.
; Why: mirror image.
; In: actor script, X = own slot.
; Out: COP 1B.
; Clobbers: A, Y (the new flame).

we_enemy_arc_jet_up_left_burst_0FEDD1 {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @we_enemy_arc_jet_flame_0FEE55, #$0200 )
    LDA $0000, Y
    SEC 
    SBC $0030, X
    STA $0000, Y
    JSR $&we_enemy_arc_jet_place_up_0FEE5D
    COP [1B] ( &we_enemy_arc_jet_up_left_next_0FEDF3, #$0001 )
}

---------------------------------------------
; End of one flame pass of the up-left jet.
; 
; When: after each flame.
; Sees: COP 04, BRA to we_enemy_arc_jet_up_left.
; Why: closes the COP 03 loop.
; In: actor script, X = own slot.
; Out: BRA.
; Clobbers: none (COP only).

we_enemy_arc_jet_up_left_next_0FEDF3 {
    COP [04]
    BRA we_enemy_arc_jet_up_left_0FEDC8
}

---------------------------------------------
; The down-right jet waits for its next burst.
; 
; When: after the placement and after each burst.
; Sees: COP AD ($10), COP 1B with $78 frames to we_enemy_arc_jet_down_right_burst.
; Why: mirror of we_enemy_arc_jet_up_right.
; In: actor script, X = own slot.
; Out: COP 1B.
; Clobbers: none (COP only).

we_enemy_arc_jet_down_right_0FEDF7 {
    COP [AD] ( #10 )
    COP [1B] ( &we_enemy_arc_jet_down_right_burst_0FEE00, #$0078 )
}

---------------------------------------------
; One burst of the down-right jet.
; 
; When: 120 frames after the wait.
; Sees: as we_enemy_arc_jet_up_right_burst, but y comes from we_enemy_arc_jet_place_down.
; Why: mirror image.
; In: actor script, X = own slot.
; Out: COP 1B.
; Clobbers: A, Y (the new flame).

we_enemy_arc_jet_down_right_burst_0FEE00 {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @we_enemy_arc_jet_flame_0FEE55, #$0200 )
    LDA $0030, X
    CLC 
    ADC $0000, Y
    STA $0000, Y
    JSR $&we_enemy_arc_jet_place_down_0FEE83
    COP [1B] ( &we_enemy_arc_jet_down_right_next_0FEE22, #$0001 )
}

---------------------------------------------
; End of one flame pass of the down-right jet.
; 
; When: after each flame.
; Sees: COP 04, BRA to we_enemy_arc_jet_down_right.
; Why: closes the COP 03 loop.
; In: actor script, X = own slot.
; Out: BRA.
; Clobbers: none (COP only).

we_enemy_arc_jet_down_right_next_0FEE22 {
    COP [04]
    BRA we_enemy_arc_jet_down_right_0FEDF7
}

---------------------------------------------
; The down-left jet waits for its next burst.
; 
; When: after the placement and after each burst.
; Sees: COP AD ($10), COP 1B with $78 frames to we_enemy_arc_jet_down_left_burst.
; Why: mirror of we_enemy_arc_jet_up_right.
; In: actor script, X = own slot.
; Out: COP 1B.
; Clobbers: none (COP only).

we_enemy_arc_jet_down_left_0FEE26 {
    COP [AD] ( #10 )
    COP [1B] ( &we_enemy_arc_jet_down_left_burst_0FEE2F, #$0078 )
}

---------------------------------------------
; One burst of the down-left jet.
; 
; When: 120 frames after the wait.
; Sees: as the up-left burst for x (x - $30) and as the down-right burst for y (we_enemy_arc_jet_place_down).
; Why: mirror image.
; In: actor script, X = own slot.
; Out: COP 1B.
; Clobbers: A, Y (the new flame).

we_enemy_arc_jet_down_left_burst_0FEE2F {
    STZ $0030, X
    BRK #$5D
    COP [03] ( #07 )
    COP [B0] ( @we_enemy_arc_jet_flame_0FEE55, #$0200 )
    LDA $0000, Y
    SEC 
    SBC $0030, X
    STA $0000, Y
    JSR $&we_enemy_arc_jet_place_down_0FEE83
    COP [1B] ( &we_enemy_arc_jet_down_left_next_0FEE51, #$0001 )
}

---------------------------------------------
; End of one flame pass of the down-left jet.
; 
; When: after each flame.
; Sees: COP 04, BRA to we_enemy_arc_jet_down_left.
; Why: closes the COP 03 loop.
; In: actor script, X = own slot.
; Out: BRA.
; Clobbers: none (COP only).

we_enemy_arc_jet_down_left_next_0FEE51 {
    COP [04]
    BRA we_enemy_arc_jet_down_left_0FEE26
}

---------------------------------------------
; One flame of an arc-jet burst.
; 
; When: spawned by the burst labels (flags $0200).
; Sees: animation $29, COP 82 (wait until it ends), COP 86 (delete).
; Why: the flame lives for one run of animation $29; its position is set by the jet.
; In: X = D = the flame.
; Out: RTL after the delete.
; Clobbers: none (COP only).

we_enemy_arc_jet_flame_0FEE55 {
    COP [80] ( #29 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Sets the y of the new flame for an upward arc and advances the distance.
; 
; When: JSR from the two up bursts with Y = the new flame, X = the jet.
; Sees: A = SineTable+$10 indexed by $30, low byte, halved and negated; y of the flame = the jet's y + that + 8; $30 is increased by $10.
; Why: the flames climb along a half-sine as their distance grows (an arc). The SineTable+$10 offset is hexadecimal.
; In: X = the jet, Y = the flame, $30 = distance.
; Out: RTS; $30 += $10.
; Clobbers: A.

we_enemy_arc_jet_place_up_0FEE5D {
    PHY 
    LDY $0030, X
    LDA $&data_engine_tables.SineTable+10, Y
    PLY 
    AND #$00FF
    LSR                   ; half of SineTable+$10 at index $30: the height of the arc at this distance
    EOR #$FFFF
    INC 
    CLC 
    ADC $0002, Y
    CLC 
    ADC #$0008
    STA $0002, Y
    LDA $0030, X
    CLC 
    ADC #$0010
    STA $0030, X
    RTS 
}

---------------------------------------------
; Sets the y of the new flame for a downward arc and advances the distance.
; 
; When: JSR from the two down bursts.
; Sees: the same half-sine height, not negated; y of the flame = the jet's y + height - 8; $30 += $10.
; Why: mirror of we_enemy_arc_jet_place_up.
; In: X = the jet, Y = the flame, $30 = distance.
; Out: RTS; $30 += $10.
; Clobbers: A.

we_enemy_arc_jet_place_down_0FEE83 {
    PHY 
    LDY $0030, X
    LDA $&data_engine_tables.SineTable+10, Y
    PLY 
    AND #$00FF
    LSR 
    CLC 
    ADC $0002, Y
    SEC 
    SBC #$0008
    STA $0002, Y
    LDA $0030, X
    CLC 
    ADC #$0010
    STA $0030, X
    RTS 
}
---------------------------------------------

; The static hazard: a script that does nothing.
; 
; When: meta type $0F (the arc jet's stats and animation $29, flags $2000); placed 12 times in A14S01 and A14S02.
; Sees: RTL at once.
; Why: the placement alone is its content; what the 12 objects are for is not clear from the walkthrough (OQ-I040-4).
; In: X = D = the actor.
; Out: RTL.
; Clobbers: none.

we_enemy_static_hazard_0FEEA5 {
    RTL                   ; no behaviour: the type exists only through its row and placements (OQ-I040-4)
}