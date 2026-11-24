# FM-A6: library `0124`-`0127` (text renderer, dialogue renderer, name entry, staff roll, menu graphics loaders)

PA batch A6, iteration I010. Read-only analysis: no names, notes, comments, `blocks.json`, `overrides.json` or docs were changed. Every proposed name below is a proposal for step PC (`npm run names`); every unverified claim is an `OQ-I010-k` row in `plans/extracted-audit/questions/I010_questions.md`.

Source: a fresh `npm run extract:lt` of `extracted/library/`. Five code files and one string file were read end to end; offsets are decimal file offsets (the `{n}` tag). LoROM, so every A6 routine is in bank `$02` and the SNES address is `$02:(8000 + (offset - 65536))`, that is `$02:` plus the label suffix with `$8000` added to its low 15 bits: `code_012769` is at `$02:A769`. The graphics and palette that `code_012416`/`code_01243D` load are in bank `$09` (`graphics_04B000` = `$09:B000`, `data_04F000.binary_04F100` = `$09:F100`); the dictionary `lookup_080000` is at `$10:8000`.

The batch description named "library 0127 and 0124-0126". There is no file `lib_0127`; the ROM address range `0127xx` is the head of `lib_shared_012769`, which runs on to `code_013169`. The files that exist for `0124-0126` are `lib_shared_012416`, `lib_0124EE` (+ `part2`, the strings) and `lib_0126CF`.

| File | Offsets | Labels | Content (this batch's reading) |
|------|---------|--------|--------------------------------|
| `lib_shared_012416` | 74774-74832 | 2 | load the 4 KB menu graphics set into VRAM; load the menu palette into the CGRAM buffer |
| `lib_0124EE` | 74990-75353 | 1 top-level + 30 sub-labels | name entry screen (`Cop3A`) |
| `lib_0124EE_part2` | 83037-83222 | 3 strings | name entry text, letter grid, "close" string |
| `lib_0126CF` | 75471-75625 | 1 top-level + 7 sub-labels | staff roll (credits) scroller |
| `lib_shared_012769` | 75625-78198 | 19 top-level + 169 sub-labels | the text renderer `code_012769` and the dialogue renderer `code_012C27`, their helpers, and the frame/button wait helpers |

232 labels in total: 23 top-level code labels, 206 sub-labels, 3 strings. Section 2 has 84 routine rows (23 top-level rows plus 61 sub-label rows that are entry points, handlers or loop heads that other code branches into; each needs its own override row in PC because the namespace is flat) and section 6 lists the other 145 sub-labels as inner branch targets with no name proposed. Section 3 has the 3 string rows and the external data the code reads.

Context that the reading relied on: `engine_000000` (main loop, NMI, the `code_0001BE` sub-frame, the debug scanner that writes `$03F3` at line 383), `lib_shared_0131B7` (`code_0131B7` vblank wait), `lib_01232B`/`lib_012390`/`lib_shared_01230B` (read for their calls to A6 code only; they have no batch, see section 7.4), `lib_0118FC` and parts (A5: callers of the renderer), `cop_handler_005E05` (`Cop3A`), `cop_handler_0057A2` (`Cop01_ShowText`), `cop_handler_0057BD` (`Cop02`), `cop_handler_005A43` (`Cop1A`), `common_actor_00729D_part2` (credits caller), `common_actor_00797B` (name entry actor), `lib_016264` (credits text), `lib_shared_014789` (list strings), `data_00F9F7` (`word_00FB2F` gauge colours), `system/string_lookup_080000`, `us/stringTypes.json`, `us/mnemonics.json`, `docs/walkthrough/01-in-the-beginning.md`, `level-up.md`, `enemy-bestiary.md`, `08-world-of-evil.md`, FM-A1 to FM-A5.

## 0. Reading the tables

Same columns and labels as FM-A5 section 0. Two additions:

- Callers are counted by `rg -w` over `extracted/` (references, branches, `BRL`, pushed addresses); a self-loop branch is counted as one site and named as such. Branch targets that exist only inside one routine are listed in section 6 and not in section 2.
- Control codes are written as in `us/stringTypes.json` (`[CUR]` 01, `[TBL]` 05, `[END]` 0C, `[N]` 0D, `[FIN]` 11, `[JMP]` 13; the others by hex id).

`BRK #n` is a sound request (FM-A2 X001; the ids `#$07` blip and `#$18` confirm are OQ-I010-16). `dpNN` is a direct-page scratch byte. All A6 routines run with D = 0, M = 8 and X = 16 at entry unless a row says otherwise.

## 1. Models that several rows share

### 1.1 The BG3 text page

`bg3_tilemap_buffer` (`$7F7000`, mnemonic) is a 32 x 32 tile map, 2 bytes per tile, row stride `$40`, 2 KB (`$7F7000-$7F77FF`). The NMI uploads it when `vram_upload_flags` bit 0 is set (A5 section 1.9); every A6 renderer sets that bit before it returns (`TSB`). Positions are byte offsets into the page: `[CUR:o]` gives the offset, `[N]` adds `$40`.

A tile word is *attribute*:*tile*: the low byte is the tile number, the high byte holds the attribute: bits 0-1 tile number bits 8-9 (the `$03E9` bit 1 is tile bit 9, see `[09]`), bits 2-4 palette, bit 5 priority. The text state byte `$03E9` is initialised to `$20` (priority, palette 0, tile bits 0).

**Two-row glyphs.** The default font draws each glyph as two tiles: the lower half is tile `c` at `X` and the upper half is tile `c + $100` (attribute + 1) at `X - $40`, so a text line occupies two rows and `[N]` steps one row. On page row 0 the upper half lands in `$7F6FC0-$7F6FFF`, the 64 bytes in front of the page (OQ-I010-7). **One-row mode** (`[09]` toggles `$03E9` bit 1, which is tile bit 9) writes only the lower tile; the glyph path tests that bit and skips the upper half. The HUD strings use it (A5 D11). That bit 1 selects a second, one-row font page is inferred from the attribute meaning and the HUD use (OQ-I010-4). `[0A]` toggles `$03F9` bit 7, which is ORed into the tile low byte: tiles `$80`+ are an alternate font (OQ-I010-3).

**Window tiles.** `1` top-left, `2` top-right, `3` top, `4` bottom, `5` bottom-left, `6` bottom-right, `7` left, `8` right, `$20` blank, `$2B` ► cursor, `$3D` ▼ continue prompt. Gauge tiles `$1B` (2 filled units), `$1C` (odd end), `$1D` (1 filled + 1 empty), `$1E` (2 empty), `$1F` (odd tail). Evidence: the draw routines `code_012B5D`, `code_012ABF`, the scanners `code_0130CA` and `code_012BDA`, and `code_01303A`.

### 1.2 Two renderers

| | `code_012769` (TR01) | `code_012C27` (DL01) |
|---|---|---|
| Role | print a string at once (menus, HUD, status, gauges) | dialogue with typing delay, key waits, paging |
| Called by | 58 sites in 13 files | `Cop01_ShowText` and 6 library/engine sites (7 in all) |
| Input | Y = string address, X = BG3 byte offset (used when the string has no `[CUR]` first) | Y = string address; X = BG3 byte offset for plain text; first byte `$10` opens the standard box |
| Data bank | forced to `$02` (the string and every `$&` reference are read in bank `$02`) | the caller's DBR; switched to `$02` when it is `$01` |
| Text state | saves `$03E9`/`$03F9` on the stack, sets `$20`/`0`, restores them at the end | sets `$03E9 = $20`, `$03F5 = 1`, `$03F9 = 0`; **never restores** `$03E9`/`$03F9` |
| End | `$00`: `PLX` pops the last line start (X returns the last line start), RTL | `$00`: wait for a key; `[END]`: no wait; both save the line start to `$03F3` |
| Delay and waits | none | `$1B84` frames per printed glyph (`code_013124`), `[0E:n]` pauses, key waits at `[FIN]`, `$00`, `[12]` |
| Resume | not resumable | `$03F3` (line start) lets a later call continue where the last stopped (OQ-I007-17 answered, 1.4) |

Both fetch the next byte through a reader that expands dictionary bytes (`code_0129DA` / `code_012F6E`, 1.6), dispatch on the byte, and share the glyph path layout. The dialogue renderer calls the shared helpers for the gauge (`code_012ABF`), window (`code_012B5D`), erase (`code_012BDA`) and the table/list printers (`code_012A48`/`code_012A92` for the menu renderer, `code_012FDF` for dialogue).

### 1.3 Control codes (both renderers)

Operand widths are the ones in `us/stringTypes.json`; the renderer reads exactly those bytes (field widths were checked against the `INY` count in each handler).

| Code | Name | Operands | Menu renderer (TR) | Dialogue renderer (DL) |
|------|------|----------|--------------------|------------------------|
| `00` | halt | none | end | wait for a key (`code_01314A`), then end and save `$03F3` |
| `01` | `[CUR]` | word | `X` = word, line start = word | same |
| `02` | list string | byte n | print `binary_list_014789[n]` with `code_012A92` (entries 2 and 3 are WRAM `$1B92` and `$0447`: the player name and the save-slot name) | same via `code_012FDF` (with typing delay) |
| `03` | attribute | byte v | `$03E9 = ($03E9 & $E3) \| v` | same |
| `04` | gauge | word cur, word max | `code_012ABF` (1.7) | same |
| `05` | table string | word list, word index | `code_012A48` | `code_012FDF` |
| `06` | BCD number | byte digits, word address | digits right to left, leading zeros blanked except the last digit | same |
| `07` | window | byte w, byte h | `code_012B5D`; saves the origin in `$03F7`; cursor to line start + `$82` | same, **no** `$03F7` store |
| `08` | erase window | word | `code_012BDA` | same |
| `09` | font page | none | toggle `$03E9` bit 1 | same |
| `0A` | alternate font | none | toggle `$03F9` bit 7 | same |
| `0B` | repeat tile | byte t, word &count | repeat tile t `count` times (count is the byte at `&count`) | **skipped**: 3 operand bytes consumed, nothing drawn |
| `0C` | `[END]` | none | ignored (no-op) | end without waiting, save `$03F3` |
| `0D` | `[N]` | none | line start + `$40` | next line, or scroll up two rows at the bottom (1.4) |
| `0E` | delay | byte n | ordinary glyph (tile `$0E`) | wait n frames; skipped when `$1B84 = 0` |
| `0F` | blip toggle | none | glyph | toggle `$03F5` bit 0 (the `BRK #$07` blip per printed glyph) |
| `10` | clear page | none | glyph | clear the box interior and restart at the top |
| `11` | `[FIN]` | none | glyph | blink the ▼ prompt, wait for B or Y, then next line or restart |
| `12` | wait key | none | glyph | wait for a key |
| `13` | `[JMP]` | word | `Y` = word (continue elsewhere) | same |
| `14` | blank run | byte n | n blank low bytes (`X += 2n`, does not OR `$03F9`) | same |
| `15-7F` | glyph | none | two tiles | two tiles, plus tick |
| `80-FF` | dictionary | none | expand `lookup_080000[b & $7F]` | same |

In the menu renderer codes `0E`-`12` and `15`-`7F` are plain glyphs: the menu renderer has no handler for them, and whether any menu string contains one is not checked (OQ-I010-15, with the dialogue renderer's own limits: no `[0B]` drawing, no `$14` runs inside `[TBL]` and `[02]` strings,). Usage counts in the ROM strings (from `rg` over `extracted/`): `[N]` 2686, `[FIN]` 566, `[10]` 558, `[JMP` 557, `[CUR` 245, `[0E` 166, `[14` 162, `[02` 124, `[03` 104, `[TBL` 76, `[END]` 62, `[0F]` 27, `[0B` 24, `[07` 20, `[08` 19, `[0A]` 18, `[06` 16, `[09]` 14, `[12]` 13, `[04:` 2.

### 1.4 Dialogue box flow (`code_012C27`)

1. Entry (DL01) pushes P and B and chooses the data bank; DL02 initialises the text state and looks at the first byte.
2. First byte `$01` (`[CUR]`): a plain print, `X` = the caller's position is pushed as the line start (DL04) and the `[CUR]` is then handled by the loop. First byte `$10`: draws the standard box `[07:16,9]` at `$0408` (22 x 9 interior, DL03 -> DL18) and starts. Anything else: continue an interrupted dialogue with `X = $03F3` as the line start: with `$1B84 != 0` go to the next line (DL27), else clear the box and restart (DL10 through the `BRL` stub `loc_012C59`).
3. The main loop (DL05) fetches a byte with `code_012F6E` and dispatches; `[N]` is tested first, then `$14`, then the glyph range, then `$00`, then the ladder. A glyph (DL06) writes both halves, ticks (`code_013124`: sets the upload flag, waits `$1B84` frames, blips when `$03F5 != 0`) and advances `X` by 2.
4. `[N]` goes to DL27: it pops the line start, tests `$7F7080,X`, the tile two rows below the current line start. If that is not the bottom border (`4`): `X += $80` (the next two-row line) and back to the loop. If it is the border (the box is full): with `$1B84 = 0` it goes to DL26 (blink the prompt and restart the page), else it scrolls the interior up two rows (`code_0130CA` finds the bounds, `code_013080` copies and clears) and stays on the same line start.
5. `[FIN]` (DL25 -> DL26): loads the line start, finds the window bounds, blinks the ▼ at line start + `((w - 1) & ~1) + $40` (`code_01303A`), then goes to DL27 when `$1B84 != 0` (next line) or restarts the page (DL10).
6. `$00` (DL28: wait for a key first) and `[END]` leave through DL29: `PLX; STX $03F3; LDA #1; TSB vram_upload_flags; PLB; PLP; RTL`.

The window bounds the scanner `code_0130CA` writes: `$03EB` word = interior top-left offset, `$03ED` byte = interior width (counted to tile `8`), `$03EF` byte = interior height (counted to tile `6`). `$03EE` and `$03F0` are never written and the code reads `$03ED` and `$03EF` as words (M = 16), so the renderer relies on them being 0 (OQ-I010-9).

### 1.5 Name entry screen (`code_0124EE`)

Screen text `asciistring_01445D`: the prompt "Please enter your name-" at `$24A`, a window `[07:1A,13]` (26 x 19) at `$184`, the current name `[02:2]` at `$318` (one-row font via `[09]`), and 8 `+` placeholders at `$358` (one-row font). Grid text `asciistring_014485` at `$3C6`: rows of 13 columns (two tiles per letter, a blank then the letter): `A-M`, `N-Z`, `a-m`, `n-z`, then `0 1 2 3 4 5 6 7 8 9 - ← Æ`; rows are `$80` apart with an extra `$40` after rows 1 and 3. `←` is tile `$24` (backspace) and `Æ` is tile `$23` (accept the name). Screen state: `$0441` column (0-12), `$0443` row (0-4), cursor tile `$2B` drawn at `X` and `X - $40` (a two-row cursor). The name buffer is `$1B92-$1B99` (8 characters); `Y` points at the next free byte and a character is appended only while `Y < $1B9A`; the terminator 0 is written at `[Y]` when the name is finished (`$1B9A` therefore holds the terminator of a full 8-character name; OQ-I010-13).

| Button | Handler | Effect |
|--------|---------|--------|
| Right (bit 0) | NE08 | `col < 12`: `col++`, `X += 4`; else `col = 0`, `X -= $30` |
| Left (bit 1) | NE07 | `col > 0`: `col--`, `X -= 4`; else `col = 12`, `X += $30` |
| Down (bit 2) | NE06 | `row < 4`: `row++`, `X += $80` (+`$40` when leaving row 1 or 3); else `row = 0`, `X -= $280` |
| Up (bit 3) | NE05 | `row > 0`: `row--`, `X -= $80` (-`$40` more when the old row is 2 or 4); else `row = 4`, `X += $280` |
| Start (bit 4) | NE11 | finish (an empty name cannot finish) |
| Y (bit 6) | NE09 | backspace (ignored when the name is empty) |
| B (bit 7) | NE10 | read the tile at `$7F7002,X` (the letter right of the cursor): `$23` finishes, `$24` backspaces, else append, `BRK #$18` (confirm), redraw |
| Select (bit 5) | - | ignored |

Every cursor move jumps to NE02 (`BRK #$07` blip) which falls into NE03 (redraw: reprint both strings, which also erases the old cursor, then draw the cursor). Walkthrough `01-in-the-beginning.md`: "You will then get to pick a name for yourself. Choose what you will; there is no default name to be used." The code agrees (no default, the buffer is only continued if it already holds a name: NE01 scans for the first 0 byte). `engine_006B7F` copies 8 bytes of `$1B92` to `$0447` for the save-slot display.

### 1.6 Dictionary expansion

`code_0129DA` (menu) and `code_012F6E` (dialogue) read the string byte; if it is `>= $80` they switch DBR to `$10`, set `Y = 12 * (byte & $7F)` and print up to 12 characters (0 terminates early) from `lookup_080000` (`$10:8000`, 12-byte entries, 128 entries), then print one blank and continue with the next string byte. Every expansion therefore ends in exactly one blank; `us/stringTypes.json` stores the same words with a trailing space. The `$&string_lookup_080000.lookup_080000` references (menu: `loc_012A00`; dialogue: `loc_012F94`) read the label with a same-bank `&`, and the DBR comes from the same label's `^`, so both follow the block wherever the packer puts it. Entry `$06` is spelled `Deathtole` (OQ-I010-2, DISCREPANCY).

### 1.7 Gauge bar (`code_012ABF`, `[04:cur,max]`)

`cur` and `max` are read as words but only the low byte is used (`dp00` = cur, `dp02` = max). The colour index is `X = 2 * floor(cur / 10)` taken **before** the clamp to 50 (`$32`), and the colour comes from `data_00F9F7.word_00FB2F[X]` (13 words, offsets 64303-64329: `$79E0` x 5, `$7AE0`, `$5FC0`, `$03D7`, `$03DE`, `$3FDE`, `$7BDE` x 3, that is BGR555 dark blue for `cur < 50`, light blue, cyan-green, green, yellow, pale yellow and white from 100 on). It is written to `$7F0014`/`$7F0015` (CGRAM colour 10) when the low byte of the bar start offset is `$CC` (the HP gauge of the HUD, A5 D13), else to `$7F001C`/`$7F001D` (colour 14, the enemy gauge at `$14C`, A5 D17). After the clamp the bar is `ceil(max / 2)` tiles built from `$1B-$1F` (2 units per tile, odd end `$1C` and tail `$1F`). It writes the tile low bytes only (the attribute stays what the page holds) and `X` ends at the bar end.

This matches the walkthrough: `level-up.md` says the bar has fifty units and "as it goes into newer colors ... each color adds ten more HP total, up to white". A `cur` of 130 or more indexes past the 13-entry table into `table_00FB49` (OQ-I010-5); `enemy-bestiary.md` lists Deathtoll at 200 HP total and several bosses at 100-150.

### 1.8 Staff roll (`code_0126CF`)

DBR is forced to `$02`, `X` starts at `$0702` and is pushed as the line start. Per glyph: tile `c` with attribute `$21` at `X` (top half, tile bit 8 set by the attribute) and tile `c` with attribute `$20` at `(X + $40) & $7FF` (bottom half), then `X += 2`. The buffer wraps inside the 2 KB page (`& $7FF`) and the BG3 vertical scroll `scroll_bg3_y` (8-bit) does the movement: `[N]` sets `vram_upload_flags` bit 0, runs 32 frames (`INC scroll_bg3_y; JSL engine_000000.code_0001BE`), moves the line start to `(old + $100) & $7FF` (4 tile rows) and clears 128 words (`$00`, attribute `$20`) at the new line start (whether that can overwrite a line still on screen is OQ-I010-17). `[14:n]` indents (`X += 2n`); `00` ends (`PLX; PLB; PLP; RTL`, X not preserved). The only caller is `common_actor_00729D_part2.code_007638` (which does PHX/PLX around it) with `Y = lib_016264.asciistring_016264` ("The staff of Soul Blazer ..."). Walkthrough `08-world-of-evil.md` ends with "Enjoy the credits" and does not quote the text. ROM text quirks are OQ-I010-11, the run time (the number of `[N]` lines x 32 frames) is OQ-I010-12.

### 1.9 Frame and button wait helpers

`code_013161` runs one sub-frame (`engine_000000.code_0001BE`, which preserves A, X, Y, B and DBR) and returns `joy_pressed+1` in A. `code_013169` does that when `$03D2 = 0` (NMI off, the screen is driven by sub-frames) and otherwise waits for the next vblank (`lib_shared_0131B7.code_0131B7`) and returns `joy_pressed+1`: it is the "one frame, give me the buttons" call for both modes (13 callers: `lib_0118FC` x4, `lib_0118FC_part2` x4, `lib_012281` x2, `lib_0124EE` x3). `code_01314A` waits until none of the `$CF` buttons is down, then until one is, consumes it (`TRB $032B,#$C0` clears the release-latch bits and `STZ $0323` clears the pressed byte) and returns. `code_013140` (RTL) loops `code_0001BE` n times.

### 1.10 Text state bytes

Layout and widths are in section 4.1.

## 2. Routine table

Rows are in file and offset order. "Callers" counts are of the label itself; for dispatch targets the one site is the dispatch ladder or branch named in the Name column's evidence.

### 2.1 Menu graphics and palette loaders (`lib_shared_012416`)

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|----------------------|----|-----|----------|--------------|
| GX01 | `code_012416` | 74774 / 39 | 2 (`lib_0118FC` L018 at 72682, `lib_01232B` at 74565) | menu / VRAM | `LoadMenuIconGraphics` (B; code, hw, caller) | M=8, X=16, NMI off (`lib_01232B`/L018 call it with the screen blanked) | DMA channel 0 mode 1 (`$2118`/`$2119`), source `$09:B000` (`graphics_04B000`, 8192 bytes), VRAM word `$2000` (byte `$4000`, BG1/BG2 char base set by `BG12NBA = $20` in `lib_01232B`), size `$2000` | A, X, DMA channel 0 | `VMADDL`, `DMAP0`, `BBAD0`, `A1T0L`, `A1B0`, `DAS0L`, `MDMAEN`; does not write `VMAIN` (OQ-I010-8) |
| GX02 | `code_01243D` | 74813 / 19 | 3 (`lib_0118FC` at 72685 and 73051, `lib_01232B` at 74568) | menu / palette | `LoadMenuBgPalette` (B; code, caller) | M=8 | 256 bytes of `data_04F000.binary_04F100` (`$09:F100`) copied to `cgram_buffer` (`$7F:0000`, CGRAM colours 0-127) with `MVN`; the NMI uploads the buffer | A, X, Y (B and P restored) | `cgram_buffer` (w) |

### 2.2 Name entry (`lib_0124EE`)

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|----------------------|----|-----|----------|--------------|
| NE01 | `code_0124EE` | 74990 / 17 | 1 (`cop_handler_005E05` `Cop3A`, `TYX; JSL`, actor `common_actor_00797B`) | name entry | `EnterPlayerName` (A; code, caller, walk) | X = actor slot (set by `Cop3A`), M=8, X=16 | name in `$1B92-$1B99`, 0-terminated; returns after the finish frame | none (PHX/PHY/PHP restored) | `$0441` (w, cleared), `$0443` (w, cleared), `$1B92-$1B99` (rw), X = `$03C6` (start) |
| NE02 | `loc_012507` | 75015 / 2 | 10 (every cursor move and the accept path) | name entry | `BlipAndRedrawNameEntry` (B; code) | - | `BRK #$07` then falls into NE03 | A | sound |
| NE03 | `loc_012509` | 75017 / 28 | 1 (`BRL` from `loc_012631`, the append, after its `BRK #$18`; plus the fall-through from NE02) | name entry | `DrawNameEntryScreen` (A; code, cons) | X = cursor offset, Y = name length | prints `asciistring_01445D` and `asciistring_014485`, draws the cursor tiles `$2B` at `X` and `X - $40` (`$7F6FC0,X`), then falls into the key wait | A, X (Y preserved) | `bg3_tilemap_buffer` (w), `$7F6FC0-$7F6FFF` (w) |
| NE04 | `loc_01252C` | 75052 / 9 | 4 (the redraw falls in; ladder branches return here) | name entry | `PollNameEntryKeys` (B; code) | - | A = `joy_pressed+1` from `code_013169`; the `LSR` ladder (NE05-NE11 targets) | A | `joy_pressed+1` (r) |
| NE05 | `loc_01255C` | 75100 / 16 | 1 (ladder) | name entry | `MoveNameCursorUp` (A; code, cons) | `$0443` row | row and `X` updated, jumps to NE02 | A | `$0443` (rw) |
| NE06 | `loc_012593` | 75155 / 18 | 1 (ladder) | name entry | `MoveNameCursorDown` (A; code, cons) | `$0443` row | row and `X` updated, jumps to NE02 | A | `$0443` (rw) |
| NE07 | `loc_0125CA` | 75210 / 15 | 1 (ladder) | name entry | `MoveNameCursorLeft` (A; code, cons) | `$0441` col | col and `X` updated, jumps to NE02 | A | `$0441` (rw) |
| NE08 | `loc_0125EB` | 75243 / 17 | 1 (ladder) | name entry | `MoveNameCursorRight` (A; code, cons) | `$0441` col | col and `X` updated, jumps to NE02 | A | `$0441` (rw) |
| NE09 | `loc_01260C` | 75276 / 8 | 2 (ladder; the `←` tile in NE10) | name entry | `DeleteNameChar` (A; code, cons) | Y = name end | `Y--` and a 0 written at `[Y]` unless the name is empty; redraw | A | `$1B92-$1B99` (w) |
| NE10 | `loc_01261D` | 75293 / 20 | 1 (ladder) | name entry | `PickNameChar` (A; code, cons) | X = cursor offset | reads the tile at `$7F7002,X`: `$23` -> NE11, `$24` -> NE09, else if `Y < $1B9A` append (`loc_012631`: store at `[Y]`, `INY`, `BRK #$18`, redraw), else back to NE04 | A | `bg3_tilemap_buffer` (r) |
| NE11 | `loc_01263E` | 75326 / 8 | 2 (ladder start button; the `Æ` tile in NE10) | name entry | `FinishNameEntry` (A; code, cons, walk) | Y = name length | refuses an empty name (returns to NE04), else writes the terminator, prints `asciistring_014512` (`[08:184]` erases the window) and runs one `code_013169` frame | A | `$1B92-$1B99` (w), `bg3_tilemap_buffer` (w) |

The append branch (`loc_012631`, 75313 / 13) has no row of its own because it is entered only from NE10; see section 6.

### 2.3 Staff roll (`lib_0126CF`)

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|----------------------|----|-----|----------|--------------|
| ST01 | `code_0126CF` | 75471 / 12 | 1 (`common_actor_00729D_part2.code_007638`, line 191, 30268) | credits | `ScrollStaffRollText` (B; code, caller) | Y = `lib_016264.asciistring_016264`; the caller saves X (COP slot) | the whole text printed and scrolled (32 frames per line) | A, X, Y (P, B restored) | `bg3_tilemap_buffer` (w), `scroll_bg3_y` (rw), `vram_upload_flags` (w) |
| ST02 | `loc_0126DB` | 75483 / 8 | 3 (the glyph path, the indent path and the line path loop back) | credits | `NextStaffRollByte` (B; code) | Y | next string byte; `00` -> ST05, `[N]` -> ST03, `[14]` -> ST04, else the glyph path | A | - |
| ST03 | `loc_012715` | 75541 / 7 | 1 (dispatch) | credits | `ScrollStaffRollLine` (B; code) | X, the stacked line start | 32 frames of `INC scroll_bg3_y` with a sub-frame each, new line start `(old + $100) & $7FF`, clear 128 words | A | `scroll_bg3_y`, `vram_upload_flags` |
| ST04 | `loc_01274F` | 75599 / 22 | 1 (dispatch) | credits | `IndentStaffRollLine` (B; code) | Y at the operand | `X += 2n` | A | - |
| ST05 | `loc_012765` | 75621 / 4 | 1 (dispatch) | credits | `EndStaffRoll` (B; code) | - | `PLX; PLB; PLP; RTL` | X | - |

### 2.4 Text renderer (`code_012769` and its handlers)

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|----------------------|----|-----|----------|--------------|
| TR01 | `code_012769` | 75625 / 25 | 58 in 13 files: `common_actor_001A28_part4` x2, `common_actor_0066C6` x1, `common_actor_0066FC` x16, `common_actor_00729D` x7, `cop_handler_0057BD` (Cop02) x1, `cop_handler_005A43` (Cop1A) x1, `w0_actor_01B33A` x1, `lib_0118FC` x14, `lib_0118FC_part6` x6, `lib_0124EE` x3, `lib_027572` x3, `engine_000000` x1, `engine_006B7F` x2 | text | `PrintTextString` (A; code, caller, walk) | Y = string (bank `$02`), X = BG3 offset, M=8 X=16, long call (`JSL`) | string printed, `vram_upload_flags` bit 0 set, X = the last line start | A, X, Y; DP `$00`, `$02`, `$0C`, `$0E/$0F` | `$03E9`/`$03F9` (saved and restored), `bg3_tilemap_buffer`, `vram_upload_flags` |
| TR02 | `loc_012782` | 75650 / 10 | 17 (every handler returns here) | text | `DispatchTextCode` (B; code) | Y | fetches via `code_0129DA`, dispatches on the byte (1.3) | A | - |
| TR03 | `loc_0127E4` | 75748 / 24 | 1 (dispatch, glyph range) | text | `PrintGlyph` (A; code, cons) | A = char, X | both tiles written, `X += 2`; top half in `loc_0127FC` (inventory) | A | `bg3_tilemap_buffer` (w), `$7F6FC0-$7F6FFF` (w) |
| TR04 | `loc_012809` | 75785 / 11 | 1 (dispatch) | text | `HandleJumpCode` (A; code, cons) | Y at the operand | `Y` = word | A | - |
| TR05 | `loc_012814` | 75796 / 7 | 1 (dispatch) | text | `HandleBlankRunCode` (A; code, cons) | Y at the operand | n blank low bytes (`X += 2n`) | A | `bg3_tilemap_buffer` (w) |
| TR06 | `loc_012829` | 75817 / 34 | 1 (dispatch) | text | `HandleRepeatTileCode` (A; code, cons) | Y at the operands | tile t repeated `count` times | A | `bg3_tilemap_buffer` (w) |
| TR07 | `loc_01285A` | 75866 / 11 | 1 (ladder) | text | `HandleAltFontCode` (B; code) | - | `$03F9 ^= $80` | A | `$03F9` (rw) |
| TR08 | `loc_012865` | 75877 / 11 | 1 (ladder) | text | `HandleFontPageCode` (B; code) | - | `$03E9 ^= $02` | A | `$03E9` (rw) |
| TR09 | `loc_012870` | 75888 / 18 | 1 (ladder) | text | `HandleEraseWindowCode` (A; code, callee) | Y at the operand | `X` = word, calls `code_012BDA` | A, X | - |
| TR10 | `loc_012882` | 75906 / 32 | 1 (ladder) | text | `HandleWindowCode` (A; code, callee, cons) | Y at the operands | `STX $03F7`, `code_012B5D`, cursor to line start + `$82` | A, X | `$03F7` (w) |
| TR11 | `loc_0128A2` | 75938 / 35 | 1 (ladder) | text | `HandleBcdNumberCode` (A; code, cons) | Y at the operands | digits right to left, leading zeros blanked except the last digit | A, X | `bg3_tilemap_buffer`, `$7F6FC0-$7F6FFF` (w) |
| TR12 | `loc_012931` | 76081 / 41 | 1 (ladder) | text | `HandleTableStringCode` (A; code, cons) | Y at the operands | list base, index read from memory (`[TBL:list,addr]`), print via `code_012A48` | A, X | - |
| TR13 | `loc_01295A` | 76122 / 36 | 1 (ladder) | text | `HandleGaugeCode` (A; code, callee) | Y at the operands | words fetched, `code_012ABF` | A, X | - |
| TR14 | `loc_01297E` | 76158 / 15 | 1 (ladder) | text | `HandleAttributeCode` (A; code) | Y at the operand | `$03E9 = ($03E9 & $E3) \| v` | A | `$03E9` (rw) |
| TR15 | `loc_01298D` | 76173 / 29 | 1 (ladder) | text | `HandleListStringCode` (A; code, cons) | Y at the operand | `binary_list_014789[n]` printed with `code_012A92` | A, X | - |
| TR16 | `loc_0129AA` | 76202 / 17 | 1 (ladder) | text | `HandleCursorCode` (A; code, cons) | Y at the operand | `X` and the line start = word | A, X | - |
| TR17 | `loc_0129BB` | 76219 / 14 | 1 (dispatch) | text | `HandleNewlineCode` (A; code, cons) | X, stacked line start | line start + `$40`, `X` = line start | A, X | - |
| TR18 | `loc_0129C9` | 76233 / 17 | 1 (dispatch, `00`) | text | `EndTextString` (A; code) | - | restores `$03F9` and `$03E9`, sets `vram_upload_flags` bit 0, `PLX`, RTL | A | `$03E9`, `$03F9` (w), `vram_upload_flags` (w) |
| TR19 | `code_0129DA` | 76250 / 7 | 4 (3 `JSR` in this renderer; a self-loop `BRA`) | text | `ReadTextByte` (A; code, callee) | Y | A = next byte; dictionary bytes are expanded and the loop re-reads; Y advanced | A | `lookup_080000` (r) |
| TR20 | `loc_0129E1` | 76257 / 31 | 1 (`BMI` in TR19) | text | `ExpandDictionaryWord` (A; code, cons) | A = byte >= `$80`, X | up to 12 characters from `lookup_080000` written (two-row, bit-9 aware), then one blank, then back to `code_0129DA` | A, Y (PHY/PLY), DBR restored | `bg3_tilemap_buffer` (w) |
| TR21 | `code_012A48` | 76360 / 8 | 4 (1 `JSR`; 3 internal) | text | `PrintStringWithRuns` (A; code, cons) | Y = string, X, attribute in B (XBA) | prints to a 0 byte, supports `$14` runs and dictionary bytes; Y on the terminator | A, X | `bg3_tilemap_buffer` (w) |
| TR22 | `code_012A92` | 76434 / 8 | 3 (1 `JSR`; 2 internal) | text | `PrintStringPlain` (A; code, cons) | Y = string, X, attribute in B | prints to a 0 byte (no `$14`); Y on the terminator | A, X | `bg3_tilemap_buffer` (w) |
| TR23 | `code_012ABF` | 76479 / 6 | 2 (internal: TR13 and DL21) | text | `DrawGaugeBar` (A; code, cons, walk) | `dp00` = cur, `dp02` = max, X = bar start | bar tiles `$1B-$1F`, colour written to CGRAM buffer 10 or 14 (1.7); X = bar end | A, Y, `dp00`, `dp02` clamped to 50 | `cgram_buffer+$14/$15` and `+$1C/$1D` (w), `word_00FB2F` (r), `bg3_tilemap_buffer` (w) |
| TR24 | `code_012B5D` | 76637 / 13 | 2 (TR10, DL18) | text | `DrawWindowFrame` (A; code, cons) | X = origin, `dp00` = w, `dp02` = h | border low bytes written, interior words `$03E9:$20` | A, X, `dp0C`, `dp0E/$0F` | `bg3_tilemap_buffer` (w) |
| TR25 | `code_012BDA` | 76762 / 14 | 4 (2 external: `Cop02` and `Cop1A`; 2 internal: TR09, DL16) | text | `EraseWindowFrame` (A; code, caller) | X = window origin (must be tile `$01`) | the window and border cleared with `$2000` | A, X (Y preserved by PHY/PLY) | `bg3_tilemap_buffer` (rw); does **not** set `vram_upload_flags` (both callers `Cop02` and `Cop1A` set it right after the call) |

### 2.5 Dialogue renderer (`code_012C27`)

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|----------------------|----|-----|----------|--------------|
| DL01 | `code_012C27` | 76839 / 14 | 7: `cop_handler_0057A2` (Cop01_ShowText) x1, `lib_0109D6` x3, `lib_010EA9_part1` x2, `engine_000000` x1 (the debug scanner, FM-A2 R07) | dialogue | `ShowDialogueText` (A; code, caller, walk) | Y = string, X = BG3 position when the string starts with `[CUR]` (it is pushed as the line start) or is a continuation (X is ignored then, `$03F3` is used); DBR = the caller's (`$01` is changed to `$02`), M=8, X=16, long call | text typed or boxed, `$03F3` saved at the end; P and B restored | A, X, Y | see DL02-DL31 |
| DL02 | `loc_012C35` | 76853 / 36 | 1 (fall-through, `BNE`) | dialogue | `InitDialogueState` (B; code) | first string byte | `$03E9 = $20`, `$03F5 = 1`, `$03F9 = 0`; continue as in 1.4 | A | `$03E9`, `$03F5`, `$03F9` (w), `$1B84` (r), `$03F3` (r) |
| DL03 | `loc_012C5C` | 76892 / 16 | 1 (first byte `$10`) | dialogue | `OpenDialogueBox` (A; code, cons) | - | `[07:16,9]` at `$0408` (22 x 9 interior) drawn via DL20; `$03F7` is **not** set (OQ-I010-14) | A, X | `bg3_tilemap_buffer` (w) |
| DL04 | `loc_012C6C` | 76908 / 1 | 1 (first byte `$01`) | dialogue | `BeginPlainDialogue` (B; code) | X | `PHX` as the line start | - | - |
| DL05 | `loc_012C6D` | 76909 / 10 | 20 (the main loop) | dialogue | `DispatchDialogueCode` (B; code) | Y | fetches with `code_012F6E`, dispatches (1.3) | A | - |
| DL06 | `loc_012CF7` | 77047 / 33 | 1 (glyph range) | dialogue | `PrintDialogueGlyph` (A; code, cons) | A = char | two-row write, or one-row write plus the stale-overlay clean-up and `$FE`/`$FF` overlay tiles for `c >= $CC` (OQ-I010-6); `code_013124` tick | A, X | `bg3_tilemap_buffer` (w), `$7F6FBE/$7F6FBF,X` (rw) |
| DL07 | `loc_012D48` | 77128 / 11 | 1 (ladder `$13`) | dialogue | `HandleDialogueJump` (A; code, cons) | Y | `Y` = word | A | - |
| DL08 | `loc_012D53` | 77139 / 7 | 1 (dispatch `$14`) | dialogue | `HandleDialogueBlankRun` (A; code, cons) | Y | n blank bytes, no tick | A | `bg3_tilemap_buffer` (w) |
| DL09 | `loc_012D68` | 77160 / 6 | 1 (ladder `$12`) | dialogue | `HandleWaitKeyCode` (A; code, callee) | - | `code_01314A` | A | `$0323`, `$032B` |
| DL10 | `loc_012D6E` | 77166 / 23 | 3 (the `BRL` stub `loc_012C59`, ladder `$10`, DL26) | dialogue | `RestartDialoguePage` (A; code, cons) | - | `code_0130CA` bounds, `code_01300F` clear, `X` = `$03EB + $40` | A, X | `$03EB` (r), `bg3_tilemap_buffer` (w) |
| DL11 | `loc_012D85` | 77189 / 11 | 1 (ladder `$0F`) | dialogue | `HandleBlipToggleCode` (B; code) | - | `$03F5 ^= 1` | A | `$03F5` (rw) |
| DL12 | `loc_012D90` | 77200 / 12 | 1 (ladder `$0E`) | dialogue | `HandleDelayCode` (A; code, cons) | Y at the operand | if `$1B84 != 0`: wait n frames via `code_013140`; the operand is always consumed | A, Y | `$1B84` (r) |
| DL13 | `loc_012DA0` | 77216 / 6 | 1 (ladder `$0B`) | dialogue | `SkipRepeatTileCode` (B; code) | Y | skips the 3 operand bytes; the repeat-tile command is not drawn in dialogue | - | - |
| DL14 | `loc_012DA6` | 77222 / 11 | 1 (ladder `$0A`) | dialogue | `HandleDialogueAltFontCode` (B; code) | - | `$03F9 ^= $80` | A | `$03F9` (rw) |
| DL15 | `loc_012DB1` | 77233 / 11 | 1 (ladder `$09`) | dialogue | `HandleDialogueFontPageCode` (B; code) | - | `$03E9 ^= $02` | A | `$03E9` (rw) |
| DL16 | `loc_012DBC` | 77244 / 18 | 1 (ladder `$08`) | dialogue | `HandleDialogueEraseWindowCode` (A; code, callee) | Y | `X` = word, `code_012BDA` | A, X | - |
| DL17 | `loc_012DCE` | 77262 / 12 | 1 (ladder `$07`) | dialogue | `HandleDialogueWindowCode` (A; code, callee) | Y | width and height fetched, falls into DL18 | A | - |
| DL18 | `loc_012DDA` | 77274 / 17 | 1 (`BRL` from DL03; plus the fall-through from DL17) | dialogue | `DrawDialogueWindow` (A; code, cons) | `dp00`, `dp02` | `code_012B5D`, cursor to line start + `$82` | A, X | `bg3_tilemap_buffer` (w) |
| DL19 | `loc_012DEB` | 77291 / 35 | 1 (ladder `$06`) | dialogue | `HandleDialogueBcdCode` (A; code, cons) | Y | digits printed (same as TR11, plus tick) | A, X | `bg3_tilemap_buffer` (w) |
| DL20 | `loc_012E7A` | 77434 / 51 | 1 (ladder `$05`) | dialogue | `HandleDialogueTableStringCode` (A; code, cons) | Y | list/index operands, `code_012FDF` with DBR `$02` | A, X | - |
| DL21 | `loc_012EAD` | 77485 / 36 | 1 (ladder `$04`) | dialogue | `HandleDialogueGaugeCode` (A; code, callee) | Y | `code_012ABF` | A, X | - |
| DL22 | `loc_012ED1` | 77521 / 15 | 1 (ladder `$03`) | dialogue | `HandleDialogueAttributeCode` (A; code) | Y | `$03E9 = ($03E9 & $E3) \| v` | A | `$03E9` (rw) |
| DL23 | `loc_012EE0` | 77536 / 39 | 1 (ladder `$02`) | dialogue | `HandleDialogueListStringCode` (A; code, cons) | Y | `binary_list_014789[n]` via `code_012FDF` | A, X | - |
| DL24 | `loc_012F07` | 77575 / 17 | 1 (ladder `$01`) | dialogue | `HandleDialogueCursorCode` (A; code, cons) | Y | `X` and line start = word | A, X | - |
| DL25 | `loc_012F18` | 77592 / 1 | 1 (ladder `$11`, `BRL`) | dialogue | `HandleFinishCode` (A; code, cons, walk) | the stacked line start | `PLX` (line start into X) and falls into DL26 | X | - |
| DL26 | `loc_012F19` | 77593 / 34 | 1 (`BEQ` in DL27, bottom border with `$1B84 = 0`; plus the DL25 fall-through) | dialogue | `PromptThenAdvance` (A; code, cons) | X = line start | `PHX`, bounds (`code_0130CA`), ▼ blinked at line start + `((w - 1) & ~1) + $40` via `code_01303A`, then DL27 when `$1B84 != 0`, else DL10 | A, X | `$03ED` (r), `$1B84` (r) |
| DL27 | `loc_012F3B` | 77627 / 22 | 3 (entry resume with `$1B84 != 0`, the `[N]` dispatch, the `BNE` in DL26) | dialogue | `AdvanceDialogueLine` (A; code, cons) | the stacked line start | pops it, `$7F7080,X` = the tile two rows below: not the bottom border (`4`) -> `X += $80`; border with `$1B84 = 0` -> DL26; border otherwise -> `code_0130CA` + `code_013080` (scroll up two rows); pushes the new line start and returns to DL05 | A, X | `bg3_tilemap_buffer` (r), `$1B84` (r) |
| DL28 | `loc_012F5F` | 77663 / 3 | 1 (`BRL`, the first-byte `$00` test) | dialogue | `HandleEndWaitCode` (A; code, callee) | - | `code_01314A` (wait for a key), falls into DL29 | A | `$0323`, `$032B` |
| DL29 | `loc_012F62` | 77666 / 12 | 1 (ladder `$0C`, `BRL`; plus the DL28 fall-through) | dialogue | `EndDialogue` (A; code, callee, cons) | the stacked line start | `PLX; STX $03F3; LDA #1; TSB vram_upload_flags; PLB; PLP; RTL` | A, X | `$03F3` (w), `vram_upload_flags` (w) |
| DL30 | `code_012F6E` | 77678 / 7 | 3 (DL05, `code_012FDF`, a self-loop `BRA`) | dialogue | `ReadDialogueByte` (A; code, cons) | Y | A = next byte, dictionary bytes expanded with a tick per character | A | `lookup_080000` (r) |
| DL31 | `loc_012F75` | 77685 / 31 | 1 (`BMI` in DL30) | dialogue | `ExpandDialogueWord` (A; code, cons) | A = byte, X | like TR20, each character through `code_013124` (counter in `dp14`) | A, Y (PHY/PLY) | `bg3_tilemap_buffer` (w) |
| DL32 | `code_012FDF` | 77791 / 8 | 4 (DL20, DL23 and 2 self-loops) | dialogue | `PrintDialogueString` (A; code, cons) | Y, X, attribute in B | like TR21/TR22 (no `$14` runs) plus a tick per glyph | A, X | `bg3_tilemap_buffer` (w) |

### 2.6 Dialogue and wait helpers

| # | Label | Off / size | Callers | Subsystem | Name (conf, evidence) | In | Out | Clobbers | Data touched |
|---|-------|-----------|---------|-----------|----------------------|----|-----|----------|--------------|
| HL01 | `code_01300F` | 77839 / 10 | 1 (DL10) | dialogue | `ClearTextWindowInterior` (A; code, cons) | `$03EB`, `$03ED`, `$03EF` | interior filled with `$2020` | A, X | `bg3_tilemap_buffer` (w) |
| HL02 | `code_01303A` | 77882 / 2 | 2 (DL26, and a self-loop `BNE`) | dialogue | `BlinkContinuePrompt` (A; code, cons, walk) | X = prompt position | blinks tile `$3D` / blank on `frame_counter & $10`, first while B or Y is still held, then until B or Y (`$0323 & $C0`) is pressed; then blanks the prompt and sets the upload flag | A, X | `frame_counter` (r), `$0323` (r), `bg3_tilemap_buffer` (w) |
| HL03 | `code_013080` | 77952 / 17 | 1 (DL27) | dialogue | `ScrollTextWindowUp` (A; code, cons) | `$03EB`, `$03ED`, `$03EF` | `h - 3` rows copied up by two rows, the last two rows cleared | A, X, Y | `bg3_tilemap_buffer` (rw) |
| HL04 | `code_0130CA` | 78026 / 2 | 3 (DL10, DL26, DL27) | dialogue | `FindTextWindowBounds` (A; code, cons) | X = a position in the window | scans left to tile `7` and up to tile `3` then right to `8` and down to `6`; writes `$03EB` (word), `$03ED` (byte), `$03EF` (byte) | A (X, Y preserved) | `$03EB`, `$03ED`, `$03EF` (w), `bg3_tilemap_buffer` (r) |
| HL05 | `code_013124` | 78116 / 7 | 3 (DL06 via `loc_012D42`, DL31, DL32) | dialogue | `TickAfterGlyph` (A; code, cons) | A = char | for a non-blank char: sets `vram_upload_flags` bit 0, waits `$1B84` frames (`code_013140`), `BRK #$07` if `$03F5 != 0` | A | `vram_upload_flags`, `$1B84` (r), `$03F5` (r) |
| HL06 | `code_013140` | 78144 / 9 | 5 (`engine_000000` line 201, `lib_0109D6` line 154, HL05, DL12 and a self-loop `BRA`) | engine | `WaitFrames` (A; code, callee, cons) | A = frame count, long call | loops `JSL engine_000000.code_0001BE; DEC` until 0, RTL | A | - |
| HL07 | `code_01314A` | 78154 / 7 | 3 (DL09, DL28 and a self-loop `BNE`) | engine | `WaitForButtonPress` (A; code, cons) | - | waits until no `$CF` button is down, then until one is; clears `$032B` bits `$C0` and `$0323` | A | `$0323`, `$032B` (rw) |
| HL08 | `code_013161` | 78177 / 8 | 5 (HL02 x2, HL07 x2 and HL09's branch) | engine | `RunFrameReadButtons` (A; code, callee) | - | one sub-frame (`code_0001BE`), A = `joy_pressed+1` | A | `joy_pressed+1` (r) |
| HL09 | `code_013169` | 78185 / 13 | 13 in 4 files (1.9) | engine | `WaitFrameReadButtons` (A; code, caller) | - | A = `joy_pressed+1`; sub-frame when `$03D2 = 0`, else vblank wait | A | `$03D2` (r), `joy_pressed+1` (r) |

### 2.7 Missing rows

None: every top-level label has a row; the inner labels (section 6) have no names proposed.

## 3. Data

### 3.1 Strings (`lib_0124EE_part2`)

| # | Label | Off / size | Callers | Proposed name (conf, evidence) | Content and consumer |
|---|-------|-----------|---------|--------------------------------|----------------------|
| SD01 | `asciistring_01445D` | 83037 / 40 | 1 (NE03) | `NameEntryFrameText` (A; code, cons) | `[CUR:184][07:1A,13][CUR:24A]Please enter your name-[CUR:318][02:2][09][CUR:358]++++++++` |
| SD02 | `asciistring_014485` | 83077 / 141 | 1 (NE03) | `NameEntryGridText` (A; code, cons) | `[CUR:3C6]` then 5 rows: `A-M`, `N-Z`, `a-m`, `n-z`, `0-9 - ← Æ`, two tiles per letter, `[N][N]` between rows and `[N][N][N]` after rows 1 and 3 |
| SD03 | `asciistring_014512` | 83218 / 4 | 1 (NE11) | `NameEntryCloseText` (A; code, cons) | `[08:184]` (erase the window) |

### 3.2 External data read by A6 code

| Label | Off / size | Read by | Content |
|-------|-----------|---------|---------|
| `graphics_04B000` | 307200-315392 (8192 raw) | GX01 | 4 KB tile set for BG1/BG2 (256 4bpp tiles; OQ-I010-10) |
| `data_04F000.binary_04F100` | `$09:F100`, 256 bytes | GX02 | CGRAM colours 0-127 |
| `data_00F9F7.word_00FB2F` | 64303-64329 (13 words) | TR23 | gauge colour ladder, 1.7 |
| `string_lookup_080000.lookup_080000` | `$10:8000`, 128 x 12 bytes | TR20, DL31 | dictionary, 1.6 |
| `lib_shared_014789.binary_list_014789` | - | TR15, DL23 | list string pointers (index 2 = `$1B92`, 3 = `$0447`) |

## 4. Structures

### 4.1 Text state (`$03E9-$03F9`)

| Addr | Width (evidence) | Field | Writers | Readers |
|------|------------------|-------|---------|---------|
| `$03E9` | byte | text attribute (bits 2-4 palette, bit 5 priority, bit 1 = tile bit 9) | TR01 (init `$20`, restore), DL02 (init `$20`), `[03]`, `[09]` | glyph and bar writers (attribute in B) |
| `$03EB` | word (`STX $03EB`, `LDX $03EB`) | interior top-left offset of the current window | HL04 | HL01, HL03, DL10 |
| `$03ED` | byte written, **read as word** (`LDA $03ED` with M=16 in HL01/HL03/DL26) | interior width | HL04 | HL01, HL03, DL26 |
| `$03EF` | byte written, **read as word** (`LDA $03EF` with M=16) | interior height | HL04 | HL01, HL03 |
| `$03F3` | word (`STX`, `LDX`) | line start to resume at | DL29 (and `engine_000000` line 383, the debug scanner) | DL02 |
| `$03F5` | byte (`LDA`/`STA` M=8) | bit 0 = typing blip enabled (init 1) | DL02, DL11 | HL05 |
| `$03F7` | word (`STX`, `LDX`) | origin of the last `[07]` window drawn by the menu renderer | TR10 | `Cop02` and `Cop1A` (as the erase target) |
| `$03F9` | byte | bit 7 = tile flip into the `$80`+ font | TR01, DL02 (init 0), `[0A]` | glyph writers (ORed into the tile byte) |
| `$0441` / `$0443` | byte each (`INC`/`DEC`/`STZ` with M=8) | name entry column / row | NE01, NE05-NE08 | the same |
| `$1B92-$1B99` | 8 bytes (the accept test is `Y < $1B9A`) | name buffer | NE09, NE10, NE11 | `[02:2]`, `engine_006B7F` |
| `$1B84` | read as a byte (`LDA $1B84` M=8 in HL05/DL12/DL27); actors write it with word stores (`LDA #$0007; STA $1B84`) | text delay in frames per printed glyph; 0 = instant | `lib_027912` (new game: 3), `engine_005354` (Deathtoll: 6), `w0_actor_01B33A` (7, 1, 5), `w5_actor_025E61` (4, 3), `w1_actor_01B98D` (saves and restores around a 5) | HL05, DL12, DL27 |

The `$1B84` width is unresolved: see OQ-I010-1 (the byte read and the word write are consistent only if `$1B85` is 0 or unused).

### 4.2 Window record (`$03EB`, `$03ED`, `$03EF`)

| Field | Offset | Width | Evidence |
|-------|--------|-------|----------|
| interior top-left | `$03EB` | word | written by `STX` in HL04, read by `LDX` in HL01/HL03/DL10 |
| interior width | `$03ED` | byte (word read, OQ-I010-9) | written `STA` M=8 in HL04, read by `LDA` M=16 |
| interior height | `$03EF` | byte (word read, OQ-I010-9) | same |

### 4.3 Dictionary entry (`lookup_080000`)

12 bytes per entry, no length field, 0-terminated (index `* 12` from `ASL/ADC/ASL/ASL` of `b & $7F`); an entry that fills all 12 bytes ends by the counter `dp0C` / `dp14` reaching 0. 128 entries: `$00` "All" ... (extracted block `string_lookup_080000`).

### 4.4 BG3 tile word

2 bytes, row stride `$40`, 32 x 32 tiles, `bg3_tilemap_buffer` (`$7F7000`): low byte tile, high byte attribute (1.1).

## 5. WRAM touched by A6 without a mnemonic (proposals only, nothing applied)

| Addr | Proposed name | Width | Evidence |
|------|---------------|-------|----------|
| `$03E9` | `text_attr` | byte | 4.1 |
| `$03EB` | `text_window_origin` | word | 4.1 |
| `$03ED` | `text_window_width` | byte | 4.1 (word read) |
| `$03EF` | `text_window_height` | byte | 4.1 (word read) |
| `$03F3` | `text_resume_pos` | word | 4.1 |
| `$03F5` | `text_blip_flag` | byte | 4.1 |
| `$03F7` | `text_last_window_origin` | word | 4.1 |
| `$03F9` | `text_font_flip` | byte | 4.1 |
| `$03D2` | `nmi_enabled` | byte | FM-A1 section 5; read by HL09 |
| `$0441` | `name_cursor_col` | byte | 1.5 |
| `$0443` | `name_cursor_row` | byte | 1.5 |
| `$1B84` | `text_delay` | byte (width OQ-I010-1) | HL05, DL12, writers in 4.1; **replaces the FM-A2 / A4 reading `ending_flag`** |
| `$1B92` | `player_name` | 8 bytes | 1.5 |
| `$0447` | `slot_name_copy` | 8 bytes | `engine_006B7F`, list entry 3 |

## 6. Branch labels that stay inside one routine (no name proposed)

All have 1 reference unless stated; the offset is the line-tracking address.

| Routine | Labels (offset) |
|---------|------------------|
| NE01 | `loc_0124FF` (75007) name-end scan loop |
| NE04 ladder | `loc_012525` (75045, release wait, 1 self-loop), `loc_012535` (75061), `loc_01253B` (75067), `loc_012541` (75073), `loc_012547` (75079), `loc_01254D` (75085), `loc_012554` (75092), `loc_01255A` (75098) |
| NE05 | `loc_01256C` (75116, the extra `-$40`), `loc_012574` (75124, the common `-$80`), `loc_012581` (75137, wrap to row 4) |
| NE06 | `loc_0125A5` (75173, the extra `+$40`), `loc_0125AD` (75181, the common `+$80`), `loc_0125BA` (75194, wrap to row 0) |
| NE07 | `loc_0125D9` (75225, wrap to column 12) |
| NE08 | `loc_0125FC` (75260, wrap to column 0) |
| NE09 | `loc_012614` (75284, write the 0 at `[Y]`) |
| NE10 | `loc_012631` (75313, append and redraw) |
| NE11 | `loc_012646` (75334, close) |
| ST01 | `loc_0126E3` (75491, the glyph path), `loc_01271C` (75548, the scroll loop), `loc_012739` (75577, the clear loop) |
| TR02 | `loc_01278C` (75660), `loc_012797` (75671), ladder `loc_0127A0` (75680), `loc_0127A6` (75686), `loc_0127AC` (75692), `loc_0127B2` (75698), `loc_0127B8` (75704), `loc_0127BE` (75710), `loc_0127C4` (75716), `loc_0127CA` (75722), `loc_0127D0` (75728), `loc_0127D6` (75734), `loc_0127DC` (75740), `loc_0127E2` (75746) |
| TR03 | `loc_0127FC` (75772, top half) |
| TR05 | `loc_01281B` (75803, loop) |
| TR06 | `loc_01284B` (75851, loop), `loc_012856` (75862, exit) |
| TR11 | `loc_0128C5` (75973), `loc_0128F4` (76020, 2 refs), `loc_01290A` (76042, 2 refs), `loc_012912` (76050), `loc_01292A` (76074) |
| TR20 | `loc_012A00` (76288, per-character loop), `loc_012A20` (76320), `loc_012A26` (76326, the trailing blank), `loc_012A42` (76354) |
| TR21 | `loc_012A50`, `loc_012A6F`, `loc_012A73`, `loc_012A79`, `loc_012A84` |
| TR22 | `loc_012A9A`, `loc_012AB5`, `loc_012AB9` |
| TR23 | `loc_012AC5`, `loc_012ACE`, `loc_012AE6`, `loc_012AF6`, `loc_012AFE`, `loc_012B08`, `loc_012B11`, `loc_012B1F`, `loc_012B28`, `loc_012B42`, `loc_012B46`, `loc_012B54`, `loc_012B5C` (3 refs, the shared `RTS`) |
| TR24 | `loc_012B6A`, `loc_012B88`, `loc_012B9D`, `loc_012BC9` |
| TR25 | `loc_012BE8`, `loc_012BF6`, `loc_012BF7`, `loc_012C01`, `loc_012C25` |
| DL01 | `loc_012C59` (76889, `BRL` stub to DL10), `loc_012C77`, `loc_012C7E` |
| DL05 ladder | `loc_012C87`, `loc_012C8D`, `loc_012C93`, `loc_012C99`, `loc_012C9F`, `loc_012CA5`, `loc_012CAB`, `loc_012CB1`, `loc_012CB7`, `loc_012CBD`, `loc_012CC3`, `loc_012CC9`, `loc_012CCF`, `loc_012CD6`, `loc_012CDC`, `loc_012CE2`, `loc_012CE8`, `loc_012CEE`, `loc_012CF4` |
| DL06 | `loc_012D18`, `loc_012D26`, `loc_012D33`, `loc_012D35`, `loc_012D42` (2 refs, the tick call) |
| DL08 | `loc_012D5A` (loop) |
| DL12 | `loc_012D9C` (skip) |
| DL19 | `loc_012E0E`, `loc_012E3D` (2 refs), `loc_012E53` (2 refs), `loc_012E5B`, `loc_012E73` |
| DL27 | `loc_012F51`, `loc_012F5B` |
| DL31 | `loc_012F94`, `loc_012FB4`, `loc_012FBD`, `loc_012FD9` |
| DL32 | `loc_012FE7`, `loc_013002`, `loc_013009` |
| HL01 | `loc_013019`, `loc_013022` |
| HL02 | `loc_01303C`, `loc_013057`, `loc_013059`, `loc_013069`, `loc_013074` |
| HL03 | `loc_013091`, `loc_013097`, `loc_0130B0`, `loc_0130B8` |
| HL04 | `loc_0130CC`, `loc_0130D8` (2 refs), `loc_0130EC`, `loc_0130F1`, `loc_0130FF`, `loc_013106`, `loc_01311C` |
| HL05 | `loc_01312B`, `loc_01313D` |
| HL06 | `loc_013149` |
| HL07 | `loc_013151` |

## 7. Findings for later batches

### 7.1 Corrections to earlier maps

1. **`$1B84` is the text delay, not `ending_flag`.** FM-A2 (conf C) and the later readers took `$1B84` for an ending flag. Evidence for the delay: HL05 loads it and waits that many frames after every non-blank glyph; DL12 and DL27 test it; the writers are the new-game init (3), the Deathtoll defeat scene (6) and speech scenes (7, 1, 5, 4, 3) that change the typing speed; `w1_actor_01B98D` saves the value and restores it around a scene. This answers OQ-I006-12 (OQ-I010-1 asks for the runtime check).
2. **OQ-I007-15 (name buffer width):** 8 characters at `$1B92-$1B99`, accepted only while `Y < $1B9A`; the terminator goes at `[Y]`.
3. **OQ-I007-17:** `$03F7` is the origin of the last `[07]` window drawn by the menu renderer: `Cop02` and `Cop1A` print a choice window, run the chooser `lib_012281.code_012281`, then erase the window at `$03F7` (`code_012BDA`) and set the upload flag. `$03F3` is the dialogue resume position. The dialogue renderer's own boxes do not set `$03F7` (OQ-I010-14 asks who removes a dialogue box).
4. **`code_012416` (A5 "menu graphics")** loads `graphics_04B000` to VRAM byte `$4000`, which `lib_01232B` selects as the BG1/BG2 character base (`BG12NBA = $20`).

### 7.2 Decode anomalies

None. M and X are consistent in every A6 label (`REP`/`SEP` and the extracted widths agree with the instruction bytes in the sampled handlers; the whole `lib_shared_012769` file was read).

### 7.3 Placement proposals for PB

- `lib_shared_012769` is two renderers in one file: the menu renderer (`code_012769` to `code_012BDA` + the shared printers) and the dialogue renderer (`code_012C27` to `code_01314A`). A split at `code_012C27` (76839) is possible without changing the layout, because the `$&` references stay in bank `$02`.
- The name entry screen and its three strings belong with `Cop3A`/`common_actor_00797B`.
- The staff roll belongs with `common_actor_00729D` and `lib_016264` (credits).
- `code_012416` and `code_01243D` belong with the menu graphics loaders `lib_01232B`/`lib_012390` (batch gap, 7.4).
- The wait helpers `code_013140`, `code_01314A`, `code_013161`, `code_013169` are system helpers: `WaitFrames`, `WaitForButtonPress`, `RunFrameReadButtons`, `WaitFrameReadButtons` (called from 4 files).

### 7.4 Batch gap

`lib_012281`, `lib_01232B`, `lib_shared_01230B` and `lib_shared_012390` (library `0122-0123`), the file `lib_shared_0131B7` and the files at `0131-0132` still have no batch (FM-A4 7). A6 only read their calls into A6 code.

### 7.5 Facts from the walkthrough that the code confirms

- Name entry: "pick a name for yourself ... no default name" (`01-in-the-beginning.md`): NE01-NE11.
- The HP bar: "fifty units ... colors ... up to white" (`level-up.md`): TR23 and `word_00FB2F`.
- Credits: "Enjoy the credits" (`08-world-of-evil.md`): `ScrollStaffRollText` exists and is called from the ending actor `common_actor_00729D`.
