; COP commands that change fields of an actor: position, parameters, animation, mirroring, drawing order, palette. Commands (id, uses): 11 MoveActorToTile (32), 12 SetActorResume (10), 13 SetActorParam (0), 17 SetOwnParam (367), 1D SetActorFlags (1), 1E MaskActorFlags (1), 2F ShiftPlayerActors (12), 33 ShowPlayerActors (5), 34 HidePlayerActors (12), 80 SetAnimation (1614), 81 SetAnimationRepeat (522), 82 WaitAnimationDone (1623), 83 WaitAnimationRepeat (529), 87 / 88 ToggleFlipX / Y (45 / 4), 8F / 90 FacePlayerX / Y (3 / 2), 92 StartAnimation (21), 93 StartAnimationCount (0), 94 AnimTick (22), 95 AnimTickRepeat (0), 96-99 SetFlipX / ClearFlipX / SetFlipY / ClearFlipY (226 / 310 / 10 / 14), 9D SetAnimationClearBlocked (51), 9E WaitAnimationDoneOrJumpIfBlocked (51), 9F AddX (79), A0 AddY (39), A1 AddXY (58), A2 SetPriority (54), A3 DrawInFront (121), A4 DrawBehind (34), A5 JumpByFlipState (25), A6 / A7 ClearDrawInFront / Behind (13 / 5), A8 SetAnimationTable (37), A9 SetDynamicTileSource (1), AA SetPalette (11). Conventions shared by all handlers: cop_core block note.
; 
; === FIELDS TOUCHED ===
; Actor fields (engine_actor_scheduler_and_sprites block note): $00/$02 x/y, $16 flags, $18 resume address, $1A attribute flags, $1C OAM attribute (bit 15 flip Y, bit 14 flip X, bits 12-13 priority, bits 9-11 palette), $1E animation id, $20 animation step, $22/$24 animation table and bank, $2A repeat counter, $2C/$34 dynamic-tile bank and source, $30 free parameter word. $1A: $8000 dynamic-tile sprite, $4000 draw in front, $2000 draw behind, $0080 not drawn.
; 
; === ANIMATION COMMANDS ===
; Cop80 and its relatives store the animation id in $1E, clear the step $20 and save the address after the command as the resume pointer. Cop82 then calls SetActorAnimFrame once per run: carry clear = a step was loaded (its duration is now in $14), the actor yields and re-runs Cop82 when that wait has run out (the resume pointer points at it); carry set = the animation ended, the script goes on. Cop83 repeats the animation $2A times (set by Cop81). Cop92/Cop93/Cop94/Cop95 drive the stepper in lib_animation directly (NextFrameRecord = advance, carry set = finished, CopyFrameData = copies the record's bytes to WRAM bank $7F, a colour animation, OQ-I026-3). Cop9D and Cop9E add the tile-blocked bit: $16 bit 2 is set when the actor ran into a solid tile.
; 
; === SPRITE ATTRIBUTES ===
; CopA2 and CopAA do not translate the operand: the byte is the high byte of the attribute, with the bits already in place (priority $10-$30, palette $02-$0E). CopA3/A4/A6/A7 set and clear the draw-order bits that CullAndSortActors turns into sort keys 0 (in front) and $01FE (behind). CopA8 sets the animation table pointer $22 and bank $24 (the effects bank $0E with table $8000 is used by RunAppearPuff); CopA9 turns an actor into a dynamic-tile sprite ($1A bit $8000).
; 
; === PLAYER ACTORS ===
; The player is three actors: the player (player_actor $039C), the sword (player_weapon_actor $039E) and the soul orb (soul_orb_actor $03A0). Cop33 / Cop34 clear / set the not-drawn bit on all three and zero / increment player_hidden_count ($0464); while it is non-zero player_core clears joy_pressed. Cop2F moves the player actor and the actor linked at its $3E by a signed amount (used in ms_snow_mountain_actors and gw_lostside_marsh_actors for forced movement of 2 pixels per frame).
---------------------------------------------

?BANK 00

?INCLUDE 'cop_core'
?INCLUDE 'engine_actor_scheduler_and_sprites'
?INCLUDE 'lib_animation'

!player_x                       0374
!player_y                       0376
!player_actor                   039C
!player_weapon_actor            039E
!soul_orb_actor                 03A0
!player_hidden_count            0464

---------------------------------------------

; Puts another actor on a tile.
; 
; When: 32 scripts (cutscene setup: the Seabed Sanctuary and World of Evil scripts).
; Sees: an actor jumps to the spot.
; Why: scripts place actors by tile; the pixel conversion is TileToPixel.
; In: Byte = slot number, Byte = tile x, Byte = tile y.
; Out: other.x = tile x x 16 and other.y = tile y x 16 (placement records add 16 to y; this command does not), then ClearActorFootprint runs on that actor at its NEW position (OQ-I025-8).
; Clobbers: A, Y = other actor; X restored; dp$0C, $0E, $16, $18; dp$38.

Cop11_MoveActorToTile {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&cop_core.SlotNumberToActor
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&cop_core.TileToPixel
    STA $0000, Y
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&cop_core.TileToPixel
    STA $0002, Y
    PHX 
    TYX 
    JSR $&cop_core.ClearActorFootprint
    PLX 
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Sets the script resume address of another actor.
; 
; When: 10 scripts.
; Sees: another actor changes what it does next (a director script cues an NPC).
; Why: lets one actor redirect another without a shared flag.
; In: Byte = slot number, &Code = new resume address in that actor's script bank.
; Out: other.$18 = word; the bank $36 is not changed.
; Clobbers: A, Y = other actor; dp$38.

Cop12_SetActorResume {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&cop_core.SlotNumberToActor
    LDA [$38]
    INC $38
    INC $38
    STA $0018, Y
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Sets the parameter word $30 of another actor.
; 
; When: no script uses it (0 uses; OQ-I025-4).
; Sees: nothing.
; Why: counterpart of Cop17 for another slot.
; In: Byte = slot number, Word = value (copdef lists three Bytes).
; Out: other.$30 = word.
; Clobbers: A, Y = other actor; dp$38.

Cop13_SetActorParam {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    JSR $&cop_core.SlotNumberToActor
    LDA [$38]
    INC $38
    INC $38
    STA $0030, Y
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Stores a word in the actor's own parameter $30.
; 
; When: 367 scripts.
; Sees: nothing by itself.
; Why: $30 is the free per-actor data word, for example the track number read by MusicLoadUpload or a pointer a shared helper script reads.
; In: Word = value.
; Out: $30,X = word.
; Clobbers: A, Y; dp$38.

Cop17_SetOwnParam {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    STA $0030, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; ORs a word into the actor's flag word $16.
; 
; When: 1 script.
; Sees: depends on the bits (flags in the engine_scheduler block note).
; Why: bulk change of state bits.
; In: Word = bits to set.
; Out: $16,X |= word.
; Clobbers: A, Y; dp$38.

Cop1D_SetActorFlags {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    ORA $0016, X
    STA $0016, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; ANDs a word into the actor's flag word $16.
; 
; When: 1 script.
; Sees: depends on the bits.
; Why: bulk clear of state bits.
; In: Word = mask (bits to keep).
; Out: $16,X &= word.
; Clobbers: A, Y; dp$38.

Cop1E_MaskActorFlags {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    AND $0016, X
    STA $0016, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Shifts the player actor and the actor linked behind it by a signed amount.
; 
; When: 12 scripts, in loops of 2 pixels per frame (ms_snow_mountain_actors, gw_lostside_marsh_actors).
; Sees: the player is pushed along without pressing the pad.
; Why: forced movement acts directly on the player's position instead of on his velocity.
; In: Word = dx, Word = dy (signed).
; Out: player_actor and the actor at its $3E link (probably the sword, OQ-I025-9) get x += dx and y += dy.
; Clobbers: A, Y; dp$16, dp$18; dp$38.

Cop2F_ShiftPlayerActors {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    STA $16
    LDA [$38]
    INC $38
    INC $38
    STA $18
    LDY $player_actor
    LDA $0000, Y
    CLC 
    ADC $16
    STA $0000, Y
    LDA $0002, Y
    CLC 
    ADC $18
    STA $0002, Y
    LDA $003E, Y
    TAY 
    LDA $0000, Y
    CLC 
    ADC $16
    STA $0000, Y
    LDA $0002, Y
    CLC 
    ADC $18
    STA $0002, Y
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Makes the player, the sword and the soul orb visible again.
; 
; When: 5 scripts (the Seabed Sanctuary after Cop11, the trial room above).
; Sees: Blazer reappears after a cutscene.
; Why: the player is three actors and all three must change together.
; In: no operand.
; Out: $1A bit $0080 (not drawn) cleared on the three actors (ShowActorSprite); player_hidden_count ($0464) = 0.
; Clobbers: A, Y.

Cop33_ShowPlayerActors {
    TYX 
    LDY $player_actor
    JSR $&ShowActorSprite
    LDY $player_weapon_actor
    JSR $&ShowActorSprite
    LDY $soul_orb_actor
    JSR $&ShowActorSprite
    STZ $player_hidden_count
    BRL cop_core.CopExitContinue
}

---------------------------------------------
; Clears the not-drawn bit of one actor.
; 
; When: Cop33, once per player actor.
; In: Y = actor. Out: $1A bit $0080 cleared. Clobbers: A.

ShowActorSprite {
    LDA $001A, Y
    AND #$FF7F
    STA $001A, Y
    RTS 
}
---------------------------------------------

; Hides the player, the sword and the soul orb.
; 
; When: 12 scripts (the start of cutscenes, teleports).
; Sees: Blazer disappears.
; Why: see Cop33.
; In: no operand.
; Out: $1A bit $0080 set on the three actors (HideActorSprite); player_hidden_count ($0464) incremented; while it is non-zero player_core clears joy_pressed (OQ-I025-10).
; Clobbers: A, Y.

Cop34_HidePlayerActors {
    TYX 
    LDY $player_actor
    JSR $&HideActorSprite
    LDY $player_weapon_actor
    JSR $&HideActorSprite
    LDY $soul_orb_actor
    JSR $&HideActorSprite
    INC $player_hidden_count
    BRL cop_core.CopExitContinue
}

---------------------------------------------
; Sets the not-drawn bit of one actor.
; 
; When: Cop34, once per player actor.
; In: Y = actor. Out: $1A bit $0080 set. Clobbers: A.

HideActorSprite {
    LDA $001A, Y
    ORA #$0080
    STA $001A, Y
    RTS 
}
---------------------------------------------

; Starts an animation and continues.
; 
; When: 1614 scripts, one of the commonest commands.
; Sees: the actor plays the animation with that id from its table.
; Why: the animation id and step are fields; the stepping happens in SetActorAnimFrame (see Cop82).
; In: Byte = animation id.
; Out: $1E,X = id, $20,X = 0, $18,X = address after this command; continues.
; Clobbers: A, Y; dp$38.

Cop80_SetAnimation {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    STA $001E, X
    STZ $0020, X
    LDA $38
    STA $0018, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Starts an animation that Cop83 repeats a given number of times.
; 
; When: 522 scripts.
; Sees: a looping animation such as a pickup that blinks.
; Why: the repeat count is kept in $2A for Cop83.
; In: Byte = animation id, Byte = repeat count.
; Out: $1E,X = id, $20,X = 0, $2A,X = count, $18,X = address after this command; continues.
; Clobbers: A, Y; dp$38.

Cop81_SetAnimationRepeat {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    STA $001E, X
    STZ $0020, X
    LDA [$38]
    INC $38
    AND #$00FF
    STA $002A, X
    LDA $38
    STA $0018, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Waits until the current animation has played through.
; 
; When: 1623 scripts.
; Sees: the script advances when the animation ends.
; Why: calls SetActorAnimFrame once per run; carry clear = a step was loaded; the saved resume pointer (set by Cop80) points back at this command.
; In: no operand; X = actor.
; Out: animation ended (carry set): continues; otherwise yield; the step duration is in $14, so the next call comes that many frames + 1 later.
; Clobbers: A, Y.

Cop82_WaitAnimationDone {
    TYX 
    JSL $@engine_actor_scheduler_and_sprites.SetActorAnimFrame
    BCC Cop82Yield
    BRL cop_core.CopExitContinue

  Cop82Yield:
    BRL cop_core.CopExitYield
}
---------------------------------------------

; Waits for the animation and repeats it $2A times.
; 
; When: 529 scripts.
; Sees: an animation plays N times, then the script goes on.
; Why: each finished run decrements the counter set by Cop81 and the next call restarts the animation.
; In: no operand; $2A,X = repeat count.
; Out: counter zero: continues; otherwise yield while a step is running. The counter is decremented before it is tested, so a count of 0 would run 65536 times; no script uses a COP 81 count below 2.
; Clobbers: A, Y.

Cop83_WaitAnimationRepeat {
    TYX 

  Cop83Step:
    JSL $@engine_actor_scheduler_and_sprites.SetActorAnimFrame
    BCC Cop83Yield
    DEC $002A, X
    BNE Cop83Step
    BRL cop_core.CopExitContinue

  Cop83Yield:
    BRL cop_core.CopExitYield
}
---------------------------------------------

; Toggles the horizontal mirror bit of the sprite.
; 
; When: 45 scripts.
; Sees: the sprite turns around.
; Why: flipping is an attribute bit ($1C bit 14), not a different animation.
; In: no operand.
; Out: $1C,X bit $4000 toggled.
; Clobbers: A, Y.

Cop87_ToggleFlipX {
    TYX 
    LDA $001C, X
    EOR #$4000
    STA $001C, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Toggles the vertical mirror bit of the sprite.
; 
; When: 4 scripts.
; Sees: the sprite is turned upside down.
; Why: see Cop87.
; In: no operand.
; Out: $1C,X bit $8000 toggled.
; Clobbers: A, Y.

Cop88_ToggleFlipY {
    TYX 
    LDA $001C, X
    EOR #$8000
    STA $001C, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Turns the actor toward the player horizontally.
; 
; When: 3 scripts.
; Sees: a character faces the player.
; Why: sets the X flip from the comparison with the player's position.
; In: no operand.
; Out: player_x >= x: $1C bit $4000 set; otherwise cleared.
; Clobbers: A, Y.

Cop8F_FacePlayerX {
    TYX 
    LDA $player_x
    CMP $0000, X
    BCC loc_006036
    LDA $001C, X
    ORA #$4000
    STA $001C, X
    BRL cop_core.CopExitContinue

  loc_006036:
    LDA $001C, X
    AND #$BFFF
    STA $001C, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; The same on the vertical axis.
; 
; When: 2 scripts.
; Sees: a character is mirrored vertically depending on the player's side.
; Why: see Cop8F.
; In: no operand.
; Out: player_y >= y: $1C bit $8000 set; otherwise cleared.
; Clobbers: A, Y.

Cop90_FacePlayerY {
    TYX 
    LDA $player_y
    CMP $0002, X
    BCC loc_006057
    LDA $001C, X
    ORA #$8000
    STA $001C, X
    BRL cop_core.CopExitContinue

  loc_006057:
    LDA $001C, X
    AND #$7FFF
    STA $001C, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Starts an animation and draws its first step at once.
; 
; When: 21 scripts.
; Sees: the animation starts on the same frame.
; Why: runs the animation stepper of lib_animation (NextFrameRecord advance, CopyFrameData copy, OQ-I026-3) immediately instead of waiting for the actor loop.
; In: Byte = animation id.
; Out: $1E,X = id, $20,X = 0; NextFrameRecord and CopyFrameData run; $18,X = address after the command; yields.
; Clobbers: A, Y; dp$38.

Cop92_StartAnimation {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    STA $001E, X
    STZ $0020, X
    JSL $@lib_animation.NextFrameRecord
    JSL $@lib_animation.CopyFrameData
    BRL cop_core.CopExitSaveResume
}
---------------------------------------------

; Cop92 with a repeat count in $2A.
; 
; When: no script uses it (0 uses; OQ-I025-4).
; Sees: nothing.
; Why: counterpart of Cop81 for the immediate form.
; In: Byte = animation id, Byte = count.
; Out: as Cop92 and $2A,X = count.
; Clobbers: A, Y; dp$38.

Cop93_StartAnimationCount {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    STA $001E, X
    STZ $0020, X
    LDA [$38]
    INC $38
    AND #$00FF
    STA $002A, X
    JSL $@lib_animation.NextFrameRecord
    JSL $@lib_animation.CopyFrameData
    BRL cop_core.CopExitSaveResume
}
---------------------------------------------

; Steps an animation on a tick counter and yields.
; 
; When: 22 scripts.
; Sees: an animation advances at its own pace.
; Why: counts $26 down; the reload value comes from $0E (OQ-I025-11).
; In: no operand.
; Out: $26,X decremented; non-negative: $14,X = $0E,X; negative: NextFrameRecord (carry set = finished: continues). CopyFrameData always runs; otherwise yields.
; Clobbers: A, Y.

Cop94_AnimTick {
    TYX 
    DEC $0026, X
    BPL loc_0060C0
    JSL $@lib_animation.NextFrameRecord
    BCC loc_0060C6
    BRL cop_core.CopExitContinue

  loc_0060C0:
    LDA $000E, X
    STA $0014, X

  loc_0060C6:
    JSL $@lib_animation.CopyFrameData
    BRL cop_core.CopExitYield
}
---------------------------------------------

; Cop94 that repeats the frame advance $2A times.
; 
; When: no script uses it (0 uses; OQ-I025-4).
; Sees: nothing.
; Why: counterpart of Cop94.
; In: no operand.
; Out: as Cop94; on finishing a run $2A,X is decremented and the advance repeats until it is 0.
; Clobbers: A, Y.

Cop95_AnimTickRepeat {
    TYX 
    DEC $0026, X
    BPL loc_0060E1

  loc_0060D3:
    JSL $@lib_animation.NextFrameRecord
    BCC loc_0060E7
    DEC $002A, X
    BNE loc_0060D3
    BRL cop_core.CopExitContinue

  loc_0060E1:
    LDA $000E, X
    STA $0014, X

  loc_0060E7:
    JSL $@lib_animation.CopyFrameData
    BRL cop_core.CopExitYield
}
---------------------------------------------

; Sets the X flip bit.
; 
; When: 226 scripts.
; Sees: the sprite faces the flipped direction.
; Why: explicit form of Cop87.
; In: no operand.
; Out: $1C,X bit $4000 set.
; Clobbers: A, Y.

Cop96_SetFlipX {
    TYX 
    LDA $001C, X
    BIT #$4000
    BNE loc_0060FD
    ORA #$4000
    STA $001C, X

  loc_0060FD:
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Clears the X flip bit.
; 
; When: 310 scripts.
; Sees: the sprite faces its drawn direction.
; Why: see Cop96.
; In: no operand.
; Out: $1C,X bit $4000 cleared.
; Clobbers: A, Y.

Cop97_ClearFlipX {
    TYX 
    LDA $001C, X
    BIT #$4000
    BEQ loc_00610F
    AND #$BFFF
    STA $001C, X

  loc_00610F:
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Sets the Y flip bit.
; 
; When: 10 scripts.
; Sees: the sprite is upside down.
; Why: see Cop96.
; In: no operand.
; Out: $1C,X bit $8000 set.
; Clobbers: A, Y.

Cop98_SetFlipY {
    TYX 
    LDA $001C, X
    BIT #$8000
    BNE loc_006121
    ORA #$8000
    STA $001C, X

  loc_006121:
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Clears the Y flip bit.
; 
; When: 14 scripts.
; Sees: the sprite is upright.
; Why: see Cop96.
; In: no operand.
; Out: $1C,X bit $8000 cleared.
; Clobbers: A, Y.

Cop99_ClearFlipY {
    TYX 
    LDA $001C, X
    BIT #$8000
    BEQ loc_006133
    AND #$7FFF
    STA $001C, X

  loc_006133:
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Starts an animation and clears the actor's tile-blocked bit.
; 
; When: 51 scripts (walking NPCs and monsters).
; Sees: an actor starts a walk after being blocked.
; Why: $16 bit 2 is set when the actor ran into a solid tile; Cop9E tests it.
; In: Byte = animation id.
; Out: as Cop80 and $16,X bit $0004 cleared.
; Clobbers: A, Y; dp$38.

Cop9D_SetAnimationClearBlocked {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    STA $001E, X
    STZ $0020, X
    LDA $38
    STA $0018, X
    LDA $0016, X
    AND #$FFFB
    STA $0016, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Plays the animation until it ends, but jumps when the actor is blocked.
; 
; When: 51 scripts (walk loops).
; Sees: a walking actor turns or stops when it hits a wall.
; Why: one command does the wait and the wall test.
; In: &Code = target when blocked.
; Out: $16 bit 2 set: jump; otherwise one SetActorAnimFrame: ended: CopExitSkip2; running: yield.
; Clobbers: A, Y; dp$38.

Cop9E_WaitAnimationDoneOrJumpIfBlocked {
    TYX 
    LDA $0016, X
    BIT #$0004
    BNE loc_0061E6
    JSL $@engine_actor_scheduler_and_sprites.SetActorAnimFrame
    BCC loc_0061E3
    BRL cop_core.CopExitSkip2

  loc_0061E3:
    BRL cop_core.CopExitYield

  loc_0061E6:
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Moves the actor horizontally by a signed amount at once.
; 
; When: 79 scripts.
; Sees: the actor jumps by that many pixels.
; Why: direct position change, no velocity.
; In: Word = dx.
; Out: x += dx.
; Clobbers: A, Y; dp$38.

Cop9F_AddX {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0000, X
    STA $0000, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Moves the actor vertically by a signed amount at once.
; 
; When: 39 scripts.
; Sees: the actor jumps vertically.
; Why: see Cop9F.
; In: Word = dy.
; Out: y += dy.
; Clobbers: A, Y; dp$38.

CopA0_AddY {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0002, X
    STA $0002, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Moves the actor by a signed x and y at once.
; 
; When: 58 scripts.
; Sees: the actor jumps.
; Why: see Cop9F.
; In: Word = dx, Word = dy.
; Out: x += dx, y += dy.
; Clobbers: A, Y; dp$38.

CopA1_AddXY {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0000, X
    STA $0000, X
    LDA [$38]
    INC $38
    INC $38
    CLC 
    ADC $0002, X
    STA $0002, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Sets the OAM priority bits of the sprite.
; 
; When: 54 scripts.
; Sees: the sprite draws in front of or behind background layers.
; Why: the bits live in the high byte of the attribute word $1C.
; In: Byte = priority bits in place (bits 4-5 of the byte).
; Out: $1C,X = ($1C and $CFFF) or byte x $100.
; Clobbers: A, Y; dp$38.

CopA2_SetPriority {
    TYX 
    LDA $001C, X
    AND #$CFFF
    PHA 
    LDA [$38]
    INC $38
    AND #$00FF
    XBA 
    ORA $01, S
    STA $001C, X
    PLA 
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Marks the actor to draw in front of all others.
; 
; When: 121 scripts.
; Sees: the sprite overlaps other sprites regardless of position.
; Why: CullAndSortActors gives $1A bit $4000 the sort key 0.
; In: no operand.
; Out: $1A,X bit $4000 set.
; Clobbers: A, Y.

CopA3_DrawInFront {
    TYX 
    LDA $001A, X
    ORA #$4000
    STA $001A, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Marks the actor to draw behind all others.
; 
; When: 34 scripts.
; Sees: the sprite is overlapped by other sprites.
; Why: CullAndSortActors gives $1A bit $2000 the sort key $01FE.
; In: no operand.
; Out: $1A,X bit $2000 set.
; Clobbers: A, Y.

CopA4_DrawBehind {
    TYX 
    LDA $001A, X
    ORA #$2000
    STA $001A, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Four-way jump on the sprite's current flip bits; clears them.
; 
; When: 25 scripts (enemy AI in the Leo's Paintings and World of Evil scripts).
; Sees: a monster behaves by the way it faces.
; Why: the flip bits double as a facing state.
; In: &Code x 4 = none, flip X only, flip Y only, both.
; Out: $1C,X bits 14-15 cleared; jump to the target chosen by their old value.
; Clobbers: A, Y.

CopA5_JumpByFlipState {
    TYX 
    LDA $001C, X
    PHA 
    AND #$3FFF
    STA $001C, X
    PLA 
    LDY #$0000
    AND #$C000            ; Y = 0, 2, 4, 6 picks the target: no flip, flip X ($4000), flip Y ($8000), both
    BEQ CopA5Pick
    INY 
    INY 
    CMP #$4000
    BEQ CopA5Pick
    INY 
    INY 
    CMP #$8000
    BEQ CopA5Pick
    INY 
    INY 

  CopA5Pick:
    LDA [$38], Y
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Clears the draw-in-front bit.
; 
; When: 13 scripts.
; Sees: the sprite sorts normally again.
; Why: see CopA3.
; In: no operand.
; Out: $1A,X bit $4000 cleared.
; Clobbers: A, Y.

CopA6_ClearDrawInFront {
    TYX 
    LDA $001A, X
    AND #$BFFF
    STA $001A, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Clears the draw-behind bit.
; 
; When: 5 scripts.
; Sees: the sprite sorts normally again.
; Why: see CopA4.
; In: no operand.
; Out: $1A,X bit $2000 cleared.
; Clobbers: A, Y.

CopA7_ClearDrawBehind {
    TYX 
    LDA $001A, X
    AND #$DFFF
    STA $001A, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Selects the animation table and its bank.
; 
; When: 37 scripts (RunAppearPuff and other effect actors, with the effects bank $0E).
; Sees: the following animation ids come from that table.
; Why: effect actors take their frames from the shared effects bank instead of a meta entry.
; In: Word = table pointer, Byte = bank.
; Out: $22,X = pointer, $24,X = bank.
; Clobbers: A, Y; dp$38.

CopA8_SetAnimationTable {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    STA $0022, X
    SEP #$20
    LDA [$38]
    INC $38
    BNE loc_0062B9
    INC $39

  loc_0062B9:
    STA $0024, X
    REP #$20
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Turns the actor into a dynamic-tile sprite with the given tile source.
; 
; When: 1 script.
; Sees: the actor's tiles are copied into VRAM as it animates.
; Why: $1A bit $8000 makes BuildActorSprites take BuildDynamicTileSprites; $34 and $2C hold the source.
; In: Word = source pointer, Byte = bank.
; Out: $34,X = pointer, $2C,X = bank, $1A,X bit $8000 set.
; Clobbers: A, Y; dp$38.

CopA9_SetDynamicTileSource {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    STA $0034, X
    SEP #$20
    LDA [$38]
    INC $38
    BNE loc_0062D5
    INC $39

  loc_0062D5:
    STA $002C, X
    REP #$20
    LDA $001A, X
    ORA #$8000
    STA $001A, X
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Sets the OAM palette bits of the sprite.
; 
; When: 11 scripts.
; Sees: the sprite changes colour.
; Why: the bits live in the high byte of $1C.
; In: Byte = palette bits in place (bits 1-3 of the byte).
; Out: $1C,X = ($1C and $F1FF) or byte x $100.
; Clobbers: A, Y; dp$38.

CopAA_SetPalette {
    TYX 
    LDA $001C, X
    AND #$F1FF
    PHA 
    LDA [$38]
    INC $38
    AND #$00FF
    XBA 
    ORA $01, S
    STA $001C, X
    PLA 
    BRL cop_core.CopExitContinue
}