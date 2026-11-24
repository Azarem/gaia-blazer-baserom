; Field menus and screens (status and souls, equipment and item menu), their menu text and the item descriptions (code at file offsets 71932-72151 and 72599-73976, SNES $02:98FC-$99D7 and $02:9B97-$A0F8, plus helpers at 74576-74639 and 74730-74773; text and tables at 83313-83723, 85876-86757 (ItemNameList and the item names) and 87358-90589; bank 02). The talk routines (72152-72598) are in lib_field_talk, the HUD strings in lib_hud and EnableDisplayAndNmi in lib_system_helpers.
; 
; === FIELD BUTTONS ===
; DispatchFieldButtons runs once per frame from RunMainLoop with NMI on (M = 8). Order: Select or X (joy_pressed+1 bit $20; the NMI copies X into the Select bit) opens the equipment menu; B ($80) talks to the actor in front of the player; A (low byte of joy_pressed, bit 7), only when no direction is held, shows the status and souls screen. Walkthrough 01-in-the-beginning.md: 'Press the X Button to open the menu ... Press the B Button twice to equip ... Press the Y Button to exit the menu', 'speak with him (B Button)'. The A-button screen is not in the walkthrough (OQ-I009-5). joy_pressed keeps a button as long as its release latch bit is set (engine_vblank_nmi JOYPAD note), so every chooser first waits until all buttons are up and the screens that end on a button clear the latch bits with TRB, to stop the same press acting in the field.
; 
; === STATUS AND SOULS SCREEN ===
; A BG3-only overlay (no screen blank, no graphics swap). ShowStatusAndSoulsScreen converts HP and maximum HP to BCD (hp_bcd, max_hp_bcd), clamps the strength and defence level parts (level_power, level_defense) to 12 for the display and restores them afterwards (OQ-I009-6), and prints StatusScreenText: the player name, HP / maximum, the EXP total of the next level (player_exp_next: the LevelExpThresholds value that WatchForLevelUp compares with player_exp, not a remainder; 8 digits), bars for Strength and Defence (two rows each, level part over gear part) and the four equipped item names. After A is released it waits for A, B, Y or a direction, prints the souls page (SoulsScreenTitleText, then one 21-byte line per bit of souls_flags: bit 0 Magician, 1 Light, 2 Shield, 3 Detection, 4 Reality), waits for release and another press, consumes the latch and clears BG3. WaitFrameKeepClock undoes the NMI's frame_counter increment, so the frame clock stands still while the screen is open.
; 
; === INVENTORY TABLE AND SLOT BYTE ===
; inventory ($1B1E) is one 64-byte table indexed by item id minus 1. The four lists of the menu are ranges of it: weapons ids $01-$08 (8 slots, $1B1E), armors $09-$10 ($1B26), magic $11-$18 ($1B2E) and items $19-$40 (40 slots, $1B36; walkthrough grid position (row, column) is slot (row - 1) x 10 + column - 1). A slot byte holds the item id in bits 0-6 (0 = not owned; an owned slot holds the id of its own slot) and bit 7 = marker: the equipped item of each list, and during a choice the cursor. DrawInventoryIcon draws a selection frame around every slot with bit 7. The equipped state is stored twice: the marker in the list and the id in the word cells equipped_weapon, equipped_armor, equipped_magic and equipped_bracelet (high bytes never written; the text codes read them as words).
; Choosing from a list (ChooseFromEquipmentList, ChooseItemSlot): the cursor starts on the first slot with bit 7 set, or marks slot 0 when none is; the list is backed up to $7F0403 (only the dead cancel paths restore it); a direction moves the marker and resets menu_blink; B and Y both confirm (BRK #$18), set the marker on the slot and return A = id with carry clear. No live path cancels (CancelEquipChoice and CancelItemChoice are unreferenced, OQ-I009-14), so choosing an empty slot returns 0, which the caller stores in the equipped cell: name index 0 is the string 'not equipped'. Weapons, armors and magic are two columns of four, column-major (Right +4, Left -4, Down +1, Up -1); items are four rows of ten, row-major (Right +1, Left -1, Down +10, Up -10). A step past an end leaves the cursor where it is; stepping down from the last slot of a column goes to the top of the next.
; 
; === EQUIPMENT MENU ===
; OpenEquipmentMenu (X or Select): HDMA off (dp$42 = 0), forced blank, BG2 map at VRAM $5C00 and characters at $2000, main screen BG2 and BG3 only, colour math and windows off; saves the four scroll words (menu_saved_bg1_x .. menu_saved_bg2_y) and zeroes the live ones, saves the CGRAM buffer ($7E6000), loads the menu graphics, palette and tile groups (LoadMenuBg2Graphics, LoadMenuPalette, ExpandMenuTileGroups in lib_menu_screen_setup), runs RunEquipmentMenu. RunEquipmentMenu prints EquipMenuFrameText (tabs Weapon, Armor, Magic at $88, $98, $A8, the description window at $408 and four equipped-item lines), switches NMI and the screen on, draws the icons, uploads the BG3 page and then the BG2 icon page ($7F7800 to VRAM $5C00), and loops on ChooseMenuRow: rows 0-2 call ChooseFromEquipmentList (A = 8, Y = list base), row 3 ChooseItemSlot (A = $28, Y = $1B36). A confirmed id is stored in the equipped cell (weapon and armor then RecalcGearStats) and the frame is reprinted from its [::] marker (the window and the equipped lines only). Y on the row level leaves.
; Exit: the B and Y latch bits are consumed (TRB $032B with $C0) and joy_pressed+1 is cleared; the scroll words, BG2SC, TM, CGADSUB and W12SEL are restored from the scene's shadows (tm_shadow, cgadsub_shadow, bg2sc_shadow, w12sel_shadow, stored by the scene loader), BG12NBA = 0; RestoreSceneBgGfxAndPalette, RestoreCgramBuffer and LoadEquippedMagicGfx put the field back in that order; when the equipped magic changed (menu_magic_on_open) all projectiles are killed and $0433 and $0434 cleared (OQ-I009-11); lib_player_helpers.ApplyPlayerWeaponPose restores the player's pose; BG3 is cleared, hud_dirty_flags = $1F, one sub-frame runs, the screen is switched on (INIDISP = $0F).
; 
; === BG3 PAGE, ICONS ===
; The BG3 text page is the 2 KB buffer at $7F7000 (bg3_tilemap_buffer), the BG2 icon page the buffer at $7F7800; vram_upload_flags bit 0 asks the NMI to send the BG3 page, bit 1 the icon page. DrawInventoryIcon writes four BG3 cells (selection frame tile $2A with its three flips, palette 3, when the slot has bit 7; else four zero cells) and the four words of the icon record IconTileRecords[id x 8] to the BG2 page (top-left, top-right, bottom-left, bottom-right). ClearBg3Page and ClearBg3UpperHalf fill the page with $2000 (tile 0, priority) but set their upload bit with DBR = $7F, so the TSB reaches $7F:03B8 instead of vram_upload_flags (OQ-I027-1).
; 
; === MENU TEXT, GEAR AND DESCRIPTIONS ===
; StatusScreenText, SoulsScreenTitleText, the five soul lines, EquipMenuFrameText, ItemMenuFrameText and the description headers (the HUD strings HudFrameText .. EnemyGaugeText with the repeat counts in HudRepeatCounts are in lib_hud) are ASCIIString parts with text control codes (the renderer is lib_text_render, batch A6: [CUR:o] cursor to BG3 byte offset o, [07:w,h] window, [03:v] attribute, [06:n,addr] n packed BCD digits, [0B:t,&c] repeat tile t by the count byte at c, [TBL:list,addr] string number (word at addr) of a pointer list, [02:n] entry n of TextListPointers (0 and 1 are fixed six-tile labels, 2 = the player name at $1B92), [04:a,b] gauge from two words, [N] newline, [::] marks the re-entry point '+M', [JMP:&s] continue at s). The extractor prints the period glyph as '-' and an apostrophe as a space ('Goat s Food').
; DescriptionTextList holds 65 string pointers, index = item id (0 = empty window). Every record starts [CUR:48A][TBL:&ItemNameList,&NameIndexCells + 2 x (id - 1)] (the item name on the first line; NameIndexCells holds k + 1 for entry k because [TBL] reads its index from memory). Weapons then print the minimum swing level from WeaponMinLevelBcd (two BCD digits at $4B2) and a bar of GearStatTable strength tiles; armors only a defence bar; magic and items start the text at $50A. Stub records (ids $2B-$31, $33, $34, $3B-$3F) print their own name and [JMP] into the carrying record (DescMastersEmblemA, DescRedHotMirror, DescBrownStone) at its [::] marker. The Gem costs of magic are literal text digits (4, 8, 8, 1, 8, 20, 8, 2; OQ-I009-10).
; GearStatTable has two rows of 17 bytes indexed by item id: row 0 the strength bonus of weapons ids 1-8 (1, 2, 3, 4, 6, 8, 10, 12), row 1 (+$11) the defence bonus of armor ids 9-$10 (the same numbers). RecalcGearStats adds the weapon and armor entries into gear_power and gear_defense. The minimum levels (1, 5, 11, 15, 16, 19, 22, 24) are compared by the player code (player_core) with player_level_bcd; the walkthrough weapon table lists exactly these. The item names (ItemNameList and its 65 strings, file offsets 85876-86757) are noted in the ItemNameList part (batch A8).
; 
; === NOTES ===
; - StoreInventoryEntry (file offset 73977, lib_inventory_store, batch A4) lies between ChooseItemSlot's neighbour routines: the code of this file continues at 74040 in lib_choice_menus.
; - ROM item names differ from the walkthrough in a few places (OQ-I027-3); labels use the walkthrough names, the strings keep the ROM text.
; - Sound requests: BRK #$07 follows every cursor move and page change, BRK #$18 every confirm (OQ-I009-12).
---------------------------------------------

?BANK 02

?INCLUDE 'data_engine_tables'
?INCLUDE 'data_iris_and_icon_tiles'
?INCLUDE 'engine_boot_main_loop'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'lib_arithmetic'
?INCLUDE 'lib_choice_menus'
?INCLUDE 'lib_field_talk'
?INCLUDE 'lib_hud'
?INCLUDE 'lib_menu_screen_setup'
?INCLUDE 'lib_player_helpers'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'lib_text_render'

!frame_counter                  0312
!joy_pressed                    0322
!joy_release_latch              032A
!hud_dirty_flags                0332
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!scroll_bg2_x                   033E
!scroll_bg2_y                   0340
!vram_upload_flags              03B8
!tm_shadow                      03C0
!cgadsub_shadow                 03C1
!bg2sc_shadow                   03C2
!w12sel_shadow                  03C3
!menu_count                     03C4
!menu_blink                     03C6
!menu_item_page                 042F
!spell_active_count             0433
!menu_magic_on_open             0435
!menu_saved_bg1_x               045A
!menu_saved_bg1_y               045C
!menu_saved_bg2_x               045E
!menu_saved_bg2_y               0460
!inventory                      1B1E
!equipped_weapon                1B5E
!equipped_armor                 1B60
!equipped_magic                 1B62
!equipped_bracelet              1B64
!gear_power                     1B70
!level_power                    1B72
!gear_defense                   1B74
!level_defense                  1B76
!souls_flags                    1B82
!player_hp                      1B88
!player_max_hp                  1B8A
!INIDISP                        2100
!BG2SC                          2108
!BG12NBA                        210B
!W12SEL                         2123
!TM                             212C
!CGADSUB                        2131
!S_bg3_tilemap_buffer           7000
!cgram_buffer                   7F0000

---------------------------------------------

; Reads the field buttons once per frame and opens the matching screen.
; 
; When: once per frame from RunMainLoop (step 3, NMI on).
; Sees: X or Select opens the equipment menu, B talks to the NPC in front of the player, A alone shows the status and souls screen.
; Why: one place decides which button does what in the field; the other buttons (attack, Start) are handled by the player code and the pause code.
; In: long call; M = 8; reads joy_pressed.
; Out: RTL after the screen has been closed, or at once when no relevant button is down. Tests in order: joy_pressed+1 bit $20 (Select or X) -> OpenEquipmentMenu; bit $80 (B) -> RunTalkInteraction; direction bits $0F clear and joy_pressed low byte bit 7 (A) -> ShowStatusAndSoulsScreen.
; Clobbers: A (the tests use BIT).

DispatchFieldButtons {
    LDA $joy_pressed+1    ; High byte of joy_pressed: $80 B, $40 Y, $20 Select or X, $10 Start, $08 Up, $04 Down, $02 Left, $01 Right
    BIT #$20
    BEQ loc_011906
    BRL OpenEquipmentMenu

  loc_011906:
    BIT #$80
    BEQ loc_01190D
    BRL lib_field_talk.RunTalkInteraction

  loc_01190D:
    BIT #$0F              ; A (low byte bit 7) acts only when no direction is down
    BNE loc_011918
    LDA $joy_pressed
    BIT #$80
    BNE ShowStatusAndSoulsScreen

  loc_011918:
    RTL 

; Shows the status page (HP, level parts, equipment) and then the souls page.
; 
; When: DispatchFieldButtons, A pressed with no direction (not described in the walkthrough, OQ-I009-5).
; Sees: a window with the player name, HP / maximum HP, 'Next level :' with the EXP total of the next level (player_exp_next), Strength and Defence bars and the four equipped items; after a button the 'Souls' page with one line for each recruited soul; another button closes it.
; Why: gives the player a read-out of HP, strength and defence without the equipment menu.
; In: long call; M = 8; reads player_hp, player_max_hp, level_power, level_defense, souls_flags.
; Out: hp_bcd and max_hp_bcd set; the strength and defence level parts are clamped to 12 only for the print and restored (the walkthrough caps strength at 13, OQ-I009-6); BRK #$07 when a page opens; after the second press the latch bits for B, Y, A and X are consumed (TRB $C0C0), joy_pressed = 0, BG3 cleared, hud_dirty_flags = $1F and UpdateHud runs once. The frame_counter does not advance while the screen is open (WaitFrameKeepClock).
; Clobbers: A, X, Y; $1B6C-$1B6F; joy_pressed, joy_release_latch.

  ShowStatusAndSoulsScreen:
    LDA $player_hp
    LDX #$1B6C
    JSL $@lib_arithmetic.ByteToPackedBcd
    LDA $player_max_hp
    LDX #$1B6E
    JSL $@lib_arithmetic.ByteToPackedBcd
    LDA $level_power      ; Strength and defence level parts are clamped to 12 for the display and restored after the print (OQ-I009-6)
    PHA 
    CMP #$0C
    BCC loc_01193A
    LDA #$0C
    STA $level_power

  loc_01193A:
    LDA $level_defense
    PHA 
    CMP #$0C
    BCC loc_011947
    LDA #$0C
    STA $level_defense

  loc_011947:
    LDY #$&StatusScreenText
    JSL $@lib_text_render.PrintTextString
    PLA 
    STA $level_defense
    PLA 
    STA $level_power
    BRK #$07
    JSL $@lib_system_helpers.WaitVBlank

  loc_01195C:
    JSR $&WaitFrameKeepClock ; Wait until A is released (M = 8: A holds the low byte of joy_pressed)
    BIT #$80
    BNE loc_01195C
    REP #$20

  loc_011965:
    JSR $&WaitFrameKeepClock
    BIT #$CF80            ; Any of A, B, Y or a direction (not Start, not Select or X)
    BEQ loc_011965
    SEP #$20
    LDY #$&SoulsScreenTitleText
    JSL $@lib_text_render.PrintTextString
    JSR $&DrawRecruitedSouls
    REP #$20

  loc_01197B:
    JSR $&WaitFrameKeepClock
    BIT #$CF80
    BNE loc_01197B

  loc_011983:
    JSR $&WaitFrameKeepClock
    BIT #$CF80
    BEQ loc_011983
    LDA #$C0C0            ; Consume the latch bits of B, Y (high byte) and A, X (low byte) so this press does not act in the field
    TRB $joy_release_latch
    STZ $joy_pressed
    SEP #$20
    BRK #$07
    JSR $&ClearBg3Page
    LDA #$1F
    STA $hud_dirty_flags
    JSL $@lib_hud.UpdateHud
    JSR $&WaitFrameKeepClock
    RTL 
}

---------------------------------------------
; Waits one frame without letting the frame counter advance and returns the pad state.
; 
; When: five times in ShowStatusAndSoulsScreen.
; Sees: n/a.
; Why: HandleVBlank increments frame_counter, which drives animations; undoing it freezes the field's animation clock while the screen is open.
; In: JSR; M as the caller (8 or 16).
; Out: A = joy_pressed (low byte with M = 8, the word with M = 16); frame_counter unchanged over the call (DEX and STX undo the NMI's increment).
; Clobbers: A, X.

WaitFrameKeepClock {
    JSL $@lib_system_helpers.WaitVBlank
    LDX $frame_counter
    DEX                   ; WaitVBlank let the NMI increment frame_counter; undo it so the frame clock stands still while the screen is open
    STX $frame_counter
    LDA $joy_pressed
    RTS 
}

---------------------------------------------
; Prints one line for every soul the player has recruited.
; 
; When: ShowStatusAndSoulsScreen, after the 'Souls' title.
; Sees: 'Soul of Magician', 'Soul of Light', 'Soul of Shield', 'Soul of Detection', 'Soul of Reality' for the souls that joined (walkthrough: the five souls of the game).
; Why: the five lines are adjacent 21-byte strings, so a loop over souls_flags prints them by stepping Y.
; In: JSR; M = 8; souls_flags (bit 0 Magician, 1 Light, 2 Shield, 3 Detection, 4 Reality).
; Out: prints the line of every set bit (lowest bit first), Y stepping $15 from SoulOfMagicianText up to EquipMenuFrameText.
; Clobbers: A, Y; X by the renderer.

DrawRecruitedSouls {
    LDA $souls_flags
    LDY #$&SoulOfMagicianText

  loc_0119BD:
    LSR 
    PHA 
    BCC loc_0119C7
    PHY 
    JSL $@lib_text_render.PrintTextString
    PLY 

  loc_0119C7:
    REP #$20
    TYA 
    CLC 
    ADC #$0015            ; Next soul line: 21 bytes ($15) per string
    TAY 
    SEP #$20
    PLA 
    CPY #$&EquipMenuFrameText ; Stop at the first byte after the five soul lines
    BNE loc_0119BD
    RTS 
}
---------------------------------------------

; Opens the equipment and item menu and puts the field back when it closes.
; 
; When: DispatchFieldButtons, X or Select pressed.
; Sees: the pause menu with the tabs Weapon, Armor, Magic and Item, the icon grid and the equipped lines (walkthrough: 'Press the X Button to open the menu').
; Why: the menu needs its own graphics, palette and screen mode, so everything it changes is saved and restored here.
; In: long call; M = 8; NMI on.
; Out: RTL after Y closed the menu, screen on. Saves scroll_bg1/2 (menu_saved_*), the CGRAM buffer ($7E6000) and equipped_magic (menu_magic_on_open), sets BG2SC = $5C, BG12NBA = $20, TM = 6, CGADSUB = W12SEL = 0, runs RunEquipmentMenu; on exit restores them, calls RestoreSceneBgGfxAndPalette, RestoreCgramBuffer and LoadEquippedMagicGfx, kills all projectiles and clears $0433 and $0434 when the magic changed, restores the player pose, clears BG3, hud_dirty_flags = $1F, runs one sub-frame and sets INIDISP = $0F.
; Clobbers: A, X, Y; menu_saved_*, $7E6000-$7E61FF.

OpenEquipmentMenu {
    STZ $42               ; No HDMA while the menu is open
    JSL $@lib_system_helpers.WaitVBlank
    LDA #$80
    STA $INIDISP
    LDA #$5C              ; BG2 map at VRAM $5C00 (the icon page, uploaded from $7F7800)
    STA $BG2SC
    LDA #$20
    STA $BG12NBA
    LDA #$06              ; Main screen: BG2 and BG3 only
    STA $TM
    STZ $CGADSUB
    STZ $W12SEL
    LDX $scroll_bg1_x     ; Save the four scroll words and zero the live ones; the menu pages are drawn from 0
    STX $menu_saved_bg1_x
    LDX $scroll_bg1_y
    STX $menu_saved_bg1_y
    LDX $scroll_bg2_x
    STX $menu_saved_bg2_x
    LDX $scroll_bg2_y
    STX $menu_saved_bg2_y
    LDX #$0000
    STX $scroll_bg1_x
    STX $scroll_bg1_y
    STX $scroll_bg2_x
    STX $scroll_bg2_y
    STZ $menu_item_page
    LDA $equipped_magic
    STA $menu_magic_on_open
    JSR $&SaveCgramBuffer
    JSR $&lib_menu_screen_setup.LoadMenuBg2Graphics
    JSR $&lib_menu_screen_setup.LoadMenuPalette
    JSR $&lib_menu_screen_setup.ExpandMenuTileGroups
    JSL $@lib_system_helpers.WaitVBlank
    BRK #$07
    JSR $&RunEquipmentMenu
    LDA #$C0              ; Consume the latch bits of B and Y ($032B = high byte of joy_release_latch) and clear the pad: the closing press must not act in the field
    TRB $032B
    STZ $joy_pressed+1
    JSL $@lib_system_helpers.WaitVBlank
    LDX $menu_saved_bg1_x
    STX $scroll_bg1_x
    LDX $menu_saved_bg1_y
    STX $scroll_bg1_y
    LDX $menu_saved_bg2_x
    STX $scroll_bg2_x
    LDX $menu_saved_bg2_y
    STX $scroll_bg2_y
    LDA #$80
    STA $INIDISP
    LDA $bg2sc_shadow     ; Back to the scene's own video settings (shadow bytes of the scene loader)
    STA $BG2SC
    STZ $BG12NBA
    LDA $tm_shadow
    STA $TM
    LDA $cgadsub_shadow
    STA $CGADSUB
    LDA $w12sel_shadow
    STA $W12SEL
    JSL $@lib_menu_screen_setup.RestoreSceneBgGfxAndPalette
    JSR $&RestoreCgramBuffer ; Overwrites the whole CGRAM buffer, including the colours RestoreSceneBgGfxAndPalette just wrote, so the spell palette is loaded after it
    JSL $@lib_menu_screen_setup.LoadEquippedMagicGfx
    LDA $equipped_magic
    CMP $menu_magic_on_open
    BEQ loc_011C5D
    JSL $@engine_spawn_lairs_death_drops.KillAllProjectiles ; Magic changed: kill all projectiles (the old spell's actors) and clear $0433 and $0434 (OQ-I009-11)
    STZ $spell_active_count
    STZ $0434

  loc_011C5D:
    JSL $@lib_player_helpers.ApplyPlayerWeaponPose
    JSR $&ClearBg3Page
    LDA #$1F
    STA $hud_dirty_flags
    JSL $@lib_system_helpers.WaitVBlank
    JSL $@engine_boot_main_loop.RunSubFrameLoader ; One game frame so the field is drawn again before the screen is lit
    JSL $@lib_system_helpers.WaitVBlank
    LDA #$0F
    STA $INIDISP
    RTL 
}

---------------------------------------------
; The menu loop: draws the frame and lists, chooses rows and stores the chosen items.
; 
; When: OpenEquipmentMenu.
; Sees: the frame and icons appear, the cursor moves between the rows, B opens a list, B or Y inside a list equips the item under the cursor.
; Why: one loop owns the row level and calls the list choosers.
; In: JSR; M = 8.
; Out: loops on ChooseMenuRow until Y (carry set, ExitEquipmentMenu). Row 0: ChooseFromEquipmentList (A = 8, Y = $1B1E), equipped_weapon = id, RecalcGearStats; row 1: Y = $1B26, equipped_armor, RecalcGearStats; row 2: Y = $1B2E, equipped_magic; row 3: ChooseItemSlot (A = $28, Y = $1B36), equipped_bracelet. After a choice the frame is reprinted from its [::] marker and the loop continues on the same row. Uploads: BG3 page, then the BG2 icon page, then the BG3 page again.
; Clobbers: A, X, Y.

RunEquipmentMenu {
    JSR $&ClearBg3Page
    LDY #$&EquipMenuFrameText
    JSL $@lib_text_render.PrintTextString
    LDA #$01              ; vram_upload_flags: bit 0 = BG3 page, bit 1 = BG2 icon page ($7F7800 to VRAM $5C00)
    STA $vram_upload_flags
    JSL $@lib_system_helpers.EnableNmi
    JSL $@lib_system_helpers.EnableDisplayAndNmi
    JSR $&DrawEquipIconRows
    LDA #$02
    STA $vram_upload_flags
    JSL $@lib_system_helpers.WaitVBlank
    LDA #$01
    STA $vram_upload_flags
    JSL $@lib_system_helpers.WaitVBlank
    LDX #$048A            ; ChooseMenuRow input: X = cursor cell of row 0 ($48A), B = start row 0, A = 4 rows
    LDA #$00
    XBA 
    LDA #$04

  loc_011CAF:
    JSR $&lib_choice_menus.ChooseMenuRow
    BCC loc_011CB7
    BRL ExitEquipmentMenu

  loc_011CB7:
    CMP #$00              ; Row 0 weapons, 1 armor, 2 magic, 3 items
    BEQ loc_011CC3
    DEC 
    BEQ loc_011CE4
    DEC 
    BEQ loc_011D05
    BRA loc_011D23

  loc_011CC3:
    LDA #$08              ; 8 slots, list base $1B1E (weapons)
    LDY #$1B1E
    JSR $&ChooseFromEquipmentList
    BCS loc_011CD3
    STA $equipped_weapon
    JSR $&RecalcGearStats

  loc_011CD3:
    LDY #$&EquipMenuFrameText+M
    JSL $@lib_text_render.PrintTextString
    LDX #$048A
    LDA #$00
    XBA 
    LDA #$04
    BRA loc_011CAF

  loc_011CE4:
    LDA #$08
    LDY #$1B26
    JSR $&ChooseFromEquipmentList
    BCS loc_011CF4
    STA $equipped_armor
    JSR $&RecalcGearStats

  loc_011CF4:
    LDY #$&EquipMenuFrameText+M
    JSL $@lib_text_render.PrintTextString
    LDX #$050A
    LDA #$01
    XBA 
    LDA #$04
    BRA loc_011CAF

  loc_011D05:
    LDA #$08
    LDY #$1B2E
    JSR $&ChooseFromEquipmentList
    BCS loc_011D12
    STA $equipped_magic

  loc_011D12:
    LDY #$&EquipMenuFrameText+M
    JSL $@lib_text_render.PrintTextString
    LDX #$058A
    LDA #$02
    XBA 
    LDA #$04
    BRA loc_011CAF

  loc_011D23:
    LDA #$28
    LDY #$1B36
    JSR $&ChooseItemSlot
    BCS loc_011D30
    STA $equipped_bracelet

  loc_011D30:
    LDY #$&EquipMenuFrameText+M
    JSL $@lib_text_render.PrintTextString
    LDX #$060A
    LDA #$03
    XBA 
    LDA #$04
    BRL loc_011CAF

  loc_011D42:
    CLC 
    RTS 

; Return path of the menu loop: carry set means the menu was closed.
; 
; When: RunEquipmentMenu, when ChooseMenuRow reports Y.
; Sees: n/a.
; Why: gives the loop a single exit that returns to OpenEquipmentMenu.
; In: entered by BRL from RunEquipmentMenu.
; Out: SEC, RTS (returns from RunEquipmentMenu). The unreferenced loc_011D42 before it is the same with CLC (dead).
; Clobbers: P.C.

  ExitEquipmentMenu:
    SEC 
    RTS 
}

---------------------------------------------
; Redraws the equipment page (frame and icons) when the cursor leaves the item row.
; 
; When: ChooseMenuRow, when the cursor moves off row 3 while the item page is shown.
; Sees: the item grid is replaced by the weapon, armor and magic icons.
; Why: the item grid and the equipment frame share the screen and are swapped as the cursor moves.
; In: JSR; M = 8.
; Out: clears the upper half of BG3, prints EquipMenuFrameText, loads the equipment palette (lib_menu_screen_setup.LoadMenuPalette), draws the icons, uploads BG3, the BG2 page and BG3 again, one frame each.
; Clobbers: A; X and Y are preserved.

RedrawEquipmentPage {
    PHX 
    PHY 
    JSR $&ClearBg3UpperHalf
    LDY #$&EquipMenuFrameText
    JSL $@lib_text_render.PrintTextString
    LDA #$01
    STA $vram_upload_flags
    JSL $@lib_system_helpers.WaitVBlank
    JSR $&lib_menu_screen_setup.LoadMenuPalette
    JSR $&DrawEquipIconRows
    LDA #$02
    STA $vram_upload_flags
    JSL $@lib_system_helpers.WaitVBlank
    LDA #$01
    STA $vram_upload_flags
    JSL $@lib_system_helpers.WaitVBlank
    PLY 
    PLX 
    RTS 
}

---------------------------------------------
; Draws the item page (frame, palette and the 40 item icons) when the cursor enters the item row.
; 
; When: ChooseMenuRow, when the cursor moves onto row 3.
; Sees: the item grid (4 rows of 10, walkthrough items.md) in place of the weapon, armor and magic icons.
; Why: see RedrawEquipmentPage.
; In: JSR; M = 8.
; Out: prints ItemMenuFrameText, loads LoadItemPagePalette, draws DrawItemIconGrid and uploads BG3, the BG2 page and BG3 again, one frame each.
; Clobbers: A; X and Y are preserved.

DrawItemPage {
    PHX 
    PHY 
    LDY #$&ItemMenuFrameText
    JSL $@lib_text_render.PrintTextString
    LDA #$01
    STA $vram_upload_flags
    JSL $@lib_system_helpers.WaitVBlank
    JSR $&lib_menu_screen_setup.LoadItemPagePalette
    JSR $&DrawItemIconGrid
    LDA #$02
    STA $vram_upload_flags
    JSL $@lib_system_helpers.WaitVBlank
    LDA #$01
    STA $vram_upload_flags
    JSL $@lib_system_helpers.WaitVBlank
    PLY 
    PLX 
    RTS 
}

---------------------------------------------
; Lets the player move a marker through one equipment list and pick an item.
; 
; When: RunEquipmentMenu, rows Weapon, Armor and Magic (3 call sites).
; Sees: the icons with a blinking selection frame on the cursor, the name and description of the item under it (header window with the level and Strength for weapons, Defence for armors), and the frame stays on the confirmed item.
; Why: one loop for all three eight-slot lists; the header changes with the id range.
; In: JSR; M = 8; A = slot count (8), Y = list base ($1B1E, $1B26, $1B2E).
; Out: carry clear and A = the chosen slot byte and $7F (the id; 0 for an empty slot); the marker (bit 7) is set on the chosen slot; BRK #$18 on confirm. The cursor starts on the first slot with bit 7 or on slot 0. Header: WeaponDescHeaderText for ids 1-8, ArmorDescHeaderText for 9-$10, PlainDescHeaderText above; then the string DescriptionTextList[id]. The loop waits for all buttons to be up, then reads Right, Left, Down, Up (bits 0-3 of joy_pressed+1), skips Start and Select, and confirms on Y (bit 6) or B (bit 7).
; Clobbers: A, X, Y; dp$56/$57 (list pointer), menu_count, menu_blink, $7F0403 (backup); vram_upload_flags.

ChooseFromEquipmentList {
    STA $menu_count
    STY $0056
    STZ $menu_blink
    JSR $&BackupSlotList
    LDX #$0000
    TXY 

  loc_011DB3:
    LDA ($56), Y          ; Start the cursor on the equipped slot (bit 7); if none is marked, slot 0 gets the marker
    BMI loc_011DC6
    INY 
    CPY $menu_count
    BNE loc_011DB3
    LDY #$0000
    LDA ($56), Y
    ORA #$80
    STA ($56), Y

  loc_011DC6:
    JSR $&DrawEquipIconRows
    JSL $@lib_system_helpers.WaitVBlank
    PHY 
    REP #$20
    LDA ($56), Y
    AND #$007F
    PHA 
    BEQ loc_011DEF
    LDY #$&WeaponDescHeaderText
    CMP #$0009            ; Header by id: 1-8 weapon (level, strength), 9-$10 armor (defence), above that the plain window
    BCC loc_011DEB
    LDY #$&ArmorDescHeaderText
    CMP #$0011
    BCC loc_011DEB
    LDY #$&PlainDescHeaderText

  loc_011DEB:
    JSL $@lib_text_render.PrintTextString

  loc_011DEF:
    PLA 
    ASL 
    TAX 
    LDA $@DescriptionTextList, X ; Description string of the item under the cursor (index = id; 0 = empty)
    TAY 
    SEP #$20
    JSL $@lib_text_render.PrintTextString
    PLY 

  loc_011DFE:
    JSR $&lib_text_render.WaitFrameReadButtons ; Wait until all buttons are up (returns the high byte of joy_pressed), blinking the marker
    BEQ loc_011E0B
    JSR $&BlinkSelectionMarker
    JSR $&DrawEquipIconRows
    BRA loc_011DFE

  loc_011E0B:
    JSR $&lib_text_render.WaitFrameReadButtons
    LSR                   ; Right, Left, Down, Up are bits 0-3 of the high byte; Start and Select or X are skipped; Y (bit 6) and B (bit 7) confirm
    BCS MoveSelectionRight
    LSR 
    BCS MoveSelectionLeft
    LSR 
    BCS MoveSelectionDown
    LSR 
    BCS MoveSelectionUp
    LSR 
    LSR 
    LSR 
    BCS loc_011E2A
    LSR 
    BCS loc_011E2A
    JSR $&BlinkSelectionMarker
    JSR $&DrawEquipIconRows
    BRA loc_011E0B

  loc_011E2A:
    BRK #$18
    LDA ($56), Y
    ORA #$80
    STA ($56), Y
    JSR $&DrawEquipIconRows
    LDA #$01
    TSB $vram_upload_flags
    JSL $@lib_system_helpers.WaitVBlank
    LDA ($56), Y
    AND #$7F
    CLC 
    RTS 
}

---------------------------------------------
; Cancel path of the equipment list: restores the list and returns carry set. Unreferenced.
; 
; When: never (0 references; B and Y both confirm, OQ-I009-14).
; Sees: n/a.
; Why: left over from a version in which a key cancelled the choice.
; In: n/a.
; Out: BRK #$07, RestoreSlotList, DrawEquipIconRows, vram_upload_flags bit 0, WaitVBlank, SEC, RTS.
; Clobbers: n/a.

CancelEquipChoice {
    BRK #$07
    JSR $&RestoreSlotList
    JSR $&DrawEquipIconRows
    LDA #$01
    TSB $vram_upload_flags
    JSL $@lib_system_helpers.WaitVBlank
    SEC 
    RTS 

; Equipment list: moves the marker one column to the right (slot + 4) if it exists.
; 
; When: ChooseFromEquipmentList, Right pressed.
; Sees: the selection frame jumps to the next column.
; Why: the lists are two columns of four, column-major.
; In: Y = current slot, menu_count = slot count.
; Out: Y + 4 when below menu_count (X = old slot, then MoveSelectionMarker), else unchanged (back to the list loop).
; Clobbers: A, X, Y.

  MoveSelectionRight:
    TYA 
    CLC 
    ADC #$04              ; Two columns of four, column-major: Right = +4, Left = -4, Down = +1, Up = -1
    CMP $menu_count
    BCC loc_011E63
    BRL loc_011DC6

  loc_011E63:
    TYX 
    INY 
    INY 
    INY 
    INY 
    BRA MoveSelectionMarker

; Equipment list: moves the marker one column to the left (slot - 4) if it exists.
; 
; When: ChooseFromEquipmentList, Left pressed.
; Sees: the frame jumps to the previous column.
; Why: see MoveSelectionRight.
; In: Y = current slot.
; Out: Y - 4 when not negative, else unchanged.
; Clobbers: A, X, Y.

  MoveSelectionLeft:
    TYA 
    SEC 
    SBC #$04
    BPL loc_011E73
    BRL loc_011DC6

  loc_011E73:
    TYX 
    DEY 
    DEY 
    DEY 
    DEY 
    BRA MoveSelectionMarker

; Equipment list: moves the marker down one slot (slot + 1).
; 
; When: ChooseFromEquipmentList, Down pressed.
; Sees: the frame steps down; from the last slot of a column it goes to the top of the next column.
; Why: the column-major order makes the next slot the one below.
; In: Y = current slot.
; Out: Y + 1 when below menu_count, else unchanged.
; Clobbers: A, X, Y.

  MoveSelectionDown:
    TYA 
    INC 
    CMP $menu_count
    BCC loc_011E84
    BRL loc_011DC6

  loc_011E84:
    TYX 
    INY 
    BRA MoveSelectionMarker

; Equipment list: moves the marker up one slot (slot - 1).
; 
; When: ChooseFromEquipmentList, Up pressed.
; Sees: the frame steps up.
; Why: see MoveSelectionDown.
; In: Y = current slot.
; Out: Y - 1 when not negative (X = old slot through the TYX and DEY), else unchanged.
; Clobbers: A, X, Y.

  MoveSelectionUp:
    TYA 
    DEC 
    BPL loc_011E8F
    BRL loc_011DC6

  loc_011E8F:
    TYX 
    DEY 

; Equipment list: moves the marker bit from the old slot to the new one.
; 
; When: after every accepted move (BRA from the four move routines).
; Sees: the selection frame and the description change.
; Why: the marker is bit 7 of the slot byte, so a move sets it on the new slot and clears it on the old.
; In: X = old slot, Y = new slot, dp$56 = list.
; Out: BRK #$07; bit 7 set on Y's byte and cleared on X's, menu_blink = 0, one blink step, then back to redraw (BRL to the list loop).
; Clobbers: A.

  MoveSelectionMarker:
    BRK #$07
    PHY 
    LDA ($56), Y
    ORA #$80
    STA ($56), Y
    TXY 
    LDA ($56), Y
    AND #$7F
    STA ($56), Y
    STZ $menu_blink
    PLY 
    JSR $&BlinkSelectionMarker
    BRL loc_011DC6
}

---------------------------------------------
; Copies the list being chosen to $7F0403.
; 
; When: the start of ChooseFromEquipmentList and ChooseItemSlot.
; Sees: n/a.
; Why: so a cancel could restore the markers; only the unreferenced cancel paths read the copy.
; In: JSR; M = 8; dp$56 = list, menu_count = bytes.
; Out: menu_count bytes copied to $7F0403.
; Clobbers: A, X, Y.

BackupSlotList {
    LDX #$0000
    TXY 

  loc_011EAF:
    LDA ($56), Y
    STA $7F0403, X
    INY 
    INX 
    CPX $menu_count
    BNE loc_011EAF
    RTS 
}

---------------------------------------------
; Copies the backup at $7F0403 back over the list.
; 
; When: only CancelEquipChoice and CancelItemChoice (both unreferenced).
; Sees: n/a.
; Why: see BackupSlotList.
; In: as BackupSlotList.
; Out: menu_count bytes copied from $7F0403 to the list.
; Clobbers: A, X, Y.

RestoreSlotList {
    LDX #$0000
    TXY 

  loc_011EC1:
    LDA $7F0403, X
    STA ($56), Y
    INY 
    INX 
    CPX $menu_count
    BNE loc_011EC1
    RTS 
}

---------------------------------------------
; Makes the marker bit of the current slot blink.
; 
; When: 6 call sites in the two list choosers and MoveSelectionMarker, once per frame while waiting.
; Sees: the selection frame is visible 24 of every 32 frames and hidden for 8.
; Why: the blink shows which slot is active.
; In: Y = slot, dp$56 = list.
; Out: bit 7 of the slot set while menu_blink and $1F is below $18, cleared otherwise; menu_blink += 1; vram_upload_flags bit 0 set.
; Clobbers: A.

BlinkSelectionMarker {
    LDA $menu_blink
    AND #$1F
    CMP #$18              ; Marker shown for 24 of every 32 calls, hidden for 8
    BCC loc_011EDE
    LDA ($56), Y
    AND #$7F
    BRA loc_011EE2

  loc_011EDE:
    LDA ($56), Y
    ORA #$80

  loc_011EE2:
    STA ($56), Y
    INC $menu_blink
    LDA #$01
    TSB $vram_upload_flags
    RTS 
}

---------------------------------------------
; Recomputes the gear part of Strength and Defence from the equipped weapon and armor.
; 
; When: RunEquipmentMenu after a weapon or an armor was chosen.
; Sees: the Strength and Defence bars of the status screen change (walkthrough items.md weapon and armor tables).
; Why: gear_power and gear_defense are stored sums that the combat code reads.
; In: M = 8, X = 16; equipped_weapon, equipped_armor.
; Out: gear_power = GearStatTable[weapon] + GearStatTable[armor]; gear_defense = GearStatTable[weapon + $11] + GearStatTable[armor + $11] (the weapon rows of the second half and the armor rows of the first are 0).
; Clobbers: A, X.

RecalcGearStats {
    LDX $equipped_weapon
    LDA $@GearStatTable, X
    STA $gear_power
    LDA $@GearStatTable+11, X ; +$11: the defence half of the table (17 bytes per row)
    STA $gear_defense
    LDX $equipped_armor
    LDA $@GearStatTable, X
    CLC 
    ADC $gear_power
    STA $gear_power
    LDA $@GearStatTable+11, X
    CLC 
    ADC $gear_defense
    STA $gear_defense
    RTS 
}

---------------------------------------------
; Draws the 8 weapon, 8 armor and 8 magic icons.
; 
; When: RunEquipmentMenu, RedrawEquipmentPage and every blink frame of ChooseFromEquipmentList (7 call sites).
; Sees: the three icon rows of the equipment page with the selection frame on equipped or chosen items.
; Why: redrawing all 24 is simpler than tracking one icon; the BG buffers are small.
; In: JSR; M = 16 is set inside (P restored).
; Out: DrawInventoryIcon for each slot of inventory $1B1E, $1B26, $1B2E at the positions of WeaponIconPositions, ArmorIconPositions and MagicIconPositions (the 16-bit load also reads the next slot's byte, which DrawInventoryIcon ignores).
; Clobbers: A, X (= 8 at the end); Y and P are restored.

DrawEquipIconRows {
    PHP 
    PHY 
    REP #$20
    LDX #$0000

  loc_011F1F:
    PHX 
    TXA 
    ASL 
    TAX 
    LDA $&data_engine_tables.WeaponIconPositions, X
    TAY 
    PLX 
    LDA $inventory, X
    JSR $&DrawInventoryIcon
    INX 
    CPX #$0008
    BNE loc_011F1F
    LDX #$0000

  loc_011F37:
    PHX 
    TXA 
    ASL 
    TAX 
    LDA $&data_engine_tables.ArmorIconPositions, X
    TAY 
    PLX 
    LDA $1B26, X
    JSR $&DrawInventoryIcon
    INX 
    CPX #$0008
    BNE loc_011F37
    LDX #$0000

  loc_011F4F:
    PHX 
    TXA 
    ASL 
    TAX 
    LDA $&data_engine_tables.MagicIconPositions, X
    TAY 
    PLX 
    LDA $1B2E, X
    JSR $&DrawInventoryIcon
    INX 
    CPX #$0008
    BNE loc_011F4F
    PLY 
    PLP 
    RTS 
}

---------------------------------------------
; Draws one 2x2 icon with an optional selection frame.
; 
; When: DrawEquipIconRows (24 times per call) and DrawItemIconGrid (40 times).
; Sees: an item icon; a frame of four tiles around it when the slot has bit 7 (equipped or under the cursor); an empty slot shows blank cells.
; Why: the frame is on BG3 (text layer) and the icon on BG2, so the cursor can blink without redrawing the icon.
; In: JSR; M = 16; A = the word loaded from the slot (slot byte in the low byte, the next byte in the high byte), Y = BG byte offset of the top-left cell.
; Out: BG3 page cells at Y: with bit 7 the frame tile $2A (attribute or $0C = palette 3; top-right flipped H, bottom-left V, bottom-right H and V), else four zero cells; BG2 page at $7F7800 + Y: the four words of IconTileRecords[id x 8] (id = slot byte and $7F). DBR is $7F inside.
; Clobbers: A (M = 16 on return); X, DBR and P preserved.

DrawInventoryIcon {
    PHB 
    PHX 
    XBA 
    TAX 
    SEP #$20
    PHP 
    LDA #$7F
    PHA 
    PLB 
    PLP 
    BMI loc_011F85        ; N = bit 7 of the slot byte: it reached X.high through XBA and TAX, PHP saved N and PLP restores it after PLB changed the flags
    LDA #$00
    STA $S_bg3_tilemap_buffer, Y
    STA $7002, Y
    STA $7040, Y
    STA $7042, Y
    BRA loc_011FAA

  loc_011F85:
    LDA #$2A
    STA $S_bg3_tilemap_buffer, Y
    STA $7002, Y
    STA $7040, Y
    STA $7042, Y
    LDA $7001, Y
    ORA #$0C              ; Attribute bits $0C = palette 3; the next three cells flip it: EOR $40 (H), EOR $C0 (V without H), EOR $40 (H and V)
    STA $7001, Y
    EOR #$40
    STA $7003, Y
    EOR #$C0
    STA $7041, Y
    EOR #$40
    STA $7043, Y

  loc_011FAA:
    REP #$20
    XBA                   ; A.low = slot byte again; mask the marker, id x 8 = index of the 4-word icon record
    AND #$007F
    ASL 
    ASL 
    ASL 
    TAX 
    LDA $@data_iris_and_icon_tiles.IconTileRecords, X
    STA $7800, Y
    LDA $@data_iris_and_icon_tiles.IconTileRecords+2, X
    STA $7802, Y
    LDA $@data_iris_and_icon_tiles.IconTileRecords+4, X
    STA $7840, Y
    LDA $@data_iris_and_icon_tiles.IconTileRecords+6, X
    STA $7842, Y
    PLX 
    PLB 
    RTS 
}

---------------------------------------------
; Draws the 40 item icons.
; 
; When: DrawItemPage and every blink frame of ChooseItemSlot (6 call sites).
; Sees: the item grid.
; Why: as DrawEquipIconRows.
; In: JSR; M = 16 is set inside.
; Out: DrawInventoryIcon for each slot of $1B36 at the positions of ItemIconPositions.
; Clobbers: A, X (= $28 at the end); Y and P restored.

DrawItemIconGrid {
    PHP 
    PHY 
    REP #$20
    LDX #$0000

  loc_011FDA:
    PHX 
    TXA 
    ASL 
    TAX 
    LDA $&data_engine_tables.ItemIconPositions, X
    TAY 
    PLX 
    LDA $1B36, X
    JSR $&DrawInventoryIcon
    INX 
    CPX #$0028
    BNE loc_011FDA
    PLY 
    PLP 
    RTS 
}

---------------------------------------------
; Lets the player move a marker through the 40 item slots and pick one.
; 
; When: RunEquipmentMenu, row Item.
; Sees: the item grid with the blinking frame; the item name and its description appear under the cursor (e.g. 'Delicious Seeds', 'Goat s Food').
; Why: same loop as ChooseFromEquipmentList for the 4 x 10 grid; the header is always the plain window.
; In: JSR; M = 8; A = $28 (slot count), Y = $1B36.
; Out: as ChooseFromEquipmentList: carry clear and A = id (0 for an empty slot); BRK #$18 on confirm; B and Y confirm.
; Clobbers: A, X, Y; dp$56/$57, menu_count, menu_blink, $7F0403.

ChooseItemSlot {
    STA $menu_count
    STY $0056
    STZ $menu_blink
    JSR $&BackupSlotList
    LDX #$0000
    TXY 

  loc_012002:
    LDA ($56), Y
    BMI loc_012015
    INY 
    CPY $menu_count
    BNE loc_012002
    LDY #$0000
    LDA ($56), Y
    ORA #$80
    STA ($56), Y

  loc_012015:
    JSR $&DrawItemIconGrid
    JSL $@lib_system_helpers.WaitVBlank
    PHY 
    REP #$20
    LDA ($56), Y
    AND #$007F
    BEQ loc_01202F
    PHA 
    LDY #$&PlainDescHeaderText
    JSL $@lib_text_render.PrintTextString
    PLA 

  loc_01202F:
    ASL 
    TAX 
    LDA $@DescriptionTextList, X
    TAY 
    SEP #$20
    JSL $@lib_text_render.PrintTextString
    PLY 

  loc_01203D:
    JSR $&lib_text_render.WaitFrameReadButtons
    BEQ loc_01204A
    JSR $&BlinkSelectionMarker
    JSR $&DrawItemIconGrid
    BRA loc_01203D

  loc_01204A:
    JSR $&lib_text_render.WaitFrameReadButtons
    LSR 
    BCS MoveItemSelectionRight
    LSR 
    BCC loc_012056
    BRL MoveItemSelectionLeft

  loc_012056:
    LSR 
    BCS MoveItemSelectionDown
    LSR 
    BCS MoveItemSelectionUp
    LSR 
    LSR 
    LSR 
    BCS loc_01206C
    LSR 
    BCS loc_01206C
    JSR $&BlinkSelectionMarker
    JSR $&DrawItemIconGrid
    BRA loc_01204A

  loc_01206C:
    BRK #$18
    LDA ($56), Y
    ORA #$80
    STA ($56), Y
    JSR $&DrawItemIconGrid
    LDA #$01
    TSB $vram_upload_flags
    JSL $@lib_system_helpers.WaitVBlank
    LDA ($56), Y
    AND #$7F
    CLC 
    RTS 
}

---------------------------------------------
; Cancel path of the item list. Unreferenced.
; 
; When: never (0 references, OQ-I009-14).
; Sees: n/a.
; Why: see CancelEquipChoice.
; In: n/a.
; Out: BRK #$07, RestoreSlotList, DrawItemIconGrid, vram_upload_flags bit 0, WaitVBlank, SEC, RTS.
; Clobbers: n/a.

CancelItemChoice {
    BRK #$07
    JSR $&RestoreSlotList
    JSR $&DrawItemIconGrid
    LDA #$01
    TSB $vram_upload_flags
    JSL $@lib_system_helpers.WaitVBlank
    SEC 
    RTS 

; Item list: moves the marker one row down (slot + 10).
; 
; When: ChooseItemSlot, Down pressed.
; Sees: the frame moves down one row of ten.
; Why: the grid is row-major.
; In: Y = slot.
; Out: Y + 10 when below menu_count, else unchanged.
; Clobbers: A, X, Y.

  MoveItemSelectionDown:
    TYA 
    CLC 
    ADC #$0A              ; Four rows of ten, row-major: Down = +10, Up = -10, Right = +1, Left = -1
    CMP $menu_count
    BCC loc_0120A5
    BRL loc_012015

  loc_0120A5:
    TYX 
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    BRA MoveItemSelectionMarker

; Item list: moves the marker one row up (slot - 10).
; 
; When: ChooseItemSlot, Up pressed.
; Sees: the frame moves up.
; Why: see MoveItemSelectionDown.
; In: Y = slot.
; Out: Y - 10 when not negative.
; Clobbers: A, X, Y.

  MoveItemSelectionUp:
    TYA 
    SEC 
    SBC #$0A
    BPL loc_0120BB
    BRL loc_012015

  loc_0120BB:
    TYX 
    DEY 
    DEY 
    DEY 
    DEY 
    DEY 
    DEY 
    DEY 
    DEY 
    DEY 
    DEY 
    BRA MoveItemSelectionMarker

; Item list: moves the marker one slot right (slot + 1).
; 
; When: ChooseItemSlot, Right pressed.
; Sees: the frame moves right; from the end of a row it goes to the start of the next.
; Why: row-major order.
; In: Y = slot.
; Out: Y + 1 when below menu_count.
; Clobbers: A, X, Y.

  MoveItemSelectionRight:
    TYA 
    INC 
    CMP $menu_count
    BCC loc_0120D2
    BRL loc_012015

  loc_0120D2:
    TYX 
    INY 
    BRA MoveItemSelectionMarker

; Item list: moves the marker one slot left (slot - 1).
; 
; When: ChooseItemSlot, Left pressed (BRL).
; Sees: the frame moves left; from the start of a row it goes to the end of the previous.
; Why: see MoveItemSelectionRight.
; In: Y = slot.
; Out: Y - 1 when not negative.
; Clobbers: A, X, Y.

  MoveItemSelectionLeft:
    TYA 
    DEC 
    BPL loc_0120DD
    BRL loc_012015

  loc_0120DD:
    TYX 
    DEY 

; Item list: moves the marker bit from the old slot to the new one.
; 
; When: after every accepted move in ChooseItemSlot.
; Sees: the frame and description change.
; Why: as MoveSelectionMarker.
; In: X = old slot, Y = new slot, dp$56 = list.
; Out: BRK #$07; bit 7 set on Y, cleared on X; menu_blink = 0; one blink step; back to the list loop (BRL).
; Clobbers: A.

  MoveItemSelectionMarker:
    BRK #$07
    PHY 
    LDA ($56), Y
    ORA #$80
    STA ($56), Y
    TXY 
    LDA ($56), Y
    AND #$7F
    STA ($56), Y
    STZ $menu_blink
    PLY 
    JSR $&BlinkSelectionMarker
    BRL loc_012015
}
---------------------------------------------

; Fills the whole BG3 text page ($7F7000, 1024 words) with the blank tile.
; 
; When: ShowStatusAndSoulsScreen, OpenEquipmentMenu (on the way in and out) and RunEquipmentMenu.
; Sees: all text of the page vanishes.
; Why: the BG3 buffer is the single text layer shared by the HUD and every window.
; In: JSR; any M.
; Out: every word of the page = $2000 (tile 0, priority); DBR is $7F while it runs, so the TSB of bit 0 at the end reaches $7F:03B8, not vram_upload_flags (OQ-I027-1; the callers set the upload flag themselves afterwards); P and DBR restored.
; Clobbers: A, X.

ClearBg3Page {
    PHP 
    PHB 
    SEP #$20
    LDA #$7F
    PHA 
    PLB 
    REP #$20
    LDA #$2000            ; Tile 0 with the priority bit
    LDX #$07FE

  loc_012360:
    STA $S_bg3_tilemap_buffer, X
    DEX 
    DEX 
    BPL loc_012360
    LDA #$0001
    TSB $03B8             ; BG3 upload bit, but DBR is $7F here: this sets bit 0 of $7F:03B8, not vram_upload_flags (OQ-I027-1)
    PLB 
    PLP 
    RTS 
}

---------------------------------------------
; Fills the upper half of the BG3 page (512 words) with the blank tile.
; 
; When: RedrawEquipmentPage.
; Sees: the upper window area is cleared while the lower lines of the equipment page stay.
; Why: the equipped-item lines live in the lower half and are reprinted separately.
; In: JSR; any M.
; Out: words $7000-$73FE = $2000; the same $7F:03B8 TSB as ClearBg3Page (OQ-I027-1); P and DBR restored.
; Clobbers: A, X.

ClearBg3UpperHalf {
    PHP 
    PHB 
    SEP #$20
    LDA #$7F
    PHA 
    PLB 
    REP #$20
    LDA #$2000
    LDX #$03FE

  loc_012380:
    STA $S_bg3_tilemap_buffer, X
    DEX 
    DEX 
    BPL loc_012380
    LDA #$0001
    TSB $03B8             ; Same TSB as in ClearBg3Page: reaches $7F:03B8 with DBR = $7F (OQ-I027-1)
    PLB 
    PLP 
    RTS 
}
---------------------------------------------

; Copies the 512-byte CGRAM buffer to $7E6000.
; 
; When: OpenEquipmentMenu.
; Sees: n/a.
; Why: the menu rewrites palettes; the field's colours are restored on exit.
; In: JSR.
; Out: cgram_buffer (512 bytes) copied to $7E6000-$7E61FF.
; Clobbers: A (P and X restored).

SaveCgramBuffer {
    PHP 
    PHX 
    REP #$20
    LDX #$01FE

  loc_0123F1:
    LDA $cgram_buffer, X
    STA $7E6000, X
    DEX 
    DEX 
    BPL loc_0123F1
    PLX 
    PLP 
    RTS 
}

---------------------------------------------
; Copies the backup at $7E6000 back over the CGRAM buffer.
; 
; When: OpenEquipmentMenu on exit, after RestoreSceneBgGfxAndPalette.
; Sees: the field's colours return.
; Why: see SaveCgramBuffer.
; In: JSR.
; Out: $7E6000 copied to cgram_buffer (the whole buffer, including palettes 11-15 that RestoreSceneBgGfxAndPalette just wrote; LoadEquippedMagicGfx then puts the spell palette on top).
; Clobbers: A (P and X restored).

RestoreCgramBuffer {
    PHP 
    PHX 
    REP #$20
    LDX #$01FE

  loc_012407:
    LDA $7E6000, X
    STA $cgram_buffer, X
    DEX 
    DEX 
    BPL loc_012407
    PLX 
    PLP 
    RTS 
}
---------------------------------------------

; The status page of the A-button screen.
; 
; When: ShowStatusAndSoulsScreen (once).
; Sees: a window at $186 (23 x 19) with the player name at $20C ([02:2] = the string at $1B92), 'HP' with HP / maximum HP (3 BCD digits each), 'Next level :' with 8 digits at $2A6, 'Strength :' and 'Defence  :' with two bars each ([0B:26,1B72] over [0B:26,1B70], [0B:27,1B76] over [0B:27,1B74]) and 'Weapon: ', 'Armor : ', 'Magic : ', 'Item  : ' with the equipped names ([TBL:&ItemNameList,1B5E..1B64]).
; Why: one string draws the page; the numbers come from WRAM through the control codes.
; In: n/a (data). Starts by erasing the name area ([CUR:216][14:A]).
; Out: n/a. The '-' glyph in the extract is the period glyph.
; Clobbers: n/a.

StatusScreenText |[CUR:216][14:A][CUR:186][07:17,13][03:20][CUR:20C][02:2][CUR:222]HP[CUR:228][06:3,1B6C]/[CUR:230][06:3,1B6E][CUR:288]Next level :[CUR:2A6][06:8,1B7C][CUR:31E][0B:26,1B72][CUR:35E][0B:26,1B70][CUR:348]Strength :[CUR:3DE][0B:27,1B76][CUR:41E][0B:27,1B74][CUR:408]Defence  :[CUR:4C8]Weapon: [TBL:&ItemNameList,1B5E][CUR:548]Armor : [TBL:&ItemNameList,1B60][CUR:5C8]Magic : [TBL:&ItemNameList,1B62][CUR:648]Item  : [TBL:&ItemNameList,1B64]|

---------------------------------------------
; The souls page title and window.
; 
; When: ShowStatusAndSoulsScreen, after the first press.
; Sees: the status window is erased ([08:186]) and a window at $18A (18 x 19) with 'Souls' at $258 appears.
; Why: the souls page replaces the status page in the same place.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

SoulsScreenTitleText |[08:186][CUR:18A][07:12,13][CUR:258]Souls|

---------------------------------------------
; The five soul lines ('Soul of Magician' here, then Light, Shield, Detection, Reality in the adjacent strings).
; 
; When: DrawRecruitedSouls, one line per set bit of souls_flags.
; Sees: a line at $30E (Magician), $3CE (Light), $48E (Shield), $54E (Detection), $60E (Reality), $C0 apart.
; Why: all five lines are 21 bytes ([CUR:o] and 18 characters padded with blanks), so the walk steps by $15.
; In: n/a (data). The extractor prints the word gaps and the padding as a block character.
; Out: n/a.
; Clobbers: n/a.

SoulOfMagicianText |[CUR:30E]Soul█of█Magician█|
---------------------------------------------

SoulOfLightText |[CUR:3CE]Soul█of█Light████|
---------------------------------------------

SoulOfShieldText |[CUR:48E]Soul█of█Shield███|
---------------------------------------------

SoulOfDetectionText |[CUR:54E]Soul█of█Detection|
---------------------------------------------

SoulOfRealityText |[CUR:60E]Soul█of█Reality██|
---------------------------------------------

; The frame of the equipment page.
; 
; When: RunEquipmentMenu, RedrawEquipmentPage and OpenEquipmentMenu (7 uses, six of them from the [::] marker with +M).
; Sees: the tab boxes 'Weapon', 'Armor', 'Magic' (6 x 12 at $88, $98, $A8), the description window at $408 (22 x 8) and four lines ' Wep-: ', ' Arm-: ', ' Mag-: ', ' Item: ' at $48A, $50A, $58A, $60A with the equipped names ([TBL:...,1B5E..1B64]); the walkthrough writes 'Wep.', the extractor prints the period glyph as '-'.
; Why: the part after [::] is reprinted alone after each choice, so the tabs are not redrawn.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

EquipMenuFrameText |[CUR:88][07:6,C]Weapon[CUR:98][07:6,C]Armor[CUR:A8][07:6,C]Magic[::][CUR:408][07:16,8][CUR:48A] Wep-: [TBL:&ItemNameList,1B5E][N][N] Arm-: [TBL:&ItemNameList,1B60][N][N] Mag-: [TBL:&ItemNameList,1B62][N][N] Item: [TBL:&ItemNameList,1B64]|

---------------------------------------------
; The frame of the item page.
; 
; When: DrawItemPage.
; Sees: a 22 x 12 box at $88 with the title 'Item'.
; Why: the item grid needs a larger box than the equipment page.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

ItemMenuFrameText |[CUR:88][07:16,C]Item|
---------------------------------------------

; Pointer list of the 65 item name strings, indexed by item id (0 = 'not equipped').
; 
; When: every [TBL:&ItemNameList,addr] print: the four equipped names of StatusScreenText and of EquipMenuFrameText, the first line of the description records (through NameIndexCells), and ChestItemReceivedText (text_arg = the item id the chest holds).
; Sees: the item name on the status screen, in the equipment menu and in 'recieved' chest messages.
; Why: the item id doubles as the inventory slot id and as the string number, so the equipped cells ($1B5E-$1B64) and the chest content byte are used as the index with no conversion. The empty equipment slot is id 0, whose name is 'not equipped'.
; In: n/a (data). 65 words (ids $00-$40), each the address of an ASCII string in bank $02 (the ItemName parts that follow, 752 bytes in total).
; Out: n/a. Ids: $01-$08 swords, $09-$10 armors, $11-$18 magic, $19-$40 items (the grouping of docs/walkthrough/items.md). Some strings use dictionary bytes (so their size is below the printed length plus one, for example 'not equipped' = 'not ' and 'equipped' in 10 bytes). The ROM text differs from the walkthrough in a few places (the four possessive names print a blank where the walkthrough has an apostrophe, the emblems read 'Emblem A' to 'Emblem H' without 'Master s', id $26 reads 'Leaves' like id $1E, articles and capitals differ): OQ-I004-6, OQ-I027-3; the labels keep the id and the string keeps the ROM text.
; Clobbers: n/a.

ItemNameList [
  &ItemName00   ;00
  &ItemName01   ;01
  &ItemName02   ;02
  &ItemName03   ;03
  &ItemName04   ;04
  &ItemName05   ;05
  &ItemName06   ;06
  &ItemName07   ;07
  &ItemName08   ;08
  &ItemName09   ;09
  &ItemName0A   ;0A
  &ItemName0B   ;0B
  &ItemName0C   ;0C
  &ItemName0D   ;0D
  &ItemName0E   ;0E
  &ItemName0F   ;0F
  &ItemName10   ;10
  &ItemName11   ;11
  &ItemName12   ;12
  &ItemName13   ;13
  &ItemName14   ;14
  &ItemName15   ;15
  &ItemName16   ;16
  &ItemName17   ;17
  &ItemName18   ;18
  &ItemName19   ;19
  &ItemName1A   ;1A
  &ItemName1B   ;1B
  &ItemName1C   ;1C
  &ItemName1D   ;1D
  &ItemName1E   ;1E
  &ItemName1F   ;1F
  &ItemName20   ;20
  &ItemName21   ;21
  &ItemName22   ;22
  &ItemName23   ;23
  &ItemName24   ;24
  &ItemName25   ;25
  &ItemName26   ;26
  &ItemName27   ;27
  &ItemName28   ;28
  &ItemName29   ;29
  &ItemName2A   ;2A
  &ItemName2B   ;2B
  &ItemName2C   ;2C
  &ItemName2D   ;2D
  &ItemName2E   ;2E
  &ItemName2F   ;2F
  &ItemName30   ;30
  &ItemName31   ;31
  &ItemName32   ;32
  &ItemName33   ;33
  &ItemName34   ;34
  &ItemName35   ;35
  &ItemName36   ;36
  &ItemName37   ;37
  &ItemName38   ;38
  &ItemName39   ;39
  &ItemName3A   ;3A
  &ItemName3B   ;3B
  &ItemName3C   ;3C
  &ItemName3D   ;3D
  &ItemName3E   ;3E
  &ItemName3F   ;3F
  &ItemName40   ;40
]

---------------------------------------------
; Name of id 0: the empty equipment slot.
; 
; When: printed through ItemNameList whenever an equipped cell holds 0 (nothing equipped, or an empty slot confirmed in the equipment menu).
; Sees: 'not equipped' on the status screen and next to Wep- / Arm- / Mag- / Item in the equipment menu.
; Why: id 0 is 'no item', so the same table serves empty and filled slots.
; In: n/a (data). 'not ' is a dictionary byte, then 'equipped'.
; Out: n/a.
; Clobbers: n/a.

ItemName00 |not equipped|

ItemName01 |Sword of Life|

ItemName02 |Psycho Sword|

ItemName03 |Critical Sword|

ItemName04 |Lucky Blade|

ItemName05 |Zantetsu Sword|

ItemName06 |Spirit Sword|

ItemName07 |Recovery Sword|

ItemName08 |The Soul Blade|

ItemName09 |Iron Armor|

ItemName0A |Ice Armor|

ItemName0B |Bubble Armor|

ItemName0C |Magic Armor|

ItemName0D |Mystic Armor|

ItemName0E |Light Armor|

ItemName0F |Elemental Mail|

ItemName10 |Soul Armor|

ItemName11 |Flame Ball|

ItemName12 |Light Arrow|

ItemName13 |Magic Flair|

ItemName14 |Rotator|

ItemName15 |Spark Bomb|

ItemName16 |Flame Pillar|

ItemName17 |Tornado|

ItemName18 |Phoenix|

ItemName19 |Goat s Food|

ItemName1A |Harp string|

ItemName1B |a pass|

ItemName1C |Dream Rod|

ItemName1D |Leo s brush|

ItemName1E |Leaves|

ItemName1F |Mole s Ribbon|

ItemName20 |the Big Pearl|

ItemName21 |Mermaid s Tears|

ItemName22 |Mushroom Shoes|

ItemName23 |a mobile key|

ItemName24 |Thunder Ring|

ItemName25 |Delicious Seeds|

---------------------------------------------
; Name of id $26: the second item printed 'Leaves'.
; 
; When: printed through ItemNameList for the item id $26.
; Sees: 'Leaves', the same text as id $1E (ItemName1E).
; Why: unknown; the walkthrough lists id $1E as 'Leaves' and this item as 'Actinidia Leaves'.
; In: n/a (data).
; Out: n/a. The ROM text is kept as printed (OQ-I004-6).
; Clobbers: n/a.

ItemName26 |Leaves|

ItemName27 |a door key|

ItemName28 |Platinum Card|

ItemName29 |the VIP Card|

ItemName2A |Emblem A|

ItemName2B |Emblem B|

ItemName2C |Emblem C|

ItemName2D |Emblem D|

ItemName2E |Emblem E|

ItemName2F |Emblem F|

ItemName30 |Emblem G|

ItemName31 |Emblem H|

ItemName32 |Red+Hot Mirror|

ItemName33 |Red+Hot Ball|

ItemName34 |Red+Hot Stick|

ItemName35 |Power Bracelet|

ItemName36 |Shield Bracelet|

ItemName37 |Super Bracelet|

ItemName38 |Medical Herb|

ItemName39 |Strange Bottle|

ItemName3A |Brown Stone|

ItemName3B |Green Stone|

ItemName3C |Blue Stone|

ItemName3D |Silver Stone|

ItemName3E |Purple Stone|

ItemName3F |Black Stone|

ItemName40 |Magic Bell|
---------------------------------------------

; Description window header for weapons: the window with 'Lev:' and 'Strength:'.
; 
; When: ChooseFromEquipmentList for item ids 1-8.
; Sees: a 22 x 8 window at $408 with 'Lev:' at $4AA and 'Strength:' at $50A; the record then prints the minimum level and the strength bar.
; Why: weapons show the minimum swing level and the Strength bonus.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

WeaponDescHeaderText |[CUR:408][07:16,8][CUR:4AA]Lev:[CUR:50A]Strength:|

---------------------------------------------
; Description window header for armors: the window with 'Defence :'.
; 
; When: ChooseFromEquipmentList for item ids 9-$10.
; Sees: the window at $408 with 'Defence :' at $50A.
; Why: armors show the Defence bonus.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

ArmorDescHeaderText |[CUR:408][07:16,8][CUR:50A]Defence :|

---------------------------------------------
; Description window header without stats: the blank window only.
; 
; When: ChooseFromEquipmentList for ids $11 and up, ChooseItemSlot for every item.
; Sees: the empty 22 x 8 window at $408; the record prints the name and text.
; Why: magic and items have no level or bar.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

PlainDescHeaderText |[CUR:408][07:16,8]|
---------------------------------------------

; Pointer table of the 65 item description strings, indexed by item id.
; 
; When: ChooseFromEquipmentList and ChooseItemSlot (index = id x 2, long read).
; Sees: the description window text under the cursor.
; Why: one pointer per id so any item can be described without a search.
; In: n/a (data). 65 words, entry 0 = the empty window (DescEmpty), entries $01-$40 = the items in id order (weapons, armors, magic, then the 40 grid items; Desc names follow the walkthrough names).
; Out: n/a. The record layout, stub records and the stat tables are in the lib_menus block note.
; Clobbers: n/a.

DescriptionTextList [
  &DescEmpty   ;00
  &DescSwordOfLife   ;01
  &DescPsychoSword   ;02
  &DescCriticalSword   ;03
  &DescLuckyBlade   ;04
  &DescZantetsuSword   ;05
  &DescSpiritSword   ;06
  &DescRecoverySword   ;07
  &DescSoulBlade   ;08
  &DescIronArmor   ;09
  &DescIceArmor   ;0A
  &DescBubbleArmor   ;0B
  &DescMagicArmor   ;0C
  &DescMysticArmor   ;0D
  &DescLightArmor   ;0E
  &DescElementalMail   ;0F
  &DescSoulArmor   ;10
  &DescFlameBall   ;11
  &DescLightArrow   ;12
  &DescMagicFlair   ;13
  &DescRotator   ;14
  &DescSparkBomb   ;15
  &DescFlamePillar   ;16
  &DescTornado   ;17
  &DescPhoenix   ;18
  &DescGoatsFood   ;19
  &DescHarpString   ;1A
  &DescAPass   ;1B
  &DescDreamRod   ;1C
  &DescLeosBrush   ;1D
  &DescLeaves   ;1E
  &DescMolesRibbon   ;1F
  &DescBigPearl   ;20
  &DescMermaidsTears   ;21
  &DescMushroomShoes   ;22
  &DescMobileKey   ;23
  &DescThunderRing   ;24
  &DescDeliciousSeeds   ;25
  &DescActinidiaLeaves   ;26
  &DescDoorKey   ;27
  &DescPlatinumCard   ;28
  &DescVipCard   ;29
  &DescMastersEmblemA   ;2A
  &DescMastersEmblemB   ;2B
  &DescMastersEmblemC   ;2C
  &DescMastersEmblemD   ;2D
  &DescMastersEmblemE   ;2E
  &DescMastersEmblemF   ;2F
  &DescMastersEmblemG   ;30
  &DescMastersEmblemH   ;31
  &DescRedHotMirror   ;32
  &DescRedHotBall   ;33
  &DescRedHotStick   ;34
  &DescPowerBracelet   ;35
  &DescShieldBracelet   ;36
  &DescSuperBracelet   ;37
  &DescMedicalHerb   ;38
  &DescStrangeBottle   ;39
  &DescBrownStone   ;3A
  &DescGreenStone   ;3B
  &DescBlueStone   ;3C
  &DescSilverStone   ;3D
  &DescPurpleStone   ;3E
  &DescBlackStone   ;3F
  &DescMagicBell   ;40
]

---------------------------------------------
; Description of the empty slot (id 0): the blank 22 x 8 window only.
; 
; When: DescriptionTextList[0], for a slot the player does not own.
; Sees: an empty description window.
; Why: an empty slot has nothing to say.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

DescEmpty |[CUR:408][07:16,8]|

DescSwordOfLife |[CUR:48A][TBL:&ItemNameList,&NameIndexCells][CUR:4B2][06:2,&WeaponMinLevelBcd][CUR:51E][0B:26,&GearStatTable+1][CUR:58A]A sword from the [N][N]Master- |

---------------------------------------------
; Description of the Psycho Sword (id $02).
; 
; When: the cursor is on the Psycho Sword.
; Sees: 'Lev 5', one strength bar and 'Invincible monsters temporarily paralyzed'; items.md lists no special effect for it (OQ-I009-3).
; Why: text for the weapon; the effect is in the combat code (engine_actor_scheduler_and_sprites).
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

DescPsychoSword |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+2][CUR:4B2][06:2,&WeaponMinLevelBcd+2][CUR:51E][0B:26,&GearStatTable+2][CUR:58A]Invincible monsters [N][N]temporarily paralyzed-|

DescCriticalSword |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+4][CUR:4B2][06:2,&WeaponMinLevelBcd+4][CUR:51E][0B:26,&GearStatTable+3][CUR:58A]Defeats monsters [N][N]at once- |

DescLuckyBlade |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+6][CUR:4B2][06:2,&WeaponMinLevelBcd+6][CUR:51E][0B:26,&GearStatTable+4][CUR:58A]The chance of getting [N][N]larger GEMs increases-|

DescZantetsuSword |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+8][CUR:4B2][06:2,&WeaponMinLevelBcd+8][CUR:51E][0B:26,&GearStatTable+5][CUR:58A]Defeats monsters with [N][N]special armor- |

DescSpiritSword |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+A][CUR:4B2][06:2,&WeaponMinLevelBcd+A][CUR:51E][0B:26,&GearStatTable+6][CUR:58A]Defeats the "spiritˮ [N][N]type monsters- |

DescRecoverySword |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+C][CUR:4B2][06:2,&WeaponMinLevelBcd+C][CUR:51E][0B:26,&GearStatTable+7][CUR:58A]HP will be filled when[N][N]monster is defeated- |

DescSoulBlade |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+E][CUR:4B2][06:2,&WeaponMinLevelBcd+E][CUR:51E][0B:26,&GearStatTable+8][CUR:58A]The strongest sword [N][N]you may use- |

DescIronArmor |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+10][CUR:51E][0B:27,&GearStatTable+1A][CUR:58A]Your defense power [N][N]becomes stronger- |

DescIceArmor |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+12][CUR:51E][0B:27,&GearStatTable+1B][CUR:58A]you can cross [N][N]fire without damage- |

DescBubbleArmor |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+14][CUR:51E][0B:27,&GearStatTable+1C][CUR:58A]Enables you to walk [N][N]under the sea- |

DescMagicArmor |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+16][CUR:51E][0B:27,&GearStatTable+1D][CUR:58A]Cuts the necessary [N][N]GEMs in half- |

DescMysticArmor |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+18][CUR:51E][0B:27,&GearStatTable+1E][CUR:58A]Invincible for longer[N][N]period of time- |

DescLightArmor |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+1A][CUR:51E][0B:27,&GearStatTable+1F][CUR:58A]Receive no damage from[N][N]weaker monsters- |

---------------------------------------------
; Description of the Elemental Mail (id $0F).
; 
; When: the cursor is on the Elemental Mail.
; Sees: the defence bar and 'Protects <player name> from the damage zones' ([02:2] = the string at $1B92).
; Why: the text is built with the name the player typed.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

DescElementalMail |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+1C][CUR:51E][0B:27,&GearStatTable+20][CUR:58A]Protects [02:2][N][N]from the damage zones-|

DescSoulArmor |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+1E][CUR:51E][0B:27,&GearStatTable+21][CUR:58A]Enables you to walk in[N][N]space- |

DescFlameBall |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+20][CUR:50A]Necessary GEM : 4[N][N]Shoots a fireball in [N][N]one direction- |

DescLightArrow |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+22][CUR:50A]Necessary GEM : 8[N][N]Shoots "lightˮ arrows [N][N]in all directions- |

DescMagicFlair |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+24][CUR:50A]Necessary GEM : 8[N][N]Power is collected [N][N]while button pressed- |

DescRotator |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+26][CUR:50A]Necessary GEM : 1[N][N]A light ring will [N][N]rotate around you- |

DescSparkBomb |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+28][CUR:50A]Necessary GEM : 8[N][N]Mines are laid, will [N][N]explode soon after- |

DescFlamePillar |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+2A][CUR:50A]Necessary GEM : 20[N][N]Pillars of fire will [N][N]rise around you- |

DescTornado |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+2C][CUR:50A]Necessary GEM : 8[N][N]Magical Tornado will [N][N]come- |

---------------------------------------------
; Description of the Phoenix spell (id $18).
; 
; When: the cursor is on the Phoenix.
; Sees: 'Necessary GEM : 2' and 'Phoenix will join <player name>' ([02:2] = the string at $1B92).
; Why: see DescElementalMail.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

DescPhoenix |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+2E][CUR:50A]Necessary GEM : 2[N][N]Phoenix will join [N][N][02:2]-|

DescGoatsFood |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+30][CUR:50A]Goat s food from the [N][N]tool shop- |

DescHarpString |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+32][CUR:50A]Harp String of singer-|

DescAPass |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+34][CUR:50A]A pass made by the [N][N]children of Grass [N][N]Valley- |

DescDreamRod |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+36][CUR:50A]A strange stick that [N][N]enables you to look [N][N]into a dream- |

DescLeosBrush |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+38][CUR:50A]The paintbrush used to[N][N]paint the picture: [N][N]"The World of Evilˮ- |

DescLeaves |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+3A][CUR:50A]Turbo s symbol- Anyone[N][N]with this is accepted [N][N]as Turbo s messenger-|

DescMolesRibbon |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+3C][CUR:50A]A ribbon that Monmo, a[N][N]mole, used to be fond [N][N]of when she was alive-|

DescBigPearl |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+3E][CUR:50A]A beautiful pearl [N][N]that can be found in [N][N]coral reef- |

DescMermaidsTears |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+40][CUR:50A]will turn magma into [N][N]stone- |

DescMushroomShoes |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+42][CUR:50A]The snail goo enables [N][N]you to walk on ice [N][N]without slipping- |

DescMobileKey |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+44][CUR:50A]Key to Airship- Plug  [N][N]into a keyhole located[N][N]somewhere on the ship-|

DescThunderRing |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+46][CUR:50A]If you touch a [N][N]lightning pyramid, [N][N]lightning will strike-|

DescDeliciousSeeds |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+48][CUR:50A]Favorite Seeds, [N][N]exchange for item [N][N]with the exchanger- |

DescActinidiaLeaves |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+4A][CUR:50A]Emits a peculiar scent[N][N]that attracts cats- |

DescDoorKey |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+4C][CUR:50A]This key will open the[N][N]door to the [N][N]laboratory- |

DescPlatinumCard |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+4E][CUR:50A]You may enter the left[N][N]tower in the Magridd [N][N]Castle- |

---------------------------------------------
; Description of the VIP Card (id $29).
; 
; When: the cursor is on the VIP Card.
; Sees: 'You may go wherever you wish within the Magridd Castle'; items.md says the card opens the Right Tower (OQ-I009-1).
; Why: item text.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

DescVipCard |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+50][CUR:50A]You may go wherever [N][N]you wish within the [N][N]Magridd Castle- |

---------------------------------------------
; Description of Master's Emblem A (id $2A); it carries the [::] marker that the stubs for B-H jump to.
; 
; When: the cursor is on Emblem A.
; Sees: 'If you collect 8 of these, you will become an expert at magic'; walkthrough: all eight give access to the Magic Bell.
; Why: the eight emblems share one text; only the name line differs.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

DescMastersEmblemA |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+52][::][CUR:50A]If you collect 8 of [N][N]these, you will become[N][N]an expert at magic- |

---------------------------------------------
; Description stub of Master's Emblem B (id $2B): prints the name and jumps into DescMastersEmblemA at its [::] marker.
; 
; When: the cursor is on Emblem B; the stubs C-H (ids $2C-$31) are the same.
; Sees: the common emblem text.
; Why: saves 50 bytes per emblem.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

DescMastersEmblemB |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+54][JMP:&DescMastersEmblemA+M]|

DescMastersEmblemC |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+56][JMP:&DescMastersEmblemA+M]|

DescMastersEmblemD |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+58][JMP:&DescMastersEmblemA+M]|

DescMastersEmblemE |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+5A][JMP:&DescMastersEmblemA+M]|

DescMastersEmblemF |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+5C][JMP:&DescMastersEmblemA+M]|

DescMastersEmblemG |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+5E][JMP:&DescMastersEmblemA+M]|

DescMastersEmblemH |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+60][JMP:&DescMastersEmblemA+M]|

---------------------------------------------
; Description of the Red-Hot Mirror (id $32); it carries the [::] marker for the Red-Hot Ball and Stick stubs.
; 
; When: the cursor is on the Mirror (the Ball and Stick, ids $33 and $34, jump into it).
; Sees: 'If you obtain all three symbols, the Phoenix will join you' (walkthrough: the three items summon the Phoenix).
; Why: the three items share one text.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

DescRedHotMirror |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+62][::][CUR:50A]If you obtain all [N][N]three symbols, the [N][N]Phoenix will join you-|

DescRedHotBall |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+64][JMP:&DescRedHotMirror+M]|

DescRedHotStick |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+66][JMP:&DescRedHotMirror+M]|

DescPowerBracelet |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+68][CUR:50A]If you equip this [N][N]item, your attack [N][N]power will double- |

DescShieldBracelet |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+6A][CUR:50A]Will reduce the amount[N][N]of damage received [N][N]from enemies by 1/2- |

DescSuperBracelet |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+6C][CUR:50A]Your sword and armor [N][N]will increase in [N][N]strength by 2- |

DescMedicalHerb |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+6E][CUR:50A]Your HP will be [N][N]refilled if your life [N][N]meter reaches 0- |

---------------------------------------------
; Description of the Strange Bottle (id $39).
; 
; When: the cursor is on the Strange Bottle.
; Sees: 'You will not lose any GEMs should your life meter reach' and nothing after it (the Medical Herb text ends 'reaches 0', OQ-I009-2).
; Why: item text.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

DescStrangeBottle |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+70][CUR:50A]You will not lose any [N][N]GEMs should your life [N][N]meter reach |

---------------------------------------------
; Description of the Brown Stone (id $3A); it carries the [::] marker for the Green, Blue, Silver, Purple and Black Stones.
; 
; When: the cursor is on a stone (ids $3B-$3F jump into this text).
; Sees: 'World of Evil will appear once you have collected 6 of these'.
; Why: the six stones share one text.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

DescBrownStone |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+72][::][CUR:50A]World of Evil will [N][N]appear once you have [N][N]collected 6 of these- |

DescGreenStone |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+74][JMP:&DescBrownStone+M]|

DescBlueStone |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+76][JMP:&DescBrownStone+M]|

DescSilverStone |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+78][JMP:&DescBrownStone+M]|

DescPurpleStone |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+7A][JMP:&DescBrownStone+M]|

DescBlackStone |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+7C][JMP:&DescBrownStone+M]|

DescMagicBell |[CUR:48A][TBL:&ItemNameList,&NameIndexCells+7E][CUR:50A]You will be able to [N][N]cast magic without [N][N]using any GEMs- |
---------------------------------------------

; 64 words holding 1 to $40: the index cells the description records pass to [TBL].
; 
; When: every description record uses [TBL:&ItemNameList,&NameIndexCells + 2 x (id - 1)].
; Sees: the item name on the first line of the description window.
; Why: the [TBL] code reads its string number from memory, so a table of the numbers lets a string print a fixed name.
; In: n/a (data). Entry k = k + 1.
; Out: n/a.
; Clobbers: n/a.

NameIndexCells [
  #$0001   ;00
  #$0002   ;01
  #$0003   ;02
  #$0004   ;03
  #$0005   ;04
  #$0006   ;05
  #$0007   ;06
  #$0008   ;07
  #$0009   ;08
  #$000A   ;09
  #$000B   ;0A
  #$000C   ;0B
  #$000D   ;0C
  #$000E   ;0D
  #$000F   ;0E
  #$0010   ;0F
  #$0011   ;10
  #$0012   ;11
  #$0013   ;12
  #$0014   ;13
  #$0015   ;14
  #$0016   ;15
  #$0017   ;16
  #$0018   ;17
  #$0019   ;18
  #$001A   ;19
  #$001B   ;1A
  #$001C   ;1B
  #$001D   ;1C
  #$001E   ;1D
  #$001F   ;1E
  #$0020   ;1F
  #$0021   ;20
  #$0022   ;21
  #$0023   ;22
  #$0024   ;23
  #$0025   ;24
  #$0026   ;25
  #$0027   ;26
  #$0028   ;27
  #$0029   ;28
  #$002A   ;29
  #$002B   ;2A
  #$002C   ;2B
  #$002D   ;2C
  #$002E   ;2D
  #$002F   ;2E
  #$0030   ;2F
  #$0031   ;30
  #$0032   ;31
  #$0033   ;32
  #$0034   ;33
  #$0035   ;34
  #$0036   ;35
  #$0037   ;36
  #$0038   ;37
  #$0039   ;38
  #$003A   ;39
  #$003B   ;3A
  #$003C   ;3B
  #$003D   ;3C
  #$003E   ;3D
  #$003F   ;3E
  #$0040   ;3F
]
---------------------------------------------

; Strength and Defence bonus of the gear by item id: two rows of 17 bytes.
; 
; When: RecalcGearStats (4 reads) and the bar codes [0B:26,&GearStatTable + id] and [0B:27,&GearStatTable + $11 + id] of the description records (16).
; Sees: the strength and defence bars, and the sum in the status screen.
; Why: data, so the numbers and the bar lengths come from one table.
; In: n/a (data). Row 0, offset = weapon id (1-8): 1, 2, 3, 4, 6, 8, 10, 12 (walkthrough items.md Strength +1 .. +12). Row 1, offset $11 + armor id (9-$10): 1, 2, 3, 4, 6, 8, 10, 12. All other bytes 0.
; Out: n/a.
; Clobbers: n/a.

GearStatTable [
  #000102030406080A0C0000000000000000   ;00
  #0000000000000000000102030406080A0C   ;01
]
---------------------------------------------

; Minimum player level of the eight weapons as packed BCD words: 1, 5, 11, 15, 16, 19, 22, 24.
; 
; When: the sword code in player_core compares it with player_level_bcd (and clears the B press when the level is lower); the weapon description records print it.
; Sees: 'Lev' in the weapon description window; a weapon below its level is not swung (walkthrough items.md weapon table, Minimum Level).
; Why: data, one word per weapon, index (id - 1) x 2.
; In: n/a (data).
; Out: n/a.
; Clobbers: n/a.

WeaponMinLevelBcd [
  #$0001   ;00
  #$0005   ;01
  #$0011   ;02
  #$0015   ;03
  #$0016   ;04
  #$0019   ;05
  #$0022   ;06
  #$0024   ;07
]