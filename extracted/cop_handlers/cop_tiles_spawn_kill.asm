; COP commands for the tile map, spawning and killing actors. Commands (id, uses): 15 BlockOwnTiles (209), 16 UnblockOwnTiles (82), 21 JumpIfTileAbove (43), 22 JumpIfTileBelow (45), 23 JumpIfTileLeft (50), 24 JumpIfTileRight (47), 28 JumpIfTileHere (24), 29 JumpIfTileIdDiffers (0), 2A BlockTileAt (20), 2B UnblockTileAt (20), AE JumpIfTileTypeNonZero (52), 30 SpawnIfEnteredViaRecord (32), 84 SpawnActorAfter (13), 85 SpawnActorBefore (346), 86 KillSelf (283), AB SpawnAfterAbsolute (0), AC SpawnBeforeAbsolute (38), AF SpawnAfterWithFlags (12), B0 SpawnBeforeWithFlags (76), B1 SpawnAfterRelative (0). CopB2_SpawnBeforeRelative (114) is in cop_core. Conventions shared by all handlers: cop_core block note.
; 
; === TILE MAP ===
; tile_type_map ($7F8000) has one byte per 16x16 tile. The low nibble is the tile type (collision), the whole byte is non-zero for a solid tile; blocking an actor's tiles ORs $F0 into the byte (cop_core.BlockActorFootprint) and unblocking zeroes the byte (ClearActorFootprint, Cop2B). lib_map_index_helpers.PixelToMapIndex turns the pixel position in dp$16 (x) and dp$18 (y) into the byte index. y is the bottom edge of an actor, so the row the actor stands on is y - 16: Cop28 samples (x, y - 16), Cop21 (x, y - 16 - height) above the box, Cop22 (x, y) below it, Cop23 (x - 16, y - 16) left of it and Cop24 (x + width, y - 16) right of it. Cop21-Cop24 and Cop28 jump when the whole byte is non-zero (a block mark or a type); CopAE tests only the type nibble and takes its position relative to the actor. Cop2A/Cop2B use the same relative offsets. Cop29 (unused) compares the byte at $7E8000 + index with an operand.
; 
; === SPAWNING ===
; Operands: 84 / 85: @Code (word + bank byte); AF / B0: @Code, Word flags ($16); AB / AC: @Code, Word x, Word y, Word flags; B1 / B2: @Code, Word dx, Word dy, Word flags (position = the caller's plus the offset); 30: Word record index, @Code. Every variant allocates with SpawnActorAfter / SpawnActorBefore, which clone the caller (InitSpawnedActor), then store the entry in $18 and the bank in $36 and, depending on the variant, overwrite position and $16. With an empty free-slot stack the new actor lands in the scratch slot $06AA and nothing is linked (the handlers do not check the carry). Cop30 spawns only for a visit that began at lair record N: return_active ($03FB) non-zero and return_record ($0405, stored by the return-trip warp in lib_tile_triggers_and_lair_return) equal to the operand.
; 
; === KILL ===
; Cop86 unlinks the caller from the actor list ($3C next, $3E previous; heads $06A8 / $06A6) and pushes its slot on the free-slot stack. The script keeps running after the COP, which is why every kill is followed by RTL.
---------------------------------------------

?BANK 00

?INCLUDE 'cop_core'
?INCLUDE 'lib_map_index_helpers'

!return_active                  03FB
!return_record                  0405
!actor_list_tail                06A6
!actor_list_head                06A8
!tile_type_map                  7F8000

---------------------------------------------

; Makes the tiles under the actor solid.
; 
; When: 209 scripts (statues, doors, chests, standing NPCs).
; Sees: the player cannot walk through the actor.
; Why: actors do not collide with each other for movement; solid ones mark the tile map instead.
; In: no operand; X = actor (box width $10, height $12).
; Out: BlockActorFootprint ORs $F0 into every tile byte under the box.
; Clobbers: A, Y; dp$0C, $0E, $16, $18.

Cop15_BlockOwnTiles {
    TYX 
    JSR $&cop_core.BlockActorFootprint
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Releases the tiles under the actor.
; 
; When: 82 scripts.
; Sees: a door opens or an NPC steps aside.
; Why: counterpart of Cop15.
; In: no operand.
; Out: ClearActorFootprint zeroes every tile byte under the box.
; Clobbers: A, Y; dp$0C, $0E, $16, $18.

Cop16_UnblockOwnTiles {
    TYX 
    JSR $&cop_core.ClearActorFootprint
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Jumps when the tile above the actor's box is occupied.
; 
; When: 43 scripts (monsters turning at walls).
; Sees: a monster turns back or stops.
; Why: probes the map instead of waiting for a collision.
; In: &Code = target.
; Out: tile at (x, y - 16 - height) non-zero: jump; otherwise CopExitSkip2 (via CopTileTestTail).
; Clobbers: A, Y; dp$16, $18; dp$38.

Cop21_JumpIfTileAbove {
    TYX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    SEC 
    SBC $0012, X          ; y - 16 - height: the tile row just above the top of the box (y is the bottom edge)
    STA $18
    BRL CopTileTestTail
}
---------------------------------------------

; Jumps when the tile row below the actor's box is occupied.
; 
; When: 45 scripts.
; Sees: as Cop21.
; Why: see Cop21.
; In: &Code = target.
; Out: tile at (x, y) non-zero: jump; otherwise CopExitSkip2.
; Clobbers: A, Y; dp$16, $18; dp$38.

Cop22_JumpIfTileBelow {
    TYX 
    LDA $0000, X
    STA $16
    LDA $0002, X          ; (x, y): the row just below the box; the other single-tile tests use the bottom row y - 16
    STA $18
    BRL CopTileTestTail
}
---------------------------------------------

; Jumps when the tile left of the actor is occupied.
; 
; When: 50 scripts.
; Sees: as Cop21.
; Why: see Cop21.
; In: &Code = target.
; Out: tile at (x - 16, y - 16) non-zero: jump; otherwise CopExitSkip2.
; Clobbers: A, Y; dp$16, $18; dp$38.

Cop23_JumpIfTileLeft {
    TYX 
    LDA $0000, X
    SEC 
    SBC #$0010
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    BRL CopTileTestTail
}
---------------------------------------------

; Jumps when the tile right of the actor is occupied.
; 
; When: 47 scripts.
; Sees: as Cop21.
; Why: see Cop21.
; In: &Code = target.
; Out: tile at (x + width, y - 16) non-zero: jump; otherwise CopExitSkip2.
; Clobbers: A, Y; dp$16, $18; dp$38.

Cop24_JumpIfTileRight {
    TYX 
    LDA $0000, X
    CLC 
    ADC $0010, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    BRL CopTileTestTail
}
---------------------------------------------

; Jumps when the tile under the actor is occupied.
; 
; When: 24 scripts.
; Sees: as Cop21.
; Why: see Cop21.
; In: &Code = target.
; Out: tile at (x, y - 16) non-zero: jump; otherwise CopExitSkip2 (falls into CopTileTestTail).
; Clobbers: A, Y; dp$16, $18; dp$38.

Cop28_JumpIfTileHere {
    TYX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18

; Shared tail of the tile tests Cop21-Cop24 and Cop28.
; 
; When: Cop21-Cop24 branch here, Cop28 falls in.
; In: dp$16 = x, dp$18 = y of the sampled tile (pixels), X = actor, dp$38 at the &Code word.
; Out: the tile byte (PixelToMapIndex index into tile_type_map) non-zero: jump; zero: CopExitSkip2. X preserved.
; Clobbers: A, Y.

  CopTileTestTail:
    PHX 
    JSL $@lib_map_index_helpers.PixelToMapIndex
    LDA $tile_type_map, X
    PLX 
    AND #$00FF            ; Only the tile's own byte: any non-zero value (the $F0 block mark or a type nibble) counts as occupied
    BNE loc_005BE2
    BRL cop_core.CopExitSkip2

  loc_005BE2:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Jumps when the byte at $7E8000 under the actor differs from an operand.
; 
; When: no script uses it (0 uses; OQ-I025-4).
; Sees: nothing.
; Why: tests a second map buffer; its meaning is not traced.
; In: Byte = value, &Code = target (copdef lists three Bytes).
; Out: byte at index (x, y - 16) differs: jump; equal: CopExitSkip2.
; Clobbers: A, Y; dp$16, $18; dp$38.

Cop29_JumpIfTileIdDiffers {
    TYX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    PHX 
    JSL $@lib_map_index_helpers.PixelToMapIndex
    SEP #$20
    LDA [$38]
    INC $38
    BNE loc_005C09
    INC $39

  loc_005C09:
    CMP $7E8000, X
    REP #$20
    BNE loc_005C15
    PLX 
    BRL cop_core.CopExitSkip2

  loc_005C15:
    PLX 
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Marks one tile at an offset from the actor solid.
; 
; When: 20 scripts.
; Sees: a spot on the map becomes impassable.
; Why: blocks a tile the actor does not stand on.
; In: Word = dx, Word = dy (pixels from the actor's position).
; Out: tile at (x + dx, y + dy - 16): byte |= $F0; X preserved.
; Clobbers: A, Y; dp$16, $18; dp$38.

Cop2A_BlockTileAt {
    TYX 
    PHX 
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0000, X
    STA $16
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    LDA $tile_type_map, X
    ORA #$00F0            ; Marks the tile solid: $F0 into the low byte, the type nibble stays in it
    STA $tile_type_map, X
    PLX 
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Clears one tile at an offset from the actor.
; 
; When: 20 scripts.
; Sees: the blocked spot becomes walkable.
; Why: counterpart of Cop2A.
; In: Word = dx, Word = dy.
; Out: low byte of the tile entry = 0 (type nibble and mark).
; Clobbers: A, Y; dp$16, $18; dp$38.

Cop2B_UnblockTileAt {
    TYX 
    PHX 
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0000, X
    STA $16
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    LDA $tile_type_map, X
    AND #$FF00            ; Zeroes the whole low byte: the type nibble goes too, not only the $F0 mark
    STA $tile_type_map, X
    PLX 
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Spawns an actor only when the current visit began at a given lair record.
; 
; When: 32 scripts (for example the Grass Valley village actors).
; Sees: an actor that is only there for that entrance.
; Why: return_active is non-zero inside a scene entered by the return-trip warp, which also stores the lair record index in return_record.
; In: Word = record index, @Code = script of the spawned actor (copdef: Word, &Code, Byte).
; Out: return_active zero: CopExitSkip5; record differs: CopExitSkip3; else branches into Cop85_SpawnActorBefore for the @Code.
; Clobbers: A, Y; dp$38.

Cop30_SpawnIfEnteredViaRecord {
    TYX 
    LDA $return_active    ; return_active: non-zero inside a scene entered by the return-trip warp (lib_tile_triggers_and_lair_return)
    BNE loc_005CDF
    BRL cop_core.CopExitSkip5

  loc_005CDF:
    LDA [$38]
    INC $38
    INC $38
    CMP $return_record    ; Operand = the LairRecords record index stored in return_record by that warp
    BEQ loc_005CED
    BRL cop_core.CopExitSkip3

  loc_005CED:
    BRL Cop85_SpawnActorBefore
}
---------------------------------------------

; Spawns an actor after the caller in the actor list.
; 
; When: 13 scripts.
; Sees: a new object appears at the caller's position.
; Why: actor list order decides who runs first; after = later.
; In: @Code = entry of the new actor (word + bank).
; Out: SpawnActorAfter; $18 = word, $36 = bank; the new actor starts as a clone of the caller.
; Clobbers: A, Y = new slot (or $06AA when the pool is full); dp$38.

Cop84_SpawnActorAfter {
    TYX 
    JSR $&cop_core.SpawnActorAfter
    LDA [$38]
    INC $38
    INC $38
    STA $0018, Y
    TXA 
    LDA [$38]
    INC $38
    AND #$00FF
    SEP #$20
    STA $0036, Y
    REP #$20
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Spawns an actor before the caller in the actor list.
; 
; When: 346 scripts (puffs, projectiles, monsters, pickups; RunAppearPuff from about 150 scene scripts).
; Sees: a new object appears at the caller's position.
; Why: see Cop84; before = runs earlier.
; In: @Code = entry of the new actor.
; Out: SpawnActorBefore; $18 = word, $36 = bank.
; Clobbers: A, Y = new slot (or $06AA); dp$38.

Cop85_SpawnActorBefore {
    TYX 
    JSR $&cop_core.SpawnActorBefore
    LDA [$38]
    INC $38
    INC $38
    STA $0018, Y
    TXA 
    LDA [$38]
    INC $38
    AND #$00FF
    SEP #$20
    STA $0036, Y
    REP #$20
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Removes the calling actor.
; 
; When: 283 scripts, always followed by RTL.
; Sees: the actor vanishes.
; Why: unlinks it from the actor list and frees its slot; the script still runs on to the RTL.
; In: no operand; X = actor.
; Out: list links repaired, slot pushed on the free-slot stack ($4A); continues.
; Clobbers: A, Y.

Cop86_KillSelf {
    TYX 
    LDY $003C, X
    BNE loc_005F23        ; Unlink from the list: $3C = next, $3E = previous; an actor without a next link is the tail
    LDY $003E, X
    STY $actor_list_tail
    BEQ loc_005F37
    LDA #$0000
    STA $003C, Y
    BRA loc_005F37

  loc_005F23:
    LDA $003E, X
    STA $003E, Y
    BNE loc_005F30
    STY $actor_list_head
    BRA loc_005F37

  loc_005F30:
    TAY 
    LDA $003C, X
    STA $003C, Y

  loc_005F37:
    SEP #$20
    DEC $4A               ; Push the slot back on the free-slot stack: $4A -= 2, then the slot word is stored at ($4A)
    DEC $4A
    REP #$20
    TXA 
    STA ($4A)
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Spawns an actor after the caller at an absolute position with flags.
; 
; When: no script uses it (0 uses; OQ-I025-4).
; Sees: nothing.
; Why: counterpart of CopAC.
; In: @Code, Word x, Word y, Word flags.
; Out: SpawnActorAfter; $18/$36 = entry, x, y and $16 = the operands.
; Clobbers: A, Y = new slot; dp$38.

CopAB_SpawnAfterAbsolute {
    TYX 
    JSR $&cop_core.SpawnActorAfter
    LDA [$38]
    INC $38
    INC $38
    STA $0018, Y
    TXA 
    LDA [$38]
    INC $38
    AND #$00FF
    SEP #$20
    STA $0036, Y
    REP #$20
    LDA [$38]
    INC $38
    INC $38
    STA $0000, Y
    LDA [$38]
    INC $38
    INC $38
    STA $0002, Y
    LDA [$38]
    INC $38
    INC $38
    STA $0016, Y
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Spawns an actor before the caller at an absolute position with flags.
; 
; When: 38 scripts.
; Sees: an object appears at a fixed spot.
; Why: for effects at map positions.
; In: @Code, Word x, Word y, Word flags.
; Out: SpawnActorBefore; $18/$36 = entry, x, y and $16 = the operands.
; Clobbers: A, Y = new slot; dp$38.

CopAC_SpawnBeforeAbsolute {
    TYX 
    JSR $&cop_core.SpawnActorBefore
    LDA [$38]
    INC $38
    INC $38
    STA $0018, Y
    TXA 
    LDA [$38]
    INC $38
    AND #$00FF
    SEP #$20
    STA $0036, Y
    REP #$20
    LDA [$38]
    INC $38
    INC $38
    STA $0000, Y
    LDA [$38]
    INC $38
    INC $38
    STA $0002, Y
    LDA [$38]
    INC $38
    INC $38
    STA $0016, Y
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Jumps when the tile type at an offset from the actor is non-zero.
; 
; When: 52 scripts.
; Sees: a monster reacts to the terrain ahead.
; Why: tests only the type nibble, so a tile blocked by an actor ($F0 mark with type 0) does not count.
; In: Word = dx, Word = dy, &Code = target.
; Out: tile byte at (x + dx, y + dy - 16) and $0F non-zero: jump; otherwise CopExitSkip2.
; Clobbers: A, Y; dp$16, $18; dp$38.

CopAE_JumpIfTileTypeNonZero {
    TYX 
    PHX 
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0000, X
    STA $16
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    LDA $tile_type_map, X
    PLX 
    AND #$000F
    BEQ loc_0063DE
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump

  loc_0063DE:
    BRL cop_core.CopExitSkip2
}
---------------------------------------------

; Spawns an actor after the caller with its own flag word.
; 
; When: 12 scripts.
; Sees: a new object appears at the caller's position.
; Why: $16 is replaced by the operand.
; In: @Code, Word flags.
; Out: SpawnActorAfter; $18/$36 = entry, $16 = flags.
; Clobbers: A, Y = new slot; dp$38.

CopAF_SpawnAfterWithFlags {
    TYX 
    JSR $&cop_core.SpawnActorAfter
    LDA [$38]
    INC $38
    INC $38
    STA $0018, Y
    TXA 
    LDA [$38]
    INC $38
    AND #$00FF
    SEP #$20
    STA $0036, Y
    REP #$20
    LDA [$38]
    INC $38
    INC $38
    STA $0016, Y
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Spawns an actor before the caller with its own flag word.
; 
; When: 76 scripts.
; Sees: a new object appears at the caller's position.
; Why: see CopAF.
; In: @Code, Word flags.
; Out: SpawnActorBefore; $18/$36 = entry, $16 = flags.
; Clobbers: A, Y = new slot; dp$38.

CopB0_SpawnBeforeWithFlags {
    TYX 
    JSR $&cop_core.SpawnActorBefore
    LDA [$38]
    INC $38
    INC $38
    STA $0018, Y
    TXA 
    LDA [$38]
    INC $38
    AND #$00FF
    SEP #$20
    STA $0036, Y
    REP #$20
    LDA [$38]
    INC $38
    INC $38
    STA $0016, Y
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Spawns an actor after the caller at an offset with flags.
; 
; When: no script uses it (0 uses; OQ-I025-4).
; Sees: nothing.
; Why: counterpart of CopB2.
; In: @Code, Word dx, Word dy, Word flags.
; Out: SpawnActorAfter; $18/$36 = entry, x and y = the caller's plus the offsets, $16 = flags.
; Clobbers: A, Y = new slot; dp$38.

CopB1_SpawnAfterRelative {
    TYX 
    JSR $&cop_core.SpawnActorAfter
    LDA [$38]
    INC $38
    INC $38
    STA $0018, Y
    TXA 
    LDA [$38]
    INC $38
    AND #$00FF
    SEP #$20
    STA $0036, Y
    REP #$20
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0000, X
    STA $0000, Y
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0002, X
    STA $0002, Y
    LDA [$38]
    INC $38
    INC $38
    STA $0016, Y
    BRL cop_core.CopExitContinue
}