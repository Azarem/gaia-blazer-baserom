# FM-A7: library `0133`-`0147` (scene loader, boot hardware setup, scene profiles, story and menu strings)

PA batch A7, iteration I011. Read-only analysis: no names, notes, comments, `blocks.json`, `overrides.json` or docs were changed. Every proposed name below is a proposal for step PC (`npm run names`); every unverified claim is an `OQ-I011-k` row in `plans/extracted-audit/questions/I011_questions.md`. (A4 owns I008, A5 I009, A6 I010; A7 takes I011.)

Source: a fresh `npm run extract:lt`. Forty-four files were read end to end; offsets are decimal file offsets (the `{n}` tag; LoROM: bank = `offset >> 15`, address = `$bank:(8000 + (offset & 7FFF))`). The label suffix is the hex file offset, so `code_013272` is at `$02:B272`, `code_01157E` at `$02:957E` and the asset list `asset_list_028000` at `$05:8000`. The batch name says "library 0133-0147"; `lib_0133A6` is a legacy name whose five parts are scattered (`$1157E`, `$131C9`, `$13272`, `$168A1`, `$1728D`), and three of its parts are far outside `0133`-`0147` (see the table).

| File | Offsets | Labels | Content |
|------|---------|--------|---------|
| `lib_0133A6_part1` | 71038-71317 | 1 (+2 sub-label rows) | lair states, flag map patches and the scene-variant lookup, run right after the loader |
| `lib_0133A6_part2` | 78281-78289 | 1 | wait N vblanks |
| `lib_0133A6_part3` | 78450-80602 | 21 | the whole scene asset loader: Quintet LZ decompressor, record walker, eight command handlers, boot hardware reset |
| `lib_0133A6_part4` | 92321-93741 | list + 97 records | scene profile list (128 words) and the 97 twelve-byte profile records |
| `lib_0133A6_part5` | 94861-95492 | 70 rows | flag-driven map patch rows (`unk13`, 9 bytes) |
| `lib_013ADA` | 80602-80679 | 1 | default PPU layout at boot |
| `lib_013B27` .. `lib_0143B0` (26 files) | 80679-82957 | 26 strings | title, intro story (14 pages), tile block, ending story (7 pages), THE END, save slot menu |
| `lib_01440D` | 82957-83037 | 1 binary | four save slot line templates |
| `lib_014516`, `lib_014527`, `lib_014536` (+`_part2`), `lib_014547`, `lib_01456A` | 83222-83313, 83906-85762 | 5 strings + 1 list | LEVEL UP banner and clear, pause location banner, lair counter, banner erase, 128 location names |
| `lib_01464B`, `lib_014660`, `lib_014675`, `lib_01468A` | 83531-83615 | 4 strings | soul lines Light, Shield, Detection, Reality (rows already in FM-A5 D04-D07) |
| `lib_shared_014789` | 83849-83906 | 1 list + 7 strings | inline text insert list for `[02:n]` |

26 routine rows (L001-L026: 24 top-level labels, 21 of them in `lib_0133A6_part3`, plus 2 sub-label rows), 41 data rows (D01-D41), the 97-row scene profile table (section 3.3), five structure layouts (section 4) and 13 open questions. No file of this batch is touched by the line-tracking gap: all `{n}` tags agree with the sizes of `us/blocks.json` (the 21 routines of part 3 add up to its 2152 bytes).

Strings that FM-A5 owns (`asciistring_014571` status screen, `01469F`, `01470C`, `01470E`, the equipment menu frames) and `asciistring_01445D` (A6, name entry) lie between A7 strings in the address space and are not repeated here.

Context read for the callee and caller models: `engine_000000` (boot 110-136, `code_00144F` lair spawn), `lib_027781_part2/part3` (scene change `code_027781`, scene init `code_0279B5`), `lib_01318C` and `lib_shared_0131B7` (screen blank, vblank wait), `lib_shared_0131D1` (8x8 multiply), `lib_02719F` (three decompressor calls), `common_shared_0FEEA6` (SPC upload), `lib_0273A2` (bit test), `lib_027462_part1` (`code_0272B8` tile index), `lib_shared_01112A` (`code_0111CB` rectangle copy), `lib_027912` (lair init), `lib_027572` (pause), `lib_shared_012769` (text renderer), `engine_006B7F` (title and slot menu), `common_actor_0066FC`, `common_actor_0066C6`, `common_actor_00729D`, `common_actor_001A28_part4` (level up), `w0_actor_01B33A` (THE END), `system/asset_list_028000`, `system/data_00F99A`, `system/data_00BA0D`, `us/structs.json`, `us/mnemonics.json`, `us/blocks.json`, `docs/walkthrough/`, `plans/doc-audit/walkthrough-crosswalk.md` and FM-A1 to FM-A6.

## 0. Reading the tables

| Column | Meaning |
|--------|---------|
| Off / size | decimal file offset and size in bytes (distance to the next label; sub-label rows split the size of the label they sit in) |
| Callers | reference count and files, from `rg` over `extracted/` |
| Name (conf, evidence) | proposed `VerbNoun` name for code, noun for data. Confidence: **A** behaviour fully read and independently corroborated (consumer, doc, walkthrough, hardware); **B** behaviour fully read, purpose inferred from code only; **C** guessed or dead code. Evidence labels: `code`, `callee`, `caller`, `cons`, `walk`, `doc`, `hw`, `dead` |
| In / Out | registers, DP and WRAM inputs and results. M/X widths are those at entry unless stated. D is 0 |
| Clobbers | registers and scratch that are not restored |
| Data touched | WRAM names from `us/mnemonics.json` where one exists, otherwise the raw address (proposals in section 5). `r` read, `w` write |

DP scratch is written `dp$nn`. The text control codes are the ones of FM-A5 1.10 and FM-A6 1.3 (`[CUR:o]` BG3 byte offset, row `o / $40`, column `(o mod $40) / 2`; `[N]` newline; `[14:n]` n blanks, hex; `[09]` two-row glyphs; `[02:n]` entry n of the insert list D04; `[03:v]` attribute; `[06:n,a]` BCD digits; `[07:w,h]` window; `[08:o]` erase window; `[TBL:list,a]` string number from the word at `a`).

## 1. Models that several rows share

### 1.1 Where the code runs

Boot (`engine_000000` lines 123-126): `code_0139AC` (L025) resets every PPU and CPU I/O register and clears WRAM, then `code_013ADA` (L026) writes the default layout. Scene change (`lib_027781_part2.code_027781`, lines 139-160): `code_01318C` (not in any batch: wait for vblank, `NMITIMEN = 1`, `INIDISP = $80`, `$03D2 = 0`) puts the PPU in **force blank with NMI off**, then `scene_next`/`area_next` become `scene_current`/`area_current` and `code_0279B5` runs. `code_0279B5` (`lib_027781_part3`, lines 42-123) clears the per-scene state (including `$0439` and, at its end, `$031E` and `$03B4`), calls the loader `code_0133A6` (L008, line 82) and, when it returns, L001 (line 104) and L002 (line 108). So every VRAM, CGRAM-buffer and map write of A7 happens with the screen blanked; the loader writes VRAM through `VMADD`/`VMDATA` directly and never checks the blanking.

### 1.2 The asset list (`asset_list_028000`, `$05:8000`, 4098 bytes, 98 records)

One record per scene: `area`, `scene`, then commands, then a `00` byte. `code_0133FF` (L009) walks the records from the top and stops at the first whose `scene` equals `scene_current` (`$0316`) and `area` equals `area_current` (`$0314`). The list has no end sentinel; the first record is a dummy `(area $53, scene $59)` with no commands (OQ-I011-3). The 97 other records are exactly the 97 scenes (every profile id `00`-`7D` that has a record appears once: see 1.7).

A command byte has exactly one set bit; the handlers are tried from `$80` down to `$01` (`code_0133A6`, the `BIT` ladder):

| Cmd | Name | Bytes | Operands | Handler | Skipped when `$03B4` bit |
|-----|------|-------|----------|---------|--------------------------|
| `$80` | graphics | 7 | b0 start, b1 end (both in 512-byte units, `b0` bit 7 = raw), b2 VRAM destination (word address `b2 << 8`), pointer | L010 | 3 |
| `$40` | palette | 7 | b0 first source colour, b1 end colour (exclusive), b2 first destination colour, pointer | L011 | 2 |
| `$20` | tileset | 8 | b0 start (64-byte units, bit 7 raw), b1 end, b2 destination offset, b3 layer mask (1 BG1, 2 BG2, 3 both), pointer | L012 | 1 |
| `$10` | tilemap | 5 | type (1 BG1, 2 BG2, 0 Mode 7), pointer | L014 | 0 |
| `$08` | asset8 | 2 | id: `< $80` scene profile, `$80-$BF` jump to label `id or $40`, `$C0-$FF` label | L018 | never |
| `$04` | meta4 | 4 | three ignored bytes | L019 | never (no record uses it) |
| `$02` | music | 6 | b0 to `$031A`, b1 to `$031C` (variant), pointer | L020 | 5 |
| `$01` | spritemap | 7 | b0 (0: `$7E:3800`, else `$7E:F000`), b1, b2 ignored, pointer | L021 | 4 |

Counts over the list: graphics 107 (`b2` `$00` 30, `$10` 27, `$20` 1, `$30` 45, `$40` 3, `$FF` 1; 9 raw), palette 109, tileset 62 (every one `00,20,00`: all 64-byte units, 2048 bytes, offset 0), tilemap 135, asset8 200 (97 profile ids, 65 jumps, 38 labels `$C1`-`$E6`), music 65 (b0 always 1, variants 0 to 4: 32, 19, 12, 1, 1), spritemap 47 (46 with b0 = 0), meta4 0. The 65 jumps go to 37 distinct labels. Shared segments (a label, its commands and the closing `00`) are how scenes of one world share graphics: after the jump the walk continues after the label in the *other* record and ends at that record's `00` (L023 leaves Y behind the label).

Pairings visible in the data (not enforced by code): `graphics` b2 `$30` (45 uses) comes with `palette` destination `$80` (45 uses, 48 colours) and a `spritemap`: sprite sets; `palette` `00,70,10` (56 uses, 112 colours at colour 16) are the background palettes; `graphics` b2 `$40` (3 uses, 12 KB) goes to the BG3 text character base (`BG34NBA = 4`, word `$4000`, set by L026 and by the profile).

### 1.3 Stream pointers (L017) and the pointer cache (L024)

Every asset has a 3-byte **linear file offset** in the record (stored `lo, mid, hi`). `code_013731` reads it from the list into `dp$29-$2B` and converts it to a LoROM address: `mid' = (mid and $7F) or $80`, `bank = (hi << 1) or (mid >> 7)`; that is `bank = offset >> 15`, `address = $8000 + (offset and $7FFF)`. The routine takes the position of the 3 bytes in X, but all six callers pass `$0029`.

Ten 3-byte caches at `$0407`-`$0424` hold the converted pointer of the last asset loaded into a slot: graphics by VRAM page (`$0407` page `$0000`, `$040A` `$1000`, `$040D` `$2000`, `$0410` `$3000`), tileset per layer (`$0413` BG1, `$0416` BG2), tilemap per layer (`$0419`, `$041C`), spritemap `$041F`, music `$0422`. `code_013983` (L024) compares `dp$29-$2B` with the slot, stores it when different and returns carry set (= load). An equal pointer skips the whole load, so entering a scene that uses the same assets in the same slots costs nothing. Palettes have no cache. A graphics `b2` that is not `$00/$10/$20/$30` (`$40`, `$FF`) clears the four graphics caches and always loads; a tileset or tilemap type that is not 1 or 2 clears both caches of its kind. The caches key on the pointer only, not on the range (`b0`, `b1`); no two graphics or tileset commands of the list share a pointer with different ranges (static check, 107 and 62 commands), so the hazard does not occur.

`$03B4` is the **skip mask** (see the table above): an actor that warps inside a world writes `$0020` (skip the music reload) before the scene change; 15 sites in 13 files do (`lib_0109D6`, `common_actor_00729D_part2`, `w0_actor_01B33A`, five St. Elles actors, and one or two actors each in Mountain of Souls, Leo's Lab, Magridd's Castle, Greenwood and the World of Evil). `code_0279B5` clears it after the load (line 123).

### 1.4 Quintet LZ (L005-L007)

`code_013272` is the Quintet LZ expander of `corpus/gaia-core/quintet-lz.md` (256-byte ring filled with `$20`, first write index `$EF`, bit 1 = literal byte, bit 0 = back reference of an 8-bit ring index plus a 4-bit length, `count = length + 2`). It does **not** read the 2-byte length that precedes every stream: the callers do. It takes the source in `dp$29-$2B`, the output count in `dp$23` and the destination in `dp$25` (bank `$7E`), uses the page `$7E:0100-$01FF` as the ring (`DBR` is set to `$7E` for the call), reads bits MSB first with the one-hot mask `dp$1E`, and preserves P, B, X and Y. `code_0132E2` (L006) reads one byte at any bit phase; `code_01333F` (L007) reads the 4-bit length. The loader always decompresses to `$7E:6000` (graphics, tileset, tilemap staging, 8 KB max) or `$7E:C000` (Mode 7 map), `$7E:3800`/`$7E:F000` (spritemap) and the layer map pages.

### 1.5 What each command does

- **graphics** (L010): VRAM word address `b2 << 8`. Not raw: the stream's length word goes to `dp$23`, the data is expanded to `$7E:6000` and words `[b0*$200, b1*$200)` are written to `VMDATAL`. Raw (`b0` bit 7): words are copied straight from the ROM pointer at the same offsets (9 uses). `b2 = $FF` (the single Mode 7 use, scene `00/0A`, location `$10`, `BGMODE = $0F`; OQ-I011-4): `VMADD = 0` and only `VMDATAH` is written, `$4000` bytes (the Mode 7 character data lives in the high bytes).
- **palette** (L011): colours `[b0, b1)` of the source are copied to the CGRAM buffer (`cgram_buffer`, `$7F:0000`) at colour `b2`. No decompression, no cache. The buffer reaches CGRAM through the NMI.
- **tileset** (L012, L013): the metatile definition tables. The compressed stream is expanded to `$7E:6000`; bytes `[b0*64, b1*64)` are copied word by word, **byte-swapped**, into `$7E:2000` (BG1, layer bit 0) and `$7E:2800` (BG2, bit 1) at offset `b2*64`. Eight bytes per metatile (FM-A4 L029: `X = id * 8`), 256 ids, `$800` bytes per layer.
- **tilemap** (L014, L015, L016): the stream header is `width` and `height` (bytes, in 256-pixel pages). `map_width_px` (`$0342`, with `map_width_pages` at `$0343`) is set to `width << 8` and `map_height_px` (`$0344`, pages at `$0345`) to `height << 8` for BG1 (type 1) and `$0346`/`$0348` for BG2 (type 2). The product `width * height` goes through the hardware multiplier (`code_0131D1`); the expected output length in bytes is `pages << 8` (one byte per 16x16 metatile, 256 per page), replaced by the length word of the stream when the height byte has bit 7 clear. The expanded map goes to the layer buffer whose base is in `$0352` (BG1) or `$0356` (BG2) (the loader copies them to `dp$25`; the pages are read at `$7E:8000` and `$7E:C000` by L001, A4 and A3). Type 0 (Mode 7, one use): `$4000` bytes to `$7E:C000`, then to VRAM word 0 with `VMAIN = 0` (low byte only), then `VMAIN` is restored to `$80`.
- **asset8** (L018, L023): see 1.7.
- **music** (L020): `dp$29-$2B` is the SPC block. The record is used only when its variant `b1` equals the scene variant `$031E` (1.8); then, unless the pointer equals the cached one: `APUIO0 = $F0`, wait until the SPC answers 0, 2 frames, `APUIO0 = $FF`, 2 frames, `code_0FEFF5` (the IPL upload of `common_shared_0FEEA6`), 3 frames, `APUIO0 = $031A` (the start command; b0 is always 1).
- **spritemap** (L021): expanded to `$7E:3800` (b0 = 0) or `$7E:F000`; meta entries use `$7E3800` as their sprite map base (`meta_tables_008000` lines 484-489).

### 1.6 Raw flags and `$2E`

Raw copies and the tileset copy loop write through `[dp$2C], Y`; the bank byte `dp$2E` is never set by A7. Its only writer is the SPC upload (`common_shared_0FEEA6`: `$07` at the start, incremented per bank, `$7E` at the end, lines 216-327). So every tileset load (L013 uses `[dp$2C]` even for expanded data) writes to the bank left by the last music upload: `$7E` after any upload. OQ-I011-1 asks whether the first scene after boot sees `$7E`. The tilemap and tileset raw paths (height byte bit 7, tileset `b0` bit 7) look unused: no tileset has `b0` bit 7 (62 of 62 are `00`); the tilemap flag cannot be checked in the extracted `.map` files (the extraction decompresses them); when the flag is set `map_height_px` receives the flag as bit 15 and the page product is wrong (OQ-I011-2).

### 1.7 The scene profile (L018, `binary_list_0168A1`)

`asset8` with an id below `$80` selects a **scene profile** (the list `binary_list_0168A1` holds 128 words, one per id; ids 25-27, 35-3B, 48-4F, 5D-63, 74-77, 7E-7F are `0000`). The id is also the **location id** (`location_id`, `$1C6A`): `code_013759` stores it first. The list holds absolute bank-`$02` addresses; the code subtracts the list base and indexes from the list label with long addressing. Each record is 12 bytes (section 4.2). Effects, in the order of the code:

1. `TM`, `TMW` and `$03C0` = byte 0; `TS`, `TSW` = byte 1; `CGWSEL` = byte 2; `CGADSUB` and `$03C1` = byte 3.
2. Byte 4: `$0373 = byte4 and $30`; `$036B = $036F = 0`; bit 0 sets `$036A = $2000`, bit 1 sets `$036E = $2000`; bit 6 chooses `$03CA` = `$0100` (set) or `$00E0` (clear); bit 7 clear ORs 1 into `$036F`; bits 2 and 3 are never read (OQ-I011-7); `$035C = $0360 = $FDFF`.
3. Byte 5: bit 7 = layer swap (`$03DB = 1`). `BG1SC = ($70 if swap else $60) + (byte5 and 3)` and `BG2SC = ($60 if swap else $70) + ((byte5 >> 2) and 3)`, also stored in `$03C2`. The low two bits are the BGnSC screen-size bits (0 32x32 ... 3 64x64); the map base is word `$6000` for the first layer and `$7000` for the second, whatever the swap.
4. Byte 6: `BGMODE` (`$09` Mode 1 with BG3 priority; `$0F` Mode 7 for location `$10`).
5. Bytes 7-10: eight nibbles; for byte k (0-3) the low nibble goes to `$034B + 2k` and the high nibble to `$034A + 2k` (the parallax ratios of FM-A4).
6. Byte 11: low nibble = world index `$03BA`; bit 5 (`INC $0439`) = no-combat flag; bits 7 and 6 each add 1 to `$031E` (1.8).

The profile ids are used once each: 97 distinct ids, one per asset record, and `location_id` addresses the 128-entry name list `asciistring_list_0147C2`.

### 1.8 Scene variant `$031E` (L003, L020, L018)

`$031E` selects which `music` record of a scene plays (`code_01389E` compares `$031E` with the record's b1; no other reader exists). `code_0279B5` clears it after the load (line 122), so it is a one-shot request for the next load, which the profile command (always the first command of a record) turns into the final value before the music command runs:

- if non-zero already (an actor set it before the scene change: `engine_005354` and `common_actor_0066FC` write 1, `w0_actor_01A440` writes 3), nothing is looked up and the profile's no-combat bit alone is applied (`AND #$3F`, bits 7 and 6 ignored);
- else `code_011662` (L003) scans `data_00F99A` (4-byte rows `location, switch id (word), variant`, structure `unk10`): the first row of this location whose switch bit in the array `$1ADE` is set writes its variant into `$031E`, returns carry set, and the profile's variant bits are ignored too;
- else (carry clear) the profile bits add: bit 7 adds 1, bit 6 adds 1.

The data fit one story. Profile byte 11 `$C0` (variant +2) occurs exactly in six rooms (locations `$0C`, `$22`, `$32`, `$44`, `$59`, `$72`: Monster in the paintings, Tomb of a stone statue, A ghost ship, Poseidon, Tin Doll, The deck of an airship) and `data_00F99A` has a variant-0 row for the same six locations with the switch ids `$009`, `$050`, `$0B6`, `$103`, `$12F`, `$195`; the other rows of those worlds (towns and shrine rooms) get variant 2 under the same switch. Profile byte 11 `$A0` (variant +1, no combat) occurs exactly in the 12 dream rooms. So the likely meaning: boss music (variant 2) until the boss switch is set, then normal music (variant 0), and a different tune (variant 2) in the rest of the world after the boss. Unverified: OQ-I011-5, OQ-I011-6.

### 1.9 After the loader: lair states and flag patches (L001, L002)

`code_01157E` visits the 420 `data_00BA0D` records (32 bytes, FM-A4 4.6, terminator `$FF`); for each record with `+B = location_id` it counts a lair in `$0456` and looks at the state byte `lair_state[i]` (`$7F0203 + i`, `i` = running index): positive spawns the lair monsters (`code_00144F`, FM-A1 R52), zero means every monster is dead and the tile at (`+C`, `+D`) tiles becomes `$FE` (the release switch), negative means the lair was released and the tile becomes `$FF` and the lair no longer counts. The tile goes into BG1 page `$7E8000` and, when `+8` is non-zero, into BG2 page `$7EC000`. The counter `$0456` is what the pause banner shows (1.10).

`code_0115F1` (L002) walks `unk13_01728D` (9-byte rows, terminator `$FF`): rows of this location whose event flag (`event_flags`, `$1A5E`, bit number = the row's word) is set copy a map rectangle from a staging place of the same map (`code_0111CB`, FM-A4 L032) into the live place: the permanent map changes of the game (opened doors and passages).

### 1.10 Strings

- **Pause banner** (`lib_027572`, called each frame by the main loop): `Start` (`$0323 and $10`) latches `$03A2`, sends `APUIO0 = $F2` (pause music), and unless **A** is held prints `asciistring_014536` (window 24x2 at `$186`, then the name: `[TBL:list_0147C2,1C6A]` takes string number = the word at `$1C6A`; `$1C6B` is never written, so the index is `location_id`; OQ-I011-11). When `$0439` is 0 it converts `$0456` to BCD at `$1B80` (`code_013215`) and prints `asciistring_014547` ("Monster Lair" / "Remaining" and two digits, window 12x4 at `$51E`). It waits for Start to be released and pressed again, erases both windows (`asciistring_01456A`), sends `APUIO0 = 1` and returns.
- **Intro** (`common_actor_0066FC`, meta entry `$56`): copyright (`013B36`) and "PUSH START" (`013B27`) on the title, then 14 story pages (`013B85`-`0140FA`, printed in address order at lines 118-287); after the last page `COP [10] (#$0A00 ...)` warps to scene `$0A` of area 0, the Mode 7 scene (location `$10`). **Ending** (`common_actor_00729D`, meta entry `$57`): 7 pages (`014192`-`014339`, lines 68-175, with a scene change between the fourth and fifth) and then "THE END" from `w0_actor_01B33A` (line 205). The intro font prints the period glyph as `-` and the closing quote as `ˮ`; the ending font prints the period as `:` and the comma as `¥` (the extract shows the glyph names).
- **Save slots** (`engine_006B7F` `code_006D4E`): `asciistring_0143B0` draws the window and four rows; the slot lines come from the 80-byte table `binary_01440D`, which is four 20-byte **strings** (`[CUR:o][02:3][CUR:o][06:2,0450][CUR:o][06:1,0452]` and a terminator), stepped by `$14`.
- **Insert list** (`binary_list_014789`, read by both renderers on `[02:n]`): entries 2 and 3 are RAM addresses of strings (`$1B92` the player name, `$0447` the slot name); the other seven are tile strings (`binary_01479B` ... `binary_0147BD`: `0A-0F`, `10-15`, `0C-0F`, `1C-1F`, `2C-2F`, `3C-3F`, `4C-4F`, each ending in 0) drawn by `asciistring_014176`.

### 1.11 Boot hardware reset (L025, L026)

`code_0139AC`: `INIDISP = $80`; `OBJSEL`, `OAMADD`, `BGMODE`, `MOSAIC`, the BGnSC, BGnNBA and the eight scroll registers (written twice each) are zeroed; `VMAIN = $80`, `VMADD = 0`; `M7SEL = $80`, the Mode 7 matrix is the identity (`M7A = M7D = $0100`, `M7B = M7C = 0`), `M7X = M7Y = 0`; window registers, `TM`, `TS`, `TMW`, `TSW` zeroed; `CGWSEL = $02`, `CGADSUB = 0`, `COLDATA = $E0`, `SETINI = 0`; `NMITIMEN = 0`, `WRIO = $FF`, multiplier, divider, timers, `MDMAEN`, `HDMAEN`, `MEMSEL` zeroed; WRAM `$7E:0000-$1EFF` and `$7E:2000-$FFFF` and the whole bank `$7F` are cleared (`$7E:1F00-$1FFF`, the stack page, is kept); `dp$2F-$31` = the asset list pointer. `code_013ADA`: `OBJSEL = $01`, `BGMODE = $09`, `BG1SC = $63`, `BG2SC = $73`, `BG3SC = $58`, `BG12NBA = 0`, `BG34NBA = 4`, `W12SEL = W34SEL = WOBJSEL = $33`, window 1 spanning `$00-$FF`, `CGWSEL = $82`, `TM = $07`. The BG1/BG2 values equal the profile record `$0F` byte of the most common scene setup.

## 2. Code rows

| ID | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|----|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L001 | `code_01157E` | 71038 / 115 | 1 site / 1 file (`lib_027781_part3` `code_0279B5`) | scene load | `ApplyLairStatesToScene` (A; code, callee A1 R52, cons A4 L025) | `JSL` after the loader; X, Y 16-bit; `location_id` set | per record of this location: monsters spawned, or tile `$FE` / `$FF` written to the BG1 page (and the BG2 page when `+8` is non-zero); `$0456` = lairs not yet released | A, X, Y, dp`$16`, dp`$18` (and what `code_0272B8` and `code_00144F` touch); M = 8 on return | r `data_00BA0D`, `location_id`, `lair_state`; w `$0456`, `$7E8000`, `$7EC000` |
| L002 | `code_0115F1` (sub-label of L001) | 71153 / 113 | 1 site / 1 file (`lib_027781_part3` `code_0279B5`) | scene load | `ApplyFlagMapPatches` (A; code, callee A4 L032) | `JSL`; M = 8, X 16-bit | for every `unk13` row of this location with its event flag set: `$1C71-$1C74` = rectangle (x, y, w, h), dp`$16`/`$18` = staging position in pixels, `code_0111CB` copies the BG1 ids and type bytes | A, Y (`LDY #$1A5E`), dp`$16`, `$18`, `$0E`, `$10` (callee); X restored per row | r `unk13_01728D`, `event_flags`, `location_id`; w `$1C71-$1C74`, map pages |
| L003 | `code_011662` (sub-label of L001) | 71266 / 51 | 1 site / 1 file (L018) | scene load | `LookupSceneVariant` (B; code, cons music variant) | `JSL`; M = 8, X 16-bit | carry set and `$031E` = the row's variant when a row of `data_00F99A` for this location has its switch set in `$1ADE`; carry clear otherwise | A; X, Y preserved | r `data_00F99A`, `location_id`, `$1ADE` (via `code_0273A2`); w `$031E` |
| L004 | `code_0131C9` | 78281 / 8 | 3 sites + 1 loop / 1 file (L020) | wait | `WaitVblankFrames` (A; code, callee `code_0131B7`) | `JSL`; M = 8, A = frames (0 means 256) | returns after A vblanks; A = 0 | A | none |
| L005 | `code_013272` | 78450 / 112 | 8 sites / 2 files (`lib_0133A6_part3` x 5: L010, L012, L015, L016, L021; `lib_02719F` x 3) | decompression | `DecompressQuintetLz` (A; code, doc `quintet-lz.md`) | `JSL`; dp`$29-$2B` source (after the 2-byte length), dp`$23` output count, dp`$25` WRAM destination (bank `$7E`) | the expanded bytes at `$7E:[dp$25]`; dp`$29` advanced past the consumed bytes; ring page `$7E:0100-$01FF` overwritten | A, dp`$1E-$22`; P, B, X, Y preserved | dp`$1E-$26`, `$29-$2B`; `$7E:0100-$01FF` |
| L006 | `code_0132E2` | 78562 / 93 | 2 sites / 1 file (L005) | decompression | `ReadLzByte` (A; code, doc) | `JSR`; dp`$1E` bit mask, dp`$29` | A.low = the next 8 bits (any bit phase), dp`$29` += 1; M = 8 on return | A (B scrambled by `XBA`) | dp`$1E`, `$29-$2B` |
| L007 | `code_01333F` | 78655 / 103 | 1 site / 1 file (L005) | decompression | `ReadLzNibble` (A; code, doc) | `JSR`; M = 8 | A = the next 4 bits (0-15); the mask `dp$1E` moves by 4 bits, dp`$29` += 1 when a byte boundary is crossed | A (B) | dp`$1E`, `$29-$2B` |
| L008 | `code_0133A6` | 78758 / 89 | 1 site / 1 file (`lib_027781_part3` `code_0279B5`) | scene load | `LoadSceneAssets` (A; code, caller, cons) | `JSL`; `area_current`, `scene_current`, dp`$2F-$31` = asset list; screen force-blanked, NMI off | runs L009 then the command ladder until a `00` byte: VRAM graphics and Mode 7 data, `cgram_buffer`, tile definitions `$7E:2000/2800`, map pages and sizes, scene profile (L018), SPC music, sprite map | A, X, Y and all the DP scratch of section 5; P restored | see 1.2-1.7 |
| L009 | `code_0133FF` | 78847 / 64 | 1 site / 1 file (L008) | scene load | `FindSceneRecord` (A; code) | `JSR`; M = 8, X 16-bit | Y = offset of the first command of the record `(area_current, scene_current)`; commands of other records are skipped by the length ladder (6, 6, 7, 4, 1, 3, 5, 6 operand bytes for `$80` .. `$01`) | A, Y | dp`$2F-$31` |
| L010 | `code_01343F` | 78911 / 243 | 1 site / 1 file (L008) | scene load | `LoadSceneGraphics` (A; code, hw) | `JSR`; Y at the first operand | graphics into VRAM (1.5); the cache slot of the VRAM page updated; Y past the 6 operand bytes | A, X, dp`$00`, `$02`, `$23`, `$25`, `$29-$2B` | w `VMADD`, `VMDATAL`, `VMDATAH`, `$0407-$0410`; r `$03B4` |
| L011 | `code_013532` | 79154 / 63 | 1 site / 1 file (L008) | scene load | `LoadScenePalette` (A; code) | `JSR`; Y at the first operand | colours `[b0, b1)` copied to `cgram_buffer + b2 * 2`; Y past the 6 bytes | A, X, dp`$00-$04`, `$29-$2B` | w `cgram_buffer`; r `$03B4` |
| L012 | `code_013571` | 79217 / 157 | 1 site / 1 file (L008) | scene load | `LoadMetatileDefs` (A; code, cons A4 L029) | `JSR`; Y at the first operand | one or both definition tables (`$7E:2000`, `$7E:2800`) filled; Y past the 7 bytes | A, X, dp`$00-$06`, `$23`, `$25`, `$2C`, `$29-$2B` | w `$7E:2000-$2FFF`, `$0413`, `$0416`; r `$03B4` |
| L013 | `code_01360E` | 79374 / 29 | 2 sites / 1 file (L012) | scene load | `CopyDefsToLayer` (A; code) | `JSR`; A = layer mask, X = `$2000` or `$2800` | when the lowest bit of A is set copies the byte-swapped words `[dp$00, dp$02)` from `$7E:6000` to `[dp$2C]` at offset dp`$04`; A shifted right on return | A, X (the caller reloads it), Y preserved | dp`$00-$04`, `$2C-$2E` |
| L014 | `code_01362B` | 79403 / 142 | 1 site / 1 file (L008) | scene load | `LoadSceneTilemap` (A; code, cons) | `JSR`; Y at the first operand | stream header decoded, product `width * height` through L (`code_0131D1`), the map loaded by L015 (types 1, 2) or L016 (type 0); Y past the 4 bytes | A, X, dp`$00-$04`, `$23`, `$25`, `$29-$2B` | w `map_width_px`, `map_height_px`, map pages, `$0419`, `$041C`; r `$03B4` |
| L015 | `code_0136B9` | 79545 / 49 | 2 sites / 1 file (L014) | scene load | `LoadMapLayer` (A; code) | `JSR`; A = type shifted so that bit 0 is this layer, X = 0 (BG1) or 4 (BG2) | when bit 0 is set: sizes stored at `map_width_px + X`, `map_height_px + X`, the map copied (raw) or expanded to `[$0352 + X]`; carry set; otherwise carry clear and A shifted | A, Y preserved | `$0342-$0348`, `$0352`, `$0356` |
| L016 | `code_0136EA` | 79594 / 71 | 1 site / 1 file (L014) | scene load | `LoadMode7Map` (A; code, hw) | `JSR`; M = 16 | `$4000` bytes expanded (or copied) to `$7E:C000`, then written to VRAM word 0 with `VMAIN = 0` (low byte), `VMAIN` back to `$80` | A, X | w `VMAIN`, `VMADD`, `VMDATAL` |
| L017 | `code_013731` | 79665 / 40 | 6 sites / 1 file (L010, L011, L012, L014, L020, L021) | scene load | `ReadAssetPointer` (A; code, hw) | `JSR`; Y at the 3 pointer bytes of the list, X = `$0029` | `dp$29-$2B` = LoROM address of the linear file offset in the record; Y += 3 | A | dp`$29-$2B` |
| L018 | `code_013759` | 79705 / 315 | 1 site / 1 file (L008) | scene load | `ApplySceneProfile` (A; code, cons) | `JSR`; Y at the operand | id `< $80`: profile applied (1.7), `location_id` = id, L003 may set the variant; `$80-$BF`: L023 jump; `$C0+`: label, nothing. 16 inner labels (section 6) | A, X, Y restored on the profile path | w `TM`, `TMW`, `TS`, `TSW`, `CGWSEL`, `CGADSUB`, `BG1SC`, `BG2SC`, `BGMODE`, `location_id`, `$03C0-$03C2`, `$034A-$0351`, `$035C`, `$0360`, `$036A-$036F`, `$0373`, `$03CA`, `$03DB`, `$031E`, `$0439`, `$03BA` |
| L019 | `code_013894` | 80020 / 10 | 1 site / 1 file (L008) | scene load | `SkipMeta4Command` (C; code, dead: 0 uses in the list) | `JSR`; Y at the operand | Y += 3 | A | none |
| L020 | `code_01389E` | 80030 / 93 | 1 site / 1 file (L008) | scene load | `LoadSceneMusic` (A; code, hw, doc `spc-transfer.md`) | `JSR`; Y at the operand | `$031A`, `$031C` set; when the variant matches and the pointer is new: the SPC handshake and upload (1.5), then the start command | A, X, dp`$29-$2B` | w `APUIO0`, `$031A`, `$031C`, `$0422`; r `$031E`, `$03B4` |
| L021 | `code_0138FB` | 80123 / 68 | 1 site / 1 file (L008) | scene load | `LoadSceneSpritemap` (A; code, cons meta entries) | `JSR`; Y at the operand | stream expanded to `$7E:3800` (b0 = 0) or `$7E:F000` unless the pointer equals the cache; Y past the 6 bytes | A, X, dp`$23`, `$25`, `$29-$2B` | w `$7E:3800`, `$7E:F000`, `$041F`; r `$03B4` |
| L022 | `code_01393F` | 80191 / 11 | 22 sites / 1 file (L008-L012, L014, L018-L021) | scene load | `ReadAssetByte` (A; code) | `JSR`; Y = position in the list | A (16-bit) = the next byte (high byte 0); Y += 1; P restored | A | none |
| L023 | `code_01394A` | 80202 / 57 | 1 site / 1 file (L018) | scene load | `FindAssetLabel` (A; code) | `JSR`; A = label value (`$C0-$FF`), M = 8 | scans the list from the first record; Y = position behind the first `asset8` whose operand equals the label | A, Y | `dp$00` |
| L024 | `code_013983` | 80259 / 41 | 10 sites / 1 file (L010 x 4, L012 x 2, L014 x 2, L020, L021) | scene load | `CheckAssetCache` (A; code) | `JSR`; X = cache slot, `dp$29-$2B` = pointer | carry clear: equal, nothing to do; carry set: the slot now holds the pointer, load the asset | A | `$0407-$0424` |
| L025 | `code_0139AC` | 80300 / 302 | 1 site / 1 file (`engine_000000` boot) | boot | `InitHardwareAndClearWram` (A; code, hw) | `JSL` from reset | see 1.11 | A, X; P restored | all PPU, DMA, math registers; WRAM; dp`$2F-$31` |
| L026 | `code_013ADA` | 80602 / 77 | 1 site / 1 file (`engine_000000` boot) | boot | `ApplyBootPpuLayout` (B; code, hw) | `JSL`; M = 8 | PPU layout registers set (1.11) | A | `OBJSEL`, `BGMODE`, `BG1SC`-`BG3SC`, `BG12NBA`, `BG34NBA`, `W12SEL`-`WOBJSEL`, `WH0`-`WH3`, `CGWSEL`, `TM` |

Two dead branches share the offset byte `$74`: `code_0133FF` ends its ladder with `BRA loc_0134AA` (78900) and `code_01394A` with `BRA loc_0139E6` (80240). Both follow eight `ASL` of a non-zero byte, so they are unreachable (OQ-I011-10), but they pin the layout: `loc_0134AA` is the `PLA; PLP; RTS` tail of L010 and `loc_0139E6` is a `STZ BG2HOFS` inside L025. A rebuild that keeps the bytes needs those blocks at these relative distances (section 7).

## 3. Data rows

### 3.1 Lists, tables and binaries

| ID | Label | Off / size | Callers | Name (conf, evidence) | Content |
|----|-------|-----------|---------|-----------------------|---------|
| D01 | `binary_list_0168A1` | 92321 / 256 | 1 (L018) | `SceneProfileList` (A; code, cons) | 128 words, one per location id: bank-`$02` addresses of the records, `0000` for the 31 unused ids |
| D02 | `binary_0169A1` ... `binary_016E21` (97 parts) | 92577-93741 / 12 each | 1 each (D01) | `SceneProfile<id>` (A; code, cons) | the 97 profile records (3.3) |
| D03 | `unk13_01728D` | 94861 / 631 | 1 (L002) | `FlagMapPatchTable` (A; code, cons) | 70 rows of 9 bytes + the `$FF` terminator (4.3) |
| D04 | `binary_list_014789` | 83849 / 57 | 2 (`lib_shared_012769`: menu and dialogue renderers) | `TextInsertList` (A; code, cons) | 9 words (18 bytes) then seven 0-terminated tile strings: entries 0 `binary_01479B` (6 tiles `0A`-`0F`), 1 `binary_0147A2` (`10`-`15`), 2 `$1B92`, 3 `$0447`, 4-8 `binary_0147A9` .. `binary_0147BD` (`0C-0F`, `1C-1F`, `2C-2F`, `3C-3F`, `4C-4F`) |
| D05 | `binary_01440D` | 82957 / 80 | 1 (`engine_006B7F` `code_006D4E`, line 252) | `SaveSlotLineTemplates` (A; code, cons) | four 20-byte strings (4.5); typed `Binary`, it is text |
| D06 | `asciistring_list_0147C2` | 83906 / 1856 | 1 (`asciistring_014536` `[TBL]`) | `LocationNameList` (A; code, cons) | 128 words (256 bytes) then the 128 name strings (1600 bytes), section 3.3 |

### 3.2 Strings

Every string is `ASCIIString`, printed by `lib_shared_012769.code_012769` (`LDY #$&label; JSL`). Sizes are label distances (dictionary bytes are expanded in the extract, so the byte size is smaller than the text for some).

| ID | Label | Off / size | Consumer (file, line) | Name (conf, evidence) | Text and layout |
|----|-------|-----------|-----------------------|-----------------------|-----------------|
| D07 | `asciistring_013B27` | 80679 / 15 | `common_actor_0066FC` 101 | `TitlePushStartText` (A; code, cons) | `[09][CUR:4D6]PUSH START` |
| D08 | `asciistring_013B36` | 80694 / 79 | `common_actor_0066FC` 88 | `TitleCopyrightText` (A; code, cons) | `[09][CUR:5C0]` "ALL RIGHTS RESERVED", "COPYRIGHT 1992 QUINTET/ENIX", "LICENSED BY NINTENDO" (`[14:6]`, `[14:9]` centring) |
| D09 | `asciistring_013B85` | 80773 / 92 | `common_actor_0066FC` 118 | `IntroPage01Text` (A; code, cons) | `[CUR:280]` "Wise men tell a tale late at night of a great King destroyed by the temptation of evil" |
| D10 | `asciistring_013BE1` | 80865 / 92 | line 131 | `IntroPage02Text` (A) | "The Freil Empire, as it was called in those days, was ruled by a powerful man, King Magridd" |
| D11 | `asciistring_013C3D` | 80957 / 121 | line 144 | `IntroPage03Text` (A) | "It seems most people thought the King was a fair and kind ruler. There were some, however, who felt the King himself was ruled by greed" |
| D12 | `asciistring_013CB6` | 81078 / 151 | line 157 | `IntroPage04Text` (A) | "One day the King happened to overhear two guards talking about a man named Dr. Leo. Now Dr. Leo was considered by all to be a great inventor and a genius" |
| D13 | `asciistring_013D4D` | 81229 / 109 | line 170 | `IntroPage05Text` (A) | "The King stayed up many nights wondering how he could use this great inventor to make him even more wealthy" |
| D14 | `asciistring_013DBA` | 81338 / 112 | line 183 | `IntroPage06Text` (A) | "All of the sudden the King had an idea. He ordered his guards to capture Dr. Leo and bring him to the castle at once!" |
| D15 | `asciistring_013E2A` | 81450 / 39 | line 196 | `IntroPage07Text` (A) | "Soon Dr. Leo was brought to the castle" |
| D16 | `asciistring_013E51` | 81489 / 110 | line 209 | `IntroPage08Text` (A) | "The King confined him in a small room and ordered him to invent a machine that would summon the King of evil, Deathtoll" |
| D17 | `asciistring_013EBF` | 81599 / 118 | line 222 | `IntroPage09Text` (A) | "Dr. Leo finally completed the machine. The King instantly called upon Deathtoll, hoping they might strike a deal" |
| D18 | `asciistring_013F35` | 81717 / 152 | line 235 | `IntroPage10Text` (A) | "After many days the deal was complete. The King would bring Deathtoll all living creatures, and in return, Deathtoll would give him a gold piece for each" |
| D19 | `asciistring_013FCD` | 81869 / 86 | line 248 | `IntroPage11Text` (A) | "One by one, all living creatures began to disappear. Soon the world was completely empty" |
| D20 | `asciistring_014023` | 81955 / 71 | line 261 | `IntroPage12Text` (A) | "Two people were watching this catastrophe, the Master, and you, his follower" |
| D21 | `asciistring_01406A` | 82026 / 144 | line 274 | `IntroPage13Text` (A) | the Master: "The King was very foolish to be tempted by evil, however I will give him another chance. You must go down to Earth and revive the World!" |
| D22 | `asciistring_0140FA` | 82170 / 124 | line 287 | `IntroPage14Text` (A) | "On a ray of light you descended to Earth. A warrior sent to revive the living and punish evil. A SOUL BLAZER!!" |
| D23 | `asciistring_014176` | 82294 / 28 | `common_actor_0066C6` 19 | `TileBlockText` (C; code, the picture is not identified, OQ-I011-9) | `[09][0A]` then `[02:4]` .. `[02:8]` at `[CUR:2DC]`, `31C`, `35C`, `39C`, `3DC`: a 4-wide, 5-high block of tiles at BG3 rows 11-15, columns 14-17 |
| D24 | `asciistring_014192` | 82322 / 95 | `common_actor_00729D` 68 | `EndingPage1Text` (A; code, cons) | "Grass Valley at sunset. The glistening ocean. The restored world was beautiful." |
| D25 | `asciistring_0141F1` | 82417 / 55 | line 83 | `EndingPage2Text` (A) | "All the creatures stopped and looked at the beauty of the sunset." |
| D26 | `asciistring_014228` | 82472 / 71 | line 98 | `EndingPage3Text` (A) | "One was with his child, and one was with his friend, creatures were in awe of the scenery." |
| D27 | `asciistring_01426F` | 82543 / 76 | line 113 | `EndingPage4Text` (A) | "Suddenly, a light ray shot into the sky. However, no one noticed it." |
| D28 | `asciistring_0142BB` | 82619 / 38 | line 145 | `EndingPage5Text` (A) | "Lisa was standing all by herself." |
| D29 | `asciistring_0142E1` | 82657 / 88 | line 160 | `EndingPage6Text` (A) | "She used to feel lonely when she saw the sunset, but now, she thinks it is beautiful." |
| D30 | `asciistring_014339` | 82745 / 107 | line 175 | `EndingPage7Text` (A) | "Just like her father changed impossible to possible, Lisa feels she will be happy if she believes." |
| D31 | `asciistring_0143A4` | 82852 / 12 | `w0_actor_01B33A` 205 | `TheEndText` (A; code, cons) | `[09][CUR:358]THE END` |
| D32 | `asciistring_0143B0` | 82864 / 93 | `engine_006B7F` 248 | `SaveSlotMenuText` (A; code, cons FM-A2 X107) | `[CUR:88][07:16,16]` window, `[CUR:14A]` "Please choose a record", column heads "Name", "Lev", "Area" at `$218`, `$226`, `$22E`, "No1:" .. "No4:" and "Erase record" |
| D33 | `asciistring_014516` | 83222 / 17 | `common_actor_001A28_part4` 89 | `LevelUpText` (A; code, cons) | `[09][03:24][CUR:216]LEVEL UP !` |
| D34 | `asciistring_014527` | 83239 / 15 | `common_actor_001A28_part4` 97 | `LevelUpClearText` (A; code, cons) | `[09][CUR:216]` and ten blank glyphs: overwrites D33 |
| D35 | `asciistring_014536` | 83254 / 17 | `lib_027572` 30 | `LocationBannerText` (A; code, cons) | `[CUR:216][14:A][CUR:186][07:18,2][TBL:list_0147C2,1C6A]` |
| D36 | `asciistring_014547` | 83271 / 35 | `lib_027572` 37 | `LairCounterText` (A; code, cons) | `[CUR:51E][07:C,4]` "Monster Lair", "Remaining" and `[06:2,1B80]` |
| D37 | `asciistring_01456A` | 83306 / 7 | `lib_027572` 51 | `PauseCloseText` (A; code, cons) | `[08:186][08:51E]`: erases both windows |
| D38-D41 | `asciistring_01464B`, `014660`, `014675`, `01468A` | 83531 / 21, 83552 / 21, 83573 / 21, 83594 / 21 | 0 direct (walked by FM-A5 L009, stride `$15`) | `SoulOfLightText`, `SoulOfShieldText`, `SoulOfDetectionText`, `SoulOfRealityText` (names of FM-A5 D04-D07) | `[CUR:3CE]`, `[CUR:48E]`, `[CUR:54E]`, `[CUR:60E]` and the soul name padded with blank glyphs to 18 characters |
The strings `asciistring_01445D` (A6, name entry), `asciistring_014571` and `asciistring_01469F` (A5 D01 and the menu frames) lie inside this address range but belong to A5 and A6.

### 3.3 Locations: names and scene profiles

Rows are the location ids that have a profile record (97). Columns: `Loc` = `location_id` (also the string number for the banner); `Name` = the string in `lib_014536_part2` (its label is `asciistring_` plus the suffix; text as in the extract: the apostrophe prints as a blank, the period as `-`; `[14:n]` is n blanks of centring); `Profile` = `binary_` plus the suffix; `Bytes` = the record (TM TS CGWSEL CGADSUB f4 f5 BGMODE parallax(4 bytes) f11); `W` = world `$03BA`; `Var` = variant increments of bits 7 and 6 (1.8); `NC` = no-combat flag (`$0439`); `SC` = `BG1SC/BG2SC`; `H` = `$03CA`.

| Loc | Name label | Name | Profile | Bytes | W | Var | NC | SC | H |
|-----|-----------|------|---------|-------|---|-----|----|----|---|
| 00 | 0148C2 |   Grass Valley Shrine  | 0169A1 | `17 00 80 00 E4 0F 09 11111111 20` | 0 | 0 | 1 | 63/73 | 256 |
| 01 | 0148D9 |  Grass Valley highlands | 0169AD | `17 12 82 43 24 8F 09 11110000 20` | 0 | 0 | 1 | 73/63 | 224 |
| 02 | 0148F1 |  Child s secret passage | 0169B9 | `15 00 80 00 64 0F 09 11110000 20` | 0 | 0 | 1 | 63/73 | 256 |
| 03 | 014908 | [14:6]Treasure room | 0169C5 | `15 00 80 00 64 0F 09 11110000 20` | 0 | 0 | 1 | 63/73 | 256 |
| 04 | 014918 | The village Chief s room | 0169D1 | `15 00 80 81 64 0F 09 11110000 20` | 0 | 0 | 1 | 63/73 | 256 |
| 05 | 014926 | Underground Castle, west | 0169DD | `17 00 80 02 24 0F 09 11111212 00` | 0 | 0 | 0 | 63/73 | 224 |
| 06 | 01493F | Underground Castle, east | 0169E9 | `17 00 80 02 24 0F 09 11111212 00` | 0 | 0 | 0 | 63/73 | 224 |
| 07 | 014958 | [14:5]Leo s Paintings | 0169F5 | `17 00 80 82 24 0F 09 11110000 00` | 0 | 0 | 0 | 63/73 | 224 |
| 08 | 014969 | [14:5]Leo s Paintings | 016A01 | `17 00 80 82 64 0F 09 11110000 00` | 0 | 0 | 0 | 63/73 | 256 |
| 09 | 01497A | [14:5]Leo s Paintings | 016A0D | `17 00 80 82 24 0F 09 11110000 00` | 0 | 0 | 0 | 63/73 | 224 |
| 0A | 01498B | [14:6]Tulip s Dream | 016A19 | `17 00 80 82 64 0F 09 11110000 A0` | 0 | 1 | 1 | 63/73 | 256 |
| 0B | 01499A | [14:5]Leo s Paintings | 016A25 | `17 00 80 82 24 0F 09 11110000 00` | 0 | 0 | 0 | 63/73 | 224 |
| 0C | 0149AB | Monster in the paintings | 016A31 | `17 00 80 82 64 0F 09 11110000 C0` | 0 | 2 | 0 | 63/73 | 256 |
| 0D | 0149BF | [14:7]Trial room | 016A3D | `15 00 80 00 64 0F 09 11110000 00` | 0 | 0 | 0 | 63/73 | 256 |
| 0E | 0149CC | [14:6]Lisa s dream | 016A49 | `17 00 80 00 24 0F 09 11111212 A0` | 0 | 1 | 1 | 63/73 | 224 |
| 0F | 0149DA | (empty) | 016A55 | `17 00 80 00 24 0F 09 11111111 00` | 0 | 0 | 0 | 63/73 | 224 |
| 10 | 0149DB | (empty) | 016A61 | `15 00 80 95 24 0F 0F 11110000 00` | 0 | 0 | 0 | 63/73 | 224 |
| 11 | 0149DC | (empty) | 016A6D | `17 00 80 00 E4 0F 09 11110000 00` | 0 | 0 | 0 | 63/73 | 256 |
| 12 | 0149DD | (empty) | 016A79 | `04 00 80 00 04 00 09 11110000 00` | 0 | 0 | 0 | 60/70 | 224 |
| 13 | 0149DE | (empty) | 016A85 | `16 00 80 82 24 8F 09 11110000 20` | 0 | 0 | 1 | 73/63 | 224 |
| 14 | 0149DF | [14:4]GreenWood Shrine | 016A91 | `17 00 80 00 E4 0F 09 11111111 21` | 1 | 0 | 1 | 63/73 | 256 |
| 15 | 0149F2 | [14:3]Woods of GreenWood | 016A9D | `17 12 82 01 26 8F 09 11110000 21` | 1 | 0 | 1 | 73/63 | 224 |
| 16 | 014A05 | [14:6]A mole s hole | 016AA9 | `15 00 80 00 24 0F 09 11111111 21` | 1 | 0 | 1 | 63/73 | 224 |
| 17 | 014A13 | [14:3]A squirrel s house | 016AB5 | `15 00 80 00 64 0F 09 11111111 21` | 1 | 0 | 1 | 63/73 | 256 |
| 18 | 014A26 |  Squirrel, the Exchanger | 016AC1 | `15 00 80 00 64 0F 09 11111111 21` | 1 | 0 | 1 | 63/73 | 256 |
| 19 | 014A3C | [14:3]Lostside, a marsh | 016AE5 | `17 00 80 00 64 03 09 11110000 01` | 1 | 0 | 0 | 63/70 | 256 |
| 1A | 014A4F | [14:6]Water Shrine | 016AF1 | `17 00 80 00 24 03 09 11110000 01` | 1 | 0 | 0 | 63/70 | 224 |
| 1B | 014A5E | [14:6]Water Shrine | 016AFD | `17 00 80 00 24 03 09 11110000 01` | 1 | 0 | 0 | 63/70 | 224 |
| 1C | 014A6D | [14:6]Water Shrine | 016B09 | `15 02 82 83 24 03 09 11111111 01` | 1 | 0 | 0 | 63/70 | 224 |
| 1D | 014A7C | [14:7]Fire Shrine | 016B15 | `17 00 80 00 24 03 09 11111100 01` | 1 | 0 | 0 | 63/70 | 224 |
| 1E | 014A8A | [14:7]Fire Shrine | 016B21 | `17 00 80 00 24 03 09 11111100 01` | 1 | 0 | 0 | 63/70 | 224 |
| 1F | 014A98 | [14:7]Fire Shrine | 016B2D | `17 00 80 00 24 03 09 11111100 01` | 1 | 0 | 0 | 63/70 | 224 |
| 20 | 014AA6 | [14:6]Light Shrine | 016B39 | `15 00 80 00 24 03 09 11111111 01` | 1 | 0 | 0 | 63/70 | 224 |
| 21 | 014AB5 | [14:6]Light Shrine | 016B45 | `15 02 82 83 64 0F 09 11111111 01` | 1 | 0 | 0 | 63/73 | 256 |
| 22 | 014AC4 |  Tomb of a stone statue | 016B51 | `15 00 80 00 64 0F 09 11111111 C1` | 1 | 2 | 0 | 63/73 | 256 |
| 23 | 014AD9 | [14:6]Bird s Dream | 016ACD | `15 00 80 00 24 0F 09 11111111 A1` | 1 | 1 | 1 | 63/73 | 224 |
| 24 | 014AE7 | [14:5]Stump s Dream | 016AD9 | `17 12 82 01 26 8F 09 11110000 A1` | 1 | 1 | 1 | 73/63 | 224 |
| 28 | 014AF9 | [14:4]St- Elles Shrine | 016B5D | `17 00 80 00 E4 0F 09 11111111 22` | 2 | 0 | 1 | 63/73 | 256 |
| 29 | 014B0C |   The Seabed Sanctuary | 016B69 | `17 00 80 02 24 0F 09 11110012 22` | 2 | 0 | 1 | 63/73 | 224 |
| 2A | 014B20 |  The Seabed of St- Elles | 016B75 | `17 12 82 03 24 8C 09 11111212 02` | 2 | 0 | 0 | 70/63 | 224 |
| 2B | 014B34 | [14:4]The Secret Cave | 016B81 | `17 12 82 03 24 8C 09 11111212 02` | 2 | 0 | 0 | 70/63 | 224 |
| 2C | 014B43 | [14:4]The Secret Cave | 016B8D | `15 00 80 00 64 0F 09 11110202 22` | 2 | 0 | 1 | 63/73 | 256 |
| 2D | 014B52 | [14:3]A dolphin s dream | 016B99 | `17 12 82 03 24 8C 09 11111212 A2` | 2 | 1 | 1 | 70/63 | 224 |
| 2E | 014B64 | [14:8]Southerta | 016BB1 | `17 00 80 02 24 03 09 11111111 02` | 2 | 0 | 0 | 63/70 | 224 |
| 2F | 014B70 |  Shore reef of Rockbird | 016BBD | `17 00 80 02 24 03 09 11111111 02` | 2 | 0 | 0 | 63/70 | 224 |
| 30 | 014B86 | [14:8]Durean | 016BC9 | `17 03 80 03 24 03 09 11111111 02` | 2 | 0 | 0 | 63/70 | 224 |
| 31 | 014B8F | [14:8]Blester | 016BD5 | `17 12 82 43 24 8C 09 11110000 02` | 2 | 0 | 0 | 70/63 | 224 |
| 32 | 014B99 | [14:6]A ghost ship | 016BE1 | `17 00 80 02 24 03 09 11111212 C2` | 2 | 2 | 0 | 63/70 | 224 |
| 33 | 014BA7 | [14:6]Servas  dream | 016BED | `17 00 80 02 24 03 09 11111212 A2` | 2 | 1 | 1 | 63/70 | 224 |
| 34 | 014BB7 |  The Seabed of St- Elles | 016BA5 | `17 12 82 03 24 8C 09 11111212 02` | 2 | 0 | 0 | 70/63 | 224 |
| 3C | 014BD2 |   The Soul s Sanctuary | 016BF9 | `17 00 80 00 E4 0F 09 11111111 23` | 3 | 0 | 1 | 63/73 | 256 |
| 3D | 014BE5 |   Soul of Mountain House | 016C05 | `15 00 80 03 24 03 09 11110012 23` | 3 | 0 | 1 | 63/70 | 224 |
| 3E | 014BFC |   Mountain, North+slope | 016C11 | `17 00 80 02 24 03 09 11111201 03` | 3 | 0 | 0 | 63/70 | 224 |
| 3F | 014C14 | [14:5]Aurora s Ridge | 016C1D | `17 00 80 A2 24 0F 09 11111202 03` | 3 | 0 | 0 | 63/73 | 224 |
| 40 | 014C24 | [14:3]An old man s dream | 016C29 | `17 00 80 A2 24 0F 09 11111202 A3` | 3 | 1 | 1 | 63/73 | 224 |
| 41 | 014C38 | [14:4]A passage to Lune | 016C35 | `17 00 80 02 24 03 09 11111414 03` | 3 | 0 | 0 | 63/70 | 224 |
| 42 | 014C49 |   Underground lake,Lune | 016C41 | `17 00 80 02 24 03 09 11111111 03` | 3 | 0 | 0 | 63/70 | 224 |
| 43 | 014C61 | [14:3]A mushroom s dream | 016C4D | `17 00 80 02 24 03 09 11111111 A3` | 3 | 1 | 1 | 63/70 | 224 |
| 44 | 014C74 | [14:8]Poseidon | 016C59 | `17 00 80 02 64 03 09 11111111 C3` | 3 | 2 | 0 | 63/70 | 256 |
| 45 | 014C7F | The top of Snow Mountain | 016C65 | `15 00 80 02 24 03 09 11111212 03` | 3 | 0 | 0 | 63/70 | 224 |
| 46 | 014C93 | [14:7]An ice hill | 016C71 | `17 00 80 02 26 8F 09 11111414 03` | 3 | 0 | 0 | 73/63 | 224 |
| 47 | 014CA1 |   Ice field of Laynole | 016C7D | `17 00 80 02 24 0F 09 11111212 03` | 3 | 0 | 0 | 63/73 | 224 |
| 50 | 014CBE |   The Laboratory Shrine | 016C89 | `17 00 80 00 E4 0F 09 11111111 24` | 4 | 0 | 1 | 63/73 | 256 |
| 51 | 014CD3 | [14:4]Leo s Laboratory | 016C95 | `17 00 80 02 24 03 09 11111212 24` | 4 | 0 | 1 | 63/70 | 224 |
| 52 | 014CE5 | [14:4]Leo s Laboratory | 016CA1 | `17 00 80 02 24 03 09 11111212 24` | 4 | 0 | 1 | 63/70 | 224 |
| 53 | 014CF7 | [14:8]An attic | 016CAD | `15 00 80 02 64 03 09 11111212 24` | 4 | 0 | 1 | 63/70 | 256 |
| 54 | 014D02 | [14:7]A mice nest | 016CB9 | `15 00 80 02 64 03 09 11111212 24` | 4 | 0 | 1 | 63/70 | 256 |
| 55 | 014D0F | [14:6]A cat s dream | 016CC5 | `17 00 80 02 24 03 09 11111212 A4` | 4 | 1 | 1 | 63/70 | 224 |
| 56 | 014D1D |  Basement of Laboratory | 016CD1 | `17 00 80 02 35 03 09 11111212 04` | 4 | 0 | 0 | 63/70 | 224 |
| 57 | 014D33 |  Basement of Laboratory | 016CDD | `17 12 82 43 26 8F 09 11111111 04` | 4 | 0 | 0 | 73/63 | 224 |
| 58 | 014D49 | [14:7]power plant | 016CE9 | `17 00 80 02 35 0F 09 11111212 04` | 4 | 0 | 0 | 63/73 | 224 |
| 59 | 014D57 | [14:8]Tin Doll | 016CF5 | `15 00 80 02 24 0F 09 11111212 C4` | 4 | 2 | 0 | 63/73 | 224 |
| 5A | 014D62 | [14:8]A dream 1 | 016D01 | `17 12 82 43 26 8F 09 11111111 A4` | 4 | 1 | 1 | 73/63 | 224 |
| 5B | 014D6D | [14:5]Model of a town | 016D0D | `17 00 80 02 B6 0F 09 11111111 04` | 4 | 0 | 0 | 63/73 | 224 |
| 5C | 014D7C | [14:5]Model of a town | 016D19 | `17 00 80 02 B6 0F 09 11111111 04` | 4 | 0 | 0 | 63/73 | 224 |
| 64 | 014D92 |   Magridd Castle Shrine | 016D25 | `17 00 80 00 E4 0F 09 11111111 25` | 5 | 0 | 1 | 63/73 | 256 |
| 65 | 014DA3 |  Castle of King Magridd | 016D31 | `17 00 80 00 24 0F 09 11111111 25` | 5 | 0 | 1 | 63/73 | 224 |
| 66 | 014DB5 | [14:3]The torture chamber | 016D3D | `15 00 80 02 24 03 09 11110101 05` | 5 | 0 | 0 | 63/70 | 224 |
| 67 | 014DC8 |  Basement of the castle | 016D49 | `17 00 80 00 B6 0F 09 11111111 05` | 5 | 0 | 0 | 63/73 | 224 |
| 68 | 014DDB |  Basement of the castle | 016D55 | `17 00 80 00 B6 0F 09 11111111 05` | 5 | 0 | 0 | 63/73 | 224 |
| 69 | 014DEE | [14:8]A dream 1 | 016D61 | `17 00 80 00 B6 0F 09 11111111 A5` | 5 | 1 | 1 | 63/73 | 224 |
| 6A | 014DF9 | [14:5]The left tower | 016D6D | `15 00 80 02 24 03 09 11110101 05` | 5 | 0 | 0 | 63/70 | 224 |
| 6B | 014E07 | [14:5]The left tower | 016D79 | `17 00 82 00 B6 0F 09 11111111 05` | 5 | 0 | 0 | 63/73 | 224 |
| 6C | 014E15 | [14:8]A prison | 016D85 | `15 00 80 02 24 03 09 11110202 05` | 5 | 0 | 0 | 63/70 | 224 |
| 6D | 014E1F | [14:5]The right tower | 016D91 | `17 00 80 00 B6 0F 09 11111111 05` | 5 | 0 | 0 | 63/73 | 224 |
| 6E | 014E2E | [14:5]The right tower | 016D9D | `17 00 80 00 B6 0F 09 11111111 05` | 5 | 0 | 0 | 63/73 | 224 |
| 6F | 014E3D | [14:5]The right tower | 016DA9 | `15 00 80 02 24 03 09 11110202 05` | 5 | 0 | 0 | 63/70 | 224 |
| 70 | 014E4C |  A corridor to the dock | 016DB5 | `17 00 80 02 24 03 09 11111101 05` | 5 | 0 | 0 | 63/70 | 224 |
| 71 | 014E5E |  The dock for an airship | 016DC1 | `17 00 80 02 24 0F 09 11111111 25` | 5 | 0 | 1 | 63/73 | 224 |
| 72 | 014E6F |  The deck of an airship | 016DCD | `17 12 82 43 26 8F 09 11110111 C5` | 5 | 2 | 0 | 73/63 | 224 |
| 73 | 014E80 | [14:4]A soldier s dream | 016DD9 | `17 12 82 43 26 8F 09 11110111 A5` | 5 | 1 | 1 | 73/63 | 224 |
| 78 | 014E96 |   The Evil World Shrine | 016DE5 | `17 00 80 03 E4 0F 09 11111111 26` | 6 | 0 | 1 | 63/73 | 256 |
| 79 | 014EAB | [14:6]World of Evil | 016DF1 | `17 02 82 43 24 0F 09 11110012 06` | 6 | 0 | 0 | 63/73 | 224 |
| 7A | 014EB9 | [14:6]World of Evil | 016DFD | `17 02 82 43 24 0F 09 11110012 06` | 6 | 0 | 0 | 63/73 | 224 |
| 7B | 014EC7 | [14:5]Dazzling Space | 016E09 | `17 02 82 43 24 0F 09 11111111 06` | 6 | 0 | 0 | 63/73 | 224 |
| 7C | 014ED8 | [14:3]Deathtoll s Shrine | 016E15 | `15 00 80 01 64 0F 09 11110000 06` | 6 | 0 | 0 | 63/73 | 256 |
| 7D | 014EEC |   Battle with Deathtoll | 016E21 | `17 00 80 82 74 03 09 11111111 06` | 6 | 0 | 0 | 63/70 | 256 |

The 31 ids without a profile have a name entry that is a single terminator byte (one byte each, consecutive labels): 25-27 (`014AF6`-`014AF8`), 35-3B (`014BCB`-`014BD1`), 48-4F (`014CB6`-`014CBD`), 5D-63 (`014D8B`-`014D91`), 74-77 (`014E92`-`014E95`), 7E (`014F00`) and 7F (`014F01`). Locations 0F-13 have a profile and an empty name (their record is in scenes 00/09-00/0D, the intro and transition scenes: no banner).

World index: 0 Grass Valley (ids 00-13: the village, the Underground Castle, Leo's Paintings, the dreams and the intro scenes), 1 GreenWood, 2 St. Elles, 3 Mountain of Souls, 4 Leo's Laboratory, 5 Magridd's Castle, 6 the World of Evil. The first id of each world (`00`, `14`, `28`, `3C`, `50`, `64`, `78`, the shrines) has byte 4 = `E4` (256 lines, BG1 and BG2 attribute bits clear) and byte 5 = `0F`; id `11` has the same two bytes.

Names read against the walkthrough and `plans/doc-audit/walkthrough-crosswalk.md`: the place names agree except for capitalisation (`power plant` against Power Plant, `Shore reef of Rockbird`, `Underground lake,Lune`, which the crosswalk already treats as matches) and the two unnamed dreams `A dream 1` (ids 5A and 69; OQ-I004-14). The 14 intro pages and 7 ending pages are not quoted by the walkthrough (it has no story text); "Freil Empire" occurs nowhere else in the project. No DISCREPANCY row arises from A7.

## 4. Structure layouts

### 4.1 Asset record (`asset_list_028000`)

| Offset | Width | Field | Evidence |
|--------|-------|-------|----------|
| +0 | byte | area | `code_0133FF` compares it with `area_current` (second compare, after `XBA`) |
| +1 | byte | scene | compared with `scene_current` first |
| +2 ... | commands | see 1.2 | `code_01393F` reads one byte at a time; the length ladders of L009 and L023 give 6, 6, 7, 4, 1, 3, 5, 6 operand bytes |
| last | byte | `00` | `code_0133A6` stops on `CMP #$00`; `code_01394A` treats `00` as "next record, skip 2 header bytes" |

Command operands (all bytes unless stated): graphics `b0 b1 b2 p0 p1 p2`; palette `b0 b1 b2 p0 p1 p2`; tileset `b0 b1 b2 b3 p0 p1 p2`; tilemap `t p0 p1 p2` (read as a 16-bit value with the high byte 0); asset8 `id`; meta4 three bytes; music `b0 b1 p0 p1 p2`; spritemap `b0 b1 b2 p0 p1 p2`. The pointer is `lo, mid, hi` of a linear file offset (1.3). Field widths: `b0`, `b1` are `XBA`-shifted bytes (`$00 = b0 << 8`, `$02 = b1 << 8`, then `ASL`), not words.

### 4.2 Scene profile (12 bytes, `binary_0169A1` ...)

| Offset | Width | Field | Evidence |
|--------|-------|-------|----------|
| +0 | byte | `TM` (also `TMW`, `$03C0`) | `STA $TM; STA $TMW; STA $03C0` |
| +1 | byte | `TS` (also `TSW`) | `STA $TS; STA $TSW` |
| +2 | byte | `CGWSEL` | `STA $CGWSEL` |
| +3 | byte | `CGADSUB` (also `$03C1`) | `STA $CGADSUB; STA $03C1` |
| +4 | byte | flags: bit 0 `$036A = $2000`, bit 1 `$036E = $2000`, bits 4-5 `$0373`, bit 6 `$03CA` 256 or 224, bit 7 clear sets `$036F` bit 0; bits 2-3 unused | eight `ROR` after `LDA +4`; `AND #$30`; `LDY #$00E0 / #$0100` |
| +5 | byte | BG layout: bits 0-1 BG1SC size, bits 2-3 BG2SC size, bit 7 swap | `AND #$03`, `LSR LSR AND #$03`, `BPL`, `INC $03DB` |
| +6 | byte | `BGMODE` | `STA $BGMODE` |
| +7 .. +10 | 4 bytes | nibble pairs (high, low) to `$034A + 2k`, `$034B + 2k` | loop `CPY #$0008` |
| +11 | byte | bits 0-3 world `$03BA`; bit 5 no-combat; bits 6 and 7 variant | `AND #$0F`, `ASL`, `INC $0439`, `INC $031E` |

### 4.3 `unk13` flag map patch (9 bytes, `us/structs.json` `Byte, Word, Byte x6`)

| Offset | Width | Field | Evidence |
|--------|-------|-------|----------|
| +0 | byte | location | `CMP $location_id` (8-bit) |
| +1 | word | event flag number | `LDA +2; XBA; LDA +1` then `code_0273A2` with `Y = $1A5E` (the array `event_flags` has `$80` bytes before `$1ADE`, so up to 1024 bits; the largest number used is `$03A2`; 13 rows use `$00FF`, OQ-I011-13) |
| +3 | byte | rectangle x (tiles) | `STA $1C71` |
| +4 | byte | rectangle y | `STA $1C72` |
| +5 | byte | rectangle width | `STA $1C73` |
| +6 | byte | rectangle height | `STA $1C74` |
| +7 | byte | staging x in tiles (pixel = `<< 4`) | `LDA +7; AND #$00FF; ASL x4; STA $16` |
| +8 | byte | staging y | same, `STA $18` |

Terminator: first byte `$FF` (`CMP #$FF`; `us/structs.json` `delimiter 255`). 70 rows for 29 locations: `00 01 06 0E 0F 13 14 15 16 18 23 24 28 2C 2D 33 34 3C 3D 42 50 55 64 65 71 72 73 78 7B`.

### 4.4 `unk10` scene variant rule (4 bytes, `system/data_00F99A`, 23 rows)

| Offset | Width | Field | Evidence |
|--------|-------|-------|----------|
| +0 | byte | location | `CMP $location_id`; a first byte `$80` or more ends the table (`BMI`) |
| +1 | word | switch number tested in `$1ADE` | `LDA +2; XBA; LDA +1`, `LDY #$1ADE`, `code_0273A2` |
| +3 | byte | variant written to `$031E` | `STA $031E` |

### 4.5 Save slot line template (20 bytes each, `binary_01440D`)

`01 <w> 02 03 01 <w> 06 02 <w> 01 <w> 06 01 <w> 00` = `[CUR:o1][02:3][CUR:o2][06:2,$0450][CUR:o3][06:1,$0452]` and the end byte; the offsets are `$2D4`, `$2E8`, `$2F2` for slot 1 and each following slot adds `$C0` (`$394`, `$454`, `$514`). The bytes decode with the control code lengths of FM-A6 1.3 (`01` + word, `02` + byte, `06` + byte + word, `00` end). `$0447` holds the slot name, `$0450` the level, `$0452` a word read from `$700200 + slot * $400 + $1B90` (the value `code_006D30` loads into `scene_next`; OQ-I011-12).

### 4.6 Pointer lists

`binary_list_0168A1` and `asciistring_list_0147C2`: 128 words, index = location id, 0 or a 1-byte string for unused ids. `[TBL:list,addr]` reads the **word** at `addr` and doubles it (`loc_012931`).

## 5. WRAM and DP proposals

| Address | Evidence | Proposed name | Conf | Users |
|---------|----------|---------------|------|-------|
| dp`$00-$06` | loader operands (start, end, destination offset, flag word) | `loader_args` | A | L010-L016 |
| dp`$1E` | one-hot bit mask of the LZ reader, `$80` = byte aligned | `lz_bit_mask` | A | L005-L007 |
| dp`$1F-$20` | ring write index (`INC $1F` wraps in the 256-byte page, `$20` = 1) | `lz_ring_write` | A | L005 |
| dp`$21-$22` | ring read index | `lz_ring_read` | A | L005 |
| dp`$23-$24` | output byte count | `lz_out_count` | A | L005 and its callers |
| dp`$25-$26` | WRAM destination | `lz_out_ptr` | A | L005 and its callers |
| dp`$29-$2B` | source long pointer | `asset_src_ptr` | A | L005-L024 |
| dp`$2C-$2E` | copy destination long pointer; `$2E` is the SPC upload's bank counter and holds `$7E` after it | `copy_dst_ptr` | B | L012, L013, L015, L016 (hazard: OQ-I011-1) |
| dp`$2F-$31` | asset list long pointer, set once at boot | `asset_list_ptr` | A | L009, L022, L023, L025 |
| `$031A` | b0 of the music record, written to `APUIO0` after the upload | `bgm_start_cmd` | B | L020 |
| `$031C` | b1 of the music record (variant it belongs to) | `bgm_record_variant` | B | L020 |
| `$031E` | scene variant (0-3 seen) | `scene_variant` | B | L003, L018, L020; writers `engine_005354`, `common_actor_0066FC`, `w0_actor_01A440` |
| `$034A-$0351` | nibble pairs of profile +7..+10 | (FM-A4 parallax ratios) | B | L018 |
| `$035C`, `$0360` | set to `$FDFF` by every profile | (FM-A4) | C | L018 |
| `$036A`, `$036E` (`$036B`, `$036F`) | BG1/BG2 tile attribute words from profile +4 | `bg1_tile_attr`, `bg2_tile_attr` | B | L018 |
| `$0372-$0373` | `$0373` = profile +4 and `$30` (OAM priority bits); `$0372` default sprite attribute word read by FM-A1 R52 | `scene_sprite_attr` | B | L018, `code_00144F` |
| `$03A2` | pause latch | `pause_latch` | B | `lib_027572` |
| `$03B4` | skip mask (1.3) | `asset_skip_mask` | A | L010-L012, L014, L020, L021; 15 writer sites in 13 files |
| `$03BA` | world index (profile +11 low nibble) | `world_index` | A | L018; readers `lib_0270E4`, `engine_000000`, `engine_0029EC`, `engine_routines_001D3B`, `common_actor_00766C` |
| `$03C0-$03C3` | shadows of `TM`, `CGADSUB`, `BG2SC` (and `W12SEL`, FM-A5) | `tm_shadow`, `cgadsub_shadow`, `bg2sc_shadow`, `w12sel_shadow` | A | L018; FM-A5 menu exit |
| `$03CA` | 224 or 256 from profile +4 bit 6 | `view_height_px` | B | L018 |
| `$03DB` | BG layer swap flag (profile +5 bit 7) | `bg_layer_swap` | B | L018, NMI `code_00046E` |
| `$0407-$0424` | ten 3-byte pointer caches (1.3) | `asset_cache` (`asset_cache_gfx0`, `_gfx1`, `_gfx2`, `_gfx3`, `_tileset1`, `_tileset2`, `_tilemap1`, `_tilemap2`, `_spritemap`, `_music`) | A | L010, L012, L014, L020, L021, L024 |
| `$0439` | no-combat flag (profile +11 bit 5), cleared by `code_0279B5` | `no_combat_scene` | B | L018, `lib_027572`, `lib_027781_part1`, `common_actor_001A28_part1/part2` |
| `$0456` | lairs of this location not yet released | `lairs_remaining` | A | L001; `lib_027572`, FM-A4 L025 |
| `$0342-$0345` | `map_width_px`, `map_width_pages`, `map_height_px`, `map_height_pages` (BG1) | existing mnemonics | A | L014, L015 |
| `$0346-$0349` | the same for BG2 | `map2_width_px`, `map2_width_pages`, `map2_height_px`, `map2_height_pages` | B | L015 (`STA map_width_px, X` with X = 4) |
| `$0352`, `$0356` | WRAM base of the BG1 and BG2 map pages (`$8000`, `$C000`) | `map_page_base_bg1`, `map_page_base_bg2` | B | L015 |
| `$1B80` | BCD digits of `lairs_remaining` for the banner | `lair_count_bcd` | B | `lib_027572` |
| `$7E:0100-$01FF` | LZ ring, scratch (OQ-I011-8) | `lz_ring` | B | L005 |
| `$7E:2000-$2FFF` | metatile definitions, BG1 and BG2 | `metatile_defs_bg1`, `metatile_defs_bg2` | A | L012; FM-A4 L029 |
| `$7E:3800`, `$7E:F000` | spritemap areas | `spritemap_main`, `spritemap_alt` | B | L021, `meta_tables_008000` |
| `$7E:6000-$7FFF` | decompression staging | `lz_staging` | A | L010, L012, L014 |
| `$7E:8000`, `$7E:C000` | BG1 and BG2 map pages (also the Mode 7 map) | existing (A3, A4) | A | L001, L014-L016 |

Existing names kept: `area_current`, `scene_current`, `location_id`, `event_flags`, `lair_state`, `cgram_buffer`, `map_width_px`, `map_height_px`.

## 6. Inner labels

Every label of a code part that is not a routine row. All are local branch targets; none has a reference from outside its routine (`rg` over `extracted/`), so no sub-label override is needed for them. The row id is the routine that contains them; offsets are the `{n}` tag of the first instruction.

| Row | Labels (offset) |
|-----|-----------------|
| L001 (6) | `loc_011585` 71045, `loc_0115A3` 71075, `loc_0115B0` 71088, `loc_0115B1` 71089, `loc_0115DE` 71134, `loc_0115ED` 71149 |
| L002 (4) | `loc_0115F5` 71157, `loc_011614` 71188, `loc_011620` 71200, `loc_011621` 71201 |
| L003 (3) | `loc_011667` 71271, `loc_01168B` 71307, `loc_011691` 71313 |
| L005 (6) | `loc_013287` 78471, `loc_013299` 78489, `loc_0132AA` 78506, `loc_0132BD` 78525, `loc_0132C7` 78535, `loc_0132DD` 78557 |
| L006 (14) | `loc_0132FF` 78591, `loc_013306` 78598, `loc_01330D` 78605, `loc_013314` 78612, `loc_01331B` 78619, `loc_013322` 78626, `loc_013329` 78633, `loc_013332` 78642, `loc_013333` 78643, `loc_013334` 78644, `loc_013335` 78645, `loc_013336` 78646, `loc_013337` 78647, `loc_013338` 78648 |
| L007 (6) | `loc_01335B` 78683, `loc_013361` 78689, `loc_013379` 78713, `loc_013385` 78725, `loc_013392` 78738, `loc_01339E` 78750 |
| L008 (9) | `loc_0133AE` 78766, `loc_0133BE` 78782, `loc_0133C7` 78791, `loc_0133D0` 78800, `loc_0133D9` 78809, `loc_0133E2` 78818, `loc_0133EB` 78827, `loc_0133F4` 78836, `loc_0133FD` 78845 |
| L009 (8) | `loc_013402` 78850, `loc_013415` 78869, `loc_013436` 78902, `loc_013437` 78903, `loc_013438` 78904, `loc_013439` 78905, `loc_01343A` 78906, `loc_01343C` 78908 |
| L010 (15) | `loc_01344D` 78925, `loc_013484` 78980, `loc_01348E` 78990, `loc_013498` 79000, `loc_0134A2` 79010, `loc_0134AA` 79018, `loc_0134AD` 79021, `loc_0134B9` 79033, `loc_0134C6` 79046, `loc_0134D4` 79060, `loc_0134E0` 79072, `loc_0134F0` 79088, `loc_013509` 79113, `loc_013518` 79128, `loc_013523` 79139 |
| L011 (2) | `loc_013540` 79168, `loc_013560` 79200 |
| L012 (9) | `loc_013580` 79232, `loc_0135B8` 79288, `loc_0135C2` 79298, `loc_0135CA` 79306, `loc_0135CD` 79309, `loc_0135D3` 79315, `loc_0135E0` 79328, `loc_0135EE` 79342, `loc_0135FF` 79359 |
| L013 (2) | `loc_013619` 79385, `loc_01362A` 79402 |
| L014 (7) | `loc_013637` 79415, `loc_01365B` 79451, `loc_013665` 79461, `loc_01366B` 79467, `loc_01369B` 79515, `loc_0136A7` 79527, `loc_0136B7` 79543 |
| L015 (4) | `loc_0136D4` 79572, `loc_0136E0` 79584, `loc_0136E6` 79590, `loc_0136E9` 79593 |
| L016 (4) | `loc_0136F8` 79608, `loc_013705` 79621, `loc_01370E` 79630, `loc_01371C` 79644 |
| L018 (16) | `loc_013765` 79717, `loc_01376B` 79723, `loc_0137C5` 79813, `loc_0137CB` 79819, `loc_0137D8` 79832, `loc_0137E3` 79843, `loc_0137F8` 79864, `loc_01381A` 79898, `loc_013835` 79925, `loc_013840` 79936, `loc_013866` 79974, `loc_01386C` 79980, `loc_013874` 79988, `loc_01387D` 79997, `loc_013883` 80003, `loc_013889` 80009 |
| L020 (4) | `loc_0138AB` 80043, `loc_0138C6` 80070, `loc_0138CF` 80079, `loc_0138D4` 80084 |
| L021 (3) | `loc_013909` 80137, `loc_013923` 80163, `loc_013938` 80184 |
| L023 (8) | `loc_01394F` 80207, `loc_013951` 80209, `loc_013972` 80242, `loc_013973` 80243, `loc_013974` 80244, `loc_013975` 80245, `loc_013976` 80246, `loc_01397B` 80251 |
| L024 (1) | `loc_01399B` 80283 |
| L025 (4) | `loc_0139E6` 80358 (target of the dead `BRA` of L023), `loc_013AAD` 80557, `loc_013ABA` 80570, `loc_013AC5` 80581 |

Sub-label rows with external callers: L002 (`code_0115F1`, 1 site, `lib_027781_part3`) and L003 (`code_011662`, 1 site, `lib_0133A6_part3`). Both are colon labels inside the part `code_01157E`; in the flat namespace each is a separate entry point and needs its own name row in PC. The other 21 routine labels of `lib_0133A6_part3` are brace labels of one part (`code_013272`, 2152 bytes), so the part has one name today and the 20 others need rows in `names/bank01.json` as well.

## 7. Fan-in, findings and placement

Fan-in of the batch:

| Routine | Sites | Files |
|---------|-------|-------|
| `code_013272` L005 | 8 | 2 (`lib_0133A6_part3` 5, `lib_02719F` 3) |
| `code_013983` L024 | 10 | 1 |
| `code_01393F` L022 | 22 | 1 |
| `code_013731` L017 | 6 | 1 |
| `code_0133A6` L008, `code_01157E` L001, `code_0115F1` L002 | 1 each | 1 (`lib_027781_part3`) |
| `code_0139AC` L025, `code_013ADA` L026 | 1 each | 1 (`engine_000000` boot) |
| `code_0131C9` L004 | 3 | 1 |

Findings for later batches and for PB:

- **The scene loader is one subsystem of 26 routines** that today sits in five parts named after `0133A6` and spread over `$1157E`-`$1728D`: the 21 routines of `lib_0133A6_part3`, `code_0131C9`, the three routines of part 1, the profile list and records (part 4), the patch table (part 5), `data_00F99A` and `data_00BA0D` (lair records, FM-A4 4.6). Proposed block `scene_loader` for the code (`code_013272` ... `code_0139AC`, kept contiguous and in this order because of the two dead `BRA $74` that cross routines), `scene_profiles` (D01, D02), `scene_patches` (D03, `data_00F99A`), `boot_hardware` (L025 and L026: L025 cannot move away from `code_01394A` without changing the dead `BRA` bytes; move them together, or treat the `BRA` as a ROM-identity constraint).
- **Strings**: `intro_text` (D07-D22 with `common_actor_0066FC`), `ending_text` (D24-D31 with `common_actor_00729D`), `pause_banner` (D35-D37), `level_up_text` (D33, D34), `save_slot_text` (D05, D32), `location_names` (D06). The soul lines D38-D41 stay next to FM-A5 D03.
- `code_01318C` (force blank and NMI off before the loader), `code_0131B7` (vblank wait), `code_0131D1` (8x8 multiply) and the rest of library `0131`-`0132` are in no batch (FM-A4, FM-A6); the loader depends on all three.
- **Decode check**: no M/X anomaly in the A7 code files; no `overrides.json` row is needed.
- **Latent defects, none reproducible in play so far (all rows in I011)**: the raw tilemap flag (height bit 7) leaks into `map_height_px` and the product (OQ-I011-2); the LZ ring page `$0100-$01FF` is clobbered by every decompression (OQ-I011-8); `$2E` is trusted to be `$7E` (OQ-I011-1); the asset list has no end sentinel (OQ-I011-3); two unreachable `BRA` (OQ-I011-10).
- **Answered here**: FM-A4's `$0372`/`$0373`, `$03BA`, `$03C0-$03C3`, `$03CA`, `$03DB`, `$0439` have a writer and a decoding (section 4.2). The unnamed locations `0F`-`13` of the crosswalk are scenes `00/09`-`00/0D`; `10` is the Mode 7 scene.

Open questions: `plans/extracted-audit/questions/I011_questions.md` (13 rows, none tagged DISCREPANCY).
