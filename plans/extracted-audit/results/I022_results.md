# I022 results: PB3 wave 5, strings and data with their users, helpers by subsystem

Date 2026-11-22. Scope: the single-string, single-table and single-routine files of the `library` group (115 blocks at the start), left over after wave 4. Rule from the user: strings and data belong with the code that uses them; minimize cross-file calls. Applied with `npm run blocks` (four specs, each dry-run first). The original ROM was never compared with the rebuilt ROM; the Mesen2 comparison is between two rebuilt builds (wave 4 and wave 5).

## Changed in the project

| File | Change |
|------|--------|
| `us/blocks.json` | by `npm run blocks`: 17 merges in four specs. The three front-end text blocks are in group `grass_valley`, scene `front_end`; `shared_choice_prompt_texts` is in `actor_shared`; the rest stay in `library`. No block became `movable` |
| `us/overrides.json` | **by hand**: `"78242": {"M": 1}` and `"78254": {"M": 1}` (`code_0131A2`, `code_0131AE` in `lib_system_helpers`); see `OQ-I022-1` |
| `extracted/` | regenerated (`npm run extract:lt`, then plain `npm run extract`): 220 to 151 files (spec 01: 220 to 181, spec 02: to 171, spec 03: to 162, spec 04: to 151), 0 stale at the end, no empty directory. The library group is 42 files |
| `docs/areas-and-scenes.md`, `docs/cop/index.md`, `docs/wram-memory-map.md`, `notes/partNotes/bank00.json` | whole-word block-name rewrites done by the tool (the file diff in `git status` also contains earlier iterations). **No doc or note was edited by hand in this step** |
| `plans/extracted-audit/edits/I022_blocks_01_strings_and_data.json` .. `I022_blocks_04_bank4_helpers.json` | new, applied; every row has a `note` |
| `plans/doc-audit/placement/I022_checklist.md` | the plan, with a progress section |
| `plans/doc-audit/placement/pinned.md` | wave 5 section appended (earlier sections untouched) |
| `plans/doc-audit/README.md` | gate value |
| `plans/extracted-audit/questions/I022_questions.md` | `OQ-I022-1` .. `-4` and method notes (no DISCREPANCY) |
| `plans/extracted-audit/results/I022_results.md` | this file |

No names, comments or `transforms.json` were changed. `merge --check` reports 26 part notes and 2 block notes, 0 orphans.

## What moved (rebuilt location and size from `rebuilt/layout.json`)

| Row | Block | Location | Size | Absorbs |
|-----|-------|----------|------|---------|
| W5-01 | `gv_title_texts` | 93776 | 295 | `lib_013B27`, `lib_013B36`, `lib_014176`, `lib_0143B0`, `lib_01440D` |
| W5-02 | `gv_prologue_texts` | 88565 | 1,466 | 14 narration strings `lib_013B85` .. `lib_0140FA` |
| W5-03 | `gv_epilogue_texts` | 79343 | 2,098 | `lib_014192`, `lib_0141F1`, `lib_014228`, `lib_01426F`, `lib_0142BB`, `lib_0142E1`, `lib_014339`, `lib_0143A4`, `lib_016264` |
| W5-04 | `lib_banner_texts` | 83459 | 1,888 | `lib_014516`, `lib_014527`, `lib_location_banner_names`, `lib_014547`, `lib_01456A` |
| W5-05 | `lib_menus` | 65536 | 6,730 | `lib_shared_014F74`, `lib_menu_item_data`, `lib_0161CE` |
| W5-06 | `shared_choice_prompt_texts` | 95019 | 114 | `lib_014F02`, `lib_014F15`, `lib_014F23`, `lib_014F43`, `lib_014F5B` |
| W5-07 | `lib_tile_triggers_and_lair_return` | 74902 | 2,281 | `lib_tile_triggers`, `lib_lair_return_mode`, `lib_shared_016246` |
| W5-08 | `lib_0108BB` | 91451 | 579 | `lib_017504` |
| W5-09 | `lib_map_streaming` | 87043 | 1,522 | `lib_010069`, `lib_shared_0104AF`, `lib_01020E`, `lib_01020E_part2`, `lib_map_strip_request`, `lib_map_column_strip_fill` |
| W5-10 | `lib_scene_map_patches` | 81441 | 2,018 | `lib_0112F5`, `lib_011395`, `lib_0114D0`, `lib_0114E4`, `lib_scene_lair_map_patches`, `lib_shared_01112A` |
| W5-11 | `lib_system_helpers` | 94071 | 219 | `lib_01185E`, `lib_01186E`, `lib_01318C`, `lib_0118FC_part8`, `lib_shared_0131B7` |
| W5-12 | `lib_arithmetic` | 94290 | 161 | `lib_shared_0131D1`, `lib_0118FC_part9`, `lib_0131FE`, `lib_01320E`, `lib_0118FC_part10`, `lib_013246` |
| W5-13 | `lib_save_system` | 160391 | 187 | `lib_0270E4`, `lib_027132`, `lib_shared_02716E` |
| W5-14 | `lib_map_index_helpers` | 158475 | 416 | `lib_027462`, `lib_027462_part1`, `lib_027462_part2`, `lib_0272E6` |
| W5-15 | `lib_bit_array` | 160901 | 140 | `lib_027348`, `lib_027374`, `lib_0273A2` |
| W5-16 | `lib_player_facing` | 161641 | 37 | `lib_0273D4`, `lib_0273EB` |
| W5-17 | `lib_player_stats` | 159439 | 257 | `lib_0275ED`, `lib_027614`, `lib_0276A5`, `lib_0276C9` |

The front-end strings are three files, split by the actor that reads them (title and file select; opening narration; ending chain and staff roll), because the original file mixed prologue and epilogue strings (`gv_front_end.asm`, the `LDY #$&lib_0142BB.asciistring_0142BB` line).

## Findings

- **Text strings cannot follow their callers.** The renderer `code_012769` forces DBR `$02`; the callers are in banks 0, 3, 4 and 31 and the banks have 1 to 84 bytes free. The merge unit for text is one bank-2 file per consumer. `rebuilt/layout.json` places all text files of this wave in bank 2 and the bank-4 helpers in bank 4; no block crosses a bank.
- **Bank-1 data (`data_00F9F7`, `data_00BA0D`, ...) stays cross-file** (bank-fixed).
- **The `lib_menus` souls run is intact:** the strings between `asciistring_014624` and `asciistring_01469F` are unchanged and in ROM order; the merge only appended the item names and descriptions that follow it.
- **A merge can change the inferred accumulator width of a part** (`OQ-I022-1`): fixed with two `M = 1` overrides; the label-by-label text check (6,047 of 6,047) is what caught it.
- **The 27 `Cross bank call detected ... COP asciistring_...` notices of `npm run rebuild` are unchanged** (counted: 27). They are the `COP [1A]` operands of the five choice prompts; they stay as they are because of the forced DBR.
- **Cross-file references fell from 3,061 to 2,936** (of 16,248 in total); `?INCLUDE` lines from 489 to 396.
- The audit still has its one finding, the movable-target hazard R-2 (`data_04F000` 5, `asset_list_028000` 1, `string_lookup_080000` 2, `spc_030000` 1), unchanged.

## Builds and SHA-1

| Build | SHA-1 (first 8) | Files after |
|-------|-----------------|-------------|
| baseline (Mesen2 slot `w4`, end of I021) | `e061c9e4` | 220 |
| after spec 01 (strings and data) | `aba92f55` | 181 |
| after spec 02 (map code) | `99ab9310` | 171 |
| after spec 03 (system helpers) | `e272e4f6` | 162 |
| after spec 04 (bank 4 helpers) | `3148390ed40ce14060b33c1387303a8a77e7a0c1` | 151 |

The last row is the new gate value (1,081,344 bytes, checksum 110068443). Merges change the SHA-1 because the packer places blocks per bank, largest first.

## Gate

| Check | Result |
|-------|--------|
| `npm run blocks` (each spec) | 6,047 of 6,047 top-level labels with identical text before and after, 0 undefined references, 0 broken 2-byte bank guarantees (13,950 checked), `?INCLUDE` closure, scratch rebuild OK; spec 03 failed once (`OQ-I022-1`) and passed after the override |
| `npm run extract:lt` | OK |
| `npm run rebuild` | OK, SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, checksum 110068443; 27 "Cross bank call detected" notices (unchanged) |
| `npm run names -- --check` | OK, 111 names |
| `npm run merge -- --check` | 0 comments, 26 part notes, 2 block notes against 151 files; errors 0, warnings 0, orphans 0 |
| `npm run audit` | one finding (R-2), unchanged |
| plain `npm run extract` | OK, 0 stale |

## Mesen2 comparison (baseline `e061c9e4` in slot `w4` against wave 5 `3148390e` in slot `w5`, both from power-on; scratch ROMs, states and screenshots in `%TEMP%\blazer-spike`, not in the repository)

All screenshots were taken with `layers` (`["bg1","bg2","bg3","obj"]`) after `step_scanline` 235 (see the method note of `I022_questions.md`).

| Scenario | Method | Result |
|----------|--------|--------|
| Full replay, title to Trial Room (3,677 frames) | `compare_runs` of `trial.rec` on power-cycled slots; watches `$0301`, `$0318`, `$0374`, `$0808` | 0 divergent frames in 3,677 |
| Title with the copyright lines (`gv_title_texts`) | stop at frame 1,100 | identical hash `594adb319a178bb32791b832339f27ea0f4aa6b4` |
| "PUSH START" (`gv_title_texts`) | stop at frame 1,300 | identical hash `cf05051cd5bdeac4c59d5ea20a7dbc5ed3e89761` |
| File select "Please choose a record" (`gv_title_texts`) | stop at frame 1,530 | identical hash `39925206c3292b8a4df9a0865de019a56669f21e` |
| Name entry "Please enter your name." | stop at frame 2,200 | identical hash `bb8473e66922c42b6a871fa13ec8e1c37665bd34` |
| Trial Room (map streaming, scene map patches, HUD) | stop at frame 3,000 | identical hash `ca81704d7736fed9de996e88f4cc466fe144acee` |
| Location banner "Grass Valley Shrine" (`lib_banner_texts`) | `menu.rec` on both slots without a start state, then `layers` | identical hash `4a96769eb6165540c7265dd8ca8131bf6fbcb460` |
| Status page (`lib_menus`) | end of `trial.rec`; `a` for 3 frames; 32 more frames | identical hash `6a3c7d11eec9c32a4e17667dea73f3741cd918b3` (the value of I018 to I021) |
| Boss fight (Metal Mantis) | from the Trial Room: `$0318 = 0x0306`, `$037C = $0080`, `$037E = $00A0`, `$0380 = 0`; 296 frames; a state per build; `compare_runs` of `boss_fight.rec` (538 frames; watches `$0301`, `$0374`, `$0376`, `$033A`, `$0808`, `$0312`) | 0 divergent frames in 538 |
| After the fight, "A voice came from above." | frame 4,512 | identical hash `88a35010d907ee38cc1b23ea228c75f86d83bd8d` (the value of I021) |

Limits: the runs reach the title, the file select, the name entry, the Trial Room, one location banner, the status page, one boss fight and one dialogue box. They do **not** reach the opening narration (`gv_prologue_texts`), the ending (`gv_epilogue_texts`), the five choice prompts (`shared_choice_prompt_texts`), the level-up banner, the item description page, the save system, or the other `lib_*` helpers by name (some are exercised by the fight and the menu: bank-4 stats, the player facing, the map index helpers, the HDMA queue and the NMI pair run every frame). For the unreached ones the evidence is static (text per label, references, bank guarantees, layout) and `OQ-I022-2` asks for a short run.

## Left apart on purpose (details in `pinned.md`, wave 5)

- The `lib_menus` helpers with callers in other files (`lib_0118FC_part2`, `_part5`, `_part6`, `lib_012281`, `lib_shared_01230B`, `lib_01232B`, `lib_shared_012390`, `lib_shared_012416`).
- `lib_scene_profile_data`; the bank-1 tables.
- Single routines with their own subsystem (`lib_027277`, `lib_027223`, `lib_02719F`, `lib_shared_027260`, `lib_027912`, `lib_027572`, `lib_010000`, `lib_013ADA`, `lib_animation`, `lib_0116C3`, `lib_0126CF`, `lib_name_entry`, `lib_map_sweep_redraw`, `lib_0109D6_part1`, `lib_0109D6_part3`, `lib_011695`, `lib_027781_part1`).

## Suggested commit message

```
Regroup wave 5 (placement-audit): strings and data with their users

- 17 merges in four specs: front-end strings split into title,
  prologue and epilogue text files; banner texts, item data and
  choice prompts merged with their users; map streaming and scene map
  patches; system helpers and arithmetic; bank 4 save, map index,
  bit array, player facing and player stats helpers
- strings stay in bank 2 (DBR forced by the text renderer); bank-1
  tables stay cross-file
- overrides.json: M=1 at code_0131A2 and code_0131AE (merge changed the
  inferred accumulator width)
- 220 to 151 extracted files; cross-file references 3,061 to 2,936
- pinned.md wave 5, OQ-I022-1..4, I022 results; new gate SHA-1
  3148390ed40ce14060b33c1387303a8a77e7a0c1
```

Please commit when you're ready.
