; The enemies of Leo's Paintings (file offsets 1027370-1028341, bank 1F): the Yellow Knight ($26) with three spear actors, the Metal Crawler ($27), the Purple Bird ($28), the Green Torch ($29) with its fireball, the Monster Blocks ($2E) and the spikes ($2F).
; 
; === ROSTER ===
; Stats from MetaGrassValley and the walkthrough bestiary: Yellow Knight 9 HP / 5 EXP ('throwing spears'), Metal Crawler 24 HP / 250 EXP ('running around', metal), Purple Bird 4 HP / 3 EXP, Green Torch 9 HP / 4 EXP ('fireballs'), Monster Blocks 4 HP ('jumping at you'), spikes 1 HP / 0 EXP. The lair records give the identities: record $22 (type $28, the Purple Birds' lair that frees a tulip) and the walkthrough's 'Purple Birds' lair to release a tulip'. The Metal Crawlers need the Zantetsu Sword (walkthrough). The spikes are placed four times in A03S02 (the walkthrough: 'stone, non-moving paths (unless you some spike fetish)').
; 
; === NOTES ===
; - DISCREPANCY: MetaGrassValley type $2E gives the Monster Blocks 3 EXP, the walkthrough bestiary 2 EXP (OQ-I034-11). The $2E identity itself comes from the jump-at-you behaviour.
; - Type $2F as 'spikes' rests on the placements and the walkthrough sentence above, not on a name in the ROM (OQ-I034-10).
---------------------------------------------

?BANK 1F

---------------------------------------------

; The Yellow Knight: walks and throws spears when lined up with the hero.
; 
; When: meta type $26; spawned by Leo's Paintings lairs.
; Sees: a knight that walks towards the hero ($0E / $14 / $0D / $13 / $0C / $12 animations) and, when lined up within $10 pixels, throws a spear in that direction (animations $16 / $15 / $17, then $10 / $0F / $11).
; Why: COP 9A / 9B / 9C choose the direction.
; In: actor script, X = own slot.
; Out: spears gv_enemy_knight_spear_0FAEAF / _0FAEBA / _0FAE8F.
; Clobbers: A.

gv_enemy_yellow_knight_0FAD2A {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAD38
    COP [1B] ( &gv_enemy_yellow_knight_0FAD2A, #$0010 )

  loc_0FAD38:
    COP [9A] ( #$0010, &code_0FAD42, &code_0FAE1B, &code_0FAD42 )
}

code_0FAD42 {
    COP [9B] ( #$0010, &code_0FAD4C, &code_0FAE53, &code_0FAD4C )
}

code_0FAD4C {
    COP [9C] ( &code_0FAD52, &code_0FADB1 )
}

code_0FAD52 {
    COP [9A] ( #$0010, &code_0FAD5C, &code_0FAE07, &code_0FAD7B )
}

code_0FAD5C {
    COP [23] ( &code_0FADA1 )
    COP [80] ( #14 )
    COP [82]
    COP [9A] ( #$0010, &code_0FAD6F, &code_0FAE1B, &code_0FAD6F )
}

code_0FAD6F {
    COP [23] ( &code_0FADA1 )
    COP [80] ( #0E )
    COP [82]
    BRL code_0FAE07
}

code_0FAD7B {
    COP [24] ( &code_0FADA1 )
    COP [96]
    COP [80] ( #14 )
    COP [82]
    COP [97]
    COP [9A] ( #$0010, &code_0FAD92, &code_0FAE1B, &code_0FAD92 )
}

code_0FAD92 {
    COP [24] ( &code_0FADA1 )
    COP [96]
    COP [80] ( #0E )
    COP [82]
    COP [97]
    BRA code_0FAE07
}

code_0FADA1 {
    COP [1B] ( &code_0FADA7, #$0000 )
}

code_0FADA7 {
    COP [9B] ( #$0000, &code_0FADBB, &code_0FADD9, &code_0FADD9 )
}

code_0FADB1 {
    COP [9B] ( #$0010, &code_0FADBB, &code_0FAE07, &code_0FADD9 )
}

code_0FADBB {
    COP [21] ( &code_0FADF7 )
    COP [80] ( #13 )
    COP [82]
    COP [9B] ( #$0010, &code_0FADCE, &code_0FAE53, &code_0FADCE )
}

code_0FADCE {
    COP [21] ( &code_0FADF7 )
    COP [80] ( #0D )
    COP [82]
    BRA code_0FAE07
}

code_0FADD9 {
    COP [22] ( &code_0FADF7 )
    COP [80] ( #12 )
    COP [82]
    COP [9B] ( #$0010, &code_0FADEC, &code_0FAE53, &code_0FADEC )
}

code_0FADEC {
    COP [22] ( &code_0FADF7 )
    COP [80] ( #0C )
    COP [82]
    BRA code_0FAE07
}

code_0FADF7 {
    COP [1B] ( &code_0FADFD, #$0000 )
}

code_0FADFD {
    COP [9A] ( #$0000, &code_0FAD5C, &code_0FAD7B, &code_0FAD7B )
}

code_0FAE07 {
    COP [9A] ( #$0010, &code_0FAE11, &code_0FAE1B, &code_0FAE11 )
}

code_0FAE11 {
    COP [9B] ( #$0010, &gv_enemy_yellow_knight_0FAD2A, &code_0FAE53, &gv_enemy_yellow_knight_0FAD2A )
}

code_0FAE1B {
    COP [9B] ( #$0000, &code_0FAE25, &code_0FAE3C, &code_0FAE3C )
}

code_0FAE25 {
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #16 )
    COP [82]
    COP [85] ( @gv_enemy_knight_spear_0FAEAF )
    COP [80] ( #10 )
    COP [82]
    BRL gv_enemy_yellow_knight_0FAD2A
}

code_0FAE3C {
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #15 )
    COP [82]
    COP [85] ( @gv_enemy_knight_spear_0FAEBA )
    COP [80] ( #0F )
    COP [82]
    BRL gv_enemy_yellow_knight_0FAD2A
}

code_0FAE53 {
    COP [9A] ( #$0000, &code_0FAE5D, &code_0FAE74, &code_0FAE74 )
}

code_0FAE5D {
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #17 )
    COP [82]
    COP [85] ( @gv_enemy_knight_spear_0FAE8F )
    COP [80] ( #11 )
    COP [82]
    BRL gv_enemy_yellow_knight_0FAD2A
}

code_0FAE74 {
    COP [96]
    COP [80] ( #0B )
    COP [82]
    COP [80] ( #17 )
    COP [82]
    COP [85] ( @gv_enemy_knight_spear_0FAE8F )
    COP [80] ( #11 )
    COP [82]
    COP [97]
    BRL gv_enemy_yellow_knight_0FAD2A
}

---------------------------------------------
; Spear thrown by the Yellow Knight (the flipped sideways throw).
; 
; When: spawned by gv_enemy_yellow_knight_0FAD2A.
; Sees: a spear that flies until it leaves the screen.
; Why: flags $0200, priority $30, in front; BRK $5B; offset (-1, -8).
; In: actor script, X = own slot.
; Out: loops animation $26 and ends with COP 86 when COP 1C finds $16 bit $8000 (off screen).
; Clobbers: A.

gv_enemy_knight_spear_0FAE8F {
    COP [A1] ( #$FFFF, #$FFF8 )
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [A2] ( #30 )
    BRK #$5B

  loc_0FAEA2:
    COP [80] ( #26 )
    COP [82]
    COP [1C] ( #$8000, &code_0FAEE2 )
    BRA loc_0FAEA2
}

---------------------------------------------
; Spear thrown by the Yellow Knight (offset (+4, -15), animation $25).
; 
; When: spawned by gv_enemy_yellow_knight_0FAD2A.
; Sees: as gv_enemy_knight_spear_0FAE8F.
; Why: the entry only sets the offset and animation, then joins the shared tail at loc_0FAEC3.
; In: actor script, X = own slot.
; Out: COP 91 and a loop until the actor is off screen, then COP 86.
; Clobbers: A.

gv_enemy_knight_spear_0FAEAF {
    COP [A1] ( #$0004, #$FFF1 )
    LDA #$0025
    BRA loc_0FAEC3
}

---------------------------------------------
; Spear thrown by the Yellow Knight (offset (-4, -8), animation $24).
; 
; When: spawned by gv_enemy_yellow_knight_0FAD2A.
; Sees: as gv_enemy_knight_spear_0FAE8F.
; Why: the entry only sets the offset and animation, then joins the shared tail at loc_0FAEC3.
; In: actor script, X = own slot.
; Out: as gv_enemy_knight_spear_0FAEAF.
; Clobbers: A.

gv_enemy_knight_spear_0FAEBA {
    COP [A1] ( #$FFFC, #$FFF8 )
    LDA #$0024

  loc_0FAEC3:
    STA $001E, X
    STZ $0020, X
    LDA #$0200
    STA $0016, X
    COP [A3]
    COP [A2] ( #30 )
    BRK #$5B
    COP [91]

  loc_0FAED8:
    COP [82]
    COP [1C] ( #$8000, &code_0FAEE2 )
    BRA loc_0FAED8
}

code_0FAEE2 {
    COP [86]
    RTL 
}
---------------------------------------------

; The Metal Crawler: runs along the walls and is immune until the Zantetsu Sword.
; 
; When: meta type $27; spawned by the Metal Crawler lairs of Leo's Paintings (the walkthrough: 'the monster lair you pass is for the Metal Crawlers').
; Sees: a metal creature that crawls back and forth, turning at walls (24 HP, 250 EXP).
; Why: COP A5 branches on the flip bits and COP 21-24 test the tiles around it, so it turns at obstacles; the animations are $1F-$21.
; In: actor script, X = own slot; it ORs $0400 into its $1A flags first (the bit is undocumented, the walkthrough calls the monster 'Metal').
; Out: loops for ever.
; Clobbers: A.

gv_enemy_metal_crawler_0FAEE5 {
    LDA $001A, X
    ORA #$0400
    STA $001A, X
    COP [A5] ( &code_0FAF32, &code_0FAF20, &code_0FAEF8, &code_0FAF0E )
}

code_0FAEF8 {
    COP [21] ( &code_0FAEFE )
    BRA loc_0FAF18
}

code_0FAEFE {
    COP [24] ( &code_0FAF32 )

  loc_0FAF02:
    COP [96]
    COP [81] ( #21, #02 )
    COP [83]
    COP [97]
    BRA code_0FAEF8
}

code_0FAF0E {
    COP [23] ( &code_0FAF14 )
    BRA loc_0FAF2A
}

code_0FAF14 {
    COP [21] ( &code_0FAEF8 )

  loc_0FAF18:
    COP [81] ( #20, #02 )
    COP [83]
    BRA code_0FAF0E
}

code_0FAF20 {
    COP [22] ( &code_0FAF26 )
    BRA loc_0FAF3C
}

code_0FAF26 {
    COP [23] ( &code_0FAF0E )

  loc_0FAF2A:
    COP [81] ( #21, #02 )
    COP [83]
    BRA code_0FAF20
}

code_0FAF32 {
    COP [24] ( &code_0FAF38 )
    BRA loc_0FAF02
}

code_0FAF38 {
    COP [22] ( &code_0FAF20 )

  loc_0FAF3C:
    COP [81] ( #1F, #02 )
    COP [83]
    BRA code_0FAF32
}
---------------------------------------------

; The Purple Bird: flutters towards the hero.
; 
; When: meta type $28; spawned by the Purple Birds' lair (record $22, which frees a tulip in the village).
; Sees: a bird that flaps in place and darts towards the hero (4 HP, 3 EXP).
; Why: COP 9C picks the axis, COP 9A / 9B the side; animations $18-$1D, each played twice with COP 81 and followed by the rest pose.
; In: actor script, X = own slot; priority $30 and drawn in front (COP A2 / A3).
; Out: loops for ever; waits 16 frames while off screen.
; Clobbers: A.

gv_enemy_purple_bird_0FAF44 {
    COP [A2] ( #30 )
    COP [A3]

  code_0FAF49:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAF57
    COP [1B] ( &code_0FAF49, #$0010 )

  loc_0FAF57:
    COP [9C] ( &code_0FAF5D, &code_0FAF85 )
}

code_0FAF5D {
    COP [9A] ( #$0010, &code_0FAF67, &code_0FAF74, &code_0FAF74 )
}

code_0FAF67 {
    COP [81] ( #1C, #02 )
    COP [83]
    COP [80] ( #1D )
    COP [82]
    BRA loc_0FAF57
}

code_0FAF74 {
    COP [96]
    COP [81] ( #1C, #02 )
    COP [83]
    COP [80] ( #1D )
    COP [82]
    COP [97]
    BRA loc_0FAF57
}

code_0FAF85 {
    COP [9B] ( #$0010, &code_0FAF8F, &code_0FAF9C, &code_0FAF9C )
}

code_0FAF8F {
    COP [81] ( #1A, #02 )
    COP [83]
    COP [80] ( #1B )
    COP [82]
    BRA loc_0FAF57
}

code_0FAF9C {
    COP [96]
    COP [81] ( #18, #02 )
    COP [83]
    COP [80] ( #19 )
    COP [82]
    COP [97]
    BRA loc_0FAF57
}
---------------------------------------------

; The Green Torch: turns to the hero and shoots fireballs.
; 
; When: meta type $29; spawned by Leo's Paintings lairs ('a ton of Green Torches').
; Sees: a torch that faces the hero and fires a fireball in his direction (9 HP, 4 EXP).
; Why: COP 9A / 9B choose up, down, left or right; COP 84 spawns gv_enemy_torch_fireball_0FB02F and the animation $27 / $28 / $29 of the child tells the direction.
; In: actor script, X = own slot.
; Out: after the shot it plays animation $22 and loops.
; Clobbers: A, Y (the child).

gv_enemy_green_torch_0FAFAD {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAFBB
    COP [1B] ( &gv_enemy_green_torch_0FAFAD, #$0008 )

  loc_0FAFBB:
    COP [97]
    COP [80] ( #22 )
    COP [82]
    COP [9B] ( #$0010, &code_0FAFCC, &code_0FAFD6, &code_0FAFCC )
}

code_0FAFCC {
    COP [9A] ( #$0010, &gv_enemy_green_torch_0FAFAD, &code_0FAFF6, &gv_enemy_green_torch_0FAFAD )
}

code_0FAFD6 {
    COP [9A] ( #$0000, &code_0FAFE0, &code_0FAFEA, &code_0FAFEA )
}

code_0FAFE0 {
    COP [80] ( #23 )
    COP [82]
    LDA #$0029
    BRA loc_0FB014
}

code_0FAFEA {
    COP [80] ( #23 )
    COP [82]
    COP [96]
    LDA #$0029
    BRA loc_0FB014
}

code_0FAFF6 {
    COP [9B] ( #$0000, &code_0FB000, &code_0FB00A, &code_0FB00A )
}

code_0FB000 {
    COP [80] ( #23 )
    COP [82]
    LDA #$0028
    BRA loc_0FB014
}

code_0FB00A {
    COP [80] ( #23 )
    COP [82]
    LDA #$0027
    BRA loc_0FB014

  loc_0FB014:
    PHA 
    COP [84] ( @gv_enemy_torch_fireball_0FB02F )
    PLA 
    STA $001E, Y
    LDA #$0000
    STA $0020, Y
    COP [97]
    COP [81] ( #22, #04 )
    COP [83]
    BRL gv_enemy_green_torch_0FAFAD
}

---------------------------------------------
; The fireball of the Green Torch.
; 
; When: spawned by gv_enemy_green_torch_0FAFAD.
; Sees: a fireball (BRK $64) that flies in the direction of its animation.
; Why: flags $0200, priority $30, in front; moved up by 4 first (COP A0).
; In: actor script, X = own slot; the parent has written animation $27-$29 into $1E.
; Out: COP 91, then animation steps until off screen and COP 86.
; Clobbers: A.

gv_enemy_torch_fireball_0FB02F {
    LDA #$0200
    STA $0016, X
    COP [A2] ( #30 )
    COP [A3]
    COP [A0] ( #$FFFC )
    BRK #$64
    COP [91]

  loc_0FB042:
    COP [82]
    COP [1C] ( #$8000, &code_0FB04C )
    BRA loc_0FB042
}

code_0FB04C {
    COP [86]
    RTL 
}
---------------------------------------------

; The Monster Blocks: sit still and then jump at the hero.
; 
; When: meta type $2E; spawned by Leo's Paintings lairs (walkthrough: 'Monster Blocks ... jump around and are easily beaten').
; Sees: a block that waits until the hero is inside its box widened by 5, then plays animation $02, $03 (two repeats) and $01 (the jump) and follows him with $04-$06 while he stays near.
; Why: COP 21-24 stop it at walls; COP 9A / 9B pick the direction.
; In: actor script, X = own slot.
; Out: loops for ever; waits 16 frames while off screen.
; Clobbers: A.

gv_enemy_monster_blocks_0FB04F {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB05D

  loc_0FB057:
    COP [1B] ( &gv_enemy_monster_blocks_0FB04F, #$0010 )

  loc_0FB05D:
    COP [0C] ( #00, #05, &code_0FB065 )
    BRA loc_0FB057
}

code_0FB065 {
    COP [80] ( #02 )
    COP [82]
    COP [81] ( #03, #02 )
    COP [83]
    COP [80] ( #01 )
    COP [82]

  loc_0FB075:
    COP [0C] ( #00, #05, &code_0FB087 )
    COP [80] ( #02 )
    COP [82]
    COP [80] ( #00 )
    COP [82]
    BRA loc_0FB057
}

code_0FB087 {
    COP [9A] ( #$0010, &code_0FB091, &code_0FB0AB, &code_0FB09E )
}

code_0FB091 {
    COP [23] ( &code_0FB0CF )
    COP [97]
    COP [80] ( #06 )
    COP [82]
    BRA code_0FB0AB
}

code_0FB09E {
    COP [24] ( &code_0FB0CF )
    COP [96]
    COP [80] ( #06 )
    COP [82]
    BRA code_0FB0AB
}

code_0FB0AB {
    COP [9B] ( #$0010, &code_0FB0B5, &code_0FB0CF, &code_0FB0C2 )
}

code_0FB0B5 {
    COP [21] ( &code_0FB0CF )
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FB0CF
}

code_0FB0C2 {
    COP [22] ( &code_0FB0CF )
    COP [97]
    COP [80] ( #04 )
    COP [82]
    BRA code_0FB0CF
}

code_0FB0CF {
    COP [80] ( #01 )
    COP [82]
    BRA loc_0FB075
}
---------------------------------------------

; The spikes of A03S02: a harmless-looking object that hurts.
; 
; When: meta type $2F; placed four times in A03S02 (one with placement flags $C1).
; Sees: static spikes, drawn behind (COP A4); they play animation $2C or $2D for 255 repeats depending on the flip state.
; Why: they are an actor so the engine can handle the contact damage like a monster's (1 HP, 0 EXP in MetaGrassValley).
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

gv_enemy_spikes_0FB0D6 {
    COP [A2] ( #00 )
    COP [A4]
    COP [A5] ( &code_0FB0E5, &code_0FB0ED, &code_0FB0ED, &code_0FB0ED )
}

code_0FB0E5 {
    COP [81] ( #2C, #FF )
    COP [83]
    BRA code_0FB0E5
}

code_0FB0ED {
    COP [81] ( #2D, #FF )
    COP [83]
    BRA code_0FB0ED
}