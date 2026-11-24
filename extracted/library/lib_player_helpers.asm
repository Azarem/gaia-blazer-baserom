; Player helpers of bank 04: the facing code (GetPlayerFacing), the actor flip (FlipActorX), the weapon pose (ApplyPlayerWeaponPose), the pay-out of pending heal and EXP (DrainPendingHeal, DrainPendingExp) and the EXP and Gem counters (AddExp, AddGems, SubtractGems) (file offsets 160724-161517, SNES $04:F3D4-$F6ED).
; 
; One file of routines that read or change the player's state and are called from several subsystems: lib_field_talk (GetPlayerFacing, FlipActorX), lib_tile_triggers_and_lair_return (GetPlayerFacing, AddGems), lib_menus and lib_boot_and_scene_init (ApplyPlayerWeaponPose), lib_hud (DrainPendingHeal, DrainPendingExp), engine_combat_hits (AddExp), cop_items_stats_text (AddGems, SubtractGems) and engine_spawn_lairs_death_drops (AddGems). The part that holds ApplyPlayerWeaponPose keeps its branch target in the same file. The sections below keep the notes of the former files in file order.
; 
; Facing code of the player and the horizontal flip of an actor (file offsets 160724-160760, SNES $04:F3D4-$F3F8, bank 04).
; 
; === MODEL ===
; GetPlayerFacing reads the player's animation id (actor $1E) and returns the facing code PlayerFacingByAnim[id] (a 44-byte table in data_engine_tables, ids $00-$2B): 0 up, 1 down, 2 right, 3 left (the probe points of RunTalkInteraction, OQ-I009-7). Animation ids of $2C or more have no facing: carry set. The animation id is read as a word, so $1F must be 0.
; FlipActorX toggles bit $4000 of the actor's $1C word, the horizontal flip flag.
; 
; === NOTES ===
; - Callers: RunTalkInteraction (lib_field_talk) for the probe point of the talk button and TryOpenChest (lib_tile_triggers_and_lair_return); ChooseFacingAnim (lib_field_talk) calls FlipActorX to show an NPC's side view mirrored.
; - ApplyPlayerWeaponPose reads the same table and xors the code with 1 to get the standing animation id of the unarmed set.
; 
; Player pose after a scene load or the equipment menu (file offsets 160761-160865, SNES $04:F3F9-$F461, bank 04).
; 
; === MODEL ===
; ApplyPlayerWeaponPose chooses between two animation sets of the player: the unarmed one when no_combat_scene ($0439) is non-zero or no weapon is equipped (equipped_weapon $1B5E = 0), the armed one otherwise. Actor field $24 is the animation data bank of an actor (lib_animation): the unarmed pose sets it to $0A, the armed one to $0B (the normal player bank, the comment in the player code says $0B).
; Unarmed: $1E = PlayerFacingByAnim[old $1E] xor 1 (the standing animation id for the current facing), $20 = 0, SetActorAnimFrame, and the weapon actor ($039E) gets bit $2000 of $16 set (hidden). Armed: $20 = 0, SetActorAnimFrame, weapon actor bit $2000 cleared; $1E is kept.
; It does nothing in locations $0F-$12 (location_id - $0F below 4).
; 
; === NOTES ===
; - Callers: the end of InitSceneState (after the two RunActors passes) and the tail of OpenEquipmentMenu in lib_menus, where a weapon change must show at once.
; - What bank $0A contains (a sword-less set?) is not verified (OQ-I031-3).
; 
; Pay-out of pending heal and EXP, and the EXP and Gem counters (file offsets 161261-161517, SNES $04:F5ED-$F6ED, bank 04).
; 
; === MODEL ===
; heal_pending ($043B) and exp_pending ($043D) are queues that Cop37_HealPlayerToFull and Cop38_QueueExp fill; UpdateHud calls DrainPendingHeal and DrainPendingExp once per frame (not in locations $0F-$12) and the drains pay them out slowly so the HUD animates. All counters are BCD (decimal mode).
; DrainPendingHeal: every 4th frame (frame_counter & 3 = 0) heal_pending - 1 and player_hp + 1 with BRK #$48 (OQ-I013-5); when HP is already at player_max_hp the rest of heal_pending is dropped. hud_dirty_flags bit $04 redraws the HP bar.
; DrainPendingExp: every 8th frame, with BRK #$48, it takes one unit of the lowest non-zero BCD digit of exp_pending (ones, then tens, then hundreds, then thousands), subtracts it from exp_pending and calls AddExp with it; hud_dirty_flags bit $02 redraws the EXP. A pending 0132 pays 1, 1, 10, 10, 10, 100 in six steps.
; AddExp: player_exp ($1B78, low word) and player_exp+2 ($1B7A, high word) are one eight-digit BCD number; on a carry out of the high word both words are set to $9999, so EXP maxes at 99,999,999 (walkthrough level-up.md agrees). AddGems: gems_low ($1B66) + A with the carry into gems_high ($1B68); gems_high can be at most $0099, so a carry ($0100, >= $009A) caps both at 999,999 (OQ-I013-8: the walkthrough gives no Gem cap). SubtractGems takes A from the Gems and returns carry set when there are not enough (nothing is taken).
; 
; === NOTES ===
; - Callers: AddExp from DrainPendingExp and from the two kill paths of engine_actor_scheduler_and_sprites (KillTarget and the second kill path at loc_000CFC: the EXP of the meta entry, +3, is added at once, not through exp_pending). Cop36_AddExp (0 uses) does its own decimal add and does not call AddExp. AddGems: ApplyGemPickup, the chest code (TryOpenChest) and Cop25_AddGems (0 uses). SubtractGems: Cop26_PayGemsOrJump.
; - DrainPendingHeal and DrainPendingExp run with M = 8; AddExp, AddGems and SubtractGems with M = 16. All routines leave the decimal flag clear.
; - docs/wram-memory-map.md said player_exp is 24-bit BCD; the code and the walkthrough make it eight digits (four bytes $1B78-$1B7B, followed by player_exp_next at $1B7C), corrected in the same step (OQ-I031-4).
---------------------------------------------

?BANK 04

?INCLUDE 'data_engine_tables'
?INCLUDE 'engine_actor_scheduler_and_sprites'

!frame_counter                  0312
!hud_dirty_flags                0332
!player_actor                   039C
!player_weapon_actor            039E
!no_combat_scene                0439
!heal_pending                   043B
!exp_pending                    043D
!equipped_weapon                1B5E
!gems_low                       1B66
!gems_high                      1B68
!player_exp                     1B78
!player_hp                      1B88
!player_max_hp                  1B8A
!location_id                    1C6A

---------------------------------------------

; Gives the direction the player faces as a code 0-3.
; 
; When: RunTalkInteraction (the B button) and TryOpenChest.
; Sees: the player talks to or opens what is in front of him, and in no direction while an animation of the $2C or higher ids plays (no talk, no chest).
; Why: the facing is derived from the animation id, so every walking, standing and attack animation maps to one of four directions.
; In: JSL; M = 8, X = 16-bit; player_actor ($039C).
; Out: carry clear and A = PlayerFacingByAnim[$1E of the player actor] (0 up, 1 down, 2 right, 3 left); carry set when $1E >= $2C (A not valid). P restored apart from the carry.
; Clobbers: A, X, Y.

GetPlayerFacing {
    PHP 
    SEP #$20
    LDY $player_actor
    LDX $001E, Y
    CPX #$002C            ; animation ids of $2C or more have no facing: carry set
    BCS GetPlayerFacingNone
    LDA $&data_engine_tables.PlayerFacingByAnim, X
    PLP 
    CLC 
    RTL 

  GetPlayerFacingNone:
    PLP 
    SEC 
    RTL 
}
---------------------------------------------

; Mirrors an actor horizontally.
; 
; When: ChooseFacingAnim (lib_field_talk) when an actor turns toward the player and needs the side view the other way round.
; Sees: the actor's sprite is drawn flipped.
; Why: the side animations exist only once; the flip bit makes the second direction.
; In: JSL; X = actor.
; Out: bit $4000 of the actor's $1C word toggled. P restored.
; Clobbers: A.

FlipActorX {
    PHP 
    REP #$20
    LDA $001C, X
    EOR #$4000            ; bit $4000 of $1C is the horizontal flip flag
    STA $001C, X
    PLP 
    RTL 
}
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
    JSL $@engine_actor_scheduler_and_sprites.SetActorAnimFrame
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
    JSL $@engine_actor_scheduler_and_sprites.SetActorAnimFrame
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
---------------------------------------------

; Pays out the queued healing one HP at a time.
; 
; When: once per frame from UpdateHud (not in locations $0F-$12).
; Sees: after Cop37_HealPlayerToFull (the healing scenes) the HP bar fills one point every 4 frames with a sound.
; Why: the command only queues the amount, so the heal is spread over frames and the sound and HUD follow.
; In: JSL; M = 8; heal_pending ($043B), frame_counter, player_hp ($1B88), player_max_hp ($1B8A).
; Out: on frames with frame_counter & 3 = 0 and heal_pending non-zero: heal_pending - 1, player_hp + 1 (BRK #$48), hud_dirty_flags |= $04; when HP is already at the maximum heal_pending = 0.
; Clobbers: A.

DrainPendingHeal {
    LDA $heal_pending
    BEQ DrainHealDone
    LDA $frame_counter
    AND #$03
    BNE DrainHealDone
    DEC $heal_pending
    LDA $player_hp
    CMP $player_max_hp
    BCS DrainHealCapped   ; HP already full: the rest of heal_pending is dropped
    INC $player_hp
    BRK #$48              ; sound request $48 for every healed HP (OQ-I013-5)
    BRA DrainHealMarkHud

  DrainHealCapped:
    STZ $heal_pending

  DrainHealMarkHud:
    LDA #$04
    TSB $hud_dirty_flags

  DrainHealDone:
    RTL 
}
---------------------------------------------

; Pays out the queued EXP in digit steps.
; 
; When: once per frame from UpdateHud (not in locations $0F-$12).
; Sees: the EXP counter climbs in steps with a sound after a Cop38 reward.
; Why: one unit of the lowest non-zero BCD digit per step keeps the number of steps at most the digit sum, and the HUD redraws only on a step.
; In: JSL; M = 8; exp_pending ($043D, a word of 4 BCD digits), frame_counter.
; Out: on frames with frame_counter & 7 = 0 and exp_pending non-zero: BRK #$48, exp_pending - one unit (1, 10, 100 or 1000), AddExp with that unit, hud_dirty_flags |= $02; decimal flag clear and M = 8 on return.
; Clobbers: A (the step is added through AddExp).

DrainPendingExp {
    LDA $exp_pending
    ORA $exp_pending+1
    BEQ DrainExpDone
    LDA $frame_counter
    AND #$07
    BNE DrainExpDone
    REP #$20
    BRK #$48              ; sound request $48 for every EXP step (OQ-I013-5)
    SED                   ; decimal mode: the digit tests and the subtraction are BCD
    LDA $exp_pending
    AND #$000F            ; pays one unit of the lowest non-zero digit: ones first, then tens, hundreds, thousands
    BNE DrainExpOnes
    LDA $exp_pending
    AND #$00F0
    BNE DrainExpTens
    LDA $exp_pending
    AND #$0F00
    BNE DrainExpHundreds
    LDA $exp_pending
    SEC 
    SBC #$1000
    STA $exp_pending
    LDA #$1000
    BRA DrainExpPay

  DrainExpHundreds:
    LDA $exp_pending
    SEC 
    SBC #$0100
    STA $exp_pending
    LDA #$0100
    BRA DrainExpPay

  DrainExpTens:
    LDA $exp_pending
    SEC 
    SBC #$0010
    STA $exp_pending
    LDA #$0010
    BRA DrainExpPay

  DrainExpOnes:
    LDA $exp_pending
    SEC 
    SBC #$0001
    STA $exp_pending
    LDA #$0001

  DrainExpPay:
    CLD 
    JSL $@AddExp
    SEP #$20
    LDA #$02
    TSB $hud_dirty_flags

  DrainExpDone:
    RTL 
}

---------------------------------------------
; Adds a BCD amount to the player's EXP with a cap.
; 
; When: DrainPendingExp and the two enemy kill paths in engine_combat_hits (KillTarget and KillOrSpareProjectileTarget; the meta entry's EXP at once).
; Sees: the EXP counter and, once the next level's threshold is reached, the level-up; the walkthrough says EXP maxes at 99,999,999.
; Why: EXP is eight BCD digits in two words, so the add carries from the low into the high word and a carry out is capped.
; In: JSL; M = 16; A = BCD amount.
; Out: player_exp ($1B78) + A, with the carry into player_exp+2 ($1B7A); a carry out of the high word sets both words to $9999; the decimal flag is cleared (CLD) on return even if the caller had set it.
; Clobbers: A.

AddExp {
    SED 
    CLC 
    ADC $player_exp
    STA $player_exp
    LDA $player_exp+2
    ADC #$0000
    STA $player_exp+2
    BCC AddExpDone        ; carry out of the high word: more than 99,999,999, cap both words
    LDA #$9999
    STA $player_exp
    STA $player_exp+2

  AddExpDone:
    CLD 
    RTL 
}
---------------------------------------------

; Adds a BCD amount to the Gems with a cap.
; 
; When: ApplyGemPickup (Gem pickups), TryOpenChest (Gems in a chest) and Cop25_AddGems (no script).
; Sees: the Gem counter rises; it never shows more than 999999.
; Why: the Gems are six BCD digits in two words, so the add carries into the high word and a result of 1,000,000 or more is capped.
; In: JSL; M = 16; A = BCD amount.
; Out: gems_low ($1B66) + A with the carry into gems_high ($1B68); when gems_high is $009A or more both words are set to $9999 and $0099; decimal flag cleared.
; Clobbers: A.

AddGems {
    SED 
    CLC 
    ADC $gems_low
    STA $gems_low
    LDA $gems_high
    ADC #$0000
    STA $gems_high
    CMP #$009A            ; gems_high is at most $0099; a carry makes it $0100: cap at 999,999
    BCC AddGemsDone
    LDA #$9999
    STA $gems_low
    LDA #$0099
    STA $gems_high

  AddGemsDone:
    CLD 
    RTL 
}
---------------------------------------------

; Takes a price from the Gems if there are enough.
; 
; When: Cop26_PayGemsOrJump (8 scripts).
; Sees: the Gem counter drops by the price, or the script's 'not enough' branch runs.
; Why: the test and the payment are one operation so no Gems are taken when the price is too high.
; In: JSL; M = 16; A = BCD price.
; Out: carry clear: gems_low and gems_high reduced by the price. Carry set: not enough Gems, nothing changed. Decimal flag cleared.
; Clobbers: A; dp$00, $02, $04.

SubtractGems {
    SED 
    STA $04
    LDA $gems_low
    SEC 
    SBC $04
    STA $00
    LDA $gems_high
    SBC #$0000
    STA $02
    BCS SubtractGemsStore ; carry set = no borrow: enough Gems
    CLD 
    SEC 
    RTL 

  SubtractGemsStore:
    LDA $00
    STA $gems_low
    LDA $02
    STA $gems_high
    CLD 
    CLC 
    RTL 
}