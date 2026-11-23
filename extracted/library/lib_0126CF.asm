; Staff roll (credits) scroller (file offsets 75471-75625, SNES $02:A6CF-$A768, bank 02).
; 
; === MODEL ===
; ScrollStaffRollText prints a long string line by line on BG3 while scrolling the layer. The only caller is the credits actor of gv_front_end (code_007638, Y = gv_epilogue_texts.StaffRollText, 'The staff of Soul Blazer ...'); afterwards the actor waits two COP 1B delays of $F0 frames and changes scene with COP 10. The walkthrough (08-world-of-evil.md) says only 'Enjoy the credits'; the credits text is not quoted there.
; Each glyph is two tiles: tile c with attribute $21 (tile bit 8 set) at the write cell and tile c with attribute $20 one row below ((X + $40) & $7FF, wrapping inside the 2 KB page). [N] ($0D) scrolls scroll_bg3_y by 32 pixels, one pixel per RunSubFrame, moves the line start four tile rows down ((old + $100) & $7FF) and clears 128 words (four rows of tile 0, attribute $20) there. [14:n] moves the write cell right by n tiles. 0 ends.
; The line start lives on the stack (one word, replaced on every [N]); the routine pops it at the end, so X is not preserved.
; 
; === NOTES ===
; - Whether the clear of the new line can overwrite a line still on screen, how long the roll runs and what the 8-bit scroll does when it wraps are open (OQ-I010-17, OQ-I010-12). Spelling oddities in the credits text are OQ-I010-11.
---------------------------------------------

?BANK 02

?INCLUDE 'engine_boot_main_loop'

!scroll_bg3_y                   0388
!vram_upload_flags              03B8
!bg3_tilemap_buffer             7F7000

---------------------------------------------

; Prints and scrolls the staff roll text, one line per 32 frames.
; 
; When: the credits actor of gv_front_end (code_007638), with Y = the credits string.
; Sees: the credits (heading, names, copyright lines) scroll up the BG3 layer.
; Why: the text is far longer than the 32-row BG3 page, so each line is written as the layer scrolls and the page rows that have scrolled away are reused.
; In: long call (JSL); Y = string (bank $02); M = 8, X = 16; NMI off (RunSubFrame requires it, OQ-I005-20).
; Out: the whole string printed and scrolled; P and DBR restored (DBR is forced to $02 inside). X is not preserved: it is popped from the line-start slot, so the caller saves it (code_007638 does PHX/PLX).
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