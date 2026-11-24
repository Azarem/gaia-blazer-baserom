; Actor scheduler, draw list sort, OAM builder and animation (file offsets 1445-2611, SNES $00:85A5-$8A33, bank 00). The hit rules are in engine_combat_hits (2612-3879) and the tile collision in engine_tile_collision (3880-4782); the scheduler reaches the collision through two references and nothing else of the two files.
; 
; === ACTOR SLOTS ===
; 64 slots of $40 bytes at $0800 + $40 x n. Free slots sit on a stack at $1800-$187F (dp$4A points to it). Two links: run order is from actor_list_tail ($06A6) following $3E; the cull and sort pass goes from actor_list_head ($06A8) following $3C. A scene's placement list links each actor in as the new head, so its first row is the tail and runs first; SpawnActorAfter links on the $3C side of its caller (the new actor runs before the caller, first on the next frame) and SpawnActorBefore on the $3E side (right after the caller, in the same frame).
; Fields: $00 x, $02 y (words); $04 dx, $06 dy; $08 $0A $0C $0E extent box (left, top, right, bottom distances from x, y); $10 width, $12 height; $14 wait counter; $16 flags; $18 script resume address and $36 its bank; $1A attribute flags; $1C OAM attribute (bit 15 flip Y, bit 14 flip X); $1E animation id; $20 animation step; $22 animation table pointer; $24 data bank of the animation and spritemap data; $25 HP; $26 hit-stun counter; $28 spritemap pointer; $2C and $34 dynamic-tile bank and source; $2E $2F lair state copies; $30 projectile damage ($FF always kills); $38 meta entry pointer; $3A placement record pointer; $3C $3E links.
; 
; === FLAGS ===
; $16: $8000 off screen (set by CullAndSortActors and at spawn); $4000 pickup; $2000 hidden or inactive; $1000 runs tile collision; $0800 hit stun; $0400 dying; $0080 hit source (player side) or the player; $0020 projectile; $0010 runs during sub-frames; $0004 blocked by a tile; $0002 deflects hits; $0001 no enemy gauge. Combat masks (engine_combat_hits): $0100 = inert (neither a hit source nor a contact hazard); $0200 = cannot be hit but still hurts on contact; $0040 = neither a target nor a contact hazard. Unexplained outside combat: $0008 and the other uses of $0040 (OQ-I049-9).
; $1A: $8000 dynamic-tile sprite; $4000 draw in front; $2000 draw behind; $0080 not drawn; $0040 frozen while stunned; $0100 survives lethal hits with 1 HP; $0200, $0400, $0800 immunity classes (special, metal, spirit; see COMBAT).
; 
; === SCHEDULER ===
; RunActors pushes EndRunActors - 1 and RunActorList - 1 and executes RTS: RunActorList starts with A = actor_list_tail, and when the list ends its RTS lands in EndRunActors, which restores dp$38-$3A, DBR and P and returns with RTL. RunActorList calls an actor script by pushing a bank-0 return address (StepActorMotion - 1), the script bank ($36) and $18 - 1, then RTL; the script returns with RTL into StepActorMotion with X = slot. A script runs when its wait counter $14 goes below 0. While subframe_active is set only actors with $16 bit $0010 run.
; 
; === DRAW LIST ===
; CullAndSortActors sets $16 bit $8000 for actors whose extent box misses the 256 x 224 screen and clears it for the rest, and builds the sorted draw list at $1900 (slot words, 0 ends). Key = (255 - (y - scroll_y)) x 2, so lower actors on screen sort first; key 0 for $1A bit $4000 (in front) and for actors with y - scroll_y outside 0-$FF; key $01FE for $1A bit $2000 (behind). Hidden ($16 bit $2000) and not-drawn ($1A bit $0080) actors are not listed. Bucket sort: pass 1 stores (key, slot) pairs at $1900, pass 2 pops them with S moved to $18FF into 256 linked buckets at $0100-$02FF (nodes carved from the OAM area at $0486), pass 3 pops the bucket heads with S = $00FF and writes the slots back to $1900 in key order, clearing every head with PHA/PLA (A = 0 over the popped word). The scan stops at the $FFFF end marker at $0300 (OQ-I013-1). S relocation is safe only because NMI is off in the work phase (OQ-I005-20).
; 
; === OAM ===
; BuildOamFromActors fills the OAM low table ($0486-$0685, 4 bytes per sprite: x, y, tile, attribute) and the high table ($0686-: two bits per sprite, x bit 8 and size) from the draw list through BuildActorSprites, until the list ends or all 128 sprites are used. Unused sprites are set to $E080 (off screen). A spritemap is a word entry count followed by 7-byte entries: flags (bit 0 = size bit), x offset, x offset when flipped in x, y offset, y offset when flipped in y, word tile and attribute (XOR $1C, or $0E00 while the stun flashes). Dynamic-tile actors ($1A bit $8000; only the hero, set by CopA9 in InitPlayerActor) copy tile blocks of 32 bytes at source + tile x 32 through tile_dma_list and use OAM tile numbers 0, 2, 4 and so on; the NMI uploads them.
; 
; === ANIMATION ===
; SetActorAnimFrame: $22 points to a word table indexed by the animation id; each entry points to a list of 8-byte steps indexed by $20: word duration (negative ends the animation), word dx, word dy, word frame pointer. A frame record has six words (left, right, top, bottom extents, width, height) followed at +12 by the spritemap. Flip bits of $1C negate dx and dy and mirror the extents.
---------------------------------------------

?BANK 00

?INCLUDE 'engine_tile_collision'

!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!subframe_active                03A6
!tile_dma_pending               03B6
!oam_buffer                     0486
!actor_list_tail                06A6
!actor_list_head                06A8
!draw_list                      1900
!tile_dma_list                  1A06
!actor_run_count                1F00

---------------------------------------------

; IRQ vector: a bare RTI. The I flag is never cleared (no CLI in extracted/), so the IRQ stays masked even though NMITIMEN is written as $A1.

HandleIrq {
    RTI 
}

---------------------------------------------
; Runs every actor script once.
; 
; When: every frame (8 call sites: the main loop variants, the sub-frames and the scene loader).
; Sees: all enemy, NPC and effect behaviour advances one step.
; Why: the engine is a cooperative scheduler: scripts yield with RTL.
; In: none; M = 0 after REP #$20.
; Out: actor_run_count ($1F00) = actors visited; dp$38-$3A saved by PEI and restored by EndRunActors.
; Clobbers: A, X, Y (P and DBR restored).

RunActors {
    PHP 
    PHB 
    PEI ($38)
    PEI ($39)
    REP #$20
    STZ $actor_run_count
    LDA $actor_list_tail
    PEA $&EndRunActors-1
    PEA $&RunActorList-1
    RTS                   ; RTS enters RunActorList with A = actor_list_tail; its closing RTS returns into EndRunActors
}

---------------------------------------------
; Landing point of RunActorList's closing RTS (the RTS trick of RunActors): restores dp$38-$3A, DBR and P and returns to RunActors' caller with RTL. Clobbers X.

EndRunActors {
    PLX 
    STX $39
    PLX 
    STX $38
    PLB 
    PLP 
    RTL 
}

---------------------------------------------
; Marks which actors are off screen and builds the sorted draw list at $1900.
; 
; When: every frame after RunActors, and in each sub-frame.
; Sees: actors nearer the bottom of the screen draw in front; off-screen actors cost nothing.
; Why: OAM order decides sprite priority, so the list is sorted by screen y; the off-screen flag lets scripts such as CopAD wait for visibility (OQ-I005-11).
; In: none (reads actor_list_head, scroll_bg1_x/y and the actor fields).
; Out: $16 bit $8000 set or cleared; $1900 holds the slot words in key order, ended by 0 (keys in the block note). The $0200 compare before the key store is a dead guard: the key never exceeds $01FE.
; Clobbers: A, X, Y, dp$00, dp$02; S relocated and restored; scratch: buckets $0100-$02FF (re-zeroed), nodes from $0486.

CullAndSortActors {
    PHP 
    REP #$20
    LDA $actor_list_head
    LDY #$0000

; Loop head of pass 1: X = actor (0 ends, branch to FillSortBuckets); tests the extent box against the screen; the next actor comes from $3C.

  CullNextActor:
    TAX 
    BNE CullTestX
    BRL FillSortBuckets

  CullTestX:
    LDA $0000, X
    SEC 
    SBC $0008, X
    SEC 
    SBC $scroll_bg1_x
    CMP #$0100            ; Screen test: 256 wide ($0100), 224 high ($00E0), using the extent box ($08 left, $0A top, $0C right, $0E bottom)
    BCC CullTestY
    BMI CullTestRightEdge
    BRL MarkActorOffScreen

  CullTestRightEdge:
    LDA $0000, X
    CLC 
    ADC $000C, X
    SEC 
    SBC $scroll_bg1_x
    CMP #$0100
    BCS MarkActorOffScreen

  CullTestY:
    LDA $0002, X
    SEC 
    SBC $000A, X
    SEC 
    SBC $scroll_bg1_y
    CMP #$00E0
    BCC CullClassify
    BPL MarkActorOffScreen
    LDA $0002, X
    CLC 
    ADC $000E, X
    SEC 
    SBC $scroll_bg1_y
    CMP #$00E0
    BCS MarkActorOffScreen

  CullClassify:
    LDA $0016, X
    BIT #$2000            ; Hidden ($16 bit $2000) or not drawn ($1A bit $0080): on screen but not put in the draw list
    BNE MarkActorOnScreen
    LDA $001A, X
    BIT #$0080
    BNE MarkActorOnScreen
    BIT #$6000
    BEQ CullKeyFromY
    BIT #$4000            ; $1A bit $4000: key 0 (drawn in front)
    BNE CullKeyFront
    LDA #$01FE            ; $1A bit $2000: key $01FE (drawn behind everything)
    BRA CullStoreKey

  CullKeyFromY:
    LDA $0002, X
    SEC 
    SBC $scroll_bg1_y
    CMP #$0100
    BCC CullKeyScale

  CullKeyFront:
    LDA #$00FF            ; y - scroll_y outside 0-$FF: key 0

  CullKeyScale:
    EOR #$00FF            ; key = (255 - (y - scroll_y)) x 2: the lower an actor stands, the smaller the key; ascending keys, OAM index 0 is in front
    ASL 

  CullStoreKey:
    CMP #$0200
    BCS CullStoreKey
    STA $draw_list, Y     ; Pass 1: (key, slot) pairs at $1900, 4 bytes each, in list order
    TXA 
    STA $1902, Y
    INY 
    INY 
    INY 
    INY 

; Visible actor that is not listed (hidden or not drawn) or was listed: clear $16 bit $8000 and go to the next actor ($3C).

  MarkActorOnScreen:
    LDA $0016, X
    AND #$7FFF            ; Clear the off-screen flag $8000 (set means off screen, OQ-I005-11)
    STA $0016, X
    LDA $003C, X
    BRL CullNextActor

; Actor box misses the screen: set $16 bit $8000 and go to the next actor ($3C).

  MarkActorOffScreen:
    LDA $0016, X
    ORA #$8000
    STA $0016, X
    LDA $003C, X
    BRL CullNextActor

; Pass 2 of the sort: terminates the pair list with $FFFF, sets dp$02 = $0486 (next free node), moves S to $18FF and pushes every (key, slot) pair into the bucket for its key (new node in front of the old head).

  FillSortBuckets:
    LDA #$FFFF            ; End of pass 1: key $FFFF ends the pair list
    STA $draw_list, Y
    LDA #$0486            ; Pass 2 (bucket sort): dp$02 = next free node, carved from the OAM area at $0486 (BuildOamFromActors overwrites it later)
    STA $02
    TSC                   ; S moved to $18FF so PLX and PLA pop the pairs from $1900 upward; old S waits in dp$00 (safe only with NMI off)
    STA $00
    LDA #$18FF
    TCS 

  SortNextPair:
    PLX 
    BMI FlattenSortBuckets
    LDY $0100, X          ; Bucket head for this key: 256 words at $0100-$02FF; nodes are (slot, next) and a new node goes in front
    BNE SortPushOnChain
    LDA $02
    STA $0100, X
    TAY 
    PLA 
    STA $0000, Y
    LDA #$0000
    STA $0002, Y
    LDA $02
    CLC 
    ADC #$0004
    STA $02
    BRA SortNextPair

  SortPushOnChain:
    LDA $02
    STA $0100, X
    TAX 
    PLA 
    STA $0000, X
    TYA 
    STA $0002, X
    LDA $02
    CLC 
    ADC #$0004
    STA $02
    BRA SortNextPair

; Pass 3 of the sort: S = $00FF so PLY pops the 256 bucket heads in key order; each chain is written back to $1900 slot by slot.

  FlattenSortBuckets:
    LDA #$00FF            ; Pass 3: S = $00FF so PLY pops the 256 bucket heads in key order
    TCS 
    LDX #$0000
    BRA FlattenNextHead

; End of a chain: PHA with A = 0 overwrites the bucket head just popped, PLA restores S. This is the bucket clear, done without a store loop.

  ClearBucketHead:
    PHA                   ; A = 0 here (end of a chain): PHA overwrites the head word just popped, PLA restores S: the bucket clear without a store loop
    PLA 

  FlattenNextHead:
    PLY 
    BEQ FlattenNextHead
    BMI TerminateDrawList ; A negative word ends the scan: the $FFFF end marker at $0300 (OQ-I013-1)

  FlattenCopyChain:
    LDA $0000, Y
    STA $draw_list, X
    INX 
    INX 
    LDA $0002, Y
    BEQ ClearBucketHead
    TAY 
    BRA FlattenCopyChain

; End marker found: stores 0 as the last draw list word, restores S from dp$00 and P, returns with RTL.

  TerminateDrawList:
    STZ $draw_list, X     ; Zero ends the sorted draw list
    LDA $00
    TCS 
    PLP 
    RTL 
}

---------------------------------------------
; Fills the OAM buffer from the draw list.
; 
; When: every frame, after CullAndSortActors, before the NMI copies the buffer.
; Sees: every on-screen actor's sprites.
; Why: the NMI can only transfer a finished buffer; this builds it in priority order.
; In: $1900 list; empties tile_dma_list first.
; Out: oam_buffer low table ($0486-$0685) and high table ($0686-); unused sprites $E080 (off screen). Stops when the list ends or the buffer is full.
; Clobbers: A, X, Y; dp$00, dp$02, dp$04 (tile record pointer, starts $1A06), dp$4C, dp$4E, dp$52, dp$54; DBR and P restored; S relocated.

BuildOamFromActors {
    PHB 
    PHP 
    SEP #$20
    REP #$30
    LDA #$1A06            ; dp$04 = tile record pointer (tile_dma_list); the first record is emptied below
    STA $04
    STZ $tile_dma_list
    STZ $02
    LDA $scroll_bg1_x
    SEC 
    SBC #$0010            ; dp$52, dp$54 = scroll origin minus 16: sprites may start up to 16 pixels off screen
    STA $52
    LDA $scroll_bg1_y
    SEC 
    SBC #$0010
    STA $54
    LDA #$0686            ; dp$4C = OAM high table pointer, dp$4E = sprites left in the current byte (4, two bits each)
    STA $4C
    LDA #$0004
    STA $4E
    TSC 
    STA $00
    LDA #$0685            ; S relocated to the end of the OAM low table: the PHA loop writes $E080 words, every sprite starts off screen (Y = $E0)
    TCS 
    LDX #$0010
    LDA #$E080

; Writes $E080 (x $80, y $E0) into all 512 bytes of the low OAM table with 16 PHA per pass while S runs down from $0685: every sprite starts off screen.

  FillOamOffscreen:
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    PHA 
    DEX 
    BNE FillOamOffscreen
    LDA $00
    TCS 
    LDX #$0000
    TXY 

; Takes the next slot from the draw list (0 ends) and calls BuildActorSprites with X = slot; carry set means the OAM is full.

  BuildOamLoop:
    LDA $draw_list, X     ; Next slot of the sorted draw list; 0 ends it
    BEQ FlushOamHighBits
    INX 
    INX 
    PHX 
    TAX 
    JSR $&BuildActorSprites
    PLX 
    BCS loc_00075E
    BRA BuildOamLoop

; Draw list ended: right-aligns the bits of the last, partial high-table byte (two shifts for every sprite still missing) and stores it at dp$4C.

  FlushOamHighBits:
    SEP #$20
    LDA $00

  loc_000756:
    LSR                   ; Last, partial high-table byte: right-align the bits (two shifts per missing sprite) and store it
    LSR 
    DEC $4E
    BNE loc_000756
    STA ($4C)

  loc_00075E:
    PLP 
    PLB 
    RTL 
}

---------------------------------------------
; Emits the OAM entries of one actor from its spritemap.
; 
; When: once per listed actor per frame, from BuildOamLoop.
; Sees: the actor's current animation frame, flipped, flashing or blinking while stunned.
; Why: spritemaps are position-independent entries; this adds the screen position and the flips.
; In: X = actor, Y = OAM byte offset (multiple of 4), dp$52 and dp$54 = scroll origin minus 16, dp$4C, dp$4E, dp$04, dp$02.
; Out: one OAM entry per spritemap entry (entries clipped outside the screen get $E080); Y advanced; carry set when the OAM is full (Y = $0200). Dynamic-tile actors take BuildDynamicTileSprites. Stun counter $26: negative = palette 7 flash on alternate frames ($0E00 into dp$06), positive = not drawn on alternate frames (OQ-I023-1).
; Clobbers: A, dp$00, dp$06, dp$0C, dp$16, dp$18, dp$50, $1A02, $1A04; X and DBR restored (DBR = $24 of the actor inside).

BuildActorSprites {
    PHB 
    PHX 
    SEP #$20
    LDA $0024, X          ; DBR = the actor's data bank ($24) for the spritemap reads
    PHA 
    PLB 
    REP #$20
    LDA $0000, X
    SEC 
    SBC $0008, X
    SEC 
    SBC $52
    STA $16               ; dp$16, dp$18 = screen x and y of the spritemap origin (position - extent left or top - scroll origin)
    LDA $0002, X
    SEC 
    SBC $000A, X
    SEC 
    SBC $54
    STA $18
    LDA $001C, X          ; dp$50 = flip bits of $1C: bit 15 flips Y, bit 14 flips X
    STA $50
    STZ $06
    LDA $0016, X
    BIT #$0800
    BEQ loc_0007A6
    LDA $0026, X          ; Stun counter $26: negative = palette 7 flash on alternate frames; positive = not drawn on alternate frames (blink, OQ-I023-1)
    BMI loc_00079E
    LSR 
    BCS loc_0007A6
    BRL loc_000827

  loc_00079E:
    LSR 
    BCS loc_0007A6
    LDA #$0E00
    STA $06

  loc_0007A6:
    LDA $001A, X
    BPL loc_0007AE
    BRL BuildDynamicTileSprites

  loc_0007AE:
    LDA $0028, X
    TAX 
    LDA $0000, X
    INX 
    INX 
    STA $0C

  loc_0007B9:
    LDA $50
    ASL 
    LDA $0003, X
    BCC loc_0007C2
    XBA 

  loc_0007C2:
    AND #$00FF
    CLC 
    ADC $18
    CMP #$00F0
    BCS loc_00082A
    SBC #$0010
    STA $0487, Y
    LDA $0005, X
    EOR $50
    ORA $06
    STA $0488, Y
    LDA $50
    ASL 
    ASL 
    LDA $0001, X
    BCC loc_0007E7
    XBA 

  loc_0007E7:
    AND #$00FF
    CLC 
    ADC $16
    CMP #$0110
    BCS loc_00082A
    SBC #$000F
    SEP #$20
    STA $oam_buffer, Y
    XBA 
    LSR 
    ROR $00               ; High table bits: x bit 8 (from the position sum), then the size bit (spritemap flags bit 0); four sprites fill a byte
    LDA $0000, X
    LSR 
    ROR $00
    DEC $4E
    BNE loc_000812
    LDA $00               ; Four sprites collected: store the high-table byte and advance
    STA ($4C)
    INC $4C
    LDA #$04
    STA $4E

  loc_000812:
    REP #$20
    INY 
    INY 
    INY 
    INY 
    CPY #$0200
    BEQ loc_000827

  loc_00081D:
    TXA 
    CLC 
    ADC #$0007
    TAX 
    DEC $0C
    BNE loc_0007B9

  loc_000827:
    PLX 
    PLB 
    RTS 

  loc_00082A:
    LDA #$E080
    STA $oam_buffer, Y
    BRA loc_00081D

; Dynamic-tile variant of BuildActorSprites ($1A bit $8000): reads the tile source from $34 and $2C, increments tile_dma_pending, and for each spritemap entry appends a 3-byte record (source + tile x 32, bank) to tile_dma_list through dp$04 and gives the entry the OAM tile number dp$02 (0, 2, 4 ...). The list ends with a 0 word.

  BuildDynamicTileSprites:
    LDA $0034, X          ; Dynamic-tile sprites: $34 = tile source address, $2C = bank; each tile number picks a 32-byte block there for the NMI to copy
    STA $1A02
    LDA $002C, X
    STA $1A04
    LDA $0028, X
    TAX 
    LDA $0000, X
    INX 
    INX 
    STA $0C
    INC $tile_dma_pending

  loc_00084C:
    LDA $50
    ASL 
    LDA $0003, X
    BCC loc_000855
    XBA 

  loc_000855:
    AND #$00FF
    CLC 
    ADC $18
    CMP #$00F0
    BCC loc_000863
    BRL loc_0008EB

  loc_000863:
    SBC #$0010
    STA $0487, Y
    LDA $0005, X
    EOR $50
    ORA $06
    PHA 
    AND #$01FF
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    ADC $1A02
    STA ($04)
    INC $04
    INC $04
    LDA $1A04
    STA ($04)
    INC $04
    PLA 
    AND #$FE00
    ORA $02
    INC $02
    INC $02
    STA $0488, Y
    LDA $50
    ASL 
    ASL 
    LDA $0001, X
    BCC loc_0008A0
    XBA 

  loc_0008A0:
    AND #$00FF
    CLC 
    ADC $16
    CMP #$0110
    BCS loc_0008EB
    SBC #$000F
    SEP #$20
    STA $oam_buffer, Y
    XBA 
    LSR 
    ROR $00
    LDA $0000, X
    LSR 
    ROR $00
    DEC $4E
    BNE loc_0008CB
    LDA $00
    STA ($4C)
    INC $4C
    LDA #$04
    STA $4E

  loc_0008CB:
    REP #$20
    INY 
    INY 
    INY 
    INY 
    CPY #$0200
    BEQ loc_0008E3

  loc_0008D6:
    TXA 
    CLC 
    ADC #$0007
    TAX 
    DEC $0C
    BEQ loc_0008E3
    BRL loc_00084C

  loc_0008E3:
    LDA #$0000
    STA ($04)
    PLX 
    PLB 
    RTS 

  loc_0008EB:
    LDA #$E080
    STA $oam_buffer, Y
    BRA loc_0008D6
}

---------------------------------------------
; Loads the next animation step into the actor.
; 
; When: after an animation id change and at each step end (14 call sites: player code, COP handlers, spawn and the loader).
; Sees: the next frame of the animation, with flips applied.
; Why: one table drives duration, velocity, hit box and spritemap together.
; In: X = actor; $1E animation id, $20 step, $22 table, $24 bank, $1C flip bits.
; Out: carry clear = step loaded: $14 duration, $04 and $06 velocity (negated for flips), $28 spritemap pointer, $08-$0E extents (mirrored), $10, $12 size; $20 incremented. Carry set = end marker (see EndAnimation).
; Clobbers: A, Y; DBR restored.

SetActorAnimFrame {
    PHB 
    SEP #$20
    LDA $0024, X
    PHA 
    PLB 
    REP #$20
    LDA $001E, X          ; Animation id selects an entry of the word table at $22; the entry points to a list of 8-byte steps indexed by $20
    ASL 
    CLC 
    ADC $0022, X
    TAY 
    LDA $0020, X
    ASL 
    ASL 
    ASL 
    CLC 
    ADC $0000, Y
    TAY 
    LDA $0000, Y
    BPL loc_000919        ; Negative duration = end marker (EndAnimation: step 0, velocity 0, carry set)
    BRL EndAnimation

  loc_000919:
    STA $0014, X
    LDA $001C, X
    ROL                   ; ROL: carry = bit 15 (flip Y), sign = bit 14 (flip X); flips negate the velocity and mirror the extents
    BPL loc_00092B
    LDA #$0000
    SEC 
    SBC $0002, Y
    BRA loc_00092E

  loc_00092B:
    LDA $0002, Y

  loc_00092E:
    STA $0004, X
    LDA $001C, X
    BPL loc_00093F
    LDA #$0000
    SEC 
    SBC $0004, Y
    BRA loc_000942

  loc_00093F:
    LDA $0004, Y

  loc_000942:
    STA $0006, X
    LDA $0006, Y
    TAY 
    CLC 
    ADC #$000C
    STA $0028, X
    LDA $001C, X
    ROL 
    PHP 
    BPL loc_00096D
    LDA $0002, Y
    SEC 
    SBC $0008, Y
    STA $0008, X
    LDA $0000, Y
    CLC 
    ADC $0008, Y
    STA $000C, X
    BRA loc_000979

  loc_00096D:
    LDA $0000, Y
    STA $0008, X
    LDA $0002, Y
    STA $000C, X

  loc_000979:
    PLP 
    BCC loc_000992
    LDA $0006, Y
    CLC 
    ADC $000A, Y
    STA $000A, X
    LDA $0004, Y
    SEC 
    SBC $000A, Y
    STA $000E, X
    BRA loc_00099E

  loc_000992:
    LDA $0004, Y
    STA $000A, X
    LDA $0006, Y
    STA $000E, X

  loc_00099E:
    LDA $0008, Y
    STA $0010, X
    LDA $000A, Y
    STA $0012, X
    INC $0020, X
    CLC 
    PLB 
    RTL 

; End marker (negative duration): $20 = 0, velocity $04 and $06 = 0, carry set, DBR restored.

  EndAnimation:
    STZ $0020, X
    STZ $0004, X
    STZ $0006, X
    SEC 
    PLB 
    RTL 
}

---------------------------------------------
; Loads A = $3E of the current actor X (the next actor toward the head) and falls into RunActorList.

NextActor {
    LDA $003E, X
}

---------------------------------------------
; Runs the scripts of all actors from A to the head.
; 
; When: every frame, entered by the RTS trick of RunActors.
; Sees: each actor acts on its own timer.
; Why: handles hit stun, the sub-frame filter, wait counters and the script call in one loop.
; In: A = first actor, M = 0.
; Out: for each actor until A = 0: actor_run_count++; hit stun ($16 bit $0800): $26 counts up when negative and down when positive, the flag clears at 0, and the script is skipped while $1A bit $0040 is set; skips actors without $16 bit $0010 while subframe_active is set; $14 counts down and at 0 the script at $36:$18 runs with X = slot; then StepActorMotion. RTS into EndRunActors at the end.
; Clobbers: A, X, Y.

RunActorList {
    TAX 
    BEQ EndActorList
    INC $actor_run_count
    LDA $0016, X
    BIT #$0800
    BEQ FilterSubFrameActor
    LDA $0026, X          ; Hit stun ($16 bit $0800): $26 counts toward 0 (up when negative, down when positive); at 0 the flag clears
    BPL HitStunCountDown
    INC $0026, X
    BPL ClearHitStun
    LDA $001A, X
    BIT #$0040
    BEQ FilterSubFrameActor
    BRA NextActor

  HitStunCountDown:
    DEC $0026, X
    BEQ ClearHitStun
    LDA $001A, X
    BIT #$0040
    BEQ FilterSubFrameActor
    BRA NextActor

; Stun counter reached 0: clears $16 bit $0800.

  ClearHitStun:
    LDA $0016, X
    AND #$F7FF
    STA $0016, X

; While subframe_active is non-zero, an actor without $16 bit $0010 is skipped (go to NextActor).

  FilterSubFrameActor:
    LDA $subframe_active  ; Sub-frame filter: while subframe_active is set only actors with $16 bit $0010 run
    BEQ CountDownAndRunScript
    LDA $0016, X
    BIT #$0010
    BEQ NextActor

; Decrements the wait counter $14; while it is still 0 or above the actor goes straight to StepActorMotion. Otherwise it clears $14 and calls the script: pushes bank 0 and StepActorMotion - 1, then the script bank $36 and address $18 - 1, and RTL enters the script.

  CountDownAndRunScript:
    DEC $0014, X          ; $14 = wait counter; the script runs when it goes below 0
    BPL StepActorMotion
    STZ $0014, X
    SEP #$20
    LDA #$00
    PHA 
    PEA $&StepActorMotion-1 ; Script call by RTL: bank 0 and StepActorMotion - 1 are pushed first, then the script bank $36 and address $18 - 1
    LDA $0036, X
    PHA 
    REP #$20
    LDA $0018, X
    DEC 
    PHA 
    RTL 
}

---------------------------------------------
; Return point of every actor script: moves the actor, then goes to the next one.
; 
; When: after each script yields (RTL), and for actors that did not run this frame.
; Sees: actors slide by their velocity and stop at walls.
; Why: movement and collision happen after the script has set $04 and $06.
; In: X = actor.
; Out: when $16 bit $1000 is set, MoveActorWithTileCollision runs; always ApplyActorVelocity; then NextActor.
; Clobbers: A.

StepActorMotion {
    LDA $0016, X
    BIT #$1000
    BEQ StepApplyVelocity
    JSL $@engine_tile_collision.MoveActorWithTileCollision

  StepApplyVelocity:
    JSR $&engine_tile_collision.ApplyActorVelocity
    BRA NextActor

  EndActorList:
    RTS 
}