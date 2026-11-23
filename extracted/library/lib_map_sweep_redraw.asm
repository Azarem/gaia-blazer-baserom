; Sweep redraw: redraws the visible map line by line from the map data (code at file offsets 69354-69929, SNES $02:8EEA-$9129; SweepStepTable 93741-94860, SNES $02:EE2D-$F28C; bank 02).
; 
; === MODEL ===
; After a map rectangle was copied (lair release, plate, NPC release scenes) the screen still shows the old tiles. The sweep step counter sweep_step ($1C75, a word) walks from 1 to 35; StepSweepRedraw is called once per frame by RunSubFrameMapSweep and, while sweep_step is non-zero, redraws one line of 16 metatiles of the 17 x 17 view (the visible map area measured from the 16-pixel aligned scroll origin sweep_origin_x/y) into vram_write_queue. The order is in SweepStepTable: columns and rows alternate outwards from the middle (column 7, row 7, column 8, row 8, column 6, row 6, ...), the last steps cover the 17th column and row because the scroll is not aligned to 16 pixels. sweep_bg1 chooses the layer: non-zero = BG1 (tilemap $6000, map $7E8000, definitions $7E2000), zero = BG2 (tilemap $7000, map $7EC000, definitions $7E2800). After step 35 the counter returns to 0 (idle).
; The callers start a sweep with sweep_step = 1 and sweep_bg1 = 1 and then call RunSubFrameMapSweep 35 times; a two-layer release does a BG2 sweep first (sweep_bg1 = 0) and a BG1 sweep after it.
; 
; === NOTES ===
; - SweepStepTable: 35 steps x 32 bytes: 16 x indexes (0-$10) then 16 y indexes. Even steps are columns (x constant, y = 0-$F), odd steps rows.
---------------------------------------------

?BANK 02

?INCLUDE 'lib_arithmetic'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_pages                0343
!tile_mask_bg1                  035C
!tile_mask_bg2                  0360
!tile_attr_bg1                  036A
!tile_attr_bg2                  036E
!sweep_bg1                      1C6C
!sweep_step                     1C75
!sweep_origin_x                 1C77
!sweep_origin_y                 1C79
!vram_write_queue               1C7B

---------------------------------------------

; Queues one line of the sweep redraw for the current step and advances the step.
; 
; When: every sub-frame of RunSubFrameMapSweep (so while a lair, plate or NPC release scene runs).
; Sees: the changed part of the map wipes in from the middle of the screen outwards.
; Why: the copied map cells are drawn a line at a time so that the VRAM write queue is never overfull and the wipe is visible.
; In: sweep_step (0 = idle, returns at once), sweep_bg1, scroll_bg1_x/y; M = 1 (the routine widens it).
; Out: 16 metatiles of the step queued (16 bytes each, terminator 0) from the map of the layer; sweep_step incremented, reset to 0 after step 35. sweep_origin_x/y = the scroll rounded down to 16.
; Clobbers: A, X, Y, dp $0C, $16, $18 (P restored).

StepSweepRedraw {
    LDA $sweep_step
    BNE loc_010EF0
    RTL 

  loc_010EF0:
    LDA $sweep_bg1        ; sweep_bg1 non-zero: BG1 pass; zero: the BG2 pass further down
    BNE loc_010EF8
    BRL loc_010FAD

  loc_010EF8:
    PHP 
    REP #$20
    LDY #$0000
    LDA $scroll_bg1_x
    AND #$FFF0            ; Screen origin rounded down to a whole metatile
    STA $sweep_origin_x
    LDA $scroll_bg1_y
    AND #$FFF0
    STA $sweep_origin_y
    LDA $sweep_step
    DEC 
    ASL                   ; (step - 1) x 32 = the row of SweepStepTable
    ASL 
    ASL 
    ASL 
    ASL 
    TAX 
    LDA #$0010            ; 16 metatiles per step (one line of the view)
    STA $0C

  loc_010F1F:
    LDA $@SweepStepTable, X ; x index of the cell here, y index at + $10
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $sweep_origin_x
    STA $16
    LDA $@SweepStepTable+10, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $sweep_origin_y
    STA $18
    PHX 
    JSR $&LookupBg1TileAndVramAddr
    STA $vram_write_queue, Y
    INC 
    STA $1C7F, Y
    CLC 
    ADC #$001F
    STA $1C83, Y
    INC 
    STA $1C87, Y
    LDA $7E2000, X
    AND $tile_mask_bg1
    ORA $tile_attr_bg1
    STA $1C7D, Y
    LDA $7E2002, X
    AND $tile_mask_bg1
    ORA $tile_attr_bg1
    STA $1C81, Y
    LDA $7E2004, X
    AND $tile_mask_bg1
    ORA $tile_attr_bg1
    STA $1C85, Y
    LDA $7E2006, X
    AND $tile_mask_bg1
    ORA $tile_attr_bg1
    STA $1C89, Y
    PLX 
    TYA 
    CLC 
    ADC #$0010
    TAY 
    INX 
    DEC $0C
    BNE loc_010F1F
    LDA #$0000
    STA $vram_write_queue, Y
    INC $sweep_step
    LDA $sweep_step
    CMP #$0024            ; After step 35 the sweep is over (the counter goes back to 0)
    BCC loc_010FAB
    STZ $sweep_step

  loc_010FAB:
    PLP 
    RTL 

  loc_010FAD:
    PHP 
    REP #$20
    LDY #$0000
    LDA $scroll_bg1_x
    AND #$FFF0
    STA $sweep_origin_x
    LDA $scroll_bg1_y
    AND #$FFF0
    STA $sweep_origin_y
    LDA $sweep_step
    DEC 
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    TAX 
    LDA #$0010
    STA $0C

  loc_010FD4:
    LDA $@SweepStepTable, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $sweep_origin_x
    STA $16
    LDA $@SweepStepTable+10, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $sweep_origin_y
    STA $18
    PHX 
    JSR $&LookupBg2TileAndVramAddr
    STA $vram_write_queue, Y
    INC 
    STA $1C7F, Y
    CLC 
    ADC #$001F
    STA $1C83, Y
    INC 
    STA $1C87, Y
    LDA $7E2800, X
    AND $tile_mask_bg2
    ORA $tile_attr_bg2
    STA $1C7D, Y
    LDA $7E2802, X
    AND $tile_mask_bg2
    ORA $tile_attr_bg2
    STA $1C81, Y
    LDA $7E2804, X
    AND $tile_mask_bg2
    ORA $tile_attr_bg2
    STA $1C85, Y
    LDA $7E2806, X
    AND $tile_mask_bg2
    ORA $tile_attr_bg2
    STA $1C89, Y
    PLX 
    TYA 
    CLC 
    ADC #$0010
    TAY 
    INX 
    DEC $0C
    BNE loc_010FD4
    LDA #$0000
    STA $vram_write_queue, Y
    INC $sweep_step
    LDA $sweep_step
    CMP #$0024
    BCC loc_011060
    STZ $sweep_step

  loc_011060:
    PLP 
    RTL 
}

---------------------------------------------
; Returns the definition offset and the VRAM tilemap address of the BG1 metatile at a pixel position.
; 
; When: StepSweepRedraw (BG1 pass), once per metatile.
; Sees: nothing by itself.
; Why: the sweep needs the map byte (which metatile) and where its top-left tile lives in the 64 x 64 tilemap.
; In: dp$16 / $18 = pixel position in the map (multiples of 16 for y); M = 16.
; Out: X = metatile id x 8 (offset in the definition table), A = VRAM word address of its top-left tile (base $6000 + ((y and $F8) x 4) + ((x and $F8) / 8) + $400 when bit 8 of x + $800 when bit 8 of y).
; Clobbers: A, X.

LookupBg1TileAndVramAddr {
    LDA $18
    PHA 
    SEP #$20
    LDA $map_width_pages
    JSL $@lib_arithmetic.Multiply8x8
    STA $02, S
    LDA $16
    LSR 
    LSR 
    LSR 
    LSR 
    AND #$0F
    CLC 
    ADC $01, S
    STA $01, S
    LDA $17
    CLC 
    ADC $02, S
    STA $02, S
    REP #$20
    PLX 
    LDA $7E8000, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    TAX 
    LDA $18
    AND #$00F8
    ASL 
    ASL 
    PHA 
    LDA $16
    AND #$00F8
    LSR 
    LSR 
    LSR 
    CLC 
    ADC $01, S
    STA $01, S
    LDA $16
    AND #$0100
    ASL 
    ASL 
    CLC 
    ADC $01, S
    STA $01, S
    LDA $18
    AND #$0100
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $01, S
    STA $01, S
    PLA 
    CLC 
    ADC #$6000
    RTS 
}

---------------------------------------------
; Same as LookupBg1TileAndVramAddr for BG2.
; 
; When: StepSweepRedraw (BG2 pass).
; Sees: nothing by itself.
; Why: BG2 has its own map ($7EC000) and tilemap base ($7000).
; In: as LookupBg1TileAndVramAddr.
; Out: X = metatile id x 8 from $7EC000; A = VRAM address with base $7000.
; Clobbers: A, X.

LookupBg2TileAndVramAddr {
    LDA $18
    PHA 
    SEP #$20
    LDA $map_width_pages
    JSL $@lib_arithmetic.Multiply8x8
    STA $02, S
    LDA $16
    LSR 
    LSR 
    LSR 
    LSR 
    AND #$0F
    CLC 
    ADC $01, S
    STA $01, S
    LDA $17
    CLC 
    ADC $02, S
    STA $02, S
    REP #$20
    PLX 
    LDA $7EC000, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    TAX 
    LDA $18
    AND #$00F8
    ASL 
    ASL 
    PHA 
    LDA $16
    AND #$00F8
    LSR 
    LSR 
    LSR 
    CLC 
    ADC $01, S
    STA $01, S
    LDA $16
    AND #$0100
    ASL 
    ASL 
    CLC 
    ADC $01, S
    STA $01, S
    LDA $18
    AND #$0100
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $01, S
    STA $01, S
    PLA 
    CLC 
    ADC #$7000
    RTS 
}
---------------------------------------------

; The 35 steps of the sweep: the cell indexes of each line.
; 
; When: StepSweepRedraw reads step n at (n - 1) x 32.
; Sees: the wipe pattern: a column, then a row, widening from the middle.
; Why: data, not code, so the pattern can be changed without touching the routine.
; In: n/a (data). Bytes 0-$F = x indexes (metatile columns of the view, 0-$10), bytes $10-$1F = y indexes; the cell is origin + index x 16.
; Out: n/a. The last entry (22) is a row of x 1-$10 at y $10.
; Clobbers: n/a.

SweepStepTable [
  #07070707070707070707070707070707000102030405060708090A0B0C0D0E0F   ;00
  #000102030405060708090A0B0C0D0E0F07070707070707070707070707070707   ;01
  #08080808080808080808080808080808000102030405060708090A0B0C0D0E0F   ;02
  #000102030405060708090A0B0C0D0E0F08080808080808080808080808080808   ;03
  #06060606060606060606060606060606000102030405060708090A0B0C0D0E0F   ;04
  #000102030405060708090A0B0C0D0E0F06060606060606060606060606060606   ;05
  #09090909090909090909090909090909000102030405060708090A0B0C0D0E0F   ;06
  #000102030405060708090A0B0C0D0E0F09090909090909090909090909090909   ;07
  #05050505050505050505050505050505000102030405060708090A0B0C0D0E0F   ;08
  #000102030405060708090A0B0C0D0E0F05050505050505050505050505050505   ;09
  #0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A000102030405060708090A0B0C0D0E0F   ;0A
  #000102030405060708090A0B0C0D0E0F0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A0A   ;0B
  #04040404040404040404040404040404000102030405060708090A0B0C0D0E0F   ;0C
  #000102030405060708090A0B0C0D0E0F04040404040404040404040404040404   ;0D
  #0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B000102030405060708090A0B0C0D0E0F   ;0E
  #000102030405060708090A0B0C0D0E0F0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B0B   ;0F
  #03030303030303030303030303030303000102030405060708090A0B0C0D0E0F   ;10
  #000102030405060708090A0B0C0D0E0F03030303030303030303030303030303   ;11
  #0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C000102030405060708090A0B0C0D0E0F   ;12
  #000102030405060708090A0B0C0D0E0F0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C   ;13
  #02020202020202020202020202020202000102030405060708090A0B0C0D0E0F   ;14
  #000102030405060708090A0B0C0D0E0F02020202020202020202020202020202   ;15
  #0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D000102030405060708090A0B0C0D0E0F   ;16
  #000102030405060708090A0B0C0D0E0F0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D0D   ;17
  #01010101010101010101010101010101000102030405060708090A0B0C0D0E0F   ;18
  #000102030405060708090A0B0C0D0E0F01010101010101010101010101010101   ;19
  #0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E000102030405060708090A0B0C0D0E0F   ;1A
  #000102030405060708090A0B0C0D0E0F0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E0E   ;1B
  #00000000000000000000000000000000000102030405060708090A0B0C0D0E0F   ;1C
  #000102030405060708090A0B0C0D0E0F00000000000000000000000000000000   ;1D
  #0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F000102030405060708090A0B0C0D0E0F   ;1E
  #000102030405060708090A0B0C0D0E0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F0F   ;1F
  #10101010101010101010101010101010000102030405060708090A0B0C0D0E0F   ;20
  #000102030405060708090A0B0C0D0E0F10101010101010101010101010101010   ;21
  #0102030405060708090A0B0C0D0E0F1010101010101010101010101010101010   ;22
]