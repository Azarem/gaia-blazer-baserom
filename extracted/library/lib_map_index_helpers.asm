; Pixel position to map index conversion, the two index steppers and the metatile hazard test (file offsets 160440-160583 and 160866-161137, SNES $04:F2B8-$F347 and $F462-$F571, bank 04).
; 
; === MODEL ===
; The field maps are stored as 256-byte pages of 16 x 16 metatiles (one byte per 16 x 16 pixel metatile), pages in rows of map_width_pages. PixelToMapIndex turns the pixel position in dp$16 (x) and dp$18 (y) into the byte index: index = ((map_width_pages x (y >> 8) + (x >> 8)) << 8) + y_low + ((x >> 4) & $0F), with 8-bit adds for the page byte and the low byte; an index of $4000 or more (a map of at most 64 pages) returns 0. The index is the same for every map-sized array: the BG1 id map $7E:8000, the BG2 map $7E:C000 and tile_type_map ($7F:8000).
; y_low is added as it is, without masking its low nibble: the exact row-major index needs y with a low nibble of 0, otherwise the low nibble is added to the column (OQ-I031-1). IsPlayerOnMetatile masks y before it calls.
; StepMapIndexEast moves the index one metatile to the east (+1, or +$F1 in the last column of a page to reach column 0 of the next page); StepMapIndexSouth one metatile to the south (+$10 on the low byte; at the end of a page the carry adds map_width_px, the next page row). PixelToBg1VramAddr is different: it turns the pixel position into the VRAM word address of the 8 x 8 tile in the BG1 tilemap at $6000, a 64 x 64 tile map made of four 32 x 32 screens (x bit 8 adds $400, y bit 8 adds $800).
; IsPlayerOnMetatile tests whether the BG1 id at the player's feet row (y - $10: y is the bottom edge of the actor) is a given id, over the 1, 2 or 4 metatiles the player's 16-pixel box covers: x and y multiples of 16 = 1 cell, only x = 2 cells one below the other, only y = 2 cells side by side, neither = 4 cells (walked east, south, east). It returns carry set at once for a cell that matches, and carry clear at once when the player's flags have $0C00 (hit stun $0800 or dying $0400).
; 
; === NOTES ===
; - PixelToMapIndex has about 40 callers (player_core, cop_core, cop_tiles_spawn_kill, lib_map_tile_patches, lib_map_tile_patches, lib_map_tile_patches, lib_tile_triggers_and_lair_return, lib_menus, engine_spawn_lairs_death_drops and four actor files); it needs M = 16 on entry and returns with M = 16 (it ends with REP #$20). It relies on B holding the high byte of dp$18 after LDA $18 at M = 16 (the page row for Multiply8x8).
; - IsPlayerOnMetatile is the floor hazard of four scenes. Each script first tests an inventory entry with Cop19 and only checks the tile while the item is not worn, then hurts the player with Cop39: Lostside Marsh id $80, 1 damage (guarded by item entry $0A; walkthrough items.md: Ice Armor protects from the fiery floors in Lostside), Leo's Laboratory dungeon ids $F3 and $E1, 4 damage (item entry $0A; 06-dr-leos-lab.md: equip the Ice Armor for the flaming bridges), Magridd's Castle dungeon id $88, 3 damage (item entry $0F; walkthrough items.md: Elemental Mail prevents spike damage), and the St. Elles coast id $47, 4 damage (after a COP [07] flag test; what the tile is is open, OQ-I031-2).
; - The routine never saves P: M = 16 is an input and kept on return.
---------------------------------------------

?BANK 04

?INCLUDE 'lib_arithmetic'

!map_width_px                   0342
!map_width_pages                0343
!player_x                       0374
!player_y                       0376
!player_actor                   039C

---------------------------------------------

; Turns a pixel position into the byte index of its 16 x 16 metatile.
; 
; When: about 40 call sites (collision, tile COP commands, map patches, chests, switches, the equipment menu, enemy spawns).
; Sees: nothing; it is the lookup behind every tile test.
; Why: one routine owns the page layout, so all maps and all overlays (id map, tile_type_map) use the same index.
; In: JSL; M = 16; dp$16 = x in pixels, dp$18 = y in pixels (low nibble of y 0 for an exact index, OQ-I031-1); map_width_pages ($0343).
; Out: X = ((map_width_pages x (y >> 8) + (x >> 8)) << 8) + y_low + ((x >> 4) & $0F), or 0 when that is $4000 or more; M = 16 on return.
; Clobbers: A, X (the result); B; flags. dp$16 and $18 are kept. The hardware multiplier is used through Multiply8x8.

PixelToMapIndex {
    LDA $18
    PHA 
    SEP #$20
    LDA $map_width_pages  ; width in pages x page row; B still holds the high byte of dp$18 (page row) from LDA $18
    JSL $@lib_arithmetic.Multiply8x8
    STA $02, S
    LDA $16
    LSR 
    LSR 
    LSR 
    LSR 
    AND #$0F              ; column inside the page; the row comes from y_low unmasked (OQ-I031-1)
    CLC 
    ADC $01, S
    STA $01, S
    LDA $17
    CLC 
    ADC $02, S
    STA $02, S
    REP #$20
    PLX 
    CPX #$4000            ; index of $4000 or more (outside 64 pages): return 0
    BCC loc_0272E5
    LDX #$0000

  loc_0272E5:
    RTL 
}
---------------------------------------------

; Turns a pixel position into the VRAM word address of its 8 x 8 BG1 tile.
; 
; When: SetMetatileBg1 and SetMetatileBg1Bg2 (lib_map_tile_patches, 2 sites) and the scene map patcher (lib_map_tile_patches) when they queue VRAM writes.
; Sees: nothing directly; the address says where the changed tile is drawn.
; Why: BG1 uses a 64 x 64 tile map made of four 32 x 32 screens, so the address is not a plain row-major index.
; In: JSL; M = 16; dp$16 = x, dp$18 = y (pixels).
; Out: A = $6000 + ((y & $F8) << 2) + ((x & $F8) >> 3) + ((x & $100) << 2) + ((y & $100) << 3). Ends with RTL without PHP/PLP.
; Clobbers: A; the stack is balanced.

PixelToBg1VramAddr {
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
    ADC #$6000            ; BG1 tilemap base; x bit 8 added $400, y bit 8 added $800 above
    RTL 
}
---------------------------------------------

; Moves a map index one metatile east.
; 
; When: 13 sites that walk over 2 x 2 or wider metatile areas (hazard test, footprint tests of the player and actors, map patches).
; Sees: nothing.
; Why: the index is not linear across pages, so a step needs the page wrap rule.
; In: JSL; X = map index.
; Out: X + 1, or X + $F1 when X & $0F is $0F (column 0 of the next page); M as the caller.
; Clobbers: A (TXA). P restored.

StepMapIndexEast {
    PHP 
    SEP #$20
    TXA 
    AND #$0F
    CMP #$0F
    REP #$20
    BEQ StepMapIndexEastNextPage
    INX 
    PLP 
    RTL 

  StepMapIndexEastNextPage:
    TXA 
    CLC 
    ADC #$00F1            ; last column of a page: +$100 to the next page and back to column 0
    TAX 
    PLP 
    RTL 
}

---------------------------------------------
; Moves a map index one metatile south.
; 
; When: 10 sites, with StepMapIndexEast.
; Sees: nothing.
; Why: same page layout rule as the east step.
; In: JSL; X = map index.
; Out: X + $10 on the low byte; when that wraps (last row of a page), the carry makes the code add map_width_px, which is one row of pages; M as the caller.
; Clobbers: A. P restored.

StepMapIndexSouth {
    PHP 
    REP #$20
    TXA 
    SEP #$20
    CLC 
    ADC #$10
    REP #$20
    BCS StepMapIndexSouthNextPageRow
    TAX 
    PLP 
    RTL 

  StepMapIndexSouthNextPageRow:
    CLC 
    ADC $map_width_px     ; last row of a page: one row of pages (map_width_px) further
    TAX 
    PLP 
    RTL 
}
---------------------------------------------

; Tests whether the player stands on a metatile with a given BG1 id.
; 
; When: the hazard scripts of Lostside Marsh, Leo's Laboratory dungeon, Magridd's Castle dungeon and the St. Elles coast (5 call sites).
; Sees: stepping on the tile hurts the player when the script then calls Cop39_DamagePlayer.
; Why: the player's box can cover one to four metatiles, and the test is true if any of them has the id.
; In: JSL; M = 16, X = 16-bit; A = metatile id (low byte used, stored in dp$00); player_x, player_y.
; Out: carry set: one of the metatiles at row y - $10 under the player has the id. Carry clear: none has, or at once when the player's flags $16 have $0C00 (hit stun or dying). X restored; M = 16 kept (P is not saved).
; Clobbers: A; dp$00, $16, $18.

IsPlayerOnMetatile {
    STA $00
    LDY $player_actor
    LDA $0016, Y
    BIT #$0C00            ; hit stun $0800 or dying $0400: no hazard hit
    BEQ loc_027471
    CLC 
    RTL 

  loc_027471:
    PHX 
    LDA $player_x         ; cells to test: x and y aligned 1, only x 2 (one below the other), only y 2 (side by side), neither 4
    AND #$000F
    BEQ MetatileTestXAligned
    LDA $player_y
    AND #$000F
    BEQ MetatileTestHorizontalPair
    BRL MetatileTestFourCells

  MetatileTestXAligned:
    LDA $player_y
    AND #$000F
    BNE MetatileTestVerticalPair
    LDA $player_x
    STA $16
    LDA $player_y
    SEC 
    SBC #$0010            ; y is the bottom edge: y - $10 is the row the feet stand on
    STA $18
    JSL $@PixelToMapIndex
    LDA $7E8000, X        ; BG1 metatile id map, one byte per 16 x 16 metatile
    AND #$00FF
    CMP $00
    BNE loc_0274AD
    BRL MetatileTestFound

  loc_0274AD:
    PLX 
    CLC 
    RTL 

  MetatileTestHorizontalPair:
    LDA $player_x
    AND #$FFF0
    STA $16
    LDA $player_y
    SEC 
    SBC #$0010
    STA $18
    JSL $@PixelToMapIndex
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BNE loc_0274D3
    BRL MetatileTestFound

  loc_0274D3:
    JSL $@StepMapIndexEast
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BNE loc_0274E5
    BRL MetatileTestFound

  loc_0274E5:
    PLX 
    CLC 
    RTL 

  MetatileTestVerticalPair:
    LDA $player_x
    STA $16
    LDA $player_y
    AND #$FFF0
    SEC 
    SBC #$0010
    STA $18
    JSL $@PixelToMapIndex
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BEQ MetatileTestFound
    JSL $@StepMapIndexSouth
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BEQ MetatileTestFound
    PLX 
    CLC 
    RTL 

  MetatileTestFourCells:
    LDA $player_x
    AND #$FFF0
    STA $16
    LDA $player_y
    AND #$FFF0
    SEC 
    SBC #$0010
    STA $18
    JSL $@PixelToMapIndex
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BEQ MetatileTestFound
    PHX 
    JSL $@StepMapIndexEast
    LDA $7E8000, X
    AND #$00FF
    PLX 
    CMP $00
    BEQ MetatileTestFound
    JSL $@StepMapIndexSouth
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BEQ MetatileTestFound
    JSL $@StepMapIndexEast
    LDA $7E8000, X
    AND #$00FF
    CMP $00
    BEQ MetatileTestFound
    PLX 
    CLC 
    RTL 

  MetatileTestFound:
    PLX 
    SEC 
    RTL 
}