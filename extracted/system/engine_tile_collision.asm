; Tile collision and actor motion: moving an actor against the tile type map, the single-point probe and the velocity step (file offsets 3880-4782, SNES $00:8F28-$92AE, bank 00).
; 
; === MODEL ===
; MoveActorWithTileCollision moves x first (CollideEast or CollideWest), then y (CollideSouth or CollideNorth), each probing the tile types in the rows or columns the actor's width and height cover. GetTileType reads tile_type_map ($7F8000): index = ((y / 16) x map_width_pages + x / 16) x 256 + (y and 15) x 16 + (x and 15) for tile coordinates; a type byte with a high nibble set (Cop15_BlockOwnTiles ORs $F0) or an index of $4000 or more reads as $0F (blocked). Blocked: $00 or $02 snapped to a multiple of 16, velocity zeroed, $16 bit $0004 set. Tile type codes are in OQ-I005-8; the east and south routines have no boundary pre-check (OQ-I005-12).
; 
; === NOTES ===
; - The callers are engine_actor_scheduler_and_sprites (two references, the actor step) and player_core (one); the file includes lib_arithmetic only. The parts are MoveActorWithTileCollision, CollideEast, CollideWest, CollideSouth, CollideNorth, ProbeTileAtVelocity (the one-point test for an actor whose width or height has bit 3 set), GetTileType and ApplyActorVelocity.
---------------------------------------------

?BANK 00

?INCLUDE 'lib_arithmetic'

!map_width_pages                0343
!tile_type_map                  7F8000

---------------------------------------------

; Moves an actor by its velocity with tile collision, x first, then y.
; 
; When: StepActorMotion for actors with $16 bit $1000 (and the player code).
; Sees: actors stop at walls instead of walking through them.
; Why: separate axes let an actor slide along a wall.
; In: X = actor with $04 and $06; RTL.
; Out: when ($10 or $12) has bit 3 the actor is tested with one point (ProbeTileAtVelocity); otherwise CollideEast for dx above 0, CollideWest for dx below 0, then CollideSouth or CollideNorth for dy.
; Clobbers: A, dp$00-$1C.

MoveActorWithTileCollision {
    LDA $0010, X
    ORA $0012, X
    AND #$0008            ; Width or height with bit 3 set: one-point test (ProbeTileAtVelocity) instead of the box
    BNE loc_000F52
    LDA $0004, X
    BEQ loc_000F42
    BMI loc_000F3F
    JSR $&CollideEast
    BRA loc_000F42

  loc_000F3F:
    JSR $&CollideWest

  loc_000F42:
    LDA $0006, X
    BEQ loc_000F51
    BMI loc_000F4E
    JSR $&CollideSouth
    BRA loc_000F51

  loc_000F4E:
    JSR $&CollideNorth

  loc_000F51:
    RTL 

  loc_000F52:
    JSR $&ProbeTileAtVelocity
    RTL 
}

---------------------------------------------
; East collision: blocks the actor when the tiles in front of it are walls.
; 
; In: X = actor, dx above 0. Out: carry set = blocked: $00 snapped to a multiple of 16, $04 = 0, $16 bit $0004 set; carry clear = free and the bit cleared.
; Probes the rows covered by the height: the current column for type $0A, then the next column for $0F, $05, $06. No tile-boundary pre-check (OQ-I005-12); type codes OQ-I005-8.
; Clobbers: A, dp$00, dp$0C, dp$0E, dp$16, dp$18, dp$1C.

CollideEast {
    PHP 
    LDA $0000, X
    CLC 
    ADC $0010, X
    SEC 
    SBC #$0010
    LSR 
    LSR 
    LSR 
    LSR 
    STA $16
    LDA $0002, X
    SEC 
    SBC $0012, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $18
    STA $1C
    LDA $0002, X
    DEC 
    LSR 
    LSR 
    LSR 
    LSR 
    STA $00
    LDA $0012, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0C
    STA $0E
    SEP #$20

  loc_000F8E:
    JSR $&GetTileType
    CMP #$0A
    BEQ loc_000FE4
    INC $18
    DEC $0C
    BNE loc_000F8E
    LDA $00
    STA $18
    JSR $&GetTileType
    CMP #$0A
    BEQ loc_000FE4
    LDA $1C
    STA $18
    INC $16

  loc_000FAC:
    JSR $&GetTileType
    BCS loc_000FFC
    CMP #$0F
    BEQ loc_000FE4
    CMP #$05
    BEQ loc_000FE4
    CMP #$06
    BEQ loc_000FE4
    INC $18
    DEC $0E
    BNE loc_000FAC
    LDA $00
    STA $18
    JSR $&GetTileType
    BCS loc_000FFC
    CMP #$0F
    BEQ loc_000FE4
    CMP #$05
    BEQ loc_000FE4
    CMP #$06
    BEQ loc_000FE4
    PLP 
    LDA $0016, X
    AND #$FFFB
    STA $0016, X
    CLC 
    RTS 

  loc_000FE4:
    PLP 
    LDA $0016, X
    ORA #$0004
    STA $0016, X

  loc_000FEE:
    LDA $0000, X
    AND #$FFF0
    STA $0000, X
    STZ $0004, X
    SEC 
    RTS 

  loc_000FFC:
    PLP 
    BRA loc_000FEE
}

---------------------------------------------
; West collision, as CollideEast with a tile-boundary pre-check: current column type $05, next column $0F, $0A, $06; dx below 0 (OQ-I005-8, -12).

CollideWest {
    PHP 
    LDA $0004, X
    CLC 
    ADC $0000, X
    EOR $0000, X
    AND #$FFF0
    BEQ loc_001088
    LDA $0000, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $16
    LDA $0002, X
    SEC 
    SBC $0012, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $18
    STA $1C
    LDA $0002, X
    DEC 
    LSR 
    LSR 
    LSR 
    LSR 
    STA $00
    LDA $0012, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0C
    STA $0E
    SEP #$20

  loc_00103E:
    JSR $&GetTileType
    CMP #$05
    BEQ loc_001094
    INC $18
    DEC $0C
    BNE loc_00103E
    LDA $00
    STA $18
    JSR $&GetTileType
    CMP #$05
    BEQ loc_001094
    LDA $1C
    STA $18
    DEC $16

  loc_00105C:
    JSR $&GetTileType
    BCS loc_0010AC
    CMP #$0F
    BEQ loc_001094
    CMP #$0A
    BEQ loc_001094
    CMP #$06
    BEQ loc_001094
    INC $18
    DEC $0E
    BNE loc_00105C
    LDA $00
    STA $18
    JSR $&GetTileType
    BCS loc_0010AC
    CMP #$0F
    BEQ loc_001094
    CMP #$0A
    BEQ loc_001094
    CMP #$06
    BEQ loc_001094

  loc_001088:
    PLP 
    LDA $0016, X
    AND #$FFFB
    STA $0016, X
    CLC 
    RTS 

  loc_001094:
    PLP 
    LDA $0016, X
    ORA #$0004
    STA $0016, X

  loc_00109E:
    LDA $0000, X
    AND #$FFF0
    STA $0000, X
    STZ $0004, X
    SEC 
    RTS 

  loc_0010AC:
    PLP 
    BRA loc_00109E
}

---------------------------------------------
; South collision, as CollideEast for y ($02 snapped, $06 = 0), no pre-check: current row type $0C, next row $0F, $03, $06; dy above 0.

CollideSouth {
    PHP 
    LDA $0002, X
    SEC 
    SBC #$0010
    LSR 
    LSR 
    LSR 
    LSR 
    STA $18
    LDA $0000, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $16
    STA $1A
    LDA $0000, X
    CLC 
    ADC $0010, X
    DEC 
    LSR 
    LSR 
    LSR 
    LSR 
    STA $00
    LDA $0010, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0C
    STA $0E
    SEP #$20

  loc_0010E3:
    JSR $&GetTileType
    CMP #$0C
    BEQ loc_001139
    INC $16
    DEC $0C
    BNE loc_0010E3
    LDA $00
    STA $16
    JSR $&GetTileType
    CMP #$0C
    BEQ loc_001139
    LDA $1A
    STA $16
    INC $18

  loc_001101:
    JSR $&GetTileType
    BCS loc_001151
    CMP #$0F
    BEQ loc_001139
    CMP #$03
    BEQ loc_001139
    CMP #$06
    BEQ loc_001139
    INC $16
    DEC $0E
    BNE loc_001101
    LDA $00
    STA $16
    JSR $&GetTileType
    BCS loc_001151
    CMP #$0F
    BEQ loc_001139
    CMP #$03
    BEQ loc_001139
    CMP #$06
    BEQ loc_001139
    PLP 
    LDA $0016, X
    AND #$FFFB
    STA $0016, X
    CLC 
    RTS 

  loc_001139:
    PLP 
    LDA $0016, X
    ORA #$0004
    STA $0016, X

  loc_001143:
    LDA $0002, X
    AND #$FFF0
    STA $0002, X
    STZ $0006, X
    SEC 
    RTS 

  loc_001151:
    PLP 
    BRA loc_001143
}

---------------------------------------------
; North collision, as CollideSouth with a tile-boundary pre-check: current row type $03, next row $0F, $0C, $06; dy below 0.

CollideNorth {
    PHP 
    LDA $0006, X
    CLC 
    ADC $0002, X
    EOR $0002, X
    AND #$FFF0
    BEQ loc_0011E1
    LDA $0002, X
    SEC 
    SBC $0012, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $18
    LDA $0000, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $16
    STA $1A
    LDA $0000, X
    CLC 
    ADC $0010, X
    DEC 
    LSR 
    LSR 
    LSR 
    LSR 
    STA $00
    LDA $0010, X
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0C
    STA $0E
    SEP #$20

  loc_001197:
    JSR $&GetTileType
    CMP #$03
    BEQ loc_0011ED
    INC $16
    DEC $0C
    BNE loc_001197
    LDA $00
    STA $16
    JSR $&GetTileType
    CMP #$03
    BEQ loc_0011ED
    LDA $1A
    STA $16
    DEC $18

  loc_0011B5:
    JSR $&GetTileType
    BCS loc_001205
    CMP #$0F
    BEQ loc_0011ED
    CMP #$0C
    BEQ loc_0011ED
    CMP #$06
    BEQ loc_0011ED
    INC $16
    DEC $0E
    BNE loc_0011B5
    LDA $00
    STA $16
    JSR $&GetTileType
    BCS loc_001205
    CMP #$0F
    BEQ loc_0011ED
    CMP #$0C
    BEQ loc_0011ED
    CMP #$06
    BEQ loc_0011ED

  loc_0011E1:
    PLP 
    LDA $0016, X
    AND #$FFFB
    STA $0016, X
    CLC 
    RTS 

  loc_0011ED:
    PLP 
    LDA $0016, X
    ORA #$0004
    STA $0016, X

  loc_0011F7:
    LDA $0002, X
    AND #$FFF0
    STA $0002, X
    STZ $0006, X
    SEC 
    RTS 

  loc_001205:
    PLP 
    BRA loc_0011F7
}

---------------------------------------------
; One-point tile test for small actors: stops the actor when the tile at its next position is blocked.
; 
; In: X = actor. Out: tile (x + dx - 4, y + dy - 4): type $0F zeroes $04 and $06, sets $16 bit $0004 and returns carry set; otherwise clears the bit, carry clear. Returns at once when dx is 0 (OQ-I005-9; the compare with $0F depends on the B byte, OQ-I005-10).
; Clobbers: A, dp$16, dp$18.

ProbeTileAtVelocity {
    LDA $0004, X
    ORA $0004, X          ; Reads $04 twice (probably meant $04 or $06): returns only when dx is 0 (OQ-I005-9)
    BEQ loc_001243
    LDA $0000, X
    CLC 
    ADC $0004, X
    SEC 
    SBC #$0004
    LSR 
    LSR 
    LSR 
    LSR 
    STA $16
    LDA $0002, X
    CLC 
    ADC $0006, X
    SEC 
    SBC #$0004
    LSR 
    LSR 
    LSR 
    LSR 
    STA $18
    JSR $&GetTileType
    CMP #$000F            ; Type $0F blocks; the 16-bit compare relies on the B byte being 0 (OQ-I005-10)
    BEQ loc_001245
    LDA $0016, X
    AND #$FFFB
    STA $0016, X

  loc_001243:
    CLC 
    RTS 

  loc_001245:
    STZ $0004, X
    STZ $0006, X
    LDA $0016, X
    ORA #$0004
    STA $0016, X
    SEC 
    RTS 
}

---------------------------------------------
; Returns the collision type of a map tile.
; 
; When: 17 call sites in the collision routines.
; In: dp$16 = tile x (byte), dp$18 = tile y (word), M = 0 or 1.
; Out: carry clear and A (8-bit) = low nibble of the tile when its high nibble is 0; carry set and A = $0F when the high nibble is non-zero (an actor blocks the tile, Cop15_BlockOwnTiles ORs $F0) or the index is $4000 or more. Index = ((y / 16) x map_width_pages + x / 16) x 256 + (y and 15) x 16 + (x and 15). The B byte is left stale (OQ-I005-10).
; Clobbers: A; X and P preserved.

GetTileType {
    PHP 
    PHX 
    REP #$20
    LDA $18
    ASL                   ; y x 16: low byte = (y and 15) x 16 (row in the page), high byte = y / 16 (page row)
    ASL 
    ASL 
    ASL 
    PHA 
    SEP #$20
    LDA $map_width_pages
    JSL $@lib_arithmetic.Multiply8x8
    STA $02, S
    LDA $16
    AND #$0F
    CLC 
    ADC $01, S
    STA $01, S
    LDA $16
    LSR 
    LSR 
    LSR 
    LSR 
    CLC 
    ADC $02, S
    STA $02, S
    PLX 
    CPX #$4000            ; An index of $4000 or more is outside the type map: blocked ($0F)
    BCS loc_001294
    LDA $tile_type_map, X
    BIT #$F0
    BNE loc_001294        ; High nibble set = tile blocked by an actor (Cop15_BlockOwnTiles ORs $F0): reads as $0F
    AND #$0F
    PLX 
    PLP 
    CLC 
    RTS 

  loc_001294:
    LDA #$0F
    PLX 
    PLP 
    SEC 
    RTS 
}

---------------------------------------------
; Adds the velocity to the position: $00 += $04 and $02 += $06 (16-bit). In: X = actor. Clobbers A.

ApplyActorVelocity {
    LDA $0000, X
    CLC 
    ADC $0004, X
    STA $0000, X
    LDA $0002, X
    CLC 
    ADC $0006, X
    STA $0002, X
    RTS 
}