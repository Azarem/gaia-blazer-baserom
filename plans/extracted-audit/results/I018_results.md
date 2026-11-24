# I018 results: PB3 wave 1, single-caller clusters

Date 2026-11-22. Scope: `placement-audit.md` section 7.2 ("wave 1"), applied with `npm run blocks`. The original ROM was never compared with a rebuilt ROM; the baseline for every comparison is the wave 0 build (`b6087e4d`, the I017 gate value).

## Changed in the project

| File | Change |
|------|--------|
| `us/blocks.json` | by `npm run blocks`: 31 `merge`/`rename` rows from spec 01 and one `merge` from spec 02 (tables below). Group, bank and `movable` unchanged (all pinned) |
| `extracted/` | regenerated (plain `npm run extract`): 694 to 652 files, 0 stale left |
| `docs/areas-and-scenes.md`, `docs/cop/index.md`, `docs/wram-memory-map.md` | whole-word block-name rewrites done by the tool (for example `lib_014536_part2` to `lib_location_banner_names`, `lib_0109D6` to `lib_tile_triggers`, `lib_0124EE` to `lib_name_entry`, `lib_010EEA` to `lib_map_sweep_redraw`); no sentence was rewritten by hand |
| `plans/extracted-audit/edits/I018_blocks_01_wave1_single_caller.json` | new, applied (dry-run first), rows W1-01 .. W1-31, each with note and evidence |
| `plans/extracted-audit/edits/I018_blocks_02_souls_contiguity.json` | new, applied (dry-run first), row W1-32 |
| `plans/doc-audit/placement/pinned.md` | wave 1 section: what was left apart and why, and the new "stride walk needs contiguity" constraint |
| `plans/doc-audit/README.md` | gate value |
| `plans/extracted-audit/questions/I018_questions.md` | `OQ-I018-1` .. `-5` (one DISCREPANCY row) |
| `plans/extracted-audit/results/I018_results.md` | this file |

No names, notes, comments, `transforms.json` or `overrides.json` were changed by hand. The absorbed blocks carried no part note that needed to move (`merge --check`: 26 part notes and 4 block notes, 0 orphans). `us/transforms.json`, `package.json` and `src/index.ts` show as modified in `git status` from earlier iterations, not from this step.

## The merges (rebuilt locations from `rebuilt/layout.json`)

| Row | New block | Absorbed | Bank | Location | Size |
|-----|-----------|----------|-----:|---------:|-----:|
| W1-01 | `player_spells_level_up` | `common_actor_001A28_part2` + `_part3` + `_part4` | 00 | 10168 | 1892 |
| W1-02 | `we_boss_deathtoll_demon` | `common_actor_005043` + `_part2` | 00 | 18830 | 839 |
| W1-03 | `common_actor_006E28` (name kept) | itself + `_part2` | 00 | 15930 | 999 |
| W1-04 | `ending_sequence` | `common_actor_00729D` + `_part2` | 00 | 17889 | 941 |
| W1-05 | `cop_set_or_clear_event_flag` | `cop_handler_005867` + `_part2` | 00 | 28228 | 57 |
| W1-06 | `cop_block_own_tiles` | `cop_handler_0059F4` + `_part2` | 00 | 27433 | 119 |
| W1-07 | `cop_jump_if_actor_in_box` | `cop_handler_005C81` + `cop_handler_0058A9` | 00 | 27311 | 122 |
| W1-08 | `cop_conditional_spawn` | `cop_handler_005CD6` + `cop_handler_005EEE` | 00 | 28342 | 57 |
| W1-09 | `gv_tool_shop_woman_and_son` | `w0_actor_0191D2` + `_part2` + `w0_actor_018353` | 03 | 104526 | 699 |
| W1-10 | `w0_actor_01A440` (name kept) | itself + `_part2` | 03 | 102194 | 833 |
| W1-11 | `w0_actor_01A3B0` (name kept) | itself + `_part2` | 03 | 116620 | 314 |
| W1-12 | `gv_fairy_gem_advice_return` | itself + `w0_shared_01B2AB` | 03 | 114426 | 404 |
| W1-13 | `ms_fairy_gems_return_prompt` | `ms_fairy_gem_return_prompt` + `w3_actor_021F22` | 04 | 156381 | 132 |
| W1-14 | `mc_give_mobile_key_dr_leo` | `w5_actor_025E61` + `_part2` | 04 | 131072 | 2893 |
| W1-15 | `w6_actor_01EC4B` (name kept) | itself + `_part2` | 03 | 109048 | 536 |
| W1-16 | `player_attack_animation_handlers` | `engine_routines_001D3B` + `engine_routines_002678` | 00 | 19669 | 771 |
| W1-17 | `engine_death_drops_ending` | `engine_0029EC` + `engine_005354` | 00 | 13489 | 1286 |
| W1-18 | `lib_map_strip_request` | `lib_01010B` + `_part2` + `_part3` | 02 | 88175 | 442 |
| W1-19 | `lib_map_column_strip_fill` | `lib_shared_01032F` + `lib_shared_010419` | 02 | 90968 | 201 |
| W1-20 | `lib_menus` | `lib_0118FC` + `_part3`, `_part4`, `_part7`, `_part11` | 02 | 68687 | 2712 (with W1-32) |
| W1-21 | `lib_menu_item_data` (rename only) | `lib_0118FC_part13` | 02 | 65536 | 3151 |
| W1-22 | `lib_name_entry` | `lib_0124EE` + `_part2` | 02 | 86710 | 548 |
| W1-23 | `lib_text_render` | `lib_shared_012769` + `lib_shared_014789` | 02 | 71399 | 2636 (1,707 lines) |
| W1-24 | `lib_location_banner_names` | `lib_014536` + `_part2` | 02 | 76195 | 1814 |
| W1-25 | `lib_lair_return_mode` | `lib_010EA9_part1` + `_part3` + `_part2` | 02 | 84005 | 944 |
| W1-26 | `lib_tile_triggers` | `lib_0109D6` + `_part4` + `_part5` | 02 | 82698 | 1307 |
| W1-27 | `lib_scene_asset_loader` | `lib_0133A6_part3` + `_part2` | 02 | 74035 | 2160 |
| W1-28 | `lib_scene_profile_data` (rename only) | `lib_0133A6_part4` | 02 | 81278 | 1420 |
| W1-29 | `lib_scene_lair_map_patches` | `lib_0133A6_part1` + `_part5` | 02 | 84949 | 910 |
| W1-30 | `lib_map_sweep_redraw` | `lib_010EEA` + `_part2` | 02 | 78009 | 1696 |
| W1-31 | `lib_scene_change_init` | `lib_027781_part2` + `_part3` | 04 | 136985 | 834 |
| W1-32 | `lib_menus` (again) | `lib_menus` + `lib_01464B` + `lib_014660` + `lib_014675` + `lib_01468A` + `lib_0118FC_part12` | 02 | 68687 | 2712 |

Names follow the walkthrough's terms where the ROM text supports them (Deathtoll the Demon, Mobile Key, Dr. Leo, Fairy Gem) and otherwise say what the code does. Four actors keep their address names (`OQ-I018-2`); `00729D` is named from the code and the ROM text, not from placement-audit 5.3 (`OQ-I018-1`). `lib_text_render` passes the 1,500-line guide on purpose and `lib_menu_item_data` and `lib_scene_profile_data` stay apart (pinned.md).

## Findings

- **The souls page was broken in the wave 0 build, and a merge fixes it (W1-32).** `code_0119B7` walks five 21-byte lines and ends only when Y equals `asciistring_01469F`. The lines and the end label were six separate files, so the packer scattered them and the loop ran until Y wrapped to the end address. In the baseline (slot `w0`) the souls page with all five souls (`$1B82 = $1F`) showed fragments of unrelated dialogue ("Magridd scared called", "talk talk from"); with `lib_menus` holding the six strings in order it lists Magician, Light, Shield, Detection and Reality. With no souls (a new game) the page is "Souls" and empty, as it should be. See `pinned.md` for the constraint.
- The first wave 1 build (`1af812e1`, without W1-32) showed the same wrong loop, with a different iteration count (the freeze around the souls page was 15 frames against 21), which is how the replay of `menu.rec` diverged at frame 109. It was a layout effect, not a regression of a regrouped routine.
- Static checks cannot see this kind of dependence (address equality in a loop): `OQ-I018-3`.
- `menu.rec` is timing sensitive and cannot be used as a wave comparator any more (`OQ-I018-4`).

## Builds

| Build | SHA-1 | Meaning |
|-------|-------|---------|
| baseline (Mesen2 slot `w0`) | `b6087e4dc69caf327190e405ab0948729183b381` | end of I017 |
| wave 1 without W1-32 (slot `w1`) | `1af812e1ed9f726ef287bf06f9f3e18859748e4e` | intermediate, not a gate value |
| wave 1 (slot `w1b`) | `6a8224ed697fb00fc47ba90539524d361698a060` | 32 merges: **the new gate value** (1,081,344 bytes, checksum 110189935). The dry-run SHA-1 (`6a8224ed697f...`) was identical |

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK (fresh before the spec and after each apply; 652 files, 0 stale left) |
| `npm run rebuild` | OK, SHA-1 `6a8224ed697fb00fc47ba90539524d361698a060`, 1,081,344 bytes (a change from `b6087e4d` is expected for a regroup); unchanged after the final plain `npm run extract` |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | OK: 0 errors, 0 warnings, 0 orphans (0 comments, 26 part notes, 4 block notes, 652 extracted files) |
| Text equivalence (`blocks` verify, scratch extract and rebuild) | 6,047 of 6,047 top-level labels identical, 8,256 labels before and after (both specs) |
| Undefined references | 0 |
| Bank guarantees | 13,950 two-byte references checked, 0 broken (both specs) |
| Contiguity of the souls run | `lib_menus` ends at 71399, the start of `lib_text_render`; the six strings are in order in `lib_menus.asm` (lines 1326 to 1341) |
| `npm run audit` | 652 blocks; the one finding is the existing R-2 list (`spc_030000` 1, `data_04F000` 5, `asset_list_028000` 1, `string_lookup_080000` 2), unchanged |

### Mesen2 (slots `w0` = baseline, `w1b` = wave 1; temp files in `%TEMP%\blazer-spike`, not in the repository)

| Path | Method | Result |
|------|--------|--------|
| Title, file select, name entry, opening dialogue, Trial Room (3,677 frames) | `compare_runs` of `trial.rec` from power-on, watches `$0301`, `$0312` (frame counter), `$0322`, `$0314`, `$0374` | 0 divergent frames. The same result for the intermediate build `1af812e1` |
| Menu, status page | `a` from the Trial Room state, screenshot 25 frames later | identical hash `6a3c7d11eec9c32a4e17667dea73f3741cd918b3` in both builds (name, HP 8/8, Next level, weapon, armor, magic, item rows) |
| Menu, souls page | `down` on the status page, `$1B82 = $1F` and `0` | baseline: garbage lines; wave 1: five correct lines (screenshots in the session); no souls: empty "Souls" page |
| Menu, `compare_runs` of `menu.rec` | baseline against wave 1 | diverges from frame 86 by design: the key at frame 85 opens the souls page, which differs (above). Not a valid comparator now (`OQ-I018-4`) |
| Boss fight | scene jump `$0318 = 0x0306`, arrival `$037C = $0080`, `$037E = $00A0`, `$0380 = 0`, state saved at frame 3977 in both builds (same CPU state), `compare_runs` of `boss_fight.rec` (538 frames, watches `$0301`, `$0374`, `$0376`, `$033A`, `$0808`, `$0312`) | 0 divergent frames; the scene shows the boss room with the boss on screen (screenshot after 120 frames of walking up) |
| World scene jump | `$0318 = 0x0501` | both builds reach the same CPU state at every sample, black screen in both (`OQ-I018-5`); not used as evidence |

Limits: the runtime evidence for the merged actors and COP handlers is the 3,677-frame title to Trial Room run and the 538-frame boss fight (same watched values in every frame). Screenshot hashes of two runs of the same ROM are not a valid comparator after a scene change (random power-on RAM), so counts and watches were used there. The Magridd's Castle (`mc_give_mobile_key_dr_leo`), Grass Valley, Mountain of Souls and the `common` actors that were merged were verified statically (text, references, banks) and through the shared engine paths; none of them was reached in a run.

## Suggested commit message

```
PB3 wave 1: merge 32 single-caller clusters; join the souls strings (I018)

Regroup with npm run blocks (blocks.json): player_spells_level_up,
we_boss_deathtoll_demon, ending_sequence, the COP handler pairs, the Grass
Valley, Mountain of Souls, Magridd's Castle and Dr. Leo actors, the player
animation and death-drop engine blocks, and the library (lib_menus,
lib_text_render, lib_name_entry, lib_tile_triggers, lib_scene_asset_loader,
lib_scene_change_init, map and banner blocks). lib_menu_item_data and
lib_scene_profile_data stay separate data files. All pinned.

lib_menus now holds the six soul strings in order: code_0119B7 walks them by
stride and stops on address equality, so the packer scattering them made the
souls page print unrelated dialogue. Text identical for 6,047 labels, 0
undefined references, title-to-Trial-Room and boss compare_runs identical.
Rebuilt SHA-1 b6087e4d -> 6a8224ed (expected for a regroup).
Adds I018 specs, questions, results and the pinned.md wave 1 section.
```

Please commit when you're ready.
