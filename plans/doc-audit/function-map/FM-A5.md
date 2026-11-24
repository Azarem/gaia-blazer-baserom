# FM-A5: library `0118` (`lib_01185E`, `lib_01186E`, `lib_0118FC` and its parts 2-13)

PA batch A5, iteration I009. Read-only analysis: no names, notes, comments, `blocks.json`, `overrides.json` or docs were changed. Every proposed name below is a proposal for step PC (`npm run names`); every unverified claim is an `OQ-I009-k` row in `plans/extracted-audit/questions/I009_questions.md`. (A4 owns I008; the number was chosen so that A4 and A5 can run in parallel.)

Source: a fresh `npm run extract:lt` of `extracted/library/`. Fifteen files were read end to end; offsets are decimal file offsets (the `{n}` tag; LoROM, so every A5 routine is in bank `$02` and the SNES address is `$02:(8000 + (offset - 65536))`, that is `$02:` plus the label suffix with `$8000` added to its low 15 bits: `code_0118FC` is at `$02:98FC`). Strings in `data_048000`/`data_04F000` that A5 reads live in bank `$09`.

| File | Offsets | Labels | Content (this batch's reading) |
|------|---------|--------|--------------------------------|
| `lib_01185E` | 71774-71790 | 1 | HDMA queue reset |
| `lib_01186E` | 71790-71932 | 2 (+1 sub-label row), 1 data | HDMA channel queue (direct and indirect) and the per-register DMAP table |
| `lib_0118FC` | 71932-73977 | 22 top-level (+23 sub-label rows) | field button dispatch, status and souls screen, talk-to-NPC probe, equipment menu, list choosers, icon drawing |
| `lib_0118FC_part2` | 74040-74369 | 1 (+1 sub-label row), 1 data | the menu row chooser (two variants) and its cursor-position table |
| `lib_0118FC_part3` | 74576-74640 | 2 | clear the BG3 text page (whole, upper half) |
| `lib_0118FC_part4` | 74730-74774 | 2 | CGRAM buffer backup and restore |
| `lib_0118FC_part5` | 74832-74990 | 3 | item-page palette, scene graphics and palette restore, equipped-magic graphics and palette |
| `lib_0118FC_part6` | 75353-75471 | 1 | HUD update and enemy gauge |
| `lib_0118FC_part7` | 78198-78220 | 1 | wait for vblank and switch the screen and NMI on |
| `lib_0118FC_part8` | 78242-78263 | 2 | NMI enable and disable |
| `lib_0118FC_part9` | 78312-78334 | 1 | hardware divide |
| `lib_0118FC_part10` | 78357-78406 | 1 | byte to packed BCD |
| `lib_0118FC_part11` | 83313-83531 | 3 strings | status screen text, souls screen title, first soul line |
| `lib_0118FC_part12` | 83615-83849 | 3 parts (+7 inner strings) | equipment and item menu frames, HUD strings, enemy gauge strings |
| `lib_0118FC_part13` | 87358-90574 | 4 parts (+65 description strings) | item description headers, the description pointer list and strings, name-index cells, gear stat table |

61 routine rows (L001-L061: 41 top-level labels of the code files plus 20 sub-label rows, each a separate entry point that needs its own override row in PC because the namespace is flat) and 23 data rows (D01-D23), plus the 65-row description table in section 3.2. The four soul lines `asciistring_01464B/014660/014675/01468A` are separate A7 files; they are listed (D04-D07) because `code_0119B7` walks them with one stride.

Context that the callee/caller reading relied on: `engine_000000` (main loop lines 118-240, NMI lines 510-545), `lib_shared_012769` (text renderer `code_012769`, `code_013169`), `lib_shared_01230B` (cursor blink), `lib_shared_012390`/`012416` (menu graphics, A6), `lib_0273D4`, `lib_0273EB`, `lib_027781_part1` (`code_0273F9`), `lib_027462_part1` (`code_0272B8`), `lib_027781_part3`, `lib_02719F`, `lib_0275ED`, `lib_027614`, `engine_0064F8` (`code_00651E`), `cop_handler_005888` (Cop0B), `common_actor_001A28_part1` (min swing level), `engine_006B7F` (title menu), `data_00F9F7` (icon positions, facing table, magic graphics and palette pointer tables), `data_048000` (`unk17_048800` icon records), `data_04F000` (menu palettes), `docs/walkthrough/items.md`, `magic.md`, `01-in-the-beginning.md`, `plans/doc-audit/walkthrough-crosswalk.md` and FM-A1/A2/A3.

## 0. Reading the tables

| Column | Meaning |
|--------|---------|
| Off / size | decimal file offset and size in bytes (distance to the next label; sub-label rows split the size of the label they sit in; the last row of a part ends at the part end in `us/blocks.json`) |
| Callers | reference count and files, from `rg` over `extracted/` (`JSL`, `JSR`, branches, `BRL`, pushed addresses); a bank byte and address word pushed for an `RTL` jump count as one site |
| Name (conf, evidence) | proposed `VerbNoun` name. Confidence: **A** behaviour fully read and independently corroborated (consumer, walkthrough, existing doc or name); **B** behaviour fully read, purpose inferred from code only; **C** guessed or dead code. Evidence labels: `code`, `callee`, `caller`, `cons`, `walk`, `doc`, `hw`, `dead` |
| In / Out | registers, DP and WRAM inputs and results. M/X widths are those at entry unless stated. D is 0 |
| Clobbers | registers and scratch that are not restored |
| Data touched | WRAM names from `us/mnemonics.json` where one exists, otherwise the raw address (proposals in section 4). `r` read, `w` write |

Actor fields are written `$nn,X` (FM-A1 section 4.1). DP scratch is written `dp$nn`. `BRK #n` is a sound request (`native_mode_brk_0055FC`, FM-A2 X001); `#$07` is used on every cursor step and `#$18` on every confirm (OQ-I009-12).

## 1. Models that several rows share

### 1.1 Where the A5 code runs in the main loop

`engine_000000` loop (lines 118-160): `code_0131B7` (wait for vblank, NMI on) -> `code_027781` (scene step) -> **`code_0118FC`** (L006, once per frame, M=8) -> `code_027572` -> `code_0131AE` (NMI off) -> the frame work (`code_01185E` resets the HDMA queue first, actors queue channels, `code_012659` draws the HUD near the end) -> `code_0131A2` (NMI on) -> loop. So the button dispatcher sees a fresh vblank, and every HUD or HDMA call happens with NMI off. Menus and screens opened from L006 take over the screen: they run their own frames with `code_0131B7` (always a vblank wait) or `lib_shared_012769.code_013169` (returns `joy_pressed+1`; when `$03D2` is 0 it runs the sub-frame `engine_000000.code_0001BE` instead of waiting, `code_013161`).

`code_0131A2` increments and `code_0131AE` zeroes `$03D2` (the `nmi_enabled` of FM-A1 section 5); the pair brackets the NPC talk script (L010) so the script runs with NMI off and drives its own frames.

### 1.2 HDMA channel queue (L001-L005)

Channels 4-7 are handed out one per call in a frame. State in DP: `$42` pending channel mask (copied to `HDMAEN` by the NMI, `engine_000000` line 518), `$44` next channel bit, `$46` offset of the next channel's register block from `$4300` (`$40` for channel 4), `$48` unread. `code_01185E` resets the queue at the start of each frame. `QueueHdmaDirect` and `QueueHdmaIndirect` take A.low = bank, **B = PPU register index** (`$21xx` low byte, `$00-$3F`), Y = table address; the caller loads the register index with `LDA #reg; XBA; LDA #bank; LDY #addr`. The register index is also the index into `binary_0118BC`, which holds the DMAP value (transfer mode, bit 7 for the read-only registers `$2134-$213F`). Direct mode uses a ROM or WRAM table as is; indirect mode (`DMAP or $40`) sets both `A1Bn` and `DASBn` to the bank, so the indirect table and its pointers are in the same bank (every caller passes `$7E`, a WRAM table at `$7800` or `$7000`).

There is no overflow guard. The fourth call (channel 7, `$46 = $70`) shifts `$80` out of `$44`, so the carry that `ADC #$10` then adds (there is no `CLC`) makes `$46 = $81`, and `$44` is 0. A fifth call would write `$4381-$4387` (not a DMA channel) and leave `$42` unchanged (OQ-I009-9). `LDX $46` is a 16-bit load; it relies on dp`$47` being 0 (no writer found, OQ-I009-9).

Decode anomaly: `code_01185E` is extracted with M=16 (`LDA #$8510` / `MVP`); the real code is `STZ $42; LDA #$10; STA $44; LDA #$40; STA $46; LDX #$6000; STX $48; RTL` (OQ-I005-7). PC needs `"71774": {"M": 1}` in `overrides.json` (A5 owns the block).

### 1.3 Button map of the field handler (L006)

`joy_pressed` is the raw `$4218` word with X copied into bit 13 (FM-A2 1.1); `$0323` is its high byte: `$80` B, `$40` Y, `$20` Select or X, `$10` Start, `$08` Up, `$04` Down, `$02` Left, `$01` Right. The low byte is `$80` A, `$40` X, `$20` L, `$10` R. L006 tests, in this order: **Select/X** (`$0323 & $20`) opens the equipment menu (L018); **B** (`$0323 & $80`) talks (L010); **A** (`joy_pressed` low byte `$80`) with no direction pressed (`$0323 & $0F == 0`) shows the status and souls screen (L007). Anything else returns. Walkthrough `01-in-the-beginning.md`: "Press the X Button to open the menu ... Press the B Button twice to equip ... Press the Y Button to exit the menu", "speak with him (B Button)". The A-button screen is not in the walkthrough (OQ-I009-5).

### 1.4 The inventory table and the slot byte

`inventory` (`$1B1E`) is one 64-byte table indexed by **item id minus 1** (`engine_0064F8.code_00651E`: `LDA $inventory,Y` with Y = id - 1; Cop0B `EOR $inventory,Y`). The four ranges that A5 treats as lists:

| Range | Ids | Slots | List base | Used by |
|-------|-----|-------|-----------|---------|
| weapons | `$01-$08` | 8 | `$1B1E` | `code_011DA3` (row 0) |
| armors | `$09-$10` | 8 | `$1B26` | `code_011DA3` (row 1) |
| magic | `$11-$18` | 8 | `$1B2E` | `code_011DA3` (row 2) |
| items | `$19-$40` | 40 | `$1B36` | `code_011FF2` (row 3); walkthrough grid position (r, c) is slot `(r-1)*10 + (c-1)` |

Slot byte: bits 0-6 = the item id (0 = not owned; the byte is the id of its own slot, which is how the crosswalk's grid rule `id = $19 + (r-1)*10 + (c-1)` works), **bit 7 = marker**. The marker is the equipped item in each list and, during a choice, the cursor: `code_011F67` draws a 2x2 selection frame (BG3 tile `$2A` and its three flips) around the icon of every slot with bit 7 set. Equipped state is stored twice: the marker in the list and the id in the word cells `$1B5E` (weapon), `$1B60` (armor), `$1B62` (magic), `$1B64` (item/bracelet/bell). The cells are read as words (`LDX $1B5E`, `[TBL:...,1B5E]` reads a word) and written as bytes (`STA $1B5E`); nothing writes the high bytes `$1B5F/$1B61/$1B63/$1B65`. FM-A1/A2 already propose `equipped_weapon`, `equipped_armor`, `equipped_magic`, `equipped_accessory`.

Choosing from a list (`code_011DA3`, `code_011FF2`): the cursor starts on the first slot with bit 7 set, or marks slot 0 when none is (slot 0 is marked even when empty; every reader masks with `$7F`, so the byte `$80` still means "not owned"). The list is backed up to `$7F0403` (`code_011EAB`; only the dead cancel paths restore it). A direction key moves the marker (clear on the old slot, set on the new, `$03C6` blink counter reset). Both **B and Y confirm** (`BRK #$18`, marker set on the slot, return A = id and carry clear); no live path cancels (L025, L040 are unreferenced). Selecting an empty slot returns 0, which the caller stores in the equipped cell: name index 0 is the string "not equipped" (`asciistring_014FF6`).

Weapons, armors and magic are laid out in two columns of four, column-major: Right = +4, Left = -4, Down = +1, Up = -1 (`word_00F9F7`/`00FA07`/`00FA17` positions `$18C,$20C,$28C,$30C` then `$190,...`; armors start at `$19C`, magic at `$1AC`). Items are 4 rows of 10, row-major: Right = +1, Left = -1, Down = +10, Up = -10 (`word_00FA27`: `$18C + 4*k` for the first row, `+ $80` per row). A step outside the list leaves the cursor where it is; stepping Down from the last slot of a column goes to the top of the next column (no wrap check).

Gear stats: `code_011EED` sets `$1B70` = weapon strength and `$1B74` = armor defence from `binary_0161AC` (section 3.3) after a weapon or armor is chosen. Level parts `$1B72`/`$1B76` come from the level-up code (FM-A1 section 5).

### 1.5 The equipment menu (L018, L019, L046)

`loc_011B97` (L018, entered from L006 when Select/X is pressed): `dp$42 = 0`; wait for vblank; force blank; BG2 map at VRAM `$5C00` (`BG2SC = $5C`), BG2 characters at `$2000` (`BG12NBA = $20`), main screen BG2 + BG3 only (`TM = 6`), colour math and windows off; save the four scroll words (`$045A-$0460`) and zero the live ones; `$042F = 0`; `$0435 = $1B62` (the magic equipped on entry); back up CGRAM (`code_0123EA`), load the menu graphics and palette (A6: `code_012416` DMAs `graphics_04B000` to VRAM `$2000`, `code_01243D` copies `binary_04F100` to the CGRAM buffer, `code_012390`), wait, `BRK #$07`, run `code_011C7B` (L019).

L019 draws the frame text `asciistring_01469F` (three tab boxes "Weapon / Armor / Magic" at `$88`, `$98`, `$A8`, the description window at `$408` and four equipped-item lines at `$48A`, `$50A`, `$58A`, `$60A`), switches NMI and the screen on (`code_0131A2`, `code_013176`), draws the icons (`code_011F18`), uploads the BG3 page and then the BG2 icon page (`vram_upload_flags` 1, 2, 1, one frame each; bit 1 = page `$7F7800` to VRAM `$5C00`, FM-A1 R16) and loops: `code_012138` (L046) returns the chosen row 0-3 or carry set when **Y** is pressed (exit). Rows 0-2 call `code_011DA3` with A = 8 and Y = the list base; row 3 calls `code_011FF2` with A = `$28`, Y = `$1B36`. A confirmed id is stored (`$1B5E`, `$1B60` with `code_011EED`, `$1B62`, `$1B64`); the frame is reprinted from the `[::]` marker (`asciistring_01469F+M`: window and equipped lines only) and the loop continues on the same row. The cursor glyph is BG3 tile `$2B` at the row offset (blink: `$2B`/`$20` by `$03C6 & $1F >= $18`, `code_01230B`). Moving the row cursor onto row 3 draws the item page (`code_011D76`) and sets `$042F`; moving off it redraws the equipment page (`code_011D46`) and clears `$042F`.

Exit (after L019 returns): consume the B and Y latch bits (`TRB $032B` with `$C0`) and clear `$0323`; wait; restore the scroll words, force blank, `BG2SC` from `$03C2`, `BG12NBA = 0`, `TM` from `$03C0`, `CGADSUB` from `$03C1`, `W12SEL` from `$03C3` (these four are the scene loader's register shadows, `lib_0133A6_part3`); `code_012463` (VRAM `$2000` from `$7F:C000`), `code_012400` (CGRAM buffer from `$7E6000`), `code_01249C` (equipped-magic graphics and palette); when the magic changed (`$1B62 != $0435`) `engine_0029EC.code_002C7D` (kill all projectiles, FM-A2 X075) and `$0433`, `$0434` are cleared; `lib_027781_part1.code_0273F9` restores the player's pose; clear BG3, `$0332 = $1F` (full HUD redraw), wait, `engine_000000.code_000127` (one sub-frame), wait, `INIDISP = $0F`.

Walkthrough agreement: X opens, B twice equips (row, then slot), Y exits; the text labels read "Wep-", "Arm-", "Mag-", "Item:" (the extractor prints the period glyph as `-`, as in every string), the walkthrough writes "Wep.".

### 1.6 Status and souls screen (L007)

A BG3-only overlay (no screen blank, no graphics swap): `code_013215` converts HP and max HP to packed BCD in `$1B6C` and `$1B6E`; the strength and defence level parts `$1B72`, `$1B76` are **clamped to 12 for the display** (`CMP #$0C`) and restored afterwards; `asciistring_014571` prints the frame, the player name (`[02:2]`, which is the string at `$1B92`), HP / max HP, "Next level :" (8 BCD digits at `$1B7C`), two bar rows each for Strength (`$1B72` over `$1B70`) and Defence (`$1B76` over `$1B74`) and the four equipped names; then wait until A is released, wait for B, Y, a direction or A, print the souls page (`asciistring_014624`, then `code_0119B7`: one 21-byte line per bit of `$1B82`), wait for release and for another press, consume the latch (`TRB $joy_release_latch` with `$C0C0`, `STZ joy_pressed`), clear BG3, `$0332 = $1F`, draw the HUD once. `code_0119A8` is the wait: vblank, then `frame_counter - 1` (cancels the NMI increment, so the frame clock does not advance while the screen is open).

Souls (`$1B82`, FM-A2 1.3): bit 0 Magician, 1 Light, 2 Shield, 3 Detection, 4 Reality; the five lines in `asciistring_014636`, `01464B`, `014660`, `014675`, `01468A` are "Soul of Magician", "Soul of Light", "Soul of Shield", "Soul of Detection", "Soul of Reality" at `$30E`, `$3CE`, `$48E`, `$54E`, `$60E` (stride `$C0`), matching the walkthrough names.

### 1.7 Talking to an actor (L010-L017)

B press (`$0323 & $80`, field only): `loc_0119D8` disables NMI, runs `code_0119E4`, enables NMI. `code_0119E4`: `lib_0273D4.code_0273D4` returns carry set when the player animation id `$1E` is `$2C` or more (no probe), otherwise A = `binary_00FA7F[anim]` = facing code. From the probe offsets the codes are **0 up, 1 down, 2 right, 3 left** (OQ-I009-7): the probe point (dp`$16`, dp`$18`) is, with the player at (x, y): up (x+8, y-16), down (x+8, y), right (x+16, y-8), left (x, y-8). For "up" a second probe is made when the first finds nothing: the tile type (low nibble of `tile_type_map` at the 16-pixel cell of (x, y-32)) must be 6, then the point (x+8, y-32) is tried. `code_011AC4` walks the actor list from `actor_list_tail` through the `$3E` links and returns carry set for the first actor whose `$16` has bit `$0040` and whose box contains the point: `0 <= px - $00,X <= $10,X` and `-$12,X <= py - $02,X <= 0` (x is the left edge, y the bottom edge, `$10`/`$12` width and height).

On a hit (`loc_011AF9`): `$30,X` = 0 means no script (return). Otherwise the script is called through an RTL frame: pushed `$02`, the return `&code_011B5A - 1` (or `&code_011B50 - 1`), the script bank (`meta_tables_008000 + $0D` of the entry at `$38,X`) and `$30,X - 1`; X = the NPC slot, M=16. `$30,X` is the script address set by `COP [17]` (FM-A3 H060: `w0_actor_018000` passes `&code_018036`), which closes OQ-I007-14. If the actor's `$16` has bit `$0008`, `loc_011B1D` first copies the whole slot (`$40` bytes) to `$1A1E`, turns the NPC toward the player (`code_011B5C` picks the animation, `$1E,X = anim`, `$20,X = 0`, `engine_000000.code_0008F3` redraws it), runs the script, and `code_011B50` copies the slot back. So `$16` bit `$0040` = talkable and bit `$0008` = turn to face the player (OQ-I005-14, partly answered).

`code_011B5C` (L017): `anim = $1E,X`; `anim / 6` (`code_0131E8`) then `6 * quotient` (`code_0131D1`) gives the base of the 6-animation group; the result is `base + 0` when the player faces up, `+1` down, `+2` right or left. For right and left it also makes the NPC's X flip (`$1C,X` bit `$4000`, which is bit `$40` of `$1D,X`) equal to "player faces left": it toggles the flip (`lib_0273EB`) only when the current flip differs (facing right toggles when the flip is set, facing left when it is clear). So an unflipped side animation looks left and a flipped one looks right, toward a player who stands at the NPC's right or left. That the `+0`, `+1`, `+2` animations are down, up and side views is inferred from the player's facing, not read from sprite data (OQ-I009-8).

### 1.8 HUD and enemy gauge (L056)

Called once per frame from the main loop (and from the sub-frame wrapper). Skipped (apart from the heal and EXP drains) when `location_id - $0F < 4`. `$0330` is the enemy gauge timer in 2-frame steps: a hit sets `$80` (FM-A1 R35); on that frame the gauge string `asciistring_01476F` is drawn once (name `[02:1]`, bar `[04:336,338]` from the words `$0336` hp and `$0338` max), then the timer counts down by 2 per frame; at 0 the clear string `asciistring_014766` is drawn and the timer becomes `$FE` (idle, nothing drawn). `lib_0275ED` (pending heal) and `lib_027614` (pending EXP) are drained every frame. `$0332` is the HUD dirty mask, tested by five `LSR`: bit 0 the frame `asciistring_01470E`, bit 1 EXP (`$1B78`, 8 digits), bit 2 the HP gauge (`[04:1B88,1B8A]`, words), bit 3 level (`$1B6A`, 2 digits), bit 4 gems (`$1B66`, 6 digits). It answers OQ-I005-13 (readers of `$0330`, `$0336`, `$0338`) and confirms the FM-A1 name `hud_dirty_flags`.

### 1.9 VRAM and palette handoff

`$7F:C000` holds an 8 KB copy of the decompressed `graphics_04D000` (written by `lib_02719F`: decompress to `$7E:8000`, `MVN` to `$7F:C000`). `code_012463` DMAs it back to VRAM word `$2000` (`$2000` bytes, channel 0) and copies `binary_04F300` (160 bytes) to CGRAM buffer offset `$160` (palettes 11-15); the scene loader (`lib_027781_part3`, when `$0454` is set) and `common_actor_0066C6.code_0066DE` call it too. `code_01249C` puts the equipped spell on top: spell `n = $1B62 - $11` (0-7; anything else returns) selects a 3-byte pointer in `table_00FB88` (`graphics_07B000 + {0, 0, $800, $1000, $1000, $1800, $1800, $800}`), DMAs `$800` bytes to VRAM word `$2600`, and copies 32 bytes from `table_00FBA0[n]` (`palette_07D000 + $20 * n`, source bank fixed to `$0F`) to CGRAM buffer `$160` (palette 11 first row). The menu exit calls `code_012463`, then `code_012400` (which overwrites the whole CGRAM buffer, including the `binary_04F300` colours just written), then `code_01249C`.

### 1.10 Text control codes used by the A5 strings

The renderer is A6 (`lib_shared_012769`, codes dispatched by `DEC` chain). Codes as read from its handlers and used in A5 data: `[CUR:o]` set the cursor to BG3 byte offset `o` (row = `o / $40`, column = `(o mod $40) / 2`); `[02:n]` print entry `n` of `binary_list_014789` (0 and 1 tile strings, 2 = the player name at `$1B92`, 3 = `$0447`); `[03:v]` set the attribute byte (`$03E9 = ($03E9 and $E3) or v`: palette bits and priority `$20`); `[04:a,b]` draw a gauge from the words at `a` and `b`; `[TBL:list,addr]` print string number (word at `addr`) of the pointer list `list`; `[06:n,addr]` print `n` packed-BCD digits (least significant byte first) from `addr`; `[07:w,h]` draw a window; `[08:o]` erase the window at `o`; `[09]` toggle `$03E9` bit 1 (two-row versus single-row glyphs); `[0A]` toggles `$03F9` bit 7; `[0B:t,&c]` repeat tile `t` the number of times held in the byte at `c`; `[14:n]` `n` blanks; `[N]` newline; `[::]` marks the re-entry point `+M`; `[JMP:&s]` continue at `s`.

## 2. Routine table

### 2.1 HDMA channel queue

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L001 | `code_01185E` | 71774 / 16 | 6 (`engine_000000` x6: main loop, two scene-change paths, sub-frame wrapper) | hdma | `ResetHdmaQueue` (A; code, caller, A1) | M=8, X=16 (the extract decodes M=16, OQ-I005-7) | `dp$42 = 0`, `dp$44 = $10`, `dp$46 = $40`, `dp$48 = $6000` | A (`$40`), X (`$6000`) | w `dp$42`, `dp$44`, `dp$46`, `dp$48` |
| L002 | `code_01186E` | 71790 / 28 | 10 (`w1_actor_01E9D3` x2, `w1_actor_01EAFB` x2, `w2_actor_0FA7C4`, `w2_actor_0FA874` x2, `w3_actor_02237E`, `w6_actor_01EEF3`, `w6_actor_01F063`) | hdma | `QueueHdmaIndirect` (A; code, hw, callers) | long call; M=8, X=16; A.low = bank of the table, B = PPU register index (`$00-$3F`), Y = table address | next free channel programmed: `DMAPn = binary_0118BC[reg] or $40`, `BBADn = reg`, `A1TnL/H = Y`, `A1Bn = DASBn = bank`; `dp$42 or= dp$44`, `dp$44 <<= 1`, `dp$46 += $10` (plus carry) | A (low = bank, B = 0); P, X, Y preserved | r `binary_0118BC`; w `DMAPn`, `BBADn`, `A1Tn`, `A1Bn`, `DASBn`, `dp$42`, `dp$44`, `dp$46`; r `dp$44`, `dp$46` |
| L003 | `code_01188A` | 71818 / 19 | 14 (`common_actor_005043_part2` x2, `common_actor_0066FC` x2, `common_actor_00729D_part2` x2, `w0_actor_01B23D`, `w0_actor_01B273`, `lib_011695`, `lib_0116C3` x2, `w3_actor_02230A`, `w3_actor_022457`, `w6_actor_01F14F`) | hdma | `QueueHdmaDirect` (A; code, hw, callers) | as L002 | as L002 with `DMAPn = binary_0118BC[reg]` (direct mode, no `DASBn`); tables are ROM (`binary_006A86`, `binary_01B284`) or WRAM | as L002 | as L002 without `DASBn` |
| L004 | `loc_01189D` (sub-label of L003, own label in PC) | 71837 / 31 | 1 (`BRA` in L002) | hdma | `WriteHdmaChannelRegisters` (A; code, callee) | stack: register index, bank (pushed by the entry); Y = table address | the shared tail of L002 and L003: `BBADn`, `A1Tn`, `A1Bn`, enable bit, advance the queue | A | as L002 |
| L005 | `binary_0118BC` | 71868 / 64 | 2 (L002, L003) | hdma | `HdmaDmapByRegister` (A; code, hw) | index = PPU register `$2100 + i` | DMAP byte: `0` single register, `1` register pair (`$2102/3`, `$2116/7`, `$2118/9`, `$2139/A`), `2` same register twice (`$2104`, `$210D-$2114`, `$211B-$2120`, `$2122`, `$213B-$213D`), `$80`+ read registers (`$2134-$2137`, `$213E`, `$213F` = `$80`; `$2138` `$82`; `$2139/A` `$81`; `$213B-$213D` `$82`) | - | data (64 bytes, one per register) |

### 2.2 Field buttons, status and souls screen, talk probe

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L006 | `code_0118FC` | 71932 / 29 | 1 (`engine_000000` main loop, line 73) | field input | `DispatchFieldButtons` (A; code, walk, callee) | long call; M=8; `$0323`, `joy_pressed` | RTL; Select/X to L018, B to L010, A without a direction to L007 (1.3) | A (the tests are `BIT`, so A holds the high byte or the low byte of `joy_pressed`) | r `$0323`, `joy_pressed` |
| L007 | `loc_011919` (sub-label of L006, own label in PC) | 71961 / 143 | 1 (`BNE` in L006) | status screen | `ShowStatusAndSoulsScreen` (A; code, cons, walk) | M=8 | RTL after the two pages (1.6) | A, X, Y; `$1B6C`, `$1B6E` (BCD scratch); dp scratch of the text renderer; `joy_pressed`, `joy_release_latch` consumed | r `player_hp`, `player_max_hp`, `$1B72`, `$1B76` (display clamp 12, restored), `$1B82`; w `$1B6C`, `$1B6E`, `$0332` (`$1F`), `$0323`, `joy_release_latch`, `joy_pressed`, BG3 page |
| L008 | `code_0119A8` | 72104 / 15 | 5 (all in L007) | field input | `WaitFrameKeepClock` (B; code, caller) | JSR; M as the caller | A = `joy_pressed` low byte (M=8) or the word (M=16); `frame_counter` unchanged over the call (the NMI increment is undone with `DEX; STX`) | A, X | w `frame_counter`; r `joy_pressed` |
| L009 | `code_0119B7` | 72119 / 33 | 1 (L007) | status screen | `DrawRecruitedSouls` (A; code, walk, A2 1.3) | JSR; M=8; `$1B82` | prints one 21-byte soul line for every set bit (bit 0 first), stride `$15`, from `asciistring_014636` up to `asciistring_01469F` | A, Y; X by the renderer | r `$1B82`; BG3 page |
| L010 | `loc_0119D8` (sub-label of L009, own label in PC) | 72152 / 12 | 1 (`BRL` in L006) | talk | `RunTalkInteraction` (A; code, callee) | long call from L006 | `code_0131AE`, `JSR code_0119E4`, `code_0131A2`, RTL | none beyond L011 | `$03D2` |
| L011 | `code_0119E4` | 72164 / 224 | 1 (L010) | talk | `FindAndTalkToActorInFront` (A; code, walk) | JSR; M=8 (REP inside); the player slot is `player_actor` | builds the probe point (1.7) and calls L012; carry from L012 set: `BRL loc_011AF9` (L013); otherwise `PLP; RTS` | A, X, Y; dp`$00` (facing), dp`$16`, dp`$18` | r `player_actor` fields `$00`, `$02`, `$1E`, `tile_type_map`, `binary_00FA7F`; w dp`$00`, `$16`, `$18` |
| L012 | `code_011AC4` | 72388 / 53 | 5 (L011) | talk | `FindTalkableActorAt` (A; code, callee) | JSR; M=16; dp`$16`, dp`$18` = point | carry set and X = the actor, or carry clear (X = 0) | A, X | r `actor_list_tail`, actor `$00`, `$02`, `$10`, `$12`, `$16`, `$3E` |
| L013 | `loc_011AF9` (sub-label of L012, own label in PC) | 72441 / 36 | 5 (`BRL` in L011) | talk | `ActivateTalkTarget` (A; code, cons) | X = actor, M=16 | `$30,X = 0`: to L016; bit `$0008` of `$16,X`: L014; else RTL into the script (frame `&code_011B5A - 1`) | A, Y | r `$30,X`, `$16,X`, `$38,X`, `meta_tables_008000 + $0D` |
| L014 | `loc_011B1D` (sub-label of L012, own label in PC) | 72477 / 51 | 1 (`BNE` in L013) | talk | `TalkFacingPlayer` (A; code, cons) | X = actor | backs up the slot to `$1A1E`, `$1E,X = anim from L017`, `$20,X = 0`, `code_0008F3`, RTL into the script (frame `&code_011B50 - 1`, slot kept on the stack) | A, Y (X = actor kept; `MVN` moves X and Y during the copy, then X is pulled back) | w `$1A1E-$1A5D` (WRAM backup of the slot), actor `$1E`, `$20` |
| L015 | `code_011B50` | 72528 / 10 | 1 (pushed address in L014) | talk | `RestoreTalkedActor` (A; code, callee) | the talk script returned; the slot number is on the stack | copies `$1A1E` back over the slot (`MVN #$01,#$01`), falls into L016 | A, X, Y | r `$1A1E-$1A5D`; w the slot |
| L016 | `code_011B5A` | 72538 / 2 | 2 (pushed address in L013, `BEQ` in L013) | talk | `ReturnFromTalk` (B; code, caller) | stack: P from L011 | `PLP; RTS` | P restored | - |
| L017 | `code_011B5C` | 72540 / 59 | 1 (`JSR` in L014) | talk | `ChooseFacingAnim` (B; code, callee) | JSR; X = actor; dp`$00` = facing | A = `6 * (anim / 6) + {0, 1, 2, 2}[facing]` (anim = `$1E,X`, 8-bit result), for facing 2 and 3 toggles `$1C,X` bit `$4000` so the flip equals "facing is 3"; `dp$01` = the result | A, Y; dp`$01` | r `$1E,X`, `$1D,X`; w `$1C,X` (through `code_0273EB`) |

### 2.3 Equipment menu and list choosers

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L018 | `loc_011B97` (sub-label of L017, own label in PC) | 72599 / 228 | 1 (`BRL` in L006) | equipment menu | `OpenEquipmentMenu` (A; code, walk) | long call; M=8; NMI on | RTL when Y closed the menu; screen on; see 1.5 | A, X, Y; `$045A-$0460` (scroll backups); `$7E6000` (CGRAM backup); `$7F:C000` read; DP scratch of the callees | w `dp$42`, `INIDISP`, `BG2SC`, `BG12NBA`, `TM`, `CGADSUB`, `W12SEL`, `scroll_bg1_x/y`, `scroll_bg2_x/y`, `$042F`, `$0435`, `$0332`, `$0433`, `$0434`, `$0323`, `joy_release_latch`; r `$1B62`, `$03C0-$03C3` |
| L019 | `code_011C7B` | 72827 / 199 | 1 (`JSR` in L018) | equipment menu | `RunEquipmentMenu` (A; code, walk) | JSR; M=8 | loops until L046 reports Y; each confirmed row stores the chosen id: `$1B5E` (+L035), `$1B60` (+L035), `$1B62`, `$1B64`; returns carry set via L021 | A, X, Y | w `$1B5E`, `$1B60`, `$1B62`, `$1B64`, `$1B70`, `$1B74`, `vram_upload_flags`, `$03D2`, BG3 and BG2 pages |
| L020 | `loc_011D42` (sub-label of L019, own label in PC) | 73026 / 2 | 0 (`CLC; RTS`, no reference) | equipment menu | `MenuExitOk` (C; dead) | - | carry clear | - | - |
| L021 | `loc_011D44` (sub-label of L019, own label in PC) | 73028 / 2 | 1 (`BRL` in L019) | equipment menu | `MenuExitCancel` (B; code) | - | `SEC; RTS` | - | - |
| L022 | `code_011D46` | 73030 / 48 | 1 (`JSR` in L046) | equipment menu | `RedrawEquipmentPage` (B; code, callee) | JSR; M=8 | clears the upper BG3 half (L050), prints `asciistring_01469F`, uploads, `code_01243D` (equipment palette), icons (L036), uploads BG2 then BG3 again | A; X, Y preserved | w BG3 and BG2 pages, `vram_upload_flags`, CGRAM buffer |
| L023 | `code_011D76` | 73078 / 45 | 1 (`JSR` in L046) | equipment menu | `DrawItemPage` (B; code, callee) | JSR; M=8 | prints `asciistring_014701`, L053 (item palette), L038 (40 icons), uploads | A; X, Y preserved | w BG3 and BG2 pages, `vram_upload_flags`, CGRAM buffer |
| L024 | `code_011DA3` | 73123 / 161 | 3 (`JSR` in L019 rows 0, 1, 2) | menu list | `ChooseFromEquipmentList` (A; code, walk) | JSR; M=8; A = slot count (8), Y = list base (`$1B1E`, `$1B26`, `$1B2E`) | carry clear and A = chosen slot byte and `$7F` (the id); marker set; `loc_011E2A` is the confirm tail | A, X, Y; `$56/$57` (list pointer), `$03C4` (count), `$03C6` (blink) | r/w the list; w `$7F0403`, `vram_upload_flags`; r `asciistring_list_015572` |
| L025 | `code_011E44` | 73284 / 19 | 0 | menu list | `CancelEquipChoice` (C; dead) | - | restores the list from `$7F0403` (L033), redraws, carry set | - | as L024 |
| L026 | `loc_011E57` (sub-label of L025, own label in PC) | 73303 / 19 | 1 (`BCS` in L024) | menu list | `MoveSelectionRight` (A; code) | Y = current slot | Y + 4 when below the count, else unchanged (to `loc_011DC6`); falls into the common move | A, X, Y | `$03C4` |
| L027 | `loc_011E6A` (sub-label of L025, own label in PC) | 73322 / 16 | 1 (`BCS` in L024) | menu list | `MoveSelectionLeft` (A; code) | as L026 | Y - 4 when not negative | A, X, Y | - |
| L028 | `loc_011E7A` (sub-label of L025, own label in PC) | 73338 / 14 | 1 (`BCS` in L024) | menu list | `MoveSelectionDown` (A; code) | as L026 | Y + 1 | A, X, Y | `$03C4` |
| L029 | `loc_011E88` (sub-label of L025, own label in PC) | 73352 / 7 | 1 (`BCS` in L024) | menu list | `MoveSelectionUp` (A; code) | as L026 | Y - 1 when not negative | A, Y | - |
| L030 | `loc_011E8F` (sub-label of L025, own label in PC) | 73359 / 2 | 1 (`BPL` in L029) | menu list | `ApplyMoveUp` (B; code) | as L026 | `TYX; DEY`, falls into L031 | X, Y | - |
| L031 | `loc_011E91` (sub-label of L025, own label in PC) | 73361 / 26 | 3 (`BRA` in L026, L027, L028; L030 falls through) | menu list | `MoveSelectionMarker` (A; code) | X = old slot, Y = new slot | `BRK #$07`; marker set on the new slot, cleared on the old, `$03C6 = 0`, blink once, back to `loc_011DC6` | A | r/w the list; `$03C6`; w `vram_upload_flags` |
| L032 | `code_011EAB` | 73387 / 18 | 2 (L024, L039) | menu list | `BackupSlotList` (A; code) | JSR; M=8; `$56` list, `$03C4` count | copies the list to `$7F0403` | A, X, Y | r list; w `$7F0403` |
| L033 | `code_011EBD` | 73405 / 18 | 2 (L025, L040; both dead) | menu list | `RestoreSlotList` (A; code, dead callers) | as L032 | copies `$7F0403` back to the list | A, X, Y | r `$7F0403`; w list |
| L034 | `code_011ECF` | 73423 / 30 | 6 (`lib_0118FC`: L024 x2, L031, L039 x2, L045) | menu list | `BlinkSelectionMarker` (A; code) | Y = slot, `$56` list | sets bit 7 of the slot for 24 of every 32 calls, clears it for 8 (`$03C6 and $1F >= $18`); `$03C6 += 1`; `vram_upload_flags or= 1` | A | r/w the list byte, `$03C6`, `vram_upload_flags` |
| L035 | `code_011EED` | 73453 / 43 | 2 (L019 after a weapon and after an armor pick) | gear | `RecalcGearStats` (A; code, walk) | M=8, X=16; `$1B5E`, `$1B60` | `$1B70 = binary_0161AC[weapon] + binary_0161AC[armor]` (the armor row has no strength), `$1B74 = binary_0161AC[weapon + $11] + binary_0161AC[armor + $11]` | A, X | r `$1B5E`, `$1B60`, `binary_0161AC`; w `$1B70`, `$1B74` |
| L036 | `code_011F18` | 73496 / 79 | 7 (`lib_0118FC`: L019, L022, L024 x4, L025 dead) | menu draw | `DrawEquipIconRows` (A; code, cons) | JSR; M=16 set inside, restored | draws 8 weapon, 8 armor and 8 magic icons through L037 (`word_00F9F7`, `word_00FA07`, `word_00FA17` positions; `$1B1E`, `$1B26`, `$1B2E` bytes; the 16-bit load also reads the next byte, harmless) | A, X (= 8); Y and P restored | r `inventory` and the three position tables |
| L037 | `code_011F67` | 73575 / 108 | 4 (L036 x3, L038) | menu draw | `DrawInventoryIcon` (A; code, cons) | JSR; M=16; A = (byte, next byte) as loaded, Y = tilemap byte offset | BG3: four frame cells (`$2A` plus flips, attribute `or $0C`) when the slot byte has bit 7, else four zero cells; BG2: the 4 words of `unk17_048800[id * 8]` at `$7800`, `$7802`, `$7840`, `$7842` (+Y) | A (M=16 on return); X and DBR preserved | r `unk17_048800` (id and `$7F`); w `$7F7000`-page and `$7F7800`-page cells |
| L038 | `code_011FD3` | 73683 / 31 | 6 (`lib_0118FC`: L023, L039 x4, L040 dead) | menu draw | `DrawItemIconGrid` (A; code, cons) | JSR; M=16 set inside | draws the 40 item icons through L037 (`word_00FA27` positions, `$1B36` bytes) | A, X (= `$28`); Y and P restored | r `$1B36-$1B5D`, `word_00FA27` |
| L039 | `code_011FF2` | 73714 / 148 | 1 (L019 row 3) | menu list | `ChooseItemSlot` (A; code, walk) | JSR; M=8; A = `$28`, Y = `$1B36` | as L024 for the 40-slot list; the header is `asciistring_01556B` (blank window) and then the description string | A, X, Y; `$56`, `$03C4`, `$03C6` | as L024 with L038 for drawing |
| L040 | `code_012086` | 73862 / 19 | 0 | menu list | `CancelItemChoice` (C; dead) | - | as L025 for the item list | - | as L039 |
| L041 | `loc_012099` (sub-label of L040, own label in PC) | 73881 / 25 | 1 (`BCS` in L039) | menu list | `MoveItemSelectionDown` (A; code) | Y = slot | Y + 10 when below the count | A, X, Y | `$03C4` |
| L042 | `loc_0120B2` (sub-label of L040, own label in PC) | 73906 / 22 | 1 (`BCS` in L039) | menu list | `MoveItemSelectionUp` (A; code) | Y = slot | Y - 10 when not negative | A, X, Y | - |
| L043 | `loc_0120C8` (sub-label of L040, own label in PC) | 73928 / 14 | 1 (`BCS` in L039) | menu list | `MoveItemSelectionRight` (A; code) | Y = slot | Y + 1 when below the count | A, X, Y | `$03C4` |
| L044 | `loc_0120D6` (sub-label of L040, own label in PC) | 73942 / 9 | 1 (`BRL` in L039) | menu list | `MoveItemSelectionLeft` (A; code) | Y = slot | Y - 1 when not negative (the `TYX; DEY` apply step is `loc_0120DD`) | A, X, Y | - |
| L045 | `loc_0120DF` (sub-label of L040, own label in PC) | 73951 / 26 | 3 (`BRA` in L041, L042, L043; L044 falls through) | menu list | `MoveItemSelectionMarker` (A; code) | X = old slot, Y = new slot | as L031 for the item list | A | as L031 |

### 2.4 Row chooser

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L046 | `code_012138` | 74040 / 176 | 1 (`JSR` in L019) | menu row | `ChooseMenuRow` (A; code, walk) | JSR; M=8; A = row count (`$03C4`), B (`XBA`) = start row, X = BG3 byte offset of the cursor cell; rows are 2 text rows apart (`$80`) | carry clear and A = the row on B; carry set on Y (cancel); the cursor glyph `$2B` stays on the final row; up/down move the row; `BRK #$07` per move and per cancel, `BRK #$18` on B in L047; moving onto row 3 runs L023 and sets `$042F`, off it runs L022 and clears `$042F` | A, X, Y (X is not restored); stack row | w `$7F6FC0`+X and `bg3_tilemap_buffer`+X (cursor), `vram_upload_flags`, `$03C4`, `$03C6`, `$042F` |
| L047 | `code_0121E8` (sub-label of L046, own label in PC) | 74216 / 143 | 2 (`engine_006B7F` x2: file select, erase menu) | menu row | `ChooseMenuRowAtTable` (B; code, caller) | JSR/JSL with `RTL`; A = row count, B = start row; cursor offsets from L048 | A = the row (8-bit), carry clear on B (`BRK #$18`), carry set on Y; X preserved; ends `REP #$20; RTL` | A | as L046 without `$042F` |
| L048 | `word_012277` | 74359 / 10 | 1 (L047) | menu row | `TitleMenuCursorOffsets` (A; code) | index = row | five BG3 byte offsets `$02CA`, `$038A`, `$044A`, `$050A`, `$05CA` (step `$C0`, three tile rows) | - | data |

### 2.5 BG3 clearing, CGRAM and VRAM swap

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L049 | `code_012350` | 74576 / 32 | 3 (L007, L018, L019) | text page | `ClearBg3Page` (A; code, hw) | JSR; any M | all 1024 words of `$7F7000` set to `$2000` (blank tile, priority), `vram_upload_flags or= 1`; P and DBR restored | A, X | w `bg3_tilemap_buffer` page (`$7FE`... 2 KB), `vram_upload_flags` |
| L050 | `code_012370` | 74608 / 32 | 1 (L022) | text page | `ClearBg3UpperHalf` (A; code, hw) | as L049 | the first 512 words (`$7000-$73FE`) cleared the same way | A, X | w half of the page, `vram_upload_flags` |
| L051 | `code_0123EA` | 74730 / 22 | 1 (L018) | palette | `SaveCgramBuffer` (A; code) | JSR | copies `cgram_buffer` (512 bytes) to `$7E6000` | A (M=16 inside, P restored) | r `cgram_buffer`; w `$7E6000-$7E61FF` |
| L052 | `code_012400` | 74752 / 22 | 1 (L018) | palette | `RestoreCgramBuffer` (A; code) | JSR | copies `$7E6000` back over `cgram_buffer` | A | r `$7E6000`; w `cgram_buffer` |
| L053 | `code_012450` | 74832 / 19 | 1 (L023) | palette | `LoadItemPagePalette` (A; code, callee) | JSR | `MVN` of `binary_04F000` (256 bytes) to `cgram_buffer`; M=8 on return | A, X, Y | w `cgram_buffer` (colours 0-127) |
| L054 | `code_012463` | 74851 / 57 | 3 (L018, `common_actor_0066C6.code_0066DE`, `lib_027781_part3`) | vram, palette | `RestoreSceneBgGfxAndPalette` (B; code, caller) | long call; M=8 | DMA channel 0: `$7F:C000` to VRAM word `$2000`, `$2000` bytes; `binary_04F300` (160 bytes) to `cgram_buffer + $160`; DBR restored | A, X, Y | w `VMADDL`, DMA 0, `MDMAEN`, `cgram_buffer` |
| L055 | `code_01249C` | 74908 / 82 | 2 (L018, `lib_027781_part3`) | vram, palette | `LoadEquippedMagicGfx` (A; code, walk, cons) | long call; `$1B62` | spell `n = $1B62 - $11`; for `n` 0-7: `graphics_07B000 + table_00FB88[n]` ($800 bytes) to VRAM `$2600` and `table_00FBA0[n]` (32 bytes, bank `$0F`) to `cgram_buffer + $160`; other `n`: nothing; `loc_0124EC` is the shared `PLP; RTL` | A, X, Y | r `$1B62`, `table_00FB88`, `table_00FBA0`; w DMA 0, `cgram_buffer` |

### 2.6 HUD

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L056 | `code_012659` | 75353 / 118 | 6 (`engine_000000` x5, L007) | hud | `UpdateHud` (A; code, cons, A1) | long call; M=8; `$0330`, `$0332` | draws the enemy gauge by `$0330` (1.8), calls `code_0275ED` and `code_027614`, then draws one HUD string per set bit of `$0332` and clears `$0332`; nothing when `location_id - $0F < 4` | A, Y; X by the callees | r `location_id`, `$0330`, `$0332`; w `$0330`, `$0332`, BG3 page |

### 2.7 NMI, arithmetic, BCD

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|-----------------------|----|-----|----------|--------------|
| L057 | `code_013176` | 78198 / 22 | 1 (L019) | nmi | `EnableDisplayAndNmi` (A; code, hw) | long call | wait for vblank (`code_0131B7`), `NMITIMEN = $A1`, `INIDISP = $0F`, `$03D2 += 1`; P restored | A | w `NMITIMEN`, `INIDISP`, `$03D2` |
| L058 | `code_0131A2` | 78242 / 12 | 12 (`engine_000000` x8, `lib_0118FC` x2, `lib_027781_part2`, `cop_handler_005CF0_part1`) | nmi | `EnableNmi` (A; code, hw, A1) | long call; M=8 | reads `RDNMI` (clears a pending flag), `NMITIMEN = $A1` (NMI and auto-joypad; bit 5 also set), `$03D2 += 1` | A | w `NMITIMEN`, `$03D2` |
| L059 | `code_0131AE` | 78254 / 9 | 9 (`engine_000000` x7, `lib_0118FC`, `cop_handler_005CF0_part1`) | nmi | `DisableNmi` (A; code, hw, A1) | long call; M=8 | `NMITIMEN = 1` (NMI off, auto-joypad on), `$03D2 = 0` | A | w `NMITIMEN`, `$03D2` |
| L060 | `code_0131E8` | 78312 / 22 | 2 (L017, `common_actor_004659_part1`) | arithmetic | `DivideWordByByte` (A; code, hw) | long call; M=8, X=16; Y = dividend (16-bit), A = divisor | A.low = quotient (low 8 bits only), B = remainder (8 NOPs wait out the 16-cycle divide) | A | w `WRDIVL`, `WRDIVB`; r `RDDIVL`, `RDMPYL` |
| L061 | `code_013215` | 78357 / 49 | 3 (L007 x2, `lib_027572`) | arithmetic | `ByteToPackedBcd` (A; code, cons) | long call; M=8, X=16; A = value 0-255, X = destination | `[X]` = tens and ones as two nibbles, `[X+1]` = hundreds (0-2) | A | w `[X]`, `[X+1]` |

## 3. Data

### 3.1 Strings (parts 11, 12 and the head of part 13)

All are `ASCIIString` parts; widths are the byte counts between labels. `[CUR:o]` positions are BG3 byte offsets.

| # | Label | Off / size | Callers | Proposed name (conf, evidence) | Content and consumer |
|---|-------|-----------|---------|--------------------------------|----------------------|
| D01 | `asciistring_014571` | 83313 / 179 | 1 (L007) | `StatusScreenText` (A; code, cons) | clears the name area, window `$186` 23x19, palette 0, name `[02:2]` at `$20C`, "HP" `$222`, `[06:3,1B6C]`, "/", `[06:3,1B6E]`, "Next level :" `$288`, `[06:8,1B7C]` at `$2A6`, bars `[0B:26,1B72]` `$31E` and `[0B:26,1B70]` `$35E` with "Strength :" at `$348`, `[0B:27,1B76]` `$3DE` and `[0B:27,1B74]` `$41E` with "Defence  :" at `$408`, then "Weapon: ", "Armor : ", "Magic : ", "Item  : " at `$4C8`, `$548`, `$5C8`, `$648` with `[TBL:list_014F74,1B5E/1B60/1B62/1B64]` |
| D02 | `asciistring_014624` | 83492 / 18 | 1 (L007) | `SoulsScreenTitleText` (A; code, cons) | `[08:186]` erase the status window, window `$18A` 18x19, "Souls" at `$258` |
| D03 | `asciistring_014636` | 83510 / 21 | 1 (L007 as the walk start) | `SoulOfMagicianText` (A; code, walk) | `[CUR:30E]` + "Soul of Magician" padded to 18 characters |
| D04 | `asciistring_01464B` | 83531 / 21 | 0 direct (walked by L009, stride `$15`; A7 file) | `SoulOfLightText` (A; code, walk) | `[CUR:3CE]` "Soul of Light" |
| D05 | `asciistring_014660` | 83552 / 21 | 0 direct (A7 file) | `SoulOfShieldText` (A; code, walk) | `[CUR:48E]` "Soul of Shield" |
| D06 | `asciistring_014675` | 83573 / 21 | 0 direct (A7 file) | `SoulOfDetectionText` (A; code, walk) | `[CUR:54E]` "Soul of Detection" |
| D07 | `asciistring_01468A` | 83594 / 21 | 0 direct (A7 file) | `SoulOfRealityText` (A; code, walk) | `[CUR:60E]` "Soul of Reality" |
| D08 | `asciistring_01469F` | 83615 / 98 | 7 (L018 x1 direct, L019 x6 with `+M`) | `EquipMenuFrameText` (A; code, walk) | tab boxes "Weapon", "Armor", "Magic" (6x12 at `$88`, `$98`, `$A8`), marker `[::]`, window `$408` 22x8, four lines `$48A..` " Wep-: / Arm-: / Mag-: / Item: " with `[TBL:list_014F74,1B5E..1B64]` and `[N][N]` |
| D09 | `asciistring_014701` | 83713 / 11 | 1 (L023) | `ItemMenuFrameText` (A; code, cons) | box 22x12 at `$88`, "Item" |
| D10 | `binary_01470C` | 83724 / 2 | 3 (strings D11, D16, D17 as `[0B:t,&c]` counts) | `HudRepeatCounts` (A; code, cons) | byte `+0` = `$19` (25 repeats), byte `+1` = `$20` (32 repeats); read as bytes (`LDA $0000,Y; AND #$00FF`) |
| D11 | `asciistring_01470E` | 83726 / 43 | 1 (L056) | `HudFrameText` (A; code, cons) | single-row mode, palette 1, 25 tiles `$1A` at `$700`, labels "LEV" `$42`, "EXP" `$50`, "GEM" `$6A`, glyph string 0 at `$C0`, palette 2, 32 blanks at `$CC` |
| D12 | `asciistring_014739` | 83769 / 11 | 1 (L056) | `HudExpText` (A; code, cons) | `$58`, `[06:8,1B78]` |
| D13 | `asciistring_014744` | 83780 / 12 | 1 (L056) | `HudHpGaugeText` (A; code, cons) | `$CC`, palette 3, `[04:1B88,1B8A]` (words: HP and max HP) |
| D14 | `asciistring_014750` | 83792 / 11 | 1 (L056) | `HudLevelText` (A; code, cons) | `$4A`, `[06:2,1B6A]` |
| D15 | `asciistring_01475B` | 83803 / 11 | 1 (L056) | `HudGemsText` (A; code, cons) | `$72`, `[06:6,1B66]` |
| D16 | `asciistring_014766` | 83814 / 9 | 1 (L056) | `EnemyGaugeClearText` (A; code, cons) | 25 blanks at `$140` |
| D17 | `asciistring_01476F` | 83823 / 26 | 1 (L056) | `EnemyGaugeText` (A; code, cons) | glyph string 1 at `$140`, 32 blanks and `[04:336,338]` (words `$0336`, `$0338`) at `$14C` |
| D18 | `asciistring_01553E` | 87358 / 26 | 1 (L024) | `WeaponDescHeaderText` (A; code, cons) | window `$408` 22x8, "Lev:" `$4AA`, "Strength:" `$50A` (ids `$01-$08`) |
| D19 | `asciistring_015558` | 87384 / 19 | 1 (L024) | `ArmorDescHeaderText` (A; code, cons) | window, "Defence :" `$50A` (ids `$09-$10`) |
| D20 | `asciistring_01556B` | 87403 / 7 | 2 (L024, L039) | `PlainDescHeaderText` (A; code, cons) | the window only (ids `$11` and up, and all items) |
| D21 | `asciistring_list_015572` | 87410 / 130 | 2 (L024, L039) | `DescriptionTextList` (A; code, cons) | 65 `&` pointers, index = item id (0 = empty), step 2; read with `LDA long, X` after `ASL`; width one word |
| D22 | `word_01612C` | 90412 / 128 | 64 (the `[TBL]` operands of D21's strings) | `NameIndexCells` (A; code, cons) | 64 words, entry `k` = `k + 1`; the strings pass `&word_01612C + 2k` because `[TBL:list,addr]` reads the index from memory |
| D23 | `binary_0161AC` | 90540 / 34 | 20 (L035 x4, strings x16) | `GearStatTable` (A; code, walk) | see 3.3 |

### 3.2 Description strings `asciistring_list_015572[id]` (65 rows; offsets 87540-90412)

Record layout (read from `asciistring_0155FB`, `0157BF`, `015951`, `015AF9`): `[CUR:48A]` + `[TBL:list_014F74,&word_01612C + 2(id-1)]` prints the item name on the first window row. Weapons (ids `$01-$08`) then print `[CUR:4B2][06:2,&word_0161CE + 2(id-1)]` (the minimum swing level, two BCD digits) and `[CUR:51E][0B:26,&binary_0161AC + id]` (a bar of strength tiles); armors (`$09-$10`) print `[CUR:51E][0B:27,&binary_0161AC + $11 + id]` only; magic (`$11-$18`) and items start the text at `$50A`; weapon and armor text starts at `$58A`. Text lines are separated by `[N][N]`. Stub strings (`$2B-$31`, `$33`, `$34`, `$3B-$3F`) print the name and `[JMP]` into the carrying string at its `[::]` marker (`+M`). The "Necessary GEM : n" costs of magic are literal text digits.

| Id | Label | Off / size | Proposed name | Content |
|----|-------|-----------|---------------|---------|
| 00 | `asciistring_0155F4` | 87540 / 7 | `DescEmpty` | the blank 22x8 window only |
| 01 | `asciistring_0155FB` | 87547 / 45 | `DescSwordOfLife` | weapon: name, Lev 1, bar +1; "A sword from the Master" |
| 02 | `asciistring_015628` | 87592 / 62 | `DescPsychoSword` | weapon: Lev 5, +2; "Invincible monsters temporarily paralyzed" (OQ-I009-3) |
| 03 | `asciistring_015666` | 87654 / 46 | `DescCriticalSword` | weapon: Lev 11, +3; "Defeats monsters at once" |
| 04 | `asciistring_015694` | 87700 / 67 | `DescLuckyBlade` | weapon: Lev 15, +4; "The chance of getting larger GEMs increases" |
| 05 | `asciistring_0156D7` | 87767 / 53 | `DescZantetsuSword` | weapon: Lev 16, +6; "Defeats monsters with special armor" |
| 06 | `asciistring_01570C` | 87820 / 61 | `DescSpiritSword` | weapon: Lev 19, +8; "Defeats the spirit type monsters" |
| 07 | `asciistring_015749` | 87881 / 63 | `DescRecoverySword` | weapon: Lev 22, +10; "HP will be filled when monster is defeated" |
| 08 | `asciistring_015788` | 87944 / 55 | `DescSoulBlade` | weapon: Lev 24, +12; "The strongest sword you may use" |
| 09 | `asciistring_0157BF` | 87999 / 58 | `DescIronArmor` | armor: bar +1; "Your defense power becomes stronger" |
| 0A | `asciistring_0157F9` | 88057 / 50 | `DescIceArmor` | armor: +2; "you can cross fire without damage" |
| 0B | `asciistring_01582B` | 88107 / 44 | `DescBubbleArmor` | armor: +3; "Enables you to walk under the sea" |
| 0C | `asciistring_015857` | 88151 / 49 | `DescMagicArmor` | armor: +4; "Cuts the necessary GEMs in half" |
| 0D | `asciistring_015888` | 88200 / 53 | `DescMysticArmor` | armor: +6; "Invincible for longer period of time" |
| 0E | `asciistring_0158BD` | 88253 / 60 | `DescLightArmor` | armor: +8; "Receive no damage from weaker monsters" |
| 0F | `asciistring_0158F9` | 88313 / 47 | `DescElementalMail` | armor: +10; "Protects [02:2] from the damage zones" (player name) |
| 10 | `asciistring_015928` | 88360 / 41 | `DescSoulArmor` | armor: +12; "Enables you to walk in space" |
| 11 | `asciistring_015951` | 88401 / 54 | `DescFlameBall` | magic: "Necessary GEM : 4"; fireball in one direction |
| 12 | `asciistring_015987` | 88455 / 60 | `DescLightArrow` | magic: GEM 8; light arrows in all directions |
| 13 | `asciistring_0159C3` | 88515 / 63 | `DescMagicFlair` | magic: GEM 8; power collected while button pressed |
| 14 | `asciistring_015A02` | 88578 / 50 | `DescRotator` | magic: GEM 1; light ring rotates around you |
| 15 | `asciistring_015A34` | 88628 / 58 | `DescSparkBomb` | magic: GEM 8; mines laid, explode soon after |
| 16 | `asciistring_015A6E` | 88686 / 51 | `DescFlamePillar` | magic: GEM 20; pillars of fire rise around you |
| 17 | `asciistring_015AA1` | 88737 / 47 | `DescTornado` | magic: GEM 8; magical tornado will come |
| 18 | `asciistring_015AD0` | 88784 / 41 | `DescPhoenix` | magic: GEM 2; "Phoenix will join [02:2]" (player name) |
| 19 | `asciistring_015AF9` | 88825 / 38 | `DescGoatsFood` | "Goat s food from the tool shop" |
| 1A | `asciistring_015B1F` | 88863 / 32 | `DescHarpString` | "Harp String of singer" |
| 1B | `asciistring_015B3F` | 88895 / 51 | `DescAPass` | "A pass made by the children of Grass Valley" |
| 1C | `asciistring_015B72` | 88946 / 53 | `DescDreamRod` | "A strange stick that enables you to look into a dream" |
| 1D | `asciistring_015BA7` | 88999 / 63 | `DescLeosBrush` | "The paintbrush used to paint the picture: The World of Evil" |
| 1E | `asciistring_015BE6` | 89062 / 69 | `DescLeaves` | "Turbo s symbol- Anyone with this is accepted as Turbo s messenger" |
| 1F | `asciistring_015C2B` | 89131 / 60 | `DescMolesRibbon` | "A ribbon that Monmo, a mole, used to be fond of when she was alive" |
| 20 | `asciistring_015C67` | 89191 / 50 | `DescBigPearl` | "A beautiful pearl that can be found in coral reef" |
| 21 | `asciistring_015C99` | 89241 / 38 | `DescMermaidsTears` | "will turn magma into stone" (text starts lower case) |
| 22 | `asciistring_015CBF` | 89279 / 56 | `DescMushroomShoes` | "The snail goo enables you to walk on ice without slipping" |
| 23 | `asciistring_015CF7` | 89335 / 65 | `DescMobileKey` | "Key to Airship- Plug into a keyhole located somewhere on the ship" |
| 24 | `asciistring_015D38` | 89400 / 62 | `DescThunderRing` | "If you touch a lightning pyramid, lightning will strike" |
| 25 | `asciistring_015D76` | 89462 / 60 | `DescDeliciousSeeds` | "Favorite Seeds, exchange for item with the exchanger" |
| 26 | `asciistring_015DB2` | 89522 / 51 | `DescActinidiaLeaves` | "Emits a peculiar scent that attracts cats" |
| 27 | `asciistring_015DE5` | 89573 / 49 | `DescDoorKey` | "This key will open the door to the laboratory" |
| 28 | `asciistring_015E16` | 89622 / 49 | `DescPlatinumCard` | "You may enter the left tower in the Magridd Castle" |
| 29 | `asciistring_015E47` | 89671 / 54 | `DescVipCard` | "You may go wherever you wish within the Magridd Castle" (OQ-I009-1) |
| 2A | `asciistring_015E7D` | 89725 / 62 | `DescEmblemA` | "If you collect 8 of these, you will become an expert at magic" (carries the marker `[::]`) |
| 2B | `asciistring_015EBB` | 89787 / 11 | `DescEmblemB` | name, `[JMP]` to `DescEmblemA+M` |
| 2C | `asciistring_015EC6` | 89798 / 11 | `DescEmblemC` | as `2B` |
| 2D | `asciistring_015ED1` | 89809 / 11 | `DescEmblemD` | as `2B` |
| 2E | `asciistring_015EDC` | 89820 / 11 | `DescEmblemE` | as `2B` |
| 2F | `asciistring_015EE7` | 89831 / 11 | `DescEmblemF` | as `2B` |
| 30 | `asciistring_015EF2` | 89842 / 11 | `DescEmblemG` | as `2B` |
| 31 | `asciistring_015EFD` | 89853 / 11 | `DescEmblemH` | as `2B` |
| 32 | `asciistring_015F08` | 89864 / 60 | `DescRedHotMirror` | "If you obtain all three symbols, the Phoenix will join you" (carries the marker) |
| 33 | `asciistring_015F44` | 89924 / 11 | `DescRedHotBall` | name, `[JMP]` to `DescRedHotMirror+M` |
| 34 | `asciistring_015F4F` | 89935 / 11 | `DescRedHotStick` | name, `[JMP]` to `DescRedHotMirror+M` |
| 35 | `asciistring_015F5A` | 89946 / 54 | `DescPowerBracelet` | "If you equip this item, your attack power will double" |
| 36 | `asciistring_015F90` | 90000 / 61 | `DescShieldBracelet` | "Will reduce the amount of damage received from enemies by 1/2" |
| 37 | `asciistring_015FCD` | 90061 / 60 | `DescSuperBracelet` | "Your sword and armor will increase in strength by 2" (OQ-I009-4) |
| 38 | `asciistring_016009` | 90121 / 61 | `DescMedicalHerb` | "Your HP will be refilled if your life meter reaches 0" |
| 39 | `asciistring_016046` | 90182 / 52 | `DescStrangeBottle` | "You will not lose any GEMs should your life meter reach" (ends there, OQ-I009-2) |
| 3A | `asciistring_01607A` | 90234 / 63 | `DescBrownStone` | "World of Evil will appear once you have collected 6 of these" (carries the marker) |
| 3B | `asciistring_0160B9` | 90297 / 11 | `DescGreenStone` | name, `[JMP]` to `DescBrownStone+M` |
| 3C | `asciistring_0160C4` | 90308 / 11 | `DescBlueStone` | as `3B` |
| 3D | `asciistring_0160CF` | 90319 / 11 | `DescSilverStone` | as `3B` |
| 3E | `asciistring_0160DA` | 90330 / 11 | `DescPurpleStone` | as `3B` |
| 3F | `asciistring_0160E5` | 90341 / 11 | `DescBlackStone` | as `3B` |
| 40 | `asciistring_0160F0` | 90352 / 60 | `DescMagicBell` | "You will be able to cast magic without using any GEMs" |

Every id-to-item pairing agrees with the crosswalk section 4 (ids `$01-$40`) and with the item name list `asciistring_list_014F74`. The `-` the extractor prints at the end of sentences is the period glyph; apostrophes are printed as spaces ("Goat s food").

### 3.3 Structures

| Structure | Layout | Evidence |
|-----------|--------|----------|
| Inventory table `$1B1E` (64 bytes) | byte per id, index `id - 1`; bits 0-6 id or 0, bit 7 marker (1.4) | `code_00651E`; the `LDA ($56),Y` byte reads in L024 and L039; `ORA #$80` and `AND #$7F` writes |
| Equipped cells `$1B5E`, `$1B60`, `$1B62`, `$1B64` | 2-byte cells, id in the low byte, high byte never written | `LDX $1B5E` (X 16-bit), `[TBL:...,1B5E]` word read in `loc_012931`, `STA $1B5E` with M=8 |
| `binary_0161AC` (34 bytes, two rows of 17) | `+id` strength bonus for weapons (`+1..+8` = 1, 2, 3, 4, 6, 8, 10, 12; other bytes 0); `+$11 + id` defence bonus (`+$1A..+$21` for armor ids `$09-$10` = 1, 2, 3, 4, 6, 8, 10, 12; other bytes 0). One byte per entry | L035 (`LDA long,X` with M=8, X = id and `+11`), the `[0B:26,&binary_0161AC+id]` and `[0B:27,...+1A..21]` bar counts, crosswalk section 5 |
| `word_0161CE` (A8's block, 16 bytes) | 8 words, packed BCD, minimum swing level of weapons `$01-$08` = 01, 05, 11, 15, 16, 19, 22, 24; compared as a word with `player_level_bcd`; a lower level clears the B bit (`TRB joy_pressed` with `$8000`) | `common_actor_001A28_part1` lines 46-58 (`LDA word_0161CE,X; CMP player_level_bcd; BEQ/BCC ok`), walkthrough `items.md` weapon table. This locates the table that crosswalk section 5 and OQ-I004-9 listed as "not located" |
| Icon record `unk17_048800[id]` (bank 9, 8 bytes) | four words: tile and attribute of the 2x2 icon (top-left, top-right, bottom-left, bottom-right), written to the BG2 icon page at `+0`, `+2`, `+$40`, `+$42` of the slot offset; row index `(id and $7F) * 8` | L037 (`ASL; ASL; ASL; TAX; LDA long,X` M=16, four loads at `+0`, `+2`, `+4`, `+6`) |
| Icon slot positions `word_00F9F7`, `word_00FA07`, `word_00FA17`, `word_00FA27` | words: BG tilemap byte offsets of each slot's top-left cell. 8, 8, 8 and 40 entries | L036, L038 (`ASL; TAX; LDA word,X; TAY`); values listed in 1.4 |
| Soul line | 21 bytes: `[CUR:o]` (3 bytes) + 18 characters; the five lines are adjacent; the walk steps Y by `$15` until `asciistring_01469F` | L009 (`ADC #$0015`, `CPY #&asciistring_01469F`) |
| HDMA queue (DP) | `$42` byte mask, `$44` byte bit, `$46` byte offset (read as a word, `$47` must be 0), `$48` word written only | 1.2 |
| `binary_0118BC` | 64 bytes, one per PPU register `$2100-$213F`, the DMAP value | L002, L003 (`LDA long,X`, X = register index) |
| Menu row geometry | row step `$80` (two text rows); five title rows step `$C0` | L046, L048 |

## 4. WRAM touched by A5 without a mnemonic (proposals only, nothing applied)

FM-A1 and FM-A2 already propose names for `$0323`, `$0330`, `$0332`, `$0336`, `$0338`, `$03D2`, `$1B5E-$1B64`, `$1B70-$1B76`, `$1B82`; A5 confirms those and adds:

| Address | Use in A5 | Proposed name | Conf | Evidence |
|---------|-----------|---------------|------|----------|
| `$03C0`, `$03C1`, `$03C2`, `$03C3` | scene-loader shadows of `TM`, `CGADSUB`, `BG2SC`, `W12SEL`; the menu exit writes them back | `tm_shadow`, `cgadsub_shadow`, `bg2sc_shadow`, `w12sel_shadow` | B | L018 (`LDA $03C0; STA TM` and the three siblings), `lib_0133A6_part3` stores |
| `$03C4` | count of the list or row set being chosen | `menu_count` | A | L024, L039, L046, `lib_012281` |
| `$03C6` | blink counter of the cursor (`and $1F >= $18` = off) | `menu_blink` | A | L034, `code_01230B`, L046 |
| `$042F` | the item page is shown (set when the row cursor reaches row 3) | `menu_item_page` | B | L046, L018 |
| `$0433`, `$0434` | cleared when the equipped magic changed; `$0433` is also incremented and decremented by the player script (`common_actor_001A28_part2`) | `spell_charge` (`$0433`, C), `$0434` unknown | C | L018, OQ-I009-11 |
| `$0435` | magic equipped when the menu opened | `menu_magic_on_open` | A | L018 (store and compare) |
| `$045A`, `$045C`, `$045E`, `$0460` | saved `scroll_bg1_x`, `scroll_bg1_y`, `scroll_bg2_x`, `scroll_bg2_y` during the menu | `menu_saved_scroll_*` | A | L018 |
| `$1B6C`, `$1B6E` | packed BCD (tens and ones, hundreds) of HP and max HP for the status screen | `hp_bcd`, `max_hp_bcd` | A | L007, L061, strings `[06:3,1B6C]`, `[06:3,1B6E]` |
| `$1B7C` | next-level EXP, 4 BCD bytes (mnemonic `player_exp_next` exists) | - | - | D01 `[06:8,1B7C]` |
| `$1B92` | the player name string (`[02:2]` = `binary_list_014789[2] = $1B92`) | `player_name` | B | D01, `DescElementalMail`, `DescPhoenix`, FM-A2 X094 |
| `$1A1E-$1A5D` | backup of an NPC slot during a face-the-player talk | `talk_actor_backup` | A | L014, L015 |
| `$7E6000-$7E61FF` | CGRAM buffer backup while a menu is open | `cgram_backup` | A | L051, L052 |
| `$7F0403-$7F042A` | backup of the list being chosen (up to 40 bytes) | `menu_list_backup` | A | L032, L033 |
| `$7F:C000-$7F:DFFF` | 8 KB copy of the decompressed `graphics_04D000`, restored to VRAM `$2000` | `vram2000_backup` | B | `lib_02719F`, L054 (OQ-I009-13) |
| `$7F7800` page | BG2 icon tilemap page (VRAM `$5C00`; FM-A1 R16 names the DMA) | `bg2_tilemap_buffer` | A | L037, FM-A1 R16 |
| DP `$56/$57` | list pointer used by the choosers (DP `$56` is also named in FM-A1 as another engine value; here it is scratch inside the menu) | `menu_list_ptr` | B | L024, L039, L032-L034 |
| DP `$00`, `$01`, `$16`, `$18` | talk probe: facing, result, probe x, probe y | - | A | L011-L017 |

## 5. Findings for later batches

- OQ-I005-7 gets its override owner: `us/overrides.json` needs `"71774": {"M": 1}` (L001, A5 block). The A4 block `lib_01010B` needs the sibling `"65803": {"M": 1}`.
- `$16` bit `$0040` is "talkable" and `$0008` "turn to face the player before the talk script" (L013, L011); OQ-I005-14 is answered for these two bits. `$30,X` is the talk script entry (`COP [17]` writes it); the reader that OQ-I007-14 asked for is L013. FM-A3 H060 can say so in its note.
- The min swing level table is `word_0161CE` (BCD, compared in `common_actor_001A28_part1`); the walkthrough levels 1, 5, 11, 15, 16, 19, 22, 24 match exactly. Crosswalk section 5 and OQ-I004-9 can mark that part as located. The gem costs remain text only (`DescFlameBall` .. `DescPhoenix` print 4, 8, 8, 1, 8, 20, 8, 2, equal to the walkthrough); the cost the spell actors pay is Cop26's operand (OQ-I009-10).
- Weapon and armor descriptions match the walkthrough tables (Critical Sword "Defeats monsters at once", Lucky Blade "larger GEMs", Zantetsu "special armor", Spirit "spirit type", Recovery "HP will be filled", Magic Armor "Cuts the necessary GEMs in half", Mystic "Invincible for longer", Light "weaker monsters"). The Psycho Sword text ("Invincible monsters temporarily paralyzed") matches the freeze that FM-A1 R35 found, so OQ-I005-3 can be settled as "intended; the walkthrough omits it" (OQ-I009-3).
- The Super Bracelet text ("increase in strength by 2") agrees with the walkthrough ("adds two points to both Strength and Defense") while FM-A1 R35/R39 doubles damage and halves it: the text supports the walkthrough side of OQ-I005-1 (OQ-I009-4).
- The status screen clamps the displayed strength and defence level parts at 12 for both; the walkthrough says strength caps at 13 and defence at 12 (OQ-I004-10; OQ-I009-6). The stored values are not clamped by A5.
- `Y` in the item and equipment lists confirms the choice, exactly like `B` (L024, L039); `Y` exits the menu only at the row level (L046). Matches the walkthrough text "Press the B Button twice to equip ... Y Button to exit".
- Dead code: `code_011E44`, `code_012086` (cancel paths), `loc_011D42`, and with them `code_011EBD` has no live caller (OQ-I009-14).
- `engine_000000.code_0131AE` brackets almost every frame step: A5 shows that `$03D2` is the switch for `code_013169` between "wait for vblank" and "run a sub-frame" (A6 owns the routine).
- Placement proposals for PB: the HDMA queue (`code_01185E`, `code_01186E`, `binary_0118BC`) and the NMI pair `code_0131A2`/`code_0131AE` with `code_0131B7` as one `system_helpers` block; the menu code, the strings D01-D23 and the description list as one `menu` block; `code_013215` and `code_0131E8` with `code_0131D1` as `arithmetic`; the A7 soul lines `asciistring_01464B..01468A` next to D03.
- Suggested names are all `VerbNoun` or `NounText`; the sub-label rows (L004, L007, L010, L013, L014, L018, L020, L021, L025-L031, L040-L045, L047) are referenced from other labels or are routines of their own, so each needs its own `names` row; the remaining `loc_` labels are branch targets inside one routine and are listed below.

### 5.1 Branch labels that stay inside one routine (no name proposed)

| Routine | Labels (offset) |
|---------|-----------------|
| L006 | `loc_011906` 71942, `loc_01190D` 71949, `loc_011918` 71960 |
| L007 | `loc_01193A` 71994, `loc_011947` 72007, `loc_01195C` 72028, `loc_011965` 72037, `loc_01197B` 72059, `loc_011983` 72067 |
| L009 | `loc_0119BD` 72125, `loc_0119C7` 72135 |
| L011 | `loc_0119EB` 72171, `loc_0119FC` 72188, `loc_011A02` 72194, `loc_011A05` 72197, `loc_011A24` 72228, `loc_011A26` 72230, `loc_011A41` 72257, `loc_011A43` 72259, `loc_011A62` 72290, `loc_011AA5` 72357, `loc_011AA7` 72359, `loc_011AC2` 72386 |
| L012 | `loc_011AC7` 72391, `loc_011ADF` 72415, `loc_011AF0` 72432, `loc_011AF5` 72437, `loc_011AF7` 72439 |
| L017 | `loc_011B84` 72580, `loc_011B8B` 72587, `loc_011B8F` 72591, `loc_011B91` 72593, `loc_011B93` 72595 |
| L018 | `loc_011C5D` 72797 |
| L019 | `loc_011CAF` 72879, `loc_011CB7` 72887, `loc_011CC3` 72899, `loc_011CD3` 72915, `loc_011CE4` 72932, `loc_011CF4` 72948, `loc_011D05` 72965, `loc_011D12` 72978, `loc_011D23` 72995, `loc_011D30` 73008 |
| L024 | `loc_011DB3` 73139, `loc_011DC6` 73158, `loc_011DEB` 73195, `loc_011DEF` 73199, `loc_011DFE` 73214, `loc_011E0B` 73227, `loc_011E2A` 73258 |
| L026-L028 | `loc_011E63` 73315, `loc_011E73` 73331, `loc_011E84` 73348 |
| L032, L033 | `loc_011EAF` 73391, `loc_011EC1` 73409 |
| L034 | `loc_011EDE` 73438, `loc_011EE2` 73442 |
| L036 | `loc_011F1F` 73503, `loc_011F37` 73527, `loc_011F4F` 73551 |
| L037 | `loc_011F85` 73605, `loc_011FAA` 73642 |
| L038 | `loc_011FDA` 73690 |
| L039 | `loc_012002` 73730, `loc_012015` 73749, `loc_01202F` 73775, `loc_01203D` 73789, `loc_01204A` 73802, `loc_012056` 73814, `loc_01206C` 73836 |
| L041-L044 | `loc_0120A5` 73893, `loc_0120BB` 73915, `loc_0120D2` 73938, `loc_0120DD` 73949 |
| L046 | `loc_012140` 74048, `loc_01214F` 74063, `loc_012159` 74073, `loc_012171` 74097, `loc_012176` 74102, `loc_012179` 74105, `loc_012185` 74117, `loc_01219A` 74138, `loc_0121AF` 74159, `loc_0121CD` 74189, `loc_0121D6` 74198, `loc_0121DF` 74207 |
| L047 | `loc_0121F0` 74224, `loc_012212` 74258, `loc_01221C` 74268, `loc_012234` 74292, `loc_012243` 74307, `loc_012250` 74320, `loc_012255` 74325, `loc_01225E` 74334, `loc_012268` 74344 |
| L049, L050 | `loc_012360` 74592, `loc_012380` 74624 |
| L051, L052 | `loc_0123F1` 74737, `loc_012407` 74759 |
| L055 | `loc_0124EC` 74988 |
| L056 | `loc_012666` 75366, `loc_012675` 75381, `loc_012678` 75384, `loc_01267C` 75388, `loc_012682` 75394, `loc_01269B` 75419, `loc_0126A7` 75431, `loc_0126B3` 75443, `loc_0126BF` 75455, `loc_0126CB` 75467 |
| L061 | `loc_01321B` 78363, `loc_013227` 78375, `loc_013233` 78387 |

Row count check: L001-L061 = 61 rows = 41 top-level labels of the A5 files (39 code labels plus the data labels `binary_0118BC` = L005 and `word_012277` = L048) plus 20 sub-label rows (L004, L007, L010, L013, L014, L018, L020, L021, L026-L031, L041-L045, L047). The branch labels in 5.1 were checked against `grep` of the extract; every decimal offset equals the label's hex suffix.
