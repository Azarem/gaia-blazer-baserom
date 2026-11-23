; Palette and graphics handoff of the menus (file offsets 74832-74989, SNES $02:A450-$A4ED, bank 02).
; 
; === MODEL ===
; The equipment menu replaces the field's VRAM character data at word $2000 with its own graphics and the palette with its own, and puts the field back on exit. LoadItemPagePalette gives the item page its palette (colours 0-127 from ItemPagePalette). RestoreSceneBgGfxAndPalette DMAs the 8 KB copy of graphics_04D000 that lib_02719F keeps at $7F:C000 back to VRAM word $2000 and restores palettes 11-15 (MenuSpellPalettes, 160 bytes, to cgram_buffer + $160); the scene loader (lib_027781_part3, when $0454 is set) and common_actor_0066C6.code_0066DE call it too. LoadEquippedMagicGfx then puts the graphics and palette of the equipped spell on top.
; On the menu exit the order is RestoreSceneBgGfxAndPalette, RestoreCgramBuffer (which overwrites the whole CGRAM buffer, including the colours just written) and LoadEquippedMagicGfx: the spell palette is loaded last so it survives.
; 
; === NOTES ===
; - What graphics_04D000 is (field BG or shared tile set): OQ-I009-13.
; - Spell n = equipped_magic - $11 (0-7). MagicGraphicsPointers holds a 3-byte pointer per spell (graphics_07B000 plus $0, $0, $800, $1000, $1000, $1800, $1800, $800), MagicPalettePointers a word per spell (palette_07D000 + $20 x n; the source bank is fixed to $0F).
---------------------------------------------

?BANK 02

?INCLUDE 'data_engine_tables'
?INCLUDE 'data_menu_palettes_and_groups'

!equipped_magic                 1B62
!VMADDL                         2116
!MDMAEN                         420B
!DMAP0                          4300
!BBAD0                          4301
!A1T0L                          4302
!A1B0                           4304
!DAS0L                          4305

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
; When: ExitEquipmentMenu, common_actor_0066C6.code_0066DE and the scene loader (lib_027781_part3).
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
; When: ExitEquipmentMenu and the scene loader (lib_027781_part3).
; Sees: the spell's own effect tiles and colours (the Flame Ball, Light Arrow ... of walkthrough magic.md) are available when the player casts it.
; Why: only one spell's graphics fit; they are swapped in when the equipped magic changes.
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