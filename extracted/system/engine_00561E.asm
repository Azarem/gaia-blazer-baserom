; COP dispatcher and command tables.
; 
; The COP instruction runs actor scripts. native_mode_cop_00561E takes the actor slot from X (TXY), builds the script pointer in DP $38/$3A from the pushed return address (bank byte from $04,S, address $02,S minus 1, so the pointer starts on the COP signature byte), reads the command id, advances $38 and jumps through the word table at code_list_005638 indexed by id*2.
; 
; The table has three extracted parts: code_list_005638 (ids 00-3C), cop_junk (ids 3D-7F, filler words, no handlers) and code_list_005738 (ids 80-B2). The ids 0E, 0F, 2C and 2D have no handler (#$0000).
; 
; Each handler is a Cop<ID>_<Name> label in extracted/cop_handlers; it ends by jumping into the exit chain in cop_handler_006473. Reference: docs/cop/index.md.
---------------------------------------------

?BANK 00

?INCLUDE 'cop_handler_00579E'
?INCLUDE 'cop_handler_0057A2'
?INCLUDE 'cop_handler_0057BD'
?INCLUDE 'cop_handler_0057F5'
?INCLUDE 'cop_handler_00580B'
?INCLUDE 'cop_handler_00581D'
?INCLUDE 'cop_handler_005838'
?INCLUDE 'cop_handler_00583E'
?INCLUDE 'cop_handler_005867'
?INCLUDE 'cop_handler_005874'
?INCLUDE 'cop_handler_005888'
?INCLUDE 'cop_handler_0058A9'
?INCLUDE 'cop_handler_00590D'
?INCLUDE 'cop_handler_005946'
?INCLUDE 'cop_handler_005970'
?INCLUDE 'cop_handler_00599E'
?INCLUDE 'cop_handler_0059B5'
?INCLUDE 'cop_handler_0059CC'
?INCLUDE 'cop_handler_0059F4'
?INCLUDE 'cop_handler_0059FB'
?INCLUDE 'cop_handler_005A02'
?INCLUDE 'cop_handler_005A0F'
?INCLUDE 'cop_handler_005A28'
?INCLUDE 'cop_handler_005A43'
?INCLUDE 'cop_handler_005A88'
?INCLUDE 'cop_handler_005A9E'
?INCLUDE 'cop_handler_005AB6'
?INCLUDE 'cop_handler_005AC6'
?INCLUDE 'cop_handler_005AD6'
?INCLUDE 'cop_handler_005AFD'
?INCLUDE 'cop_handler_005B15'
?INCLUDE 'cop_handler_005B2B'
?INCLUDE 'cop_handler_005B39'
?INCLUDE 'cop_handler_005B4F'
?INCLUDE 'cop_handler_005B65'
?INCLUDE 'cop_handler_005B79'
?INCLUDE 'cop_handler_005BB1'
?INCLUDE 'cop_handler_005BC1'
?INCLUDE 'cop_handler_005BEB'
?INCLUDE 'cop_handler_005C1F'
?INCLUDE 'cop_handler_005C50'
?INCLUDE 'cop_handler_005C81'
?INCLUDE 'cop_handler_005C97'
?INCLUDE 'cop_handler_005CD6'
?INCLUDE 'cop_handler_005CF0'
?INCLUDE 'cop_handler_005D10'
?INCLUDE 'cop_handler_005D30'
?INCLUDE 'cop_handler_005D53'
?INCLUDE 'cop_handler_005D76'
?INCLUDE 'cop_handler_005D94'
?INCLUDE 'cop_handler_005DB0'
?INCLUDE 'cop_handler_005DBE'
?INCLUDE 'cop_handler_005DCB'
?INCLUDE 'cop_handler_005E05'
?INCLUDE 'cop_handler_005E0D'
?INCLUDE 'cop_handler_005E6C'
?INCLUDE 'cop_handler_005E7A'
?INCLUDE 'cop_handler_005E90'
?INCLUDE 'cop_handler_005EB0'
?INCLUDE 'cop_handler_005EBD'
?INCLUDE 'cop_handler_005ECF'
?INCLUDE 'cop_handler_005EEE'
?INCLUDE 'cop_handler_005F0D'
?INCLUDE 'cop_handler_005F45'
?INCLUDE 'cop_handler_005F52'
?INCLUDE 'cop_handler_005F5F'
?INCLUDE 'cop_handler_005F85'
?INCLUDE 'cop_handler_005FAB'
?INCLUDE 'cop_handler_005FD1'
?INCLUDE 'cop_handler_005FF7'
?INCLUDE 'cop_handler_00600C'
?INCLUDE 'cop_handler_006021'
?INCLUDE 'cop_handler_006042'
?INCLUDE 'cop_handler_006063'
?INCLUDE 'cop_handler_006075'
?INCLUDE 'cop_handler_00608E'
?INCLUDE 'cop_handler_0060B1'
?INCLUDE 'cop_handler_0060CD'
?INCLUDE 'cop_handler_0060EE'
?INCLUDE 'cop_handler_006100'
?INCLUDE 'cop_handler_006112'
?INCLUDE 'cop_handler_006124'
?INCLUDE 'cop_handler_006136'
?INCLUDE 'cop_handler_00615D'
?INCLUDE 'cop_handler_006184'
?INCLUDE 'cop_handler_0061B2'
?INCLUDE 'cop_handler_0061D1'
?INCLUDE 'cop_handler_0061EF'
?INCLUDE 'cop_handler_006200'
?INCLUDE 'cop_handler_006211'
?INCLUDE 'cop_handler_00622F'
?INCLUDE 'cop_handler_006248'
?INCLUDE 'cop_handler_006255'
?INCLUDE 'cop_handler_006262'
?INCLUDE 'cop_handler_00628B'
?INCLUDE 'cop_handler_006298'
?INCLUDE 'cop_handler_0062A5'
?INCLUDE 'cop_handler_0062C1'
?INCLUDE 'cop_handler_0062E6'
?INCLUDE 'cop_handler_0062FF'
?INCLUDE 'cop_handler_006339'
?INCLUDE 'cop_handler_006373'
?INCLUDE 'cop_handler_0063A9'
?INCLUDE 'cop_handler_0063E1'
?INCLUDE 'cop_handler_006409'
?INCLUDE 'cop_handler_006431'
?INCLUDE 'cop_handler_006473'

---------------------------------------------

; Native-mode COP vector. In: X = actor slot (copied to Y), stack = return address of the COP instruction. Sets $3A (script bank) and $38 (script pointer at the command id), reads the id, advances $38 and dispatches through code_list_005638,X.

native_mode_cop_00561E {
    SEP #$20
    TXY 
    LDA $04, S
    STA $3A
    REP #$20
    LDA $02, S
    DEC 
    STA $38
    LDA [$38]
    INC $38
    AND #$00FF
    ASL 
    TAX 
    JMP ($&code_list_005638, X)
}
---------------------------------------------

; Handler words for command ids 00-3C, indexed id*2. Ids 0E, 0F, 2C and 2D are #$0000 (undefined).

code_list_005638 [
  &cop_handler_00579E.Cop00_Yield   ;00
  &cop_handler_0057A2.Cop01_ShowText   ;01
  &cop_handler_0057BD.Cop02_PromptFixedString   ;02
  &cop_handler_0057F5.Cop03_LoopStart   ;03
  &cop_handler_00580B.Cop04_LoopNext   ;04
  &cop_handler_00581D.Cop05_WaitFlag   ;05
  &cop_handler_005838.Cop06_Jump   ;06
  &cop_handler_00583E.Cop07_JumpIfFlagClear   ;07
  &cop_handler_00583E.Cop08_JumpIfFlagSet   ;08
  &cop_handler_005867.Cop09_SetOrClearFlag   ;09
  &cop_handler_005874.Cop0A_SetInventoryIfEmpty   ;0A
  &cop_handler_005888.Cop0B_ClearInventoryEntry   ;0B
  &cop_handler_0058A9.Cop0C_JumpIfActorInBox   ;0C
  &cop_handler_00590D.Cop0D_JumpIfActorAtTile   ;0D
  #$0000   ;0E
  #$0000   ;0F
  &cop_handler_005946.Cop10_SetNextScene   ;10
  &cop_handler_005970.Cop11_MoveActorToTile   ;11
  &cop_handler_00599E.Cop12_SetActorResume   ;12
  &cop_handler_0059B5.Cop13_SetActorData30   ;13
  &cop_handler_0059CC.Cop14_JumpIfSwitchSet   ;14
  &cop_handler_0059F4.Cop15_BlockOwnTiles   ;15
  &cop_handler_0059FB.Cop16_UnblockOwnTiles   ;16
  &cop_handler_005A02.Cop17_SetOwnData30   ;17
  &cop_handler_005A0F.Cop18_JumpIfInventoryZero   ;18
  &cop_handler_005A28.Cop19_JumpUnlessInventoryBit7   ;19
  &cop_handler_005A43.Cop1A_ChoiceMenu   ;1A
  &cop_handler_005A88.Cop1B_SetResumeAndDelay   ;1B
  &cop_handler_005A9E.Cop1C_JumpIfActorFlags   ;1C
  &cop_handler_005AB6.Cop1D_SetActorFlags   ;1D
  &cop_handler_005AC6.Cop1E_MaskActorFlags   ;1E
  &cop_handler_005AD6.Cop1F_StepRandom   ;1F
  &cop_handler_005AFD.Cop20_JumpIfPlayerOffGrid   ;20
  &cop_handler_005B15.Cop21_JumpIfTileAbove   ;21
  &cop_handler_005B2B.Cop22_JumpIfTileAtPos   ;22
  &cop_handler_005B39.Cop23_JumpIfTileLeft   ;23
  &cop_handler_005B4F.Cop24_JumpIfTileRight   ;24
  &cop_handler_005B65.Cop25_CallLib0276A5   ;25
  &cop_handler_005B79.Cop26_JumpIfLib0276C9   ;26
  &cop_handler_005BB1.Cop27_SetResumeAndYield   ;27
  &cop_handler_005BC1.Cop28_JumpIfTileHere   ;28
  &cop_handler_005BEB.Cop29_JumpIfTileIdDiffers   ;29
  &cop_handler_005C1F.Cop2A_BlockTileAt   ;2A
  &cop_handler_005C50.Cop2B_UnblockTileAt   ;2B
  #$0000   ;2C
  #$0000   ;2D
  &cop_handler_005C81.Cop2E_JumpIfActorInBoxWord   ;2E
  &cop_handler_005C97.Cop2F_ShiftPlayerActors   ;2F
  &cop_handler_005CD6.Cop30_ConditionalSpawn   ;30
  &cop_handler_005CF0.Cop31_SpawnEngineActor2C9B   ;31
  &cop_handler_005D10.Cop32_SpawnEngineActor2CCB   ;32
  &cop_handler_005D30.Cop33_PlayerActorsClearBit7   ;33
  &cop_handler_005D53.Cop34_PlayerActorsSetBit7   ;34
  &cop_handler_005D76.Cop35_RandomMod   ;35
  &cop_handler_005D94.Cop36_AddBcdCounter   ;36
  &cop_handler_005DB0.Cop37_GetMissingHp   ;37
  &cop_handler_005DBE.Cop38_SetParam043D   ;38
  &cop_handler_005DCB.Cop39_DamagePlayer   ;39
  &cop_handler_005E05.Cop3A_CallLib0124EE   ;3A
  &cop_handler_005E0D.Cop3B_JumpIfSwitchSetData   ;3B
  &cop_handler_005E6C.Cop3C_SetMode03E3   ;3C
]
---------------------------------------------

; Filler words (#$0000 or #$FFFF) that cover command ids 3D-7F so that code_list_005738 starts at id 80 (code_list_005638 + $100). No handler.

cop_junk [
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

code_list_005738 [
  &cop_handler_005E7A.Cop80_SetAnimation   ;00
  &cop_handler_005E90.Cop81_SetAnimationCount   ;01
  &cop_handler_005EB0.Cop82_AnimStepYield   ;02
  &cop_handler_005EBD.Cop83_AnimStepRepeat   ;03
  &cop_handler_005ECF.Cop84_SpawnActorAfter   ;04
  &cop_handler_005EEE.Cop85_SpawnActorBefore   ;05
  &cop_handler_005F0D.Cop86_KillSelf   ;06
  &cop_handler_005F45.Cop87_ToggleFlipX   ;07
  &cop_handler_005F52.Cop88_ToggleFlipY   ;08
  &cop_handler_005F5F.Cop89_JumpIfPlayerWithinX   ;09
  &cop_handler_005F85.Cop8A_JumpIfPlayerWithinY   ;0A
  &cop_handler_005FAB.Cop8B_JumpIfPlayerBeyondX   ;0B
  &cop_handler_005FD1.Cop8C_JumpIfPlayerBeyondY   ;0C
  &cop_handler_005FF7.Cop8D_JumpIfBit15Clear   ;0D
  &cop_handler_00600C.Cop8E_JumpIfBit15Set   ;0E
  &cop_handler_006021.Cop8F_FacePlayerX   ;0F
  &cop_handler_006042.Cop90_FacePlayerY   ;10
  &cop_handler_006063.Cop91_SetEntryHere   ;11
  &cop_handler_006075.Cop92_StartAnimation   ;12
  &cop_handler_00608E.Cop93_StartAnimationCount   ;13
  &cop_handler_0060B1.Cop94_AnimTick   ;14
  &cop_handler_0060CD.Cop95_AnimTickRepeat   ;15
  &cop_handler_0060EE.Cop96_SetFlipX   ;16
  &cop_handler_006100.Cop97_ClearFlipX   ;17
  &cop_handler_006112.Cop98_SetFlipY   ;18
  &cop_handler_006124.Cop99_ClearFlipY   ;19
  &cop_handler_006136.Cop9A_JumpByPlayerDeltaX   ;1A
  &cop_handler_00615D.Cop9B_JumpByPlayerDeltaY   ;1B
  &cop_handler_006184.Cop9C_JumpByPlayerAxis   ;1C
  &cop_handler_0061B2.Cop9D_SetAnimationUnlock   ;1D
  &cop_handler_0061D1.Cop9E_AnimStepUnlessBit2   ;1E
  &cop_handler_0061EF.Cop9F_AddX   ;1F
  &cop_handler_006200.CopA0_AddY   ;20
  &cop_handler_006211.CopA1_AddXY   ;21
  &cop_handler_00622F.CopA2_SetPriority   ;22
  &cop_handler_006248.CopA3_SetFlag1A4000   ;23
  &cop_handler_006255.CopA4_SetFlag1A2000   ;24
  &cop_handler_006262.CopA5_JumpByFlipState   ;25
  &cop_handler_00628B.CopA6_ClearFlag1A4000   ;26
  &cop_handler_006298.CopA7_ClearFlag1A2000   ;27
  &cop_handler_0062A5.CopA8_SetFields22And24   ;28
  &cop_handler_0062C1.CopA9_SetFields34And2C   ;29
  &cop_handler_0062E6.CopAA_SetPalette   ;2A
  &cop_handler_0062FF.CopAB_SpawnAfterAbsolute   ;2B
  &cop_handler_006339.CopAC_SpawnBeforeAbsolute   ;2C
  &cop_handler_006373.CopAD_YieldWhileInView   ;2D
  &cop_handler_0063A9.CopAE_JumpIfTileTypeSet   ;2E
  &cop_handler_0063E1.CopAF_SpawnAfterFlags   ;2F
  &cop_handler_006409.CopB0_SpawnBeforeFlags   ;30
  &cop_handler_006431.CopB1_SpawnAfterRelative   ;31
  &cop_handler_006473.CopB2_SpawnBeforeRelative   ;32
]