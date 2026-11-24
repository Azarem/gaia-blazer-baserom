; Menu screen setup of bank 02: the BG2 menu screen (SetupMenuBg2Screen), the menu tile groups (ExpandMenuTileGroups), the menu graphics and palette loaders, the item page palette, the scene graphics restore and the equipped magic graphics (file offsets 74539-74575, 74640-74989 and the loaders up to the end of the file, SNES $02:A32B-$A34F and $02:A390-$A4ED).
; 
; One file because SetupMenuBg2Screen calls LoadMenuBg2Graphics, LoadMenuPalette and ExpandMenuTileGroups together, and the other parts load or restore the graphics and palettes that a menu replaces. Callers: engine_title_file_select (SetupMenuBg2Screen), lib_menus (LoadMenuBg2Graphics, LoadMenuPalette, LoadItemPagePalette, RestoreSceneBgGfxAndPalette, LoadEquippedMagicGfx), lib_boot_and_scene_init (RestoreSceneBgGfxAndPalette, LoadEquippedMagicGfx) and gv_front_end (RestoreSceneBgGfxAndPalette). The sections below keep the notes of the loaders; SetupMenuBg2Screen and ExpandMenuTileGroups have part notes.
; 
; Menu graphics and palette loaders (file offsets 74774-74832, SNES $02:A416-$A44F, bank 02).
; 
; === MODEL ===
; Two short routines give the field menus and the file-select screen their own BG2 tile set and colours. LoadMenuBg2Graphics DMAs graphics_04B000 ($09:B000, 8192 bytes, 256 4bpp tiles) to VRAM word $2000; LoadMenuPalette copies 256 bytes of data_menu_palettes_and_groups.MenuBgPalette ($09:F100) into the CGRAM buffer (cgram_buffer, colours 0-127), which the NMI uploads.
; 
; Both are called in this order by OpenEquipmentMenu (lib_menus) and by lib_menu_screen_setup (the setup of the file-select screen, called from EnterFileSelect). RedrawEquipmentPage (lib_menus) calls LoadMenuPalette alone to bring the equipment palette back after the item page.
; 
; === NOTES ===
; - VRAM word $2000 is the BG2 character base: lib_menu_screen_setup writes BG12NBA = $20, BG2SC = $5C and BGMODE = 9 right before it calls these routines, and OpenEquipmentMenu writes the same BG2SC and BG12NBA. That graphics_04B000 is the menu icon and frame set and MenuBgPalette its palette is a reading of the callers (OQ-I010-10).
; - LoadMenuBg2Graphics does not write VMAIN ($2115); it relies on a value left by earlier code (OQ-I010-8) and on forced blank (both callers blank the screen first).
; - The wrapper docs earlier called these code_012416 and code_01243D and the first one a '4 KB' set; the DMA size is $2000 bytes (8 KB, 4K words).
; 
; Palette and graphics handoff of the menus (file offsets 74832-74989, SNES $02:A450-$A4ED, bank 02).
; 
; === MODEL ===
; The equipment menu replaces the field's VRAM character data at word $2000 with its own graphics and the palette with its own, and puts the field back on exit. LoadItemPagePalette gives the item page its palette (colours 0-127 from ItemPagePalette). RestoreSceneBgGfxAndPalette DMAs the 8 KB copy of graphics_04D000 that lib_boot_and_scene_init keeps at $7F:C000 back to VRAM word $2000 and restores palettes 11-15 (MenuSpellPalettes, 160 bytes, to cgram_buffer + $160); the scene change (lib_boot_and_scene_init, when $0454 is set) and code_0066DE of gv_front_end call it too. LoadEquippedMagicGfx then puts the graphics and palette of the equipped spell on top.
; On the menu exit the order is RestoreSceneBgGfxAndPalette, RestoreCgramBuffer (which overwrites the whole CGRAM buffer, including the colours just written) and LoadEquippedMagicGfx: the spell palette is loaded last so it survives.
; 
; === NOTES ===
; - What graphics_04D000 is (field BG or shared tile set): OQ-I009-13.
; - Spell n = equipped_magic - $11 (0-7). MagicGraphicsPointers holds a 3-byte pointer per spell (graphics_07B000 plus $0, $0, $800, $1000, $1000, $1800, $1800, $800), MagicPalettePointers also a 3-byte pointer per spell (palette_07D000 + $20 x n; LoadEquippedMagicGfx indexes both tables with 3 x n and reads only the word of the palette entry, the source bank is fixed to $0F).
---------------------------------------------

?BANK 02

?INCLUDE 'data_engine_tables'
?INCLUDE 'data_iris_and_icon_tiles'
?INCLUDE 'data_menu_palettes_and_groups'

!vram_upload_flags              03B8
!equipped_magic                 1B62
!BGMODE                         2105
!BG2SC                          2108
!BG12NBA                        210B
!VMADDL                         2116
!TM                             212C
!CGADSUB                        2131
!MDMAEN                         420B
!DMAP0                          4300
!BBAD0                          4301
!A1T0L                          4302
!A1B0                           4304
!DAS0L                          4305

---------------------------------------------

; Switches to the BG2 menu screen: registers, graphics, palette and tile groups.
; 
; When: EnterFileSelect (engine_title_file_select), with the screen blanked.
; Sees: the menu background (BG2 at VRAM $5C00, characters at $2000, main screen BG2 and BG3) replaces the field.
; Why: one call sets up what every full-screen menu needs before its text is printed.
; In: long call; the screen blanked.
; Out: BG2SC = $5C, BG12NBA = $20, TM = $06, CGADSUB = 0, BGMODE = 9, then LoadMenuBg2Graphics, LoadMenuPalette and ExpandMenuTileGroups; P restored.
; Clobbers: A, X, Y.

SetupMenuBg2Screen {
    PHP 
    SEP #$20
    LDA #$5C
    STA $BG2SC
    LDA #$20
    STA $BG12NBA
    LDA #$06
    STA $TM
    STZ $CGADSUB
    LDA #$09
    STA $BGMODE
    JSR $&LoadMenuBg2Graphics
    JSR $&LoadMenuPalette
    JSR $&ExpandMenuTileGroups
    PLP 
    RTL 
}
---------------------------------------------

; Expands the menu tile group map into the BG2 tilemap buffer.
; 
; When: SetupMenuBg2Screen.
; Sees: the menu background tiles (icons and frames) appear once the buffer is uploaded.
; Why: the menu background is stored as one byte per 2 x 2 tile group; each group is a record of four tile words (IconTileRecords).
; In: near call (RTS); DBR is set to $7F inside.
; Out: for every byte of MenuTileGroupMap the four words of IconTileRecords[byte] are written as a 2 x 2 block at $7F:7800 (two rows $40 bytes apart, $800 bytes in all); vram_upload_flags bit 1 is set so the NMI uploads the buffer; P and DBR restored.
; Clobbers: A, X, Y, dp$00-$02.

ExpandMenuTileGroups {
    PHP 
    PHB 
    LDA #$7F
    PHA 
    PLB 
    REP #$20
    LDY #$&data_menu_palettes_and_groups.MenuTileGroupMap
    STY $00
    LDA #$*data_menu_palettes_and_groups.MenuTileGroupMap
    STA $02
    LDY #$0000

  loc_0123A5:
    LDA [$00]
    INC $00
    AND #$00FF
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
    INY 
    INY 
    INY 
    INY 
    TYA 
    AND #$003F
    BNE loc_0123A5
    TYA 
    CLC 
    ADC #$0040
    TAY 
    CPY #$0800
    BNE loc_0123A5
    PLB 
    LDA #$0002
    TSB $vram_upload_flags
    PLP 
    RTS 
}
---------------------------------------------

; Loads the 8 KB menu tile set into VRAM at word address $2000.
; 
; When: OpenEquipmentMenu (X or Select in the field) and lib_menu_screen_setup (setup of the file-select screen), with the screen blanked.
; Sees: the frame, icon and gauge tiles that the BG2 menu page draws with (a reading of the callers, OQ-I010-10).
; Why: the menus need their own character set; the scene's tiles are put back when the menu closes (RestoreSceneBgGfxAndPalette).
; In: JSR; M = 8, X = 16; forced blank; VMAIN = $80 is assumed, not written here (OQ-I010-8).
; Out: one DMA on channel 0 (mode 1, $2118/$2119): graphics_04B000 to VRAM word $2000, $2000 bytes.
; Clobbers: A, X, DMA channel 0 registers.

LoadMenuBg2Graphics {
    LDX #$2000            ; VRAM word $2000 = BG2 character base (BG12NBA = $20)
    STX $VMADDL
    LDA #$01
    STA $DMAP0
    LDA #$18
    STA $BBAD0
    LDX #$&graphics_04B000
    STX $A1T0L
    LDA #$^graphics_04B000
    STA $A1B0
    LDX #$2000            ; $2000 bytes = 256 4bpp tiles
    STX $DAS0L
    LDA #$01
    STA $MDMAEN
    RTS 
}

---------------------------------------------
; Copies the 256-byte menu palette into the CGRAM buffer.
; 
; When: OpenEquipmentMenu, RedrawEquipmentPage (to restore the equipment colours after the item page) and lib_menu_screen_setup.
; Sees: the menu colours on the next NMI upload.
; Why: the buffer is uploaded by the NMI, so loading the palette is a memory copy, not a hardware write.
; In: JSR; M = 8, X = 16 (the routine switches to 16-bit A for the MVN and back to 8-bit).
; Out: 256 bytes of MenuBgPalette to cgram_buffer ($7F:0000, CGRAM colours 0-127); DBR and P restored.
; Clobbers: A, X, Y.

LoadMenuPalette {
    PHB 
    REP #$20
    LDX #$&data_menu_palettes_and_groups.MenuBgPalette ; MVN with A = $FF: 256 bytes from $09:F100 to $7F:0000 (cgram_buffer)
    LDY #$0000
    LDA #$00FF
    MVN #$7F, #$^data_menu_palettes_and_groups.MenuBgPalette
    SEP #$20
    PLB 
    RTS 
}
---------------------------------------------

; Copies the item page palette into the CGRAM buffer.
; 
; When: DrawItemPage, every time the item page is shown.
; Sees: the item icons and the page frame use their own colours.
; Why: the item icons need colours different from the equipment page.
; In: JSR; any M (REP #$20 inside).
; Out: 256 bytes of ItemPagePalette copied to cgram_buffer (colours 0-127) with MVN; M = 8 on return; DBR restored.
; Clobbers: A, X, Y.

LoadItemPagePalette {
    PHB 
    REP #$20
    LDX #$&data_menu_palettes_and_groups.ItemPagePalette
    LDY #$0000
    LDA #$00FF
    MVN #$7F, #$^data_menu_palettes_and_groups.ItemPagePalette ; 256 bytes to the CGRAM buffer (X = source, Y = 0); the bank operands are destination $7F, source bank of ItemPagePalette
    SEP #$20
    PLB 
    RTS 
}

---------------------------------------------
; Puts the field's background graphics and palettes 11-15 back after a menu or a scene load.
; 
; When: the tail of OpenEquipmentMenu, code_0066DE of gv_front_end and the scene change (lib_boot_and_scene_init).
; Sees: the field looks normal again after the menu.
; Why: the menu overwrote VRAM $2000 and part of the palette.
; In: long call; M = 8; the screen must be in forced blank (it writes VRAM through DMA channel 0).
; Out: VRAM word $2000 receives $2000 bytes from $7F:C000; MenuSpellPalettes (160 bytes) is copied to cgram_buffer + $160; DBR restored.
; Clobbers: A, X, Y; DMA channel 0.

RestoreSceneBgGfxAndPalette {
    LDX #$2000            ; VRAM word $2000 <- $2000 bytes from $7F:C000, the copy of graphics_04D000 made at scene load
    STX $VMADDL
    LDA #$01
    STA $DMAP0
    LDA #$18
    STA $BBAD0
    LDX #$C000
    STX $A1T0L
    LDA #$7F
    STA $A1B0
    LDX #$2000
    STX $DAS0L
    LDA #$01
    STA $MDMAEN
    PHB 
    REP #$20
    LDX #$&data_menu_palettes_and_groups.MenuSpellPalettes
    LDY #$0160
    LDA #$009F            ; 160 bytes to cgram_buffer + $160: palettes 11-15
    MVN #$7F, #$^data_menu_palettes_and_groups.MenuSpellPalettes
    SEP #$20
    PLB 
    RTL 
}

---------------------------------------------
; Loads the graphics and palette of the equipped spell.
; 
; When: the tail of OpenEquipmentMenu (every menu close) and the scene change (lib_boot_and_scene_init).
; Sees: the spell's own effect tiles and colours (the Flame Ball, Light Arrow ... of walkthrough magic.md) are available when the player casts it.
; Why: only one spell's graphics fit at VRAM word $2600, and the menu's own character data ($2000-$2FFF) overwrites that area, so they are loaded again after every menu close and scene load, not only when the equipped magic changed.
; In: long call; reads equipped_magic.
; Out: for equipped_magic - $11 = n in 0-7: $800 bytes of graphics_07B000 + the MagicGraphicsPointers offset to VRAM word $2600 (DMA channel 0), and 32 bytes of palette_07D000 + $20 x n (source bank $0F) to cgram_buffer + $160; any other value (no magic) does nothing.
; Clobbers: A, X, Y; DMA channel 0.

LoadEquippedMagicGfx {
    PHP 
    REP #$20
    LDA $equipped_magic
    SEC 
    SBC #$0011            ; Magic ids $11-$18 become spell 0-7; anything else (no magic, other items) returns
    CMP #$0008
    BCS loc_0124EC
    PHA 
    ASL 
    CLC 
    ADC $01, S            ; A = 3 x spell number (the table entries are 3 bytes)
    PLX 
    TAX 
    SEP #$20
    LDY #$2600
    STY $VMADDL
    LDA #$01
    STA $DMAP0
    LDA #$18
    STA $BBAD0
    LDY $&data_engine_tables.MagicGraphicsPointers, X
    STY $A1T0L
    LDA $&data_engine_tables.MagicGraphicsPointers+2, X
    STA $A1B0
    LDY #$0800
    STY $DAS0L
    LDA #$01
    STA $MDMAEN
    REP #$20
    PHB 
    LDA $&data_engine_tables.MagicPalettePointers, X
    TAX 
    LDY #$0160
    LDA #$001F
    MVN #$7F, #$0F        ; 32 bytes of palette_07D000 + $20 x n to cgram_buffer + $160 (bank $0F)
    PLB 

  loc_0124EC:
    PLP 
    RTL 
}