; Actor-slot and collision helpers for the COP handlers.
; 
; Actor slots are 0x40 bytes wide from $0800. Actors are in a doubly linked list ($3C = next, $3E = previous; heads $06A6 and $06A8). Free slots are kept on a stack addressed by $4A (word entries; a taken entry is zeroed). The spawn helpers link a new actor after (code_00663A) or before (code_006662) the caller and clone the caller's first $3C bytes into it (code_0066A3).
---------------------------------------------

?BANK 00

?INCLUDE 'lib_027462_part1'
?INCLUDE 'lib_027462_part2'
?INCLUDE 'lib_shared_0131D1'

!actor_list_tail                06A6
!actor_list_head                06A8
!switch_owner_table             7F0483
!tile_type_map                  7F8000

---------------------------------------------

; Clear the collision footprint of the actor at X: for every tile under its box (widths $10/$12) the low byte of the entry in the collision buffer $7F8000 is zeroed. Uses lib_027462 to turn the position into a buffer offset. Counterpart of Cop15_BlockOwnTiles, which ORs $F0 into the same entries.

code_0065A7 {
    LDA $0010, X
    CLC 
    ADC $0012, X
    CMP #$0021
    BCS loc_0065D3
    PHX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    LDA $tile_type_map, X
    AND #$FF00
    STA $tile_type_map, X
    PLX 
    RTS 

  loc_0065D3:
    TXY 
    LDA $0012, Y
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0C
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC $0012, X

  loc_0065E9:
    STA $18
    JSL $@lib_027462_part1.code_0272B8
    LDA $0010, Y
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0E

  loc_0065F8:
    LDA $tile_type_map, X
    AND #$FF00
    STA $tile_type_map, X
    JSL $@lib_027462_part2.code_02731A
    DEC $0E
    BNE loc_0065F8
    LDA $18
    CLC 
    ADC #$0010
    DEC $0C
    BNE loc_0065E9
    TYX 
    RTS 
}

---------------------------------------------
; Convert a slot number to a slot address. In: A (8-bit) = slot number. Out: Y = $0800 + number * $40.

code_006617 {
    SEP #$20
    XBA 
    LDA #$40
    JSL $@lib_shared_0131D1.code_0131D1
    REP #$20
    CLC 
    ADC #$0800
    TAY 
    RTS 
}

---------------------------------------------
; Tile number to pixel coordinate: A = A * 16.

code_006628 {
    ASL 
    ASL 
    ASL 
    ASL 
    RTS 
}

---------------------------------------------
; Register the actor X in the table $7F0483 at index A (word entries). Used by Cop14_JumpIfSwitchSet and Cop3B_JumpIfSwitchSetData. Preserves A and X.

code_00662D {
    PHA 
    PHX 
    ASL 
    TAX 
    LDA $01, S
    STA $switch_owner_table, X
    PLX 
    PLA 
    RTS 
}

---------------------------------------------
; Spawn: take a free slot, link it AFTER the actor X, then initialise it (code_0066A3). Out: Y = new slot, carry set when no slot is free.

code_00663A {
    JSL $@code_00668A
    BCS loc_006661
    TXA 
    STA $003E, Y
    LDA $003C, X
    STA $003C, Y
    TYA 
    STA $003C, X
    PHX 
    LDX $003C, Y
    BNE loc_006659
    STY $actor_list_tail
    BRA loc_00665D

  loc_006659:
    TYA 
    STA $003E, X

  loc_00665D:
    PLX 
    JSR $&code_0066A3

  loc_006661:
    RTS 
}

---------------------------------------------
; Spawn: take a free slot, link it BEFORE the actor X, then initialise it (code_0066A3). Out: Y = new slot, carry set when no slot is free.

code_006662 {
    JSL $@code_00668A
    BCS loc_006689
    TXA 
    STA $003C, Y
    LDA $003E, X
    STA $003E, Y
    TYA 
    STA $003E, X
    PHX 
    LDX $003E, Y
    BEQ loc_006682
    TYA 
    STA $003C, X
    BRA loc_006685

  loc_006682:
    STY $actor_list_head

  loc_006685:
    PLX 
    JSR $&code_0066A3

  loc_006689:
    RTS 
}

---------------------------------------------
; Pop a free slot from the stack at $4A. Out: Y = slot, carry clear; or carry set (Y = $06AA, a scratch slot) when the stack is empty.

code_00668A {
    LDA ($4A)
    BEQ loc_00669E
    TAY 
    LDA #$0000
    STA ($4A)
    SEP #$20
    INC $4A
    INC $4A
    REP #$20
    CLC 
    RTL 

  loc_00669E:
    SEC 
    LDY #$06AA
    RTL 
}

---------------------------------------------
; Initialise a new actor Y from the caller X: copy $3C bytes (MVN), set $16 bit $2000 and clear bit $0010, zero $1A, $30 and $14.

code_0066A3 {
    PHX 
    PHY 
    LDA #$003B
    MVN #$01, #$01
    PLY 
    PLX 
    LDA $0016, Y
    ORA #$2000
    AND #$FFEF
    STA $0016, Y
    LDA #$0000
    STA $001A, Y
    STA $0030, Y
    STA $0014, Y
    RTS 
}