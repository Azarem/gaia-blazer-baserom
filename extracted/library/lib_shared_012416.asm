; Menu graphics and palette loaders (file offsets 74774-74832, SNES $02:A416-$A44F, bank 02).
; 
; === MODEL ===
; Two short routines give the field menus and the file-select screen their own BG2 tile set and colours. LoadMenuBg2Graphics DMAs graphics_04B000 ($09:B000, 8192 bytes, 256 4bpp tiles) to VRAM word $2000; LoadMenuPalette copies 256 bytes of data_menu_palettes_and_groups.MenuBgPalette ($09:F100) into the CGRAM buffer (cgram_buffer, colours 0-127), which the NMI uploads.
; 
; Both are called in this order by OpenEquipmentMenu (lib_menus) and by lib_01232B (the setup of the file-select screen, called from EnterFileSelect). RedrawEquipmentPage (lib_menus) calls LoadMenuPalette alone to bring the equipment palette back after the item page.
; 
; === NOTES ===
; - VRAM word $2000 is the BG2 character base: lib_01232B writes BG12NBA = $20, BG2SC = $5C and BGMODE = 9 right before it calls these routines, and OpenEquipmentMenu writes the same BG2SC and BG12NBA. That graphics_04B000 is the menu icon and frame set and MenuBgPalette its palette is a reading of the callers (OQ-I010-10).
; - LoadMenuBg2Graphics does not write VMAIN ($2115); it relies on a value left by earlier code (OQ-I010-8) and on forced blank (both callers blank the screen first).
; - The wrapper docs earlier called these code_012416 and code_01243D and the first one a '4 KB' set; the DMA size is $2000 bytes (8 KB, 4K words).
---------------------------------------------

?BANK 02

?INCLUDE 'data_menu_palettes_and_groups'

!VMADDL                         2116
!MDMAEN                         420B
!DMAP0                          4300
!BBAD0                          4301
!A1T0L                          4302
!A1B0                           4304
!DAS0L                          4305

---------------------------------------------

; Loads the 8 KB menu tile set into VRAM at word address $2000.
; 
; When: OpenEquipmentMenu (X or Select in the field) and lib_01232B (setup of the file-select screen), with the screen blanked.
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
; When: OpenEquipmentMenu, RedrawEquipmentPage (to restore the equipment colours after the item page) and lib_01232B.
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