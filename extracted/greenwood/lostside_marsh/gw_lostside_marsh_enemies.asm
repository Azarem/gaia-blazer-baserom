; The monster scripts of the Lostside marsh and its shrines (file offsets 1028341-1030943, SNES $1F:B0F5-$BB1E, bank 1F; the two scripts without a placement, gw_enemies_without_placement, lie between them). Each part is one monster type of MetaGreenwood, the meta table of world 1 (WorldMetaPointers): the meta entry holds attack, defence, HP (binary), EXP (BCD word), the first animation, the flag word and this script. All monsters of areas 4 and 5 that are not villagers are here, except the three statue bosses (gw_boss_light_water_fire_statues).
; 
; === ROSTER (meta type, ROM stats attack / defence / HP / EXP, how it appears) ===
; $2C Water Lizard 4/1/10/10: placed in A05S01 (10), A05S02 (4) and A05S03 (7).
; $2D Mud Man 4/0/12/11, $2E Walking Plant 4/0/6/12, $2F Stone Statue 4/1/13/12: lair monsters. Mud Men and Walking Plants live in the marsh lair ($19) and the three Water Shrine scenes ($1A-$1C), the Stone Statues in the second and third Water Shrine scene (switches $4A, $4F, $51).
; $30 Purple Flower 4/3/3/6: placed in A05S01 (4). Its bee is the child code_0FB57F, which asks the shared homing projectile.
; $31 floor spears 5/0/5/EXP $3000: placed in A05S03 (9); no bestiary row (OQ-I035-2).
; $33 Spirit Ball 7/5/40/EXP $1100: lair monster of the two Light Shrine scenes (switches $36, $37); the bestiary: 40 HP, 1,100 EXP, 'Spirit? Yes'.
; $35 Ghost Head 4/3/8/14: lair monster of the Fire and Light Shrines.
; $37 Lizard Man (chaser) 4/1/12/12 and $38 Lizard Man (wanderer) 5/1/15/15: lair monsters of the Fire and Light Shrines; the names come from elimination, as the walkthrough knows the 'Green Lizard Man' and the ROM text has no name for them. DISCREPANCY: the bestiary lists the Green Lizard Man with 8 HP and 14 EXP (OQ-I035-1).
; $48 Fire Man 4/1/12/13: lair monster of the third Fire Shrine scene and of the Light Shrines.
; $49 Metal Scorpion 5/9/30/EXP $0350: lair monster of the Fire Shrines (switches $53, $64, $76); the bestiary: 30 HP, 350 EXP, 'Metal? Yes'.
; $34 and $36 have scripts but no placement and no lair record: gw_enemies_without_placement.
; 
; === HOW A MONSTER WORKS ===
; Most roots start with COP A5, which turns the placement's flip bits into one of four facings (no flip, flip X, flip Y, both), each with its own set of animations and its own copy of the behaviour loop; the Spirit Ball and the Metal Scorpion use the same trick for the direction they follow along a wall. Movement is tile and animation driven (COP 9A / 9B compare the distance to the hero, COP 21 / 22 / 23 / 24 test the tile above / below / left / right, COP 1F draws a random number from rng_state): the scripts contain no explicit move command except where noted. Immunity classes are bits of $1A set at the start: $0200 floor spears, $0400 Metal Scorpion (the bestiary: only the Zantetsu Sword hurts it), $0800 Spirit Ball (only the Spirit Sword). The flag $2000 of $16 is used by the Water Lizard and the Stone Statue as 'hidden'.
; Projectiles and children are separate actors made with COP 85 / COP B0 / COP B2 (the three lizard shots, the vines of the Walking Plant, the leap of the Stone Statue, the bee of the Purple Flower, the fireball of the Fire Man); the Purple Flower's bee and the Fire Man's fireball tail-jump into the shared movers in shared_actor_helpers_bank0 (cm_enemy_aimed_shot_mover_002D96, cm_enemy_aimed_shot_body_002D67).
; 
; Open points: the Lizard Man stats and the floor-spear EXP (OQ-I035-1, OQ-I035-2); the bee's CPY #$06AA is the pool-full test of PopFreeSlot, not an open point.
---------------------------------------------

?BANK 1F

?INCLUDE 'shared_actor_helpers_bank0'
?INCLUDE 'WorldMetaPointers'

!rng_state                      0301
!map_width_px                   0342
!map_height_px                  0344
!player_x                       0374
!player_y                       0376

---------------------------------------------

; The Water Lizard: spits a ball from the water and dives again.
; 
; When: meta type $2C (4/1/10 HP, 10 EXP); placed in the marsh and the first two Water Shrine scenes (A05S01 x10, A05S02 x4, A05S03 x7). The bestiary: 'Water Lizard, firing projectiles'.
; Sees: nothing while it lies under water (flag $2000 of $16 set). When the hero stands in front of it within $30 pixels it comes up, spits a ball in its facing and dives again for 120 frames (COP 1B #$78). While it is off screen it waits (COP AD).
; Why: COP A5 at the root picks one of four facings; every facing has the same loop with its own animations ($16-$18 for the shot) and offsets for COP B2, which spawns the projectile children code_0FB2DB, code_0FB2E8 and code_0FB2F5 (one per direction, with BRK $5B).
; In: actor script, X = own slot (the placement's flip bits choose the facing).
; Out: loops until the monster is killed.
; Clobbers: A, Y.

gw_enemy_water_lizard_0FB0F5 {
    COP [A5] ( &code_0FB0FF, &code_0FB172, &code_0FB1E5, &code_0FB25A ) ; four facings by the placement's flip bits
}

code_0FB0FF {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB10D

  code_0FB107:
    COP [1B] ( &code_0FB0FF, #$0008 )

  loc_0FB10D:
    COP [9A] ( #$0030, &code_0FB107, &code_0FB117, &code_0FB107 )
}

code_0FB117 {
    COP [9B] ( #$0000, &code_0FB107, &code_0FB107, &code_0FB121 )
}

code_0FB121 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #03 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #00 )
    COP [82]
    COP [B2] ( @code_0FB2DB, #$0000, #$000C, #$0200 ) ; the lizard's shot, code_0FB2DB, at (0,12)
    COP [80] ( #09 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #04 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    JSR $&code_0FB2CD
    COP [1B] ( &code_0FB0FF, #$0078 )
}

code_0FB172 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB180

  code_0FB17A:
    COP [1B] ( &code_0FB172, #$0008 )

  loc_0FB180:
    COP [9B] ( #$0030, &code_0FB17A, &code_0FB18A, &code_0FB17A )
}

code_0FB18A {
    COP [9A] ( #$0000, &code_0FB194, &code_0FB17A, &code_0FB17A )
}

code_0FB194 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #07 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    COP [B2] ( @code_0FB2E8, #$FFF0, #$0000, #$0200 )
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #08 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    JSR $&code_0FB2CD
    COP [1B] ( &code_0FB172, #$0078 )
}

code_0FB1E5 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB1F3

  code_0FB1ED:
    COP [1B] ( &code_0FB1E5, #$0008 )

  loc_0FB1F3:
    COP [9B] ( #$0030, &code_0FB1ED, &code_0FB1FD, &code_0FB1ED )
}

code_0FB1FD {
    COP [9A] ( #$0000, &code_0FB1ED, &code_0FB1ED, &code_0FB207 )
}

code_0FB207 {
    COP [96]
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #07 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    COP [B2] ( @code_0FB2E8, #$0020, #$0000, #$0200 )
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #08 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    JSR $&code_0FB2CD
    COP [1B] ( &code_0FB1E5, #$0078 )
}

code_0FB25A {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB268

  code_0FB262:
    COP [1B] ( &code_0FB25A, #$0008 )

  loc_0FB268:
    COP [9A] ( #$0030, &code_0FB262, &code_0FB272, &code_0FB262 )
}

code_0FB272 {
    COP [9B] ( #$0000, &code_0FB27C, &code_0FB262, &code_0FB262 )
}

code_0FB27C {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #05 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #01 )
    COP [82]
    COP [B2] ( @code_0FB2F5, #$0000, #$FFE0, #$0200 )
    COP [80] ( #0A )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #06 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    JSR $&code_0FB2CD
    COP [1B] ( &code_0FB25A, #$0078 )
}

code_0FB2CD {
    SEP #$20
    LDY $0038, X
    LDA $&WorldMetaPointers+2, Y
    STA $0025, X
    REP #$20
    RTS 
}

code_0FB2DB {
    COP [A3]
    BRK #$5B
    COP [81] ( #16, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0FB2E8 {
    COP [A3]
    BRK #$5B
    COP [81] ( #18, #08 )
    COP [83]
    COP [86]
    RTL 
}

code_0FB2F5 {
    COP [A3]
    BRK #$5B
    COP [81] ( #17, #08 )
    COP [83]
    COP [86]
    RTL 
}
---------------------------------------------

; The Mud Man: a slow lump that turns toward the hero.
; 
; When: meta type $2D (4/0/12 HP, 11 EXP); lair monster of the marsh and the Water Shrines. The bestiary: 'running into you'.
; Sees: it faces the hero (COP 9A / 9B with threshold $10, flip with COP 96 / 97, animations $24-$26); the script has no move command, so the walking itself is in the animation data (OQ-I035-4).
; In: actor script, X = own slot.
; Out: loops until it is killed.
; Clobbers: A.

gw_enemy_mud_man_0FB302 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB310

  code_0FB30A:
    COP [1B] ( &gw_enemy_mud_man_0FB302, #$0002 )

  loc_0FB310:
    COP [9A] ( #$0010, &code_0FB31A, &code_0FB32C, &code_0FB323 )
}

code_0FB31A {
    COP [97]
    COP [80] ( #26 )
    COP [82]
    BRA code_0FB32C
}

code_0FB323 {
    COP [96]
    COP [80] ( #26 )
    COP [82]
    BRA code_0FB32C
}

code_0FB32C {
    COP [9B] ( #$0010, &code_0FB336, &code_0FB30A, &code_0FB33F )
}

code_0FB336 {
    COP [97]
    COP [80] ( #25 )
    COP [82]
    BRA gw_enemy_mud_man_0FB302
}

code_0FB33F {
    COP [97]
    COP [80] ( #24 )
    COP [82]
    BRA gw_enemy_mud_man_0FB302
}
---------------------------------------------

; The Walking Plant: wanders and shoots a vine when the hero is in line.
; 
; When: meta type $2E (4/0/6 HP, 12 EXP); lair monster of the marsh and the Water Shrines. The bestiary: 'running into you; vines'.
; Sees: it picks a random direction (COP 1F with rng_state+1, animations $0D-$0F, COP 9D / 9E until it stops against a tile); when the hero is in line within $10 pixels it plays animation $0C and spawns a vine child (code_0FB3F6, code_0FB406 or code_0FB416 by direction, animations $11-$13 and $27).
; In: actor script, X = own slot.
; Out: loops until it is killed.
; Clobbers: A, Y.

gw_enemy_walking_plant_0FB348 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB356

  code_0FB350:
    COP [1B] ( &gw_enemy_walking_plant_0FB348, #$0020 )

  loc_0FB356:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FB369
    DEC 
    BEQ loc_0FB372
    DEC 
    BEQ loc_0FB37B
    DEC 
    BEQ loc_0FB386

  loc_0FB369:
    COP [9D] ( #0E )
    COP [9E] ( &code_0FB350 )

  loc_0FB370:
    BRA loc_0FB391

  loc_0FB372:
    COP [9D] ( #0D )
    COP [9E] ( &code_0FB350 )

  loc_0FB379:
    BRA loc_0FB391

  loc_0FB37B:
    COP [96]
    COP [9D] ( #0F )
    COP [9E] ( &code_0FB350 )

  loc_0FB384:
    BRA loc_0FB391

  loc_0FB386:
    COP [97]
    COP [9D] ( #0F )
    COP [9E] ( &code_0FB350 )

  loc_0FB38F:
    BRA loc_0FB391

  loc_0FB391:
    COP [9A] ( #$0010, &code_0FB3A5, &code_0FB39B, &code_0FB3AF )
}

code_0FB39B {
    COP [9B] ( #$0000, &code_0FB3B9, &code_0FB3C2, &code_0FB3C2 )
}

code_0FB3A5 {
    COP [9B] ( #$0010, &gw_enemy_walking_plant_0FB348, &code_0FB3CB, &gw_enemy_walking_plant_0FB348 )
}

code_0FB3AF {
    COP [9B] ( #$0010, &gw_enemy_walking_plant_0FB348, &code_0FB3D4, &gw_enemy_walking_plant_0FB348 )
}

code_0FB3B9 {
    COP [97]
    COP [85] ( @code_0FB3F6 )
    BRA loc_0FB3DB
}

code_0FB3C2 {
    COP [97]
    COP [85] ( @code_0FB406 )
    BRA loc_0FB3DB
}

code_0FB3CB {
    COP [97]
    COP [85] ( @code_0FB416 )
    BRA loc_0FB3DB
}

code_0FB3D4 {
    COP [96]
    COP [85] ( @code_0FB416 )

  loc_0FB3DB:
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [81] ( #0C, #02 )
    COP [83]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    BRL code_0FB350
}

code_0FB3F6 {
    LDA #$0200
    STA $0016, X
    COP [A4]
    COP [80] ( #12 )
    COP [82]
    COP [86]
    RTL 
}

code_0FB406 {
    LDA #$0200
    STA $0016, X
    COP [A4]
    COP [80] ( #11 )
    COP [82]
    COP [86]
    RTL 
}

code_0FB416 {
    LDA #$0200
    STA $0016, X
    COP [A4]
    LDA $001C, X
    ASL 
    BPL loc_0FB42B
    COP [80] ( #27 )
    COP [82]
    BRA loc_0FB430

  loc_0FB42B:
    COP [80] ( #13 )
    COP [82]

  loc_0FB430:
    COP [86]
    RTL 
}
---------------------------------------------

; The Stone Statue: stands still until the hero comes close, then hops next to the hero again and again.
; 
; When: meta type $2F (4/1/13 HP, 12 EXP); lair monster of the second and third Water Shrine scene. The bestiary: 'leaping at you'.
; Sees: a still statue (COP 15, tiles blocked) until the hero enters its box widened by 1 (COP 0C). Then it vanishes (BRK $5F, animation $10, flag $2000), and every 32 frames it picks a spot $20-$50 pixels from the hero (sign and size from rng_state+1, rounded to 16 pixels), reappears there (animations $10, $1C, $1D), spawns the leap child code_0FB4E4 (animations $1E-$22 by the hero's direction, 16 repeats, drawn in front) and vanishes again.
; Why: a spot outside the map or on an occupied tile (COP 28) makes it pick again; the child is the part that hurts.
; In: actor script, X = own slot.
; Out: loops until it is killed.
; Clobbers: A, Y.

gw_enemy_stone_statue_0FB433 {
    COP [15]

  code_0FB435:
    LDA $0016, X
    BIT #$8000
    BNE loc_0FB443
    COP [0C] ( #00, #01, &code_0FB449 ) ; the hero is in the statue's box widened by 1: wake up

  loc_0FB443:
    COP [1B] ( &code_0FB435, #$0010 )
}

code_0FB449 {
    COP [16]
    BRL loc_0FB4CE

  code_0FB44E:
    COP [1F]
    LDA $rng_state+1
    PHP 
    AND #$0030
    CLC 
    ADC #$0020
    PLP 
    BPL loc_0FB462
    EOR #$FFFF
    INC 

  loc_0FB462:
    CLC 
    ADC $player_x
    AND #$FFF0
    CMP $map_width_px
    BCS code_0FB4DE
    STA $0000, X
    COP [1F]
    LDA $rng_state+1
    PHP 
    AND #$0030
    CLC 
    ADC #$0020
    PLP 
    BPL loc_0FB485
    EOR #$FFFF
    INC 

  loc_0FB485:
    CLC 
    ADC $player_y
    AND #$FFF0
    CMP $map_height_px
    BCS code_0FB4DE
    STA $0002, X
    COP [28] ( &code_0FB4DE ) ; occupied tile: pick another spot
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    BRK #$5F
    COP [80] ( #10 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #1C )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    COP [85] ( @code_0FB4E4 )
    COP [80] ( #1C )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X

  loc_0FB4CE:
    BRK #$5F
    COP [80] ( #10 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
}

code_0FB4DE {
    COP [1B] ( &code_0FB44E, #$0020 )
}

code_0FB4E4 {
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [A0] ( #$FFF4 )
    BRK #$5B
    COP [9A] ( #$0018, &code_0FB506, &code_0FB4FC, &code_0FB510 )
}

code_0FB4FC {
    COP [9B] ( #$0000, &code_0FB558, &code_0FB55E, &code_0FB532 )
}

code_0FB506 {
    COP [9B] ( #$0018, &code_0FB51A, &code_0FB522, &code_0FB52A )
}

code_0FB510 {
    COP [9B] ( #$0018, &code_0FB54E, &code_0FB544, &code_0FB53A )
}

code_0FB51A {
    COP [81] ( #22, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB522 {
    COP [81] ( #20, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB52A {
    COP [81] ( #21, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB532 {
    COP [81] ( #1E, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB53A {
    COP [96]
    COP [81] ( #21, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB544 {
    COP [96]
    COP [81] ( #20, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB54E {
    COP [96]
    COP [81] ( #22, #10 )
    COP [83]
    BRA code_0FB55E
}

code_0FB558 {
    COP [81] ( #1F, #10 )
    COP [83]
}

code_0FB55E {
    COP [86]
    RTL 
}
---------------------------------------------

; The Purple Flower: sits in the marsh and sends out a bee.
; 
; When: meta type $30 (4/3/3 HP, 6 EXP); placed in A05S01 (x4). The bestiary: 'Purple Flower: projectiles' and 'Purple Flower's Bee: running into you' (the bee shares the stats).
; Sees: a flower that waits until it is on screen (COP AD), shows animation $14 and spawns the bee child code_0FB57F at (8,-4); it repeats animation $14 every 8 frames.
; Why: the bee draws in front (COP A3), plays animation $15 and spawns the shared aimed-shot mover cm_enemy_aimed_shot_mover_002D96 once per wing cycle (the newer mover ends the older one) until Y = $06AA, the value PopFreeSlot returns when no actor slot is free, then ends.
; In: actor script, X = own slot.
; Out: loops until the flower is killed.
; Clobbers: A, Y.

gw_enemy_purple_flower_0FB561 {
    COP [AD] ( #10 )
    COP [81] ( #14, #02 )
    COP [83]
    COP [B2] ( @code_0FB57F, #$0008, #$FFFC, #$0000 )

  loc_0FB575:
    COP [AD] ( #08 )
    COP [80] ( #14 )
    COP [82]
    BRA loc_0FB575
}

code_0FB57F {
    COP [A3]
    COP [81] ( #15, #02 )
    COP [83]

  loc_0FB587:
    COP [85] ( @shared_actor_helpers_bank0.cm_enemy_aimed_shot_mover_002D96 )
    CPY #$06AA            ; $06AA: PopFreeSlot's pool-full value; the bee ends when no slot is left for a mover
    BEQ loc_0FB599
    COP [81] ( #15, #02 )
    COP [83]
    BRA loc_0FB587

  loc_0FB599:
    COP [86]
    RTL 
}
---------------------------------------------

; The floor spears: a trap that pops up in a four-step pattern.
; 
; When: meta type $31 (5/0/5 HP, EXP BCD $3000); placed in A05S03 (x9). No bestiary row (OQ-I035-2).
; Sees: the spears in animation $28, then $2C, $29, $2B and $2A in turn, each four rounds of a COP 03 / COP 04 loop (animation $28 is the base, the other the extended spears). The class bit $0200 of $1A makes it immune to the sword.
; In: actor script, X = own slot.
; Out: loops forever.
; Clobbers: A.

gw_enemy_floor_spears_0FB59C {
    LDA $001A, X
    ORA #$0200            ; $1A bit $0200: the spears cannot be hurt
    STA $001A, X

  loc_0FB5A5:
    COP [03] ( #04 )
    COP [80] ( #28 )
    COP [82]
    COP [80] ( #2C )
    COP [82]
    COP [04]
    COP [03] ( #04 )
    COP [80] ( #28 )
    COP [82]
    COP [80] ( #29 )
    COP [82]
    COP [04]
    COP [03] ( #04 )
    COP [80] ( #28 )
    COP [82]
    COP [80] ( #2B )
    COP [82]
    COP [04]
    COP [03] ( #04 )
    COP [80] ( #28 )
    COP [82]
    COP [80] ( #2A )
    COP [82]
    COP [04]
    BRA loc_0FB5A5
}
---------------------------------------------

; The Spirit Ball: follows the walls.
; 
; When: meta type $33 (7/5/40 HP, EXP BCD $1100); lair monster of the Light Shrines (switches $36, $37). The bestiary: 40 HP, 1,100 EXP, 'Spirit? Yes' (only the Spirit Sword hurts it).
; Sees: it moves along walls with COP A5 (four facings) and COP AE tile tests (animations $0F-$11). The class bit $0800 of $1A is the spirit immunity.
; In: actor script, X = own slot.
; Out: loops until it is killed.
; Clobbers: A.

gw_enemy_spirit_ball_0FB5E3 {
    LDA $001A, X
    ORA #$0800            ; $1A bit $0800: spirit immunity
    STA $001A, X

  code_0FB5EC:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB5FA
    COP [1B] ( &code_0FB5EC, #$0010 )

  loc_0FB5FA:
    COP [A5] ( &code_0FB604, &code_0FB623, &code_0FB642, &code_0FB661 )
}

code_0FB604 {
    COP [97]
    COP [80] ( #0F )
    COP [82]

  loc_0FB60B:
    COP [AE] ( #$FFF0, #$FFF0, &code_0FB661 )
    COP [AE] ( #$0000, #$FFE0, &code_0FB623 )
    COP [81] ( #11, #04 )
    COP [83]
    BRA loc_0FB60B
}

code_0FB623 {
    COP [97]
    COP [80] ( #0F )
    COP [82]

  loc_0FB62A:
    COP [AE] ( #$FFF0, #$0000, &code_0FB642 )
    COP [AE] ( #$0000, #$0010, &code_0FB604 )
    COP [81] ( #10, #04 )
    COP [83]
    BRA loc_0FB62A
}

code_0FB642 {
    COP [96]
    COP [80] ( #0F )
    COP [82]

  loc_0FB649:
    COP [AE] ( #$0020, #$0000, &code_0FB623 )
    COP [AE] ( #$0010, #$0010, &code_0FB661 )
    COP [81] ( #10, #04 )
    COP [83]
    BRA loc_0FB649
}

code_0FB661 {
    COP [96]
    COP [80] ( #0F )
    COP [82]

  loc_0FB668:
    COP [AE] ( #$0010, #$FFE0, &code_0FB642 )
    COP [AE] ( #$0020, #$FFF0, &code_0FB604 )
    COP [81] ( #11, #04 )
    COP [83]
    BRA loc_0FB668
}
---------------------------------------------

; The Ghost Head: sleeps until the hero is close, then chases.
; 
; When: meta type $35 (4/3/8 HP, 14 EXP); lair monster of the Fire and Light Shrines. The bestiary: 'running into you'.
; Sees: it waits until the hero is within box margin 6, then appears (animation $1B), draws in front (COP A3), takes speed COP A2 #$30 and chases with COP 9C / 9A / 9B (animations $1C-$1E).
; In: actor script, X = own slot.
; Out: loops until it is killed.
; Clobbers: A.

gw_enemy_ghost_head_0FB695 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB6A3
    COP [1B] ( &gw_enemy_ghost_head_0FB695, #$0010 )

  loc_0FB6A3:
    COP [0C] ( #00, #06, &code_0FB6B0 )
    COP [80] ( #1A )
    COP [82]
    BRA gw_enemy_ghost_head_0FB695
}

code_0FB6B0 {
    COP [80] ( #1B )
    COP [82]
    COP [A3]
    COP [A2] ( #30 )

  loc_0FB6BA:
    COP [9C] ( &code_0FB6C0, &code_0FB6DC )
}

code_0FB6C0 {
    COP [9A] ( #$0000, &code_0FB6CA, &code_0FB6D3, &code_0FB6D3 )
}

code_0FB6CA {
    COP [97]
    COP [80] ( #1E )
    COP [82]
    BRA loc_0FB6BA
}

code_0FB6D3 {
    COP [96]
    COP [80] ( #1E )
    COP [82]
    BRA loc_0FB6BA
}

code_0FB6DC {
    COP [9B] ( #$0000, &code_0FB6E6, &code_0FB6EF, &code_0FB6EF )
}

code_0FB6E6 {
    COP [97]
    COP [80] ( #1D )
    COP [82]
    BRA loc_0FB6BA
}

code_0FB6EF {
    COP [97]
    COP [80] ( #1C )
    COP [82]
    BRA loc_0FB6BA
}
---------------------------------------------

; The Lizard Man that turns toward the hero.
; 
; When: meta type $37 (4/1/12 HP, 12 EXP); lair monster of the Fire and Light Shrines. The name is by elimination (OQ-I035-1: DISCREPANCY with the bestiary's Green Lizard Man).
; Sees: it turns toward the hero (COP 9A / 9B, threshold $10, animations $0B, $07 and $03); the movement itself is in the animation data.
; In: actor script, X = own slot.
; Out: loops until it is killed.
; Clobbers: A.

gw_enemy_lizard_man_chaser_0FB898 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB8A6

  code_0FB8A0:
    COP [1B] ( &gw_enemy_lizard_man_chaser_0FB898, #$0010 )

  loc_0FB8A6:
    COP [9A] ( #$0010, &code_0FB8B0, &code_0FB8C2, &code_0FB8B9 )
}

code_0FB8B0 {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    BRA code_0FB8C2
}

code_0FB8B9 {
    COP [96]
    COP [80] ( #0B )
    COP [82]
    BRA code_0FB8C2
}

code_0FB8C2 {
    COP [9B] ( #$0010, &code_0FB8CC, &code_0FB8A0, &code_0FB8D5 )
}

code_0FB8CC {
    COP [97]
    COP [80] ( #07 )
    COP [82]
    BRA gw_enemy_lizard_man_chaser_0FB898
}

code_0FB8D5 {
    COP [97]
    COP [80] ( #03 )
    COP [82]
    BRA gw_enemy_lizard_man_chaser_0FB898
}
---------------------------------------------

; The Lizard Man that wanders at random.
; 
; When: meta type $38 (5/1/15 HP, 15 EXP); lair monster of the Fire and Light Shrines (switches $5B, $6F and others). The name is by elimination (OQ-I035-1).
; Sees: it picks a random direction (COP 1F, animations $00-$0E) until a tile test (COP 23) stops it.
; In: actor script, X = own slot.
; Out: loops until it is killed.
; Clobbers: A.

gw_enemy_lizard_man_wanderer_0FB8DE {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB8EC
    COP [1B] ( &gw_enemy_lizard_man_wanderer_0FB8DE, #$0010 )

  loc_0FB8EC:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FB8FF
    DEC 
    BEQ loc_0FB937
    DEC 
    BEQ loc_0FB96C
    BRL loc_0FB9A1

  loc_0FB8FF:
    COP [97]
    COP [80] ( #02 )
    COP [82]
    COP [23] ( &gw_enemy_lizard_man_wanderer_0FB8DE )
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #0C )
    COP [82]
    COP [A4]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [A7]
    COP [80] ( #0D )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    BRA gw_enemy_lizard_man_wanderer_0FB8DE

  loc_0FB937:
    COP [96]
    COP [80] ( #02 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #0C )
    COP [82]
    COP [A4]
    COP [81] ( #0E, #02 )
    COP [83]
    COP [A7]
    COP [80] ( #0D )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #02 )
    COP [82]
    BRL gw_enemy_lizard_man_wanderer_0FB8DE

  loc_0FB96C:
    COP [97]
    COP [80] ( #01 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #08 )
    COP [82]
    COP [A4]
    COP [81] ( #0A, #02 )
    COP [83]
    COP [A7]
    COP [80] ( #09 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #01 )
    COP [82]
    BRL gw_enemy_lizard_man_wanderer_0FB8DE

  loc_0FB9A1:
    COP [97]
    COP [80] ( #00 )
    COP [82]
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [80] ( #04 )
    COP [82]
    COP [A4]
    COP [81] ( #06, #02 )
    COP [83]
    COP [A7]
    COP [80] ( #05 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [80] ( #00 )
    COP [82]
    BRL gw_enemy_lizard_man_wanderer_0FB8DE
}
---------------------------------------------

; The Fire Man: runs along walls and sometimes spits a fireball.
; 
; When: meta type $48 (4/1/12 HP, 13 EXP); lair monster of the third Fire Shrine scene and the Light Shrines. The bestiary: 'running into you; fireball'.
; Sees: it waits until on screen (COP AD), turns toward the hero (COP 9A / 9B, threshold $18, tile tests COP 21-24, animations $1F-$24) and in one of four cases spits a fireball child (COP B0, code_0FBAA6, animation $1F first).
; Why: the fireball runs the shared mover cm_enemy_aimed_shot_body_002D67 by a tail jump (an address pushed, RTL) with Y = $28.
; In: actor script, X = own slot.
; Out: loops until it is killed.
; Clobbers: A, Y.

gw_enemy_fire_man_0FB9D6 {
    COP [AD] ( #08 )
    COP [9B] ( #$0000, &code_0FB9E3, &code_0FBA01, &code_0FBA01 )
}

code_0FB9E3 {
    COP [97]
    COP [9B] ( #$0018, &code_0FB9EF, &code_0FBA68, &code_0FB9EF )
}

code_0FB9EF {
    COP [21] ( &code_0FB9FA )
    COP [80] ( #23 )
    COP [82]
    BRA gw_enemy_fire_man_0FB9D6
}

code_0FB9FA {
    COP [80] ( #20 )
    COP [82]
    BRA gw_enemy_fire_man_0FB9D6
}

code_0FBA01 {
    COP [97]
    COP [9B] ( #$0018, &code_0FBA0D, &code_0FBA68, &code_0FBA0D )
}

code_0FBA0D {
    COP [22] ( &code_0FBA18 )
    COP [80] ( #22 )
    COP [82]
    BRA gw_enemy_fire_man_0FB9D6
}

code_0FBA18 {
    COP [80] ( #1F )
    COP [82]
    BRA gw_enemy_fire_man_0FB9D6

  loc_0FBA1F:
    COP [AD] ( #08 )
    COP [9A] ( #$0000, &code_0FBA2C, &code_0FBA4A, &code_0FBA4A )
}

code_0FBA2C {
    COP [9A] ( #$0018, &code_0FBA36, &code_0FBA85, &code_0FBA36 )
}

code_0FBA36 {
    COP [97]
    COP [23] ( &code_0FBA43 )
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA43 {
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA4A {
    COP [9A] ( #$0018, &code_0FBA54, &code_0FBA85, &code_0FBA54 )
}

code_0FBA54 {
    COP [96]
    COP [24] ( &code_0FBA61 )
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA61 {
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA68 {
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BNE loc_0FBA1F
    COP [80] ( #1F )
    COP [82]
    COP [B0] ( @code_0FBAA6, #$0200 )
    COP [80] ( #1F )
    COP [82]
    BRA loc_0FBA1F
}

code_0FBA85 {
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FBA92
    BRL gw_enemy_fire_man_0FB9D6

  loc_0FBA92:
    COP [80] ( #1F )
    COP [82]
    COP [B0] ( @code_0FBAA6, #$0200 )
    COP [80] ( #1F )
    COP [82]
    BRL gw_enemy_fire_man_0FB9D6
}

code_0FBAA6 {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$64
    LDY #$0028
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67-1
    PHA                   ; RTL jumps to cm_enemy_aimed_shot_body_002D67 (shared mover) with Y = $28
    RTL 
}
---------------------------------------------

; The Metal Scorpion: an armoured scorpion that crawls along the walls.
; 
; When: meta type $49 (5/9/30 HP, EXP BCD $0350); lair monster of the Fire Shrines. The bestiary: 30 HP, 350 EXP, 'Metal? Yes' (only the Zantetsu Sword hurts it).
; Sees: it crawls along walls with COP A5 (four facings) and COP 21-24 tile tests (animations $25-$27). The class bit $0400 of $1A is the metal immunity.
; In: actor script, X = own slot.
; Out: loops until it is killed.
; Clobbers: A.

gw_enemy_metal_scorpion_0FBABC {
    LDA $001A, X
    ORA #$0400            ; $1A bit $0400: metal immunity
    STA $001A, X
    COP [A5] ( &code_0FBB0B, &code_0FBAF7, &code_0FBACF, &code_0FBAE3 )
}

code_0FBACF {
    COP [21] ( &code_0FBAD5 )
    BRA loc_0FBAED
}

code_0FBAD5 {
    COP [24] ( &code_0FBB0B )

  loc_0FBAD9:
    COP [96]
    COP [81] ( #27, #02 )
    COP [83]
    BRA code_0FBACF
}

code_0FBAE3 {
    COP [23] ( &code_0FBAE9 )
    BRA loc_0FBB01
}

code_0FBAE9 {
    COP [21] ( &code_0FBACF )

  loc_0FBAED:
    COP [97]
    COP [81] ( #26, #02 )
    COP [83]
    BRA code_0FBAE3
}

code_0FBAF7 {
    COP [22] ( &code_0FBAFD )
    BRA loc_0FBB15
}

code_0FBAFD {
    COP [23] ( &code_0FBAE3 )

  loc_0FBB01:
    COP [97]
    COP [81] ( #27, #02 )
    COP [83]
    BRA code_0FBAF7
}

code_0FBB0B {
    COP [24] ( &code_0FBB11 )
    BRA loc_0FBAD9
}

code_0FBB11 {
    COP [22] ( &code_0FBAF7 )

  loc_0FBB15:
    COP [97]
    COP [81] ( #25, #02 )
    COP [83]
    BRA code_0FBB0B
}