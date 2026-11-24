# I021 results: PB3 wave 4, regroup of the world groups and `actor_shared`

Date 2026-11-22. Scope: `placement-audit.md` wave 4 (the clusters left for wave 4 in `pinned.md`: the nine `actor_shared` helpers, the actor, enemy and text blocks of each world area, the two string stubs). Applied with `npm run blocks` (eight specs, each dry-run first). The original ROM was never compared with a rebuilt ROM; the baseline for every comparison is the wave 3 build (`3939c4be`, the I020 gate value). Rebuilt locations below are from `rebuilt/layout.json`.

## Changed in the project

| File | Change |
|------|--------|
| `us/blocks.json` | by `npm run blocks`: 47 merges and 5 renames in eight specs (52 rows). No block became `movable`; every merged block is pinned to the bank of its start |
| `extracted/` | regenerated (`npm run extract:lt`, then plain `npm run extract` at the end): 547 to 220 files, 379 stale files removed by the specs, 0 stale at the end. No empty folder |
| `docs/cop/index.md` (line 231), `docs/wram-memory-map.md` | whole-word block-name rewrites done by the tool (the file diff in `git status` also contains earlier iterations). **No doc was edited by hand in this step** |
| `plans/extracted-audit/edits/I021_blocks_01_wave4_actor_shared.json` .. `I021_blocks_08_wave4_world_of_evil.json` | new, applied; every row has a `note` with the evidence |
| `plans/doc-audit/placement/pinned.md` | wave 4 section appended (earlier sections untouched) |
| `plans/doc-audit/README.md` | gate value |
| `plans/extracted-audit/questions/I021_questions.md` | `OQ-I021-1` .. `-6` (one DISCREPANCY, `OQ-I021-1`); closes the "did not render" part of `OQ-I020-6` and reframes `OQ-I020-7` |
| `plans/extracted-audit/results/I021_results.md` | this file |

No names (outside the 5 block renames of the tool), notes, comments, `transforms.json` or `overrides.json` were changed by hand. No part note had to move: `merge --check` reports 26 part notes and 2 block notes (`cop_core`, `cop_dispatch`), 0 orphans. `git status` also shows files modified by earlier iterations; they are not from this step.

## What moved (merged blocks, rebuilt location and size from `rebuilt/layout.json`)

| Spec | Row | Merged block | Location | Size | Absorbs (from the spec) |
|------|-----|--------------|----------|------|-------------------------|
| 01 | W4-S01 | `shared_actor_helpers_bank0` | 20239 | 1,117 | `shared_animation_tick_loop`, `shared_enemy_helper_002D67`, `shared_shrine_save_menu`, `shared_dialogue_tail_007A52` |
| 01 | W4-S02 | `shared_actor_helpers_bank3` | 126396 | 146 | `shared_animation_loop_helper_01B161`, `shared_help_me_message_0191D2`, `shared_dialogue_tail_01B988` |
| 01 | W4-S03 | `shared_actor_helpers_bank4` | 159032 | 263 | `shared_animation_loop_hurt_message_022289`, `shared_ms_fairy_gem_texts_dialogue_tail` |
| 02 | W4-GV01 .. | `gv_front_end` | 11891 | 2,150 | boot, title and ending blocks |
| 02 | | `gv_up_above_actors_and_name_entry` | 18886 | 1,353 | name entry and Up Above actors, bank 0 |
| 02 | | `gv_up_above_trial_room_and_lisa_turbo_actors` | 118638 | 2,182 | Trial Room and Lisa and Turbo actors, bank 3 |
| 02 | | `gv_village_actors_018000` / `_019475` | 109317 / 114399 | 5,082 / 4,239 | the village actors (1,919 lines), split by ROM order |
| 02 | | `gv_leos_paintings_actors` / `_enemies` | 125429 / 1043651 | 405 / 971 | |
| 02 | | `gv_underground_castle_actors` / `_enemies` | 120820 / 1044622 | 1,796 / 667 | |
| 02 | | `gv_multi_area_actors` | 125834 | 391 | |
| 03 | W4-GW01 .. | `gw_lostside_marsh_actors` / `_enemies` | 122616 / 1029135 | 1,544 / 2,165 | |
| 03 | | `gw_woods_actors_01B98D` / `_01D045` | 98304 / 103981 | 5,677 / 5,336 | the woods actors (2,595 lines), split by ROM order |
| 03 | | `gw_enemies_without_placement` | 1045783 | 437 | |
| 04 | W4-SE01 .. | `se_ghost_ship_enemies` / `se_ghost_ship_actors` | 30500 / 1045289 | 407 / 494 | enemies include the child scripts (bank 0) |
| 04 | | `se_seabed_of_st_elles_actors` / `_enemies` | 1031300 / 1042664 | 2,095 / 987 | |
| 04 | | `se_seabed_sanctuary_actors_0F8000` / `_0F8D58` | 1023237 / 1015808 | 3,337 / 3,854 | split by ROM order |
| 04 | | `se_st_elles_coast_actors` / `_enemies` | 1046220 / 1033395 | 422 / 2,058 | |
| 05 | W4-MS01 .. | `ms_multi_area_actors` / `_enemies` | 159295 / 1026574 | 256 / 2,561 | |
| 05 | | `ms_dungeon_actors`, `ms_snow_mountain_actors` | 156950, 157776 | 826, 699 | |
| 05 | | `ms_soul_of_mountain_house_actors_020000` / `_02100B` | 148905 / 152889 | 3,984 / 3,227 | split by ROM order |
| 06 | W4-LL01 .. | `ll_laboratory_dungeon_actors` / `_enemies` | 160153 / 1035453 | 160 / 1,743 | |
| 06 | | `ll_laboratory_actors` | 137886 | 6,132 | 30 blocks, 1,545 lines (kept as one file) |
| 06 | | `ll_town_models_actors` / `_enemies` | 159798 / 1040219 | 192 / 1,284 | |
| 07 | W4-MC01 .. | `mc_return_prompt_and_chest_hint_texts` | 158475 | 285 | `w5_shared_026DF2` + `w5_shared_02706C` |
| 07 | | `mc_airship_dock_actors` | 144018 | 4,887 | |
| 07 | | `mc_castle_dungeon_actors` / `_enemies` | 159551 / 1038739 | 247 / 1,480 | |
| 07 | | `mc_castle_actors` | 131072 | 6,814 | |
| 07 | | `mc_castle_towers_actors` / `_enemies` | 161641 / 1037196 | 31 / 1,543 | |
| 08 | W4-WE01 .. | `we_deathtolls_shrine_actors` | 15933 | 1,524 | Deathtoll mage, shrine actor `004F4D`, demon (bank 0) |
| 08 | | `we_evil_world_actors` / `_enemies` | 124160 / 1041503 | 733 / 1,161 | |

Renames (byte-neutral): `w0_shared_01ABB9` to `gv_watching_over_world_texts`; `w0_shared_01A4F9` to `gv_unreferenced_string_stub_01A4F9`; `w1_shared_01EBC2` to `gw_watching_over_world_return_prompt_texts`; `w4_shared_023F33` to `ll_watching_over_world_return_prompt_texts`; `w5_shared_02623C` to `mc_unreferenced_string_stub_02623C`.

The list of absorbed blocks per row is in each spec (`from` of each `merge` op); this table does not repeat them where the row has many. Left apart and why: `pinned.md`, wave 4.

## Findings

- **No cluster failed a hard constraint.** The reasons for the choices (bank per start address, return-address idiom, souls stride run, COP tables, `rewrites.json` keys, R-2) are in `pinned.md` wave 4. The clusters that were not merged are singletons, not constraint failures.
- **The `lib_menus` souls run is intact:** `lib_menus` at 68687 with 2,712 bytes ends at 71399, where `lib_text_render` starts.
- **DISCREPANCY (`OQ-I021-1`):** `shared_ms_fairy_gem_texts_dialogue_tail` is one part of five strings, not two parts as I020 stated.
- **A plain screenshot can be black while the machine is running; `layers` gives the settled image.** All screenshots of this run used `layers` (`["bg1","bg2","bg3","obj"]`) and gave images in both builds. This is the answer to the "did not render" part of `OQ-I020-6`. The earlier black frames were not a build difference.
- **The CPU phase differs at equal frames by a constant offset.** At frames 3,977 and 4,081 the two builds have equal `A`, `X`, `Y`, `SP`, `D`, `DBR` and `pc` values 1,447 bytes apart (`OQ-I021-4`); not yet confirmed as "same routine, relocated".

## Builds and SHA-1

| Build | SHA-1 (first 8) | Files after |
|-------|-----------------|-------------|
| baseline (Mesen2 slot `w3`, end of I020) | `3939c4be` | 547 |
| after spec 01 (actor_shared) | `4b76b0ac` | 541 |
| after spec 02 (Grass Valley) | `a7e6f985` | |
| after spec 03 (Greenwood) | `601d5bcd` | |
| after spec 04 (St. Elles) | `8ffd6ef1` | |
| after spec 05 (Mountain of Souls) | `23b94aa9` | |
| after spec 06 (Leo's Lab) | `40a3d591` | |
| after spec 07 (Magridd's Castle) | `ad8472c7` | |
| after spec 08 (World of Evil) | `e061c9e4179880ee2b537e28d4113cf958c9fda6` | 220 |

The last row is the new gate value (1,081,344 bytes, checksum 110050252). Merges change the SHA-1 because the packer places blocks per bank, largest first; the renames do not (per the I020 finding for `rename`; not isolated in this wave, because every rename here shares a spec with merges).

## Gate

| Check | Result |
|-------|--------|
| `npm run blocks` (each spec, in its scratch folder) | 6,047 of 6,047 top-level labels with identical text before and after, 0 undefined references, 0 broken 2-byte bank guarantees, `?INCLUDE` closure, scratch rebuild OK, for each of the eight specs |
| `npm run extract:lt` | OK, 0 stale at the final run |
| `npm run rebuild` | OK, SHA-1 `e061c9e4179880ee2b537e28d4113cf958c9fda6`, 1,081,344 bytes, checksum 110050252; 27 "Cross bank call detected" notices (the same count as the wave 3 run recorded in I020) |
| `npm run names -- --check` | OK, 111 names |
| `npm run merge -- --check` | 0 comments, 26 part notes, 2 block notes against 220 files; errors 0, warnings 0, orphans 0, duplicate keys 0 |
| `npm run audit` | 11 groups (`system`, `library`, `cop_handlers`, `actor_shared` and the seven world groups); one finding, the movable-target hazard R-2 (`data_04F000` 5, `asset_list_028000` 1, `string_lookup_080000` 2, `spc_030000` 1), unchanged; exits 1 because of it |
| plain `npm run extract` | OK, 0 stale |
| Empty groups or folders | none (every `extracted/*` folder has files) |

## Mesen2 comparison (baseline `3939c4be` in slot `w3` against wave 4 `e061c9e4` in slot `w4`, both from power-on; scratch ROMs, states and screenshots in `%TEMP%\blazer-spike`, not in the repository)

| Scenario | Method | Result |
|----------|--------|--------|
| Title, file select, name entry, opening dialogue, Trial Room (3,677 frames) | `compare_runs` of `trial.rec` on power-cycled slots, 5 watches; then `play_input_file` on each | 0 divergent frames in 3,677; same CPU registers at frame 3,677; same screenshot hash `ebd102f2...` at frame 3,681 |
| Menu, status page | state at the end of `trial.rec`; `a` for 3 frames, 30 frames of no buttons, 2 more frames; `take_screenshot` with `layers` | identical hash `6a3c7d11eec9c32a4e17667dea73f3741cd918b3` in both builds (the value of I018 to I020) |
| Boss fight (Metal Mantis, `gv_boss_metal_mantis`) | from the Trial Room state: `$0318 = 0x0306`, `$037C = $0080`, `$037E = $00A0`, `$0380 = 0`; 296 frames; state saved at frame 3,977; `layers` screenshot; `compare_runs` of `boss_fight.rec` (538 frames, watches `$0301`, `$0374`, `$0376`, `$033A`, `$0808`, `$0312`) from those states | the boss room is on screen in both builds, identical hash `e7ca9e3b5e1c42212d4e3d2dee462e157b700715`; 0 divergent frames in 538; after the fight both builds show the same Trial Room with the text "A voice came from above." (hash `88a35010d907ee38cc1b23ea228c75f86d83bd8d`, frame 4,515) |
| World scene | from the Trial Room state: `$0318 = 0x0101` (Grass Valley), arrival `$0080`, `$00A0`, 400 frames; `layers` screenshot | identical hash `d96230579dfd959848e50e130fe2ecec5f17131d` in both builds (the player on the cliff face, clouds above) at frame 4,081. The arrival point is not a real entrance (`OQ-I021-3`) |
| CPU phase | registers at equal frames | frame 3,977: `pc` 56,803 against 58,250; frame 4,081: `pc` 56,817 against 58,264 (1,447 apart both times), all other registers equal; recorded as `OQ-I021-4` |

Limits: the runtime evidence is the title to Trial Room run, the status page, the Metal Mantis room and fight, and one Grass Valley scene. The boss fight and the Grass Valley scene exercise `gv_*` and the engine; the actors, enemies and texts of Greenwood, St. Elles, the Mountain of Souls, Leo's Lab, Magridd's Castle and the World of Evil were verified statically only (text per label, references, banks, rebuild), because no scene of those worlds was loaded (`OQ-I021-3`). They are reached by 3-byte references from `meta_tables_008000` or 2-byte references inside their bank, and no block changed bank.

## Suggested commit message

```
Regroup wave 4 (placement-audit): world groups and actor_shared

- 47 merges in eight specs: 9 shared helpers into one file per bank;
  per area, kind and bank the actors, enemies and texts of Grass Valley,
  Greenwood, St. Elles, Mountain of Souls, Leo's Lab, Magridd's Castle,
  World of Evil; four files over 1,500 lines split by ROM order
- 5 renames (watching-over-world prompts, two unreferenced string stubs)
- blocks stay pinned to their bank; 547 to 220 extracted files
- pinned.md wave 4, OQ-I021-1..6, I021 results; new gate SHA-1
  e061c9e4179880ee2b537e28d4113cf958c9fda6
```

Please commit when you're ready.
