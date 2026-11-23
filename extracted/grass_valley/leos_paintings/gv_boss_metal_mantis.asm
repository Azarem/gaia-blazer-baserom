; The Metal Mantis, the boss of Leo's Paintings (file offsets 12717-13254, bank 00): the mantis itself (meta type $1F, 50 HP, 50 EXP in MetaGrassValley; the walkthrough: 'Maximum HP: 50 HP, EXP. Earned: 50 EXP.') and its projectiles.
; 
; === ROLE ===
; The boss lair is record $09 (RunLairFormation, one monster of type $1F; home location 04, the Chief's room). The script starts the fight (boss_fight_active + 1, boss_actor = X, exit_list_ofs = 0) and spawns engine_003005.RunBossMapPatch with patch id 0 (it blocks the pad while the map changes). Defeating it sets switch $09, which frees the village Chief (gv_village_actors_019475) and changes the village dialogue.
; 
; === ATTACKS (static reading, OQ-I034-12) ===
; The walkthrough: 'Three fireballs fired simultaneously usually when you're far off', 'Arm attack if you're close', and the boss 'turns silvery' (immune) when the hero is on the far side of the field. In the script the hero's Y is tested against $70: at $70 or more the mantis is in its fire mode: three fireballs at once (gv_boss_mantis_fireball_003348 / _003359 / _003367, each spawned with COP B2 at offset (+8, -$18)) or two shots from its sides (gv_boss_mantis_shot_00337F, _003394); below $70 it uses the arm attack (gv_boss_mantis_arm_strike_0033B9 with gv_boss_mantis_arm_0033A9 on the left or _0033B1 on the right, while $16 bit $0002 is set). The silver phase is not visible in the script as a separate state (OQ-I034-12).
; 
; === NOTES ===
; - The boss is placed in the paintings scene A03S06 through its lair, not through a placement row.
---------------------------------------------

?BANK 00

?INCLUDE 'engine_003005'

!player_y                       0376
!boss_actor                     039A
!exit_list_ofs                  03B2
!boss_fight_active              0458

---------------------------------------------

; The Metal Mantis.
; 
; When: meta type $1F; spawned by lair record $09 in A03S06 (the Metal Mantis room, location $0C).
; Sees: 'a boss that only the sword hurts' (the walkthrough); its pose depends on where the hero stands.
; Why: the script sets up the fight and then loops forever; COP 9A / 9B and the hero's Y choose between firing and arm attacks.
; In: actor script, X = the boss slot.
; Out: exit_list_ofs = 0, boss_fight_active += 1, boss_actor = X; RunBossMapPatch is spawned with patch id 0 in its $30; then the behaviour loops; COP 9F shifts the actor's X by +$10 before the distance tests and by -$10 in each branch, so the tests are taken from a point $10 right of its X.
; Clobbers: A, Y.

gv_boss_metal_mantis_0031AD {
    STZ $exit_list_ofs
    INC $boss_fight_active
    STX $boss_actor
    COP [85] ( @engine_003005.RunBossMapPatch )
    LDA #$0000
    STA $0030, Y

  loc_0031C1:
    COP [80] ( #00 )
    COP [82]

  loc_0031C6:
    LDA $player_y
    CMP #$0070            ; hero Y >= $70: fire from the mantis; below $70 the arm attack at loc_0032B2
    BCS loc_0031D1
    BRL loc_0032B2

  loc_0031D1:
    COP [9F] ( #$0010 )
    COP [9A] ( #$0010, &code_003210, &code_0031DF, &code_003210 )
}

code_0031DF {
    COP [9F] ( #$FFF0 )
    COP [80] ( #0E )
    COP [82]
    COP [B2] ( @gv_boss_mantis_fireball_003348, #$0008, #$FFE8, #$0200 )
    COP [B2] ( @gv_boss_mantis_fireball_003359, #$0008, #$FFE8, #$0200 )
    COP [B2] ( @gv_boss_mantis_fireball_003367, #$0008, #$FFE8, #$0200 )
    COP [80] ( #16 )
    COP [82]
    BRA loc_0031C1
}

code_003210 {
    COP [9A] ( #$0050, &code_00321A, &code_003290, &code_00321A )
}

code_00321A {
    COP [9A] ( #$0070, &code_003290, &code_003224, &code_003290 )
}

code_003224 {
    COP [9A] ( #$0000, &code_00322E, &code_00325F, &code_00325F )
}

code_00322E {
    COP [9F] ( #$FFF0 )
    COP [80] ( #0D )
    COP [82]
    COP [B2] ( @gv_boss_mantis_shot_00337F, #$FFFC, #$FFE6, #$0200 )
    COP [80] ( #17 )
    COP [82]
    COP [80] ( #0D )
    COP [82]
    COP [B2] ( @gv_boss_mantis_shot_00337F, #$FFFC, #$FFE6, #$0200 )
    COP [80] ( #17 )
    COP [82]
    BRL loc_0031C6
}

code_00325F {
    COP [9F] ( #$FFF0 )
    COP [80] ( #0F )
    COP [82]
    COP [B2] ( @gv_boss_mantis_shot_003394, #$0014, #$FFE6, #$0200 )
    COP [80] ( #18 )
    COP [82]
    COP [80] ( #0F )
    COP [82]
    COP [B2] ( @gv_boss_mantis_shot_003394, #$0014, #$FFE6, #$0200 )
    COP [80] ( #18 )
    COP [82]
    BRL loc_0031C6
}

code_003290 {
    COP [9A] ( #$0000, &code_00329A, &code_0032A6, &code_0032A6 )
}

code_00329A {
    COP [9F] ( #$FFF0 )
    COP [80] ( #07 )
    COP [82]
    BRL loc_0031C6
}

code_0032A6 {
    COP [9F] ( #$FFF0 )
    COP [80] ( #05 )
    COP [82]
    BRL loc_0031C6

  loc_0032B2:
    COP [9F] ( #$0010 )
    COP [9A] ( #$0040, &code_003330, &code_0032C0, &code_00333C )
}

code_0032C0 {
    COP [9A] ( #$0000, &code_0032CA, &code_0032FD, &code_0032FD )
}

code_0032CA {
    COP [9F] ( #$FFF0 )
    LDA $0016, X
    ORA #$0002
    STA $0016, X
    COP [85] ( @gv_boss_mantis_arm_strike_0033B9 )
    COP [80] ( #09 )
    COP [82]
    COP [B2] ( @gv_boss_mantis_arm_0033A9, #$FFD8, #$FFE8, #$0200 )
    COP [80] ( #0A )
    COP [82]
    LDA $0016, X
    AND #$FFFD
    STA $0016, X
    BRL loc_0031C6
}

code_0032FD {
    COP [9F] ( #$FFF0 )
    LDA $0016, X
    ORA #$0002
    STA $0016, X
    COP [85] ( @gv_boss_mantis_arm_strike_0033B9 )
    COP [80] ( #0B )
    COP [82]
    COP [B2] ( @gv_boss_mantis_arm_0033B1, #$0028, #$FFE8, #$0200 )
    COP [80] ( #0C )
    COP [82]
    LDA $0016, X
    AND #$FFFD
    STA $0016, X
    BRL loc_0031C6
}

code_003330 {
    COP [9F] ( #$FFF0 )
    COP [80] ( #08 )
    COP [82]
    BRL loc_0031C6
}

code_00333C {
    COP [9F] ( #$FFF0 )
    COP [80] ( #06 )
    COP [82]
    BRL loc_0031C6
}

---------------------------------------------
; First of the three simultaneous fireballs of the Metal Mantis.
; 
; When: spawned by gv_boss_metal_mantis_0031AD (COP B2, flags $0200).
; Sees: a fireball that flies away.
; Why: the three share the offset (+8, -$18); this one plays animation $10 and then $1B.
; In: actor script, X = own slot; priority $30, in front.
; Out: animation $13 repeated $0C times, then COP 86.
; Clobbers: A.

gv_boss_mantis_fireball_003348 {
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #1B )
    COP [82]
    BRA loc_003376
}

---------------------------------------------
; Second of the three simultaneous fireballs.
; 
; When: spawned by gv_boss_metal_mantis_0031AD.
; Sees: a fireball with the sound BRK $61.
; Why: as gv_boss_mantis_fireball_003348; this one has no extra animation after $10.
; In: actor script, X = own slot.
; Out: joins the tail of 003348 (animation $13 repeated $0C times, COP 86).
; Clobbers: A.

gv_boss_mantis_fireball_003359 {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$61
    COP [80] ( #10 )
    COP [82]
    BRA loc_003376
}

---------------------------------------------
; Third of the three simultaneous fireballs.
; 
; When: spawned by gv_boss_metal_mantis_0031AD.
; Sees: a fireball with animation $10 and then $1C.
; Why: as gv_boss_mantis_fireball_003348.
; In: actor script, X = own slot.
; Out: joins the tail of 003348.
; Clobbers: A.

gv_boss_mantis_fireball_003367 {
    COP [A3]
    COP [A2] ( #30 )
    COP [80] ( #10 )
    COP [82]
    COP [80] ( #1C )
    COP [82]

  loc_003376:
    COP [81] ( #13, #0C )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; First kind of shot of the Metal Mantis.
; 
; When: spawned twice per volley by gv_boss_metal_mantis_0031AD (COP B2, offset (-4, -$1A)) while the mantis plays animations $0D / $17.
; Sees: a projectile (BRK $61) that plays animation $11, then $14 repeated $0C times.
; Why: unknown beyond that it is the second kind of ranged attack (OQ-I034-12).
; In: actor script, X = own slot.
; Out: ends with COP 86.
; Clobbers: A.

gv_boss_mantis_shot_00337F {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$61
    COP [80] ( #11 )
    COP [82]
    COP [81] ( #14, #0C )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; Second kind of shot of the Metal Mantis.
; 
; When: spawned twice per volley by gv_boss_metal_mantis_0031AD (COP B2, offset (+$14, -$1A)) while the mantis plays animations $0F / $18.
; Sees: as gv_boss_mantis_shot_00337F with animation $12 and then $15.
; Why: the same shot at offset +$14 instead of -4 (OQ-I034-12).
; In: actor script, X = own slot.
; Out: ends with COP 86.
; Clobbers: A.

gv_boss_mantis_shot_003394 {
    COP [A3]
    COP [A2] ( #30 )
    BRK #$61
    COP [80] ( #12 )
    COP [82]
    COP [81] ( #15, #0C )
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; Left arm of the arm attack.
; 
; When: spawned by the mantis (COP B2, offset (-$28, -$18)) while it plays animation $09 / $0A.
; Sees: an arm sprite (animation $19).
; Why: it only plays the animation and ends; the damage comes from gv_boss_mantis_arm_strike_0033B9.
; In: actor script, X = own slot.
; Out: COP 82 then COP 86.
; Clobbers: A.

gv_boss_mantis_arm_0033A9 {
    COP [80] ( #19 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Right arm of the arm attack.
; 
; When: spawned by the mantis (COP B2, offset (+$28, -$18)) while it plays animation $0B / $0C.
; Sees: an arm sprite (animation $1A).
; Why: as gv_boss_mantis_arm_0033A9.
; In: actor script, X = own slot.
; Out: COP 82 then COP 86.
; Clobbers: A.

gv_boss_mantis_arm_0033B1 {
    COP [80] ( #1A )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; The hit area of the arm attack.
; 
; When: spawned by the mantis (COP 85) during the arm attack, after it sets $16 bit $0002.
; Sees: nothing of its own; it takes the animation table $8000 with bank $0D (COP A8) and plays animation $4E.
; Why: the damage actor of the arm; priority is set from its table.
; In: actor script, X = own slot.
; Out: COP 92 / 94 animation ticks, then COP 86.
; Clobbers: A.

gv_boss_mantis_arm_strike_0033B9 {
    COP [A8] ( #$8000, #0D )
    COP [92] ( #4E )
    COP [94]
    COP [86]
    RTL 
}