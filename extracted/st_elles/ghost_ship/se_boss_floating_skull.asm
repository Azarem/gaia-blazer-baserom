; The boss of the Ghost Ship, the Floating Skull, with its two hands, the fire attack and the link actor (world 2; file offsets 15939-16641, SNES $00:3E43-$4101, bank 00). Meta type $41 of MetaStElles; spawned by the boss lair record $B6 (location $32, one monster); boss_actor holds its slot and boss_fight_active is incremented.
; 
; === ROSTER ===
; - Floating Skull ($41): 17 / 8 / 69 HP / 200 EXP, flags $0000. The bestiary says 70 HP (OQ-I033-1). Walkthrough: 'magic will not affect this boss; only his hands, which are pretty much irrelevant'; no step of this file explains that.
; - Hands: spawned by COP AF with flags $0201 at (x $30 / $B0, y $70); each has HP $63 and $1A bit $0100. Walkthrough: 'His hands crawl towards you; they can be beaten in ~5 hits'.
; - Fire spawner (spawned with flags $0200), fire mouth and three fire anchors: the 'fiery anchors from his mouth'.
; - Link actor: ties the skull to another actor (see OPEN).
; 
; === HANDSHAKE ===
; The skull and the fire spawner talk through event flag $0000: the skull sets it (COP 09 $8000) and waits (COP 05 $8000) until the spawner has breathed fire and cleared it (COP 09 $0000); the spawner waits (COP 05 $0000) for the flag to be set. The link actor reads the same flag.
; 
; === OPEN ===
; - Which actor the link copies from and onto the skull is not known: its first read is $3C of the skull, the neighbour in the actor list, and nothing in the files names it (OQ-I036-12). While flag $0000 is clear it copies that actor's x and y to the skull; while the flag is set it copies its hit-stun counter ($26) and the $0800 bit of its $16, and when that actor is dying ($0400) it freezes the skull (se_boss_skull_halt_0040FB) and removes itself.
; - The 'rush forward' of the walkthrough is not a distinct step of the script: the skull moves with its animations ($1E, $1F, $20, $21); which animation is the rush is not known.
---------------------------------------------

?BANK 00

!boss_actor                     039A
!player_actor                   039C
!boss_fight_active              0458

---------------------------------------------

; The Floating Skull (boss).
; 
; When: meta type $41, spawned by the boss lair record $B6.
; Sees: boss_fight_active + 1, boss_actor = own slot; drawn in front; waits until on screen with the hero inside its box widened by 4 (else 8 frames per pass); then animation 0, COP 85 spawns the link, COP B0 the fire spawner (flags $0200), COP AF the left and right hands (flags $0201). Loop: four turns (flip X cleared and set, animation 1), animations $20 and $1E, sets flag $0000 and waits until the spawner has cleared it, animation $1F, then faces the hero by his x (below $80: flip X clear, otherwise set) with animation $21.
; Why: walkthrough: 'Rushing forward ... Releasing fiery anchors from his mouth'.
; In: actor script, X = own slot.
; Out: loops for ever (the boss dies through the engine).
; Clobbers: A, Y, boss_actor, boss_fight_active.

se_boss_floating_skull_003E43 {
    INC $boss_fight_active
    STX $boss_actor       ; boss_actor = the skull's slot (read by the engine)

  code_003E49:
    COP [A3]
    COP [AD] ( #08 )
    COP [0C] ( #00, #04, &code_003E5A )
    COP [1B] ( &code_003E49, #$0008 )
}

code_003E5A {
    COP [80] ( #00 )
    COP [82]
    COP [85] ( @se_boss_skull_link_00409B )
    COP [B0] ( @se_boss_skull_fire_spawner_003EC0, #$0200 )
    COP [AF] ( @se_boss_skull_hand_left_003F3F, #$0201 )
    COP [AF] ( @se_boss_skull_hand_right_003FEC, #$0201 )

  loc_003E79:
    COP [03] ( #04 )
    COP [97]
    COP [80] ( #01 )
    COP [82]
    COP [96]
    COP [80] ( #01 )
    COP [82]
    COP [04]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1E )
    COP [82]
    COP [09] ( #$8000 )   ; flag $0000 set: asks the fire spawner to breathe fire
    COP [05] ( #$8000 )   ; waits until the fire spawner has cleared flag $0000
    COP [80] ( #1F )
    COP [82]
    LDY $player_actor
    LDA $0000, Y
    CMP #$0080
    BCS loc_003EB7
    COP [97]
    COP [80] ( #21 )
    COP [82]
    BRA loc_003E79

  loc_003EB7:
    COP [96]
    COP [80] ( #21 )
    COP [82]
    BRA loc_003E79
}

---------------------------------------------
; The fire spawner: breathes the fire when the skull asks for it.
; 
; When: spawned (COP B0, flags $0200) by the skull.
; Sees: drawn in front; animation $22, waits until flag $0000 is set (COP 05), animation 3, spawns se_boss_skull_fire_mouth_003EE8 (flags $0200), waits 24 frames, animation 4, clears flag $0000 and starts again.
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_boss_skull_fire_spawner_003EC0 {
    COP [A3]

  loc_003EC2:
    COP [80] ( #22 )
    COP [82]
    COP [05] ( #$0000 )   ; waits until the skull has set flag $0000
    COP [80] ( #03 )
    COP [82]
    COP [AF] ( @se_boss_skull_fire_mouth_003EE8, #$0200 )
    COP [1B] ( &code_003EDD, #$0018 )
}

code_003EDD {
    COP [80] ( #04 )
    COP [82]
    COP [09] ( #$0000 )
    BRA loc_003EC2
}

---------------------------------------------
; The mouth of the fire attack: opens and releases three anchors.
; 
; When: spawned (COP AF, flags $0200) by the fire spawner.
; Sees: drawn in front, moves (+8, -4), animation $18, sound $51, spawns three fire anchors (flags $0200), animation $17 and COP 86.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_boss_skull_fire_mouth_003EE8 {
    COP [A3]
    COP [A1] ( #$0008, #$FFFC )
    COP [80] ( #18 )
    COP [82]
    BRK #$51
    COP [B0] ( @se_boss_skull_fire_anchor_003F14, #$0200 )
    COP [B0] ( @se_boss_skull_fire_anchor_003F1D, #$0200 )
    COP [B0] ( @se_boss_skull_fire_anchor_003F26, #$0200 )
    COP [80] ( #17 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; A fire anchor, animation $16, then the flight animation $14 (shares loc_003F2F).
; 
; When: spawned by the fire mouth.
; Sees: drawn in front; animation $16, then animation $14 loops until $16 bit $8000 is set (off screen) and COP 86.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_boss_skull_fire_anchor_003F14 {
    COP [A3]
    COP [80] ( #16 )
    COP [82]
    BRA loc_003F2F
}

---------------------------------------------
; A fire anchor, animation $15 (shares loc_003F2F).
; 
; When: spawned by the fire mouth.
; Sees: drawn in front; animation $15, then the flight animation $14 until off screen.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_boss_skull_fire_anchor_003F1D {
    COP [A3]
    COP [80] ( #15 )
    COP [82]
    BRA loc_003F2F
}

---------------------------------------------
; The mirrored fire anchor: flip X set, animation $15 (shares loc_003F2F).
; 
; When: spawned by the fire mouth.
; Sees: drawn in front; COP 96 sets flip X, animation $15, then the flight animation $14 until off screen.
; In: X = D = slot of the new actor.
; Out: RTL after COP 86.
; Clobbers: A.

se_boss_skull_fire_anchor_003F26 {
    COP [A3]
    COP [96]
    COP [80] ( #15 )
    COP [82]

  loc_003F2F:
    COP [80] ( #14 )
    COP [82]
    COP [1C] ( #$8000, &code_003F3C )
    BRA loc_003F2F
}

code_003F3C {
    COP [86]
    RTL 
}

---------------------------------------------
; The left hand of the skull: crawls after the hero; after ten points of damage it retreats for a while.
; 
; When: spawned (COP AF, flags $0201) by the skull.
; Sees: drawn in front; ORs $0100 into $1A (cannot be killed: 1 HP is kept). code_003F4A: flips cleared, x = $30, y = $70, animation $25 twenty times (it comes out), HP = $63, $16 bits $0300 cleared. While the HP is $5A or more COP 9C picks the axis and COP 9A / 9B (threshold 0) the side: it crawls by animations $27 / $29, $10 / $12, $0F / $11 or $26 / $28 with the matching flips. Below $5A it ORs $0300 into $16 (unhittable, no hit source), plays animation $25 twenty times (it goes in), waits 300 frames and starts again.
; Why: walkthrough: 'His hands crawl towards you; they can be beaten in ~5 hits' and 'The hands themselves are easily dealt with just because they get in your way'.
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_boss_skull_hand_left_003F3F {
    COP [A3]
    LDA $001A, X
    ORA #$0100
    STA $001A, X          ; $1A bit $0100: the hand survives a lethal hit with 1 HP

  code_003F4A:
    COP [99]
    COP [97]
    LDA #$0030
    STA $0000, X
    LDA #$0070
    STA $0002, X
    COP [81] ( #25, #14 )
    COP [83]
    SEP #$20
    LDA #$63
    STA $0025, X          ; HP = $63 at every appearance
    REP #$20
    LDA $0016, X
    AND #$FCFF
    STA $0016, X

  loc_003F72:
    LDA $0025, X
    AND #$00FF
    CMP #$005A            ; ten points of damage ($63 down to below $5A): the hand retreats
    BCC loc_003FD7
    COP [9C] ( &code_003F83, &code_003FAD )
}

code_003F83 {
    COP [9A] ( #$0000, &code_003F8D, &code_003F9D, &code_003F9D )
}

code_003F8D {
    COP [97]
    COP [99]
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #29 )
    COP [82]
    BRA loc_003F72
}

code_003F9D {
    COP [96]
    COP [99]
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #12 )
    COP [82]
    BRA loc_003F72
}

code_003FAD {
    COP [9B] ( #$0000, &code_003FB7, &code_003FC7, &code_003FC7 )
}

code_003FB7 {
    COP [97]
    COP [98]
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    BRA loc_003F72
}

code_003FC7 {
    COP [97]
    COP [99]
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #28 )
    COP [82]
    BRA loc_003F72

  loc_003FD7:
    LDA $0016, X
    ORA #$0300
    STA $0016, X          ; $16 |= $0300: unhittable and no hit source while the hand is away
    COP [81] ( #25, #14 )
    COP [83]
    COP [1B] ( &code_003F4A, #$012C )
}

---------------------------------------------
; The right hand of the skull: the mirror of the left hand, starting at x = $B0.
; 
; When: spawned (COP AF, flags $0201) by the skull.
; Sees: COP 96 first (flip X set); code_003FF9: x = $B0, y = $70, animation $0E twenty times to come out, HP = $63; the crawl and the retreat below HP $5A (animation $0E again, 300 frames) are those of se_boss_skull_hand_left_003F3F with the animation pairs swapped.
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_boss_skull_hand_right_003FEC {
    COP [A3]
    COP [96]
    LDA $001A, X
    ORA #$0100
    STA $001A, X

  code_003FF9:
    COP [99]
    COP [97]
    LDA #$00B0
    STA $0000, X
    LDA #$0070
    STA $0002, X
    COP [81] ( #0E, #14 )
    COP [83]
    SEP #$20
    LDA #$63
    STA $0025, X
    REP #$20
    LDA $0016, X
    AND #$FCFF
    STA $0016, X

  loc_004021:
    LDA $0025, X
    AND #$00FF
    CMP #$005A
    BCC loc_004086
    COP [9C] ( &code_004032, &code_00405C )
}

code_004032 {
    COP [9A] ( #$0000, &code_00403C, &code_00404C, &code_00404C )
}

code_00403C {
    COP [97]
    COP [99]
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #12 )
    COP [82]
    BRA loc_004021
}

code_00404C {
    COP [96]
    COP [99]
    COP [80] ( #27 )
    COP [82]
    COP [80] ( #29 )
    COP [82]
    BRA loc_004021
}

code_00405C {
    COP [9B] ( #$0000, &code_004066, &code_004076, &code_004076 )
}

code_004066 {
    COP [97]
    COP [98]
    COP [80] ( #26 )
    COP [82]
    COP [80] ( #28 )
    COP [82]
    BRA loc_004021
}

code_004076 {
    COP [97]
    COP [99]
    COP [80] ( #0F )
    COP [82]
    COP [80] ( #11 )
    COP [82]
    BRA loc_004021

  loc_004086:
    LDA $0016, X
    ORA #$0300
    STA $0016, X
    COP [81] ( #0E, #14 )
    COP [83]
    COP [1B] ( &code_003FF9, #$012C )
}

---------------------------------------------
; The link actor of the skull (see the block note).
; 
; When: spawned (COP 85) by the skull before its other actors.
; Sees: its y field holds the skull's slot and its x field the slot read from $3C of the skull; each frame, with flag $0000 clear, it copies the x and y of that actor onto the skull; with the flag set it copies the hit-stun counter $26 and the $0800 bit of $16 and, when that actor is dying ($0400), sets the skull's resume address to se_boss_skull_halt_0040FB with a wait of 0 and removes itself.
; Why: not known (OQ-I036-12).
; In: X = D = slot of the new actor.
; Out: RTL (one pass per frame).
; Clobbers: A, Y.

se_boss_skull_link_00409B {
    LDA $003C, X
    STA $0002, X
    TAY 
    LDA $003C, Y
    STA $0000, X
    COP [91]
    PHX 
    COP [07] ( #$8000, &code_0040C4 ) ; flag $0000 set (the fire attack): jump to the status copy
    LDA $0000, X
    LDY $0002, X
    TAX 
    LDA $0000, X
    STA $0000, Y
    LDA $0002, X
    STA $0002, Y
}

code_0040C4 {
    PLX 
    PHX 
    LDA $0000, X
    LDY $0002, X
    TAX 
    LDA $0026, X
    STA $0026, Y          ; copies the hit-stun counter of the other actor to the skull
    LDA $0016, X
    BIT #$0400            ; the other actor is dying: the skull is halted
    BNE loc_0040ED
    AND #$0800
    PHA 
    LDA $0016, Y
    AND #$F7FF
    ORA $01, S
    STA $0016, Y
    PLA 
    PLX 
    RTL 

  loc_0040ED:
    TYX 
    LDA #$&se_boss_skull_halt_0040FB
    STA $0018, X
    STZ $0014, X
    PLX 
    COP [86]
    RTL 
}
---------------------------------------------

; Halt routine of the skull: clears its speeds.
; 
; When: the link actor made it the resume address of the skull.
; Sees: STZ $04 and $06 (dx, dy).
; In: X = slot of the skull.
; Out: RTL.
; Clobbers: none.

se_boss_skull_halt_0040FB {
    STZ $0004, X
    STZ $0006, X
    RTL 
}