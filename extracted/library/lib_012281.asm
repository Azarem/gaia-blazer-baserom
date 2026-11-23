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
; - ChooseMenuRow and ChooseMenuRowAtTable (lib_0118FC_part2) are the same loop for the equipment, file-select and erase menus with their own row spacing and page swap; they share BlinkChoiceCursor with this routine.
; - Nothing limits the option count except the window: the largest in use is 3.
---------------------------------------------

?BANK 02

?INCLUDE 'lib_shared_01230B'
?INCLUDE 'lib_text_render'

!vram_upload_flags              03B8
!menu_count                     03C4
!menu_blink                     03C6
!bg3_tilemap_buffer             7F7000

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
    JSR $&lib_shared_01230B.BlinkChoiceCursor
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
    JSR $&lib_shared_01230B.BlinkChoiceCursor
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