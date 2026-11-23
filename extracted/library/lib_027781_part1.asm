; Player pose after a scene load or the equipment menu (file offsets 160761-160865, SNES $04:F3F9-$F461, bank 04).
; 
; === MODEL ===
; ApplyPlayerWeaponPose chooses between two animation sets of the player: the unarmed one when no_combat_scene ($0439) is non-zero or no weapon is equipped (equipped_weapon $1B5E = 0), the armed one otherwise. Actor field $24 is the animation data bank of an actor (lib_animation): the unarmed pose sets it to $0A, the armed one to $0B (the normal player bank, the comment in the player code says $0B).
; Unarmed: $1E = PlayerFacingByAnim[old $1E] xor 1 (the standing animation id for the current facing), $20 = 0, SetActorAnimFrame, and the weapon actor ($039E) gets bit $2000 of $16 set (hidden). Armed: $20 = 0, SetActorAnimFrame, weapon actor bit $2000 cleared; $1E is kept.
; It does nothing in locations $0F-$12 (location_id - $0F below 4).
; 
; === NOTES ===
; - Callers: the end of InitSceneState (after the two RunActors passes) and ExitEquipmentMenu in lib_menus, where a weapon change must show at once.
; - What bank $0A contains (a sword-less set?) is not verified (OQ-I031-3).
---------------------------------------------

?BANK 04

?INCLUDE 'data_engine_tables'
?INCLUDE 'engine_scheduler_sprites_combat_collision'

!player_actor                   039C
!player_weapon_actor            039E
!no_combat_scene                0439
!equipped_weapon                1B5E
!location_id                    1C6A

---------------------------------------------

; Puts the player into the armed or unarmed standing pose.
; 
; When: at the end of InitSceneState and after the equipment menu closes (lib_menus).
; Sees: in towns and without a sword the player stands without a weapon and the sword actor is hidden; with a sword in a normal scene the weapon is shown.
; Why: scene entry and a weapon change both must show the right pose before the first frame, without waiting for the player's own script.
; In: JSL; M = 8, X = 16-bit; location_id, no_combat_scene ($0439), equipped_weapon ($1B5E), player_actor ($039C), player_weapon_actor ($039E).
; Out: skipped in locations $0F-$12. Unarmed: player $24 = $0A, $1E = PlayerFacingByAnim[$1E] xor 1, $20 = 0, SetActorAnimFrame, weapon actor $16 |= $2000. Armed: $24 = $0B, $20 = 0, SetActorAnimFrame, weapon actor $16 &= $DFFF. X and P restored.
; Clobbers: A, Y.

ApplyPlayerWeaponPose {
    PHP 
    PHX 
    SEP #$20
    LDA $location_id
    SEC 
    SBC #$0F
    CMP #$04              ; locations $0F-$12 keep their pose
    BCS PlayerPoseCheckWeapon
    BRL PlayerPoseDone

  PlayerPoseCheckWeapon:
    LDA $no_combat_scene
    BNE PlayerPoseUnarmed
    LDA $equipped_weapon
    BNE PlayerPoseArmed

  PlayerPoseUnarmed:
    LDX $player_actor
    LDA #$0A              ; animation data bank $0A: the unarmed set (OQ-I031-3)
    STA $0024, X
    LDY $001E, X
    LDA $&data_engine_tables.PlayerFacingByAnim, Y
    EOR #$01              ; facing code xor 1 = standing animation id of the unarmed set
    STA $001E, X
    REP #$20
    STZ $0020, X
    JSL $@engine_scheduler_sprites_combat_collision.SetActorAnimFrame
    LDX $player_weapon_actor
    LDA $0016, X
    ORA #$2000            ; hide the weapon actor
    STA $0016, X
    SEP #$20
    BRA PlayerPoseDone

  PlayerPoseArmed:
    LDX $player_actor
    LDA #$0B              ; animation data bank $0B: the normal player set
    STA $0024, X
    REP #$20
    STZ $0020, X
    JSL $@engine_scheduler_sprites_combat_collision.SetActorAnimFrame
    LDX $player_weapon_actor
    LDA $0016, X
    AND #$DFFF            ; show the weapon actor
    STA $0016, X
    SEP #$20

  PlayerPoseDone:
    PLX 
    PLP 
    RTL 
}