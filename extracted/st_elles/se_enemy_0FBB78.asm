; One enemy script that nothing uses (file offsets 1031032-1031075, SNES $1F:BB78-$BBA2): meta type $33 of MetaStElles (attack 1, defence 2, HP 3, EXP 0, animation $22, flags $2310). No lair record of the world uses it and no placement of A06-A09 has it; the types $33 in the placements of other worlds belong to the other worlds' lists.
; 
; === OPEN ===
; What it was meant to be is not known; it hides itself ($16 bit $2000), plays animation $22 and moves down by $48 pixels (OQ-I036-9).
---------------------------------------------

?BANK 1F

---------------------------------------------

; An unused enemy of world 2 (meta type $33).
; 
; When: never in the shipped data (no lair or placement of the world refers to type $33).
; Sees: off screen it waits 60 frames per pass; otherwise it clears the hidden bit ($2000) of its $16, plays animation $22, sets the bit again, adds $48 to its Y (COP A0) and starts over.
; Why: not known (OQ-I036-9).
; In: actor script, X = own slot.
; Out: loops for ever.
; Clobbers: A.

se_unused_enemy_drifting_0FBB78 {
    LDA $0016, X
    BIT #$8000
    BEQ loc_0FBB86

  loc_0FBB80:
    COP [1B] ( &se_unused_enemy_drifting_0FBB78, #$003C )

  loc_0FBB86:
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [80] ( #22 )
    COP [82]
    LDA $0016, X
    ORA #$2000
    STA $0016, X
    COP [A0] ( #$0048 )
    BRA loc_0FBB80
}