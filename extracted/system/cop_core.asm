; CopB2_SpawnBeforeRelative, the exit chain and the helpers shared by every COP handler (file offsets 25715-26309, SNES $00:E473-$E6C5, bank 00). The handlers are in the cop_handlers files: cop_script_flow_flags, cop_items_stats_text, cop_conditions, cop_actor_fields_animation and cop_tiles_spawn_kill; the dispatcher and tables are in cop_dispatch.
; 
; === CONVENTIONS OF EVERY HANDLER ===
; HandleCop enters a handler with X = Y = the actor slot, DP $38 = the script pointer just past the id byte (the first operand byte) and DP $3A = the script bank. Every handler starts with TYX, reads its operands with LDA [$38] / INC $38 (a word costs two INCs; a Byte operand is read as a word and masked with $00FF) and leaves through the exit chain with BRL. A and Y are scratch; X is the actor slot again on exit, so the next COP of the script finds it intact. Scratch DP used by handlers: $00, $0C, $0E, $16, $18 (listed in each part note). A script that calls COP from its own code must keep X = actor slot (AGENTS.md, COP register requirement).
; A jump command reads the target word and leaves through CopExitJump; a failed condition leaves through the CopExitSkipN that matches the operand bytes still unread. A wait command (Cop05, Cop82, Cop83, CopAD) does not move past itself while the wait lasts: it saves a resume pointer that re-runs the same COP next frame and yields. A command that spawns, kills or changes fields simply continues through CopExitContinue.
; 
; === EXIT CHAIN ===
; The chain (CopExitSkip5 .. CopExitYield) is entered by BRL from the handlers: CopExitSkip5 skips 5 operand bytes, CopExitSkip4 skips 4, CopExitSkip3 skips 3, CopExitSkip2 skips 2, CopExitSkip1 skips 1, CopExitContinue skips none. They fall through to CopExitJump, which writes A over the return address on the stack ($02,S) and returns with RTI, so the script continues at A (for a jump, A is the target). CopExitSaveResume stores $38 as the actor's resume pointer ($18,X) and falls into CopExitYield, which pops the COP frame and returns with RTL (yield to the actor loop).
; 
; === FLAGS AND INVENTORY ===
; Event flags are a bit array at $1A5E. A flag word has the bit number (0-7) in its low byte and the byte index in bits 8-14; bit 15 is a command-specific sense bit (Cop05_WaitWhileFlagEquals, Cop09_SetOrClearFlag). The inventory/progress bytes are at $1B1E (entry n at $1B1E + n - 1, bit 7 = flag, bits 0-6 = value).
; 
; === ACTORS, TILES, SPAWNING ===
; Actor slots are 0x40 bytes wide from $0800. Actors are in a doubly linked list ($3C = next, $3E = previous; heads $06A6 and $06A8). Free slots are kept on a stack addressed by $4A (word entries; a taken entry is zeroed); when it is empty PopFreeSlot returns the scratch slot $06AA with carry set and the spawn handlers, which never test the carry, write into that slot. The spawn helpers link a new actor after (SpawnActorAfter) or before (SpawnActorBefore) the caller and clone the caller's first $3C bytes into it (InitSpawnedActor); the handlers then set the entry address ($18, bank $36) and optionally position and $16. BlockActorFootprint and ClearActorFootprint write the $F0 block mark into tile_type_map ($7F8000) for the box of an actor (width $10, height $12; a box with width + height below $21 is one tile at (x, y - 16)).
---------------------------------------------

?BANK 00

?INCLUDE 'lib_arithmetic'
?INCLUDE 'lib_map_index_helpers'

!actor_list_tail                06A6
!actor_list_head                06A8
!event_flags                    1A5E
!inventory                      1B1E
!switch_owner_table             7F0483
!tile_type_map                  7F8000

---------------------------------------------

; Spawns an actor before the caller at an offset from the caller, with flags.
; 
; When: 114 scripts (effects and projectiles placed next to their spawner).
; Sees: a new object appears beside the caller.
; Why: the offset form of Cop85; the file also holds the exit chain after it (this handler sits in front of it in the ROM).
; In: @Code, Word dx, Word dy, Word flags.
; Out: SpawnActorBefore; $18/$36 = entry; x = caller x + dx, y = caller y + dy, $16 = flags; leaves through CopExitContinue.
; Clobbers: A, Y = new slot (or $06AA when the pool is full); dp$38.

CopB2_SpawnBeforeRelative {
    TYX 
    JSR $&SpawnActorBefore
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
    BRL CopExitContinue

; Skip 5 operand bytes (falls through the INC chain to CopExitContinue).

  CopExitSkip5:
    INC $38

; Skip 4 operand bytes.

  CopExitSkip4:
    INC $38

; Skip 3 operand bytes.

  CopExitSkip3:
    INC $38

; Skip 2 operand bytes (a not-taken jump with one &Code operand).

  CopExitSkip2:
    INC $38

; Skip 1 operand byte.

  CopExitSkip1:
    INC $38

; Continue at the script pointer: A = $38.

  CopExitContinue:
    LDA $38

; A = new script pointer (jump target or $38). Replaces the return address on the stack and returns with RTI.

  CopExitJump:
    STA $02, S
    RTI 

; Save $38 as the actor's resume pointer ($18,X), then yield.

  CopExitSaveResume:
    LDA $38
    STA $0018, X

; Yield: PLA PLA RTL back to the actor loop. The script resumes next time from $18,X/$36,X.

  CopExitYield:
    PLA 
    PLA 
    RTL 
}
---------------------------------------------

; Set or clear an event flag. In: A = flag word (low byte = bit number 0-7, bits 8-14 = byte index into $1A5E, bit 15 set = set the bit, clear = clear it). Preserves X.

WriteEventFlag {
    PHX 
    STA $00
    AND #$00FF
    TAX 
    LDA $01
    AND #$007F
    TAY 
    SEP #$20
    LDA $01
    BPL loc_0064E8
    LDA $@BitMaskTable, X
    ORA $event_flags, Y
    BRA loc_0064F1

  loc_0064E8:
    LDA $@BitMaskTable, X
    EOR #$FF
    AND $event_flags, Y

  loc_0064F1:
    STA $event_flags, Y
    PLX 
    REP #$20
    RTS 
}
---------------------------------------------

; Tests one event flag.
; 
; When: from the COP flag handlers Cop05_WaitWhileFlagEquals, Cop07_JumpIfFlagEquals and Cop08_JumpIfFlagNotEquals.
; Sees: scripts branch on story progress (a released NPC, an opened door, a talked-to villager).
; Why: every flag lives in one bit array (event_flags, $1A5E) and is addressed by one flag word.
; In: A = flag word: low byte = bit number 0-7 (index into BitMaskTable), bits 8-14 = byte index; bit 15 is a command-specific sense bit that this routine ignores.
; Out: carry set when the flag bit is set, clear otherwise; M = 16 on return.
; Clobbers: A, Y, dp$00-$01; X preserved (PHX/PLX).

TestEventFlag {
    PHX 
    STA $00
    AND #$00FF
    TAX 
    LDA $01
    AND #$007F            ; Byte index = bits 8-14 of the flag word (bit 15 is not used here)
    TAY 
    SEP #$20
    LDA $@BitMaskTable, X
    AND $event_flags, Y
    SEC 
    BNE loc_006512
    CLC 

  loc_006512:
    PLX 
    REP #$20
    RTS 
}
---------------------------------------------

; Bit masks $01, $02, $04 ... $80, indexed by the low byte of a flag word (bit numbers 0-7). Read by TestEventFlag.

BitMaskTable #0102040810204080
---------------------------------------------

; Reads one inventory/progress entry.
; 
; When: from the COP inventory handlers Cop0A_GiveItemIfNotOwned, Cop0B_RemoveItem, Cop18_JumpIfItemMissing and Cop19_JumpUnlessItemEquipped.
; Sees: shops, chests and the death check act on what the player owns and has equipped.
; Why: inventory entry n sits at inventory + n - 1 (bit 7 = flag, bits 0-6 = value); all handlers share this read.
; In: A (8-bit) = entry number, 1-based.
; Out: carry set and A = the entry number when the value bits 0-6 are zero; carry clear and A = the whole byte when they are not; M = 16 on return.
; Clobbers: A, Y.

LookupInventoryEntry {
    SEP #$20
    PHA 
    TAY 
    DEY 
    LDA $inventory, Y
    AND #$7F
    BNE loc_00652F
    PLA 
    REP #$20
    SEC 
    RTS 

  loc_00652F:
    PLA 
    LDA $inventory, Y
    REP #$20
    CLC 
    RTS 
}
---------------------------------------------

; Marks the collision footprint of the actor at X solid.
; 
; When: Cop15_BlockOwnTiles.
; Sees: the tiles under the actor stop the player (a statue, a door, a chest, a standing NPC).
; Why: the tile map keeps one entry per tile; solid actors write $F0 into it. Counterpart of ClearActorFootprint.
; In: X = actor; position $00/$02, box width $10 and height $12.
; Out: $F0 is ORed into the low byte of every tile_type_map entry under the box; a box with width + height below $21 covers the one tile at (x, y - 16), a bigger box width / 16 columns by height / 16 rows.
; Clobbers: A, Y, dp$0C, $0E, $16, $18 and the scratch of lib_map_index_helpers; X preserved.

BlockActorFootprint {
    LDA $0010, X
    CLC 
    ADC $0012, X
    CMP #$0021            ; Width + height below $21: the box covers one tile at (x, y - 16); otherwise width / 16 by height / 16 tiles
    BCS loc_006563
    PHX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    LDA $tile_type_map, X
    ORA #$00F0            ; Mark the tile solid: $F0 ORed into the tile-type byte (ClearActorFootprint zeroes the byte)
    STA $tile_type_map, X
    PLX 
    RTS 

  loc_006563:
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

  loc_006579:
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    LDA $0010, Y
    LSR 
    LSR 
    LSR 
    LSR 
    STA $0E

  loc_006588:
    LDA $tile_type_map, X
    ORA #$00F0
    STA $tile_type_map, X
    JSL $@lib_map_index_helpers.StepMapIndexEast
    DEC $0E
    BNE loc_006588
    LDA $18
    CLC 
    ADC #$0010
    DEC $0C
    BNE loc_006579
    TYX 
    RTS 
}
---------------------------------------------

; Clears the collision footprint of the actor at X.
; 
; When: Cop16_UnblockOwnTiles, and Cop11_MoveActorToTile before it moves an actor.
; Sees: the tiles the actor blocked become walkable again (a door or a statue that moves away).
; Why: the tile map keeps one blocking entry per tile; an actor that moves or disappears must release its tiles. Counterpart of Cop15_BlockOwnTiles, which ORs $F0 into the same entries.
; In: X = actor; position $00/$02, box width $10 and height $12.
; Out: the low byte of every tile_type_map entry under the box is zeroed (the high byte stays). A box with width + height below $21 covers the one tile at (x, y - 16); a bigger box covers width / 16 columns by height / 16 rows.
; Clobbers: A, Y, dp$0C, $0E, $16, $18 and the scratch of lib_map_index_helpers; X preserved.

ClearActorFootprint {
    LDA $0010, X
    CLC 
    ADC $0012, X
    CMP #$0021            ; Width + height below $21: the box covers one tile at (x, y - 16); otherwise width / 16 by height / 16 tiles
    BCS loc_0065D3
    PHX 
    LDA $0000, X
    STA $16
    LDA $0002, X
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    LDA $tile_type_map, X
    AND #$FF00            ; Zero the low byte of the tile entry, keep the high byte
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
    JSL $@lib_map_index_helpers.PixelToMapIndex
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
    JSL $@lib_map_index_helpers.StepMapIndexEast
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
; Converts a slot number to the address of the actor slot.
; 
; When: COP handlers whose operand names another actor by slot number (Cop0C, Cop0D, Cop11, Cop12, Cop13, Cop2E).
; Sees: nothing.
; Why: scripts store 0-63 slot numbers (one byte) instead of $0800-based addresses.
; In: A (8-bit) = slot number.
; Out: Y = $0800 + number * $40 (product from lib_arithmetic.Multiply8x8).
; Clobbers: A, Y; M = 16 on return.

SlotNumberToActor {
    SEP #$20
    XBA 
    LDA #$40
    JSL $@lib_arithmetic.Multiply8x8
    REP #$20
    CLC 
    ADC #$0800
    TAY 
    RTS 
}

---------------------------------------------
; Converts a tile number to a pixel coordinate: A = A * 16.
; 
; When: COP handlers with tile operands (Cop0C, Cop0D, Cop11).
; Sees: nothing.
; Why: map tiles are 16 pixels wide; scripts give positions in tiles.
; In: A = tile number. Out: A = A * 16. Clobbers: A.

TileToPixel {
    ASL 
    ASL 
    ASL 
    ASL 
    RTS 
}

---------------------------------------------
; Records which actor waits for a switch.
; 
; When: Cop14_JumpIfSwitchSet and Cop3B_JumpIfSwitchSetElseHold, when the script first tests a switch.
; Sees: nothing at once; the actor later reacts when its switch is triggered (the walkthrough's green switch under a cleared lair).
; Why: switch_owner_table ($7F0483, word entries, cleared at every scene load by lib_scene_change_init) maps a switch number to the actor that owns it. Its readers are not traced yet.
; In: A = switch index, X = actor. Out: switch_owner_table[A] = X. Clobbers: none (A and X preserved).

RegisterSwitchOwner {
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
; Spawns an actor and links it after the actor X in the list.
; 
; When: Cop84_SpawnActorAfter, CopAB, CopAF, CopB1 and other spawn handlers.
; Sees: a monster, effect, projectile or pickup appears next to its spawner.
; Why: one shared path for allocating, linking and initialising a new actor.
; In: X = spawner.
; Out: Y = new slot ($3E of the new actor = X, $3C = the old $3C of X; actor_list_tail updated when the new actor is last), then InitSpawnedActor; carry set and nothing linked when no slot is free (Y = $06AA). X preserved.
; Clobbers: A, Y.

SpawnActorAfter {
    JSL $@PopFreeSlot
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
    JSR $&InitSpawnedActor

  loc_006661:
    RTS 
}

---------------------------------------------
; Spawns an actor and links it before the actor X in the list.
; 
; When: Cop85_SpawnActorBefore, CopAC, CopB0 and the lair code (SpawnLairMonster, SpawnLairActor).
; Sees: a monster, effect, projectile or pickup appears; an actor linked before X runs earlier in the actor loop.
; Why: one shared path for allocating, linking and initialising a new actor.
; In: X = spawner.
; Out: Y = new slot ($3C of the new actor = X, $3E = the old $3E of X; actor_list_head updated when the new actor is first), then InitSpawnedActor; carry set and nothing linked when no slot is free (Y = $06AA). X preserved.
; Clobbers: A, Y.

SpawnActorBefore {
    JSL $@PopFreeSlot
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
    JSR $&InitSpawnedActor

  loc_006689:
    RTS 
}

---------------------------------------------
; Takes a slot from the free-slot stack.
; 
; When: every spawn (SpawnActorAfter, SpawnActorBefore, SpawnPlacementList).
; Sees: nothing; when the stack is empty the spawn silently fails (the 64-slot pool is full).
; Why: slots are recycled through a stack so spawning is constant time.
; In: dp$4A = top of the stack (word entries).
; Out: Y = slot address, the entry zeroed, dp$4A += 2, carry clear; empty stack: carry set and Y = $06AA, a scratch slot. Called with JSL (ends in RTL).
; Clobbers: A, Y; M = 16 on return.

PopFreeSlot {
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
    LDY #$06AA            ; Stack empty: scratch slot $06AA, carry set (the caller must check it)
    RTL 
}

---------------------------------------------
; Turns the new slot Y into a copy of its spawner X.
; 
; When: at the end of SpawnActorAfter and SpawnActorBefore.
; Sees: the new actor starts at the spawner's position, animation and sprite attributes; callers then overwrite the script ($18) and flags ($16).
; Why: inheriting the first $3C bytes saves every spawn from setting position and sprite fields by hand.
; In: X = spawner, Y = new slot (list links already set by the caller).
; Out: MVN copies $3C bytes (A = $003B) from X to Y; then $16 bit $2000 is set and bit $0010 cleared; $1A, $30 and $14 = 0. The links $3C/$3E at the end of the slot are not copied.
; Clobbers: A; X and Y preserved.

InitSpawnedActor {
    PHX 
    PHY 
    LDA #$003B            ; MVN below copies $3C bytes (A = $3B): position, animation and attributes of the spawner X into the new slot Y
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