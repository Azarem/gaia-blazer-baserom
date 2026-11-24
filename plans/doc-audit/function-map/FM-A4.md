# FM-A4: library `0100-0111` (camera, scroll streaming, tile edits, triggers, lair release)

PA batch A4, iteration I008. Read-only analysis: no names, notes, comments, `blocks.json`, `overrides.json` or docs were changed. Every proposed name below is a proposal for step PC (`npm run names`); every unverified claim is an `OQ-I008-k` row in `plans/extracted-audit/questions/I008_questions.md`.

Source: a fresh `npm run extract:lt` of `extracted/library/`. Twenty-four files were read end to end; offsets are decimal file offsets (the `{n}` tag; LoROM). A label `code_01xxxx` is at file offset `0x01xxxx`; the SNES address of the code files `0100-0111` is `$02:8000 + (offset - 0x10000)`, i.e. `code_010000` is `$02:8000`.

| File | Offsets | Top-level labels | Content (this batch's reading) |
|------|---------|------------------|--------------------------------|
| `lib_010000` | 65536-65641 | 1 | camera target to scroll delta |
| `lib_010069` | 65641-65803 | 1 | apply the delta to BG1, request strips, BG2 parallax |
| `lib_01010B` | 65803-66062 | 3 | strip request dispatcher, column strip, row strip |
| `lib_01020E` | 66062-66351 | 1 | full redraw of both layers at scene entry |
| `lib_shared_01032F` | 66351-66475 | 1 | column strip buffer fill |
| `lib_01010B_part2` | 66475-66585 | 1 | row strip buffer fill |
| `lib_shared_010419` | 66585-66662 | 1 | 16 metatiles as a tile column |
| `lib_01010B_part3` | 66662-66735 | 1 | 16 metatiles as a tile row |
| `lib_shared_0104AF` | 66735-66941 | 3 | ratio scaler, BG2 parallax x and y |
| `lib_01020E_part2` | 66941-67163 | 2 | strip buffers to VRAM (DMA ch2), one DMA chunk |
| `lib_01065B` | 67163-67277 | 1 | next animation frame record (`Cop92`-`Cop95`) |
| `lib_0106CD` | 67277-67313 | 1 | copy of the frame data through the RAM `MVN` stub |
| `lib_0109D6_part1` | 67313-67771 | 2 | set one metatile (BG1, BG1 and BG2) and queue its VRAM words |
| `lib_0108BB` | 67771-68054 | 1 | scripted map patch (rectangle from a staging area) |
| `lib_0109D6` | 68054-69053 | 5 | per-frame tile triggers: lair switch, plates, chests, exits |
| `lib_010EA9_part1` | 69053-69354 | 2 | return-mode frame (release message and reveal) |
| `lib_010EEA` | 69354-69930 | 3 | cross-shaped sweep redraw, one step per sub-frame |
| `lib_shared_01112A` | 69930-70389 | 3 | rectangle copies in the metatile maps (variant slab, staging) |
| `lib_0109D6_part3` | 73977-74040 | 1 | inventory entry store |
| `lib_010EA9_part2` | 86758-87358 | 1 list + 53 strings | NPC name list |
| `lib_010EA9_part3` | 90590-90646 | 2 strings | release and recall messages |
| `lib_0109D6_part4` | 90646-90694 | 2 strings | chest messages |
| `lib_010EEA_part2` | 93741-94861 | 1 | sweep step table (35 x 32 bytes) |
| `lib_0109D6_part5` | 95788-96048 | 1 | location id to (area, scene) |

94 top-level labels: 34 code, 60 data (1 pointer list, 57 strings, 1 binary, 1 word table). The 34 code routines and the 8 data blocks are rows `L001`-`L042` (the 53 list strings are in section 4.10). No sub-label row is needed: the 0 references to a `loc_*` label of these files from another file were found (`rg`), so every `loc_` is local to its routine.

Context read for the callee and caller models: `lib_shared_0131D1` (8x8 hardware multiply, 16-bit result), `lib_027462_part1` (`code_0272B8` tile index), `lib_027462_part2` (`code_02731A` next x, `code_027331` next row), `lib_0272E6` (BG1 VRAM word address), `lib_0273A2`/`lib_027348`/`lib_027374` (test, set, clear bit), `lib_0273D4` (facing byte), `lib_0276A5` (Gems add), `lib_027912` (boot init of the layer parameters and the `MVN` stub), `lib_0133A6_part3` (scene header decode), `lib_0133A6_part1`, `lib_011395`, `lib_0114D0`, `lib_0114E4` (list pointers per location), `lib_shared_012769` (`code_013140` wait, `code_012C27` text box), `cop_handler_006075/00608E/0060B1/0060CD`, `engine_000000` (main loop, sub-frame, `code_0004C8`), `engine_003005`, `common_actor_001A28_part1`, `common_actor_006E28`, `table_058000`, `table_068000`, the three trigger tables and `data_00BA0D`.

## 0. Reading the tables

| Column | Meaning |
|--------|---------|
| Off / size | decimal file offset and size in bytes (distance to the next label; the last row of a file ends at the part end in `us/blocks.json`) |
| Callers | reference count and files, from `rg` over `extracted/` (`JSL`, `JSR`, branches, pointer words); string references inside text (`[TBL:]`, `[JMP:]`) are counted as `text` |
| Name (conf, evidence) | proposed `VerbNoun` name. Confidence: **A** behaviour fully read and independently corroborated (consumer, walkthrough, existing doc or name); **B** behaviour fully read, purpose inferred from code only; **C** guessed, partly decoded or dead. Evidence labels: `code`, `callee`, `caller`, `cons` (consumer), `walk` (walkthrough), `doc`, `hw`, `dead` |
| In / Out | registers, DP and WRAM inputs and results. M/X widths are those at entry unless stated. D is 0 |
| Clobbers | registers and DP scratch that are not restored |
| Data touched | WRAM names from `us/mnemonics.json` where one exists, otherwise the raw address (proposals are in section 5). `r` read, `w` write |

Layer offset: a routine that takes `X = 0` (BG1) or `X = 4` (BG2) indexes per-layer words with a stride of 4 bytes: `scroll_bg1_x,X` is `$033A` (BG1) or `$033E` (BG2, mnemonic `scroll_bg2_x`), `map_width_px,X` is `$0342`/`$0346`, `$0352,X` is `$0352`/`$0356`, and so on (section 4.1). `engine_000000.code_0004AB` writes both scroll pairs to `BG1HOFS`/`BG2HOFS` this way.

## 1. Models that several rows share

### 1.1 Two page-organised metatile maps, definitions and the type map

The map of a scene is a grid of 16x16-pixel metatiles stored as 256-byte **pages** (16 x 16 metatile ids, row-major inside a page, pages row-major over the map: `width_pages * 256` bytes per page row). `code_0272B8` (callee) turns a pixel position `($16, $18)` into the byte index `X = (page row * width_pages + page column) * 256 + (y & $FF) + ((x >> 4) & $0F)` (`y & $FF` is not masked to a multiple of 16: OQ-I007-7), or 0 when the index is `>= $4000`.

| Buffer | Address | Content | Set at boot by `lib_027912` |
|--------|---------|---------|------------------------------|
| BG1 metatile ids | `$7E:8000` (`$0352`) | one byte per metatile | `$0352 = $8000` |
| BG2 metatile ids | `$7E:C000` (`$0356`) | one byte per metatile | `$0356 = $C000` |
| BG1 / BG2 definitions | `$7E:2000` / `$7E:2800` (`$035A`, `$035E`) | 8 bytes per id: four tile words TL, TR, BL, BR | `$035A = $2000`, `$035E = $2800` |
| `tile_type_map` | `$7F:8000` | one byte per BG1 metatile, same index as the BG1 id map | - |
| Strip buffers | `$7E:3000`, `$3102`, `$3204`, `$3306` (`$0362`, `$0364`, `$0366`, `$0368`) | 258 bytes each (section 4.2) | set; `$34 = $37 = $7E` |

The BG1 tilemap is at VRAM word `$6000` (`BG1SC = $60 | size`), BG2 at `$7000`, with size bits that `lib_0133A6_part3` takes from the scene header (`BG1SC`, `BG2SC` stores). The strip code assumes a **64 x 64 tile map** (four 32 x 32 screens): the screen is chosen by bit 8 of x (`+$0400` words) and bit 8 of y (`+$0800`), which is what `code_0272E6` and the strip headers compute. The definition words are `vhopppcc cccccccc` tile words; the high byte's bit 1 (tile-number bit 9) is **not** a graphics bit: `code_0106F1`/`code_0107AC` copy it as the quadrant's solid flag into `tile_type_map` (bits 0-3 = TL, TR, BL, BR), and every VRAM upload masks it out with `$035C`/`$0360` (`lib_0133A6_part3` stores `$FDFF` there). Each upload also ORs the layer attribute word `$036A` (BG1) or `$036E` (BG2).

**Variants (slabs).** A map can have extra copies of itself behind the live pages. `code_01112A` copies a rectangle from `slab k` (offset `k * width_pages * height_pages * 256` bytes from the live page index; it needs `k * pages < 256`) into the live map. A rectangle can also come from a **staging** area inside the same map (`code_0111CB`, `code_01125E`, `code_0108BB`). The strip code wraps its page walk at `base + width_pages * height_pages` pages, so slabs are never streamed.

Special ids seen in these routines: `$FD` lair tile (A2 X057), `$FE` lair switch, `$FF` cleared, `$FB` closed chest, `$FC` open chest.

### 1.2 Camera and scroll streaming (rows L001-L015)

```
player move (common_actor_001A28_part1, common_actor_006E28)
  -> code_010000: $0382/$0384 = target - scroll       (target = player - ($70, $80), clamped)
main loop and sub-frame (engine_000000)
  -> code_010069: scroll += delta (clamped); crossing a 16-px line ORs $80 (x) or $40 (y) into $0396;
                  BG2 parallax: code_0104E1 / code_01052F with masks $20 / $10
  -> code_01010B: for each request bit: build the strip into a buffer (code_010163 column, code_0101C2 row);
                  after the BG1 strips the delta is replaced by the BG2 delta ($038E/$0390); at the end both are zeroed
NMI (engine_000000.code_0004C8)
  -> code_01057D: header word <> 0: four 64-byte DMA chunks per buffer (ch2), then the header is cleared
```

`$0396` request bits: `$80` BG1 column, `$40` BG1 row, `$20` BG2 column, `$10` BG2 row. The BG2 strips are built only when the BG2 map is at least 3 pages wide (`$0347`) or tall (`$0349`); a BG2 map of 1-2 pages already fits in the 64 x 64 tilemap. A column strip rewrites the whole 64-tile height (two page rows, `$18` bit 8 decides which half comes first); a row strip rewrites two pages across.

**Strip buffer** (258 bytes): header word = VRAM word address of the top-left tile (0 = empty), then four blocks of 64 bytes. Column buffer: `left column, screen 0` | `right column, screen 0` | `left column, screen 1` | `right column, screen 1`, written with `VMAIN = $81` (step 32 words) to `hdr`, `hdr+1`, `hdr+$800`, `hdr+$801`. Row buffer: `top tile row` | `bottom tile row` for the first page, then for the second page, written with `VMAIN = $80` to `hdr`, `hdr+$20`, `hdr+$400`, `hdr+$420`. DMA channel 2, mode 1 to `$2118`, source bank `$7E`.

**Parallax.** The scene header (`lib_0133A6_part3`, `binary_list_0168A1+7..+A`) gives four bytes; for each, the high nibble is stored as the low byte and the low nibble as the high byte of a word at `$034A`, `$034C`, `$034E`, `$0350` (BG1 x, BG1 y, BG2 x, BG2 y). `code_0104AF` computes `A * low / high` with the multiplier and the divider (a zero divisor gives `$FFFF`). BG2 follows BG1 by that ratio plus the scripted offset `$038A`/`$038C`. `code_010069` runs the BG2 update only when the word is non-zero; `code_01020E` runs it for both layers, so a BG1 ratio of 0 would divide by zero (OQ-I008-6).

### 1.3 Palette-style frame records (`Cop92`-`Cop95`, rows L016-L017)

`code_01065B` reads 6-byte records `[hold][source word][slot][length code][delay]` from `bank [$24,X]:$8000 + 2 * $1E,X` (pointer) `+ 6 * $20,X` (frame). The bank varies per actor (`$0B` = `table_058000`, `$0D` = `table_068000`); the operand printed as `$&meta_tables_008000` is the constant `$8000` read with `DBR = $24,X`, not a reference to bank 0 (OQ-I008-3). `code_0106CD` then patches the destination and source banks into the RAM stub at `$1C5C` (`PHB`, `MVN $7F,src`, `PLB`, `RTS`, written by `lib_027912`) and copies `length code + 1` bytes from the source to `$7F:(slot * 2)`. The destination base is `$7F0000` (`cgram_buffer`) and the example rows in bank `$0D` (`slot $70`, 18 bytes) land inside the BG palettes, so the frames are palette data (OQ-I008-4). The `$0C = 2` case moves the destination to `$7F0200` (`coldata_buffer`, OQ-I008-5).

### 1.4 Tile triggers, one call per frame (`code_0109D6`, rows L021-L027)

`code_0109D6` runs from the main loop after `code_0118FC` when `location_id - $10 >= 3` and `return_active` is 0. The player's position must be tile aligned for the first three triggers (`(player_x | player_y) & $0F == 0`, byte compare).

| Step | Condition | Routine |
|------|-----------|---------|
| 1 | aligned and the BG1 id at `(player_x, player_y - 16)` is `$FE` | `$0458 == 0`: `code_010C25` (lair switch) |
| 2 | aligned, any other tile | `code_010B9B` (plates), then `code_010A29` (chests); carry set stops further checks |
| 3 | always (also when not aligned) | `code_010AF2` (exit regions) |
| end | any carry set | `$04,X` and `$06,X` of the player actor are zeroed (the move is cancelled) |

The three lists are per location: `$03AE` (offset into `table_00A9DE`, chests), `$03B2` (offset into `table_00AC96`, exits; 0 = none, boss actors `STZ` it), `$03AC` (current list of `table_00B69A`, plates); `lib_0114D0`, `lib_0114E4` and `lib_011445` set them.

### 1.5 Lair release (rows L025-L027, L028-L033)

A lair (A2) is a `data_00BA0D` record. When the monsters are dead the lair tile `$FD` is replaced by the switch `$FE` (A2). Stepping on the switch runs `code_010C25`:

1. Find the record whose switch location and tile (`+B`, `+C`, `+D`) match; `$0456` (lair count) is decremented when non-zero.
2. The switch tile becomes `$FF` in the BG1 id map (and in the BG2 map when record `+8` is non-zero).
3. Record **without** a rectangle (`+E | +F == 0`): `lair_state[i] = +A | $C0`. Host location (`+0`) is the current one: the home tile gets `tile_type_map = 1`, `BRK #$94`, one BG1 sweep. Host elsewhere: the return trip (step 5).
4. Record **with** a rectangle: `lair_state[i] = +A | $80`, bit `i` is set in `$1ADE` and `$1A9E`. Host is the current location: the staging rectangle `(+E, +F)` is copied to `(+4, +5)` (`code_0111CB` when `+8` is 0 or bit 0 is clear, `code_01125E` when bit 0 is set), `BRK #$94`; `+8 == 0`: one BG1 sweep; `+8 != 0`: a BG2 sweep, then a BG1 sweep. Host elsewhere: nothing is copied, only `BRK #$94` and one BG1 sweep (the state byte persists; `lib_0112F5`, `lib_011395` and `lib_0133A6_part1` act on it at scene load).
5. Return trip (only from step 3, host elsewhere): `return_area/scene/x/y` = current area, scene, player x, y - 16; `warp_dest_x/y` = home tile * 16; `warp_dest_anim = +1D`; `area_next/scene_next` = `word_01762C[+0]`; `transition_type = $80`; `$03B4 = $20`; `$0405 = i`; `return_active++`.

In the host location the main loop runs `code_010EA9` once (return mode): when the player's tile has `tile_type_map == 1` (`lib_011395` marks the home tile of released records at scene load) `code_010DBD` finds the record, prints "released NAME" (`asciistring_016203`), clears bit 6 of `lair_state[i]`, plays `BRK #$9C`, applies the variant slabs `+1 .. 3` with a sweep each (`code_01112A`) and sets the bits in `$1A9E`/`$1ADE`; otherwise it prints "NAME cannot be recalled yet!" (`asciistring_0161DE`). The main loop then waits, adds `max_hp / 8` to `$043B` (pending heal), waits 120 frames and returns to the saved area, scene and position. The walkthrough agrees with the first half: the switch under a lair frees an NPC, opens a path or releases chests (`02-grass-valley.md` lines 47 and 238, `03-greenwood.md` lines 59 and 339, `04-st-elles.md` line 351).

### 1.6 Sweep redraw (rows L028-L030, L042)

`$1C75` is the step (0 = idle, 1-35), `$1C6C` the layer (0 = BG2, 1 = BG1). `code_010EEA` runs once per sub-frame (`engine_000000` after `code_027223`): it takes record `$1C75 - 1` of `binary_016E2D`, and for each of 16 cells `(x_k, y_k)` (metatile offsets from `scroll & $FFF0`) queues four VRAM words of that metatile at the current id and definition. After step 35 `$1C75` is 0. The records alternate a column and a row, from the screen centre outward (columns 7, 8, 6, 9, ... 0, 15, 16; rows the same, then a last row 16), so the new map is wiped in over 35 sub-frames. Every caller waits 35 sub-frames with `code_000173` and sets the layer: `$1C6C` stays 0 for the first sweep (BG2) and is incremented for the second (BG1).

## 2. Routine table

### 2.1 Camera and scroll

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L001 | `code_010000` | 65536 / 105 | 3 sites / 3 files (`common_actor_001A28_part1`, `common_actor_006E28`, `engine_000000` `code_000127`) | camera | `AimCameraAtPlayer` (A; code, caller, cons L002) | `JSL`, any M/X (`PHP`, `REP #$30`) | `$0382 = target_x - scroll_bg1_x`, `$0384 = target_y - scroll_bg1_y` (signed words); `target_x = clamp(player_x - $70, 0, map_width_px - $100)`, `target_y = clamp(player_y - $80, 0, map_height_px - $03CA)` | A, X, Y (P restored) | r `player_x`, `player_y`, `scroll_bg1_x/y`, `map_width_px`, `map_height_px`, `$03CA`; w `$0382`, `$0384` |
| L002 | `code_010069` | 65641 / 162 | 4 sites / 1 file (`engine_000000`: main loop `loc_000032`, `code_000127`, `code_000173`, `code_0001BE`) | camera | `ScrollCameraByDelta` (A; code, cons L003) | `JSL`, `REP #$20` inside, X ignored | `scroll_bg1_x += $0382` clamped to `[0, map_width_px - $100]`, `scroll_bg1_y += $0384` clamped to `[0, map_height_px - $03CA]`; a 16-px line crossed ORs `$80` (x) or `$40` (y) into `$0396`; then `JSR code_0104E1` (A = `$20`, X = 4) if `$034E` is non-zero and `JSR code_01052F` (A = `$10`) if `$0350` is non-zero. The delta is not cleared here | A, X (P restored) | r `$0382`, `$0384`, `scroll_bg1_x/y`, `map_width_px`, `map_height_px`, `$03CA`, `$034E`, `$0350`; w `scroll_bg1_x/y`, `$0396` |
| L003 | `code_01010B` | 65803 / 88 | 4 sites / 1 file (`engine_000000`, the same four sub-frame loops as L002) | scroll streaming | `BuildScrollStrips` (A; code, cons L014) | `JSL`, **M = 1** (the extract shows `LDA #$1C80`, `STX $03,Y`, `CMP #$9003`: missing override, OQ-I008-1). Real code: `LDA #$80; TRB $0396; BEQ; LDX #0; JSR code_010163; LDA #$40; TRB $0396; BEQ; LDX #0; JSR code_0101C2; LDX $038E; STX $0382; LDX $0390; STX $0384; LDA #$20; TRB $0396; BEQ; LDX #4; LDA $0347; CMP #3; BCC; JSR code_010163; LDA #$10; TRB $0396; BEQ; LDX #4; LDA $0349; CMP #3; BCC; JSR code_0101C2; LDX #0; STX $0382; STX $0384; RTL` | strip buffers filled; `$0396` request bits cleared; `$0382/$0384 = 0` | A, X, Y, DP scratch of L004/L005 | rw `$0396`, `$0382`, `$0384`; r `$038E`, `$0390`, `$0347`, `$0349` |
| L004 | `code_010163` | 65891 / 95 | 2 sites / 1 file (`lib_01010B`; one site is hidden by the M mis-decode) | scroll streaming | `BuildColumnStrip` (A; code, cons L014) | `JSR`, X = layer (0, 4), `$0382` = x delta of that layer | if the delta is non-zero: `$16 = (scroll_x,X + (delta > 0 ? $100 : 0)) & $0FF0`, `$18 = scroll_y,X & $0F00`, parameters loaded (`$00 = $0354,X` VRAM base, `$02 = $0352,X` map base, `$04 = map_width_px,X`, `$06 = $036B,X << 8`, `$08 = (width_pages * height_pages + $0353,X) << 8`, `$0A = $035C,X`, `$29 = $035A,X`), then `JSR code_01032F` with X = `$0362,X`; returns M = 1 | A, X, Y, DP `$00-$0A`, `$16`, `$18`, `$29` | r `$0352..$0362`, `$036B`, `map_width_pages`, `map_height_pages`; w the column buffer |
| L005 | `code_0101C2` | 65986 / 76 | 2 sites / 1 file (`lib_01010B`; one hidden as L004) | scroll streaming | `BuildRowStrip` (A; code, cons L014) | `JSR`, X = layer, `$0384` = y delta | `$16 = scroll_x,X & $0F00`, `$18 = (scroll_y,X + (delta > 0 ? $100 : 0)) & $0FF0`, same parameters as L004 (no `$08`), `JSR code_0103AB` with X = `$0364,X`; returns M = 1 | A, X, Y, DP as L004 | as L004; w the row buffer |
| L006 | `code_01020E` | 66062 / 289 | 1 site / 1 file (`lib_027781_part3`, scene load) | scene load | `RedrawBackgroundsAtEntry` (B; code, caller; the force-blank assumption is not read) | `JSL`, M = 0 on entry (`REP #$20` first) | `scroll_bg1_x/y` = player position minus `($70, $90)` clamped as in L001; `$0392 = map_width_px >> 4`, `$0394 = map_height_px >> 4`; for each layer (X = 0, 4): `code_0104E1` and `code_01052F` with A = 0 (no request bits), scroll reduced modulo the layer's map size, then 32 iterations of (`code_01032F` into the column buffer, `code_01057D`, `$16 += $10` wrapped) that write the whole 64-tile width | A, X, Y, DP `$00-$0A`, `$16`, `$18`, `$29`, `$32`, `$35` | r `player_x/y`, `map_*`, `$03CA`, `$034A..$0368`; w `scroll_bg1_x/y`, `scroll_bg2_x/y` (through L012/L013), `$0392`, `$0394`, VRAM through `code_01057D` |

### 2.2 Strip builders and upload

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L007 | `code_01032F` | 66351 / 124 | 2 sites / 2 files (`lib_01010B`, `lib_01020E`) | scroll streaming | `FillColumnStripBuffer` (A; code, hw, cons L014) | `JSR`, X = buffer address in bank `$7E`, DP `$00` VRAM base, `$02` map base, `$04` width px, `$06` attribute OR, `$08` map end, `$0A` mask, `$16` x px, `$18` y px (bit 8 = page-row parity), `$29` definition table | header word at `[X]` = `$00 + ((x & $F0) >> 3 & $1E) + ((x >> 8 & 1) << 10)`, then page 1 (page index `$03 + (y >> 8) * width_pages + (x >> 8)`, metatile column `(x & $F0) >> 4`) and page 2 (next page row, wrapped at `$08` back by `$02`) through `code_010419`; the page at the even y page row goes to block 0 | A, X, Y (P, DBR restored) | r DP above; w the 258-byte buffer, `$7E` bank |
| L008 | `code_0103AB` | 66475 / 110 | 1 site / 1 file (`lib_01010B`) | scroll streaming | `FillRowStripBuffer` (A; code, hw, cons L014) | `JSR`, same DP as L007 | header word = `$00 + ((y & $F0) << 2) + ((y & $100) << 3)`, then two pages side by side (`+$100` per page, no wrap) through `code_010466`; the page at the even x page column goes first | A, X, Y (P, DBR restored) | as L007 |
| L009 | `code_010419` | 66585 / 77 | 4 sites / 1 file (`lib_shared_01032F`) | scroll streaming | `CopyMetatileColumn` (A; code, cons L007) | `JSR`, M = 0, X = buffer cursor, Y = WRAM page pointer, DBR = `$7E`, DP `$06`, `$0A`, `$29` | 16 metatiles downwards (`Y += $10` each): each id `* 8` indexes `($29)`; each definition word `w` is stored as `(w AND dp$0A) OR dp$06`: word 0 to `0,X`, word 1 to `$40,X`, word 2 to `2,X`, word 3 to `$42,X` (left tile column first, then the right one); `X += 4` per metatile; X and Y are restored | A, DP `$0E` | r `$7E` page, definitions; w 128 bytes at X |
| L010 | `code_010466` | 66662 / 73 | 4 sites / 1 file (`lib_01010B_part2`) | scroll streaming | `CopyMetatileRow` (A; code, cons L008) | as L009 | 16 metatiles to the right (`INY` each): words `0,X`, `2,X`, `$40,X`, `$42,X` for definition words 0-3 (top tile row, then bottom tile row); X and Y restored | A, DP `$0E` | as L009 |
| L011 | `code_0104AF` | 66735 / 50 | 2 sites / 1 file (`lib_shared_0104AF`) | parallax | `ScaleByRatio` (A; code, hw) | `JSR`, A = value (16-bit), Y = ratio word (low byte multiplier, high byte divisor) | A = `(value * low) / high` (16-bit): `M7A` written twice with A, `M7B` written twice with the low byte, `MPYL` word to `WRDIVL`, divisor `WRDIVB`, 8 `NOP`, quotient from `RDDIV`; the multiply is signed, so the multiplier must be below 128; a zero divisor gives `$FFFF` | none (P, Y restored) | hw `M7A`, `M7B`, `MPYL`, `WRDIVL`, `WRDIVB`, `RDDIVL/H` (the Mode 7 registers are shared with the title screen hook) |
| L012 | `code_0104E1` | 66785 / 78 | 2 sites / 2 files (`lib_010069`, `lib_01020E`) | parallax | `UpdateLayerScrollX` (A; code, cons L002) | `JSR`, M = 0, A = request mask (`$20`, or 0), X = layer | `scroll_bg1_x,X = scaled(scroll_bg1_x, $034A,X)` (clamped to `width - $100` when the layer is at least `$300` wide) `+ $038A`; if bit 4 of the position changed, `$0396 |= A`; `$038E = new - old` | A (popped), P and Y restored | r `scroll_bg1_x`, `$034A,X`, `map_width_px,X`, `$038A`; w `scroll_bg1_x,X`, `$0396`, `$038E` |
| L013 | `code_01052F` | 66863 / 78 | 2 sites / 2 files (`lib_010069`, `lib_01020E`) | parallax | `UpdateLayerScrollY` (A; code, cons L002) | as L012 with `$10` | same for y: ratio `$034C,X`, height `map_height_px,X` and `$03CA`, offset `$038C`, delta to `$0390` | as L012 | `$034C`, `$038C`, `$0390` instead |
| L014 | `code_01057D` | 66941 / 195 | 3 sites / 2 files (`engine_000000` x 2 in `code_0004C8`, `lib_01020E`) | scroll streaming | `UploadScrollStrips` (A; code, hw, caller) | `JSL`, `REP #$20`, `SEP #$10`, `[$32]` = column buffer, `[$35]` = row buffer (`$34 = $37 = $7E`) | for each buffer whose header is non-zero: four `code_010640` chunks (VMAIN `$81` for columns, `$80` for rows; addresses in 1.2), then the header is set to 0 | A, X (8-bit after `SEP #$10`; P restored), DMA ch2, `VMAIN`, `VMADD` | r both buffers; w `$2115`, `$2116`, `$4320-$4325`, `$420B`, buffer headers |
| L015 | `code_010640` | 67136 / 27 | 8 sites / 1 file (`lib_01020E_part2`) | scroll streaming | `DmaStripChunk` (A; code, hw) | `JSR`, X 8-bit, `$4322` (source offset) and `VMADD` set | one DMA: mode 1, `$2118`, bank `$7E`, 64 bytes, channel 2 | X | `$4320`, `$4321`, `$4324`, `$4325`, `$420B` |

### 2.3 Palette-style frame records (`Cop92`-`Cop95`)

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L016 | `code_01065B` | 67163 / 114 | 4 sites / 4 files (`cop_handler_006075`, `_00608E`, `_0060B1`, `_0060CD`) | animation | `NextFrameRecord` (B; code, caller, cons L017) | `JSL`, X = actor slot, `$1E,X` animation id, `$20,X` frame index, `$24,X` bank | carry clear: `$26 = hold - 1`, `$08 = source word`, `$0A = slot * 2` (+`$200` when the length code is 2), `$0C = length code`, `$14 = $0E = delay`, `$20 += 1`; carry set (and `$20 = 0`) when the record's first byte is 0 | A, Y (P, DBR restored) | r actor `$1E`, `$20`, `$24`, the record list; w actor `$08`, `$0A`, `$0C`, `$0E`, `$14`, `$20`, `$26` |
| L017 | `code_0106CD` | 67277 / 36 | 4 sites / 4 files (same four handlers) | animation | `CopyFrameData` (B; code, caller, hw) | `JSL`, **M = 0** (the extract decodes it with the wrong override `"67277": {"M":1}`: `AND #$00`, `SBC $007F09,X`, OQ-I008-2), X = actor slot | `$1C5E = $7F | ($24,X << 8)` (the `MVN` operands), then `JSR $1C5C`: copies `$0C,X + 1` bytes from `[$24,X]:$08,X` to `$7F:$0A,X`; `$08,X` advances by the amount copied | A, Y (P not saved; X, DBR restored) | r actor `$08`, `$0A`, `$0C`, `$23/$24`; w `$1C5E/$1C5F`, `$7F:0000-$7F:03FF` (`cgram_buffer`, `coldata_buffer`) |

### 2.4 Tile edits and map patches

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L018 | `code_0106F1` | 67313 / 187 | 2 sites / 2 files (`lib_0109D6`, `engine_0026F3`) | tile edit | `SetMetatileBg1` (A; code, cons) | `JSL`, M = 1 (`PHA`/`PLA` of one byte), A = metatile id, DP `$16` = x px, `$18` = y px (aligned) | `$7E8000[idx] = id`; `tile_type_map[idx]` = 4-bit mask from bit 1 of the high byte of each definition word (TL 1, TR 2, BL 4, BR 8); when `x + 16 - scroll_x < $111` and `y + 16 - scroll_y < $111`: `vram_write_queue` = four (address, word) pairs (TL, TL+1, +`$20`, +`$21`; words `(def & $035C) | $036A`) and `$1C8B = 0` (the queue is overwritten, not appended) | A (P, X restored) | w `$7E8000`, `tile_type_map`, `$1C7B-$1C8B`; r `scroll_bg1_x/y`, `$035C`, `$036A`, `$7E2000` |
| L019 | `code_0107AC` | 67500 / 271 | 2 sites / 2 files (`lib_0109D6`, `engine_0026F3`) | tile edit | `SetMetatileBg1Bg2` (A; code, cons) | as L018 | as L018, plus `$7EC000[idx] = id` and a second queue block at `$1C8B-$1C9A` for BG2 (address `- $6000 + $7000`, words `(def2 & $0360) | $036E` from `$7E2800`), terminator `$1C9B = 0`; the type map comes from the BG1 definitions only | A (P, X restored) | as L018 plus `$7EC000`, `$1C8B-$1C9B`, `$7E2800`, `$0360`, `$036E` |
| L020 | `code_0108BB` | 67771 / 283 | 1 site / 1 file (`engine_003005` `code_003194`) | map patch | `ApplyMapPatchRect` (A; code, caller, A2 X088) | `JSL`, M = 0, A = patch id (8-byte records of `unk14_017504`) | copies a `w x h` rectangle from the staging position (`+4`, `+6` words, px) to the live position (`+0`, `+1` bytes, tiles): BG1 id and type byte per cell, and for each cell inside the screen margin four queue entries (16 bytes) at `$1C7B + 16 * n`; ends with a 0 word | A, Y, DP `$00`, `$02`, `$0C`, `$0E`, `$16`, `$18` (X restored) | r `unk14_017504`; w `$7E8000`, `tile_type_map`, `vram_write_queue` |

### 2.5 Triggers

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L021 | `code_0109D6` | 68054 / 83 | 1 site / 1 file (`engine_000000` main loop) | triggers | `CheckPlayerTileTriggers` (A; code, caller, walk) | `JSL`, M = 1 (override `"68054": {"M":1}` is right) | order and condition in 1.4; any carry zeroes the player actor's `$04,X` and `$06,X` (velocity) | A, X, Y, DP `$16`, `$18`, scratch of the callees | r `player_x/y`, `$7E8000`, `$0458`; w player actor `$04`, `$06` |
| L022 | `code_010A29` | 68137 / 201 | 1 site / 1 file (`lib_0109D6`) | triggers | `TryOpenChest` (A; code, walk) | `JSL`, M = 1; the player faces direction code 0 (`binary_00FA7F[$1E]` through `code_0273D4`, carry set for animations `>= $2C`), stands on a row of `table_00A9DE` (list `$03AE`) and the BG1 id at `(player_x, player_y - $20)` is `$FB` | carry clear when nothing happens. Otherwise: bit `+2 & $7F` of `$1A7E` must be clear, then is set (`code_027348`); `BRK #$15`; the tile becomes `$FC` (`code_0107AC` when row `+2` bit 7 is set, else `code_0106F1`); 30 frames (`code_013140`); then by row `+3`: 0 = "Nothing inside" (`asciistring_016232`); `$FF` = Gems `+4` word added (BCD `code_0276A5`), `$0332 \|= $10`, `BRK #$8D`, message `asciistring_016246` (A8); else the item id is stored with `code_0120F9`, `$03C8 = id`, "X recieved Y" (`asciistring_016216`), `BRK #$9E`. Carry set when a message was shown | A, X, Y, DP `$16`, `$18` | r `player_tile_x/y`, `player_x/y`, `$03AE`, `table_00A9DE`, `$7E8000`, `$1A7E`; w `$1A7E`, `$7E8000/$7EC000`, `$03C8`, `$03C9`, `$1B66/$1B68`, `$0332`, inventory |
| L023 | `code_010AF2` | 68338 / 169 | 1 site / 1 file (`lib_0109D6`) | triggers | `CheckExitRegions` (A; code, cons) | `JSL`, M = 1, `$03B2` = offset into `table_00AC96` (0 = none) | carry set when the player is inside a row's box: tile test `player_tile - xy < wh` first, then an exact pixel test (`player_x - 16 * x < 16 * w - 15`, `player_y - 16 * (y + 1) < 16 * h - 15`); then `area_next = +4`, `scene_next = +5`, `warp_dest_anim = +6`, `warp_dest_x = word +7`, `warp_dest_y = word +9`; carry clear otherwise | A, X, Y, DP `$00-$06` (P restored) | r `player_tile_x/y`, `player_x/y`, `$03B2`, `table_00AC96`; w `area_next`, `scene_next`, `warp_dest_x/y/anim` |
| L024 | `code_010B9B` | 68507 / 138 | 1 site / 1 file (`lib_0109D6`) | triggers | `TriggerVariantPlate` (C; code; the purpose is inferred, OQ-I008-11) | `JSL`, M = 1, `$03AC` = offset of the current list in `table_00B69A` | carry clear: no row matches the player tile, or bit `id` of `$1A9E` is clear. Carry set: record `id` of `data_00BA0D` (8 bytes to `$1C6D-$1C74`), `$1C6E = $03A8 + 2`, `code_01112A`, sweep once on BG1 (`$1C75 = 1`, `$1C6C++`, 35 sub-frames, `$1C6C = 0`), `$03A8 ^= 1`, `$03AC` = the other list of this location (`table_00B69A[$03AA + 2 * $03A8]`) | A, X, Y | r `$03AC`, `$03AA`, `$03A8`, `table_00B69A`, `$1A9E`, `data_00BA0D`; w `$1C6C-$1C75`, `$03A8`, `$03AC`, rectangle in the BG1 map |
| L025 | `code_010C25` | 68645 / 408 | 1 site / 1 file (`lib_0109D6`) | lair release | `ReleaseLairAtSwitch` (A; code, walk, cons) | `JSL`, M = 1, X = BG1 map index of the switch tile | steps 1-5 of 1.5. Returns RTL after the sweeps, or after setting up the return trip | A, X, Y, DP `$00`, `$16`, `$18` | r `data_00BA0D`, `location_id`, `player_tile_x/y`, `$0456`; w `$7E8000`, `$7EC000`, `$7F0203`, `$1ADE`, `$1A9E`, `$1C6C-$1C75`, `$0456`, `return_*`, `warp_dest_*`, `area_next`, `scene_next`, `transition_type`, `$03B4`, `$0405`, `tile_type_map` |
| L026 | `code_010DBD` | 69053 / 236 | 1 site / 1 file (`lib_010EA9_part1`) | lair release | `RevealReleasedHome` (B; code, cons L025) | `JSL`, M = 1, X = 0 | searches `data_00BA0D` (until `+0 >= $80`) for `+0 = location_id`, home tile `(+2, +3)` = player tile; none: returns. Found: `$03C8 = +9`, message `asciistring_016203`, one `code_000173`, `lair_state[i] &= $BF`, record bytes 0-7 to `$1C6D-$1C74`, `BRK #$9C`; when `$1C73` is non-zero: repeat (`code_01112A`, `$1C75 = 1`, `$1C6C++`, 35 sub-frames, `$1C6C = 0`, `$1C6E++`) while `$1C6E < 4`; else one sub-frame; finally bits `i` in `$1A9E` and `$1ADE` are set. A loop of four additions to X (the home tile index across slabs) is computed and discarded (`dead`) | A, X, Y, DP `$00`, `$01`, `$16`, `$18` | r `data_00BA0D`, `$7F0203`; w `$7F0203`, `$03C8`, `$1C6C-$1C75`, `$1A9E`, `$1ADE`, `$7E8000` (through L031) |
| L027 | `code_010EA9` | 69289 / 65 | 1 site / 1 file (`engine_000000` `loc_0000AA`) | lair release | `RunReturnModeFrame` (B; code, caller) | `JSL`, M = 1 | `tile_type_map[(player_x, player_y - 16)] == 1`: `code_010DBD`. Else: `X = $0405 * 32`, `$03C8 = data_00BA0D[X + 9]`, text `asciistring_0161DE` | A, X, Y, DP `$16`, `$18` | r `player_x/y`, `tile_type_map`, `$0405`, `data_00BA0D`; w `$03C8`, `$03C9` |

### 2.6 Sweep redraw and rectangle copies

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L028 | `code_010EEA` | 69354 / 376 | 1 site / 1 file (`engine_000000` `code_000173`) | sweep | `StepSweepRedraw` (A; code, caller, cons L042) | `JSL`, M = 1 on entry; `$1C75` = step | `$1C75 == 0`: return. Else 16 cells of record `$1C75 - 1` redrawn into `vram_write_queue` (4 entries each, 0 terminator): BG1 when `$1C6C != 0` (L029, `$7E8000`, `$7E2000`), BG2 when 0 (L030, `$7EC000`, `$7E2800`); `$1C75++`, reset to 0 at 36 | A, X, Y, DP `$0C`, `$16`, `$18` (P restored) | r `scroll_bg1_x/y`, `$1C6C`, `$1C75`, `binary_016E2D`, maps, definitions; w `$1C75`, `$1C77`, `$1C79`, `vram_write_queue` |
| L029 | `code_011062` | 69730 / 100 | 1 site / 1 file (`lib_010EEA`) | sweep | `LookupBg1TileAndVramAddr` (A; code) | `JSR`, M = 0, DP `$16`, `$18` | A = VRAM word address (`$6000 + ...`), X = id `* 8` (offset into the definitions); same arithmetic as `code_0272B8` and `code_0272E6` in one routine | A, X (stack balanced) | r `map_width_pages`, `$7E8000` |
| L030 | `code_0110C6` | 69830 / 100 | 1 site / 1 file (`lib_010EEA`) | sweep | `LookupBg2TileAndVramAddr` (A; code) | as L029 | as L029 for BG2: map `$7EC000`, base `$7000` | A, X | r `$7EC000` |
| L031 | `code_01112A` | 69930 / 161 | 4 sites / 4 files (`lib_0109D6`, `lib_010EA9_part1`, `lib_0112F5`, `lib_011395`) | map patch | `CopyMapRectFromSlab` (A; code, cons) | `JSR`, `$1C71/$1C72` = rectangle x, y (tiles), `$1C73/$1C74` = width, height (each must be `< $80`: `CMP #$80; BCS self` is a hang guard), `$1C6E` = slab index | for each cell: BG1 id from slab `k` to the live map, `tile_type_map` live byte = `(live & $F0) \| slab byte`; row steps use `code_02731A`, `code_027331`; the BG2 map is not touched | A, X, `$0E`, `$10`, `$16`, `$18` (P restored) | r `$1C6E`, `$1C71-$1C74`, `map_width_pages`, `map_height_pages`; w `$1C64-$1C68`, `$7E8000`, `tile_type_map` |
| L032 | `code_0111CB` | 70091 / 147 | 4 sites / 3 files (`lib_0109D6` x 2, `lib_0112F5`, `lib_0133A6_part1`) | map patch | `CopyMapRectFromStaging` (A; code, cons) | `JSR`, `$16`/`$18` = staging position (px), `$1C71-$1C74` = live rectangle | copies BG1 id and the whole type byte from the staging position to the live rectangle; BG2 not touched | A, X, `$0E`, `$10`, `$16`, `$18` | r `$1C71-$1C74`; w `$1C62-$1C68`, `$7E8000`, `tile_type_map` |
| L033 | `code_01125E` | 70238 / 151 | 2 sites / 2 files (`lib_0109D6`, `lib_0112F5`) | map patch | `CopyMapRectFromStagingBothLayers` (A; code, cons) | as L032 | as L032 and the id is also stored in `$7EC000` | as L032 | as L032 plus `$7EC000` |

### 2.7 Inventory

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L034 | `code_0120F9` | 73977 / 63 | 3 sites / 3 files (`cop_handler_005874` Cop0A, `engine_000000`, `lib_0109D6`) | inventory | `StoreInventoryEntry` (A; existing block note, caller) | `JSL`, A (8-bit) = entry number | entries below `$19`: `inventory[n - 1] = n`; others: bit 7 of the old byte is kept, `n` ORed in, `$1B64 = value & $7F` when bit 7 is set, and `$043B = max_hp - hp` when the old value was `$38` | A, Y (P restored) | rw `inventory` (`$1B1E`), `$1B64`, `$043B`; r `player_hp`, `player_max_hp` |

### 2.8 Data

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | Content |
|---|-------|-----------|---------|-----------|-----------------------|---------|
| L035 | `word_01762C` | 95788 / 260 | 2 sites / 1 file (`lib_0109D6`: low and high byte of one entry) | warp | `LocationAreaScene` (A; code, cons) | 130 words indexed by `location_id`: low byte = area, high byte = scene (`$0100`, `$0101`, `$0201`, `$0301`, `$0401` for locations 0-4). `code_010C25` copies them to `area_next`/`scene_next` |
| L036 | `asciistring_list_0152E6` | 86758 / 106 | 2 (text `[TBL:]` in L038, L039) | text | `NpcNameStrings` (A; code, walk) | 53 pointers to the names of section 4.10, indexed by `$03C8` |
| L037 | 53 strings `asciistring_015350` ... `asciistring_015538` | 86864-87358 / 494 | 1 each (the list) | text | listed in 4.10 | the names |
| L038 | `asciistring_0161DE` | 90590 / 37 | 1 / 1 (`lib_010EA9_part1`) | text | `MsgNpcCannotBeRecalled` (B; code) | `[10][03:24][TBL:list_0152E6,03C8][03:20][N]cannot be recalled [N]yet! [JMP:asciistring_016246+M]` |
| L039 | `asciistring_016203` | 90627 / 19 | 1 / 1 (`lib_010EA9_part1`) | text | `MsgNpcReleased` (A; code, walk) | `[10][02:2] released [N][03:24][TBL:list_0152E6,03C8][03:20]-[JMP:...]` |
| L040 | `asciistring_016216` | 90646 / 28 | 1 / 1 (`lib_0109D6`) | text | `MsgChestReceived` (A; code) | `[10] [02:2] recieved[N] [03:24][TBL:list_014F74,03C8][03:20]-[JMP:...]` (the ROM spells `recieved`) |
| L041 | `asciistring_016232` | 90674 / 20 | 1 / 1 (`lib_0109D6`) | text | `MsgChestEmpty` (A; code) | `[10] Nothing inside-[JMP:...]` |
| L042 | `binary_016E2D` | 93741 / 1120 | 4 sites / 1 file (`lib_010EEA`) | sweep | `SweepStepTable` (A; code, cons L028) | 35 records of 32 bytes: 16 x offsets then 16 y offsets (section 4.8) |

## 3. Fan-in summary

| Routine | Sites | Files |
|---------|-------|-------|
| `code_01112A` (L031) | 4 | 4 (`lib_0109D6`, `lib_010EA9_part1`, `lib_0112F5`, `lib_011395`) |
| `code_0111CB` (L032) | 4 | 3 |
| `code_01065B`, `code_0106CD` (L016, L017) | 4 each | 4 handlers |
| `code_010069`, `code_01010B` (L002, L003) | 4 each | 1 (`engine_000000`) |
| `code_0120F9` (L034), `code_010000` (L001), `code_01057D` (L014) | 3 each | 3, 3, 2 |
| `code_0106F1`, `code_0107AC`, `code_01125E` | 2 each | 2 each |
| every other A4 routine | 1 | 1 (internal chains: `code_0109D6` calls five, `code_01010B` two, `code_01020E` four) |

No routine of this batch is unreferenced. `engine_000000` is the only external caller of the per-frame entry points (`code_010069`, `code_01010B`, `code_0109D6`, `code_010EA9`, `code_010EEA`, `code_01057D`); the tile edits are called from `engine_0026F3` (lairs), the patches from `engine_003005`.

## 4. Structures observed (consumer evidence only; widths are the access sizes seen)

### 4.1 Per-layer parameters (stride 4 from BG1 to BG2)

| BG1 / BG2 | Field | Width | Evidence |
|-----------|-------|-------|----------|
| `$033A`/`$033E`, `$033C`/`$0340` | scroll x, y | 2 + 2 | `code_0004AB`, L002, L012, L013 |
| `$0342`/`$0346`, `$0344`/`$0348` | map width, height in px (`pages * 256`; the high byte is the page count `$0343`/`$0347`, `$0345`/`$0349`) | 2 + 2 | L004, L006, L012 |
| `$034A`/`$034E`, `$034C`/`$0350` | parallax ratio x, y (low byte multiplier, high byte divisor) | 2 each | `lib_0133A6_part3` (`STA $034A,Y`, `STA $034B,Y`), L011 |
| `$0352`/`$0356` | map base (`$8000`, `$C000`) | 2 | `lib_027912` |
| `$0354`/`$0358` | tilemap VRAM word base (`$6000`, `$7000`) | 2 | `lib_027912`, `BG1SC`/`BG2SC` |
| `$035A`/`$035E` | definition table (`$2000`, `$2800`) | 2 | `lib_027912` |
| `$035C`/`$0360` | tile word AND mask | 2 | `lib_0133A6_part3` (`$FDFF`), L018 |
| `$0362`/`$0366`, `$0364`/`$0368` | column and row buffer addresses | 2 each | `lib_027912` |
| `$036A`/`$036E` (high bytes `$036B`/`$036F`) | tile word OR (attribute) | 2 | L018, L004 (`$036B,X << 8`) |

### 4.2 Strip buffer (258 bytes)

| Offset | Width | Content |
|--------|-------|---------|
| 0 | 2 | VRAM word address of the first tile; 0 = empty (read and cleared by L014) |
| 2 | 64 | block 0 |
| 66 | 64 | block 1 |
| 130 | 64 | block 2 |
| 194 | 64 | block 3 |

### 4.3 Chest row of `table_00A9DE` (6 bytes; the table is a pointer word per location, a list ends at a first byte `$FF`)

| Offset | Width | Content | Evidence |
|--------|-------|---------|----------|
| +0 | 1 | player tile x in front of the chest | `CMP $&table_00A9DE,X` with `player_tile_x` (M = 1) |
| +1 | 1 | player tile y | same with `player_tile_y` |
| +2 | 1 | bits 0-6: bit index in `$1A7E` (opened); bit 7: also write the BG2 map (`code_0107AC`) | `AND #$7F` (A.hi cleared with `XBA`), `BMI` |
| +3 | 1 | 0 = empty; `$FF` = Gems; other = inventory entry (also `$03C8`) | `BEQ`, `CMP #$FF` |
| +4 | 2 | Gems amount, BCD word (only when +3 is `$FF`) | `REP #$20; LDA +4,X; STA $03C8` |

Stride: `ADC #$0006`.

### 4.4 Exit row of `table_00AC96` (11 bytes; first byte `$FF` ends a list; a pointer word per location)

| Offset | Width | Content | Evidence |
|--------|-------|---------|----------|
| +0, +1 | 1 + 1 | x, y of the box in tiles | `SBC` with `player_tile_x/y` |
| +2, +3 | 1 + 1 | width, height in tiles | `CMP` after the subtraction |
| +4, +5 | 1 + 1 | `area_next`, `scene_next` | `STA` |
| +6 | 1 | `warp_dest_anim` | `STA` |
| +7 | 2 | `warp_dest_x` (px) | `LDY` with X 16-bit |
| +9 | 2 | `warp_dest_y` (px) | `LDY` |

Stride: `ADC #$000B`. The pixel box is `x * 16 .. x * 16 + w * 16 - 16` by `(y + 1) * 16 .. (y + 1) * 16 + h * 16 - 16`.

### 4.5 `table_00B69A` (variant plates)

`$03AA = location_id * 4` indexes two pointer words per location (`lib_011445`): the list for `$03A8 = 0` and for `$03A8 = 1`. A list row is 4 bytes: `+0` tile x, `+1` tile y, `+2` a word id (also the `data_00BA0D` record index: `id << 5`); a first byte `$FF` ends a list. `$03AC` holds the offset of the current list from the table label.

### 4.6 `data_00BA0D` record, fields read in A4 (32 bytes, `id << 5`; FM-A11 defines the whole struct)

| Offset | Width | Content (A4 reading) | Evidence |
|--------|-------|----------------------|----------|
| +0 | 1 | host location (compared with `location_id`); `$FF`/`>= $80` ends the table | L025, L026 |
| +1 | 1 | first variant slab (1-3), copied to `$1C6E` | L026, L031 |
| +2, +3 | 1 + 1 | home tile x, y (tiles; `* 16` for `warp_dest_x/y`) | L026, L025 |
| +4, +5 | 1 + 1 | live rectangle x, y (tiles) | L031, L032, `$1C71/$1C72` |
| +6, +7 | 1 + 1 | rectangle width, height (tiles, `< $80`) | L031 |
| +8 | 1 | layer flags: 0, 2, 3 seen. Non-zero also clears the switch tile in the BG2 map; bit 0 selects `code_01125E` | L025 |
| +9 | 1 | name index into `asciistring_list_0152E6` (0-52 seen) | L026, L027 |
| +A | 1 | low bits of `lair_state` (0-6 seen), ORed with `$80` or `$C0` | L025 |
| +B, +C, +D | 1 + 1 + 1 | switch location, tile x, tile y | L025 |
| +E, +F | 1 + 1 | staging rectangle position (tiles); both 0 = no rectangle | L025 |
| +1D | 1 | `warp_dest_anim` (0-3 seen) | L025 |
| +1E | 2 | gate switch word (A2, OQ-I007-13) | `engine_003005` |

Measured over the 420 rows of `extracted/system/data_00BA0D.asm`: `+1` is 0-3, `+6` up to 49, `+7` up to 30 (the `< $80` guard never trips), `+8` is 0, 2 or 3, `+9` up to 52, `+A` up to 6, `+1D` up to 3; 236 rows have a rectangle and 184 do not; 250 rows have `+0 = +B`.

### 4.7 Frame record (6 bytes, `code_01065B`)

| Offset | Width | Content |
|--------|-------|---------|
| +0 | 1 | hold count (0 ends the list); `$26 = value - 1` |
| +1 | 2 | source offset in bank `$24,X` (`$08,X`) |
| +3 | 1 | destination slot; `$0A,X = slot * 2` (`ASL`, `ADC #$0000`) |
| +4 | 1 | length code (`MVN` count; 2 adds `$200` to the destination) |
| +5 | 1 | delay stored in `$14,X` and `$0E,X` |

Example (bank `$0D`, animation `$2D`): `01 92 A0 70 11 08` (hold 1, source `$A092`, slot `$70`, 18 bytes, delay 8). The list pointer table is at `$8000` of the bank (`table_058000`: 44 pointers; `table_068000`: more).

### 4.8 `binary_016E2D` (35 x 32 bytes)

`+0 .. +15` = x offsets and `+16 .. +31` = y offsets, in metatiles from `(scroll_x & $FFF0, scroll_y & $FFF0)`. Records 0, 2, 4 ... are columns (`x = 7, 8, 6, 9, 5, 10, 4, 11, 3, 12, 2, 13, 1, 14, 0, 15, 16`, `y = 0 .. 15`), records 1, 3, 5 ... are rows (`y` the same sequence, `x = 0 .. 15`), record 33 is row 16, record 34 is `x = 1 .. 16, y = 16`.

### 4.9 Buffers written by A4 outside the structs above

| Address | Content |
|---------|---------|
| `$1C7B`... | `vram_write_queue`: entries of (address word, data word) in groups of four (16 bytes) with a 0 word terminator; L018 `$1C7B-$1C8B`, L019 `$1C7B-$1C9B`, L020/L028 `$1C7B + 16 * n` |
| `$1C62-$1C68` | rectangle copy cursors (staging `$1C62`, `$1C64`; live `$1C66`, `$1C68`) |
| `$1C6D-$1C74` | record bytes 0-7 of the active release (`$1C6E` variant, `$1C71-$1C74` rectangle) |
| `$1C75`, `$1C6C`, `$1C77`, `$1C79` | sweep step, layer, origin x, y |

### 4.10 `asciistring_list_0152E6` (53 names, index = `$03C8` = `data_00BA0D+9`)

Each row: index, label (offset = label hex), offset / size, text as extracted. The extractor prints some glyphs as other characters (OQ-I008-15): apostrophes as a space, `.` as `-`.

| Index | Label | Offset / size | Text |
|-------|-------|---------------|------|
| 0x00 | `asciistring_015350` | 86864 / 9 | an old man |
| 0x01 | `asciistring_015359` | 86873 / 11 | an old woman |
| 0x02 | `asciistring_015364` | 86884 / 5 | a boy |
| 0x03 | `asciistring_015369` | 86889 / 5 | Lisa |
| 0x04 | `asciistring_01536E` | 86894 / 8 | The village Chief |
| 0x05 | `asciistring_015376` | 86902 / 14 | The bridge guard |
| 0x06 | `asciistring_015384` | 86916 / 11 | an architect |
| 0x07 | `asciistring_01538F` | 86927 / 21 | tool shop owner s son |
| 0x08 | `asciistring_0153A4` | 86948 / 16 | tool shop owner |
| 0x09 | `asciistring_0153B4` | 86964 / 6 | a goat |
| 0x0A | `asciistring_0153BA` | 86970 / 13 | a lonely goat |
| 0x0B | `asciistring_0153C7` | 86983 / 6 | tulip |
| 0x0C | `asciistring_0153CD` | 86989 / 4 | ivy |
| 0x0D | `asciistring_0153D1` | 86993 / 19 | The water mill keeper |
| 0x0E | `asciistring_0153E4` | 87012 / 10 | a squirrel |
| 0x0F | `asciistring_0153EE` | 87022 / 6 | a deer |
| 0x10 | `asciistring_0153F4` | 87028 / 11 | a crocodile |
| 0x11 | `asciistring_0153FF` | 87039 / 14 | a dog, "Turbo" |
| 0x12 | `asciistring_01540D` | 87053 / 15 | Wood s guardian |
| 0x13 | `asciistring_01541C` | 87068 / 6 | a mole |
| 0x14 | `asciistring_015422` | 87074 / 5 | none |
| 0x15 | `asciistring_015427` | 87079 / 8 | The village Chief |
| 0x16 | `asciistring_01542F` | 87087 / 6 | a bird |
| 0x17 | `asciistring_015435` | 87093 / 5 | a dog |
| 0x18 | `asciistring_01543A` | 87098 / 9 | a mermaid |
| 0x19 | `asciistring_015443` | 87107 / 9 | a dolphin |
| 0x1A | `asciistring_01544C` | 87116 / 11 | an angelfish |
| 0x1B | `asciistring_015457` | 87127 / 7 | the Queen |
| 0x1C | `asciistring_01545E` | 87134 / 14 | the dolphin, Lue |
| 0x1D | `asciistring_01546C` | 87148 / 17 | a mermaid s statue |
| 0x1E | `asciistring_01547D` | 87165 / 5 | a boy |
| 0x1F | `asciistring_015482` | 87170 / 6 | a girl |
| 0x20 | `asciistring_015488` | 87176 / 8 | Grandpa |
| 0x21 | `asciistring_015490` | 87184 / 8 | Grandma |
| 0x22 | `asciistring_015498` | 87192 / 7 | a snail |
| 0x23 | `asciistring_01549F` | 87199 / 6 | the King |
| 0x24 | `asciistring_0154A5` | 87205 / 10 | a mushroom |
| 0x25 | `asciistring_0154AF` | 87215 / 13 | the snail, Nome |
| 0x26 | `asciistring_0154BC` | 87228 / 6 | steps |
| 0x27 | `asciistring_0154C2` | 87234 / 12 | a great door |
| 0x28 | `asciistring_0154CE` | 87246 / 5 | a cat |
| 0x29 | `asciistring_0154D3` | 87251 / 7 | a plant |
| 0x2A | `asciistring_0154DA` | 87258 / 7 | a mouse |
| 0x2B | `asciistring_0154E1` | 87265 / 16 | a chest of drawers |
| 0x2C | `asciistring_0154F1` | 87281 / 6 | a doll |
| 0x2D | `asciistring_0154F7` | 87287 / 13 | the doll, Marie |
| 0x2E | `asciistring_015504` | 87300 / 13 | a model of town |
| 0x2F | `asciistring_015511` | 87313 / 9 | a soldier |
| 0x30 | `asciistring_01551A` | 87322 / 6 | a maid |
| 0x31 | `asciistring_015520` | 87328 / 8 | a singer |
| 0x32 | `asciistring_015528` | 87336 / 9 | King Magridd |
| 0x33 | `asciistring_015531` | 87345 / 7 | Dr-Leo |
| 0x34 | `asciistring_015538` | 87352 / 6 | Queen |

The walkthrough agrees with Lisa, the village chief, the bridge guard, the tool shop owner, the water mill keeper, Turbo the dog, Lue the dolphin, Nome the snail, Marie the doll, the chest of drawers, King Magridd and the Queen. Mismatches are in OQ-I008-14.

## 5. WRAM touched by A4 without a mnemonic (proposals only, nothing applied)

| Address | Meaning | Proposed name | Conf | Evidence |
|---------|---------|---------------|------|----------|
| `$0382`, `$0384` | camera delta x, y (target minus scroll; consumed by strips) | `scroll_delta_x`, `scroll_delta_y` | A | L001, L002, L003 |
| `$0390`, `$038E` | BG2 delta y, x written by the parallax routines | `scroll_delta_bg2_y`, `scroll_delta_bg2_x` | A | L012, L013, L003 |
| `$038A`, `$038C` | scripted scroll offset x, y added to the parallax result (changed by `w5_actor_026F44/57/48/53`, `w6_actor_01F063`, cleared by `lib_027781_part3`) | `scroll_offset_x`, `scroll_offset_y` | B | L012, L013, OQ-I008-9 |
| `$0392`, `$0394` | map width, height in metatiles (`px >> 4`) | `map_width_tiles`, `map_height_tiles` | C | L006 only writes them (OQ-I008-7) |
| `$0396` | strip request bits (`$80`, `$40`, `$20`, `$10`) | `strip_requests` | A | L002, L003, L012, L013 |
| `$034A`, `$034C`, `$034E`, `$0350` | parallax ratios | `ratio_bg1_x`, `ratio_bg1_y`, `ratio_bg2_x`, `ratio_bg2_y` | A | 1.2 |
| `$0352`, `$0356`, `$0354`, `$0358` | map base, tilemap VRAM base per layer | `map_base_bg1/2`, `tilemap_vram_bg1/2` | A | `lib_027912` |
| `$035A`, `$035E`, `$035C`, `$0360` | definition table, tile AND mask | `metatile_defs_bg1/2`, `tile_mask_bg1/2` | A | L004, L018 |
| `$0362`-`$0368` | strip buffer addresses (col BG1, row BG1, col BG2, row BG2) | `strip_buf_col_bg1`, ... | A | `lib_027912`, `code_0004C8` |
| `$036A`, `$036E` | tile attribute OR | `tile_attr_bg1`, `tile_attr_bg2` | A | L018, L019 |
| `$03CA` | visible height in px (clamp for the y scroll) | `view_height_px` | B | L001, L002 |
| `$03A8`, `$03AA`, `$03AC` | plate state (0/1), `location_id * 4`, current plate list offset | `plate_state`, `plate_ptr_index`, `plate_list_ofs` | B | L024 |
| `$03AE`, `$03B2` | chest list, exit list offsets of the location | `chest_list_ofs`, `exit_list_ofs` | A | L022, L023, `lib_0114D0`, `lib_0114E4` |
| `$03B4` | set to `$20` when a lair sends the player to the host location | `warp_timer` (identity unknown) | C | L025 (OQ-I008-12) |
| `$03C8`, `$03C9` | text argument (item id, NPC name index or BCD Gems; high byte cleared) | `text_arg` | A | L022, L026, L027, the strings |
| `$0332` | bit `$10` is set after a Gems chest | (identity unknown) | C | L022 (OQ-I008-13) |
| `$0405` | record index of the lair that started the return trip | `return_record` | B | L025, L027, OQ-I007-8 |
| `$0456`, `$0458` | lair counter (decremented by L025), boss lock (read in L021) | `lair_count`, `boss_lock` | B | L025, L021, OQ-I007-10 |
| `$1A7E` | opened-chest bits (index = row `+2 & $7F`) | `chest_bits` | A | L022 |
| `$1A9E`, `$1ADE` | switch arrays (bit = `data_00BA0D` index) | `switch_bits_a`, `switch_bits_b` (FM-A2) | B | L024-L026 |
| `$1B66`, `$1B68` | Gems (FM-A2) | `gems_low`, `gems_high` | A | L022 |
| `$1C5C`-`$1C61` | RAM `MVN` stub (`PHB`, `MVN dst,src`, `PLB`, `RTS`) | `mvn_stub` | A | `lib_027912`, L017 |
| `$1C62`-`$1C68` | rectangle copy cursors | `rect_staging_idx`, `rect_live_idx` | B | L031-L033 |
| `$1C6C` | sweep layer (0 = BG2, 1 = BG1) | `sweep_layer` | A | L028, L025 |
| `$1C6D`-`$1C74` | active record bytes 0-7 | `rect_rec` | A | L025, L026, L031 |
| `$1C75` | sweep step (0 = idle) | `sweep_step` | A | L028 |
| `$1C77`, `$1C79` | sweep origin x, y | `sweep_origin_x`, `sweep_origin_y` | B | L028 |
| `$7E2000`, `$7E2800` | metatile definitions BG1, BG2 | `metatile_defs_bg1/2` | A | 1.1 |
| `$7E3000`-`$7E3407` | four strip buffers | `strip_buffers` | A | 4.2 |
| `$7E8000`, `$7EC000` | metatile id maps BG1, BG2 (A2's "lair tile buffer" `$7E8000` is the BG1 map) | `metatile_map_bg1/2` | A | 1.1 |
| `$7F0203` | `lair_state[i]` (bit 7 released, bit 6 return pending) | (FM-A2 `lair_state`) | B | L025, L026 |
| DP `$32`-`$37` | column and row buffer pointers (`$34 = $37 = $7E`) | - | A | `lib_027912`, L014 |

## 6. Findings for later batches

- **Decode anomalies (override file).** `code_01010B` (65803) needs `"65803": {"M":1}`; the extract is nonsense (`LDA #$1C80`, `STX $03,Y`, `CMP #$9003`, `REP #$81`) and hides one call to `code_010163` and one to `code_0101C2`. The existing `"67277": {"M":1}` is wrong for `code_0106CD`: it needs M = 0 (the bytes `BD 23 00 29 00 FF 09 7F 00 8D 5E 1C` are `LDA $0023,X; AND #$FF00; ORA #$007F; STA $1C5E`). Neither is applied here (no db edits in this step); both are PB candidates and the rebuild must keep the SHA-1 (OQ-I008-1, -2).
- **False reference.** `lib_01065B` prints `$&meta_tables_008000` for `LDA $8000,Y` under `DBR = $24,X`. The read is in the actor's animation bank (`table_058000`, `table_068000`, ...), so the `?INCLUDE 'meta_tables_008000'` of `lib_01065B` and of the four `cop_handler_*` files and the fan-in of `meta_tables_008000` are artefacts (OQ-I008-3). The `meta_tables_008000+N,Y` reads in `engine_003005` and `lib_0118FC` are different (field offsets of a meta entry).
- **OQ-I007-24 is answered in part**: `code_01065B` writes `$08`, `$0A`, `$0C`, `$0E`, `$14`, `$20`, `$26` per animation step as source, destination, length, delay and counters of a frame record; FM-A1 section 4.1 lists `$08-$0E` as extents, which is wrong for actors that run `Cop92`-`Cop95`.
- **A2's OQ-I006-23 (`$7E8000` buffer in which `$FD` marks an intact lair) is answered**: it is the BG1 metatile id map; `$FD`, `$FE`, `$FF`, `$FB`, `$FC` are ordinary ids.
- **A2 X088** copies from `unk14_017504` through `code_0108BB`: the records are 8 bytes (`x`, `y`, `w`, `h` bytes, source x and y words), not 14 (the extractor's `unk14` is a type tag).
- **Names in the data:** `data_00BA0D` is also the table of plate records (L024 copies a record by id), so FM-A11 should treat it as "release/patch records", not only lair records.
- **Batch gap.** The plan's ranges (A4 `0100-0111`, A5 `0118`, A6 `0124-0127`) leave the library files `0112-0116` (`lib_0112F5`, `lib_011395`, `lib_0114D0`, `lib_0114E4`, `lib_011695`, `lib_0116C3`), `0122-0123` (`lib_012281`, `lib_01232B`, `lib_shared_01230B`, `lib_shared_012390`) and `0131-0132` (`lib_01318C`, `lib_shared_0131B7`, `lib_shared_0131D1`, `lib_0131FE`, `lib_01320E`, `lib_013246`) without a batch. Several of them are callers or callees of A4 (`lib_0112F5`, `lib_011395`, `lib_0114D0`, `lib_0114E4` set the three trigger lists and call L031-L033; `lib_shared_0131D1` is the multiplier). They were read here only as far as needed for the models.
- **Dead or suspicious code:** the discarded slab-step loop in `code_010DBD`; the `CMP #$80; BCS self` hang guards (L031-L033) never trip for the current table; `code_010163`/`code_0101C2` rely on `code_0104E1`/`code_01052F` (or BG1 ratios) being non-zero (OQ-I008-6).
- **Placement proposals for PB:** `code_0120F9` (inventory) belongs with `engine_0064F8` (flags and inventory) rather than in `lib_0109D6_part3`; `asciistring_016216`/`016232` sit next to `lib_shared_016246` and `lib_shared_014F74`; `word_01762C` next to the trigger tables.
- **Suggested names for PC with their risks:** the 34 routine names above are descriptive; L024 (`TriggerVariantPlate`) and L026/L027 (`RevealReleasedHome`, `RunReturnModeFrame`) rest on inferred purpose and should wait for the Mesen2 rows OQ-I008-11 and -12. The text strings should keep their mechanical names until the extractor's glyph mapping is settled (OQ-I008-15).
