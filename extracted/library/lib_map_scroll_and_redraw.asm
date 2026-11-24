; Camera aim, scroll streaming and the sweep redraw: everything that keeps the BG1 and BG2 maps on screen (file offsets 65536-67162 and 69354-69929, SNES $02:8000-$865A and $02:8EEA-$9129; SweepStepTable at 93741-94860; bank 02).
; 
; One file because the main loop, the NMI and the scene init call all three parts and the parts need nothing but lib_arithmetic. The sections below keep the notes of the three routines in file order: the camera aim, the scroll streaming, the sweep redraw.
; 
; Camera aim: one routine, AimCameraAtPlayer (file offsets 65536-65640, SNES $02:8000-$8068, bank 02).
; 
; The camera follows the player without smoothing: AimCameraAtPlayer converts 'where the camera should be' into the signed deltas scroll_delta_x and scroll_delta_y, and ScrollCameraByDelta (lib_map_scroll_and_redraw) applies them in the same frame. The whole scroll model is in the lib_map_scroll_and_redraw block note.
; 
; Scroll streaming: camera update, strip building and strip upload (file offsets 65641-67162, SNES $02:8069-$865A, bank 02).
; 
; === SCREEN MODEL ===
; BG1 and BG2 each show a map that is larger than their VRAM tilemap (64 x 64 tiles = 512 x 512 pixels). A map is a grid of 16 x 16 pixel metatiles stored one byte per metatile at $7E8000 (BG1) and $7EC000 (BG2), in pages of 256 bytes (16 x 16 metatiles = 256 x 256 pixels): page = (y >> 8) x map_width_pages + (x >> 8), cell = ((y >> 4) and 15) x 16 + ((x >> 4) and 15). map_width_px ($0342, word) is map_width_pages x 256; map_height_px likewise. A metatile definition is 8 bytes (four tile words: top-left, top-right, bottom-left, bottom-right) at $7E2000 (BG1) and $7E2800 (BG2). Bit 9 of a tile word is not a tile bit: it is the solid flag of that quarter, the mask $FDFF removes it before the word reaches VRAM, and SetMetatileBg1 gathers the four flags into the low nibble of the tile_type_map byte ($7F8000).
; The per-layer tables are word pairs indexed by X = 0 (BG1) or X = 4 (BG2): scroll_bg1_x/y and scroll_bg2_x/y, map_width_px/map_height_px, the parallax ratios ratio_x_bg1 .. ratio_y_bg2, map_base_bg1/2 ($8000, $C000), tilemap_vram_bg1/2 ($6000, $7000), tile_defs_bg1/2, tile_mask_bg1/2, tile_attr_bg1/2 and the strip buffers strip_col_bg1 .. strip_row_bg2. The scene loader fills them (lib_boot_and_scene_init, lib_scene_asset_loader).
; 
; === ONE FRAME ===
; Work phase (NMI off): AimCameraAtPlayer stores scroll_delta_x/y; ScrollCameraByDelta adds them to scroll_bg1_x/y (clamped to the map), derives BG2 from BG1 through the ratios (UpdateLayerScrollX/Y) and sets a request bit in scroll_requests ($0396: $80 = BG1 column, $40 = BG1 row, $20 = BG2 column, $10 = BG2 row) whenever the scroll crosses a 16-pixel line (bit 4 of the position changed); BuildScrollStrips tests and clears each bit and builds the strip for it (BuildColumnStrip / BuildRowStrip), then zeroes scroll_delta_x/y. In the NMI, UploadMapStripBuffers calls UploadScrollStrips for the BG1 pair and the BG2 pair of buffers.
; A strip record is 258 bytes in bank $7E: a word (the VRAM address of the strip, 0 = empty) and four blocks of 64 bytes. A column strip is one metatile column of the whole tilemap height: 2 tile columns x 64 tiles, written with VMAIN $81 (increment 32 words); a row strip is one metatile row of the whole width: 2 tile rows x 64 tiles, written with VMAIN $80. The blocks go to the VRAM address, address + 1 (or + $20), + $800 (or + $400) and + $801 (or + $420): the four 32 x 32 tile screens of a 64 x 64 tilemap. Buffer addresses: BG1 column $3000, BG1 row $3102, BG2 column $3204, BG2 row $3306.
; A column strip goes at the right edge of the view (scroll x + $100) for a positive delta and at the left edge (scroll x) for a negative one; a row strip likewise below (scroll y + $100) or above. FillColumnStripBuffer / FillRowStripBuffer read 2 pages along the strip (the second is the next page, wrapping at the end of the map for columns) and CopyMetatileColumn / CopyMetatileRow expand 16 metatiles into 2 x 2 tiles each, applying the layer's tile mask and attribute.
; 
; === ENTRY REDRAW ===
; RedrawBackgroundsAtEntry (called once by the scene change code, not for location $10) places the camera on the player, derives BG2, wraps the BG2 scroll into its map and then builds and uploads 32 column strips per layer (32 x 16 px = the whole 512-pixel tilemap width), one strip at a time through UploadScrollStrips with NMI off.
; 
; === NOTES ===
; - ScaleByRatio computes scroll x numerator / divisor: the ratio word has the numerator in its low byte and the divisor in its high byte (using the PPU multiplier $211B/$211C and the hardware divider $4204/$4206), so $0201 is half speed and $0101 is the same speed.
; - BuildScrollStrips is mis-decoded by the extractor (OQ-I005-7, OQ-I026-1): read its part note for the real code.
; - scroll_bg1_x/y and scroll_bg2_x/y are positions in map pixels; the NMI writes them to the PPU scroll registers (WriteScrollRegisters; bg_scroll_swap exchanges the two pairs between BG1 and BG2).
; 
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
!map_width_px                   0342
!map_width_pages                0343
!map_height_px                  0344
!map_height_pages               0345
!ratio_x_bg1                    034A
!ratio_y_bg1                    034C
!ratio_x_bg2                    034E
!ratio_y_bg2                    0350
!map_base_bg1                   0352
!tilemap_vram_bg1               0354
!tile_defs_bg1                  035A
!tile_mask_bg1                  035C
!tile_mask_bg2                  0360
!strip_col_bg1                  0362
!strip_row_bg1                  0364
!tile_attr_bg1                  036A
!tile_attr_bg2                  036E
!player_x                       0374
!player_y                       0376
!scroll_delta_x                 0382
!scroll_delta_y                 0384
!bg2_offset_x                   038A
!bg2_offset_y                   038C
!bg2_delta_x                    038E
!bg2_delta_y                    0390
!scroll_requests                0396
!view_height_px                 03CA
!sweep_bg1                      1C6C
!sweep_step                     1C75
!sweep_origin_x                 1C77
!sweep_origin_y                 1C79
!vram_write_queue               1C7B
!VMAIN                          2115
!VMADDL                         2116
!M7A                            211B
!M7B                            211C
!MPYL                           2134
!WRDIVL                         4204
!WRDIVB                         4206
!MDMAEN                         420B
!RDDIVL                         4214
!RDDIVH                         4215
!DMAP2                          4320
!BBAD2                          4321
!A1T2L                          4322
!A1B2                           4324
!DAS2L                          4325

---------------------------------------------

; Computes how far the camera must move to centre on the player and stores it as the scroll deltas.
; 
; When: every frame from the player code (player_core), in every sub-frame of the scene loader (RunSubFrameLoader), and from the Grass Valley name-entry actor.
; Sees: the screen follows the player and stops at the map edges (the walkthrough's rooms scroll only as far as the map goes).
; Why: keeps the scroll logic in one place: this routine only says where to go, ScrollCameraByDelta does the clamping to the map and the strip requests.
; In: none (native mode; M and X are set to 16 bits inside). Reads player_x, player_y, scroll_bg1_x, scroll_bg1_y, map_width_px, map_height_px, view_height_px.
; Out: scroll_delta_x = target x - scroll_bg1_x with target x = player_x - $70, limited to 0 .. map_width_px - $100; scroll_delta_y likewise with player_y - $80 and the view height view_height_px ($E0 or $100) in place of $100. The scroll itself is not changed.
; Clobbers: A, X, Y (P restored).

AimCameraAtPlayer {
    PHP 
    REP #$30
    LDX #$0000
    TXY 
    LDA $scroll_bg1_x
    PHA 
    LDA $player_x
    SEC 
    SBC #$0070            ; Target x: the player's x minus $70, so the player sits a little left of the centre of the 256-pixel view
    BPL loc_010019
    LDA #$0000
    BRA loc_01002F

  loc_010019:
    CLC 
    ADC #$0100
    CMP $map_width_px
    BCS loc_010028
    SEC 
    SBC #$0100
    BRA loc_01002F

  loc_010028:
    LDA $map_width_px
    SEC 
    SBC #$0100

  loc_01002F:
    SEC 
    SBC $01, S            ; Delta = target - current scroll: the camera snaps to its target in one frame (no easing)
    TAX 
    PLA 
    LDA $scroll_bg1_y
    PHA 
    LDA $player_y
    SEC 
    SBC #$0080
    BPL loc_010046
    LDA #$0000
    BRA loc_01005C

  loc_010046:
    CLC 
    ADC $view_height_px
    CMP $map_height_px
    BCS loc_010055
    SEC 
    SBC $view_height_px
    BRA loc_01005C

  loc_010055:
    LDA $map_height_px
    SEC 
    SBC $view_height_px

  loc_01005C:
    SEC 
    SBC $01, S
    TAY 
    PLA 
    STX $scroll_delta_x
    STY $scroll_delta_y
    PLP 
    RTL 
}
---------------------------------------------

; Moves BG1 by scroll_delta_x/y within the map and brings BG2 along; requests new strips when a 16-pixel line was crossed.
; 
; When: every game frame (main loop, return loop and every sub-frame runner), after AimCameraAtPlayer.
; Sees: the map scrolls with the player and the parallax layer behind it moves at its own speed.
; Why: the scroll position, the strip requests and the BG2 position must change together.
; In: scroll_delta_x, scroll_delta_y (signed words). M and X are set to 16 bits inside (PHP / PLP).
; Out: scroll_bg1_x/y = old + delta, limited to 0 .. map size - view size ($100 wide, view_height_px high). scroll_requests gets $80 (x) or $40 (y) when bit 4 of the position changed. BG2: if ratio_x_bg2 is non-zero UpdateLayerScrollX runs with request bit $20, if ratio_y_bg2 is non-zero UpdateLayerScrollY with $10 (X = 4). The deltas are not cleared here (BuildScrollStrips does).
; Clobbers: A, X (P restored).

ScrollCameraByDelta {
    PHP 
    REP #$20
    LDA $scroll_delta_x
    BEQ loc_0100AE
    BPL loc_010084
    LDA $scroll_bg1_x
    BEQ loc_0100AE
    PHA 
    CLC 
    ADC $scroll_delta_x
    BPL loc_01009C
    LDA #$0000
    BRA loc_01009C

  loc_010084:
    LDA $scroll_bg1_x
    PHA 
    CLC 
    ADC $scroll_delta_x
    CLC 
    ADC #$0100
    CMP $map_width_px
    BCC loc_010098
    LDA $map_width_px

  loc_010098:
    SEC 
    SBC #$0100

  loc_01009C:
    STA $scroll_bg1_x
    PLA 
    EOR $scroll_bg1_x
    AND #$0010
    BEQ loc_0100AE
    LDA #$0080            ; Request bit $80: a BG1 column strip is needed (the scroll crossed a 16-pixel line in x)
    TSB $scroll_requests

  loc_0100AE:
    LDA $scroll_delta_y
    BEQ loc_0100F0
    BPL loc_0100C6
    LDA $scroll_bg1_y
    BEQ loc_0100F0
    PHA 
    CLC 
    ADC $scroll_delta_y
    BPL loc_0100DE
    LDA #$0000
    BRA loc_0100DE

  loc_0100C6:
    LDA $scroll_bg1_y
    PHA 
    CLC 
    ADC $scroll_delta_y
    CLC 
    ADC $view_height_px
    CMP $map_height_px
    BCC loc_0100DA
    LDA $map_height_px

  loc_0100DA:
    SEC 
    SBC $view_height_px

  loc_0100DE:
    STA $scroll_bg1_y
    PLA 
    EOR $scroll_bg1_y
    AND #$0010
    BEQ loc_0100F0
    LDA #$0040            ; Request bit $40: a BG1 row strip is needed
    TSB $scroll_requests

  loc_0100F0:
    LDX #$0004            ; X = 4: the BG2 entries of the per-layer word-pair tables
    LDA $ratio_x_bg2
    BEQ loc_0100FE
    LDA #$0020
    JSR $&UpdateLayerScrollX

  loc_0100FE:
    LDA $ratio_y_bg2
    BEQ loc_010109
    LDA #$0010
    JSR $&UpdateLayerScrollY

  loc_010109:
    PLP 
    RTL 
}
---------------------------------------------

; Builds the strips for every request bit in scroll_requests, then clears the scroll deltas. The extractor decodes it wrongly (OQ-I005-7, OQ-I026-1); the listing below the label is not the code.
; 
; Real code (M = 1 on entry; bytes read at file offsets 65803-65890):
;   LDA #$80; TRB scroll_requests; BEQ next; LDX #0; JSR BuildColumnStrip   (BG1 column)
;   LDA #$40; TRB scroll_requests; BEQ next; LDX #0; JSR BuildRowStrip      (BG1 row)
;   LDX bg2_delta_x; STX scroll_delta_x; LDX bg2_delta_y; STX scroll_delta_y   (BG2 uses its own deltas)
;   LDA #$20; TRB scroll_requests; BEQ next; LDX #4; LDA map_width_pages,X; CMP #3; BCC next; JSR BuildColumnStrip   (BG2 column, only when the BG2 map is at least 3 pages wide)
;   LDA #$10; TRB scroll_requests; BEQ next; LDX #4; LDA map_height_pages,X; CMP #3; BCC next; JSR BuildRowStrip      (BG2 row, at least 3 pages high)
;   LDX #0; STX scroll_delta_x; STX scroll_delta_y; RTL
; 
; When: every game frame after ScrollCameraByDelta.
; Sees: the new column or row of the map appears at the screen edge in the same frame's NMI.
; Why: the strip is built in the work phase and uploaded by the NMI, which has no time to read the map.
; In: M = 1 (callers); scroll_requests, the deltas and bg2_delta_x/y set by ScrollCameraByDelta.
; Out: strip records filled for the requested layers; scroll_delta_x/y = 0. A BG2 map narrower than 3 pages is never streamed (it fits the tilemap and was drawn whole at entry).
; Clobbers: A, X, Y, dp $00-$0A, $16, $18, $29 (through the strip builders).

BuildScrollStrips {
    LDA #$80
    TRB $scroll_requests
    BEQ loc_010118
    LDX #$0000
    JSR $&BuildColumnStrip

  loc_010118:
    LDA #$40
    TRB $scroll_requests
    BEQ loc_010125
    LDX #$0000
    JSR $&BuildRowStrip

  loc_010125:
    LDX $bg2_delta_x
    STX $scroll_delta_x
    LDX $bg2_delta_y
    STX $scroll_delta_y
    LDA #$20
    TRB $scroll_requests
    BEQ loc_010145
    LDX #$0004
    LDA $map_width_pages, X
    CMP #$03
    BCC loc_010145
    JSR $&BuildColumnStrip

  loc_010145:
    LDA #$10
    TRB $scroll_requests
    BEQ loc_010159
    LDX #$0004
    LDA $map_height_pages, X
    CMP #$03
    BCC loc_010159
    JSR $&BuildRowStrip

  loc_010159:
    LDX #$0000
    STX $scroll_delta_x
    STX $scroll_delta_y
    RTL 
}

---------------------------------------------
; Builds the column strip of layer X for the sign of scroll_delta_x.
; 
; When: BuildScrollStrips for request bits $80 (X = 0) and $20 (X = 4).
; Sees: one new column of metatiles at the right (or left) screen edge.
; Why: gathers the layer's parameters into the DP block the buffer filler expects.
; In: X = 0 (BG1) or 4 (BG2); scroll_delta_x (zero = nothing to do).
; Out: M = 1. dp$16 = (scroll x + $100 for a positive delta, scroll x for a negative one) and $0FF0; $18 = scroll y and $0F00; $00 = tilemap VRAM base, $02 = map base, $04 = map_width_px (the row stride of pages), $06 = attribute word (tile_attr high byte x 256), $08 = end of the map data (map base + pages), $0A = tile mask, $29 = tile definition table. FillColumnStripBuffer then fills the layer's column record.
; Clobbers: A, X, Y, dp $00-$0A, $16, $18, $29.

BuildColumnStrip {
    REP #$20
    LDA #$0000
    LDY $scroll_delta_x
    BEQ loc_0101BF
    BMI loc_010172
    LDA #$0100

  loc_010172:
    CLC 
    ADC $scroll_bg1_x, X
    AND #$0FF0
    STA $16
    LDA $scroll_bg1_y, X
    AND #$0F00
    STA $18
    SEP #$20
    LDY $tilemap_vram_bg1, X
    STY $00
    LDY $map_base_bg1, X
    STY $02
    LDY $map_width_px, X
    STY $04
    LDA $tile_attr_bg1+1, X
    STZ $06
    STA $07
    LDA $map_width_pages, X
    XBA 
    LDA $map_height_pages, X
    JSL $@lib_arithmetic.Multiply8x8
    CLC 
    ADC $0353, X
    STZ $08
    STA $09
    LDY $tile_mask_bg1, X
    STY $0A
    LDY $tile_defs_bg1, X
    STY $29
    LDY $strip_col_bg1, X
    TYX 
    JSR $&FillColumnStripBuffer

  loc_0101BF:
    SEP #$20
    RTS 
}

---------------------------------------------
; Builds the row strip of layer X for the sign of scroll_delta_y.
; 
; When: BuildScrollStrips for request bits $40 (X = 0) and $10 (X = 4).
; Sees: one new row of metatiles at the bottom (or top) screen edge.
; Why: same parameter set as BuildColumnStrip, for the vertical direction.
; In: X = 0 or 4; scroll_delta_y (zero = nothing to do).
; Out: M = 1. dp$16 = scroll x and $0F00; $18 = (scroll y + $100 for a positive delta, scroll y for a negative one) and $0FF0; the rest as in BuildColumnStrip; FillRowStripBuffer fills the layer's row record.
; Clobbers: A, X, Y, dp $00-$0A, $16, $18, $29.

BuildRowStrip {
    REP #$20
    LDA $scroll_bg1_x, X
    AND #$0F00
    STA $16
    LDA #$0000
    LDY $scroll_delta_y
    BEQ loc_01020B
    BMI loc_0101D9
    LDA #$0100

  loc_0101D9:
    CLC 
    ADC $scroll_bg1_y, X
    AND #$0FF0
    STA $18
    SEP #$20
    LDY $tilemap_vram_bg1, X
    STY $00
    LDY $map_base_bg1, X
    STY $02
    LDY $map_width_px, X
    STY $04
    LDA $tile_attr_bg1+1, X
    STZ $06
    STA $07
    LDY $tile_mask_bg1, X
    STY $0A
    LDY $tile_defs_bg1, X
    STY $29
    LDY $strip_row_bg1, X
    TYX 
    JSR $&FillRowStripBuffer

  loc_01020B:
    SEP #$20
    RTS 
}
---------------------------------------------

; Places the camera on the player and draws both backgrounds completely.
; 
; When: once per scene change (lib_boot_and_scene_init), except in location $10 (the Mode 7 title scene).
; Sees: the room is already fully drawn when the screen fades in.
; Why: the strip streaming only adds edges, so a new scene needs a full draw first.
; In: player_x, player_y, map sizes, per-layer tables set by the scene loader.
; Out: scroll_bg1_x = player_x - $70 and scroll_bg1_y = player_y - $90 (limited to the map), BG2 scroll from UpdateLayerScrollX/Y with request bit 0 (the ratio, plus bg2_offset), reduced modulo the map size; then for X = 0 and X = 4, 32 passes of FillColumnStripBuffer + UploadScrollStrips advance dp$16 by 16 pixels each. $0392 and $0394 are written (map width and height divided by 16) and never read (OQ-I026-5).
; Clobbers: A, X, Y, dp $00-$0A, $0E, $16, $18, $29, $32-$37; DMA channel 2 and VMAIN are used directly (NMI is off).

RedrawBackgroundsAtEntry {
    REP #$20
    LDA $player_x
    SEC 
    SBC #$0070
    BPL loc_01021E
    LDA #$0000
    BRA loc_010234

  loc_01021E:
    CLC 
    ADC #$0100
    CMP $map_width_px
    BCS loc_01022D
    SEC 
    SBC #$0100
    BRA loc_010234

  loc_01022D:
    LDA $map_width_px
    SEC 
    SBC #$0100

  loc_010234:
    STA $scroll_bg1_x
    LDA $player_y
    SEC 
    SBC #$0090
    BPL loc_010245
    LDA #$0000
    BRA loc_01025B

  loc_010245:
    CLC 
    ADC $view_height_px
    CMP $map_height_px
    BCS loc_010254
    SEC 
    SBC $view_height_px
    BRA loc_01025B

  loc_010254:
    LDA $map_height_px
    SEC 
    SBC $view_height_px

  loc_01025B:
    STA $scroll_bg1_y
    LDA $map_width_px
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0392
    LDA $map_height_px
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0394
    LDX #$0000            ; Layer loop: X = 0 (BG1), then 4 (BG2)

  loc_010275:
    REP #$20
    LDA #$0000
    JSR $&UpdateLayerScrollX
    LDA $map_width_px, X
    BEQ loc_010290
    LDA $scroll_bg1_x, X

  loc_010285:
    SEC 
    SBC $map_width_px, X
    BCC loc_010290
    STA $scroll_bg1_x, X
    BRA loc_010285

  loc_010290:
    LDA #$0000
    JSR $&UpdateLayerScrollY
    LDA $map_height_px, X
    BEQ loc_0102A9
    LDA $scroll_bg1_y, X

  loc_01029E:
    SEC 
    SBC $map_height_px, X
    BCC loc_0102A9
    STA $scroll_bg1_y, X
    BRA loc_01029E

  loc_0102A9:
    SEP #$20
    REP #$20
    LDA $scroll_bg1_x, X
    AND #$FF00
    STA $16
    LDA $scroll_bg1_y, X
    AND #$FF00
    STA $18
    SEP #$20
    LDY $tilemap_vram_bg1, X
    STY $00
    LDY $map_base_bg1, X
    STY $02
    LDY $map_width_px, X
    STY $04
    LDA $tile_attr_bg1+1, X
    STZ $06
    STA $07
    LDA $map_width_pages, X
    XBA 
    LDA $map_height_pages, X
    JSL $@lib_arithmetic.Multiply8x8
    CLC 
    ADC $0353, X
    STZ $08
    STA $09
    LDY $tile_mask_bg1, X
    STY $0A
    LDY $tile_defs_bg1, X
    STY $29
    LDY $strip_col_bg1, X
    STY $32
    LDY $strip_row_bg1, X
    STY $35
    LDA #$20              ; 32 column strips of 16 pixels = the 512-pixel width of the 64 x 64 tilemap

  loc_0102FE:
    PHA 
    PHX 
    LDX $32
    JSR $&FillColumnStripBuffer
    JSL $@UploadScrollStrips
    PLX 
    REP #$20
    LDA $16
    CLC 
    ADC #$0010
    CMP $map_width_px, X
    BCC loc_01031A
    AND #$0100

  loc_01031A:
    STA $16
    SEP #$20
    PLA 
    DEC 
    BNE loc_0102FE
    INX 
    INX 
    INX 
    INX 
    CPX #$0008
    BEQ loc_01032E
    BRL loc_010275

  loc_01032E:
    RTL 
}
---------------------------------------------

; Fills one column record: the VRAM address and the four 64-byte blocks of tiles.
; 
; When: BuildColumnStrip and RedrawBackgroundsAtEntry.
; Sees: nothing by itself; the NMI uploads the result.
; Why: turns map metatiles into the exact tile order the DMA writes down the tilemap.
; In: X = buffer address (strip_col_bg1/2), dp $00-$0A, $16, $18, $29 as set by BuildColumnStrip; DBR is set to $7E inside.
; Out: word at X = VRAM address (tilemap base + $400 when bit 8 of x is set + ((x >> 3) and $1E)); then the first page and the second page of the column are expanded by CopyMetatileColumn into the blocks (the order depends on bit 8 of $18, the vertical half the strip starts in; the second page wraps to the start of the map data at its end).
; Clobbers: A, X, Y (P and B saved).

FillColumnStripBuffer {
    PHP 
    PHB 
    SEP #$20
    LDA $19
    XBA 
    LDA $05
    JSL $@lib_arithmetic.Multiply8x8
    CLC 
    ADC $17
    CLC 
    ADC $03
    XBA 
    LDA $16
    LSR 
    LSR 
    LSR 
    LSR 
    TAY 
    LDA #$7E
    PHA 
    PLB 
    LDA $17
    AND #$01
    ASL 
    ASL 
    XBA 
    LDA $16
    LSR 
    LSR 
    LSR 
    AND #$1E
    REP #$20
    CLC 
    ADC $00
    STA $0000, X
    INX 
    INX 
    LDA $18
    AND #$0100
    BNE loc_01038B
    JSR $&CopyMetatileColumn
    TYA 
    CLC 
    ADC $04
    CMP $08
    BCC loc_01037E
    SEC 
    SBC $08
    CLC 
    ADC $02

  loc_01037E:
    TAY 
    TXA 
    CLC 
    ADC #$0080
    TAX 
    JSR $&CopyMetatileColumn
    PLB 
    PLP 
    RTS 

  loc_01038B:
    PHX 
    TXA 
    CLC 
    ADC #$0080
    TAX 
    JSR $&CopyMetatileColumn
    TYA 
    CLC 
    ADC $04
    CMP $08
    BCC loc_0103A3
    SEC 
    SBC $08
    CLC 
    ADC $02

  loc_0103A3:
    TAY 
    PLX 
    JSR $&CopyMetatileColumn
    PLB 
    PLP 
    RTS 
}
---------------------------------------------

; Fills one row record: the VRAM address and the four 64-byte blocks of tiles.
; 
; When: BuildRowStrip.
; Sees: nothing by itself; the NMI uploads the result.
; Why: same as FillColumnStripBuffer for rows.
; In: X = buffer address (strip_row_bg1/2), dp $00-$0A, $16, $18, $29 as set by BuildRowStrip; DBR is set to $7E inside.
; Out: word at X = VRAM address (tilemap base + row ((y and $F0) x 4 + $800 when bit 8 of y is set)); the first page and the page to its right (+ $100 in the map) are expanded by CopyMetatileRow (the order depends on bit 8 of $16). No wrap at the end of the map for the second page.
; Clobbers: A, X, Y (P and B saved).

FillRowStripBuffer {
    PHP 
    PHB 
    SEP #$20
    LDA $19
    XBA 
    LDA $05
    JSL $@lib_arithmetic.Multiply8x8
    CLC 
    ADC $17
    CLC 
    ADC $03
    XBA 
    LDA $18
    AND #$F0
    TAY 
    LDA #$7E
    PHA 
    PLB 
    REP #$20
    LDA $18
    AND #$00F0
    ASL 
    ASL 
    PHA 
    LDA $18
    AND #$0100
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $01, S
    CLC 
    ADC $00
    STA $0000, X
    PLA 
    INX 
    INX 
    LDA $16
    AND #$0100
    BNE loc_010402
    JSR $&CopyMetatileRow
    TYA 
    CLC 
    ADC #$0100
    TAY 
    TXA 
    CLC 
    ADC #$0080
    TAX 
    JSR $&CopyMetatileRow
    PLB 
    PLP 
    RTS 

  loc_010402:
    PHX 
    TXA 
    CLC 
    ADC #$0080
    TAX 
    JSR $&CopyMetatileRow
    TYA 
    CLC 
    ADC #$0100
    TAY 
    PLX 
    JSR $&CopyMetatileRow
    PLB 
    PLP 
    RTS 
}
---------------------------------------------

; Expands 16 metatiles of a page column into tile words for a column record.
; 
; When: FillColumnStripBuffer, up to 4 times per strip.
; Sees: nothing by itself.
; Why: a column strip stores the left tile column of the 16 metatiles first (32 words), then the right tile column.
; In: Y = map offset of the first metatile (the next one is + $10), X = buffer position; dp $06 attribute, $0A mask, $29 definition table; DBR = $7E.
; Out: per metatile 4 words (definition AND mask OR attribute): top-left to X, bottom-left to X + 2, top-right to X + $40, bottom-right to X + $42; X advances 4 per metatile. X and Y are restored on exit.
; Clobbers: A, dp $0E.

CopyMetatileColumn {
    PHX 
    PHY 
    LDA #$0010
    STA $0E

  loc_010420:
    LDA $0000, Y
    AND #$00FF
    PHY 
    ASL 
    ASL 
    ASL 
    TAY 
    LDA ($29), Y          ; Metatile definition word ($29 = the layer's table, 8 bytes per metatile: TL, TR, BL, BR); the mask drops bit 9 (solid flag), $06 adds the attribute
    INY 
    INY 
    AND $0A
    ORA $06
    STA $0000, X
    LDA ($29), Y
    INY 
    INY 
    AND $0A
    ORA $06
    STA $0040, X
    LDA ($29), Y
    INY 
    INY 
    AND $0A
    ORA $06
    STA $0002, X
    LDA ($29), Y
    AND $0A
    ORA $06
    STA $0042, X
    INX 
    INX 
    INX 
    INX 
    PLA 
    CLC 
    ADC #$0010
    TAY 
    DEC $0E
    BNE loc_010420
    PLY 
    PLX 
    RTS 
}
---------------------------------------------

; Expands 16 metatiles of a page row into tile words for a row record.
; 
; When: FillRowStripBuffer, up to 4 times per strip.
; Sees: nothing by itself.
; Why: a row strip stores the top tile row of the 16 metatiles first (32 words), then the bottom tile row.
; In: Y = map offset of the first metatile (the next one is + 1), X = buffer position; dp $06, $0A, $29; DBR = $7E.
; Out: per metatile 4 words: top-left to X, top-right to X + 2, bottom-left to X + $40, bottom-right to X + $42; X advances 4 per metatile. X and Y are restored on exit.
; Clobbers: A, dp $0E.

CopyMetatileRow {
    PHX 
    PHY 
    LDA #$0010
    STA $0E

  loc_01046D:
    LDA $0000, Y
    AND #$00FF
    INY 
    PHY 
    ASL 
    ASL 
    ASL 
    TAY 
    LDA ($29), Y
    INY 
    INY 
    AND $0A
    ORA $06
    STA $0000, X
    LDA ($29), Y
    INY 
    INY 
    AND $0A
    ORA $06
    STA $0002, X
    LDA ($29), Y
    INY 
    INY 
    AND $0A
    ORA $06
    STA $0040, X
    LDA ($29), Y
    AND $0A
    ORA $06
    STA $0042, X
    INX 
    INX 
    INX 
    INX 
    PLY 
    DEC $0E
    BNE loc_01046D
    PLY 
    PLX 
    RTS 
}
---------------------------------------------

; Multiplies a scroll position by a ratio word: A x numerator / divisor.
; 
; When: UpdateLayerScrollX and UpdateLayerScrollY (BG2 parallax).
; Sees: the background behind the map moves slower than the map in front (the ratio $0201 is half speed).
; Why: uses the PPU multiplier ($211B/$211C) for A x numerator and the hardware divider for the division.
; In: A = position (16 bits), Y = ratio word (low byte numerator, high byte divisor).
; Out: A = quotient (16 bits).
; Clobbers: A (P and Y saved); the divider result registers.

ScaleByRatio {
    PHP 
    PHY 
    SEP #$20
    STA $M7A
    XBA 
    STA $M7A
    REP #$20
    TYA 
    SEP #$20
    STA $M7B
    STA $M7B
    LDY $MPYL             ; Position x numerator from the PPU multiplier; the divisor is the high byte of the ratio
    STY $WRDIVL
    XBA 
    STA $WRDIVB
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    NOP 
    LDA $RDDIVH
    XBA 
    LDA $RDDIVL
    PLY 
    PLP 
    RTS 
}

---------------------------------------------
; Sets the x scroll of layer X from BG1's scroll through the layer's ratio and requests a column strip when a 16-pixel line was crossed.
; 
; When: ScrollCameraByDelta (BG2, X = 4) and RedrawBackgroundsAtEntry.
; Sees: the BG2 layer drifts with the map.
; Why: BG2's position is a function of BG1's, so only BG1 is scrolled directly.
; In: A = the request bit to set (16 bits), X = 0 or 4. Reads scroll_bg1_x, ratio_x_bg1/2, map_width_px,X and bg2_offset_x.
; Out: scroll_bg1_x,X = scaled position, clamped to map_width_px - $100 when the layer's map is at least $300 pixels wide, plus bg2_offset_x; scroll_requests |= A when bit 4 of the position changed; bg2_delta_x = new - old position.
; Clobbers: none (A, Y and P saved).

UpdateLayerScrollX {
    PHP 
    PHY 
    REP #$20
    PHA 
    LDA $scroll_bg1_x, X
    PHA 
    LDY $ratio_x_bg1, X
    LDA $scroll_bg1_x
    JSR $&ScaleByRatio
    TAY 
    CLC 
    ADC #$0100
    CMP $map_width_px, X
    BCC loc_01050A
    LDA $map_width_px, X
    CMP #$0300            ; Clamp only when the layer's map is at least 3 pages wide
    BCC loc_01050A
    SEC 
    SBC #$0100
    TAY 

  loc_01050A:
    TYA 
    CLC 
    ADC $bg2_offset_x
    STA $scroll_bg1_x, X
    LDA $01, S
    EOR $scroll_bg1_x, X
    AND #$0010
    BEQ loc_010521
    LDA $03, S
    TSB $scroll_requests  ; Request bit passed in A by the caller ($20 column, $10 row for BG2)

  loc_010521:
    LDA $scroll_bg1_x, X
    SEC 
    SBC $01, S
    STA $bg2_delta_x      ; How far the layer moved this frame (BuildScrollStrips uses it as the BG2 delta)
    PLA 
    PLA 
    PLY 
    PLP 
    RTS 
}

---------------------------------------------
; Sets the y scroll of layer X from BG1's scroll through the layer's ratio and requests a row strip when a 16-pixel line was crossed.
; 
; When: ScrollCameraByDelta (BG2, X = 4) and RedrawBackgroundsAtEntry.
; Sees: the BG2 layer drifts with the map.
; Why: same as UpdateLayerScrollX for y.
; In: A = the request bit to set (16 bits), X = 0 or 4. Reads scroll_bg1_y, ratio_y_bg1/2, map_height_px,X, view_height_px and bg2_offset_y.
; Out: scroll_bg1_y,X = scaled position, clamped to map_height_px - view_height_px for maps at least $300 pixels high, plus bg2_offset_y; scroll_requests |= A when bit 4 changed; bg2_delta_y = new - old.
; Clobbers: none (A, Y and P saved).

UpdateLayerScrollY {
    PHP 
    PHY 
    REP #$20
    PHA 
    LDA $scroll_bg1_y, X
    PHA 
    LDY $ratio_y_bg1, X
    LDA $scroll_bg1_y
    JSR $&ScaleByRatio
    TAY 
    CLC 
    ADC $view_height_px
    CMP $map_height_px, X
    BCC loc_010558
    LDA $map_height_px, X
    CMP #$0300
    BCC loc_010558
    SEC 
    SBC $view_height_px
    TAY 

  loc_010558:
    TYA 
    CLC 
    ADC $bg2_offset_y
    STA $scroll_bg1_y, X
    LDA $01, S
    EOR $scroll_bg1_y, X
    AND #$0010
    BEQ loc_01056F
    LDA $03, S
    TSB $scroll_requests

  loc_01056F:
    LDA $scroll_bg1_y, X
    SEC 
    SBC $01, S
    STA $bg2_delta_y
    PLA 
    PLA 
    PLY 
    PLP 
    RTS 
}
---------------------------------------------

; Sends a column record and a row record to VRAM by DMA channel 2 and empties them.
; 
; When: the NMI (UploadMapStripBuffers, once for the BG1 pair and once for the BG2 pair) and RedrawBackgroundsAtEntry.
; Sees: the new map edge appears.
; Why: the map must reach VRAM during vblank; an empty record (address word 0) costs nothing.
; In: dp $32 = column record pointer (bank in $34), dp $35 = row record pointer (bank in $37).
; Out: for each non-empty record: VMAIN = $81 (column) or $80 (row), four DmaStripChunk transfers to the record's address, + 1 / + $20, + $800 / + $400 and + $801 / + $420, then the record's address word is zeroed.
; Clobbers: A, X (X is made 8-bit by the routine; P restored).

UploadScrollStrips {
    PHP 
    REP #$20
    SEP #$10
    LDX #$81
    STX $VMAIN            ; VMAIN $81: step 32 words after the high byte = write down a column
    LDA [$32]
    BEQ loc_0105E0
    LDA [$32]
    STA $VMADDL
    LDA $32
    CLC 
    ADC #$0002
    STA $A1T2L
    JSR $&DmaStripChunk
    LDA [$32]
    CLC 
    ADC #$0001
    STA $VMADDL
    LDA $32
    CLC 
    ADC #$0042
    STA $A1T2L
    JSR $&DmaStripChunk
    LDA [$32]
    CLC 
    ADC #$0800            ; + $800: the lower screen of the 64 x 64 tilemap
    STA $VMADDL
    LDA $32
    CLC 
    ADC #$0082
    STA $A1T2L
    JSR $&DmaStripChunk
    LDA [$32]
    CLC 
    ADC #$0801
    STA $VMADDL
    LDA $32
    CLC 
    ADC #$00C2
    STA $A1T2L
    JSR $&DmaStripChunk
    LDA #$0000
    STA [$32]             ; A zero address word marks the record as empty

  loc_0105E0:
    LDX #$80
    STX $VMAIN            ; VMAIN $80: step 1 word = write along a row
    LDA [$35]
    BEQ loc_01063E
    LDA [$35]
    STA $VMADDL
    LDA $35
    CLC 
    ADC #$0002
    STA $A1T2L
    JSR $&DmaStripChunk
    LDA [$35]
    CLC 
    ADC #$0020
    STA $VMADDL
    LDA $35
    CLC 
    ADC #$0042
    STA $A1T2L
    JSR $&DmaStripChunk
    LDA [$35]
    CLC 
    ADC #$0400
    STA $VMADDL
    LDA $35
    CLC 
    ADC #$0082
    STA $A1T2L
    JSR $&DmaStripChunk
    LDA [$35]
    CLC 
    ADC #$0420
    STA $VMADDL
    LDA $35
    CLC 
    ADC #$00C2
    STA $A1T2L
    JSR $&DmaStripChunk
    LDA #$0000
    STA [$35]

  loc_01063E:
    PLP 
    RTL 
}

---------------------------------------------
; Starts one 64-byte DMA of a strip block to VRAM.
; 
; When: UploadScrollStrips, 4 times per record.
; Sees: nothing by itself.
; Why: the common part of the four block transfers.
; In: VMADDL and A1T2L set by the caller; X flag = 8-bit.
; Out: DMA channel 2: mode 1 (two registers), B-bus $2118, source bank $7E, 64 bytes, started with MDMAEN = 4.
; Clobbers: X (8 bits).

DmaStripChunk {
    LDX #$01
    STX $DMAP2
    LDX #$18
    STX $BBAD2
    LDX #$7E
    STX $A1B2
    LDA #$0040
    STA $DAS2L
    LDX #$04
    STX $MDMAEN
    RTS 
}
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