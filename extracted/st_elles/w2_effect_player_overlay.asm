; One actor of the world 2 shared code (file offsets 1025781-1025953, SNES $1F:A6F5-$A7A0): the player overlay (meta type $30, animation table $7E3800, the scene spritemap that every enemy and NPC uses, as for the underwater breath actor, meta type $47; no COP A9, so its sprites are static tiles). It spawns two helper actors and keeps them on the hero.
; 
; === OPEN ===
; What the two overlay sprites draw (animations $20-$29 and $21-$2A of the helpers) is not identified; the rule that picks the animation from the hero's speed is traced (OQ-I036-5).
---------------------------------------------

?BANK 1F

!player_actor                   039C
!subframe_active                03A6

---------------------------------------------

; The player overlay (meta type $30).
; 
; When: placement script of the world 2 scenes that use it; runs every frame.
; Sees: spawns the helpers b and a (COP 85), then each frame picks an animation number from the hero's state: subframe_active set: $20; otherwise by the hero's speeds ($04 = x, $06 = y): x negative $26, x positive $28, else y negative $24, y positive $22, still $20. It moves helper a (the previous actor link of this actor) onto the hero (x, y + 1) and helper b onto the hero (x, y), and restarts a helper's animation (step $14 = 0) only when its number changes; helper b uses the number + 1.
; In: X = D = slot.
; Out: RTL; X restored (PHX / PLX).
; Clobbers: A, Y, DP $00.

w2_effect_player_overlay_0FA6F5 {
    COP [85] ( @w2_effect_player_overlay_b_0FA78C )
    COP [85] ( @w2_effect_player_overlay_a_0FA777 )
    COP [91]
    LDA $subframe_active  ; subframe_active set: the first animation ($20) is used and the hero's direction is ignored
    BNE loc_0FA717
    LDY $player_actor
    LDA $0004, Y          ; $04 and $06 of the player actor are his x and y speeds (the pearl ride sets $06 to -1 and 1)
    BMI loc_0FA726
    BNE loc_0FA72B
    LDA $0006, Y
    BMI loc_0FA721
    BNE loc_0FA71C

  loc_0FA717:
    LDA #$0020
    BRA loc_0FA72E

  loc_0FA71C:
    LDA #$0022
    BRA loc_0FA72E

  loc_0FA721:
    LDA #$0024
    BRA loc_0FA72E

  loc_0FA726:
    LDA #$0026
    BRA loc_0FA72E

  loc_0FA72B:
    LDA #$0028

  loc_0FA72E:
    STA $00
    LDY $003E, X
    PHX 
    LDX $player_actor
    LDA $0000, X
    STA $0000, Y
    LDA $0002, X
    INC 
    STA $0002, Y
    LDA $00
    CMP $001E, Y
    BEQ loc_0FA754
    STA $001E, Y
    LDA #$0000
    STA $0014, Y

  loc_0FA754:
    LDA $003E, Y
    TAY 
    LDA $0000, X
    STA $0000, Y
    LDA $0002, X
    STA $0002, Y
    PLX 
    LDA $00
    INC 
    CMP $001E, Y
    BEQ loc_0FA776
    STA $001E, Y
    LDA #$0000
    STA $0014, Y

  loc_0FA776:
    RTL 
}

---------------------------------------------
; First helper of the player overlay: $16 = $0310 (drawn in front, not blocking), animation $20 and an endless animation loop; the overlay actor changes its animation number.
; 
; In: X = D = slot of the helper.
; Out: never returns (loop with COP 82).
; Clobbers: A.

w2_effect_player_overlay_a_0FA777 {
    LDA #$0310
    STA $0016, X
    LDA #$0020
    STA $001E, X
    STZ $0020, X
    COP [91]

  loc_0FA788:
    COP [82]
    BRA loc_0FA788
}

---------------------------------------------
; Second helper of the player overlay: $16 = $0310, animation $21 and an endless animation loop.
; 
; In: X = D = slot of the helper.
; Out: never returns.
; Clobbers: A.

w2_effect_player_overlay_b_0FA78C {
    LDA #$0310
    STA $0016, X
    LDA #$0021
    STA $001E, X
    STZ $0020, X
    COP [91]

  loc_0FA79D:
    COP [82]
    BRA loc_0FA79D
}