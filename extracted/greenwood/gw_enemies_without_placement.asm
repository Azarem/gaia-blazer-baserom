; Two monster scripts of world 1 that no scene uses (file offsets 1029760-1029781 and 1029880-1030296, SNES $1F:B680-$B694 and $1F:B6F8-$B897, bank 1F; they lie inside gw_lostside_marsh_enemies). MetaGreenwood has entries for meta types $34 and $36, but neither type appears in a placement row of areas 4 and 5 or in a lair record (the lair records of the marsh and the shrines use $2D, $2E, $2F, $33, $35, $37, $38, $48, $49, $3D). They are left-over monsters of the unused set (OQ-I035-11).
; $34 an unused still monster 1/2/5 HP, EXP 0: sits in animation $12 and does nothing. $36 an unused turret 1/2/5 HP, EXP 0: hides, and when the hero is within $40 pixels in front it appears (animation $13), spawns a shot child and hides again for 60 frames.
---------------------------------------------

?BANK 1F

---------------------------------------------

; An unused monster that only stands still.
; 
; When: meta type $34 (1/2/5 HP, 0 EXP); no placement row and no lair record (OQ-I035-11).
; Sees: nothing but animation $12.
; In: actor script, X = own slot.
; Out: stays in the animation.
; Clobbers: A.

gw_unused_enemy_still_0FB680 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB68E
    COP [1B] ( &gw_unused_enemy_still_0FB680, #$0010 )

  loc_0FB68E:
    COP [80] ( #12 )
    COP [82]
    BRA gw_unused_enemy_still_0FB680
}
---------------------------------------------

; An unused turret monster that pops up and shoots.
; 
; When: meta type $36 (1/2/5 HP, 0 EXP); no placement row and no lair record (OQ-I035-11).
; Sees: COP A5 picks one of four facings; when the hero is within $40 pixels (COP 9A / 9B) it appears (animation $13), spawns a shot child (animations $14-$17 with offsets of 4 or 8 pixels per facing) and hides for 60 frames.
; In: actor script, X = own slot.
; Out: loops forever.
; Clobbers: A, Y.

gw_unused_enemy_turret_0FB6F8 {
    COP [A5] ( &code_0FB702, &code_0FB767, &code_0FB7CC, &code_0FB833 )
}

code_0FB702 {
    COP [A0] ( #$0004 )

  code_0FB706:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB714

  code_0FB70E:
    COP [1B] ( &code_0FB706, #$0004 )

  loc_0FB714:
    COP [9B] ( #$0000, &code_0FB70E, &code_0FB71E, &code_0FB71E )
}

code_0FB71E {
    COP [9A] ( #$0040, &code_0FB70E, &code_0FB728, &code_0FB70E )
}

code_0FB728 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #13 )
    COP [82]
    COP [85] ( @code_0FB74A )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [1B] ( &code_0FB706, #$003C )
}

code_0FB74A {
    LDA #$0200
    STA $0016, X
    COP [A0] ( #$0008 )
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #14 )
    COP [82]
    COP [81] ( #17, #20 )
    COP [83]
    COP [86]
    RTL 
}

code_0FB767 {
    COP [9F] ( #$FFFC )

  code_0FB76B:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB779

  code_0FB773:
    COP [1B] ( &code_0FB76B, #$0004 )

  loc_0FB779:
    COP [9A] ( #$0000, &code_0FB783, &code_0FB783, &code_0FB773 )
}

code_0FB783 {
    COP [9B] ( #$0040, &code_0FB773, &code_0FB78D, &code_0FB773 )
}

code_0FB78D {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #13 )
    COP [82]
    COP [85] ( @code_0FB7AF )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [1B] ( &code_0FB76B, #$003C )
}

code_0FB7AF {
    LDA #$0200
    STA $0016, X
    COP [9F] ( #$FFF8 )
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #16 )
    COP [82]
    COP [81] ( #19, #20 )
    COP [83]
    COP [86]
    RTL 
}

code_0FB7CC {
    COP [9F] ( #$0004 )
    COP [96]

  code_0FB7D2:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB7E0

  code_0FB7DA:
    COP [1B] ( &code_0FB7D2, #$0004 )

  loc_0FB7E0:
    COP [9A] ( #$0000, &code_0FB7DA, &code_0FB7EA, &code_0FB7EA )
}

code_0FB7EA {
    COP [9B] ( #$0040, &code_0FB7DA, &code_0FB7F4, &code_0FB7DA )
}

code_0FB7F4 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #13 )
    COP [82]
    COP [85] ( @code_0FB816 )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [1B] ( &code_0FB7D2, #$003C )
}

code_0FB816 {
    LDA #$0200
    STA $0016, X
    COP [9F] ( #$0008 )
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #16 )
    COP [82]
    COP [81] ( #19, #20 )
    COP [83]
    COP [86]
    RTL 
}

code_0FB833 {
    COP [A0] ( #$FFFC )

  code_0FB837:
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FB845

  code_0FB83F:
    COP [1B] ( &code_0FB837, #$0004 )

  loc_0FB845:
    COP [9B] ( #$0000, &code_0FB84F, &code_0FB84F, &code_0FB83F )
}

code_0FB84F {
    COP [9A] ( #$0040, &code_0FB83F, &code_0FB859, &code_0FB83F )
}

code_0FB859 {
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #13 )
    COP [82]
    COP [85] ( @code_0FB87B )
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [1B] ( &code_0FB837, #$003C )
}

code_0FB87B {
    LDA #$0200
    STA $0016, X
    COP [A0] ( #$FFF0 )
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #15 )
    COP [82]
    COP [81] ( #18, #20 )
    COP [83]
    COP [86]
    RTL 
}