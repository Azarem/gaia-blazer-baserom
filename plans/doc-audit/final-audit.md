# Final audit of the Blazer documentation and analysis plan (I060)

Step "Final audit" of the plan "Blazer docs and analysis" (`c:\Users\azare\.cursor\plans\blazer_docs_and_analysis_e740ea3f.plan.md`), measured 2026-11-23 from a fresh `npm run extract:lt`. The audit is read-only: no name, note, comment, block, override or doc was changed, and no `merge`, `names` or `blocks` spec was needed. The ROM is unchanged. Records: [`I060_results.md`](../extracted-audit/results/I060_results.md), [`I060_questions.md`](../extracted-audit/questions/I060_questions.md).

## 1. Gate

| Step | Result |
|------|--------|
| `npm run extract:lt` (fresh, at the start) | OK, stale files removed: 0 |
| `npm run rebuild` | OK, SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1,081,344 bytes, checksum 110070696, **unchanged** from I042 to I059. 27 `Cross bank call detected` warnings (the `COP ChoiceYesNoText` / `ChoiceStayGoBackText` calls, known since I020) |
| `npm run names -- --check` | OK (2765 names) |
| `npm run merge -- --check` | 1401 comments, 1684 part notes, 135 block notes against 136 extracted files. Errors 0, warnings 0, orphans 0 (comments 0, part notes 0, block notes 0), duplicate keys 0 |
| `npm run audit` | 1 finding: the R-2 bank-base hazard (section 3.1). No block without a file, no file without a block, no duplicate label, no dangling `?INCLUDE`, no closure gap |

## 2. What the plan changed (baseline I003 against now)

| Measure | Baseline (I003) | Now |
|---------|----------------:|----:|
| Extracted `.asm` files / blocks in `blocks.json` | 704 | 136 |
| Lines | 67,746 | 81,899 (the extract prints block notes, part notes and comments as `;` lines, which is where the growth comes from) |
| Labels (top-level + sub) | 8,256 (6,047 + 2,209) | 8,256 (6,049 + 2,207) |
| Names (`names --check`) | 111 | 2,765 |
| Block notes | 4 | 135 of 136 files |
| Part notes | 26 | 1,684 (1,496 on top-level labels, 188 on sub-labels) |
| Inline comments | 0 | 1,401 (4.2% of 33,399 instructions) |
| Cross-file references | 3,531 in 1,514 file pairs | 2,921 in 374 file pairs |
| Docs | `docs/cop/index.md`, `areas-and-scenes.md`, `wram-memory-map.md`, 2 audio pages | plus the `docs/code/` hub and 15 spokes, 7 `docs/worlds/` pages, the crosswalk, 59 iteration result files |
| Open questions | OQ-I001, OQ-I002 | 560 ids in 57 files, consolidated into 219 rows, 25 experiment groups |
| SHA-1 | `65ff27aa...` | `040a408a...` (regroup waves 0 to 6; every later step annotation-only) |

## 3. Sweeps

### 3.1 Audit findings (`npm run audit`)

- **R-2 residual (OQ-I016-2, Q-TO-01):** 2-byte references from other files into four `movable` blocks: `data_menu_palettes_and_groups` (5), `data_scene_asset_lists` (1), `data_dictionary` (2), `data_spc_driver` (1), that is **9** references. The inventory row Q-TO-01 says "eight"; the audit now says nine (logged as OQ-I060-3). `meta_tables_008000` (now `WorldMetaPointers`) stays pinned (`movable: false`) with the `lib_animation` transform.
- Six movable blocks in all: `lib_animation` and five data blocks (the four above and `data_iris_and_icon_tiles`). `meta_tables_008000` (movable in the baseline; now the block `WorldMetaPointers`) is pinned since I016.

### 3.2 Orphan sweep

| Check | Result |
|-------|--------|
| Notes (`merge --check`) | 0 orphan comments, part notes and block notes; 0 duplicate keys |
| Names against labels | 8,256 labels are defined in `extracted/`; 2,765 names. Every name is a defined label (0 orphan names, 0 duplicate names); every defined label that is not a generated name has a name (0 unnamed). The two sets are equal: 8,256 - 5,491 generated = 2,765 |
| Address suffixes | 992 names end in `_XXXXXX`; in every one the hex equals the key (0 mismatches) |
| Blocks and files | 136 blocks in `blocks.json`, 136 `.asm` files, 0 stale files |
| Doc links | every relative `](path)` link in `docs/` resolves (0 broken); every spoke, world page, the crosswalk, the WRAM map, the COP index and both audio pages are linked from `docs/code/README.md` and `docs/README.md` |
| Doc file names | 138 `.asm` names cited in `docs/` (outside the walkthrough): one does not exist, `chunk_0FAA49.asm` (`docs/audio/spc-disassembly.md`, see 3.6). `_enemies.asm` in the world pages is the glob shorthand `*_enemies.asm` |
| Doc label names | 1,231 label-like backticked tokens; the ones without a label are intentional: COP ids (`Cop0A`), SPC-side labels, asset file names (`music_0C0000`, `graphics_04B000`), hardware registers (`W12SEL`, `M7A`), the `MoveNameCursor*` family prefix, `common_actor_0033C6` and `w0_actor_01AB4F` quoted as history in the crosswalk. No ghost label found |
| Stale regroup names | no label of the old form (`w0_actor_`, `common_actor_`, `lib_0xxxxx`, `engine_xxxxxx`, `meta_tables`, `table_00xxxx`) is left. One convention outlier: five `w2_` labels in two blocks (see 3.3) |

### 3.3 Generic-name sweep: remaining auto-named labels

**Two measures.** `npm run audit` calls a label "auto" when it matches `^[a-z][a-z0-9_]*_[0-9A-F]{6}$` (`src/asm-index.ts`, `AUTO_LABEL`). That also matches the descriptive world names that keep the file offset as suffix (`gv_obj_push_zone_setup_01AFFD`), so the audit overstates the gap: **6,454** auto labels by the audit, **5,491** really generated by the extractor (`code_`, `loc_`, `binary_`, `asciistring_`, `unk<N>_`, `word_` plus six hex digits). The 963 difference are descriptive names with an offset suffix; 992 names carry one (29 of them contain a capital and are not matched by the audit regex). The numbers below use the strict measure; the audit table of section 3.3a is the tool's view.

**Generated labels by group and kind** (strict; sub-labels are `loc_`):

| Group | Labels | Generated | % | `code_` (top-level routines) | `loc_` (sub-labels) | `asciistring_` | `binary_` | `unk<N>_` / `word_` | Audit "auto" % |
|-------|-------:|----------:|--:|-----:|-----:|-----:|-----:|-----:|-----:|
| actor_shared | 80 | 22 | 27.5 | 0 | 0 | 22 | 0 | 0 | 93.8 |
| cop_handlers | 193 | 61 | 31.6 | 0 | 61 | 0 | 0 | 0 | 31.6 |
| grass_valley | 806 | 662 | 82.1 | 408 | 128 | 126 | 0 | 0 | 96.0 |
| greenwood | 859 | 787 | 91.6 | 553 | 124 | 110 | 0 | 0 | 100.0 |
| leos_lab | 557 | 461 | 82.8 | 319 | 77 | 65 | 0 | 0 | 100.0 |
| library | 1,378 | 581 | 42.2 | 0 | 528 | 53 | 0 | 0 | 42.2 |
| magridds_castle | 595 | 296 | 49.7 | 127 | 65 | 104 | 0 | 0 | 95.5 |
| mountain_of_souls | 568 | 460 | 81.0 | 260 | 124 | 76 | 0 | 0 | 100.0 |
| st_elles | 680 | 560 | 82.4 | 352 | 117 | 88 | 0 | 3 | 100.0 |
| system | 2,371 | 1,562 | 65.9 | 0 | 234 | 0 | 951 | 377 | 65.9 |
| world_of_evil | 169 | 39 | 23.1 | 0 | 33 | 6 | 0 | 0 | 100.0 |
| **Total** | **8,256** | **5,491** | **66.5** | **2,019** | **1,491** | **650** | **951** | **380** | 78.2 |

(The `code_` column counts every `code_` label definition: 1,890 are top-level routines (`code_xxxxxx {`) and 129 are sub-labels (`code_xxxxxx:`); the `loc_` column is therefore the `loc_` sub-labels only. The last column before the audit view, `unk<N>_` / `word_`, is `unk3/9/11/12/16_` and two `word_` labels.)

**Where the generated labels sit** (read as three masses):

1. **World actor internals, 1,890 top-level `code_` routines** (the states an actor script reaches through `&code_xxxxxx` operands; the other 129 `code_` labels are sub-labels). The actor roots carry names and part notes (light depth, decided in the plan); the routines inside do not, and only 77 of the 1,890 have a part note (grass_valley 30, st_elles 37, mountain_of_souls 10; greenwood, leos_lab and magridds_castle have none). The 23 blocks with 30 or more such routines hold 1,680 of them; largest first (part-note column = top-level labels of the block, named or not, that have a part note):

   | Block | `code_` routines | Top-level labels with a part note | Comments |
   |-------|-----:|-----:|-----:|
   | `gw_boss_light_water_fire_statues` | 160 | 1 of 161 | 18 |
   | `ll_laboratory_actors` | 126 | 34 of 220 | 38 |
   | `gw_woods_actors_01B98D` | 118 | 15 of 191 | 12 |
   | `gw_woods_actors_01D045` | 99 | 21 of 163 | 25 |
   | `mc_castle_actors` | 95 | 34 of 191 | 21 |
   | `gv_village_actors_018000` | 92 | 12 of 151 | 12 |
   | `ms_multi_area_enemies` | 91 | 20 of 115 | 11 |
   | `ll_laboratory_dungeon_enemies` | 87 | 17 of 104 | 6 |
   | `gw_lostside_marsh_enemies` | 86 | 12 of 98 | 9 |
   | `gv_village_actors_019475` | 86 | 16 of 144 | 15 |
   | `se_st_elles_coast_enemies` | 74 | 29 of 103 | 13 |
   | `se_seabed_sanctuary_actors_0F8000` | 65 | 32 of 120 | 11 |
   | `ms_soul_of_mountain_house_actors_02100B` | 63 | 14 of 110 | 14 |
   | `gv_leos_paintings_enemies` | 57 | 10 of 67 | 0 |
   | `ms_soul_of_mountain_house_actors_020000` | 55 | 22 of 110 | 16 |
   | `se_seabed_sanctuary_actors_0F8D58` | 49 | 26 of 95 | 20 |
   | `ll_town_models_enemies` | 48 | 17 of 65 | 4 |
   | `se_seabed_of_st_elles_enemies` | 45 | 7 of 51 | 4 |
   | `se_seabed_of_st_elles_actors` | 43 | 27 of 72 | 23 |
   | `gv_up_above_actors_and_name_entry` | 42 | 36 of 55 | 3 |
   | `gw_lostside_marsh_actors` | 37 | 20 of 61 | 21 |
   | `ll_boss_tin_doll` | 31 | 21 of 52 | 19 |
   | `gv_underground_castle_enemies` | 31 | 9 of 40 | 0 |

   `gw_boss_light_water_fire_statues` is the largest single gap: the boss of Lostside Marsh has one part note for 161 top-level labels. Note that the part notes sit mostly on the named actor roots, so the ratio of the first nine rows says "roots documented, routines not".
2. **Animation and table data in `system`, 1,328 labels** (`binary_` frame leaves 951, `unk3/9/11/12_` list heads 377). They are the `data_anim_*` blocks (`data_anim_palette_cycles` 673, `data_anim_magic` 178, `data_anim_player` 144, `data_anim_player_unarmed` 90, `data_anim_weapon_overlay` 86, `data_anim_effects` 45) and `data_lair_formations` (112). They cannot be named per entry without the struct decisions of mapping 1.10, 2.8 and 2.10 (rows Q-TO-09, M-2.8, M-2.10).
3. **Branch targets, 1,491 `loc_` sub-labels** and **650 `asciistring_` text lines.** Leave both: a `loc_` label inside a routine is read through the part note of its parent, and a dialogue line is identified by its text.

**Convention outlier:** five labels in two blocks still use the old `w2_` prefix: `w2_effect_player_overlay_0FA6F5`, `_a_0FA777`, `_b_0FA78C` (block `w2_effect_player_overlay`) and `w2_npc_caged_plea_0FA95A`, `w2_obj_fairy_idle_loop_0FA945` (block `w2_obj_fairy_idle_loop`, fan-in 94 from 5 files). The convention is `se_` (world 2 is St. Elles) or `cm_` for shared actors.

**Generic names in the names files:** none. A search of the 2,765 names for placeholder words (`Sub`, `Loc`, `Unk`, `Temp`, `Misc`, `Stuff`, `Data`, `Label`, a bare number) finds only legitimate whole-word hits (`ChestListEmpty`, `SaveSlotLineTemplates`, `TornadoTurn...`). The 391 names that end in a digit are series (`LocationName1..80`, `SceneProfile1..62`, `ExitListLoc1..62`, `ItemName1..41`, `PlacementA05S1..`, `CopExitSkip1..5`).

#### 3.3a The audit's own table (tool view)

| Group | Blocks | Top | Sub | Auto % | Block notes | Part-note % | Comment % |
|-------|-------:|----:|----:|-------:|------------:|------------:|----------:|
| actor_shared | 4 | 50 | 30 | 93.8 | 4/4 | 77.5 | 11.2 |
| cop_handlers | 5 | 109 | 84 | 31.6 | 5/5 | 58.0 | 2.4 |
| grass_valley | 17 | 657 | 149 | 96.0 | 16/17 | 19.7 | 1.6 |
| greenwood | 8 | 698 | 161 | 100.0 | 8/8 | 8.4 | 2.6 |
| leos_lab | 7 | 463 | 94 | 100.0 | 7/7 | 17.2 | 3.6 |
| library | 25 | 637 | 741 | 42.2 | 25/25 | 23.4 | 5.1 |
| magridds_castle | 9 | 512 | 83 | 95.5 | 9/9 | 20.8 | 3.1 |
| mountain_of_souls | 9 | 419 | 149 | 100.0 | 9/9 | 18.3 | 3.1 |
| st_elles | 12 | 534 | 146 | 100.0 | 12/12 | 23.2 | 3.7 |
| system | 35 | 1,836 | 535 | 65.9 | 35/35 | 14.6 | 6.3 |
| world_of_evil | 5 | 134 | 35 | 100.0 | 5/5 | 76.9 | 6.4 |
| **Total** | **136** | **6,049** | **2,207** | **78.2** | **135/136** | **20.4** | **4.2** |

### 3.4 Files without a block note

One of 136: **`gv_watching_over_world_texts`** (`extracted/grass_valley/gv_watching_over_world_texts.asm`, 9 lines, two strings, bank 3; the other `*_watching_over_world_return_prompt_texts` blocks of greenwood and leos_lab have one). It is the only one. The shortest block notes are the unreferenced stubs (`mc_unreferenced_string_stub_02623C`, 272 characters), which is adequate.

### 3.5 Part notes and comments

- **Named but no part note: 766 labels.** By block: `lib_banner_texts` 128, `lib_menus` 122 (data), `lib_scene_profile_data` 97, `data_scene_placements` 97, `data_exit_lists` 94, `mc_castle_dungeon_enemies` 84, `mc_castle_towers_enemies` 75, `data_chest_lists` 34, `gv_prologue_texts` 13, `ms_multi_area_enemies` 7, `ms_enemy_ice_crystal` 7, `gv_epilogue_texts` 6, `se_seabed_sanctuary_actors_0F8000` 1, `lib_map_tile_patches` 1. Of these 591 are the entries of indexed series (`ItemNameN`, `LocationNameN`, `SceneProfileN`, `ExitListLocN`, `PlacementAxxSn`, `ChestListLocN`, the prologue and epilogue text lines) that the block note describes as one table; 159 are small animation, shooter and aimed-shot routines in the two Magridd enemy files (`mc_obj_statue_shooter_*`, `mc_enemy_skeleton_soldier_slash_anim_*`), which are named by their role and need no more than a one-line note; the last 16 are 14 routines in `ms_multi_area_enemies` and `ms_enemy_ice_crystal`, one in `se_seabed_sanctuary_actors_0F8000` and one table in `lib_map_tile_patches`.
- **Part notes without the `When:` line of the Three Questions: 190 of 1,684**, of which 85 are on code labels (directional variants such as `CollideNorth/South/East/West`, `StartWalk*`, `StartSidestep*`, `StartBackstep*`, `StartIdle*`, `Swing*`, `PhoenixProjectile*`; the debug helpers; 6 `cm_` routines; 15 generated `code_0F8xxx` to `code_0FA4xx` routines of the St. Elles files; 12 `se_`/`w2_` routines). The other 105 are data and tables, where the question does not apply.
- **Comments:** 1,401, 4.2% of the instructions. Six blocks with 100 or more instructions have none: `gv_underground_castle_enemies` (216), `gv_leos_paintings_enemies` (280), `gw_enemies_without_placement` (121), `lib_hdma_window_effects` (186), `engine_unreferenced_code` (143, dead code), `engine_spc_ipl_upload` (293). The first two are enemy files with no part-note coverage either.

### 3.6 Docs without sources, and doc defects

| Doc | Source link in the header | Finding |
|-----|---------------------------|---------|
| `docs/code/README.md` and the 15 spokes | yes (`**Source:**`, or a Source section) | none found by the header check; every spoke has See Also (the hub has none). Level-up and stats, a spoke of the plan, is covered inside `player.md` |
| `docs/worlds/*.md` (7) | yes | none |
| `docs/walkthrough/*` (14), `walkthrough-crosswalk.md` | yes (guide credit and the crosswalk method) | none; the crosswalk quotes two pre-regroup names as history |
| `docs/wram-memory-map.md` | yes | none |
| `docs/cop/index.md` | `Sources:` paragraph in the introduction (no header) | acceptable; no See Also section |
| `docs/areas-and-scenes.md` | **no source line** | 88 lines, cites `lib_banner_texts.LocationNameList` and `groups.json` in prose; add a `**Source:**` line and a See Also (OQ-I060-4) |
| `docs/README.md` | not applicable (index) | none |
| `docs/audio/spc-engine.md` | one engine-binary line pointing at `engine_spc_ipl_upload.asm` and the SPC spoke | acceptable |
| **`docs/audio/spc-disassembly.md`** | **no** | **defect, committed since `bf7c6c1`:** lines 1 to 4 are the log output of the disassembler (`Wrote 1768 lines to ./docs/audio/spc-disassembly.md`, `Code range: ...`, `Labels: 192 (92 named + 100 auto)`, a stray `ytes)`), and line 6 cites `chunk_0FAA49.asm`, a file that no longer exists (the block is `data_spc_driver`, label `SpcEngineBlock`). The page is a raw 1,766-line listing with no header or link. The four lines are the `console.log` output of `scripts/disasm-spc700.mjs`, which wrote the page; that script and `scripts/disassemble-spc.mjs` still read `extracted/system/chunk_0FAA49.asm` and cannot run (OQ-I060-2) |

### 3.7 Layout

- Ten blocks have more than 1,500 lines (the plan's target is 200 to 1,500): `lib_text_render` 2,389, `data_anim_palette_cycles` 2,216 (one table, acceptable), `lib_menus` 2,160, `player_core` 1,943, `engine_spawn_lairs_death_drops` 1,906, `ll_laboratory_actors` 1,754, `lib_scene_asset_loader` 1,748, `lib_map_scroll_and_redraw` 1,579, `mc_castle_actors` 1,537, `ms_multi_area_enemies` 1,523. Decision Q-TO-05.
- Eight blocks are under 40 lines (small text, stub and unused blocks such as `gv_watching_over_world_texts`, `mc_unreferenced_string_stub_02623C`, `unreferenced_stubs_bank1f`). They are small by nature; seven have a note (section 3.4).
- All 353 extracted assets other than sound effects (`.map` 115, `.pal` 83, `.bin` 70, `.set` 34, `.spm` 30, `.bgm` 21) carry an offset-only name (`graphics_04B000.bin`, `music_0C0000.bgm`); the 33 `.sfx` files are `sfxNN`. Mapping 1.8 is open (I059 counts 319 keys in `us/files.json`, because one key can feed several folders).

### 3.8 Open questions (PQ)

`plans/doc-audit/mesen2/question-inventory.md` holds 219 deduplicated rows (19 static queue rows, 19 decision rows, 102 static-then-runtime, 79 runtime) in 25 experiment groups; priorities P1 1, P2 43, P3 115, P4 60. **42 rows carry the tag DISC** (walkthrough against ROM), none resolved by invention: boss HP (`Q-BH-*`), Purple Bull, Toy Calvary, Monster Blocks, `Deathtole` against `Deathtoll`, `Recover Sword` against `Recovery Sword`, Super Bracelet, Critical and Psycho Sword, Magic Bell, the Fairy Gem return prompts, Master's Emblem G. This audit found no new game-fact discrepancy.

### 3.9 State of the repository

Work since the last commit `b32b31d` ("More audit documentation") is **uncommitted**. `git status` shows it staged or untracked: the new `docs/code/` hub and spokes, `docs/worlds/`, `docs/walkthrough-crosswalk.md` and the refreshed docs, `notes/**`, `us/blocks.json`, `us/names/bank00|01|0F.json`, `src/blocks-edit.ts`, `src/blocks-verify.ts`, 143 changed `extracted/` entries (23 deleted, 18 renamed, 94 modified, 8 added), and the untracked `plans/` and `.cursor/rules/no-adhoc-scripts.mdc`, `no-python.mdc`. `us/overrides.json`, `us/mnemonics.json` and `us/config.json` have no change against `HEAD`.

## 4. Prioritized follow-up list

| # | Pri | Item | How | Size | Source row |
|---|-----|------|-----|------|-----------|
| 1 | P1 | **Decide the `BuildScrollStrips` override** `"65803": {"M": 1}` in `us/overrides.json`. Without it the extractor reads `LDA #$80; TRB $0396` as `LDA #$1C80; STX $03,Y` and hides two `JSR`s as literals in the rebuilt ROM. The fix changes the SHA-1 | your decision, then one hand edit, `extract:lt`, `rebuild`, Mesen2 title-to-world check; the new SHA-1 becomes the gate value | 1 entry | Q-TO-03 (OQ-I026-1, OQ-I008-1) |
| 2 | P1 | **Commit the work in slices.** Everything since `b32b31d` is staged or untracked (section 3.9), so a lost working tree loses every iteration after it. Suggested slices: tooling (`src/`, `.cursor/rules`), `us/` and `notes/` and `extracted/`, `docs/`, `plans/` | you (the agent never commits) | 4 commits | section 3.9 |
| 3 | P2 | **Repair `docs/audio/spc-disassembly.md`:** delete lines 1 to 4, replace the `chunk_0FAA49.asm` reference by `extracted/system/data_spc_driver.asm` (`SpcEngineBlock`), add a header with the source link, the ARAM range `$0400`-`$0F46` and a pointer to `spc-engine.md` and `code/spc-interface.md`; add the Source line and See Also to `docs/areas-and-scenes.md`; repoint or remove the two stale SPC disassembler scripts in `scripts/` | doc edit by hand (docs are not notes), then re-check links | 2 docs, 2 scripts | OQ-I060-2, OQ-I060-4 |
| 4 | P2 | **Block note for `gv_watching_over_world_texts`** (the two strings, who prints them, the shared `[JMP:]` into `shared_actor_helpers_bank3.asciistring_01B988`) | `npm run merge` spec, `--dry-run` first | 1 note | OQ-I060-4 |
| 5 | P2 | **Run the Mesen2 groups in the order of inventory section 6:** fixtures (Q-TO-11), EG-B (CDL, closes the dead-code rows and mapping 3.7), EG-N, EG-O (before any further regroup), then EG-A, C, D, E, G, H | the inventory; results through `merge` and `names` only | 1 session for EG-B, then 25 groups | Q-TO-11, Q-DC-*, EG-B |
| 6 | P2 | **Name and annotate the actor-internal routines of the 23 largest world files** (section 3.3, table). Start with `gw_boss_light_water_fire_statues` (160 routines, 1 part note), then `ll_laboratory_actors`, the two `gw_woods_actors`, `mc_castle_actors`. Names from the walkthrough and the dialogue, part notes with the Three Questions, no comments except non-obvious logic. Those 23 files hold 1,680 of the 1,890 top-level `code_` routines | `names` spec per file (`address` and `old` from `extract:lt`; sub-labels need their own rows), `merge` spec; gate per file; one iteration per world | 7 to 9 iterations | section 3.3 |
| 7 | P2 | **Resolve the R-2 residuals** (9 two-byte references into four movable blocks): decide whether `blocks-verify` refuses `movable: true` on a block with a cross-bank 2-byte reference, and whether the four blocks should be pinned | ST then RT; `npm run audit` lists them | 9 refs | Q-TO-01, OQ-I060-3 |
| 8 | P3 | **Fix the audit metric:** split `auto` into "generated" (`code_`, `loc_`, `binary_`, `asciistring_`, `unk<N>_`, `word_`) and "descriptive with offset suffix", so the group table shows 66.5%, not 78.2% | extend `src/asm-index.ts` (`AUTO_LABEL`) and `src/audit.ts`, document in `gaia-core/docs/notes-and-comments.md` §"Audit Report", tell the user | 2 files | OQ-I060-1 |
| 9 | P3 | **Struct decisions, then the animation data** (1,328 `binary_` / `unk<N>_` labels): decide the `structs.json` retypes of FM-A11 §4.17 and the pointer coagulation of the 112 formation lists, 265 animation step lists and 951 frame leaves | decision queue first; then `names` and `blocks` | decision, then 1 to 3 iterations | Q-TO-09, M-1.10, M-2.8, M-2.10 |
| 10 | P3 | **Decide the 42 walkthrough-against-ROM spellings and values as one batch** (`Deathtole`, `Recover Sword`, boss HP, EXP) and record the decision in the walkthrough crosswalk and the block notes that quote them | decision queue (DQ list in the inventory), then `merge` | 1 batch | 42 DISC rows, Q-TX-01, Q-TX-05, Q-TX-07, Q-TX-08 |
| 11 | P3 | **Rename the five `w2_` labels and their two blocks** to the `se_` or `cm_` convention (check first who uses `w2_obj_fairy_idle_loop`: 94 references from 5 files, so it is probably the shared fairy and belongs to `cm_`) | `names` rows, then `blocks rename`; SHA must stay | 5 labels, 2 blocks | section 3.3 |
| 12 | P3 | **Descriptive asset file names** (353 files) from the identification runs of EG-M | decision, `us/files.json` keys (not `names/`) | 353 files | M-1.8 |
| 13 | P3 | **Layout decisions:** split the files over 1,500 lines by ROM order (`lib_text_render`, `lib_menus`, `player_core`, `engine_spawn_lairs_death_drops`, `ll_laboratory_actors`), placement of the blocks without a scene, `MapPatchRectsAndMapSizes` into two tables | `npm run blocks` (needs a Mesen2 regression pass, EG-O); each step changes the SHA-1 | 5 files | Q-TO-05, Q-TO-06 |
| 14 | P3 | **Comments for the six uncommented blocks** of section 3.5 and part notes for the 85 code labels without a `When:` line | `merge` with `expect` guards | about 100 notes | section 3.5 |
| 15 | P3 | **Housekeeping:** tick mapping boxes 1.11, 2.17, 3.6; mark the four stale rows of `placement/pinned.md`; refresh the crosswalk and placement-audit labels (Q-TO-10); set the `todos` of the plan file to `completed` (they still read `pending`) | hand edits of plan files | 3 files | Q-TO-13, Q-TO-14, Q-TO-10 |
| 16 | P4 | **Part notes for the 159 Magridd enemy stubs and the 591 series rows** if a consumer needs them; otherwise leave the block note as the description | `merge` | optional | section 3.5 |
| 17 | P4 | **Leave** the 1,491 `loc_` branch targets and the 650 `asciistring_` lines named by address | none | none | section 3.3 |

## 5. Method

- Counts of the group table, blocks, coverage and fan-in come from `npm run audit` (summary, `--blocks`, `--block=<name>` for all 136 blocks, `--json`), run after the fresh extraction.
- The strict generated-label counts, the name-against-label comparison, the suffix check, the generic-name search, the doc-link check, the doc file-name and label-name check and the `When:` marker count are read-only `rg`, `awk` and `sort`/`comm` pipelines over `extracted/`, `us/names/`, `notes/` and `docs/`, and one read-only JSON query of the audit output. Nothing was written except the three plan records.
- The Mesen2 evidence of earlier iterations was not repeated. No experiment was run and no ROM was compared with another.
