# Pinned clusters (PB3)

Clusters that a regroup wave did not move, or moved only as a pinned (non-`movable`) block, with the reason. A wave appends its section; earlier sections are not rewritten. "Pinned" means `movable` is absent: the block keeps the bank of its start and the packer only chooses the place inside the bank. A cluster that fails a constraint is not merged at all and is listed under "Not merged". Sources: `placement-audit.md` (section numbers are its own), `spike-decision.md`, and the dry-run and Mesen2 evidence of the wave.

## Wave 0 (I017): nine fall-through units

**Not merged: none.** All nine pairs passed every constraint (same group, same bank, adjacent in the original, no `rewrites.json` or `overrides.json` entry inside, no `&` closure broken, text identical for 6,047 of 6,047 labels, 0 undefined references, 0 broken bank guarantees).

**Merged and kept pinned (all nine).** The merged blocks stay non-movable because other blocks reach their labels by a 2-byte reference, so the bank must not change (spike condition 2). Inbound references from other files, read from the extracted tree after the wave:

| Block (new name) | Absorbed blocks | Bank | Inbound `&` / `BRL` from other files | Why it stays pinned |
|------------------|-----------------|-----:|---------------------------------------|---------------------|
| `gv_fairy_gem_advice_return` | `w0_actor_01AC32`, `w0_shared_01AD1B` | 03 | `BRL` from `w0_actor_01A3B0_part2`, `w0_actor_01ADF8` into `code_01AD1B`; meta entry `$39` of world 0 (`@`) | `BRL` and the meta list need the bank of the target; the actor also uses the return-address helper `w0_shared_01B161` |
| `gw_fairy_gem_return_prompt` | `w1_actor_01E4C3`, `w1_shared_01E4E9` | 03 | `COP [07] ( &code_01E4E9 )` and `BRL` from `w1_actor_01E510`, `01E540`, `01E594`; meta entry `$3F` of world 1 | 2-byte `COP` operands from three other files |
| `gw_player_shift_north` | `w1_actor_01E759`, `w1_shared_01E75C` | 03 | `COP [27] ( &code_01E759 )` from `gw_player_shift_south`, `COP [27] ( &code_01E75C )` from `w1_actor_01E62A`; meta `$39` | 2-byte `COP [27]` operands, and a mutual `COP [27]` ring with the other three shift blocks |
| `gw_player_shift_south` | `w1_actor_01E7D5`, `w1_shared_01E7D8` | 03 | `COP [27]` from `gw_player_shift_north`, `COP [12] ( #14.., &code_01E7D8 )` from `w1_actor_01E5BA`; meta `$3B` | same |
| `gw_player_shift_west` | `w1_actor_01E851`, `w1_shared_01E854` | 03 | `COP [27]` from `gw_player_shift_east`, `COP [12] ( #16, &code_01E854 )` from `w1_actor_01E5BA`; meta `$3A` | same |
| `gw_player_shift_east` | `w1_actor_01E8ED`, `w1_shared_01E8F0` | 03 | `COP [27]` from `gw_player_shift_west`, `COP [12]` from `w1_actor_01E5BA`; meta `$3C` | same |
| `se_fairy_gem_return_prompt` | `w2_actor_0FA440`, `w2_shared_0FA46D` | 1F | `COP [07] ( &code_0FA46D )` and `BRL` from `w2_actor_0FA494`, `0FA4C4`, `0FA4F4`; meta `$50` | 2-byte `COP` operands from three other files |
| `ms_fairy_gem_return_prompt` | `w3_actor_021ECE`, `w3_shared_021EFB` | 04 | `COP [07] ( &code_021EFB )` and `BRL` from `w3_actor_021F22`; meta `$3E` | 2-byte `COP` operand |
| `ll_fairy_gem_return_prompt` | `w4_actor_023DD3`, `w4_shared_023E00` | 04 | `COP [07] ( &code_023E00 )` and `BRL` from `w4_actor_023E27`, `023E57`; meta `$2F` | 2-byte `COP` operands from two other files |

Within each merged block the part order is the original ROM order (actor first, tail second); the assembled ROM shows the actor's last byte run (`02 09 xx xx` or `02 AD 08`) directly followed by the tail's first `COP` (checked in the rebuilt bytes at the block's `layout.json` location, not against the original).

## Pins established before PB3 (carried forward, unchanged by wave 0)

| Cluster | Reason | Source |
|---------|--------|--------|
| `meta_tables_008000` | 34 base-relative reads with DBR `$01` from bank 0 and bank 2: may move inside bank 1 only; pinned with `movable:false` | `spike-decision.md` |
| `table_0099B4`, `table_00A9DE`, `table_00AC96`, `table_00B69A`, `data_00BA0D`, `data_00EE8E`, `data_00F99A`, `data_00F9F7` | read through DBR `$01` or long pointers into bank `$01` | audit 4.3 |
| `asset_list_028000`, `spc_030000`, `data_048000`, `data_04F000`, `string_lookup_080000`, `table_050000` .. `table_078000` | bank selectors in `us/labels.json`; the five `movable` ones still have eight open 2-byte references (`OQ-I016-2`) | audit 4.3, `I016_questions.md` |
| 110 COP handlers, 28 pose handlers (`code_list_001B2B`), `engine_00561E` (COP, BRK), `native_mode_nmi_000342`, `native_mode_irq_0005A5`, `emulation_mode_reset_000000` | vectors and `&Code` handler tables: bank 0 | audit 4.1 |
| the 46 `ASCIIString` blocks of the library and the `&ASCIIString` tables | the string COPs read through DBR `$02`: bank 2 | audit 4.2 |
| `engine_003005.code_00305F`, `w0_shared_01B161.code_01B17C`, `w3_shared_022289`, `common_actor_004659_part1` | return-address idiom (`LDA #$&label-1`, `PHA`, `RTS`): the target keeps the bank of the executing routine | audit 4.5 |
| `lib_027781_part1` .. `part3` | `BRL` / `BMI` into `loc_02787C`, run in order: keep in one block | audit 4.8 |
| `engine_routines_001D3B` with `common_actor_001A28_part1` | 273 and 32 references, one mutual pair, bank 0 | audit 3.4, 4.6 |

## Wave 1 (I018): single-caller clusters

**No cluster failed a hard constraint.** All 32 merges (31 from placement-audit 7.2 plus the souls strings, W1-32) kept the same group and the same bank, kept the original ROM order inside the block, and passed the `blocks` verifier (text identical for 6,047 labels, 0 undefined references, 0 broken 2-byte bank guarantees). Every merged block stays non-`movable` (its start bank is fixed by the 2-byte references that already reached it). The entries below are the things wave 1 did **not** merge, with the reason.

| Cluster | Left apart because | Where it goes |
|---------|--------------------|---------------|
| `lib_menu_item_data` (was `lib_0118FC_part13`, 3,151 bytes, 285 lines) | pure data (item description headers, pointer list and 65 strings, gear stat table), one caller; merging it into `lib_menus` would pass 1,600 lines (guide: about 1,500) and mixes data with code (placement 6.3). Renamed only | stays a data file |
| `lib_scene_profile_data` (was `lib_0133A6_part4`, 1,420 bytes) | profile list and records read through pointers; merging it into `lib_scene_asset_loader` would pass 1,790 lines. Renamed only | stays a data file |
| `lib_text_render` (1,707 lines) | over the 1,500 guide, accepted: `code_012769` is the one text renderer (`lib_shared_012769` + `lib_shared_014789`, one subsystem; splitting it would re-create a cross-file `JSL` pair) | none |
| `lib_0118FC` parts 2, 5, 6, 8, 9, 10, 12 | the code parts have several callers outside the menu file (not single-caller); part 12 was later merged only for contiguity (W1-32) | later wave, with the callers' subsystems |
| `lib_0109D6` parts 1 and 3 | called from two subsystems | later wave |
| Fairy Gem families of the other worlds | not single-caller in the wave 1 table (wave 0 already merged what falls through); only the Grass Valley and Mountain of Souls pairs were merged here (W1-12, W1-13) | later wave |
| `common_actor_001A28_part1` with `engine_routines_001D3B` (now `player_attack_animation_handlers`) | the pair stays pinned (273 and 32 references); `player_core` waits for the `common` to `system` group move of wave 3, so part 1 was not merged with `player_spells_level_up` | wave 3 |
| COP `move-part` ideas (`code_0064CC`, `code_006537`) | need a group change; not single-caller merges | wave 2 |

**New constraint found at run time (W1-32): a stride walk needs contiguity.** `code_0119B7` (the souls page) prints the five 21-byte soul lines with `LDY #$&asciistring_014636`, `ADC #$0015`, `CPY #$&asciistring_01469F`, `BNE`, and stops only when Y equals the end label **exactly**. The five lines lived in five separate files (`lib_menus`, `lib_01464B`, `lib_014660`, `lib_014675`, `lib_01468A`) and the end label in a sixth (`lib_0118FC_part12`), so the packer scattered them. The loop then ran until Y wrapped to the end address and printed other strings (seen in Mesen2 in the wave 0 build: the souls page showed pieces of unrelated dialogue; earlier builds were not examined). Now one block, `lib_menus`, in the order `asciistring_014636`, `01464B`, `014660`, `014675`, `01468A`, `01469F` (checked in `layout.json`: `lib_menus` ends at the byte where `lib_text_render` starts, and the five lines are 21 bytes apart). **Do not split or reorder this run.** `CPY #$&label` / `CMP #$&label` against a label is the pattern; `lib_menus.asm` line 172 is the only instance in the extraction.

## Wave 2 (I019): COP handlers and the engine blocks of bank 0

**No cluster failed a hard constraint, and none was dropped from the wave.** All 17 rows (W2-01 .. W2-17, specs `edits/I019_blocks_01..03`) passed the `blocks` verifier (text identical for 6,047 of 6,047 labels, 0 undefined references, 13,950 two-byte bank guarantees checked, 0 broken, `?INCLUDE` closure intact). Every new block is **pinned in bank 0** (no `movable`): the COP handlers are reached through the three word tables read by `native_mode_cop_00561E`, and the engine blocks hold the vectors and the exit chain. The wave moved no block to another bank, so there is nothing that needs the bank of its start to change.

**What was merged and why it stays pinned.**

| New block | Pinned because |
|-----------|----------------|
| `cop_dispatch` (`native_mode_brk_0055FC` + `engine_00561E`) | holds the BRK/COP entry and the COP dispatcher; vector targets are bank 0 |
| `cop_core` (`CopB2_SpawnBeforeRelative`, `code_0064CC`, `code_0064F8`, `binary_006516`, `code_00651E`, `code_006537`, `code_0065A7`) | every COP handler ends with a `BRL` into the exit chain `loc_0064B5` .. `loc_0064C9`; the `BRL` is 2 bytes and bank-local. `code_0064CC` (`WriteEventFlag`, one caller) and `code_006537` (`BlockActorFootprint`, one caller) were single-caller routines in other blocks and were moved in with `move-part` (W2-01, W2-02) |
| `cop_script_flow_flags`, `cop_items_stats_text`, `cop_conditions`, `cop_actor_fields_animation`, `cop_tiles_spawn_kill` | the handlers are named in `&Code` word tables (`code_list_005638`, `cop_junk`, `code_list_005738`): 2-byte references that need bank 0 |
| `engine_boot_main_loop` (`emulation_mode_reset_000000`) | reset vector |
| `engine_vblank_nmi` (`native_mode_nmi_000342`) | NMI vector |
| `engine_scheduler_sprites_combat_collision` (`native_mode_irq_0005A5`, 3,338 bytes, one part) | the IRQ vector points into this part; the part cannot be split by the tool (`OQ-I015-8`), so the block name describes what the part contains |
| `engine_spawn_lairs_death_drops`, `engine_title_file_select` | reached by `JSR`/`BRL`/`&` references from other bank 0 files (their parts were pinned to bank 0 already) |
| `engine_unreferenced_code` | no inbound reference, so no 2-byte reference pins it; it is kept in bank 0 because its parts started there and the wave moves nothing across banks |

**Left apart (not merged), with the reason.**

| Cluster | Left apart because | Where it goes |
|---------|--------------------|---------------|
| `player_core` | its parts depend on the `common` to `system` group move; moving it now would repeat the wave 1 decision (`common_actor_001A28_part1` stays with `player_attack_animation_handlers`) | wave 3 |
| `engine_003005` (return-address helper `code_00305F`, about 11 callers in worlds 0, 1 and 5; also listed in `rewrites.json`) | shared helper with many callers across files; the idiom `LDA #$&label-1` / `PHA` / `RTS` needs the target in the bank of the executing routine (audit 4.5). Nothing to join it with | stays pinned alone |
| `engine_004281` (24 bytes, three child scripts of the ghost-ship Purple Worms) and `engine_007A52` (a string reached from the save point `common_actor_00766C`) | not engine code: placement-audit 6.2 sends them to `se_ghost_ship` and to the save-point file of `actor_shared`, which needs the group moves of wave 3 | wave 3 |
| the IRQ part `native_mode_irq_0005A5` | cannot be split by `npm run blocks` (no `split-part`): `OQ-I015-8`, `OQ-I019-3` | tool extension, then a split |
| the three dispatch table parts (`code_list_005638`, `cop_junk`, `code_list_005738`) | they were already parts of `engine_00561E`; the dispatcher indexes one word table by id*2 across all three, so they stay contiguous and in this order (see below). The merge only added `native_mode_brk_0055FC` in front | none |
| `code_006BA5` (placement-audit 4.8 lists it as unreferenced) | not a part of its own: it is a 3-byte `JSR` label inside the `code_006B7F` part that falls into `code_006BA8`, so it stays in `engine_title_file_select`; gathering it into `engine_unreferenced_code` needs a part split (`OQ-I019-3`) | after the split tool |

**Constraints this wave confirmed or added.**

- **The COP dispatch tables are one run.** `native_mode_cop_00561E` reads word `id*2` of `code_list_005638` (ids `$00`..`$3C`), then `cop_junk` (ids `$3D`..`$7F`, filler), then `code_list_005738` (ids `$80`..`$B2`, which must start at `code_list_005638 + $100`). The three parts stay adjacent and ordered inside `cop_dispatch` (checked in the extraction: lines 69, 136, 209 of `cop_dispatch.asm`). The verifier cannot see this kind of dependence (same class as the souls run above).
- **The COP exit chain is a fixed target.** All handlers `BRL` into `loc_0064B5` .. `loc_0064C9` (`cop_core`). A handler may move only inside bank 0.
- **"Unreferenced" is not "dead".** `engine_unreferenced_code` holds `code_000205`, `binary_00030D`, `code_00031D` and `code_0074B1`: no label reference in the extraction (FM-A1, FM-A3). That is a static statement; the code can still be reached by a computed jump or from a table of addresses. The name says what the extraction shows, not that the code never runs (`OQ-I019-2`).
- **Relocating bank 0 code can move a frame boundary.** After the engine split the final build is frame-identical to the wave 1 build in the 538-frame boss fight (same watched values in every frame) and its work RAM at the start of that fight differs in only 236 of 131,072 bytes (3 in the direct page, 30 in the `+$18`/`+$19` field of 15 actor slots, 203 in the stack page; details in the I019 results). On a scene change, though, a frame of output (screen on or off) can differ between the two builds while the watched engine values stay equal (`OQ-I019-1`). The stage 2 build (COP regroup only) was frame-identical over the whole title to Trial Room run.

## Wave 3 (I020): regroup of `common`

Everything below stays pinned (`movable` unset): all blocks keep the bank their start address gives. `set group`, `set scene` and `rename` changed no byte (SHA-1 `1b5950f9...` after each of those specs). The two merges changed the SHA-1 to `3939c4be...` (the packer orders blocks by size).

**Merged in this wave.**

| New block | Absorbed | Pinned because |
|-----------|----------|----------------|
| `player_core` (group `system`, bank 0, 2,860 bytes) | `common_actor_001A28_part1` + `player_attack_animation_handlers` (parts `code_001512`, `word_001588`, `code_0015E0`, `code_list_001B2B`, `code_001D3B`, `code_002678`) | the part `code_list_001B2B` is a table of return addresses that the player code pulls with `LDA $@code_list_001B2B, X`, `DEC`, `PHA`, `RTS` (twice); the `RTS` target must lie in the bank of the executing routine (placement-audit 4.5, the same idiom as `engine_003005`), so the targets stay in bank 0. The only outside reference is the 3-byte `@player_core.code_001A28` in the seven world meta tables (`meta_tables_008000`). Audit 6.1 accepted about 1,660 lines. `player_spells_level_up` (the audit's `player_magic`) stays a block of its own |
| `unreferenced_stubs_bank1f` (group `system`, bank 1F, 6 bytes) | `common_shared_0FDFC0` + `common_shared_0FE769` (each `COP [86]`, `RTL`) | no reference to either label in the extraction, so no rule pins them; they stay in bank 1F because that is where they started and nothing moves across banks. "Unreferenced" is a static statement (`OQ-I020-4`) |

**Moved without merging (group and scene only).**

| What | Where | Note |
|------|-------|------|
| 7 bosses, 3 ghost-ship enemies, 82 bank 1F enemy blocks | world group of their prefix, scene = the area key of their placements or of their lair/boss spawn (placement-audit 5.5) | a block that is placed in two areas, or in none (meta entries `w1:34`, `w1:36`, `w2:33`), has no scene |
| 124 blocks of the former `common` group (spec 02) plus 258 existing world blocks (spec 03) | scene per area | 27 world blocks have no scene on purpose: see below |
| `engine_004281` (renamed `se_ghost_ship_enemy_child_scripts`) | `st_elles/ghost_ship`, bank 0 | placement-audit 6.2: only the two ghost-ship enemies spawn it. Renamed because `engine_` described the old group |
| 9 shared helpers | new group `actor_shared` (no scene) | callers lie in more than one world (audit 5.4) |
| player pieces, `engine_spc_ipl_upload` | `system` | called from engine code in every world |

**Left apart (not merged, or without a scene), with the reason.**

| Cluster | Left apart because | Where it goes |
|---------|--------------------|---------------|
| the 9 `actor_shared` blocks | they live in three banks (0, 3 and 4); a merge across banks would move code. Per-bank files are possible: `shared_animation_tick_loop`, `shared_enemy_helper_002D67`, `shared_dialogue_tail_007A52` and `shared_shrine_save_menu` (bank 0); `shared_animation_loop_helper_01B161`, `shared_help_me_message_0191D2`, `shared_dialogue_tail_01B988` (bank 3); `shared_animation_loop_hurt_message_022289`, `shared_ms_fairy_gem_texts_dialogue_tail` (bank 4) | wave 4 |
| `shared_ms_fairy_gem_texts_dialogue_tail` | one block with two unrelated parts (the Mountain of Souls fairy-gem texts and a dialogue tail): needs a part split to place the texts in world 3 | after the split tool (`OQ-I015-8`) |
| `w0_shared_01A4F9`, `w5_shared_02623C` (string stubs) | no inbound reference (audit 4.8), but they sit in banks 3 and 4 next to their world's code; gathering them into dead-code files is a wave 4 decision | wave 4 |
| 27 world blocks without a scene: `grass_valley` 5 (`w0_shared_01A4F9`, `w0_shared_01ABB9`, `w0_actor_01AFFD`, `w0_actor_01B1F7`, `gv_enemy_0FAA49`), `greenwood` 4 (`w1_actor_01E4BB`, `w1_shared_01EBC2`, `gw_enemy_0FB680`, `gw_enemy_0FB6F8`), `st_elles` 3 (`w2_actor_0FA6F5`, `w2_shared_0FA945`, `se_enemy_0FBB78`), `mountain_of_souls` 11 (`ms_fairy_gems_return_prompt`, `w3_actor_02220D`, nine `ms_enemy_*`), `leos_lab` 1 (`w4_shared_023F33`), `magridds_castle` 3 (`w5_shared_02623C`, `w5_shared_026DF2`, `w5_shared_02706C`) | placed in more than one area, helpers whose users span areas, unused meta entries, or no placement evidence | stay in the world group without a scene (`OQ-I020-5`) |
| enemy family merges (for example the six `we_enemy_*` of `evil_world`, or the five `gv_enemy_*` of `underground_castle`) | each enemy block is reached by its own 3-byte `@block.label` entry in `meta_tables_008000`, so the merge is allowed by the references, but it re-orders what the packer places and is a separate decision | wave 4 |

**Constraint carried through this wave.** The souls string run in `lib_menus`, the COP dispatch tables, the COP exit chain and the vector blocks were not touched. Boss and enemy blocks are reached from `meta_tables_008000` (bank 1, `movable:false`) by 3-byte references, so their group and scene folders do not matter to the packer; no block changed bank. New constraint: `player_core` holds a return-address table (`code_list_001B2B`), so it stays in bank 0 with the targets.

## Wave 4 (I021): regroup of the world groups and `actor_shared`

Eight specs (`plans/extracted-audit/edits/I021_blocks_01_*.json` .. `_08_*.json`), each dry-run first and each verified in its scratch folder (6,047 of 6,047 labels with identical text, 0 undefined references, 0 broken 2-byte bank guarantees, `?INCLUDE` closure, rebuild OK). 47 merges and 5 renames; 547 to 220 files. No cluster failed a hard constraint. Every merged block is still pinned (`movable` unset): it stays in the bank its start address gives, and nothing crossed a bank. Because the packer places blocks per bank, largest first, a merge changes the SHA-1 (chain in the I021 results) but cannot move a block into another bank.

**Merged in this wave (the rule for each cluster: same bank, same area, same kind).**

| Cluster | Merged into | Pinned because |
|---------|-------------|----------------|
| 9 shared helpers of `actor_shared` | `shared_actor_helpers_bank0` (4 blocks), `shared_actor_helpers_bank3` (3), `shared_actor_helpers_bank4` (2); one block per bank | the three banks differ; a merge across banks would move code. Each helper keeps the bank of its start; callers use 2-byte references and the `RTS` return-address idiom, so the targets must stay in their bank |
| actors, enemies and texts of each world area, one block per area, kind and bank | `gv_*`, `gw_*`, `se_*`, `ms_*`, `ll_*`, `mc_*`, `we_*` (full list in the I021 results) | actors in bank 0 or banks 3 and 4 and enemies in bank 1F are separate blocks, because the bank follows the start address; enemies are reached by 3-byte references from `meta_tables_008000` (bank 1, R-2), so their merge needs no reference to be kept |
| files over about 1,500 lines | split by ROM order: `gv_village_actors_018000` and `_019475`, `gw_woods_actors_01B98D` and `_01D045`, `se_seabed_sanctuary_actors_0F8000` and `_0F8D58`, `ms_soul_of_mountain_house_actors_020000` and `_02100B` | readability only (audit 6.1). The name carries the offset of the first absorbed block (`OQ-I021-6`). `ll_laboratory_actors` (30 blocks, 1,545 lines) was accepted as one file |

**Left apart (not merged), with the reason.**

| Block | Left apart because |
|-------|--------------------|
| `gv_boss_metal_mantis`, `gw_boss_light_water_fire_statues`, `se_boss_floating_skull`, `ms_boss_poseidon`, `ll_boss_tin_doll`, `mc_boss_demon_falcon` | each is the only boss of its area and sits in bank 0 with its own scene; a boss is one self-contained fight, and merging it with its area's actors would only hide it. (`we_boss_deathtoll_mage` was merged into `we_deathtolls_shrine_actors` with the shrine actor and the demon, which share scene `deathtolls_shrine` and bank 0) |
| `gv_enemy_0FAA49`, `se_enemy_0FBB78`, `ms_enemy_0FCFD6`, `ms_enemy_0FD058` | singletons: no scene of its own, or placed in more than one area (`OQ-I020-5`), so no cluster of the wave 4 plan contains them |
| `w1_actor_01E4BB`, `w2_actor_0FA6F5`, `w6_actor_01F14F`, `w6_actor_01EC4B` | singletons: no cluster of the wave 4 plan contains them (no failed constraint; a later wave may pair them) |
| `w2_shared_0FA945` | return-address helper (`LDA #$&label-1`, `PHA`, `RTS` idiom, 94 references): the block keeps its bank, and no cluster of the wave 4 plan contains it |
| `w4_shared_023F33` | renamed `ll_watching_over_world_return_prompt_texts`; no partner in bank 4 and area |
| `lib_0118FC` parts and `lib_0109D6` parts 1 and 3 | library leftovers: not in placement-audit 7.5, not touched |
| enemies of different areas | not merged across areas (per area and bank only), so a scene folder still says where an enemy is |

**Renames only (no merge needed).**

| Old | New | Reason |
|-----|-----|--------|
| `w0_shared_01ABB9` | `gv_watching_over_world_texts` | the ROM text is the "Watching over world" prompt of Grass Valley |
| `w1_shared_01EBC2` | `gw_watching_over_world_return_prompt_texts` | same, Greenwood |
| `w4_shared_023F33` | `ll_watching_over_world_return_prompt_texts` | same, Leo's Lab |
| `w0_shared_01A4F9` | `gv_unreferenced_string_stub_01A4F9` | no inbound reference in the extraction; "unreferenced" is a static statement (`OQ-I021-2`) |
| `w5_shared_02623C` | `mc_unreferenced_string_stub_02623C` | same, Magridd's Castle |

**Constraints this wave confirmed or added.**

- **A block ends with a fall-through only when its successor is in the same file.** The nine units that were found in wave 0 are inside the merged files; no merge in this wave separated a fall-through pair (the verifier compares text per label, and the rebuild would have reported an undefined reference).
- **The return-address helpers stay in their bank.** `shared_actor_helpers_bank0/3/4` keep one block per bank; the same applies to `w2_shared_0FA945`.
- **The COP [9B] files and the `rewrites.json` entries** (offsets 11622, 12382, 21331, 110971, 113033, 139912, 1026372) are keyed by offset, not by block; no merge in this wave changed an offset key (the rebuild is OK; they were checked only by that rebuild, not site by site).
- **`lib_menus` souls run intact.** In the final layout `lib_menus` is at 68687 with 2712 bytes, ending at 71399, where `lib_text_render` starts: the contiguous run that the souls stride loop needs is unchanged.
- **`shared_ms_fairy_gem_texts_dialogue_tail` is one part of five strings**, not two parts (I020 said two): it was merged into `shared_actor_helpers_bank4` as is (`OQ-I021-1`).
- **A merged block with several callers is still one label per original block.** The flat label namespace is unchanged: the 6,047 top-level labels have identical text before and after.

## Wave 5 (I022): strings and data with their users, helpers by subsystem

**Why this wave exists.** After wave 4 the `library` group still held many files of one string, one table or one routine each (its 115 blocks were not in any cluster of `placement-audit.md`). A file of one string is overhead: every caller carries an extra `?INCLUDE` and a cross-file reference. Rule from the user: strings and data go with the code that uses them; minimize cross-file calls. Result: 220 to 151 files, 17 merges (plans in `plans/extracted-audit/edits/I022_blocks_01..04`, checklist in `I022_checklist.md`), cross-file references 3,061 to 2,936.

**What cannot be merged into the caller (the constraints that decided the shape of this wave).**

- **Text strings stay in bank 2.** The text renderer `code_012769` forces DBR `$02` and the callers pass 2-byte pointers (`COP [01]` and `COP [1A]`, `&ASCIIString`). The callers are in banks 0, 3, 4 and 31, and no bank has room (1 to 84 bytes free), so a string cannot follow its caller. The unit of merging is therefore **one bank-2 text file per consumer**, in the consumer's group and scene. The 27 `Cross bank call detected ... COP asciistring_...` notices of `npm run rebuild` are the same 27 `COP [1A]` operands as before (checked: the count is unchanged).
- **Bank-1 data is bank-fixed.** `data_00F9F7`, `data_00BA0D` and the other tables keep their bank; `$@` long references to them stay cross-file (`lib_bit_array` reads `binary_00FA77`).
- **The souls string run of `lib_menus` stays contiguous and in order** (the stride loop `CPY #$&asciistring_01469F`). It was merged with the item names and descriptions that follow it in ROM order (`lib_shared_014F74`, `lib_menu_item_data`, `lib_0161CE`); nothing was inserted into the run.

**Merges (row ids of the specs).**

| Row | Block | Group, scene | What it holds |
|-----|-------|--------------|---------------|
| W5-01 | `gv_title_texts` | `grass_valley`, `front_end` | "PUSH START", the copyright lines, the cursor string `asciistring_014176`, the "Please choose a record" screen and the table `binary_01440D` read with it |
| W5-02 | `gv_prologue_texts` | `grass_valley`, `front_end` | the 14 narration strings of the opening ("Wise men tell a tale ...") |
| W5-03 | `gv_epilogue_texts` | `grass_valley`, `front_end` | the 9 strings of the ending chain and staff roll ("Grass Valley at sunset ...") |
| W5-04 | `lib_banner_texts` | `library` | the "LEVEL UP !" banner, the bar string, the location banner and its name list (`lib_location_banner_names`), "Monster Lair / Remaining" |
| W5-05 | `lib_menus` | `library` | + item data, the item names and descriptions (`lib_shared_014F74`, `lib_menu_item_data`, `lib_0161CE`) |
| W5-06 | `shared_choice_prompt_texts` | `actor_shared` | the five choice prompts ("Yes / No", "Yes", "Record / Move / Quit", "Record / Quit", "Stay / Go back") used by the 27 `COP [1A]` calls from many areas |
| W5-07 | `lib_tile_triggers_and_lair_return` | `library` | tile triggers, lair return mode, `lib_shared_016246` |
| W5-08 | `lib_0108BB` | `library` | + `lib_017504` |
| W5-09 | `lib_map_streaming` | `library` | camera delta, strip request, column and row fills, full redraw, BG2 parallax ratio |
| W5-10 | `lib_scene_map_patches` | `library` | the scene-entry map patches and the rectangle copy they share |
| W5-11 | `lib_system_helpers` | `library` | HDMA channel queue, force blank, NMI on and off, vblank wait |
| W5-12 | `lib_arithmetic` | `library` | 8x8 multiply, divide, byte to BCD, the random number routine |
| W5-13 | `lib_save_system` | `library` | save to SRAM, load, slot checksum (bank 4) |
| W5-14 | `lib_map_index_helpers` | `library` | pixel to map index, VRAM address, step east and south, metatile test (bank 4) |
| W5-15 | `lib_bit_array` | `library` | set, clear, test a bit of a bit array (bank 4) |
| W5-16 | `lib_player_facing` | `library` | player facing and X flip (bank 4) |
| W5-17 | `lib_player_stats` | `library` | pending heal, pending EXP, add EXP, add and subtract Gems (bank 4) |

**Prologue and epilogue are two files, not one.** The front-end strings were mixed (the user's remark on `gv_front_end.asm` line 675, `LDY #$&lib_0142BB.asciistring_0142BB`). They are split by the actor that reads them: `code_0066FC` (title and opening) reads the title and prologue strings, `code_00729D` (ending chain) and `code_007638` (staff roll) read the epilogue strings. The file-select strings belong with the title, because the boot and file-select actors read them, so they are a third file.

**Left apart (not merged), with the reason.**

| Block | Left apart because |
|-------|--------------------|
| `lib_0118FC_part2`, `_part5`, `_part6`, `lib_012281`, `lib_shared_01230B`, `lib_01232B`, `lib_shared_012390`, `lib_shared_012416` | helpers of the menus with callers in other files; with the item data `lib_menus` is already 1,848 lines. A separate wave if wanted |
| `lib_scene_profile_data` | 1,420 bytes of data, 17 references from `lib_scene_asset_loader` only; merging it would take that file past 1,790 lines |
| `data_00F9F7`, `data_00BA0D` and the other bank-1 tables | bank-fixed |
| `lib_027277`, `lib_027223`, `lib_02719F`, `lib_shared_027260`, `lib_027912`, `lib_027572`, `lib_010000`, `lib_013ADA`, `lib_animation`, `lib_0116C3`, `lib_0126CF`, `lib_name_entry`, `lib_map_sweep_redraw`, `lib_0109D6_part1`, `lib_0109D6_part3`, `lib_011695`, `lib_027781_part1` | single routines of their own subsystem, with their own small data table where they have one; no cohesive partner |

**Constraint found in this wave.**

- **A merge can change the accumulator width the extraction infers for a part.** In `lib_system_helpers` the two entry points `code_0131A2` and `code_0131AE` (NMI on and off) follow `code_01318C`, which ends with `PLP`; the verifier reported `LDA #$A1` becoming `LDA #$8DA1`. The fix is a register-state override (`"M": 1` at 78242 and 78254 in `us/overrides.json`), not a reorder. Any later merge that puts a bare entry point behind a routine ending in `PLP` should expect the same (`OQ-I022-1`).

## Wave 6 (I042): final layout of the core engine and library

Specs `edits/I042a_blocks.json`, `I042b_blocks.json`, `I042c_blocks.json`. Files 151 -> 136, cross-file references 2,936 -> 2,921; every spec passed per-label text equality (8,256 labels), 0 undefined references and the bank guarantees. New operation `split-part` (a cut needs a label at the offset and a terminator before it).

**Merged.**

| New block | From |
|-----------|------|
| `lib_map_scroll_and_redraw` | `lib_010000`, `lib_map_streaming`, `lib_map_sweep_redraw` |
| `lib_map_tile_patches` | `lib_0109D6_part1`, `lib_0108BB`, `lib_scene_map_patches` |
| `lib_hdma_window_effects` | `lib_011695`, `lib_0116C3` |
| `lib_choice_menus` | `lib_0118FC_part2`, `lib_012281`, `lib_shared_01230B` |
| `lib_menu_screen_setup` | `lib_01232B`, `lib_shared_012390`, `lib_shared_012416`, `lib_0118FC_part5` |
| `lib_name_entry_and_staff_roll` | `lib_name_entry`, `lib_0126CF` |
| `lib_system_helpers` (grown) | `lib_013ADA` (`ApplyBootPpuLayout`) and `EnableDisplayAndNmi` from `lib_menus` |
| `lib_hud` (renamed from `lib_0118FC_part6`) | gets `HudRepeatCounts` and `HudFrameText` from `lib_menus` |
| `lib_boot_and_scene_init` | `lib_scene_change_init`, `lib_02719F`, `lib_shared_027260`, `lib_027912` |
| `lib_main_loop_helpers` | `lib_027223`, `lib_027572` |
| `lib_player_helpers` | `lib_player_facing`, `lib_027781_part1`, `lib_player_stats` |

**Split.** `DispatchFieldButtons` | `RunTalkInteraction` (new `lib_field_talk`) | `OpenEquipmentMenu` (back in `lib_menus`); the scheduler into `engine_actor_scheduler_and_sprites`, `engine_combat_hits` (from `DetectHitSourceCollisions`) and `engine_tile_collision` (from `MoveActorWithTileCollision`).

**Renamed.** `lib_0109D6_part3` -> `lib_inventory_store`, `lib_027277` -> `lib_unused_sine_wave_tables`, `engine_003005` -> `engine_player_death_and_actor_helpers`, and nine world blocks with one named part (`gw_actor_fixed_gem_pickup`, `w2_effect_player_overlay`, `w2_obj_fairy_idle_loop`, `we_obj_master_shrine_event`, `we_fx_battle_bg2_hofs_bands`, `se_unused_enemy_drifting`, `ms_enemy_ice_maker`, `ms_enemy_ice_crystal`, `gv_enemy_green_humanoid`). Blocks with several actors keep the address suffix.

**New pin.** `FindAssetLabel` ends with a never-taken `BRA loc_0139E6`, and that target is the `STZ BG2HOFS` inside `InitHardwareAndClearWram`. The routine cannot be split away from `lib_scene_asset_loader` (a first plan to split the loader at 80300 failed the rebuild with "Relative out of range in ScanAssetCommands"), so `lib_013ADA` went into `lib_system_helpers` instead (`OQ-I042-7`).

**Left apart (not merged), with the reason.**

| Block | Left apart because |
|-------|--------------------|
| `lib_text_render` (about 2,400 lines), `lib_scene_asset_loader`, `lib_menus` (about 2,160 lines), `lib_tile_triggers_and_lair_return` | over or near the 1,500-line guide size already; no merge that adds to them |
| `player_core` (1,942 lines), `engine_spawn_lairs_death_drops` (music load, ending, gem pickups mixed with lair spawn) | candidates for a later split wave (`OQ-I042-8`); not touched here |
| `unreferenced_stubs_bank1f`, `engine_spc_ipl_upload` | bank 1F, nothing moves across banks; the names stay |
