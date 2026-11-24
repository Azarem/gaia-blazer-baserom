; The two text screens that the story scripts call: the name entry screen (RunNameEntryScreen) and the staff roll scroller (ScrollStaffRollText) (name entry code at file offsets 74990-75353 and strings at 83037-83222, SNES $02:A4EE-$A658 and $02:C45D-$C515; staff roll code at 75471-75625, SNES $02:A6CF-$A768; bank 02).
; 
; One file because both are small interactive text screens with their own loop and one caller each: RunNameEntryScreen from cop_items_stats_text, ScrollStaffRollText from the credits actor of gv_front_end. The sections below keep the notes of the two former files in file order.
; 
; Name entry screen (file offsets 74990-75353 code, 83037-83222 strings; SNES $02:A4EE-$A658 and $02:C45D-$C515, bank 02).
; 
; === MODEL ===
; RunNameEntryScreen is one blocking routine: Cop3A_EnterPlayerName calls it once, at the start of the game after the Master's first speech (walkthrough 01-in-the-beginning.md: 'You will then get to pick a name for yourself. Choose what you will; there is no default name to be used'). The code agrees: the buffer is not pre-filled; it only continues a name that is already in it (the loop at loc_0124FF finds the first 0 byte).
; The screen is plain BG3 text, drawn with PrintTextString from three strings: NameEntryFrameText (prompt, window, name line, placeholders), NameEntryGridText (the letter grid) and NameEntryCloseText (erases the window). Every change repaints both strings, which also erases the old cursor.
; 
; === STATE ===
; - X = BG3 byte offset of the cursor cell, from $03C6 (the blank cell left of 'A'); the letter is the tile at X + 2 (bg3_tilemap_buffer + 2 + X).
; - name_cursor_col ($0441, 0-12) and name_cursor_row ($0443, 0-4); both are zeroed on entry.
; - Y = write pointer into the name buffer $1B92-$1B99 (8 characters). A character is accepted while Y < $1B9A; the 0 terminator is stored at [Y] when the name is finished, so a full name has its terminator at $1B9A (OQ-I010-13).
; 
; === GRID ===
; 13 columns, two tiles (4 bytes) per column, five rows: A-M, N-Z, a-m, n-z, then 0-9, '-', the tile $24 (printed by the extractor as an arrow: backspace) and the tile $23 (printed as AE: accept). Rows are $80 apart (one text row is two tile rows); an extra $40 follows rows 1 and 3, so Up and Down add or subtract $C0 there and Down from row 4 / Up from row 0 wrap by $280. Right from column 12 wraps by -$30, Left from column 0 by +$30.
; 
; === BUTTONS (joy_pressed+1 bits) ===
; Right (0) MoveNameCursorRight, Left (1) MoveNameCursorLeft, Down (2) MoveNameCursorDown, Up (3) MoveNameCursorUp, Start (4) FinishNameEntry (an empty name is ignored), Select (5) ignored, Y (6) DeleteNameChar (ignored when empty), B (7) PickNameChar (the tile under the letter decides: $23 finish, $24 backspace, else append with sound $18). Every cursor move jumps to BlipAndRedrawNameEntry (sound $07, then redraw). After each redraw the screen waits for all buttons to be released, so one press is one step.
; 
; === NOTES ===
; - Sound ids $07 and $18 are BRK requests (OQ-I010-16).
; - The save-slot name copy at $0447-$044E (list entry 3 of TextListPointers) is filled by DrawSaveSlotMenu from the save block, not by this screen.
; - FM-A6 correction: in NameEntryFrameText the [09] (one-row font) comes after the name [02:2], so only the placeholders are one-row; the name line is two-row.
; 
; Staff roll (credits) scroller (file offsets 75471-75625, SNES $02:A6CF-$A768, bank 02).
; 
; === MODEL ===
; ScrollStaffRollText prints a long string line by line on BG3 while scrolling the layer. The only caller is the credits actor of gv_front_end (gv_obj_staff_roll_007638, Y = gv_epilogue_texts.StaffRollText, 'The staff of Soul Blazer ...'); afterwards the actor waits two COP 1B delays of $F0 frames and changes scene with COP 10. The walkthrough (08-world-of-evil.md) says only 'Enjoy the credits'; the credits text is not quoted there.
; Each glyph is two tiles: tile c with attribute $21 (tile bit 8 set) at the write cell and tile c with attribute $20 one row below ((X + $40) & $7FF, wrapping inside the 2 KB page). [N] ($0D) scrolls scroll_bg3_y by 32 pixels, one pixel per RunSubFrame, moves the line start four tile rows down ((old + $100) & $7FF) and clears 128 words (four rows of tile 0, attribute $20) there. [14:n] moves the write cell right by n tiles. 0 ends.
; The line start lives on the stack (one word, replaced on every [N]); the routine pops it at the end, so X is not preserved.
; 
; === NOTES ===
; - Whether the clear of the new line can overwrite a line still on screen, how long the roll runs and what the 8-bit scroll does when it wraps are open (OQ-I010-17, OQ-I010-12). Spelling oddities in the credits text are OQ-I010-11.
---------------------------------------------

?BANK 02

?INCLUDE 'engine_boot_main_loop'
?INCLUDE 'lib_text_render'

!scroll_bg3_y                   0388
!vram_upload_flags              03B8
!name_cursor_col                0441
!name_cursor_row                0443
!bg3_tilemap_buffer             7F7000

---------------------------------------------

; Runs the name entry screen until the player accepts a name, which is left in the name buffer.
; 
; When: Cop3A_EnterPlayerName, once, at the start of the game after the Master's first speech.
; Sees: 'Please enter your name-', a 26 x 19 window with the letter grid, the name so far with eight + placeholders, and a cursor that the D-pad moves from letter to letter; B types the letter, Y deletes, Start finishes.
; Why: one blocking routine owns the screen, so the COP script just continues when it returns.
; In: long call (JSL); X = actor slot (Cop3A does TYX); M = 8, X = 16. Works with NMI on or off (WaitFrameReadButtons).
; Out: name in $1B92-$1B99, 0-terminated at [Y]; returns after the close text and one frame. P, X and Y are restored.
; Clobbers: A; name_cursor_col and name_cursor_row are zeroed.

RunNameEntryScreen {
    PHP 
    PHX 
    PHY 
    SEP #$20
    STZ $name_cursor_col
    STZ $name_cursor_row
    LDX #$03C6            ; Cursor starts on the blank cell left of 'A' ([CUR:3C6] of the grid); X = cursor cell from here on
    LDY #$1B92            ; Y = name write pointer; the loop below moves it past a name already in the buffer

  loc_0124FF:
    LDA $0000, Y
    BEQ BlipAndRedrawNameEntry
    INY 
    BRA loc_0124FF

; Plays the cursor sound, then redraws the screen with the cursor at its new cell.
; 
; When: after every cursor move and after a letter is typed (10 jumps).
; Sees: a short click and the cursor jumping to the new letter.
; Why: every move handler ends here, so the sound and the redraw are written once.
; In: X = cursor cell, Y = name write pointer.
; Out: BRK #$07, then falls into DrawNameEntryScreen.
; Clobbers: A.

  BlipAndRedrawNameEntry:
    BRK #$07              ; Sound request $07: cursor blip (OQ-I010-16)

; Prints the frame text and the letter grid, draws the cursor and waits for the buttons to be released.
; 
; When: on entry and after every move, append and delete.
; Sees: the whole screen repainted from the two strings (which erases the old cursor), then the cursor tile $2B in the cell and in the cell one row above (a two-row cursor).
; Why: there is no dirty-cell logic: printing both strings is the redraw.
; In: X = cursor cell, Y = name write pointer.
; Out: NameEntryFrameText and NameEntryGridText printed with PrintTextString (X and Y kept); falls into the release wait (loc_012525: no key is read until joy_pressed+1 is 0) and then PollNameEntryKeys.
; Clobbers: A.

  DrawNameEntryScreen:
    PHX 
    PHY 
    LDY #$&NameEntryFrameText
    JSL $@lib_text_render.PrintTextString
    LDY #$&NameEntryGridText
    JSL $@lib_text_render.PrintTextString
    PLY 
    PLX 
    LDA #$2B              ; Cursor tile $2B in the cell and in the cell one row above
    STA $bg3_tilemap_buffer, X
    STA $7F6FC0, X

  loc_012525:
    JSR $&lib_text_render.WaitFrameReadButtons ; Release wait: no key is read until every button is up, so one press is one step
    CMP #$00
    BNE loc_012525

; Reads the pad once per frame and routes the pressed button to its handler.
; 
; When: the key loop of the name entry screen.
; Sees: nothing by itself; the handlers do the visible work.
; Why: a branch ladder over joy_pressed+1: bit 0 Right, 1 Left, 2 Down, 3 Up, 4 Start, 5 Select (skipped by a double LSR), 6 Y, 7 B; the first set bit wins.
; In: -
; Out: A = joy_pressed+1 from WaitFrameReadButtons; jumps to MoveNameCursorRight, MoveNameCursorLeft, MoveNameCursorDown, MoveNameCursorUp, FinishNameEntry, DeleteNameChar or PickNameChar; with no button (or Select) it loops.
; Clobbers: A.

  PollNameEntryKeys:
    JSR $&lib_text_render.WaitFrameReadButtons ; A = joy_pressed+1; the LSR ladder tests Right, Left, Down, Up, Start, (Select skipped), Y, B
    LSR 
    BCC loc_012535
    BRL MoveNameCursorRight

  loc_012535:
    LSR 
    BCC loc_01253B
    BRL MoveNameCursorLeft

  loc_01253B:
    LSR 
    BCC loc_012541
    BRL MoveNameCursorDown

  loc_012541:
    LSR 
    BCC loc_012547
    BRL MoveNameCursorUp

  loc_012547:
    LSR 
    BCC loc_01254D
    BRL FinishNameEntry

  loc_01254D:
    LSR                   ; Two LSR: bit 5 (Select) is skipped
    LSR 
    BCC loc_012554
    BRL DeleteNameChar

  loc_012554:
    LSR 
    BCC loc_01255A
    BRL PickNameChar

  loc_01255A:
    BRA PollNameEntryKeys

; Moves the cursor up one grid row, wrapping from the top row to the bottom row.
; 
; When: the Up button in PollNameEntryKeys.
; Sees: the cursor jumps to the letter above; from the first row it wraps to the digit row.
; Why: the rows are not evenly spaced in the buffer (a blank row follows rows 1 and 3), so the step is computed.
; In: name_cursor_row (0-4), X = cursor cell.
; Out: row - 1 and X - $80 (X - $C0 when the old row was 2 or 4); from row 0: row 4 and X + $280. Jumps to BlipAndRedrawNameEntry.
; Clobbers: A.

  MoveNameCursorUp:
    LDA $name_cursor_row
    BEQ loc_012581
    DEC $name_cursor_row
    CMP #$02
    BEQ loc_01256C
    CMP #$04
    BNE loc_012574

  loc_01256C:
    REP #$20              ; Leaving row 2 or 4 upward: extra -$40 for the blank row after rows 1 and 3
    TXA 
    SEC 
    SBC #$0040
    TAX 

  loc_012574:
    REP #$20
    TXA 
    SEC 
    SBC #$0080
    TAX 
    SEP #$20
    BRL BlipAndRedrawNameEntry

  loc_012581:
    LDA #$04
    STA $name_cursor_row
    REP #$20
    TXA 
    CLC 
    ADC #$0280            ; Wrap to row 4: +$280 = four row steps ($80, $C0, $80, $C0)
    TAX 
    SEP #$20
    BRL BlipAndRedrawNameEntry

; Moves the cursor down one grid row, wrapping from the bottom row to the top row.
; 
; When: the Down button in PollNameEntryKeys.
; Sees: the cursor jumps to the letter below; from the digit row it wraps to the first row.
; Why: same uneven row spacing as MoveNameCursorUp.
; In: name_cursor_row (0-4), X = cursor cell.
; Out: row + 1 and X + $80 (X + $C0 when the old row was 1 or 3); from row 4: row 0 and X - $280. Jumps to BlipAndRedrawNameEntry.
; Clobbers: A.

  MoveNameCursorDown:
    LDA $name_cursor_row
    CMP #$04
    BCS loc_0125BA
    INC $name_cursor_row
    CMP #$01
    BEQ loc_0125A5
    CMP #$03
    BNE loc_0125AD

  loc_0125A5:
    REP #$20
    TXA 
    CLC 
    ADC #$0040
    TAX 

  loc_0125AD:
    REP #$20
    TXA 
    CLC 
    ADC #$0080
    TAX 
    SEP #$20
    BRL BlipAndRedrawNameEntry

  loc_0125BA:
    STZ $name_cursor_row
    REP #$20
    TXA 
    SEC 
    SBC #$0280
    TAX 
    SEP #$20
    BRL BlipAndRedrawNameEntry

; Moves the cursor one column left, wrapping from column 0 to column 12.
; 
; When: the Left button in PollNameEntryKeys.
; Sees: the cursor jumps to the previous letter; from the first column it wraps to the last.
; Why: a column is 4 bytes (two tiles), 13 columns, so the wrap is 12 * 4 = $30.
; In: name_cursor_col (0-12), X = cursor cell.
; Out: col - 1 and X - 4; from column 0: col 12 and X + $30. Jumps to BlipAndRedrawNameEntry.
; Clobbers: A.

  MoveNameCursorLeft:
    LDA $name_cursor_col
    BEQ loc_0125D9
    DEC $name_cursor_col
    DEX 
    DEX 
    DEX 
    DEX 
    BRL BlipAndRedrawNameEntry

  loc_0125D9:
    LDA #$0C
    STA $name_cursor_col
    REP #$20
    TXA 
    CLC 
    ADC #$0030            ; Wrap to column 12: 12 columns x 4 bytes
    TAX 
    SEP #$20
    BRL BlipAndRedrawNameEntry

; Moves the cursor one column right, wrapping from column 12 to column 0.
; 
; When: the Right button in PollNameEntryKeys.
; Sees: the cursor jumps to the next letter; from the last column it wraps to the first.
; Why: mirror of MoveNameCursorLeft.
; In: name_cursor_col (0-12), X = cursor cell.
; Out: col + 1 and X + 4; from column 12: col 0 and X - $30. Jumps to BlipAndRedrawNameEntry.
; Clobbers: A.

  MoveNameCursorRight:
    LDA $name_cursor_col
    CMP #$0C
    BCS loc_0125FC
    INC $name_cursor_col
    INX 
    INX 
    INX 
    INX 
    BRL BlipAndRedrawNameEntry

  loc_0125FC:
    STZ $name_cursor_col
    REP #$20
    TXA 
    SEC 
    SBC #$0030            ; Wrap to column 0
    TAX 
    SEP #$20
    BRL BlipAndRedrawNameEntry

; Removes the last character of the name.
; 
; When: the Y button, or B on the backspace tile ($24).
; Sees: the last typed letter disappears from the name line; nothing happens when the name is empty.
; Why: the button and the grid tile share one routine.
; In: Y = name write pointer.
; Out: Y - 1 and 0 stored at [Y]; then BlipAndRedrawNameEntry. With Y = $1B92 (empty) it returns to PollNameEntryKeys without a redraw.
; Clobbers: A.

  DeleteNameChar:
    CPY #$1B92
    BNE loc_012614
    BRL PollNameEntryKeys

  loc_012614:
    DEY 
    LDA #$00
    STA $0000, Y
    BRL BlipAndRedrawNameEntry

; Takes the grid cell under the cursor: a letter, the backspace tile or the accept tile.
; 
; When: the B button.
; Sees: the letter is appended to the name line with the confirm sound; on the backspace tile the last letter is removed; on the accept tile the name is finished.
; Why: the grid doubles as the control surface: tile $23 accepts and tile $24 deletes, so B needs no extra button.
; In: X = cursor cell, Y = name write pointer.
; Out: reads the tile at bg3_tilemap_buffer + 2 + X (the cell right of the cursor): $23 jumps to FinishNameEntry, $24 to DeleteNameChar; otherwise while Y < $1B9A the tile number is stored at [Y] and Y + 1 (loc_012631: BRK #$18, redraw); a ninth character is ignored (back to PollNameEntryKeys).
; Clobbers: A.

  PickNameChar:
    LDA $7F7002, X        ; Tile right of the cursor = the letter: $23 accepts the name, $24 deletes, anything else is the character
    CMP #$23
    BEQ FinishNameEntry
    CMP #$24
    BEQ DeleteNameChar
    CPY #$1B9A            ; Accept only while Y < $1B9A: the name buffer is $1B92-$1B99 (8 characters)
    BCC loc_012631
    BRL PollNameEntryKeys

  loc_012631:
    LDA $7F7002, X        ; The tile number is the character code stored in the name
    STA $0000, Y
    INY 
    BRK #$18              ; Sound request $18: confirm (OQ-I010-16)
    BRL DrawNameEntryScreen

; Ends the name entry: terminates the name and removes the window.
; 
; When: the Start button, or B on the accept tile.
; Sees: the window disappears and the game goes on; an empty name is not accepted (nothing happens).
; Why: the terminator goes where the buffer ended, so names shorter than 8 characters work.
; In: Y = name write pointer.
; Out: Y = $1B92 returns to PollNameEntryKeys; otherwise 0 is stored at [Y], NameEntryCloseText is printed (erases the window), one WaitFrameReadButtons frame runs and the routine returns (PLY, PLX, PLP, RTL: the exit of RunNameEntryScreen).
; Clobbers: A.

  FinishNameEntry:
    CPY #$1B92
    BNE loc_012646
    BRL PollNameEntryKeys

  loc_012646:
    LDA #$00
    STA $0000, Y
    LDY #$&NameEntryCloseText
    JSL $@lib_text_render.PrintTextString
    JSR $&lib_text_render.WaitFrameReadButtons
    PLY 
    PLX 
    PLP 
    RTL 
}
---------------------------------------------

; Prints and scrolls the staff roll text, one line per 32 frames.
; 
; When: the credits actor of gv_front_end (gv_obj_staff_roll_007638), with Y = the credits string.
; Sees: the credits (heading, names, copyright lines) scroll up the BG3 layer.
; Why: the text is far longer than the 32-row BG3 page, so each line is written as the layer scrolls and the page rows that have scrolled away are reused.
; In: long call (JSL); Y = string (bank $02); M = 8, X = 16; NMI off (RunSubFrame requires it, OQ-I005-20).
; Out: the whole string printed and scrolled; P and DBR restored (DBR is forced to $02 inside). X is not preserved: it is popped from the line-start slot, so the caller saves it (gv_obj_staff_roll_007638 does PHX/PLX).
; Clobbers: A, X, Y.

ScrollStaffRollText {
    PHP 
    PHB 
    SEP #$20
    LDA #$02
    PHA 
    PLB 
    LDX #$0702            ; First line start: BG3 row 28, column 1
    PHX 

; Fetches the next string byte and routes it; an ordinary byte is written as a two-tile glyph.
; 
; When: loop head of ScrollStaffRollText; every glyph, indent and line loops back here.
; Sees: the letter appears at the write cell with its upper half one row above.
; Why: one loop for the three codes (0, [N], [14:n]); anything else is a tile number.
; In: Y = string pointer, X = write cell, line start on the stack.
; Out: 0 goes to EndStaffRoll, $0D to ScrollStaffRollLine, $14 to IndentStaffRollLine; any other byte c is written as tile c with attribute $21 at X and tile c with attribute $20 at (X + $40) & $7FF, then X + 2.
; Clobbers: A.

  NextStaffRollByte:
    LDA $0000, Y
    BNE loc_0126E3
    BRL EndStaffRoll

  loc_0126E3:
    INY 
    CMP #$0D
    BEQ ScrollStaffRollLine
    CMP #$14
    BEQ IndentStaffRollLine
    PHX 
    PHA 
    STA $bg3_tilemap_buffer, X
    LDA #$21              ; Top half: tile c with attribute $21 (bit 0 = tile bit 8, tile c + $100); the bottom half below uses $20
    STA $7F7001, X
    REP #$20
    TXA 
    CLC 
    ADC #$0040            ; Next row (+$40); the AND wraps inside the 2 KB page
    AND #$07FF
    TAX 
    SEP #$20
    PLA 
    STA $bg3_tilemap_buffer, X
    LDA #$20
    STA $7F7001, X
    PLX 
    INX 
    INX 
    BRA NextStaffRollByte

; Starts the next credits line: scrolls BG3 by four tile rows and clears the rows that scrolled in.
; 
; When: a [N] byte in the credits string.
; Sees: the text moves up 32 pixels in 32 frames; the next line appears below the last one.
; Why: the scroll is the animation, one pixel per frame; the clear prepares the page rows for the next line.
; In: the line start is on the stack; X = write cell.
; Out: vram_upload_flags bit 0 set; scroll_bg3_y + 32 with one RunSubFrame per pixel; new line start (old + $100) & $7FF replaces the stacked one; 128 words (tile 0, attribute $20) cleared from it; X = new line start.
; Clobbers: A, dp$0C.

  ScrollStaffRollLine:
    LDA #$01
    TSB $vram_upload_flags
    LDA #$20

  loc_01271C:
    INC $scroll_bg3_y     ; One pixel of scroll per sub-frame; 32 frames = four tile rows = one line
    JSL $@engine_boot_main_loop.RunSubFrame
    DEC 
    BNE loc_01271C
    REP #$20
    PLA 
    CLC 
    ADC #$0100            ; New line start: four tile rows down
    AND #$07FF
    TAX 
    PHA 
    SEP #$20
    PHX 
    LDA #$80              ; Clear 128 words = the four 32-tile rows of the new line
    STA $0C

  loc_012739:
    LDA #$00
    STA $bg3_tilemap_buffer, X
    LDA #$20
    STA $7F7001, X
    INX 
    INX 
    DEC $0C
    BNE loc_012739
    PLX 
    BRL NextStaffRollByte

; Moves the write cell right by n tiles.
; 
; When: a [14:n] byte (the credits strings use 3 to 9).
; Sees: names are indented under their headings.
; Why: the credits layout is drawn with spaces that cost no string bytes.
; In: Y at the operand byte n, X = write cell.
; Out: X + 2n; Y + 1. The stacked line start is unchanged.
; Clobbers: A.

  IndentStaffRollLine:
    LDA $0000, Y
    INY 
    REP #$20
    AND #$00FF
    ASL 
    PHX 
    CLC 
    ADC $01, S
    STA $01, S
    PLX 
    SEP #$20
    BRL NextStaffRollByte

; Leaves ScrollStaffRollText.
; 
; When: the 0 terminator of the credits string.
; Sees: the credits stop scrolling.
; Why: the single exit of the routine.
; Out: PLX (pops the line-start slot, so X = the last line start), PLB, PLP, RTL.

  EndStaffRoll:
    PLX 
    PLB 
    PLP 
    RTL 
}
---------------------------------------------

; Text of the name entry screen: prompt, window, name line and placeholders.
; 
; [CUR:184][07:1A,13] draws a window (26 wide, 19 high interior) at BG3 offset $184; [CUR:24A] prints 'Please enter your name-'; [CUR:318][02:2] prints the current name (list entry 2 = $1B92); [09] switches to the one-row font and [CUR:358] prints eight + placeholders. Printed by DrawNameEntryScreen.

NameEntryFrameText |[CUR:184][07:1A,13][CUR:24A]Please enter your name-[CUR:318][02:2][09][CUR:358]++++++++|

---------------------------------------------
; Text of the letter grid: [CUR:3C6] and then five rows of 13 columns, each column a blank followed by the letter (4 bytes per column).
; 
; Rows: A-M, N-Z, a-m, n-z, then 0-9, '-', the tile $24 (backspace) and the tile $23 (accept). [N][N] steps two tile rows ($80) between rows; after the second and fourth row [N][N][N] steps three ($C0). Printed by DrawNameEntryScreen; the cursor handlers rely on this spacing.

NameEntryGridText |[CUR:3C6] A B C D E F G H I J K L M[N][N] N O P Q R S T U V W X Y Z[N][N][N] a b c d e f g h i j k l m[N][N] n o p q r s t u v w x y z[N][N][N] 0 1 2 3 4 5 6 7 8 9 - ← Æ[N][N]|

---------------------------------------------
; Text that closes the name entry screen: [08:184] erases the window drawn at BG3 offset $184 (EraseWindowFrame). Printed by FinishNameEntry.

NameEntryCloseText |[08:184]|