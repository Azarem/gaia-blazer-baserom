# I012 results: PA batch A8 (library `014F`-`0175`)

Date 2026-11-21. Scope: read-only analysis. No names, notes, comments, blocks, overrides or docs of the project were changed. One function-map document and this record pair were added.

## Added

| File | Purpose |
|------|---------|
| `plans/doc-audit/function-map/FM-A8.md` | the batch has no routines (10 data blocks, 2935 bytes): 10 data rows, the 65 item name rows, the 97-location live map size table, 9 consumer rows (the routines that give the data its meaning, including the unbatched chooser `code_012281`), seven structure layouts with field evidence, WRAM proposals, placement pins and naming hazards |
| `plans/extracted-audit/questions/I012_questions.md` | `OQ-I012-1` .. `OQ-I012-12` (one tagged DISCREPANCY: OQ-I012-7) |
| `plans/extracted-audit/results/I012_results.md` | this file |

## Method

Fresh `npm run extract:lt`; the ten files of the batch were read end to end. Every field of every structure was fixed by reading its consumers: `code_0108BB` (patch rectangle copy), `code_003188`/`code_003194` and the five boss actors (who passes which patch index), `code_0279B5` (the size table read), `code_012281` and `Cop1A`/`Cop02` (choice windows), `code_001512` (sword minimum level), the equipment description strings of `lib_0118FC_part13`, `TryOpenChest` and the lair strings (the shared message tail), and `common_actor_00729D` (the staff roll caller). The 128 size entries were decoded and compared with the width and height bytes at the head of the tilemap stream of each of the 85 locations that have a type-1 or type-2 tilemap (read with `xxd` from the `.map` files). Counts (callers, `[N]`, dictionary words) were made with `rg` over the extraction. The walkthrough was read for `items.md` (sword levels) and checked against crosswalk 4 for the item names. Nothing was compared between the original ROM and the rebuilt ROM.

## Findings

- **`unk14_017504` is two tables, not 37 `unk14` rows.** Rows 0-4 (40 bytes) are map patch rectangles (dest x, y, width, height as bytes in 16-pixel blocks; source x and y as pixel words), applied by the five boss actors (Metal Mantis `0C`, statues `22`, Poseidon `44`, Tin Doll `59`, Deathtoll `7C`) through a child actor. The remaining 256 bytes are 128 two-byte live map sizes (width and height in 256-pixel pages) indexed by `location_id * 2` in the scene init. The zero entries are exactly the 31 locations without a scene profile. The stream is never smaller than the live size: 31 equal, 9 four-slab, 1 `W+1`, 33 `H+1`, 8 `H+2`, 3 `H+3`, 12 not comparable.
- **`word_0161CE` is the sword minimum level table** (BCD, index = equipped sword id `$1B5E` - 1). It clears the swing button only; thrusts are untouched. All eight values match the walkthrough (`items.md`). It also feeds the eight weapon description strings of the equipment screen. This answers the weapon-level part of OQ-I004-9.
- **The five choice windows share one layout**: `[CUR:o][07:w,h]` + options + a final `[CUR:o+$82]`, with `h = 2 x options`, a bottom border always in BG3 row 15, and the `COP [1A]` count equal to the option count in all 27 uses.
- **The 27 `Cross bank call detected ... COP asciistring_...` warnings of `npm run rebuild` are exactly the 27 `COP [1A]` uses of these five strings.** They are expected (the text renderer forces DBR `$02`) and must not be "fixed" by moving the strings.
- The item name list has 65 entries; the sizes add up to 752 bytes; several names use dictionary words, and `Goat s Food`, `Leo s brush`, `Mole s Ribbon`, `Mermaid s Tears` are a blank plus the dictionary word `s ` (no apostrophe glyph in the ROM text).
- The staff roll has 218 `[N]` (answers the count part of OQ-I010-12). The credits spell `Soul Blader` once and `COPORATION` twice (DISCREPANCY, OQ-I012-7).
- The chest and lair messages share the tail of `asciistring_016246` through the `+M` entry (four jumpers).
- Consumers without a batch: `code_012281` (chooser, 138 bytes), `code_01230B` (cursor blink), `code_001512` (player input filter), `code_0279B5` (scene init). FM-A8 records the data-facing part of each.
- Naming hazards for step PC: the two identical `Leaves` strings and four open spellings (use `ItemName<id>`); `asciistring_016246+M` is not a nameable label; renaming `unk14_017504` as one label keeps its wrong typing, and `npm run blocks` has no split-part operation (OQ-I012-4).
- Pins: D01-D05 and D06-D09 stay in bank `$02` (2-byte `&` references from the renderer's forced DBR); D10 is read with long references and `word_0161CE` with long and `&` references.

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK |
| `npm run rebuild` | OK, SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes (unchanged); 27 pre-existing `Cross bank call` warnings (see Findings) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | OK (0 errors, 0 warnings, 0 orphans; 0 comments, 26 part notes, 4 block notes) |

`extracted/` shows as modified in `git status` because of the line-tracked extraction (`; {n}` annotations); run `npm run extract` again before committing if those annotations should not be committed. `package.json`, `src/` and `.cursor/rules/` changes shown by `git status` were already there and are not part of this step.

## Suggested commit message

```
docs(blazer): A8 function map for choice windows, item names, map patch and size table (I012)

Add FM-A8 (library 014F-0175: 10 data blocks, 65 item names, 97-row live
map size table, 9 consumer rows, 7 struct layouts), the I012 open
questions (12 rows) and results. No names, notes or db files changed;
ROM SHA-1 unchanged.
```

Please commit when you're ready.
