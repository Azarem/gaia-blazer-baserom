; NMI handler and the DMA routines it calls (file offsets 834-1444, SNES $00:8342-$85A4, bank 00).
; 
; === ORDER OF WORK IN HandleVBlank ===
; Saves P, B, A, X and Y; works with M = 1, X = 16-bit, DBR = $01. HDMAEN = 0; then DmaOamBuffer, DmaCgramAndFixedColor, DmaBg3TilemapPage, WriteScrollRegisters, UploadMapStripBuffers, DmaDynamicSpriteTiles, DmaAnimatedTileStrip, FlushVramWriteQueue and the title and file-select hook engine_title_file_select.UpdateTitleMode7; then wait for the auto-joypad read (HVBJOY bit 0); HDMAEN = dp$42 (the shadow the work phase set); frame_counter++; joypad; sound request. DMA channels: 0 = OAM, 1 = CGRAM, 2 = every VRAM transfer.
; HandleIrq (the IRQ vector) is a bare RTI; the I flag is never cleared (no CLI in extracted/), so the IRQ stays masked.
; 
; === JOYPAD ===
; JOY1L is read as one word. The X button (word bit 6) is copied to the Select position (bit 13), so X and Select act as one button. joy_pressed = raw buttons with the bits of joy_block_mask removed (scripts block buttons with TSB and TRB on joy_block_mask), ANDed with joy_release_latch: a button counts only while its latch bit is set. The latch gets a bit whenever that button is seen up; the users (player code, menus, level up) clear the bit with TRB after using a press, so a held button acts once. Scene init sets the latch to $FFFF. joy_override ($0468) non-zero skips all of this and keeps the scripted value in joy_pressed (used by the Lisa and Turbo scene).
; 
; === SOUND ===
; sound_request ($0398, word) is filled by the BRK handler (HandleBrk): BRK #n requests sound n. On even frames the word goes to APUIO2 and is cleared; on odd frames 0 is sent.
; 
; === STAGING DATA THE NMI UPLOADS ===
; - oam_buffer $0486: 512 bytes low table + 32 bytes high table (544 bytes, channel 0 to OAMDATA).
; - palette $7F0000 (512 bytes, channel 1 to CGDATA); COLDATA from coldata_buffer $7F0200-$7F0202.
; - BG3 tilemap pages: $7F7000 to VRAM $5800, or (bit 1 of vram_upload_flags) $7F7800 to $5C00, 2048 bytes each.
; - Scroll words: BG1 from scroll_bg1_x/y ($033A, $033C), BG2 from scroll_bg2_x/y ($033E, $0340), each value 10 bits (low byte, then high byte and 3); bg_scroll_swap ($03DB) non-zero swaps the pairs. BG3 uses the low bytes of scroll_bg3_x/y.
; - Map strip records at $3000, $3102 and $3204, $3306 ($102 bytes each; column record, then row record).
; - tile_dma_list $1A06: 3-byte records (source address word, bank), 0 ends; tile_dma_pending is the trigger.
; - vram_strip_src, vram_strip_dest, vram_strip_pending ($03DD, $03DF, $03E1): one animated background strip.
; - vram_write_queue $1C7B: pairs of words (VRAM address, data), address 0 ends.
---------------------------------------------

?BANK 00

?INCLUDE 'engine_title_file_select'
?INCLUDE 'lib_map_scroll_and_redraw'

!frame_counter                  0312
!joy_pressed                    0322
!joy_block_mask                 0326
!joy_release_latch              032A
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!scroll_bg3_x                   0386
!scroll_bg3_y                   0388
!sound_request                  0398
!tile_dma_pending               03B6
!vram_upload_flags              03B8
!bg_scroll_swap                 03DB
!vram_strip_src                 03DD
!vram_strip_dest                03DF
!vram_strip_pending             03E1
!joy_override                   0468
!tile_dma_list                  1A06
!vram_write_queue               1C7B
!OAMADDL                        2102
!BG1HOFS                        210D
!BG1VOFS                        210E
!BG3HOFS                        2111
!BG3VOFS                        2112
!VMADDL                         2116
!VMADDH                         2117
!VMDATAL                        2118
!CGADD                          2121
!COLDATA                        2132
!APUIO2                         2142
!MDMAEN                         420B
!HDMAEN                         420C
!HVBJOY                         4212
!JOY1L                          4218
!DMAP0                          4300
!BBAD0                          4301
!A1T0L                          4302
!A1B0                           4304
!DAS0L                          4305
!DMAP1                          4310
!BBAD1                          4311
!A1T1L                          4312
!A1B1                           4314
!DAS1L                          4315
!DMAP2                          4320
!BBAD2                          4321
!A1T2L                          4322
!A1B2                           4324
!DAS2L                          4325
!coldata_buffer                 7F0200

---------------------------------------------

; NMI handler: uploads everything the work phase prepared, then reads the pad and sends the sound request.
; 
; When: every vblank while NMI is enabled (the main loop waits for it in WaitVBlank).
; Sees: all graphics changes of a frame (sprites, palette, tilemap, scroll, animated tiles) appear here, and input and sound are sampled here.
; Why: VRAM, CGRAM and OAM may only be written in vblank, and the work phase runs with NMI off, so the NMI is the single place that transfers the results.
; In: hardware; saves P, B, A, X, Y; body runs with M = 1, X = 16-bit, DBR = $01.
; Out: RTI.
; Clobbers: none visible; writes dp $32-$37 through UploadMapStripBuffers.

HandleVBlank {
    PHP 
    PHB 
    REP #$30
    PHA 
    PHX 
    PHY 
    SEP #$20
    REP #$10
    CLD 
    LDA #$01
    PHA 
    PLB 
    STZ $HDMAEN           ; HDMA off while the DMA transfers below run
    JSR $&DmaOamBuffer
    JSR $&DmaCgramAndFixedColor
    JSR $&DmaBg3TilemapPage
    JSR $&WriteScrollRegisters
    JSR $&UploadMapStripBuffers
    JSR $&DmaDynamicSpriteTiles
    JSR $&DmaAnimatedTileStrip
    JSR $&FlushVramWriteQueue
    JSL $@engine_title_file_select.UpdateTitleMode7 ; Title Mode 7 hook: acts only when location_id = $10 (writes the Mode 7 matrix and centre to the PPU)

; Waits until the auto-joypad read has finished (HVBJOY bit 0 clear) before JOY1L is read; HDMAEN is restored from dp$42 right after this wait.

  WaitAutoJoypad:
    LDA $HVBJOY           ; Wait for the auto-joypad read to finish (HVBJOY bit 0)
    ROR 
    BCS WaitAutoJoypad
    LDA $42               ; HDMA enable mask for the coming frame comes from the shadow in dp$42
    STA $HDMAEN
    REP #$30
    INC $frame_counter
    LDA $joy_override     ; joy_override non-zero: scripted input replaces the pad
    BNE StoreJoyPressed
    LDA $JOY1L
    XBA                   ; X (JOY1L bit 6) is moved to the Select position ($2000) below: X and Select act as one button
    LSR 
    AND #$2000
    ORA $JOY1L
    PHA 
    LDA $joy_block_mask   ; Buttons blocked by scripts (joy_block_mask) are removed from the raw state
    EOR #$FFFF
    AND $01, S
    STA $joy_pressed
    PLA 
    EOR #$FFFF            ; Latch bits are set for buttons seen up; consumers clear them (TRB) after a press, so a held button acts once
    ORA $joy_release_latch
    STA $joy_release_latch
    AND $joy_pressed

; Join point of the joypad code: stores A in joy_pressed. Reached by the normal path with the latched value and by the branch for joy_override with the scripted value.

  StoreJoyPressed:
    STA $joy_pressed
    LDA $frame_counter    ; Even frames send sound_request to APUIO2 and clear it; odd frames send 0
    LSR 
    LDA #$0000
    BCS WriteSoundPort
    LDA $sound_request
    STZ $sound_request

; Writes A (a sound request word on even frames, 0 on odd frames) to APUIO2, then restores the registers and returns with RTI.

  WriteSoundPort:
    STA $APUIO2
    PLY 
    PLX 
    PLA 
    PLB 
    PLP 
    RTI 
}

---------------------------------------------
; Copies the 544-byte OAM buffer to OAM.
; 
; When: every NMI. Sees: the sprites built by BuildOamFromActors. Why: OAM can only be written in vblank.
; In: none.
; Out: channel 0: 544 bytes ($0220) from oam_buffer ($0486) to OAMDATA, OAMADD = 0.
; Clobbers: A, X.

DmaOamBuffer {
    LDX #$0000
    STX $OAMADDL
    STZ $DMAP0
    LDA #$04
    STA $BBAD0
    LDX #$0486
    STX $A1T0L
    LDA #$00
    STA $A1B0
    LDX #$0220
    STX $DAS0L
    LDA #$01
    STA $MDMAEN
    RTS 
}

---------------------------------------------
; Copies the 512-byte palette buffer to CGRAM and writes the three fixed-colour components.
; 
; When: every NMI. Sees: palette changes and the fixed colour (screen tint). Why: the work phase edits the buffers, the NMI transfers them.
; In: none.
; Out: channel 1: 512 bytes from $7F0000 to CGDATA with CGADD = 0; then $7F0200, $7F0201 and $7F0202 to COLDATA.
; Clobbers: A, X.

DmaCgramAndFixedColor {
    STZ $CGADD
    STZ $DMAP1
    LDA #$22
    STA $BBAD1
    LDX #$0000
    STX $A1T1L
    LDA #$7F
    STA $A1B1
    LDX #$0200
    STX $DAS1L
    LDA #$02
    STA $MDMAEN
    LDA $coldata_buffer
    STA $COLDATA
    LDA $7F0201
    STA $COLDATA
    LDA $7F0202
    STA $COLDATA
    RTS 
}

---------------------------------------------
; Uploads one 2048-byte BG3 tilemap page (text and HUD layer) when vram_upload_flags asks for it.
; 
; When: every NMI; skipped when the high byte of the first write-queue word ($1C7C) is non-zero or vram_upload_flags is 0 (OQ-I005-19).
; Sees: dialogue boxes and the HUD appear. Why: the text renderer draws into a staging page and flags it.
; In: vram_upload_flags (bit 1 selects the second page).
; Out: bit 1 clear: $7F7000 to VRAM $5800 and all flags cleared; bit 1 set: $7F7800 to $5C00 and only bit 1 cleared. Channel 2, 2048 bytes.
; Clobbers: A, X.

DmaBg3TilemapPage {
    LDA $1C7C
    BEQ Bg3PageCheckFlags
    RTS 

  Bg3PageCheckFlags:
    LDA $vram_upload_flags
    BNE Bg3PageSelect
    RTS 

  Bg3PageSelect:
    BIT #$02
    BNE Bg3PageSecond
    LDX #$5800
    STX $VMADDL
    LDX #$7000
    STX $A1T2L
    STZ $vram_upload_flags
    BRA Bg3PageStartDma

  Bg3PageSecond:
    LDX #$5C00
    STX $VMADDL
    LDX #$7800
    STX $A1T2L
    LDA #$02
    TRB $vram_upload_flags

  Bg3PageStartDma:
    LDA #$01
    STA $DMAP2
    LDA #$18
    STA $BBAD2
    LDA #$7F
    STA $A1B2
    LDX #$0800
    STX $DAS2L
    LDA #$04
    STA $MDMAEN
    RTS 
}

---------------------------------------------
; Writes the BG1, BG2 and BG3 scroll registers.
; 
; When: every NMI. Sees: the camera. Why: scroll registers are written during vblank so a frame never mixes two positions.
; In: scroll_bg3_x/y, the BG1 and BG2 scroll words, bg_scroll_swap ($03DB).
; Out: BG3 gets the low byte of its scroll words (high byte 0); BG1 and BG2 are written through WriteScrollPair, with the two pairs swapped while bg_scroll_swap is non-zero.
; Clobbers: A, X, Y.

WriteScrollRegisters {
    LDA $scroll_bg3_x
    STA $BG3HOFS
    STZ $BG3HOFS
    LDA $scroll_bg3_y
    STA $BG3VOFS
    STZ $BG3VOFS
    LDA $bg_scroll_swap   ; bg_scroll_swap non-zero: BG1 takes the BG2 scroll pair and BG2 the BG1 pair
    BNE WriteScrollSwapped
    LDX #$0000
    LDY #$0000
    JSR $&WriteScrollPair
    LDX #$0004
    LDY #$0002
    JSR $&WriteScrollPair
    RTS 

  WriteScrollSwapped:
    LDX #$0004
    LDY #$0000
    JSR $&WriteScrollPair
    LDX #$0000
    LDY #$0002
    JSR $&WriteScrollPair
    RTS 
}

---------------------------------------------
; Writes one BG scroll pair (horizontal and vertical) with the 10-bit masking.
; 
; When: twice per NMI from WriteScrollRegisters. Why: every scroll register takes two writes (low byte, then high byte masked with 3).
; In: X = offset into the scroll block (0 for BG1, 4 for BG2), Y = register pair (0 BG1, 2 BG2).
; Out: BG1HOFS+Y and BG1VOFS+Y written twice each.
; Clobbers: A.

WriteScrollPair {
    LDA $scroll_bg1_x, X
    STA $BG1HOFS, Y
    LDA $033B, X
    AND #$03
    STA $BG1HOFS, Y
    LDA $scroll_bg1_y, X
    STA $BG1VOFS, Y
    LDA $033D, X
    AND #$03
    STA $BG1VOFS, Y
    RTS 
}

---------------------------------------------
; Uploads the two pairs of map strip records (new map columns and rows revealed by scrolling) to VRAM.
; 
; When: every NMI. Sees: the map drawing in as the camera moves. Why: the map is bigger than VRAM, so the edge strips are streamed in.
; In: none. Sets dp$32 and dp$35 to the record pointers ($3000 and $3102, then $3204 and $3306); the bank bytes dp$34 and dp$37 are not set here.
; Out: two calls of UploadScrollStrips; each uploads the column record (VMAIN $81) and the row record (VMAIN $80), four 64-byte blocks each, then zeroes the record's first word.
; Clobbers: A, X, dp $32-$36.

UploadMapStripBuffers {
    LDX #$3000
    STX $32
    LDX #$3102
    STX $35
    JSL $@lib_map_scroll_and_redraw.UploadScrollStrips
    LDX #$3204
    STX $32
    LDX #$3306
    STX $35
    JSL $@lib_map_scroll_and_redraw.UploadScrollStrips
    RTS 
}

---------------------------------------------
; Copies the tiles of dynamic-tile sprites into VRAM in two passes (top and bottom tile rows).
; 
; When: every NMI with tile_dma_pending non-zero (set by BuildActorSprites). Sees: actors flagged $1A bit $8000 (only the hero: CopA9_SetDynamicTileSource in InitPlayerActor is the one place that sets the bit, OQ-I050-1) show their frames from streamed tiles. Why: those frames are copied into VRAM every frame.
; In: tile_dma_list at $1A06: 3-byte records (source word, bank byte), 0 ends.
; Out: pass 1 to VRAM $2000 upward (0x40 bytes per record); pass 2 adds $0200 to each record's source and uploads to $2100 upward; tile_dma_pending cleared. There is no count limit in the code (OQ-I005-6); the hero's frames have three entries each, so three records per frame and OAM tiles 0-5 and 16-21.
; Clobbers: A, X, Y.

DmaDynamicSpriteTiles {
    LDA $tile_dma_pending
    BNE DynamicTilesPass1
    RTS 

  DynamicTilesPass1:
    LDA #$18
    STA $BBAD2
    LDA #$01
    STA $DMAP2
    LDY #$0000
    LDX #$2000
    STX $VMADDL
    JSR $&DmaSpriteTileRecords
    LDX #$0000

  DynamicTilesBumpSource:
    LDY $tile_dma_list, X
    BEQ DynamicTilesPass2
    INC $1A07, X          ; Second pass: the source address high byte is incremented twice (+$0200), the bottom tile row of the 16x16 sprites
    INC $1A07, X
    INX 
    INX 
    INX 
    BRA DynamicTilesBumpSource

  DynamicTilesPass2:
    LDY #$0000
    LDX #$2100
    STX $VMADDL
    JSR $&DmaSpriteTileRecords
    STZ $tile_dma_pending
    RTS 
}

---------------------------------------------
; Uploads one 0x40-byte DMA per record of tile_dma_list until the terminator.
; 
; When: twice per NMI from DmaDynamicSpriteTiles. Why: shared loop of the two passes.
; In: Y = list offset; DMAP2 and BBAD2 set by the caller; VMADDL set.
; Out: Y at the terminator.
; Clobbers: A, X, Y.

DmaSpriteTileRecords {
    LDX $tile_dma_list, Y
    BEQ SpriteTileRecordsDone
    STX $A1T2L
    LDA $1A08, Y
    STA $A1B2
    LDX #$0040
    STX $DAS2L
    LDA #$04
    STA $MDMAEN
    INY 
    INY 
    INY 
    BRA DmaSpriteTileRecords

  SpriteTileRecordsDone:
    RTS 
}

---------------------------------------------
; Uploads one animated background tile strip (two 0x40-byte blocks) to VRAM.
; 
; When: every NMI with vram_strip_pending non-zero (QueueAnimatedTileStrip sets it once per frame outside locations $0F-$12).
; Sees: background tile animation (four VRAM slots cycling, 32 source frames).
; Why: animates BG tiles without the work phase touching VRAM.
; In: vram_strip_src (bank $7F), vram_strip_dest.
; Out: 0x40 bytes to vram_strip_dest, the next 0x40 bytes to the address 256 words higher (high byte + 1); vram_strip_pending cleared.
; Clobbers: A, X.

DmaAnimatedTileStrip {
    LDA $vram_strip_pending
    BNE AnimatedStripStart
    RTS 

  AnimatedStripStart:
    LDA #$01
    STA $DMAP2
    LDA #$18
    STA $BBAD2
    LDX $vram_strip_src
    STX $A1T2L
    LDA #$7F
    STA $A1B2
    LDX #$0040
    STX $DAS2L
    LDX $vram_strip_dest
    STX $VMADDL
    LDA #$04
    STA $MDMAEN
    LDX #$0040
    STX $DAS2L
    LDA $vram_strip_dest
    STA $VMADDL
    LDA $03E0             ; The second half goes to the address 256 words higher (VMADDH + 1)
    INC 
    STA $VMADDH
    LDA #$04
    STA $MDMAEN
    STZ $vram_strip_pending
    RTS 
}

---------------------------------------------
; Writes the queued (VRAM address, data) word pairs to VRAM and empties the queue.
; 
; When: every NMI, last of the transfers. Sees: single tilemap or tile edits (HUD digits, small text). Why: lets the work phase request a few VRAM writes without DMA setup.
; In: vram_write_queue at $1C7B: pairs of words, address 0 ends.
; Out: each pair written with VMADDL and VMDATAL; the first queue word is zeroed. S is moved to $1C7A for the PLA reads and restored by TXS; M restored.
; Clobbers: A (16-bit), X.

FlushVramWriteQueue {
    REP #$20
    TSX 
    LDA #$1C7A            ; S points just below the queue at $1C7B so PLA pulls (VRAM address, data) pairs; a zero address ends it
    TCS 

  FlushQueueLoop:
    PLA 
    BEQ FlushQueueDone
    STA $VMADDL
    PLA 
    STA $VMDATAL
    BRA FlushQueueLoop

  FlushQueueDone:
    TXS 
    STZ $vram_write_queue
    SEP #$20
    RTS 
}