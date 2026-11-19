# Soul Blazer WRAM memory map

Source: `us/mnemonics.json` (Pass 5). Every name below has one sentence of evidence taken from the extracted code
(`extracted/`); an address with no verified meaning stays unnamed and is listed in §8. Addresses are SNES
addresses (WRAM mirror `$0000-$1FFF`, or long `$7E/$7F`); the keys in `mnemonics.json` are the same numbers in
decimal.

## 1. How names reach the extracted code

- The baserom builds `mnemonics = { ...snes.vectors, ...mnemonics.json }`. **Hardware registers** (`INIDISP`,
  `VMADDL`, `DMAPx`, `APUIO0`, ...) come from `gaia-core/snes/vectors.json`; they print only where the extractor
  knows the data bank. `us/overrides.json` supplies that with `"B": 1` at `code_0133A6` (78758) and `code_0139AC`
  (80300), both entered with DBR = `$01` (the reset code does `LDA #$01 / PHA / PLB`); the SPC upload routine
  `code_0FEFF5` inherits it through its `JSL` caller. After that no `$21xx`, `$42xx` or `$43xx` operand is left raw
  in `extracted/`.
- A name is printed only for an **absolute** operand (`LDA $0312`, `LDA $7F8000, X`). Immediates
  (`LDY #$1ADE`, `CPY #$06AA`) and **direct-page** operands (`LDA $38`) are never resolved, so neither can be
  named; the direct page is documented in §5 only.
- `rng_state+1` is the engine's `name+N` form: it prints `$rng_state+1` for `$0302`.
- Absolute operands below `$0100` with an index register (`LDA $0016, X`) are actor-slot fields, not globals (§4).

## 2. System, input and frame state

| Address | Name | Evidence |
|---|---|---|
| `$0301`-`$0311` | `rng_state` | 17-byte generator state: `code_013246` and `cop_handler_005AD6` add neighbouring bytes (`$rng_state+1,X` + `$rng_state,X`, X counting down) and then increment from `$0311` with carry. |
| `$0302` | `rng_state+1` | `code_013246` returns `LDA $rng_state+1` as the random byte (44 reads in total). |
| `$0312` | `frame_counter` | `INC $frame_counter` once per NMI (`engine_000000`); its bit 0 selects odd/even frame work. |
| `$0322` | `joy_pressed` | The NMI joypad code stores `JOY1L` masked by `joy_block_mask` and the release latch here. |
| `$0326` | `joy_block_mask` | NMI does `EOR #$FFFF / AND` with it before writing `joy_pressed`; actors set and clear bits with `TSB`/`TRB` (123 uses). |
| `$032A` | `joy_release_latch` | NMI ORs the inverted current buttons into it; actors clear the bit of a consumed button with `LDA #$4000 / TRB` (`$4000` and `$8000` seen). |
| `$032E` | `scene_active` | `code_027781` zeroes it at the start of a scene load and increments it when the scene is built; `code_00299D` skips its work while it is 0. |
| `$0437` | `random_mod_result` | `Cop35_RandomMod` stores its result here; scripts read it back (10 reads). |
| `$03D0` | `choice_result` | `Cop1A_ChoiceMenu` stores the player's choice here (its only write); 25 reads test it. |

## 3. Scene, area, scrolling and player

| Address | Name | Evidence |
|---|---|---|
| `$0314` | `area_current` | Debug dump `code_000271` prints it as the area; `lib_0109D6` room entry stores it into `return_area`. (`mnemonics.json` previously keyed `$0300`, an unreferenced address.) |
| `$0316` | `scene_current` | Same debug dump prints it as the scene; `lib_0109D6` room entry stores it into `return_scene`. |
| `$0318` | `scene_next` | A non-zero value starts `code_027781` (`LDA $scene_next / BEQ`); low byte = scene. |
| `$0319` | `area_next` | High byte of the `$0318` word: `lib_0109D6` writes it with an 8-bit `STA $area_next` next to `scene_next`. |
| `$1C6A` | `location_id` | Debug dump prints it next to the area/scene; `lib_0109D6` compares it with the first byte of each 32-byte `data_00BA0D` record, and area actors compare it with constants. |
| `$033A` / `$033C` | `scroll_bg1_x` / `_y` | NMI `code_0004AB` writes `$scroll_bg1_x, X` / `$scroll_bg1_y, X` (X = 0) to `BG1HOFS`/`BG1VOFS`; `lib_010069` moves it with the player. |
| `$033E` / `$0340` | `scroll_bg2_x` / `_y` | The same helper called with X = 4, Y = 2 sends this pair to the BG2 scroll registers. |
| `$0386` / `$0388` | `scroll_bg3_x` / `_y` | `code_00046E` writes `$scroll_bg3_x` to `BG3HOFS` (the Y word goes to `BG3VOFS`). |
| `$0342` / `$0344` | `map_width_px` / `map_height_px` | Actors compare their position against them (`CMP $map_width_px` in `cop_handler_006373`, `common_actor_0FB433`, ...); `code_0279B5` fills them from the scene header. |
| `$0343` / `$0345` | `map_width_pages` / `map_height_pages` | High bytes of the two words, read as page counts (`code_0279B5` loads them from `unk14_017504+28/+29`). |
| `$0374` / `$0376` | `player_x` / `player_y` | Pixel position copied from the player actor (`STA $player_y` after `LDA $0002,X`); the debug dump prints both. |
| `$0378` / `$037A` | `player_tile_x` / `_y` | Stored after two `LSR`s of the pixel X (`common_actor_001A28_part1`); `lib_0109D6` compares `player_tile_x` with trigger-table bytes (`table_00A9DE`). |
| `$037C` / `$037E` / `$0380` | `warp_dest_x` / `_y` / `_anim` | `lib_0109D6` and `cop_handler_005946` store the arrival position and animation from the exit tables (`table_00AC96`, `data_00BA0D`); the return path copies `return_x`/`return_y` into them (`engine_000000`). |
| `$039C` | `player_actor` | `LDY`/`LDX $player_actor` (56 uses) loads the player's actor slot address; `$039E`/`$03A0` follow it and are not yet named. |
| `$03E3` | `transition_type` | `Cop3C_SetMode03E3` stores its operand here and `lib_0109D6` stores `$80`; the loader (`code_0277D5`, `code_027827`) branches on bit 7 and `lib_027781_part2` zeroes it afterwards. |
| `$03FB` | `return_active` | `lib_0109D6` does `INC $return_active` after storing the return point; `code_027706`, `Cop30_ConditionalSpawn` and the player actor test it (14 uses). |
| `$03FD` / `$03FF` / `$0401` / `$0403` | `return_area` / `_scene` / `_x` / `_y` | `lib_0109D6` stores `area_current`, `scene_current` and the player position; the return path in `engine_000000` copies them to `area_next`, `scene_next`, `warp_dest_x`/`_y`. |

## 4. Actor system

| Address | Name | Evidence |
|---|---|---|
| `$0800` + `n*$40` | actor slot table | Slots are 0x40 bytes wide (`code_0066A3` clones the first `$3C` bytes of the caller); fields in `docs/cop/index.md` §2. |
| `$06A6` | `actor_list_tail` | Spawn code (`engine_0065A7`) links new slots after it (9 uses). |
| `$06A8` | `actor_list_head` | The runners `code_0005A6`/`code_0005C4` start walking the doubly linked list here (5 uses). |

`$06AA` is the scratch slot returned when the free-slot stack (`$4A`) is empty, and `$1ADE` is the switch bit
array; both are only ever loaded as immediates (`LDY #$06AA`, `LDY #$1ADE`), which the extractor never names, so
they carry no mnemonic (documented here and in `docs/cop/index.md`).

Actor fields (accessed as `$00xx, X`, or with D = slot): `$00/$02` position, `$10/$12` size, `$14` wait counter,
`$16` flags (bit 15 in view), `$18` resume pointer (`$36` bank), `$1A` attribute flags, `$1C` OAM attribute word,
`$1E/$20` animation, `$30` data word, `$3C/$3E` next/previous. Evidence and open fields (OQ-I001-4) are in
`docs/cop/index.md` §2.

## 5. Direct page

The extractor does not resolve direct-page operands, so there are no direct-page mnemonics. Verified roles:

| DP | Role | Evidence |
|---|---|---|
| `$38` / `$3A` | COP script pointer | `native_mode_cop_00561E` reads the opcode through it; handlers advance it past operands (`LDA [$38]`). |
| `$18` + `$36` | actor resume pointer and bank | `Cop1B_SetResumeAndDelay` / `Cop27_SetResumeAndYield` write them before yielding. |
| `$4A` | free-slot stack pointer | `engine_0065A7` pops a free slot from it. |
| `$42` | HDMA enable shadow | NMI does `LDA $42 / STA $HDMAEN`; `code_027781` clears it while loading. |

## 6. Video, DMA and buffers

| Address | Name | Evidence |
|---|---|---|
| `$03B8` | `vram_upload_flags` | NMI tests bit 0 / bit 1 to DMA the tilemap buffers to VRAM `$5800` / `$5C00`; 20 `TSB` and 17 `STA` set it elsewhere. |
| `$03B6` | `tile_dma_pending` | `code_0004E5` returns when it is 0; `code_000524` DMAs the records then does `STZ $tile_dma_pending`; the queue builder in `engine_000000` increments it. |
| `$1A06` | `tile_dma_list` | `code_000524` walks it (`LDX $tile_dma_list, Y / BEQ`) and loads each non-zero entry into `A1T2L`. |
| `$03DD` / `$03DF` / `$03E1` | `vram_strip_src` / `_dest` / `_pending` | `code_000543` DMAs from `$vram_strip_src` to the VRAM address stored at `$vram_strip_dest`, then `STZ $vram_strip_pending`; `lib_027223` sets the source. |
| `$1C7B` | `vram_write_queue` | NMI `code_00058B` points the stack at `$1C7A` and pops (VRAM address, data) word pairs into `VMADDL`/`VMDATAL` until an address of 0, then zeroes the first word; `lib_0108BB`/`lib_010EEA` push the pairs. |
| `$0486` | `oam_buffer` | NMI OAM DMA reads `$0220` bytes from it. |
| `$7F0000` | `cgram_buffer` | NMI CGRAM DMA reads `$0200` bytes from it. |
| `$7F0200` | `coldata_buffer` | NMI writes `COLDATA` from `$7F0200`-`$7F0202`. |
| `$7F7000` | `bg3_tilemap_buffer` | NMI tilemap DMA source for VRAM `$5800` when `vram_upload_flags` bit 0 is set (`$7F7800` goes to `$5C00` for bit 1); `BG3SC` = `$58` in `code_013ADA`. |
| `$7F8000` | `tile_type_map` | 43 uses; the low nibble of each byte is the collision tile type (`$F0` marks blocked, see `Cop15_BlockOwnTiles`). |
| `$7F0483` | `switch_owner_table` | `Cop14_JumpIfSwitchSet` registers the actor slot id per switch id here (`code_00662D`). |

## 7. Game state

| Address | Name | Evidence |
|---|---|---|
| `$1A5E` | `event_flags` | `Cop05_WaitFlag` / `Cop07` / `Cop08` test and set it (flag word: low byte = bit, high 7 bits = byte index). |
| `$1B1E` | `inventory` | Byte array indexed by `operand - 1` (bit 7 flag, bits 0-6 value); item commands read and write it. |
| `$1B86` | `player_level` | New-game init (`lib_027912`) stores 1; level-up `code_002F56` does `INC $player_level`. |
| `$1B6A` | `player_level_bcd` | Same init stores 1; `code_002F56` increments it with `SED / ADC #$0001` (decimal level for display). |
| `$1B78` | `player_exp` | 24-bit BCD (high byte `$1B7A`): `cop_handler_005D94` and `lib_027614` add rewards with `SED / ADC`; `code_002F56` subtracts `player_exp_next` from it. |
| `$1B7C` | `player_exp_next` | 24-bit BCD (high byte `$1B7E`): `code_002F56` loads it from `data_00F9F7.word_00FBB8+2,Y` (a per-level table). |
| `$1B88` | `player_hp` | New-game init stores 8; `cop_handler_005DCB` subtracts damage from it and level-up adds 2 (`code_002F56`). |
| `$1B8A` | `player_max_hp` | New-game init stores 8; `cop_handler_005DB0` computes `player_max_hp - player_hp` into `$043B`. |

## 8. Left unnamed (open)

No sentence of verified evidence yet; tracked in `plans/extracted-audit/questions/I002_questions.md`:
`$0332`, `$03B4`, `$03A6`, `$03E5`/`$03E7`, `$0433`, `$0454`/`$0458`/`$0462`/`$0464`/`$0466`/`$0468`, `$0482`,
`$03D4`/`$03D6`, `$043B` (looks like missing HP, see `player_max_hp`), `$043D`, `$0405`, `$039E`/`$03A0`,
`$03F7`, `$1B84`/`$1B82`, `$1B5E`-`$1B64`, `$1B72`/`$1B76`, `$1C62`-`$1C89`, `$1F00`, `$7E8000`, `$7EC000`,
`$7F0203`, `$7F6FC0`, `$7E7000`/`$7E7800` (HDMA table staging).
