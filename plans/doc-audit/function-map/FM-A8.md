# FM-A8: library `014F`-`0175` (choice menus, item names, weapon levels, chest message tail, staff roll, map patch and map size table)

PA batch A8, iteration I012. Read-only analysis: no names, notes, comments, `blocks.json`, `overrides.json` or docs were changed. Every proposed name below is a proposal for step PC (`npm run names`); every unverified claim is an `OQ-I012-k` row in `plans/extracted-audit/questions/I012_questions.md`. (A4 owns I008, A5 I009, A6 I010, A7 I011; A8 takes I012.)

Source: a fresh `npm run extract:lt`. Offsets are decimal file offsets (the `{n}` tag; LoROM: bank = `offset >> 15`, address = `$bank:(8000 + (offset & 7FFF))`). The label suffix is the hex file offset, so `asciistring_014F02` is at `$02:CF02` and `unk14_017504` at `$02:F504`. Block sizes below were checked against `us/blocks.json` (lines 3511-3613): every block of the batch starts where the previous label ends.

**This batch has no routines.** All ten files are data (seven strings, one string list with its 65 strings, one word table, one structure table). The `014F`-`0175` range also contains blocks owned by other batches (`lib_010EA9_part2/3`, `lib_0118FC_part13`, `lib_0109D6_part4/5`, `lib_010EEA_part2`, `lib_0133A6_part4/5`); they are not repeated. The rows of section 2 therefore describe the **consumer routines** that decide what each field means. They are listed with the inputs, outputs and clobbers that concern this data; the routines themselves belong to the batches named in the "Owner" column (one of them, the chooser `code_012281`, has no batch: FM-A4 7 and FM-A6 7 list `lib_012281` as a gap, so this file records it).

| File | Offsets | Labels | Content |
|------|---------|--------|---------|
| `lib_014F02` | 85762-85781 | 1 string | Yes / No choice window |
| `lib_014F15` | 85781-85795 | 1 string | Yes (one option) choice window |
| `lib_014F23` | 85795-85827 | 1 string | Record / Move / Quit choice window |
| `lib_014F43` | 85827-85851 | 1 string | Record / Quit choice window |
| `lib_014F5B` | 85851-85876 | 1 string | Stay / Go back choice window |
| `lib_shared_014F74` | 85876-86758 | 1 list + 65 strings | item name list (id 00-40) |
| `lib_0161CE` | 90574-90590 | 1 table | weapon minimum level (8 BCD words) |
| `lib_shared_016246` | 90694-90724 | 1 string | chest and lair message tail (GEMs found, wait for a key, close) |
| `lib_016264` | 90724-92321 | 1 string | staff roll text (1597 bytes) |
| `lib_017504` | 95492-95788 | 1 table (typed `unk14` x 37) | 5 map patch records + 128 location map sizes |

10 data rows (D01-D10), 65 item name rows (3.2), the 97-location live map size table (3.3), seven structure layouts (section 4), 9 consumer rows (C01-C09) and 12 open questions. The two `lib_0109D6_part4/5` files that carry the chest records and the `lib_0118FC_part13` equipment strings read this batch's data; their rows are in FM-A4 and FM-A5.

Context read for the consumer models: `cop_handler_005A43` (Cop1A), `cop_handler_0057BD` (Cop02), `lib_012281`, `lib_shared_01230B`, `lib_shared_012769` (`code_013169`), `common_actor_00766C` (Master's Shrine menu), `common_actor_001A28_part1` (`code_001512`, `code_0018A1`), `system/engine_003005` (`code_003188`, `code_003194`), the five boss actors `common_actor_0031AD`, `_0033C6`, `_004299`, `_004659`, `_004D8B`, `lib_0108BB` (`code_0108BB`), `lib_027781_part3` (`code_0279B5`), `lib_027462_part1` (`code_0272B8`), `lib_0109D6` (`TryOpenChest`), `lib_0109D6_part4`, `lib_010EA9_part3`, `lib_0118FC_part13`, `lib_0133A6_part5` (`unk13` rows), `common_actor_00729D` and `_part2` (ending), `system/asset_list_028000`, the `.map` stream headers, `us/stringTypes.json` (dictionary `lookup_108000`), `us/structs.json`, `us/mnemonics.json`, `us/blocks.json`, `docs/walkthrough/` (`items.md`, `magic.md`), `plans/doc-audit/walkthrough-crosswalk.md` (4, 14), FM-A1 to FM-A7 and the open questions of I004, I010 and I011.

## 0. Reading the tables

| Column | Meaning |
|--------|---------|
| Off / size | decimal file offset and size in bytes (distance to the next label; for strings the size includes the `00` terminator) |
| Callers | reference count and files, from `rg` over `extracted/` (a `?INCLUDE` line is not a reference) |
| Name (conf, evidence) | proposed name. Confidence: **A** content fully read and independently corroborated (consumer, doc, walkthrough, hardware); **B** content fully read, purpose inferred from code only; **C** guessed or dead. Evidence labels: `code`, `cons` (the consuming handler), `caller`, `walk`, `doc`, `hw`, `dead` |
| Data touched | WRAM names from `us/mnemonics.json` where one exists, otherwise the raw address (proposals in section 5). `r` read, `w` write |

Text control codes are those of FM-A6 1.3 (`[CUR:o]` BG3 byte offset, row `o / $40`, column `(o mod $40) / 2`; `[N]` newline (+`$40`); `[07:w,h]` window; `[08:o]` erase window; `[10]` clear page and open the standard box; `[02:n]` insert list entry n; `[03:v]` attribute; `[06:n,a]` n BCD digits of the word at `a`; `[TBL:list,a]` string number from the word at `a`; `[14:n]` n blanks (hex); `[12]` wait for a key; `[::]` marks an entry point written `+M`; `[JMP]` jump; `[END]`). The extractor prints the dictionary expansions of `lookup_108000` (`us/stringTypes.json`, bytes `$80`-`$FF`, e.g. `$CA` = `not `, `$CB` = `of `, `$D7` = `s `), so a string's byte size can be smaller than its printed length (3.2).

## 1. Models that several rows share

### 1.1 The choice window (D01-D05, C01-C03)

A choice window string has exactly this shape: `[CUR:o] [07:w,h] ( " " option [N][N] )* [CUR:o+$82] [END]`. Evidence from all five strings:

| String | `[CUR]` o | `[07]` w,h | Options (leading blank = cursor column) | final `[CUR]` | `COP [1A]` count operand |
|--------|-----------|------------|-----------------------------------------|---------------|--------------------------|
| `014F02` | `$288` | 4,4 | ` Yes`, ` No` | `$30A` | 2 (all 16 sites), Cop02 fixed |
| `014F15` | `$308` | 4,2 | ` Yes` | `$38A` | 1 |
| `014F23` | `$208` | 7,6 | ` Record`, ` Move `, ` Quit` | `$28A` | 3 |
| `014F43` | `$288` | 7,4 | ` Record`, ` Quit` | `$30A` | 2 |
| `014F5B` | `$288` | 8,4 | ` Stay`, ` Go back` | `$30A` | 2 |

Rules read from the data:

- `h = 2 x options` in every string (2x2=4, 1x2=2, 3x2=6) and `w` = the longest option text including its leading blank (` Record` = 7, ` Go back` = 8, ` Yes` = 4). `[N][N]` between two options is two rows (`$80`), and the chooser moves the cursor in steps of `$80` (`code_012281`, lines 74459 and 74482), so one option = two BG3 rows.
- The final `[CUR]` is always `o + $82` (row + 2, column + 1). It is the **cursor cell of the first option**: the chooser takes it as X (C03). The first option text starts at the same cell, so the arrow tile `$2B` is drawn over the leading blank.
- The windows are placed so that the bottom border is in BG3 row 15 for all five (origin row + h + 1: row 10+4+1, 8+6+1, 12+2+1): directly above the dialogue box that starts at row 16 (`[CUR:408]` = row 16). That is why the origin moves up when the option count grows.
- The `count` operand of `COP [1A]` equals the number of options in the string for all 27 uses (counted by `rg`).

All five strings are referenced with 2-byte `&` pointers from many banks: `Cop02` and `Cop1A` call `code_012769`, which forces DBR `$02` (FM-A3 H036-H037), so these strings must stay in bank `$02` (section 7).

### 1.2 The item name list (D06, 3.2)

`asciistring_list_014F74` is 65 little-endian words (130 bytes, `$02:CF74`), index = item id `$00`-`$40`, each word a bank-`$02` offset of a string. The strings follow the words at 86006, in id order, with no padding (sizes in 3.2 sum to 752; 130 + 752 = 882 = `blocks.json` 85876..86758). Id `$00` is `not equipped`. The ids group as in the walkthrough: `$01`-`$08` swords, `$09`-`$10` armours, `$11`-`$18` magic, `$19`-`$40` the 40 key items (the pause grid cell is `id - $19`; crosswalk 4).

Consumers: `[TBL:&lib_shared_014F74.asciistring_list_014F74,addr]` reads the word at `addr` as a **string number** and indexes the list (FM-A7 4.6; `loc_012931`). `addr` is `$03C8` in the chest item message (`asciistring_016216`, `lib_0109D6_part4`) and `&word_01612C+2k` in the 64 equipment description strings (`lib_0118FC_part13`: 8 weapon, 8 armour, 8 magic, 40 key item). `word_01612C` is the A5 table of item ids per grid position.

### 1.3 Weapon minimum level (D07, C04, C05)

`word_0161CE` has eight words `0001, 0005, 0011, 0015, 0016, 0019, 0022, 0024`: BCD levels, index = weapon number - 1 (swords `$01`-`$08`). Two consumers:

1. `common_actor_001A28_part1.code_001512` (the player's per-frame input filter, lines 28-55): when `$0439` is zero and `$1B5E` (`equipped_weapon`, the equipped sword id `$01`-`$08`, FM-A1) is not zero, `JSR code_0018A1` (the sword push-back scan; it saves and restores A and X, so A is still `$1B5E`), then `DEC; ASL; TAX` (`X = (weapon - 1) * 2`) and `LDA word_0161CE, X; CMP player_level_bcd`. When the table value is **greater** than the level (`BEQ`/`BCC` skip the next line otherwise) it clears bit `$8000` of `joy_pressed` (the swing button B). Thrusts and every other button are not touched. A level equal to the table value passes. (When `$0439` is non-zero or `$1B5E` is zero the filter clears `$C000` instead, buttons B and Y, without any table read.) FM-A2 independently uses `$1B5E == 4` for the Lucky Blade and `$08` for the Soul Blade, which fixes the index as the item id.
2. The eight weapon description strings of `lib_0118FC_part13` (`asciistring_0155FB` .. `015788`) print it: `[TBL:list,&word_01612C+2k][CUR:4B2][06:2,&lib_0161CE.word_0161CE+2k]` = the name from item id `k`, then 2 BCD digits of table word `k`. The same screen therefore pairs table word `k` with weapon `k` (the strong evidence that the index is the weapon number).

Walkthrough `items.md` lines 61-70 lists exactly these minimum levels per sword: Sword of Life 1, Psycho Sword 5, Critical Sword 11, Lucky Blade 15, Zantetsu Sword 16, Spirit Sword 19, Recovery Sword 22, Soul Blade 24, and states that thrusts are not restricted. All eight values agree; this answers the "weapon minimum levels" part of OQ-I004-9 (the gem costs, the armour effects and the Magic Armor halving are still open there).

### 1.4 The map table `unk14_017504` is two different tables (D10, C06-C08)

The extractor types the whole block as 37 rows of `unk14` (`Byte, Byte, Byte, Byte, Word, Word`, 8 bytes, `us/structs.json`), but the consumers read it as two unrelated structures:

- **Rows 0-4 (offset +0 to +39, 40 bytes): five map patch rectangles** (4.1), read by `code_0108BB` with `X = patch index * 8`.
- **Offset +$28 (40) to the end (256 bytes): 128 two-byte map size entries** (4.2), read by `code_0279B5` with `X = location_id * 2`. Rows 5-36 of the typed view are those bytes cut into groups of 8, which is why they look like random words (`#$0404`, `#$0202`).

The block ends at 95788 = 95492 + 40 + 256 (`blocks.json` `end`), and the next label is `word_01762C` (A4). Both consumers reach the table by a long reference with a hexadecimal offset: `lib_0108BB` uses `unk14_017504+0..+7` and `lib_027781_part3` uses `unk14_017504+28` and `+29` (hex 28 = 40, the start of the size table).

### 1.5 The chest and lair message tail (D08)

`asciistring_016246` is `[10] [02:2] found[N][03:24][06:3,03C8] GEMs-[03:20]` followed by `[::]` (entry point `+M`, offset +25) and the tail `[12][08:408][END]` (wait for a key, erase the box at `$408`, end). `[02:2]` is insert list entry 2 = the name buffer `$1B92`; `$03C8` holds the BCD gem count (written by `TryOpenChest`: `LDA table_00A9DE+4, X; STA $03C8` at 68309-68312, then the print at 68327). Four other strings jump to `+M` so that they share the tail: `asciistring_016216` (`[10] [02:2] recieved[N] [03:24][TBL:list,03C8][03:20]-`, chest item), `asciistring_016232` (`[10] Nothing inside-`, empty chest), `asciistring_0161DE` (`...cannot be recalled yet!`) and `asciistring_016203` (`... released ...`), the last two in `lib_010EA9_part3` (lair, A4). Only `TryOpenChest` (line 182, `LDY #$&lib_shared_016246.asciistring_016246`) prints the head, for the gem chests. Note that the ROM spells `recieved` (a typo in `lib_0109D6_part4`, not in this batch).

### 1.6 The staff roll (D09, C09)

`asciistring_016264` is 1597 bytes of centred credits. The scroller `ScrollStaffRollText` (`code_0126CF`, A6; FM-A6 L-rows) reads it with DBR `$02`, so the string pointer is a bank-`$02` offset. The only caller is `common_actor_00729D_part2.code_007638`, spawned by `common_actor_00729D.code_007431` (`COP [85]`, line 208; the actor is the ending sequence). When the text ends, `code_007638` waits `$F0` frames, runs `COP [31]`, waits `$F0` frames again and spawns actor `$0D00` (`code_007650`, C09). Counts over the string (from `rg -o` on the extract): 218 `[N]` (new lines; 32 frames each, FM-A6), `[14:9]` x 48 (name lines), `[14:4]` x 19 (headings), `[14:3]` x 8, `[14:6]` x 3, `[14:5]` x 1. The two glyph runs the extractor prints as `*►,+-/` (3 times) and `·"▼ˮ?` (5 times) are font tile numbers (OQ-I010-11). Spelling in the ROM: `Soul Blazer` twice and `Soul Blader` once (`Based Upon Soul Blader`), `COPORATION` twice (`OQ-I012-7`).

## 2. Code rows

This batch has no routines. The rows below are the **consumers** that give the data its meaning. They are not proposals to rename the routine (the owner batch does that); they record what the data layouts rely on.

### 2.1 Consumer routines

| ID | Routine | Offset / size | Owner | Reads (this batch) | Inputs | Outputs | Clobbers (with respect to this data) | Data touched |
|----|---------|---------------|-------|--------------------|--------|---------|---------------------------------------|--------------|
| C01 | `Cop1A_ChoiceMenu` (`cop_handler_005A43`) | 23107 / 69 | A3 (H037) | D01-D05 | string pointer `&`, option count (byte), cancel code pointer; DBR forced to `$02` by `code_012769` | selection index in `choice_result`, skips the cancel pointer; cancel (carry set) jumps to the cancel code; erases the window at `$03F7`, `vram_upload_flags = 1` | A, Y (X restored) | r D01-D05; w `choice_result` (`$03D0`), `vram_upload_flags`; r `$03F7` |
| C02 | `Cop02_PromptYesNo` (`cop_handler_0057BD`) | 22461 / 56 | A3 (H036) | D01 | none (the string is the fixed `asciistring_014F02`, `LDY #$&lib_014F02.asciistring_014F02`) | Yes (index 0) skips the jump operand; No or cancel takes the jump | A, Y (X restored) | r D01; r `$03F7`; w `vram_upload_flags` |
| C03 | `code_012281` (proposed `RunChoiceMenu`, B, code) | 74369 / 138 | **none (gap)** | the window geometry of 1.1 | `A` = option count (stored in `$03C4`, 8-bit; the count is never above 3), `X` = BG3 byte offset of the first option's cursor cell, M = 8 | returns in `A` the selected index (0 based; the value was kept on the stack: `XBA; PHA`), carry clear = confirmed (bit `$80` of the high byte of `joy_pressed`, i.e. `$8000` = B), carry set = cancelled (bit `$40`, `$4000` = Y); Up (`$08`) and Down (`$04`) move the cursor by one option, clamped at both ends; a blink loop runs while no button is down (`code_01230B`: arrow tile `$2B` for 24 of 32 frames, blank `$20` for 8); the cursor tile is cleared to `$2B` on exit, DBR unchanged | `A`, `X`, `Y` (loop uses `TXY`), `$03C6` (blink counter) | w `$03C4`, `$03C6`, `bg3_tilemap_buffer` and `$7F6FC0` at X, `vram_upload_flags`; r joypad via `code_013169` |
| C04 | `code_001512` (`common_actor_001A28_part1`) | 5394 / 118 | **none (no batch; the player actor `common_actor_001A28` is outside A1-A7; FM-A3 H064/H066 only cite it)** | D07 | `$1B5E` (`equipped_weapon`), `player_level_bcd` (`$1B6A`), `joy_pressed`, `$0439`, `$0464`; Y = `player_actor` | clears `joy_pressed` bit `$8000` when the level is below the minimum of the equipped sword (or `$C000` when `$0439 <> 0` or no sword); zeroes `joy_pressed` while `$0464 <> 0` | `A`, `Y` (`X` saved with `PHX`/`PLX` around the lookup) | r D07; r/w `joy_pressed`; r `$0464`, `$0439`, `$1B5E` |
| C05 | equipment description strings (`lib_0118FC_part13`) | 8 strings | A5 | D06, D07 | the menu renderer, `[06:2,&...word_0161CE+2k]` | prints the level of weapon k | (renderer) | r D06, D07 |
| C06 | `code_0108BB` = `ApplyMapPatchRect` (`lib_0108BB`) | 67771 / 283 | A4 (L020) | D10 rows 0-4 | `A` = patch index (0-4), `X` saved; uses `dp$00`, `$02`, `$0C`, `$0E`, `$16`, `$18` | copies a rectangle of 16x16 blocks (tile index `$7E8000` and type `tile_type_map`) from the source to the destination and queues the visible blocks for redraw | `A`, `Y`, `dp$00-$18` | r D10 +0..+7; w `$7E8000`, `tile_type_map`; r `scroll_bg1_x`, `scroll_bg1_y` |
| C07 | `code_003188` = `RunLockedMapPatch`, `code_003194` = `ApplyMapPatchAndUnlock` (`engine_003005`) | 12680 / 12 and 12692 / 19 | A2 (X087, X088) | D10 rows 0-4 (via C06) | the actor's `$30` = patch index, set by the parent boss actor (`LDA #n; STA $30,Y`) | sets `joy_block_mask = $FFFF`, waits until `vram_write_queue` is empty, runs `BRK #$83`, calls C06, then `joy_block_mask = 0` and ends | `A`, `Y` | w `joy_block_mask`; r `vram_write_queue` |
| C08 | `code_0279B5` (`lib_027781_part3`, lines 42-103; scene init) | 162229 / 286 | **none (no batch; FM-A7 cites it as context)** | D10 +$28.. | `location_id` (`$1C6A`) | `map_width_pages` (`$0343`) and `map_height_pages` (`$0345`) = the two bytes at `D10 + $28 + 2 * location_id`; then the pointer cache and the map redraw | `A`, `X` | r `location_id`; w `map_width_pages`, `map_height_pages` |
| C09 | `code_007638` (`common_actor_00729D_part2`) | 30264 / 15 | none (FM-A6 ST01 cites it as the caller) | D09 | `PHX; LDY #$&lib_016264.asciistring_016264; JSL code_0126CF (ScrollStaffRollText, A6 ST01); PLX` | the staff roll; then `COP [1B]` waits `$F0` frames and continues in `code_007647` (`COP [31]`, another `$F0`-frame wait, then `code_007650`: `COP [10]` spawn of actor `$0D00`, `$1B82 = 0`, `$03B4 = $20`, `INC $0454`, `COP [91]`) | `A`, `Y` (X saved) | r D09; w `$1B82`, `$03B4`, `$0454` |

The five patch-rectangle indices are fixed by the five boss actors (each passes its own index to the child spawned by `COP [85] @engine_003005.code_003188`): `common_actor_0031AD` (Metal Mantis) 0, `common_actor_0033C6` (the three statues) 1, `common_actor_004299` (Poseidon) 2, `common_actor_004659` (Tin Doll) 3, `common_actor_004D8B` (Deathtoll the Mage) 4. The locations are the boss rooms of the crosswalk (14): `0C`, `22`, `44`, `59`, `7C`.

## 3. Data rows

### 3.1 Blocks

| ID | Label | Off / size | Callers | Name (conf, evidence) | Content |
|----|-------|-----------|---------|----------------------|---------|
| D01 | `asciistring_014F02` | 85762 / 19 | 19 refs in 18 files: `Cop02` (`cop_handler_0057BD`), 16 `COP [1A]` sites (`w0_actor_0180F7`, `_0186A2`, `_0191D2`, `_019CDE`, `_01B33A`; `w1_actor_01B98D`, `_01C57B`, `_01CC61`; `w2_actor_0F82DD`, `_0F98F5`; `w4_actor_022B80`, `_0232B3`; `w5_actor_024597`, `_02494A`, `_024E53`, `_025E61_part2`), `common_actor_00766C` x 2 | `ChoiceYesNoText` (A; code, cons) | `[CUR:288][07:4,4] Yes[N][N] No[CUR:30A]` |
| D02 | `asciistring_014F15` | 85781 / 14 | 1 (`w0_actor_01A440`, count 1) | `ChoiceYesOnlyText` (A; code, cons) | `[CUR:308][07:4,2] Yes[CUR:38A]` |
| D03 | `asciistring_014F23` | 85795 / 32 | 1 (`common_actor_00766C`, count 3) | `ChoiceRecordMoveQuitText` (A; code, cons) | `[CUR:208][07:7,6] Record[N][N] Move [N][N] Quit[CUR:28A]` |
| D04 | `asciistring_014F43` | 85827 / 24 | 1 (`common_actor_00766C`, count 2) | `ChoiceRecordQuitText` (A; code, cons) | `[CUR:288][07:7,4] Record[N][N] Quit[CUR:30A]` |
| D05 | `asciistring_014F5B` | 85851 / 25 | 6 (`w0_shared_01AD1B`, `w1_shared_01E4E9`, `w2_shared_0FA46D`, `w3_shared_021EFB`, `w4_shared_023E00`, `w5_shared_026DF2`: one per world, count 2) | `ChoiceStayGoBackText` (A; code, cons) | `[CUR:288][07:8,4] Stay[N][N] Go back[CUR:30A]`. All six callers follow a `COP [01]` line `[10]Would you like to return to <hub>? ` (hubs: Grass Valley, GreenWood, the Seabed Palace, the location of the Mountain of Souls, Dr. Leo's Laboratory, the outside of Magridd Castle; read from the strings next to each caller). Stay (index 0) says "Come back whenever you feel like returning"; Go back (index 1) says "Allright, please continue", does `INC $042D` (`contact_lock`) and spawns the warp actor with `COP [10]` (read for world 0 and world 3, the other four have the same code shape) |
| D06 | `asciistring_list_014F74` | 85876 / 882 (130 list + 752 strings) | 65 `[TBL]` readers in 2 files: `asciistring_016216` (`lib_0109D6_part4`, chest item) and the 64 equipment description strings of `lib_0118FC_part13` (the lair strings of `lib_010EA9_part3` use another list, `asciistring_list_0152E6`) | `ItemNameList` (A; code, cons) | 65 words + 65 strings (3.2) |
| D07 | `word_0161CE` | 90574 / 16 | 9 (`code_001512` 1, `lib_0118FC_part13` 8) | `WeaponMinLevelBcd` (A; code, cons, walk) | 8 BCD words, 1.3 |
| D08 | `asciistring_016246` | 90694 / 30 | 5 (`TryOpenChest` 1 head; 4 `[JMP ...+M]` from `lib_0109D6_part4` x 2 and `lib_010EA9_part3` x 2) | `ChestGemsFoundText` (A; code, cons). The shared tail is the `+M` entry (section 6) | `[10] [02:2] found[N][03:24][06:3,03C8] GEMs-[03:20]` `[::]` `[12][08:408][END]` |
| D09 | `asciistring_016264` | 90724 / 1597 | 1 (`code_007638`, `LDY #`) | `StaffRollText` (A; code, cons) | 1.6 |
| D10 | `unk14_017504` | 95492 / 296 | 2 files (`lib_0108BB` 6 reads of `+0..+7`, `lib_027781_part3` 2 reads `+28`, `+29`) | `MapPatchAndSizeTable` (B; code, cons) as one label; two labels if the block is split: `MapPatchTable` (rows 0-4) and `MapSizeTable` (128 entries) (section 7) | 1.4, 4.1, 4.2, 3.3 |

### 3.2 Item names (D06, 65 strings)

Sizes include the terminator. A size smaller than the printed length plus one means the string uses dictionary bytes (`lookup_108000`): `00` = `not `, `01` = `of `, `08` = `The `, `1B` = `a `, `1C` = `Dream `, `20` and `29` = `the `, `23` and `27` = `a `, `3B` = `Green `, and the four `X s` names (`19`, `1D`, `1F`, `21`) = a literal blank then the dictionary word `s ` (`$D7`): the ROM text has no apostrophe glyph in those names (the extractor prints a blank, the walkthrough writes `Goat's Food`; OQ-I004-6 lists the spellings). "Walkthrough" is the name used in `docs/walkthrough/` (crosswalk 4); status A = same name, D = DISCREPANCY (OQ-I004-6). Proposed label for every row: `ItemName<id>` (A; code, cons, walk), id as two hex digits (a descriptive suffix is possible; the id form avoids the two identical `Leaves` strings and the four spellings that are still open).

| id | Label | Off / `$02:` | Size | ROM text | Walkthrough | Status |
|----|-------|--------------|------|----------|-------------|--------|
| 00 | `asciistring_014FF6` | 86006 / `CFF6` | 10 | not equipped | (menu empty slot) | A |
| 01 | `asciistring_015000` | 86016 / `D000` | 12 | Sword of Life | Sword of Life | A |
| 02 | `asciistring_01500C` | 86028 / `D00C` | 13 | Psycho Sword | Psycho Sword | A |
| 03 | `asciistring_015019` | 86041 / `D019` | 15 | Critical Sword | Critical Sword | A |
| 04 | `asciistring_015028` | 86056 / `D028` | 12 | Lucky Blade | Lucky Blade | A |
| 05 | `asciistring_015034` | 86068 / `D034` | 15 | Zantetsu Sword | Zantetsu Sword | A |
| 06 | `asciistring_015043` | 86083 / `D043` | 13 | Spirit Sword | Spirit Sword | A |
| 07 | `asciistring_015050` | 86096 / `D050` | 15 | Recovery Sword | Recovery Sword | A (the dialogue says `Recover Sword`: OQ-I004-6) |
| 08 | `asciistring_01505F` | 86111 / `D05F` | 12 | The Soul Blade | Soul Blade | A (article `The` only in the ROM) |
| 09 | `asciistring_01506B` | 86123 / `D06B` | 11 | Iron Armor | Iron Armor | A |
| 0A | `asciistring_015076` | 86134 / `D076` | 10 | Ice Armor | Ice Armor | A |
| 0B | `asciistring_015080` | 86144 / `D080` | 13 | Bubble Armor | Bubble Armor | A |
| 0C | `asciistring_01508D` | 86157 / `D08D` | 12 | Magic Armor | Magic Armor | A |
| 0D | `asciistring_015099` | 86169 / `D099` | 13 | Mystic Armor | Mystic Armor | A |
| 0E | `asciistring_0150A6` | 86182 / `D0A6` | 12 | Light Armor | Light Armor | A |
| 0F | `asciistring_0150B2` | 86194 / `D0B2` | 15 | Elemental Mail | Elemental Mail | A |
| 10 | `asciistring_0150C1` | 86209 / `D0C1` | 11 | Soul Armor | Soul Armor | A |
| 11 | `asciistring_0150CC` | 86220 / `D0CC` | 11 | Flame Ball | Flame Ball | A |
| 12 | `asciistring_0150D7` | 86231 / `D0D7` | 12 | Light Arrow | Light Arrow | A |
| 13 | `asciistring_0150E3` | 86243 / `D0E3` | 12 | Magic Flair | Magic Flair | A |
| 14 | `asciistring_0150EF` | 86255 / `D0EF` | 8 | Rotator | Rotator | A |
| 15 | `asciistring_0150F7` | 86263 / `D0F7` | 11 | Spark Bomb | Spark Bomb | A |
| 16 | `asciistring_015102` | 86274 / `D102` | 13 | Flame Pillar | Flame Pillar | A |
| 17 | `asciistring_01510F` | 86287 / `D10F` | 8 | Tornado | Tornado | A |
| 18 | `asciistring_015117` | 86295 / `D117` | 8 | Phoenix | Phoenix | A |
| 19 | `asciistring_01511F` | 86303 / `D11F` | 11 | Goat s Food | Goat's Food | A (apostrophe) |
| 1A | `asciistring_01512A` | 86314 / `D12A` | 12 | Harp string | Harp String | A (case) |
| 1B | `asciistring_015136` | 86326 / `D136` | 6 | a pass | A Pass / Clubhouse Pass | A (case, OQ-I004-6) |
| 1C | `asciistring_01513C` | 86332 / `D13C` | 5 | Dream Rod | Dream Rod | A |
| 1D | `asciistring_015141` | 86337 / `D141` | 11 | Leo s brush | Leo's Brush | A (case, apostrophe) |
| 1E | `asciistring_01514C` | 86348 / `D14C` | 7 | Leaves | Leaves | A |
| 1F | `asciistring_015153` | 86355 / `D153` | 13 | Mole s Ribbon | Mole's Ribbon | A (apostrophe) |
| 20 | `asciistring_015160` | 86368 / `D160` | 11 | the Big Pearl | Big Pearl | A (article) |
| 21 | `asciistring_01516B` | 86379 / `D16B` | 15 | Mermaid s Tears | Mermaid's Tears | A (apostrophe) |
| 22 | `asciistring_01517A` | 86394 / `D17A` | 15 | Mushroom Shoes | Mushroom Shoes | A |
| 23 | `asciistring_015189` | 86409 / `D189` | 12 | a mobile key | A Mobile Key | A (case) |
| 24 | `asciistring_015195` | 86421 / `D195` | 13 | Thunder Ring | Thunder Ring | A |
| 25 | `asciistring_0151A2` | 86434 / `D1A2` | 16 | Delicious Seeds | Delicious Seeds | A |
| 26 | `asciistring_0151B2` | 86450 / `D1B2` | 7 | Leaves | Actinidia Leaves | **D** (OQ-I004-6; same text as id 1E) |
| 27 | `asciistring_0151B9` | 86457 / `D1B9` | 10 | a door key | A Door Key | A (case) |
| 28 | `asciistring_0151C3` | 86467 / `D1C3` | 14 | Platinum Card | Platinum Card | A |
| 29 | `asciistring_0151D1` | 86481 / `D1D1` | 10 | the VIP Card | VIP Card | A (article) |
| 2A | `asciistring_0151DB` | 86491 / `D1DB` | 9 | Emblem A | Master's Emblem A | **D** (OQ-I004-6) |
| 2B | `asciistring_0151E4` | 86500 / `D1E4` | 9 | Emblem B | Master's Emblem B | **D** |
| 2C | `asciistring_0151ED` | 86509 / `D1ED` | 9 | Emblem C | Master's Emblem C | **D** |
| 2D | `asciistring_0151F6` | 86518 / `D1F6` | 9 | Emblem D | Master's Emblem D | **D** |
| 2E | `asciistring_0151FF` | 86527 / `D1FF` | 9 | Emblem E | Master's Emblem E | **D** |
| 2F | `asciistring_015208` | 86536 / `D208` | 9 | Emblem F | Master's Emblem F | **D** |
| 30 | `asciistring_015211` | 86545 / `D211` | 9 | Emblem G | Master's Emblem G | **D** |
| 31 | `asciistring_01521A` | 86554 / `D21A` | 9 | Emblem H | Master's Emblem H | **D** |
| 32 | `asciistring_015223` | 86563 / `D223` | 15 | Red+Hot Mirror | Red-Hot Mirror | A (the `+` glyph prints as a hyphen, FM-A7 3.3) |
| 33 | `asciistring_015232` | 86578 / `D232` | 13 | Red+Hot Ball | Red-Hot Ball | A |
| 34 | `asciistring_01523F` | 86591 / `D23F` | 14 | Red+Hot Stick | Red-Hot Stick | A |
| 35 | `asciistring_01524D` | 86605 / `D24D` | 15 | Power Bracelet | Power Bracelet | A |
| 36 | `asciistring_01525C` | 86620 / `D25C` | 16 | Shield Bracelet | Shield Bracelet | A |
| 37 | `asciistring_01526C` | 86636 / `D26C` | 15 | Super Bracelet | Super Bracelet | A |
| 38 | `asciistring_01527B` | 86651 / `D27B` | 13 | Medical Herb | Medical Herb | A |
| 39 | `asciistring_015288` | 86664 / `D288` | 15 | Strange Bottle | Strange Bottle | A |
| 3A | `asciistring_015297` | 86679 / `D297` | 12 | Brown Stone | Brown Stone | A |
| 3B | `asciistring_0152A3` | 86691 / `D2A3` | 7 | Green Stone | Green Stone | A |
| 3C | `asciistring_0152AA` | 86698 / `D2AA` | 11 | Blue Stone | Blue Stone | A |
| 3D | `asciistring_0152B5` | 86709 / `D2B5` | 13 | Silver Stone | Silver Stone | A |
| 3E | `asciistring_0152C2` | 86722 / `D2C2` | 13 | Purple Stone | Purple Stone | A |
| 3F | `asciistring_0152CF` | 86735 / `D2CF` | 12 | Black Stone | Black Stone | A |
| 40 | `asciistring_0152DB` | 86747 / `D2DB` | 11 | Magic Bell | Magic Bell | A |

The sizes add up: the 65 rows sum to 752 (86006 to 86758), the same figure as `blocks.json`. The 8 + 8 + 8 + 40 + 1 grouping of the ids matches `items.md` (8 swords, 8 armours, 8 magic spells, 40 key items). The walkthrough name column is repeated from crosswalk 4 and was not re-derived; no row is new. The DISCREPANCY rows keep their id-based names until OQ-I004-6 is decided (crosswalk rule: a name with a DISCREPANCY keeps the old label).

### 3.3 Live map size per location (D10, offset +$28, 128 entries)

`Loc` = `location_id` (the id of the profile and of the location name banner, FM-A7 3.3); `Name` = the ROM name as printed in FM-A7 3.3 (apostrophe prints as a blank). `Live` = the table entry (width x height in 256-pixel pages: 1 page = 16 x 16 blocks of 16 pixels, stored as `map_width_pages` / `map_height_pages`). `Stream` = the width and height bytes at the head of the tilemap stream that the asset list loads for the location (read with `xxd` from the `.map` files; "n/a" = the location has no type-1 tilemap in its record, a jump record, or a Mode 7 map, so nothing to compare). `Relation`: `=` equal; `H+k` the stream has k extra page rows; `W+1` one extra page column; `x4` the stream height is 4 times the live height (four slabs of the live size, one after another).

The 31 ids that have no profile (`0000` in the profile list) have size `00,00` in this table: `25`-`27`, `35`-`3B`, `48`-`4F`, `5D`-`63`, `74`-`77`, `7E`, `7F` (3 + 7 + 8 + 7 + 4 + 2 = 31; the zero entries align exactly with the profile list). Nothing else is zero.

| Loc | Name | Live | Stream | Relation |
|-----|------|------|--------|----------|
| 00 | Grass Valley Shrine | 1x1 | 1x1 | = |
| 01 | Grass Valley highlands | 4x4 | 4x16 | x4 |
| 02 | Child s secret passage | 1x1 | 1x1 | = |
| 03 | Treasure room | 1x1 | 1x1 | = |
| 04 | The village Chief s room | 1x1 | 1x1 | = |
| 05 | Underground Castle, west | 5x4 | 5x4 | = |
| 06 | Underground Castle, east | 4x4 | 4x4 | = |
| 07 | Leo s Paintings | 1x4 | 1x4 | = |
| 08 | Leo s Paintings | 4x1 | 5x1 | W+1 |
| 09 | Leo s Paintings | 2x2 | 2x2 | = |
| 0A | Tulip s Dream | 1x1 | 1x1 | = |
| 0B | Leo s Paintings | 1x4 | 1x5 | H+1 |
| 0C | Monster in the paintings | 1x1 | 1x1 | = |
| 0D | Trial room | 1x1 | 1x1 | = |
| 0E | Lisa s dream | 4x4 | 4x4 | = |
| 0F | (empty) | 2x2 | 2x3 | H+1 |
| 10 | (empty, Mode 7) | 1x1 | n/a | |
| 11 | (empty) | 2x1 | 2x1 | = |
| 12 | (empty) | 1x1 | n/a | |
| 13 | (empty) | 4x4 | n/a | |
| 14 | GreenWood Shrine | 1x1 | n/a | |
| 15 | Woods of GreenWood | 3x3 | 3x12 | x4 |
| 16 | A mole s hole | 2x2 | 2x2 | = |
| 17 | A squirrel s house | 1x1 | 1x1 | = |
| 18 | Squirrel, the Exchanger | 1x1 | 1x1 | = |
| 19 | Lostside, a marsh | 2x6 | 2x7 | H+1 |
| 1A | Water Shrine | 2x2 | 2x3 | H+1 |
| 1B | Water Shrine | 3x3 | 3x4 | H+1 |
| 1C | Water Shrine | 4x4 | 4x5 | H+1 |
| 1D | Fire Shrine | 2x2 | 2x3 | H+1 |
| 1E | Fire Shrine | 3x3 | 3x4 | H+1 |
| 1F | Fire Shrine | 4x4 | 4x4 | = |
| 20 | Light Shrine | 3x3 | 3x4 | H+1 |
| 21 | Light Shrine | 4x4 | 4x4 | = |
| 22 | Tomb of a stone statue | 2x1 | 2x1 | = |
| 23 | Bird s Dream | 2x2 | 2x2 | = |
| 24 | Stump s Dream | 3x3 | 3x12 | x4 |
| 28 | St. Elles Shrine | 1x1 | n/a | |
| 29 | The Seabed Sanctuary | 4x4 | 4x16 | x4 |
| 2A | The Seabed of St. Elles | 8x3 | 8x4 | H+1 |
| 2B | The Secret Cave | 1x2 | 1x3 | H+1 |
| 2C | The Secret Cave | 2x1 | 2x1 | = |
| 2D | A dolphin s dream | 8x4 | 8x4 | = |
| 2E | Southerta | 4x4 | 4x6 | H+2 |
| 2F | Shore reef of Rockbird | 3x3 | 3x6 | H+3 |
| 30 | Durean | 4x4 | 4x5 | H+1 |
| 31 | Blester | 4x4 | 4x6 | H+2 |
| 32 | A ghost ship | 1x5 | 1x5 | = |
| 33 | Servas dream | 1x5 | n/a | |
| 34 | The Seabed of St. Elles | 8x4 | 8x4 | = |
| 3C | The Soul s Sanctuary | 1x1 | n/a | |
| 3D | Soul of Mountain House | 4x4 | 4x16 | x4 |
| 3E | Mountain, north and slope | 3x4 | 3x5 | H+1 |
| 3F | Aurora s Ridge | 3x3 | 3x4 | H+1 |
| 40 | An old man s dream | 3x3 | 3x4 | H+1 |
| 41 | A passage to Lune | 3x4 | 3x6 | H+2 |
| 42 | Underground lake, Lune | 3x4 | 3x7 | H+3 |
| 43 | A mushroom s dream | 3x4 | 3x7 | H+3 |
| 44 | Poseidon | 2x1 | 2x1 | = |
| 45 | The top of Snow Mountain | 3x3 | 3x4 | H+1 |
| 46 | An ice hill | 2x6 | 2x7 | H+1 |
| 47 | Ice field of Laynole | 4x4 | 4x5 | H+1 |
| 50 | The Laboratory Shrine | 1x1 | n/a | |
| 51 | Leo s Laboratory | 2x2 | 2x8 | x4 |
| 52 | Leo s Laboratory | 2x2 | 2x8 | x4 |
| 53 | An attic | 1x1 | 1x1 | = |
| 54 | A mice nest | 2x1 | 2x1 | = |
| 55 | A cat s dream | 2x2 | 2x8 | x4 |
| 56 | Basement of Laboratory | 4x4 | 4x5 | H+1 |
| 57 | Basement of Laboratory | 2x6 | 2x7 | H+1 |
| 58 | power plant | 4x4 | 4x6 | H+2 |
| 59 | Tin Doll | 2x2 | 2x2 | = |
| 5A | A dream | 2x6 | 2x7 | H+1 |
| 5B | Model of a town | 4x4 | 4x5 | H+1 |
| 5C | Model of a town | 4x4 | 4x6 | H+2 |
| 64 | Magridd Castle Shrine | 1x1 | n/a | |
| 65 | Castle of King Magridd | 4x4 | 4x16 | x4 |
| 66 | The torture chamber | 3x3 | 3x4 | H+1 |
| 67 | Basement of the castle | 3x3 | 3x5 | H+2 |
| 68 | Basement of the castle | 4x4 | 4x5 | H+1 |
| 69 | A dream | 4x4 | 4x5 | H+1 |
| 6A | The left tower | 2x2 | 2x3 | H+1 |
| 6B | The left tower | 2x2 | 2x3 | H+1 |
| 6C | A prison | 2x2 | 2x4 | H+2 |
| 6D | The right tower | 2x2 | 2x3 | H+1 |
| 6E | The right tower | 2x2 | 2x4 | H+2 |
| 6F | The right tower | 2x2 | 2x3 | H+1 |
| 70 | A corridor to the dock | 3x2 | 3x3 | H+1 |
| 71 | The dock for an airship | 3x3 | 3x3 | = |
| 72 | The deck of an airship | 3x3 | n/a | |
| 73 | A soldier s dream | 3x3 | n/a | |
| 78 | The Evil World Shrine | 1x1 | n/a | |
| 79 | World of Evil | 3x6 | 3x7 | H+1 |
| 7A | World of Evil | 2x4 | 2x5 | H+1 |
| 7B | Dazzling Space | 2x4 | 2x5 | H+1 |
| 7C | Deathtoll s Shrine | 1x3 | 1x3 | = |
| 7D | Battle with Deathtoll | 1x1 | 1x1 | = |

Tally over the 85 comparable locations: 31 equal, 9 `x4`, 1 `W+1` (location `08`), 33 `H+1`, 8 `H+2`, 3 `H+3`; 12 locations are n/a (`10`, `12`, `13`, `14`, `28`, `33`, `3C`, `50`, `64`, `72`, `73`, `78`). The stream is never smaller than the live size. For the four-slab locations the `unk13` staging coordinates of FM-A7 4.3 run past the live height (location `24`: live 48 block rows, staging y up to `$5C` = 92, i.e. slab 1 of 4). Location `13` (stream n/a above) has live 64 block rows and staging y up to `$ED` = 237, so it must have slabs too. For the 45 locations with `H+k` or `W+1`, 42 have no `unk13` row at all (the exceptions are `0F`, `42`, `7B`); what the extra rows hold is OQ-I012-1.

## 4. Structure layouts

### 4.1 `MapPatchRect` (8 bytes, rows 0-4 of D10; the extractor type is `unk14`: `Byte, Byte, Byte, Byte, Word, Word`)

Index `n` is multiplied by 8 in `code_0108BB` (`ASL` x 3).

| Offset | Width | Field | Evidence |
|--------|-------|-------|----------|
| +0 | byte | destination x, in 16-pixel blocks | `LDA +0; AND #$00FF; ASL x4; STA dp$00` (pixel x of the destination, `lib_0108BB` lines 67795-67806) |
| +1 | byte | destination y, in blocks | same, `STA dp$18` (67808-67819) |
| +2 | byte | width in blocks | `AND #$00FF; STA dp$02` (the inner column counter `dp$0C` is reloaded from `dp$02` per row: lines 67844-67846) |
| +3 | byte | height in blocks | `AND #$00FF; STA dp$0E` (row counter) |
| +4 | word | source x in **pixels** | `LDA +4; STA dp$16` (67777-67781) before `code_0272B8` computes the source tile index |
| +6 | word | source y in pixels | `LDA +6; STA dp$18` (67783-67787) |

Why the widths are as stated: a word is needed at +4 and +6 because `$0130` and `$0120` do not fit a byte (rows 1 and 3); the four byte fields are masked with `AND #$00FF` after a 16-bit load, the mark of a byte read, and are all below `$0D`; the struct is 8 bytes because `code_0108BB` steps by `ASL x3`. The five records:

| n | Dest (x, y) blocks | Size w x h | Source px (x, y) | Source blocks | Boss actor | Location |
|---|-------------------|-----------|------------------|---------------|------------|----------|
| 0 | (6, 11) | 4 x 3 | (`$0020`, `$00B0`) | (2, 11) | `common_actor_0031AD` Metal Mantis | `0C` (1x1) |
| 1 | (13, 11) | 6 x 3 | (`$0130`, `$00B0`) | (19, 11) | `common_actor_0033C6` statues | `22` (2x1) |
| 2 | (14, 12) | 4 x 2 | (`$0070`, `$00C0`) | (7, 12) | `common_actor_004299` Poseidon | `44` (2x1) |
| 3 | (14, 0) | 1 x 9 | (`$0120`, `$0000`) | (18, 0) | `common_actor_004659` Tin Doll | `59` (2x2) |
| 4 | (6, 11) | 4 x 3 | (`$0020`, `$00B0`) | (2, 11) | `common_actor_004D8B` Deathtoll the Mage | `7C` (1x3) |

Records 0 and 4 are identical (OQ-I012-3). For each record the destination rectangle lies inside the live map of its location (checked against 3.3: e.g. record 1 ends at x = 18 < 32 blocks, record 3 at y = 8 < 32). Whether the source rectangle is another part of the same live map or a part of the extra stream rows is not decided by the code (`code_0272B8` turns any pixel position into a tile index inside the `W x H`-page map): OQ-I012-2.

The copy itself (`code_0108BB`): for every cell the source block id (`$7E8000`) and type (`tile_type_map`) are read, the destination index is computed with `code_0272B8` and both are written, then, if the destination is within the visible window (`pixel + 16 - scroll` below `$111` on both axes), the block is queued for redraw via `$7E2000`. It is a copy, not a swap.

### 4.2 `MapSizeEntry` (2 bytes, 128 entries at D10 + `$28`)

| Offset | Width | Field | Evidence |
|--------|-------|-------|----------|
| +0 | byte | live map width in pages | `LDA table+28, X; STA map_width_pages` with `X = location_id * 2` (`lib_027781_part3` lines 96-98; the 8-bit store follows `SEP #$20`) |
| +1 | byte | live map height in pages | `LDA table+29, X; STA map_height_pages` (lines 98-99) |

Index is `location_id` (`$1C6A`, 8-bit range `$00`-`$7F`): 128 entries x 2 = 256 bytes, which is the exact size left in the block after the five patch records (1.4). `map_width_pages` is the page stride of `code_0272B8` (the tile index is `page_x`, `page_y` times the width in pages, times 256, plus the in-page index) and the strip code wraps at `W x H` pages, so a wrong entry would corrupt the map; the zero entries (no profile) are the ids the scene loader never enters. Entries stay 8-bit because every value is `1`-`8` and the loader stores a byte.

### 4.3 Choice window string

See 1.1. Layout: `01 <o:2>` (`[CUR]`), `07 <w> <h>`, per option: `20` (blank, cursor column), the option text, `0D 0D` (`[N]` x 2) except after the last option, `01 <o+$82:2>`, `00`. (`[CUR]` = `01` + word, `[07]` = `07` + 2 bytes, per `us/stringTypes.json`.)

### 4.4 Item name list

`word[65]` of bank-`$02` string offsets, then the 65 `00`-terminated strings in id order. Word `k` points at the string of item id `k`. A string number from `[TBL]` is the item id (items `$01`-`$40`; id `$00` prints `not equipped`).

### 4.5 `WeaponMinLevelBcd`

`word[8]`, index = weapon number - 1 (item ids `$01`-`$08`). The value is a BCD level in the low byte; the high byte is `00` in all eight. `CMP player_level_bcd` compares the whole word with `player_level_bcd` (`$1B6A`, 16-bit BCD), and the description strings print two digits (`[06:2]`).

### 4.6 Chest message tail (`asciistring_016246`)

Head (25 bytes): `10`, blank, `[02:2]`, ` found`, `[N]`, `[03:24]`, `[06:3,$03C8]`, ` GEMs-`, `[03:20]`; entry `+M` (+25): `12` (wait key), `08 08 04` (`[08:$0408]` erase), `00`. Other strings enter at `+M` through `[JMP:&...+M]` (1.5).

### 4.7 Staff roll

One `00`-terminated string, no table. Lines are separated by `[N]`; a heading is `[14:4]` (4 blanks) + text, a name line is `[14:9]` + text, a title line `[14:3]`. The scroller prints one row per `[N]` and advances 32 frames per row (FM-A6).

## 5. WRAM and DP proposals

Existing names used: `joy_pressed` (`$0322`), `joy_block_mask` (`$0326`), `map_width_pages` (`$0343`), `map_height_pages` (`$0345`), `vram_upload_flags` (`$03B8`), `choice_result` (`$03D0`), `player_level_bcd` (`$1B6A`), `location_id` (`$1C6A`), `vram_write_queue` (`$1C7B`), `scroll_bg1_x/y` (`$033A/$033C`), `scroll_bg3_y` (`$0388`), `tile_type_map` (`$7F8000`), `bg3_tilemap_buffer` (`$7F7000`).

| Address | Meaning (this batch) | Proposal | Conf | Writers / readers |
|---------|----------------------|----------|------|-------------------|
| `$03C4` | option count of the choice being run (8-bit) | `menu_count` (A5 proposes it for the list or row count; the chooser stores its A there too) | B | w `code_012281`, A5 menu; r `code_012281` |
| `$03C6` | blink counter of the cursor tile (`AND #$1F`, below `$18` shows the arrow `$2B`, else blank `$20`) | `cursor_blink` | A | w/r `code_01230B`, `code_012281` |
| `$03C8` | value for the chest and lair messages: BCD gem count (`[06:3,$03C8]`) or the item id (`[TBL,$03C8]`) | `message_value` | B | w `TryOpenChest` (`lib_0109D6`), lair release; r the strings of 1.5 |
| `$03F7` | origin of the last `[07]` window (FM-A6 OQ-I007-17) | `text_box_pos` (A3 proposal) | B | w `code_012769`; r Cop02, Cop1A |
| `$7F6FC0 + X` | the BG3 row above the arrow cell (the arrow is two tiles tall: row above and row at `bg3_tilemap_buffer + X`) | part of the BG3 buffer (no name) | B | w `code_012281`, `code_01230B` |
| `$0458` | boss lock (A3) | unchanged | B | w the boss actors (not this batch) |
| `$1B5E` | equipped sword id `$01`-`$08` (index of D07) | `equipped_weapon` (FM-A1 proposal) | A | r `code_001512` and others |

DP scratch of `code_0108BB`: `dp$00` (dest pixel x), `dp$02` (width), `dp$0C` (column counter), `dp$0E` (row count), `dp$16` (pixel x, also the source), `dp$18` (pixel y). They are free scratch in the actor engine (not on the persistent list of the knowledge base, which is for IOG).

## 6. Inner labels

| Label | Offset | Where | Note |
|-------|--------|-------|------|
| `asciistring_016246+M` | 90694 + 25 = 90719 | D08, `[::]` marker | not a label of its own in the extract: the four other strings jump to it as `asciistring_016246+M`. A names row cannot target it. The tail is `[12][08:408][END]`. |

`code_012281` has inner labels (`loc_012289`, `loc_012298`, `loc_0122A2`, `loc_0122BA`, `loc_0122BF`, `loc_0122C2`, `loc_0122CE`, `loc_0122E3`, `loc_0122F8`) that are local to it; none is referenced from outside.

## 7. Fan-in, findings and placement

Fan-in (counted by `rg` over `extracted/`, a `?INCLUDE` line is not a reference): D01 19 refs / 18 files; D02 1; D03 1; D04 1; D05 6; D06 the list is read by `[TBL]` in 65 strings of 2 files; D07 9 (2 files); D08 5 (3 files); D09 1; D10 8 reads in 2 files. Sum of the sizes of the batch: 19+14+32+24+25+882+16+30+1597+296 = 2935 bytes.

Findings:

1. The batch has **no code**. Every row is data; its meaning is fixed by consumers in A2, A3, A4, A5, A6 and A7 (section 2).
2. **`unk14_017504` is not a table of 37 `unk14` rows.** It is five 8-byte map patch records followed by a 256-byte table of 128 two-byte live map sizes (1.4, 4.1, 4.2). The consumers, the block's end (95788 = 95492 + 40 + 256) and the zero entries (exactly the 31 locations without a profile) agree. The extractor's `unk14` view makes rows 5-36 look like structure; they are two-byte entries cut into groups of 8.
3. The five patch records are applied by the five boss actors through a child actor (`code_003188`: lock input, wait for the VRAM queue to drain, copy, unlock).
4. The live map size is smaller than the stream for 54 of the 85 comparable locations (33 + 8 + 3 + 1 plus 9 four-slab locations); the stream is never smaller.
5. `word_0161CE` is the sword minimum level table and also feeds the equipment description screen. All eight values match the walkthrough.
6. The five choice strings share one layout (1.1) and the `COP [1A]` count equals the number of options in all 27 uses.
7. The item name list has two identical strings (`Leaves`, ids `1E` and `26`) and eight `Emblem A`-`H` strings that the walkthrough calls `Master's Emblem`; all in OQ-I004-6, none new.
8. The credits contain `Soul Blader` once and `COPORATION` twice (OQ-I012-7).
9. `npm run rebuild` prints 27 `Cross bank call detected ... 'COP asciistring_...'` warnings (checked on this run). They are exactly the 27 `COP [1A]` uses of D01-D05 (18 of D01, 1 each of D02-D04, 6 of D05): the operand is a 2-byte `&` pointer into bank `$02` written in scripts of banks `$00`, `$03`-`$05`, `$0F`, which is correct because `code_012769` forces DBR `$02` (1.1). The warning is not a defect; PC and PD should not "fix" it by moving the strings.

Placement and pins (for PB and PC):

- **Bank `$02` pins.** D01-D05 are referenced with 2-byte pointers from many banks and must keep the text renderer's forced DBR `$02` (`code_012769`). D06 is referenced by `&` from `[TBL]` in bank `$02` strings. D08 and D09 are `&` references inside bank `$02` text. D07 and D10 are read with long references (`$@`), so they could move to any bank, but D07 is also `&`-referenced from the bank `$02` description strings (`[06:2,&lib_0161CE.word_0161CE+2k]`), so D07 stays in bank `$02` as well.
- **Splitting D10.** To give each structure its own label and type, D10 would be split at offset 95532 (`$02:F52C`) into a 40-byte `MapPatchRect` array (typed with a struct of the 4.1 layout instead of `unk14`; the existing `unk14` struct in `us/structs.json` already has the right field widths, so it can keep its name or be renamed) and a 256-byte table of word entries. The two references `unk14_017504+28` and `unk14_017504+29` (hex 28 = 40) would then be `MapSizeTable+0` and `MapSizeTable+1`. `npm run blocks` has no operation that splits a part (it merges blocks, moves a part, renames a block and sets `scene`, `group`, `order`, `movable`), so this needs a decision (OQ-I012-4).
- **Naming hazards (PC).** (a) The 65 item strings need `ItemName<id>` or a descriptive scheme chosen once; two strings have identical text (ids `1E`, `26`) so a name derived from the text alone would collide. (b) `asciistring_016246+M` is not a nameable label. (c) `unk14_017504` renamed as one label (`MapPatchAndSizeTable`) keeps the extractor's misleading `unk14` rows; a rename does not fix the typing (finding 2). (d) The seven proposals for strings do not clash with any existing name in `db-us`/`us/names` (they are all still `asciistring_*`, `word_*` and `unk14_*`).
- **Notes (PD).** The part notes of D10 must describe both structures; D07 should say that it is read by the player input filter and by the equipment description strings.

## 8. Open questions

All are in `plans/extracted-audit/questions/I012_questions.md`:

1. **OQ-I012-1** what the extra stream rows and the one extra column hold (R+S).
2. **OQ-I012-2** where the patch source rectangle lies (live map or extra rows) and what each of the five patches shows (R+S).
3. **OQ-I012-3** records 0 and 4 are identical (D).
4. **OQ-I012-4** how to split `unk14_017504` (tool gap, D).
5. **OQ-I012-5** confirm the size table against `$0343` / `$0345` at runtime (S).
6. **OQ-I012-6** the cursor sound and window effects of the chooser `BRK #$07` / `#$18` (R+S).
7. **OQ-I012-7** (DISCREPANCY) `Soul Blader` and `COPORATION` in the credits.
8. **OQ-I012-8** staff roll duration and end (answers the count part of OQ-I010-12).
9. **OQ-I012-9** which event flag selects the three-option shrine menu (word `$9B00`).
10. **OQ-I012-10** `Goat s`, `Leo s`, `Mole s`, `Mermaid s`: blank plus `s ` in the ROM; is the apostrophe drawn by the blank tile or absent?
11. **OQ-I012-11** are the five choice windows placed as the geometry says (bottom border at BG3 row 15, arrow on the first option) when drawn in game (S).
12. **OQ-I012-12** do the two identical `Leaves` strings (ids `1E`, `26`) show with different descriptions in the equipment menu (S, ties to OQ-I004-6).
