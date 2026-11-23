; Text renderer and dialogue renderer for the BG3 page, with their helpers and the frame and button wait helpers (file offsets 75625-78198, SNES $02:A769-$B175; list strings at 83849-83906, SNES $02:C789-$C7C1; bank 02).
; 
; === MODEL ===
; Both renderers write tile words into the BG3 tile page bg3_tilemap_buffer ($7F7000, 32 x 32 tiles, 2 bytes per tile, row stride $40); the NMI uploads the page when vram_upload_flags bit 0 is set (DmaBg3TilemapPage) and every renderer sets that bit before it returns. Offsets are byte offsets into the page; [CUR:o] gives the offset, so a text row is $40 bytes and a column is 2.
; A tile word is tile (low byte) and attribute (high byte): bits 0-1 are tile bits 8-9, bits 2-4 the palette, bit 5 priority. text_attr ($03E9) starts at $20 (priority, palette 0, tile bits 0).
; Two-row glyphs: the default font draws a character c as two tiles, the lower half tile c at X and the upper half tile c + $100 (attribute + 1) one row up at X - $40, so a line occupies two rows and the first line of a window starts two rows below the origin. For the first page row the upper halves land in the 64 bytes before the page ($7F6FC0-$7F6FFF, OQ-I010-7). One-row mode ([09] toggles text_attr bit 1 = tile bit 9) writes only the lower tile; the HUD strings and the name-entry placeholders use it (OQ-I010-4). [0A] toggles text_font_flip bit 7, ORed into every tile low byte, selecting tiles $80-$FF (OQ-I010-3).
; Strings live in bank $02 or in the WRAM mirror below $2000 (Y < $2000 reads WRAM: the player name $1B92, the debug buffer $1F02), because the renderers read them with DBR = $02. Bytes >= $80 are dictionary words: 12-byte entries of data_dictionary (bank $10), expanded followed by one blank.
; 
; === TWO RENDERERS ===
; PrintTextString (menu renderer): prints at once, saves and restores text_attr and text_font_flip, forces DBR = $02, returns X = the last line start. 58 call sites: menus, status, HUD, gauges, title and file-select screens, name entry, Cop02 and Cop1A. No delay, no key wait, not resumable.
; ShowDialogueText (dialogue renderer): typed text with a delay per glyph, key waits, paging and window scrolling, resumable. Callers: Cop01_ShowText, five sites in lib_tile_triggers_and_lair_return (chests and returns) and the debug scanner. It keeps the caller's DBR (bank $01 becomes $02), sets text_attr = $20, text_blip_flag = 1, text_font_flip = 0 and never restores text_attr and text_font_flip. It saves the line start in text_resume_pos at the end.
; 
; === CONTROL CODES (operand widths as in us/stringTypes.json) ===
; Code, operands, PrintTextString / ShowDialogueText:
; - 00: none. End / wait for a key (WaitForButtonPress), then end.
; - 01 [CUR:word]: X and the line start = word. Same in both.
; - 02 [02:n] (byte): print TextListPointers[n] with PrintStringPlain / PrintDialogueString.
; - 03 [03:v] (byte): text_attr = (text_attr & $E3) | v (replaces the palette bits; $24, $28, $2C = palette 1-3 with priority).
; - 04 [04:a,b] (two words): the WORD ADDRESSES of the current and the maximum value (not the values); DrawGaugeBar (FM-A6 called them values).
; - 05 [TBL:list,addr] (two words): list base and the WRAM address of the index; the entry is a pointer to the string.
; - 06 [06:n,addr] (byte, word): n packed-BCD digits at addr, written right to left, leading zeros blanked except the last digit.
; - 07 [07:w,h] (two bytes): window of w top-border tiles and h interior rows (DrawWindowFrame); the menu renderer also stores the origin in text_last_window_origin; the text cursor moves to line start + $82.
; - 08 [08:origin] (word): erase the window at origin (EraseWindowFrame).
; - 09: toggle one-row mode. 0A: toggle the alternate tile page.
; - 0B [0B:tile,&count] (byte, word): repeat the tile 'count' times, count = the byte at the address (HudRepeatCounts). Menu renderer only; the dialogue renderer skips the three operand bytes.
; - 0C [END]: ignored by the menu renderer; ends the dialogue without a key wait.
; - 0D [N]: next line: line start + $40 (menu) / + $80 and scrolling at the bottom (dialogue).
; - 0E [0E:n] delay n frames, 0F toggle the typing blip, 10 clear the window page and restart, 11 [FIN] blink the continue arrow, wait for B or Y, next line or restart page, 12 wait for a key: dialogue renderer only; the menu renderer prints these bytes as glyphs (OQ-I010-15).
; - 13 [JMP:word]: continue the string at that address. 14 [14:n]: n blank cells (low tile bytes only; the attribute stays).
; - 15-7F: glyph. 80-FF: dictionary word.
; 
; === DIALOGUE BOX FLOW (ShowDialogueText) ===
; 1. First byte $10: the standard box [07:16,9] at offset $0408 (BG3 row 16, column 4; 22 x 9 interior) is drawn and the $10 is consumed. First byte $01: a plain print at the caller's X. Anything else: continue the previous dialogue at text_resume_pos (the next line when text_delay is not 0, otherwise a cleared page).
; 2. DispatchDialogueCode fetches bytes with ReadDialogueByte and dispatches; a glyph is written (PrintDialogueGlyph) and followed by TickAfterGlyph: it sets the upload bit, waits text_delay frames (WaitFrames, so actors keep running) and plays the blip (BRK #$07) while text_blip_flag is set; a blank does neither.
; 3. [N] (AdvanceDialogueLine): looks at the tile two rows below the line start. Not the bottom border (tile 4): next line, X + $80. Border: with text_delay 0 the page is prompted and restarted (PromptThenAdvance), otherwise the window interior scrolls up two rows (FindTextWindowBounds, ScrollTextWindowUp).
; 4. [FIN]: PromptThenAdvance measures the window, blinks the down arrow (tile $3D) under the line start (BlinkContinuePrompt: first while B or Y is still held, then until it is pressed), then goes to the next line (text_delay not 0) or restarts the page.
; 5. 00 (after a key wait) and [END] leave through EndDialogue: line start into text_resume_pos, upload bit set, P and DBR restored.
; Window geometry written by FindTextWindowBounds: text_window_origin ($03EB, word) = interior top-left, text_window_width ($03ED) counted to tile 8, text_window_height ($03EF) counted to tile 6; the code reads the last two as words and relies on the high bytes being 0 (OQ-I010-9). Window tiles: 1 top-left, 2 top-right, 3 top, 4 bottom, 5 bottom-left, 6 bottom-right, 7 left, 8 right, $20 blank, $2B cursor, $3D continue arrow.
; 
; === GAUGE BAR (DrawGaugeBar) ===
; cur and max are read through the two addresses and only the low byte counts. The colour index is 2 * floor(cur / 10) taken before the clamp to 50 units, into data_engine_tables.GaugeColorLadder (13 words: dark blue for cur < 50, then lighter colours, white from 100); the colour goes to CGRAM colour 10 (HP bar of the HUD, bar start low byte $CC) or colour 14 (enemy bar). The bar is ceil(max / 2) tiles of $1B-$1F. This matches the walkthrough (level-up.md: 'fifty units in that bar ... each color adds ten more HP total, up to white'). A cur of 130 or more indexes past the table (OQ-I010-5).
; 
; === WAIT HELPERS ===
; WaitFrames (A frames of RunSubFrame), WaitForButtonPress (release, then press of B, Y or a direction), RunFrameReadButtons (one sub-frame, returns joy_pressed+1) and WaitFrameReadButtons (the same, or a vblank wait when NMI is on). They live in this file because the renderers use them.
; 
; === TEXT STATE ($03E9-$03F9, $1B84) ===
; text_attr $03E9 (byte); text_window_origin $03EB (word), text_window_width $03ED, text_window_height $03EF; text_resume_pos $03F3 (word; also written by the debug scanner); text_blip_flag $03F5 (bit 0, set to 1 at the start of a dialogue); text_last_window_origin $03F7 (word, origin of the last [07] drawn by the menu renderer; Cop02 and Cop1A erase it); text_font_flip $03F9 (bit 7); text_delay $1B84 (frames per printed glyph, 0 = instant; set to 3 by a new game, other values by speech scenes; the renderer reads a byte while the scenes write words, OQ-I010-1). The old reading of $1B84 as an ending flag is withdrawn.
; 
; === DATA ===
; TextListPointers ([02:n]) and its tile strings are at the end of the file.
; 
; === NOTES ===
; - Dictionary entry $06 is spelled 'Deathtole' in data_dictionary while every dialogue spells 'Deathtoll' (OQ-I010-2, DISCREPANCY with the walkthrough; unchanged here).
; - The helpers WaitFrames, RunFrameReadButtons and the dialogue renderer call RunSubFrame, so they need NMI off (OQ-I005-20).
---------------------------------------------

?BANK 02

?INCLUDE 'data_dictionary'
?INCLUDE 'data_engine_tables'
?INCLUDE 'engine_boot_main_loop'
?INCLUDE 'lib_system_helpers'

!frame_counter                  0312
!joy_pressed                    0322
!vram_upload_flags              03B8
!nmi_enabled                    03D2
!text_attr                      03E9
!text_window_origin             03EB
!text_window_width              03ED
!text_window_height             03EF
!text_resume_pos                03F3
!text_blip_flag                 03F5
!text_last_window_origin        03F7
!text_font_flip                 03F9
!text_delay                     1B84
!bg3_tilemap_buffer             7F7000

---------------------------------------------

; Prints a string into the BG3 tile page at once: the menu, status, HUD and gauge renderer.
; 
; When: 58 call sites in 10 files: Cop02 and Cop1A, the equipment, status and talk screens, the HUD, the title and file-select screens, the name entry screen, the pause screen and the front-end sequences.
; Sees: the text appears on the next frame (the NMI uploads the page); no typing, no key wait.
; Why: separate from ShowDialogueText because menus draw many strings in one frame and need no delay, waiting or paging.
; In: long call (JSL); Y = string (bank $02 or WRAM below $2000); X = BG3 byte offset for strings that do not start with [CUR]; M = 8, X = 16.
; Out: string printed, vram_upload_flags bit 0 set, DBR and P restored; X = the last line start; text_attr and text_font_flip restored to their values at entry.
; Clobbers: A, X, Y; dp$00, $02, $0C, $0E, $0F.
; Control codes: block note.

PrintTextString {
    PHP 
    PHB 
    SEP #$20
    LDA #$02
    PHA 
    PLB 
    LDA $text_font_flip   ; Save the font flip and the attribute: EndTextString restores them
    PHA 
    LDA $text_attr
    PHA 
    LDA #$20              ; Start every string with attribute $20 (priority, palette 0) and font flip 0
    STA $text_attr
    STZ $text_font_flip
    PHX 

; Fetches the next string byte and routes it to its handler.
; 
; When: the loop head of PrintTextString; every handler and PrintGlyph jump back here.
; Sees: -
; Why: one dispatch for all control codes. $14 and $13 are tested first, then $0D, then any byte above $0D is a glyph (so $0E-$12 print as glyphs here), $00 ends, and a DEC ladder handles $01-$0B; $0C is ignored.
; In: Y = string pointer, X = write cell, the line start on the stack.
; Out: jumps to the handler of the code.
; Clobbers: A.

  DispatchTextCode:
    JSR $&ReadTextByte
    CMP #$14
    BNE loc_01278C
    BRL HandleBlankRunCode

  loc_01278C:
    CMP #$13
    BEQ HandleJumpCode
    CMP #$0D
    BNE loc_012797
    BRL HandleNewlineCode

  loc_012797:
    BCS PrintGlyph
    CMP #$00
    BNE loc_0127A0
    BRL EndTextString

  loc_0127A0:
    DEC                   ; Ladder: one DEC per code, $01-$0B; $0C falls through and is ignored
    BNE loc_0127A6
    BRL HandleCursorCode

  loc_0127A6:
    DEC 
    BNE loc_0127AC
    BRL HandleListStringCode

  loc_0127AC:
    DEC 
    BNE loc_0127B2
    BRL HandleAttributeCode

  loc_0127B2:
    DEC 
    BNE loc_0127B8
    BRL HandleGaugeCode

  loc_0127B8:
    DEC 
    BNE loc_0127BE
    BRL HandleTableStringCode

  loc_0127BE:
    DEC 
    BNE loc_0127C4
    BRL HandleBcdNumberCode

  loc_0127C4:
    DEC 
    BNE loc_0127CA
    BRL HandleWindowCode

  loc_0127CA:
    DEC 
    BNE loc_0127D0
    BRL HandleEraseWindowCode

  loc_0127D0:
    DEC 
    BNE loc_0127D6
    BRL HandleFontPageCode

  loc_0127D6:
    DEC 
    BNE loc_0127DC
    BRL HandleAltFontCode

  loc_0127DC:
    DEC 
    BNE loc_0127E2
    BRL HandleRepeatTileCode

  loc_0127E2:
    BRA DispatchTextCode

; Writes one character as a two-tile glyph, or one tile in one-row mode.
; 
; When: any string byte $0E-$12 or $15-$7F.
; Sees: the letter at the write cell with its upper half one row above.
; Why: the font is two tiles tall: lower half tile c, upper half tile c + $100.
; In: A = character, X = write cell; text_attr, text_font_flip.
; Out: tile (c | text_font_flip) with attribute text_attr at X; unless text_attr bit 1 is set, tile c with attribute + 1 at X - $40; X + 2.
; Clobbers: A.

  PrintGlyph:
    ORA $text_font_flip   ; Tile low byte = char | font flip ($80 = alternate tile page); attribute from text_attr
    STA $bg3_tilemap_buffer, X
    XBA 
    LDA $text_attr
    STA $7F7001, X
    INX 
    INX 
    BIT #$02              ; text_attr bit 1 set = one-row mode: skip the upper half
    BEQ loc_0127FC
    BRL DispatchTextCode

  loc_0127FC:
    INC                   ; Upper half: attribute + 1 (tile bit 8) = tile c + $100, one row up (X was already advanced, hence the $7F6FBE base)
    STA $7F6FBF, X
    XBA 
    STA $7F6FBE, X
    BRL DispatchTextCode

; [JMP:word]: continues the string at another address.
; 
; When: a $13 byte.
; Sees: nothing; the text goes on from the other string.
; Why: lets strings share a common tail.
; In: Y at the 2-byte operand.
; Out: Y = the word.
; Clobbers: A.

  HandleJumpCode:
    LDA $0001, Y
    XBA 
    LDA $0000, Y
    TAY 
    BRL DispatchTextCode

; [14:n]: writes n blank cells.
; 
; When: a $14 byte.
; Sees: a gap in the line (menus use it for alignment).
; Why: a run costs two string bytes instead of n spaces.
; In: Y at the byte operand n, X = write cell.
; Out: the tile low byte $20 stored n times; the attribute already on the page and the upper rows are left alone (text_font_flip is not applied); X + 2n; Y + 1.
; Clobbers: A.

  HandleBlankRunCode:
    LDA #$20
    XBA 
    LDA $0000, Y
    INY 

  loc_01281B:
    XBA 
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    XBA 
    DEC 
    BNE loc_01281B
    BRL DispatchTextCode

; [0B:tile,&count]: repeats a tile along the row.
; 
; When: a $0B byte (the HUD frame draws its bars with it).
; Sees: a bar of identical tiles.
; Why: the repeat count is a byte of ROM data (HudRepeatCounts) instead of part of the string.
; In: Y at the operands: byte tile, word address of a byte holding the count.
; Out: the word text_attr:tile written 'count' times from X (a count of 0 draws nothing); X advanced; Y after the operands.
; Clobbers: A; dp$00.

  HandleRepeatTileCode:
    LDA $0000, Y          ; Operands: byte tile, word address of a byte that holds the repeat count
    INY 
    STA $00
    REP #$20
    LDA $0000, Y
    INY 
    INY 
    PHY 
    TAY 
    LDA $0000, Y
    AND #$00FF
    SEP #$20
    TAY 
    BEQ loc_012856
    LDA $text_attr
    XBA 
    LDA $00
    REP #$20

  loc_01284B:
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    DEY 
    BNE loc_01284B
    SEP #$20

  loc_012856:
    PLY 
    BRL DispatchTextCode

; [0A]: toggles the alternate tile page.
; 
; When: a $0A byte.
; Sees: following characters use tiles $80-$FF (a 4 x 5 tile block of the title screen is drawn this way, TileBlockText; the other uses are speech strings, OQ-I010-3).
; Why: the flip is ORed into every tile low byte, so one flag changes the whole page of tiles.
; In: -
; Out: text_font_flip ^= $80.
; Clobbers: A.

  HandleAltFontCode:
    LDA $text_font_flip
    EOR #$80
    STA $text_font_flip
    BRL DispatchTextCode

; [09]: toggles one-row mode.
; 
; When: a $09 byte.
; Sees: following characters are one tile tall (HUD labels, the name entry placeholders).
; Why: text_attr bit 1 is tile bit 9; the glyph code tests it to skip the upper half (OQ-I010-4).
; In: -
; Out: text_attr ^= $02.
; Clobbers: A.

  HandleFontPageCode:
    LDA $text_attr
    EOR #$02
    STA $text_attr
    BRL DispatchTextCode

; [08:origin]: erases a window.
; 
; When: an $08 byte (NameEntryCloseText).
; Sees: the window disappears.
; Why: the string that closes a screen can remove its own window.
; In: Y at the word operand.
; Out: EraseWindowFrame at X = origin; X and the line start are unchanged; Y + 2.
; Clobbers: A.

  HandleEraseWindowCode:
    PHX 
    REP #$20
    LDX $0000, Y
    INY 
    INY 
    SEP #$20
    JSL $@EraseWindowFrame
    PLX 
    BRL DispatchTextCode

; [07:w,h]: draws a window and starts the text inside it.
; 
; When: a $07 byte (menu and name entry windows).
; Sees: a framed box.
; Why: text and frame come from one string.
; In: Y at the operands: byte w, byte h; X = origin.
; Out: DrawWindowFrame; text_last_window_origin = X (Cop02 and Cop1A erase the choice window from it); the line start becomes line start + $82 (two rows and one tile in) and X follows.
; Clobbers: A, X; dp$00, $02.

  HandleWindowCode:
    LDA $0000, Y
    INY 
    STA $00
    LDA $0000, Y
    INY 
    STA $02
    STX $text_last_window_origin ; Remember the window origin: Cop02 and Cop1A erase the choice window from it
    JSR $&DrawWindowFrame
    REP #$20
    PLA 
    CLC 
    ADC #$0082            ; First text cell: two rows and one tile in (the upper half of the first line needs the row above)
    TAX 
    PHX 
    SEP #$20
    BRL DispatchTextCode

; [06:n,addr]: prints an n-digit packed-BCD number.
; 
; When: a $06 byte (HP, level, gems, EXP).
; Sees: the number with leading zeros blanked except the last digit.
; Why: stats are kept as BCD so no binary-to-decimal routine is needed.
; In: Y at the operands: byte n, word address of the BCD bytes (low nibble of the first byte is the last digit).
; Out: digit tiles $30 + nibble written right to left from X + 2 * (n - 1); leading zeros replaced by $20; unless one-row mode is on, each digit's upper half is written one row up; X = the cell after the number.
; Clobbers: A; dp$00, $02.

  HandleBcdNumberCode:
    LDA $0000, Y
    INY 
    STA $00
    STA $02
    REP #$20
    DEC                   ; X = last digit cell: start + 2 * (digits - 1); digits are written right to left
    AND #$00FF
    ASL 
    PHX 
    CLC 
    ADC $01, S
    STA $01, S
    TAX 
    LDA $0000, Y
    INY 
    INY 
    PHY 
    TAY 
    SEP #$20
    LDA $text_attr
    XBA 

  loc_0128C5:
    LDA $0000, Y
    AND #$0F
    ORA #$30              ; Digit tile = $30 + nibble; the low nibble of the byte is the lower digit
    REP #$20
    STA $bg3_tilemap_buffer, X
    DEX 
    DEX 
    SEP #$20
    DEC $00
    BEQ loc_0128F4
    LDA $0000, Y
    INY 
    AND #$F0
    LSR 
    LSR 
    LSR 
    LSR 
    ORA #$30
    REP #$20
    STA $bg3_tilemap_buffer, X
    DEX 
    DEX 
    SEP #$20
    DEC $00
    BNE loc_0128C5

  loc_0128F4:
    INX 
    INX 
    DEC $02
    BEQ loc_01290A
    LDA $bg3_tilemap_buffer, X
    CMP #$30              ; Leading zero: blank it; the last digit is never blanked (DEC of the count above)
    BNE loc_01290A
    LDA #$20
    STA $bg3_tilemap_buffer, X
    BRA loc_0128F4

  loc_01290A:
    XBA 
    BIT #$02
    BNE loc_01292A
    XBA 
    INC $02

  loc_012912:
    LDA $bg3_tilemap_buffer, X
    REP #$20
    ORA #$0100            ; Upper half of the digit: same tile with tile bit 8, one row up
    STA $7F6FC0, X
    AND #$FEFF
    SEP #$20
    INX 
    INX 
    DEC $02
    BNE loc_012912

  loc_01292A:
    PLY 
    PLX 
    INX 
    INX 
    BRL DispatchTextCode

; [TBL:list,addr]: prints entry i of a pointer list, i read from memory.
; 
; When: a $05 byte (item and magic names in the equipment window and the chest message).
; Sees: the name of the item or spell whose id is in the WRAM cell.
; Why: the string depends on game state, not on the script.
; In: Y at the operands: word list base, word address of the index.
; Out: PrintStringWithRuns on the pointer list[index].
; Clobbers: A, X; dp$00.

  HandleTableStringCode:
    REP #$20
    LDA $0000, Y          ; Operands: word list base, word address of the index; the list entry is a string pointer
    INY 
    INY 
    STA $00
    LDA $0000, Y
    INY 
    INY 
    PHY 
    TAY 
    LDA $0000, Y
    ASL 
    CLC 
    ADC $00
    TAY 
    LDA $0000, Y
    TAY 
    SEP #$20
    LDA $text_attr
    XBA 
    JSR $&PrintStringWithRuns
    PLY 
    BRL DispatchTextCode

; [04:cur_addr,max_addr]: draws a gauge bar.
; 
; When: a $04 byte (the enemy bar of EnemyGaugeText, [04:336,338]).
; Sees: a bar whose length and colour follow the two values.
; Why: the string names the WRAM words, so the bar follows the game state.
; In: Y at the operands: two word addresses (current value, maximum value).
; Out: the two words read into dp$00 and dp$02, DrawGaugeBar; Y + 4.
; Clobbers: A, X, Y; dp$00, $02.

  HandleGaugeCode:
    REP #$20
    PHY 
    LDA $0000, Y          ; Both operands are word ADDRESSES of the current and maximum value, not the values
    TAY 
    LDA $0000, Y
    STA $00
    PLY 
    PHY 
    LDA $0002, Y
    TAY 
    LDA $0000, Y
    STA $02
    SEP #$20
    JSR $&DrawGaugeBar
    PLY 
    INY 
    INY 
    INY 
    INY 
    BRL DispatchTextCode

; [03:v]: sets the palette and priority bits.
; 
; When: a $03 byte.
; Sees: following text in another palette (HUD colours).
; Why: the attribute is part of the string, so no code is needed to recolour a label.
; In: Y at the byte operand.
; Out: text_attr = (text_attr & $E3) | v.
; Clobbers: A.

  HandleAttributeCode:
    LDA $text_attr
    AND #$E3              ; Replace the palette bits 2-4 and OR in v ($24, $28, $2C = palette 1-3 with priority)
    ORA $0000, Y
    INY 
    STA $text_attr
    BRL DispatchTextCode

; [02:n]: prints list string n.
; 
; When: a $02 byte ([02:2] prints the player name in the status screen and many scripts).
; Sees: the name or label.
; Why: dynamic and shared strings (the player name at $1B92) live in one pointer list.
; In: Y at the byte operand n.
; Out: PrintStringPlain on TextListPointers[n]; Y + 1.
; Clobbers: A, X.

  HandleListStringCode:
    LDA $0000, Y
    INY 
    PHY 
    REP #$20
    AND #$00FF
    ASL 
    TAY 
    LDA $&TextListPointers, Y
    TAY 
    SEP #$20
    LDA $text_attr
    XBA 
    JSR $&PrintStringPlain
    PLY 
    BRL DispatchTextCode

; [CUR:word]: moves the write position.
; 
; When: a $01 byte (almost every string starts with one).
; Sees: the text appears at that cell.
; Why: placement is data in the string.
; In: Y at the word operand.
; Out: X = word and the stacked line start = word; Y + 2.
; Clobbers: A, X.

  HandleCursorCode:
    LDA $0001, Y
    STA $02, S            ; [CUR]: overwrite the stacked line start with the new offset
    XBA 
    LDA $0000, Y
    STA $01, S
    INY 
    INY 
    TAX 
    BRL DispatchTextCode

; [N]: next text row.
; 
; When: a $0D byte.
; Sees: the following text starts one tile row ($40) below the line start (two-row glyphs need [N][N] for a full line).
; Why: the line start is kept on the stack, so lines return to the same column.
; In: stacked line start.
; Out: line start + $40, X = line start.
; Clobbers: A, X.

  HandleNewlineCode:
    REP #$20
    PLA 
    CLC 
    ADC #$0040
    TAX 
    PHA 
    SEP #$20
    BRL DispatchTextCode

; Finishes PrintTextString.
; 
; When: the 0 terminator.
; Sees: the text appears on the next NMI upload.
; Why: the single exit; it restores the state the caller had.
; In: stack: line start, text_attr, text_font_flip, DBR, P.
; Out: X = the last line start; text_attr and text_font_flip restored; vram_upload_flags bit 0 set; DBR and P restored; RTL.
; Clobbers: A.

  EndTextString:
    PLX 
    PLA 
    STA $text_attr
    PLA 
    STA $text_font_flip
    LDA #$01
    TSB $vram_upload_flags
    PLB 
    PLP 
    RTL 
}

---------------------------------------------
; Returns the next string byte for PrintTextString and expands dictionary words on the way.
; 
; When: the first step of every dispatch.
; Sees: a dictionary word appears as its letters.
; Why: the dictionary expansion draws the word and then reads on, so the dispatcher only ever sees ordinary bytes and control codes.
; In: Y = string pointer.
; Out: A = the next byte below $80, Y advanced; a byte of $80 or more is expanded by ExpandDictionaryWord first.
; Clobbers: A.

ReadTextByte {
    LDA $0000, Y
    BMI ExpandDictionaryWord
    INY 
    RTS 

; Prints dictionary word (byte & $7F) and one blank.
; 
; When: a string byte of $80 or more, in the menu renderer.
; Sees: the word ('All', 'Soul', ...) in the current font, followed by a blank.
; Why: dialogue and menu text repeat common words, so each is stored once in data_dictionary (12-byte entries).
; In: A = byte >= $80, X = write cell; the attribute in B.
; Out: up to 12 characters of the entry (a 0 ends it early) written with the two-row or one-row rule, then one blank; X advanced; DBR restored; then back to ReadTextByte.
; Clobbers: A, Y (saved); dp$0C.

  ExpandDictionaryWord:
    INY 
    PHB 
    PHY 
    REP #$20
    AND #$007F            ; Dictionary word index = byte & $7F
    PHA 
    ASL                   ; x3 here, x4 below: 12 bytes per dictionary entry
    CLC 
    ADC $01, S
    ASL 
    ASL 
    TAY 
    PLA 
    SEP #$20
    LDA #$^data_dictionary.Dictionary ; The dictionary is in bank $10: switch DBR
    PHA 
    PLB 
    LDA #$0C              ; At most 12 characters per word
    STA $0C
    LDA $text_attr
    XBA 

  loc_012A00:
    LDA $&data_dictionary.Dictionary, Y
    BEQ loc_012A26
    INY 
    ORA $text_font_flip
    REP #$20
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    BIT #$0200            ; Tile word bit 9 ($0200) = one-row mode: only the lower tile; else the upper half goes one row up
    BNE loc_012A20
    ORA #$0100
    STA $7F6FBE, X
    AND #$FEFF

  loc_012A20:
    SEP #$20
    DEC $0C
    BNE loc_012A00

  loc_012A26:
    LDA #$20              ; One blank follows every dictionary word
    ORA $text_font_flip
    REP #$20
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    BIT #$0200
    BNE loc_012A42
    ORA #$0100
    STA $7F6FBE, X
    AND #$FEFF

  loc_012A42:
    SEP #$20
    PLY 
    PLB 
    BRA ReadTextByte
}

---------------------------------------------
; Prints a list string up to its 0 terminator, with [14:n] runs and dictionary words.
; 
; When: HandleTableStringCode (a pointer from a [TBL] list).
; Sees: the item or spell name.
; Why: list strings may contain blank runs, so they need the $14 case that PrintStringPlain lacks.
; In: Y = string, X = write cell, the attribute in B (the caller did LDA text_attr, XBA).
; Out: written to the 0 byte; Y on the terminator; X advanced.
; Clobbers: A, X.

PrintStringWithRuns {
    LDA $0000, Y
    BMI loc_012A73
    BNE loc_012A50
    RTS 

  loc_012A50:
    CMP #$14
    BEQ loc_012A79
    INY 
    ORA $text_font_flip
    REP #$20
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    BIT #$0200
    BNE loc_012A6F
    ORA #$0100
    STA $7F6FBE, X
    AND #$FEFF

  loc_012A6F:
    SEP #$20
    BRA PrintStringWithRuns

  loc_012A73:
    JSR $&ReadTextByte
    DEY 
    BRA PrintStringWithRuns

  loc_012A79:
    LDA #$20
    ORA $text_font_flip
    XBA 
    INY 
    LDA $0000, Y
    INY 

  loc_012A84:
    XBA 
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    XBA 
    DEC 
    BNE loc_012A84
    BRL PrintStringWithRuns
}

---------------------------------------------
; Prints a list string up to its 0 terminator, without runs.
; 
; When: HandleListStringCode.
; Sees: the player name, a HUD label.
; Why: the list strings are fixed text, so no control codes are needed.
; In: Y = string, X = write cell, the attribute in B.
; Out: written to the 0 byte (dictionary words allowed); Y on the terminator; X advanced.
; Clobbers: A, X.

PrintStringPlain {
    LDA $0000, Y
    BMI loc_012AB9
    BNE loc_012A9A
    RTS 

  loc_012A9A:
    INY 
    ORA $text_font_flip
    REP #$20
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    BIT #$0200
    BNE loc_012AB5
    ORA #$0100
    STA $7F6FBE, X
    AND #$FEFF

  loc_012AB5:
    SEP #$20
    BRA PrintStringPlain

  loc_012AB9:
    JSR $&ReadTextByte
    DEY 
    BRA PrintStringPlain
}

---------------------------------------------
; Draws a gauge bar of up to 25 tiles and sets its colour.
; 
; When: the [04] code in both renderers (the HUD HP bar and the enemy bar).
; Sees: a bar of 2 units per tile; its colour changes every 10 units (dark blue below 50, then lighter, white from 100).
; Why: the HP can exceed the 50 units the bar can show, so the colour carries the tens above 50 (walkthrough level-up.md).
; In: dp$00 = current, dp$02 = maximum (low bytes), X = bar start, M = 8.
; Out: tiles $1B-$1F written (low bytes only); X = the cell after the bar; the colour word data_engine_tables.GaugeColorLadder[2 * floor(cur / 10)] stored in cgram_buffer colour 10 (bar start low byte $CC) or colour 14; cur and max clamped to 50 in dp$00 and dp$02.
; Clobbers: A, X, Y; dp$00, $02. A cur of 130 or more reads past the 13-word table (OQ-I010-5).

DrawGaugeBar {
    PHX 
    LDX #$0000
    LDA $00

  loc_012AC5:
    SEC 
    SBC #$0A              ; X = 2 * floor(cur / 10), taken before the clamp: index into the colour table
    BMI loc_012ACE
    INX 
    INX 
    BRA loc_012AC5

  loc_012ACE:
    LDA $01, S
    CMP #$CC              ; Bar start low byte $CC = the HUD HP bar: colour 10 ($7F0014); any other bar uses colour 14 ($7F001C)
    BNE loc_012AE6
    LDA $@data_engine_tables.GaugeColorLadder, X
    STA $7F0014
    LDA $@data_engine_tables.GaugeColorLadder+1, X
    STA $7F0015
    BRA loc_012AF6

  loc_012AE6:
    LDA $@data_engine_tables.GaugeColorLadder, X
    STA $7F001C
    LDA $@data_engine_tables.GaugeColorLadder+1, X
    STA $7F001D

  loc_012AF6:
    LDA $00
    CMP #$33              ; Clamp cur (and max below) to 50 units
    BCC loc_012AFE
    LDA #$32

  loc_012AFE:
    STA $00
    LDA $02
    CMP #$33
    BCC loc_012B08
    LDA #$32

  loc_012B08:
    STA $02
    PLX 
    LDA $00               ; Tiles: cur / 2 full ($1B), an odd unit ends in $1C or $1D, the rest empty ($1E), an odd max ends in $1F
    LSR 
    BEQ loc_012B1F
    PHP 

  loc_012B11:
    XBA 
    LDA #$1B
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    XBA 
    DEC 
    BNE loc_012B11
    PLP 

  loc_012B1F:
    BCS loc_012B28
    LDA $02
    SEC 
    SBC $00
    BRA loc_012B42

  loc_012B28:
    LDA #$1C
    STA $bg3_tilemap_buffer, X
    LDA $02
    SEC 
    SBC $00
    BEQ loc_012B5C
    XBA 
    LDA #$1D
    STA $bg3_tilemap_buffer, X
    XBA 
    INX 
    INX 
    DEC 
    BEQ loc_012B5C

  loc_012B42:
    LSR 
    BEQ loc_012B54
    PHP 

  loc_012B46:
    XBA 
    LDA #$1E
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    XBA 
    DEC 
    BNE loc_012B46
    PLP 

  loc_012B54:
    BCC loc_012B5C
    LDA #$1F
    STA $bg3_tilemap_buffer, X

  loc_012B5C:
    RTS 
}

---------------------------------------------
; Draws an empty window frame with a blank interior.
; 
; When: HandleWindowCode and DrawDialogueWindow.
; Sees: a bordered box in the BG3 page.
; Why: all windows share one frame layout whose border tiles other code recognizes (FindTextWindowBounds and EraseWindowFrame scan for them).
; In: X = origin, dp$00 = width (top-border tiles), dp$02 = height (interior rows).
; Out: tile 1 top-left, 3 top edge, 2 top-right; per row 7, interior words text_attr:$20, 8; then 5, 4 edge, 6 at the bottom. Rows are $40 apart.
; Clobbers: A, X; dp$0C, $0E, $0F.

DrawWindowFrame {
    PHX 
    LDA #$01              ; Frame tiles: 1 top-left, 3 top, 2 top-right, 7 left, 8 right, 5 bottom-left, 4 bottom, 6 bottom-right
    STA $bg3_tilemap_buffer, X
    LDA $00
    STA $0C
    LDA #$03

  loc_012B6A:
    STA $7F7002, X
    INX 
    INX 
    DEC $0C
    BNE loc_012B6A
    LDA #$02
    STA $7F7002, X
    REP #$20
    PLA 
    CLC 
    ADC #$0040
    TAX 
    SEP #$20
    LDA $02
    STA $0C

  loc_012B88:
    PHX 
    LDA #$07
    STA $bg3_tilemap_buffer, X
    LDA $00
    STA $0E
    STZ $0F
    LDA $text_attr
    XBA 
    LDA #$20
    REP #$20

  loc_012B9D:
    STA $7F7002, X
    INX 
    INX 
    DEC $0E
    BNE loc_012B9D
    SEP #$20
    LDA #$08
    STA $7F7002, X
    REP #$20
    PLA 
    CLC 
    ADC #$0040
    TAX 
    SEP #$20
    DEC $0C
    BNE loc_012B88
    LDA #$05
    STA $bg3_tilemap_buffer, X
    LDA $00
    STA $0C
    LDA #$04

  loc_012BC9:
    STA $7F7002, X
    INX 
    INX 
    DEC $0C
    BNE loc_012BC9
    LDA #$06
    STA $7F7002, X
    RTS 
}

---------------------------------------------
; Erases a window frame, border and interior.
; 
; When: HandleEraseWindowCode and HandleDialogueEraseWindowCode, and Cop02 and Cop1A after a choice (the origin from text_last_window_origin).
; Sees: the window disappears (the caller sets the upload bit).
; Why: the window size is not stored, so the routine measures it from the border tiles.
; In: long call (JSL); X = window origin, which must hold tile 1 (anything else is ignored).
; Out: every row filled with tile 0, attribute $20 until the row ends in tile 6; vram_upload_flags is NOT set (both external callers set it).
; Clobbers: A, X; Y preserved; dp$00, $01, $0C.

EraseWindowFrame {
    PHY 
    LDA $bg3_tilemap_buffer, X
    CMP #$01              ; Only a window whose origin cell is tile 1 is erased
    BNE loc_012C25
    STZ $00
    STZ $01
    PHX 

  loc_012BE8:
    LDA $bg3_tilemap_buffer, X
    CMP #$02
    BEQ loc_012BF6
    INX 
    INX 
    INC $00
    BRA loc_012BE8

  loc_012BF6:
    PLX 

  loc_012BF7:
    REP #$20
    LDA $00
    STA $0C
    PHX 
    LDA #$2000            ; Erased cell = tile 0, attribute $20

  loc_012C01:
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    DEC $0C
    BNE loc_012C01
    LDA $bg3_tilemap_buffer, X
    TAY 
    LDA #$2000
    STA $bg3_tilemap_buffer, X
    PLX 
    TXA 
    CLC 
    ADC #$0040
    TAX 
    SEP #$20
    TYA 
    CMP #$06
    BNE loc_012BF7

  loc_012C25:
    PLY 
    RTL 
}

---------------------------------------------
; Types a dialogue string into the BG3 page with a delay per glyph, key waits and paging.
; 
; When: Cop01_ShowText (every NPC line, sign and chest message), five sites in lib_tile_triggers_and_lair_return and the debug scanner.
; Sees: the text window opens and the speech appears glyph by glyph; a down arrow blinks when the page is full and B or Y continues.
; Why: separate from PrintTextString because dialogue needs the delay, the waits, the paging and the resume.
; In: long call (JSL); Y = string; X = BG3 offset when the string starts with [CUR] (pushed as the line start; otherwise X is ignored and text_resume_pos is used); DBR = the caller's ($01 is changed to $02); M = 8, X = 16; NMI off.
; Out: text typed, text_resume_pos saved at the end; P and DBR restored.
; Clobbers: A, X, Y; text_attr, text_blip_flag and text_font_flip are initialised and not restored.

ShowDialogueText {
    PHP 
    PHB 
    SEP #$20
    LDA $01, S            ; $01,S = the caller's DBR (after PHP, PHB); bank $01 is switched to $02
    CMP #$01
    BNE InitDialogueState
    LDA #$02
    PHA 
    PLB 

; Initialises the text state and picks the entry path by the first string byte.
; 
; When: ShowDialogueText, right after the DBR choice.
; Sees: -
; Why: three ways in: open a box ($10), print at X ($01) or continue (anything else).
; In: Y = string.
; Out: text_attr = $20, text_blip_flag = 1, text_font_flip = 0; $01 goes to BeginPlainDialogue, $10 to OpenDialogueBox; otherwise X = text_resume_pos is pushed as the line start and the routine goes to AdvanceDialogueLine when text_delay is not 0, else to RestartDialoguePage.
; Clobbers: A, X.

  InitDialogueState:
    LDA #$20
    STA $text_attr
    LDA #$01
    STA $text_blip_flag
    STZ $text_font_flip
    LDA $0000, Y          ; First byte: $01 = plain print at X, $10 = open the standard box, else continue the previous dialogue
    CMP #$01
    BEQ BeginPlainDialogue
    CMP #$10
    BEQ OpenDialogueBox
    LDX $text_resume_pos  ; Continue: resume at the line start saved by the last call
    PHX 
    LDA $text_delay
    BEQ loc_012C59
    BRL AdvanceDialogueLine

  loc_012C59:
    BRL RestartDialoguePage

; Draws the standard dialogue box.
; 
; When: a string whose first byte is $10.
; Sees: a 22 x 9 box at BG3 row 16, column 4 (the lower part of the screen).
; Why: most dialogues share the same box, so the first byte stands for [07:16,9] at $0408.
; In: Y at the $10.
; Out: the $10 is consumed; width $16 and height 9 set; falls through to DrawDialogueWindow with $0408 as the line start. text_last_window_origin is not set (OQ-I010-14).
; Clobbers: A, X; dp$00, $02.

  OpenDialogueBox:
    INY 
    LDX #$0408            ; Standard box: BG3 row 16, column 4; 22 x 9 interior
    PHX 
    LDA #$16
    STA $00
    LDA #$09
    STA $02
    BRL DrawDialogueWindow

; Pushes the caller's X as the line start of a plain dialogue.
; 
; When: a string whose first byte is $01.
; Sees: -
; Why: the [CUR] code then replaces the pushed word, so X only matters for strings without it.
; In: X = BG3 offset.
; Out: X pushed; falls into DispatchDialogueCode.

  BeginPlainDialogue:
    PHX 

; Fetches the next byte and routes it to its handler.
; 
; When: the loop head of ShowDialogueText; every handler jumps back here.
; Sees: -
; Why: the same ladder as DispatchTextCode with the dialogue-only codes $0E-$12 added and $0B skipped.
; In: Y = string pointer, X = write cell, the line start on the stack.
; Out: $0D to AdvanceDialogueLine, $14 to HandleDialogueBlankRun, bytes above $14 to PrintDialogueGlyph, $00 to HandleEndWaitCode, $01-$0C and $0E-$13 to their handlers.
; Clobbers: A.

  DispatchDialogueCode:
    JSR $&ReadDialogueByte
    CMP #$0D
    BNE loc_012C77
    BRL AdvanceDialogueLine

  loc_012C77:
    CMP #$14
    BNE loc_012C7E
    BRL HandleDialogueBlankRun

  loc_012C7E:
    BCS PrintDialogueGlyph
    CMP #$00
    BNE loc_012C87
    BRL HandleEndWaitCode

  loc_012C87:
    DEC                   ; Same ladder as the menu renderer for $01-$0C; $0E-$13 follow below
    BNE loc_012C8D
    BRL HandleDialogueCursorCode

  loc_012C8D:
    DEC 
    BNE loc_012C93
    BRL HandleDialogueListStringCode

  loc_012C93:
    DEC 
    BNE loc_012C99
    BRL HandleDialogueAttributeCode

  loc_012C99:
    DEC 
    BNE loc_012C9F
    BRL HandleDialogueGaugeCode

  loc_012C9F:
    DEC 
    BNE loc_012CA5
    BRL HandleDialogueTableStringCode

  loc_012CA5:
    DEC 
    BNE loc_012CAB
    BRL HandleDialogueBcdCode

  loc_012CAB:
    DEC 
    BNE loc_012CB1
    BRL HandleDialogueWindowCode

  loc_012CB1:
    DEC 
    BNE loc_012CB7
    BRL HandleDialogueEraseWindowCode

  loc_012CB7:
    DEC 
    BNE loc_012CBD
    BRL HandleDialogueFontPageCode

  loc_012CBD:
    DEC 
    BNE loc_012CC3
    BRL HandleDialogueAltFontCode

  loc_012CC3:
    DEC 
    BNE loc_012CC9
    BRL SkipRepeatTileCode

  loc_012CC9:
    DEC 
    BNE loc_012CCF
    BRL EndDialogue

  loc_012CCF:
    DEC                   ; Two DECs: $0D was handled earlier, this reaches $0E
    DEC 
    BNE loc_012CD6
    BRL HandleDelayCode

  loc_012CD6:
    DEC 
    BNE loc_012CDC
    BRL HandleBlipToggleCode

  loc_012CDC:
    DEC 
    BNE loc_012CE2
    BRL RestartDialoguePage

  loc_012CE2:
    DEC 
    BNE loc_012CE8
    BRL HandleFinishCode

  loc_012CE8:
    DEC 
    BNE loc_012CEE
    BRL HandleWaitKeyCode

  loc_012CEE:
    DEC 
    BNE loc_012CF4
    BRL HandleDialogueJump

  loc_012CF4:
    BRL DispatchDialogueCode

; Writes one character like PrintGlyph, then ticks.
; 
; When: any dialogue byte above $14.
; Sees: the letter appears and the typing delay and blip follow.
; Why: the dialogue version adds the tick and the one-row clean-up of the row above.
; In: A = character, X = write cell.
; Out: two-row write as PrintGlyph; in one-row mode a stale overlay tile above ($FE or $FF) is blanked and characters $CC-$F3 draw tile $FE and $F4 and above draw $FF in the row above (OQ-I010-6); TickAfterGlyph; X + 2.
; Clobbers: A.

  PrintDialogueGlyph:
    ORA $text_font_flip
    STA $bg3_tilemap_buffer, X
    XBA 
    LDA $text_attr
    STA $7F7001, X
    INX 
    INX 
    BIT #$02
    BNE loc_012D18
    INC 
    STA $7F6FBF, X
    XBA 
    STA $7F6FBE, X
    BRA loc_012D42

  loc_012D18:
    LDA $7F6FBE, X        ; One-row mode: blank a stale overlay tile above ($FE/$FF), then draw $FE (char $CC-$F3) or $FF ($F4+) above (OQ-I010-6)
    CMP #$FE
    BCC loc_012D26
    LDA #$20
    STA $7F6FBE, X

  loc_012D26:
    XBA 
    CMP #$F4
    BCS loc_012D33
    CMP #$CC
    BCC loc_012D42
    LDA #$FE
    BRA loc_012D35

  loc_012D33:
    LDA #$FF

  loc_012D35:
    STA $7F6FBE, X
    XBA 
    LDA $text_attr
    STA $7F6FBF, X
    XBA 

  loc_012D42:
    JSR $&TickAfterGlyph
    BRL DispatchDialogueCode

; [JMP:word] in dialogue: continues the string at another address.
; 
; When: a $13 byte.
; Sees: nothing; the speech goes on from the other string.
; Why: shared text tails.
; In: Y at the word operand.
; Out: Y = the word.
; Clobbers: A.

  HandleDialogueJump:
    LDA $0001, Y
    XBA 
    LDA $0000, Y
    TAY 
    BRL DispatchDialogueCode

; [14:n] in dialogue: writes n blank cells with no tick.
; 
; When: a $14 byte.
; Sees: an indent.
; Why: same as HandleBlankRunCode without the typing delay.
; In: Y at the byte operand, X = write cell.
; Out: tile low byte $20 stored n times; X + 2n.
; Clobbers: A.

  HandleDialogueBlankRun:
    LDA #$20
    XBA 
    LDA $0000, Y
    INY 

  loc_012D5A:
    XBA 
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    XBA 
    DEC 
    BNE loc_012D5A
    BRL DispatchDialogueCode

; [12]: waits for a key.
; 
; When: a $12 byte.
; Sees: the speech pauses until B, Y or a direction is pressed.
; Why: lets a script split a line without a full page prompt.
; In: -
; Out: WaitForButtonPress.
; Clobbers: A; joy_release_latch bits and joy_pressed+1 consumed.

  HandleWaitKeyCode:
    JSR $&WaitForButtonPress
    BRL DispatchDialogueCode

; Clears the box interior and restarts at its top.
; 
; When: the [10] code in a string, a continuation with text_delay 0, and PromptThenAdvance when text_delay is 0.
; Sees: the box empties and the next text starts at the top line.
; Why: a new page of speech replaces the old one.
; In: the stacked line start (popped; any cell inside the window).
; Out: FindTextWindowBounds, ClearTextWindowInterior; X = text_window_origin + $40 (second interior row: the first row takes the upper halves) and pushed as the line start.
; Clobbers: A, X.

  RestartDialoguePage:
    PLX 
    JSR $&FindTextWindowBounds
    JSR $&ClearTextWindowInterior
    REP #$20
    LDA $text_window_origin
    CLC 
    ADC #$0040            ; Line start = interior top-left + $40: the first interior row takes the upper halves
    TAX 
    PHX 
    SEP #$20
    BRL DispatchDialogueCode

; [0F]: toggles the typing blip.
; 
; When: a $0F byte.
; Sees: the per-glyph click turns off or on.
; Why: some speech is silent.
; In: -
; Out: text_blip_flag ^= 1.
; Clobbers: A.

  HandleBlipToggleCode:
    LDA $text_blip_flag
    EOR #$01
    STA $text_blip_flag
    BRL DispatchDialogueCode

; [0E:n]: pauses the typing.
; 
; When: a $0E byte.
; Sees: a pause of n frames in the speech (not with text_delay 0).
; Why: dramatic pauses in scripted text.
; In: Y at the byte operand n.
; Out: WaitFrames(n) unless text_delay is 0; the operand is always consumed.
; Clobbers: A.

  HandleDelayCode:
    LDA $text_delay       ; text_delay 0 = instant text: the delay is skipped but the operand is still consumed
    BEQ loc_012D9C
    LDA $0000, Y
    JSL $@WaitFrames

  loc_012D9C:
    INY 
    BRL DispatchDialogueCode

; [0B] in dialogue: skips the three operand bytes; the repeat tile is not drawn.
; 
; When: a $0B byte in a dialogue string.
; Sees: nothing.
; Why: only the menu renderer draws repeats; the operands still have to be skipped.
; In: Y at the operands.
; Out: Y + 3.

  SkipRepeatTileCode:
    INY 
    INY 
    INY 
    BRL DispatchDialogueCode

; [0A] in dialogue: toggles the alternate tile page, as HandleAltFontCode.
; 
; When: a $0A byte.
; In: -
; Out: text_font_flip ^= $80.
; Clobbers: A.

  HandleDialogueAltFontCode:
    LDA $text_font_flip
    EOR #$80
    STA $text_font_flip
    BRL DispatchDialogueCode

; [09] in dialogue: toggles one-row mode, as HandleFontPageCode.
; 
; When: a $09 byte.
; In: -
; Out: text_attr ^= $02.
; Clobbers: A.

  HandleDialogueFontPageCode:
    LDA $text_attr
    EOR #$02
    STA $text_attr
    BRL DispatchDialogueCode

; [08:origin] in dialogue: erases a window, as HandleEraseWindowCode.
; 
; When: an $08 byte.
; In: Y at the word operand.
; Out: EraseWindowFrame at X = origin; X restored; Y + 2.
; Clobbers: A.

  HandleDialogueEraseWindowCode:
    PHX 
    REP #$20
    LDX $0000, Y
    INY 
    INY 
    SEP #$20
    JSL $@EraseWindowFrame
    PLX 
    BRL DispatchDialogueCode

; [07:w,h] in dialogue: reads the size and falls into DrawDialogueWindow.
; 
; When: a $07 byte.
; In: Y at the two byte operands.
; Out: dp$00 = w, dp$02 = h; unlike the menu renderer it does not store text_last_window_origin.
; Clobbers: A.

  HandleDialogueWindowCode:
    LDA $0000, Y
    INY 
    STA $00
    LDA $0000, Y
    INY 
    STA $02

; Draws the window at the line start and moves the cursor inside.
; 
; When: OpenDialogueBox and HandleDialogueWindowCode.
; Sees: the box.
; Why: shared tail of the two ways to open a window.
; In: dp$00 = width, dp$02 = height, the line start on the stack and in X.
; Out: DrawWindowFrame; the stacked line start and X become line start + $82.
; Clobbers: A, X.

  DrawDialogueWindow:
    JSR $&DrawWindowFrame
    REP #$20
    PLA 
    CLC 
    ADC #$0082
    TAX 
    PHX 
    SEP #$20
    BRL DispatchDialogueCode

; [06:n,addr] in dialogue: prints an n-digit packed-BCD number, as HandleBcdNumberCode.
; 
; When: a $06 byte.
; In: Y at the operands.
; Out: same digits and leading-zero rule; no typing tick.
; Clobbers: A, X; dp$00, $02.

  HandleDialogueBcdCode:
    LDA $0000, Y
    INY 
    STA $00
    STA $02
    REP #$20
    DEC 
    AND #$00FF
    ASL 
    PHX 
    CLC 
    ADC $01, S
    STA $01, S
    TAX 
    LDA $0000, Y
    INY 
    INY 
    PHY 
    TAY 
    SEP #$20
    LDA $text_attr
    XBA 

  loc_012E0E:
    LDA $0000, Y
    AND #$0F
    ORA #$30
    REP #$20
    STA $bg3_tilemap_buffer, X
    DEX 
    DEX 
    SEP #$20
    DEC $00
    BEQ loc_012E3D
    LDA $0000, Y
    INY 
    AND #$F0
    LSR 
    LSR 
    LSR 
    LSR 
    ORA #$30
    REP #$20
    STA $bg3_tilemap_buffer, X
    DEX 
    DEX 
    SEP #$20
    DEC $00
    BNE loc_012E0E

  loc_012E3D:
    INX 
    INX 
    DEC $02
    BEQ loc_012E53
    LDA $bg3_tilemap_buffer, X
    CMP #$30
    BNE loc_012E53
    LDA #$20
    STA $bg3_tilemap_buffer, X
    BRA loc_012E3D

  loc_012E53:
    XBA 
    BIT #$02
    BNE loc_012E73
    XBA 
    INC $02

  loc_012E5B:
    LDA $bg3_tilemap_buffer, X
    REP #$20
    ORA #$0100
    STA $7F6FC0, X
    AND #$FEFF
    SEP #$20
    INX 
    INX 
    DEC $02
    BNE loc_012E5B

  loc_012E73:
    PLY 
    PLX 
    INX 
    INX 
    BRL DispatchDialogueCode

; [TBL:list,addr] in dialogue: prints a pointer-list entry (item name in the chest message) with the typing delay.
; 
; When: a $05 byte.
; In: Y at the operands.
; Out: PrintDialogueString on list[index] with DBR = $02.
; Clobbers: A, X; dp$00.

  HandleDialogueTableStringCode:
    REP #$20
    LDA $0000, Y
    INY 
    INY 
    STA $00
    LDA $0000, Y
    INY 
    INY 
    PHY 
    TAY 
    LDA $0000, Y
    ASL 
    CLC 
    ADC $00
    TAY 
    SEP #$20
    PHB 
    LDA #$02
    PHA 
    PLB 
    REP #$20
    LDA $0000, Y
    TAY 
    SEP #$20
    LDA $text_attr
    XBA 
    JSR $&PrintDialogueString
    PLB 
    PLY 
    BRL DispatchDialogueCode

; [04:cur_addr,max_addr] in dialogue: draws a gauge bar, as HandleGaugeCode.
; 
; When: a $04 byte.
; In: Y at the operands (two word addresses).
; Out: DrawGaugeBar; Y + 4.
; Clobbers: A, X, Y; dp$00, $02.

  HandleDialogueGaugeCode:
    REP #$20
    PHY 
    LDA $0000, Y
    TAY 
    LDA $0000, Y
    STA $00
    PLY 
    PHY 
    LDA $0002, Y
    TAY 
    LDA $0000, Y
    STA $02
    SEP #$20
    JSR $&DrawGaugeBar
    PLY 
    INY 
    INY 
    INY 
    INY 
    BRL DispatchDialogueCode

; [03:v] in dialogue: sets the palette bits, as HandleAttributeCode.
; 
; When: a $03 byte.
; In: Y at the byte operand.
; Out: text_attr = (text_attr & $E3) | v.
; Clobbers: A.

  HandleDialogueAttributeCode:
    LDA $text_attr
    AND #$E3
    ORA $0000, Y
    INY 
    STA $text_attr
    BRL DispatchDialogueCode

; [02:n] in dialogue: prints list string n (the player name) with the typing delay.
; 
; When: a $02 byte.
; In: Y at the byte operand.
; Out: PrintDialogueString on TextListPointers[n] with DBR = $02; Y + 1.
; Clobbers: A, X.

  HandleDialogueListStringCode:
    LDA $0000, Y
    INY 
    PHY 
    REP #$20
    AND #$00FF
    ASL 
    TAY 
    SEP #$20
    PHB 
    LDA #$^TextListPointers
    PHA 
    PLB 
    REP #$20
    LDA $&TextListPointers, Y
    TAY 
    SEP #$20
    LDA $text_attr
    XBA 
    JSR $&PrintDialogueString
    PLB 
    PLY 
    BRL DispatchDialogueCode

; [CUR:word] in dialogue: moves the write position, as HandleCursorCode.
; 
; When: a $01 byte.
; In: Y at the word operand.
; Out: X and the stacked line start = word; Y + 2.
; Clobbers: A, X.

  HandleDialogueCursorCode:
    LDA $0001, Y
    STA $02, S
    XBA 
    LDA $0000, Y
    STA $01, S
    INY 
    INY 
    TAX 
    BRL DispatchDialogueCode

; [FIN]: pulls the line start into X and prompts for a key.
; 
; When: an $11 byte (the end of a page of speech).
; Sees: the down arrow blinks.
; Why: the page end is part of the string.
; In: stacked line start.
; Out: PLX; falls into PromptThenAdvance.

  HandleFinishCode:
    PLX 

; Blinks the continue arrow and then goes to the next line or restarts the page.
; 
; When: [FIN], and AdvanceDialogueLine when the box is full and text_delay is 0.
; Sees: the down arrow blinks below the text, roughly centred in the box; B or Y continues.
; Why: the player must be able to read a page before it is replaced.
; In: X = line start.
; Out: FindTextWindowBounds; arrow position = line start + ((width - 1) & $FFFE) + $40; BlinkContinuePrompt; with text_delay not 0 continues in AdvanceDialogueLine (the next line), with 0 in RestartDialoguePage.
; Clobbers: A, X.

  PromptThenAdvance:
    PHX 
    JSR $&FindTextWindowBounds
    REP #$20
    LDA $text_window_width ; Arrow column = (width - 1) & ~1 bytes from the line start, +$40 = the row below: centred under the text
    DEC 
    AND #$FFFE
    CLC 
    ADC $01, S
    CLC 
    ADC #$0040
    TAX 
    SEP #$20
    JSR $&BlinkContinuePrompt
    LDA $text_delay
    BNE AdvanceDialogueLine
    BRL RestartDialoguePage

; Moves to the next two-row line, scrolling the box when it is full.
; 
; When: a [N] byte, a continuation with text_delay not 0, and PromptThenAdvance.
; Sees: the next line appears below, or the text moves up two rows when the box is full.
; Why: a box holds a few lines; longer speech scrolls instead of paging when text_delay is not 0.
; In: the stacked line start.
; Out: pops the line start and tests the tile two rows below it: not tile 4 (bottom border): X + $80; border with text_delay 0: PromptThenAdvance; border otherwise: FindTextWindowBounds and ScrollTextWindowUp, line start unchanged. The line start is pushed again and DispatchDialogueCode continues.
; Clobbers: A, X.

  AdvanceDialogueLine:
    PLX 
    LDA $7F7080, X        ; Tile two rows below the line start: tile 4 = bottom border = the box is full
    CMP #$04
    BNE loc_012F51
    LDA $text_delay       ; Box full: text_delay 0 prompts and restarts the page, otherwise the interior scrolls up two rows
    BEQ PromptThenAdvance
    JSR $&FindTextWindowBounds
    JSR $&ScrollTextWindowUp
    BRA loc_012F5B

  loc_012F51:
    REP #$20
    TXA 
    CLC 
    ADC #$0080
    TAX 
    SEP #$20

  loc_012F5B:
    PHX 
    BRL DispatchDialogueCode

; 00 in dialogue: waits for a key, then ends.
; 
; When: a $00 byte.
; Sees: the speech stays until B, Y or a direction is pressed.
; Why: the last page must be read before the box can be closed.
; Out: WaitForButtonPress, falls into EndDialogue.
; Clobbers: A.

  HandleEndWaitCode:
    JSR $&WaitForButtonPress

; Finishes ShowDialogueText.
; 
; When: [END] ($0C) and HandleEndWaitCode.
; Sees: the last text stays on screen (the box is removed by script code, OQ-I010-14).
; Why: the line start is saved so the next call with another first byte can continue here.
; In: stacked line start.
; Out: text_resume_pos = line start; vram_upload_flags bit 0 set; PLB, PLP, RTL.
; Clobbers: A, X.

  EndDialogue:
    PLX 
    STX $text_resume_pos  ; Remember the line start: a later call with another first byte continues here
    LDA #$01
    TSB $vram_upload_flags
    PLB 
    PLP 
    RTL 
}

---------------------------------------------
; Returns the next dialogue byte and expands dictionary words with a tick per character.
; 
; When: the first step of every DispatchDialogueCode pass and from PrintDialogueString.
; Sees: a dictionary word typed out.
; Why: as ReadTextByte, with the typing delay.
; In: Y = string pointer.
; Out: A = next byte below $80; Y advanced.
; Clobbers: A.

ReadDialogueByte {
    LDA $0000, Y
    BMI ExpandDialogueWord
    INY 
    RTS 

; Prints dictionary word (byte & $7F) and one blank, each character followed by a tick.
; 
; When: a string byte of $80 or more in the dialogue renderer.
; Sees: the word typed out.
; Why: as ExpandDictionaryWord, with TickAfterGlyph per character (counter in dp$14).
; In: A = byte, X = write cell.
; Out: up to 12 characters and a blank written; X advanced; DBR restored.
; Clobbers: A, Y (saved); dp$14.

  ExpandDialogueWord:
    INY 
    PHB 
    PHY 
    REP #$20
    AND #$007F
    PHA 
    ASL 
    CLC 
    ADC $01, S
    ASL 
    ASL 
    TAY 
    PLA 
    SEP #$20
    LDA #$^data_dictionary.Dictionary
    PHA 
    PLB 
    LDA #$0C
    STA $14
    LDA $text_attr
    XBA 

  loc_012F94:
    LDA $&data_dictionary.Dictionary, Y
    BEQ loc_012FBD
    INY 
    ORA $text_font_flip
    REP #$20
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    BIT #$0200
    BNE loc_012FB4
    ORA #$0100
    STA $7F6FBE, X
    AND #$FEFF

  loc_012FB4:
    SEP #$20
    JSR $&TickAfterGlyph
    DEC $14
    BNE loc_012F94

  loc_012FBD:
    LDA #$20
    ORA $text_font_flip
    REP #$20
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    BIT #$0200
    BNE loc_012FD9
    ORA #$0100
    STA $7F6FBE, X
    AND #$FEFF

  loc_012FD9:
    SEP #$20
    PLY 
    PLB 
    BRA ReadDialogueByte
}

---------------------------------------------
; Prints a list string with a tick per glyph.
; 
; When: HandleDialogueTableStringCode and HandleDialogueListStringCode.
; Sees: the item name or the player name typed out.
; Why: as PrintStringPlain, with the typing delay (no [14] runs).
; In: Y = string, X = write cell, the attribute in B.
; Out: written to the 0 byte; Y on the terminator.
; Clobbers: A, X.

PrintDialogueString {
    LDA $0000, Y
    BMI loc_013009
    BNE loc_012FE7
    RTS 

  loc_012FE7:
    INY 
    ORA $text_font_flip
    REP #$20
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    BIT #$0200
    BNE loc_013002
    ORA #$0100
    STA $7F6FBE, X
    AND #$FEFF

  loc_013002:
    SEP #$20
    JSR $&TickAfterGlyph
    BRA PrintDialogueString

  loc_013009:
    JSR $&ReadDialogueByte
    DEY 
    BRA PrintDialogueString
}

---------------------------------------------
; Fills the window interior with blanks.
; 
; When: RestartDialoguePage.
; Sees: the box empties.
; Why: the interior size is read from the window record, so any window can be cleared.
; In: text_window_origin, text_window_width, text_window_height (read as words, OQ-I010-9).
; Out: height rows of width words $2020 (tile $20, attribute $20).
; Clobbers: A, X; dp$0C, $0E.

ClearTextWindowInterior {
    REP #$20
    LDX $text_window_origin
    LDA $text_window_height ; Height and width are words but are stored as bytes; the high bytes are assumed 0 (OQ-I010-9)
    STA $0E

  loc_013019:
    LDA $text_window_width
    STA $0C
    PHX 
    LDA #$2020

  loc_013022:
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    DEC $0C
    BNE loc_013022
    PLX 
    TXA 
    CLC 
    ADC #$0040
    TAX 
    DEC $0E
    BNE loc_013019
    SEP #$20
    RTS 
}

---------------------------------------------
; Blinks the down arrow (tile $3D) until B or Y is pressed.
; 
; When: PromptThenAdvance.
; Sees: the arrow blinks (16 frames on, 16 off) under the text; it disappears when the player continues.
; Why: tells the player the page is complete.
; In: X = arrow cell.
; Out: the first loop runs while B or Y is still held from the previous page, the second (loc_013069) waits for a new press; each pass sets the upload bit and calls RunFrameReadButtons; on exit the cell is blank and the upload bit set. The latch bits are not consumed here.
; Clobbers: A.

BlinkContinuePrompt {
    LDA #$3D              ; Tile $3D = the down arrow

  loc_01303C:
    STA $bg3_tilemap_buffer, X
    LDA #$01
    STA $vram_upload_flags
    JSR $&RunFrameReadButtons
    BIT #$C0
    BEQ loc_013069
    LDA $frame_counter    ; Blink: shown while frame_counter bit 4 is set (16 frames on, 16 off); this loop runs while B or Y is still held, the one at loc_013069 waits for a press
    AND #$10
    BNE BlinkContinuePrompt
    LDA #$20
    BRA loc_01303C

  loc_013057:
    LDA #$3D

  loc_013059:
    STA $bg3_tilemap_buffer, X
    LDA #$01
    STA $vram_upload_flags
    JSR $&RunFrameReadButtons
    BIT #$C0
    BNE loc_013074

  loc_013069:
    LDA $frame_counter
    AND #$10
    BNE loc_013057
    LDA #$20
    BRA loc_013059

  loc_013074:
    LDA #$20
    STA $bg3_tilemap_buffer, X
    LDA #$01
    STA $vram_upload_flags
    RTS 
}

---------------------------------------------
; Scrolls the window interior up by two rows and blanks the last two.
; 
; When: AdvanceDialogueLine when the box is full and text_delay is not 0.
; Sees: the speech moves up one line and a free line appears at the bottom.
; Why: lets long speech continue without a page prompt.
; In: text_window_origin, text_window_width, text_window_height.
; Out: height - 3 rows each copied from the row two below, then two rows filled with $2020; X preserved (PHX/PLX).
; Clobbers: A.

ScrollTextWindowUp {
    REP #$20
    PHX 
    LDX $text_window_origin
    LDA $text_window_height
    SEC 
    SBC #$0003            ; Rows copied = height - 3: each takes the row two below it; the last two rows are cleared
    BEQ loc_0130B0
    STA $0E

  loc_013091:
    LDA $text_window_width
    STA $0C
    PHX 

  loc_013097:
    LDA $7F7080, X
    STA $bg3_tilemap_buffer, X
    INX 
    INX 
    DEC $0C
    BNE loc_013097
    PLX 
    TXA 
    CLC 
    ADC #$0040
    TAX 
    DEC $0E
    BNE loc_013091

  loc_0130B0:
    LDA $text_window_width
    STA $0C
    LDA #$2020

  loc_0130B8:
    STA $bg3_tilemap_buffer, X
    STA $7F7040, X
    INX 
    INX 
    DEC $0C
    BNE loc_0130B8
    PLX 
    SEP #$20
    RTS 
}

---------------------------------------------
; Measures the window around a cell and stores its geometry.
; 
; When: RestartDialoguePage, PromptThenAdvance and AdvanceDialogueLine.
; Sees: -
; Why: the window size is not stored when it is drawn, so the renderer scans the border tiles.
; In: X = a cell inside the window.
; Out: scans left to tile 7 and up to tile 3 (X = interior top-left, text_window_origin), right to tile 8 (text_window_width) and down to tile 6 (text_window_height); X and Y preserved.
; Clobbers: A; dp$00.

FindTextWindowBounds {
    PHX 
    PHY 

  loc_0130CC:
    LDA $7F6FFE, X        ; Scan left for tile 7, up for tile 3 ($7F6FC0 = X - $40), right for tile 8, down for tile 6
    CMP #$07
    BEQ loc_0130D8
    DEX 
    DEX 
    BRA loc_0130CC

  loc_0130D8:
    LDA $7F6FC0, X
    CMP #$03
    BEQ loc_0130EC
    REP #$20
    TXA 
    SEC 
    SBC #$0040
    TAX 
    SEP #$20
    BRA loc_0130D8

  loc_0130EC:
    STX $text_window_origin
    STZ $00

  loc_0130F1:
    LDA $bg3_tilemap_buffer, X
    CMP #$08
    BEQ loc_0130FF
    INX 
    INX 
    INC $00
    BRA loc_0130F1

  loc_0130FF:
    LDA $00
    STA $text_window_width
    STZ $00

  loc_013106:
    LDA $bg3_tilemap_buffer, X
    CMP #$06
    BEQ loc_01311C
    REP #$20
    TXA 
    CLC 
    ADC #$0040
    TAX 
    SEP #$20
    INC $00
    BRA loc_013106

  loc_01311C:
    LDA $00
    STA $text_window_height
    PLY 
    PLX 
    RTS 
}

---------------------------------------------
; Per-glyph pause and typing sound.
; 
; When: after every printed character of the dialogue renderer.
; Sees: the speech appears at the speed set by text_delay, with a click per glyph.
; Why: the single place for the typing speed.
; In: A = the character.
; Out: a blank ($20 or $A0) returns at once; otherwise vram_upload_flags bit 0 set, WaitFrames(text_delay), and BRK #$07 while text_blip_flag is not 0.
; Clobbers: A.

TickAfterGlyph {
    AND #$7F              ; A blank ($20, or $A0 in the alternate font) neither waits nor clicks
    CMP #$20
    BNE loc_01312B
    RTS 

  loc_01312B:
    LDA #$01
    TSB $vram_upload_flags
    LDA $text_delay
    JSL $@WaitFrames
    LDA $text_blip_flag
    BNE loc_01313D
    RTS 

  loc_01313D:
    BRK #$07              ; Sound request $07: typing blip (OQ-I010-16)
    RTS 
}

---------------------------------------------
; Waits A frames by running RunSubFrame A times.
; 
; When: WaitReturnDone (A = $78), TryOpenChest, TickAfterGlyph and HandleDelayCode.
; Sees: the game keeps running (actors animate) while the caller waits.
; Why: a plain wait loop would freeze the actors.
; In: long call (JSL); A = frames (M = 8); NMI off.
; Out: returns after A sub-frames; A = 0.
; Clobbers: A.

WaitFrames {
    BEQ loc_013149
    JSL $@engine_boot_main_loop.RunSubFrame
    DEC 
    BRA WaitFrames

  loc_013149:
    RTL 
}

---------------------------------------------
; Waits until no button is down, then until B, Y or a direction is pressed, and consumes the press.
; 
; When: [12] and the text end ($00) in dialogue.
; Sees: the speech waits for the player.
; Why: waiting for the release first stops a held button from skipping the page.
; In: -
; Out: B and Y latch bits cleared ($032B bits $C0) and joy_pressed+1 cleared; the mask $CF covers B, Y and the four directions.
; Clobbers: A.

WaitForButtonPress {
    JSR $&RunFrameReadButtons
    BIT #$CF              ; $CF = B, Y and the four directions
    BNE WaitForButtonPress

  loc_013151:
    JSR $&RunFrameReadButtons
    BIT #$CF
    BEQ loc_013151
    LDA #$C0              ; Consume the B and Y latch bits so the press is not seen twice
    TRB $032B
    STZ $joy_pressed+1
    RTS 
}

---------------------------------------------
; Runs one sub-frame and returns the pad state.
; 
; When: WaitForButtonPress, BlinkContinuePrompt and WaitFrameReadButtons.
; Sees: one frame passes.
; Why: the frame step for loops that must keep the game running with NMI off.
; In: long call target of RunSubFrame; NMI off.
; Out: A = joy_pressed+1 (B, Y, Select, Start, Up, Down, Left, Right from bit 7 to 0).
; Clobbers: A.

RunFrameReadButtons {
    JSL $@engine_boot_main_loop.RunSubFrame
    LDA $joy_pressed+1
    RTS 
}

---------------------------------------------
; Waits one frame in either NMI mode and returns the pad state.
; 
; When: the name entry screen, the row choosers and the menus.
; Sees: one frame passes.
; Why: the same menu code runs with NMI on and off.
; In: JSR.
; Out: NMI off (nmi_enabled = 0): RunFrameReadButtons; NMI on: WaitVBlank. A = joy_pressed+1.
; Clobbers: A.

WaitFrameReadButtons {
    LDA $nmi_enabled      ; NMI off: drive one sub-frame; NMI on: wait for vblank
    BEQ RunFrameReadButtons
    JSL $@lib_system_helpers.WaitVBlank
    LDA $joy_pressed+1
    RTS 
}
---------------------------------------------

; List strings for the [02:n] text code: 9 pointers (index = n * 2).
; 
; 00 ListHudBarLabelTiles and 01 ListEnemyBarLabelTiles (the six-tile labels of the HUD and enemy bars), 02 = $1B92 (the player name, a WRAM address: the strings are read through the low-RAM mirror), 03 = $0447 (the eight-byte name field that DrawSaveSlotMenu fills for a save slot line; no extracted ROM string uses [02:3]), 04-08 ListTileBlockRow1-5 (rows of a 4 x 5 tile block that gv_title_texts.TileBlockText draws). A mnemonic cannot name the WRAM entries: a name inside this pointer table changes the assembled bytes (I027).

TextListPointers [
  &ListHudBarLabelTiles   ;00
  &ListEnemyBarLabelTiles   ;01
  $#1B92   ;02
  $#0447   ;03
  &ListTileBlockRow1   ;04
  &ListTileBlockRow2   ;05
  &ListTileBlockRow3   ;06
  &ListTileBlockRow4   ;07
  &ListTileBlockRow5   ;08
]

---------------------------------------------
; Tiles $0A-$0F: the six-tile label printed by [02:0] in HudFrameText.

ListHudBarLabelTiles #0A0B0C0D0E0F00

---------------------------------------------
; Tiles $10-$15: the six-tile label printed by [02:1] in EnemyGaugeText.

ListEnemyBarLabelTiles #10111213141500

---------------------------------------------
; Tiles $0C-$0F: first of five rows of four tiles printed by [02:4]-[02:8] in gv_title_texts.TileBlockText (drawn with [09][0A], so the tile numbers get the alternate-page flip).

ListTileBlockRow1 #0C0D0E0F00

---------------------------------------------
; Tiles $1C-$1F: second row of the 4 x 5 tile block of ListTileBlockRow1.

ListTileBlockRow2 #1C1D1E1F00

---------------------------------------------
; Tiles $2C-$2F: third row of the 4 x 5 tile block of ListTileBlockRow1.

ListTileBlockRow3 #2C2D2E2F00

---------------------------------------------
; Tiles $3C-$3F: fourth row of the 4 x 5 tile block of ListTileBlockRow1.

ListTileBlockRow4 #3C3D3E3F00

---------------------------------------------
; Tiles $4C-$4F: fifth row of the 4 x 5 tile block of ListTileBlockRow1.

ListTileBlockRow5 #4C4D4E4F00