; Fixed engine state and new-game starting values, set once at reset (file offsets 162066-162228, SNES $04:F912-$F9B4, bank 04).
; 
; === MODEL ===
; InitFixedState stores the layer parameters the loaders and the streaming code read (map bases $8000 and $C000, tilemap VRAM $6000 and $7000, tile definitions $2000 and $2800, strip work areas $3000, $3102, $3204, $3306), the bank bytes $7E of the strip pointers in dp$34, $37 and $2E, the RAM copy stub at $1C5C, text_delay = 3, a dynamic-tile source pointer, and the starting game values: event flag $FF set (the word $1A7D = $0080), HP and max HP 8, level 1 (also the BCD level), and the initial lair_state of every lair from the 32-byte records of LairRecords (byte +$13).
; The RAM stub is PHB, MVN src,dst, PLB, RTS (8B 54 xx xx AB 60) at $1C5C; CopyFrameData patches the two bank operands and jumps to it (wram_copy_stub), because MVN has its banks in the instruction.
; 
; === NOTES ===
; - Called once from BootGame in engine_boot_main_loop, before the first scene loads, so a loaded save overwrites the starting values and a new game keeps them.
; - Event flag $FF (bit 7 of $1A7D) is set here at every start-up and travels with the save image. This is the writer OQ-I011-13 looked for: the 13 unk13 map-patch rows that test flag $00FF see it set (answers the 'who sets it' part; whether it is ever cleared is open).
; - $1A02/$1A04 are the long pointer of the dynamic-tile sprite code (BuildDynamicTileSprites builds it from actor $34/$2C before it reads it); the initial $7F:3000 is the buffer LoadBootGraphicsBuffers fills with graphics_054000. A read before the first write was not found.
---------------------------------------------

?BANK 04

?INCLUDE 'data_lair_records'

!map_base_bg1                   0352
!tilemap_vram_bg1               0354
!map_base_bg2                   0356
!tilemap_vram_bg2               0358
!tile_defs_bg1                  035A
!tile_defs_bg2                  035E
!strip_col_bg1                  0362
!strip_row_bg1                  0364
!strip_col_bg2                  0366
!strip_row_bg2                  0368
!player_level_bcd               1B6A
!text_delay                     1B84
!player_level                   1B86
!player_hp                      1B88
!player_max_hp                  1B8A
!wram_copy_stub                 1C5C
!lair_state                     7F0203

---------------------------------------------

; Sets the engine variables that never change and the starting state of a new game.
; 
; When: once, from the reset code (BootGame), before the first scene loads.
; Sees: nothing directly; a new game starts with HP 8 and level 1 from here, and a loaded save overwrites them.
; Why: these values are the initial memory the engine and a new game rely on.
; In: JSL; M = 8, X = 16-bit.
; Out: map_base_bg1 $8000, map_base_bg2 $C000, tilemap_vram_bg1 $6000, tilemap_vram_bg2 $7000, tile_defs_bg1 $2000, tile_defs_bg2 $2800, strip_col_bg1 $3000, strip_row_bg1 $3102, strip_col_bg2 $3204, strip_row_bg2 $3306; dp$34, $37 and $2E = $7E; the RAM stub wram_copy_stub ($1C5C) = PHB, MVN, PLB, RTS (8B 54 xx xx AB 60, the MVN banks are patched by CopyFrameData); text_delay = 3; $1A02/$1A04 = $7F:3000 (initial dynamic-tile source, overwritten before its first read by BuildDynamicTileSprites, static reading); the word $1A7D = $0080 (event flag $FF set, $1A7E = 0); player_hp and player_max_hp = 8; player_level and player_level_bcd = 1; lair_state[i] = byte +$13 of every 32-byte record of LairRecords (until a first byte $FF).
; Clobbers: A, X, Y.

InitFixedState {
    LDX #$8000
    STX $map_base_bg1
    LDX #$C000
    STX $map_base_bg2
    LDX #$6000
    STX $tilemap_vram_bg1
    LDX #$7000
    STX $tilemap_vram_bg2
    LDX #$2000
    STX $tile_defs_bg1
    LDX #$2800
    STX $tile_defs_bg2
    LDX #$3000
    STX $strip_col_bg1
    LDX #$3102
    STX $strip_row_bg1
    LDX #$3204
    STX $strip_col_bg2
    LDX #$3306
    STX $strip_row_bg2
    LDA #$7E
    STA $34
    STA $37
    STA $002E
    LDA #$8B
    STA $wram_copy_stub   ; RAM stub at $1C5C: PHB (8B), MVN (54) with two patched bank bytes, PLB (AB), RTS (60)
    LDA #$54
    STA $1C5D
    LDA #$AB
    STA $1C60
    LDA #$60
    STA $1C61
    LDA #$03
    STA $text_delay
    LDX #$3000
    STX $1A02             ; long pointer $7F:3000, the dynamic-tile source; rewritten before use (static)
    LDA #$7F
    STA $1A04
    REP #$20
    LDA #$0080
    STA $1A7D             ; word $0080: sets event flag $FF (bit 7 of $1A7D) and clears $1A7E (chests opened)
    SEP #$20
    LDA #$08
    STA $player_max_hp
    STA $player_hp
    LDA #$01
    STA $player_level
    STA $player_level_bcd
    LDX #$0000
    TXY 

  InitLairStatesLoop:
    LDA $&data_lair_records.LairRecords, Y
    CMP #$FF
    BEQ InitFixedStateDone
    LDA $&data_lair_records.LairRecords+13, Y ; byte +$13 of each 32-byte lair record is the initial lair_state
    STA $lair_state, X
    REP #$20
    INX 
    TYA 
    CLC 
    ADC #$0020
    TAY 
    SEP #$20
    BRA InitLairStatesLoop

  InitFixedStateDone:
    RTL 
}