; Tile triggers under the player, the Monster Lair release and the NPC return trip (code at file offsets 68054-69353, SNES $02:89D6-$8EE9; NpcNameStrings 86758-86863 (53 words) and its strings, SNES $02:D2E6; the five chest and lair messages LairNpcNotRecalledText to ChestGemsFoundText at 90590-90723, SNES $02:E1DE-$E263; LocationAreaScene 95788, SNES $02:F62C; bank 02).
; 
; === TILE TRIGGERS ===
; CheckPlayerTileTriggers runs every frame at the start of the work phase. When the player stands on the 16-pixel grid (both coordinates have zero low nibbles) it reads the BG1 metatile at (player_x, player_y - 16): $FE (the green switch, written by SealLair) releases a lair (ReleaseLairAtSwitch, not while boss_fight_active), otherwise a pressure plate (TriggerVariantPlate) and then a chest in front of the player (TryOpenChest) are tried. The exit regions (CheckExitRegions) are tested every frame, aligned or not. Any trigger that fires zeroes the player's velocity ($04, $06). Special metatile ids: $FD intact lair, $FE green switch, $FF cleared switch, $FB closed chest, $FC open chest.
; Lists: chests ChestListPointers (6-byte rows, from chest_list_ofs), exit regions ExitListPointers (11-byte rows, from exit_list_ofs), plates PlateListPointers (4-byte rows, from plate_list_ofs); every list ends with an $FF byte. The offsets are set by the scene loader.
; 
; === LAIR RECORD (32 bytes in LairRecords) ===
; Fields as used by this file (bytes 0-7 are copied to $1C6D-$1C74 for the rectangle routines): +0 location of the freed NPC's home ($FF/$80+ ends the table), +1 slab number (0-3), +2 / +3 the NPC's home tile (x, y), +4 / +5 x, y and +6 / +7 width, height of the rectangle (metatiles), +8 layer flag (0 = BG1 only, bit 0 = also BG2), +9 NPC name index (NpcNameStrings), +A state bits ORed into lair_state, +B location of the lair, +C / +D lair tile (x, y; the switch appears here), +E / +F x, y of the staging rectangle (both 0 = the lair frees an NPC; otherwise the lair opens a path), +$10-$12 lair script, +$13 monster count, +$1D warp animation, +$1E release switch word (bit index in $1ADE). The block note of data_lair_records and the part note of LairRecords describe the whole record, its counts and the six boss lairs.
; 
; === RELEASE MODEL ===
; When the last monster of a lair dies SealLair turns the lair tile into the green switch $FE. Stepping on it (ReleaseLairAtSwitch) finds the lair record, turns the switch into $FF, decrements lairs_left and then does one of two things. If +E / +F are non-zero it opens a path: lair_state = +A or $80, bit n is set in the switch array $1ADE and the released array $1A9E, and the staging rectangle is copied to the rectangle at +4 / +5 (CopyMapRectFromStaging, or ...BothLayers when bit 0 of +8 is set) while the sweep redraw (StepSweepRedraw, 35 frames per layer through RunSubFrameMapSweep) shows it. If they are zero it frees an NPC: lair_state = +A or $C0 and, when the NPC's home is the current location, the home tile gets type 1; otherwise the player is sent to the NPC's home: the return point (area, scene, x, y - 16) is saved, warp_dest is set to the home tile, area_next / scene_next come from LocationAreaScene, transition_type = $80, return_record = the lair index and return_active is incremented. In the home scene the return loop runs RunLairReleaseOnReturn every frame: when the player stands on the type 1 tile PlayLairReleaseScene prints '<name> released', steps the NPC through the slabs 0-3 and sets the arrays; otherwise it prints '<name> cannot be recalled yet!'. When the return loop ends the player is warped back (RunReturnLoop). The walkthrough agrees: freeing an NPC, opening a path or a chest by the switch beneath a lair (02-grass-valley.md lines 47, 51, 238; 03-greenwood.md line 339).
; Bits of lair_state ($7F0203 + lair index): $80 = released, $40 = the NPC's return is pending (cleared by PlayLairReleaseScene and by HoldActorUntilReleased).
; 
; === MESSAGES ===
; The five strings of the chest and lair messages share one tail: ChestGemsFoundText holds the Gems line and, from its [::] marker (the '+M' entry), the key wait ([12]) and the erase of the dialogue box ([08:408]). The other four (LairNpcNotRecalledText, LairNpcReleasedText, ChestItemReceivedText, ChestEmptyText) end with [JMP:&ChestGemsFoundText+M]. text_arg ($03C8) is the one parameter: the NPC name index (lair record +9) for the two lair strings (through NpcNameStrings), the item id (through ItemNameList) for ChestItemReceivedText and the Gem amount as packed BCD ([06:3,03C8]) for ChestGemsFoundText; TryOpenChest picks the string by the content byte of the chest row (0 empty, $FF Gems, else an item id).
; 
; === NOTES ===
; - Arrays used here: $1A7E bit (chest id and $7F) = chest already opened; $1A9E bit n = lair n released; $1ADE bit n = switch n set. lib_bit_array.SetBitInArray sets bit A of the array at Y, TestBitInArray tests it (carry = set).
; - The ROM text 'recieved' (ChestItemReceivedText) is kept as printed; the extractor prints an apostrophe as a space in some names (OQ-I008-14, OQ-I008-15).
; - The names of NpcNameStrings are printed through the text code [TBL:&NpcNameStrings,03C8] with text_arg set to the name index.
---------------------------------------------

?BANK 02

?INCLUDE 'data_chest_lists'
?INCLUDE 'data_exit_lists'
?INCLUDE 'data_lair_records'
?INCLUDE 'data_plate_lists'
?INCLUDE 'engine_boot_main_loop'
?INCLUDE 'lib_0109D6_part1'
?INCLUDE 'lib_0109D6_part3'
?INCLUDE 'lib_arithmetic'
?INCLUDE 'lib_bit_array'
?INCLUDE 'lib_map_index_helpers'
?INCLUDE 'lib_menus'
?INCLUDE 'lib_player_facing'
?INCLUDE 'lib_player_stats'
?INCLUDE 'lib_scene_map_patches'
?INCLUDE 'lib_text_render'

!area_current                   0314
!scene_current                  0316
!scene_next                     0318
!area_next                      0319
!hud_dirty_flags                0332
!map_width_pages                0343
!map_height_pages               0345
!player_x                       0374
!player_y                       0376
!player_tile_x                  0378
!player_tile_y                  037A
!warp_dest_x                    037C
!warp_dest_y                    037E
!warp_dest_anim                 0380
!player_actor                   039C
!plate_variant                  03A8
!plate_lists_ofs                03AA
!plate_list_ofs                 03AC
!chest_list_ofs                 03AE
!exit_list_ofs                  03B2
!asset_skip_mask                03B4
!text_arg                       03C8
!transition_type                03E3
!return_active                  03FB
!return_area                    03FD
!return_scene                   03FF
!return_x                       0401
!return_y                       0403
!return_record                  0405
!lairs_left                     0456
!boss_fight_active              0458
!location_id                    1C6A
!sweep_bg1                      1C6C
!release_slab                   1C6E
!release_npc_x                  1C6F
!release_npc_y                  1C70
!release_rect_w                 1C73
!sweep_step                     1C75
!lair_state                     7F0203
!tile_type_map                  7F8000

---------------------------------------------

; Tests the tile under the player for a lair switch, a pressure plate, a chest or an exit region.
; 
; When: every frame of the main loop, before the actors run.
; Sees: stepping on the green switch frees an NPC or opens a path; walking into a room edge or door changes scene; a chest opens when the player faces it.
; Why: the triggers are map data (tiles and region lists), not actor scripts, so the engine polls them once per frame.
; In: M = 1; player_x, player_y, player_tile_x/y; boss_fight_active.
; Out: a trigger fired: the player actor's $04 and $06 (velocity) are zeroed. ReleaseLairAtSwitch, TriggerVariantPlate and TryOpenChest play their own scenes with sub-frames; CheckExitRegions sets area_next, scene_next and warp_dest_*.
; Clobbers: A, X, Y, dp $00-$06, $16, $18.

CheckPlayerTileTriggers {
    LDA $player_x
    ORA $player_y
    AND #$0F              ; The switch, plate and chest tests run only on the 16-pixel grid; the exit regions are tested every frame
    BNE loc_010A15
    REP #$20
    LDA $player_x
    STA $16
    LDA $player_y
    SEC 
    SBC #$0010            ; The player's tile is at y - 16 (the position is the feet)
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    SEP #$20
    LDA $7E8000, X
    CMP #$FE              ; $FE = the green switch left by SealLair
    BNE loc_010A09
    LDA $boss_fight_active ; No lair release during a boss fight
    BNE loc_010A28
    JSL $@ReleaseLairAtSwitch
    BRA loc_010A1B

  loc_010A09:
    JSL $@TriggerVariantPlate
    BCS loc_010A1B
    JSL $@TryOpenChest
    BCS loc_010A1B

  loc_010A15:
    JSL $@CheckExitRegions
    BCC loc_010A28

  loc_010A1B:
    REP #$20
    LDX $player_actor
    STZ $0004, X          ; A trigger fired: the player's velocity (dx, dy) is zeroed
    STZ $0006, X
    SEP #$20

  loc_010A28:
    RTL 
}

---------------------------------------------
; Opens the chest above the player when the player faces up and the chest has not been opened.
; 
; When: CheckPlayerTileTriggers, when the tile under the player is not a switch and no plate fired.
; Sees: the chest tile opens, the message box shows 'Nothing inside', '<item> recieved' or 'found N GEMs' (the walkthrough: chests with Gems or items, 02-grass-valley.md line 47).
; Why: chest data is a list (ChestListPointers), so any room can hold chests without an actor.
; In: M = 1. Row of ChestListPointers (6 bytes): +0 x, +1 y of the tile the player stands on, +2 chest id (bit 7 = tile on both layers; the low 7 bits index the array $1A7E), +3 content (0 = empty, $FF = Gems, otherwise the inventory entry), +4 word Gem amount.
; Out: carry clear = nothing happened. Carry set = the chest opened: the tile at (player_x, player_y - $20) must be $FB, becomes $FC (SetMetatileBg1 or ...Bg1Bg2), the chest bit is set, BRK #$15, the text box opens (WaitFrames with A = $1E); an item goes through StoreInventoryEntry (BRK #$9E); Gems go through lib_player_stats.AddGems with hud_dirty_flags |= $10 (BRK #$8D); an empty chest prints 'Nothing inside'. text_arg carries the entry or the amount.
; Clobbers: A, X, Y, text_arg.

TryOpenChest {
    JSL $@lib_player_facing.GetPlayerFacing
    BCS loc_010A5A        ; Carry set = no facing direction; A = 0 is the up direction (the chest is above the player)
    CMP #$00
    BNE loc_010A5A
    LDX $chest_list_ofs

  loc_010A36:
    LDA $&data_chest_lists.ChestListPointers, X
    CMP #$FF
    BEQ loc_010A5A
    LDA $player_tile_x
    CMP $&data_chest_lists.ChestListPointers, X
    BNE loc_010A4D
    LDA $player_tile_y
    CMP $&data_chest_lists.ChestListPointers+1, X
    BEQ loc_010A5C

  loc_010A4D:
    REP #$20
    TXA 
    CLC 
    ADC #$0006
    TAX 
    SEP #$20
    BRL loc_010A36

  loc_010A5A:
    CLC 
    RTL 

  loc_010A5C:
    TXY 
    REP #$20
    LDA $player_x
    STA $16
    LDA $player_y
    SEC 
    SBC #$0020
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    SEP #$20
    LDA $7E8000, X
    CMP #$FB              ; $FB = closed chest; SetMetatile writes $FC (open)
    BNE loc_010A5A
    TYX 
    LDA #$00
    XBA 
    LDA $&data_chest_lists.ChestListPointers+2, X
    AND #$7F
    LDY #$1A7E
    JSL $@lib_bit_array.TestBitInArray ; Tests bit (id and $7F) of the chest array $1A7E: carry = already opened
    BCS loc_010A5A
    JSL $@lib_bit_array.SetBitInArray
    BRK #$15
    LDA $&data_chest_lists.ChestListPointers+2, X
    BMI loc_010AA0        ; Bit 7 of the id: the chest tile exists on both layers
    LDA #$FC
    JSL $@lib_0109D6_part1.SetMetatileBg1
    BRA loc_010AA6

  loc_010AA0:
    LDA #$FC
    JSL $@lib_0109D6_part1.SetMetatileBg1Bg2

  loc_010AA6:
    LDA #$1E
    JSL $@lib_text_render.WaitFrames
    LDA $&data_chest_lists.ChestListPointers+3, X
    STA $text_arg
    STZ $text_arg+1
    BEQ loc_010ACA        ; Content byte: 0 = empty chest, $FF = Gems (amount at +4), anything else = the inventory entry
    CMP #$FF
    BEQ loc_010AD3
    JSL $@lib_0109D6_part3.StoreInventoryEntry
    LDY #$&ChestItemReceivedText
    JSL $@lib_text_render.ShowDialogueText
    BRK #$9E
    SEC 
    RTL 

  loc_010ACA:
    LDY #$&ChestEmptyText
    JSL $@lib_text_render.ShowDialogueText
    SEC 
    RTL 

  loc_010AD3:
    REP #$20
    LDA $&data_chest_lists.ChestListPointers+4, X
    STA $text_arg
    JSL $@lib_player_stats.AddGems
    LDA #$0010
    TSB $hud_dirty_flags
    SEP #$20
    LDY #$&ChestGemsFoundText
    JSL $@lib_text_render.ShowDialogueText
    BRK #$8D
    SEC 
    RTL 
}

---------------------------------------------
; Warps the player when it stands inside an exit region of the room.
; 
; When: CheckPlayerTileTriggers, every frame (also when the player is not on the 16-pixel grid).
; Sees: walking through a doorway, a room edge or a ladder starts the next scene.
; Why: exits are rectangles in a list (ExitListPointers), so the room needs no script for them.
; In: M = 1; exit_list_ofs (0 = no list). Row (11 bytes): +0 x, +1 y, +2 width, +3 height (tiles), +4 area, +5 scene, +6 arrival animation, +7 word arrival x, +9 word arrival y; an $FF byte ends the list.
; Out: no match: carry clear. A match needs the player's tile inside the rectangle and then its pixel position inside the rectangle shrunk by 15 pixels: area_next, scene_next, warp_dest_anim, warp_dest_x and warp_dest_y are set and carry is set.
; Clobbers: A, X, Y, dp $00-$06 (P restored).

CheckExitRegions {
    PHP 
    LDX $exit_list_ofs
    BEQ loc_010B23

  loc_010AF8:
    LDA $&data_exit_lists.ExitListPointers, X
    CMP #$FF
    BEQ loc_010B23
    LDA $player_tile_x
    SEC 
    SBC $&data_exit_lists.ExitListPointers, X
    CMP $&data_exit_lists.ExitListPointers+2, X ; Tile test: player tile - region origin, unsigned, must be below the size
    BCS loc_010B17
    LDA $player_tile_y
    SEC 
    SBC $&data_exit_lists.ExitListPointers+1, X
    CMP $&data_exit_lists.ExitListPointers+3, X
    BCC loc_010B26

  loc_010B17:
    REP #$20
    TXA 
    CLC 
    ADC #$000B
    TAX 
    SEP #$20
    BRA loc_010AF8

  loc_010B23:
    PLP 
    CLC 
    RTL 

  loc_010B26:
    REP #$20
    LDA $&data_exit_lists.ExitListPointers, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $00
    LDA $&data_exit_lists.ExitListPointers+1, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    CLC 
    ADC #$0010
    STA $02
    LDA $&data_exit_lists.ExitListPointers+2, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    SEC 
    SBC #$000F
    STA $04
    LDA $&data_exit_lists.ExitListPointers+3, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    SEC 
    SBC #$000F
    STA $06
    LDA $player_x
    SEC 
    SBC $00               ; Pixel test: the region shrunk by 15 pixels, so the warp starts only when the player is well inside
    CMP $04
    BCS loc_010B23
    LDA $player_y
    SEC 
    SBC $02
    CMP $06
    BCS loc_010B23
    SEP #$20
    LDA $&data_exit_lists.ExitListPointers+4, X ; Destination of the exit: area, scene, arrival animation, x and y from the region row
    STA $area_next
    LDA $&data_exit_lists.ExitListPointers+5, X
    STA $scene_next
    LDA $&data_exit_lists.ExitListPointers+6, X
    STA $warp_dest_anim
    LDY $&data_exit_lists.ExitListPointers+7, X
    STY $warp_dest_x
    LDY $&data_exit_lists.ExitListPointers+9, X
    STY $warp_dest_y
    PLP 
    SEC 
    RTL 
}

---------------------------------------------
; Applies the next map variant when the player steps on an active pressure plate.
; 
; When: CheckPlayerTileTriggers, when the tile under the player is not a switch.
; Sees: part of the room changes with a sweep when the player steps on a plate of a released lair, and the next plate takes over.
; Why: a room alternates between two map variants (slabs 2 and 3) driven by plate_variant.
; In: M = 1; plate_list_ofs. Row of PlateListPointers (4 bytes): +0 x, +1 y of the plate tile, +2 word lair record index (also the bit number in $1A9E).
; Out: carry clear = no plate at the player's tile, or its bit in $1A9E is clear (the plate is inactive until the lair is released). Carry set: the lair record's bytes 0-7 are copied to $1C6D, release_slab = plate_variant + 2, CopyMapRectFromSlab, a 35-frame BG1 sweep; then plate_variant is toggled and plate_list_ofs is taken from the entry of the other variant in the pair at plate_lists_ofs.
; Clobbers: A, X, Y, dp $0E, $10, $16, $18 and the rectangle variables $1C62-$1C75.

TriggerVariantPlate {
    LDX $plate_list_ofs

  loc_010B9E:
    LDA $&data_plate_lists.PlateListPointers, X
    CMP #$FF
    BEQ loc_010C23
    CMP $player_tile_x
    BNE loc_010C1C
    LDA $&data_plate_lists.PlateListPointers+1, X
    CMP $player_tile_y
    BNE loc_010C1C
    LDA $&data_plate_lists.PlateListPointers+3, X
    XBA 
    LDA $&data_plate_lists.PlateListPointers+2, X
    LDY #$1A9E
    JSL $@lib_bit_array.TestBitInArray ; Bit n of $1A9E (lair n released): a plate works only after its lair was released
    BCC loc_010C23
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
    MVN #$01, #$^data_lair_records.LairRecords ; Copies record bytes 0-7 to $1C6D-$1C74 (slab, rectangle)
    SEP #$20
    LDA $plate_variant
    CLC 
    ADC #$02
    STA $release_slab     ; Slab = plate_variant + 2 (the variant slabs are 2 and 3)
    JSR $&lib_scene_map_patches.CopyMapRectFromSlab
    LDA #$01
    STA $sweep_step       ; Starts the sweep at step 1
    INC $sweep_bg1        ; sweep_bg1 = 1: the sweep redraws BG1 (0 redraws BG2)
    LDA #$23              ; 35 frames = the 35 sweep steps

  loc_010BF2:
    JSL $@engine_boot_main_loop.RunSubFrameMapSweep
    DEC 
    BNE loc_010BF2
    STZ $sweep_bg1
    REP #$20
    LDX $plate_lists_ofs
    LDA $plate_variant
    EOR #$0001
    STA $plate_variant
    BEQ loc_010C0E
    INX 
    INX 

  loc_010C0E:
    LDA $&data_plate_lists.PlateListPointers, X
    SEC 
    SBC #$&data_plate_lists.PlateListPointers
    STA $plate_list_ofs
    SEP #$20
    SEC 
    RTL 

  loc_010C1C:
    INX 
    INX 
    INX 
    INX 
    BRL loc_010B9E

  loc_010C23:
    CLC 
    RTL 
}

---------------------------------------------
; Releases the lair whose green switch the player stands on: opens a path or frees an NPC.
; 
; When: CheckPlayerTileTriggers, when the tile at (player_x, player_y - 16) is $FE and no boss fight is running.
; Sees: the switch disappears; either a stretch of the room changes with a sweep (a path opens) or the screen changes to the NPC's home (the NPC goes home).
; Why: all lair rewards are rows of LairRecords, so one routine serves every lair.
; In: M = 1; X = map offset of the switch tile (dp$00 keeps it); player_tile_x/y; location_id.
; Out: no matching record (location, tile): nothing. Otherwise: lairs_left decremented (if non-zero), the switch tile = $FF in BG1 (and BG2 when +8 is non-zero), then the path or NPC case described in the block note; the NPC case for a home elsewhere ends with return_active incremented and RTL.
; Clobbers: A, X, Y, dp $00, $16, $18 and the rectangle variables $1C6D-$1C75.

ReleaseLairAtSwitch {
    STX $00
    LDX #$0000
    TXY 

  loc_010C2B:
    LDA $&data_lair_records.LairRecords, X ; Record search: +B = location, +C / +D = lair tile; the table ends at an $FF in byte 0
    CMP #$FF
    BEQ loc_010C57
    LDA $&data_lair_records.LairRecords+B, X
    CMP $location_id
    BNE loc_010C4A
    LDA $&data_lair_records.LairRecords+C, X
    CMP $player_tile_x
    BNE loc_010C4A
    LDA $&data_lair_records.LairRecords+D, X
    CMP $player_tile_y
    BEQ loc_010C58

  loc_010C4A:
    REP #$20
    TXA 
    CLC 
    ADC #$0020
    TAX 
    SEP #$20
    INY 
    BRA loc_010C2B

  loc_010C57:
    RTL 

  loc_010C58:
    LDA $lairs_left       ; One lair less in this location (read by the pause code)
    BEQ loc_010C60
    DEC $lairs_left

  loc_010C60:
    PHX 
    LDA $&data_lair_records.LairRecords+8, X
    PHP 
    LDX $00
    LDA #$FF
    STA $7E8000, X        ; The switch tile becomes $FF (cleared)
    PLP 
    BEQ loc_010C74
    STA $7EC000, X        ; Record byte +8 non-zero: the lair tile is on BG2 too

  loc_010C74:
    PLX 
    LDA $&data_lair_records.LairRecords+E, X ; +E / +F = the staging rectangle; both zero = the lair frees an NPC instead of opening a path
    ORA $&data_lair_records.LairRecords+F, X
    BNE loc_010C80
    BRL loc_010D18

  loc_010C80:
    PHX 
    LDA $&data_lair_records.LairRecords+A, X
    ORA #$80
    TYX 
    STA $lair_state, X    ; lair_state = +A or $80: released, no monsters left (the path case)
    REP #$20
    TYA 
    LDY #$1ADE
    JSL $@lib_bit_array.SetBitInArray ; Sets bit n (the lair index) in the switch array $1ADE, then in the released array $1A9E
    LDY #$1A9E
    JSL $@lib_bit_array.SetBitInArray
    SEP #$20
    PLX 
    LDA $&data_lair_records.LairRecords, X
    CMP $location_id
    BNE loc_010CFD
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
    PHX 
    TXA 
    CLC 
    ADC #$&data_lair_records.LairRecords
    TAX 
    LDY #$1C6D
    LDA #$0007
    MVN #$01, #$^data_lair_records.LairRecords
    PLX 
    SEP #$20
    LDA $&data_lair_records.LairRecords+8, X ; +8: 0 = BG1 only, bit 0 = both layers
    BEQ loc_010CFA
    LSR 
    BCC loc_010CE1
    JSR $&lib_scene_map_patches.CopyMapRectFromStagingBothLayers
    BRA loc_010CE4

  loc_010CE1:
    JSR $&lib_scene_map_patches.CopyMapRectFromStaging

  loc_010CE4:
    BRK #$94
    JSL $@engine_boot_main_loop.RunSubFrameMapSweep
    LDA #$01
    STA $sweep_step       ; Sweep 1 of 2: BG2 (sweep_bg1 is still 0)
    LDA #$23

  loc_010CF1:
    JSL $@engine_boot_main_loop.RunSubFrameMapSweep
    DEC 
    BNE loc_010CF1
    BRA loc_010D03

  loc_010CFA:
    JSR $&lib_scene_map_patches.CopyMapRectFromStaging

  loc_010CFD:
    JSL $@engine_boot_main_loop.RunSubFrameMapSweep
    BRK #$94

  loc_010D03:
    LDA #$01
    STA $sweep_step
    INC $sweep_bg1        ; Sweep 2 of 2: BG1
    LDA #$23

  loc_010D0D:
    JSL $@engine_boot_main_loop.RunSubFrameMapSweep
    DEC 
    BNE loc_010D0D
    STZ $sweep_bg1
    RTL 

  loc_010D18:
    PHX 
    LDA $&data_lair_records.LairRecords+A, X
    ORA #$C0
    TYX 
    STA $lair_state, X    ; lair_state = +A or $C0: released, the NPC's return is pending (the NPC case)
    PLX 
    LDA $&data_lair_records.LairRecords, X
    CMP $location_id
    BNE loc_010D54
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
    LDA #$01
    STA $tile_type_map, X ; Type 1 on the NPC's home tile: RunLairReleaseOnReturn looks for it
    BRA loc_010CFD

  loc_010D54:
    BRK #$98
    LDA $area_current
    STA $return_area      ; The home is elsewhere: save the return point (area, scene, x, y - 16) and warp to the NPC
    LDA $scene_current
    STA $return_scene
    LDA $&data_lair_records.LairRecords+1D, X
    STA $warp_dest_anim
    REP #$20
    LDA $player_x
    STA $return_x
    LDA $player_y
    SEC 
    SBC #$0010
    STA $return_y
    LDA $&data_lair_records.LairRecords+2, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $warp_dest_x
    LDA $&data_lair_records.LairRecords+3, X
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $warp_dest_y
    LDA $&data_lair_records.LairRecords, X
    AND #$00FF
    ASL 
    TAX 
    SEP #$20
    LDA #$80
    STA $transition_type
    LDA $@LocationAreaScene, X ; Area and scene of the NPC's home location (word per location: low byte area, high byte scene)
    STA $area_next
    LDA $@LocationAreaScene+1, X
    STA $scene_next
    LDA #$20
    STA $asset_skip_mask
    STY $return_record    ; The lair record index, read by Cop30 in the home scene
    INC $return_active    ; Starts the return trip: the main loop switches to RunReturnLoop
    RTL 
}
---------------------------------------------

; Plays the 'NPC released' scene in the NPC's home location.
; 
; When: RunLairReleaseOnReturn, when the player stands on the type 1 tile.
; Sees: the message '<name> released', then the NPC's spot is redrawn in four steps with a sweep each (the walkthrough: the freed NPC returns home).
; Why: lets the home scene show what the player did elsewhere.
; In: M = 1; player_tile_x/y; location_id. Record = the one whose +0 is this location and +2 / +3 are the player's tile (the table ends at a first byte of $80 or more).
; Out: text_arg = record +9, the message printed, the lair's bit $40 cleared, release_slab = 0-3 in turn with CopyMapRectFromSlab and a 35-frame BG1 sweep each (only one frame when the rectangle width is 0); the arrays $1A9E and $1ADE get the lair's bit set. A block that computes the NPC tile's map offset + 4 map sizes is dead (OQ-I026-6).
; Clobbers: A, X, Y, dp $00, $01, $16, $18 and the rectangle variables.

PlayLairReleaseScene {
    LDX #$0000
    TXY 

  loc_010DC1:
    LDA $&data_lair_records.LairRecords, X
    BMI loc_010DE8
    CMP $location_id
    BNE loc_010DDB
    LDA $&data_lair_records.LairRecords+2, X
    CMP $player_tile_x
    BNE loc_010DDB
    LDA $&data_lair_records.LairRecords+3, X
    CMP $player_tile_y
    BEQ loc_010DE9

  loc_010DDB:
    REP #$20
    TXA 
    CLC 
    ADC #$0020
    TAX 
    INY 
    SEP #$20
    BRA loc_010DC1

  loc_010DE8:
    RTL 

  loc_010DE9:
    LDA $&data_lair_records.LairRecords+9, X ; Record +9: the NPC name index for the message
    STA $text_arg
    STZ $text_arg+1
    PHX 
    PHY 
    LDY #$&LairNpcReleasedText
    JSL $@lib_text_render.ShowDialogueText
    JSL $@engine_boot_main_loop.RunSubFrameMapSweep
    PLY 
    PLX 
    PHX 
    TYX 
    LDA $lair_state, X
    AND #$BF              ; Clears bit 6: the NPC's return is no longer pending
    STA $lair_state, X
    PLX 
    REP #$20
    TYA 
    PHA 
    TXA 
    CLC 
    ADC #$&data_lair_records.LairRecords
    TAX 
    LDY #$1C6D
    LDA #$0007
    MVN #$01, #$^data_lair_records.LairRecords
    LDA $release_npc_x
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $16
    LDA $release_npc_y
    AND #$00FF
    ASL 
    ASL 
    ASL 
    ASL 
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    PHX 
    SEP #$20
    LDA $map_width_pages
    XBA 
    LDA $map_height_pages
    JSL $@lib_arithmetic.Multiply8x8
    STA $01
    STZ $00
    LDY #$0004

  loc_010E52:
    REP #$20
    TXA 
    CLC 
    ADC $00
    TAX 
    SEP #$20
    CPX #$4000
    BCS loc_010E63
    DEY 
    BNE loc_010E52

  loc_010E63:
    PLX 
    BRK #$9C
    LDA $release_rect_w   ; Rectangle width 0: nothing to copy, one frame only
    BNE loc_010E74
    STZ $sweep_step
    JSL $@engine_boot_main_loop.RunSubFrameMapSweep
    BRA loc_010E95

  loc_010E74:
    JSR $&lib_scene_map_patches.CopyMapRectFromSlab
    LDA #$01
    STA $sweep_step
    INC $sweep_bg1
    LDA #$23

  loc_010E81:
    JSL $@engine_boot_main_loop.RunSubFrameMapSweep
    DEC 
    BNE loc_010E81
    STZ $sweep_bg1
    INC $release_slab
    LDA $release_slab
    CMP #$04              ; Slabs 0-3 in turn
    BCC loc_010E74

  loc_010E95:
    REP #$20
    PLA 
    LDY #$1A9E
    JSL $@lib_bit_array.SetBitInArray
    LDY #$1ADE
    JSL $@lib_bit_array.SetBitInArray
    SEP #$20
    RTL 
}

---------------------------------------------
; Per-frame hook of the return loop: starts the release scene or reports that the NPC cannot be recalled yet.
; 
; When: every frame of RunReturnLoop.
; Sees: after the warp to the NPC's home scene, the release message appears; if the player is not on the home tile the text says the NPC cannot be recalled yet.
; Why: the return loop is generic; this hook ties it to the lair that started the trip (return_record).
; In: player_x, player_y, return_record (the routine sets M itself).
; Out: the tile under the player has type 1: PlayLairReleaseScene runs. Otherwise text_arg = the name index of record return_record and 'cannot be recalled yet!' is printed.
; Clobbers: A, X, Y, text_arg.

RunLairReleaseOnReturn {
    REP #$20
    LDA $player_x
    STA $16
    LDA $player_y
    SEC 
    SBC #$0010
    STA $18
    JSL $@lib_map_index_helpers.PixelToMapIndex
    SEP #$20
    LDA $tile_type_map, X
    CMP #$01              ; Type 1 under the player: the marker ReleaseLairAtSwitch left on the NPC's home tile
    BNE loc_010ECC
    JSL $@PlayLairReleaseScene
    RTL 

  loc_010ECC:
    REP #$20
    LDA $return_record
    ASL 
    ASL 
    ASL 
    ASL 
    ASL 
    TAX 
    SEP #$20
    LDA $&data_lair_records.LairRecords+9, X
    STA $text_arg
    STZ $text_arg+1
    LDY #$&LairNpcNotRecalledText ; '<name> cannot be recalled yet!'
    JSL $@lib_text_render.ShowDialogueText
    RTL 
}
---------------------------------------------

; Pointer table of the 53 NPC and object names used in the release and chest messages.
; 
; When: the text code [TBL:&NpcNameStrings,03C8] with text_arg = the name index (lair record +9).
; Sees: '<name> released', '<name> cannot be recalled yet!'; the names are the freed NPC's description ('an old man', 'Lisa', 'The village Chief', 'a dog, Turbo', 'King Magridd', 'Dr-Leo', 'the doll, Marie' ...).
; Why: the message is shared, only the name changes.
; In: n/a (data). 53 words (index $00-$34), each the address of an ASCII string a few lines below.
; Out: n/a. Spelling differences with the walkthrough are OQ-I008-14 and OQ-I008-15.
; Clobbers: n/a.

NpcNameStrings [
  &asciistring_015350   ;00
  &asciistring_015359   ;01
  &asciistring_015364   ;02
  &asciistring_015369   ;03
  &asciistring_01536E   ;04
  &asciistring_015376   ;05
  &asciistring_015384   ;06
  &asciistring_01538F   ;07
  &asciistring_0153A4   ;08
  &asciistring_0153B4   ;09
  &asciistring_0153BA   ;0A
  &asciistring_0153C7   ;0B
  &asciistring_0153CD   ;0C
  &asciistring_0153D1   ;0D
  &asciistring_0153E4   ;0E
  &asciistring_0153EE   ;0F
  &asciistring_0153F4   ;10
  &asciistring_0153FF   ;11
  &asciistring_01540D   ;12
  &asciistring_01541C   ;13
  &asciistring_015422   ;14
  &asciistring_015427   ;15
  &asciistring_01542F   ;16
  &asciistring_015435   ;17
  &asciistring_01543A   ;18
  &asciistring_015443   ;19
  &asciistring_01544C   ;1A
  &asciistring_015457   ;1B
  &asciistring_01545E   ;1C
  &asciistring_01546C   ;1D
  &asciistring_01547D   ;1E
  &asciistring_015482   ;1F
  &asciistring_015488   ;20
  &asciistring_015490   ;21
  &asciistring_015498   ;22
  &asciistring_01549F   ;23
  &asciistring_0154A5   ;24
  &asciistring_0154AF   ;25
  &asciistring_0154BC   ;26
  &asciistring_0154C2   ;27
  &asciistring_0154CE   ;28
  &asciistring_0154D3   ;29
  &asciistring_0154DA   ;2A
  &asciistring_0154E1   ;2B
  &asciistring_0154F1   ;2C
  &asciistring_0154F7   ;2D
  &asciistring_015504   ;2E
  &asciistring_015511   ;2F
  &asciistring_01551A   ;30
  &asciistring_015520   ;31
  &asciistring_015528   ;32
  &asciistring_015531   ;33
  &asciistring_015538   ;34
]

asciistring_015350 |an old man|

asciistring_015359 |an old woman|

asciistring_015364 |a boy|

asciistring_015369 |Lisa|

asciistring_01536E |The village Chief|

asciistring_015376 |The bridge guard|

asciistring_015384 |an architect|

asciistring_01538F |tool shop owner s son|

asciistring_0153A4 |tool shop owner|

asciistring_0153B4 |a goat|

asciistring_0153BA |a lonely goat|

asciistring_0153C7 |tulip|

asciistring_0153CD |ivy|

asciistring_0153D1 |The water mill keeper|

asciistring_0153E4 |a squirrel|

asciistring_0153EE |a deer|

asciistring_0153F4 |a crocodile|

asciistring_0153FF |a dog, "Turboˮ|

asciistring_01540D |Wood s guardian|

asciistring_01541C |a mole|

asciistring_015422 |none|

asciistring_015427 |The village Chief|

asciistring_01542F |a bird|

asciistring_015435 |a dog|

asciistring_01543A |a mermaid|

asciistring_015443 |a dolphin|

asciistring_01544C |an angelfish|

asciistring_015457 |the Queen|

asciistring_01545E |the dolphin, Lue|

asciistring_01546C |a mermaid s statue|

asciistring_01547D |a boy|

asciistring_015482 |a girl|

asciistring_015488 |Grandpa|

asciistring_015490 |Grandma|

asciistring_015498 |a snail|

asciistring_01549F |the King|

asciistring_0154A5 |a mushroom|

asciistring_0154AF |the snail, Nome|

asciistring_0154BC |steps|

asciistring_0154C2 |a great door|

asciistring_0154CE |a cat|

asciistring_0154D3 |a plant|

asciistring_0154DA |a mouse|

asciistring_0154E1 |a chest of drawers|

asciistring_0154F1 |a doll|

asciistring_0154F7 |the doll, Marie|

asciistring_015504 |a model of town|

asciistring_015511 |a soldier|

asciistring_01551A |a maid|

asciistring_015520 |a singer|

asciistring_015528 |King Magridd|

asciistring_015531 |Dr-Leo|

asciistring_015538 |Queen|
---------------------------------------------

; '<NPC> cannot be recalled yet!' message.
; 
; When: RunLairReleaseOnReturn, in the home location of a freed NPC, when the tile under the player is not the type-1 marker that ReleaseLairAtSwitch left on the NPC's home tile (so the release scene cannot play).
; Sees: the standard dialogue box with the NPC's description in the highlight attribute ($24) and 'cannot be recalled yet!'.
; Why: the return trip is only completed on the home tile; anywhere else the player is told so.
; In: n/a (data). text_arg = the NPC name index (lair record +9); [TBL:&NpcNameStrings,03C8] prints it.
; Out: n/a. Ends through [JMP:&ChestGemsFoundText+M]: key wait and box erase.
; Clobbers: n/a.

LairNpcNotRecalledText |[10][03:24][TBL:&NpcNameStrings,03C8][03:20][N]cannot be recalled [N]yet! [JMP:&ChestGemsFoundText+M]|

---------------------------------------------
; '<hero> released <NPC>-' message.
; 
; When: PlayLairReleaseScene, once the freed NPC has appeared at its home tile.
; Sees: the player name ([02:2]) followed by 'released' and, on the next line, the NPC's description.
; Why: the Monster Lair release has no script, so the engine prints the message itself.
; In: n/a (data). text_arg = the NPC name index (lair record +9).
; Out: n/a. Ends through [JMP:&ChestGemsFoundText+M].
; Clobbers: n/a.

LairNpcReleasedText |[10][02:2] released [N][03:24][TBL:&NpcNameStrings,03C8][03:20]-[JMP:&ChestGemsFoundText+M]|
---------------------------------------------

; '<hero> recieved <item>-' chest message (the ROM spells it 'recieved').
; 
; When: TryOpenChest, when the chest content byte is an item id; after StoreInventoryEntry has stored the item.
; Sees: the player name, 'recieved' and the item name on the second line.
; Why: every chest uses this one string; the item changes through text_arg.
; In: n/a (data). text_arg = the item id; [TBL:&ItemNameList,03C8] prints its name.
; Out: n/a. Ends through [JMP:&ChestGemsFoundText+M].
; Clobbers: n/a.

ChestItemReceivedText |[10] [02:2] recieved[N] [03:24][TBL:&lib_menus.ItemNameList,03C8][03:20]-[JMP:&ChestGemsFoundText+M]|

---------------------------------------------
; ' Nothing inside-' chest message.
; 
; When: TryOpenChest, when the content byte of the chest row is 0.
; Sees: 'Nothing inside-' in the dialogue box.
; Why: an empty chest still opens and needs a message.
; In: n/a (data).
; Out: n/a. Ends through [JMP:&ChestGemsFoundText+M].
; Clobbers: n/a.

ChestEmptyText |[10] Nothing inside-[JMP:&ChestGemsFoundText+M]|
---------------------------------------------

; '<hero> found <n> GEMs-' chest message and the shared tail of the five chest and lair messages.
; 
; When: TryOpenChest, when the content byte is $FF (the amount is the word at row +4, added to the Gem counter by lib_player_stats.AddGems); the other four strings jump into its '+M' entry.
; Sees: the player name, 'found' and the amount with ' GEMs-' on the second line ([03:24] sets the highlight attribute for the number); then the box waits for a key and disappears. The ROM text spells 'GEMs', the walkthrough 'Gems'.
; Why: the key wait and box erase are written once, in the part that every message reaches.
; In: n/a (data). text_arg = the Gem amount as packed BCD, 3 digits ([06:3,03C8]); entered at [::] by the other messages, where text_arg means something else.
; Out: n/a. [12] waits for a key, [08:408] erases the dialogue box window, [END].
; Clobbers: n/a.

ChestGemsFoundText |[10] [02:2] found[N][03:24][06:3,03C8] GEMs-[03:20][::][12][08:408][END]|
---------------------------------------------

; Table of the (area, scene) pair of every location id.
; 
; When: ReleaseLairAtSwitch, to warp to the NPC's home location (record +0).
; Sees: the destination of the return trip.
; Why: the lair record stores the location id, the scene loader wants area and scene.
; In: n/a (data). 130 words indexed by location_id x 2: low byte = area, high byte = scene; unused locations hold 0.
; Out: n/a.
; Clobbers: n/a.

LocationAreaScene [
  #$0100   ;00
  #$0101   ;01
  #$0201   ;02
  #$0301   ;03
  #$0401   ;04
  #$0102   ;05
  #$0202   ;06
  #$0103   ;07
  #$0203   ;08
  #$0303   ;09
  #$0403   ;0A
  #$0503   ;0B
  #$0603   ;0C
  #$0800   ;0D
  #$0302   ;0E
  #$0900   ;0F
  #$0A00   ;10
  #$0B00   ;11
  #$0C00   ;12
  #$0D00   ;13
  #$0200   ;14
  #$0104   ;15
  #$0204   ;16
  #$0304   ;17
  #$0404   ;18
  #$0105   ;19
  #$0205   ;1A
  #$0305   ;1B
  #$0405   ;1C
  #$0505   ;1D
  #$0605   ;1E
  #$0705   ;1F
  #$0805   ;20
  #$0905   ;21
  #$0A05   ;22
  #$0504   ;23
  #$0604   ;24
  #$0000   ;25
  #$0000   ;26
  #$0000   ;27
  #$0300   ;28
  #$0106   ;29
  #$0107   ;2A
  #$0207   ;2B
  #$0307   ;2C
  #$0407   ;2D
  #$0108   ;2E
  #$0208   ;2F
  #$0308   ;30
  #$0408   ;31
  #$0109   ;32
  #$0209   ;33
  #$0507   ;34
  #$0000   ;35
  #$0000   ;36
  #$0000   ;37
  #$0000   ;38
  #$0000   ;39
  #$0000   ;3A
  #$0000   ;3B
  #$0400   ;3C
  #$010A   ;3D
  #$010B   ;3E
  #$020B   ;3F
  #$030B   ;40
  #$040B   ;41
  #$050B   ;42
  #$060B   ;43
  #$070B   ;44
  #$010C   ;45
  #$020C   ;46
  #$030C   ;47
  #$0000   ;48
  #$0000   ;49
  #$0000   ;4A
  #$0000   ;4B
  #$0000   ;4C
  #$0000   ;4D
  #$0000   ;4E
  #$0000   ;4F
  #$0500   ;50
  #$010D   ;51
  #$020D   ;52
  #$030D   ;53
  #$040D   ;54
  #$050D   ;55
  #$010E   ;56
  #$020E   ;57
  #$030E   ;58
  #$040E   ;59
  #$050E   ;5A
  #$010F   ;5B
  #$020F   ;5C
  #$0000   ;5D
  #$0000   ;5E
  #$0000   ;5F
  #$0000   ;60
  #$0000   ;61
  #$0000   ;62
  #$0000   ;63
  #$0600   ;64
  #$0110   ;65
  #$0111   ;66
  #$0211   ;67
  #$0311   ;68
  #$0411   ;69
  #$0112   ;6A
  #$0212   ;6B
  #$0312   ;6C
  #$0412   ;6D
  #$0512   ;6E
  #$0612   ;6F
  #$0712   ;70
  #$0113   ;71
  #$0213   ;72
  #$0313   ;73
  #$0000   ;74
  #$0000   ;75
  #$0000   ;76
  #$0000   ;77
  #$0700   ;78
  #$0114   ;79
  #$0214   ;7A
  #$0314   ;7B
  #$0115   ;7C
  #$0215   ;7D
  #$0000   ;7E
  #$0000   ;7F
  #$0000   ;80
  #$0000   ;81
]