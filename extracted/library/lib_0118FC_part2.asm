; Menu row chooser (file offsets 74040-74368, SNES $02:A138-$A280, bank 02; the cursor offset table is at 74359-74368).
; 
; === MODEL ===
; A cursor of one glyph (BG3 tile $2B, drawn in the cell at the row's offset and in the cell one tilemap row above it) moves between a few rows of a menu. ChooseMenuRow serves the equipment menu: rows are $80 apart in the BG3 buffer (two text rows), Up and Down move, Y cancels (carry set) and B confirms (carry clear); the equipment menu uses it with four rows (Weapon, Armor, Magic, Item) and swaps the page on the way. ChooseMenuRowAtTable is the same loop for the file-select and erase menus of engine_title_file_select: the row offsets come from TitleMenuCursorOffsets ($C0 apart) and there is no page swap; B plays the confirm sound ($18) there and the cancel and move sounds are $07 (OQ-I009-12).
; Both wait for all buttons to be up (lib_text_render.WaitFrameReadButtons, which returns the high byte of joy_pressed) before reading a press and call lib_shared_01230B.BlinkChoiceCursor while waiting (it blinks the cursor glyph; menu_blink counts the frames).
; 
; === NOTES ===
; - Input: A = row count (stored in menu_count), B (after XBA) = start row, X = BG3 byte offset of the start row's cursor cell. Output: carry clear and A = row; carry set when Y was pressed. The final cursor glyph stays drawn on the last row.
; - The first 'wait until released' loop gives an edge-triggered feel: joy_pressed holds a button as long as it is down (or until the latch is cleared), so a held button would otherwise repeat.
---------------------------------------------

?BANK 02

?INCLUDE 'lib_menus'
?INCLUDE 'lib_shared_01230B'
?INCLUDE 'lib_text_render'

!vram_upload_flags              03B8
!menu_count                     03C4
!menu_blink                     03C6
!menu_item_page                 042F
!bg3_tilemap_buffer             7F7000

---------------------------------------------

; Lets the player move a cursor between menu rows and returns the chosen row.
; 
; When: RunEquipmentMenu, once per row choice (rows Weapon, Armor, Magic, Item).
; Sees: the cursor glyph on the active row; moving onto the Item row swaps the equipment page for the item page, moving off redraws the equipment page (walkthrough: 'Press the B Button twice to equip ... Y Button to exit').
; Why: one loop for the row level; the lists (ChooseFromEquipmentList, ChooseItemSlot) are separate loops entered after B.
; In: JSR; M = 8; A = row count, B = start row, X = BG3 byte offset of the cursor cell of the start row.
; Out: carry clear and A = the row on B (BRK #$07); carry set on Y (BRK #$07). The cursor glyph ($2B) stays on the final row. Up and Down move one row ($80 in the BG3 buffer) and are ignored at the ends; each move plays BRK #$07, resets menu_blink and runs the page swap: with menu_item_page clear, entering row 3 calls DrawItemPage and increments menu_item_page; with it set, leaving row 3 calls RedrawEquipmentPage and clears it.
; Clobbers: A, X, Y (X is not restored); vram_upload_flags bit 0 is set on every cursor change.

ChooseMenuRow {
    STA $menu_count
    XBA 
    PHA 
    STZ $menu_blink

  loc_012140:
    LDA #$2B              ; Cursor glyph: tile $2B in the cell at X and in the cell one tilemap row above ($7F6FC0 + X = $7F7000 + X - $40)
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    LDA #$01
    TSB $vram_upload_flags

  loc_01214F:
    JSR $&lib_text_render.WaitFrameReadButtons
    BEQ loc_012159
    JSR $&lib_shared_01230B.BlinkChoiceCursor
    BRA loc_01214F

  loc_012159:
    JSR $&lib_text_render.WaitFrameReadButtons
    BIT #$08              ; High byte of joy_pressed: $08 Up, $04 Down, $40 Y (cancel), $80 B (confirm)
    BNE loc_012185
    BIT #$04
    BNE loc_01219A
    BIT #$40
    BNE loc_012176
    BIT #$80
    BNE loc_012171
    JSR $&lib_shared_01230B.BlinkChoiceCursor
    BRA loc_012159

  loc_012171:
    BRK #$07
    CLC 
    BRA loc_012179

  loc_012176:
    BRK #$07
    SEC 

  loc_012179:
    LDA #$2B
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    PLA 
    RTS 

  loc_012185:
    LDA $01, S
    BEQ loc_01214F
    DEC 
    STA $01, S
    TXY 
    REP #$20
    TYA 
    SEC 
    SEC 
    SBC #$0080
    TAY 
    SEP #$20
    BRA loc_0121AF

  loc_01219A:
    LDA $01, S
    INC 
    CMP $menu_count
    BCS loc_01214F
    STA $01, S
    TXY 
    REP #$20
    TYA 
    CLC 
    ADC #$0080
    TAY 
    SEP #$20

  loc_0121AF:
    BRK #$07
    LDA #$20
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    STZ $menu_blink
    TYX 
    LDA $menu_item_page   ; Page swap: entering row 3 draws the item page, leaving it redraws the equipment page
    BEQ loc_0121D6
    LDA $01, S
    CMP #$03
    BNE loc_0121CD
    BRL loc_012140

  loc_0121CD:
    JSR $&lib_menus.RedrawEquipmentPage
    STZ $menu_item_page
    BRL loc_012140

  loc_0121D6:
    LDA $01, S
    CMP #$03
    BEQ loc_0121DF
    BRL loc_012140

  loc_0121DF:
    JSR $&lib_menus.DrawItemPage
    INC $menu_item_page
    BRL loc_012140

; The same row chooser for menus whose row offsets come from a table.
; 
; When: engine_title_file_select, twice: the file-select menu and the erase menu.
; Sees: the cursor glyph moves between the rows of those menus.
; Why: these menus have rows three tile rows apart, not two, and no item page.
; In: long call (ends REP #$20 and RTL); A = row count, B = start row.
; Out: A = the row, carry clear on B (BRK #$18), carry set on Y (BRK #$07); the cursor glyph is drawn at the final row on confirm and erased (tile $20) on cancel; X is preserved (PHX and PLX).
; Clobbers: A.

  ChooseMenuRowAtTable:
    PHX 
    SEP #$20
    STA $menu_count
    XBA 
    PHA 

  loc_0121F0:
    LDA $01, S
    REP #$20
    AND #$00FF
    ASL 
    TAX 
    LDA $@TitleMenuCursorOffsets, X ; Cursor cell of this row (file select and erase menus)
    TAX 
    SEP #$20
    STZ $menu_blink
    LDA #$2B
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    LDA #$01
    TSB $vram_upload_flags

  loc_012212:
    JSR $&lib_text_render.WaitFrameReadButtons
    BEQ loc_01221C
    JSR $&lib_shared_01230B.BlinkChoiceCursor
    BRA loc_012212

  loc_01221C:
    JSR $&lib_text_render.WaitFrameReadButtons
    BIT #$08
    BNE loc_012255
    BIT #$04
    BNE loc_01225E
    BIT #$40
    BNE loc_012243
    BIT #$80
    BNE loc_012234
    JSR $&lib_shared_01230B.BlinkChoiceCursor
    BRA loc_01221C

  loc_012234:
    BRK #$18
    CLC 
    LDA #$2B
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    BRA loc_012250

  loc_012243:
    BRK #$07
    SEC 
    LDA #$20
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X

  loc_012250:
    PLA 
    PLX 
    REP #$20
    RTL 

  loc_012255:
    LDA $01, S
    BEQ loc_012212
    DEC 
    STA $01, S
    BRA loc_012268

  loc_01225E:
    LDA $01, S
    INC 
    CMP $menu_count
    BCS loc_012212
    STA $01, S

  loc_012268:
    BRK #$07
    LDA #$20
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    BRL loc_0121F0
}
---------------------------------------------

; BG3 byte offsets of the cursor cell of the five rows of the file-select menus.
; 
; When: ChooseMenuRowAtTable (entry = row).
; Sees: the cursor beside each of five rows, $C0 apart (three tile rows).
; Why: data, so the menu layout is changed in one place.
; In: n/a (data). Five words: $02CA, $038A, $044A, $050A, $05CA.
; Out: n/a.
; Clobbers: n/a.

TitleMenuCursorOffsets [
  #$02CA   ;00
  #$038A   ;01
  #$044A   ;02
  #$050A   ;03
  #$05CA   ;04
]