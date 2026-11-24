; Code that nothing in the ROM calls (file offsets 517-833 and 29873-29906, bank 00).
; 
; === DEBUG BLOCK (offsets 517-833, SNES $00:8205-$8341) ===
; DebugPollPad2 and its helpers have no caller and no vector entry: a pad 2 poll (Select: scan banks $00, $03, $04 and $1F for the bytes 02 01 AA followed by a word of $8000 or more; B: wait 30 frames; Y: show a hex position readout), a hex digit helper pair and table, and DebugApplyItem (a two-digit BCD item entry in $0484 that nothing writes). They look like leftover debug code; that is an inference, not proven (OQ-I005-22 asks for a CDL run). us/overrides.json forces M = 1 at offsets 517 and 797.
; DebugShowPosition writes hex digits into the text buffer $1F06-$1F1A (area, scene, location, tile x, x low digit, tile y, y low digit, actor count) and prints it from $1F02 through the text renderer PrintTextString; the template at $1F02-$1F05 is never initialised.
; 
; === UnusedAnimWaitStep4 (offset 29873) ===
; UnusedAnimWaitStep4 (SNES $00:F4B1) is an unreferenced actor script: it plays animation 07 (COP 80, COP 82) in a loop until $0482 = 4, plays 07 once more, then animations 08 and 09, increments $0482 and ends with COP 91. $0482 is the step counter of the gv_front_end sequence (written and read only there and here), and the routine lies between two of that file's INC $0482 sites, so it looks like an unused step of the title sequence (OQ-I006-7).
---------------------------------------------

?BANK 00

?INCLUDE 'lib_arithmetic'
?INCLUDE 'lib_inventory_store'
?INCLUDE 'lib_system_helpers'
?INCLUDE 'lib_text_render'

!area_current                   0314
!scene_current                  0316
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!vram_upload_flags              03B8
!text_resume_pos                03F3
!front_end_step                 0482
!location_id                    1C6A
!actor_run_count                1F00
!JOY2H                          421B

---------------------------------------------

; Pad 2 debug shortcuts (never called).
; 
; When: never; no reference exists in the ROM.
; Sees: nothing in the shipped game.
; Why: probably a developer hook (inference, OQ-I005-22).
; In: M = 1.
; Out: Select on pad 2 runs DebugScanBanks; B waits 30 frames; Y runs DebugShowPosition.
; Clobbers: A, X, Y; reads JOY2H ($421B).

DebugPollPad2 {
    LDA $JOY2H
    BIT #$20
    BEQ loc_000210
    JSR $&DebugScanBanks
    RTS 

  loc_000210:
    LDA $JOY2H
    BIT #$80
    BEQ loc_000223
    LDA #$1E

  loc_000219:
    PHA 
    JSL $@lib_system_helpers.WaitVBlank
    PLA 
    DEC 
    BNE loc_000219
    RTS 

  loc_000223:
    BIT #$40
    BEQ loc_00022A
    JSR $&DebugShowPosition

  loc_00022A:
    RTS 
}

---------------------------------------------
; Calls DebugScanBank for banks $00, $03, $04 and $1F (never called).

DebugScanBanks {
    LDA #$00
    JSR $&DebugScanBank
    LDA #$03
    JSR $&DebugScanBank
    LDA #$04
    JSR $&DebugScanBank
    LDA #$1F
    JSR $&DebugScanBank
    RTS 
}

---------------------------------------------
; Scans $8000-$FFFF of the bank in A for the bytes 02 01 AA followed by a word of $8000 or more and calls ShowDialogueText with $03F3 = $040A for each hit; purpose unknown (OQ-I023-4). In: A = bank. DBR restored. Clobbers: A, X, Y, $03F3.

DebugScanBank {
    PHB 
    PHA 
    PLB 
    LDX #$8000

  loc_000246:
    LDA $0000, X
    CMP #$02
    BNE loc_00026C
    LDA $0001, X
    CMP #$01
    BNE loc_00026C
    LDA $0002, X
    CMP #$AA
    BNE loc_00026C
    LDY $0003, X
    BPL loc_00026C
    PHX 
    LDX #$040A
    STX $text_resume_pos
    JSL $@lib_text_render.ShowDialogueText
    PLX 

  loc_00026C:
    INX 
    BNE loc_000246
    PLB 
    RTS 
}

---------------------------------------------
; Writes area, scene, location, tile x, x low digit, tile y, y low digit and the actor count as hex digits into $1F06-$1F1A, prints the buffer from $1F02 with PrintTextString and sets vram_upload_flags = 1 (never called). Clobbers: A, X, Y.

DebugShowPosition {
    LDA $area_current
    JSR $&DebugHexHighNibble
    STA $1F06
    LDA $area_current
    JSR $&DebugHexLowNibble
    STA $1F07
    LDA $scene_current
    JSR $&DebugHexHighNibble
    STA $1F09
    LDA $scene_current
    JSR $&DebugHexLowNibble
    STA $1F0A
    LDA $location_id
    JSR $&DebugHexHighNibble
    STA $1F0C
    LDA $location_id
    JSR $&DebugHexLowNibble
    STA $1F0D
    LDA $player_tile_x
    JSR $&DebugHexHighNibble
    STA $1F0F
    LDA $player_tile_x
    JSR $&DebugHexLowNibble
    STA $1F10
    LDA $player_x
    JSR $&DebugHexLowNibble
    STA $1F12
    LDA $player_tile_y
    JSR $&DebugHexHighNibble
    STA $1F14
    LDA $player_tile_y
    JSR $&DebugHexLowNibble
    STA $1F15
    LDA $player_y
    JSR $&DebugHexLowNibble
    STA $1F17
    LDA $actor_run_count
    JSR $&DebugHexHighNibble
    STA $1F19
    LDA $actor_run_count
    JSR $&DebugHexLowNibble
    STA $1F1A
    LDY #$1F02
    JSL $@lib_text_render.PrintTextString
    LDA #$01
    STA $vram_upload_flags
    RTS 
}

---------------------------------------------
; High nibble of A (four LSR) as an ASCII hex digit; falls into DebugHexLowNibble. In: A (8-bit). Out: A = ASCII.

DebugHexHighNibble {
    LSR 
    LSR 
    LSR 
    LSR 
}

---------------------------------------------
; Low nibble of A as an ASCII hex digit through DebugHexDigits; M = 1 on exit (B holds the next table byte). Clobbers: A, X.

DebugHexLowNibble {
    REP #$20
    AND #$000F
    TAX 
    LDA $@DebugHexDigits, X
    SEP #$20
    RTS 
}
---------------------------------------------

; The bytes 0123456789ABCDEF, indexed by a nibble.

DebugHexDigits #30313233343536373839414243444546
---------------------------------------------

; Converts the two BCD digits in $0484 to a binary entry number (high digit x 10 + low digit through Multiply8x8), stores that inventory entry with StoreInventoryEntry and clears $0484. Nothing writes $0484 (never called). M = 1 on exit. Clobbers: A, B.

DebugApplyItem {
    LDA $0484
    BNE loc_000323
    RTS 

  loc_000323:
    AND #$F0
    LSR 
    LSR 
    LSR 
    LSR 
    XBA 
    LDA #$0A
    JSL $@lib_arithmetic.Multiply8x8
    PHA 
    LDA $0484
    AND #$0F
    CLC 
    ADC $01, S
    JSL $@lib_inventory_store.StoreInventoryEntry
    PLA 
    STZ $0484
    RTS 
}
---------------------------------------------

; Unused step of the title sequence (inference, OQ-I006-7).
; 
; When: never; no reference exists in the ROM.
; Sees: nothing in the shipped game.
; Why: probably left over from the title sequence of gv_front_end, which also steps $0482.
; In: X = actor slot. Out: waits for $0482 = 4 with animation 07, plays 07, 08, 09, $0482 + 1, COP 91.
; Clobbers: A.

UnusedAnimWaitStep4 {
    COP [80] ( #07 )
    COP [82]
    LDA $front_end_step
    CMP #$0004
    BNE UnusedAnimWaitStep4
    COP [80] ( #07 )
    COP [82]
    COP [80] ( #08 )
    COP [82]
    COP [80] ( #09 )
    COP [82]
    INC $front_end_step
    COP [91]
    RTL 
}