; COP commands that jump on a condition about actors, the player and the screen. Commands (id, uses): 0C JumpIfActorInBox (94), 0D JumpIfActorAtTile (76), 1C JumpIfActorFlags (6), 20 JumpIfPlayerOffGrid (3), 2E JumpIfActorInBoxWord (3), 89 / 8A JumpIfPlayerWithinX / Y (0 / 0), 8B / 8C JumpIfPlayerBeyondX / Y (0 / 0), 8D JumpIfOnScreen (0), 8E JumpIfOffScreen (0), 9A / 9B JumpByPlayerDeltaX / Y (175 / 174), 9C JumpByPlayerAxis (28), AD WaitUntilOnScreen (80). The other conditional jumps are in cop_script_flow_flags (flags, switches), cop_items_stats_text (items, Gems), cop_actor_fields_animation (Cop9E, CopA5) and cop_tiles_spawn_kill (tiles, Cop30).
; 
; === CONVENTIONS ===
; A jump command reads the &Code word at the script pointer and leaves through CopExitJump; a failed test leaves through the CopExitSkipN that matches the unread operand bytes (the position and slot operands are consumed first). Actor positions are x (left) and y (bottom edge) in pixels at $00/$02 of the actor; a box is the actor's width $10 and height $12. A tile operand is multiplied by 16 (TileToPixel); because y is the bottom edge, an actor standing on tile row n has y = (n + 1) x 16. Other actors are named by slot number 0-63 (SlotNumberToActor: $0800 + number x $40). player_x and player_y ($0374/$0376) are the player's position.
; 
; === BOX TESTS ===
; Cop0C and Cop2E (CopActorBoxTest) test whether the other actor's position lies inside the caller's box widened by a margin m: x in [x - m, x + m + width - 16] and y in [y - m - height + 16, y + m]. Cop0C takes m in tiles, Cop2E in pixels. Lair proximity scripts (RunLairProximity) use Cop0C; Cop0D tests for exactly one tile.
; 
; === THREE-WAY BRANCHES ===
; Cop9A and Cop9B take a threshold T and three targets: player left of (above) the actor by more than T, within the band, right of (below) it by T or more. Cop9C compares the X and Y distances to the player. They steer NPCs and enemies toward or away from the player; the usual follow-up is a facing or animation command.
; 
; === UNUSED AND SUSPICIOUS ===
; Cop89-Cop8E have no uses (OQ-I025-4). On the not-taken path Cop8D and Cop8E leave through CopExitContinue without skipping the &Code operand, so the script would run the target word as code (OQ-I001-1); harmless while unused. CopAD stops waiting once the actor is on screen or outside the map (it compares the actor position with map_width_px / map_height_px).
---------------------------------------------

?BANK 00

?INCLUDE 'cop_core'

!map_width_px                   0342
!map_height_px                  0344
!player_x                       0374
!player_y                       0376

---------------------------------------------

; Jumps when another actor's position is inside this actor's box widened by a margin in tiles.
; 
; When: 94 scripts (the player-near tests of NPCs, triggers and RunLairProximity).
; Sees: an NPC or trap reacts when the player (or another actor) steps near.
; Why: position tests are done in script data so each actor picks its own range.
; In: Byte = slot number of the other actor, Byte = margin in tiles, &Code = target.
; Out: other.x in [x - m, x + m + width - 16] and other.y in [y - m - height + 16, y + m] (m in pixels): jump; otherwise CopExitSkip2.
; Clobbers: A, Y = other actor; dp$00 (margin), dp$16, dp$18; dp$38.

Cop0C_JumpIfActorInBox {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&cop_core.SlotNumberToActor
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&cop_core.TileToPixel
    STA $00

; Box test shared by Cop0C and Cop2E.
; 
; When: Cop0C falls in after converting its margin; Cop2E branches here (BRL).
; In: dp$00 = margin in pixels, X = caller, Y = other actor, dp$38 at the &Code word.
; Out: inside: the &Code word is the target (CopExitJump); outside: CopExitSkip2.
; Clobbers: A, dp$16, dp$18.

  CopActorBoxTest:
    LDA $0000, X          ; Box test: other.x - (x - m) must be below 2m + width - 15; the Y test below mirrors it from the bottom edge
    SEC 
    SBC $00
    STA $16
    LDA $00
    ASL 
    CLC 
    ADC $0010, X
    SEC 
    SBC #$000F
    STA $18
    LDA $0000, Y
    SEC 
    SBC $16
    CMP $18
    BCC loc_0058E2
    BRL cop_core.CopExitSkip2

  loc_0058E2:
    LDA $0002, X
    CLC 
    ADC $00
    STA $16
    LDA $00
    ASL 
    CLC 
    ADC $0012, X
    SEC 
    SBC #$000F
    STA $18
    LDA $16
    SEC 
    SBC $0002, Y
    CMP $18
    BCC loc_005904
    BRL cop_core.CopExitSkip2

  loc_005904:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Jumps when another actor stands exactly on a tile.
; 
; When: 76 scripts (cutscenes that wait until an actor has walked to its mark).
; Sees: the scene goes on when the actor arrives.
; Why: the exact equality makes a script step wait for a precise position.
; In: Byte = slot number, Byte = tile x, Byte = tile y, &Code = target.
; Out: other.x == tile x x 16 and other.y == (tile y + 1) x 16: jump; x differs: CopExitSkip3; y differs: CopExitSkip2.
; Clobbers: A, Y = other actor; dp$38.

Cop0D_JumpIfActorAtTile {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&cop_core.SlotNumberToActor
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&cop_core.TileToPixel
    CMP $0000, Y
    BEQ loc_00592A
    BRL cop_core.CopExitSkip3

  loc_00592A:
    LDA [$38]
    INC $38
    AND #$00FF
    INC                   ; Tile y + 1: an actor's y is its bottom edge, so a standing actor has y = (tile row + 1) x 16
    JSR $&cop_core.TileToPixel
    CMP $0002, Y
    BEQ loc_00593D
    BRL cop_core.CopExitSkip2

  loc_00593D:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Jumps when any of the given bits is set in the actor's own flag word $16.
; 
; When: 6 scripts.
; Sees: an actor reacts to its own status (flags in the engine_scheduler block note).
; Why: reads $16 directly instead of a dedicated command per bit.
; In: Word = mask, &Code = target.
; Out: $16 and mask non-zero: jump; otherwise CopExitSkip2.
; Clobbers: A, Y; dp$38.

Cop1C_JumpIfActorFlags {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    AND $0016, X
    BNE loc_005AAD
    BRL cop_core.CopExitSkip2

  loc_005AAD:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Jumps while the player is between tile positions.
; 
; When: 3 scripts (Grass Valley NPCs, before Cop9A).
; Sees: an NPC waits for the player to finish a step.
; Why: movement is tile based; the low 4 bits of x or y tell a step is under way.
; In: &Code = target.
; Out: (player_x or player_y) and $0F non-zero: jump; otherwise CopExitSkip2.
; Clobbers: A, Y; dp$38.

Cop20_JumpIfPlayerOffGrid {
    TYX 
    LDA $player_x
    ORA $player_y
    AND #$000F
    BEQ loc_005B12
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump

  loc_005B12:
    BRL cop_core.CopExitSkip2
}
---------------------------------------------

; Cop0C with the margin in pixels.
; 
; When: 3 scripts.
; Sees: same as Cop0C.
; Why: a finer margin than whole tiles.
; In: Byte = slot number, Word = margin in pixels, &Code = target.
; Out: continues in CopActorBoxTest.
; Clobbers: as Cop0C.

Cop2E_JumpIfActorInBoxWord {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&cop_core.SlotNumberToActor
    LDA [$38]
    INC $38
    INC $38
    STA $00
    BRL CopActorBoxTest
}
---------------------------------------------

; Jumps when the player is at most N pixels away horizontally.
; 
; When: no script uses it (0 uses; OQ-I025-4).
; Sees: nothing.
; Why: Cop8A/8B/8C are the same test on the other axis and sense.
; In: Word = N, &Code = target.
; Out: |player_x - x| <= N: jump; otherwise CopExitSkip2.
; Clobbers: A, Y; dp$00; dp$38.

Cop89_JumpIfPlayerWithinX {
    TYX 
    LDA $player_x
    SEC 
    SBC $0000, X
    BPL loc_005F6D
    EOR #$FFFF
    INC 

  loc_005F6D:
    STA $00
    LDA [$38]
    INC $38
    INC $38
    CMP $00
    BCS loc_005F7C
    BRL cop_core.CopExitSkip2

  loc_005F7C:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Jumps when the player is at most N pixels away vertically.
; 
; When: no script uses it (0 uses; OQ-I025-4).
; Sees: nothing.
; Why: see Cop89.
; In: Word = N, &Code = target.
; Out: |player_y - y| <= N: jump; otherwise CopExitSkip2.
; Clobbers: A, Y; dp$00; dp$38.

Cop8A_JumpIfPlayerWithinY {
    TYX 
    LDA $player_y
    SEC 
    SBC $0002, X
    BPL loc_005F93
    EOR #$FFFF
    INC 

  loc_005F93:
    STA $00
    LDA [$38]
    INC $38
    INC $38
    CMP $00
    BCS loc_005FA2
    BRL cop_core.CopExitSkip2

  loc_005FA2:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Jumps when the player is more than N pixels away horizontally.
; 
; When: no script uses it (0 uses; OQ-I025-4).
; Sees: nothing.
; Why: see Cop89.
; In: Word = N, &Code = target.
; Out: |player_x - x| > N: jump; otherwise CopExitSkip2.
; Clobbers: A, Y; dp$00; dp$38.

Cop8B_JumpIfPlayerBeyondX {
    TYX 
    LDA $player_x
    SEC 
    SBC $0000, X
    BPL loc_005FB9
    EOR #$FFFF
    INC 

  loc_005FB9:
    STA $00
    LDA [$38]
    INC $38
    INC $38
    CMP $00
    BCC loc_005FC8
    BRL cop_core.CopExitSkip2

  loc_005FC8:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Jumps when the player is more than N pixels away vertically.
; 
; When: no script uses it (0 uses; OQ-I025-4).
; Sees: nothing.
; Why: see Cop89.
; In: Word = N, &Code = target.
; Out: |player_y - y| > N: jump; otherwise CopExitSkip2.
; Clobbers: A, Y; dp$00; dp$38.

Cop8C_JumpIfPlayerBeyondY {
    TYX 
    LDA $player_y
    SEC 
    SBC $0002, X
    BPL loc_005FDF
    EOR #$FFFF
    INC 

  loc_005FDF:
    STA $00
    LDA [$38]
    INC $38
    INC $38
    CMP $00
    BCC loc_005FEE
    BRL cop_core.CopExitSkip2

  loc_005FEE:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Jumps when the actor is on screen ($16 bit 15 clear).
; 
; When: no script uses it (0 uses; OQ-I025-4).
; Sees: nothing.
; Why: counterpart of Cop8E.
; In: &Code = target.
; Out: on screen: jump. Off screen: leaves through CopExitContinue WITHOUT skipping the &Code word (latent fault, OQ-I001-1).
; Clobbers: A, Y.

Cop8D_JumpIfOnScreen {
    TYX 
    LDA $0016, X
    BIT #$8000
    BEQ loc_006003
    BRL cop_core.CopExitContinue

  loc_006003:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Jumps when the actor is off screen ($16 bit 15 set).
; 
; When: no script uses it (0 uses; OQ-I025-4).
; Sees: nothing.
; Why: counterpart of Cop8D.
; In: &Code = target.
; Out: off screen: jump. On screen: CopExitContinue without skipping the &Code word (latent fault, OQ-I001-1).
; Clobbers: A, Y.

Cop8E_JumpIfOffScreen {
    TYX 
    LDA $0016, X
    BIT #$8000
    BNE loc_006018
    BRL cop_core.CopExitContinue

  loc_006018:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Three-way jump on the player's horizontal position relative to the actor.
; 
; When: 175 scripts (NPCs and enemies that turn or walk toward the player).
; Sees: a character reacts to the side the player is on.
; Why: one command replaces two comparisons; the targets usually set the facing.
; In: Word = threshold T, &Code = left, &Code = within, &Code = right.
; Out: d = player_x - x. Left target when the player is left by more than T (|d| > T), right target when d >= T, otherwise (also d = 0) the middle target; the jump is always taken.
; Clobbers: A, Y.

Cop9A_JumpByPlayerDeltaX {
    TYX 
    LDY #$0004
    LDA $player_x
    SEC 
    SBC $0000, X
    BEQ loc_006158
    BPL loc_006151
    EOR #$FFFF            ; EOR without INC gives |d| - 1: the left band is one pixel wider than the right (left |d| > T, right d >= T)
    CMP [$38]
    BCC loc_006158
    LDY #$0002
    BRA loc_006158

  loc_006151:
    CMP [$38]
    BCC loc_006158
    LDY #$0006

  loc_006158:
    LDA [$38], Y
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Three-way jump on the player's vertical position relative to the actor.
; 
; When: 174 scripts.
; Sees: a character reacts to whether the player is above or below.
; Why: see Cop9A.
; In: Word = threshold T, &Code = above, &Code = within, &Code = below.
; Out: d = player_y - y: above by more than T: first target; below by T or more: third; otherwise the second.
; Clobbers: A, Y.

Cop9B_JumpByPlayerDeltaY {
    TYX 
    LDY #$0004
    LDA $player_y
    SEC 
    SBC $0002, X
    BEQ loc_00617F
    BPL loc_006178
    EOR #$FFFF
    CMP [$38]
    BCC loc_00617F
    LDY #$0002
    BRA loc_00617F

  loc_006178:
    CMP [$38]
    BCC loc_00617F
    LDY #$0006

  loc_00617F:
    LDA [$38], Y
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Two-way jump on whether the player is further away horizontally or vertically.
; 
; When: 28 scripts (enemy AI).
; Sees: an enemy chooses to approach along the longer axis first.
; Why: compares |player_x - x| with |player_y - y| without a subtraction in the script.
; In: &Code = first target, &Code = second target.
; Out: |dy| < |dx|: first target; otherwise second (always jumps).
; Clobbers: A, Y.

Cop9C_JumpByPlayerAxis {
    TYX 
    LDY #$0000
    LDA $player_x
    SEC 
    SBC $0000, X
    BPL loc_006195
    EOR #$FFFF
    INC 

  loc_006195:
    PHA 
    LDA $player_y
    SEC 
    SBC $0002, X
    BPL loc_0061A3
    EOR #$FFFF
    INC 

  loc_0061A3:
    CMP $01, S
    BCC loc_0061AC
    LDY #$0002
    BRA loc_0061AC

  loc_0061AC:
    PLA 
    LDA [$38], Y
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Waits while the actor is off screen but inside the map.
; 
; When: 80 scripts (the first command of many enemy scripts).
; Sees: an enemy stays idle until it scrolls into view.
; Why: off-screen actors would waste frames; CullAndSortActors sets $16 bit $8000 for them.
; In: Byte = frames to wait before testing again.
; Out: off screen ($16 bit 15 set) and x < map_width_px and y < map_height_px: $18,X = this command, $14,X = byte, yield; otherwise CopExitSkip1 and the script goes on.
; Clobbers: A, Y; dp$38.

CopAD_WaitUntilOnScreen {
    TYX 
    LDA $0016, X
    BIT #$8000            ; $16 bit 15 = off screen: only an off-screen actor inside the map waits; otherwise the command is skipped
    BNE loc_00637F
    BRL cop_core.CopExitSkip1

  loc_00637F:
    LDA $0000, X
    CMP $map_width_px
    BCC loc_00638A
    BRL cop_core.CopExitSkip1

  loc_00638A:
    LDA $0002, X
    CMP $map_height_px
    BCC loc_006395
    BRL cop_core.CopExitSkip1

  loc_006395:
    LDA $38               ; dp$38 - 2 = this COP instruction: the saved resume pointer repeats it after the delay
    DEC 
    DEC 
    STA $0018, X
    LDA [$38]
    INC $38
    AND #$00FF
    STA $0014, X
    BRL cop_core.CopExitYield
}