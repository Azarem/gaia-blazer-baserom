; Map rectangle copies of the release scenes (file offsets 69930-70388, SNES $02:912A-$92F4, bank 02), four release-scene routines that no batch has annotated yet (70389-71037), the lair state and flag map patches that run at every scene load (ApplyLairStatesToScene 71038-71152, ApplyFlagMapPatches 71153-71265, LookupSceneVariant 71266-71316, SNES $02:957E-$96D4) and FlagMapPatchTable (94861-95491, SNES $02:F28D-$F503).
; 
; === MODEL: RELEASE SCENES ===
; The rectangle is given by the copied lair record bytes in $1C6D-$1C74: release_slab ($1C6E), release_npc_x/y ($1C6F-$1C70), release_rect_x/y ($1C71-$1C72, the destination in metatiles) and release_rect_w/h ($1C73-$1C74). A slab is an alternative full-size copy of the map stored behind the live map in the $7E8000 region: slab k starts k x (map size in bytes) after the live map; its cells are copied onto the same cells of the live map (CopyMapRectFromSlab). The staging copies instead read from a rectangle of the live map itself whose position the caller put in dp$16 / $18 (record +E / +F) and write to release_rect_x/y.
; CopyMapRectFromSlab keeps the high nibble of the live collision byte (the actor block bits $F0) and takes the low nibble from the slab; the staging copies replace the whole byte. A width or height of $80 or more would hang on a BCS to itself (the guard before the loops); the shipped records never do that.
; Nothing is queued for VRAM by these routines: the sweep redraw (StepSweepRedraw) draws the result.
; 
; === MODEL: SCENE LOAD ===
; InitSceneState (lib_scene_change_init) calls ApplyLairStatesToScene and ApplyFlagMapPatches right after LoadSceneAssets, so the map pages and collision map they change are the ones just loaded. The two routines make the scene show what the player already did: lairs that are released stay open and gone, and rooms whose event flag is set show their opened state.
; ApplyLairStatesToScene visits the 420 lair records of LairRecords (32 bytes each, $FF terminator) with a running index X over ALL records (lair_state[X] is the state byte of record X). Records of this location count in lairs_left (the number the pause banner shows). State above 0: the lair still has monsters, SpawnLairActor creates it. State 0: every monster is dead and the tile at the record's (+C, +D) becomes $FE (the lair's release switch). State below 0: the lair was released, the tile becomes $FF and the lair stops counting. The tile is written to the BG1 page $7E8000 and, when record +8 is non-zero, to the BG2 page $7EC000.
; ApplyFlagMapPatches walks FlagMapPatchTable. For each row of this location whose event flag is set it copies a rectangle of the map from a hidden staging place of the same map to the visible place (CopyMapRectFromStaging): the permanent map changes of the game (opened doors and passages). LookupSceneVariant walks SceneVariantRules and is called from ApplySceneProfile (see lib_scene_asset_loader).
; 
; === NOTES ===
; - The routines from code_0112F5 to code_0114E4 (code_0112F5, code_011395 with its sub-label code_011445, code_0114D0, code_0114E4) belong to no function-map batch and stay unannotated here (OQ-I029-1).
; - 13 of the 70 FlagMapPatchTable rows test event flag number $00FF (locations 00, 0E, 13, 71, 72, 73). Which flag that is and who sets it is open (OQ-I011-13).
---------------------------------------------

?BANK 02

?INCLUDE 'data_chest_lists'
?INCLUDE 'data_exit_lists'
?INCLUDE 'data_lair_records'
?INCLUDE 'data_plate_lists'
?INCLUDE 'data_scene_variant_rules'
?INCLUDE 'engine_spawn_lairs_death_drops'
?INCLUDE 'lib_arithmetic'
?INCLUDE 'lib_bit_array'
?INCLUDE 'lib_map_index_helpers'

!scene_variant                  031E
!map_width_pages                0343
!map_height_pages               0345
!player_tile_x                  0378
!player_tile_y                  037A
!plate_variant                  03A8
!plate_lists_ofs                03AA
!plate_list_ofs                 03AC
!chest_list_ofs                 03AE
!exit_list_ofs                  03B2
!lairs_left                     0456
!location_id                    1C6A
!release_slab                   1C6E
!release_rect_x                 1C71
!release_rect_y                 1C72
!release_rect_w                 1C73
!release_rect_h                 1C74
!lair_state                     7F0203
!tile_type_map                  7F8000

---------------------------------------------

; Copies a rectangle of metatiles and collision bytes from a map slab onto the live BG1 map.
; 
; When: PlayLairReleaseScene (slabs 0-3), TriggerVariantPlate (slab 2 or 3) and the scene-entry replay of freed NPCs (slab 3).
; Sees: after the sweep, the NPC's spot or the plate's part of the room shows its new state.
; Why: each state of the room is a prebuilt slab, so the change is a copy.
; In: M = 1 (it widens inside); release_slab, release_rect_x/y/w/h.
; Out: for each cell of the rectangle: the live $7E8000 byte = the slab's byte; the live tile_type_map byte = (live byte and $F0) OR the slab's byte. BG2 is not changed.
; Clobbers: A, X, dp $0E, $10, $16, $18, $1C64-$1C68 (P restored). RTS.

CopyMapRectFromSlab {
    PHP 
    REP #$20
    LDA $release_rect_x   ; Rectangle origin x in metatiles (record +4) x 16 = pixels
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $release_rect_y
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    STX $1C66
    STX $1C68
    SEP #$20
    SEP #$20
    LDA $map_width_pages
    XBA 
    LDA $map_height_pages
    JSL $@lib_arithmetic.Multiply8x8
    XBA 
    LDA $release_slab     ; Slab k starts k x (map size) after the live map: offset = slab x pages x 256 (only the low byte of the page count is used)
    JSL $@lib_arithmetic.Multiply8x8
    STA $1C65
    XBA 
    STA $1C64
    LDA $release_rect_h
    CMP #$80

  loc_011172:
    BCS loc_011172
    STA $10

  loc_011176:
    LDA $release_rect_w
    CMP #$80

  loc_01117B:
    BCS loc_01117B
    STA $0E

  loc_01117F:
    REP #$20
    LDA $1C66
    CLC 
    ADC $1C64
    TAX 
    SEP #$20
    LDA $7E8000, X
    PHA 
    LDA $tile_type_map, X
    PHA 
    LDX $1C66
    LDA $tile_type_map, X
    AND #$F0
    ORA $01, S
    STA $tile_type_map, X
    PLA 
    PLA 
    STA $7E8000, X
    LDX $1C66
    JSL $@lib_map_index_helpers.StepMapIndexEast
    STX $1C66
    DEC $0E
    BNE loc_01117F
    LDX $1C68
    JSL $@lib_map_index_helpers.StepMapIndexSouth
    STX $1C68
    STX $1C66
    DEC $10
    BNE loc_011176
    PLP 
    RTS 
}

---------------------------------------------
; Copies a rectangle inside the live BG1 map from a staging position to the target rectangle.
; 
; When: ReleaseLairAtSwitch (path case, bit 0 of record +8 clear) and the scene-entry replay of released lairs.
; Sees: after the sweep, a path or a room part is open.
; Why: the opened state is stored in a hidden part of the map and copied into view when the lair is released.
; In: dp$16 / $18 = pixel position of the staging rectangle (record +E / +F x 16); release_rect_x/y/w/h = the target and size; M = 1.
; Out: for each cell: the target's $7E8000 byte and whole tile_type_map byte = the staging cell's. BG2 is not changed.
; Clobbers: A, X, dp $0E, $10, $16, $18, $1C62-$1C68 (P restored). RTS.

CopyMapRectFromStaging {
    PHP 
    REP #$20
    JSL $@lib_map_index_helpers.PixelToMapIndex ; Source: the position the caller left in dp$16 / $18 (record +E / +F)
    STX $1C62
    STX $1C64
    LDA $release_rect_x
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $release_rect_y
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex ; Target: the rectangle origin of the record (+4 / +5)
    STX $1C66
    STX $1C68
    SEP #$20
    LDA $release_rect_h
    CMP #$80

  loc_011201:
    BCS loc_011201
    STA $10

  loc_011205:
    LDA $release_rect_w
    CMP #$80

  loc_01120A:
    BCS loc_01120A
    STA $0E

  loc_01120E:
    LDX $1C62
    LDA $7E8000, X
    PHA 
    LDA $tile_type_map, X
    LDX $1C66
    STA $tile_type_map, X
    PLA 
    STA $7E8000, X
    LDX $1C62
    JSL $@lib_map_index_helpers.StepMapIndexEast
    STX $1C62
    LDX $1C66
    JSL $@lib_map_index_helpers.StepMapIndexEast
    STX $1C66
    DEC $0E
    BNE loc_01120E
    LDX $1C64
    JSL $@lib_map_index_helpers.StepMapIndexSouth
    STX $1C64
    STX $1C62
    LDX $1C68
    JSL $@lib_map_index_helpers.StepMapIndexSouth
    STX $1C68
    STX $1C66
    DEC $10
    BNE loc_011205
    PLP 
    RTS 
}

---------------------------------------------
; As CopyMapRectFromStaging, and the BG1 metatile is also written to BG2.
; 
; When: ReleaseLairAtSwitch (path case, bit 0 of record +8 set) and the scene-entry replay of released lairs.
; Sees: a path opens on both background layers.
; Why: the tile exists on both layers (see SetMetatileBg1Bg2).
; In: as CopyMapRectFromStaging.
; Out: as CopyMapRectFromStaging; additionally $7EC000 at the target = the same id.
; Clobbers: as CopyMapRectFromStaging.

CopyMapRectFromStagingBothLayers {
    PHP 
    REP #$20
    JSL $@lib_map_index_helpers.PixelToMapIndex
    STX $1C62
    STX $1C64
    LDA $release_rect_x
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $release_rect_y
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    STX $1C66
    STX $1C68
    SEP #$20
    LDA $release_rect_h
    CMP #$80

  loc_011294:
    BCS loc_011294
    STA $10

  loc_011298:
    LDA $release_rect_w
    CMP #$80

  loc_01129D:
    BCS loc_01129D
    STA $0E

  loc_0112A1:
    LDX $1C62
    LDA $7E8000, X
    PHA 
    LDA $tile_type_map, X
    LDX $1C66
    STA $tile_type_map, X
    PLA 
    STA $7E8000, X
    STA $7EC000, X
    LDX $1C62
    JSL $@lib_map_index_helpers.StepMapIndexEast
    STX $1C62
    LDX $1C66
    JSL $@lib_map_index_helpers.StepMapIndexEast
    STX $1C66
    DEC $0E
    BNE loc_0112A1
    LDX $1C64
    JSL $@lib_map_index_helpers.StepMapIndexSouth
    STX $1C64
    STX $1C62
    LDX $1C68
    JSL $@lib_map_index_helpers.StepMapIndexSouth
    STX $1C68
    STX $1C66
    DEC $10
    BNE loc_011298
    PLP 
    RTS 
}
---------------------------------------------

code_0112F5 {
    LDX #$0000
    TXY 

  loc_0112F9:
    LDA $1A9E, Y
    INY 
    STA $04
    LDA #$08
    STA $0C

  loc_011303:
    LDA $&data_lair_records.LairRecords, X
    BPL loc_01130B
    BRL loc_011394

  loc_01130B:
    LSR $04
    BCC loc_011380
    CMP $location_id
    BNE loc_011380
    LDA $&data_lair_records.LairRecords+6, X
    ORA $&data_lair_records.LairRecords+7, X
    BEQ loc_011380
    PHX 
    PHY 
    LDA $&data_lair_records.LairRecords+E, X
    ORA $&data_lair_records.LairRecords+F, X
    BEQ loc_011363
    REP #$20
    LDA $&data_lair_records.LairRecords+E, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $&data_lair_records.LairRecords+F, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    LDA $&data_lair_records.LairRecords+8, X
    LSR 
    PHP 
    TXA 
    CLC 
    ADC #$&data_lair_records.LairRecords
    TAX 
    LDY #$1C6D
    LDA #$0007
    MVN #$01, #$^data_lair_records.LairRecords
    PLP 
    SEP #$20
    BCS loc_01135E
    JSR $&CopyMapRectFromStaging
    BRA loc_01137E

  loc_01135E:
    JSR $&CopyMapRectFromStagingBothLayers
    BRA loc_01137E

  loc_011363:
    REP #$20
    TXA 
    CLC 
    ADC #$&data_lair_records.LairRecords
    TAX 
    LDY #$1C6D
    LDA #$0007
    MVN #$01, #$^data_lair_records.LairRecords
    SEP #$20
    LDA #$03
    STA $release_slab
    JSR $&CopyMapRectFromSlab

  loc_01137E:
    PLY 
    PLX 

  loc_011380:
    REP #$20
    TXA 
    CLC 
    ADC #$0020
    TAX 
    SEP #$20
    DEC $0C
    BEQ loc_011391
    BRL loc_011303

  loc_011391:
    BRL loc_0112F9

  loc_011394:
    RTL 
}
---------------------------------------------

code_011395 {
    LDX #$01FF

  loc_011398:
    LDA $lair_state, X
    BPL loc_0113A1
    ASL 
    BMI loc_0113A5

  loc_0113A1:
    DEX 
    BPL loc_011398
    RTL 

  loc_0113A5:
    REP #$20
    PHX 
    TXA 
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    TAX 
    TAY 
    SEP #$20
    LDA $&data_lair_records.LairRecords, X
    CMP $location_id
    BEQ loc_0113BD
    BRL loc_011441

  loc_0113BD:
    LDY $&data_lair_records.LairRecords+1E, X
    BEQ loc_0113D2
    LDA $&data_lair_records.LairRecords+1F, X
    XBA 
    LDA $&data_lair_records.LairRecords+1E, X
    LDY #$1ADE
    JSL $@lib_bit_array.TestBitInArray
    BCC loc_011441

  loc_0113D2:
    TXY 
    REP #$20
    LDA $&data_lair_records.LairRecords+2, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $&data_lair_records.LairRecords+3, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    SEP #$20
    LDA $&data_lair_records.LairRecords+6, Y
    ORA $&data_lair_records.LairRecords+7, Y
    BNE loc_01143B
    LDA $map_width_pages
    XBA 
    LDA $map_height_pages
    JSL $@lib_arithmetic.Multiply8x8
    STA $01
    STZ $00
    XBA 
    LDA $&data_lair_records.LairRecords+1, Y
    BEQ loc_011421
    JSL $@lib_arithmetic.Multiply8x8
    REP #$20
    PHX 
    XBA 
    CLC 
    ADC $01, S
    TAX 
    PLA 
    SEP #$20
    BRA loc_01143B

  loc_011421:
    LDY #$0003

  loc_011424:
    LDA #$01
    STA $tile_type_map, X
    REP #$20
    TXA 
    CLC 
    ADC $00
    TAX 
    SEP #$20
    CPX #$4000
    BCS loc_011441
    DEY 
    BNE loc_011424

  loc_01143B:
    LDA #$01
    STA $tile_type_map, X

  loc_011441:
    PLX 
    BRL loc_0113A1

  code_011445:
    LDX #$0000
    STZ $plate_variant
    REP #$20
    LDA $location_id
    ASL 
    ASL 
    TAX 
    STX $plate_lists_ofs
    LDA $&data_plate_lists.PlateListPointers, X
    SEC 
    SBC #$&data_plate_lists.PlateListPointers
    STA $plate_list_ofs
    TAX 
    SEP #$20

  loc_011463:
    LDA $&data_plate_lists.PlateListPointers, X
    CMP #$FF
    BEQ loc_01148E
    CMP $player_tile_x
    BNE loc_011487
    LDA $&data_plate_lists.PlateListPointers+1, X
    CMP $player_tile_y
    BNE loc_011487
    LDA $&data_plate_lists.PlateListPointers+3, X
    XBA 
    LDA $&data_plate_lists.PlateListPointers+2, X
    LDY #$1A9E
    JSL $@lib_bit_array.TestBitInArray
    BCS loc_01148F

  loc_011487:
    INX 
    INX 
    INX 
    INX 
    BRL loc_011463

  loc_01148E:
    RTL 

  loc_01148F:
    REP #$20
    LDA $&data_plate_lists.PlateListPointers+2, X
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC #$&data_lair_records.LairRecords
    TAX 
    LDY #$1C6D
    LDA #$0007
    MVN #$01, #$^data_lair_records.LairRecords
    SEP #$20
    LDA #$02
    STA $release_slab
    JSR $&CopyMapRectFromSlab
    REP #$20
    LDX $plate_lists_ofs
    LDA $plate_variant
    EOR #$0001
    STA $plate_variant
    BEQ loc_0114C3
    INX 
    INX 

  loc_0114C3:
    LDA $&data_plate_lists.PlateListPointers, X
    SEC 
    SBC #$&data_plate_lists.PlateListPointers
    STA $plate_list_ofs
    SEP #$20
    RTL 
}
---------------------------------------------

code_0114D0 {
    REP #$20
    LDA $location_id
    ASL 
    TAX 
    LDA $&data_exit_lists.ExitListPointers, X
    SEC 
    SBC #$&data_exit_lists.ExitListPointers
    STA $exit_list_ofs
    SEP #$20
    RTL 
}
---------------------------------------------

code_0114E4 {
    REP #$20
    LDA $location_id
    ASL 
    TAX 
    LDA $&data_chest_lists.ChestListPointers, X
    SEC 
    SBC #$&data_chest_lists.ChestListPointers
    STA $chest_list_ofs
    SEP #$20
    LDX $chest_list_ofs

  loc_0114FA:
    LDA $&data_chest_lists.ChestListPointers, X
    CMP #$FF
    BEQ loc_01157D
    LDA #$00
    XBA 
    LDA $&data_chest_lists.ChestListPointers+2, X
    AND #$7F
    LDY #$1A7E
    JSL $@lib_bit_array.TestBitInArray
    BCC loc_011570
    PHX 
    LDA $&data_chest_lists.ChestListPointers+2, X
    STA $02
    REP #$20
    LDA $&data_chest_lists.ChestListPointers, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $&data_chest_lists.ChestListPointers+1, X
    AND #$00FF
    DEC 
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    SEP #$20
    LDA $map_width_pages
    XBA 
    LDA $map_height_pages
    JSL $@lib_arithmetic.Multiply8x8
    STA $01
    XBA 
    STA $00

  loc_011549:
    LDA $7E8000, X
    CMP #$FB
    BNE loc_011561
    LDA #$FC
    STA $7E8000, X
    LDA $02
    BPL loc_011561
    LDA #$FC
    STA $7EC000, X

  loc_011561:
    REP #$20
    TXA 
    CLC 
    ADC $00
    TAX 
    CPX #$4000
    SEP #$20
    BCC loc_011549
    PLX 

  loc_011570:
    REP #$20
    TXA 
    CLC 
    ADC #$0006
    TAX 
    SEP #$20
    BRL loc_0114FA

  loc_01157D:
    RTL 
}
---------------------------------------------

; Applies the saved state of every lair of this location to the freshly loaded scene.
; 
; When: every scene change, from InitSceneState, right after LoadSceneAssets.
; Sees: lairs with monsters left spawn, a lair whose monsters are all dead shows its release switch, a released lair is gone; the Start-button banner shows how many lairs remain (walkthrough 01-in-the-beginning.md: the number of Monster Lairs in the area is shown by pressing Start).
; Why: lair state is saved per record index; the map is rebuilt from the ROM at every scene change, so the state must be replayed.
; In: JSL; X, Y 16-bit; location_id set; lair_state holds one state byte per record of LairRecords.
; Out: lairs_left = lairs of this location not yet released; per record: SpawnLairActor, or tile $FE (state 0) or $FF (state below 0) at record (+C, +D) in the BG1 page $7E8000 (and the BG2 page $7EC000 when record +8 is non-zero). M = 8 on return.
; Clobbers: A, X, Y, dp$16, dp$18 (and what lib_map_index_helpers.PixelToMapIndex and SpawnLairActor use).

ApplyLairStatesToScene {
    LDX #$0000
    TXY 
    STZ $lairs_left       ; lairs_left counts the records of this location that are not released

  ScanLairRecords:
    LDA $&data_lair_records.LairRecords, Y
    CMP #$FF
    BEQ EndLairScan
    LDA $&data_lair_records.LairRecords+B, Y ; record +B = location id
    CMP $location_id
    BNE NextLairRecord
    INC $lairs_left
    LDA $lair_state, X    ; state byte of the running record index X (all records count, not only this location's)
    BMI PaintLairTile     ; below 0: released; 0: all monsters dead; above 0: monsters left, spawn the lair
    BEQ PaintLairTile
    JSL $@engine_spawn_lairs_death_drops.SpawnLairActor

  NextLairRecord:
    REP #$20
    TYA 
    CLC 
    ADC #$0020
    TAY 
    SEP #$20
    INX 
    BRA ScanLairRecords

  EndLairScan:
    RTL 

  PaintLairTile:
    PHX 
    PHY 
    PHP 
    REP #$20
    LDA $&data_lair_records.LairRecords+C, Y
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $&data_lair_records.LairRecords+D, Y
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    SEP #$20
    LDA #$FE              ; $FE = the release switch tile (state 0)
    PLP 
    BPL loc_0115DE
    LDA #$FF              ; $FF = released lair: no tile, and it no longer counts
    DEC $lairs_left

  loc_0115DE:
    STA $7E8000, X        ; BG1 map page
    XBA 
    LDA $&data_lair_records.LairRecords+8, Y
    BEQ loc_0115ED
    XBA 
    STA $7EC000, X        ; BG2 map page, only when record +8 is non-zero

  loc_0115ED:
    PLY 
    PLX 
    BRA NextLairRecord

; Applies the permanent map changes whose event flag is set.
; 
; When: every scene change, from InitSceneState, after ApplyLairStatesToScene.
; Sees: opened doors and passages stay open after the player reopens the area.
; Why: the rooms are rebuilt from the ROM at every scene change, so each change an event flag stands for must be replayed.
; In: JSL; M = 8, X 16-bit; FlagMapPatchTable (9-byte rows, $FF terminator), location_id, event_flags.
; Out: per row of this location whose event flag (bit number = the row's word) is set: release_rect_x/y/w/h = the destination rectangle, dp$16 / dp$18 = the staging position in pixels, CopyMapRectFromStaging copies the BG1 ids and the type bytes.
; Clobbers: A, Y (loaded with $1A5E), dp$16, dp$18, dp$0E, dp$10, release_rect_x/y/w/h; X is restored per row.

  ApplyFlagMapPatches:
    LDX #$0000
    TXY 

  ScanPatchRows:
    LDA $@FlagMapPatchTable, X
    CMP #$FF
    BEQ EndPatchScan
    CMP $location_id
    BNE NextPatchRow
    LDA $@FlagMapPatchTable+2, X
    XBA 
    LDA $@FlagMapPatchTable+1, X
    LDY #$1A5E            ; event_flags ($1A5E): the row's word is a bit number in it
    JSL $@lib_bit_array.TestBitInArray
    BCS ApplyPatchRow

  NextPatchRow:
    REP #$20
    TXA 
    CLC 
    ADC #$0009
    TAX 
    SEP #$20
    BRA ScanPatchRows

  EndPatchScan:
    RTL 

  ApplyPatchRow:
    PHX 
    LDA $@FlagMapPatchTable+3, X
    STA $release_rect_x
    LDA $@FlagMapPatchTable+4, X
    STA $release_rect_y
    LDA $@FlagMapPatchTable+5, X
    STA $release_rect_w
    LDA $@FlagMapPatchTable+6, X
    STA $release_rect_h
    REP #$20
    LDA $@FlagMapPatchTable+7, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $@FlagMapPatchTable+8, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSR $&CopyMapRectFromStaging ; copies the staging rectangle (dp$16 / dp$18, in pixels) onto release_rect_x/y/w/h
    SEP #$20
    PLX 
    BRA NextPatchRow

; Looks for a switch row that forces the music variant of this location.
; 
; When: ApplySceneProfile, when scene_variant is still 0 after the actors had their chance to set it.
; Sees: the music of a boss room before the boss switch, and the music of the rest of the world after it (the likely story, OQ-I011-5).
; Why: the boss and post-boss music of a world depend on a switch, not on the room.
; In: JSL; M = 8, X 16-bit; SceneVariantRules rows of 4 bytes (location, switch word, variant; a first byte of $80 or more ends the table), the switch bit array at $1ADE.
; Out: carry set and scene_variant = the row's variant when a row of this location has its switch set; carry clear otherwise.
; Clobbers: A (X and Y are preserved).

  LookupSceneVariant:
    PHX 
    PHY 
    LDX #$0000

  ScanVariantRows:
    LDA $&data_scene_variant_rules.SceneVariantRules, X
    BMI NoVariantRow
    CMP $location_id
    BNE NextVariantRow
    LDA $&data_scene_variant_rules.SceneVariantRules+2, X
    XBA 
    LDA $&data_scene_variant_rules.SceneVariantRules+1, X
    LDY #$1ADE            ; switch bit array at $1ADE ($80 bytes behind event_flags)
    JSL $@lib_bit_array.TestBitInArray
    BCC NextVariantRow
    LDA $&data_scene_variant_rules.SceneVariantRules+3, X ; row +3 = the variant
    STA $scene_variant
    SEC 
    PLY 
    PLX 
    RTL 

  NextVariantRow:
    INX 
    INX 
    INX 
    INX 
    BRA ScanVariantRows

  NoVariantRow:
    CLC 
    PLY 
    PLX 
    RTL 
}
---------------------------------------------

FlagMapPatchTable [
  unk13 < #01, #$000F, #00, #10, #01, #1F, #00, #D0 >   ;00
  unk13 < #01, #$000F, #3F, #10, #01, #1F, #3F, #D0 >   ;01
  unk13 < #01, #$000F, #00, #2F, #40, #03, #00, #EF >   ;02
  unk13 < #01, #$000F, #1D, #12, #06, #1D, #1D, #D2 >   ;03
  unk13 < #00, #$00FF, #05, #06, #01, #01, #00, #0F >   ;04
  unk13 < #00, #$00FF, #07, #08, #01, #01, #03, #0F >   ;05
  unk13 < #00, #$0200, #07, #08, #01, #01, #00, #0F >   ;06
  unk13 < #00, #$0224, #09, #06, #01, #01, #00, #0F >   ;07
  unk13 < #06, #$0232, #0B, #30, #02, #04, #1C, #00 >   ;08
  unk13 < #06, #$0232, #0F, #36, #01, #01, #1E, #00 >   ;09
  unk13 < #14, #$023B, #05, #06, #01, #01, #00, #0F >   ;0A
  unk13 < #14, #$0270, #09, #06, #01, #01, #00, #0F >   ;0B
  unk13 < #18, #$0241, #0D, #08, #01, #02, #00, #0E >   ;0C
  unk13 < #28, #$002A, #05, #06, #01, #01, #00, #0F >   ;0D
  unk13 < #28, #$0278, #09, #06, #01, #01, #00, #0F >   ;0E
  unk13 < #3C, #$02F9, #05, #06, #01, #01, #00, #0F >   ;0F
  unk13 < #3C, #$02E4, #09, #06, #01, #01, #00, #0F >   ;10
  unk13 < #50, #$031C, #05, #06, #01, #01, #00, #0F >   ;11
  unk13 < #50, #$032D, #09, #06, #01, #01, #00, #0F >   ;12
  unk13 < #64, #$036A, #05, #06, #01, #01, #00, #0F >   ;13
  unk13 < #64, #$0393, #09, #06, #01, #01, #00, #0F >   ;14
  unk13 < #78, #$0397, #05, #06, #01, #01, #00, #0F >   ;15
  unk13 < #78, #$03A2, #09, #06, #01, #01, #00, #0F >   ;16
  unk13 < #16, #$0020, #05, #0B, #05, #04, #11, #00 >   ;17
  unk13 < #16, #$001F, #08, #12, #01, #01, #19, #00 >   ;18
  unk13 < #16, #$004F, #08, #12, #01, #01, #19, #01 >   ;19
  unk13 < #16, #$0274, #18, #15, #03, #04, #16, #00 >   ;1A
  unk13 < #23, #$0261, #19, #19, #01, #01, #19, #1A >   ;1B
  unk13 < #23, #$0261, #19, #0C, #01, #02, #19, #12 >   ;1C
  unk13 < #15, #$0275, #1B, #06, #03, #03, #0D, #08 >   ;1D
  unk13 < #24, #$0258, #1D, #09, #01, #01, #1C, #5C >   ;1E
  unk13 < #24, #$0258, #0F, #05, #02, #02, #0E, #09 >   ;1F
  unk13 < #33, #$027C, #05, #43, #01, #08, #0A, #43 >   ;20
  unk13 < #33, #$027C, #05, #41, #01, #02, #06, #41 >   ;21
  unk13 < #33, #$027C, #05, #40, #01, #01, #0A, #40 >   ;22
  unk13 < #33, #$027C, #0E, #15, #01, #01, #0E, #14 >   ;23
  unk13 < #33, #$027C, #02, #34, #02, #01, #02, #33 >   ;24
  unk13 < #34, #$0279, #07, #2A, #05, #04, #00, #3C >   ;25
  unk13 < #72, #$00FF, #1B, #17, #02, #04, #01, #2C >   ;26
  unk13 < #71, #$00FF, #17, #22, #01, #01, #17, #21 >   ;27
  unk13 < #0F, #$0250, #00, #10, #10, #0B, #00, #20 >   ;28
  unk13 < #0F, #$0395, #10, #06, #0E, #0A, #10, #26 >   ;29
  unk13 < #0F, #$0303, #0D, #0A, #08, #06, #10, #20 >   ;2A
  unk13 < #0F, #$00FC, #0D, #00, #02, #09, #00, #00 >   ;2B
  unk13 < #2C, #$0031, #09, #07, #04, #02, #00, #0E >   ;2C
  unk13 < #2D, #$02BB, #05, #1F, #01, #01, #02, #22 >   ;2D
  unk13 < #3D, #$003E, #1F, #2E, #04, #02, #20, #2C >   ;2E
  unk13 < #3D, #$003E, #18, #2E, #06, #02, #18, #2C >   ;2F
  unk13 < #3D, #$003E, #11, #2E, #06, #02, #11, #2C >   ;30
  unk13 < #55, #$0326, #01, #08, #11, #05, #01, #68 >   ;31
  unk13 < #55, #$0326, #03, #03, #12, #04, #03, #63 >   ;32
  unk13 < #73, #$00FF, #1B, #17, #02, #04, #01, #2C >   ;33
  unk13 < #73, #$00FF, #17, #22, #01, #01, #17, #21 >   ;34
  unk13 < #65, #$0046, #00, #12, #01, #2B, #00, #D2 >   ;35
  unk13 < #65, #$0046, #3F, #12, #01, #2B, #3F, #D2 >   ;36
  unk13 < #65, #$0046, #00, #3C, #40, #04, #00, #FC >   ;37
  unk13 < #65, #$038C, #1D, #12, #05, #01, #1D, #92 >   ;38
  unk13 < #42, #$02E7, #12, #2E, #0E, #08, #20, #40 >   ;39
  unk13 < #15, #$025C, #02, #20, #01, #02, #0D, #25 >   ;3A
  unk13 < #0E, #$00FA, #0F, #34, #04, #02, #0F, #2E >   ;3B
  unk13 < #0E, #$00FF, #19, #2F, #01, #01, #19, #2E >   ;3C
  unk13 < #7B, #$0050, #08, #00, #10, #0C, #08, #40 >   ;3D
  unk13 < #7B, #$0050, #06, #00, #02, #03, #06, #40 >   ;3E
  unk13 < #7B, #$0050, #18, #00, #02, #03, #18, #40 >   ;3F
  unk13 < #13, #$00FF, #23, #23, #13, #0B, #23, #E3 >   ;40
  unk13 < #13, #$00FF, #34, #29, #02, #02, #2B, #E5 >   ;41
  unk13 < #13, #$00FF, #35, #28, #01, #01, #35, #ED >   ;42
  unk13 < #13, #$00FF, #35, #2B, #01, #01, #35, #E6 >   ;43
  unk13 < #13, #$00FF, #34, #2B, #01, #01, #33, #EA >   ;44
  unk13 < #13, #$00FF, #36, #1A, #08, #0C, #36, #9A >   ;45
]