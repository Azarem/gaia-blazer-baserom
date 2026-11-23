; Scene asset loader, Quintet LZ expander and boot hardware reset (file offsets 78281-78288 and 78450-80601, SNES $02:B1C9 and $02:B272-$BAD9, bank 02).
; 
; === MODEL ===
; Every scene change calls LoadSceneAssets once (lib_scene_change_init InitSceneState), after the scene-change code has put the PPU in forced blank with NMI off. So every VRAM, CGRAM-buffer and WRAM write below happens without a vblank check. dp$2F-$31 is the long pointer to the asset list (SceneAssetLists, $05:8000), set once at boot by InitHardwareAndClearWram.
; The asset list has one record per scene: area, scene, commands, then a 00 byte. FindSceneRecord walks the records from the top and stops at the first whose scene equals scene_current ($0316) and whose area equals area_current ($0314). The first record is a dummy (area $53, scene $59) with no commands and the list has no end sentinel (OQ-I011-3). The other 97 records are exactly the 97 scenes that have a scene profile.
; A command byte has exactly one bit set. LoadSceneAssets reads one command at a time and tries the bits from $80 down to $01 (a BIT ladder), calls the handler, which reads its own operands with ReadAssetByte, and stops on a 00 byte:
;   $80 graphics   6 operand bytes  b0 start, b1 end (512-byte units, b0 bit 7 = raw), b2 VRAM page (word address b2 << 8), 3-byte pointer. LoadSceneGraphics. Skipped when asset_skip_mask bit 3 is set
;   $40 palette    6 operand bytes  b0 first source colour, b1 end colour, b2 destination colour, pointer. LoadScenePalette. Skip bit 2
;   $20 tileset    7 operand bytes  b0 start, b1 end (64-byte units, b0 bit 7 = raw), b2 destination offset, b3 layer mask (1 BG1, 2 BG2), pointer. LoadMetatileDefs. Skip bit 1
;   $10 tilemap    4 operand bytes  type (1 BG1, 2 BG2, 0 Mode 7), pointer. LoadSceneTilemap. Skip bit 0
;   $08 asset8     1 operand byte   id below $80 = scene profile, $80-$BF = jump to the label id or $40, $C0-$FF = a label. ApplySceneProfile. Never skipped
;   $04 meta4      3 operand bytes  ignored. SkipMeta4Command (no record uses it)
;   $02 music      5 operand bytes  b0 start command, b1 variant, pointer. LoadSceneMusic. Skip bit 5
;   $01 spritemap  6 operand bytes  b0 (0 = $7E:3800, else $7E:F000), b1 and b2 ignored, pointer. LoadSceneSpritemap. Skip bit 4
; Shared segments are how scenes of one world share graphics: an asset8 jump (id $80-$BF) makes FindAssetLabel scan the whole list for the matching label ($C0-$FF) and the walk continues after that label in the OTHER record, up to that record's 00. The 65 jumps in the list go to 37 labels.
; 
; === STREAM POINTERS AND CACHE ===
; Every asset pointer in a record is a 3-byte linear FILE OFFSET (lo, mid, hi). ReadAssetPointer converts it to a LoROM address in dp$29-$2B: bank = offset >> 15, address = $8000 + (offset and $7FFF). Ten 3-byte cache cells at $0407-$0424 remember the pointer of the last asset loaded into a slot: graphics by VRAM page (asset_cache_gfx0-3 for b2 $00, $10, $20, $30), tileset per layer (asset_cache_tileset1/2), tilemap per layer (asset_cache_tilemap1/2), spritemap and music. CheckAssetCache compares the new pointer with the cell, stores it and says 'load' (carry set) only when different, so entering a scene that uses the same assets in the same slots costs nothing. Palettes have no cache. A graphics b2 other than $00/$10/$20/$30 ($40 and $FF), and a tileset or tilemap type other than 1 or 2, zero the cells of that kind and always load. A zeroed cell forces a reload: other code zeroes cells to invalidate them. The cache keys on the pointer only, not on the range (b0, b1); no two commands of the shipped list share a pointer with different ranges, so that hazard does not occur.
; asset_skip_mask ($03B4) is a one-shot request: an actor that warps inside a world writes $0020 before the scene change so that the music is not reloaded (15 writer sites in 13 files), and InitSceneState clears it after the load. Skipped commands still advance Y past their operands. The record walkers (FindSceneRecord, FindAssetLabel) ignore the mask.
; 
; === QUINTET LZ ===
; DecompressQuintetLz is the Quintet LZ expander of corpus/gaia-core/quintet-lz.md: a 256-byte ring pre-filled with $20, first write position $EF, a flag bit per token (1 = literal byte, 0 = back reference of an 8-bit ring position and a 4-bit length, count = length + 2), bits read MSB first with the one-hot mask dp$1E. It does NOT read the 2-byte length word that precedes every compressed stream: each caller reads it into dp$23 first. The loader decompresses to $7E:6000 (graphics and tileset staging, 8 KB at most), $7E:C000 (Mode 7 map), $7E:3800 or $7E:F000 (spritemap) and the layer map pages.
; 
; === SCENE PROFILE, MUSIC AND VARIANT ===
; ApplySceneProfile writes the PPU layout of the scene from a 12-byte record of lib_scene_profile_data (see its block note for the layout) and sets location_id, world_index, the BG tile attributes, the view height, the parallax ratios, scene_variant and no_combat_scene. scene_variant ($031E) selects which music record of the scene plays: LoadSceneMusic plays a record only when its variant byte equals scene_variant. InitSceneState clears scene_variant after the load, so it is a one-shot request: an actor may set it before the scene change; otherwise LookupSceneVariant (lib_scene_map_patches) may set it from the switch rows of SceneVariantRules; otherwise bits 7 and 6 of profile byte 11 add 1 each. The profile command is always the first command of a record, so the variant is final before the music command runs.
; 
; === NOTES ===
; - The loader never sets dp$2E, the bank byte of the copy destination [dp$2C]. Its only writer is the SPC upload (engine_spc_ipl_upload: $07 at the start, incremented per bank, $7E at the end), so the tileset and raw map copies write to the bank left by the last music upload. Whether the very first scene after boot sees $7E is open (OQ-I011-1).
; - LoadMapLayer stores the height byte of a raw map with its flag bit into map_height_px (OQ-I011-2). The raw tilemap and tileset flags look unused in the shipped data.
; - The LZ ring is the page $7E:0100-$01FF, which every decompression overwrites (OQ-I011-8).
; - Two BRA instructions never run (after eight ASL of a non-zero byte): FindSceneRecord ends its ladder with BRA GraphicsCacheHit and FindAssetLabel with BRA loc_0139E6, a STZ BG2HOFS inside InitHardwareAndClearWram (OQ-I011-10). They pin the layout: a rebuild that keeps the bytes needs those labels at the same relative distance, so InitHardwareAndClearWram cannot move away from FindAssetLabel on its own.
; - Walkthrough check: the places and bosses the walkthrough names (Grass Valley, GreenWood, St. Elles, Mountain of Souls, Leo's Laboratory, Magridd's Castle, World of Evil, Deathtoll) agree with the location names that profile ids select (LocationNameList); the story text is not in the walkthrough.
---------------------------------------------

?BANK 02

?INCLUDE 'data_scene_asset_lists'
?INCLUDE 'engine_spc_ipl_upload'
?INCLUDE 'lib_arithmetic'
?INCLUDE 'lib_scene_map_patches'
?INCLUDE 'lib_scene_profile_data'
?INCLUDE 'lib_system_helpers'

!area_current                   0314
!scene_current                  0316
!bgm_start_cmd                  031A
!bgm_record_variant             031C
!scene_variant                  031E
!map_width_px                   0342
!map_height_px                  0344
!ratio_x_bg1                    034A
!map_base_bg1                   0352
!tile_mask_bg1                  035C
!tile_mask_bg2                  0360
!tile_attr_bg1                  036A
!tile_attr_bg2                  036E
!scene_sprite_attr              0372
!asset_skip_mask                03B4
!world_index                    03BA
!tm_shadow                      03C0
!cgadsub_shadow                 03C1
!bg2sc_shadow                   03C2
!view_height_px                 03CA
!bg_scroll_swap                 03DB
!asset_cache_gfx0               0407
!asset_cache_gfx1               040A
!asset_cache_gfx2               040D
!asset_cache_gfx3               0410
!asset_cache_tileset1           0413
!asset_cache_tileset2           0416
!asset_cache_tilemap1           0419
!asset_cache_tilemap2           041C
!no_combat_scene                0439
!location_id                    1C6A
!INIDISP                        2100
!OBJSEL                         2101
!OAMADDL                        2102
!OAMADDH                        2103
!BGMODE                         2105
!MOSAIC                         2106
!BG1SC                          2107
!BG2SC                          2108
!BG3SC                          2109
!BG4SC                          210A
!BG12NBA                        210B
!BG34NBA                        210C
!BG1HOFS                        210D
!BG1VOFS                        210E
!BG2HOFS                        210F
!BG2VOFS                        2110
!BG3HOFS                        2111
!BG3VOFS                        2112
!BG4HOFS                        2113
!BG4VOFS                        2114
!VMAIN                          2115
!VMADDL                         2116
!VMADDH                         2117
!VMDATAL                        2118
!VMDATAH                        2119
!M7SEL                          211A
!M7A                            211B
!M7B                            211C
!M7C                            211D
!M7D                            211E
!M7X                            211F
!M7Y                            2120
!CGADD                          2121
!W12SEL                         2123
!W34SEL                         2124
!WOBJSEL                        2125
!WH0                            2126
!WH1                            2127
!WH2                            2128
!WH3                            2129
!WBGLOG                         212A
!WOBJLOG                        212B
!TM                             212C
!TS                             212D
!TMW                            212E
!TSW                            212F
!CGWSEL                         2130
!CGADSUB                        2131
!COLDATA                        2132
!SETINI                         2133
!APUIO0                         2140
!NMITIMEN                       4200
!WRIO                           4201
!WRMPYA                         4202
!WRMPYB                         4203
!WRDIVL                         4204
!WRDIVH                         4205
!WRDIVB                         4206
!HTIMEL                         4207
!HTIMEH                         4208
!VTIMEL                         4209
!VTIMEH                         420A
!MDMAEN                         420B
!HDMAEN                         420C
!MEMSEL                         420D
!cgram_buffer                   7F0000

---------------------------------------------

; Waits for A vblanks.
; 
; When: UploadSceneMusic, three times (2, 2 and 3 frames around the SPC handshake).
; Sees: nothing; the scene change is still blanked.
; Why: the SPC needs time between the steps of the handshake and a frame is the clock the loader has.
; In: JSL; M = 8, A = number of frames (0 means 256).
; Out: returns after A calls of lib_system_helpers.WaitVBlank; A = 0.
; Clobbers: A.

WaitVblankFrames {
    JSL $@lib_system_helpers.WaitVBlank
    DEC 
    BNE WaitVblankFrames
    RTL 
}
---------------------------------------------

; Expands one Quintet LZ stream into bank $7E.
; 
; When: LoadSceneGraphics, LoadMetatileDefs, LoadMapLayer, LoadMode7Map, LoadSceneSpritemap (5 sites) and three sites of lib_02719F.
; Sees: the decoded graphics, tile definitions or map bytes that the caller then copies on.
; Why: all scene data is stored compressed; the ring keeps the last 256 output bytes so a back reference costs 12 bits.
; In: JSL; dp$29-$2B = source (behind the 2-byte length word), dp$23 = bytes to produce, dp$25 = destination offset in bank $7E. Sets M = 8, X = 16 itself and DBR = $7E for the call.
; Out: the bytes at $7E:[dp$25]; dp$29 advanced past the consumed bytes; the ring page $7E:0100-$01FF is overwritten (OQ-I011-8).
; Clobbers: A, dp$1E-$22; P, B, X, Y are preserved.

DecompressQuintetLz {
    PHP 
    PHB 
    PHX 
    PHY 
    REP #$10
    SEP #$20
    LDA #$7E
    PHA 
    PLB 
    LDX #$0100            ; ring = $7E:0100-$01FF; the low byte of dp$1F (write) and dp$21 (read) is the ring position
    STX $1F
    STX $21
    LDA #$20              ; the ring is pre-filled with $20

  ClearLzRing:
    STA ($1F)
    INC $1F
    BNE ClearLzRing
    LDA #$EF              ; first ring write position
    STA $1F
    LDA #$80              ; flag-bit mask, MSB first; $80 = the stream is byte aligned
    STA $1E
    LDX $25               ; X = output offset in bank $7E
    LDY $23               ; Y = bytes still to produce

  NextLzToken:
    LDA [$29]
    AND $1E
    PHA 
    LSR $1E
    BCC loc_0132AA
    ROR $1E
    INC $29
    BNE loc_0132AA
    INC $2A

  loc_0132AA:
    PLA 
    BEQ CopyLzBackReference ; flag bit clear = back reference, set = literal byte
    JSR $&ReadLzByte
    STA $0000, X
    INX 
    STA ($1F)
    INC $1F
    DEY 
    BNE NextLzToken
    BRA FinishLzExpand

  CopyLzBackReference:
    JSR $&ReadLzByte
    STA $21
    JSR $&ReadLzNibble
    INC                   ; two INC: length = nibble + 2
    INC 

  CopyLzRingByte:
    XBA 
    LDA ($21)
    INC $21
    STA ($1F)
    INC $1F
    STA $0000, X
    INX 
    DEY 
    BEQ FinishLzExpand
    XBA 
    DEC 
    BNE CopyLzRingByte
    BRA NextLzToken

  FinishLzExpand:
    PLY 
    PLX 
    PLB 
    PLP 
    RTL 
}

---------------------------------------------
; Reads the next 8 bits of the stream at any bit phase.
; 
; When: DecompressQuintetLz, for a literal byte and for the 8-bit ring position of a back reference.
; Sees: nothing directly.
; Why: the flag bits sit between the data bits, so a byte of output is rarely aligned to a byte of input; the eight-way ladder picks the shift for the current phase of dp$1E.
; In: JSR; M = 8; dp$1E = one-hot bit mask ($80 = aligned), dp$29 = source.
; Out: A.low = the 8 bits; dp$29 += 1; the mask is unchanged (the phase does not move); M = 8.
; Clobbers: A (B is scrambled by XBA).

ReadLzByte {
    LDA $1E
    BMI loc_013329
    ASL 
    BMI loc_013322
    ASL 
    BMI loc_01331B
    ASL 
    BMI loc_013314
    ASL 
    BMI loc_01330D
    ASL 
    BMI loc_013306
    ASL 
    BMI loc_0132FF
    REP #$20
    LDA [$29]
    XBA 
    BRA loc_013332

  loc_0132FF:
    REP #$20
    LDA [$29]
    XBA 
    BRA loc_013333

  loc_013306:
    REP #$20
    LDA [$29]
    XBA 
    BRA loc_013334

  loc_01330D:
    REP #$20
    LDA [$29]
    XBA 
    BRA loc_013335

  loc_013314:
    REP #$20
    LDA [$29]
    XBA 
    BRA loc_013336

  loc_01331B:
    REP #$20
    LDA [$29]
    XBA 
    BRA loc_013337

  loc_013322:
    REP #$20
    LDA [$29]
    XBA 
    BRA loc_013338

  loc_013329:
    LDA [$29]
    REP #$20
    INC $29
    SEP #$20
    RTS 

  loc_013332:
    ASL 

  loc_013333:
    ASL 

  loc_013334:
    ASL 

  loc_013335:
    ASL 

  loc_013336:
    ASL 

  loc_013337:
    ASL 

  loc_013338:
    ASL 
    INC $29
    XBA 
    SEP #$20
    RTS 
}

---------------------------------------------
; Reads the next 4 bits of the stream (the length of a back reference).
; 
; When: DecompressQuintetLz, after the ring position of a back reference.
; Sees: nothing directly.
; Why: the length is 4 bits wide, so it moves the bit phase by 4.
; In: JSR; M = 8; dp$1E = bit mask, dp$29 = source.
; Out: A = 0-15; dp$1E moved by 4 bits; dp$29 += 1 when a byte boundary was crossed.
; Clobbers: A (B).

ReadLzNibble {
    LDA $1E
    CMP #$10
    BCC loc_013361
    LSR 
    LSR 
    LSR 
    LSR 
    STA $1E
    XBA 
    LDA [$29]
    XBA 
    REP #$20
    LSR 
    BCS loc_01335B
    LSR 
    BCS loc_01335B
    LSR 
    BCS loc_01335B
    LSR 

  loc_01335B:
    SEP #$20
    XBA 
    AND #$0F
    RTS 

  loc_013361:
    LSR 
    BCS loc_013392
    LSR 
    BCS loc_013385
    LSR 
    BCS loc_013379
    LDA #$80
    STA $1E
    LDA [$29]
    REP #$20
    INC $29
    SEP #$20
    AND #$0F
    RTS 

  loc_013379:
    LDA #$40
    STA $1E
    REP #$20
    LDA [$29]
    XBA 
    ASL 
    BRA loc_01339E

  loc_013385:
    LDA #$20
    STA $1E
    REP #$20
    LDA [$29]
    XBA 
    ASL 
    ASL 
    BRA loc_01339E

  loc_013392:
    LDA #$10
    STA $1E
    REP #$20
    LDA [$29]
    XBA 
    ASL 
    ASL 
    ASL 

  loc_01339E:
    INC $29
    SEP #$20
    XBA 
    AND #$0F
    RTS 
}

---------------------------------------------
; Loads everything a scene needs: graphics, palette, tile definitions, maps, profile, music and sprite map.
; 
; When: every scene change, from InitSceneState (lib_scene_change_init), with the screen in forced blank.
; Sees: after it returns the new scene's data is in VRAM and WRAM; the player sees it when the screen is unblanked.
; Why: scenes are data. One list, one record per scene and one command per asset replace a loader routine per scene.
; In: JSL; area_current, scene_current set; dp$2F-$31 = asset list.
; Out: FindSceneRecord, then the command ladder until a 00 byte (see the block note for the eight commands).
; Clobbers: A, X, Y, dp$00-$06, dp$1E-$26, dp$29-$2C and the I/O registers the handlers write; P restored.

LoadSceneAssets {
    PHP 
    SEP #$20
    REP #$10
    JSR $&FindSceneRecord

  NextAssetCommand:
    JSR $&ReadAssetByte
    CMP #$00
    BEQ EndSceneAssets
    BIT #$80
    BEQ loc_0133BE
    JSR $&LoadSceneGraphics
    BRA NextAssetCommand

  loc_0133BE:
    BIT #$40
    BEQ loc_0133C7
    JSR $&LoadScenePalette
    BRA NextAssetCommand

  loc_0133C7:
    BIT #$20
    BEQ loc_0133D0
    JSR $&LoadMetatileDefs
    BRA NextAssetCommand

  loc_0133D0:
    BIT #$10
    BEQ loc_0133D9
    JSR $&LoadSceneTilemap
    BRA NextAssetCommand

  loc_0133D9:
    BIT #$08
    BEQ loc_0133E2
    JSR $&ApplySceneProfile
    BRA NextAssetCommand

  loc_0133E2:
    BIT #$04
    BEQ loc_0133EB
    JSR $&SkipMeta4Command
    BRA NextAssetCommand

  loc_0133EB:
    BIT #$02
    BEQ loc_0133F4
    JSR $&LoadSceneMusic
    BRA NextAssetCommand

  loc_0133F4:
    BIT #$01
    BEQ NextAssetCommand
    JSR $&LoadSceneSpritemap
    BRA NextAssetCommand

  EndSceneAssets:
    PLP 
    RTL 
}

---------------------------------------------
; Finds the record of the current scene in the asset list.
; 
; When: the start of LoadSceneAssets.
; Sees: nothing.
; Why: the list is a plain concatenation of variable-length records, so records of other scenes are skipped command by command.
; In: JSR; M = 8, X = 16; dp$2F-$31 = list, area_current, scene_current.
; Out: Y = offset of the first command of the record whose scene (byte 1) and area (byte 0) match. Other records are skipped with the operand lengths 6, 6, 7, 4, 1, 3, 5, 6 for the commands $80 down to $01. A scene with no record runs off the end of the list (OQ-I011-3).
; Clobbers: A, Y.

FindSceneRecord {
    LDY #$0000

  CheckSceneRecord:
    LDA [$2F], Y
    INY 
    XBA 
    LDA [$2F], Y
    INY 
    CMP $scene_current    ; record byte 1 = scene (byte 0, the area, is compared next)
    BNE SkipRecordCommands
    XBA 
    CMP $area_current     ; record byte 0 = area
    BNE SkipRecordCommands
    RTS 

  SkipRecordCommands:
    JSR $&ReadAssetByte
    CMP #$00
    BEQ CheckSceneRecord
    ASL 
    BCS loc_013437
    ASL 
    BCS loc_013437
    ASL 
    BCS loc_013436
    ASL 
    BCS loc_013439
    ASL 
    BCS loc_01343C
    ASL 
    BCS loc_01343A
    ASL 
    BCS loc_013438
    ASL 
    BCS loc_013437
    BRA GraphicsCacheHit  ; never taken: eight ASL of a non-zero byte; pins the layout (OQ-I011-10)

  loc_013436:
    INY 

  loc_013437:
    INY 

  loc_013438:
    INY 

  loc_013439:
    INY 

  loc_01343A:
    INY 
    INY 

  loc_01343C:
    INY 
    BRA SkipRecordCommands
}

---------------------------------------------
; Loads one block of tile graphics into VRAM (command $80).
; 
; When: LoadSceneAssets, for each graphics command (107 in the list).
; Sees: the character graphics of the scene (backgrounds, sprite sets, the BG3 text font) appear in VRAM.
; Why: a scene loads only the blocks it needs and the cache skips a block that is already in its VRAM page.
; In: JSR; Y at the first operand; operands b0 start, b1 end (x $200 bytes, b0 bit 7 = raw), b2 VRAM page (word address b2 << 8), pointer.
; Out: compressed (the usual case): the stream is expanded to $7E:6000 and the words [b0 x $200, b1 x $200) go to VMDATAL. Raw: the same words are copied straight from the ROM pointer. b2 = $FF (the Mode 7 scene only, OQ-I011-4): VMADD = 0 and only VMDATAH is written, $4000 bytes. The cache cell of the page is updated; Y is past the 6 operand bytes. Skipped (only Y moves) when asset_skip_mask bit 3 is set.
; Clobbers: A, X, dp$00, dp$02, dp$23, dp$25, dp$29-$2B.

LoadSceneGraphics {
    LDA $asset_skip_mask
    BIT #$08
    BEQ ReadGraphicsOperands
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    RTS 

  ReadGraphicsOperands:
    PHP 
    REP #$20
    JSR $&ReadAssetByte
    XBA 
    STA $00               ; dp$00 = b0 << 8: start in 512-byte units, bit 15 = raw flag (shifted out by ASL at StartGraphicsCopy)
    JSR $&ReadAssetByte
    XBA 
    ASL 
    STA $02               ; dp$02 = b1 x $200: end offset
    JSR $&ReadAssetByte
    PHA 
    XBA 
    CLC 
    ADC #$0000
    STA $VMADDL           ; VRAM word address = b2 << 8
    LDX #$0029
    JSR $&ReadAssetPointer
    LDA $01, S
    BEQ loc_013484
    CMP #$0010
    BEQ loc_01348E
    CMP #$0020
    BEQ loc_013498
    CMP #$0030
    BEQ loc_0134A2
    BRA ClearGraphicsCaches

  loc_013484:
    LDX #$0407            ; asset_cache_gfx0: VRAM page $0000
    JSR $&CheckAssetCache
    BCS StartGraphicsCopy
    BRA GraphicsCacheHit

  loc_01348E:
    LDX #$040A            ; asset_cache_gfx1: VRAM page $1000
    JSR $&CheckAssetCache
    BCS StartGraphicsCopy
    BRA GraphicsCacheHit

  loc_013498:
    LDX #$040D            ; asset_cache_gfx2: VRAM page $2000
    JSR $&CheckAssetCache
    BCS StartGraphicsCopy
    BRA GraphicsCacheHit

  loc_0134A2:
    LDX #$0410            ; asset_cache_gfx3: VRAM page $3000
    JSR $&CheckAssetCache
    BCS StartGraphicsCopy

  GraphicsCacheHit:
    PLA 
    PLP 
    RTS 

  ClearGraphicsCaches:
    STZ $asset_cache_gfx0
    STZ $asset_cache_gfx1
    STZ $asset_cache_gfx2
    STZ $asset_cache_gfx3

  StartGraphicsCopy:
    ASL $00
    BCC ExpandGraphicsToVram
    PLA 
    CMP #$00FF            ; b2 = $FF: the Mode 7 character data, high bytes only (OQ-I011-4)
    BEQ CopyRawMode7Graphics
    PHY 
    LDY $00

  loc_0134C6:
    LDA [$29], Y
    STA $VMDATAL
    INY 
    INY 
    CPY $02
    BNE loc_0134C6
    PLY 
    PLP 
    RTS 

  CopyRawMode7Graphics:
    LDX #$0000
    STX $VMADDL
    PHY 
    SEP #$20
    LDY #$0000

  loc_0134E0:
    LDA [$29], Y
    STA $VMDATAH
    INY 
    CPY #$4000
    BNE loc_0134E0
    REP #$20
    PLY 
    PLP 
    RTS 

  ExpandGraphicsToVram:
    LDA [$29]
    STA $23
    INC $29
    INC $29
    LDX #$6000            ; expanded graphics are staged at $7E:6000
    STX $25
    JSL $@DecompressQuintetLz
    PLA 
    CMP #$00FF            ; b2 = $FF: Mode 7 characters, $4000 bytes into VMDATAH
    BEQ CopyExpandedMode7Graphics
    LDX $00

  loc_013509:
    LDA $7E6000, X
    STA $VMDATAL
    INX 
    INX 
    CPX $02
    BNE loc_013509
    PLP 
    RTS 

  CopyExpandedMode7Graphics:
    LDX #$0000
    STX $VMADDL
    SEP #$20
    LDX #$0000

  loc_013523:
    LDA $7E6000, X
    STA $VMDATAH
    INX 
    CPX #$4000
    BNE loc_013523
    PLP 
    RTS 
}

---------------------------------------------
; Copies a range of colours from the asset into the CGRAM buffer (command $40).
; 
; When: LoadSceneAssets, for each palette command (109 in the list).
; Sees: the scene's colours after the NMI uploads the buffer.
; Why: the buffer is uploaded by the NMI, so loading a palette is a memory copy with no hardware write and needs no cache.
; In: JSR; Y at the first operand; b0 first source colour, b1 end colour (exclusive), b2 first destination colour, pointer.
; Out: colours [b0, b1) of the source copied to cgram_buffer + b2 x 2; Y past the 6 operand bytes. Skipped when asset_skip_mask bit 2 is set.
; Clobbers: A, X, dp$00-$04, dp$29-$2B.

LoadScenePalette {
    LDA $asset_skip_mask
    BIT #$04
    BEQ loc_013540
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    RTS 

  loc_013540:
    PHP 
    REP #$20
    JSR $&ReadAssetByte
    ASL                   ; palette bytes are colours: byte offset = colour x 2
    STA $00
    JSR $&ReadAssetByte
    ASL 
    STA $02
    JSR $&ReadAssetByte
    ASL 
    STA $04
    LDX #$0029
    JSR $&ReadAssetPointer
    PHY 
    LDY $00
    LDX $04

  loc_013560:
    LDA [$29], Y
    STA $cgram_buffer, X  ; the CGRAM buffer is uploaded by the NMI
    INY 
    INY 
    INX 
    INX 
    CPY $02
    BNE loc_013560
    PLY 
    PLP 
    RTS 
}

---------------------------------------------
; Loads the metatile definition tables of one or both background layers (command $20).
; 
; When: LoadSceneAssets, for each tileset command (62 in the list; every one is b0 = 00, b1 = 20, b2 = 00).
; Sees: the 16x16 blocks of the map get their four tiles and attributes (the map streamer reads the tables).
; Why: the maps store one byte per metatile; this table says what the byte means.
; In: JSR; Y at the first operand; b0 start, b1 end, b2 destination offset (all in 64-byte units, b0 bit 7 = raw), b3 layer mask (1 BG1, 2 BG2, 3 both), pointer.
; Out: the stream is expanded to $7E:6000 and bytes [b0 x 64, b1 x 64) are copied, word by word and byte-swapped, to $7E:2000 (BG1) and/or $7E:2800 (BG2) at offset b2 x 64 (eight bytes per metatile, 256 ids, $800 bytes per layer). A raw tileset (b0 bit 7) is copied 2 KB to [dp$2C] = $xx:6000 instead, in the bank left in dp$2E (OQ-I011-1); no shipped tileset is raw. Cache cell by b3: 1 asset_cache_tileset1, 2 asset_cache_tileset2, anything else zeroes both and loads. Y past the 7 operand bytes. Skipped when asset_skip_mask bit 1 is set.
; Clobbers: A, X, dp$00-$06, dp$23, dp$25, dp$2C, dp$29-$2B.

LoadMetatileDefs {
    LDA $asset_skip_mask
    BIT #$02
    BEQ loc_013580
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    RTS 

  loc_013580:
    PHP 
    REP #$20
    JSR $&ReadAssetByte
    XBA 
    STA $06
    AND #$7FFF
    LSR 
    LSR 
    STA $00
    JSR $&ReadAssetByte
    XBA 
    LSR 
    LSR 
    STA $02
    JSR $&ReadAssetByte
    XBA 
    LSR 
    LSR 
    STA $04
    JSR $&ReadAssetByte
    PHA 
    LDX #$0029
    JSR $&ReadAssetPointer
    LDA $01, S
    CMP #$0001
    BEQ loc_0135B8
    CMP #$0002
    BEQ loc_0135C2
    BRA ClearTilesetCaches

  loc_0135B8:
    LDX #$0413            ; asset_cache_tileset1
    JSR $&CheckAssetCache
    BCS StageTilesetData
    BRA loc_0135CA

  loc_0135C2:
    LDX #$0416            ; asset_cache_tileset2
    JSR $&CheckAssetCache
    BCS StageTilesetData

  loc_0135CA:
    PLA 
    PLP 
    RTS 

  ClearTilesetCaches:
    STZ $asset_cache_tileset1
    STZ $asset_cache_tileset2

  StageTilesetData:
    LDA $06
    BPL loc_0135EE
    LDA #$6000            ; raw tileset: 2 KB copied to [dp$2C] = $xx:6000, bank in dp$2E (OQ-I011-1)
    STA $2C
    PHY 
    LDY #$0000

  loc_0135E0:
    LDA [$29], Y
    STA [$2C], Y
    INY 
    INY 
    CPY #$0800
    BNE loc_0135E0
    PLY 
    BRA loc_0135FF

  loc_0135EE:
    LDA [$29]
    STA $23
    INC $29
    INC $29
    LDX #$6000
    STX $25
    JSL $@DecompressQuintetLz

  loc_0135FF:
    PLA 
    LDX #$2000            ; BG1 definitions: $7E:2000
    JSR $&CopyDefsToLayer
    LDX #$2800            ; BG2 definitions: $7E:2800
    JSR $&CopyDefsToLayer
    PLP 
    RTS 
}

---------------------------------------------
; Copies the staged tile definitions to one layer's table when the layer mask asks for it.
; 
; When: LoadMetatileDefs, once for BG1 (X = $2000) and once for BG2 (X = $2800).
; Sees: nothing directly.
; Why: one staged definition set can feed one layer or both.
; In: JSR; A = remaining layer mask (bit 0 = this layer), X = low word of the destination table, dp$00 start, dp$02 end, dp$04 destination offset.
; Out: bit 0 set: the words [dp$00, dp$02) of $7E:6000, byte-swapped, to [dp$2C] + dp$04 (dp$2E, the bank, is not set here: OQ-I011-1). A is shifted right for the next layer.
; Clobbers: A and X (the caller reloads X); Y is preserved.

CopyDefsToLayer {
    LSR 
    BCC loc_01362A
    PHA 
    PHY 
    STX $2C               ; destination = [dp$2C] + dp$04; dp$2E (the bank) is not set here (OQ-I011-1)
    LDX $00
    LDY $04

  loc_013619:
    LDA $7E6000, X        ; the words are byte-swapped on the way
    XBA 
    STA [$2C], Y
    INX 
    INX 
    INY 
    INY 
    CPX $02
    BNE loc_013619
    PLY 
    PLA 

  loc_01362A:
    RTS 
}

---------------------------------------------
; Loads the map of one background layer, or the Mode 7 map (command $10).
; 
; When: LoadSceneAssets, for each tilemap command (135 in the list).
; Sees: the scene's layout of metatiles, and its size for the camera clamp and the collision.
; Why: the stream header gives the map size so one routine serves every scene.
; In: JSR; Y at the first operand; type (1 BG1, 2 BG2, 0 Mode 7), pointer.
; Out: the stream header is two bytes, width and height in 256-pixel pages (height bit 7 = raw map, OQ-I011-2). The expected output length is width x height x 256 bytes (one byte per metatile; the product comes from lib_arithmetic.Multiply8x8), replaced by the length word of the stream when the map is compressed. Types 1 and 2 go to LoadMapLayer, type 0 to LoadMode7Map. Cache cell: type 1 asset_cache_tilemap1, type 2 asset_cache_tilemap2 (a hit skips the whole load, the sizes are not stored again); any other type zeroes both. Y past the 4 operand bytes. Skipped when asset_skip_mask bit 0 is set.
; Clobbers: A, X, dp$00-$04, dp$23, dp$25, dp$29-$2B.

LoadSceneTilemap {
    LDA $asset_skip_mask
    BIT #$01
    BEQ loc_013637
    INY 
    INY 
    INY 
    INY 
    RTS 

  loc_013637:
    PHP 
    REP #$20
    JSR $&ReadAssetByte
    STA $04
    LDX #$0029
    JSR $&ReadAssetPointer
    LDA $04
    CMP #$0001
    BEQ loc_01365B
    CMP #$0002
    BNE ClearTilemapCaches
    LDX #$041C            ; asset_cache_tilemap2
    JSR $&CheckAssetCache
    BCS ReadTilemapHeader
    PLP 
    RTS 

  loc_01365B:
    LDX #$0419            ; asset_cache_tilemap1
    JSR $&CheckAssetCache
    BCS ReadTilemapHeader
    PLP 
    RTS 

  ClearTilemapCaches:
    STZ $asset_cache_tilemap1
    STZ $asset_cache_tilemap2

  ReadTilemapHeader:
    LDA [$29]
    INC $29
    AND #$00FF
    XBA 
    STA $00
    LDA [$29]
    INC $29
    AND #$00FF
    XBA 
    STA $02
    SEP #$20
    LDA $01
    XBA 
    LDA $03
    JSL $@lib_arithmetic.Multiply8x8 ; width x height in pages
    REP #$20
    XBA 
    STA $23               ; expected output length = pages x 256 (one byte per metatile)
    LDA $03
    BMI LoadTilemapByType ; height bit 7 set = raw map: no length word, no expansion (OQ-I011-2)
    LDA [$29]
    STA $23
    INC $29
    INC $29

  LoadTilemapByType:
    LDA $04
    AND #$FF7F
    BNE loc_0136A7
    JSR $&LoadMode7Map
    BRA loc_0136B7

  loc_0136A7:
    LDX #$0000
    JSR $&LoadMapLayer
    BCS loc_0136B7
    LDX #$0004
    JSR $&LoadMapLayer
    BCS loc_0136B7

  loc_0136B7:
    PLP 
    RTS 
}

---------------------------------------------
; Stores the map size and expands or copies the map of one layer.
; 
; When: LoadTilemapByType, with X = 0 for BG1 and X = 4 for BG2 (A = the type shifted so that bit 0 is this layer).
; Sees: map_width_px, map_height_px (or the BG2 pair, map2_width_px, map2_height_px) and the layer's map page.
; Why: both layers share the code and differ by the index X into the per-layer word tables.
; In: JSR; A = type, X = 0 or 4; dp$00 = width x 256, dp$02 = height x 256, dp$23 = output length.
; Out: bit 0 set: size words stored at map_width_px + X and map_height_px + X, the map copied (raw) or expanded to the page at map_base_bg1 + X ($8000 BG1, $C000 BG2); carry set; A preserved. Otherwise carry clear and A shifted right.
; Clobbers: Y is preserved; A as described.

LoadMapLayer {
    LSR 
    BCC loc_0136E9
    PHA 
    PHY 
    LDA $00
    STA $map_width_px, X
    LDA $02
    STA $map_height_px, X
    LDY $map_base_bg1, X  ; destination = the layer's map page base ($8000 BG1, $C000 BG2)
    LDA $03
    BPL loc_0136E0
    STY $2C
    LDY #$0000

  loc_0136D4:
    LDA [$29], Y
    STA [$2C], Y
    INY 
    INY 
    CPY $23
    BNE loc_0136D4
    BRA loc_0136E6

  loc_0136E0:
    STY $25
    JSL $@DecompressQuintetLz

  loc_0136E6:
    PLY 
    PLA 
    SEC 

  loc_0136E9:
    RTS 
}

---------------------------------------------
; Loads the Mode 7 map and writes it to VRAM (tilemap type 0).
; 
; When: LoadTilemapByType, for the only Mode 7 scene (OQ-I011-4).
; Sees: the Mode 7 floor map in the low bytes of VRAM word 0 onward.
; Why: Mode 7 keeps its map in the low byte of the VRAM words and its characters in the high byte, so the map goes in with VMAIN = 0.
; In: JSR; M = 16; dp$29-$2B = source, dp$03 bit 7 = raw.
; Out: $4000 bytes expanded (or copied) to $7E:C000, then written to VMDATAL from word 0 with VMAIN = 0; VMAIN back to $80.
; Clobbers: A, X; Y and P are preserved.

LoadMode7Map {
    PHP 
    PHY 
    LDA $03
    BPL loc_013705
    LDY #$C000
    STY $2C
    LDY #$0000

  loc_0136F8:
    LDA [$29], Y
    STA [$2C], Y
    INY 
    INY 
    CPY #$4000
    BNE loc_0136F8
    BRA loc_01370E

  loc_013705:
    LDX #$C000
    STX $25
    JSL $@DecompressQuintetLz

  loc_01370E:
    SEP #$20
    LDX #$0000
    STX $VMADDL
    STZ $VMAIN            ; VMAIN = 0: only the low byte of each word is written
    LDX #$0000

  loc_01371C:
    LDA $7EC000, X
    STA $VMDATAL
    INX 
    CPX #$4000
    BNE loc_01371C
    LDA #$80
    STA $VMAIN            ; VMAIN restored to $80
    PLY 
    PLP 
    RTS 
}

---------------------------------------------
; Converts the 3-byte file offset in the asset list to a LoROM address in dp$29-$2B.
; 
; When: the pointer step of every asset command that loads data (graphics, palette, tileset, tilemap, music, spritemap).
; Sees: nothing.
; Why: the list stores plain file offsets; the loader reads through long pointers.
; In: JSR; Y at the 3 pointer bytes of the list, X = $0029 (all six callers).
; Out: dp$29-$2B = $8000 + (offset and $7FFF) and bank offset >> 15: the middle byte becomes (mid and $7F) or $80 and the bank is the high byte x 2 plus bit 7 of the middle byte; Y += 3.
; Clobbers: A.

ReadAssetPointer {
    PHP 
    REP #$20
    LDA [$2F], Y
    INY 
    INY 
    STA $29
    SEP #$20
    LDA [$2F], Y
    INY 
    STA $2B
    REP #$20
    LDA $0001, X
    AND #$007F            ; LoROM: middle byte = (mid and $7F) or $80, bank = high byte x 2 + bit 7 of the middle byte
    PHA 
    EOR $0001, X
    ASL 
    ORA #$0080
    ORA $01, S
    STA $0001, X
    PLA 
    PLP 
    RTS 
}

---------------------------------------------
; Applies a scene profile, or jumps to a shared label (command $08).
; 
; When: LoadSceneAssets, once per record (the first command of every scene).
; Sees: the scene's layer setup: which layers show, colour math, the 224 or 256 line view, where the maps sit in VRAM, how fast BG2 drifts.
; Why: the settings that differ from scene to scene are 12 bytes, so they live in a table and one routine writes them to the PPU and the engine variables.
; In: JSR; Y at the operand byte (the id). id below $80: profile; $80-$BF: jump to label id or $40; $C0-$FF: a label, nothing to do.
; Out: profile path: location_id = id; TM, TMW, TS, TSW, CGWSEL, CGADSUB, BG1SC, BG2SC, BGMODE written; tm_shadow, cgadsub_shadow, bg2sc_shadow, bg_scroll_swap, view_height_px, tile_attr_bg1/2, tile_mask_bg1/2 ($FDFF), scene_sprite_attr+1, the four parallax ratio words, world_index, no_combat_scene and scene_variant set (record layout in lib_scene_profile_data). Jump path: Y = position behind the label (FindAssetLabel) and the walk continues there.
; Clobbers: A, X; Y is restored on the profile path.

ApplySceneProfile {
    JSR $&ReadAssetByte
    BIT #$80              ; id below $80: scene profile; $80-$BF: jump to a label; $C0-$FF: a label (nothing to do)
    BEQ ApplyProfileRecord
    BIT #$40
    BEQ JumpToAssetLabel
    RTS 

  JumpToAssetLabel:
    ORA #$40              ; jump id $80-$BF becomes label $C0-$FF
    JSR $&FindAssetLabel
    RTS 

  ApplyProfileRecord:
    STA $location_id
    PHY 
    REP #$20
    AND #$00FF
    ASL 
    TAX 
    LDA $@lib_scene_profile_data.SceneProfileList, X
    SEC                   ; the list holds absolute addresses: subtract the list base to index it with long addressing
    SBC #$&lib_scene_profile_data.SceneProfileList
    TAX 
    SEP #$20
    LDA $@lib_scene_profile_data.SceneProfileList, X
    STA $TM
    STA $TMW
    STA $tm_shadow
    LDA $@lib_scene_profile_data.SceneProfileList+1, X
    STA $TS
    STA $TSW
    LDA $@lib_scene_profile_data.SceneProfileList+2, X
    STA $CGWSEL
    LDA $@lib_scene_profile_data.SceneProfileList+3, X
    STA $CGADSUB
    STA $cgadsub_shadow
    LDA $@lib_scene_profile_data.SceneProfileList+4, X
    AND #$30
    STA $scene_sprite_attr+1 ; byte 4 bits 4-5: high byte of the default sprite attribute word
    LDA $@lib_scene_profile_data.SceneProfileList+4, X
    STZ $tile_attr_bg1+1
    STZ $tile_attr_bg2+1
    LDY #$2000            ; $2000 = bit 13 of a tile word (tile priority); byte 4 bit 0 sets it for BG1, bit 1 for BG2
    ROR 
    BCC loc_0137C5
    STY $tile_attr_bg1

  loc_0137C5:
    ROR 
    BCC loc_0137CB
    STY $tile_attr_bg2

  loc_0137CB:
    ROR 
    ROR 
    ROR 
    ROR 
    LDY #$00E0            ; view height 224 lines
    ROR 
    BCC loc_0137D8
    LDY #$0100            ; byte 4 bit 6 set: 256-line view

  loc_0137D8:
    STY $view_height_px
    ROR 
    BCS loc_0137E3
    LDA #$01              ; byte 4 bit 7 clear: bit 8 of the BG2 tile attribute word (OQ-I029-4)
    TSB $tile_attr_bg2+1

  loc_0137E3:
    LDY #$FDFF            ; both tile masks = $FDFF in every profile
    STY $tile_mask_bg1
    STY $tile_mask_bg2
    STZ $bg_scroll_swap
    LDA $@lib_scene_profile_data.SceneProfileList+5, X
    BPL loc_0137F8
    INC $bg_scroll_swap   ; byte 5 bit 7: BG1 and BG2 swap their roles (BG1SC base $7000, BG2SC base $6000)

  loc_0137F8:
    LDA $bg_scroll_swap
    BNE loc_01381A
    LDA $@lib_scene_profile_data.SceneProfileList+5, X
    PHA 
    AND #$03
    CLC 
    ADC #$60              ; BG1SC = $60 + size bits: map base word $6000
    STA $BG1SC
    PLA 
    LSR 
    LSR 
    AND #$03
    CLC 
    ADC #$70              ; BG2SC = $70 + size bits: map base word $7000
    STA $BG2SC
    STA $bg2sc_shadow
    BRA loc_013835

  loc_01381A:
    LDA $@lib_scene_profile_data.SceneProfileList+5, X
    PHA 
    AND #$03
    CLC 
    ADC #$70
    STA $BG1SC
    PLA 
    LSR 
    LSR 
    AND #$03
    CLC 
    ADC #$60
    STA $BG2SC
    STA $bg2sc_shadow

  loc_013835:
    LDA $@lib_scene_profile_data.SceneProfileList+6, X
    STA $BGMODE
    PHX 
    LDY #$0000

  loc_013840:
    LDA $@lib_scene_profile_data.SceneProfileList+7, X ; bytes 7-10, one per layer axis: high nibble = numerator (low byte of the ratio word), low nibble = divisor (high byte)
    AND #$0F
    STA $ratio_x_bg1+1, Y
    LDA $@lib_scene_profile_data.SceneProfileList+7, X
    AND #$F0
    LSR 
    LSR 
    LSR 
    LSR 
    STA $ratio_x_bg1, Y
    INX 
    INY 
    INY 
    CPY #$0008
    BNE loc_013840
    PLX 
    LDA $scene_variant    ; an actor already requested a variant: no lookup, bits 7 and 6 are ignored
    BEQ loc_013866
    BRA ProfileKeepVariant

  loc_013866:
    JSL $@lib_scene_map_patches.LookupSceneVariant ; carry set: a SceneVariantRules row had its switch set and wrote scene_variant
    BCC ProfileAddVariantBits

  ProfileKeepVariant:
    LDA $@lib_scene_profile_data.SceneProfileList+B, X
    AND #$3F
    BRA loc_01387D

  ProfileAddVariantBits:
    LDA $@lib_scene_profile_data.SceneProfileList+B, X
    BPL loc_01387D
    INC $scene_variant    ; byte 11 bit 7: variant + 1

  loc_01387D:
    ASL 
    BPL loc_013883
    INC $scene_variant    ; byte 11 bit 6: variant + 1

  loc_013883:
    ASL 
    BPL loc_013889
    INC $no_combat_scene  ; byte 11 bit 5: no-combat scene (OQ-I029-2)

  loc_013889:
    LDA $@lib_scene_profile_data.SceneProfileList+B, X
    AND #$0F
    STA $world_index      ; byte 11 low nibble = world index
    PLY 
    RTS 
}

---------------------------------------------
; Skips the three operand bytes of command $04.
; 
; When: LoadSceneAssets, if a record had a meta4 command; none does (OQ-I011-10).
; Sees: nothing.
; Why: the command is defined but unused.
; In: JSR; Y at the operands.
; Out: Y += 3.
; Clobbers: A.

SkipMeta4Command {
    JSR $&ReadAssetByte
    JSR $&ReadAssetByte
    JSR $&ReadAssetByte
    RTS 
}

---------------------------------------------
; Starts the scene's music: the SPC handshake, the song upload and the start command (command $02).
; 
; When: LoadSceneAssets, for each music command (65 in the list), unless asset_skip_mask bit 5 is set.
; Sees: the music of the scene starts; a scene change that keeps the same song (same pointer) does not restart it.
; Why: uploading a song through the SPC IPL takes several frames; the cache and the skip mask avoid it when the song is already loaded.
; In: JSR; Y at the operands: b0 start command (always 1), b1 variant, pointer.
; Out: bgm_start_cmd = b0, bgm_record_variant = b1. Only when scene_variant equals b1 and the pointer differs from asset_cache_music: UploadSceneMusic. Y past the 5 operand bytes.
; Clobbers: A, X, dp$29-$2B.

LoadSceneMusic {
    LDA $asset_skip_mask
    BIT #$20
    BEQ ReadMusicOperands
    INY 
    INY 
    INY 
    INY 
    INY 
    RTS 

  ReadMusicOperands:
    JSR $&ReadAssetByte
    STA $bgm_start_cmd
    JSR $&ReadAssetByte
    STA $bgm_record_variant
    LDX #$0029
    JSR $&ReadAssetPointer
    LDA $scene_variant
    CMP $bgm_record_variant ; only the music record of this variant plays
    BEQ CheckMusicCache
    RTS 

  CheckMusicCache:
    LDX #$0422            ; asset_cache_music
    JSR $&CheckAssetCache
    BCS UploadSceneMusic
    RTS 

; Hands the song block at dp$29-$2B to the SPC.
; 
; When: LoadSceneMusic, when the variant matches and the pointer is new.
; Sees: the previous music stops; the new song starts at the end.
; Why: the SPC must be taken out of its engine and into the IPL boot handler before a block can be sent.
; In: dp$29-$2B = song block.
; Out: APUIO0 = $F0 and wait until the SPC answers 0; 2 frames; APUIO0 = $FF (the SPC's boot handshake handler, as in MusicLoadUpload); 2 frames; engine_spc_ipl_upload.code_0FEFF5 sends the block; 3 frames; APUIO0 = bgm_start_cmd.
; Clobbers: A.

  UploadSceneMusic:
    LDA #$F0
    STA $APUIO0           ; request $F0; the loop below waits for the SPC to clear port 0

  loc_0138D4:
    LDA $APUIO0
    BNE loc_0138D4
    LDA #$02
    JSL $@WaitVblankFrames
    LDA #$FF
    STA $APUIO0           ; $FF = the SPC's boot handshake handler (as MusicLoadUpload)
    LDA #$02
    JSL $@WaitVblankFrames
    JSL $@engine_spc_ipl_upload.code_0FEFF5 ; the song block at dp$29-$2B goes through the IPL transfer
    LDA #$03
    JSL $@WaitVblankFrames
    LDA $bgm_start_cmd
    STA $APUIO0           ; start command b0 (always 1 in the shipped list)
    RTS 
}

---------------------------------------------
; Expands the scene's sprite map (command $01).
; 
; When: LoadSceneAssets, for each spritemap command (47 in the list).
; Sees: the meta entries of the scene's actors find their sprite pieces (they read the map at $7E:3800).
; Why: the sprite maps of a scene are compressed in the ROM and live in WRAM while the scene runs.
; In: JSR; Y at the operands: b0 (0 = $7E:3800, else $7E:F000), b1 and b2 ignored, pointer.
; Out: the stream is expanded to $7E:3800 or $7E:F000 unless the pointer equals asset_cache_spritemap; Y past the 6 operand bytes. Skipped when asset_skip_mask bit 4 is set.
; Clobbers: A, X, dp$23, dp$25, dp$29-$2B.

LoadSceneSpritemap {
    LDA $asset_skip_mask
    BIT #$10
    BEQ loc_013909
    INY 
    INY 
    INY 
    INY 
    INY 
    INY 
    RTS 

  loc_013909:
    JSR $&ReadAssetByte
    PHA 
    JSR $&ReadAssetByte
    JSR $&ReadAssetByte
    LDX #$0029
    JSR $&ReadAssetPointer
    LDX #$041F            ; asset_cache_spritemap
    JSR $&CheckAssetCache
    BCS ExpandSpritemap
    PLA 
    RTS 

  ExpandSpritemap:
    REP #$20
    LDA [$29]
    STA $23
    INC $29
    INC $29
    SEP #$20
    LDX #$3800            ; b0 = 0: $7E:3800
    PLA 
    BEQ loc_013938
    LDX #$F000            ; b0 non-zero: $7E:F000

  loc_013938:
    STX $25
    JSL $@DecompressQuintetLz
    RTS 
}

---------------------------------------------
; Reads the next byte of the asset list.
; 
; When: every handler of the loader (22 sites).
; Sees: nothing.
; Why: one place advances the list position.
; In: JSR; Y = position in the list (dp$2F-$31 + Y).
; Out: A (16-bit, high byte 0) = the byte; Y += 1; P restored.
; Clobbers: A.

ReadAssetByte {
    PHP 
    REP #$20
    LDA [$2F], Y
    INY 
    AND #$00FF
    PLP 
    RTS 
}

---------------------------------------------
; Finds the shared segment that starts after an asset8 label.
; 
; When: ApplySceneProfile, for a jump id ($80-$BF, passed as label id or $40).
; Sees: nothing; the scene continues with the commands of another scene's record.
; Why: scenes of one world share graphics and palettes by sharing a segment; the label marks where the shared commands start.
; In: JSR; M = 8; A = label value ($C0-$FF).
; Out: Y = position behind the first asset8 command whose operand equals the label, scanning the list from the first record (each 00 byte skips the 2 header bytes of the next record).
; Clobbers: A, Y, dp$00.

FindAssetLabel {
    STA $00
    LDY #$0000

  NextAssetRecord:
    INY 
    INY 

  ScanAssetCommands:
    LDA [$2F], Y
    INY 
    CMP #$00
    BEQ NextAssetRecord
    ASL 
    BCS loc_013973
    ASL 
    BCS loc_013973
    ASL 
    BCS loc_013972
    ASL 
    BCS loc_013975
    ASL 
    BCS CompareAssetLabel
    ASL 
    BCS loc_013976
    ASL 
    BCS loc_013974
    ASL 
    BCS loc_013973
    BRA loc_0139E6        ; never taken: eight ASL of a non-zero byte; pins the layout (OQ-I011-10)

  loc_013972:
    INY 

  loc_013973:
    INY 

  loc_013974:
    INY 

  loc_013975:
    INY 

  loc_013976:
    INY 
    INY 
    INY 
    BRA ScanAssetCommands

  CompareAssetLabel:
    LDA [$2F], Y
    INY 
    CMP $00
    BNE ScanAssetCommands
    RTS 
}

---------------------------------------------
; Compares the pointer in dp$29-$2B with a 3-byte cache cell and updates the cell.
; 
; When: before every graphics, tileset, tilemap, music and spritemap load (10 sites).
; Sees: nothing; an equal pointer means the asset is already in place and the load is skipped.
; Why: a scene change that keeps the same assets in the same slots should cost nothing.
; In: JSR; X = address of the cell (asset_cache_*), dp$29-$2B = pointer.
; Out: carry clear = equal, nothing to do; carry set = the cell now holds the pointer, load the asset. P otherwise restored.
; Clobbers: A.

CheckAssetCache {
    PHP 
    REP #$20
    LDA $29
    CMP $0000, X
    BNE StoreAssetCache
    SEP #$20
    LDA $2B
    CMP $0002, X
    BNE StoreAssetCache
    REP #$20
    PLP 
    CLC 
    RTS 

  StoreAssetCache:
    SEP #$20
    LDA $2B
    STA $0002, X
    REP #$20
    LDA $29
    STA $0000, X
    PLP 
    SEC 
    RTS 
}

---------------------------------------------
; Puts the PPU, the DMA and math registers into a known state, clears WRAM and sets the asset list pointer.
; 
; When: once at boot, from the reset path (engine_boot_main_loop BootGame), before any scene.
; Sees: a black, forced-blank screen with every layer, window and effect off.
; Why: the SNES powers up with undefined PPU and WRAM contents.
; In: JSL; DBR must map WRAM at $0000 (banks $00-$3F; BootGame sets $01).
; Out: INIDISP = $80; OBJSEL, OAMADD, BGMODE, MOSAIC, the BGnSC, BGnNBA and the eight scroll registers (written twice each) = 0; VMAIN = $80, VMADD = 0; M7SEL = $80 and the Mode 7 matrix = identity (A = D = $0100, B = C = 0, X = Y = 0); CGADD, window and layer registers = 0; CGWSEL = $02, CGADSUB = 0, COLDATA = $E0, SETINI = 0; NMITIMEN = 0, WRIO = $FF; the multiplier, divider, timers, MDMAEN and HDMAEN = 0; MEMSEL = 0. WRAM $7E:0000-$1EFF and $7E:2000-$FFFF and the whole of bank $7F are cleared; $7E:1F00-$1FFF (the stack page) is kept. dp$2F-$31 = SceneAssetLists (set after the clear, since the direct page is inside it).
; Clobbers: A, X; P restored.

InitHardwareAndClearWram {
    PHP 
    SEP #$20
    REP #$10
    LDA #$80              ; forced blank
    STA $INIDISP
    STZ $OBJSEL
    STZ $OAMADDL
    STZ $OAMADDH
    STZ $BGMODE
    STZ $MOSAIC
    STZ $BG1SC
    STZ $BG2SC
    STZ $BG3SC
    STZ $BG4SC
    STZ $BG12NBA
    STZ $BG34NBA
    STZ $BG1HOFS
    STZ $BG1HOFS
    STZ $BG1VOFS
    STZ $BG1VOFS
    STZ $BG2HOFS

  loc_0139E6:
    STZ $BG2HOFS
    STZ $BG2VOFS
    STZ $BG2VOFS
    STZ $BG3HOFS
    STZ $BG3HOFS
    STZ $BG3VOFS
    STZ $BG3VOFS
    STZ $BG4HOFS
    STZ $BG4HOFS
    STZ $BG4VOFS
    STZ $BG4VOFS
    LDA #$80
    STA $VMAIN
    STZ $VMADDL
    STZ $VMADDH
    LDA #$80
    STA $M7SEL
    LDA #$01              ; Mode 7 matrix = identity: A = D = $0100
    STZ $M7A
    STA $M7A
    STZ $M7B
    STZ $M7B
    STZ $M7C
    STZ $M7C
    STZ $M7D
    STA $M7D
    STZ $M7X
    STZ $M7X
    STZ $M7Y
    STZ $M7Y
    STZ $CGADD
    STZ $W12SEL
    STZ $W34SEL
    STZ $WOBJSEL
    STZ $WH0
    STZ $WH1
    STZ $WH2
    STZ $WH3
    STZ $WBGLOG
    STZ $WOBJLOG
    STZ $TM
    STZ $TS
    STZ $TMW
    STZ $TSW
    LDA #$02
    STA $CGWSEL
    STZ $CGADSUB
    LDA #$E0              ; fixed colour: all planes selected, intensity 0
    STA $COLDATA
    STZ $SETINI
    STZ $NMITIMEN
    LDA #$FF
    STA $WRIO
    LDA #$00
    STZ $WRMPYA
    STZ $WRMPYB
    STZ $WRDIVL
    STZ $WRDIVH
    STZ $WRDIVB
    STZ $HTIMEL
    STZ $HTIMEH
    STZ $VTIMEL
    STZ $VTIMEH
    STZ $MDMAEN
    STZ $HDMAEN
    STZ $MEMSEL
    REP #$20
    LDX #$0000
    LDA #$0000

  ClearLowWram:
    STA $0000, X
    INX 
    INX 
    CPX #$1F00            ; stops at $1EFE: the stack page $1F00-$1FFF is kept
    BNE ClearLowWram
    LDX #$2000            ; $7E:2000-$FFFF

  ClearBank7EHigh:
    STA $7E0000, X
    INX 
    INX 
    BNE ClearBank7EHigh
    LDX #$0000

  ClearBank7F:
    STA $cgram_buffer, X
    INX 
    INX 
    BNE ClearBank7F
    SEP #$20
    LDX #$&data_scene_asset_lists.SceneAssetLists ; dp$2F-$31 = long pointer to the asset list; set after the clear (the direct page is inside it)
    STX $2F
    LDA #$^data_scene_asset_lists.SceneAssetLists
    STA $31
    PLP 
    RTL 
}