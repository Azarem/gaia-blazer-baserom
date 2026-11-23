; COP commands for script flow, event flags, scene changes, randomness and music loading. Commands (id, uses in extracted/ at I025): 00 Yield (0), 03 LoopStart (229), 04 LoopNext (228), 05 WaitWhileFlagEquals (70), 06 Jump (0), 07 JumpIfFlagEquals (190), 08 JumpIfFlagNotEquals (7), 09 SetOrClearFlag (213), 10 SetNextScene (65), 14 JumpIfSwitchSet (245), 1B DelayThenGoto (211), 1F StepRandom (49), 27 YieldThenGoto (81), 31 FadeAndLoadMusic (9), 32 StopAndLoadMusic (5), 35 RandomMod (9), 3B JumpIfSwitchSetElseHold (28), 3C SetTransitionType (23), 91 SetEntryHere (414). Conventions shared by all handlers: cop_core block note.
; 
; === RESUME POINTER AND WAITS ===
; An actor script runs when its wait counter $14 goes below 0 (the actor loop in engine_scheduler_sprites_combat_collision decrements it every frame). A yield (CopExitYield, or a plain RTL in the script) returns to the actor loop; the next run starts at the resume address $18,X in the bank $36,X. So a command that must repeat sets or keeps $18,X: Cop91 stores the address after itself (a script that is COP 91 ... RTL re-runs from there every frame), Cop1B stores a target plus a delay in $14 (the script runs delay + 1 frames later), Cop27 stores a target and clears $14 (next frame), Cop03/Cop04 keep a loop start in $2C and a counter in $2E (one loop per actor, no nesting; $2E is also the monsters-left counter of the lair scripts). Cop05 rewinds $38 to the COP instruction itself so the wait re-tests every frame. Two commands in a row, COP 03 (#N) and COP 04 with nothing between, are a pause of N frames.
; 
; === FLAG WORDS AND SWITCHES ===
; Event flags (cop_core.TestEventFlag, WriteEventFlag): a word with the bit number in bits 0-7, the byte index into event_flags ($1A5E) in bits 8-14 and a sense bit v in bit 15. Cop05 waits while the flag equals v, Cop07 jumps when it equals v, Cop08 when it differs from v, Cop09 writes v. Switches are a second bit array at $1ADE addressed by the lair record index (LairRecords, 32 bytes per record): Cop14 and Cop3B test them and register the calling actor in switch_owner_table; HoldActorUntilReleased (engine_003005) sets the bits.
; 
; === SCENES, RANDOM, MUSIC ===
; Cop10 writes scene_next ($0318; the main loop's loader starts when it is non-zero) and the arrival point warp_dest_*; Cop3C chooses the transition style first. Cop1F and Cop35 are the random pair (state $0302-$0311 of rng_state). Cop31 and Cop32 spawn the music-load actor (MusicLoadSendFade / MusicLoadSendStop in engine_spawn_lairs_death_drops, section MUSIC LOAD AND RESPAWN): the operand is a track number, an index into MusicPointerTable (21 long pointers); the numbers used are $00, $02, $0D, $11, $12 and $13.
---------------------------------------------

?BANK 00

?INCLUDE 'cop_core'
?INCLUDE 'data_lair_records'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'lib_bit_array'

!rng_state                      0301
!scene_next                     0318
!warp_dest_x                    037C
!warp_dest_y                    037E
!warp_dest_anim                 0380
!transition_type                03E3
!random_mod_result              0437
!lair_state                     7F0203

---------------------------------------------

; Yields without touching the resume pointer.
; 
; When: no script uses it (0 uses; OQ-I025-4).
; Sees: nothing.
; Why: spare entry of the command table; the same effect is an RTL in the script.
; In: no operand; X = actor.
; Out: leaves through CopExitYield; the actor loop runs the script again at the unchanged resume address $18,X.
; Clobbers: none (TYX only).

Cop00_Yield {
    TYX 
    BRL cop_core.CopExitYield
}
---------------------------------------------

; Starts a counted loop of the script.
; 
; When: 229 scripts, always paired with Cop04.
; Sees: a repeated action; with nothing between Cop03 and Cop04 it is a pause of about N frames (#$3D = 61 frames).
; Why: the script language has no other loop; the loop state lives in the actor itself, so an actor has one loop at a time (no nesting) and $2C/$2E are not free for the lair scripts' own counters.
; In: Byte = number of passes N; X = actor.
; Out: $2E,X = N, $2C,X and $18,X = address of the first command after this one; continues there (leaves through CopExitJump with A = $38).
; Clobbers: A, Y; dp$38 advanced.

Cop03_LoopStart {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    STA $002E, X
    LDA $38
    STA $002C, X
    STA $0018, X
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Ends one pass of the loop started by Cop03.
; 
; When: 228 scripts, after the body of a Cop03 loop.
; Sees: the body repeats; when the body yields (wait, animation) each pass lasts that long.
; Why: see Cop03.
; In: no operand; X = actor with $2C = loop start and $2E = counter.
; Out: $2E,X decremented; zero: continues after this command; non-zero: $18,X = $2C,X (the loop start) and yield, so the body runs again next frame.
; Clobbers: A, Y.

Cop04_LoopNext {
    TYX 
    DEC $002E, X
    BNE loc_005814
    BRL cop_core.CopExitContinue

  loc_005814:
    LDA $002C, X
    STA $0018, X
    BRL cop_core.CopExitYield
}
---------------------------------------------

; Waits while an event flag has the value v given in bit 15 of the flag word.
; 
; When: 70 scripts.
; Sees: a scripted actor stands still until a story flag changes (set elsewhere by Cop09).
; Why: event flags are the only state shared between actors, and this is the blocking wait on them.
; In: Word = flag word (bits 0-7 bit number, bits 8-14 byte index into $1A5E, bit 15 = v).
; Out: flag == v: dp$38 is rewound by 2 (id and opcode bytes) to the COP instruction itself, saved as the resume pointer, and the actor yields (it re-tests next frame); flag != v: skips the word and continues.
; Clobbers: A, Y, dp$00-$01 (TestEventFlag); dp$38.

Cop05_WaitWhileFlagEquals {
    TYX 
    LDA [$38]
    BMI loc_005829        ; Sense bit v (bit 15 of the flag word): clear = wait while the flag is clear, set = wait while it is set
    JSR $&cop_core.TestEventFlag
    BCC loc_00582E
    BRA loc_005835

  loc_005829:
    JSR $&cop_core.TestEventFlag
    BCC loc_005835

  loc_00582E:
    DEC $38               ; Rewind dp$38 over the id and the COP opcode: the saved resume pointer re-runs this command next frame
    DEC $38
    BRL cop_core.CopExitSaveResume

  loc_005835:
    BRL cop_core.CopExitSkip2
}
---------------------------------------------

; Unconditional jump.
; 
; When: no script uses it (0 uses; OQ-I025-4).
; Sees: nothing.
; Why: complete command set (a plain BRA/BRL in the script does the same).
; In: &Code = target.
; Out: the script continues at the target (CopExitJump).
; Clobbers: A, Y.

Cop06_Jump {
    TYX 
    LDA [$38]
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Jumps when an event flag has the value v given in bit 15 of the flag word.
; 
; When: 190 scripts, the commonest flag branch.
; Sees: NPC dialogue and behaviour depend on story progress (before/after a released NPC or an opened door).
; Why: one command for both polarities: v = 1 jumps when the flag is set, v = 0 when it is clear.
; In: Word = flag word (bit 15 = v), &Code = target.
; Out: flag == v: jump; otherwise skips the four operand bytes (CopExitSkip4). The test is in CopFlagJumpTail.
; Clobbers: A, Y, dp$00-$01; dp$38.

Cop07_JumpIfFlagEquals {
    TYX 
    LDA [$38]
    BRA CopFlagJumpTail
}

---------------------------------------------
; Jumps when an event flag differs from the value v given in bit 15 of the flag word.
; 
; When: 7 scripts.
; Sees: same as Cop07, with the opposite branch.
; Why: Cop07 with the sense bit inverted (EOR #$8000) before the shared test.
; In: Word = flag word (bit 15 = v), &Code = target.
; Out: flag != v: jump; otherwise CopExitSkip4.
; Clobbers: A, Y, dp$00-$01; dp$38.

Cop08_JumpIfFlagNotEquals {
    TYX 
    LDA [$38]
    EOR #$8000            ; Cop08 inverts the sense bit and shares the test of Cop07

; Shared tail of Cop07 and Cop08: tests the flag word in A and jumps or skips the operands.
; 
; When: Cop07 branches here, Cop08 falls in after inverting bit 15.
; In: A = flag word, dp$38 at the flag word; bit 15 set = jump when the flag is set, clear = jump when it is clear.
; Out: jump: dp$38 moves past the flag word, the &Code word is read and the script continues there (CopExitJump); no jump: CopExitSkip4.
; Clobbers: A, Y, dp$00-$01.

  CopFlagJumpTail:
    BMI loc_005852        ; Bit 15 set = jump when the flag is set; clear = jump when it is clear
    JSR $&cop_core.TestEventFlag
    BCS loc_005857
    BRA loc_00585A

  loc_005852:
    JSR $&cop_core.TestEventFlag
    BCS loc_00585A

  loc_005857:
    BRL cop_core.CopExitSkip4

  loc_00585A:
    INC $38
    INC $38
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump
}
---------------------------------------------

; Sets or clears an event flag.
; 
; When: 213 scripts.
; Sees: story progress is recorded (an NPC was talked to, a switch was pulled); Cop05, Cop07 and Cop08 in other scripts see it later.
; Why: all progress flags are in one bit array, written by this one command.
; In: Word = flag word: bit 15 set = set the flag, clear = clear it; bits 0-14 select the flag.
; Out: WriteEventFlag; continues.
; Clobbers: A, Y, dp$00-$01; dp$38.

Cop09_SetOrClearFlag {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    JSR $&cop_core.WriteEventFlag
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Requests a scene change and sets the arrival point.
; 
; When: 65 scripts (doors, stairs and the end of cutscenes; ends in RTL).
; Sees: the screen changes (style from Cop3C) and the next scene loads with the player at the given position and animation.
; Why: a scene change is just a value in scene_next; the main loop starts the loader when it is non-zero.
; In: Word = area in the low byte and scene in the high byte (#$0104 = area $04, scene $01); Byte = arrival animation; Word = arrival x; Word = arrival y.
; Out: scene_next ($0318) = scene low byte, area high byte (XBA); warp_dest_anim ($0380), warp_dest_x ($037C), warp_dest_y ($037E) = the three arrival values (SpawnPlacementList puts the player at x and y + 16).
; Clobbers: A, Y; dp$38.

Cop10_SetNextScene {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    XBA                   ; The operand word is #$SSAA (area low byte): XBA turns it into scene_next (scene low byte, area high byte)
    STA $scene_next
    LDA [$38]
    INC $38
    AND #$00FF
    STA $warp_dest_anim
    LDA [$38]
    INC $38
    INC $38
    STA $warp_dest_x
    LDA [$38]
    INC $38
    INC $38
    STA $warp_dest_y
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Registers the actor as the owner of a switch and jumps when the switch is already set.
; 
; When: 245 scripts, the first command of nearly every placed NPC or object: COP 14 (#switch, &Active) followed by RTL, so the actor polls its switch every frame.
; Sees: the NPC, chest or door becomes active (appears) once its lair is cleared or its switch is triggered; before that nothing.
; Why: bit n of the array at $1ADE is switch n, the lair record index of LairRecords; the actor keeps polling and wakes when its bit is set (HoldActorUntilReleased sets it).
; In: Word = switch number, &Code = target.
; Out: RegisterSwitchOwner (switch_owner_table[n] = actor); the bit set (lib_bit_array.TestBitInArray, Y = $1ADE, carry set = set): $16 bit $2000 cleared and jump; clear: CopExitSkip2 (the script then normally yields).
; Clobbers: A, Y; the scratch of lib_bit_array; dp$38.

Cop14_JumpIfSwitchSet {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    JSR $&cop_core.RegisterSwitchOwner
    LDY #$1ADE            ; Y = $1ADE, the switch bit array; A = switch number
    JSL $@lib_bit_array.TestBitInArray
    BCC loc_0059F1
    LDA $0016, X          ; Switch already triggered: clear $16 bit $2000 (inactive) and jump to the target
    AND #$DFFF
    STA $0016, X
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump

  loc_0059F1:
    BRL cop_core.CopExitSkip2
}
---------------------------------------------

; Waits a number of frames, then continues at another address.
; 
; When: 211 scripts (timers, state machines, loops back to a poll such as COP 1B (&Poll, #$0004)).
; Sees: a pause of delay + 1 frames.
; Why: stores the resume address and the wait counter in one command.
; In: &Code = target, Word = delay in frames.
; Out: $18,X = target, $14,X = delay (the actor loop runs the script again when $14 goes below 0); yields.
; Clobbers: A, Y; dp$38.

Cop1B_DelayThenGoto {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    STA $0018, X
    LDA [$38]
    INC $38
    INC $38
    STA $0014, X
    BRL cop_core.CopExitYield
}
---------------------------------------------

; Advances the random generator.
; 
; When: 49 scripts, before a Cop35 draw.
; Sees: nothing; the next draw differs.
; Why: the state is a 16-byte additive generator ($0302-$0311) that only moves when a script asks.
; In: no operand; X = actor (kept in Y meanwhile).
; Out: bytes $0302-$0310 each receive the next byte added with a running carry (one CLC), then $0311 is incremented as a counter with the carry running up to $0302; continues; M = 16.
; Clobbers: A (X restored from Y); dp none.

Cop1F_StepRandom {
    PHY 
    SEP #$20
    LDX #$000F
    LDA #$00
    XBA 
    CLC 

  loc_005AE0:
    LDA $rng_state+1, X   ; Additive generator: byte $0302 + X gets the next byte added; the carry runs through the whole chain
    ADC $rng_state, X
    STA $rng_state, X
    DEX 
    BNE loc_005AE0
    LDX #$0010

  loc_005AEF:
    INC $rng_state, X     ; Then $0311 is incremented as a counter, the carry running up toward $0302
    BNE loc_005AF7
    DEX 
    BNE loc_005AEF

  loc_005AF7:
    REP #$20
    PLX 
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Yields now and continues at another address next frame.
; 
; When: 81 scripts, also the step command of the music-load actor (MusicLoadSendFade and the others).
; Sees: a one-frame pause, then the target runs (a state machine step per frame).
; Why: Cop1B with a delay of 0.
; In: &Code = target.
; Out: $18,X = target, $14,X = 0; yields.
; Clobbers: A, Y; dp$38.

Cop27_YieldThenGoto {
    TYX 
    LDA [$38]
    INC $38
    INC $38
    STA $0018, X
    STZ $0014, X
    BRL cop_core.CopExitYield
}
---------------------------------------------

; Starts a music change with the full SPC handshake (fade command, stop command, upload).
; 
; When: 9 scripts: the front end (gv_front_end), village and cutscene actors with track $00, $12 and $13, and RunBossDeath with track $02 when the boss was not the last one.
; Sees: the running music stops and the numbered track starts after a short silence; the game keeps running between the handshake steps, only the upload itself blocks.
; Why: the sound CPU can only get a new song through the IPL upload, so a helper actor does the multi-frame handshake and ends itself.
; In: Byte = track number (index into MusicPointerTable, 21 entries).
; Out: a new actor before the caller (SpawnActorBefore) with $18/$36 = MusicLoadSendFade and $30 = track number; the caller continues. A full actor pool silently loses the request (Y = scratch slot $06AA).
; Clobbers: A, Y = new slot; dp$38.

Cop31_FadeAndLoadMusic {
    TYX 
    JSR $&cop_core.SpawnActorBefore
    LDA #$&engine_spawn_lairs_death_drops.MusicLoadSendFade
    STA $0018, Y
    SEP #$20
    LDA #$^engine_spawn_lairs_death_drops.MusicLoadSendFade
    STA $0036, Y
    REP #$20
    LDA [$38]
    INC $38
    AND #$00FF
    STA $0030, Y
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Starts a music change without the fade step (stop command, upload).
; 
; When: 5 scripts: tracks $00, $02, $0D and $11 (Grass Valley village, the trial room above, Death Toll's Shrine and the Magridd airship dock).
; Sees: the music stops and the numbered track starts.
; Why: same as Cop31, entering the chain at MusicLoadSendStop.
; In: Byte = track number.
; Out: new actor before the caller with $18/$36 = MusicLoadSendStop and $30 = track number.
; Clobbers: A, Y = new slot; dp$38.

Cop32_StopAndLoadMusic {
    TYX 
    JSR $&cop_core.SpawnActorBefore
    LDA #$&engine_spawn_lairs_death_drops.MusicLoadSendStop
    STA $0018, Y
    SEP #$20
    LDA #$^engine_spawn_lairs_death_drops.MusicLoadSendStop
    STA $0036, Y
    REP #$20
    LDA [$38]
    INC $38
    AND #$00FF
    STA $0030, Y
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Draws a random number below N.
; 
; When: 9 scripts, after Cop1F (operands $10, $1E, $20, $30, $40, $64, $A0).
; Sees: random timing or direction of an actor.
; Why: modulo by repeated subtraction of the byte $0302 of the generator.
; In: Byte = N (must be non-zero).
; Out: random_mod_result ($0437) = $0302 mod N.
; Clobbers: A, dp$00.

Cop35_RandomMod {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    STA $00
    LDA $rng_state+1
    AND #$00FF

  loc_005D86:
    SEC                   ; Modulo by repeated subtraction; an operand of 0 would never leave this loop
    SBC $00
    BPL loc_005D86
    CLC 
    ADC $00
    STA $random_mod_result
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Wakes a held NPC when its switch is set; otherwise keeps it waiting or sends it into the hold script.
; 
; When: 28 scripts, the first command of the villager and soul NPCs of the Mountain of Souls houses, Magridd's Castle, the Seabed Sanctuary, the Woods of Greenwood and Grass Valley, followed by COP 17 and the HoldActorUntilReleased tail.
; Sees: a shut-in NPC either stays frozen until its lair switch is set, or acts normally (OQ-I025-1).
; Why: two bits decide: the release switch of the lair record (word at +$1E of LairRecords, 0 = none) and the NPC's own switch n.
; In: Word = lair record index n (also switch number), &Code = script of the active NPC.
; Out: RegisterSwitchOwner(n). Release switch absent or set: switch n set: $16 bit $2000 cleared and jump; switch n clear: yield. Release switch not set: $34,X = n; bit $40 of lair_state[n] set: $16 bit $0010 set and CopExitSkip2 (continues into the hold code); bit clear: yield (OQ-I025-1).
; Clobbers: A, Y; the scratch of lib_bit_array; dp$38.

Cop3B_JumpIfSwitchSetElseHold {
    TYX 
    LDA [$38]
    JSR $&cop_core.RegisterSwitchOwner
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    TAY 
    LDA $&data_lair_records.LairRecords+1E, Y ; Word +$1E of the lair record = release switch number (0 = none)
    BEQ loc_005E27
    LDY #$1ADE
    JSL $@lib_bit_array.TestBitInArray ; Release switch not set (carry clear): locked path at loc_005E4B; set: the free path below
    BCC loc_005E4B

  loc_005E27:
    LDA [$38]
    INC $38
    INC $38
    LDY #$1ADE
    JSL $@lib_bit_array.TestBitInArray
    BCC loc_005E48
    LDA $0016, X
    AND #$DFFF
    STA $0016, X
    LDA [$38]
    INC $38
    INC $38
    BRL cop_core.CopExitJump

  loc_005E48:
    BRL cop_core.CopExitYield

  loc_005E4B:
    LDA [$38]             ; Locked path: $34,X = lair index; lair_state bit $40 clear = yield, set = $16 bit $0010 and continue after the command
    INC $38
    INC $38
    STA $0034, X
    PHX 
    TAX 
    LDA $lair_state, X
    PLX 
    BIT #$0040
    BEQ loc_005E48
    LDA $0016, X
    ORA #$0010
    STA $0016, X
    BRL cop_core.CopExitSkip2
}
---------------------------------------------

; Chooses the screen transition style of the next scene change.
; 
; When: 23 scripts, always just before a Cop10 (operand #$04 in all of them).
; Sees: how the screen changes when the player leaves the scene.
; Why: lib_scene_change_init reads transition_type; RunReturnLoop writes $80 for return trips.
; In: Byte = transition type.
; Out: transition_type ($03E3) = byte.
; Clobbers: A, Y; dp$38.

Cop3C_SetTransitionType {
    TYX 
    LDA [$38]
    INC $38
    AND #$00FF
    STA $transition_type
    BRL cop_core.CopExitContinue
}
---------------------------------------------

; Makes the command after this one the re-entry point of the script.
; 
; When: 414 scripts (poll loops: COP 91, the checks, RTL).
; Sees: nothing by itself; the actor repeats its checks every frame (wait for the player, a switch, a lair monster).
; Why: after a yield the actor continues at $18,X; this command sets $18,X and $36,X to the next instruction, so a body ending in RTL re-runs from here.
; In: no operand; X = actor.
; Out: $36,X = script bank ($3A), $18,X = address after the command; continues (CopExitJump).
; Clobbers: A, Y.

Cop91_SetEntryHere {
    TYX 
    SEP #$20
    LDA $3A
    STA $0036, X
    REP #$20
    LDA $38
    STA $0018, X
    BRL cop_core.CopExitJump
}