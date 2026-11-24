; The hero's blade layer, soul orb, magic and level-up: RunWeaponLayer, RunSoulOrb and RunSoulOrbController, the spell gate DispatchSpellCast, the seven spells with their child actors, EndSpellActor and the level-up watcher with its 'LEVEL UP !' blink (file offsets 8143-9848, 9959-9971 and 12118-12293, SNES $00:9FCF-$A678, $00:A6E7-$A6F3 and $00:AF56-$B005, bank 00; the four Phoenix projectiles between them belong to player_core). All of it is spawned by InitPlayerActor.
; 
; === BLADE LAYER AND SOUL ORB ===
; RunWeaponLayer is a clone of the player with $16 and $CEFF (visible, no tile collision, not-a-hit-source bit cleared) and the animation bank $0B changed to $0C, so it plays the blade sprites of WeaponOverlayAnims while the body plays PlayerAnims. FinishPlayerMove puts it on the player every frame.
; RunSoulOrb stays hidden ($16 bit $2000) while return_active is set or souls_flags is 0, then shows the orb: the walkthrough says the Soul of Magician 'also ends up being the little orb of light surrounding you'. It spawns RunSoulOrbController, which moves an invisible steering point and writes the orb's position every frame: the d-pad moves the point 2 px per frame per axis whether or not the hero can move, a pull toward the hero adds 1 px (2 px at 80 px or more distance to the right or below, 96 px to the left, 64 px above), and the orb sits on a circle of radius 31 px around the point (the sine tables SineTable and SineTableTail, index soul_orbit_phase x 2 mod 256, sample / 4, so 128 phases per turn at one phase per frame). The orb can be parked in front of enemies; spells start at the orb. The walkthrough: a soul reveals hidden passages in King Magridd's Castle 'as your orb of light circles over them'.
; 
; === SPELLS ===
; DispatchSpellCast is called by the controller every frame. With no spell alive and Y pressed, equipped_magic - $11 picks the arm; each arm pays with COP 26 (BCD Gems, halved by Magic Armor, zero with the Magic Bell; too poor: nothing is cast), increments spell_active_count and spawns the cast actor with COP 85.
; equipped_magic: spell (ROM text and walkthrough magic.md agree), Gems, cast actor, damage byte $30 of the projectile (ApplyProjectileHit reads it):
; $11 Flame Ball, 4 Gems, RunFlameBall, 5. $12 Light Arrow, 8, RunLightArrow (four arrows), 10 each. $13 Magic Flair, 8, RunMagicFlair, 20. $14 Rotator, 1 per burst, RunRotator, 5 per burst. $15 Spark Bomb, 8, RunSparkBombSpawner (four bombs), 30 each. $16 Flame Pillar, 20, RunFlamePillarSpawner (four pillars), 6. $17 Tornado, 8, RunTornado, 15. $18 Phoenix, 2, not here: the sword swings cast it (PayPhoenixCost).
; Every cast actor copies the orb's position at its first run and plays animations of bank $0F (COP A8 #$8000, #$0F = MagicAnims); the movement is in the animation steps (velocity words per step), not in the scripts. $16 values: $03A0 = harmless while it forms (projectile $0020, not a hit target $0200, not yet a hit source $0100), $02A0 = armed (bit $0100 cleared), $2020 = hidden projectile of a spawner, $0010 added = runs in sub-frames. The Flame Ball goes in the facing direction (PlayerFacingByAnim; the opposite directions use the flip commands COP 96 and 98), the Light Arrow in all four, Magic Flair is charged by holding Y (tap plus three levels: animations $0D/$10, $0E/$11, $0E/$12, $0E/$13), the Rotator releases a burst every 5 frames while Y is held, the Spark Bomb and Flame Pillar spawners drop four actors about 18 frames apart, and the Tornado wanders in a four-state heading graph (see RunTornado).
; 
; === THE CAST LOCK ===
; spell_active_count counts the live spell actors and is tested first by the gate, so no spell at all can be cast while one lives (the walkthrough only says one Tornado is allowed: OQ-I032-7). The Flame Ball, Light Arrow, Magic Flair and Rotator actors end through EndSpellActor, which clears the count and consumes the Y press (TRB $4000 of joy_release_latch: a held Y does not cast again); the Flame Ball clears the count already at the launch. The Spark Bomb, Flame Pillar and Tornado parents reset the count to 0 and let their children INC / DEC it; the last one to end consumes the press. The gate also refuses when the free actor stack ($4A) is empty.
; 
; === LEVEL UP ===
; WatchForLevelUp loads the EXP needed for the next level from LevelExpThresholds[player_level x 4] (two big-endian BCD words, the first one is the high word) and compares it with player_exp as a 32-bit subtract. At 50 it ends. On a level: max HP and HP + 2 capped at 100, COP 37 refills the bar over time, player_level and player_level_bcd + 1, the new level's low bit chooses level_defense (odd) or level_power (even) + 1, the HUD is marked dirty, BRK #$97, then 'LEVEL UP !' (LevelUpText) is printed three times for 21 frames each with 11 frames of blank (LevelUpClearText) between, and the watcher checks again, so a big EXP gain gives several levels in a row.
; 
; === NOTES ===
; - Walkthrough checks: the seven Gem costs, the four-arrow Light Arrow, the three charge levels of Magic Flair, one Tornado, the Rotator's 1 Gem per burst, the level cap of 50, max HP + 2 per level (8 at level 1, 100 at level 47), strength at even and defense at odd levels, and four EXP table rows (level 1 = 100, level 2 = 280, level 18 = 83,000, level 19 = 115,000) agree with the code. The ROM spells the third spell 'Magic Flair' as the walkthrough does.
; - DISCREPANCY, Spark Bomb: the walkthrough says four bombs at sixty-degree intervals, the fourth 180 degrees from the first; the code spaces them about 18 frames apart at 2 of 256 sine steps per frame, about 51 degrees each (OQ-I032-3).
; - DISCREPANCY, strength and defense: the walkthrough caps the unequipped values at 13 and 12; level_power and level_defense have no cap here, and lib_menus clamps only the display of the level parts to 12 (OQ-I032-8).
; - The Tornado's first heading and every restart use LDA #$0302, an immediate that is always 2 (OQ-I032-6).
---------------------------------------------

?BANK 00

?INCLUDE 'data_engine_tables'
?INCLUDE 'lib_banner_texts'
?INCLUDE 'lib_text_render'

!rng_state                      0301
!joy_pressed                    0322
!joy_release_latch              032A
!hud_dirty_flags                0332
!player_x                       0374
!player_y                       0376
!player_actor                   039C
!soul_orb_actor                 03A0
!subframe_active                03A6
!return_active                  03FB
!soul_orbit_phase               0431
!spell_active_count             0433
!no_combat_scene                0439
!equipped_magic                 1B62
!player_level_bcd               1B6A
!level_power                    1B72
!level_defense                  1B76
!player_exp                     1B78
!player_exp_next                1B7C
!souls_flags                    1B82
!player_level                   1B86
!player_hp                      1B88
!player_max_hp                  1B8A

---------------------------------------------

; The blade layer of the hero: a copy of the player that shows the sword.
; 
; When: spawned once by InitPlayerActor (COP 85, kept in player_weapon_actor), runs every frame after the player.
; Sees: the sword sprite follows the hero through every pose.
; Why: the sword has its own sprite set (WeaponOverlayAnims) apart from the body (PlayerAnims) and is a separate actor for drawing and hit tests.
; In: actor script, X = own slot; starts as a clone of the player.
; Out: $16 and $CEFF (visible, no tile collision, bit $0100 'not a hit source' cleared); $24 + 1 (animation bank $0B becomes $0C); COP 91, then COP 82 steps the animation that PublishPlayerAnim writes into $1E, $20 and $14 of this actor. FinishPlayerMove moves it onto the player every frame.
; Clobbers: A.

RunWeaponLayer {
    LDA $0016, X
    AND #$CEFF            ; clear hidden ($2000), tile collision ($1000) and the not-a-hit-source bit ($0100): the blade is visible and can hurt
    STA $0016, X
    INC $0024, X          ; animation bank $0B becomes $0C: the blade plays WeaponOverlayAnims while the player plays PlayerAnims
    COP [91]
    COP [82]
    RTL 
}

---------------------------------------------
; The visible soul orb: the little orb of light around the hero.
; 
; When: spawned once by InitPlayerActor (kept in soul_orb_actor), runs every frame ($16 bit $0010).
; Sees: nothing until a soul is owned, then a glowing orb circling the hero (walkthrough items.md: the Soul of Magician 'also ends up being the little orb of light surrounding you').
; Why: the orb is a sprite actor; RunSoulOrbController places it every frame.
; In: actor script, X = own slot (a clone of the player with the $16 that InitPlayerActor sets).
; Out: hidden ($16 bit $2000) while return_active or souls_flags = 0; when a soul exists the actor is shown, RunSoulOrbController is spawned (COP 85), and the orb animation 8 of table $0E:8000 (EffectAnims) repeats 16 times, forever. A soul received after the scene started clears the position to map 0,0 first (OQ-I032-4).
; Clobbers: A, Y.

RunSoulOrb {
    LDA $0016, X
    ORA #$2000            ; hidden until the first soul is owned
    STA $0016, X
    LDA $return_active
    BNE SoulOrbStayHidden
    LDA $souls_flags      ; any soul recruited shows the orb: the Soul of Magician is also the little orb of light around the hero
    BEQ SoulOrbWaitForSoul

  SoulOrbShow:
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    COP [85] ( @RunSoulOrbController )
    COP [A8] ( #$8000, #0E ) ; animation table $0E:8000 = EffectAnims (the orb sprites)
    COP [A3]
    COP [A2] ( #30 )

  SoulOrbAnimate:
    COP [81] ( #08, #10 )
    COP [83]
    BRA SoulOrbAnimate

  SoulOrbStayHidden:
    COP [91]
    RTL 

  SoulOrbWaitForSoul:
    COP [91]
    LDA $souls_flags
    BNE SoulOrbAppear
    RTL 

  SoulOrbAppear:
    STZ $0000, X          ; a soul obtained after the scene started: the orb restarts at map position 0,0 (OQ-I032-4)
    STZ $0002, X
    BRA SoulOrbShow
}

---------------------------------------------
; Steers the orb's centre and circles the orb around it.
; 
; When: spawned by RunSoulOrb (COP 85, so it runs right after the orb in the same frame); every frame, also in sub-frames ($16 bit $0010).
; Sees: the d-pad moves the orb around the hero independently of him; it trails behind and circles (walkthrough items.md: a soul reveals hidden passages 'as your orb of light circles over them').
; Why: the orb can be parked in front of enemies, and the spells start at the orb.
; In: actor script, X = own slot (PHX / PLX around the body); reads joy_pressed, player_x, player_y, soul_orbit_phase, SineTable and SineTableTail.
; Out: DispatchSpellCast first (carry set: nothing more this frame). The d-pad moves this actor 2 px per frame per axis; a pull toward the hero adds 1 px, 2 px at 80 px or more distance to the right or below, 96 px to the left and 64 px above; the new centre is stored in $00 and $02. The orb actor (the $3C link) gets the centre + (sine x / 4, cosine y / 4): a circle of radius 31 px, 128 phases per turn.
; Clobbers: A, Y (= the orb), dp$16, dp$18; X restored.

RunSoulOrbController {
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    COP [91]
    PHX 
    JSR $&DispatchSpellCast
    BCC OrbReadDpadX
    BRL OrbControllerExit ; carry set (Flame Ball or Light Arrow forming): neither steering nor orbit this frame

  OrbReadDpadX:
    LDA $joy_pressed      ; the d-pad moves the steering point 2 px per frame per axis, read before FilterPlayerInput and whether or not the hero can move
    LDY #$0002
    BIT #$0100
    BNE OrbReadDpadY
    LDY #$FFFE
    BIT #$0200
    BNE OrbReadDpadY
    LDY #$0000

  OrbReadDpadY:
    STY $16
    LDY #$0002
    BIT #$0400
    BNE OrbPullToPlayerX
    LDY #$FFFE
    BIT #$0800
    BNE OrbPullToPlayerX
    LDY #$0000

  OrbPullToPlayerX:
    STY $18
    LDA $player_x         ; pull toward the hero on x: 1 px, 2 px from 80 px away on the right or 96 px on the left
    SEC 
    SBC $0000, X
    BEQ OrbApplyX
    BPL OrbPlayerRightOfOrb
    EOR #$FFFF
    INC 
    DEC $16
    CMP #$0060
    BCC OrbApplyX
    DEC $16
    BRA OrbApplyX

  OrbPlayerRightOfOrb:
    INC $16
    CMP #$0050
    BCC OrbApplyX
    INC $16

  OrbApplyX:
    LDA $0000, X
    CLC 
    ADC $16
    STA $0000, X
    STA $16
    LDA $player_y         ; pull toward the hero on y: 1 px, 2 px from 80 px below or 64 px above
    SEC 
    SBC $0002, X
    BEQ OrbApplyY
    BPL OrbPlayerBelowOrb
    EOR #$FFFF
    INC 
    DEC $18
    CMP #$0040
    BCC OrbApplyY
    DEC $18
    BRA OrbApplyY

  OrbPlayerBelowOrb:
    INC $18
    CMP #$0050
    BCC OrbApplyY
    INC $18

  OrbApplyY:
    LDA $0002, X
    CLC 
    ADC $18
    STA $0002, X
    STA $18
    LDY $003C, X          ; Y = the orb actor ($3C link; this controller is spawned just before it): it gets the orbit position
    LDA $soul_orbit_phase
    ASL                   ; sine index = phase x 2 mod 256: 128 phases per turn
    AND #$00FF
    TAX 
    SEP #$20
    LDA #$00
    XBA 
    LDA $&data_engine_tables.SineTable, X ; x offset: signed sine byte, divided by 4 below (radius 31 px)
    BPL OrbSineXPositive
    XBA                   ; negative sample: B = $FF, then two arithmetic shifts right (divide by 4, sign kept)
    DEC 
    XBA 
    SEC 
    ROR 
    SEC 
    ROR 
    BRA OrbStoreOrbitX

  OrbSineXPositive:
    LSR 
    LSR 

  OrbStoreOrbitX:
    REP #$20
    CLC 
    ADC $16
    STA $0000, Y
    SEP #$20
    LDA #$00
    XBA 
    LDA $&data_engine_tables.SineTableTail, X ; y offset: the same table a quarter period later (SineTableTail = SineTable + $40)
    BPL OrbSineYPositive
    XBA 
    DEC 
    XBA 
    SEC 
    ROR 
    SEC 
    ROR 
    BRA OrbStoreOrbitY

  OrbSineYPositive:
    LSR 
    LSR 

  OrbStoreOrbitY:
    REP #$20
    CLC 
    ADC $18
    STA $0002, Y

  OrbControllerExit:
    PLX 
    RTL 
}

---------------------------------------------
; The spell gate: casts the equipped spell when Y is pressed and tells the controller whether to skip this frame.
; 
; When: RunSoulOrbController, every frame (JSR; X = the controller slot, so the COP commands inside work).
; Sees: Y casts the equipped spell at the orb and the Gem counter drops; nothing happens in towns, with no magic equipped, with too few Gems or while another spell lives.
; Why: all seven spells share the checks, the one-spell lock and the orbit tick; only the cast arms differ.
; In: X = controller slot. Reads no_combat_scene, subframe_active, equipped_magic, ($4A) (the free slot stack), spell_active_count, joy_pressed.
; Out: refusals, in order: no-combat scene, sub-frame running, no magic equipped, no free actor slot: TickOrbitPhase. A spell alive (spell_active_count != 0): no new cast; Flame Ball and Light Arrow return carry set (the orb freezes while the shot forms), the Rotator adds one extra orbit tick, the others TickOrbitPhase. Otherwise Y pressed: equipped_magic - $11 picks the arm (Flame Ball, Light Arrow, Magic Flair, Rotator, Spark Bomb, Flame Pillar, Tornado; the Phoenix $18 is cast by the sword swing). Every arm except the Rotator pays with COP 26 (too poor: TickOrbitPhase, nothing cast), then increments spell_active_count and spawns its actor with COP 85. Carry is set after Flame Ball and Light Arrow, clear after the others.
; Clobbers: A, Y.

DispatchSpellCast {
    LDA $no_combat_scene
    BNE TickOrbitPhase
    LDA $subframe_active
    BNE TickOrbitPhase
    LDA $equipped_magic
    BEQ TickOrbitPhase
    LDA ($4A)             ; $4A points at the free actor slot stack; zero means no slot is left to spawn a spell actor into
    BEQ TickOrbitPhase
    LDA $spell_active_count ; a spell actor is alive: no new cast (one spell at a time), only the orbit rules below apply
    BEQ CastGateTryCast
    LDA $equipped_magic
    SEC 
    SBC #$0011            ; equipped_magic - $11: 0 Flame Ball, 1 Light Arrow, 2 Magic Flair, 3 Rotator, 4 Spark Bomb, 5 Flame Pillar, 6 Tornado
    BEQ SkipOrbFlameBall
    DEC 
    BEQ SkipOrbLightArrow
    DEC 
    BEQ TickOrbitPhase
    DEC 
    BEQ RotatorBoostPhase ; Rotator alive: one extra orbit tick per frame, so the orb circles twice as fast
    DEC 
    BEQ TickOrbitPhase
    DEC 
    BEQ TickOrbitPhase
    DEC 
    BEQ TickOrbitPhase
    BRL TickOrbitPhase

  CastGateTryCast:
    LDA $joy_pressed
    BIT #$4000            ; Y pressed (a held Y fires once: EndSpellActor clears the latch bit)
    BEQ TickOrbitPhase
    LDA $equipped_magic
    SEC 
    SBC #$0011
    BEQ CastFlameBall
    DEC 
    BEQ CastLightArrow
    DEC 
    BEQ CastMagicFlair
    DEC 
    BEQ CastRotator
    DEC 
    BEQ CastSparkBomb
    DEC 
    BEQ CastFlamePillar
    DEC 
    BEQ CastTornado

; Advances the orbit phase by one and returns carry clear.
; 
; When: the shared exit of DispatchSpellCast (every refusal, every failed payment and most casts), once per frame; 21 references.
; Sees: the orb circles the hero: 128 frames per turn, 64 while the Rotator burns.
; Why: every path ends here, so the orb keeps circling whatever the gate did.
; In: nothing (reached by JSR or by branch inside DispatchSpellCast).
; Out: soul_orbit_phase + 1, carry clear.
; Clobbers: none besides the carry.

  TickOrbitPhase:
    INC $soul_orbit_phase
    CLC 
    RTS 

  CastFlameBall:
    COP [26] ( #$0004, &TickOrbitPhase ) ; cost 4 Gems (BCD; Magic Armor halves, Magic Bell makes it 0); too poor: orbit tick only
    INC $spell_active_count
    COP [85] ( @RunFlameBall )

  SkipOrbFlameBall:
    SEC 
    RTS 

  CastLightArrow:
    COP [26] ( #$0008, &TickOrbitPhase ) ; cost 8 Gems
    INC $spell_active_count
    COP [85] ( @RunLightArrow )

  SkipOrbLightArrow:
    SEC 
    RTS 

  CastMagicFlair:
    COP [26] ( #$0008, &TickOrbitPhase ) ; cost 8 Gems
    INC $spell_active_count
    COP [85] ( @RunMagicFlair )
    BRA TickOrbitPhase

  CastRotator:
    INC $spell_active_count
    COP [85] ( @RunRotator )

  RotatorBoostPhase:
    INC $soul_orbit_phase
    BRA TickOrbitPhase

  CastSparkBomb:
    COP [26] ( #$0008, &TickOrbitPhase ) ; cost 8 Gems
    INC $spell_active_count
    COP [85] ( @RunSparkBombSpawner )
    BRA TickOrbitPhase

  CastFlamePillar:
    COP [26] ( #$0020, &TickOrbitPhase ) ; cost $20 = 20 Gems (BCD)
    INC $spell_active_count
    COP [85] ( @RunFlamePillarSpawner )
    BRA TickOrbitPhase

  CastTornado:
    COP [26] ( #$0008, &TickOrbitPhase ) ; cost 8 Gems
    INC $spell_active_count
    COP [85] ( @RunTornado )
    BRA TickOrbitPhase
}

---------------------------------------------
; The Flame Ball: one fireball launched from the orb in the direction the hero faces.
; 
; When: spawned by CastFlameBall (COP 85) when Y is pressed with the Flame Ball equipped and 4 Gems are paid.
; Sees: a fireball leaves the orb in the facing direction (walkthrough magic.md: 'The direction of the fireball is determined by your facing').
; Why: one actor plays the launch and the flight; the speed is in the animation steps.
; In: actor script, X = own slot.
; Out: $16 = $03A0 (harmless while it forms), position copied from the orb, damage $30 = 5, launch animation $00 with BRK #$1B, $16 = $02A0 (armed). Direction by PlayerFacingByAnim[player animation]: up = animation 2 flipped in Y (COP 98), down = animation 2, right = animation 1 flipped in X (COP 96), left = animation 1; 8 passes ($2A = 8). The Y press is consumed and spell_active_count cleared at the launch, then COP 91, COP 83 (the flight) and COP 86.
; Clobbers: A, Y.

RunFlameBall {
    LDA #$03A0
    STA $0016, X
    LDA #$0005
    STA $0030, X
    LDY $soul_orb_actor
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    COP [A3]
    COP [A2] ( #30 )
    COP [A8] ( #$8000, #0F )
    COP [80] ( #00 )
    COP [82]
    BRK #$1B
    LDA #$02A0
    STA $0016, X
    LDY $player_actor
    LDA $001E, Y
    TAY 
    LDA $&data_engine_tables.PlayerFacingByAnim, Y ; facing of the player's animation: 0 up, 1 down, 2 right, 3 left
    AND #$00FF
    BEQ FlameBallUp
    DEC 
    BEQ FlameBallDown
    DEC 
    BEQ FlameBallRight
    BRA FlameBallLeft

  FlameBallUp:
    COP [98]              ; up: animation 2 flipped in Y; down plays it unflipped

  FlameBallDown:
    LDA #$0002
    BRA FlameBallLaunch

  FlameBallRight:
    COP [96]              ; right: animation 1 flipped in X; left plays it unflipped

  FlameBallLeft:
    LDA #$0001

  FlameBallLaunch:
    STA $001E, X
    STZ $0020, X
    LDA #$0008            ; 8 passes of the flight animation; the speed (4 px per frame) is in its steps
    STA $002A, X
    LDA #$4000
    TRB $joy_release_latch ; consume the Y press: a held Y does not cast again
    STZ $spell_active_count ; the Flame Ball releases the cast lock at the launch: the next cast is allowed while it flies
    COP [91]
    COP [83]
    COP [86]
    RTL 
}

---------------------------------------------
; The Light Arrow: four arrows leave the orb, north, south, west and east.
; 
; When: spawned by CastLightArrow (COP 85) after 8 Gems are paid.
; Sees: four arrows of light fly due north, east, south and west (walkthrough magic.md).
; Why: one actor plays the launch and spawns the four arrows; each arrow is its own damaging actor.
; In: actor script.
; Out: $16 = $03A0, position copied from the orb, launch animation $03 with BRK #$12; four COP B2 spawns with flags $02A0 at offsets (0, -8), (0, +8), (-8, 0) and (+8, 0): RunLightArrowUp, RunLightArrowDown, RunLightArrowLeft, RunLightArrowRight; animation $04, then EndSpellActor.
; Clobbers: A, Y.

RunLightArrow {
    LDA #$03A0
    STA $0016, X
    LDY $soul_orb_actor
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    COP [A3]
    COP [A2] ( #30 )
    COP [A8] ( #$8000, #0F )
    COP [80] ( #03 )
    COP [82]
    BRK #$12
    COP [B2] ( @RunLightArrowUp, #$0000, #$FFF8, #$02A0 ) ; four COP B2 spawns: offset (dx, dy) from the orb and flags $02A0; this one flies north
    COP [B2] ( @RunLightArrowDown, #$0000, #$0008, #$02A0 )
    COP [B2] ( @RunLightArrowLeft, #$FFF8, #$0000, #$02A0 )
    COP [B2] ( @RunLightArrowRight, #$0008, #$0000, #$02A0 )
    COP [80] ( #04 )
    COP [82]
    BRL EndSpellActor
}

---------------------------------------------
; The north arrow of the Light Arrow.
; 
; When: spawned by RunLightArrow at (0, -8) from the orb with $16 = $02A0.
; Sees: an arrow of light flying up.
; Why: each direction is its own actor with its own animation; the speed is in the animation steps.
; In: actor script.
; Out: damage $30 = $0A, flip Y (COP 98), animation $07 then $08 eight times, then COP 86 at LightArrowEnd.
; Clobbers: A.

RunLightArrowUp {
    LDA #$000A
    STA $0030, X
    COP [98]
    COP [80] ( #07 )
    COP [82]
    COP [81] ( #08, #08 )
    COP [83]
    BRA LightArrowEnd
}

---------------------------------------------
; The south arrow of the Light Arrow.
; 
; When: spawned by RunLightArrow at (0, +8) from the orb with $16 = $02A0.
; Sees: an arrow of light flying down.
; Why: see RunLightArrowUp.
; In: actor script.
; Out: damage $30 = $0A, animation $07 then $08 eight times, then COP 86 at LightArrowEnd.
; Clobbers: A.

RunLightArrowDown {
    LDA #$000A
    STA $0030, X
    COP [80] ( #07 )
    COP [82]
    COP [81] ( #08, #08 )
    COP [83]
    BRA LightArrowEnd
}

---------------------------------------------
; The west arrow of the Light Arrow.
; 
; When: spawned by RunLightArrow at (-8, 0) from the orb with $16 = $02A0.
; Sees: an arrow of light flying left.
; Why: see RunLightArrowUp.
; In: actor script.
; Out: damage $30 = $0A, animation $05 then $06 eight times, then COP 86 at LightArrowEnd.
; Clobbers: A.

RunLightArrowLeft {
    LDA #$000A
    STA $0030, X
    COP [80] ( #05 )
    COP [82]
    COP [81] ( #06, #08 )
    COP [83]
    BRA LightArrowEnd
}

---------------------------------------------
; The east arrow of the Light Arrow.
; 
; When: spawned by RunLightArrow at (+8, 0) from the orb with $16 = $02A0.
; Sees: an arrow of light flying right.
; Why: see RunLightArrowUp.
; In: actor script.
; Out: damage $30 = $0A, flip X (COP 96), animation $05 then $06 eight times, then COP 86 at LightArrowEnd (shared by the four arrows).
; Clobbers: A.

RunLightArrowRight {
    LDA #$000A
    STA $0030, X
    COP [96]
    COP [80] ( #05 )
    COP [82]
    COP [81] ( #06, #08 )
    COP [83]

  LightArrowEnd:
    COP [86]
    RTL 
}

---------------------------------------------
; Magic Flair: hold Y to charge, release to burst around the orb.
; 
; When: spawned by CastMagicFlair (COP 85) after 8 Gems are paid.
; Sees: a charging glow on the orb while Y is held; on release an explosion around the orb, the larger the longer Y was held: a tap and three charge levels (walkthrough magic.md: 'There are three levels of charge').
; Why: one actor plays the charge and the burst; TrackOrbWhileCharging keeps it on the orb.
; In: actor script.
; Out: $16 = $03A0, damage $30 = $14 (the same for every size, OQ-I032-5), TrackOrbWhileCharging spawned; charge animations $09, $0A, $0B (5 passes each), then $0C looping while Y is held. At the first check where Y is no longer held: $16 = $02A0 and the burst of that level: tap $0D x3 then $10, charge 1 $0E x3 then $11, charge 2 $0E x3 then $12, full $0E x3 then $13, BRK #$21 at the burst; then EndSpellActor.
; Clobbers: A, Y.

RunMagicFlair {
    LDA #$03A0
    STA $0016, X
    LDA #$0014
    STA $0030, X          ; damage $14 = 20 for every charge level; only the burst animation grows (OQ-I032-5)
    COP [85] ( @TrackOrbWhileCharging )
    COP [A3]
    COP [A2] ( #30 )
    COP [A8] ( #$8000, #0F )
    COP [03] ( #05 )
    COP [80] ( #09 )
    COP [82]
    LDA $joy_pressed
    BIT #$4000
    BEQ FlairReleaseTap
    COP [04]
    COP [03] ( #05 )
    COP [80] ( #0A )
    COP [82]
    LDA $joy_pressed
    BIT #$4000
    BEQ FlairReleaseCharge1
    COP [04]
    COP [03] ( #05 )
    COP [80] ( #0B )
    COP [82]
    LDA $joy_pressed
    BIT #$4000
    BEQ FlairReleaseCharge2
    COP [04]

  FlairFullChargeLoop:
    COP [80] ( #0C )
    COP [82]
    LDA $joy_pressed
    BIT #$4000
    BEQ FlairReleaseFull
    BRA FlairFullChargeLoop

  FlairReleaseTap:
    LDA #$02A0
    STA $0016, X
    COP [A3]
    COP [81] ( #0D, #03 )
    COP [83]
    BRK #$21
    COP [80] ( #10 )
    COP [82]
    BRL EndSpellActor

  FlairReleaseCharge1:
    LDA #$02A0
    STA $0016, X
    COP [A3]
    COP [81] ( #0E, #03 )
    COP [83]
    BRK #$21
    COP [80] ( #11 )
    COP [82]
    BRL EndSpellActor

  FlairReleaseCharge2:
    LDA #$02A0
    STA $0016, X
    COP [A3]
    COP [81] ( #0E, #03 )
    COP [83]
    BRK #$21
    COP [80] ( #12 )
    COP [82]
    BRL EndSpellActor

  FlairReleaseFull:
    LDA #$02A0
    STA $0016, X
    COP [A3]
    COP [81] ( #0E, #03 )
    COP [83]
    BRK #$21
    COP [80] ( #13 )
    COP [82]
    BRL EndSpellActor
}

---------------------------------------------
; Keeps the charging Magic Flair on the orb while Y is held.
; 
; When: spawned by RunMagicFlair (COP 85, so the $3C link of this actor is RunMagicFlair); every frame ($16 bit $0010).
; Sees: the charge glow follows the orb; the burst stays where Y was released.
; Why: RunMagicFlair only plays animations; this helper moves it.
; In: actor script, X = own slot (PHX / PLX).
; Out: Y held: the parent ($3C link) gets the position of the orb actor (soul_orb_actor). Y released: COP 86.
; Clobbers: A, Y.

TrackOrbWhileCharging {
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    COP [91]
    LDA $joy_pressed
    BIT #$4000
    BEQ FlairFollowerEnd
    PHX 
    LDY $soul_orb_actor
    LDA $003C, X          ; the $3C link is RunMagicFlair, which spawned this follower
    TAX 
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    PLX 
    RTL 

  FlairFollowerEnd:
    COP [86]
    RTL 
}

---------------------------------------------
; Rotator: while Y is held, a burst of light is released at the orb every 5 frames.
; 
; When: spawned by CastRotator (COP 85); no Gems are paid yet (the payment is in RepeatRotatorBurst).
; Sees: walkthrough magic.md: 'Just press the Y Button to release a bit of light behind the orb of light around the character; holding down Y will make this constant and a rapid loss of Gems'.
; Why: the parent is invisible and only repeats the payment and the burst spawn.
; In: actor script.
; Out: $16 = $2020 (hidden projectile), then it falls into RepeatRotatorBurst. While the Rotator lives the gate adds one extra orbit tick per frame, so the orb circles twice as fast.
; Clobbers: A.

RunRotator {
    LDA #$2020
    STA $0016, X

; One Rotator burst per pass while Y is held.
; 
; When: first from RunRotator, then every 5 frames through its own COP 1B.
; Sees: a burst per 5 frames, each costing 1 Gem.
; Why: the loop lives in the delay operand (COP 1B resumes here).
; In: the Rotator parent.
; Out: Y not held: EndSpellActor. Y held: COP 26 pays 1 Gem (too poor: EndSpellActor), COP B0 spawns RunRotatorBurst with flags $02B0, COP 1B waits 4 frames (plus one) and returns here.
; Clobbers: A.

  RepeatRotatorBurst:
    LDA $joy_pressed
    BIT #$4000
    BNE RotatorFireBurst
    BRL EndSpellActor

  RotatorFireBurst:
    COP [26] ( #$0001, &EndSpellActor ) ; 1 Gem per burst; too poor: end the Rotator
    COP [B0] ( @RunRotatorBurst, #$02B0 )
    COP [1B] ( &RepeatRotatorBurst, #$0004 ) ; wait 4 frames (plus one), then come back for the next burst
}

---------------------------------------------
; One burst of the Rotator at the orb.
; 
; When: spawned by RepeatRotatorBurst (COP B0).
; Sees: a puff of light at the orb.
; Why: each burst is its own short-lived damaging actor.
; In: actor script, spawned with $16 = $02B0.
; Out: position copied from the orb, damage $30 = 5, BRK #$24, animations $14, $15, $16 and $17 one step each, then COP 86.
; Clobbers: A, Y.

RunRotatorBurst {
    LDY $soul_orb_actor
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    LDA #$0005
    STA $0030, X
    COP [A3]
    COP [A2] ( #30 )
    COP [A8] ( #$8000, #0F )
    BRK #$24
    COP [80] ( #14 )
    COP [82]
    COP [80] ( #15 )
    COP [82]
    COP [80] ( #16 )
    COP [82]
    COP [80] ( #17 )
    COP [82]
    COP [86]
    RTL 
}

---------------------------------------------
; Drops four Spark Bombs, one after another, at the orb.
; 
; When: spawned by CastSparkBomb (COP 85) after 8 Gems are paid.
; Sees: four bombs laid along the orb's circle (walkthrough magic.md: 'four bombs in a semicircle ... intervals of sixty degrees ... 180 degrees', OQ-I032-3: the code gives about 51 degrees per bomb).
; Why: the spawner is invisible; each bomb is its own actor and holds the cast lock while it lives.
; In: actor script.
; Out: $16 = $2020 (hidden projectile), spell_active_count = 0 (each bomb increments it), COP 03 loop of 4: COP B0 spawns RunSparkBomb (flags $03A0), COP 1B waits 16 frames (plus one, plus one for COP 04: about 18) and resumes at RepeatSparkBombSpawn.
; Clobbers: A.

RunSparkBombSpawner {
    LDA #$2020
    STA $0016, X
    STZ $spell_active_count ; the spawner does not hold the lock: each bomb increments the count while it lives
    COP [03] ( #04 )
    COP [B0] ( @RunSparkBomb, #$03A0 )
    COP [1B] ( &RepeatSparkBombSpawn, #$0010 ) ; about 18 frames between bombs, the orb moves 36 of 256 sine steps meanwhile (OQ-I032-3)
}

---------------------------------------------
; Loop end of the Spark Bomb spawner.
; 
; When: 18 frames after each bomb was spawned (COP 1B of RunSparkBombSpawner).
; Sees: the next bomb, or nothing after the fourth.
; Why: COP 04 counts the four passes.
; In: the spawner, loop counter $2E.
; Out: COP 04 repeats the spawn; after the fourth pass COP 86 ends the spawner.
; Clobbers: A.

RepeatSparkBombSpawn {
    COP [04]
    COP [86]
    RTL 
}

---------------------------------------------
; One Spark Bomb: it appears at the orb, ticks and explodes.
; 
; When: spawned by RunSparkBombSpawner (COP B0, flags $03A0).
; Sees: a bomb appears where the orb is, shows two tick animations (four passes each) and explodes.
; Why: harmless while it ticks ($03A0), armed for the explosion ($02A0).
; In: actor script.
; Out: spell_active_count + 1, damage $30 = $1E, position copied from the orb, COP A4 (drawn behind), animations $18 x4 and $19 x4, then $16 = $02A0, BRK #$21, animation $1A (the explosion), spell_active_count - 1; the last bomb alive also consumes the Y press (TRB $4000 of joy_release_latch); COP 86.
; Clobbers: A, Y.

RunSparkBomb {
    INC $spell_active_count
    LDA #$001E
    STA $0030, X
    LDY $soul_orb_actor
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    COP [A4]
    COP [A8] ( #$8000, #0F )
    COP [81] ( #18, #04 )
    COP [83]
    COP [81] ( #19, #04 )
    COP [83]
    LDA #$02A0
    STA $0016, X
    BRK #$21
    COP [80] ( #1A )
    COP [82]
    DEC $spell_active_count ; the last bomb alive releases the lock and consumes the Y press
    BNE SparkBombEnd
    LDA #$4000
    TRB $joy_release_latch

  SparkBombEnd:
    COP [86]
    RTL 
}

---------------------------------------------
; Drops four Flame Pillars, one after another, at the orb.
; 
; When: spawned by CastFlamePillar (COP 85) after 20 Gems ($20 in BCD) are paid.
; Sees: four fire pillars along the orb's circle (walkthrough magic.md: 'basically the Spark Bomb spell ... fire pillars').
; Why: the same spawner pattern as the Spark Bomb.
; In: actor script.
; Out: $16 = $2020 (hidden projectile), spell_active_count = 0, COP 03 loop of 4: COP B0 spawns RunFlamePillar (flags $02A0), COP 1B waits 16 frames and resumes at RepeatFlamePillarSpawn.
; Clobbers: A.

RunFlamePillarSpawner {
    LDA #$2020
    STA $0016, X
    STZ $spell_active_count
    COP [03] ( #04 )
    COP [B0] ( @RunFlamePillar, #$02A0 )
    COP [1B] ( &RepeatFlamePillarSpawn, #$0010 )
}

---------------------------------------------
; Loop end of the Flame Pillar spawner.
; 
; When: after each pillar was spawned (COP 1B of RunFlamePillarSpawner).
; Sees: the next pillar, or nothing after the fourth.
; Why: COP 04 counts the four passes.
; In: the spawner, loop counter $2E.
; Out: COP 04 repeats the spawn; after the fourth pass COP 86 ends the spawner.
; Clobbers: A.

RepeatFlamePillarSpawn {
    COP [04]
    COP [86]
    RTL 
}

---------------------------------------------
; One Flame Pillar: it rises at the orb, burns and sinks.
; 
; When: spawned by RunFlamePillarSpawner (COP B0, flags $02A0).
; Sees: a pillar of fire that damages any enemy that touches it (walkthrough magic.md: lasts 5 to 8 seconds, OQ-I032-13).
; Why: it is armed for its whole life, so it needs no unarmed phase.
; In: actor script.
; Out: spell_active_count + 1, damage $30 = 6, position copied from the orb, BRK #$0B, animation $1C (rise), animation $1B repeated $14 times (burn), animation $1D (sink), spell_active_count - 1; the last pillar alive also consumes the Y press; COP 86.
; Clobbers: A, Y.

RunFlamePillar {
    INC $spell_active_count
    LDA #$0006
    STA $0030, X
    LDY $soul_orb_actor
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    STA $0002, X
    COP [A8] ( #$8000, #0F )
    BRK #$0B
    COP [80] ( #1C )
    COP [82]
    COP [81] ( #1B, #14 )
    COP [83]
    COP [80] ( #1D )
    COP [82]
    DEC $spell_active_count ; the last pillar alive releases the lock and consumes the Y press
    BNE FlamePillarEnd
    LDA #$4000
    TRB $joy_release_latch

  FlamePillarEnd:
    COP [86]
    RTL 
}

---------------------------------------------
; The Tornado: a wandering tornado that cannot be steered, one at a time.
; 
; When: spawned by CastTornado (COP 85) after 8 Gems are paid.
; Sees: a tornado appears above the orb, grows, then drifts diagonally in random arcs until its time runs out or it leaves the screen (walkthrough magic.md: 'a randomly-moving tornado that cannot be controlled; only one is allowed on-screen at a time').
; Why: the movement is a random walk over four diagonal headings, each step an animation whose steps carry the velocity.
; In: actor script.
; Out: $16 = $02A0, RunTornadoBody spawned (COP 85), position = the orb 16 px higher, animation $24 x4 (grow), BRK #$16, animation $25, damage $30 = $0F, countdown $2E = 60. The wander is a graph of four states, TornadoStateUpRight, TornadoStateDownRight, TornadoStateDownLeft and TornadoStateUpLeft: each visit uses one count of $2E and rolls rng_state+1 and 3: 0 keeps the heading (straight diagonal animation $28, $29, $1E or $1F), 1 and 2 turn to a neighbouring heading with one of eight arc animations ($20-$23, $2A-$2D), 3 restarts at TornadoPickHeading (pause animation $27, then a new heading). It ends when $2E reaches 0 or the actor leaves the screen ($16 bit $8000): TornadoVanish (animation $26 x2), Y press consumed, spell_active_count = 0, COP 86. The first heading and every restart use LDA #$0302, an immediate that is always 2: always down-left (OQ-I032-6).
; Clobbers: A, Y.

RunTornado {
    LDA #$02A0
    STA $0016, X
    COP [85] ( @RunTornadoBody )
    LDY $soul_orb_actor
    LDA $0000, Y
    STA $0000, X
    LDA $0002, Y
    SEC 
    SBC #$0010            ; starts 16 px above the orb
    STA $0002, X
    COP [A8] ( #$8000, #0F )
    COP [A2] ( #30 )
    COP [81] ( #24, #04 )
    COP [83]
    BRK #$16
    COP [80] ( #25 )
    COP [82]
    LDA #$000F
    STA $0030, X
    COP [03] ( #3C )      ; countdown $2E = 60: every visit of a heading state uses one count, at 0 the tornado vanishes

  TornadoPickHeading:
    COP [80] ( #27 )
    COP [82]
    COP [1F]
    LDA #$0302            ; an immediate, always 2: the first heading and every restart go down-left; the other rolls read rng_state+1 (OQ-I032-6)
    AND #$0003
    BNE TornadoPickTestOne
    BRL TornadoStateUpRight

  TornadoPickTestOne:
    DEC 
    BNE TornadoPickTestTwo
    BRL TornadoStateDownRight

  TornadoPickTestTwo:
    DEC 
    BNE TornadoPickUpLeft
    BRL TornadoStateDownLeft

  TornadoPickUpLeft:
    BRL TornadoStateUpLeft

  TornadoKeepUpRight:
    COP [80] ( #28 )
    COP [82]
    BRA TornadoStateUpRight

  TornadoKeepUpLeft:
    COP [80] ( #1F )
    COP [82]
    BRL TornadoStateUpLeft

  TornadoKeepDownLeft:
    COP [80] ( #1E )
    COP [82]
    BRL TornadoStateDownLeft

  TornadoKeepDownRight:
    COP [80] ( #29 )
    COP [82]
    BRA TornadoStateDownRight

  TornadoTurnDownRightToUpRight:
    COP [80] ( #2B )
    COP [82]
    BRA TornadoStateUpRight

  TornadoTurnUpRightToUpLeft:
    COP [80] ( #2D )
    COP [82]
    BRL TornadoStateUpLeft

  TornadoTurnUpLeftToDownLeft:
    COP [80] ( #20 )
    COP [82]
    BRA TornadoStateDownLeft

  TornadoTurnDownLeftToDownRight:
    COP [80] ( #22 )
    COP [82]
    BRA TornadoStateDownRight

  TornadoTurnDownLeftToUpLeft:
    COP [80] ( #21 )
    COP [82]
    BRL TornadoStateUpLeft

  TornadoTurnUpLeftToUpRight:
    COP [80] ( #23 )
    COP [82]
    BRA TornadoStateUpRight

  TornadoTurnUpRightToDownRight:
    COP [80] ( #2A )
    COP [82]
    BRA TornadoStateDownRight

  TornadoTurnDownRightToDownLeft:
    COP [80] ( #2C )
    COP [82]
    BRA TornadoStateDownLeft

  TornadoStateUpRight:
    DEC $002E, X
    BNE TornadoUpRightCheckScreen
    BRL TornadoVanish

  TornadoUpRightCheckScreen:
    LDA $0016, X
    BIT #$8000            ; off screen: vanish
    BEQ TornadoUpRightRoll
    BRL TornadoVanish

  TornadoUpRightRoll:
    COP [1F]
    LDA $rng_state+1      ; roll 0 keeps the heading, 1 and 2 turn to a neighbouring heading, 3 restarts at TornadoPickHeading
    AND #$0003
    BEQ TornadoKeepUpRight
    DEC 
    BNE TornadoUpRightTestTwo
    BRL TornadoTurnUpRightToUpLeft

  TornadoUpRightTestTwo:
    DEC 
    BNE TornadoUpRightRestart
    BRL TornadoTurnUpRightToDownRight

  TornadoUpRightRestart:
    BRL TornadoPickHeading

  TornadoStateDownRight:
    DEC $002E, X
    BEQ TornadoVanish
    LDA $0016, X
    BIT #$8000
    BNE TornadoVanish
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BNE TornadoDownRightTestOne
    BRL TornadoKeepDownRight

  TornadoDownRightTestOne:
    DEC 
    BNE TornadoDownRightTestTwo
    BRL TornadoTurnDownRightToUpRight

  TornadoDownRightTestTwo:
    DEC 
    BNE TornadoDownRightRestart
    BRL TornadoTurnDownRightToDownLeft

  TornadoDownRightRestart:
    BRL TornadoPickHeading

  TornadoStateDownLeft:
    DEC $002E, X
    BEQ TornadoVanish
    LDA $0016, X
    BIT #$8000
    BNE TornadoVanish
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BNE TornadoDownLeftTestOne
    BRL TornadoKeepDownLeft

  TornadoDownLeftTestOne:
    DEC 
    BNE TornadoDownLeftTestTwo
    BRL TornadoTurnDownLeftToDownRight

  TornadoDownLeftTestTwo:
    DEC 
    BNE TornadoDownLeftRestart
    BRL TornadoTurnDownLeftToUpLeft

  TornadoDownLeftRestart:
    BRL TornadoPickHeading

  TornadoStateUpLeft:
    DEC $002E, X
    BEQ TornadoVanish
    LDA $0016, X
    BIT #$8000
    BNE TornadoVanish
    COP [1F]
    LDA $rng_state+1
    AND #$0003
    BNE TornadoUpLeftTestOne
    BRL TornadoKeepUpLeft

  TornadoUpLeftTestOne:
    DEC 
    BNE TornadoUpLeftTestTwo
    BRL TornadoTurnUpLeftToDownLeft

  TornadoUpLeftTestTwo:
    DEC 
    BNE TornadoUpLeftRestart
    BRL TornadoTurnUpLeftToUpRight

  TornadoUpLeftRestart:
    BRL TornadoPickHeading

  TornadoVanish:
    COP [81] ( #26, #02 ) ; vanish animation $26, two passes, then Y press consumed, lock released, end
    COP [83]
    LDA #$4000
    TRB $joy_release_latch
    STZ $spell_active_count
    COP [86]
    RTL 
}

---------------------------------------------
; The visual body of the Tornado.
; 
; When: spawned by RunTornado (COP 85); lives while spell_active_count is non-zero.
; Sees: the tornado sprite (what it draws: OQ-I032-12).
; Why: it runs the second animation system (COP 92 and 94) so it animates independently of the movement animations of RunTornado.
; In: actor script.
; Out: animation table $0D:8000 (PaletteAnimLists), animation $42 started and ticked in a loop while spell_active_count != 0; then COP 86.
; Clobbers: A.

RunTornadoBody {
    COP [A8] ( #$8000, #0D ) ; animation table $0D:8000 = PaletteAnimLists, played with the second animation system (COP 92 and 94)

  TornadoBodyLoop:
    COP [92] ( #42 )
    COP [94]
    LDA $spell_active_count
    BNE TornadoBodyLoop
    COP [86]
    RTL 
}
---------------------------------------------

; Ends a spell actor: consume the Y press, release the cast lock, kill itself.
; 
; When: the Light Arrow after the launch, Magic Flair after the burst and the Rotator when Y is released or the Gems run out (7 references).
; Sees: a held Y does not cast again; the next cast needs Y released and pressed once more.
; Why: one exit for every spell that holds the lock itself.
; In: spell actor, X = its slot.
; Out: bit $4000 of joy_release_latch cleared, spell_active_count = 0, COP 86.
; Clobbers: A.

EndSpellActor {
    LDA #$4000
    TRB $joy_release_latch ; consume the Y press: clearing the latch bit makes a held Y fire only once
    STZ $spell_active_count
    COP [86]
    RTL 
}
---------------------------------------------

; Watches EXP and gives a level when the next threshold is reached.
; 
; When: helper actor spawned by InitPlayerActor (also on a return trip), runs every frame; ends itself at level 50.
; Sees: the level and HP rise, 'LEVEL UP !' blinks three times near the top of the screen and the HP bar refills (walkthrough level-up.md: level cap 50, max HP + 2 per level, strength at even and defense at odd levels).
; Why: the EXP code only adds EXP; the level logic lives in this one actor.
; In: actor script, X = own slot. Reads player_level, LevelExpThresholds, player_exp.
; Out: level 50 or more: StopLevelUpWatcher. Otherwise player_exp_next = LevelExpThresholds[player_level x 4] (two big-endian BCD words, the first is the high word) and a 32-bit subtract of it from player_exp; short: RTL each frame. Reached: player_max_hp + 2 and player_hp + 2, each capped at 100, COP 37 (heal_pending = max HP - HP), player_level + 1, player_level_bcd + 1 in decimal mode, the new level's low bit adds 1 to level_defense (odd) or level_power (even), hud_dirty_flags |= $1F, the next threshold is loaded, BRK #$97, then three times: print 'LEVEL UP !' (LevelUpText), wait 21 frames, erase it (ClearLevelUpText), wait 11 frames; then it checks again, so a big EXP gain gives several levels in a row.
; Clobbers: A, Y; X saved (PHX / PLX) around the text calls.

WatchForLevelUp {
    LDA $player_level
    CMP #$0032            ; level 50 is the cap: the watcher ends
    BCC LevelUpLoadThreshold
    BRL StopLevelUpWatcher

  LevelUpLoadThreshold:
    ASL                   ; index = level x 4: two big-endian BCD words per level
    ASL 
    TAY 
    LDA $&data_engine_tables.LevelExpThresholds, Y ; first word = high word of the EXP needed for the next level
    STA $player_exp_next+2
    LDA $&data_engine_tables.LevelExpThresholds+2, Y
    STA $player_exp_next
    COP [91]
    LDA $player_exp
    SEC 
    SBC $player_exp_next  ; EXP - needed as a 32-bit subtract (BCD digits compare like binary); carry set = level reached
    LDA $player_exp+2
    SBC $player_exp_next+2
    BCS LevelUpGain
    RTL 

  LevelUpGain:
    LDA $player_max_hp
    CLC 
    ADC #$0002
    CMP #$0065            ; max HP is capped at 100 (walkthrough: 100 at level 47); the HP below uses the same cap
    BCC LevelUpStoreMaxHp
    LDA #$0064

  LevelUpStoreMaxHp:
    STA $player_max_hp
    LDA $player_hp
    CLC 
    ADC #$0002
    CMP #$0065
    BCC LevelUpStoreHp
    LDA #$0064

  LevelUpStoreHp:
    STA $player_hp
    COP [37]              ; refill: heal_pending = max HP - HP, the bar fills over time (OQ-I032-9)
    INC $player_level
    SED                   ; decimal mode: the BCD level + 1
    LDA $player_level_bcd
    CLC 
    ADC #$0001
    STA $player_level_bcd
    CLD 
    LSR                   ; low bit of the new BCD level: odd adds to defense, even to strength (walkthrough level-up.md)
    BCS LevelUpAddDefense
    INC $level_power
    BRA LevelUpAnnounce

  LevelUpAddDefense:
    INC $level_defense

  LevelUpAnnounce:
    LDA #$001F
    TSB $hud_dirty_flags
    LDA $player_level
    ASL 
    ASL 
    TAY 
    LDA $&data_engine_tables.LevelExpThresholds, Y
    STA $player_exp_next+2
    LDA $&data_engine_tables.LevelExpThresholds+2, Y
    STA $player_exp_next
    BRK #$97              ; sound request $97, the level-up fanfare (inferred from the call site)
    COP [03] ( #03 )      ; three blinks of the banner
    PHX 
    LDY #$&lib_banner_texts.LevelUpText
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [1B] ( &ClearLevelUpText, #$0014 ) ; the banner stays 21 frames, then ClearLevelUpText erases it for 11
}

---------------------------------------------
; Erases the 'LEVEL UP !' banner.
; 
; When: 21 frames after the banner was printed (COP 1B of WatchForLevelUp).
; Sees: the banner disappears and comes back after 11 frames, two more times.
; Why: BG3 has no background, so the cells are overprinted with blank glyphs.
; In: X = the watcher slot.
; Out: LevelUpClearText printed (PrintTextString), COP 1B waits 11 frames and resumes at RepeatLevelUpBlink.
; Clobbers: A, Y; X saved (PHX / PLX).

ClearLevelUpText {
    PHX 
    LDY #$&lib_banner_texts.LevelUpClearText
    JSL $@lib_text_render.PrintTextString
    PLX 
    COP [1B] ( &RepeatLevelUpBlink, #$000A )
}

---------------------------------------------
; Loop end of the level-up banner blink.
; 
; When: 11 frames after the banner was erased (COP 1B of ClearLevelUpText).
; Sees: the banner returns, or after the third pass the game goes on.
; Why: COP 03 / 04 count the three blinks.
; In: the watcher, loop counter $2E.
; Out: COP 04 jumps back to the print; after the third pass BRL WatchForLevelUp checks the next level. StopLevelUpWatcher (COP 86) is the level-50 exit of WatchForLevelUp.
; Clobbers: A.

RepeatLevelUpBlink {
    COP [04]
    BRL WatchForLevelUp   ; check the next level at once: a big EXP gain gives several levels in a row

  StopLevelUpWatcher:
    COP [86]
    RTL 
}