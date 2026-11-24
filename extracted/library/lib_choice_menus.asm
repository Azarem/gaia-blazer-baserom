; Choice menus of bank 02: the row chooser, the question window chooser and the cursor blink they share (file offsets 74040-74537, SNES $02:A138-$A329).
; 
; One file because ChooseMenuRow (with ChooseMenuRowAtTable and TitleMenuCursorOffsets) and RunChoiceMenu both blink their cursor through BlinkChoiceCursor, which nothing else calls. Callers: lib_menus (ChooseMenuRow), engine_title_file_select (ChooseMenuRowAtTable, the file select) and cop_items_stats_text (RunChoiceMenu, the question windows of Cop1A_ChoiceMenu). The sections below keep the notes of the former files in file order.
; 
; Menu row chooser (file offsets 74040-74368, SNES $02:A138-$A280, bank 02; the cursor offset table is at 74359-74368).
; 
; === MODEL ===
; A cursor of one glyph (BG3 tile $2B, drawn in the cell at the row's offset and in the cell one tilemap row above it) moves between a few rows of a menu. ChooseMenuRow serves the equipment menu: rows are $80 apart in the BG3 buffer (two text rows), Up and Down move, Y cancels (carry set) and B confirms (carry clear); the equipment menu uses it with four rows (Weapon, Armor, Magic, Item) and swaps the page on the way. ChooseMenuRowAtTable is the same loop for the file-select and erase menus of engine_title_file_select: the row offsets come from TitleMenuCursorOffsets ($C0 apart) and there is no page swap; B plays the confirm sound ($18) there and the cancel and move sounds are $07 (OQ-I009-12).
; Both wait for all buttons to be up (lib_text_render.WaitFrameReadButtons, which returns the high byte of joy_pressed) before reading a press and call lib_choice_menus.BlinkChoiceCursor while waiting (it blinks the cursor glyph; menu_blink counts the frames).
; 
; === NOTES ===
; - Input: A = row count (stored in menu_count), B (after XBA) = start row, X = BG3 byte offset of the start row's cursor cell. Output: carry clear and A = row; carry set when Y was pressed. The final cursor glyph stays drawn on the last row.
; - The first 'wait until released' loop gives an edge-triggered feel: joy_pressed holds a button as long as it is down (or until the latch is cleared), so a held button would otherwise repeat.
; 
; Choice menu: the arrow cursor list of every question window (file offsets 74369-74506, SNES $02:A281-$A30A, bank 02).
; 
; === MODEL ===
; RunChoiceMenu is called by Cop1A_ChoiceMenu (27 scripts) and Cop02_PromptYesNo (no script uses it) after the option window of shared_choice_prompt_texts has been printed. A = number of options (8 bit), the high byte of A (read with XBA) = the start index (both callers pass 0), X = BG3 byte offset of the first option's arrow cell. Options are $80 bytes apart (two tile rows). The selected index is kept on the stack ($01,S) for the whole menu; menu_count ($03C4) holds the option count and menu_blink ($03C6) the blink frame counter.
; The arrow is the glyph tile $2B, two tiles tall like every glyph: the lower half at X in the BG3 buffer ($7F7000) and the upper half one row above (X - $40, the buffer base $7F6FC0 + X). Only the tile byte is written, the attribute stays. Blank is tile $20.
; Flow: (1) DrawChoiceCursor writes the arrow and sets vram_upload_flags bit 0. (2) WaitChoiceKeysUp calls WaitFrameReadButtons and BlinkChoiceCursor until a frame reports no new button press, so the press that opened the question cannot answer it. (3) PollChoiceKeys reads one frame at a time (joy_pressed+1: $08 Up, $04 Down, $40 Y, $80 B); any other frame runs BlinkChoiceCursor and polls again. Up on the first option and Down on the last go back to step 2 (the move is ignored). A move erases the arrow (tile $20 in both halves), plays BRK #$07, resets menu_blink, moves the cell by $80 and redraws.
; Exit: B plays BRK #$18 and returns carry clear, Y plays BRK #$07 and returns carry set. In both cases the arrow stays drawn (tile $2B) on the current option, A = the index pulled off the stack and X = its arrow cell. The callers then erase the window (EraseWindowFrame at text_last_window_origin, $03F7), set vram_upload_flags = 1 and either store the index in choice_result ($03D0) or, on cancel, take the cancel pointer.
; 
; === NOTES ===
; - B = confirm and Y = cancel match the walkthrough ('Press the B Button twice to equip ... Press the Y Button to exit the menu', 01-in-the-beginning.md). The other buttons are ignored here.
; - ChooseMenuRow and ChooseMenuRowAtTable (lib_choice_menus) are the same loop for the equipment, file-select and erase menus with their own row spacing and page swap; they share BlinkChoiceCursor with this routine.
; - Nothing limits the option count except the window: the largest in use is 3.
; 
; Blink step of the arrow cursor, shared by the choice menu and the menu-row choosers (file offsets 74507-74537, SNES $02:A30B-$A329, bank 02).
; 
; === MODEL ===
; One call per frame while a chooser waits for a key. menu_blink ($03C6) counts the calls: the low 5 bits below $18 draw the arrow (tile $2B, 24 frames), $18-$1F draw a blank (tile $20, 8 frames), so the period is 32 frames. The chooser resets the counter to 0 on every move so that the arrow is visible right after a step. Callers: RunChoiceMenu (2 sites) and the four wait loops of ChooseMenuRow and ChooseMenuRowAtTable in lib_choice_menus.
---------------------------------------------

?BANK 02

?INCLUDE 'lib_menus'
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
    JSR $&BlinkChoiceCursor
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
    JSR $&BlinkChoiceCursor
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
    JSR $&BlinkChoiceCursor
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
    JSR $&BlinkChoiceCursor
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
---------------------------------------------

; Runs one choice menu: moves the arrow between the options until B confirms or Y cancels.
; 
; When: Cop1A_ChoiceMenu (27 scripts) and Cop02_PromptYesNo, right after PrintTextString has drawn the option window.
; Sees: an arrow (the ► glyph, tile $2B) in front of an option that blinks and steps with Up and Down; it stays on the answer when the menu closes.
; Why: every question window of the game uses the same keys and the same arrow, so one routine serves all of them.
; In: long call (JSL); M = 8; A = number of options, high byte of A = start index; X = BG3 byte offset of the first option's arrow cell (the trailing [CUR] of the option string).
; Out: carry clear = B (BRK #$18), carry set = Y (BRK #$07); A = chosen index; X = the arrow cell of that option; the arrow stays drawn.
; Clobbers: A, X, Y; menu_count, menu_blink, vram_upload_flags bit 0; P is not preserved (the stack is balanced).

RunChoiceMenu {
    STA $menu_count
    XBA 
    PHA                   ; the start index (high byte of A) stays at $01,S for the whole menu
    STZ $menu_blink

  DrawChoiceCursor:
    LDA #$2B
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    LDA #$01
    TSB $vram_upload_flags

  WaitChoiceKeysUp:
    JSR $&lib_text_render.WaitFrameReadButtons ; wait until a frame shows no new button press, so the press that opened the question does not answer it
    BEQ PollChoiceKeys
    JSR $&BlinkChoiceCursor
    BRA WaitChoiceKeysUp

  PollChoiceKeys:
    JSR $&lib_text_render.WaitFrameReadButtons
    BIT #$08              ; joy_pressed+1: $08 Up, $04 Down, $40 Y (cancel), $80 B (confirm)
    BNE MoveChoiceUp
    BIT #$04
    BNE MoveChoiceDown
    BIT #$40
    BNE CancelChoice
    BIT #$80
    BNE ConfirmChoice
    JSR $&BlinkChoiceCursor
    BRA PollChoiceKeys

  ConfirmChoice:
    BRK #$18
    CLC 
    BRA FinishChoice

  CancelChoice:
    BRK #$07
    SEC 

  FinishChoice:
    LDA #$2B              ; confirm and cancel both leave the arrow drawn on the current option
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    PLA 
    RTL 

  MoveChoiceUp:
    LDA $01, S            ; Up on the first option is ignored
    BEQ WaitChoiceKeysUp
    DEC 
    STA $01, S
    TXY 
    REP #$20
    TYA 
    SEC 
    SEC 
    SBC #$0080            ; one option = two text rows = $80 bytes of the BG3 buffer
    TAY 
    SEP #$20
    BRA MoveChoiceCursor

  MoveChoiceDown:
    LDA $01, S
    INC 
    CMP $menu_count       ; Down on the last option is ignored
    BCS WaitChoiceKeysUp
    STA $01, S
    TXY 
    REP #$20
    TYA 
    CLC 
    ADC #$0080
    TAY 
    SEP #$20

  MoveChoiceCursor:
    BRK #$07
    LDA #$20              ; erase the old arrow (tile $20) in both halves before moving
    STA $7F6FC0, X
    STA $bg3_tilemap_buffer, X
    STZ $menu_blink
    TYX 
    BRL DrawChoiceCursor
}
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