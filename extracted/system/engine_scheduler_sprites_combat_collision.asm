; Actor scheduler, draw list sort, OAM builder, animation, combat and tile collision (file offsets 1445-4782, SNES $00:85A5-$92AD, bank 00).
; 
; === ACTOR SLOTS ===
; 64 slots of $40 bytes at $0800 + $40 x n. Free slots sit on a stack at $1800-$187F (dp$4A points to it). Two links: run order is from actor_list_tail ($06A6) following $3E; the cull and sort pass goes from actor_list_head ($06A8) following $3C. A new actor is linked in as the new head.
; Fields: $00 x, $02 y (words); $04 dx, $06 dy; $08 $0A $0C $0E extent box (left, top, right, bottom distances from x, y); $10 width, $12 height; $14 wait counter; $16 flags; $18 script resume address and $36 its bank; $1A attribute flags; $1C OAM attribute (bit 15 flip Y, bit 14 flip X); $1E animation id; $20 animation step; $22 animation table pointer; $24 data bank of the animation and spritemap data; $25 HP; $26 hit-stun counter; $28 spritemap pointer; $2C and $34 dynamic-tile bank and source; $2E $2F lair state copies; $30 projectile damage ($FF always kills); $38 meta entry pointer; $3A placement record pointer; $3C $3E links.
; 
; === FLAGS ===
; $16: $8000 off screen (set by CullAndSortActors and at spawn); $4000 pickup; $2000 hidden or inactive; $1000 runs tile collision; $0800 hit stun; $0400 dying; $0080 hit source (player side) or the player; $0020 projectile; $0010 runs during sub-frames; $0004 blocked by a tile; $0002 deflects hits; $0001 no enemy gauge. Read but unexplained: $0008, $0040, $0100, $0200 (OQ-I005-14).
; $1A: $8000 dynamic-tile sprite; $4000 draw in front; $2000 draw behind; $0080 not drawn; $0040 frozen while stunned; $0100 survives lethal hits with 1 HP; $0200, $0400, $0800 immunity classes (special, metal, spirit; see COMBAT).
; 
; === SCHEDULER ===
; RunActors pushes EndRunActors - 1 and RunActorList - 1 and executes RTS: RunActorList starts with A = actor_list_tail, and when the list ends its RTS lands in EndRunActors, which restores dp$38-$3A, DBR and P and returns with RTL. RunActorList calls an actor script by pushing a bank-0 return address (StepActorMotion - 1), the script bank ($36) and $18 - 1, then RTL; the script returns with RTL into StepActorMotion with X = slot. A script runs when its wait counter $14 goes below 0. While subframe_active is set only actors with $16 bit $0010 run.
; 
; === DRAW LIST ===
; CullAndSortActors sets $16 bit $8000 for actors whose extent box misses the 256 x 224 screen and clears it for the rest, and builds the sorted draw list at $1900 (slot words, 0 ends). Key = (255 - (y - scroll_y)) x 2, so lower actors on screen sort first; key 0 for $1A bit $4000 (in front) and for actors with y - scroll_y outside 0-$FF; key $01FE for $1A bit $2000 (behind). Hidden ($16 bit $2000) and not-drawn ($1A bit $0080) actors are not listed. Bucket sort: pass 1 stores (key, slot) pairs at $1900, pass 2 pops them with S moved to $18FF into 256 linked buckets at $0100-$02FF (nodes carved from the OAM area at $0486), pass 3 pops the bucket heads with S = $00FF and writes the slots back to $1900 in key order, clearing every head with PHA/PLA (A = 0 over the popped word). The scan stops at the $FFFF end marker at $0300 (OQ-I013-1). S relocation is safe only because NMI is off in the work phase (OQ-I005-20).
; 
; === OAM ===
; BuildOamFromActors fills the OAM low table ($0486-$0685, 4 bytes per sprite: x, y, tile, attribute) and the high table ($0686-: two bits per sprite, x bit 8 and size) from the draw list through BuildActorSprites, until the list ends or all 128 sprites are used. Unused sprites are set to $E080 (off screen). A spritemap is a word entry count followed by 7-byte entries: flags (bit 0 = size bit), x offset, x offset when flipped in x, y offset, y offset when flipped in y, word tile and attribute (XOR $1C, or $0E00 while the stun flashes). Dynamic-tile actors ($1A bit $8000) copy tile blocks of 32 bytes at source + tile x 32 through tile_dma_list and use OAM tile numbers 0, 2, 4 and so on; the NMI uploads them.
; 
; === ANIMATION ===
; SetActorAnimFrame: $22 points to a word table indexed by the animation id; each entry points to a list of 8-byte steps indexed by $20: word duration (negative ends the animation), word dx, word dy, word frame pointer. A frame record has six words (left, right, top, bottom extents, width, height) followed at +12 by the spritemap. Flip bits of $1C negate dx and dy and mirror the extents.
; 
; === COMBAT ===
; DetectHitSourceCollisions pairs every listed actor with $16 bit $0080 (and none of $0D00) against every actor without $EEC0 whose box overlaps and whose sprite rectangles overlap (TestSpriteOverlap); sources with $16 bit $0020 go to ApplyProjectileHit, the others to ApplySwordHit. DetectPlayerContact tests the player's hurt box against actors without $25C0 and calls ApplyContactDamageOrPickup. The rules below are read from the code; the item names are those of the walkthrough (docs/walkthrough/items.md).
; - Equipment ids: equipped_weapon $1B5E (2 Psycho Sword, 3 Critical Sword, 5 Zantetsu Sword, 6 Spirit Sword, 7 Recovery Sword, 8 Soul Blade), equipped_armor $1B60 ($0D Mystic Armor, $0E Light Armor), equipped_magic $1B62 ($18 Phoenix), equipped_bracelet $1B64 ($35 Power, $36 Shield, $37 Super).
; - Sword damage = max(1, attack_current $1B8C - monster defence (meta entry +1)); Power and Super Bracelet double it. Monster HP is $25; a hit that does not leave HP above 0 kills (or leaves 1 HP when $1A bit $0100).
; - Immunity classes ($1A): $0400 metal is hurt only by the Zantetsu Sword, $0800 spirit only by the Spirit Sword, $0200 special only by the Soul Blade (which hurts everything). Metal deflects with sound $4C, the other two ignore the hit silently.
; - Damage to the player = max(1, monster attack - 1 - defense_current $1B8E); Shield and Super Bracelet halve it. Light Armor blocks the hit when attack x 1.5 is below $1B8E (sound $0C). Mystic Armor sets the hit stun counter to -64 instead of -32.
; - Hit stun: $26 = -8 for monsters, $FFE0 or $FFC0 for the player; while $16 bit $0800 is set the stunned player only picks things up.
; - Differences from the walkthrough are in OQ-I005-1 (Super Bracelet), -2 (Critical Sword), -3 (Psycho Sword).
; 
; === COLLISION ===
; MoveActorWithTileCollision moves x first (CollideEast or CollideWest), then y (CollideSouth or CollideNorth), each probing the tile types in the rows or columns the actor's width and height cover. GetTileType reads tile_type_map ($7F8000): index = ((y / 16) x map_width_pages + x / 16) x 256 + (y and 15) x 16 + (x and 15) for tile coordinates; a type byte with a high nibble set (Cop15_BlockOwnTiles ORs $F0) or an index of $4000 or more reads as $0F (blocked). Blocked: $00 or $02 snapped to a multiple of 16, velocity zeroed, $16 bit $0004 set. Tile type codes are in OQ-I005-8; the east and south routines have no boundary pre-check (OQ-I005-12).
; 
; === ENEMY GAUGE ===
; A hit on a monster without $16 bit $0001 sets enemy_gauge_hp ($0336) to its HP, enemy_gauge_max ($0338) to the meta entry HP (+2) and enemy_gauge_timer ($0330) to $80. The HUD update (UpdateHud) draws the gauge string EnemyGaugeText ([04:336,338]) once, counts the timer down by 2 per frame and erases the gauge when it reaches 0.
---------------------------------------------

?BANK 00

?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'lib_arithmetic'
?INCLUDE 'lib_player_stats'
?INCLUDE 'WorldMetaPointers'

!frame_counter                  0312
!enemy_gauge_timer              0330
!hud_dirty_flags                0332
!enemy_gauge_hp                 0336
!enemy_gauge_max                0338
!scroll_bg1_x                   033A
!scroll_bg1_y                   033C
!map_width_pages                0343
!boss_actor                     039A
!player_actor                   039C
!subframe_active                03A6
!tile_dma_pending               03B6
!contact_lock                   042D
!oam_buffer                     0486
!actor_list_tail                06A6
!actor_list_head                06A8
!draw_list                      1900
!tile_dma_list                  1A06
!equipped_weapon                1B5E
!equipped_armor                 1B60
!equipped_magic                 1B62
!equipped_bracelet              1B64
!gear_power                     1B70
!level_power                    1B72
!player_hp                      1B88
!player_max_hp                  1B8A
!attack_current                 1B8C
!defense_current                1B8E
!actor_run_count                1F00
!tile_type_map                  7F8000

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
    BNE loc_0005D3
    BRL FillSortBuckets

  loc_0005D3:
    LDA $0000, X
    SEC 
    SBC $0008, X
    SEC 
    SBC $scroll_bg1_x
    CMP #$0100            ; Screen test: 256 wide ($0100), 224 high ($00E0), using the extent box ($08 left, $0A top, $0C right, $0E bottom)
    BCC loc_0005F8
    BMI loc_0005E8
    BRL MarkActorOffScreen

  loc_0005E8:
    LDA $0000, X
    CLC 
    ADC $000C, X
    SEC 
    SBC $scroll_bg1_x
    CMP #$0100
    BCS MarkActorOffScreen

  loc_0005F8:
    LDA $0002, X
    SEC 
    SBC $000A, X
    SEC 
    SBC $scroll_bg1_y
    CMP #$00E0
    BCC loc_00061A
    BPL MarkActorOffScreen
    LDA $0002, X
    CLC 
    ADC $000E, X
    SEC 
    SBC $scroll_bg1_y
    CMP #$00E0
    BCS MarkActorOffScreen

  loc_00061A:
    LDA $0016, X
    BIT #$2000            ; Hidden ($16 bit $2000) or not drawn ($1A bit $0080): on screen but not put in the draw list
    BNE MarkActorOnScreen
    LDA $001A, X
    BIT #$0080
    BNE MarkActorOnScreen
    BIT #$6000
    BEQ loc_000639
    BIT #$4000            ; $1A bit $4000: key 0 (drawn in front)
    BNE loc_000645
    LDA #$01FE            ; $1A bit $2000: key $01FE (drawn behind everything)
    BRA loc_00064C

  loc_000639:
    LDA $0002, X
    SEC 
    SBC $scroll_bg1_y
    CMP #$0100
    BCC loc_000648

  loc_000645:
    LDA #$00FF            ; y - scroll_y outside 0-$FF: key 0

  loc_000648:
    EOR #$00FF            ; key = (255 - (y - scroll_y)) x 2: the lower an actor stands, the smaller the key; ascending keys, OAM index 0 is in front
    ASL 

  loc_00064C:
    CMP #$0200
    BCS loc_00064C
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

  loc_00068C:
    PLX 
    BMI FlattenSortBuckets
    LDY $0100, X          ; Bucket head for this key: 256 words at $0100-$02FF; nodes are (slot, next) and a new node goes in front
    BNE loc_0006AE
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
    BRA loc_00068C

  loc_0006AE:
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
    BRA loc_00068C

; Pass 3 of the sort: S = $00FF so PLY pops the 256 bucket heads in key order; each chain is written back to $1900 slot by slot.

  FlattenSortBuckets:
    LDA #$00FF            ; Pass 3: S = $00FF so PLY pops the 256 bucket heads in key order
    TCS 
    LDX #$0000
    BRA loc_0006D1

; End of a chain: PHA with A = 0 overwrites the bucket head just popped, PLA restores S. This is the bucket clear, done without a store loop.

  ClearBucketHead:
    PHA                   ; A = 0 here (end of a chain): PHA overwrites the head word just popped, PLA restores S: the bucket clear without a store loop
    PLA 

  loc_0006D1:
    PLY 
    BEQ loc_0006D1
    BMI TerminateDrawList ; A negative word ends the scan: the $FFFF end marker at $0300 (OQ-I013-1)

  loc_0006D6:
    LDA $0000, Y
    STA $draw_list, X
    INX 
    INX 
    LDA $0002, Y
    BEQ ClearBucketHead
    TAY 
    BRA loc_0006D6

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
    BEQ loc_000A33
    INC $actor_run_count
    LDA $0016, X
    BIT #$0800
    BEQ FilterSubFrameActor
    LDA $0026, X          ; Hit stun ($16 bit $0800): $26 counts toward 0 (up when negative, down when positive); at 0 the flag clears
    BPL loc_0009E1
    INC $0026, X
    BPL ClearHitStun
    LDA $001A, X
    BIT #$0040
    BEQ FilterSubFrameActor
    BRA NextActor

  loc_0009E1:
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
    BEQ loc_000A2E
    JSL $@MoveActorWithTileCollision

  loc_000A2E:
    JSR $&ApplyActorVelocity
    BRA NextActor

  loc_000A33:
    RTS 
}

---------------------------------------------
; Finds which hit sources (the player's sword, magic and projectiles) touch which actors this frame.
; 
; When: every frame after the sort, in the main loop only.
; Sees: monsters flash, are knocked back, lose HP and die.
; Why: the draw list gives the on-screen candidates cheaply.
; In: none; skipped when the player actor is dying ($16 bit $0400).
; Out: for every listed actor with $16 bit $0080 and none of $0D00 (source), scans the list for targets without any of $EEC0 whose box overlaps; TestSpriteOverlap confirms; sources with $16 bit $0020 call ApplyProjectileHit, others ApplySwordHit. A source can hit several targets in one frame.
; Clobbers: A, X, Y, dp$00-$06 (source box top, bottom, left, right), dp$3E (source slot); DBR and P restored.

DetectHitSourceCollisions {
    PHP 
    PHB 
    REP #$20
    LDX $player_actor
    LDA $0016, X
    BIT #$0400            ; Player dying ($16 bit $0400): no hits this frame
    BEQ loc_000A46
    BRL loc_000AEF

  loc_000A46:
    LDX #$0000

; Next source candidate from the draw list; 0 ends the scan. A source needs $16 bit $0080 and none of $0D00.

  NextHitSource:
    LDY $draw_list, X
    BNE loc_000A51
    BRL loc_000AEF

  loc_000A51:
    INX 
    INX 
    LDA $0016, Y
    BIT #$0080
    BEQ NextHitSource
    BIT #$0D00            ; Source needs $0080 (hits other actors) and none of $0D00 (hit stun, dying, bit $0100)
    BNE NextHitSource
    PHX 
    SEP #$20
    LDA $0024, Y
    PHA 
    PLB 
    REP #$20
    LDX #$0000
    STY $3E

; Loads the source's box into dp$00-$06 (top = y - $0A, bottom = y + $0E, left = x - $08, right = x + $0C) and sets the source slot in dp$3E; X restarts at the head of the list for the targets.

  LoadHitSourceBox:
    LDY $3E
    LDA $0002, Y
    SEC 
    SBC $000A, Y
    STA $00
    LDA $0002, Y
    CLC 
    ADC $000E, Y
    STA $02
    LDA $0000, Y
    SEC 
    SBC $0008, Y
    STA $04
    LDA $0000, Y
    CLC 
    ADC $000C, Y
    STA $06

; Next target from the draw list; box overlap test against dp$00-$06, then TestSpriteOverlap, then the hit routines. 0 ends the targets of this source.

  NextHitTarget:
    LDY $draw_list, X
    BEQ loc_000AEB
    INX 
    INX 
    LDA $0016, Y
    BIT #$EEC0            ; Target must have none of $EEC0 (off screen, pickup, hidden, hit stun, dying, hit source, $0200, $0040)
    BNE NextHitTarget
    LDA $0000, Y
    SEC 
    SBC $0008, Y
    CMP $06
    BCS NextHitTarget
    LDA $0000, Y
    CLC 
    ADC $000C, Y
    CMP $04
    BCC NextHitTarget
    LDA $0002, Y
    SEC 
    SBC $000A, Y
    CMP $02
    BCS NextHitTarget
    LDA $0002, Y
    CLC 
    ADC $000E, Y
    CMP $00
    BCC NextHitTarget
    JSR $&TestSpriteOverlap
    BCC LoadHitSourceBox
    PHX 
    LDX $3E
    LDA $0016, X
    BIT #$0020            ; $16 bit $0020 = projectile source; all others are sword hits
    BNE loc_000AE5
    JSR $&ApplySwordHit
    BRA loc_000AE8

  loc_000AE5:
    JSR $&ApplyProjectileHit

  loc_000AE8:
    PLX 
    BRA LoadHitSourceBox

  loc_000AEB:
    PLX 
    BRL NextHitSource

  loc_000AEF:
    PLB 
    PLP 
    RTL 
}

---------------------------------------------
; Applies the equipped sword to a hit target: damage, freeze, immunity, kill and EXP.
; 
; When: a sword-side source ($16 bit $0080, not a projectile) overlaps a target.
; Sees: the monster flashes and is knocked back, loses HP, or dies with a drop and EXP; deflected hits ring.
; Why: all sword rules live here, so every weapon differs only by id (rules in the block note).
; In: X = source, Y = target; ignored when the player animation $1E is $24 or more.
; Out: target $25 (HP), $26, $16, $1A, $18, $36, $14; HUD bits in $0332; enemy gauge words; player_hp (Recovery Sword).
; Clobbers: A, X; dp$00. Open: OQ-I005-1, -2, -3, -4.

ApplySwordHit {
    LDX $player_actor
    LDA $001E, X
    CMP #$0024            ; Sword hits count only while the player animation ($1E) is below $24
    BCC loc_000AFE
    RTS 

  loc_000AFE:
    LDA $0016, Y
    BIT #$0002            ; $16 bit $0002: this actor deflects every hit
    BEQ loc_000B09

; BRK #$4C: sound $4C (the hit is deflected) and return without damage.

  DeflectHit:
    BRK #$4C              ; BRK #n requests sound n (the BRK handler stores it in sound_request); $4C = deflected hit
    RTS 

  loc_000B09:
    LDA $equipped_weapon  ; equipped_weapon: 8 (Soul Blade) skips every immunity check
    CMP #$0008
    BEQ ApplySwordDamage
    LDA $equipped_weapon
    CMP #$0002            ; Weapon 2 (Psycho Sword): a target with an immunity class ($1A bits $0E00), except the $039A actor, is frozen for 180 frames (OQ-I005-3)
    BNE CheckImmunityClass
    CPY $boss_actor
    BEQ CheckImmunityClass
    LDA $001A, Y
    BIT #$0E00
    BEQ ApplySwordDamage
    LDA $001A, Y
    ORA #$0040
    STA $001A, Y
    LDA $0016, Y
    ORA #$0800
    STA $0016, Y
    LDA #$00B4
    STA $0026, Y

; Tests the $1A immunity classes: $0800 (spirit) needs weapon 6, $0400 (metal) needs weapon 5 and otherwise deflects, $0200 (special) ignores the hit (the Soul Blade skipped this earlier); no class goes on to ApplySwordDamage.

  CheckImmunityClass:
    LDA $001A, Y          ; Immunity classes in $1A: $0800 spirit (Spirit Sword 6 only), $0400 metal (Zantetsu Sword 5 only, others deflect), $0200 special (Soul Blade only)
    BIT #$0800
    BNE loc_000B51
    BIT #$0400
    BNE loc_000B5A
    BIT #$0200
    BEQ ApplySwordDamage
    RTS 

  loc_000B51:
    LDA $equipped_weapon
    CMP #$0006
    BEQ ApplySwordDamage
    RTS 

  loc_000B5A:
    LDA $equipped_weapon
    CMP #$0005
    BNE DeflectHit

; Damage path: weapon 3 (Critical Sword) kills when (frame_counter and $0F) = 0 except the $039A actor; otherwise damage = max(1, attack_current - monster defence), doubled for the Super or Power Bracelet, subtracted from $25; HP 0 or below goes to KillOrSpareTarget, else the target is stunned ($26 = -8, $16 bit $0800), frozen while the player swings ($20-$23), and sound $42 plays.

  ApplySwordDamage:
    LDA $equipped_weapon
    CMP #$0003            ; Weapon 3 (Critical Sword): when (frame_counter and $0F) = 0 the hit kills outright, except the $039A actor (OQ-I005-2)
    BNE loc_000B77
    CPY $boss_actor
    BEQ loc_000B77
    LDA $frame_counter
    AND #$000F
    BEQ KillOrSpareTarget

  loc_000B77:
    SEP #$20
    LDX $0038, Y
    LDA $@WorldMetaPointers+1, X
    STA $00
    LDA $attack_current   ; damage = max(1, attack_current ($1B8C) - monster defence (meta entry +1))
    SEC 
    SBC $00
    BEQ loc_000B8C
    BCS loc_000B8E

  loc_000B8C:
    LDA #$01

  loc_000B8E:
    STA $00
    LDA $equipped_bracelet ; Bracelet $1B64: $37 (Super) or $35 (Power) doubles the damage (OQ-I005-1)
    CMP #$37
    BEQ loc_000B9B
    CMP #$35
    BNE loc_000B9D

  loc_000B9B:
    ASL $00

  loc_000B9D:
    LDA $0025, Y
    SEC 
    SBC $00               ; Target HP - damage; zero or below goes to the kill path
    BCC KillOrSpareTarget
    BEQ KillOrSpareTarget

  loc_000BA7:
    STA $0025, Y
    REP #$20
    CPY $boss_actor
    BEQ loc_000BC0
    LDX $player_actor
    LDA $001E, X
    SEC 
    SBC #$0020            ; Player animation $20-$23 (sword swing): the target stays frozen ($1A bit $0040) during the stun; otherwise the bit is cleared
    CMP #$0004
    BCC loc_000BCB

  loc_000BC0:
    LDA $001A, Y
    AND #$FFBF
    STA $001A, Y
    BRA loc_000BD4

  loc_000BCB:
    LDA $001A, Y
    ORA #$0040
    STA $001A, Y

  loc_000BD4:
    LDA #$FFF8            ; Hit stun: $26 = -8 (counts up to 0) and $16 bit $0800
    STA $0026, Y
    LDA $0016, Y
    ORA #$0800
    STA $0016, Y
    BRK #$42              ; Sound $42: a hit lands
    BRA SetEnemyGauge

; Lethal hit: with $1A bit $0100 the target keeps 1 HP and takes the normal hit path, otherwise it is killed (KillTarget).

  KillOrSpareTarget:
    REP #$20
    LDA $001A, Y
    BIT #$0100            ; $1A bit $0100: survives a lethal hit with 1 HP
    SEP #$20
    BEQ KillTarget
    LDA #$01
    BRA loc_000BA7

; Kills the target: script = RunEnemyDeath (death and drops), HP 0, wait 0, $16 bit $0400 (dying); adds the meta entry EXP (+3) to the player EXP in BCD; HUD bit $0002; Recovery Sword (7) heals 1 HP (HUD bit $0004); sound $43.

  KillTarget:
    LDA #$^engine_spawn_lairs_death_drops.RunEnemyDeath ; Kill: script = RunEnemyDeath (death and drops), HP 0, wait 0, $16 bit $0400 (dying)
    STA $0036, Y
    LDA #$00
    STA $0025, Y
    REP #$20
    LDA #$&engine_spawn_lairs_death_drops.RunEnemyDeath
    STA $0018, Y
    LDA #$0000
    STA $0014, Y
    LDA $0016, Y
    ORA #$0400
    STA $0016, Y
    LDX $0038, Y
    LDA $@WorldMetaPointers+3, X ; EXP = meta entry +3, added to the player EXP in BCD by AddExp
    JSL $@lib_player_stats.AddExp
    LDA #$0002
    TSB $hud_dirty_flags
    LDA $equipped_weapon  ; Weapon 7 (Recovery Sword): +1 HP per kill (HUD HP bit)
    CMP #$0007
    BNE loc_000C42
    LDA $player_hp
    CMP $player_max_hp
    BEQ loc_000C42
    INC $player_hp
    LDA #$0004
    TSB $hud_dirty_flags

  loc_000C42:
    BRK #$43              ; Sound $43: the monster dies

; Unless $16 bit $0001: enemy_gauge_hp = target HP, enemy_gauge_max = meta entry HP (+2), enemy_gauge_timer = $80 (HUD gauge, see the block note).

  SetEnemyGauge:
    LDA $0016, Y
    BIT #$0001
    BEQ loc_000C4D
    RTS 

  loc_000C4D:
    SEP #$20
    LDA $0025, Y
    STA $enemy_gauge_hp   ; Enemy gauge for the HUD: $0336 = HP after the hit, $0338 = max HP (meta +2), $0330 = $80 starts the display timer
    LDX $0038, Y
    LDA $@WorldMetaPointers+2, X
    STA $enemy_gauge_max
    LDA #$80
    STA $enemy_gauge_timer
    REP #$20
    RTS 
}

---------------------------------------------
; Applies a projectile (magic) hit to a target.
; 
; When: a projectile source ($16 bit $0020) overlaps a target.
; Sees: the monster is hurt, stunned or killed by the spell.
; Why: projectiles carry their own damage ($30) instead of using the sword formula.
; In: X = projectile, Y = target.
; Out: damage $30 ($FF = always kills) or, with equipped_magic $18 (Phoenix), $1B70 + $1B72 - defence; immunity checks as for the sword (metal deflects, spirit and special are ignored); stun $FFF8; kill as in KillTarget (no Recovery Sword).
; Clobbers: A, X; dp$00.

ApplyProjectileHit {
    LDA $0016, Y
    BIT #$0002
    BEQ loc_000C72

; BRK #$4C: sound $4C and return without damage.

  DeflectProjectile:
    BRK #$4C
    RTS 

  loc_000C72:
    LDA $0030, X          ; Projectile damage in $30 ($FF = always kills)
    CMP #$00FF
    BEQ ApplyProjectileDamage
    LDA $equipped_magic   ; equipped_magic $18 (Phoenix): damage from the attack formula below instead of $30
    CMP #$0018
    BEQ ApplyPhoenixDamage
    CPY $boss_actor
    BEQ DeflectProjectile
    LDA $001A, Y
    BIT #$0A00
    BEQ loc_000C90
    RTS 

  loc_000C90:
    BIT #$0400
    BNE DeflectProjectile

; Damage = $30 of the projectile ($FF kills outright); subtracts it from the target HP; HP 0 or below goes to KillOrSpareProjectileTarget, otherwise StunProjectileTarget.

  ApplyProjectileDamage:
    SEP #$20
    LDA $0025, Y
    SEC 
    SBC $0030, X
    BCC KillOrSpareProjectileTarget
    BEQ KillOrSpareProjectileTarget
    BRA StunProjectileTarget

; Phoenix equipped: damage = max(1, $1B70 + $1B72 - monster defence) instead of the projectile's $30.

  ApplyPhoenixDamage:
    SEP #$20
    LDX $0038, Y
    LDA $@WorldMetaPointers+1, X
    STA $00
    LDA $gear_power
    CLC 
    ADC $level_power
    SEC 
    SBC $00
    BEQ loc_000CBD
    BCS loc_000CBF

  loc_000CBD:
    LDA #$01

  loc_000CBF:
    STA $00
    LDA $0025, Y
    SEC 
    SBC $00
    BCC KillOrSpareProjectileTarget
    BEQ KillOrSpareProjectileTarget

; Stores the HP, sets the stun ($26 = $FFF8, $16 bit $0800), clears $1A bit $0040 and plays sound $42.

  StunProjectileTarget:
    STA $0025, Y
    REP #$20
    LDA #$FFF8
    STA $0026, Y
    LDA $0016, Y
    ORA #$0800
    STA $0016, Y
    LDA $001A, Y
    AND #$FFBF
    STA $001A, Y
    BRK #$42
    BRA SetEnemyGaugeProjectile

; Lethal projectile hit: $1A bit $0100 keeps 1 HP, otherwise the target is killed as in KillTarget (script RunEnemyDeath, EXP, HUD bit $0002, sound $43).

  KillOrSpareProjectileTarget:
    REP #$20
    LDA $001A, Y
    BIT #$0100
    SEP #$20
    BEQ loc_000CFC
    LDA #$01
    BRA StunProjectileTarget

  loc_000CFC:
    SEP #$20
    LDA #$^engine_spawn_lairs_death_drops.RunEnemyDeath
    STA $0036, Y
    LDA #$00
    STA $0025, Y
    REP #$20
    LDA #$&engine_spawn_lairs_death_drops.RunEnemyDeath
    STA $0018, Y
    LDA #$0000
    STA $0014, Y
    LDA $0016, Y
    ORA #$0400
    STA $0016, Y
    LDX $0038, Y
    LDA $@WorldMetaPointers+3, X
    JSL $@lib_player_stats.AddExp
    LDA #$0002
    TSB $hud_dirty_flags
    BRK #$43

; Same as SetEnemyGauge for projectile hits.

  SetEnemyGaugeProjectile:
    LDA $0016, Y
    BIT #$0001
    BEQ loc_000D3B
    RTS 

  loc_000D3B:
    SEP #$20
    LDA $0025, Y
    STA $enemy_gauge_hp
    LDX $0038, Y
    LDA $@WorldMetaPointers+2, X
    STA $enemy_gauge_max
    LDA #$80
    STA $enemy_gauge_timer
    REP #$20
    RTS 
}

---------------------------------------------
; Exact hit test: does any spritemap rectangle of the source overlap the target's box?
; 
; When: after the coarse box test of DetectHitSourceCollisions.
; Sees: hits land where sprites touch, not where boxes touch.
; Why: boxes are coarse; spritemaps give the real shapes.
; In: Y = target, dp$3E = source, dp$00-$06 = target box.
; Out: carry set when any rectangle (size 8 or 16 by the entry flag bit 0, flips from $1C of the source) overlaps; X and Y preserved.
; Clobbers: A, dp$00-$0C.

TestSpriteOverlap {
    PHX 
    PHY 
    TYX 
    LDY $3E
    LDA $0002, X
    SEC 
    SBC $000A, X
    STA $00
    LDA $0002, X
    CLC 
    ADC $000E, X
    STA $02
    LDA $0000, X
    SEC 
    SBC $0008, X
    STA $04
    LDA $0000, X
    CLC 
    ADC $000C, X
    STA $06
    LDA $0000, Y
    SEC 
    SBC $0008, Y
    STA $08
    LDA $0002, Y
    SEC 
    SBC $000A, Y
    STA $0A
    LDX $0028, Y
    LDA $0000, X
    STA $0C
    INX 
    INX 

  loc_000D9A:
    LDA $0000, X
    LSR 
    BCC loc_000DA5
    LDA #$000F
    BRA loc_000DA8

  loc_000DA5:
    LDA #$0007

  loc_000DA8:
    PHA 
    LDA $001C, Y
    ASL 
    ASL 
    LDA $0001, X
    BCC loc_000DB4
    XBA 

  loc_000DB4:
    AND #$00FF
    CLC 
    ADC $08
    CMP $06
    BCS loc_000DE5
    CLC 
    ADC $01, S
    CMP $04
    BCC loc_000DE5
    LDA $001C, Y
    ASL 
    LDA $0003, X
    BCC loc_000DCF
    XBA 

  loc_000DCF:
    AND #$00FF
    CLC 
    ADC $0A
    CMP $02
    BCS loc_000DE5
    CLC 
    ADC $01, S
    CMP $00
    BCC loc_000DE5
    PLA 
    PLY 
    PLX 
    SEC 
    RTS 

  loc_000DE5:
    PLA 
    TXA 
    CLC 
    ADC #$0007
    TAX 
    DEC $0C
    BNE loc_000D9A
    PLY 
    PLX 
    CLC 
    RTS 
}

---------------------------------------------
; Finds actors touching the player and applies contact damage or pickups.
; 
; When: every frame after DetectHitSourceCollisions, main loop only.
; Sees: the player takes damage or picks up items and drops.
; Why: monsters hurt by touch, pickups work by touch.
; In: none; skipped while contact_lock ($042D) is non-zero or the player is dying.
; Out: hurt box x from x + 5 to x + 12, y from y - 12 to y - 4; scans the draw list for actors without any of $25C0 that overlap and calls ApplyContactDamageOrPickup until it returns carry clear; while the player is stunned ($16 bit $0800) only pickups ($16 bit $4000) are tested.
; Clobbers: A, X, Y; dp$16, dp$18, dp$1A, dp$1C; P restored.

DetectPlayerContact {
    PHP 
    REP #$30
    LDA $contact_lock     ; contact_lock non-zero: no player contact this frame
    BNE loc_000E5F
    LDY $player_actor
    LDA $0000, Y
    CLC 
    ADC #$0005
    STA $16               ; Player hurt box: dp$16, dp$1A = x + 5, x + 12; dp$18, dp$1C = y - 12, y - 4
    CLC 
    ADC #$0007
    STA $1A
    LDA $0002, Y
    SEC 
    SBC #$0004
    STA $1C
    SEC 
    SBC #$0008
    STA $18
    LDA $0016, Y
    BIT #$0400
    BNE loc_000E5F
    BIT #$0800            ; Player in hit stun: only pickups are tested (ScanContactPickups)
    BNE ScanContactPickups
    LDY #$0000

; Next actor of the draw list for the contact scan; 0 ends. Actors with $25C0 are skipped.

  NextContactCandidate:
    LDX $draw_list, Y
    BEQ loc_000E5F
    INY 
    INY 
    LDA $0016, X
    BIT #$25C0            ; Skip actors with $25C0 (hidden, dying, $0100, hit source, $0040)
    BNE NextContactCandidate
    LDA $0000, X
    CMP $1A
    BCS NextContactCandidate
    CLC 
    ADC $0010, X
    CMP $16
    BCC NextContactCandidate
    LDA $0002, X
    CMP $18
    BCC NextContactCandidate
    SEC 
    SBC $0012, X
    CMP $1C
    BCS NextContactCandidate
    JSR $&ApplyContactDamageOrPickup
    BCS NextContactCandidate ; Carry clear = damage applied, stop. Carry set (pickup, or nothing) keeps scanning

  loc_000E5F:
    PLP 
    RTL 

; Contact scan while the player is stunned: same box test, but only actors with $16 bit $4000 (pickups) count.

  ScanContactPickups:
    LDY #$0000

  loc_000E64:
    LDX $draw_list, Y
    BEQ loc_000E9B
    INY 
    INY 
    LDA $0016, X
    BIT #$25C0
    BNE loc_000E64
    BIT #$4000
    BEQ loc_000E64
    LDA $0000, X
    CMP $1A
    BCS loc_000E64
    CLC 
    ADC $0010, X
    CMP $16
    BCC loc_000E64
    LDA $0002, X
    CMP $18
    BCC loc_000E64
    SEC 
    SBC $0012, X
    CMP $1C
    BCS loc_000E64
    JSR $&ApplyContactDamageOrPickup
    BCS loc_000E64

  loc_000E9B:
    PLP 
    RTL 
}

---------------------------------------------
; A touching actor either gives its pickup or hurts the player.
; 
; When: DetectPlayerContact finds an overlapping actor.
; Sees: items and drops are collected, or the player loses HP, flashes and is briefly invulnerable.
; Why: all contact rules and armor effects are in one place (rules in the block note).
; In: X = touching actor.
; Out: pickups ($16 bit $4000): ApplyGemPickup, carry set so the scan goes on. Otherwise damage = max(1, attack - 1 - $1B8E), halved with the Shield or Super Bracelet; Light Armor may block (sound $0C); player_hp reduced (floor 0), HUD bit $0004, player $26 = $FFC0 (Mystic Armor) or $FFE0, sound $04, stun flag. Carry clear.
; Clobbers: A, X, Y.

ApplyContactDamageOrPickup {
    LDA $0016, X
    BIT #$4000            ; Pickup actor ($16 bit $4000): handled by ApplyGemPickup, carry set
    BNE loc_000F22
    LDA $equipped_armor   ; equipped_armor: $0E (Light Armor) blocks the hit when monster attack x 1.5 is below defense_current (sound $0C)
    CMP #$000E
    BNE loc_000EC3
    SEP #$20
    LDY $0038, X
    LDA $&WorldMetaPointers, Y
    LSR 
    CLC 
    ADC $&WorldMetaPointers, Y
    CMP $defense_current
    BCS loc_000EC3
    BRK #$0C
    BRA loc_000F20

  loc_000EC3:
    SEP #$20
    LDY $0038, X
    LDA $&WorldMetaPointers, Y
    DEC                   ; damage = attack (meta entry +0) - 1 - defense_current ($1B8E), at least 0 here
    SEC 
    SBC $defense_current
    BCS loc_000ED4
    LDA #$00

  loc_000ED4:
    STA $00
    LDA $equipped_bracelet ; Bracelet $1B64: $37 (Super) or $36 (Shield) halves the damage
    CMP #$37
    BEQ loc_000EE1
    CMP #$36
    BNE loc_000EE3

  loc_000EE1:
    LSR $00

  loc_000EE3:
    LDA $00
    BNE loc_000EE8        ; Minimum damage 1
    INC 

  loc_000EE8:
    PHA 
    LDA $player_hp
    SEC 
    SBC $01, S
    BPL loc_000EF3
    LDA #$00

  loc_000EF3:
    STA $player_hp
    PLA 
    REP #$20
    LDA #$0004
    TSB $hud_dirty_flags
    LDX $player_actor
    LDA $equipped_armor
    CMP #$000D            ; Mystic Armor ($1B60 = $0D): stun counter -64 instead of -32 (longer invulnerability)
    BNE loc_000F0F
    LDA #$FFC0
    BRA loc_000F12

  loc_000F0F:
    LDA #$FFE0

  loc_000F12:
    STA $0026, X
    BRK #$04              ; Sound $04: the player is hurt
    LDA $0016, X
    ORA #$0800
    STA $0016, X

  loc_000F20:
    CLC 
    RTS 

  loc_000F22:
    JSL $@engine_spawn_lairs_death_drops.ApplyGemPickup
    SEC 
    RTS 
}

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