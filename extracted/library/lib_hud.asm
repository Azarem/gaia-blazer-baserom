; HUD update, enemy gauge and the HUD strings (UpdateHud at file offsets 75353-75470, SNES $02:A659-$A6CE; HudRepeatCounts and HudFrameText with the enemy gauge strings at 83724-83848, SNES $02:C70C-$C788; bank 02). UpdateHud is the only reader of the strings, so they live in this file.
; 
; === MODEL ===
; UpdateHud runs once per frame at the end of the work phase (RunMainLoop step 7, RunReturnLoop, RunSubFrame) and once from ShowStatusAndSoulsScreen. It draws the enemy gauge, pays out the pending heal and EXP (lib_player_helpers.DrainPendingHeal and DrainPendingExp) and redraws the parts of the HUD that hud_dirty_flags marks.
; Locations $0F-$12 have no HUD: UpdateHud returns at once for location_id - $0F below 4, so the heal and EXP drains and the redraw are skipped there too, and the dirty bits are cleared (FM-A5 section 1.8 said the drains still ran; the code does not). The reduced loop of $10-$12 never calls it; location $0F still runs the full main loop (OQ-I027-2).
; 
; === ENEMY GAUGE ===
; enemy_gauge_timer ($0330) is one byte. A hit sets it to $80 (SetEnemyGauge in engine_combat_hits); on the next UpdateHud $80 is the only value that draws the gauge (EnemyGaugeText: a fixed six-tile label, entry 1 of the text renderer's list TextListPointers, and the bar from enemy_gauge_hp and enemy_gauge_max). The timer then counts down by 2 per frame ($7E ... $00, 63 frames, about one second); at 0 the clear string is drawn and the timer becomes $FE; every other negative value is idle and draws nothing (OQ-I009-15).
; 
; === HUD PARTS ===
; hud_dirty_flags ($0332) is shifted out bit by bit: bit 0 HudFrameText (the backing tiles, the LEV, EXP and GEM labels and a fixed six-tile label, entry 0 of TextListPointers), bit 1 HudExpText (8 BCD digits from player_exp), bit 2 HudHpGaugeText (the HP gauge from player_hp and player_max_hp), bit 3 HudLevelText (2 digits from player_level_bcd's low byte at $1B6A), bit 4 HudGemsText (6 digits from gems_low). The menus store $1F to redraw everything; hits set bits 1 and 2, pickups bit 4.
; 
; === NOTES ===
; - The BG3 cells are written into the buffer by the text renderer (lib_text_render.PrintTextString) and reach VRAM through the upload flags it sets.
---------------------------------------------

?BANK 02

?INCLUDE 'lib_player_helpers'
?INCLUDE 'lib_text_render'

!enemy_gauge_timer              0330
!hud_dirty_flags                0332
!location_id                    1C6A

---------------------------------------------

; Draws the enemy gauge, pays out the pending heal and EXP and redraws the dirty parts of the HUD.
; 
; When: once per frame at the end of the work phase (5 call sites in engine_boot_main_loop) and from ShowStatusAndSoulsScreen.
; Sees: the LEV, EXP and GEM numbers and the HP bar at the top of the screen, and the enemy gauge below them for about a second after a hit (walkthrough level-up.md and the HUD of every chapter).
; Why: all HUD text goes through one routine and a dirty mask, so only what changed is redrawn.
; In: long call; M = 8; reads location_id, enemy_gauge_timer, hud_dirty_flags.
; Out: nothing at all for locations $0F-$12 (hud_dirty_flags is cleared). Otherwise: the gauge by enemy_gauge_timer (see the block note), DrainPendingHeal and DrainPendingExp drained, one HUD string per set bit of hud_dirty_flags, then hud_dirty_flags = 0.
; Clobbers: A, Y; X by the callees.

UpdateHud {
    LDA $location_id
    SEC 
    SBC #$0F              ; Locations $0F-$12 have no HUD: skip everything, including the heal and EXP drains
    CMP #$04
    BCS loc_012666
    BRL loc_0126CB

  loc_012666:
    LDA $enemy_gauge_timer ; Enemy gauge timer (a byte): $80 = a hit just set it, draw the gauge; 2 per frame down to 0, then erase; negative = idle
    BEQ loc_012675
    BPL loc_01267C
    DEC                   ; $80 - 1 = $7F is positive, so only $80 draws; other negative values stay idle (the result is not stored)
    BMI loc_012682
    LDY #$&EnemyGaugeText
    BRA loc_012678

  loc_012675:
    LDY #$&EnemyGaugeClearText

  loc_012678:
    JSL $@lib_text_render.PrintTextString

  loc_01267C:
    DEC $enemy_gauge_timer
    DEC $enemy_gauge_timer

  loc_012682:
    JSL $@lib_player_helpers.DrainPendingHeal ; Pay out heal_pending and exp_pending
    JSL $@lib_player_helpers.DrainPendingExp
    LDA $hud_dirty_flags  ; One LSR per bit: 0 frame, 1 EXP, 2 HP, 3 level, 4 gems
    BEQ loc_0126CB
    LSR $hud_dirty_flags
    BCC loc_01269B
    LDY #$&HudFrameText
    JSL $@lib_text_render.PrintTextString

  loc_01269B:
    LSR $hud_dirty_flags
    BCC loc_0126A7
    LDY #$&HudExpText
    JSL $@lib_text_render.PrintTextString

  loc_0126A7:
    LSR $hud_dirty_flags
    BCC loc_0126B3
    LDY #$&HudHpGaugeText
    JSL $@lib_text_render.PrintTextString

  loc_0126B3:
    LSR $hud_dirty_flags
    BCC loc_0126BF
    LDY #$&HudLevelText
    JSL $@lib_text_render.PrintTextString

  loc_0126BF:
    LSR $hud_dirty_flags
    BCC loc_0126CB
    LDY #$&HudGemsText
    JSL $@lib_text_render.PrintTextString

  loc_0126CB:
    STZ $hud_dirty_flags
    RTL 
}
---------------------------------------------

; Two count bytes for the HUD strings: $19 (25) and $20 (32).
; 
; When: the [0B:t,&c] codes of HudFrameText, EnemyGaugeClearText and EnemyGaugeText repeat a tile by the byte at c.
; Sees: 25-tile and 32-tile rows behind the HUD labels and the enemy gauge (OQ-I009-16).
; Why: the control code takes its count from memory, not from the string.
; In: n/a (data; read as bytes).
; Out: n/a.
; Clobbers: n/a.

HudRepeatCounts [
  $#1920
]
---------------------------------------------

; The frame of the HUD: backing tiles and the labels LEV, EXP and GEM.
; 
; When: UpdateHud, dirty bit 0 (every menu close, scene start).
; Sees: 25 tiles $1A at $700, the labels LEV ($42), EXP ($50) and GEM ($6A), a fixed six-tile label (entry 0 of TextListPointers, tiles $0A-$0F) at $C0 and 32 blanks at $CC.
; Why: the static parts of the HUD are drawn once and the numbers are updated separately.
; In: n/a (data). Single-row glyph mode [09], palettes [03:24] and [03:28].
; Out: n/a.
; Clobbers: n/a.

HudFrameText |[09][03:24][CUR:700][0B:1A,&HudRepeatCounts][CUR:42]LEV[CUR:50]EXP[CUR:6A]GEM[CUR:C0][02:0][CUR:CC][03:28][0B:20,&HudRepeatCounts+1]|

---------------------------------------------
; The EXP number of the HUD (8 BCD digits from $1B78).
; 
; When: UpdateHud, dirty bit 1 (EXP changed).
; Sees: the EXP value next to the EXP label.
; Why: updated alone when only the EXP changes.
; In: n/a (data). Position $58.
; Out: n/a.
; Clobbers: n/a.

HudExpText |[09][CUR:58][03:20][06:8,1B78]|

---------------------------------------------
; The HP gauge of the HUD.
; 
; When: UpdateHud, dirty bit 2 (HP changed).
; Sees: the gauge at $CC, palette 3, from player_hp and player_max_hp ([04:1B88,1B8A], two words).
; Why: updated alone when only the HP changes.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

HudHpGaugeText |[09][CUR:CC][03:2C][04:1B88,1B8A]|

---------------------------------------------
; The level number of the HUD (2 BCD digits from $1B6A).
; 
; When: UpdateHud, dirty bit 3.
; Sees: the level next to LEV.
; Why: updated alone on a level up.
; In: n/a (data). Position $4A.
; Out: n/a.
; Clobbers: n/a.

HudLevelText |[09][CUR:4A][03:20][06:2,1B6A]|

---------------------------------------------
; The Gem number of the HUD (6 BCD digits from $1B66).
; 
; When: UpdateHud, dirty bit 4.
; Sees: the Gems next to GEM.
; Why: updated alone when Gems change.
; In: n/a (data). Position $72.
; Out: n/a.
; Clobbers: n/a.

HudGemsText |[09][CUR:72][03:20][06:6,1B66]|

---------------------------------------------
; Erases the enemy gauge (25 blanks at $140).
; 
; When: UpdateHud, when enemy_gauge_timer reaches 0.
; Sees: the enemy gauge disappears about a second after the last hit.
; Why: see UpdateHud.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

EnemyGaugeClearText |[09][CUR:140][0B:20,&HudRepeatCounts]|

---------------------------------------------
; Draws the enemy gauge: a fixed label and the life bar.
; 
; When: UpdateHud on the frame after a hit set enemy_gauge_timer to $80.
; Sees: a six-tile label (entry 1 of TextListPointers, tiles $10-$15) at $140 and a bar at $14C from enemy_gauge_hp and enemy_gauge_max ([04:336,338], two words) over 32 blank tiles.
; Why: shows how much life the monster just hit has left.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

EnemyGaugeText |[09][CUR:140][03:24][02:1][CUR:14C][03:2C][0B:20,&HudRepeatCounts+1][CUR:14C][04:336,338]|