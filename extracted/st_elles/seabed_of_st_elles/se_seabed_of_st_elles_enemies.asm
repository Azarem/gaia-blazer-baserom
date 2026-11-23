; The enemies of the seabed scenes (world 2, St. Elles; file offsets 1030943-1031032 and 1031075-1031973, SNES $1F:BB1F-$BB77 and $BBA3-$BF24): the Sea Urchin ($32), the Jellyfish ($34), the Hermit Crab ($35), the Manta Ray ($36) with its bolt and the Yellow Seahorse ($37). The unused type $33 sits between them in se_enemy_0FBB78.
; 
; === ROSTER (meta type: attack / defence / HP / EXP; bestiary row) ===
; - $32 Sea Urchin: 9 / 2 / 36 / 20 (bestiary: 36 HP, 20 EXP, 'Moving around'). Not in any lair: placed directly.
; - $34 Jellyfish: 6 / 1 / 10 / 25 (10 HP, 25 EXP, 'Quick rushes'). Lair records $78, $7B, $82, $83 (releases the jumping angelfish), $85, $88 and $C2 (Anna).
; - $35 Hermit Crab: 9 / 4 / 15 / 22 (15 HP, 22 EXP, 'Walking around'). Lair records $77, $80, $86 (the best jumper angelfish), $AD (the creek angelfish) and $B7.
; - $36 Manta Ray: 8 / 3 / 10 / 30 (10 HP, 30 EXP, 'Electric projectiles'). Lair records $7A (the 250 EXP fairy), $7C (Servas), $7E and $84 (the herb mermaid).
; - $37 Yellow Seahorse: 6 / 3 / 8 / 21 (8 HP, 21 EXP, 'Moving around'). Lair records $7F (the 300 EXP fairy), $81, $87 and $C1 (the pearl ride dolphin).
; 
; === NOTES ===
; - The Hermit Crab sets bit $0400 (the metal immunity class: only the Zantetsu Sword hurts) of its $1A while it hides in its shell and clears it while it walks; the walkthrough bestiary lists it as 'Metal? No' (OQ-I036-8).
; - The identities rest on the HP / EXP match in MetaStElles (inferred, no names in the ROM) and, for the lairs, on the walkthrough sentences: 'Jellyfish lair that releases an angelfish', 'Yellow Seahorse lair ... releases a Fairy Gem that hands over 300 EXP', 'Manta Rays ... Use the lair to release a mermaid'.
---------------------------------------------

?BANK 1F

!rng_state                      0301

---------------------------------------------

; The Sea Urchin: sits and turns toward the hero.
; 
; When: meta type $32; placed directly in the seabed scenes (no lair).
; Sees: while off screen ($16 bit $8000) it waits 16 frames per pass; otherwise animation $04 until the hero is inside its box widened by 5 (COP 0C), then it faces him: COP 9C picks the axis, COP 9A / 9B the side, animation $07 sideways (flip set or cleared) or $06 / $05 vertically.
; Why: walkthrough: 'They move rather slowly, so it's not their offense that annoys, but their defense'.
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_enemy_sea_urchin_0FBB1F {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FBB2D
    COP [1B] ( &se_enemy_sea_urchin_0FBB1F, #$0010 )

  loc_0FBB2D:
    COP [0C] ( #00, #05, &code_0FBB3A )
    COP [80] ( #04 )
    COP [82]
    BRA se_enemy_sea_urchin_0FBB1F
}

code_0FBB3A {
    COP [9C] ( &code_0FBB40, &code_0FBB5C )
}

code_0FBB40 {
    COP [9A] ( #$0000, &code_0FBB4A, &code_0FBB53, &code_0FBB53 )
}

code_0FBB4A {
    COP [97]
    COP [80] ( #07 )
    COP [82]
    BRA se_enemy_sea_urchin_0FBB1F
}

code_0FBB53 {
    COP [96]
    COP [80] ( #07 )
    COP [82]
    BRA se_enemy_sea_urchin_0FBB1F
}

code_0FBB5C {
    COP [9B] ( #$0000, &code_0FBB66, &code_0FBB6F, &code_0FBB6F )
}

code_0FBB66 {
    COP [97]
    COP [80] ( #06 )
    COP [82]
    BRA se_enemy_sea_urchin_0FBB1F
}

code_0FBB6F {
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRA se_enemy_sea_urchin_0FBB1F
}
---------------------------------------------

; The Jellyfish: drifts at random and rushes when the hero is lined up.
; 
; When: meta type $34; spawned by the Jellyfish lairs.
; Sees: drawn in front (COP A3, priority $30); waits until on screen (COP AD); when the hero is within $18 pixels on one axis it rushes along the other with animations $28-$2B (two repeats); otherwise code_0FBBD3 picks one of animations $03, $2C, $02, $01 at random (COP 1F, rng_state+1 AND 3).
; Why: walkthrough: 'let their fast tackles carry them over to you so you can mash them with your sword'.
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_enemy_jellyfish_0FBBA3 {
    COP [A3]
    COP [A2] ( #30 )

  loc_0FBBA8:
    COP [AD] ( #10 )
    COP [9A] ( #$0018, &code_0FBBB5, &code_0FBBC9, &code_0FBBB5 )
}

code_0FBBB5 {
    COP [9B] ( #$0018, &code_0FBBD3, &code_0FBBBF, &code_0FBBD3 )
}

code_0FBBBF {
    COP [9A] ( #$0000, &code_0FBC01, &code_0FBC09, &code_0FBC09 )
}

code_0FBBC9 {
    COP [9B] ( #$0000, &code_0FBC11, &code_0FBC19, &code_0FBC19 )
}

code_0FBBD3 {
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ loc_0FBBE5
    DEC 
    BEQ loc_0FBBEC
    DEC 
    BEQ loc_0FBBF3
    BRA loc_0FBBFA

  loc_0FBBE5:
    COP [80] ( #03 )
    COP [82]
    BRA loc_0FBBA8

  loc_0FBBEC:
    COP [80] ( #2C )
    COP [82]
    BRA loc_0FBBA8

  loc_0FBBF3:
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FBBA8

  loc_0FBBFA:
    COP [80] ( #01 )
    COP [82]
    BRA loc_0FBBA8
}

code_0FBC01 {
    COP [81] ( #2A, #02 )
    COP [83]
    BRA code_0FBBD3
}

code_0FBC09 {
    COP [81] ( #2B, #02 )
    COP [83]
    BRA code_0FBBD3
}

code_0FBC11 {
    COP [81] ( #29, #02 )
    COP [83]
    BRA code_0FBBD3
}

code_0FBC19 {
    COP [81] ( #28, #02 )
    COP [83]
    BRL code_0FBBD3
}
---------------------------------------------

; The Hermit Crab: hides in its shell, comes out to walk and goes back.
; 
; When: meta type $35; spawned by the Hermit Crab lairs.
; Sees: ORs $0400 into $1A (metal class while hidden); off screen it waits 30 frames per pass; then a random direction (COP 1F, AND 3) is tried in a ring: COP 23 / 24 / 21 / 22 test the tile left, right, above, below and fall through to the next direction when it is blocked; the crab clears $0400, plays animation $1B (out), $1D, the walk ($20 left, $21 right, $1F up, $1E down) and $1C, ORs $0400 back and plays $1A (in), then starts again.
; Why: walkthrough: 'Walking around'.
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_enemy_hermit_crab_0FBC22 {
    LDA $001A, X
    ORA #$0400            ; $1A bit $0400 = metal immunity class (only the Zantetsu Sword hurts): set while the crab hides in its shell, cleared while it walks
    STA $001A, X

  code_0FBC2B:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FBC39

  loc_0FBC33:
    COP [1B] ( &code_0FBC2B, #$001E )

  loc_0FBC39:
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BEQ code_0FBC4C
    DEC 
    BEQ code_0FBC7D
    DEC 
    BEQ code_0FBCAE
    BRL code_0FBCE0

  code_0FBC4C:
    COP [23] ( &code_0FBC7D ) ; COP 23 / 24 / 21 / 22 test the tile left / right / above / below; a blocked side falls through to the next direction
    LDA $001A, X
    AND #$FBFF
    STA $001A, X
    COP [80] ( #1B )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1C )
    COP [82]
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [80] ( #1A )
    COP [82]
    BRA loc_0FBC33
}

code_0FBC7D {
    COP [24] ( &code_0FBCAE )
    LDA $001A, X
    AND #$FBFF
    STA $001A, X
    COP [80] ( #1B )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #21 )
    COP [82]
    COP [80] ( #1C )
    COP [82]
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [80] ( #1A )
    COP [82]
    BRA loc_0FBC33
}

code_0FBCAE {
    COP [21] ( &code_0FBCE0 )
    LDA $001A, X
    AND #$FBFF
    STA $001A, X
    COP [80] ( #1B )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #1C )
    COP [82]
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [80] ( #1A )
    COP [82]
    BRL loc_0FBC33
}

code_0FBCE0 {
    COP [22] ( &code_0FBC4C )
    LDA $001A, X
    AND #$FBFF
    STA $001A, X
    COP [80] ( #1B )
    COP [82]
    COP [80] ( #1D )
    COP [82]
    COP [80] ( #1E )
    COP [82]
    COP [80] ( #1C )
    COP [82]
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [80] ( #1A )
    COP [82]
    BRL loc_0FBC33
}
---------------------------------------------

; The Manta Ray: turns toward the hero, charges and fires an electric bolt.
; 
; When: meta type $36; spawned by the Manta Ray lairs.
; Sees: COP A5 chooses the first animation by the flip state ($08, $0A, $0A flipped, $09); then COP AD and COP 9C pick the axis; sideways it turns (COP 96 / 97), animation $0A and a charge loop with animation $0D until the hero is level (COP 9A); vertically animations $09 / $08 and $0C / $0B with COP 9B; to fire it ORs $0200 into its $16 (unhittable while it fires: the engine's target mask $EEC0), COP B2 spawns se_enemy_manta_bolt_0FBE44 at (-8, +8) with flags $0200, clears the bit and plays the shot animation twice.
; Why: walkthrough: 'pretty hard to beat if you let them live too long because of their electrical shocks'.
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_enemy_manta_ray_0FBD12 {
    COP [A5] ( &code_0FBD1C, &code_0FBD23, &code_0FBD2A, &code_0FBD33 )
}

code_0FBD1C {
    COP [80] ( #08 )
    COP [82]
    BRA loc_0FBD38
}

code_0FBD23 {
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FBD38
}

code_0FBD2A {
    COP [96]
    COP [80] ( #0A )
    COP [82]
    BRA loc_0FBD38
}

code_0FBD33 {
    COP [80] ( #09 )
    COP [82]

  loc_0FBD38:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FBD41, &code_0FBDC2 )
}

code_0FBD41 {
    COP [9A] ( #$0000, &code_0FBD4B, &code_0FBD86, &code_0FBD86 )
}

code_0FBD4B {
    COP [97]
    COP [80] ( #0A )
    COP [82]

  code_0FBD52:
    COP [80] ( #0D )
    COP [82]
    COP [9A] ( #$0000, &code_0FBD52, &code_0FBD61, &code_0FBD61 )
}

code_0FBD61 {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @se_enemy_manta_bolt_0FBE44, #$FFF8, #$0008, #$0200 ) ; spawns the bolt at (-8,+8) with flags $0200
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #0A, #02 )
    COP [83]
    BRA loc_0FBD38
}

code_0FBD86 {
    COP [96]
    COP [80] ( #0A )
    COP [82]

  code_0FBD8D:
    COP [80] ( #0D )
    COP [82]
    COP [9A] ( #$0000, &code_0FBD9C, &code_0FBD9C, &code_0FBD8D )
}

code_0FBD9C {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @se_enemy_manta_bolt_0FBE44, #$FFF8, #$0008, #$0200 )
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #0A, #02 )
    COP [83]
    BRL loc_0FBD38
}

code_0FBDC2 {
    COP [9B] ( #$0000, &code_0FBDCC, &code_0FBE08, &code_0FBE08 )
}

code_0FBDCC {
    COP [97]
    COP [80] ( #09 )
    COP [82]

  code_0FBDD3:
    COP [80] ( #0C )
    COP [82]
    COP [9B] ( #$0000, &code_0FBDD3, &code_0FBDE2, &code_0FBDE2 )
}

code_0FBDE2 {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @se_enemy_manta_bolt_0FBE44, #$FFF8, #$0008, #$0200 )
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #09, #02 )
    COP [83]
    BRL loc_0FBD38
}

code_0FBE08 {
    COP [97]
    COP [80] ( #08 )
    COP [82]

  code_0FBE0F:
    COP [80] ( #0B )
    COP [82]
    COP [9B] ( #$0000, &code_0FBE1E, &code_0FBE1E, &code_0FBE0F )
}

code_0FBE1E {
    LDA $0016, X
    ORA #$0200
    STA $0016, X
    COP [B2] ( @se_enemy_manta_bolt_0FBE44, #$FFF8, #$0008, #$0200 )
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    COP [81] ( #08, #02 )
    COP [83]
    BRL loc_0FBD38
}

---------------------------------------------
; The bolt of the Manta Ray.
; 
; When: spawned by the Manta Ray (COP B2) with flags $0200.
; Sees: drawn in front, flips cleared; animation $10 eight times, a sound (BRK #$4B), then by the larger distance to the hero (COP 9C / 9A / 9B) the flight animation $0F (sideways, flipped to the hero's side) or $0E (vertical, flip Y for 'above') for 32 repeats; then it kills itself.
; In: X = D = slot of the new actor; RTL after COP 86.
; Out: RTL.
; Clobbers: A.

se_enemy_manta_bolt_0FBE44 {
    COP [A3]
    COP [97]
    COP [99]
    COP [81] ( #10, #08 )
    COP [83]
    BRK #$4B
    COP [9C] ( &code_0FBE58, &code_0FBE62 )
}

code_0FBE58 {
    COP [9A] ( #$0000, &code_0FBE78, &code_0FBE76, &code_0FBE76 )
}

code_0FBE62 {
    COP [9B] ( #$0000, &code_0FBE6C, &code_0FBE6E, &code_0FBE6E )
}

code_0FBE6C {
    COP [98]
}

code_0FBE6E {
    COP [81] ( #0E, #20 )
    COP [83]
    BRA loc_0FBE7E
}

code_0FBE76 {
    COP [96]
}

code_0FBE78 {
    COP [81] ( #0F, #20 )
    COP [83]

  loc_0FBE7E:
    COP [86]
    RTL 
}
---------------------------------------------

; The Yellow Seahorse: swims toward the hero and flinches when it is hit.
; 
; When: meta type $37; spawned by the Yellow Seahorse lairs.
; Sees: remembers its HP in $30; waits until on screen; COP 9C / 9A / 9B pick the side and the swim animation ($16 / $15 / $14, eight repeats, flipped by COP 96 / 97); after each swim code_0FBF13 compares the HP; when it changed the hit animations ($19 or $18 or $17, then $13 or $12 or $11) play.
; Why: walkthrough: 'their IQ is as low as their health'.
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_enemy_yellow_seahorse_0FBE81 {
    LDA $0025, X
    AND #$00FF
    STA $0030, X          ; $30 = the last HP seen; code_0FBF13 compares it with the HP in $25

  loc_0FBE8A:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FBE93, &code_0FBED3 )
}

code_0FBE93 {
    COP [9A] ( #$0000, &code_0FBE9D, &code_0FBEB8, &code_0FBEB8 )
}

code_0FBE9D {
    COP [97]
    COP [81] ( #16, #08 )
    COP [83]
    JSR $&code_0FBF13
    BCC loc_0FBE8A
    COP [81] ( #19, #04 )
    COP [83]
    COP [81] ( #13, #10 )
    COP [83]
    BRA loc_0FBE8A
}

code_0FBEB8 {
    COP [96]
    COP [81] ( #16, #08 )
    COP [83]
    JSR $&code_0FBF13
    BCC loc_0FBE8A
    COP [81] ( #19, #04 )
    COP [83]
    COP [81] ( #13, #10 )
    COP [83]
    BRA loc_0FBE8A
}

code_0FBED3 {
    COP [9B] ( #$0000, &code_0FBEDD, &code_0FBEF8, &code_0FBEF8 )
}

code_0FBEDD {
    COP [97]
    COP [81] ( #15, #08 )
    COP [83]
    JSR $&code_0FBF13
    BCC loc_0FBE8A
    COP [81] ( #18, #04 )
    COP [83]
    COP [81] ( #12, #10 )
    COP [83]
    BRA loc_0FBE8A
}

code_0FBEF8 {
    COP [97]
    COP [81] ( #14, #08 )
    COP [83]
    JSR $&code_0FBF13
    BCC loc_0FBE8A
    COP [81] ( #17, #04 )
    COP [83]
    COP [80] ( #11 )
    COP [82]
    BRL loc_0FBE8A
}

---------------------------------------------
; HP change test of the Yellow Seahorse.
; 
; When: after every swim step.
; Sees: compares the low byte of the HP ($25) with the remembered value in $30; when they differ the new value is stored.
; In: X = own slot.
; Out: carry set when the HP changed (the seahorse was hit), carry clear otherwise.
; Clobbers: A.

code_0FBF13 {
    LDA $0025, X
    AND #$00FF
    CMP $0030, X
    BEQ loc_0FBF23
    STA $0030, X
    SEC 
    RTS 

  loc_0FBF23:
    CLC 
    RTS 
}