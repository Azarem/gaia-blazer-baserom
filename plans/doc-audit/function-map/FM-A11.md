# FM-A11: data and tables, struct inventory

Batch A11 of the doc audit (iteration I014). It covers the 20 data and table files below; they contain no routines, so the "one row per routine" of the template becomes one row per **data label** (blocks and the parts that have their own consumers). Every field width below was read from the handler that consumes it (the access size, `REP`/`SEP` state and any `AND #$00FF`), never from `structs.json`. Where `structs.json` disagrees, the disagreement is logged as an `OQ` with tag `DISCREPANCY` (I014 questions file); nothing in `us/`, `db-us/` or the notes was edited.

Source of the reading: a fresh `npm run extract:lt` (`; {n}` = decimal file offset), `us/blocks.json`, `us/structs.json`, `us/mnemonics.json`, `us/copdef.json`, the consumer files named in each row, `docs/walkthrough/level-up.md`, `docs/cop/index.md` and the earlier function maps FM-A1, FM-A2, FM-A4 to FM-A9 (they defer all struct definitions to this file). The rebuilt ROM was not compared with the original.

| File | File offsets | CPU address | Content |
|------|-------------|-------------|---------|
| `meta_tables_008000` | 32768-39348 (6580) | `$01:8000` | 7 world pointers + 469 actor meta entries of 14 bytes |
| `table_0099B4` | 39348-43486 (4138) | `$01:99B4` | scene placement index and 97 placement lists |
| `table_00A9DE` | 43486-44182 (696) | `$01:A9DE` | chest lists |
| `table_00AC96` | 44182-46746 (2564) | `$01:AC96` | exit (warp) lists |
| `table_00B69A` | 46746-47629 (883) | `$01:B69A` | plate (switch tile) lists |
| `data_00BA0D` | 47629-61070 (13441) | `$01:BA0D` | 420 lair/release records of 32 bytes + terminator |
| `data_00EE8E` | 61070-63898 (2828) | `$01:EE8E` | formation pointers + 434 formation rows |
| `data_00F99A` | 63898-63991 (93) | `$01:F99A` | scene variant rules |
| `data_00F9F7` | 63991-65092 (1101) | `$01:F9F7` | 16 small tables (icon positions, bit masks, facing, music, EXP, sine) |
| `asset_list_028000` | 163840-167938 (4098) | `$05:8000` | per-scene asset lists (layout: FM-A7 4.1) |
| `spc_030000` | 196608-198415 (1807) | `$06:8000` | SPC700 driver upload block |
| `data_048000` | 294912-295424 (512) and 296960-297984 (1024) | `$09:8000`, `$09:8800` | iris frames, 2x2 icon tile records |
| `data_04F000` | 323584-324512 (928) | `$09:F000` | 4 palette/map leaves |
| `table_050000` | 327680-330952 (3272) | `$0A:8000` | animation steps, bank `$0A` |
| `table_058000` | 360448-365596 (5148) | `$0B:8000` | animation steps, bank `$0B` |
| `table_060000` | 393216-395766 (2550) | `$0C:8000` | animation steps, bank `$0C` |
| `table_068000` | 425984-440320 (14336) | `$0D:8000` | VRAM copy steps, bank `$0D` |
| `table_070000` | 458752-460527 (1775) | `$0E:8000` | animation steps, bank `$0E` |
| `table_078000` | 491520-500834 (9314) | `$0F:8000` | animation steps, bank `$0F` |
| `string_lookup_080000` | 524288-525824 (1536) | `$10:8000` | 128-entry dictionary (FM-A6 4.3) |

## 0. Reading the tables

- **Address model (LoROM):** bank = `offset >> 15`, CPU address = `$bank:(8000 + (offset & $7FFF))`. Labels carry the hex file offset (`data_00BA0D` is file offset `$BA0D` = 47629 = `$01:BA0D`).
- **Callers** counts the references **outside** the defining file (`?INCLUDE` lines excluded). A "line" is one referencing instruction line; a "site" is a call or spawn.
- **Evidence labels:** `code` = read in the consuming code, `cons` = confirmed against a second consumer, `data` = arithmetic or a pattern in the bytes, `walk` = the walkthrough, `hw` = hardware fact. **Confidence:** A = field width and meaning both read in code; B = width read in code, meaning inferred; C = inferred from data shape only.
- **Inputs / Outputs / Clobbers** of a data row describe how a consumer reaches it: In = the key and register state, Out = what the consumer takes away, Clobbers = always "none (ROM)" unless a runtime stub is involved.
- **Data touched** lists the WRAM written or read by the consumer, with `us/mnemonics.json` names where one exists; unnamed addresses are listed in section 5.
- **R-2 (bank-base idiom):** actor code runs with DBR `$81`/`$01`, so `$&meta_tables_008000+N,X` there is a real meta read. In `lib_01065B` DBR is the actor's data bank (`$24`, banks `$0A-$0F`), so `$&meta_tables_008000,Y` reads the first word of that bank's pointer table. Neither is a world-pointer access.

## 1. Shared models

### 1.1 How each table is keyed

| Table family | Key | Index step | Where the pointer comes from |
|--------------|-----|-----------|------------------------------|
| Meta entry | world `$03BA` (0-6), actor type byte | `$03B0 = meta_tables_008000[$03BA*2] - $8000`, entry = `$03B0 + type*14` (`lib_shared_0131D1`) | `code_0012DE` |
| Scene placement | `area_current`, `scene_current` | 4-byte rows scanned in order, first match wins | `code_0012DE` |
| Chest, exit | `location_id` (`$1C6A`) | word table `[location_id*2]` | `lib_0109D6`, `lib_0114D0`, `lib_0114E4` |
| Plate | `location_id` and a variant bit | word table `[$03AA]`, `$03AA = location*4` | `lib_0109D6`, `lib_011395` |
| Lair record | record number, `index << 5` | 32 bytes | `code_00144F`, `lib_0112F5`, `lib_011395`, `lib_0109D6` |
| Formation | `$26*2` of the lair actor | word table, row count from the live count `$0C` | `engine_0026F3.code_002752` |
| Animation steps | actor `$22` (table base, `$8000`) + `$1E*2` | list pointer, then `$20*8` (or `*6`) | `code_0008F3`, `lib_01065B` |

### 1.2 Switch bit arrays touched by these tables

The bit number is a 10-bit value (`n and $3FF`, FM-A9 L012/L014); the byte is `base + (n >> 3)`, the mask `binary_00FA77[n and 7]`. The three 64-byte arrays are `$1A5E` (event flags, `event_flags`), `$1A9E` and `$1ADE`; `$1A7E` lies inside the first array's span (`$1A5E + $20`) and is the chest-opened bit array used by the chest rows. A record or switch number therefore fits when it is below 512 bits: the largest gate switch in `data_00BA0D` is `$018C` = 396, below the 420 records.

### 1.3 Animation: two table systems

- **Step lists** (`unk3`, `unk12`; banks `$0A-$0C`, `$0E`, `$0F`): `code_0008F3` reads one step per call: duration, dx, dy, frame pointer. It is the sprite animator for every actor.
- **Copy lists** (`unk11`; bank `$0D`): `lib_01065B` (COPs `92`, `93`, `94`, `95`, `9D`, `9E`) reads one 6-byte step and copies tile graphics to VRAM through a RAM `MVN` stub; it moves no sprite. The header says `unk11` is an animation, the code says it is a graphics-streaming list (FM-A4 4.7).

## 2. Data rows

Offsets are `decimal file offset / size in bytes`.

| ID | Label | Off / size | Callers | Subsystem | Name (conf; evidence) | In | Out | Clobbers | Data touched |
|----|-------|------------|---------|-----------|-----------------------|----|-----|----------|--------------|
| D01 | `meta_tables_008000` header | 32768 / 14 | 1 line (`engine_000000.code_0012DE`) | actor | `WorldMetaPointers` (A; code) | `$03BA` world index, `ASL; TAX` | word address of the world's entry list | none (ROM) | r `$03BA`; w `$03B0` |
| D02 | `meta_entry_00800E` | 32782 / 1330 (95) | world 0 (Grass Valley); 41 lines in 7 files shared by D02-D08 (`engine_000000` 22, `engine_0026F3` 8, `engine_003005` 6, `lib_0118FC` 2, `lib_01065B` 1 (R-2, not a real read), `engine_0029EC` 1, `common_actor_0FB0F5` 1) | actor | `MetaGrassValley` (B; code, data) | `X = $03B0 + type*14` | one 14-byte `meta_entry` (4.1) | none (ROM) | actor fields `$16 $18 $1C $1E $22 $24 $25 $36 $38` |
| D03 | `meta_entry_008540` | 34112 / 1134 (81) | world 1 (Greenwood), shared as D02 | actor | `MetaGreenwood` (B; code, data) | as D02 | as D02 | none | as D02 |
| D04 | `meta_entry_0089AE` | 35246 / 1218 (87) | world 2 (St. Elles), shared | actor | `MetaStElles` (B) | as D02 | as D02 | none | as D02 |
| D05 | `meta_entry_008E70` | 36464 / 952 (68) | world 3 (Mountain of Souls), shared | actor | `MetaMountainOfSouls` (B) | as D02 | as D02 | none | as D02 |
| D06 | `meta_entry_009228` | 37416 / 770 (55) | world 4 (Leo's Lab), shared | actor | `MetaLeosLab` (B) | as D02 | as D02 | none | as D02 |
| D07 | `meta_entry_00952A` | 38186 / 868 (62) | world 5 (Magridd's Castle), shared | actor | `MetaMagriddsCastle` (B) | as D02 | as D02 | none | as D02 |
| D08 | `meta_entry_00988E` | 39054 / 294 (21) | world 6 (World of Evil), shared | actor | `MetaWorldOfEvil` (B) | as D02 | as D02 | none | as D02 |
| D09 | `table_0099B4` (`unk1` rows) | 39348 / 389 (97 rows + terminator) | 3 lines / 1 file (`engine_000000.code_0012DE` 2, `code_001314` 1) | placement | `ScenePlacementIndex` (A; code, cons) | `area_current`, `scene_current` scanned in 4-byte steps | `$29` = list pointer; first byte `>= $80` ends the scan | none | r `area_current`, `scene_current`; w `$29`, `$2B`, actor `$3A` |
| D10 | 97 `unk2` lists (labels `unk2_*`) | 39737 / 3749 (913 rows + 97 terminators) | via `[$29]` in `code_001314` (1 file) | placement | `ScenePlacementLists` (A; code, data) | `[$29]` row pointer | one 4-byte placement row (4.2); list ends at first byte `$FF` | none | r list; w new actors' `$00 $02 $1C $38` |
| D11 | `table_00A9DE` pointer words | 43486 / 256 (128 words) | 14 lines / 2 files (`lib_0109D6` 7, `lib_0114E4` 7) | chest | `ChestListPointers` (A; code, cons) | `location_id*2` | word address of the chest list; entries for `$7E`, `$7F` are `$0000`; `$03AE` keeps the offset | none | r `location_id`; w `$03AE` |
| D12 | chest lists | 43742 / 440 (38 lists, 67 rows; shared empty list `binary_00AC95`) | as D11 | chest | `ChestLists` (A; code) | list pointer | 6-byte chest row (4.3), list ends at `$FF` | none | `$1A7E` chest bits, `$7EC000` BG2 map, `inventory`, Gems BCD |
| D13 | `table_00AC96` pointer words | 44182 / 256 (128 words) | 16 lines / 2 files (`lib_0109D6` 14, `lib_0114D0` 2) | warp | `ExitListPointers` (A; code) | `location_id*2` | word address of the exit list; `lib_0114D0` stores it to `$03B2` | none | r `location_id`; w `$03B2` |
| D14 | exit lists | 44438 / 2308 (97 lists, 201 rows) | as D13 | warp | `ExitLists` (A; code, cons) | list pointer | 11-byte exit row (4.4) | none | `area_next`, `scene_next`, `warp_dest_x/y/anim`, `transition_type` |
| D15 | `table_00B69A` pointer words | 46746 / 512 (256 words) | 16 lines / 2 files (`lib_0109D6` 7, `lib_011395` 9) | switch | `PlateListPointers` (A; code) | `$03AA = location*4` | word address of the plate list (2 words per location) | none | r `location_id`, `$03AA` |
| D16 | plate lists | 47258 / 371 (7 lists, 91 rows; the empty list is the last byte `$00BA0C`) | as D15 | switch | `PlateLists` (A; code) | list pointer | 4-byte plate row (4.5) | none | `$1A9E` bit array, record `id << 5` |
| D17 | `data_00BA0D` | 47629 / 13441 (420 x 32 + terminator) | 71 lines / 10 files (`lib_0109D6` 24, `lib_0112F5` 12, `lib_011395` 11, `lib_010EA9_part1` 7, `engine_000000` 7, `lib_0133A6_part1` 5, `lib_027912` 2, `cop_handler_005E0D`, `engine_0026F3`, `engine_003005` 1 each) | lair / release | `LairRecords` (A; code, cons, data) | record `index << 5`; `+0 = $FF` ends | see 4.6 | none | `lair_state` (`$7F:0203`), `$1A9E`, `$1ADE`, `tile_type_map`, `$7EC000`, `$1C6D-$1C74` |
| D18 | `data_00EE8E` pointer words | 61070 / 224 (112 words) | 1 line (`engine_0026F3.code_002752`) | lair spawn | `FormationPointers` (A; code) | `$26*2` | word address of a formation list | none | r actor `$26` |
| D19 | formation rows | 61294 / 2604 (434 rows x 6) | as D18 | lair spawn | `FormationRows` (A; code, data) | row pointer, count from the live count `$0C` (no terminator) | 6-byte formation row (4.7) | none | w new actor x, y, `$1C` |
| D20 | `data_00F99A` | 63898 / 93 (23 rows x 4 + terminator) | 4 lines / 1 file (`lib_0133A6_part1.code_011662`) | scene | `SceneVariantRules` (A; code, cons FM-A7 4.4) | rows scanned until byte `>= $80` | `$031E = variant`; row applies when the switch bit is set | none | r `location_id`, `$1ADE`; w `$031E` |
| D21 | `word_00F9F7` | 63991 / 16 (8 words) | A5 `code_011F18` | menu | `WeaponIconPositions` (A; cons FM-A5) | slot 0-7, `ASL; TAX` | BG tilemap byte offset | none | `$1B1E` bytes |
| D22 | `word_00FA07` | 64007 / 16 (8 words) | as D21 | menu | `ArmorIconPositions` (A; cons FM-A5) | as D21 | as D21 | none | `$1B26` |
| D23 | `word_00FA17` | 64023 / 16 (8 words) | as D21 | menu | `MagicIconPositions` (A; cons FM-A5) | as D21 | as D21 | none | `$1B2E` |
| D24 | `word_00FA27` | 64039 / 80 (40 words) | A5 `code_011FD3` | menu | `ItemIconPositions` (A; cons FM-A5) | slot 0-39 | BG tilemap byte offset | none | `$1B36-$1B5D` |
| D25 | `binary_00FA77` | 64119 / 8 | 7 sites / 3 files (FM-A9 L012-L014) | bit array | `BitMaskTable` (A; code, cons) | `n and 7` | `01 02 04 08 10 20 40 80` | none | the three switch arrays |
| D26 | `binary_00FA7F` | 64127 / 44 | 2 labels (`code_0273D4`, `code_0273F9`) | player | `PlayerFacingByAnim` (A; code, cons) | player `$1E` (0-`$2B`) | facing code 0 up, 1 down, 2 right, 3 left (A5) | none | player actor `$1E` |
| D27 | `binary_00FAAB` | 64171 / 44 | 2 lines (`common_actor_001A28_part1.code_001892`, `w3_actor_022007`) | player | `PlayerFacingByAnimAlt` (C; code, data) | player `$1E` | an alternate 0-3 value per anim id; differs from D26 | none | player `$1E` |
| D28 | `word_00FAD7` | 64215 / 88 (44 words) | 2 lines (`common_actor_001A28_part1`, `w0_actor_01AF5C`) | player | `WeaponYOffsetByAnim` (B; code, data) | player `$1E*2` | 0 or 1 added to the weapon actor's y | none | actor `$039E` y |
| D29 | `word_00FB2F` | 64303 / 26 (13 words) | 4 lines (`lib_shared_012769`, FM-A6 TR23) | text | `GaugeColorLadder` (A; cons FM-A6) | `2*floor(cur/10)` | BGR555 colour | none | `cgram_buffer+$14/$1C` |
| D30 | `table_00FB49` | 64329 / 63 (21 long pointers) | 2 lines (`cop_handler_005CF0_part1`) | audio | `MusicPointerTable` (B; code) | index `*3` | long pointer to a music block | none | SPC upload |
| D31 | `table_00FB88` | 64392 / 24 (8 long pointers) | 2 lines (`lib_0118FC_part5`) | magic | `MagicGraphicsPointers` (A; cons FM-A5) | spell `n` | `graphics_07B000 + {0,0,$800,$1000,$1000,$1800,$1800,$800}` | none | VRAM `$2600` |
| D32 | `table_00FBA0` | 64416 / 24 (8 pointers) | 1 line (`lib_0118FC_part5`) | magic | `MagicPalettePointers` (A; cons FM-A5) | spell `n` | `palette_07D000 + $20*n` | none | `cgram_buffer+$160` |
| D33 | `word_00FBB8` | 64440 / 204 (51 rows x 4) | 4 lines (`common_actor_001A28_part4.code_002F56`) | level | `LevelExpThresholds` (A; code, walk) | level x 4 | row (4.9): BCD EXP needed | none | `$1B7E`, `player_exp_next` |
| D34 | `binary_00FC84` | 64644 / 64 | 9 lines / 6 files (with D35) | math | `SineTableHead` (A; code, data) | angle byte | first 64 entries of the 320-byte signed sine | none | `$7E:7900-$7CFF` |
| D35 | `binary_00FCC4` | 64708 / 256 | 4 lines | math | `SineTableTail` (A; code, data) | angle byte | entries 64-319; cosine = sine + 64 | none | as D34 |
| D36 | `binary_00FDC4` | 64964 / 128 | 2 lines (`lib_0116C3`) | effect | `CircleHalfWidths` (B; code, data) | row, Y steps by 2 | half-width of a circle row | none | `$7EC000` area |
| D37 | `asset_list_028000` | 163840 / 4098 | 2 lines (`lib_0133A6_part3`) | scene | `SceneAssetLists` (A; cons FM-A7 4.1) | `area_current`, `scene_current` | record, 98 extraction rows (the first, area `$53` scene `$59`, is empty) | none | asset loader |
| D38 | `spc_030000` | 196608 / 1807 | 2 lines (`common_shared_0FEEA6`) | audio | `SpcDriverBlock` (B; code) | `$29-$2B` = source, `$0320 = $3000` | IPL upload stream: word length, word ARAM dest, data | none | SPC ports |
| D39 | `binary_048000` | 294912 / 512 | 8 lines (`lib_027781_part2`) | transition | `IrisFrames` (B; code, data) | frame 0-31 | 16 bytes, 2bpp | none | VRAM |
| D40 | `unk17_048800` | 296960 / 1024 (128 x 8) | 8 lines / 2 files (`lib_0118FC` 4, `lib_shared_012390` 4) | menu | `IconTileRecords` (A; code) | `byte*8` | 4 words (TL, TR, BL, BR) | none | `$7F:7800/7840` |
| D41 | `binary_04F000` | 323584 / 256 | 2 lines (A5) | menu | `ItemPagePalette` (A; cons FM-A5) | CGRAM 0-127 | palette | none | `cgram_buffer` |
| D42 | `binary_04F100` | 323840 / 256 | 2 lines (A6) | menu | `MenuBgPalette` (A; cons FM-A6) | -- | palette | none | `cgram_buffer` |
| D43 | `binary_04F200` | 324096 / 256 (16 x 16) | 2 lines (`lib_shared_012390`) | menu | `MenuTileGroupMap` (A; code) | cell | group index; `x8` indexes D40 | none | `$7F:7800/7840` |
| D44 | `binary_04F300` | 324352 / 160 | 2 lines (A5) | menu | `MenuSpellPalettes` (A; cons FM-A5) | -- | CGRAM `$160` palettes 11-15 | none | `cgram_buffer+$160` |
| D45 | `table_050000` | 327680 / 3272 (26 lists, 116 steps, 64 leaves) | by `$24 = $0A` only (`lib_027781_part1.code_0273F9`) | animation | `PlayerUnarmedAnims` (B; code) | actor `$1E`, `$20` | 8-byte step (4.8) | none | player actor `$22 $1E $20 $14 $04 $06 $28` |
| D46 | `table_058000` | 360448 / 5148 (44 lists, 184 steps, 100 leaves) | meta `Address` x 7 (entry 0 of each world), `$24 = $0B` in `code_0273F9` and `engine_routines_001D3B` | animation | `PlayerAnims` (A; code, data) | as D45 | as D45 | none | as D45 |
| D47 | `table_060000` | 393216 / 2550 (44 lists, 120 steps, 42 leaves) | `$24 = $0C` for the `$039E` actor in `engine_routines_001D3B.loc_001ED3` only | animation | `WeaponOverlayAnims` (B; code, data) | as D45 | as D45 | none | weapon actor `$039E` |
| D48 | `table_068000` | 425984 / 14336 (80 lists, 686 steps, 593 leaves) | 69 meta `Address` + 13 `CopA8 #$8000,#0D` sites in 9 files | graphics stream | `VramCopyLists` (A; code, cons FM-A4 4.7) | actor `$22`, `$1E`, `$20` | 6-byte copy step (4.10) | none | `$1C5C` stub, VRAM write queue |
| D49 | `table_070000` | 458752 / 1775 (17 lists, 83 steps, 28 leaves) | 4 meta `Address` + 14 `CopA8 #$8000,#0E` sites in 10 files | animation | `EffectAnimsE` (C; code, data) | as D45 | as D45 | none | effect actors |
| D50 | `table_078000` | 491520 / 9314 (54 lists, 264 steps, 124 leaves) | 8 `CopA8 #$8000,#0F` sites in 2 files (`common_actor_001A28_part2` 7, `engine_routines_002678` 1) | animation | `EffectAnimsF` (C; code, data) | as D45 | as D45 | none | effect actors |
| D51 | `string_lookup_080000` | 524288 / 1536 (128 x 12) | 4 lines (`lib_shared_012769`) | text | `Dictionary` (A; cons FM-A6 4.3) | entry id | 12-byte entry | none | text buffer |

D49 and D50 are named `EffectAnimsE/F` at confidence C: the bank is referenced only by `CopA8` operands in effect and boss actors, and the step data matches D45. A better name needs the actor lists (OQ-I014-13).

## 3. Per-label inventories

### 3.1 Meta lists (D02-D08)

| List | Entries | Size | First-row note |
|------|---------|------|----------------|
| `meta_entry_00800E` | 95 | 1330 | entry 0 is the player; `Address` = `$7E3800` (the world's own spritemap asset) |
| `meta_entry_008540` | 81 | 1134 | |
| `meta_entry_0089AE` | 87 | 1218 | |
| `meta_entry_008E70` | 68 | 952 | |
| `meta_entry_009228` | 55 | 770 | |
| `meta_entry_00952A` | 62 | 868 | |
| `meta_entry_00988E` | 21 | 294 | |

Total 469 entries; block size = 14 + 469 x 14 = 6580. Operand counts of the `Address` field (3 bytes, offset +8 word and +A bank) over all 469: 358 `$7E3800` (spritemap decompressed to WRAM), 69 `@table_068000`, 31 `$000000` (no animation), 7 `@table_058000` (entry 0 of every world), 4 `@table_070000`. Counts of the flags word (+6): `$2010` 95, `$2040` 87, `$0040` 49, `$0000` 43, `$2048` 39, `$2050` 38, `$1000` 22, `$3040` 21 (sum 394; the rest are 75 rows with one-off values).

The list-to-world order is the order of the header words; it follows from `$03BA` selecting `[$03BA*2]` (code), the names are from the directory of the actor files that use each list (B).

### 3.2 Placement (D09, D10)

97 index rows, 97 lists, 913 placement rows. Check: 389 + 3749 = 4138 = block size. The first row of each list is the player (the `bit $0080` test in `code_001314` replaces its x and y with `warp_dest_x/y` when either is non-zero, and stores `player_actor`).

### 3.3 Chest, exit, plate (D11-D16)

| Table | Pointer words | Lists | Rows | Bytes |
|-------|--------------|-------|------|-------|
| chest | 128 | 38 (+ shared empty `binary_00AC95`) | 67 | 256 + 440 = 696 |
| exit | 128 | 97 | 201 | 256 + 2308 = 2564 |
| plate | 256 (2 per location) | 7 | 91 | 512 + 371 = 883 |

Chest pointers `$7E` and `$7F` are `$0000` (no list). The sizes add up to the block sizes in the file table.

### 3.4 Lair records (D17): value ranges of the fields

| Field | Values seen over the 420 records |
|-------|----------------------------------|
| `+8` layer | 0, 2, 3 |
| `+13` monster count | 0 (5), 1 (36), 2 (37), 3 (54), 4 (93), 5 (61), 6 (98), 7 (5), 8 (28), 10 (3) |
| `+16` word | 0 (409), `$4000` (6), `$C000` (4), `$8000` (1) |
| `+18`, `+1A` words | always 0 |
| `+1C` | 0 (408), `$0100` (6), `$0200` (3), `$0300` (3) as a word; always 0 as a byte pair `+1C` |
| `+1D` warp anim | 0-3 |
| `+1E` word | 0 (393), 27 records with a gate (max `$018C`) |

Check of the tail: 11 records have `+16`, 12 have a non-zero `+1C/+1D` word, 27 have `+1E`, one record has both `+1C` and `+1E`: 11 + 12 + 27 - 1 = 49 = 420 - 371 all-zero records.

### 3.5 Animation tables (D45-D50)

| Table | Bank | Pointer table | Lists | Steps | Leaves (frames) | Reached by |
|-------|------|---------------|-------|-------|-----------------|------------|
| `table_050000` | `$0A` | 26 words | 26 | 116 | 64 | `$24 = $0A` (player, no weapon) |
| `table_058000` | `$0B` | 44 words | 44 | 184 | 100 | meta entry 0 of each world; `$24 = $0B` (player, armed) |
| `table_060000` | `$0C` | 44 words | 44 | 120 | 42 | `$24 = $0C` (weapon actor `$039E`) |
| `table_068000` | `$0D` | 80 words | 80 | 686 | 593 | 69 meta entries, 13 `CopA8` sites |
| `table_070000` | `$0E` | 17 words | 17 | 83 | 28 | 4 meta entries, 14 `CopA8` sites |
| `table_078000` | `$0F` | 54 words | 54 | 264 | 124 | 8 `CopA8` sites |

`CopA8_SetFields22And24` operands over the ROM: `#$8000,#0E` 14, `#$8000,#0D` 13, `#$8000,#0F` 8, plus `#$F000,#7E` and `#$3800,#7E` once each (the WRAM-resident spritemap asset).

Size check, step lists: a list is `steps x 8 + 2` bytes (the `$FFFF` end word). Example: the list at `$050034` has one step and is 10 bytes (next list at `$05003E`); the 6-step list at `$05005C` is 50 bytes (next at `$05008E`). Copy lists end with one `$00` byte: the 6-step list at `$0680A0` is 6 x 6 + 1 = 37 bytes, followed by its leaf `binary_0680C5` (6 x 24 = 144 bytes) and the next list at `$068155`.

## 4. Struct layouts

### 4.1 `meta_entry` (14 bytes)

`$38` of an actor points at its entry; every read is `$&meta_tables_008000+N,Y` with DBR `$01`/`$81`.

| Off | Width | Field | Evidence |
|-----|-------|-------|----------|
| +0 | byte | attack | 8-bit read under `SEP #$20` (FM-A1 R35) |
| +1 | byte | defence | `LDA +1; STA dp00` under `SEP #$20` (FM-A1 R36) |
| +2 | byte | HP | `LDA +2; STA $0025,Y` (`code_0013AB`, `code_00144F`) |
| +3 | word | EXP (BCD) | `lib_027614.code_027687` reads it as a word (FM-A2 4.1) |
| +5 | byte | animation id | `STA $001E,Y` under `SEP #$20` in `code_0013AB`, `code_00144F`, `engine_003005` |
| +6 | word | flags | `LDA +6; ORA #$8000; STA $0016,X` (`code_00295E`) |
| +8 | word | animation table pointer | `STA $0022,X` |
| +A | byte | animation bank | `STA $0024,X` |
| +B | word | script pointer | `STA $0018,X` |
| +D | byte | script bank | `STA $0036,X` |

Matches `structs.json` `meta_entry` (`Byte, Byte, Byte, Word, Byte, Word, Address, @Code`: `+8..+A` is the 3-byte `Address`, `+B..+D` the 3-byte `@Code`). One anomaly: `engine_0026F3.code_00296A` loads `+5` as a **word** (`REP #$20; LDA +5; STA $001E,X`), so `+6`'s low byte becomes the high byte of the animation id read by `code_0008F3` (`ASL` of the whole word). It is harmless only for rows whose flags low byte is 0 (OQ-I014-5).

### 4.2 Placement index (`unk1`, 4 bytes) and row (`unk2`, 4 bytes)

| Struct | Off | Width | Field | Evidence |
|--------|-----|-------|-------|----------|
| `unk1` | +0 | byte | area | `LDA table+0,X; BMI end; CMP area_current` (`code_0012DE`) |
| `unk1` | +1 | byte | scene | `CMP scene_current` |
| `unk1` | +2 | word | `&unk2` list | `LDA table+2,X; STA $29` (`code_001314`) |
| `unk2` | +0 | byte | x tile | `code_0013AB`: `<< 4` |
| `unk2` | +1 | byte | y tile | `<< 4`, plus 16 |
| `unk2` | +2 | byte | flags | the word at `+1` is masked with `$C100` into `$1C`: bits 7 and 6 are the flip bits and bit 0 becomes `$1C` bit 8 |
| `unk2` | +3 | byte | meta type | times 14 through `lib_shared_0131D1`, plus `$03B0` |

A list ends at a first byte of `$FF` (`CMP #$00FF`), an index scan at a first byte `>= $80`.

### 4.3 Chest row (6 bytes)

| Off | Width | Field | Evidence |
|-----|-------|-------|----------|
| +0 | byte | x (player tile) | `lib_0109D6` `TryOpenChest`, compare with `player_tile_x` |
| +1 | byte | y (player tile; chest tile is `y-1`) | compare with `player_tile_y` |
| +2 | byte | bit 0-6: bit number in `$1A7E`; bit 7: also edit the BG2 map `$7EC000` | `lib_0109D6`, `lib_0114E4` |
| +3 | byte | item (0 empty, `$FF` Gems) | `lib_0109D6` |
| +4 | word | Gems (BCD) | read with `REP #$20` |

`lib_0114E4` runs at scene init: it walks the list and turns tile `$FB` into `$FC` for chests whose bit is set.

### 4.4 Exit row (11 bytes)

| Off | Width | Field | Evidence |
|-----|-------|-------|----------|
| +0, +1 | byte, byte | x, y of the trigger rectangle | `lib_0109D6` lines 193-280 |
| +2, +3 | byte, byte | width, height | same |
| +4 | byte | `area_next` | stored to `$0319` |
| +5 | byte | `scene_next` | stored to `$0318` |
| +6 | byte | `warp_dest_anim` | stored to `$0380` |
| +7 | word | `warp_dest_x` | `LDY` with X 16-bit |
| +9 | word | `warp_dest_y` | same |

`structs.json` `unk6` declares 11 Bytes: a retype is proposed in 4.17 (OQ-I014-2).

### 4.5 Plate row (4 bytes)

| Off | Width | Field | Evidence |
|-----|-------|-------|----------|
| +0 | byte | x tile | `lib_011395`, `lib_0109D6` |
| +1 | byte | y tile | same |
| +2 | word | id | the bit number in `$1A9E` and the record index (`id << 5`) |

### 4.6 Lair / release record (`unk8`, 32 bytes)

| Off | Width | Field | Evidence |
|-----|-------|-------|----------|
| +0 | byte | home location | compared with `location_id`; `$FF` ends the array (`BMI`/`CMP #$FF`) |
| +1 | byte | variant slab number | copied to `$1C6E` |
| +2, +3 | byte, byte | home tile x, y | `lib_0112F5` |
| +4, +5 | byte, byte | live rectangle x, y | `code_0111CB`, `code_01125E` |
| +6, +7 | byte, byte | rectangle w, h; `0/0` (an `ORA` test) writes one type-1 tile to `tile_type_map` | `lib_0112F5` |
| +8 | byte | layer: non-zero also writes BG2 `$7EC000`; bit 0 selects `code_01125E` or `code_0111CB` | `lib_0109D6`, FM-A2 4.2 |
| +9 | byte | name index (`$03C8`, `asciistring_list_0152E6`) | `lib_010EA9_part1` |
| +A | byte | low bits of `lair_state` after release (ORed with `$80`, or `$C0` for a rectangle) | `lib_0109D6_part5` |
| +B | byte | lair location | step on it calls `code_010C25` |
| +C, +D | byte, byte | lair tile x, y | `code_010C25` writes `$FF` to the BG1 map (and BG2 when `+8` is non-zero) |
| +E, +F | byte, byte | staging rectangle x, y (tiles) | `code_01112A` |
| +10 | word | script address (low part of `@Code`) | `code_00144F` |
| +12 | byte | script bank | `STA $0036,Y` (`LDA data_00BA0D+12,X`) |
| +13 | byte | monster count (also the initial `lair_state`) | `code_00144F` copies it to `$2E` and `$2F`; `engine_0029EC.code_002B86` decrements `$2E` of the parent on a child's death; `code_0028C6` fires when `$2E` reaches 0; `lib_027912` copies it to `$7F0203+i` |
| +14 | byte | spawn interval (`code_0026F3`, `code_00271B`: `$14 = 3*$26 - 1`) or formation index (`code_002752`: `$26*2` into D18) | `AND #$00FF` in `code_00144F` |
| +15 | byte | meta type | times 14 plus `$03B0` |
| +16 | word | OAM attribute extra (`$4000`, `$8000`, `$C000` only) | `ORA #$0100`, `ORA $0372`, into `$1C`/`$30` |
| +18, +1A | word, word | always 0; **no reader** | width unverified (OQ-I014-4) |
| +1C | byte | always 0 | width unverified |
| +1D | byte | `warp_dest_anim` (0-3) | `code_0115F1` |
| +1E | word | gate switch (bit in `$1ADE`) | `cop_handler_005E0D`, `engine_003005`, `code_011395` |

The first 8 bytes are copied by `MVN #$01,#$^data_00BA0D` to `$1C6D-$1C74` (the active release record).
The walkthrough-consistent reading: stepping on the lair tile (`+B..+D`) frees a being, which appears at the home tile (`+0..+3`) and whose script is the record's `@Code`.

### 4.7 Formation row (`unk9`, 6 bytes)

| Off | Width | Field | Evidence |
|-----|-------|-------|----------|
| +0 | word | x | `engine_0026F3.code_002752` |
| +2 | word | y | same |
| +4 | word | OR-bits into `$1C` (after `AND #$3FFF`) | same |

No per-list terminator; the count comes from the lair state count `$0C`. Check: 224 + 434 x 6 = 2828.

### 4.8 Animation step (`unk3`, `unk12`; 8 bytes) and frame

| Off | Width | Field | Evidence |
|-----|-------|-------|----------|
| +0 | word | duration; negative ends the list (`BPL`); stored in `$14` | `code_0008F3` |
| +2 | word | dx (stored to `$04`; `0 - dx` when flip X, bit 14 of `$1C`) | same |
| +4 | word | dy (stored to `$06`; negated for flip Y, bit 15) | same |
| +6 | word | `&frame` | `TAY` then the header reads |

The list ends with the word `$FFFF`. `structs.json` declares 6 Bytes + `&Binary`: retype proposed in 4.17.

**Frame leaf:** 12-byte header of 6 words (`+0`, `+2`, `+4`, `+6` box edges swapped on flip into `$08/$0C/$0A/$0E`; `+8` width into `$10`; `+A` height into `$12`), then the spritemap at `+12` (`$28 = frame + $0C`). A 35-byte frame is 12 + 2 + 3 x 7. This is the layout of the `.spm` spritemap files too (mapping item 1.10): a word table based at `$3800`, step lists, frame leaves with `$FFFF`/`$0000` markers (the `$FFFF` is the step-list end, the `$0000` a zero duration).

### 4.9 EXP threshold row (`word_00FBB8`, 4 bytes)

High word to `$1B7E`, low word to `player_exp_next`, BCD; row index = level x 4; row 50 = `9999 9999`. Verified against `docs/walkthrough/level-up.md`: 100, 280, 580, 1,000, 2,000, 3,200, 4,500, 5,800, 7,600, 9,600, 12,400, 15,000, 19,000, 25,000, 32,000, 42,000, 59,000, 83,000, 115,000, 160,000, 220,000 all match.

### 4.10 Copy step (`unk11`, 6 bytes)

| Off | Width | Field | Evidence |
|-----|-------|-------|----------|
| +0 | byte | hold count (0 ends; `$26 = hold - 1`) | `lib_01065B` |
| +1 | word | source pointer (to `$08`) | same |
| +3 | byte | destination slot (`*2` to `$0A`) | same |
| +4 | byte | length - 1 (to `$0C`, the `MVN` count) | same |
| +5 | byte | delay (to `$14` and `$0E`) | same |

`lib_0106CD` runs the RAM stub at `$1C5C` (`8B 54 .. .. AB 60` = `PHB`, `MVN`, `PLB`, `RTS`, built in `lib_027912`). Its bank bytes come from `LDA $23,X; AND #$00; SBC $007F09,X`, an odd decode (OQ-I014-6).

### 4.11 Smaller records

| Struct | Size | Fields | Evidence |
|--------|------|--------|----------|
| `unk10` scene variant | 4 | +0 byte location (`>= $80` ends); +1 word switch bit in `$1ADE` (`LDA +2; XBA; LDA +1`); +3 byte variant to `$031E` | `code_011662`; FM-A7 4.4 |
| `unk17` icon tile record | 8 | 4 words: TL, TR, BL, BR 2x2 tilemap entries | `code_012390`, `lib_0118FC` |
| Asset record | variable | FM-A7 4.1 (counts: spritemap 47, music 65, asset8 200, tilemap 135, tileset 62, palette 109, graphics 107) | `lib_0133A6_part3` |
| Dictionary entry | 12 | FM-A6 4.3; entry `$06` is spelled "Deathtole" (OQ-I010-2) | `lib_shared_012769` |
| SPC upload stream | -- | word length, word ARAM dest, data | `common_shared_0FEEA6.code_0FF0E6` |

### 4.12 Pointer-table index domains

`ChestListPointers` and `ExitListPointers` are 128 words indexed by `location_id`; `PlateListPointers` has 256 words (`location*4`); `FormationPointers` has 112 words; the animation pointer tables are indexed by `$1E` (44 ids for D46 and D47, 26 for D45, 80, 17, 54 for the rest).

## 4.17 `structs.json` proposals (proposals only, no edits)

| Struct | Now | Proposed | Why |
|--------|-----|----------|-----|
| `unk6` (exit row) | 11 Bytes | 7 Bytes + 2 Words | `+7`, `+9` are 16-bit reads |
| `unk3`, `unk12` (step) | 6 Bytes + `&Binary` | 3 Words + `&Binary` | duration, dx, dy are word reads |
| `unk8` (lair) | 16 Bytes, `@Code`, 3 Bytes, 5 Words | 16 Bytes, `@Code`, 2 Bytes (`+13`, `+14`), 1 Byte (`+15`), Word (`+16`), then `+18`/`+1A`/`+1C-+1D` pending, Word (`+1E`) | `+14` is a byte; `+1D` is a byte read; `+18..+1C` have no reader |

## 5. WRAM proposals

Names that already exist in `us/mnemonics.json` are used in the rows above. New ones used here (proposals; no edit made):

| Address | Proposed name | Evidence |
|---------|---------------|----------|
| `$7F0203` | `lair_state` | `lib_027912` copies `+13` there |
| `$1A7E` | `chest_opened_bits` | chest rows 4.3 |
| `$1A9E`, `$1ADE` | `switch_bits_a`, `switch_bits_b` | FM-A9 |
| `$03B0` | `meta_table_offset` | `code_0012DE` |
| `$03BA` | `world_index` | `code_0012DE` |
| `$031E` | `scene_variant` | `code_011662` |
| `$03AE`, `$03B2` | `chest_list_offset`, `exit_list_offset` | `lib_0114E4`, `lib_0114D0` |
| `$039E` | `weapon_actor` | follows the player (`word_00FAD7` offset) |
| `$0439` | `no_combat_flag` | FM-A7 4.2 |
| `$1B5E` | `equipped_weapon` | FM-A1 |
| `$1B7E` | `player_exp_next_hi` | row 4.9 |
| `$0372` | `sprite_attr_base` | OR-ed into `$1C` |
| `$1C5C` | `mvn_stub` | 4.10 |
| `$1C6D-$1C74` | `release_record` | 4.6 |
| `$03C8` | `name_index` | 4.6 |

## 6. Inner labels

D02-D08 hold 469 `meta_entry_*` rows; D10 holds 97 `unk2_*` list labels; D12 38, D14 97, D16 7 list labels; D19 112 list labels; the animation tables hold 26 + 44 + 44 + 80 + 17 + 54 = 265 list labels and 951 leaf labels (64 + 100 + 42 + 593 + 28 + 124) `binary_*`. All come from the extractor; none is referenced from outside its own block except through the pointer tables above.

## 7. Findings, placement and closing of mapping items

- **2.8 Struct inventory:** `meta_entry`, `unk1`, `unk2`, `unk6`, `unk7`, `unk8`, `unk9`, `unk10`, `unk3`, `unk11`, `unk12`, `unk17` all have widths read from consumers (4.1-4.11); three `structs.json` declarations disagree and are proposed in 4.17.
- **1.10 Spritemap / `.spm` struct:** the word table, step lists and frame leaves of 4.8 are the layout (a pointer table based at `$3800`); the `0xFFFF` marker ends a step list.
- **3.6 `data_00BA0D` and the other `data_*` blocks:** consumers are named for `00BA0D` (lair records), `00EE8E` (formations), `00F99A` (scene variants) and `00F9F7` (D21-D36).
- The sine table is 320 bytes (`00FC84` 64 + `00FCC4` 256, cosine = sine + 64); FM-A9 L007 reads 256 entries from `00FC84`. The split at `00FCC4` is an extraction boundary.
- **Placement proposal:** a future regroup could merge `binary_00FC84` and `binary_00FCC4`; this step is not a regroup and the ROM is unchanged.
- Answered statically: lair `+13` is the monster count (OQ-I006-16 and OQ-I013-11 can close); lair `+14` is a byte (FM-A2 4.2 says word).

## 8. Open questions

The `OQ-I014-k` rows are in `plans/extracted-audit/questions/I014_questions.md`.
