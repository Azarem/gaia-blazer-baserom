; Metatile writers: put one metatile into the map and, when it is on screen, queue it for VRAM (file offsets 67313-67770, SNES $02:86F1-$88BA, bank 02).
; 
; === MODEL ===
; Both routines (1) turn the pixel position in dp$16 / $18 into a map offset (lib_map_index_helpers.PixelToMapIndex), (2) store the metatile id in the BG1 map ($7E8000) and, for SetMetatileBg1Bg2, also in the BG2 map ($7EC000), (3) rewrite the tile_type_map byte ($7F8000) from the definition (the solid flag, bit 9, of the four tile words gives bits 0 to 3: top-left, top-right, bottom-left, bottom-right) and (4) when the metatile lies in the view plus 16 pixels, write four (VRAM address, tile word) entries per layer to vram_write_queue ($1C7B, 4 bytes per entry, 16 per metatile) and a zero terminator; the NMI (FlushVramWriteQueue) draws them.
; The queue is overwritten from its start: callers either wait for it to be empty first (SealLair) or call right after the NMI has emptied it (the tile triggers).
; Callers: SealLair (green switch $FE), CheckPlayerTileTriggers / TryOpenChest (open chest $FC) and ReleaseLairAtSwitch's own map write (it writes the map bytes directly).
---------------------------------------------

?BANK 02

?INCLUDE 'lib_map_index_helpers'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!tile_mask_bg1                  035C
!tile_mask_bg2                  0360
!tile_attr_bg1                  036A
!tile_attr_bg2                  036E
!vram_write_queue               1C7B
!tile_type_map                  7F8000

---------------------------------------------

; Writes one metatile into the BG1 map and queues its four tiles for VRAM.
; 
; When: SealLair (lair with record byte +8 = 0) and TryOpenChest (chest with bit 7 of its id clear).
; Sees: a tile of the room changes: the green switch appears under a cleared lair, a chest opens.
; Why: one routine keeps the map, the collision byte and the screen in step.
; In: A (8 bits) = metatile id; dp$16 / $18 = pixel position of the metatile (multiples of 16); M = 1.
; Out: $7E8000 + offset = id; tile_type_map[offset] = the four solid flags of the definition (the whole byte is replaced, so the block bits $F0 are cleared); if on screen vram_write_queue holds 4 entries and a terminator.
; Clobbers: A (X, P restored).

SetMetatileBg1 {
    PHP 
    PHX 
    PHA 
    REP #$20
    JSL $@lib_map_index_helpers.PixelToMapIndex
    SEP #$20
    PLA 
    STA $7E8000, X
    PHX 
    REP #$20
    AND #$00FF
    ASL 
    ASL 
    ASL 
    TAX 
    LDA $7E2000, X
    AND $tile_mask_bg1
    ORA $tile_attr_bg1
    STA $1C7D
    LDA $7E2002, X
    AND $tile_mask_bg1
    ORA $tile_attr_bg1
    STA $1C81
    LDA $7E2004, X
    AND $tile_mask_bg1
    ORA $tile_attr_bg1
    STA $1C85
    LDA $7E2006, X
    AND $tile_mask_bg1
    ORA $tile_attr_bg1
    STA $1C89
    SEP #$20
    LDA $7E2001, X
    AND #$02
    PHA 
    LDA $7E2003, X
    AND #$02
    PHA 
    LDA $7E2005, X
    AND #$02
    PHA 
    LDA $7E2007, X
    AND #$02
    ASL 
    ORA $01, S
    ASL 
    ORA $02, S
    ASL 
    ORA $03, S
    LSR 
    XBA 
    PLA 
    PLA 
    PLA 
    XBA 
    PLX 
    STA $tile_type_map, X ; Collision type: bit 9 of the four tile words (TL, TR, BL, BR) becomes bits 0-3; the byte is replaced
    REP #$20
    LDA $16
    CLC 
    ADC #$0010
    SEC 
    SBC $scroll_bg1_x
    CMP #$0111            ; On-screen test (unsigned): inside the 256-pixel view plus a 16-pixel margin, else nothing is queued
    BCS loc_0107A9
    LDA $18
    CLC 
    ADC #$0010
    SEC 
    SBC $scroll_bg1_y
    CMP #$0111
    BCS loc_0107A9
    JSL $@lib_map_index_helpers.PixelToBg1VramAddr
    STA $vram_write_queue ; Queue entries (VRAM address, tile word): top-left, top-right, bottom-left (+ $20), bottom-right
    INC 
    STA $1C7F
    CLC 
    ADC #$001F
    STA $1C83
    INC 
    STA $1C87
    STZ $1C8B             ; Terminator of the VRAM write queue

  loc_0107A9:
    PLX 
    PLP 
    RTL 
}

---------------------------------------------
; Same as SetMetatileBg1 for a tile that exists on both layers: BG1 and BG2.
; 
; When: SealLair (lair with record byte +8 non-zero) and TryOpenChest (chest with bit 7 of its id set).
; Sees: the same tile change, on both backgrounds.
; Why: some rooms draw a tile on both layers; changing only one would leave the other visible.
; In: as SetMetatileBg1.
; Out: $7E8000 and $7EC000 + offset = id; tile_type_map as above (from the BG1 definition); 8 queue entries (BG1 at the tilemap address, BG2 at the same offset + $1000) and a terminator, when on screen.
; Clobbers: A (X, P restored).

SetMetatileBg1Bg2 {
    PHP 
    PHX 
    PHA 
    REP #$20
    JSL $@lib_map_index_helpers.PixelToMapIndex
    SEP #$20
    PLA 
    STA $7E8000, X
    STA $7EC000, X
    PHX 
    REP #$20
    AND #$00FF
    ASL 
    ASL 
    ASL 
    TAX 
    LDA $7E2000, X
    AND $tile_mask_bg1
    ORA $tile_attr_bg1
    STA $1C7D
    LDA $7E2002, X
    AND $tile_mask_bg1
    ORA $tile_attr_bg1
    STA $1C81
    LDA $7E2004, X
    AND $tile_mask_bg1
    ORA $tile_attr_bg1
    STA $1C85
    LDA $7E2006, X
    AND $tile_mask_bg1
    ORA $tile_attr_bg1
    STA $1C89
    LDA $7E2800, X
    AND $tile_mask_bg2
    ORA $tile_attr_bg2
    STA $1C8D
    LDA $7E2802, X
    AND $tile_mask_bg2
    ORA $tile_attr_bg2
    STA $1C91
    LDA $7E2804, X
    AND $tile_mask_bg2
    ORA $tile_attr_bg2
    STA $1C95
    LDA $7E2806, X
    AND $tile_mask_bg2
    ORA $tile_attr_bg2
    STA $1C99
    SEP #$20
    LDA $7E2001, X
    AND #$02
    PHA 
    LDA $7E2003, X
    AND #$02
    PHA 
    LDA $7E2005, X
    AND #$02
    PHA 
    LDA $7E2007, X
    AND #$02
    ASL 
    ORA $01, S
    ASL 
    ORA $02, S
    ASL 
    ORA $03, S
    LSR 
    XBA 
    PLA 
    PLA 
    PLA 
    XBA 
    PLX 
    STA $tile_type_map, X
    REP #$20
    LDA $16
    CLC 
    ADC #$0010
    SEC 
    SBC $scroll_bg1_x
    CMP #$0111
    BCS loc_0108B8
    LDA $18
    CLC 
    ADC #$0010
    SEC 
    SBC $scroll_bg1_y
    CMP #$0111
    BCS loc_0108B8
    JSL $@lib_map_index_helpers.PixelToBg1VramAddr
    PHA 
    STA $vram_write_queue
    INC 
    STA $1C7F
    CLC 
    ADC #$001F
    STA $1C83
    INC 
    STA $1C87
    PLA 
    SEC 
    SBC #$6000
    CLC 
    ADC #$7000
    STA $1C8B
    INC 
    STA $1C8F
    CLC 
    ADC #$001F
    STA $1C93
    INC 
    STA $1C97
    STZ $1C9B

  loc_0108B8:
    PLX 
    PLP 
    RTL 
}