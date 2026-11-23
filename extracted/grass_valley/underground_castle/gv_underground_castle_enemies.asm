; The enemies of the Underground Castle that have their own code (file offsets 1026703-1027370, bank 1F): the Yellow Humanoid ($21) with its three spheres, the Walking Bush ($22), the Fly ($23), the Blue Liquid ($24) and the Blue Torch ($25) with its fireball. The Green Humanoid ($20) is in gv_enemy_0FAA49.
; 
; === ROSTER ===
; Stats are the MetaGrassValley row (HP, BCD EXP) and the walkthrough bestiary agrees: Yellow Humanoid 4 HP / 2 EXP ('running into you, spheres'); Walking Bush, Fly and Blue Liquid 3 HP / 1 EXP; Blue Torch 5 HP / 2 EXP ('fireballs'). The type is the byte +$15 of a lair record (LairRecords): for example record $30 / $31 (Underground Castle east) has type $22 and the walkthrough says 'defeat the Walking Bushes coming from the nearby monster lair'; records $0F and $12 have type $23 and the walkthrough says 'Flies spawned by the monster lair'. The Blue Liquids ($24) and Blue Torches ($25) are placed in A02S01 and A02S02 directly (placement rows). The identity of $22 / $23 / $24 follows from these lairs and the placement, not from the sprites (OQ-I034-10).
; 
; === NOTES ===
; - All five start with the same guard: while the actor is off screen ($16 bit $8000) it waits a few frames with COP 1B.
---------------------------------------------

?BANK 1F

?INCLUDE 'shared_actor_helpers_bank0'

!rng_state                      0301

---------------------------------------------

; The Yellow Humanoid: a chaser that throws spheres.
; 
; When: meta type $21; spawned by Underground Castle lairs, runs every frame.
; Sees: it walks towards the hero; when it is lined up with him within $10 pixels on one axis it plays its throw (animations $0C / $0A / $0E, then $10 / $0F / $11) and a sphere flies out (animations $36 / $35 / $37 follow).
; Why: COP 9A / 9B pick the direction (left, within, right; above, within, below); each throw spawns one of the sphere actors with COP 85.
; In: actor script, X = own slot.
; Out: spheres gv_enemy_humanoid_sphere_0FAB61 (hero above), _0FAB6C (below), _0FAB4B (left or right, flipped by COP 96).
; Clobbers: A.

gv_enemy_yellow_humanoid_0FAA8F {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAA9D

  code_0FAA97:
    COP [1B] ( &gv_enemy_yellow_humanoid_0FAA8F, #$0008 )

  loc_0FAA9D:
    COP [9A] ( #$0010, &code_0FAAA7, &code_0FAAB9, &code_0FAAB0 )
}

code_0FAAA7 {
    COP [97]
    COP [80] ( #0D )
    COP [82]
    BRA code_0FAAF3
}

code_0FAAB0 {
    COP [96]
    COP [80] ( #0D )
    COP [82]
    BRA code_0FAAF3
}

code_0FAAB9 {
    COP [9B] ( #$0010, &code_0FAAC3, &code_0FAAF3, &code_0FAADB )
}

code_0FAAC3 {
    COP [97]
    COP [80] ( #0C )
    COP [82]
    COP [80] ( #10 )
    COP [82]
    COP [85] ( @gv_enemy_humanoid_sphere_0FAB61 )
    COP [80] ( #36 )
    COP [82]
    BRA code_0FAAF3
}

code_0FAADB {
    COP [97]
    COP [80] ( #0A )
    COP [82]
    COP [80] ( #0F )
    COP [82]
    COP [85] ( @gv_enemy_humanoid_sphere_0FAB6C )
    COP [80] ( #35 )
    COP [82]
    BRA code_0FAAF3
}

code_0FAAF3 {
    COP [9B] ( #$0010, &code_0FAAFD, &code_0FAB0F, &code_0FAB06 )
}

code_0FAAFD {
    COP [97]
    COP [80] ( #0B )
    COP [82]
    BRA gv_enemy_yellow_humanoid_0FAA8F
}

code_0FAB06 {
    COP [97]
    COP [80] ( #09 )
    COP [82]
    BRA gv_enemy_yellow_humanoid_0FAA8F
}

code_0FAB0F {
    COP [9A] ( #$0010, &code_0FAB19, &code_0FAA97, &code_0FAB32 )
}

code_0FAB19 {
    COP [97]
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    COP [85] ( @gv_enemy_humanoid_sphere_0FAB4B )
    COP [80] ( #37 )
    COP [82]
    BRL code_0FAA97
}

code_0FAB32 {
    COP [96]
    COP [80] ( #0E )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    COP [85] ( @gv_enemy_humanoid_sphere_0FAB4B )
    COP [80] ( #37 )
    COP [82]
    BRL code_0FAA97
}

---------------------------------------------
; Sphere thrown sideways by the Yellow Humanoid.
; 
; When: spawned by gv_enemy_yellow_humanoid_0FAA8F (COP 85).
; Sees: a small sphere that flies away and bursts.
; Why: the sphere is its own actor so it can hurt the hero (flags $0200, priority $30, in front).
; In: actor script, X = own slot; the spawner sets the position.
; Out: starts at offset (-1, +2) with animation $25 (the parent's flip bit gives the side; a second entry loc_0FAB56 with (+1, +2) is not referenced), repeats the flight animation $0C times, plays animation $24 and ends with COP 86; BRK $5B at the start.
; Clobbers: A.

gv_enemy_humanoid_sphere_0FAB4B {
    COP [A1] ( #$FFFF, #$0002 )
    LDA #$0025
    BRA loc_0FAB75

  loc_0FAB56:
    COP [A1] ( #$0001, #$0002 )
    LDA #$0025
    BRA loc_0FAB75
}

---------------------------------------------
; Sphere thrown upward by the Yellow Humanoid.
; 
; When: spawned by gv_enemy_yellow_humanoid_0FAA8F when the hero is above it.
; Sees: as gv_enemy_humanoid_sphere_0FAB4B.
; Why: see there; the entry only sets the offset and animation (offset (+4, -13), animation $26).
; In: actor script, X = own slot.
; Out: falls into the shared tail at loc_0FAB75.
; Clobbers: A.

gv_enemy_humanoid_sphere_0FAB61 {
    COP [A1] ( #$0004, #$FFF3 )
    LDA #$0026
    BRA loc_0FAB75
}

---------------------------------------------
; Sphere thrown downward by the Yellow Humanoid.
; 
; When: spawned by gv_enemy_yellow_humanoid_0FAA8F when the hero is below it.
; Sees: as gv_enemy_humanoid_sphere_0FAB4B.
; Why: see there; offset (-3, +2), animation $27.
; In: actor script, X = own slot.
; Out: falls into the shared tail at loc_0FAB75.
; Clobbers: A.

gv_enemy_humanoid_sphere_0FAB6C {
    COP [A1] ( #$FFFD, #$0002 )
    LDA #$0027

  loc_0FAB75:
    STA $001E, X
    STZ $0020, X
    LDA #$000C
    STA $002A, X
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [A2] ( #30 )
    BRK #$5B
    COP [91]
    COP [83]
    COP [80] ( #24 )
    COP [82]
    COP [86]
    RTL 
}
---------------------------------------------

; The Walking Bush: stands still until the hero comes close.
; 
; When: meta type $22; spawned by Underground Castle lairs (records $30 / $31 in the walkthrough: 'Walking Bushes').
; Sees: a bush (animation $1B) that wakes and walks towards the hero once he is inside its box widened by 5 (COP 0C).
; Why: the walkthrough bestiary lists it as 'running into you'.
; In: actor script, X = own slot.
; Out: while the hero is near it picks the direction with COP 9A / 9B and plays walk animations $1A, $1C, $1D, $1E and $34 (16 repeats each, flipped by COP 96 / 97).
; Clobbers: A.

gv_enemy_walking_bush_0FAB9A {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FABA8
    COP [1B] ( &gv_enemy_walking_bush_0FAB9A, #$0010 )

  loc_0FABA8:
    COP [0C] ( #00, #05, &code_0FABB5 )
    COP [80] ( #1B )
    COP [82]
    BRA gv_enemy_walking_bush_0FAB9A
}

code_0FABB5 {
    COP [9A] ( #$0010, &code_0FABBF, &code_0FABFB, &code_0FABC9 )
}

code_0FABBF {
    COP [9B] ( #$0010, &code_0FABE7, &code_0FAC1F, &code_0FABF1 )
}

code_0FABC9 {
    COP [9B] ( #$0010, &code_0FABD3, &code_0FAC15, &code_0FABDD )
}

code_0FABD3 {
    COP [96]
    COP [81] ( #1E, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FABDD {
    COP [96]
    COP [81] ( #1D, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FABE7 {
    COP [97]
    COP [81] ( #1E, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FABF1 {
    COP [97]
    COP [81] ( #1D, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FABFB {
    COP [9B] ( #$0000, &code_0FAC0D, &code_0FAC0D, &code_0FAC05 )
}

code_0FAC05 {
    COP [81] ( #34, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FAC0D {
    COP [81] ( #1A, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FAC15 {
    COP [96]
    COP [81] ( #1C, #10 )
    COP [83]
    BRA loc_0FAC29
}

code_0FAC1F {
    COP [97]
    COP [81] ( #1C, #10 )
    COP [83]
    BRA loc_0FAC29

  loc_0FAC29:
    COP [80] ( #1B )
    COP [82]
    BRL gv_enemy_walking_bush_0FAB9A
}
---------------------------------------------

; The Fly: flits in random directions.
; 
; When: meta type $23; spawned by Underground Castle lairs (the Fly lairs of the walkthrough, records $0F and $12).
; Sees: a fly that never aims at the hero; the walkthrough says 'running into you'.
; Why: it draws a random number (COP 1F, rng_state + 1 & 3) and plays one of four movements ($14, $12, $16 mirrored, $16) with COP 9D / 9E until a wall is hit (COP 9E jumps back).
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

gv_enemy_fly_0FAC31 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAC3F

  code_0FAC39:
    COP [1B] ( &gv_enemy_fly_0FAC31, #$0010 )

  loc_0FAC3F:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FAC52
    DEC 
    BEQ loc_0FAC5B
    DEC 
    BEQ loc_0FAC64
    DEC 
    BEQ loc_0FAC6F

  loc_0FAC52:
    COP [9D] ( #14 )
    COP [9E] ( &code_0FAC39 )

  loc_0FAC59:
    BRA gv_enemy_fly_0FAC31

  loc_0FAC5B:
    COP [9D] ( #12 )
    COP [9E] ( &code_0FAC39 )

  loc_0FAC62:
    BRA gv_enemy_fly_0FAC31

  loc_0FAC64:
    COP [96]
    COP [9D] ( #16 )
    COP [9E] ( &code_0FAC39 )

  loc_0FAC6D:
    BRA gv_enemy_fly_0FAC31

  loc_0FAC6F:
    COP [97]
    COP [9D] ( #16 )
    COP [9E] ( &code_0FAC39 )

  loc_0FAC78:
    BRA gv_enemy_fly_0FAC31
}
---------------------------------------------

; The Blue Liquid: lies still, then slides towards the hero.
; 
; When: meta type $24; placed directly in A02S01 and A02S02 ('Blue Liquids laying around').
; Sees: a blob (animation $2E) that stirs (animation $2F) when the hero is inside its box widened by 5, then slides with animations $30-$33.
; Why: COP 9C decides whether the X or the Y distance is larger, then COP 9A / 9B pick the side.
; In: actor script, X = own slot.
; Out: returns to animation $2E when the actor is off screen ($16 bit $8000).
; Clobbers: A.

gv_enemy_blue_liquid_0FAC7A {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAC88
    COP [1B] ( &gv_enemy_blue_liquid_0FAC7A, #$0020 )

  loc_0FAC88:
    COP [0C] ( #00, #05, &code_0FAC95 )
    COP [80] ( #2E )
    COP [82]
    BRA gv_enemy_blue_liquid_0FAC7A
}

code_0FAC95 {
    COP [80] ( #2F )
    COP [82]

  loc_0FAC9A:
    COP [9C] ( &code_0FACA0, &code_0FACC0 )
}

code_0FACA0 {
    COP [9A] ( #$0000, &code_0FACAA, &code_0FACDC, &code_0FACB5 )
}

code_0FACAA {
    COP [97]
    COP [9D] ( #33 )
    COP [9E] ( &code_0FACC0 )

  loc_0FACB3:
    BRA code_0FACDC
}

code_0FACB5 {
    COP [96]
    COP [9D] ( #33 )
    COP [9E] ( &code_0FACC0 )

  loc_0FACBE:
    BRA code_0FACDC
}

code_0FACC0 {
    COP [9B] ( #$0000, &code_0FACCA, &code_0FACDC, &code_0FACD3 )
}

code_0FACCA {
    COP [9D] ( #32 )
    COP [9E] ( &code_0FACA0 )

  loc_0FACD1:
    BRA code_0FACDC
}

code_0FACD3 {
    COP [9D] ( #31 )
    COP [9E] ( &code_0FACA0 )

  loc_0FACDA:
    BRA code_0FACDC
}

code_0FACDC {
    LDA $0016, X
    BIT #$8000
    BNE loc_0FACEB
    COP [80] ( #30 )
    COP [82]
    BRA loc_0FAC9A

  loc_0FACEB:
    COP [80] ( #2E )
    COP [82]
    BRA gv_enemy_blue_liquid_0FAC7A
}
---------------------------------------------

; The Blue Torch: stands in place and shoots fireballs.
; 
; When: meta type $25; placed directly in A02S01 and A02S02.
; Sees: a torch that burns (animation $18, 8 repeats, then $19) and fires.
; Why: COP B0 spawns gv_enemy_torch_fireball_0FAD14 with flags $0200 once per cycle.
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

gv_enemy_blue_torch_0FACF2 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAD00
    COP [1B] ( &gv_enemy_blue_torch_0FACF2, #$0008 )

  loc_0FAD00:
    COP [81] ( #18, #08 )
    COP [83]
    COP [80] ( #19 )
    COP [82]
    COP [B0] ( @gv_enemy_torch_fireball_0FAD14, #$0200 )
    BRA gv_enemy_blue_torch_0FACF2
}

---------------------------------------------
; The fireball of the Blue Torch.
; 
; When: spawned by gv_enemy_blue_torch_0FACF2.
; Sees: a fireball that flies off (BRK $64).
; Why: priority $30 and drawn in front (COP A3 / A2); the flight itself is the shared tail shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67, entered through a pushed return address with Y = $1F.
; In: actor script, X = own slot.
; Out: RTL into cm_enemy_aimed_shot_body_002D67.
; Clobbers: A, Y.

gv_enemy_torch_fireball_0FAD14 {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$64
    LDY #$001F
    SEP #$20
    LDA #$^shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67
    PHA 
    REP #$20
    LDA #$&shared_actor_helpers_bank0.cm_enemy_aimed_shot_body_002D67-1
    PHA 
    RTL 
}