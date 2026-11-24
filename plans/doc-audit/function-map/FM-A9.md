# FM-A9: library `0270`-`0279` (save system, scene change and transitions, scene init, map index helpers, bit arrays, player stats)

PA batch A9, iteration I013. Read-only analysis: no names, notes, comments, `blocks.json`, `overrides.json` or docs were changed. Every proposed name below is a proposal for step PC (`npm run names`); every unverified claim is an `OQ-I013-k` row in `plans/extracted-audit/questions/I013_questions.md`. (A4 owns I008, A5 I009, A6 I010, A7 I011, A8 I012; A9 takes I013.)

Source: a fresh `npm run extract:lt`. Twenty-five files were read end to end; offsets are decimal file offsets (the `{n}` tag; LoROM: bank = `offset >> 15`, address = `$bank:(8000 + (offset & 7FFF))`). Every file is `?BANK 04`, so the label suffix is the hex file offset and the address is `$04:xxxx` (for example `code_0270E4` is at `$04:70E4`, `code_0279B5` at `$04:79B5`). The 25 files are one contiguous run of `$04:70E4`-`$04:7AD2` (offsets 159972-162515, 2543 bytes, no gap, no overlap with `us/blocks.json`): 35 routine rows (34 labels plus the sub-label `loc_02787C`, which has a caller outside its routine), 1 data row and the five tables the code reads. The three-part names `lib_027462` (`part1`, `part2`, base), `lib_027781` (`part1` at `$0273F9`, `part2` at `$0276EE`, `part3` at `$0279B5`) are legacy names: neither group is one subsystem (see section 7).

| File | Offsets | Labels | Content |
|------|---------|--------|---------|
| `lib_0270E4`, `lib_027132`, `lib_shared_02716E` | 159972-160159 | 3 | save to SRAM, load from SRAM, slot checksum |
| `lib_02719F` | 160159-160291 | 1 | three decompressions into `$7F` buffers at boot |
| `lib_027223` | 160291-160352 | 1 + 4-word table | animated BG tile strip request |
| `lib_shared_027260` | 160352-160375 | 1 | reset the actor sort buckets |
| `lib_027277` | 160375-160440 | 1 (dead) | sine wave tables for a wobble effect |
| `lib_027462_part1`, `lib_0272E6`, `lib_027462_part2` | 160440-160584 | 4 | pixel to map index, pixel to BG1 VRAM address, step east, step south |
| `lib_027348`, `lib_027374`, `lib_0273A2` | 160584-160724 | 3 | set, clear (dead), test a bit in a bit array |
| `lib_0273D4`, `lib_0273EB`, `lib_027781_part1` | 160724-160866 | 3 | player facing, flip X, player pose for the equipped weapon |
| `lib_027462` | 160866-161138 | 1 | is the player standing on metatile id A |
| `lib_027572` | 161138-161261 | 2 | pause banner and its frame wait |
| `lib_0275ED`, `lib_027614`, `lib_0276A5`, `lib_0276C9` | 161261-161518 | 6 | pending heal, pending EXP, add EXP, add and subtract Gems |
| `lib_027781_part2` | 161518-162066 | 8 (+1 sub-label row) | BG3 clear, switch owner clear, tile type map, scene change, fade out and in, iris |
| `lib_027912` | 162066-162229 | 1 | new game and boot state |
| `lib_027781_part3` | 162229-162515 | 1 | scene initialisation |

Counts: 35 routine rows (L001-L035), 1 data row (D01), 4 tables read from other blocks (section 3.2), the 97-row location table (section 3.3), 8 structure layouts (section 4) and 14 open questions. Two routines have no caller (L007, L013). No file of this batch is touched by the line-tracking gap: all `{n}` tags agree with the sizes of `us/blocks.json` (the sum of the row sizes is 2543 bytes).

Context read for the callee and caller models: `engine_000000` (boot 110-136, main loop, `code_000127` sub-frame loader, `code_0005C4` sort lines 846-1000, NMI strip DMA `code_000543`, `code_0004C8`), `engine_006B7F` (title, file select `code_006CD0`, slot menu `code_006D4E`), `common_actor_00766C` (the save actor), `common_actor_0066C6` (boot actor), `cop_handler_005E6C` (`Cop3C_SetMode03E3`), `lib_shared_0131D1` and `lib_shared_0131B7` and `lib_01318C` and `lib_0118FC_part8` (multiply, vblank wait, force blank, `code_0131A2`), `lib_013246` (random numbers), `lib_0133A6_part3` (loader), `lib_0109D6` (return trip, gems), `lib_0112F5`, `lib_011395`, `lib_0114D0`, `lib_0114E4` (called by L035, no FM owns them: A4 section 7 batch gap), `system/asset_list_028000`, `system/data_048000`, `system/data_00F9F7`, `system/data_00BA0D`, `lib_017504`, `lib_01020E_part2`, `lib_0106CD` (RAM stub caller), `us/structs.json` (`unk8`, `unk14`, `unk17`), `us/mnemonics.json`, `us/config.json` (`ramSize 3`), `docs/wram-memory-map.md`, `docs/walkthrough/` and FM-A1 to FM-A7.

## 0. Reading the tables

| Column | Meaning |
|--------|---------|
| Off / size | decimal file offset and size in bytes (distance to the next label; the sub-label row splits the size of the label it sits in) |
| Callers | reference count and files, from `rg` over `extracted/` (definition lines excluded) |
| Name (conf, evidence) | proposed `VerbNoun` name for code, noun for data. Confidence: **A** behaviour fully read and independently corroborated (consumer, doc, walkthrough, hardware); **B** behaviour fully read, purpose inferred from code only; **C** guessed or dead code. Evidence labels: `code`, `callee`, `caller`, `cons`, `walk`, `doc`, `hw`, `dead` |
| In / Out | registers, DP and WRAM inputs and results. M/X widths are those at entry unless stated. D is 0 |
| Clobbers | registers and scratch that are not restored |
| Data touched | WRAM names from `us/mnemonics.json` where one exists, otherwise the raw address (proposals in section 5). `r` read, `w` write |

DP scratch is written `dp$nn`. A "bit number" is the 10-bit index used by L012-L014 (byte `n >> 3`, bit `n & 7`, bit 0 = least significant). "Live size" is the page size of the map the game scrolls over (`unk14_017504` table, section 3.3); "header size" is the width and height read from the tilemap stream header.

## 1. Models that several rows share

### 1.1 Where the code runs

Boot (`engine_000000` lines 123-132): `code_0139AC` (hardware reset, A7 L025), `code_013ADA` (default PPU layout, A7 L026), **L034** (state that never changes again), **L026** (BG3 buffer cleared), `scene_next = $000C` (area 0, scene `$0C`, the boot scene: location `$12`, answering OQ-I005-21), `code_0131A2` (NMI on), **L030**. The main loop (lines 133-160) is `code_0131B7` (wait for vblank), **L030** (a scene change when `scene_next` is set), then for `location_id - $10 >= 3` the chain `code_0118FC` (menus, A5), **L019** (pause), `code_0131AE` (NMI off), the work phase, `code_012659` (HUD, A5, which calls **L021** and **L022**), and **L005** (animated tile strip) just before `code_0131A2`. The sub-frame loader `code_000127` (R02, A1) runs the same work phase once and also calls L005, and every wait in L031-L033 is a call of `code_000127` (one vblank each).

### 1.2 Save system (L001-L003, section 4.1)

SRAM is `$70:0000-$1FFF` (8 KB; `us/config.json` has `ramSize 3`). It holds **four slots of `$400` bytes** at `$70:slot*$400` and a **mirror** of each at `+$1000`; the last played slot number is the word `$70:1FFE`, which sits in the last two bytes of slot 3's mirror (the mirror copy is `$3FE` bytes, so it never overwrites them). A slot is the byte image of `lair_state` (`$7F:0203`, `$200` bytes) followed by the persistent WRAM `$1A5E-$1C57` (`$1FA` bytes: event flags, switches, inventory, Gems, EXP, level, HP, name) and two checksum words. L003 computes the checksum from the slot in `$03A4`: both words start at `$3652`; for each of the first `$1FD` words (bytes `$000-$3F9`) the first adds the word (the sum modulo `$10000`) and the second XORs it. L001 stores `world_index + 1` into `$1B90` first (so the image carries the arrival scene), copies the two blocks, stores the sum at `+$3FA` and the XOR at `+$3FC`, then copies `$3FE` bytes to the mirror and writes `$03A4` to `$70:1FFE`. L002 recomputes the checksum and, only when both words match, copies the two blocks back and returns carry clear; any mismatch returns carry set and changes nothing. L002 never looks at the mirror: the slot menu (`engine_006B7F.code_006D4E`, FM-A2 X107) has already copied the mirror over the main copy when the main checksum failed, and the main copy over the mirror when it passed. "Erase" (X106) writes the word `slot << 8` into the first word of both copies, which breaks the checksum in all but a contrived case (OQ-I013-10). The only writer is the actor `common_actor_00766C` (one `JSL` in L001's caller list), which the walkthrough describes as the save point in the Master's shrine ("use the save point ... to reach the Master ... heal and save"); the file is continued in the shrine of the saved world (`$1B90 = world_index + 1` is a scene number of area 0: Up Above scene N is the shrine of world N, §8c of the mapping plan).

### 1.3 Scene change and transitions (L030-L033)

L030 runs once per main-loop pass and returns at once when `scene_next` is 0. Otherwise, when a scene is already running (`scene_active != 0`) it plays the **out** transition with `$03E5 = $1E` and `$03E7 = $FF` (the iris parameters, used by types with bit 7 only). Then: `scene_active = 0`; `dp$42 = 0` (HDMA shadow, A1); `code_01318C` (A7: force blank, NMI off); `scene_current = scene_next`, `area_current = area_next`, `scene_next = 0`; **L035** (scene init, 1.4); one `code_000127` sub-frame; `code_0131A2` (NMI on); `$03E5 = 0`, `$03E7 = 1`; the **in** transition; `scene_active += 1`; `transition_type = 0`; `$0462 = 0`; one more sub-frame. The type is chosen **before** the change and is used for both halves, then reset to 0 (a default fade).

| `transition_type` | Out (L031) | In (L032) | Frames out / in | Selected by |
|-------------------|------------|-----------|-----------------|-------------|
| 0 | fade: `INIDISP` `$0F` down to 0, one sub-frame per step | fade: 0 up to `$0F`, one sub-frame per step | 16 / 16 | default after every change |
| 1 | fade | instant: one sub-frame, then `INIDISP = $0F` | 16 / 1 | none found |
| 2 | instant: one sub-frame, `INIDISP = 0` | fade | 1 / 16 | none found |
| 3, 7 | instant | instant | 1 / 1 | none found |
| 4 | mosaic fade: `$0F` down to 0, two sub-frames per step, `MOSAIC = ((b xor $0F) << 4) or 3` (pixel size 1 growing to 16) | the same upwards | 32 / 32 | `COP [3C] ( #04 )`: 23 uses in 20 files (`Cop3C_SetTransitionType`, A3 H040) |
| 5 | mosaic fade | instant | 32 / 1 | none found |
| 6 | instant | mosaic fade | 1 / 32 | none found |
| 8-`$7F` | as 0 | as 0 | 16 / 16 | none found |
| `$80` | iris: BG3 tile 0 redefined, frames `$1E` down to 0, two sub-frames per step | iris: frames 0 up to `$1F`, two sub-frames per step | 62 / 64 | `engine_000000` line 203 (return trip, A1 `loc_0000DD`) and `lib_0109D6` line 566 (lair release, A4 1.5) |
| `$81`-`$FF` | iris with a frame offset that reads past the 512-byte frame table into `unk17_048800` | the same | undefined | none found |

The **iris** (type `$80`, L033) uses BG3 as a screen-wide mask: out, it sets `$0462 = 1` (which makes `code_000127` skip `code_012659` and `code_011695`, so the HUD does not draw into BG3), fills `bg3_tilemap_buffer` with `$2000` (tile 0, priority) through L026 and sets bit 0 of `vram_upload_flags`; in, it only sets `INIDISP = $0F`. Each step writes one 16-byte frame of `binary_048000` into VRAM word `$4000` (tile 0 of the BG3 character base, `BG34NBA = 4`): eight rows of (plane 0, plane 1), plane 1 always 0, so the pixels are colour 1 or transparent; frame 0 is solid, frame `$1F` is empty, and the opaque area shrinks towards the tile corners. The frame offset is `((2 * transition_type + bit 4 of frame) << 8) or ((frame and $0F) << 4)`: the bit 4 comes from the carry of the last `ASL` of `$03E5 << 4` and the table has 32 frames of 16 bytes. For type `$80` the term `2 * $80` wraps to 0 in 8 bits, giving `frame * 16`.

### 1.4 Scene initialisation (L035) and what follows

Order of L035 (screen is force-blanked, NMI off): zero the player position, `joy_pressed`, `joy_block_mask`, a block of unnamed words (`$0382`, `$0384`, `$03D4`, `$03D6`, `$03D8`, `$038A`, `$038C`, `$0433` twice, `$0458`, `$0464`, `$0468`); `$039E`, `$03A0`, `$039A` = `$06AA` (no weapon actor, no second slot, no boss); `event_flags` byte 0 = 0 (**event flags `$00`-`$07` are scene-local**), `$042D`, `$0439` (no-combat flag), `BG12NBA`, `vram_upload_flags`, `W12SEL`, `$03C3`, `W34SEL`, `WOBJSEL`, `MOSAIC` = 0; `COLDATA = $E0` and its three shadow bytes = 0; the first CGRAM buffer colour = 0; **the loader** `code_0133A6` (A7 L008); a one-shot `$0454` (set when a file was chosen): `code_012463` and `code_01249C` reload the menu background graphics and the equipped magic graphics (FM-A5 L054, L055) and clear the flag; **L028** (tile type map, 1.5, using the header sizes still in `map_width_pages`/`map_height_pages`); **the live sizes** from `unk14_017504` (`+$28` and `+$29` at index `location_id * 2`) stored into `map_width_pages` (`$0343`, the high byte of `map_width_px`) and `map_height_pages` (`$0345`); `code_0012AF` (actor pool), `code_0012DE` (scene actors), `code_011395`, `code_0112F5`, `code_01157E` (A7 L001, lair states), `code_011445`, `code_0114D0`, `code_0114E4`, `code_0115F1` (A7 L002, flag patches), **L026** (BG3 buffer), **L027**, two `code_0005A6` (run actors twice, A1 R25), **L017** (player pose), `code_01020E` (A4 L006, background redraw) unless `location_id = $10` (the Mode 7 scene), then `vram_upload_flags |= 1`, `$031E = 0`, `$03B4 = 0`, `rng_state+1` (`$0302-$0303`) = `frame_counter` (the only seed the generator ever gets besides the frame timing), `joy_release_latch = $FFFF` (every button must be released before it counts), `frame_counter = $FFFF`, `WH0 = 0`, `WH1 = $FF`, **L006**, and `$0332 = $1F` (full HUD redraw) unless event flag `$FA` (bit 2 of `$1A7D`) is set.

`$1A7D` is byte 31 of the event flag array (`$1A5E + $1F`), so its bits are event flags `$F8`-`$FF`. L034 sets the whole word to `$0080`: **event flag `$FF` is set by a new game** and stays set (A7 OQ-I011-13: 13 `unk13` patch rows use flag `$00FF`, so they are applied unconditionally from the first scene on).

### 1.5 Map index helpers and the tile type map (L008-L011, L028-L029)

The map is a grid of 256-byte pages of 16 x 16 metatiles (FM-A4 1.1). L008 turns a pixel position into the byte index shared by the BG1 id map (`$7E:8000`) and `tile_type_map` (`$7F:8000`): `((live_width_pages * (y >> 8) + (x >> 8)) << 8) + (y and $FF) + ((x >> 4) and $0F)`, or 0 when the index is `>= $4000`. The multiply is the hardware multiplier through `code_0131D1`, whose second operand arrives in the **high byte of A**: L008 loads `map_width_pages` in 8-bit mode while B still holds `dp$19` (`y >> 8`, left there by the earlier 16-bit `LDA $18`). `y and $FF` is not masked to a multiple of 16 (FM-A3, OQ-I007-7). L010 moves one metatile east (`+1`, or `+$F1` from column 15 into the next page) and L011 one metatile south (`+$10`, or into the next page row by adding `map_width_px` when the low byte wraps). The index math works only with the **live** width, so the pages of variant slabs and staging areas (stored after the live pages in the stream) have indices at or above `live_width * live_height * $100`.

The tile type map is built once per scene by L028 and L029. L029 phase 1 fills a 256-entry mask table at `$0200-$02FF` (it indexes `$0200 + id` through the pointer `dp$29/$2A` with `$2A = 2`, so DBR must be `$01`): for metatile id `i` it reads the four definition words of `$7E:2000 + i * 8` (the BG1 definitions) and takes **bit 1 of each high byte** (tile number bit 9); the result byte is `TL + 2 * TR + 4 * BL + 8 * BR` (each 0 or 1). Phase 2 copies `mask[map id]` into `tile_type_map` for every metatile byte, **one byte per metatile** (`X` is the source and destination index at once). L028 supplies the count `header_width * header_height * $100` from the **loader's header dimensions** (before they are trimmed to the live size): the map is built for the live pages **and** the slab and staging pages after them, so a later map patch can copy type bytes along with ids (A4 L031-L032). The page `$0200-$02FF` is therefore temporary and is zeroed again by L006 at the end of L035.

### 1.6 Pause, pending HP and EXP, Gems (L019-L025)

L019 is the pause. A rising edge of Start (`$0323 and $10`, high byte of `joy_pressed`) while the latch `$03A2` is 0 sets the latch, sends `APUIO0 = $F2` (pause the music, OQ-I013-6), and **unless A is held** (`JOY1L` bit 7) prints the location banner (`asciistring_014536`, name from the 128-entry list indexed by `$1C6A`) and, outside no-combat scenes (`$0439 = 0`), the number of monster lairs left (`$0456` converted by `code_013215` to BCD at `$1B80`, printed by `asciistring_014547`), then waits in two loops (until Start is released, then until it is pressed again; each wait is L020, which also subtracts 1 from `frame_counter` so the frozen game keeps its clock), erases the banner (`asciistring_01456A`), sends `APUIO0 = $01` (resume) and waits one vblank. This matches the walkthrough: the number of monster lairs of the area "can be found by pressing the Start Button".

L021 drains `$043B` (set by Cop37 to the missing HP, A3 H032): every 4th frame one unit becomes **+1 HP** (`BRK #$48`, OQ-I013-5), stopping and zeroing when HP reaches `player_max_hp`; it sets HUD dirty bit `$04`. L022 drains `$043D` (set by Cop38, A3 H033; a BCD word): every 8th frame it removes **one unit of the lowest non-zero decimal digit** (`$0001`, `$0010`, `$0100` or `$1000`), adds the same unit to EXP through L023, plays `BRK #$48` and sets HUD dirty bit `$02`; the number of steps is therefore the digit sum of the pending amount. L023 adds a BCD word to the 8-digit EXP (`$1B78` low word, `$1B7A` high word) and caps at `$9999 9999`: the walkthrough says EXP "maxes at 99,999,999 ... a four-byte stat located at `0x7E1B78`", which agrees with the code, including the decimal digits. L024 adds to Gems (`$1B66` low word, `$1B68` high word, only its low byte used) and caps at `$0099 9999` (999,999: the walkthrough gives no cap, OQ-I013-8); L025 subtracts a BCD cost and reports "not enough" in carry without changing anything (used by `Cop26_PayGemsOrJump`; the walkthrough says "gems are used" for magic and "do not use MP"). L023-L025 all end with `CLD`.

### 1.7 Bit arrays (L012-L014)

The three helpers take a bit number `n` in A (bits 10 and up are ignored: `n and $3FF`) and an array base in Y (an address in DBR's bank, so a WRAM offset) and use the byte at `Y + (n >> 3)` and the mask `binary_00FA77[n and 7]` (`01 02 04 08 10 20 40 80`). The arrays used by the callers: three 64-byte arrays at `$1A5E` (event flags), `$1A9E` and `$1ADE` (the base `Y` loaded by the callers: `lib_0133A6_part1`, `lib_0109D6`, `lib_011395`, `cop_handler_005E0D`, `engine_003005`); the `unk13` patch rows (A7 4.3) store the 10-bit number in the word `+1`/`+2`. Only the test and the set are used; the clear (L013) has no caller.

### 1.8 The `$0100-$02FF` page (L004, L006, L029)

`$0100-$01FF` is the Quintet LZ ring of the decompressor (A7 L005) and `$0100-$02FF` plus `$0300` is the sort bucket array of `code_0005C4` (A1 R27): 256 word list heads indexed by an even key (`$0100 + key`, key up to `$1FE`) and the end marker `$FFFF` at `$0300` that stops the second phase of the sort (`BMI` on the popped word). The sort leaves the heads zeroed (its `PHA`/`PLA` trick), so the page is "all zero, then `$FFFF`" at rest. Every decompression overwrites the first half, so **L006 restores the invariant** at the end of L035 and of L004. This answers OQ-I011-8: the ring page is the bucket page; it is safe because nothing keeps live bucket data across a load, and the stack is at `$1FFF` (`TCS` at reset).

## 2. Code rows

| ID | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|----|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L001 | `code_0270E4` | 159972 / 78 | 1 site / 1 file (`common_actor_00766C`) | save | `SaveGameToSlot` (A; code, caller, cons L002, walk) | `JSL`; `$03A4` = slot 0-3, `$03BA` = world index (a word, `$03BB` must be 0) | slot `slot * $400` filled (1.2), checksum words at `+$3FA`, `+$3FC`, mirror at `+$1000`, `$70:1FFE` = slot, `$1B90 = world_index + 1` | A, Y, dp`$0C`, `$16`, `$18` (L003); X, B, P restored | r `$03A4`, `$03BA`, `lair_state`, `$1A5E-$1C57`; w `$1B90`, `$70:0000-$1FFF` |
| L002 | `code_027132` | 160050 / 60 | 1 site / 1 file (`engine_006B7F`, `code_006CD0`) | save | `LoadGameFromSlot` (A; code, caller, cons L001) | `JSL`; `$03A4` = slot | carry clear: `lair_state` and `$1A5E-$1C57` replaced from the main copy; carry set: bad checksum, nothing changed | A, Y, dp`$0C`, `$16`, `$18`; X, B, P restored | r `$03A4`, `$70:slot*$400`; w `lair_state`, `$1A5E-$1C57` |
| L003 | `code_02716E` | 160110 / 49 | 4 sites / 3 files (`engine_006B7F` x 2, L001, L002) | save | `ComputeSlotChecksum` (A; code, callee, cons) | `JSL`; `$03A4` = slot | dp`$16` = `$3652 + sum of the first $1FD words`, dp`$18` = `$3652 xor each of those words` | A; dp`$0C` (loop count), `$16`, `$18`; X, Y, P restored | r `$03A4`, `$70:slot*$400` |
| L004 | `code_02719F` | 160159 / 132 | 1 site / 1 file (`common_actor_0066C6`, boot actor) | boot | `LoadBootGraphicsBuffers` (B; code, caller, cons) | `JSL`; no VRAM access, so any NMI state | `graphics_054000` (16 KB) at `$7F:3000`, `graphics_05C000` (8 KB) at `$7F:1000`, `graphics_04D000` (8 KB) at `$7F:C000`, each expanded to `$7E:8000` and moved with `MVN #$7F,#$7E`; L006 | A, X, Y, dp`$23-$2B`, `$7E:0100-$01FF` and `$7E:8000-$BFFF`; P restored | w `$7F:1000`, `$7F:3000`, `$7F:C000` |
| L005 | `code_027223` | 160291 / 53 | 5 sites / 1 file (`engine_000000`: main loop, `loc_0000AA`, `code_000127`, two more) | animated BG | `QueueAnimatedTileStrip` (B; code, cons NMI `code_000543`, hw) | `JSL`; M any; `frame_counter`, `location_id` | unless `location_id - $0F < 4`: `vram_strip_src = $1000 + (frame_counter and $1F) * $80`, `vram_strip_dest = D01[frame_counter and 3]`, `vram_strip_pending += 1`; the NMI copies `$40` bytes from `$7F:src` to VRAM word dest and the next `$40` bytes to dest `+ $100` | A, X (P restored) | r `frame_counter`, `location_id`, D01; w `vram_strip_src`, `vram_strip_dest`, `vram_strip_pending` |
| L006 | `code_027260` | 160352 / 23 | 2 sites / 2 files (L004, L035) | scheduler | `ResetSortBuckets` (A; code, cons A1 R27) | `JSL`; M any (PHP, REP) | `$0100-$02FF` = 0 and `$0300` = `$FFFF` | A, X; P restored | w `$0100-$0301` |
| L007 | `code_027277` | 160375 / 65 | 0 | effect | `FillSineWaveTables` (C; code, hw, dead) | `JSL`; M any (SEP); `$03CD` non-zero = request, `$03CC` amplitude (one byte, 0-255; `M7A` high byte written 0), `$03CE` phase step | clears `$03CD`; 256 words `amplitude * sin(phase) >> 8` (the `MPYM`/`MPYH` pair) stored twice, to `$7E:7900` and `$7E:7B00`; phase starts at 0 and advances by `$03CE` per word | A, Y; X and P restored | r `$03CC-$03CE`, `binary_00FC84` (256-byte signed sine, A11 `data_00F9F7`); w `$7E:7900-$7AFF`, `$7E:7B00-$7CFF`, `M7A`, `M7B` |
| L008 | `code_0272B8` | 160440 / 46 | 40 sites / 23 files (`lib_shared_01112A` 5, `lib_027462` 4, `common_actor_001A28_part1` 4, `lib_0109D6` 3; 2 each in `lib_0109D6_part1`, `lib_010EA9_part1`, `lib_0108BB`, `cop_handler_0059F4_part2`, `engine_0065A7`; 14 files with 1) | map | `PixelToMapIndex` (A; code, caller x40, cons A3, A4) | `JSL`; M = 16; dp`$16` x px, dp`$18` y px | X = index of 1.5, or 0 when `>= $4000`; M = 16 | A, X (the result), flags | r `map_width_pages`, hardware multiplier |
| L009 | `code_0272E6` | 160486 / 52 | 3 sites / 2 files (`lib_0109D6_part1` x 2, `lib_0108BB`) | map | `PixelToBg1VramAddr` (A; code, hw, cons A4 L029) | `JSL` (no `PHP`; ends with `RTL`); M = 16; dp`$16` x, dp`$18` y | A = `$6000 + ((y and $F8) << 2) + ((x and $F8) >> 3) + ((x and $100) << 2) + ((y and $100) << 3)`: the BG1 tilemap word of the 8x8 tile in a 64 x 64 tile map | A | none |
| L010 | `code_02731A` | 160538 / 23 | 13 sites / 6 files (`lib_shared_01112A` 5, `lib_027462` 3, `common_actor_001A28_part1` 2, `cop_handler_0059F4_part2`, `engine_0065A7`, `lib_0108BB`) | map | `StepMapIndexEast` (A; code, cons) | `JSL`; X = map index | X + 1, or X + `$F1` when `X and $0F = $0F` (next page); M restored | A (`TXA`); P restored | none |
| L011 | `code_027331` | 160561 / 23 | 10 sites / 4 files (`lib_shared_01112A` 5, `lib_027462` 2, `common_actor_001A28_part1` 2, `lib_0108BB`) | map | `StepMapIndexSouth` (A; code, cons) | `JSL`; X = map index | X + `$10` on the low byte; when that wraps, X + `map_width_px` (the next page row) | A; P restored | r `map_width_px` |
| L012 | `code_027348` | 160584 / 44 | 7 sites / 3 files (`lib_0109D6` 3, `lib_010EA9_part1` 2, `engine_003005` 2) | bit array | `SetBitInArray` (A; code, callee, caller) | `JSL`; A = bit number, Y = array address | byte `Y + (A >> 3)` or'ed with `binary_00FA77[A and 7]` | none (A, X, Y, P restored) | r `binary_00FA77`; w `[Y + n/8]` |
| L013 | `code_027374` | 160628 / 46 | 0 | bit array | `ClearBitInArray` (C; code, dead) | as L012 | the same bit cleared | none | as L012 |
| L014 | `code_0273A2` | 160674 / 50 | 11 sites / 7 files (`lib_0133A6_part1` 2, `lib_011395` 2, `lib_0109D6` 2, `cop_handler_005E0D` 2, `lib_0114E4`, `cop_handler_0059CC`, `engine_003005`) | bit array | `TestBitInArray` (A; code, caller) | as L012 | carry set when the bit is set, clear otherwise | none | r `binary_00FA77`, `[Y + n/8]` |
| L015 | `code_0273D4` | 160724 / 23 | 2 sites / 2 files (`lib_0118FC` talk, `lib_0109D6`) | player | `GetPlayerFacing` (A; code, cons A5 1.7) | `JSL`; M = 8, X 16-bit; `player_actor` | carry clear and A = `binary_00FA7F[$1E of the player actor]` (0 up, 1 down, 2 right, 3 left per A5 OQ-I009-7); carry set when the animation id is `>= $2C` (the word is read, so `$1F` must be 0) | A, X, Y; P restored apart from carry | r `player_actor`, actor `$1E`, `binary_00FA7F` (44 bytes) |
| L016 | `code_0273EB` | 160747 / 14 | 1 site / 1 file (`lib_0118FC`, NPC turn, A5 L017) | actor | `FlipActorX` (A; code, cons A5) | `JSL`; X = actor | actor `$1C` bit `$4000` (flip X) toggled | A; P restored | w actor `$1C` |
| L017 | `code_0273F9` | 160761 / 105 | 2 sites / 2 files (`lib_0118FC` after the equipment menu, L035) | player | `ApplyPlayerWeaponPose` (B; code, caller, cons A5) | `JSL`; M = 8, X 16-bit | skipped when `location_id - $0F < 4`. Unarmed (`$0439 != 0` or `$1B5E = 0`): player `$24 = $0A`, `$1E = binary_00FA7F[$1E] xor 1`, `$20 = 0`, `code_0008F3`, weapon actor `$039E`: `$16 or $2000` (hidden). Armed: `$24 = $0B`, `$20 = 0`, `code_0008F3`, `$039E`: `$16 and $DFFF` | A, Y; X and P restored | r `location_id`, `$0439`, `$1B5E`, `player_actor`, `$039E`, `binary_00FA7F`; w player `$1E`, `$20`, `$24`, weapon `$16` |
| L018 | `code_027462` | 160866 / 272 | 5 sites / 4 files (`w2_actor_0FA5BF`, `w5_actor_026F30`, `w1_actor_01E98D`, `w4_actor_023F17` x 2) | tile test | `IsPlayerOnMetatile` (A; code, caller) | `JSL`; M = 16, X 16-bit; A = BG1 metatile id; `player_x`, `player_y` | carry set when any of the 1 to 4 metatiles at the player's row (`y - 16`) holds id A (1 when both x and y are multiples of 16, 2 when one is not, 4 when neither; the 2 x 2 block is walked with L010, L011, L010); carry clear when none does, or at once when the player's `$16` has `$0C00` (hit stun or dying) | A, dp`$00` (the id), `$16`, `$18`; X restored; P not saved (M = 16 kept) | r `player_x`, `player_y`, `player_actor`, actor `$16`, `$7E:8000` |
| L019 | `code_027572` | 161138 / 106 | 1 site / 1 file (`engine_000000` main loop) | pause | `HandlePauseBanner` (A; code, walk, hw) | `JSL` once per frame; M = 8, X 16-bit | 1.6; returns after the second Start press or at once | A, X, Y | r `$0323`, `$03A2`, `$0439`, `$0456`, `$1C6A`, `JOY1L`; w `$03A2`, `APUIO0`, `$1B80-$1B81`, `vram_upload_flags`, BG3 text via `code_012769` |
| L020 | `code_0275DC` | 161244 / 17 | 2 sites / 1 file (L019 x 2) | pause | `WaitFrameForStart` (B; code) | `JSR`; M = 8 | `frame_counter` decremented, one vblank waited, Z clear while Start is down | A, X | w `frame_counter`; r `$0323` |
| L021 | `code_0275ED` | 161261 / 39 | 1 site / 1 file (`lib_0118FC_part6`, A5 L056) | player stats | `DrainPendingHeal` (A; code, cons Cop37) | `JSL`; M = 8 | 1.6 | A | r/w `$043B`, `player_hp`; r `player_max_hp`, `frame_counter`; w `$0332` |
| L022 | `code_027614` | 161300 / 115 | 1 site / 1 file (`lib_0118FC_part6`) | player stats | `DrainPendingExp` (A; code, cons Cop38, walk) | `JSL`; M = 8 | 1.6 | A; decimal flag cleared; M = 8 on return | r/w `$043D` (word); r `frame_counter`; w `player_exp` (L023), `$0332` |
| L023 | `code_027687` | 161415 / 30 | 3 sites / 2 files (L022, `engine_000000` x 2) | player stats | `AddExp` (A; code, walk, cons) | `JSL`; M = 16; A = BCD amount | `player_exp` (`$1B78`) plus A with the carry into `$1B7A`; on overflow both words `$9999`; `CLD` on return | A | r/w `$1B78`, `$1B7A` |
| L024 | `code_0276A5` | 161445 / 36 | 3 sites / 3 files (`cop_handler_005B65` (Cop25, no table entry, A3 H029), `lib_0109D6`, `engine_002EC0`) | player stats | `AddGems` (A; code, callee, cons A3) | `JSL`; M = 16; A = BCD amount | `$1B66` plus A with the carry into `$1B68`; `$1B68 >= $009A` caps both at `$9999` and `$0099`; `CLD` | A | r/w `$1B66`, `$1B68` |
| L025 | `code_0276C9` | 161481 / 37 | 1 site / 1 file (`cop_handler_005B79`, `Cop26_PayGemsOrJump`) | player stats | `SubtractGems` (A; code, caller, walk) | `JSL`; M = 16; A = BCD cost | carry clear: Gems reduced; carry set: not enough, unchanged; `CLD` | A, dp`$00`, `$02`, `$04` | r/w `$1B66`, `$1B68` |
| L026 | `code_0276EE` | 161518 / 24 | 25 sites / 5 files (`common_actor_0066FC` 15, `common_actor_00729D` 7, `engine_000000`, L033, L035) | BG3 | `ClearBg3Buffer` (A; code, caller x25) | `JSL`; any M | `bg3_tilemap_buffer` (`$7F:7000`, `$1000` bytes) filled with `$2000`; the upload flag is the caller's job | A; X and P restored | w `bg3_tilemap_buffer` |
| L027 | `code_027706` | 161542 / 29 | 1 site / 1 file (L035) | scene init | `ClearSwitchOwnersOnReturn` (B; code, cons A4 1.5) | `JSL`; M = 8, X 16-bit | when `return_active != 0`: `switch_owner_table` (`$7F:0483`, `$400` bytes) zeroed; DBR restored | A, X; M = 8 | r `return_active`; w `switch_owner_table` |
| L028 | `code_027723` | 161571 / 26 | 1 site / 1 file (L035) | map | `BuildTileTypeMap` (A; code, cons A3, A4) | `JSL`; M = 8, X 16-bit; `map_width_pages`, `map_height_pages` = the loader's header sizes | Y = `width * height * $100` metatiles (0: nothing done); calls L029 with X = `$8000` | A, X, Y, dp`$0C`, `$0E`, `$29`, `$2A` (set to 2) | r `map_width_pages`, `map_height_pages` |
| L029 | `code_02773D` | 161597 / 68 | 1 site / 1 file (L028, `JSR`) | map | `FillTileTypeMap` (A; code, cons) | `JSR`; M = 8, X 16-bit; X = `$8000`, Y = count, `dp$2A = 2`, DBR = `$01` | 1.5: mask table at `$0200`, then `tile_type_map[i] = mask[id]` | A, X, Y, dp`$0C`, `$0E`, `$29` | r `$7E:2000-$27FF`, `$7E:8000...`; w `$0200-$02FF`, `tile_type_map` |
| L030 | `code_027781` | 161665 / 84 | 2 sites / 1 file (`engine_000000`: boot, main loop) | scene change | `ChangeSceneIfRequested` (A; code, caller, cons A1, A7) | `JSL`; M = 8; `scene_next`, `area_next`, `scene_active`, `transition_type` | 1.3 | A, X, Y (nothing is saved or restored) | r/w `scene_next`, `area_next`, `scene_current`, `area_current`, `scene_active`, `transition_type`, `$03E5`, `$03E7`, `$0462`, dp`$42` |
| L031 | `code_0277D5` | 161749 / 82 | 1 site / 1 file (L030, `JSR`) | scene change | `PlayTransitionOut` (A; code, hw) | `JSR`; M = 8 | 1.3 (out); the negative types `BRL` into L033 | A | w `INIDISP`, `MOSAIC` |
| L032 | `code_027827` | 161831 / 85 | 1 site / 1 file (L030, `JSR`) | scene change | `PlayTransitionIn` (A; code, hw) | `JSR`; M = 8 | 1.3 (in); the negative types `BMI` into L033 | A | w `INIDISP`, `MOSAIC` |
| L033 | `loc_02787C` (sub-label of L032, own label in PC) | 161916 / 150 | 2 refs / 1 file (`BMI` in L032, `BRL` in L031) | scene change | `RunIrisTransition` (A; code, hw) | entered by branch from L031 or L032; `$03E7` = `$FF` (out) or 1 (in), `$03E5` = first frame | the iris of 1.3; falls out through the `RTS` at `loc_027911` (the `RTS` returns to L030) | A, X, Y | w `VMADDL`, `VMDATAL`, `INIDISP`, `$0462`, `vram_upload_flags`, `$03E5`; r `binary_048000` |
| L034 | `code_027912` | 162066 / 163 | 1 site / 1 file (`engine_000000` boot) | boot | `InitFixedState` (A; code, caller, cons A4 4.1) | `JSL` from reset; M = 8, X 16-bit | layer parameters (A4 4.1): `$0352 = $8000`, `$0356 = $C000`, `$0354 = $6000`, `$0358 = $7000`, `$035A = $2000`, `$035E = $2800`, `$0362 = $3000`, `$0364 = $3102`, `$0366 = $3204`, `$0368 = $3306`; dp`$34`, `$37`, `$2E` = `$7E` (the bank bytes of the strip pointers `dp$32`, `dp$35` and the loader's copy pointer); RAM stub `$1C5C` = `PHB, MVN, PLB, RTS` (bytes `8B 54 -- -- AB 60`, operands filled by callers, e.g. `lib_0106CD` `JSR $1C5C`); `$1B84 = 3`; `$1A02 = $3000`, `$1A04 = $7F`; word `$1A7D = $0080` (event flag `$FF`); `player_hp = player_max_hp = 8`; `player_level = player_level_bcd = 1`; `lair_state[i]` = byte `+$13` of every `data_00BA0D` record (record size `$20`, ends at a first byte `$FF`; 420 records) | A, X, Y | w the addresses listed, `lair_state`; r `data_00BA0D` |
| L035 | `code_0279B5` | 162229 / 286 | 1 site / 1 file (L030) | scene init | `InitSceneState` (A; code, caller, cons A7) | `JSL`; M = 8, X 16-bit; screen force-blanked, NMI off; `area_current`, `scene_current` set | 1.4 | A, X, Y, dp scratch of its callees | see 1.4 |

D01 is in section 3.1.

Notes on rows:

- **L001 and L002 are not symmetric**: L001 stores the image `$1A5E-$1C57` (`$1FA` bytes) after `lair_state`; the slot name sits at slot offset `$334` (`$1B92`, 1.2 and 4.1), where FM-A2 X107 reads it. The checksum covers the image and the lair block but not itself; the mirror copy includes the checksum words (`$3FE` bytes).
- **L005** has no loop guard: it overwrites the destination every call; calling it five times in a frame changes nothing.
- **L008** does not care about M on return (it ends with `REP #$20; PLX`): callers rely on M = 16.
- **L018** never saves P (no `PHP`): M = 16 is both an input and an output.
- **L023** clears the decimal flag with `CLD` even when the caller had it set (all callers run with D clear).
- **L033** is reached by a `BRL` from L031, so L031 and L032 and L033 must stay in one block in this order (section 7).

## 3. Data rows

### 3.1 Data owned by this batch

| ID | Label | Off / size | Callers | Name (conf, evidence) | Content |
|----|-------|-----------|---------|-----------------------|---------|
| D01 | `word_027258` | 160344 / 8 | 1 (L005) | `AnimatedStripVramDests` (A; code, cons L005, hw) | 4 words `$2060`, `$2080`, `$20A0`, `$20C0`: VRAM word destinations, `$20` words apart = 2 tiles of 4bpp (16 words each). With the second DMA at `+$100` (one tile row of 16 tiles), each strip is a 2 x 2 tile (16 x 16 pixel) block at tiles `$206`/`$208`/`$20A`/`$20C` and `$216`/`$218`/`$21A`/`$21C` |

### 3.2 Tables read by this batch (owned elsewhere)

| Table | Size | Read by | Layout seen here |
|-------|------|---------|------------------|
| `binary_00FA77` (`data_00F9F7`) | 8 bytes | L012, L013, L014 | `01 02 04 08 10 20 40 80`, indexed by `n and 7` |
| `binary_00FA7F` (`data_00F9F7`) | `$2C` = 44 bytes | L015, L017 | byte per player animation id (`$00-$2B`): facing code 0-3 (A5) |
| `binary_00FC84` (`data_00F9F7`) | 256 bytes | L007 | start of a **single 256-entry signed sine** (`00 03 06 ... 7F`, then the label `binary_00FCC4` continues it: `7F ... 00 FC ... 81 ... 00`); `binary_00FCC4` is the same wave + 64 (the cosine, FM-A2 X102) |
| `binary_048000` (`data_048000`) | 512 bytes | L033 | 32 iris frames of 16 bytes (4.5) |
| `unk14_017504` (`lib_017504`) | 296 bytes | L035 | 5 eight-byte map patch records (A4) then 128 pairs (width, height) from byte `$28` (3.3, 4.4) |
| `data_00BA0D` (`system`) | 420 records of 32 bytes | L034 | byte `+$13` (4.7); the rest is FM-A4 4.6 and the A11 struct |
| `graphics_054000`, `graphics_05C000`, `graphics_04D000` | LZ blocks | L004 | read at `+2` (skipping the 2-byte length) |

### 3.3 Location table: live size against header size (`unk14_017504 + $28`)

For every profile id (`location_id`, A7 3.3) the table gives the **live** map size in pages (width, height); L035 stores it over the sizes the loader read. The right column is the header of the BG1 tilemap stream (`tilemap < #01 ...>` of the scene's asset record; `-` = no BG1 tilemap in the record, or reached through a jump segment). Of the 85 records with a direct BG1 tilemap, 31 are equal and 54 have a larger header (`header pages - live pages` is 0: 31 scenes, 1: 3, 2: 13, 3: 10, 4: 9, 6: 2, 8: 5, 9: 3, 12: 3, 27: 2, 48: 4); none is smaller. Nine headers are exactly four times the live height (`4x4` to `4x16`, `3x3` to `3x12`, `2x2` to `2x8`: the live map plus three variant slabs), one differs in width (`03/02`: `4x1` against `5x1`; a single row, so the extra page is still just after the live pages), and the others have 1-9 extra pages (staging areas of the map patches, FM-A4 1.5). The extra pages sit **after the live pages in the stream**, which is why L008 can use the live width and still address them.

| id: scene live / header | id: scene live / header | id: scene live / header | id: scene live / header |
|---|---|---|---|
| `00`: 00/01 1x1 / 1x1 | `01`: 01/01 4x4 / 4x16 | `02`: 01/02 1x1 / 1x1 | `03`: 01/03 1x1 / 1x1 |
| `04`: 01/04 1x1 / 1x1 | `05`: 02/01 5x4 / 5x4 | `06`: 02/02 4x4 / 4x4 | `07`: 03/01 1x4 / 1x4 |
| `08`: 03/02 4x1 / 5x1 | `09`: 03/03 2x2 / 2x2 | `0A`: 03/04 1x1 / 1x1 | `0B`: 03/05 1x4 / 1x5 |
| `0C`: 03/06 1x1 / 1x1 | `0D`: 00/08 1x1 / 1x1 | `0E`: 02/03 4x4 / 4x4 | `0F`: 00/09 2x2 / 2x3 |
| `10`: 00/0A 1x1 / - | `11`: 00/0B 2x1 / 2x1 | `12`: 00/0C 1x1 / - | `13`: 00/0D 4x4 / - |
| `14`: 00/02 1x1 / - | `15`: 04/01 3x3 / 3x12 | `16`: 04/02 2x2 / 2x2 | `17`: 04/03 1x1 / 1x1 |
| `18`: 04/04 1x1 / 1x1 | `19`: 05/01 2x6 / 2x7 | `1A`: 05/02 2x2 / 2x3 | `1B`: 05/03 3x3 / 3x4 |
| `1C`: 05/04 4x4 / 4x5 | `1D`: 05/05 2x2 / 2x3 | `1E`: 05/06 3x3 / 3x4 | `1F`: 05/07 4x4 / 4x4 |
| `20`: 05/08 3x3 / 3x4 | `21`: 05/09 4x4 / 4x4 | `22`: 05/0A 2x1 / 2x1 | `23`: 04/05 2x2 / 2x2 |
| `24`: 04/06 3x3 / 3x12 | `28`: 00/03 1x1 / - | `29`: 06/01 4x4 / 4x16 | `2A`: 07/01 8x3 / 8x4 |
| `2B`: 07/02 1x2 / 1x3 | `2C`: 07/03 2x1 / 2x1 | `2D`: 07/04 8x4 / 8x4 | `2E`: 08/01 4x4 / 4x6 |
| `2F`: 08/02 3x3 / 3x6 | `30`: 08/03 4x4 / 4x5 | `31`: 08/04 4x4 / 4x6 | `32`: 09/01 1x5 / 1x5 |
| `33`: 09/02 1x5 / - | `34`: 07/05 8x4 / 8x4 | `3C`: 00/04 1x1 / - | `3D`: 0A/01 4x4 / 4x16 |
| `3E`: 0B/01 3x4 / 3x5 | `3F`: 0B/02 3x3 / 3x4 | `40`: 0B/03 3x3 / 3x4 | `41`: 0B/04 3x4 / 3x6 |
| `42`: 0B/05 3x4 / 3x7 | `43`: 0B/06 3x4 / 3x7 | `44`: 0B/07 2x1 / 2x1 | `45`: 0C/01 3x3 / 3x4 |
| `46`: 0C/02 2x6 / 2x7 | `47`: 0C/03 4x4 / 4x5 | `50`: 00/05 1x1 / - | `51`: 0D/01 2x2 / 2x8 |
| `52`: 0D/02 2x2 / 2x8 | `53`: 0D/03 1x1 / 1x1 | `54`: 0D/04 2x1 / 2x1 | `55`: 0D/05 2x2 / 2x8 |
| `56`: 0E/01 4x4 / 4x5 | `57`: 0E/02 2x6 / 2x7 | `58`: 0E/03 4x4 / 4x6 | `59`: 0E/04 2x2 / 2x2 |
| `5A`: 0E/05 2x6 / 2x7 | `5B`: 0F/01 4x4 / 4x5 | `5C`: 0F/02 4x4 / 4x6 | `64`: 00/06 1x1 / - |
| `65`: 10/01 4x4 / 4x16 | `66`: 11/01 3x3 / 3x4 | `67`: 11/02 3x3 / 3x5 | `68`: 11/03 4x4 / 4x5 |
| `69`: 11/04 4x4 / 4x5 | `6A`: 12/01 2x2 / 2x3 | `6B`: 12/02 2x2 / 2x3 | `6C`: 12/03 2x2 / 2x4 |
| `6D`: 12/04 2x2 / 2x3 | `6E`: 12/05 2x2 / 2x4 | `6F`: 12/06 2x2 / 2x3 | `70`: 12/07 3x2 / 3x3 |
| `71`: 13/01 3x3 / 3x3 | `72`: 13/02 3x3 / - | `73`: 13/03 3x3 / - | `78`: 00/07 1x1 / - |
| `79`: 14/01 3x6 / 3x7 | `7A`: 14/02 2x4 / 2x5 | `7B`: 14/03 2x4 / 2x5 | `7C`: 15/01 1x3 / 1x3 |
| `7D`: 15/02 1x1 / 1x1 | | | |

The 31 ids with no scene (table entry 0) are `25`-`27`, `35`-`3B`, `48`-`4F`, `5D`-`63`, `74`-`77` and `7E`-`7F`. The ids `0F`-`12` (scenes `00/09`-`00/0C`: town model, Mode 7 scene, two intro scenes) are the ones L005 and L017 skip.

## 4. Structure layouts

### 4.1 Save slot (`$70:slot*$400`, 4 slots; mirror at `+$1000`)

| Offset | Width | Field | Evidence |
|--------|-------|-------|----------|
| `+$000` | `$200` bytes | `lair_state[0..$1FF]` (copy of `$7F:0203`; 420 entries are used) | `LDX #$0203`, `LDA #$01FF`, `MVN #$70,#$7F` (L001); reverse in L002 |
| `+$200` | `$1FA` bytes | image of WRAM `$1A5E-$1C57` | `LDX #$1A5E`, `LDA #$01F9`, `MVN #$70,#$01`; the destination continues after the first block |
| `+$3FA` | word | checksum sum | `STA $7003FA,X` (16-bit) |
| `+$3FC` | word | checksum xor | `STA $7003FC,X` |
| `+$3FE` | 2 bytes | not written | the mirror copy is `$3FE` bytes (`LDA #$03FD`); L003 reads words `$000-$3F8` only |
| slot 3 mirror `+$3FE` = `$70:1FFE` | word | last played slot | `STA $701FFE` (16-bit) in L001; read in X106 |

The image fields written or read with a width in this batch (slot offset = `$200 + (address - $1A5E)`): `$1A7D` byte (`+$21F`, event flags `$F8-$FF`); `$1B66`/`$1B68` Gems (`+$308`, two words, 3 BCD bytes used); `$1B6A` level BCD byte (`+$30C`); `$1B78`/`$1B7A` EXP (`+$31A`, two words); `$1B86` level byte (`+$328`); `$1B88`, `$1B8A` HP and maximum HP bytes (`+$32A`, `+$32C`); `$1B90` arrival scene word (`+$332`); `$1B92` name (`+$334`, A7 4.5). Other fields of the image are in A2, A5 and A7 and are not re-read here.

### 4.2 Sort bucket page (`$0100-$0301`)

| Address | Width | Field | Evidence |
|---------|-------|-------|----------|
| `$0100 + key` (key even, `$000-$1FE`) | word | head of a node list; 0 = empty | L006 stores 0 words; `code_0005C4`: `LDY $0100,X`, `BNE` |
| `$0300` | word | `$FFFF` end marker (`$0301` is its high byte) | L006 `DEC` of 0 stored at `X = $0200`; `code_0005C4` second phase: `PLY`, `BMI` |

A node (4 bytes, from `$0486`, A1 R27) is a word payload (the actor slot) at `+0` and a word next-link at `+2` (0 ends the list).

### 4.3 Mask table `$0200 + id` and `tile_type_map`

| Table | Width | Field | Evidence |
|-------|-------|-------|----------|
| `$0200 + id` (256 entries, temporary) | byte | bit 0 = TL, bit 1 = TR, bit 2 = BL, bit 3 = BR, each from bit 1 of the high byte of the definition word | L029 phase 1: `AND #$02`, four pushes, `ASL`/`ORA`, `LSR`, `STA $0200,Y` (8-bit) |
| definition word (`$7E:2000 + id * 8`, four words TL, TR, BL, BR) | word | tile word; only bit 9 (bit 1 of the high byte) is read here | `LDA $7E2001,X`, `INX`, `INX` four times per id, 256 ids |
| `tile_type_map + i` | byte | the mask of the id at `$7E:8000 + i` (later `ORA $F0` marks and other values from A3/A4) | L029 phase 2: 8-bit `STA`, `INX` |

### 4.4 Location size table (`unk14_017504 + $28`, 128 x 2 bytes)

| Offset | Width | Field | Evidence |
|--------|-------|-------|----------|
| `+$28 + 2 * id` | byte | live width in pages | L035: `LDA $@unk14+28,X`, 8-bit, X = `location_id * 2` |
| `+$29 + 2 * id` | byte | live height in pages | L035: `LDA $@unk14+29,X` |

The 296 bytes of `unk14_017504` are typed `unk14` (eight `Byte`s per record, 37 records in the extraction): records 0-4 are map patch records (A4 4.1, L020) and records 5-36 are this table. The type does not distinguish them (decision for PB, OQ-I013-9).

### 4.5 Iris frame (`binary_048000`, 16 bytes, 32 frames)

| Offset | Width | Field | Evidence |
|--------|-------|-------|----------|
| `+0, +2, ..., +14` | byte | plane 0 of rows 0-7 (`FF` row = 8 opaque pixels) | 8 words written to `VMDATAL`: low byte = plane 0 |
| `+1, +3, ..., +15` | byte | plane 1 of rows 0-7, always 0 in the 32 frames | frame bytes in `data_048000` |

Frame index `f` (0-31): offset `((2 * type + bit 4 of f) << 8) or ((f and $0F) << 4)` (1.3). Frame 0 is solid, frame `$1F` empty.

### 4.6 BCD fields

| Address | Width | Field | Evidence |
|---------|-------|-------|----------|
| `$1B66` | word | Gems, digits 1-4 | `ADC $1B66` (16-bit, `SED`) |
| `$1B68` | word (high byte 0) | Gems, digits 5-6 | `ADC #$0000`, `CMP #$009A`, `LDA #$0099` |
| `$1B78` | word | EXP, digits 1-4 | `ADC $player_exp` |
| `$1B7A` | word | EXP, digits 5-8 | `ADC #$0000`, `LDA #$9999` |
| `$043D` | word | pending EXP, 4 digits | 16-bit `AND #$000F`, `#$00F0`, `#$0F00`, `SBC #$1000` |
| `$043B` | byte | pending HP (binary, not BCD) | `DEC $043B` in 8-bit mode against `INC $player_hp` |

### 4.7 `data_00BA0D` byte `+$13` (`us/structs.json` `unk8`: 16 bytes, `@Code` pointer at `+$10`..`+$12`, then bytes `+$13`, `+$14`, `+$15`, then five words)

| Offset | Width | Field | Evidence |
|--------|-------|-------|----------|
| `+$13` | byte | initial `lair_state[i]` | `LDA $&data_00BA0D+13,Y` (hex offset), `STA $7F0203,X` |

Values over the 420 records: `0` 5, `1` 36, `2` 37, `3` 54, `4` 93, `5` 61, `6` 98, `7` 5, `8` 28, `10` 3. `lair_state` bit 7 is "released" and bit 6 "return pending" (A4); the low bits are not explained here (OQ-I013-11).

### 4.8 Strip request (`$03DD`, `$03DF`, `$03E1`)

| Address | Width | Field | Evidence |
|---------|-------|-------|----------|
| `$03DD` | word | source offset in bank `$7F` | `STA vram_strip_src` (16-bit); NMI: `LDX`, `STX A1T2L`, `LDA #$7F` |
| `$03DF` | word | VRAM word destination | `STA vram_strip_dest`; NMI `STX VMADDL` |
| `$03E1` | word (low byte read by the NMI) | pending count | L005 `INC` (16-bit); NMI: `LDA`, `STZ` (8-bit) |

## 5. WRAM and DP proposals

| Address | Evidence | Proposed name | Conf | Users |
|---------|----------|---------------|------|-------|
| `$0100-$02FF`, `$0300` | 1.8, 4.2 | `sort_buckets`, `sort_bucket_end` | A | L006, A1 R27 |
| `$0200-$02FF` (during scene init) | 4.3 | `type_mask_table` | A | L029 |
| `$0302-$0311` | 16 bytes read by `code_013246` (X = 1 to `$0F` plus `$0311`); `$0301` is never touched by the generator (OQ-I013-1) | `rng_state` (move from `$0301`) | A | L035 seed, `code_013246` |
| `$03A2` | latch set by the first Start, cleared when Start is released | `pause_latch` | A | L019 (A7 proposal kept) |
| `$03A4` | slot 0-3 chosen in the file menu | `save_slot` | A | L001-L003, X106 |
| `$03CC`, `$03CD`, `$03CE` | amplitude, request flag, phase step | `wave_amplitude`, `wave_request`, `wave_phase_step` | C | L007 (dead) |
| `$03E5` | iris frame `$00-$1F` (signed while counting down) | `iris_frame` | A | L030, L033 |
| `$03E7` | iris step (`$FF` out, 1 in) | `iris_step` | A | L030, L033 |
| `$0462` | non-zero while the iris covers BG3: the HUD routines are skipped | `bg3_iris_active` | B | L033, L030, `engine_000000` `code_000127` |
| `$0332` | HUD dirty mask (A5 1.8: `$01` frame, `$02` EXP, `$04` HP, `$08` level, `$10` Gems) | `hud_dirty` | A | L021, L022, L035 |
| `$043B` | pending HP | `heal_pending` (A2, A3) | A | L021 |
| `$043D` | pending EXP | `exp_pending` (A3) | A | L022 |
| `$0454` | set when a file was chosen, cleared by the first scene init, which reloads the menu graphics and magic graphics | `reload_menu_gfx` (A2 name `file_chosen`, C) | B | L035, X106 |
| `$1A02`, `$1A04` | `$7F:3000`, dynamic tile source (A1) | `dyn_tile_src`, `dyn_tile_bank` | B | L034 |
| `$1A5E` bits 0-7 | cleared by every scene init: event flags `$00`-`$07` are scene-local | (`event_flags` kept) | A | L035 |
| `$1A7D` bit 7, bit 2 | event flags `$FF` (set by a new game) and `$FA` (suppresses the HUD redraw at scene init) | (flag names for PB) | B | L034, L035 |
| `$1B66`, `$1B68` | 1.6, 4.6 | `player_gems`, `player_gems_hi` | A | L024, L025, A5 HUD |
| `$1B84` | frames per printed glyph (A6), 3 at new game | `text_speed` | A | L034, `code_013124` |
| `$1B90` | scene number in area 0 where the saved file resumes | `saved_scene` | B | L001, X106 |
| `$1C5C-$1C61` | `8B 54 -- -- AB 60`: `PHB`, `MVN`, `PLB`, `RTS` | `mvn_stub` | A | L034, `lib_0106CD` |
| dp`$32`-`$34`, dp`$35`-`$37` | long pointers to the strip buffers (`$7E:3000`..), bank bytes set by L034, read by `code_01057D` through `[$32]`, `[$35]` | `strip_ptr_a`, `strip_ptr_b` | B | L034, `engine_000000` `code_0004C8`, `lib_01020E_part2` |
| dp`$2A` | high byte of the `dp$29` pointer into `$0200` | (scratch of L029) | A | L028, L029 |
| `$7F:1000`, `$7F:3000`, `$7F:C000` | L004, 1.2, A5 | `anim_strip_gfx`, `dyn_tile_gfx`, `menu_bg_gfx_copy` | B | L004, L005, A1 R29, A5 |
| `$700000-$701FFF` (SRAM) | 1.2 | `sram_slots`, `sram_last_slot` (`$701FFE`) | A | L001-L003 |

Existing names kept: `frame_counter`, `joy_pressed`, `scene_next`, `area_next`, `scene_current`, `area_current`, `scene_active`, `transition_type`, `vram_strip_src`, `vram_strip_dest`, `vram_strip_pending`, `vram_upload_flags`, `location_id`, `player_x`, `player_y`, `player_actor`, `player_exp`, `player_hp`, `player_max_hp`, `return_active`, `map_width_px`, `map_width_pages`, `map_height_pages`, `bg3_tilemap_buffer`, `switch_owner_table`, `tile_type_map`, `lair_state`.

## 6. Inner labels

Every label of a code part that is not a routine row. All are local branch targets inside their routine except `loc_02787C` (row L033). Offsets are the `{n}` tag of the first instruction.

| Row | Labels (offset) |
|-----|-----------------|
| L002 (1) | `loc_027169` 160105 |
| L003 (1) | `loc_027186` 160134 |
| L005 (2) | `loc_027235` 160309, `loc_027256` 160342 |
| L006 (1) | `loc_027267` 160359 |
| L007 (2) | `loc_027290` 160400, `loc_0272B5` 160437 |
| L008 (1) | `loc_0272E5` 160485 |
| L010 (1) | `loc_027329` 160553 |
| L011 (1) | `loc_027341` 160577 |
| L014 (1) | `loc_0273CE` 160718 |
| L015 (1) | `loc_0273E8` 160744 |
| L017 (4) | `loc_02740A` 160778, `loc_027414` 160788, `loc_027440` 160832, `loc_02745F` 160863 |
| L018 (9) | `loc_027471` 160881, `loc_027485` 160901, `loc_0274AD` 160941, `loc_0274B0` 160944, `loc_0274D3` 160979, `loc_0274E5` 160997, `loc_0274E8` 161000, `loc_02751A` 161050, `loc_02756F` 161135 |
| L019 (5) | `loc_0275AC` 161196, `loc_0275B1` 161201, `loc_0275B6` 161206, `loc_0275D1` 161233, `loc_0275DB` 161243 |
| L021 (3) | `loc_02760B` 161291, `loc_02760E` 161294, `loc_027613` 161299 |
| L022 (5) | `loc_02764F` 161359, `loc_02765E` 161374, `loc_02766D` 161389, `loc_02767A` 161402, `loc_027686` 161414 |
| L023 (1) | `loc_0276A3` 161443 |
| L024 (1) | `loc_0276C7` 161479 |
| L025 (1) | `loc_0276E1` 161505 |
| L026 (1) | `loc_0276F8` 161528 |
| L027 (2) | `loc_027715` 161557, `loc_027722` 161570 |
| L028 (1) | `loc_02773C` 161596 |
| L029 (3) | `loc_027747` 161607, `loc_02774B` 161611, `loc_027770` 161648 |
| L030 (2) | `loc_027798` 161688, `loc_0277D4` 161748 |
| L031 (6) | `loc_0277DD` 161757, `loc_0277F4` 161780, `loc_0277F6` 161782, `loc_027801` 161793, `loc_027809` 161801, `loc_02780B` 161803 |
| L032 (5) | `loc_027843` 161859, `loc_027845` 161861, `loc_027852` 161874, `loc_02785C` 161884, `loc_02785E` 161886 |
| L033 (5) | `loc_02788F` 161935, `loc_027894` 161940, `loc_027900` 162048, `loc_027911` 162065 (and `loc_02787C` itself, 161916, which is the row) |
| L034 (2) | `loc_027999` 162201, `loc_0279B4` 162228 |
| L035 (3) | `loc_027A41` 162369, `loc_027A9F` 162463, `loc_027AD2` 162514 |

Sub-label rows with external callers: L033 (`loc_02787C`, a colon label inside the part `code_027827`; `code_0277D5` branches to it with `BRL`). Within one extraction file the flat namespace keeps it as its own entry, so it needs its own name row in PC; a branch into it from a routine that is moved to another block would not create the label (§8c of the mapping plan). The routines of the batch that have neither a name today nor a separate block: the 8 labels of `lib_027781_part2` share one part named `code_0276EE` (548 bytes), so PC needs 7 additional rows for L027-L033 (L033 as the sub-label).

## 7. Fan-in, findings and placement

Fan-in of the batch:

| Routine | Sites | Files |
|---------|-------|-------|
| `code_0272B8` L008 | 40 | 23 |
| `code_0276EE` L026 | 25 | 5 |
| `code_02731A` L010 | 13 | 6 |
| `code_0273A2` L014 | 11 | 7 |
| `code_027331` L011 | 10 | 4 |
| `code_027348` L012 | 7 | 3 |
| `code_027223` L005 | 5 | 1 |
| `code_027462` L018 | 5 | 4 |
| `code_02716E` L003 | 4 | 3 |
| `code_0272E6` L009, `code_027687` L023, `code_0276A5` L024 | 3 each | 2, 2, 3 |
| `code_027781` L030, `code_027260` L006, `code_0273D4` L015, `code_0273F9` L017, `code_0275DC` L020 | 2 each | 1, 2, 2, 2, 1 |
| L001, L002, L004, L016, L019, L021, L022, L025, L027, L028, L029, L031, L032, L034, L035 | 1 each | 1 |
| L007, L013 | 0 | dead |

Findings for later batches and for PB:

- **Two routines are dead**: `code_027277` (sine wave tables for `$7E:7900` and `$7E:7B00`, with the three parameters `$03CC-$03CE` that nothing else touches; a leftover of an HDMA wobble that never shipped or an effect whose caller was removed) and `code_027374` (clear a bit). They are inside the used range, so a rebuild keeps their bytes; either keep them as marked dead code or remove them in a regroup step with the rest of the dead-code pass (OQ-I013-12).
- **Subsystem split (proposals for PB, no move is part of this step)**: `save_system` (L001-L003, kept contiguous: `code_02716E` is `lib_shared_` today and is included by both callers), `map_helpers` (L008-L011, L028-L029: they all depend on `map_width_*`, the hardware multiplier and the `$7E:8000` and `$7F:8000` pages; today the group is split over `lib_027462_part1`, `lib_0272E6`, `lib_027462_part2` and `lib_027781_part2` under the legacy names `lib_027462` and `lib_027781`), `bit_array` (L012-L014), `player_helpers` (L015-L018), `pause` (L019-L020), `player_stats` (L021-L025), `scene_flow` (L026-L027, L030-L033, L035 with L028-L029 called from it) and `new_game_init` (L034, with the `$1C5C` RAM stub), `anim_strip` (L005, D01), `sort_buckets` (L006), `boot_buffers` (L004). The names `lib_027462` and `lib_027781` describe three unrelated things each.
- **Placement constraints**: L031, L032 and L033 are one contiguous run (`BRL loc_02787C` and `BMI loc_02787C`; `code_027781` `JSR`s L031 and L032 by `&` 16-bit address, so L030-L033 must also share a bank, which they do: all `$04`). L029 must follow L028 or be reachable by `JSR` (same bank). L028-L029 use `DBR = $01` (mirror page `$0200`), not DBR `$7E`, and only work while `$02:xxxx` pointer reads go through the bank-`$01` mirror (OQ-I013-13). L001 and L002 share `MVN` order (destination first): `MVN #$70,#$7F` copies from bank `$7F`.
- **Hidden inputs**: L029 needs `dp$2A = 2`, set only by L028; L008 relies on B holding `dp$19` after `LDA $18` (1.5); L009 and L008 assume M = 16 on entry (`overrides.json` has `160440` `X:0` and `160866` `M:0`, which match; no new override is needed for this batch).
- **A7 questions answered here**: OQ-I011-1 (`dp$2E` is `$7E` from boot: L034 stores it; the SPC upload leaves it at `$7E`, so the loader's raw copies write to bank `$7E`); OQ-I011-8 (the LZ ring page is the sort bucket page; 1.8); OQ-I011-13 (event flag `$FF` is set by every new game, 1.4). **A5 and A2**: `$0454` is a one-shot "reload menu and magic graphics" flag (`file_chosen` in FM-A2 is its setter's view); the HUD dirty bits `$02` and `$04` are set by L022 and L021. **A4**: the header-against-live size table (3.3) explains the "staging pages" and the `$0343`/`$0345` overwrite; `tile_type_map` is **one byte per metatile** (FM-A3 1.x says one word: OQ-I013-2). **A1**: the boot scene `00/0C` is location `$12` (OQ-I005-21).
- **Walkthrough checks (no DISCREPANCY with it)**: Start shows the number of monster lairs; the file is saved at the Master's shrine; the Master greets a new file; EXP is a four-byte BCD stat at `$7E:1B78` with the maximum 99,999,999; Gems pay for magic and not MP. The walkthrough gives no Gems cap, no transition types and no checksum, so nothing could be compared.
- **Two documentation mismatches** are logged as `DISCREPANCY` rows: `docs/wram-memory-map.md` (the generator state is `$0302-$0311`, 16 bytes; `$0301` is the high byte of the sort end marker, OQ-I013-1) and FM-A3 1.x (`tile_type_map` is byte-per-metatile, OQ-I013-2).
- **Latent defects**: the erase marker of the file menu may equal the stored first word (OQ-I013-10); the animated strip rewrites VRAM tiles `$206-$21D` in every scene except the four `$0F-$12` scenes and so reserves that range in every tileset (OQ-I013-14); `STX $0433` twice in L035 looks like a missed second target (OQ-I013-13).

Open questions: `plans/extracted-audit/questions/I013_questions.md` (14 rows, 2 tagged DISCREPANCY).
