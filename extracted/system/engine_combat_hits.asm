; Hit detection and damage: the player's sword, magic and projectiles against actors, and the player's contact with monsters and pickups (file offsets 2612-3879, SNES $00:8A34-$8F27, bank 00).
; 
; === MODEL ===
; DetectHitSourceCollisions pairs every listed actor with $16 bit $0080 (and none of $0D00) against every actor without $EEC0 whose box overlaps and whose sprite rectangles overlap (TestSpriteOverlap); sources with $16 bit $0020 go to ApplyProjectileHit, the others to ApplySwordHit. DetectPlayerContact tests the player's hurt box against actors without $25C0 and calls ApplyContactDamageOrPickup. The rules below are read from the code; the item names are those of the walkthrough (docs/walkthrough/items.md). The only caller of the file is engine_boot_main_loop (two references).
; 
; === RULES ===
; - Equipment ids: equipped_weapon $1B5E (2 Psycho Sword, 3 Critical Sword, 5 Zantetsu Sword, 6 Spirit Sword, 7 Recovery Sword, 8 Soul Blade), equipped_armor $1B60 ($0D Mystic Armor, $0E Light Armor), equipped_magic $1B62 ($18 Phoenix), equipped_bracelet $1B64 ($35 Power, $36 Shield, $37 Super).
; - Sword damage = max(1, attack_current $1B8C - monster defence (meta entry +1)); Power and Super Bracelet double it. Monster HP is $25; a hit that does not leave HP above 0 kills (or leaves 1 HP when $1A bit $0100).
; - Immunity classes ($1A): $0400 metal is hurt only by the Zantetsu Sword, $0800 spirit only by the Spirit Sword, $0200 special only by the Soul Blade (which hurts everything). Metal deflects with sound $4C, the other two ignore the hit silently.
; - Damage to the player = max(1, monster attack - 1 - defense_current $1B8E); Shield and Super Bracelet halve it. Light Armor blocks the hit when attack x 1.5 is below $1B8E (sound $0C). Mystic Armor sets the hit stun counter to -64 instead of -32.
; - Hit stun: $26 = -8 for monsters, $FFE0 or $FFC0 for the player; while $16 bit $0800 is set the stunned player only picks things up.
; - Differences from the walkthrough are in OQ-I005-1 (Super Bracelet), -2 (Critical Sword), -3 (Psycho Sword).
; 
; === ENEMY GAUGE ===
; A hit on a monster without $16 bit $0001 sets enemy_gauge_hp ($0336) to its HP, enemy_gauge_max ($0338) to the meta entry HP (+2) and enemy_gauge_timer ($0330) to $80 (SetEnemyGauge). The HUD update (lib_hud.UpdateHud) draws the gauge string EnemyGaugeText ([04:336,338]) once, counts the timer down by 2 per frame and erases the gauge when it reaches 0.
---------------------------------------------

?BANK 00

?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'lib_player_helpers'
?INCLUDE 'WorldMetaPointers'

!frame_counter                  0312
!enemy_gauge_timer              0330
!hud_dirty_flags                0332
!enemy_gauge_hp                 0336
!enemy_gauge_max                0338
!boss_actor                     039A
!player_actor                   039C
!contact_lock                   042D
!draw_list                      1900
!equipped_weapon                1B5E
!equipped_armor                 1B60
!equipped_magic                 1B62
!equipped_bracelet              1B64
!gear_power                     1B70
!level_power                    1B72
!player_hp                      1B88
!player_max_hp                  1B8A
!attack_current                 1B8C
!defense_current                1B8E

---------------------------------------------

; Finds which hit sources (the player's sword, magic and projectiles) touch which actors this frame.
; 
; When: every frame after the sort, in the main loop only.
; Sees: monsters flash, lose HP and die (nothing is knocked back, OQ-I047-6).
; Why: the draw list gives the on-screen candidates cheaply.
; In: none; skipped when the player actor is dying ($16 bit $0400).
; Out: for every listed actor with $16 bit $0080 and none of $0D00 (source), scans the list for targets without any of $EEC0 whose box overlaps; TestSpriteOverlap confirms; sources with $16 bit $0020 call ApplyProjectileHit, others ApplySwordHit. A source can hit several targets in one frame.
; Clobbers: A, X, Y, dp$00-$06 (source box top, bottom, left, right), dp$3E (source slot); DBR and P restored.

DetectHitSourceCollisions {
    PHP 
    PHB 
    REP #$20
    LDX $player_actor
    LDA $0016, X
    BIT #$0400            ; Player dying ($16 bit $0400): no hits this frame
    BEQ loc_000A46
    BRL loc_000AEF

  loc_000A46:
    LDX #$0000

; Next source candidate from the draw list; 0 ends the scan. A source needs $16 bit $0080 and none of $0D00.

  NextHitSource:
    LDY $draw_list, X
    BNE loc_000A51
    BRL loc_000AEF

  loc_000A51:
    INX 
    INX 
    LDA $0016, Y
    BIT #$0080
    BEQ NextHitSource
    BIT #$0D00            ; Source needs $0080 (hits other actors) and none of $0D00 (hit stun, dying, bit $0100)
    BNE NextHitSource
    PHX 
    SEP #$20
    LDA $0024, Y
    PHA 
    PLB 
    REP #$20
    LDX #$0000
    STY $3E

; Loads the source's box into dp$00-$06 (top = y - $0A, bottom = y + $0E, left = x - $08, right = x + $0C) and sets the source slot in dp$3E; X restarts at the head of the list for the targets.

  LoadHitSourceBox:
    LDY $3E
    LDA $0002, Y
    SEC 
    SBC $000A, Y
    STA $00
    LDA $0002, Y
    CLC 
    ADC $000E, Y
    STA $02
    LDA $0000, Y
    SEC 
    SBC $0008, Y
    STA $04
    LDA $0000, Y
    CLC 
    ADC $000C, Y
    STA $06

; Next target from the draw list; box overlap test against dp$00-$06, then TestSpriteOverlap, then the hit routines. 0 ends the targets of this source.

  NextHitTarget:
    LDY $draw_list, X
    BEQ loc_000AEB
    INX 
    INX 
    LDA $0016, Y
    BIT #$EEC0            ; Target must have none of $EEC0 (off screen, pickup, hidden, hit stun, dying, hit source, $0200, $0040)
    BNE NextHitTarget
    LDA $0000, Y
    SEC 
    SBC $0008, Y
    CMP $06
    BCS NextHitTarget
    LDA $0000, Y
    CLC 
    ADC $000C, Y
    CMP $04
    BCC NextHitTarget
    LDA $0002, Y
    SEC 
    SBC $000A, Y
    CMP $02
    BCS NextHitTarget
    LDA $0002, Y
    CLC 
    ADC $000E, Y
    CMP $00
    BCC NextHitTarget
    JSR $&TestSpriteOverlap
    BCC LoadHitSourceBox
    PHX 
    LDX $3E
    LDA $0016, X
    BIT #$0020            ; $16 bit $0020 = projectile source; all others are sword hits
    BNE loc_000AE5
    JSR $&ApplySwordHit
    BRA loc_000AE8

  loc_000AE5:
    JSR $&ApplyProjectileHit

  loc_000AE8:
    PLX 
    BRA LoadHitSourceBox

  loc_000AEB:
    PLX 
    BRL NextHitSource

  loc_000AEF:
    PLB 
    PLP 
    RTL 
}

---------------------------------------------
; Applies the equipped sword to a hit target: damage, freeze, immunity, kill and EXP.
; 
; When: a sword-side source ($16 bit $0080, not a projectile) overlaps a target.
; Sees: the monster flashes and loses HP (it stands still for the stun while the hero swings; nothing is knocked back, OQ-I047-6), or dies with a drop and EXP; deflected hits ring.
; Why: all sword rules live here, so every weapon differs only by id (rules in the block note).
; In: X = source, Y = target; ignored when the player animation $1E is $24 or more.
; Out: target $25 (HP), $26, $16, $1A, $18, $36, $14; HUD bits in $0332; enemy gauge words; player_hp (Recovery Sword).
; Clobbers: A, X; dp$00. Open: OQ-I005-1, -2, -3, -4.

ApplySwordHit {
    LDX $player_actor
    LDA $001E, X
    CMP #$0024            ; Sword hits count only while the player animation ($1E) is below $24
    BCC loc_000AFE
    RTS 

  loc_000AFE:
    LDA $0016, Y
    BIT #$0002            ; $16 bit $0002: this actor deflects every hit
    BEQ loc_000B09

; BRK #$4C: sound $4C (the hit is deflected) and return without damage.

  DeflectHit:
    BRK #$4C              ; BRK #n requests sound n (the BRK handler stores it in sound_request); $4C = deflected hit
    RTS 

  loc_000B09:
    LDA $equipped_weapon  ; equipped_weapon: 8 (Soul Blade) skips every immunity check
    CMP #$0008
    BEQ ApplySwordDamage
    LDA $equipped_weapon
    CMP #$0002            ; Weapon 2 (Psycho Sword): a target with an immunity class ($1A bits $0E00), except the $039A actor, is frozen for 180 frames (OQ-I005-3)
    BNE CheckImmunityClass
    CPY $boss_actor
    BEQ CheckImmunityClass
    LDA $001A, Y
    BIT #$0E00
    BEQ ApplySwordDamage
    LDA $001A, Y
    ORA #$0040
    STA $001A, Y
    LDA $0016, Y
    ORA #$0800
    STA $0016, Y
    LDA #$00B4
    STA $0026, Y

; Tests the $1A immunity classes: $0800 (spirit) needs weapon 6, $0400 (metal) needs weapon 5 and otherwise deflects, $0200 (special) ignores the hit (the Soul Blade skipped this earlier); no class goes on to ApplySwordDamage.

  CheckImmunityClass:
    LDA $001A, Y          ; Immunity classes in $1A: $0800 spirit (Spirit Sword 6 only), $0400 metal (Zantetsu Sword 5 only, others deflect), $0200 special (Soul Blade only)
    BIT #$0800
    BNE loc_000B51
    BIT #$0400
    BNE loc_000B5A
    BIT #$0200
    BEQ ApplySwordDamage
    RTS 

  loc_000B51:
    LDA $equipped_weapon
    CMP #$0006
    BEQ ApplySwordDamage
    RTS 

  loc_000B5A:
    LDA $equipped_weapon
    CMP #$0005
    BNE DeflectHit

; Damage path: weapon 3 (Critical Sword) kills when (frame_counter and $0F) = 0 except the $039A actor; otherwise damage = max(1, attack_current - monster defence), doubled for the Super or Power Bracelet, subtracted from $25; HP 0 or below goes to KillOrSpareTarget, else the target is stunned ($26 = -8, $16 bit $0800), frozen while the player swings ($20-$23), and sound $42 plays.

  ApplySwordDamage:
    LDA $equipped_weapon
    CMP #$0003            ; Weapon 3 (Critical Sword): when (frame_counter and $0F) = 0 the hit kills outright, except the $039A actor (OQ-I005-2)
    BNE loc_000B77
    CPY $boss_actor
    BEQ loc_000B77
    LDA $frame_counter
    AND #$000F
    BEQ KillOrSpareTarget

  loc_000B77:
    SEP #$20
    LDX $0038, Y
    LDA $@WorldMetaPointers+1, X
    STA $00
    LDA $attack_current   ; damage = max(1, attack_current ($1B8C) - monster defence (meta entry +1))
    SEC 
    SBC $00
    BEQ loc_000B8C
    BCS loc_000B8E

  loc_000B8C:
    LDA #$01

  loc_000B8E:
    STA $00
    LDA $equipped_bracelet ; Bracelet $1B64: $37 (Super) or $35 (Power) doubles the damage (OQ-I005-1)
    CMP #$37
    BEQ loc_000B9B
    CMP #$35
    BNE loc_000B9D

  loc_000B9B:
    ASL $00

  loc_000B9D:
    LDA $0025, Y
    SEC 
    SBC $00               ; Target HP - damage; zero or below goes to the kill path
    BCC KillOrSpareTarget
    BEQ KillOrSpareTarget

  loc_000BA7:
    STA $0025, Y
    REP #$20
    CPY $boss_actor
    BEQ loc_000BC0
    LDX $player_actor
    LDA $001E, X
    SEC 
    SBC #$0020            ; Player animation $20-$23 (sword swing): the target stays frozen ($1A bit $0040) during the stun; otherwise the bit is cleared
    CMP #$0004
    BCC loc_000BCB

  loc_000BC0:
    LDA $001A, Y
    AND #$FFBF
    STA $001A, Y
    BRA loc_000BD4

  loc_000BCB:
    LDA $001A, Y
    ORA #$0040
    STA $001A, Y

  loc_000BD4:
    LDA #$FFF8            ; Hit stun: $26 = -8 (counts up to 0) and $16 bit $0800
    STA $0026, Y
    LDA $0016, Y
    ORA #$0800
    STA $0016, Y
    BRK #$42              ; Sound $42: a hit lands
    BRA SetEnemyGauge

; Lethal hit: with $1A bit $0100 the target keeps 1 HP and takes the normal hit path, otherwise it is killed (KillTarget).

  KillOrSpareTarget:
    REP #$20
    LDA $001A, Y
    BIT #$0100            ; $1A bit $0100: survives a lethal hit with 1 HP
    SEP #$20
    BEQ KillTarget
    LDA #$01
    BRA loc_000BA7

; Kills the target: script = RunEnemyDeath (death and drops), HP 0, wait 0, $16 bit $0400 (dying); adds the meta entry EXP (+3) to the player EXP in BCD; HUD bit $0002; Recovery Sword (7) heals 1 HP (HUD bit $0004); sound $43.

  KillTarget:
    LDA #$^engine_spawn_lairs_death_drops.RunEnemyDeath ; Kill: script = RunEnemyDeath (death and drops), HP 0, wait 0, $16 bit $0400 (dying)
    STA $0036, Y
    LDA #$00
    STA $0025, Y
    REP #$20
    LDA #$&engine_spawn_lairs_death_drops.RunEnemyDeath
    STA $0018, Y
    LDA #$0000
    STA $0014, Y
    LDA $0016, Y
    ORA #$0400
    STA $0016, Y
    LDX $0038, Y
    LDA $@WorldMetaPointers+3, X ; EXP = meta entry +3, added to the player EXP in BCD by AddExp
    JSL $@lib_player_helpers.AddExp
    LDA #$0002
    TSB $hud_dirty_flags
    LDA $equipped_weapon  ; Weapon 7 (Recovery Sword): +1 HP per kill (HUD HP bit)
    CMP #$0007
    BNE loc_000C42
    LDA $player_hp
    CMP $player_max_hp
    BEQ loc_000C42
    INC $player_hp
    LDA #$0004
    TSB $hud_dirty_flags

  loc_000C42:
    BRK #$43              ; Sound $43: the monster dies

; Unless $16 bit $0001: enemy_gauge_hp = target HP, enemy_gauge_max = meta entry HP (+2), enemy_gauge_timer = $80 (HUD gauge, see the block note).

  SetEnemyGauge:
    LDA $0016, Y
    BIT #$0001
    BEQ loc_000C4D
    RTS 

  loc_000C4D:
    SEP #$20
    LDA $0025, Y
    STA $enemy_gauge_hp   ; Enemy gauge for the HUD: $0336 = HP after the hit, $0338 = max HP (meta +2), $0330 = $80 starts the display timer
    LDX $0038, Y
    LDA $@WorldMetaPointers+2, X
    STA $enemy_gauge_max
    LDA #$80
    STA $enemy_gauge_timer
    REP #$20
    RTS 
}

---------------------------------------------
; Applies a projectile (magic) hit to a target.
; 
; When: a projectile source ($16 bit $0020) overlaps a target.
; Sees: the monster is hurt, stunned or killed by the spell.
; Why: projectiles carry their own damage ($30) instead of using the sword formula.
; In: X = projectile, Y = target.
; Out: damage $30 ($FF = always kills) or, with equipped_magic $18 (Phoenix), $1B70 + $1B72 - defence; immunity checks as for the sword (metal deflects, spirit and special are ignored); stun $FFF8; kill as in KillTarget (no Recovery Sword).
; Clobbers: A, X; dp$00.

ApplyProjectileHit {
    LDA $0016, Y
    BIT #$0002
    BEQ loc_000C72

; BRK #$4C: sound $4C and return without damage.

  DeflectProjectile:
    BRK #$4C
    RTS 

  loc_000C72:
    LDA $0030, X          ; Projectile damage in $30 ($FF = always kills)
    CMP #$00FF
    BEQ ApplyProjectileDamage
    LDA $equipped_magic   ; equipped_magic $18 (Phoenix): damage from the attack formula below instead of $30
    CMP #$0018
    BEQ ApplyPhoenixDamage
    CPY $boss_actor
    BEQ DeflectProjectile
    LDA $001A, Y
    BIT #$0A00
    BEQ loc_000C90
    RTS 

  loc_000C90:
    BIT #$0400
    BNE DeflectProjectile

; Damage = $30 of the projectile ($FF kills outright); subtracts it from the target HP; HP 0 or below goes to KillOrSpareProjectileTarget, otherwise StunProjectileTarget.

  ApplyProjectileDamage:
    SEP #$20
    LDA $0025, Y
    SEC 
    SBC $0030, X
    BCC KillOrSpareProjectileTarget
    BEQ KillOrSpareProjectileTarget
    BRA StunProjectileTarget

; Phoenix equipped: damage = max(1, $1B70 + $1B72 - monster defence) instead of the projectile's $30.

  ApplyPhoenixDamage:
    SEP #$20
    LDX $0038, Y
    LDA $@WorldMetaPointers+1, X
    STA $00
    LDA $gear_power
    CLC 
    ADC $level_power
    SEC 
    SBC $00
    BEQ loc_000CBD
    BCS loc_000CBF

  loc_000CBD:
    LDA #$01

  loc_000CBF:
    STA $00
    LDA $0025, Y
    SEC 
    SBC $00
    BCC KillOrSpareProjectileTarget
    BEQ KillOrSpareProjectileTarget

; Stores the HP, sets the stun ($26 = $FFF8, $16 bit $0800), clears $1A bit $0040 and plays sound $42.

  StunProjectileTarget:
    STA $0025, Y
    REP #$20
    LDA #$FFF8
    STA $0026, Y
    LDA $0016, Y
    ORA #$0800
    STA $0016, Y
    LDA $001A, Y
    AND #$FFBF
    STA $001A, Y
    BRK #$42
    BRA SetEnemyGaugeProjectile

; Lethal projectile hit: $1A bit $0100 keeps 1 HP, otherwise the target is killed as in KillTarget (script RunEnemyDeath, EXP, HUD bit $0002, sound $43).

  KillOrSpareProjectileTarget:
    REP #$20
    LDA $001A, Y
    BIT #$0100
    SEP #$20
    BEQ loc_000CFC
    LDA #$01
    BRA StunProjectileTarget

  loc_000CFC:
    SEP #$20
    LDA #$^engine_spawn_lairs_death_drops.RunEnemyDeath
    STA $0036, Y
    LDA #$00
    STA $0025, Y
    REP #$20
    LDA #$&engine_spawn_lairs_death_drops.RunEnemyDeath
    STA $0018, Y
    LDA #$0000
    STA $0014, Y
    LDA $0016, Y
    ORA #$0400
    STA $0016, Y
    LDX $0038, Y
    LDA $@WorldMetaPointers+3, X
    JSL $@lib_player_helpers.AddExp
    LDA #$0002
    TSB $hud_dirty_flags
    BRK #$43

; Same as SetEnemyGauge for projectile hits.

  SetEnemyGaugeProjectile:
    LDA $0016, Y
    BIT #$0001
    BEQ loc_000D3B
    RTS 

  loc_000D3B:
    SEP #$20
    LDA $0025, Y
    STA $enemy_gauge_hp
    LDX $0038, Y
    LDA $@WorldMetaPointers+2, X
    STA $enemy_gauge_max
    LDA #$80
    STA $enemy_gauge_timer
    REP #$20
    RTS 
}

---------------------------------------------
; Exact hit test: does any spritemap rectangle of the source overlap the target's box?
; 
; When: after the coarse box test of DetectHitSourceCollisions.
; Sees: hits land where sprites touch, not where boxes touch.
; Why: boxes are coarse; spritemaps give the real shapes.
; In: Y = target, dp$3E = source, dp$00-$06 = target box.
; Out: carry set when any rectangle (size 8 or 16 by the entry flag bit 0, flips from $1C of the source) overlaps; X and Y preserved.
; Clobbers: A, dp$00-$0C.

TestSpriteOverlap {
    PHX 
    PHY 
    TYX 
    LDY $3E
    LDA $0002, X
    SEC 
    SBC $000A, X
    STA $00
    LDA $0002, X
    CLC 
    ADC $000E, X
    STA $02
    LDA $0000, X
    SEC 
    SBC $0008, X
    STA $04
    LDA $0000, X
    CLC 
    ADC $000C, X
    STA $06
    LDA $0000, Y
    SEC 
    SBC $0008, Y
    STA $08
    LDA $0002, Y
    SEC 
    SBC $000A, Y
    STA $0A
    LDX $0028, Y
    LDA $0000, X
    STA $0C
    INX 
    INX 

  loc_000D9A:
    LDA $0000, X
    LSR 
    BCC loc_000DA5
    LDA #$000F
    BRA loc_000DA8

  loc_000DA5:
    LDA #$0007

  loc_000DA8:
    PHA 
    LDA $001C, Y
    ASL 
    ASL 
    LDA $0001, X
    BCC loc_000DB4
    XBA 

  loc_000DB4:
    AND #$00FF
    CLC 
    ADC $08
    CMP $06
    BCS loc_000DE5
    CLC 
    ADC $01, S
    CMP $04
    BCC loc_000DE5
    LDA $001C, Y
    ASL 
    LDA $0003, X
    BCC loc_000DCF
    XBA 

  loc_000DCF:
    AND #$00FF
    CLC 
    ADC $0A
    CMP $02
    BCS loc_000DE5
    CLC 
    ADC $01, S
    CMP $00
    BCC loc_000DE5
    PLA 
    PLY 
    PLX 
    SEC 
    RTS 

  loc_000DE5:
    PLA 
    TXA 
    CLC 
    ADC #$0007
    TAX 
    DEC $0C
    BNE loc_000D9A
    PLY 
    PLX 
    CLC 
    RTS 
}

---------------------------------------------
; Finds actors touching the player and applies contact damage or pickups.
; 
; When: every frame after DetectHitSourceCollisions, main loop only.
; Sees: the player takes damage or picks up items and drops.
; Why: monsters hurt by touch, pickups work by touch.
; In: none; skipped while contact_lock ($042D) is non-zero or the player is dying.
; Out: hurt box x from x + 5 to x + 12, y from y - 12 to y - 4; scans the draw list for actors without any of $25C0 that overlap and calls ApplyContactDamageOrPickup until it returns carry clear; while the player is stunned ($16 bit $0800) only pickups ($16 bit $4000) are tested.
; Clobbers: A, X, Y; dp$16, dp$18, dp$1A, dp$1C; P restored.

DetectPlayerContact {
    PHP 
    REP #$30
    LDA $contact_lock     ; contact_lock non-zero: no player contact this frame
    BNE loc_000E5F
    LDY $player_actor
    LDA $0000, Y
    CLC 
    ADC #$0005
    STA $16               ; Player hurt box: dp$16, dp$1A = x + 5, x + 12; dp$18, dp$1C = y - 12, y - 4
    CLC 
    ADC #$0007
    STA $1A
    LDA $0002, Y
    SEC 
    SBC #$0004
    STA $1C
    SEC 
    SBC #$0008
    STA $18
    LDA $0016, Y
    BIT #$0400
    BNE loc_000E5F
    BIT #$0800            ; Player in hit stun: only pickups are tested (ScanContactPickups)
    BNE ScanContactPickups
    LDY #$0000

; Next actor of the draw list for the contact scan; 0 ends. Actors with $25C0 are skipped.

  NextContactCandidate:
    LDX $draw_list, Y
    BEQ loc_000E5F
    INY 
    INY 
    LDA $0016, X
    BIT #$25C0            ; Skip actors with $25C0 (hidden, dying, $0100, hit source, $0040)
    BNE NextContactCandidate
    LDA $0000, X
    CMP $1A
    BCS NextContactCandidate
    CLC 
    ADC $0010, X
    CMP $16
    BCC NextContactCandidate
    LDA $0002, X
    CMP $18
    BCC NextContactCandidate
    SEC 
    SBC $0012, X
    CMP $1C
    BCS NextContactCandidate
    JSR $&ApplyContactDamageOrPickup
    BCS NextContactCandidate ; Carry clear = damage applied, stop. Carry set (pickup, or nothing) keeps scanning

  loc_000E5F:
    PLP 
    RTL 

; Contact scan while the player is stunned: same box test, but only actors with $16 bit $4000 (pickups) count.

  ScanContactPickups:
    LDY #$0000

  loc_000E64:
    LDX $draw_list, Y
    BEQ loc_000E9B
    INY 
    INY 
    LDA $0016, X
    BIT #$25C0
    BNE loc_000E64
    BIT #$4000
    BEQ loc_000E64
    LDA $0000, X
    CMP $1A
    BCS loc_000E64
    CLC 
    ADC $0010, X
    CMP $16
    BCC loc_000E64
    LDA $0002, X
    CMP $18
    BCC loc_000E64
    SEC 
    SBC $0012, X
    CMP $1C
    BCS loc_000E64
    JSR $&ApplyContactDamageOrPickup
    BCS loc_000E64

  loc_000E9B:
    PLP 
    RTL 
}

---------------------------------------------
; A touching actor either gives its pickup or hurts the player.
; 
; When: DetectPlayerContact finds an overlapping actor.
; Sees: items and drops are collected, or the player loses HP, flashes and is briefly invulnerable.
; Why: all contact rules and armor effects are in one place (rules in the block note).
; In: X = touching actor.
; Out: pickups ($16 bit $4000): ApplyGemPickup, carry set so the scan goes on. Otherwise damage = max(1, attack - 1 - $1B8E), halved with the Shield or Super Bracelet; Light Armor may block (sound $0C); player_hp reduced (floor 0), HUD bit $0004, player $26 = $FFC0 (Mystic Armor) or $FFE0, sound $04, stun flag. Carry clear.
; Clobbers: A, X, Y.

ApplyContactDamageOrPickup {
    LDA $0016, X
    BIT #$4000            ; Pickup actor ($16 bit $4000): handled by ApplyGemPickup, carry set
    BNE loc_000F22
    LDA $equipped_armor   ; equipped_armor: $0E (Light Armor) blocks the hit when monster attack x 1.5 is below defense_current (sound $0C)
    CMP #$000E
    BNE loc_000EC3
    SEP #$20
    LDY $0038, X
    LDA $&WorldMetaPointers, Y
    LSR 
    CLC 
    ADC $&WorldMetaPointers, Y
    CMP $defense_current
    BCS loc_000EC3
    BRK #$0C
    BRA loc_000F20

  loc_000EC3:
    SEP #$20
    LDY $0038, X
    LDA $&WorldMetaPointers, Y
    DEC                   ; damage = attack (meta entry +0) - 1 - defense_current ($1B8E), at least 0 here
    SEC 
    SBC $defense_current
    BCS loc_000ED4
    LDA #$00

  loc_000ED4:
    STA $00
    LDA $equipped_bracelet ; Bracelet $1B64: $37 (Super) or $36 (Shield) halves the damage
    CMP #$37
    BEQ loc_000EE1
    CMP #$36
    BNE loc_000EE3

  loc_000EE1:
    LSR $00

  loc_000EE3:
    LDA $00
    BNE loc_000EE8        ; Minimum damage 1
    INC 

  loc_000EE8:
    PHA 
    LDA $player_hp
    SEC 
    SBC $01, S
    BPL loc_000EF3
    LDA #$00

  loc_000EF3:
    STA $player_hp
    PLA 
    REP #$20
    LDA #$0004
    TSB $hud_dirty_flags
    LDX $player_actor
    LDA $equipped_armor
    CMP #$000D            ; Mystic Armor ($1B60 = $0D): stun counter -64 instead of -32 (longer invulnerability)
    BNE loc_000F0F
    LDA #$FFC0
    BRA loc_000F12

  loc_000F0F:
    LDA #$FFE0

  loc_000F12:
    STA $0026, X
    BRK #$04              ; Sound $04: the player is hurt
    LDA $0016, X
    ORA #$0800
    STA $0016, X

  loc_000F20:
    CLC 
    RTS 

  loc_000F22:
    JSL $@engine_spawn_lairs_death_drops.ApplyGemPickup
    SEC 
    RTS 
}