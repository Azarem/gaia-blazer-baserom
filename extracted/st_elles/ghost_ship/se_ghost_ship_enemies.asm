; The enemies of the Ghost Ship scenes (world 2; file offsets 16642-17048, SNES $00:4102-$4298, bank 00): the Purple Worm ($44) with its burst variant ($46) and fragments, and the Ghost Ship Torch ($45) with its fireball. All of them are placed in the scenes (no lair record spawns them) and all remove themselves once switch $B6 is set.
; 
; === ROSTER (meta type: attack / defence / HP / EXP; bestiary row) ===
; - $44 Purple Worm: 9 / 8 / 5 / 10 (bestiary: 5 HP, 10 EXP, 'Wriggling around'), flags $0200. 'Look out for Purple Worms coming up from below.'
; - $45 Ghost Ship Torch: 10 / 0 / 1 / 0, flags $0201 (bestiary: '? HP', 0 EXP, 'Fireballs'). 'The torches around here are indestructible - attacks merely will stem their efforts for a few seconds.'
; - $46 worm burst: 9 / 8 / 5 / 10, flags $0300: the same stats as the Purple Worm, but it only throws the three fragments.
; 
; === FLAGS ===
; - Switch $B6 is the lair record of the Floating Skull (record $B6, location $32, one monster of type $41). COP 14 in the worm, the torch and the burst jumps to a kill (COP 86) once the boss is beaten and the lair released; the burst only freezes itself (SetEntryHere + RTL).
; - $16 bit $0200 makes an actor unhittable (target mask $EEC0 of the engine); the worm clears it (STZ $16) when it comes out of the floor, the torch sets it while it is stunned. $1A bit $0100 keeps the torch alive with 1 HP.
; 
; === OPEN ===
; - The burst variant ($46) bursts when the hero is at least $30 pixels ABOVE it (COP 9B, first target); why the trap only fires then, and where the type is placed, is not known (OQ-I036-11).
---------------------------------------------

?BANK 00

---------------------------------------------

; The Purple Worm: waits under the floor, comes out when the hero is near and crawls after him.
; 
; When: meta type $44; placed in the Ghost Ship scenes.
; Sees: COP 14 (switch $B6) removes it after the boss; while waiting (animation $1A, unhittable by the meta flags $0200) it waits until on screen and tests the hero inside its box widened by 3; then sound $A1, COP B0 spawns three fragments (flags $0200), STZ $16 clears the flags (it can be hit now), animation $0B (it comes out); afterwards it waits until on screen and, with the hero inside the box widened by 4, COP 9C picks the axis and COP 9A / 9B (threshold $10) the side, a tile test (COP 23 / 24 / 21 / 22) stops it at a wall and it crawls by animation $0D (sideways, flip X by the side) or $0C (flip Y for up); otherwise animation $2A.
; Why: walkthrough: 'Purple Worms coming up from below'; bestiary 'Wriggling around'.
; In: actor script, X = own slot.
; Out: loops for ever, or COP 86 when switch $B6 is set.
; Clobbers: A.

se_enemy_purple_worm_004102 {
    COP [14] ( #$00B6, &code_00419D ) ; switch $B6 = the Floating Skull's lair record: the worm removes itself once the boss lair is released

  loc_004108:
    COP [AD] ( #08 )
    COP [0C] ( #00, #03, &code_004118 )
    COP [80] ( #1A )
    COP [82]
    BRA loc_004108
}

code_004118 {
    BRK #$A1
    COP [B0] ( @se_enemy_worm_fragment_004281, #$0200 )
    COP [B0] ( @se_enemy_worm_fragment_004289, #$0200 )
    COP [B0] ( @se_enemy_worm_fragment_004291, #$0200 )
    STZ $0016, X          ; clears the meta flags ($0200 = unhittable): from now on the worm can be hit
    COP [80] ( #0B )
    COP [82]

  loc_004137:
    COP [AD] ( #08 )
    COP [0C] ( #00, #04, &code_004147 )

  code_004140:
    COP [80] ( #2A )
    COP [82]
    BRA loc_004137
}

code_004147 {
    COP [9C] ( &code_00414D, &code_004175 )
}

code_00414D {
    COP [9A] ( #$0010, &code_004157, &code_004166, &code_004166 )
}

code_004157 {
    COP [23] ( &code_004140 )
    COP [97]
    COP [99]
    COP [80] ( #0D )
    COP [82]
    BRA code_004140
}

code_004166 {
    COP [24] ( &code_004140 )
    COP [96]
    COP [99]
    COP [80] ( #0D )
    COP [82]
    BRA code_004140
}

code_004175 {
    COP [9B] ( #$0010, &code_00417F, &code_00418E, &code_00418E )
}

code_00417F {
    COP [21] ( &code_004140 )
    COP [97]
    COP [98]
    COP [80] ( #0C )
    COP [82]
    BRA code_004140
}

code_00418E {
    COP [22] ( &code_004140 )
    COP [97]
    COP [99]
    COP [80] ( #0C )
    COP [82]
    BRA code_004140
}

code_00419D {
    COP [86]
    RTL 
}
---------------------------------------------

; The Ghost Ship Torch: lights up when the hero is near, shoots fireballs along its row; a hit only stuns it.
; 
; When: meta type $45; placed on the Ghost Ship deck.
; Sees: COP 14 (switch $B6) removes it after the boss; Y - 8; ORs $0100 into its $1A (survives a lethal hit with 1 HP). It waits on animation $23 until the hero is within $40 pixels vertically (COP 9B), then plays animation 5, sets HP ($25) = $63 and clears $0200 of its $16. Then a loop of 15 passes (COP 03): when the HP is below $63 it was hit: $16 |= $0200, animation 9, animation $23, and after 300 frames (COP 1B, $012C) it lights up again; otherwise, with the hero level (within $10 pixels vertically) it plays animation 7, spawns se_enemy_torch_fireball_004231 (flags $0200), animations 8 and 6; with the hero not level it plays animation 6 and COP 04 repeats the pass, and after the 15th pass it fires anyway.
; Why: walkthrough: 'The torches ... are indestructible - attacks merely will stem their efforts for a few seconds' and 'his fire-anchor attack only works if you're stupid enough to fight amongst the torches'.
; In: actor script, X = own slot.
; Out: loops for ever, or COP 86.
; Clobbers: A.

se_enemy_ghost_ship_torch_0041A0 {
    COP [14] ( #$00B6, &code_004245 )
    COP [A0] ( #$FFF8 )
    LDA $001A, X
    ORA #$0100
    STA $001A, X          ; $1A bit $0100: survives a lethal hit with 1 HP, so the torch cannot be destroyed

  loc_0041B3:
    COP [AD] ( #08 )
    COP [9B] ( #$0040, &code_0041C0, &code_0041C7, &code_0041C0 )
}

code_0041C0 {
    COP [80] ( #23 )
    COP [82]
    BRA loc_0041B3
}

code_0041C7 {
    COP [AD] ( #08 )
    COP [80] ( #05 )
    COP [82]
    SEP #$20
    LDA #$63
    STA $0025, X          ; HP = $63 when it lights up; any hit makes it lower than $63 and stuns the torch
    REP #$20
    LDA $0016, X
    AND #$FDFF
    STA $0016, X

  loc_0041E1:
    COP [03] ( #0F )
    LDA $0025, X
    AND #$00FF
    CMP #$0063
    BCC loc_004218
    COP [9B] ( #$0010, &code_0041F9, &code_004200, &code_0041F9 )
}

code_0041F9 {
    COP [80] ( #06 )
    COP [82]
    COP [04]
}

code_004200 {
    COP [80] ( #07 )
    COP [82]
    COP [B0] ( @se_enemy_torch_fireball_004231, #$0200 )
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #06 )
    COP [82]
    BRA loc_0041E1

  loc_004218:
    LDA $0016, X
    ORA #$0200
    STA $0016, X          ; $16 bit $0200: unhittable while stunned
    COP [80] ( #09 )
    COP [82]
    COP [80] ( #23 )
    COP [82]
    COP [1B] ( &code_0041C7, #$012C ) ; after 300 frames the torch lights up again
}

---------------------------------------------
; Fireball of a Ghost Ship Torch.
; 
; When: spawned (COP B0, flags $0200) by the torch.
; Sees: COP 8F faces it toward the hero's side, sound $5B, animation $13 loops until $16 bit $8000 is set (it left the screen), then COP 86.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_torch_fireball_004231 {
    COP [8F]
    BRK #$5B

  loc_004235:
    COP [80] ( #13 )
    COP [82]
    COP [1C] ( #$8000, &code_004242 )
    BRA loc_004235
}

code_004242 {
    COP [86]
    RTL 
}

code_004245 {
    COP [86]
    RTL 
}
---------------------------------------------

; A worm burst: throws three worm fragments when the hero is far above it, then blocks its tile.
; 
; When: meta type $46 (flags $0300); placed.
; Sees: drawn behind (COP A4), COP 16 clears its own tiles, COP 14 (switch $B6) freezes it after the boss (SetEntryHere + RTL); every 8 frames COP 9B ($30) tests the hero: when he is at least $30 pixels above it, sound $A1, three fragments (COP B0, flags $0200), COP 15 blocks its own tiles and COP 86 ends it.
; Why: not known (OQ-I036-11).
; In: actor script, X = own slot.
; Out: COP 86 after the burst.
; Clobbers: A.

se_obj_worm_burst_004248 {
    COP [A4]
    COP [16]
    COP [14] ( #$00B6, &code_00427E )

  code_004252:
    COP [9B] ( #$0030, &code_004262, &code_00425C, &code_00425C )
}

code_00425C {
    COP [1B] ( &code_004252, #$0008 )
}

code_004262 {
    BRK #$A1
    COP [B0] ( @se_enemy_worm_fragment_004281, #$0200 )
    COP [B0] ( @se_enemy_worm_fragment_004289, #$0200 )
    COP [B0] ( @se_enemy_worm_fragment_004291, #$0200 )
    COP [15]              ; the burst leaves its tiles blocked after it disappears
    COP [86]
    RTL 
}

code_00427E {
    COP [91]
    RTL 
}
---------------------------------------------

; Worm fragment, animation $1B.
; 
; When: spawned (COP B0, flags $0200) by the worm or the burst.
; Sees: animation $1B, then COP 86.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_worm_fragment_004281 {
    COP [80] ( #1B )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Worm fragment, animation $1C.
; 
; When: spawned by the worm or the burst.
; Sees: animation $1C, then COP 86.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_worm_fragment_004289 {
    COP [80] ( #1C )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Worm fragment, animation $1D.
; 
; When: spawned by the worm or the burst.
; Sees: animation $1D, then COP 86.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_enemy_worm_fragment_004291 {
    COP [80] ( #1D )
    COP [82]
    COP [86]
    RTL 
}