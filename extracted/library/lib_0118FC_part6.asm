; HUD update and enemy gauge (file offsets 75353-75470, SNES $02:A659-$A6CE, bank 02).
; 
; === MODEL ===
; UpdateHud runs once per frame at the end of the work phase (RunMainLoop step 7, RunReturnLoop, RunSubFrame) and once from ShowStatusAndSoulsScreen. It draws the enemy gauge, pays out the pending heal and EXP (lib_player_stats.DrainPendingHeal and DrainPendingExp) and redraws the parts of the HUD that hud_dirty_flags marks.
; Locations $0F-$12 have no HUD: UpdateHud returns at once for location_id - $0F below 4, so the heal and EXP drains and the redraw are skipped there too, and the dirty bits are cleared (FM-A5 section 1.8 said the drains still ran; the code does not). The reduced loop of $10-$12 never calls it; location $0F still runs the full main loop (OQ-I027-2).
; 
; === ENEMY GAUGE ===
; enemy_gauge_timer ($0330) is one byte. A hit sets it to $80 (SetEnemyGauge in engine_scheduler_sprites_combat_collision); on the next UpdateHud $80 is the only value that draws the gauge (EnemyGaugeText: a fixed six-tile label, entry 1 of the text renderer's list TextListPointers, and the bar from enemy_gauge_hp and enemy_gauge_max). The timer then counts down by 2 per frame ($7E ... $00, 63 frames, about one second); at 0 the clear string is drawn and the timer becomes $FE; every other negative value is idle and draws nothing (OQ-I009-15).
; 
; === HUD PARTS ===
; hud_dirty_flags ($0332) is shifted out bit by bit: bit 0 HudFrameText (the backing tiles, the LEV, EXP and GEM labels and a fixed six-tile label, entry 0 of TextListPointers), bit 1 HudExpText (8 BCD digits from player_exp), bit 2 HudHpGaugeText (the HP gauge from player_hp and player_max_hp), bit 3 HudLevelText (2 digits from player_level_bcd's low byte at $1B6A), bit 4 HudGemsText (6 digits from gems_low). The menus store $1F to redraw everything; hits set bits 1 and 2, pickups bit 4.
; 
; === NOTES ===
; - The BG3 cells are written into the buffer by the text renderer (lib_text_render.PrintTextString) and reach VRAM through the upload flags it sets.
---------------------------------------------

?BANK 02

?INCLUDE 'lib_menus'
?INCLUDE 'lib_player_stats'
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
    LDY #$&lib_menus.EnemyGaugeText
    BRA loc_012678

  loc_012675:
    LDY #$&lib_menus.EnemyGaugeClearText

  loc_012678:
    JSL $@lib_text_render.PrintTextString

  loc_01267C:
    DEC $enemy_gauge_timer
    DEC $enemy_gauge_timer

  loc_012682:
    JSL $@lib_player_stats.DrainPendingHeal ; Pay out heal_pending and exp_pending
    JSL $@lib_player_stats.DrainPendingExp
    LDA $hud_dirty_flags  ; One LSR per bit: 0 frame, 1 EXP, 2 HP, 3 level, 4 gems
    BEQ loc_0126CB
    LSR $hud_dirty_flags
    BCC loc_01269B
    LDY #$&lib_menus.HudFrameText
    JSL $@lib_text_render.PrintTextString

  loc_01269B:
    LSR $hud_dirty_flags
    BCC loc_0126A7
    LDY #$&lib_menus.HudExpText
    JSL $@lib_text_render.PrintTextString

  loc_0126A7:
    LSR $hud_dirty_flags
    BCC loc_0126B3
    LDY #$&lib_menus.HudHpGaugeText
    JSL $@lib_text_render.PrintTextString

  loc_0126B3:
    LSR $hud_dirty_flags
    BCC loc_0126BF
    LDY #$&lib_menus.HudLevelText
    JSL $@lib_text_render.PrintTextString

  loc_0126BF:
    LSR $hud_dirty_flags
    BCC loc_0126CB
    LDY #$&lib_menus.HudGemsText
    JSL $@lib_text_render.PrintTextString

  loc_0126CB:
    STZ $hud_dirty_flags
    RTL 
}