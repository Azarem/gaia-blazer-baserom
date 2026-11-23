; COP and BRK dispatchers and the COP command tables (from file offset 22012, SNES $00:D5FC, bank 00).
; 
; === BRK (HandleBrk) ===
; BRK #n is the sound request. HandleBrk reads the signature byte n after the BRK (return address minus 1, long pointer in DP $3B-$3D). When bit 6 ($40) of n is set, n and $BF is stored in $0399 (the high byte of the sound word); otherwise n is stored in $0398 (sound_request, the low byte). HandleVBlank writes the word to APUIO2 on even frames and clears it (engine_vblank_nmi, section SOUND). A is preserved; DP $3B-$3D are clobbered. What the two bytes mean to the sound driver is OQ-I024-1. us/config.json lists HandleBrk and HandleCop as the native BRK and COP vectors (nativeBrk, nativeCop).
; 
; === COP (HandleCop) ===
; The COP instruction runs actor scripts. HandleCop takes the actor slot from X (TXY), builds the script pointer in DP $38/$3A from the pushed return address (bank byte from $04,S, address $02,S minus 1, so the pointer starts on the COP signature byte), reads the command id, advances $38 and jumps through the word table at CopHandlerTable_00_3C indexed by id*2.
; 
; The table has three extracted parts: CopHandlerTable_00_3C (ids 00-3C), CopFillerTable_3D_7F (ids 3D-7F, filler words, no handlers) and CopHandlerTable_80_B2 (ids 80-B2). The ids 0E, 0F, 2C and 2D have no handler (#$0000).
; 
; Each handler is a Cop<ID>_<Name> label in extracted/cop_handlers; it ends by jumping into the exit chain in cop_core. Reference: docs/cop/index.md.
---------------------------------------------

?BANK 00

?INCLUDE 'cop_actor_fields_animation'
?INCLUDE 'cop_conditions'
?INCLUDE 'cop_core'
?INCLUDE 'cop_items_stats_text'
?INCLUDE 'cop_script_flow_flags'
?INCLUDE 'cop_tiles_spawn_kill'

!sound_request                  0398

---------------------------------------------

; Native-mode BRK vector: the sound request.
; 
; When: every BRK #n in the game (about a hundred call sites: sword swings, spawns, pickups, deaths, scripts).
; Sees: nothing itself; the sound driver plays the request one or two frames later.
; Why: a two-byte instruction is the cheapest way for scripts and engine code to ask for a sound.
; In: stack = return address of the BRK (the byte after the BRK opcode is n).
; Out: bit 6 of n clear: sound_request ($0398) = n; bit 6 set: $0399 = n and $BF. The previous value of the byte is overwritten, so two requests in one frame lose the first.
; Clobbers: DP $3B-$3D; A and P restored (PHA/PLA, RTI).

HandleBrk {
    REP #$20
    PHA 
    LDA $04, S
    DEC 
    STA $3B
    SEP #$20
    LDA $06, S
    STA $3D
    LDA [$3B]
    BIT #$40              ; Bit 6 of the BRK signature byte: set = n and $BF goes to the high byte $0399 of the sound word, clear = n goes to sound_request ($0398)
    BNE loc_005615
    STA $sound_request
    BRA loc_00561A

  loc_005615:
    AND #$BF
    STA $0399

  loc_00561A:
    REP #$20
    PLA 
    RTI 
}
---------------------------------------------

; Native-mode COP vector: the command dispatcher of every actor script.
; 
; When: every COP instruction in an actor script (thousands of call sites).
; Sees: nothing itself; each command moves, animates, tests or spawns something.
; Why: one 2-byte opcode plus a table lets scripts stay short; operand bytes follow the id and are read by the handler through $38.
; In: X = actor slot (copied to Y), stack = return address of the COP instruction.
; Out: $3A = script bank, $38 = pointer past the command id, Y = actor slot, X = id * 2; jumps through CopHandlerTable_00_3C,X. Every handler starts with TYX to get the actor slot back.
; Clobbers: A, X; DP $38-$3A.

HandleCop {
    SEP #$20
    TXY 
    LDA $04, S
    STA $3A
    REP #$20
    LDA $02, S
    DEC                   ; Return address - 1 = the byte after COP, the command id; DP $38/$3A become the script read pointer
    STA $38
    LDA [$38]
    INC $38
    AND #$00FF
    ASL 
    TAX 
    JMP ($&CopHandlerTable_00_3C, X) ; Handlers are words indexed by id * 2; ids 3D-7F are filler words so CopHandlerTable_80_B2 starts $100 bytes after CopHandlerTable_00_3C
}
---------------------------------------------

; Handler words for command ids 00-3C, indexed id*2. Ids 0E, 0F, 2C and 2D are #$0000 (undefined).

CopHandlerTable_00_3C [
  &cop_script_flow_flags.Cop00_Yield   ;00
  &cop_items_stats_text.Cop01_ShowText   ;01
  &cop_items_stats_text.Cop02_PromptYesNo   ;02
  &cop_script_flow_flags.Cop03_LoopStart   ;03
  &cop_script_flow_flags.Cop04_LoopNext   ;04
  &cop_script_flow_flags.Cop05_WaitWhileFlagEquals   ;05
  &cop_script_flow_flags.Cop06_Jump   ;06
  &cop_script_flow_flags.Cop07_JumpIfFlagEquals   ;07
  &cop_script_flow_flags.Cop08_JumpIfFlagNotEquals   ;08
  &cop_script_flow_flags.Cop09_SetOrClearFlag   ;09
  &cop_items_stats_text.Cop0A_GiveItemIfNotOwned   ;0A
  &cop_items_stats_text.Cop0B_RemoveItem   ;0B
  &cop_conditions.Cop0C_JumpIfActorInBox   ;0C
  &cop_conditions.Cop0D_JumpIfActorAtTile   ;0D
  #$0000   ;0E
  #$0000   ;0F
  &cop_script_flow_flags.Cop10_SetNextScene   ;10
  &cop_actor_fields_animation.Cop11_MoveActorToTile   ;11
  &cop_actor_fields_animation.Cop12_SetActorResume   ;12
  &cop_actor_fields_animation.Cop13_SetActorParam   ;13
  &cop_script_flow_flags.Cop14_JumpIfSwitchSet   ;14
  &cop_tiles_spawn_kill.Cop15_BlockOwnTiles   ;15
  &cop_tiles_spawn_kill.Cop16_UnblockOwnTiles   ;16
  &cop_actor_fields_animation.Cop17_SetOwnParam   ;17
  &cop_items_stats_text.Cop18_JumpIfItemMissing   ;18
  &cop_items_stats_text.Cop19_JumpUnlessItemEquipped   ;19
  &cop_items_stats_text.Cop1A_ChoiceMenu   ;1A
  &cop_script_flow_flags.Cop1B_DelayThenGoto   ;1B
  &cop_conditions.Cop1C_JumpIfActorFlags   ;1C
  &cop_actor_fields_animation.Cop1D_SetActorFlags   ;1D
  &cop_actor_fields_animation.Cop1E_MaskActorFlags   ;1E
  &cop_script_flow_flags.Cop1F_StepRandom   ;1F
  &cop_conditions.Cop20_JumpIfPlayerOffGrid   ;20
  &cop_tiles_spawn_kill.Cop21_JumpIfTileAbove   ;21
  &cop_tiles_spawn_kill.Cop22_JumpIfTileBelow   ;22
  &cop_tiles_spawn_kill.Cop23_JumpIfTileLeft   ;23
  &cop_tiles_spawn_kill.Cop24_JumpIfTileRight   ;24
  &cop_items_stats_text.Cop25_AddGems   ;25
  &cop_items_stats_text.Cop26_PayGemsOrJump   ;26
  &cop_script_flow_flags.Cop27_YieldThenGoto   ;27
  &cop_tiles_spawn_kill.Cop28_JumpIfTileHere   ;28
  &cop_tiles_spawn_kill.Cop29_JumpIfTileIdDiffers   ;29
  &cop_tiles_spawn_kill.Cop2A_BlockTileAt   ;2A
  &cop_tiles_spawn_kill.Cop2B_UnblockTileAt   ;2B
  #$0000   ;2C
  #$0000   ;2D
  &cop_conditions.Cop2E_JumpIfActorInBoxWord   ;2E
  &cop_actor_fields_animation.Cop2F_ShiftPlayerActors   ;2F
  &cop_tiles_spawn_kill.Cop30_SpawnIfEnteredViaRecord   ;30
  &cop_script_flow_flags.Cop31_FadeAndLoadMusic   ;31
  &cop_script_flow_flags.Cop32_StopAndLoadMusic   ;32
  &cop_actor_fields_animation.Cop33_ShowPlayerActors   ;33
  &cop_actor_fields_animation.Cop34_HidePlayerActors   ;34
  &cop_script_flow_flags.Cop35_RandomMod   ;35
  &cop_items_stats_text.Cop36_AddExp   ;36
  &cop_items_stats_text.Cop37_HealPlayerToFull   ;37
  &cop_items_stats_text.Cop38_QueueExp   ;38
  &cop_items_stats_text.Cop39_DamagePlayer   ;39
  &cop_items_stats_text.Cop3A_EnterPlayerName   ;3A
  &cop_script_flow_flags.Cop3B_JumpIfSwitchSetElseHold   ;3B
  &cop_script_flow_flags.Cop3C_SetTransitionType   ;3C
]
---------------------------------------------

; Filler words (#$0000 or #$FFFF) that cover command ids 3D-7F so that CopHandlerTable_80_B2 starts at id 80 (CopHandlerTable_00_3C + $100). No handler.

CopFillerTable_3D_7F [
  #$0000   ;00
  #$0000   ;01
  #$0000   ;02
  #$0000   ;03
  #$0000   ;04
  #$0000   ;05
  #$0000   ;06
  #$FFFF   ;07
  #$FFFF   ;08
  #$FFFF   ;09
  #$FFFF   ;0A
  #$FFFF   ;0B
  #$FFFF   ;0C
  #$FFFF   ;0D
  #$FFFF   ;0E
  #$FFFF   ;0F
  #$FFFF   ;10
  #$FFFF   ;11
  #$FFFF   ;12
  #$FFFF   ;13
  #$FFFF   ;14
  #$FFFF   ;15
  #$FFFF   ;16
  #$0000   ;17
  #$0000   ;18
  #$0000   ;19
  #$0000   ;1A
  #$0000   ;1B
  #$0000   ;1C
  #$0000   ;1D
  #$0000   ;1E
  #$0000   ;1F
  #$0000   ;20
  #$0000   ;21
  #$0000   ;22
  #$0000   ;23
  #$0000   ;24
  #$0000   ;25
  #$0020   ;26
  #$FFFF   ;27
  #$FFFF   ;28
  #$FFFF   ;29
  #$FFFF   ;2A
  #$FFFF   ;2B
  #$FFFF   ;2C
  #$FFFF   ;2D
  #$FFFF   ;2E
  #$FFFF   ;2F
  #$FFFF   ;30
  #$FFFF   ;31
  #$FFFF   ;32
  #$FFFF   ;33
  #$FFFF   ;34
  #$FFFF   ;35
  #$FFFF   ;36
  #$0000   ;37
  #$0000   ;38
  #$0000   ;39
  #$0000   ;3A
  #$0000   ;3B
  #$0000   ;3C
  #$0000   ;3D
  #$0000   ;3E
  #$0000   ;3F
  #$0000   ;40
  #$0000   ;41
  #$0000   ;42
]
---------------------------------------------

; Handler words for command ids 80-B2 (id = $80 + index).

CopHandlerTable_80_B2 [
  &cop_actor_fields_animation.Cop80_SetAnimation   ;00
  &cop_actor_fields_animation.Cop81_SetAnimationRepeat   ;01
  &cop_actor_fields_animation.Cop82_WaitAnimationDone   ;02
  &cop_actor_fields_animation.Cop83_WaitAnimationRepeat   ;03
  &cop_tiles_spawn_kill.Cop84_SpawnActorAfter   ;04
  &cop_tiles_spawn_kill.Cop85_SpawnActorBefore   ;05
  &cop_tiles_spawn_kill.Cop86_KillSelf   ;06
  &cop_actor_fields_animation.Cop87_ToggleFlipX   ;07
  &cop_actor_fields_animation.Cop88_ToggleFlipY   ;08
  &cop_conditions.Cop89_JumpIfPlayerWithinX   ;09
  &cop_conditions.Cop8A_JumpIfPlayerWithinY   ;0A
  &cop_conditions.Cop8B_JumpIfPlayerBeyondX   ;0B
  &cop_conditions.Cop8C_JumpIfPlayerBeyondY   ;0C
  &cop_conditions.Cop8D_JumpIfOnScreen   ;0D
  &cop_conditions.Cop8E_JumpIfOffScreen   ;0E
  &cop_actor_fields_animation.Cop8F_FacePlayerX   ;0F
  &cop_actor_fields_animation.Cop90_FacePlayerY   ;10
  &cop_script_flow_flags.Cop91_SetEntryHere   ;11
  &cop_actor_fields_animation.Cop92_StartAnimation   ;12
  &cop_actor_fields_animation.Cop93_StartAnimationCount   ;13
  &cop_actor_fields_animation.Cop94_AnimTick   ;14
  &cop_actor_fields_animation.Cop95_AnimTickRepeat   ;15
  &cop_actor_fields_animation.Cop96_SetFlipX   ;16
  &cop_actor_fields_animation.Cop97_ClearFlipX   ;17
  &cop_actor_fields_animation.Cop98_SetFlipY   ;18
  &cop_actor_fields_animation.Cop99_ClearFlipY   ;19
  &cop_conditions.Cop9A_JumpByPlayerDeltaX   ;1A
  &cop_conditions.Cop9B_JumpByPlayerDeltaY   ;1B
  &cop_conditions.Cop9C_JumpByPlayerAxis   ;1C
  &cop_actor_fields_animation.Cop9D_SetAnimationClearBlocked   ;1D
  &cop_actor_fields_animation.Cop9E_WaitAnimationDoneOrJumpIfBlocked   ;1E
  &cop_actor_fields_animation.Cop9F_AddX   ;1F
  &cop_actor_fields_animation.CopA0_AddY   ;20
  &cop_actor_fields_animation.CopA1_AddXY   ;21
  &cop_actor_fields_animation.CopA2_SetPriority   ;22
  &cop_actor_fields_animation.CopA3_DrawInFront   ;23
  &cop_actor_fields_animation.CopA4_DrawBehind   ;24
  &cop_actor_fields_animation.CopA5_JumpByFlipState   ;25
  &cop_actor_fields_animation.CopA6_ClearDrawInFront   ;26
  &cop_actor_fields_animation.CopA7_ClearDrawBehind   ;27
  &cop_actor_fields_animation.CopA8_SetAnimationTable   ;28
  &cop_actor_fields_animation.CopA9_SetDynamicTileSource   ;29
  &cop_actor_fields_animation.CopAA_SetPalette   ;2A
  &cop_tiles_spawn_kill.CopAB_SpawnAfterAbsolute   ;2B
  &cop_tiles_spawn_kill.CopAC_SpawnBeforeAbsolute   ;2C
  &cop_conditions.CopAD_WaitUntilOnScreen   ;2D
  &cop_tiles_spawn_kill.CopAE_JumpIfTileTypeNonZero   ;2E
  &cop_tiles_spawn_kill.CopAF_SpawnAfterWithFlags   ;2F
  &cop_tiles_spawn_kill.CopB0_SpawnBeforeWithFlags   ;30
  &cop_tiles_spawn_kill.CopB1_SpawnAfterRelative   ;31
  &cop_core.CopB2_SpawnBeforeRelative   ;32
]