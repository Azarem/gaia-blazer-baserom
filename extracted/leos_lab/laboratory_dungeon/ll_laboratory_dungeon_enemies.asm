; The enemies of the Laboratory Dungeon (file offsets 1036917-1038659, SNES $1F:D275-$D943, bank 1F): the Mini Race Car ($1F), Mini Bulldozer ($20), Mini Helicopter ($21), Ball Worm ($22), the Flail ($23) and the Sweeper Bot ($24) with its eight burst pieces.
; 
; === ROSTER ===
; Stats from MetaLeosLab (attack, defence, HP binary, EXP BCD) against docs/walkthrough/enemy-bestiary.md: Mini Race Car $1F 12 HP / 150 EXP ('Ramming you fast', metal), Mini Bulldozer $20 14 HP / 145 EXP ('Ramming you', metal), Mini Helicopter $21 18 HP / 160 EXP ('Ramming you', metal), Ball Worm $22 18 HP / 150 EXP ('Leaping at you'), Sweeper Bot $24 24 HP / 140 EXP ('Ramming you'). The Flail $23 has 1 HP and 0 EXP and no bestiary row: it is the pipe obstacle of the walkthrough ('dodging the flails in the pipe dream'; 'Dodge the two pairs of flails'). The three metal enemies set $1A bit $0400 at the start of their script and need the Zantetsu Sword (the Sweeper Bot and the Ball Worm do not).
; All of them are spawned by lairs (RunLairRespawn / SpawnAll) or placed in the scenes; the walkthrough ties lairs to releases: the Mini Bulldozer lairs release a mouse, the Mini Race Cars' lair removes pipes, the Mini Helicopters' lairs release the Fairy Gems (lair records $127 and $130, see ll_laboratory_dungeon_actors), the Ball Worms' lair releases a cat, and the Sweeper Bots' lair assaults the Mini Bulldozers.
; 
; === SHARED PATTERNS ===
; COP A5 (CopA5_JumpByFlipState) starts the Race Car, Ball Worm, Flail and Sweeper Bot in one of four states chosen by the flip bits that the placement or lair gave the actor (none, flip X, flip Y, both): the flips are the start direction, not a picture. COP 9A / 9B compare the hero's X / Y with a threshold (Bulldozer $10, Helicopter 0 and 8, Ball Worm $20), COP 21-24 test the tile above, below, left and right. $16 bit $0100 is 'not a hit source' (cannot hurt) and $0200 'not a hit target' (cannot be hit); COP B2 spawns the child with the flags given.
; 
; === OPEN ===
; Which flip combination is which direction of travel is not traced (OQ-I038-5); the runners are described by their states.
---------------------------------------------

?BANK 1F

---------------------------------------------

; The Mini Race Car: a metal pipe runner that never looks at the hero.
; 
; When: meta type $1F; spawned by a lair or placed; runs every frame.
; Sees: $1A bit $0400 (metal) is set, COP A5 picks one of four runner states from the flip bits; each state drives straight with animations $00-$05 (COP 81, 2 repeats) and turns when COP 21-24 reports a blocked tile; there is no COP 9A / 9B, so it follows the pipe, not the hero.
; Why: 'Ramming you fast' (bestiary); the walkthrough sends the hero to its lairs to remove pipes.
; In: actor script, X = D = own slot.
; Out: loops forever.
; Clobbers: A.

ll_enemy_mini_race_car_0FD275 {
    LDA $001A, X
    ORA #$0400            ; $1A bit $0400: metal class, hurt only by the Zantetsu Sword (bestiary: Metal = yes)
    STA $001A, X
    COP [A5] ( &code_0FD316, &code_0FD2EA, &code_0FD288, &code_0FD2BC )
}

code_0FD288 {
    COP [21] ( &code_0FD29C )
    COP [96]
    COP [80] ( #02 )
    COP [82]
    COP [97]
    COP [80] ( #01 )
    COP [82]
    BRA loc_0FD2D2
}

code_0FD29C {
    COP [24] ( &code_0FD2AC )

  loc_0FD2A0:
    COP [96]
    COP [81] ( #05, #02 )
    COP [83]
    COP [97]
    BRA code_0FD288
}

code_0FD2AC {
    COP [96]
    COP [80] ( #02 )
    COP [82]
    COP [97]
    COP [80] ( #00 )
    COP [82]
    BRA code_0FD316
}

code_0FD2BC {
    COP [23] ( &code_0FD2CE )
    COP [97]
    COP [80] ( #01 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    BRA loc_0FD300
}

code_0FD2CE {
    COP [21] ( &code_0FD2DA )

  loc_0FD2D2:
    COP [81] ( #04, #02 )
    COP [83]
    BRA code_0FD2BC
}

code_0FD2DA {
    COP [97]
    COP [80] ( #01 )
    COP [82]
    COP [96]
    COP [80] ( #02 )
    COP [82]
    BRA code_0FD288
}

code_0FD2EA {
    COP [22] ( &code_0FD2FC )
    COP [97]
    COP [80] ( #02 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    BRA loc_0FD32F
}

code_0FD2FC {
    COP [23] ( &code_0FD308 )

  loc_0FD300:
    COP [81] ( #05, #02 )
    COP [83]
    BRA code_0FD2EA
}

code_0FD308 {
    COP [97]
    COP [80] ( #02 )
    COP [82]
    COP [80] ( #01 )
    COP [82]
    BRA code_0FD2BC
}

code_0FD316 {
    COP [24] ( &code_0FD32B )
    COP [97]
    COP [80] ( #00 )
    COP [82]
    COP [96]
    COP [80] ( #02 )
    COP [82]
    BRL loc_0FD2A0
}

code_0FD32B {
    COP [22] ( &code_0FD337 )

  loc_0FD32F:
    COP [81] ( #03, #02 )
    COP [83]
    BRA code_0FD316
}

code_0FD337 {
    COP [97]
    COP [80] ( #00 )
    COP [82]
    COP [80] ( #02 )
    COP [82]
    BRA code_0FD2EA
}
---------------------------------------------

; The Mini Bulldozer: waits off screen, then charges at the hero.
; 
; When: meta type $20; runs every frame.
; Sees: metal ($1A bit $0400). With bit $8000 of $16 set (off screen) it waits 4 frames (COP 1B) and tests again; on screen COP 9A / 9B (threshold $10) pick the side, up or down, and the charge: a pose (animation $08 side, $07 up, $06 down), then two charge animations (4 and 16 repeats, with the pose between them and after them): side $08 / $0D / $0E, up $07 / $0B / $0C, down $06 / $09 / $0A; COP 96 / 97 set the flip for left or right.
; Why: 'Ramming you' (bestiary).
; In: actor script, X = D = own slot.
; Out: loops forever.
; Clobbers: A.

ll_enemy_mini_bulldozer_0FD345 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X

  code_0FD34E:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FD35C

  code_0FD356:
    COP [1B] ( &code_0FD34E, #$0004 )

  loc_0FD35C:
    COP [9A] ( #$0010, &code_0FD366, &code_0FD370, &code_0FD366 )
}

code_0FD366 {
    COP [9B] ( #$0010, &code_0FD356, &code_0FD37A, &code_0FD356 )
}

code_0FD370 {
    COP [9B] ( #$0000, &code_0FD3C2, &code_0FD3E2, &code_0FD3E2 )
}

code_0FD37A {
    COP [9A] ( #$0000, &code_0FD384, &code_0FD3A3, &code_0FD3A3 )
}

code_0FD384 {
    COP [97]
    COP [80] ( #08 )
    COP [82]
    COP [81] ( #0D, #04 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    COP [81] ( #0E, #10 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FD34E
}

code_0FD3A3 {
    COP [96]
    COP [80] ( #08 )
    COP [82]
    COP [81] ( #0D, #04 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    COP [81] ( #0E, #10 )
    COP [83]
    COP [80] ( #08 )
    COP [82]
    BRA code_0FD34E
}

code_0FD3C2 {
    COP [97]
    COP [80] ( #07 )
    COP [82]
    COP [81] ( #0B, #04 )
    COP [83]
    COP [80] ( #07 )
    COP [82]
    COP [81] ( #0C, #10 )
    COP [83]
    COP [80] ( #07 )
    COP [82]
    BRL code_0FD34E
}

code_0FD3E2 {
    COP [97]
    COP [80] ( #06 )
    COP [82]
    COP [81] ( #09, #04 )
    COP [83]
    COP [80] ( #06 )
    COP [82]
    COP [81] ( #0A, #10 )
    COP [83]
    COP [80] ( #06 )
    COP [82]
    BRL code_0FD34E
}
---------------------------------------------

; The Mini Helicopter: a metal flier that goes for the hero along the longer axis.
; 
; When: meta type $21; runs every frame.
; Sees: metal ($1A bit $0400); waits while off screen (COP AD, 8 frames); COP 9C picks the axis with the greater distance to the hero, COP 9A / 9B (threshold 0, then 8) the direction; it flies in steps of animations $16-$19 (2 repeats) and tests the tile under it with COP 28 after each (what it tests for: OQ-I038-12); the second phase (animation $15, then $12-$14 with 4 repeats and the turn poses $0F-$11) is the same chase with threshold 0.
; Why: 'Ramming you' (bestiary); two of its lairs release the Fairy Gems.
; In: actor script, X = D = own slot.
; Out: loops forever.
; Clobbers: A.

ll_enemy_mini_helicopter_0FD402 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X

  loc_0FD40B:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FD414, &code_0FD41E )
}

code_0FD414 {
    COP [9A] ( #$0000, &code_0FD428, &code_0FD440, &code_0FD440 )
}

code_0FD41E {
    COP [9B] ( #$0000, &code_0FD458, &code_0FD470, &code_0FD470 )
}

code_0FD428 {
    COP [97]

  code_0FD42A:
    COP [81] ( #18, #02 )
    COP [83]
    COP [28] ( &code_0FD436 )
    BRA loc_0FD488
}

code_0FD436 {
    COP [9A] ( #$0008, &code_0FD42A, &code_0FD41E, &code_0FD440 )
}

code_0FD440 {
    COP [97]

  code_0FD442:
    COP [81] ( #19, #02 )
    COP [83]
    COP [28] ( &code_0FD44E )
    BRA loc_0FD488
}

code_0FD44E {
    COP [9A] ( #$0008, &code_0FD428, &code_0FD41E, &code_0FD442 )
}

code_0FD458 {
    COP [97]

  code_0FD45A:
    COP [81] ( #17, #02 )
    COP [83]
    COP [28] ( &code_0FD466 )
    BRA loc_0FD488
}

code_0FD466 {
    COP [9B] ( #$0008, &code_0FD45A, &code_0FD414, &code_0FD470 )
}

code_0FD470 {
    COP [97]

  code_0FD472:
    COP [81] ( #16, #02 )
    COP [83]
    COP [28] ( &code_0FD47E )
    BRA loc_0FD488
}

code_0FD47E {
    COP [9B] ( #$0008, &code_0FD458, &code_0FD414, &code_0FD472 )

  loc_0FD488:
    COP [80] ( #15 )
    COP [82]

  loc_0FD48D:
    COP [AD] ( #08 )
    COP [9C] ( &code_0FD496, &code_0FD4A0 )
}

code_0FD496 {
    COP [9A] ( #$0000, &code_0FD4AA, &code_0FD4C0, &code_0FD4C0 )
}

code_0FD4A0 {
    COP [9B] ( #$0000, &code_0FD4D6, &code_0FD4EC, &code_0FD4EC )
}

code_0FD4AA {
    COP [97]
    COP [23] ( &code_0FD4B8 )
    COP [81] ( #14, #04 )
    COP [83]
    BRA loc_0FD48D
}

code_0FD4B8 {
    COP [80] ( #11 )
    COP [82]
    BRL loc_0FD40B
}

code_0FD4C0 {
    COP [96]
    COP [24] ( &code_0FD4CE )
    COP [81] ( #14, #04 )
    COP [83]
    BRA loc_0FD48D
}

code_0FD4CE {
    COP [80] ( #11 )
    COP [82]
    BRL loc_0FD40B
}

code_0FD4D6 {
    COP [97]
    COP [21] ( &code_0FD4E4 )
    COP [81] ( #13, #04 )
    COP [83]
    BRA loc_0FD48D
}

code_0FD4E4 {
    COP [80] ( #10 )
    COP [82]
    BRL loc_0FD40B
}

code_0FD4EC {
    COP [97]
    COP [22] ( &code_0FD4FA )
    COP [81] ( #12, #04 )
    COP [83]
    BRA loc_0FD48D
}

code_0FD4FA {
    COP [80] ( #0F )
    COP [82]
    BRL loc_0FD40B
}
---------------------------------------------

; The Ball Worm: a pipe walker that leaps when the tiles ahead say so.
; 
; When: meta type $22; runs every frame.
; Sees: COP A5 picks one of four states from the flip bits; each waits while off screen (COP AD), then COP 9A / 9B with threshold $20 give the direction of the hero and COP AE reads the tile types at offsets of $10 and $30 pixels ahead: it leaps (animations $21, $22 or $23, $21) only when the tile $10 ahead has a non-zero type and the tile $30 ahead has type zero; otherwise it stands or walks (animations $1A-$1E). The leap animations are $21-$23 vertically and $1F-$20 horizontally.
; Why: 'Leaping at you' (bestiary); its lair releases a cat.
; In: actor script, X = D = own slot.
; Out: loops forever.
; Clobbers: A.

ll_enemy_ball_worm_0FD502 {
    COP [A5] ( &code_0FD673, &code_0FD583, &code_0FD50C, &code_0FD5FA )
}

code_0FD50C {
    COP [97]
    COP [80] ( #1B )
    COP [82]

  loc_0FD513:
    COP [AD] ( #08 )
    COP [9A] ( #$0020, &code_0FD520, &code_0FD52B, &code_0FD520 )
}

code_0FD520 {
    COP [23] ( &code_0FD583 )
    COP [80] ( #1E )
    COP [82]
    BRA loc_0FD513
}

code_0FD52B {
    COP [9B] ( #$0000, &code_0FD535, &code_0FD558, &code_0FD558 )
}

code_0FD535 {
    COP [AE] ( #$0000, #$FFD0, &code_0FD520 )
    COP [AE] ( #$0000, #$FFF0, &code_0FD547 )
    BRA code_0FD520
}

code_0FD547 {
    COP [80] ( #21 )
    COP [82]
    COP [80] ( #23 )
    COP [82]
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FD579
}

code_0FD558 {
    COP [AE] ( #$0000, #$0030, &code_0FD520 )
    COP [AE] ( #$0000, #$0010, &code_0FD56A )
    BRA code_0FD520
}

code_0FD56A {
    COP [80] ( #21 )
    COP [82]
    COP [80] ( #22 )
    COP [82]
    COP [80] ( #21 )
    COP [82]

  loc_0FD579:
    COP [9A] ( #$0000, &code_0FD50C, &code_0FD583, &code_0FD583 )
}

code_0FD583 {
    COP [96]
    COP [80] ( #1B )
    COP [82]

  loc_0FD58A:
    COP [AD] ( #08 )
    COP [9A] ( #$0020, &code_0FD597, &code_0FD5A2, &code_0FD597 )
}

code_0FD597 {
    COP [24] ( &code_0FD50C )
    COP [80] ( #1E )
    COP [82]
    BRA loc_0FD58A
}

code_0FD5A2 {
    COP [9B] ( #$0000, &code_0FD5AC, &code_0FD5CF, &code_0FD5CF )
}

code_0FD5AC {
    COP [AE] ( #$0000, #$FFD0, &code_0FD597 )
    COP [AE] ( #$0000, #$FFF0, &code_0FD5BE )
    BRA code_0FD597
}

code_0FD5BE {
    COP [80] ( #21 )
    COP [82]
    COP [80] ( #23 )
    COP [82]
    COP [80] ( #21 )
    COP [82]
    BRA loc_0FD5F0
}

code_0FD5CF {
    COP [AE] ( #$0000, #$0030, &code_0FD597 )
    COP [AE] ( #$0000, #$0010, &code_0FD5E1 )
    BRA code_0FD597
}

code_0FD5E1 {
    COP [80] ( #21 )
    COP [82]
    COP [80] ( #22 )
    COP [82]
    COP [80] ( #21 )
    COP [82]

  loc_0FD5F0:
    COP [9A] ( #$0000, &code_0FD50C, &code_0FD583, &code_0FD583 )
}

code_0FD5FA {
    COP [97]
    COP [80] ( #1A )
    COP [82]

  loc_0FD601:
    COP [AD] ( #08 )
    COP [9B] ( #$0020, &code_0FD60E, &code_0FD619, &code_0FD60E )
}

code_0FD60E {
    COP [21] ( &code_0FD673 )
    COP [80] ( #1C )
    COP [82]
    BRA loc_0FD601
}

code_0FD619 {
    COP [9A] ( #$0000, &code_0FD623, &code_0FD646, &code_0FD646 )
}

code_0FD623 {
    COP [AE] ( #$FFD0, #$0000, &code_0FD60E )
    COP [AE] ( #$FFF0, #$0000, &code_0FD635 )
    BRA code_0FD60E
}

code_0FD635 {
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1F )
    COP [82]
    BRA loc_0FD669
}

code_0FD646 {
    COP [AE] ( #$0030, #$0000, &code_0FD60E )
    COP [AE] ( #$0010, #$0000, &code_0FD658 )
    BRA code_0FD60E
}

code_0FD658 {
    COP [96]
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1F )
    COP [82]

  loc_0FD669:
    COP [9B] ( #$0000, &code_0FD5FA, &code_0FD673, &code_0FD673 )
}

code_0FD673 {
    COP [97]
    COP [80] ( #1A )
    COP [82]

  loc_0FD67A:
    COP [AD] ( #08 )
    COP [9B] ( #$0020, &code_0FD687, &code_0FD692, &code_0FD687 )
}

code_0FD687 {
    COP [22] ( &code_0FD5FA )
    COP [80] ( #1D )
    COP [82]
    BRA loc_0FD67A
}

code_0FD692 {
    COP [9A] ( #$0000, &code_0FD69C, &code_0FD6BF, &code_0FD6BF )
}

code_0FD69C {
    COP [AE] ( #$FFD0, #$0000, &code_0FD687 )
    COP [AE] ( #$FFF0, #$0000, &code_0FD6AE )
    BRA code_0FD687
}

code_0FD6AE {
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1F )
    COP [82]
    BRA loc_0FD6E2
}

code_0FD6BF {
    COP [AE] ( #$0030, #$0000, &code_0FD687 )
    COP [AE] ( #$0010, #$0000, &code_0FD6D1 )
    BRA code_0FD687
}

code_0FD6D1 {
    COP [96]
    COP [80] ( #1F )
    COP [82]
    COP [80] ( #20 )
    COP [82]
    COP [80] ( #1F )
    COP [82]

  loc_0FD6E2:
    COP [9B] ( #$0000, &code_0FD5FA, &code_0FD673, &code_0FD673 )
}
---------------------------------------------

; The Flail: a pipe obstacle that swings between harmless and harmful.
; 
; When: meta type $23 (1 HP, 0 EXP), placed in the pipes in pairs; runs every frame.
; Sees: COP A5 picks one of four states from the flip bits; each first moves the actor by a fixed offset (COP 9F / A0: X by -$10, +$10, Y by -8 or +$18), then loops: with $16 bit $0100 set (cannot hurt) and priority $20 (behind) it plays animation $25 / $27, with the bit cleared and priority $30 (in front) animation $24 / $26.
; Why: the walkthrough: 'dodging the flails in the pipe dream'.
; In: actor script, X = D = own slot.
; Out: loops forever.
; Clobbers: A.

ll_enemy_flail_0FD6EC {
    COP [A5] ( &code_0FD6F6, &code_0FD6FC, &code_0FD724, &code_0FD72A )
}

code_0FD6F6 {
    COP [9F] ( #$FFF0 )
    BRA loc_0FD711
}

code_0FD6FC {
    COP [9F] ( #$0010 )

  loc_0FD700:
    LDA $0016, X
    ORA #$0100            ; $0100 = not a hit source: harmless while the flail is behind (animation $25)
    STA $0016, X
    COP [A2] ( #20 )
    COP [80] ( #25 )
    COP [82]

  loc_0FD711:
    LDA $0016, X
    AND #$FEFF            ; clears it: the flail hurts again in front (animation $24)
    STA $0016, X
    COP [A2] ( #30 )
    COP [80] ( #24 )
    COP [82]
    BRA loc_0FD700
}

code_0FD724 {
    COP [A0] ( #$FFF8 )
    BRA loc_0FD73F
}

code_0FD72A {
    COP [A0] ( #$0018 )

  loc_0FD72E:
    LDA $0016, X
    ORA #$0100
    STA $0016, X
    COP [A2] ( #20 )
    COP [80] ( #27 )
    COP [82]

  loc_0FD73F:
    LDA $0016, X
    AND #$FEFF
    STA $0016, X
    COP [A2] ( #30 )
    COP [80] ( #26 )
    COP [82]
    BRA loc_0FD72E
}
---------------------------------------------

; The Sweeper Bot: a pipe runner that blows up in four-and-four pieces when it touches the hero.
; 
; When: meta type $24 (24 HP, 140 EXP); runs every frame.
; Sees: COP A5 picks one of four runner states from the flip bits; each state moves in animations $2C-$2F (4 repeats) and turns on the tile tests COP 21-24, with a delay of 0 frames (COP 1B) and a wait while off screen (COP AD, 8 frames) at each turn. In every step it first calls ll_enemy_sweeper_bot_contact_0FD85C (JSR).
; Why: 'Ramming you' (bestiary); the burst on contact is read from the script.
; In: actor script, X = D = own slot.
; Out: loops forever.
; Clobbers: A.

ll_enemy_sweeper_bot_0FD752 {
    COP [A5] ( &code_0FD75C, &code_0FD81C, &code_0FD7DC, &code_0FD79C )
}

code_0FD75C {
    JSR $&ll_enemy_sweeper_bot_contact_0FD85C
    COP [24] ( &code_0FD76B )
    COP [81] ( #2F, #04 )
    COP [83]
    BRA code_0FD75C
}

code_0FD76B {
    COP [1B] ( &code_0FD771, #$0000 )
}

code_0FD771 {
    COP [AD] ( #08 )
    COP [22] ( &code_0FD7CD )
    COP [81] ( #2C, #04 )
    COP [83]

  loc_0FD77E:
    JSR $&ll_enemy_sweeper_bot_contact_0FD85C
    COP [23] ( &code_0FD78D )
    COP [81] ( #2E, #04 )
    COP [83]
    BRA loc_0FD77E
}

code_0FD78D {
    COP [AD] ( #08 )
    COP [22] ( &code_0FD7AB )
    COP [81] ( #2C, #04 )
    COP [83]
    BRA code_0FD75C
}

code_0FD79C {
    JSR $&ll_enemy_sweeper_bot_contact_0FD85C
    COP [23] ( &code_0FD7AB )
    COP [81] ( #2E, #04 )
    COP [83]
    BRA code_0FD79C
}

code_0FD7AB {
    COP [1B] ( &code_0FD7B1, #$0000 )
}

code_0FD7B1 {
    COP [AD] ( #08 )
    COP [21] ( &code_0FD78D )
    COP [81] ( #2D, #04 )
    COP [83]

  loc_0FD7BE:
    JSR $&ll_enemy_sweeper_bot_contact_0FD85C
    COP [24] ( &code_0FD7CD )
    COP [81] ( #2F, #04 )
    COP [83]
    BRA loc_0FD7BE
}

code_0FD7CD {
    COP [AD] ( #08 )
    COP [21] ( &code_0FD76B )
    COP [81] ( #2D, #04 )
    COP [83]
    BRA code_0FD79C
}

code_0FD7DC {
    JSR $&ll_enemy_sweeper_bot_contact_0FD85C
    COP [22] ( &code_0FD7EB )
    COP [81] ( #2C, #04 )
    COP [83]
    BRA code_0FD7DC
}

code_0FD7EB {
    COP [1B] ( &code_0FD7F1, #$0000 )
}

code_0FD7F1 {
    COP [AD] ( #08 )
    COP [24] ( &code_0FD84D )
    COP [81] ( #2F, #04 )
    COP [83]

  loc_0FD7FE:
    JSR $&ll_enemy_sweeper_bot_contact_0FD85C
    COP [21] ( &code_0FD80D )
    COP [81] ( #2D, #04 )
    COP [83]
    BRA loc_0FD7FE
}

code_0FD80D {
    COP [AD] ( #08 )
    COP [24] ( &code_0FD82B )
    COP [81] ( #2F, #04 )
    COP [83]
    BRA code_0FD7DC
}

code_0FD81C {
    JSR $&ll_enemy_sweeper_bot_contact_0FD85C
    COP [21] ( &code_0FD82B )
    COP [81] ( #2D, #04 )
    COP [83]
    BRA code_0FD81C
}

code_0FD82B {
    COP [1B] ( &code_0FD831, #$0000 )
}

code_0FD831 {
    COP [AD] ( #08 )
    COP [23] ( &code_0FD80D )
    COP [81] ( #2E, #04 )
    COP [83]

  loc_0FD83E:
    JSR $&ll_enemy_sweeper_bot_contact_0FD85C
    COP [22] ( &code_0FD84D )
    COP [81] ( #2C, #04 )
    COP [83]
    BRA loc_0FD83E
}

code_0FD84D {
    COP [AD] ( #08 )
    COP [23] ( &code_0FD7EB )
    COP [81] ( #2E, #04 )
    COP [83]
    BRA code_0FD81C
}

---------------------------------------------
; The contact test every Sweeper Bot step calls.
; 
; When: JSR from every state of ll_enemy_sweeper_bot_0FD752.
; Sees: COP 0C with slot 0 (the hero) and margin 2: on contact it jumps (it does not return) to ll_enemy_sweeper_bot_burst_0FD863 with the JSR return address still on the stack; otherwise RTS.
; Why: the bot must burst the moment the hero touches it, from any state.
; In: X = D = the bot.
; Out: RTS, or the burst.
; Clobbers: A.

ll_enemy_sweeper_bot_contact_0FD85C {
    COP [0C] ( #00, #02, &ll_enemy_sweeper_bot_burst_0FD863 )
    RTS 
}

---------------------------------------------
; The first half of the burst: the bot's pose, the sound and four pieces.
; 
; When: jumped to by COP 0C in ll_enemy_sweeper_bot_contact_0FD85C.
; Sees: pops the caller's return address into $30,X (the stack is restored at the end), animation $30, sets $16 bit $0200 (cannot be hit), sound BRK #$56, spawns four pieces with COP B2 at the offsets (0,8), ($10,-8), (0,-$18), (-$10,-8) with the flags $0200 (they hurt but cannot be hit), then waits 1 frame (COP 1B) and continues in ll_enemy_sweeper_bot_burst_wave2_0FD8A9.
; Why: the burst is a short, two-wave explosion around the bot.
; In: X = D = the bot, the JSR return address on the stack.
; Out: continues in the second wave.
; Clobbers: A, Y.

ll_enemy_sweeper_bot_burst_0FD863 {
    PLA                   ; COP 0C jumped here, not called: this pops the JSR return address of the running state; it is pushed back at 1038566
    STA $0030, X
    COP [80] ( #30 )
    COP [82]
    LDA $0016, X
    ORA #$0200            ; $0200 = not a hit target: the bot cannot be hit during the burst
    STA $0016, X
    BRK #$56
    COP [B2] ( @ll_enemy_sweeper_bot_burst_piece_0FD8E8, #$0000, #$0008, #$0200 )
    COP [B2] ( @ll_enemy_sweeper_bot_burst_piece_0FD8FE, #$0010, #$FFF8, #$0200 )
    COP [B2] ( @ll_enemy_sweeper_bot_burst_piece_0FD916, #$0000, #$FFE8, #$0200 )
    COP [B2] ( @ll_enemy_sweeper_bot_burst_piece_0FD92A, #$FFF0, #$FFF8, #$0200 )
    COP [1B] ( &ll_enemy_sweeper_bot_burst_wave2_0FD8A9, #$0001 )
}

---------------------------------------------
; The second half of the burst: four more pieces, then back to the running bot.
; 
; When: after the 1-frame delay of ll_enemy_sweeper_bot_burst_0FD863.
; Sees: four more pieces at ($10,8), ($10,-$18), (-$10,-$18), (-$10,8), animation $31, clears $16 bit $0200 and pushes the saved return address back so that RTS resumes the caller's loop.
; Why: see there.
; In: X = D = the bot.
; Out: RTS into the state that called the contact test (the bot lives on).
; Clobbers: A.

ll_enemy_sweeper_bot_burst_wave2_0FD8A9 {
    COP [B2] ( @ll_enemy_sweeper_bot_burst_piece_0FD8F2, #$0010, #$0008, #$0200 )
    COP [B2] ( @ll_enemy_sweeper_bot_burst_piece_0FD90A, #$0010, #$FFE8, #$0200 )
    COP [B2] ( @ll_enemy_sweeper_bot_burst_piece_0FD920, #$FFF0, #$FFE8, #$0200 )
    COP [B2] ( @ll_enemy_sweeper_bot_burst_piece_0FD934, #$FFF0, #$0008, #$0200 )
    COP [80] ( #31 )
    COP [82]
    LDA $0016, X
    AND #$FDFF
    STA $0016, X
    LDA $0030, X
    PHA                   ; the saved return address: the RTS resumes the state loop that called the contact test
    RTS 
}

---------------------------------------------
; One burst piece (the first of the first wave): drawn in front, plays animation $32 three times, then $37 and ends.
; 
; When: spawned by ll_enemy_sweeper_bot_burst_0FD863 (COP B2, flags $0200).
; Sees: COP A3 (draw in front), animation $32 with 3 repeats, animation $37, COP 86.
; Why: the eight pieces differ only in animation ($32-$36) and flip.
; In: X = D = the piece.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_sweeper_bot_burst_piece_0FD8E8 {
    COP [A3]
    COP [81] ( #32, #03 )
    COP [83]
    BRA loc_0FD93C
}

---------------------------------------------
; A burst piece of the second wave: flip X set, animation $35 three times, then $37 and ends.
; 
; When: spawned by ll_enemy_sweeper_bot_burst_wave2_0FD8A9.
; Sees: as ll_enemy_sweeper_bot_burst_piece_0FD8E8 with COP 96 and animation $35.
; Why: see there.
; In: X = D = the piece.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_sweeper_bot_burst_piece_0FD8F2 {
    COP [A3]
    COP [96]
    COP [81] ( #35, #03 )
    COP [83]
    BRA loc_0FD93C
}

---------------------------------------------
; A burst piece of the first wave: flip X set, animation $34.
; 
; When: spawned by ll_enemy_sweeper_bot_burst_0FD863.
; Sees: as ll_enemy_sweeper_bot_burst_piece_0FD8E8 with COP 96 and animation $34.
; Why: see there.
; In: X = D = the piece.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_sweeper_bot_burst_piece_0FD8FE {
    COP [A3]
    COP [96]
    COP [81] ( #34, #03 )
    COP [83]
    BRA loc_0FD93C
}

---------------------------------------------
; A burst piece of the second wave: flip X set, animation $36.
; 
; When: spawned by ll_enemy_sweeper_bot_burst_wave2_0FD8A9.
; Sees: as ll_enemy_sweeper_bot_burst_piece_0FD8E8 with COP 96 and animation $36.
; Why: see there.
; In: X = D = the piece.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_sweeper_bot_burst_piece_0FD90A {
    COP [A3]
    COP [96]
    COP [81] ( #36, #03 )
    COP [83]
    BRA loc_0FD93C
}

---------------------------------------------
; A burst piece of the first wave: no flip, animation $33.
; 
; When: spawned by ll_enemy_sweeper_bot_burst_0FD863.
; Sees: as ll_enemy_sweeper_bot_burst_piece_0FD8E8 with animation $33 and no flip.
; Why: see there.
; In: X = D = the piece.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_sweeper_bot_burst_piece_0FD916 {
    COP [A3]
    COP [81] ( #33, #03 )
    COP [83]
    BRA loc_0FD93C
}

---------------------------------------------
; A burst piece of the second wave: no flip, animation $36.
; 
; When: spawned by ll_enemy_sweeper_bot_burst_wave2_0FD8A9.
; Sees: as ll_enemy_sweeper_bot_burst_piece_0FD8E8 with animation $36 and no flip.
; Why: see there.
; In: X = D = the piece.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_sweeper_bot_burst_piece_0FD920 {
    COP [A3]
    COP [81] ( #36, #03 )
    COP [83]
    BRA loc_0FD93C
}

---------------------------------------------
; A burst piece of the first wave: no flip, animation $34.
; 
; When: spawned by ll_enemy_sweeper_bot_burst_0FD863.
; Sees: as ll_enemy_sweeper_bot_burst_piece_0FD8E8 with animation $34 and no flip.
; Why: see there.
; In: X = D = the piece.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_sweeper_bot_burst_piece_0FD92A {
    COP [A3]
    COP [81] ( #34, #03 )
    COP [83]
    BRA loc_0FD93C
}

---------------------------------------------
; A burst piece of the second wave: no flip, animation $35; the last piece of the file and the shared end of all eight (loc_0FD93C: animation $37, kill).
; 
; When: spawned by ll_enemy_sweeper_bot_burst_wave2_0FD8A9.
; Sees: as ll_enemy_sweeper_bot_burst_piece_0FD8E8 with animation $35 and no flip; the other seven pieces branch here for the final animation $37 and COP 86.
; Why: see there.
; In: X = D = the piece.
; Out: RTL after the kill.
; Clobbers: A.

ll_enemy_sweeper_bot_burst_piece_0FD934 {
    COP [A3]
    COP [81] ( #35, #03 )
    COP [83]

  loc_0FD93C:
    COP [80] ( #37 )
    COP [82]
    COP [86]
    RTL 
}