# I022 checklist: PB3 wave 5, library strings, data and tiny helpers

Trigger (user, 2026-11-22): the library holds dozens of one-string files (`lib_013B27` .. `lib_016264`) and other one-routine files. Strings and data belong with the code that uses them; every such file costs an `?INCLUDE`, a block, a file and a cross-file reference. `placement-audit.md` 6.3 named the target (`lib_text_strings`, `lib_map_helpers`, ...) but wave 1 only merged single-caller blocks, and wave 4 did not touch the library (`OQ-I021-5`). Refinement (user, same day): the front-end strings are prologue (intro narration) and epilogue (ending narration); do not merge them into one file.

Baseline: wave 4 build `e061c9e4179880ee2b537e28d4113cf958c9fda6` (1,081,344 bytes, 220 files). Method per spec: `npm run blocks -- <spec> --dry-run`, then apply, then `extract:lt`. Records: `plans/extracted-audit/edits/I022_blocks_0N_*.json`, `results/I022_results.md`, `questions/I022_questions.md`, section "Wave 5 (I022)" appended to `pinned.md`.

## Facts that bound the merges (read, not assumed)

- A string read by the text renderer must be in bank 2: `code_012769` sets `DBR = $02` (`lib_text_render.asm` line 14-20), `COP [1A]` / `COP [01]` take `&ASCIIString$2`. So a string whose caller lives in bank 0, 3, 4 or 31 cannot join its caller (a non-movable block lies in one bank and the banks are full). The best result for those is **one bank-2 text file per consumer, next to the consumer's folder** (same group and scene), instead of one file per string.
- A long reference (`$@`) to data does not depend on the bank, but the data block keeps the bank of its start (`data_00F9F7` in bank 1 stays in bank 1). Tables of bank 1 cannot join library code (this is why `lib_027348` keeps `$@data_00F9F7.binary_00FA77`).
- The only stride loop over a string run is the souls page in `lib_menus` (`CPY #$&asciistring_01469F`, `lib_menus.asm` line 173). Nothing in this wave splits or reorders it.
- Merged parts stay in ROM order inside the block (the tool sorts by `order`, else by start).

## Merges (all pinned, one bank per block, text per label unchanged)

Spec 01, strings and data:

| Row | New block | Absorbs | Why |
|-----|-----------|---------|-----|
| W5-01 | `gv_title_texts` (group `grass_valley`, scene `front_end`) | `lib_013B27` PUSH START, `lib_013B36` copyright, `lib_014176` boot actor status line, `lib_0143B0` file select window, `lib_01440D` file select table | title and file select: callers `code_0066FC`, `code_0066C6` (`gv_front_end`) and `code_006D4E` (`engine_title_file_select`) |
| W5-02 | `gv_prologue_texts` (same group and scene) | 14 strings `lib_013B85` .. `lib_0140FA` | intro narration ("Wise men tell a tale ..." to "A SOUL BLAZER!!"), printed by the title actor `code_0066FC` |
| W5-03 | `gv_epilogue_texts` (same group and scene) | 7 strings `lib_014192` .. `lib_014339`, `lib_0143A4` THE END, `lib_016264` staff roll | ending narration (actor `code_00729D`), staff roll (`code_007638` via `lib_0126CF`), THE END (Lisa and Turbo actor) |
| W5-04 | `lib_banner_texts` | `lib_014516` LEVEL UP, `lib_014527`, `lib_location_banner_names`, `lib_014547`, `lib_01456A` | level-up banner (player, bank 0) and pause/location banner (`lib_027572`, bank 4) |
| W5-05 | `lib_menus` | `lib_shared_014F74`, `lib_menu_item_data`, `lib_0161CE` | item names (72 refs from menu data and menus), item descriptions (10 refs from menus), gear table |
| W5-06 | `shared_choice_prompt_texts` (group `actor_shared`) | `lib_014F02`, `lib_014F15`, `lib_014F23`, `lib_014F43`, `lib_014F5B` | Yes/No and Record/Quit prompts used by `COP [1A]` in every world |
| W5-07 | `lib_tile_triggers_and_lair_return` | `lib_tile_triggers`, `lib_lair_return_mode`, `lib_shared_016246` | one feature (lair switch, chest, return mode) and the GEM message both call |
| W5-08 | `lib_0108BB` | `lib_017504` | live map size table read 6 times by the patch routine |

Spec 02, map code (bank 2):

| Row | New block | Absorbs |
|-----|-----------|---------|
| W5-09 | `lib_map_streaming` | `lib_010069`, `lib_shared_0104AF`, `lib_01020E`, `lib_01020E_part2`, `lib_map_strip_request`, `lib_map_column_strip_fill` |
| W5-10 | `lib_scene_map_patches` | `lib_0112F5`, `lib_011395`, `lib_0114D0`, `lib_0114E4`, `lib_scene_lair_map_patches`, `lib_shared_01112A` |

Spec 03, system helpers (bank 2, contiguous run `0x1318C`-`0x13272` and the HDMA queue):

| Row | New block | Absorbs |
|-----|-----------|---------|
| W5-11 | `lib_system_helpers` | `lib_01185E`, `lib_01186E`, `lib_01318C`, `lib_0118FC_part8`, `lib_shared_0131B7` |
| W5-12 | `lib_arithmetic` | `lib_shared_0131D1`, `lib_0118FC_part9`, `lib_0131FE`, `lib_01320E`, `lib_0118FC_part10`, `lib_013246` |

Spec 04, bank 4 helpers (`lib_027xxx`):

| Row | New block | Absorbs |
|-----|-----------|---------|
| W5-13 | `lib_save_system` | `lib_0270E4`, `lib_027132`, `lib_shared_02716E` |
| W5-14 | `lib_map_index_helpers` | `lib_027462`, `lib_027462_part1`, `lib_027462_part2`, `lib_0272E6` |
| W5-15 | `lib_bit_array` | `lib_027348`, `lib_027374`, `lib_0273A2` |
| W5-16 | `lib_player_facing` | `lib_0273D4`, `lib_0273EB` |
| W5-17 | `lib_player_stats` | `lib_0275ED`, `lib_027614`, `lib_0276A5`, `lib_0276C9` |

## Left apart on purpose (to be recorded in `pinned.md`)

- `lib_menus` helpers `lib_0118FC_part2`, `_part5`, `_part6`, `lib_012281`, `lib_shared_01230B`, `lib_01232B`, `lib_shared_012390`, `lib_shared_012416`: several callers in other files; with the item data `lib_menus` is already about 1,860 lines. Own wave if wanted.
- `lib_scene_profile_data` (1,420 B data, 17 refs from `lib_scene_asset_loader`): merging passes 1,790 lines.
- Bank-1 tables (`data_00F9F7`, `data_00BA0D`, ...): bank-fixed.
- `lib_027277`, `lib_027223`, `lib_02719F`, `lib_shared_027260`, `lib_027912`, `lib_027572`, `lib_010000`, `lib_013ADA`, `lib_animation`, `lib_0116C3`, `lib_0126CF`, `lib_name_entry`, `lib_map_sweep_redraw`, `lib_0109D6_part1`, `lib_0109D6_part3`: single routines of their own subsystem; no cohesive partner.

## Steps (progress is recorded at the end of this file)

- [x] 1. Fresh `npm run extract:lt` (done at start), baseline ROM saved to `%TEMP%\blazer-w5`
- [x] 2. Write spec 01 .. 04 (Write tool, once each)
- [x] 3. Dry-run each spec, apply, `npm run extract:lt` after each
- [x] 4. Check: no `*_texts` file over 400 lines, no stale file, 0 undefined references
- [x] 5. Gate: `extract:lt`, `rebuild`, `names --check`, `merge --check`, `audit`; record SHA-1 (changes: regroup)
- [x] 6. Mesen2 comparison against the baseline ROM: title, file select, name entry, intro narration, status page and item description page, pause banner, a chest or prompt, boss fight (done for the scenes that the recordings reach; see the results file for what was not reachable)
- [x] 7. `pinned.md` wave 5 section, `README.md` gate value, `I022_questions.md`, `I022_results.md` with a suggested commit message

## Progress

- Spec 01 (8 merges): dry-run clean (6,047 of 6,047 labels identical, 0 broken bank guarantees); applied. The front end is split into `gv_title_texts` (5 strings: PUSH START, copyright, the file-select layout and screen), `gv_prologue_texts` (14 narration strings) and `gv_epilogue_texts` (9 ending strings), as the user asked.
- Spec 02 (map code, 2 merges): dry-run clean; applied.
- Spec 03 (system helpers, 2 merges): the first dry-run **failed**: the text of `code_0131A2` and `code_0131AE` changed (`LDA #$A1` became `LDA #$8DA1`), because in the merged file the accumulator width of these two entry points was inferred from the `PLP` that ends the preceding routine. Fixed with two `M = 1` entries in `us/overrides.json` (keys 78242 and 78254); dry-run clean afterwards; applied. See `OQ-I022-1`.
- Spec 04 (bank 4 helpers, 5 merges): dry-run clean; applied.
- Gate: `extract:lt`, `rebuild` (OK, SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, checksum 110068443), `names --check` OK (111 names), `merge --check` 0 errors, 0 orphans, plain `extract` 0 stale. 220 to 151 files; the library group is now 42 files (it had 115 blocks at the start of this wave).
- Mesen2: the full 3,677-frame trial replay on baseline (`e061c9e4`) and wave 5 (`3148390e`): 0 divergent frames; screenshot hashes equal in all scenes; boss fight 0 divergent frames in 538.
