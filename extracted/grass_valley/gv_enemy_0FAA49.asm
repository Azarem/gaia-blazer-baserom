; The Green Humanoid (meta type $20 of world 0, 3 HP and 1 EXP in MetaGrassValley; the walkthrough bestiary lists 3 HP, 1 EXP, 'running into you') (file offset 1026633-1026703, bank 1F).
; 
; === ROLE ===
; A walker without an attack: it turns towards the hero (sideways with animation $05 and a flip bit, up $04, down $03) and runs into him. It is spawned by lair records whose type byte (+$15) is $20, for example the Underground Castle lairs of the walkthrough ('the Green Humanoids spawned by the monster lair').
; 
; === NOTES ===
; - Type $20 has no placement row in any Grass Valley scene; it only comes from lair records.
---------------------------------------------

?BANK 1F

---------------------------------------------

; The Green Humanoid.
; 
; When: meta type $20; spawned by a lair (RunLairRespawn / SpawnAll), runs every frame.
; Sees: a green humanoid that follows the hero; waits 8 frames while off screen.
; Why: the simplest chaser of the world: COP 9A compares the X distance to the hero with $10, COP 9B the Y distance.
; In: actor script, X = own slot.
; Out: first a sideways step (animation $05, flip cleared or set by COP 97 / 96) when the hero is left or right, then a vertical one ($04 above, $03 below), then back to the start.
; Clobbers: A.

gv_enemy_green_humanoid_0FAA49 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FAA57

  code_0FAA51:
    COP [1B] ( &gv_enemy_green_humanoid_0FAA49, #$0008 )

  loc_0FAA57:
    COP [9A] ( #$0010, &code_0FAA61, &code_0FAA73, &code_0FAA6A )
}

code_0FAA61 {
    COP [97]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FAA73
}

code_0FAA6A {
    COP [96]
    COP [80] ( #05 )
    COP [82]
    BRA code_0FAA73
}

code_0FAA73 {
    COP [9B] ( #$0010, &code_0FAA7D, &code_0FAA51, &code_0FAA86 )
}

code_0FAA7D {
    COP [97]
    COP [80] ( #04 )
    COP [82]
    BRA gv_enemy_green_humanoid_0FAA49
}

code_0FAA86 {
    COP [97]
    COP [80] ( #03 )
    COP [82]
    BRA gv_enemy_green_humanoid_0FAA49
}