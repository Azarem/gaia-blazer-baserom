; Blink step of the arrow cursor, shared by the choice menu and the menu-row choosers (file offsets 74507-74537, SNES $02:A30B-$A329, bank 02).
; 
; === MODEL ===
; One call per frame while a chooser waits for a key. menu_blink ($03C6) counts the calls: the low 5 bits below $18 draw the arrow (tile $2B, 24 frames), $18-$1F draw a blank (tile $20, 8 frames), so the period is 32 frames. The chooser resets the counter to 0 on every move so that the arrow is visible right after a step. Callers: RunChoiceMenu (2 sites) and the four wait loops of ChooseMenuRow and ChooseMenuRowAtTable in lib_0118FC_part2.
---------------------------------------------

?BANK 02

!vram_upload_flags              03B8
!menu_blink                     03C6
!bg3_tilemap_buffer             7F7000

---------------------------------------------

; Draws the arrow or a blank in the cursor cell and advances the blink counter.
; 
; When: once per frame from the wait loops of RunChoiceMenu (2 sites) and ChooseMenuRow / ChooseMenuRowAtTable (4 sites).
; Sees: the arrow blinks: on for 24 frames, off for 8.
; Why: tells the player which option is selected and that the menu waits for a key.
; In: near call (JSR); M = 8; X = BG3 byte offset of the arrow cell.
; Out: the tile byte ($2B or $20) written to the lower half (buffer + X) and the upper half ($7F6FC0 + X); menu_blink + 1; vram_upload_flags bit 0 set. X is preserved.
; Clobbers: A.

BlinkChoiceCursor {
    LDA $menu_blink
    AND #$1F              ; the low 5 bits of the counter give a 32-frame blink period
    CMP #$18              ; counter 0-$17: arrow (24 frames); $18-$1F: blank (8 frames)
    BCC BlinkCursorShown
    LDA #$20
    BRA StoreBlinkTile

  BlinkCursorShown:
    LDA #$2B

  StoreBlinkTile:
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    INC $menu_blink
    LDA #$01
    TSB $vram_upload_flags
    RTS 
}