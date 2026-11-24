# FM-A1: `engine_000000` (boot, NMI, main loop, scheduler)

PA batch A1, iteration I005. Read-only analysis: no names, notes, comments, `blocks.json`, `overrides.json` or docs were changed. Every proposed name below is a proposal for step PC (`npm run names`); every unverified claim is an `OQ-I005-k` row in `plans/extracted-audit/questions/I005_questions.md`.

Source: `extracted/system/engine_000000.asm` from a fresh `npm run extract:lt` (3060 lines, file offsets 0 to 5393, bank `$00`, LoROM so the SNES address is `$8000 + offset`). The file has 52 top-level labels (51 code, 1 data table). `us/blocks.json` maps it with 7 parts only: `emulation_mode_reset_000000` (0-517), `code_000205` (517-781), `binary_00030D` (781-797), `code_00031D` (797-834), `native_mode_nmi_000342` (834-1445), `native_mode_irq_0005A5` (1445-4783, which swallows 40 labels) and `code_0012AF` (4783-5394). The rows below follow the labels, not the parts.

Callee heads that were read to describe the callers: `lib_0118FC_part8` (`code_0131A2`, `code_0131AE`), `lib_shared_0131B7`, `lib_shared_0131D1`, `lib_01020E_part2.code_01057D`, `lib_01185E`, `lib_01010B`, `lib_027781_part2` (`code_0276EE`, scene loader `code_027781`), `lib_0109D6_part3.code_0120F9`, `lib_0118FC` (equipment menu, `code_011EED`), `engine_routines_001D3B.code_001F9D`, `engine_003005`, `engine_0065A7` (`code_006662`, `code_00668A`, `code_0066A3`), `native_mode_brk_0055FC`, `lib_0275ED`, `cop_handler_00637x` (`CopAD`).

## 0. Reading the tables

| Column | Meaning |
|--------|---------|
| Off / size | decimal file offset (the `{n}` tag) and size in bytes (distance to the next label; the last row ends at 5394) |
| Callers | reference count and files, from `rg` over `extracted/` (`JSL`, `JSR`, branches, `PEA`); matches the `npm run audit -- --block=engine_000000` matrix (43 references from 19 files in total) |
| Name (conf, evidence) | proposed `VerbNoun` name. Confidence: **A** behaviour fully read and independently corroborated (consumer, walkthrough, existing doc or name); **B** behaviour fully read, purpose inferred from the code only; **C** guessed or dead code. Evidence labels: `code` read in the routine, `callee` read a callee, `caller` read the caller, `cons` read a consumer of its output, `walk` walkthrough fact, `doc` existing doc or note, `hw` hardware register semantics, `dead` no references |
| In / Out | registers, DP and WRAM inputs and results. M/X widths are those at entry unless stated. D is 0 everywhere |
| Clobbers | registers and scratch that are not restored, and DP scratch bytes written |
| Data touched | WRAM names from `us/mnemonics.json` where one exists; otherwise the raw address (proposals for the unnamed ones are in section 5). `r` read, `w` write |

Actor fields are written `$nn,X` (WRAM absolute with X = actor slot, `$0800 + 0x40 * n`). DP scratch is written `dp$nn` (D = 0, so it is `$00nn`). The engine uses DP `$3E` as a scratch word in `code_000A34` while `$3E,X` is the actor link field: they are different things.

## 1. Frame model

### 1.1 Normal main loop (`emulation_mode_reset_000000` label `loc_000032`)

Reset: `SEI CLD`, native mode, `D=0`, `S=$1FFF`, `DBR=$01`; `code_0139AC` (hardware init: PPU and CPU I/O registers, including `NMITIMEN`, `HTIME`, `VTIME`, `MDMAEN`, `HDMAEN`), `code_013ADA`, `code_027912`, `code_0276EE` (fills the BG3 tilemap buffer); `scene_next = $000C` (scene `$0C`, area 0); NMI on; first `code_027781` call (scene loader).

One iteration (`location_id` not in `$10-$12`, `return_active` low byte zero):

| Step | Call | Note |
|------|------|------|
| 1 | `code_0131B7` WaitVBlank | NMI is enabled here, so the NMI handler fires in this wait |
| 2 | `code_027781` scene loader | runs only when `scene_next` low byte is non-zero; the loader runs its own sub-frames through R02 |
| 3 | `code_0118FC`, `code_027572` | menu (Select or X) and pause (Start) handlers, NMI still on |
| 4 | `code_0131AE` DisableNmi | the work phase below runs with NMI off |
| 5 | `code_0109D6` | return-point store, runs before the actors |
| 6 | `code_01185E` | per-frame reset: `dp$42 = 0` (HDMA shadow), `dp$44 = $10`, `dp$46 = $40`, `dp$48 = $6000` (decode needs `M=1`, OQ-I005-7) |
| 7 | R25 RunActors | every actor script runs once |
| 8 | R27 CullAndSortActors | visibility flag, sorted draw list `$1900` |
| 9 | R34 DetectHitSourceCollisions | player-side hits on actors |
| 10 | R38 DetectPlayerContact | actors touching the player |
| 11 | `engine_003005.code_003005` | death check and automatic Medical Herb |
| 12 | `lib_010069`, `lib_01010B` | camera/scroll updates (`lib_01010B` tests and clears the scroll request bits in `$0396`) |
| 13 | R28 BuildOamFromActors | OAM buffer from the draw list |
| 14 | `code_012659`, `code_011695` | HUD update (`$0332` dirty bits) |
| 15 | `code_027223` | not read in A1 |
| 16 | `code_0131A2` EnableNmi, loop | NMI is on again for step 1 |

Variants: `loc_00008F` (`location_id` `$10-$12`, three unnamed Up Above scenes, OQ-I001-6) runs steps 4, 6, 7, 8, 13 only (no menu, hits, HUD): a cinematic loop. The boot scene is `00/0C`, which should be location `$12` (inference, OQ-I005-21). `loc_0000AA` (`return_active` low byte non-zero) runs steps 4, `code_010EA9`, 6, `STZ $0323` (drops Start/Select/X so the menu cannot open), 7, 8, 13, 14, 15, EnableNmi, WaitVBlank, DisableNmi, then loops over R04 while the word at `$03FB` is negative, then clears `return_active` and `$03FC`, adds `player_max_hp / 8` to `$043B`, calls `code_013140` with A = `$78`, sets `transition_type = $80`, copies `return_area/scene/x/y` into `area_next`, `scene_next`, `warp_dest_x`, `warp_dest_y`, enables NMI and jumps back to `loc_000032`.

### 1.2 NMI order (R13)

`HDMAEN = 0`; R14 OAM DMA; R15 CGRAM DMA and COLDATA; R16 BG3 tilemap page DMA; R17 scroll registers; R19 scroll strips; R20 dynamic sprite tiles; R22 VRAM strip; R23 VRAM write queue; `engine_006B7F.code_006B7F` (hook, copies `$70xxxx` blocks with `MVN`, role left to batch A2); wait for `HVBJOY` bit 0 (auto-joypad) to clear; `HDMAEN = dp$42`; `frame_counter++`; joypad; sound request. The DMA channels: 0 = OAM, 1 = CGRAM, 2 = every VRAM transfer.

### 1.3 Sub-frames

R02, R03 and R04 run one complete game frame from inside a script, a menu or the loader. They set `$03A6` to 1 while the work phase runs; R32 then runs only actors whose `$16` bit `$0010` is set, so a modal routine keeps its own actors alive while the rest of the game stands still. `$03A6` is also read by the player actor code (`common_actor_001A28_part1`, `_part2`) and `w2_actor_0FA6F5`.

### 1.4 Scheduler tricks

- R25 pushes `code_0005BB-1` then `code_0009BF-1` and executes `RTS`: R32 starts with A = list tail and, when it reaches the end, its `RTS` lands in R26, which restores `dp$38-$3A` and DBR and returns with `RTL`.
- R32 calls an actor script by pushing a bank-0 return address (`code_000A22-1`), the script bank (`$36,X`) and `$18,X - 1`, then `RTL`. The script returns with `RTL` into R33.
- R27 and R28 relocate S (`TCS`) to read the sort lists with `PLX`/`PLY` and to write the OAM buffer with `PHA`. That is only safe because NMI is off during the work phase (OQ-I005-20 asks whether every caller of R03 and R04 guarantees it).
- R27 clears the bucket heads without a store loop: after popping a bucket word it executes `PHA` and `PLA` with A = 0, which writes zero over the word it just consumed.

## 2. Routine table

### 2.1 Boot, main loop, sub-frames

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| R01 | `emulation_mode_reset_000000` | 0 / 295 | 0 (reset vector); sub-label `loc_0000DD` loops on R04 | boot, main loop | `BootGame` (A; code, hw) | power-on, emulation mode | never returns; loop state is M=1, X=16-bit, D=0, S=`$1FFF`, DBR=`$01` | everything | w `scene_next` (word `$000C`), `area_next`, `transition_type`, `warp_dest_x`, `warp_dest_y`, `return_active`, `$03FC`, `$043B`, `$0323`; r `location_id`, `return_active`, `return_area`, `return_scene`, `return_x`, `return_y`, `player_max_hp` |
| R02 | `code_000127` | 295 / 76 | 13 (`lib_027781_part2` x12, `lib_0118FC` x1) | frame step | `RunSubFrameLoader` (B; code, caller) | any NMI state; M=1; DBR is kept | returns after one WaitVBlank with NMI **enabled**; skips `code_012659` and `code_011695` when `$0462` is non-zero; calls `lib_010000` (camera) | none visible (B, A, X, Y, DBR saved and restored); callees use DP `$00-$1C`, `$38-$3A`, `$42-$54` | w `$03A6` (1 during the work phase, 0 after); r `$0462` |
| R03 | `code_000173` | 371 / 75 | 8 (`lib_0109D6` x5, `lib_010EA9_part1` x3) | frame step | `RunSubFrameTransition` (B; code, caller) | NMI must be off; M=1; DBR is set to `$01` and restored | one frame, NMI off again on return; adds `lib_010EEA.code_010EEA` (not read) before the NMI wait | as R02 | w `$03A6` |
| R04 | `code_0001BE` | 446 / 71 | 4 (`engine_000000` x1, `lib_0126CF` x1, `lib_shared_012769` x2) | frame step | `RunSubFrame` (B; code, caller) | as R03 | as R03, without `code_010EEA` | as R02 | w `$03A6` |

Sub-labels of R01 that deserve their own names in PC (each needs its own override row, flat namespace): `loc_000032` `RunMainLoop`, `loc_00008F` `RunCinematicLoop`, `loc_0000AA` `RunReturnLoop`, `loc_0000DD` `WaitReturnDone` (all B; code).

### 2.2 Debug code (no references; dead)

All of R05-R12 have no external caller and no entry from the vectors. `us/overrides.json` already forces `M=1` at offsets 517 (R05) and 797 (R12).

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| R05 | `code_000205` | 517 / 38 | 0 | debug (dead) | `PollDebugPad2` (C; code, dead) | M=1 | Select on pad 2: R06; B: wait 30 frames; Y: R08 | A, X, Y | r `JOY2H` |
| R06 | `code_00022B` | 555 / 21 | 1 (R05) | debug (dead) | `ScanDebugBanks` (C; code, dead) | none | calls R07 for banks `$00`, `$03`, `$04`, `$1F` | A, X, DBR kept by R07 | none |
| R07 | `code_000240` | 576 / 49 | 4 (R06) | debug (dead) | `ScanDebugBank` (C; code, dead) | A = bank | scans `$8000-$FFFF` of the bank for the bytes `02 01 AA` followed by a negative word, and calls `lib_shared_012769.code_012C27` with `$03F3 = $040A` for each hit (purpose unknown) | A, X, Y; DBR restored | w `$03F3` |
| R08 | `code_000271` | 625 / 139 | 1 (R05) | debug (dead) | `ShowDebugPosition` (C; code, dead) | none | writes hex digits into the text buffer `$1F06-$1F1A` (area, scene, location, tile x, x low digit, tile y, y low digit, actor count), prints it with `code_012769` from `$1F02`, sets `vram_upload_flags = 1` | A, X, Y | r `area_current`, `scene_current`, `location_id`, `player_tile_x`, `player_tile_y`, `player_x`, `player_y`, `$1F00`; w `$1F06-$1F1A`, `vram_upload_flags` |
| R09 | `code_0002FC` | 764 / 4 | 6 (R08) | util (dead) | `GetHighNibbleChar` (C; code) | A (8-bit) | A = ASCII hex digit of the high nibble; falls into R10 | A, X | none |
| R10 | `code_000300` | 768 / 13 | 8 (R08) and the fall-through from R09 | util (dead) | `GetHexChar` (C; code) | A (8-bit) | A low byte = ASCII of the low nibble (B = the next table byte); M=1 on exit | A, X | r R11 |
| R11 | `binary_00030D` | 781 / 16 | 1 (R10) | data (dead) | `HexDigitTable` (A; code) | indexed by nibble | the bytes `0123456789ABCDEF` | none | none |
| R12 | `code_00031D` | 797 / 37 | 0 | debug (dead) | `ApplyDebugItem` (C; code, callee, dead) | `$0484` = two BCD digits | converts them to a binary entry number (high digit x 10 plus low digit through `code_0131D1`), calls `lib_0109D6_part3.code_0120F9` (store an inventory entry), clears `$0484`; M=1 on exit | A, B | r and w `$0484` (nothing in the ROM writes it) |

### 2.3 NMI and IRQ

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| R13 | `native_mode_nmi_000342` | 834 / 131 | 0 (NMI vector) | nmi | `HandleVBlank` (A; code, hw) | hardware; saves P, B, A, X, Y; body runs M=1, X=16-bit, DBR=`$01` | `RTI`; see 1.2 | none visible; writes DP `$32-$37` through R19 | w `frame_counter`, `joy_pressed`, `joy_release_latch`, `$0398` (word), `HDMAEN`, `APUIO2`; r `joy_block_mask`, `$0468`, `dp$42`, `JOY1L`, `HVBJOY` |
| R14 | `code_0003C5` | 965 / 37 | 1 (R13) | vram, dma | `DmaOamBuffer` (A; code, hw) | none | channel 0: 544 bytes (`$0220`) from `oam_buffer` (`$0486`) to `OAMDATA`, `OAMADD` = 0 | A, X | r `oam_buffer`; w `OAMADDL`, DMA 0 |
| R15 | `code_0003EA` | 1002 / 55 | 1 (R13) | vram, dma | `DmaPaletteAndFixedColor` (A; code, hw) | none | channel 1: 512 bytes from `$7F0000` to `CGDATA`, `CGADD` = 0; then writes `$7F0200`, `$7F0201`, `$7F0202` to `COLDATA` | A, X | r `coldata_buffer` (+1, +2), palette buffer `$7F0000`; w `CGADD`, `COLDATA`, DMA 1 |
| R16 | `code_000421` | 1057 / 77 | 1 (R13) | vram, dma | `DmaBg3TilemapPage` (A; code, hw) | none | skips when the high byte of the first write-queue word (`$1C7C`) is non-zero or `vram_upload_flags` is 0; bit 1 set: page `$7F7800` to VRAM `$5C00` and clear bit 1; else page `$7F7000` to VRAM `$5800` and clear all flags; 2048 bytes by channel 2 | A, X | r `$1C7C`, `vram_upload_flags`; w `vram_upload_flags`, `VMADDL`, DMA 2 |
| R17 | `code_00046E` | 1134 / 61 | 1 (R13) | scroll | `WriteScrollRegisters` (A; code, hw) | none | BG3 scroll: low byte of `scroll_bg3_x` and `scroll_bg3_y` (high byte 0); BG1 and BG2 through R18, pairs swapped when `$03DB` is non-zero | A, X, Y | r `scroll_bg3_x`, `scroll_bg3_y`, `$03DB`; w `BG3HOFS`, `BG3VOFS` |
| R18 | `code_0004AB` | 1195 / 29 | 4 (R17) | scroll | `WriteScrollPair` (A; code, hw) | X = offset into the scroll block (0 or 4), Y = register pair (0 BG1, 2 BG2) | writes `BG1HOFS+Y` and `BG1VOFS+Y` twice each: low byte, then high byte masked to 2 bits (10-bit scroll) | A | r `scroll_bg1_x`, `$033B`, `scroll_bg1_y`, `$033D` (each plus X), `BG1HOFS`, `BG1VOFS` |
| R19 | `code_0004C8` | 1224 / 29 | 1 (R13) | vram, scroll | `UploadScrollStrips` (A; code, callee) | none | two calls of `lib_01020E_part2.code_01057D`; each call uploads the column strip record at the long pointer in `dp$32` (VMAIN `$81`) and the row strip record at `dp$35` (VMAIN `$80`), four 64-byte blocks each, then zeroes the record's first word. Records are at `$3000`, `$3102` and `$3204`, `$3306` (0x102 bytes each) | A, X, `dp$32-$36` (the bank bytes `dp$34`, `dp$37` are not set here) | w `dp$32`, `dp$35`; WRAM `$3000-$3407`; `VMAIN` |
| R20 | `code_0004E5` | 1253 / 63 | 1 (R13) | vram, sprites | `DmaDynamicSpriteTiles` (B; code, cons) | `tile_dma_pending` non-zero (set by R29) | two passes over `tile_dma_list` (3-byte records: word address, bank byte; 0 ends), 0x40 bytes each, first to VRAM `$2000` upward, then with each record's source plus `$200` to VRAM `$2100` upward (top and bottom tile rows of 16x16 sprites); clears `tile_dma_pending` | A, X, Y | r and w `tile_dma_list`, `tile_dma_pending`; w `VMADDL`, DMA 2 |
| R21 | `code_000524` | 1316 / 31 | 3 (R20 x2, itself) | vram, sprites | `DmaSpriteTileRecords` (B; code) | Y = list offset, `DMAP2` and `BBAD2` set by R20, `VMADDL` set | one 0x40-byte DMA per record until the word is 0; Y at the terminator | A, X, Y | r `tile_dma_list`; w `A1T2L`, `A1B2`, `DAS2L`, `MDMAEN` |
| R22 | `code_000543` | 1347 / 72 | 1 (R13) | vram | `DmaVramStrip` (B; code) | `vram_strip_pending` non-zero | 0x40 bytes from `$7F:vram_strip_src` to VRAM `vram_strip_dest`, then the next 0x40 bytes to the address 0x100 words higher (high byte plus 1); clears `vram_strip_pending` | A, X | r `vram_strip_src`, `vram_strip_dest`, `vram_strip_pending`, `$03E0`; w DMA 2 |
| R23 | `code_00058B` | 1419 / 26 | 1 (R13) | vram | `FlushVramWriteQueue` (A; code, hw) | queue at `$1C7B`: pairs of words (VRAM address, data), address 0 ends | writes each pair with `VMADDL`/`VMDATAL`; stores 0 in the first word (`vram_write_queue`) so the queue is empty; S and M restored (`TSX`/`TXS`, `SEP #$20`) | A (16-bit) | r and w `vram_write_queue`; w `VMADDL`, `VMDATAL` |
| R24 | `native_mode_irq_0005A5` | 1445 / 1 | 0 (IRQ vector) | irq | `HandleIrq` (A; code) | none | `RTI` | none | none. No `CLI` exists in `extracted/`, so the I flag stays set and the IRQ is masked even though `NMITIMEN` is written as `$A1` |

### 2.4 Scheduler, sprites, animation

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| R25 | `code_0005A6` | 1446 / 21 | 8 (`engine_000000` x6, `lib_027781_part3` x2) | scheduler | `RunActors` (A; code, cons) | none; M=0 after `REP #$20` | runs R32 over the whole list from `actor_list_tail`; `$1F00` = number of actors visited; `dp$38-$3A` saved by `PEI` and restored by R26 | A, X, Y (P and DBR restored) | w `$1F00`; r `actor_list_tail` |
| R26 | `code_0005BB` | 1467 / 9 | 1 (`PEA` in R25) | scheduler | `EndRunActors` (A; code) | reached by the `RTS` of R32 | restores `dp$38-$3A`, DBR, P; `RTL` | X | w `dp$38`, `dp$39` |
| R27 | `code_0005C4` | 1476 / 298 | 6 (`engine_000000`) | sprites, scheduler | `CullAndSortActors` (A; code, cons R28, R34, R38) | none | per actor (head to tail through `$3C`): sets `$16` bit `$8000` when the extent box misses the 256x224 screen, clears it otherwise; builds `$1900` as slot words sorted by key, ended by 0. Key = `(255 - (y - scroll_y))` x 2 for the normal case, `$0000` for `$1A` bit `$4000` (front) or actors far off vertically, `$01FE` for `$1A` bit `$2000` (behind); actors with `$16` bit `$2000` or `$1A` bit `$0080` are not listed | A, X, Y, `dp$00`, `dp$02`; S relocated and restored; scratch: buckets `$0100-$02FF` (re-zeroed), nodes from `$0486`, key list in `$1900` | r `actor_list_head`, `scroll_bg1_x`, `scroll_bg1_y`, actor `$00`, `$02`, `$08`, `$0A`, `$0C`, `$0E`, `$16`, `$1A`, `$3C`; w `$16`, `$1900-`, `$0100-$02FF`, `$0486-` |
| R28 | `code_0006EE` | 1774 / 115 | 6 (`engine_000000`) | sprites | `BuildOamFromActors` (A; code) | `$1900` list | fills the OAM low table (`$0486-$0685`) and high table (`$0686-`) via R29 until the list ends or the buffer is full; unused sprites get `$E080` (off screen); empties `tile_dma_list` first | A, X, Y; `dp$00`, `dp$02`, `dp$04` (tile record pointer, starts `$1A06`), `dp$4C`, `dp$4E`, `dp$52`, `dp$54`; DBR and P restored; S relocated | r `scroll_bg1_x`, `scroll_bg1_y`, `$1900`; w `oam_buffer`, `tile_dma_list` |
| R29 | `code_000761` | 1889 / 402 | 1 (R28) | sprites | `BuildActorSprites` (A; code, cons R20) | X = actor, Y = OAM byte offset (multiple of 4), `dp$52`, `dp$54` scroll origin minus 16, `dp$4C`, `dp$4E`, `dp$04`, `dp$02` | emits one OAM entry per spritemap entry (see 4.4); Y advanced; carry set when the OAM is full (Y = `$200`); dynamic-tile actors (`$1A` bit `$8000`) also append `tile_dma_list` records and increment `tile_dma_pending`; hit-stun flash (`dp$06 = $0E00`) | A, `dp$00`, `dp$06`, `dp$0C`, `dp$16`, `dp$18`, `dp$50`, `$1A02`, `$1A04`; X and DBR restored (DBR = `$24,X` inside) | r actor `$00`, `$02`, `$08`, `$0A`, `$16`, `$1A`, `$1C`, `$24`, `$26`, `$28`, `$2C`, `$34`; w `oam_buffer`, `tile_dma_pending`, `tile_dma_list`, `$1A02`, `$1A04` |
| R30 | `code_0008F3` | 2291 / 201 | 14 (`engine_000000` x2 and 12 elsewhere: `common_actor_001A28_part1`, `cop_handler_005EB0`, `cop_handler_005EBD`, `cop_handler_0061D1`, `w0_shared_01B161`, `lib_0118FC`, `lib_027781_part1` x2, `w5_actor_025E61`, `w2_actor_0FA64B`, `engine_0026F3`, `engine_003005`) | animation | `SetActorAnimFrame` (A; code, caller x12, doc) | X = actor; reads `$1E` anim id, `$20` step, `$22` table, `$24` bank, `$1C` flip bits | loads the next animation step (see 4.3): `$14` wait, `$04`, `$06` velocity (negated for flips), `$28` spritemap pointer, `$08-$0E` extents (mirrored for flips), `$10`, `$12` size; increments `$20`; carry clear = step loaded; carry set = end marker (step reset to 0, `$04`, `$06` zeroed) | A, Y; DBR restored | r and w actor `$04`, `$06`, `$08-$14`, `$20`, `$28`; r `$1C`, `$1E`, `$22`, `$24` |
| R31 | `code_0009BC` | 2492 / 3 | 4 (branches: R32 x3, R33 x1) plus entry for the fall-through | scheduler | `NextActor` (A; code) | X = current actor | A = `$3E,X`, falls into R32 | A | r actor `$3E` |
| R32 | `code_0009BF` | 2495 / 99 | 1 (`PEA` in R25) plus the fall-through from R31 | scheduler | `RunActorList` (A; code, cons) | A = first actor, M=0 | for each actor until A = 0: `$1F00++`; hit-stun (`$16` bit `$0800`): `$26` negative counts up, positive counts down, the actor skips the script while `$1A` bit `$0040` is set, the flag clears at 0; skips actors without `$16` bit `$0010` while `$03A6` is non-zero; `$14` counts down, at 0 calls the script at `$36,X`:`$18,X` with X = slot; then R33. `RTS` into R26 at the end | A, X, Y | r and w `$1F00`, actor `$14`, `$16`, `$26`; r `$03A6`, `$18`, `$1A`, `$36`, `$3E` |
| R33 | `code_000A22` | 2594 / 18 | 2 (`BPL` and `PEA` in R32) | scheduler, collision | `StepActorMotion` (B; code) | X = actor, returns here from the script by `RTL` | when `$16` bit `$1000` is set calls R40; always calls R47; continues with R31 | A | r `$16` |

### 2.5 Combat

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| R34 | `code_000A34` | 2612 / 190 | 1 (`engine_000000`) | combat | `DetectHitSourceCollisions` (B; code, cons R35, R36) | none | skipped when the player actor has `$16` bit `$0400` (dying). For every listed actor with `$16` bit `$0080` and none of `$0D00` (source), scans the list for targets (none of `$EEC0`) whose box overlaps; if R37 confirms, calls R36 for sources with `$16` bit `$0020` (projectile), else R35; a source can hit several targets in one frame | A, X, Y; `dp$00-$06` (source box top, bottom, left, right), `dp$3E` (source slot); DBR and P restored | r `player_actor`, `$1900`, actor `$00`, `$02`, `$08-$0E`, `$16`, `$24` |
| R35 | `code_000AF2` | 2802 / 373 | 1 (R34) | combat | `ApplySwordHit` (B; code, walk) | Y = target; player animation `$1E` below `$24` or the hit is ignored | see 4.6. Applies the equipped sword: damage, freeze, immunity classes, kill and EXP | A, X; `dp$00` | r `player_actor`, `$1B5E`, `$1B64`, `$1B8C`, `$039A`, `frame_counter`, meta `+1`, `+2`, `+3`; w target `$25`, `$26`, `$16`, `$1A`, `$18`, `$36`, `$14`, `$0332`, `$0330`, `$0336`, `$0338`, `player_hp` (Recovery Sword) |
| R36 | `code_000C67` | 3175 / 238 | 1 (R34) | combat | `ApplyProjectileHit` (B; code) | X = projectile, Y = target | damage from `$30,X` (`$FF` = always kills) or, with `$1B62` = `$18` (Phoenix equipped), the attack formula `$1B70 + $1B72 - defence`; immunity checks; stun `$FFF8`; kill as in R35 (without Recovery) | A, X; `dp$00` | r `$1B62`, `$039A`, actor `$30`, `$25`; w as R35 |
| R37 | `code_000D55` | 3413 / 159 | 1 (R34) | combat | `TestSpriteOverlap` (B; code) | Y = target, `dp$3E` = source | carry set when any source spritemap rectangle (size 8 or 16 by entry flag bit 0, flips from `$1C,source`) overlaps the target box held in `dp$00-$06`; X and Y preserved | A, `dp$00-$0C` | r actor `$00`, `$02`, `$08-$0E`, `$1C`, `$28` |
| R38 | `code_000DF4` | 3572 / 169 | 1 (`engine_000000`) | combat | `DetectPlayerContact` (B; code, cons R39) | none | skipped when `$042D` is non-zero or the player is dying (`$16` bit `$0400`). Hurt box x from `x+5` to `x+12`, y from `y-12` to `y-4`; scans the draw list for actors without any of `$25C0` that overlap and calls R39 until it returns carry clear; while the player is stunned (`$0800`) only pickups (`$16` bit `$4000`) are tested | A, X, Y; `dp$16`, `dp$18`, `dp$1A`, `dp$1C`; P restored | r `$042D`, `player_actor`, `$1900`, actor `$00`, `$02`, `$10`, `$12`, `$16` |
| R39 | `code_000E9D` | 3741 / 139 | 2 (R38) | combat | `ApplyContactDamageOrPickup` (B; code, walk) | X = touching actor | pickups (`$16` bit `$4000`): `engine_002EC0.code_002F0A`, carry set (R38 keeps scanning). Otherwise Light Armor (`$1B60` = `$0E`) blocks when attack plus attack/2 is below `$1B8E` (sound `$0C`); else damage = max(1, attack - 1 - `$1B8E`), halved with `$1B64` = `$37` or `$36`; subtracts from `player_hp` (floor 0), sets `$0332` bit 2 (`$0004`), player `$26` = `$FFC0` (Mystic Armor `$1B60` = `$0D`) or `$FFE0`, sound `$04`, stun flag. Carry clear | A, X, Y | r `$1B60`, `$1B64`, `$1B8E`, meta `+0`; w `player_hp`, `$0332`, player `$26`, `$16` |

### 2.6 Movement and collision

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| R40 | `code_000F28` | 3880 / 46 | 2 (R33, `common_actor_001A28_part1`) | collision | `MoveActorWithTileCollision` (A; code, caller) | X = actor with `$04`, `$06` velocity; `RTL` | if `($10 or $12) and $0008` is set the actor is tested with a single point (R45); otherwise x first (R41 for dx above 0, R42 for dx below 0), then y (R43, R44) | A, `dp$00-$1C` | r actor `$04`, `$06`, `$10`, `$12` |
| R41 | `code_000F56` | 3926 / 169 | 1 (R40) | collision | `CollideEast` (B; code) | X = actor, dx above 0 | carry set = blocked: `$00` snapped to a multiple of 16, `$04` = 0, `$16` bit `$0004` set; carry clear = free and bit cleared. Probes the rows covered by the height: first the current column for type `$0A`, then the next column for `$0F`, `$05`, `$06`; no tile-boundary pre-check | A, `dp$00`, `dp$0C`, `dp$0E`, `dp$16`, `dp$18`, `dp$1C` | r actor `$00`, `$02`, `$10`, `$12`; w `$00`, `$04`, `$16` |
| R42 | `code_000FFF` | 4095 / 176 | 1 (R40) | collision | `CollideWest` (B; code) | X = actor, dx below 0 | as R41 with a tile-boundary pre-check; current column type `$05`, next column `$0F`, `$0A`, `$06` | as R41 | as R41 |
| R43 | `code_0010AF` | 4271 / 165 | 1 (R40) | collision | `CollideSouth` (B; code) | X = actor, dy above 0 | as R41 for y, no pre-check; current row type `$0C`, next row `$0F`, `$03`, `$06` | as R41 | r actor `$00`, `$02`, `$10`, `$12`; w `$02`, `$06`, `$16` |
| R44 | `code_001154` | 4436 / 180 | 1 (R40) | collision | `CollideNorth` (B; code) | X = actor, dy below 0 | as R43 with a pre-check; current row type `$03`, next row `$0F`, `$0C`, `$06` | as R41 | as R43 |
| R45 | `code_001208` | 4616 / 78 | 1 (R40) | collision | `ProbeTileAtVelocity` (B; code) | X = actor | single tile at (x + dx - 4, y + dy - 4): type `$000F` (16-bit compare) stops the actor (`$04`, `$06` = 0, `$16` bit `$0004`), carry set; else clears the bit, carry clear. Returns at once when `$04 or $04` is 0 (the code reads `$04` twice; OQ-I005-9) | A, `dp$16`, `dp$18` | r actor `$00`, `$02`, `$04`, `$06`; w `$04`, `$06`, `$16` |
| R46 | `code_001256` | 4694 / 68 | 17 (R41-R45) | collision | `GetTileType` (A; code, caller x17) | `dp$16` = tile x (byte), `dp$18` = tile y (word), M=0 or 1 | carry clear, A (8-bit) = low nibble of the tile when its high nibble is 0; carry set and A = `$0F` when the high nibble is non-zero or the index is `$4000` or more. Index = ((y shr 4) x `map_width_pages` + (x shr 4)) x 256 + (y and 15) x 16 + (x and 15); the B byte is left stale (OQ-I005-10) | A; X and P preserved | r `map_width_pages`, `tile_type_map`; calls `lib_shared_0131D1` |
| R47 | `code_00129A` | 4762 / 21 | 1 (R33) | collision | `ApplyActorVelocity` (A; code) | X = actor | `$00 += $04`, `$02 += $06` (16-bit) | A | r and w actor `$00`, `$02`; r `$04`, `$06` |

### 2.7 Spawning

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| R48 | `code_0012AF` | 4783 / 47 | 1 (`lib_027781_part3`) | actor spawn | `InitActorPool` (A; code, doc) | none | free-slot stack `$1800-$187F` filled with the 64 slot addresses `$0800, $0840, ..., $17C0`; `dp$4A = $1800`; `actor_list_tail = $0800`; pool `$0800-$17FF` zeroed | A, X; P restored | w `dp$4A`, `actor_list_tail`, `$1800-$187F`, `$0800-$17FF` |
| R49 | `code_0012DE` | 4830 / 54 | 1 (`lib_027781_part3`) | actor spawn | `SpawnSceneActors` (A; code) | `area_current`, `scene_current`, `$03BA` (world index) | `$03B0` = offset of the world's meta table inside `meta_tables_008000`; finds the first 4-byte record of `table_0099B4` whose area and scene match (list ends at a byte of `$80` or more) and calls R50 once | A, X; P restored | r `$03BA`, `area_current`, `scene_current`, `table_0099B4`, `meta_tables_008000`; w `$03B0` |
| R50 | `code_001314` | 4884 / 151 | 1 (R49) | actor spawn | `SpawnPlacementList` (B; code, callee) | X = offset of the `table_0099B4` record; M=1 on entry | `dp$29-$2B` = long pointer to 4-byte placement records (bank `$01`); allocates actors with `engine_0065A7.code_00668A`, links each as the new head (`$3E` of the old head and `$3C` of the new one), stores the record pointer in `$3A`, calls R51; ends at the `$FF` record. The actor with `$16` bit `$0080` is the player: placed at `warp_dest_x`/`warp_dest_y + 16` when non-zero (anim `warp_dest_anim`, R30), `warp_dest_*` cleared, `player_tile_x/y`, `player_x/y`, `player_actor` set | A, X, Y; `dp$29-$2B` | w `actor_list_head`, `player_actor`, `player_x`, `player_y`, `player_tile_x`, `player_tile_y`, `warp_dest_x`, `warp_dest_y`; r `warp_dest_anim`; actor `$00`, `$02`, `$1E`, `$20`, `$14`, `$3A`, `$3C`, `$3E` |
| R51 | `code_0013AB` | 5035 / 164 | 2 (R50, `cop_handler_005CF0_part1`) | actor spawn | `InitActorFromPlacement` (A; code, caller, walkthrough names via crosswalk) | X = new slot, `$3A,X` = record pointer in bank `$01` | position from the record (x tile x 16, y tile x 16 + 16); `$1C` = record bits `$C100` or `$0372`; meta entry = `$03B0` + type x 14: `$38` entry pointer, `$25` HP (+2), `$1E` anim (+5), `$24` bank (+A), `$36` script bank (+D), `$16` flags (+6) or `$8000`, `$22` anim table (+8), `$18` script (+B); extents from R30, or a 16x16 default box for actors with `$16` bit `$2000` and not `$0040`; `$14`, `$04`, `$06` = 0 | A, X (= slot on return), Y | r `$0372`, `$03B0`, `meta_tables_008000`; w actor `$00`, `$02`, `$1C`, `$38`, `$25`, `$1E`, `$24`, `$36`, `$16`, `$22`, `$18`, `$08-$0E`, `$14`, `$04`, `$06` |
| R52 | `code_00144F` | 5199 / 195 | 1 (`lib_0133A6_part1`) | actor spawn | `SpawnLairMonster` (B; code, caller) | X = lair index (byte table `$7F0203`), Y = lair record offset in `data_00BA0D` (32 bytes per record) | allocates an actor before the head (`code_006662`, clone), `$16 = $A000`, `$34` = lair index, position (+C x 16, (+D + 1) x 16), `$1C` and `$30` = (+16 or `$0100` or `$0372`), script `$18` (+10) and `$36` (+12), `$2E` and `$2F` = lair state byte, `$26` = +14, meta entry from +15 (`$38`, `$25`, `$1E`, `$24`, `$22`), size and extents 16, `$32` = 0 | A, X, Y restored; P restored | r `$7F0203`, `data_00BA0D`, `$0372`, `$03B0`, `actor_list_head`, `meta_tables_008000`; w actor fields listed |

## 3. Fan-in summary

Referenced from outside `engine_000000`: R02 (13), R03 (8), R04 (3 external), R25 (2), R30 (12), R40 (1), R48, R49, R51, R52 (1 each). Everything else is internal. `code_0005C4` (R27), `code_0006EE` (R28), `code_000A34` (R34) and `code_000DF4` (R38) have no caller outside the loop.

## 4. Structures observed (consumer evidence only; widths are the access sizes seen)

### 4.1 Actor slot (0x40 bytes at `$0800 + 0x40 * n`, 64 slots)

| Off | Width seen | Role (routine) |
|-----|-----------|----------------|
| `$00`, `$02` | word | x, y (R47, R29, R27); y is the bottom edge for the contact test (R38) |
| `$04`, `$06` | word | dx, dy per frame (R30, R47) |
| `$08`, `$0A`, `$0C`, `$0E` | word | extent box: left, top, right, bottom distances from (x, y) (R27, R34, R37, R30) |
| `$10`, `$12` | word | width, height (R30, R38, R40, R41-R44) |
| `$14` | word | wait counter (R32, R30) |
| `$16` | word | flags, bit table in 4.2 |
| `$18` | word | script resume address; `$36` byte = its bank (R32, R51) |
| `$1A` | word | attribute flags, bit table in 4.2 |
| `$1C` | word | OAM attribute: bit 15 flip Y, bit 14 flip X (R29, R30) |
| `$1E` | word (R30); stored as byte in R51 | animation id |
| `$20` | word | animation step (8 bytes per step) |
| `$22` | word | animation table pointer |
| `$24` | byte | data bank of the animation and spritemap data |
| `$25` | byte | HP |
| `$26` | word | hit-stun counter (R32); in R52 loaded from a byte |
| `$28` | word | spritemap pointer (R29) |
| `$2C`, `$34` | word | dynamic-tile bank (low byte used, R29) and source base (R29); `$34` is also the lair index in R52 |
| `$2E`, `$2F` | byte, byte | lair state byte copies (R52) |
| `$30` | word (R36 compare) and byte (R36 subtract) | projectile damage, `$FF` kills; copy of `$1C` in R52 |
| `$32` | word | zeroed in R52 |
| `$38` | word | meta entry pointer (offset into `meta_tables_008000`) |
| `$3A` | word | placement record pointer |
| `$3C`, `$3E` | word | link toward the older and toward the newer actor |

### 4.2 Flag bits read in A1

`$16`: `$8000` off screen (set by R27 and at spawn); `$4000` pickup (R38, R39); `$2000` hidden or inactive (R27, R51); `$1000` run tile collision (R33); `$0800` hit stun (R32, R34); `$0400` dying (R34, R38); `$0080` player-side hit source or the player (R34, R50); `$0020` projectile (R34); `$0010` runs during sub-frames (R32); `$0004` blocked (R41-R45); `$0002` deflects hits (R35, R36); `$0001` no enemy gauge (R35, R36). Read but unexplained: `$0008`, `$0040`, `$0100`, `$0200` (OQ-I005-14).

`$1A`: `$8000` dynamic-tile sprite (R29); `$4000` draw in front, `$2000` draw behind (R27); `$0080` not drawn (R27); `$0040` frozen while stunned (R32, R35); `$0100` survives lethal hits with 1 HP (R35, R36); `$0200`, `$0400`, `$0800` immunity classes: only the Soul Blade, Zantetsu Sword and Spirit Sword hurt them (R35).

### 4.3 Animation tables (R30)

`$22,X` points to a word table indexed by the animation id; each entry points to a list of 8-byte steps (indexed by `$20`): word duration (negative ends the animation), word dx, word dy, word frame pointer. A frame record has six words (left, right, top, bottom extents, width, height) followed at +12 by the spritemap.

### 4.4 Spritemap (R29, R37)

Word entry count, then 7-byte entries: byte flags (bit 0 goes to the OAM size bit), byte x offset, byte x offset when flipped in x, byte y offset, byte y offset when flipped in y, word tile and attribute (xor `$1C`, or `$0E00` while flashing). For dynamic-tile actors the tile number (low 9 bits) selects a 32-byte block at source + n x 32 and the OAM tile number becomes 0, 2, 4, and so on.

### 4.5 Meta entry (14 bytes at `meta_tables_008000`, R35, R36, R39, R51, R52)

`+0` byte attack, `+1` byte defence, `+2` byte HP, `+3` word EXP, `+5` byte animation id, `+6` word flags (becomes `$16`), `+8` word animation table, `+A` byte data bank, `+B` word script, `+D` byte script bank. The crosswalk (I004) agrees on `+1` and `+2`.

### 4.6 Hit rules, with the walkthrough items they match

| Fact in code | Walkthrough statement | Match |
|--------------|----------------------|-------|
| damage = max(1, `$1B8C` - defence); Power (`$35`) and Super (`$37`) Bracelet double it | Power Bracelet: doubles offensive power and damage dealt | yes |
| damage to the player = max(1, attack - 1 - `$1B8E`); Shield (`$36`) and Super (`$37`) halve it | Shield Bracelet: doubles your defense, halving damage taken | yes |
| Super Bracelet gets both effects | Super Bracelet: adds two points to both Strength and Defense | no (OQ-I005-1) |
| Zantetsu (5) hurts `$1A` bit `$0400` actors, Spirit (6) bit `$0800`, Soul Blade (8) bit `$0200` and all others | hurts metal, spirit, special enemies and Deathtoll | yes (class names by walkthrough) |
| Mystic Armor (`$0D`): stun `$FFC0` (64 frames) instead of `$FFE0` (32) | increases invulnerability period after damage | yes |
| Light Armor (`$0E`): no damage when attack + attack/2 is below `$1B8E` | weaker monsters won't ever hurt you | yes |
| Recovery Sword (7): +1 HP per kill | heal some HP in battles | consistent (OQ-I005-4) |
| Critical Sword (3): kill chance 1/16 (`frame_counter` and `$0F` = 0), not against `$039A` | higher critical-hit rate | open (OQ-I005-2) |
| Psycho Sword (2): freezes (`$1A` bit `$0040`, stun 180 frames) enemies of the three immunity classes instead of damaging them | none | open (OQ-I005-3) |

## 5. WRAM touched by A1 without a mnemonic (proposals only, nothing applied)

| Address | Use in A1 | Proposed name | Conf | Evidence |
|---------|-----------|---------------|------|----------|
| `$0323` | `STZ` clears the high byte of `joy_pressed`; bits `$20` (Select or X) and `$10` (Start) are tested by the menu and pause code | `joy_pressed+1` (part of `joy_pressed`) | A | R13, R01 |
| `$0330`, `$0336`, `$0338` | set on a hit when the target has no `$16` bit `$0001`: `$80`, target HP after the hit, meta max HP (+2) | `enemy_gauge_timer`, `enemy_gauge_hp`, `enemy_gauge_max` | B | R35, R36; no reader found by name (OQ-I005-13) |
| `$0332` | HUD dirty bits: `$0002` EXP, `$0004` HP; the HUD routine `lib_0118FC_part6` shifts the word right five times | `hud_dirty_flags` | A | R35, R39 and the consumer |
| `$0372` | OR-ed into the OAM attribute (`$1C`) of every spawned actor | `sprite_attr_base` | B | R51, R52 and 8 other readers (OQ-I005-16) |
| `$0398` (word) | sound request; the BRK handler stores `$0398` (bit 6 clear) or `$0399` (`n and $BF`); the NMI sends the word to `APUIO2` on even frames and clears it, sends 0 on odd frames | `sound_request` | A | R13, `native_mode_brk_0055FC` |
| `$039A` | actor slot compared against the hit target to exempt it from Psycho freeze, Critical kill and projectile immunity | `boss_actor` | C | R35, R36; `STX $039A` in `common_actor_004299`, `_003E43`, `_0033C6` (OQ-I005-15) |
| `$03A6` | sub-frame flag (see 1.3) | `subframe_active` | A | R02-R04, R32 |
| `$03B0` | offset of the current world's meta table inside `meta_tables_008000` | `meta_table_offset` | A | R49, R51, R52 |
| `$03BA` | world index (0-6), written by `lib_0133A6_part3`; selects the meta table | `world_index` | B | R49 and four other readers |
| `$03D2` | 1 while NMI is enabled (`code_0131A2` increments, `code_0131AE` stores 0) | `nmi_enabled` | A | callees |
| `$03DB` | non-zero swaps which scroll pair feeds BG1 and BG2 | `bg_scroll_swap` | B | R17 |
| `$042D` | non-zero disables R38; incremented by four `w*_shared` scene routines, cleared by `common_actor_0033C6` and the scene loader | `contact_lock` | B | R38 (OQ-I005-16) |
| `$043B` | pending heal: `engine_003005` stores `player_max_hp` when a Medical Herb (`$38`) is used on death, the return path adds `max_hp / 8`, `lib_0275ED` decrements it | `heal_pending` | B | R01, `engine_003005`, `lib_0275ED`, `lib_0109D6_part3` note |
| `$0462` | non-zero while the scene loader runs (`INC` and `STZ` in `lib_027781_part2`); R02 skips the HUD then | `scene_loading` | B | R02 |
| `$0468` | non-zero replaces `joy_pressed` (scripted input); written by `w0_actor_01B33A` and cleared by `lib_027781_part3` | `forced_joy` | B | R13 (OQ-I005-16) |
| `$0484` | debug item entry, read only by R12 | `debug_item_bcd` | C | R12, dead |
| `$1900` | sorted draw list (slot words, 0 ends) | `draw_list` | A | R27, R28, R34, R38 |
| `$1A02`, `$1A04` | dynamic-tile source address and bank scratch | `dyn_tile_src`, `dyn_tile_bank` | B | R29 |
| `$1B5E`, `$1B60`, `$1B62`, `$1B64` | equipped weapon, armor, magic and bracelet ids; the equipment menu fills them from the item rows `$1B1E`, `$1B26`, `$1B2E`, `$1B36` | `equipped_weapon`, `equipped_armor`, `equipped_magic`, `equipped_bracelet` | A | `lib_0118FC` code `011CC3-011D30`, ids match the crosswalk |
| `$1B70`, `$1B72`, `$1B74`, `$1B76` | weapon strength, level strength, armor defence, level defence (I004-10 already reads `$1B72` and `$1B76` as level parts) | `weapon_power`, `level_power`, `armor_defense`, `level_defense` | A | `lib_0118FC.code_011EED`, I004 |
| `$1B8C`, `$1B8E` | effective attack (`$1B70`, plus `$1B72` while the player animation is `$20-$23`) and effective defence (`$1B74 + $1B76`), recomputed in `engine_routines_001D3B.code_001F9D` | `attack_current`, `defense_current` | B | R35, R39 |
| `$1F00` | actors run this frame | `actor_run_count` | A | R25, R32, R08 |
| `$7F0203` | per-lair state bytes indexed by lair index | `lair_state` | B | R52 |
| DP `$42` | HDMA enable shadow (cleared by `code_01185E`, copied to `HDMAEN` in the NMI) | `hdma_shadow` | A | R13, `code_01185E` |
| DP `$4A` | free-slot stack pointer (`$1800`) | `actor_free_ptr` | A | R48 |
| DP `$52`, `$54`, `$4C`, `$4E` | OAM scroll origin (minus 16), OAM high-table pointer and bit counter | `oam_origin_x`, `oam_origin_y`, `oam_hi_ptr`, `oam_hi_count` | B | R28, R29 |

## 6. Findings for later batches

- Decode anomalies (static proof in OQ-I005-7): `lib_01185E.code_01185E` and `lib_01010B.code_01010B` are extracted with the wrong M flag at entry (callers run with M=1). Correct decodes: `STZ $42; LDA #$10; STA $44; LDA #$40; STA $46; LDX #$6000; STX $48; RTL` and `LDA #$80; TRB $0396; BEQ ...` and `LDA #$40; TRB $0396; BEQ ...`. `us/overrides.json` needs `"71774": {"M": 1}` and `"65803": {"M": 1}` in step PC; blocks owned by A4 and A5.
- `docs/cop/index.md` section 2 and the name `CopAD_YieldWhileInView` call `$16` bit 15 an in-view flag, but R27 sets it when the actor is outside the screen, and `CopAD` waits when it is set (OQ-I005-11).
- The reset code has a 38-byte debug block (R05-R12) with no references, a hex-digit table and a text template at `$1F02-$1F05` that nothing initialises.
- The sort in R27 never reaches the `CMP #$0200 / BCS` self-loop at `loc_00064C`: both routes into `loc_000648` leave A at `$00FF` or less, so the key is at most `$01FE`. The loop is a dead guard, not an OQ.
- A1 relies on I004 for the item and sword names (crosswalk rows 193-241); no name in A1 conflicts with the walkthrough.
