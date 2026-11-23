; Map patch rectangles: copy a rectangle of the map to another place, and the table that holds the five boss-room patches followed by the map sizes (ApplyMapPatchRect: file offsets 67771-68053, SNES $02:88BB-$89D5; MapPatchRectsAndMapSizes: 95492-95787, SNES $02:F504-$F62B; bank 02).
; 
; === MODEL ===
; ApplyMapPatchRect copies a rectangle of metatiles (and their tile_type_map bytes) inside the BG1 map: from the source rectangle given in the record's pixel words +4 / +6 to the destination given by +0 / +1 (metatile units), width +2, height +3; then every copied cell that is on screen is queued for VRAM (16 bytes per cell in vram_write_queue, zero terminator). It is the boss-room patch: RunBossMapPatch (engine_003005) calls it with the id 0-4 stored by five boss scripts (whether the patch closes or opens the room is OQ-I024-3).
; 
; === TABLE ===
; MapPatchRectsAndMapSizes holds two tables back to back in one 296-byte part: 5 patch records of 8 bytes (entries 00-04 of the extracted rows) and, from byte $28, 128 pairs (map_width_pages, map_height_pages) indexed by location_id x 2, read by lib_scene_change_init (OQ-I026-2: the part should be split in blocks.json).
; Patch record: +0 destination x, +1 destination y (metatiles), +2 width, +3 height (metatiles), +4 word source x, +6 word source y (pixels).
---------------------------------------------

?BANK 02

?INCLUDE 'lib_map_index_helpers'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!tile_mask_bg1                  035C
!tile_attr_bg1                  036A
!vram_write_queue               1C7B
!tile_type_map                  7F8000

---------------------------------------------

; Copies a rectangle of BG1 metatiles (and their collision bytes) to another place and redraws what is on screen.
; 
; When: ApplyBossMapPatch (engine_003005), once per boss room, with the patch id 0-4 from the boss script.
; Sees: part of the boss room changes at the moment the fight starts or ends (a door opens or closes, OQ-I024-3).
; Why: the changed room is prebuilt elsewhere in the same map, so the patch only has to copy cells.
; In: A (16 bits) = patch id (0-4); M = 16.
; Out: for every cell of the width x height rectangle: $7E8000 and tile_type_map at the destination = the cells at the source; on-screen cells queued (4 entries each) and a terminator word 0. BG2 is not touched.
; Clobbers: A, Y, dp $00, $02, $0C, $0E, $16, $18 (X restored).

ApplyMapPatchRect {
    PHX 
    ASL 
    ASL 
    ASL 
    TAX 
    TXY 
    LDA $@MapPatchRectsAndMapSizes+4, X ; Record = id x 8: +0 / +1 destination, +2 / +3 size (metatiles), +4 / +6 source position (pixels)
    STA $16
    LDA $@MapPatchRectsAndMapSizes+6, X
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    PHX 
    TYX 
    LDA $@MapPatchRectsAndMapSizes, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $00
    LDA $@MapPatchRectsAndMapSizes+1, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    LDA $@MapPatchRectsAndMapSizes+2, X
    AND #$00FF
    STA $02
    LDA $@MapPatchRectsAndMapSizes+3, X
    AND #$00FF
    STA $0E
    LDY #$0000
    PLX 

  loc_010903:
    PHX 
    LDA $02
    STA $0C
    LDA $00
    STA $16

  loc_01090C:
    PHX 
    SEP #$20
    LDA $7E8000, X        ; Source cell: its metatile and collision byte are read here and stored at the destination cell
    PHA 
    LDA $tile_type_map, X
    PHA 
    REP #$20
    JSL $@lib_map_index_helpers.PixelToMapIndex ; X = map offset of the destination cell (dp$16 / $18)
    SEP #$20
    PLA 
    STA $tile_type_map, X
    PLA 
    STA $7E8000, X
    REP #$20
    LDA $16
    CLC 
    ADC #$0010
    SEC 
    SBC $scroll_bg1_x
    CMP #$0111
    BCS loc_0109A6        ; Only cells inside the view (plus a 16-pixel margin) are queued for VRAM
    LDA $18
    CLC 
    ADC #$0010
    SEC 
    SBC $scroll_bg1_y
    CMP #$0111
    BCS loc_0109A6
    LDA $7E8000, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    TAX 
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
    JSL $@lib_map_index_helpers.PixelToBg1VramAddr
    STA $vram_write_queue, Y
    INC 
    STA $1C7F, Y
    CLC 
    ADC #$001F
    STA $1C83, Y
    INC 
    STA $1C87, Y
    TYA 
    CLC 
    ADC #$0010
    TAY 

  loc_0109A6:
    PLX 
    JSL $@lib_map_index_helpers.StepMapIndexEast
    LDA $16
    CLC 
    ADC #$0010
    STA $16
    DEC $0C
    BEQ loc_0109BA
    BRL loc_01090C

  loc_0109BA:
    PLX 
    JSL $@lib_map_index_helpers.StepMapIndexSouth
    LDA $18
    CLC 
    ADC #$0010
    STA $18
    DEC $0E
    BEQ loc_0109CE
    BRL loc_010903

  loc_0109CE:
    LDA #$0000
    STA $vram_write_queue, Y
    PLX 
    RTL 
}
---------------------------------------------

; Five boss map patch records followed by the per-location map size table.
; 
; When: ApplyMapPatchRect reads the records (id x 8); lib_scene_change_init reads the sizes (location_id x 2 + $28) into map_width_pages and map_height_pages.
; Sees: the boss room patch and the size of every scene's map.
; Why: both are small constant tables of this file's code; the size table has 128 entries (unused locations hold 0, 0).
; In: n/a (data).
; Out: n/a. Patch ids 0 and 4 are identical (OQ-I024-3).
; Clobbers: n/a.

MapPatchRectsAndMapSizes [
  unk14 < #06, #0B, #04, #03, #$0020, #$00B0 >   ;00
  unk14 < #0D, #0B, #06, #03, #$0130, #$00B0 >   ;01
  unk14 < #0E, #0C, #04, #02, #$0070, #$00C0 >   ;02
  unk14 < #0E, #00, #01, #09, #$0120, #$0000 >   ;03
  unk14 < #06, #0B, #04, #03, #$0020, #$00B0 >   ;04
  unk14 < #01, #01, #04, #04, #$0101, #$0101 >   ;05
  unk14 < #01, #01, #05, #04, #$0404, #$0401 >   ;06
  unk14 < #04, #01, #02, #02, #$0101, #$0401 >   ;07
  unk14 < #01, #01, #01, #01, #$0404, #$0202 >   ;08
  unk14 < #01, #01, #02, #01, #$0101, #$0404 >   ;09
  unk14 < #01, #01, #03, #03, #$0202, #$0101 >   ;0A
  unk14 < #01, #01, #02, #06, #$0202, #$0303 >   ;0B
  unk14 < #04, #04, #02, #02, #$0303, #$0404 >   ;0C
  unk14 < #03, #03, #04, #04, #$0102, #$0202 >   ;0D
  unk14 < #03, #03, #00, #00, #$0000, #$0000 >   ;0E
  unk14 < #01, #01, #04, #04, #$0308, #$0201 >   ;0F
  unk14 < #02, #01, #08, #04, #$0404, #$0303 >   ;10
  unk14 < #04, #04, #04, #04, #$0501, #$0501 >   ;11
  unk14 < #08, #04, #00, #00, #$0000, #$0000 >   ;12
  unk14 < #00, #00, #00, #00, #$0000, #$0000 >   ;13
  unk14 < #01, #01, #04, #04, #$0403, #$0303 >   ;14
  unk14 < #03, #03, #03, #04, #$0403, #$0403 >   ;15
  unk14 < #02, #01, #03, #03, #$0602, #$0404 >   ;16
  unk14 < #00, #00, #00, #00, #$0000, #$0000 >   ;17
  unk14 < #00, #00, #00, #00, #$0000, #$0000 >   ;18
  unk14 < #01, #01, #02, #02, #$0202, #$0101 >   ;19
  unk14 < #02, #01, #02, #02, #$0404, #$0602 >   ;1A
  unk14 < #04, #04, #02, #02, #$0602, #$0404 >   ;1B
  unk14 < #04, #04, #00, #00, #$0000, #$0000 >   ;1C
  unk14 < #00, #00, #00, #00, #$0000, #$0000 >   ;1D
  unk14 < #01, #01, #04, #04, #$0303, #$0303 >   ;1E
  unk14 < #04, #04, #04, #04, #$0202, #$0202 >   ;1F
  unk14 < #02, #02, #02, #02, #$0202, #$0202 >   ;20
  unk14 < #03, #02, #03, #03, #$0303, #$0303 >   ;21
  unk14 < #00, #00, #00, #00, #$0000, #$0000 >   ;22
  unk14 < #01, #01, #03, #06, #$0402, #$0402 >   ;23
  unk14 < #01, #03, #01, #01, #$0000, #$0000 >   ;24
]