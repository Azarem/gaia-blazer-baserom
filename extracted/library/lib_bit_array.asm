; Set, clear and test of one bit in a bit array (file offsets 160584-160723, SNES $04:F348-$F3D3, bank 04).
; 
; === MODEL ===
; Three routines share one addressing rule: A = bit number (& $3FF, at most 1024 bits), Y = address of the array. The byte is Y + ((A & $3F8) >> 3) and the mask comes from SwitchBitMasks (01 02 04 08 10 20 40 80) indexed by A & 7. All three save A, X, Y and P; TestBitInArray returns the result in the carry (set = the bit is set).
; The arrays the callers pass in Y: $1A7E chests opened (bit = chest id & $7F), $1A9E lairs released (bit = lair index), $1ADE switches set (bit = switch id); $1A5E is event_flags, and the arrays at $1A7E, $1A9E and $1ADE lie inside the range that holds the event flags and the saved progress image ($1A5E-$1C57).
; 
; === NOTES ===
; - Callers: SetBitInArray 7 sites (lib_tile_triggers_and_lair_return 5, engine_003005 2), TestBitInArray 11 sites (lib_scene_map_patches 5, cop_script_flow_flags 3, lib_tile_triggers_and_lair_return 2, engine_003005 1).
; - ClearBitInArray has no caller (OQ-I013-12).
---------------------------------------------

?BANK 04

?INCLUDE 'data_engine_tables'

---------------------------------------------

; Sets one bit of a bit array.
; 
; When: when a lair is released, a switch is pressed or a chest is opened (lib_tile_triggers_and_lair_return 5 sites, engine_003005 2 sites).
; Sees: nothing directly; the bit is what later keeps the lair open, the switch pressed and the chest empty.
; Why: lets the progress arrays use one bit per object, so a save slot stays small.
; In: JSL; A = bit number (& $3FF), Y = array address.
; Out: bit (A & 7) of byte Y + (A >> 3) set; A, X, Y and P restored.
; Clobbers: none.

SetBitInArray {
    PHP 
    REP #$20
    PHA 
    PHX 
    PHY 
    PHA 
    PHY 
    AND #$03F8            ; byte index = (bit number & $3F8) >> 3, added to the array address on the stack
    LSR 
    LSR 
    LSR 
    CLC 
    ADC $01, S
    STA $01, S
    PLY 
    PLA 
    AND #$0007
    TAX 
    SEP #$20
    LDA $@data_engine_tables.SwitchBitMasks, X ; mask 01 02 04 ... 80 indexed by bit & 7
    ORA $0000, Y
    STA $0000, Y
    REP #$20
    PLY 
    PLX 
    PLA 
    PLP 
    RTL 
}
---------------------------------------------

; Clears one bit of a bit array (dead code).
; 
; When: never called (OQ-I013-12).
; Sees: nothing in the shipped game.
; Why: the counterpart of SetBitInArray, left unused: the game never takes a lair, switch or chest bit back.
; In: as SetBitInArray.
; Out: the bit cleared; A, X, Y and P restored.
; Clobbers: none.

ClearBitInArray {
    PHP 
    REP #$20
    PHA 
    PHX 
    PHY 
    PHA 
    PHY 
    AND #$03F8
    LSR 
    LSR 
    LSR 
    CLC 
    ADC $01, S
    STA $01, S
    PLY 
    PLA 
    AND #$0007
    TAX 
    SEP #$20
    LDA $@data_engine_tables.SwitchBitMasks, X
    EOR #$FF
    AND $0000, Y
    STA $0000, Y
    REP #$20
    PLY 
    PLX 
    PLA 
    PLP 
    RTL 
}
---------------------------------------------

; Tests one bit of a bit array.
; 
; When: 11 sites: map patches that depend on lair, switch and chest state, tile triggers, the COP switch commands and the chest code.
; Sees: a chest stays open, a released lair stays gone, a pressed switch stays pressed after the scene is entered again.
; Why: one test serves all arrays, and the carry is the result.
; In: JSL; A = bit number (& $3FF), Y = array address.
; Out: carry set when the bit is set, clear otherwise; A, X, Y restored (P restored apart from the carry).
; Clobbers: none.

TestBitInArray {
    PHP 
    REP #$20
    PHA 
    PHX 
    PHY 
    PHA 
    PHY 
    AND #$03F8
    LSR 
    LSR 
    LSR 
    CLC 
    ADC $01, S
    STA $01, S
    PLY 
    PLA 
    AND #$0007
    TAX 
    SEP #$20
    LDA $@data_engine_tables.SwitchBitMasks, X
    AND $0000, Y
    REP #$20
    BNE TestBitInArraySet ; bit set: carry set on return
    PLY 
    PLX 
    PLA 
    PLP 
    CLC 
    RTL 

  TestBitInArraySet:
    PLY 
    PLX 
    PLA 
    PLP 
    SEC 
    RTL 
}