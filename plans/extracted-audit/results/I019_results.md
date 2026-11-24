# I019 results: PB3 wave 2, COP handlers and bank 0 engine blocks

Date 2026-11-22. Scope: `placement-audit.md` sections 6.1, 6.2 and 7.3 ("wave 2"), applied with `npm run blocks` (three specs, dry-run first). The original ROM was never compared with a rebuilt ROM; the baseline for every comparison is the wave 1 build (`6a8224ed`, the I018 gate value). Rebuilt locations below are from `rebuilt/layout.json`.

## Changed in the project

| File | Change |
|------|--------|
| `us/blocks.json` | by `npm run blocks`: 17 rows (W2-01 .. W2-17), tables below. Group and `movable` of the new blocks: `system` group (engine blocks) and the existing COP family groups; none `movable` (all stay in bank 0) |
| `notes/blockNotes/bank00.json` | by `npm run blocks` (`notes:"join"`): the four notes of `cop_handler_006473`, `engine_0064F8`, `engine_0065A7` and `engine_00561E` became the two notes of `cop_core` and `cop_dispatch` |
| `extracted/` | regenerated (`npm run extract:lt`, then the plain extract at the end): 652 to 549 files, 0 stale left. New: `extracted/system/` (`cop_core`, `cop_dispatch`, `engine_boot_main_loop`, `engine_vblank_nmi`, `engine_scheduler_sprites_combat_collision`, `engine_spawn_lairs_death_drops`, `engine_unreferenced_code`, `engine_title_file_select`) and `extracted/cop_handlers/` (the five family files) |
| `docs/areas-and-scenes.md`, `docs/cop/index.md`, `docs/wram-memory-map.md` | whole-word block-name rewrites done by the tool. **Three lines of `docs/wram-memory-map.md` were corrected by hand** (line 28 `frame_counter` to `engine_vblank_nmi`; lines 52 and 56 "return path" to `engine_boot_main_loop`): the tool rewrote every mention of `engine_000000` to the new scheduler name, also where the text meant the reset or NMI code. This is the only manual doc edit; it is a block-name fix, not a fact |
| `plans/extracted-audit/edits/I019_blocks_01_cop_core_dispatch.json` | new, applied (W2-01 .. W2-04) |
| `plans/extracted-audit/edits/I019_blocks_02_cop_families.json` | new, applied (W2-05 .. W2-09) |
| `plans/extracted-audit/edits/I019_blocks_03_engine_split.json` | new, applied (W2-10 .. W2-17), each row with a `note` giving the evidence (FM-A1, FM-A2, FM-A3) |
| `plans/doc-audit/placement/pinned.md` | wave 2 section: what was merged and why it stays pinned, what was left apart, three constraints |
| `plans/doc-audit/README.md` | gate value |
| `plans/extracted-audit/questions/I019_questions.md` | `OQ-I019-1` .. `-6` (no DISCREPANCY) |
| `plans/extracted-audit/results/I019_results.md` | this file |

No names, notes (other than the join above), comments, `transforms.json` or `overrides.json` were changed by hand. `merge --check`: 26 part notes and 2 block notes, 0 orphans. `git status` also shows files modified by earlier iterations (`us/transforms.json`, `package.json`, `src/index.ts`); they are not from this step.

## The merges

| Rows | New block | Absorbed | Bank | Location | Size |
|------|-----------|----------|-----:|---------:|-----:|
| W2-01, W2-02, W2-03 | `cop_core` | `cop_handler_006473` (exit chain, `CopB2_SpawnBeforeRelative`) + `engine_0064F8` + `engine_0065A7`, plus `code_0064CC` (from `cop_set_or_clear_event_flag`) and `code_006537` (from `cop_block_own_tiles`) as parts | 00 | 25184 | 595 |
| W2-04 | `cop_dispatch` | `native_mode_brk_0055FC` + `engine_00561E` (dispatcher and the three table parts) | 00 | 28671 | 418 |
| W2-05 | `cop_script_flow_flags` | 18 handler blocks (`00579E` .. `006063`, including `cop_set_or_clear_event_flag`) | 00 | 26833 | 511 |
| W2-06 | `cop_items_stats_text` | 14 handler blocks (`0057A2` .. `005E05`) | 00 | 27344 | 454 |
| W2-07 | `cop_conditions` | 14 handler blocks (`cop_jump_if_actor_in_box`, `00590D` .. `006373`) | 00 | 24585 | 599 |
| W2-08 | `cop_actor_fields_animation` | 39 handler blocks | 00 | 16595 | 973 |
| W2-09 | `cop_tiles_spawn_kill` | 19 handler blocks (`cop_block_own_tiles`, `cop_conditional_spawn`, `0059FB` .. `006431`) | 00 | 21842 | 748 |
| W2-10, W2-11 | `engine_spawn_lairs_death_drops` | `engine_0026F3` + `engine_death_drops_ending` + `engine_002EC0` + `cop_handler_005CF0_part1`, plus part `code_0012AF` (from `engine_000000`) | 00 | 3338 | 3008 |
| W2-12 | `engine_boot_main_loop` | part `emulation_mode_reset_000000` (from `engine_000000`) | 00 | 26316 | 517 |
| W2-13 | `engine_vblank_nmi` | part `native_mode_nmi_000342` (from `engine_000000`) | 00 | 23974 | 611 |
| W2-14, W2-15 | `engine_unreferenced_code` | parts `code_000205`, `binary_00030D`, `code_00031D` (from `engine_000000`) + `engine_0074B1` | 00 | 29502 | 351 |
| W2-16 | `engine_scheduler_sprites_combat_collision` (rename of `engine_000000`, which kept the IRQ part `native_mode_irq_0005A5`) | what is left of `engine_000000` | 00 | 0 | 3338 |
| W2-17 | `engine_title_file_select` (rename of `engine_006B7F`) | itself | 00 | 23293 | 681 |

The COP merges cut 110 handler files to 5 family files; the 124 `BRL` pairs into `cop_core` stay cross-file by design (placement-audit 7.3). Names follow the walkthrough's terms where the ROM text supports them and otherwise say what the code does; `engine_unreferenced_code` says what the extraction shows, not that the code never runs (`OQ-I019-2`).

## Findings

- **Stage by stage the layout stayed correct.** Static checks passed for each spec on its own. The runtime comparison was run after stage 2 and after stage 3.
- **Frame phase.** The stage 2 build (`31136448`, COP regroup only) is frame-identical to the wave 1 baseline over the whole 3,677-frame title to Trial Room run. The final build is identical at frame 3,677 (CPU registers `A=$0060 X=$0980 SP=$1FFB`, screenshot hash `2767aaee...`), but a `compare_runs` of the whole run shows a one-frame phase shift at the scene change (frame 3389). In the boss fight the engine values are identical in all 538 frames; at the very end of that run one frame of screen output differs (baseline black, wave 2 showing the dialogue) with equal watched values. Cause not proven: `OQ-I019-1`.
- **Work RAM of the two builds at the boss room** (frame 3,977, both from the same recording and jump) differs in 236 of 131,072 bytes: 3 in the direct page (`$38`, `$3B`, `$3C`, the COP script pointer), 30 in the `+$18` / `+$19` field of 15 actor slots (low and high bytes of a word at `$0818`, `$0858`, ... step `$40`), and 203 in the stack page (`$1F02` .. `$1FFE`, stale return addresses). All the differing words are addresses or stack remains; the 128 KB outside them (including the frame counter, scene, player, boss and inventory words) is equal. The reading of those bytes as relocated addresses is an inference from where they are, not checked per byte.
- Baseline slot SP differs from wave 2 by 2 at frame 4,516 with the same PC (`$02:E30A`); see `OQ-I019-1`.

## Builds

| Build | SHA-1 | Meaning |
|-------|-------|---------|
| baseline (Mesen2 slot `w1b`) | `6a8224ed697fb00fc47ba90539524d361698a060` | end of I018 |
| stage 1 (`I019_s1.smc`) | `0cc5ac5e...` | spec 01 only (not a gate value) |
| stage 2 (`I019_s2.smc`, slot `s2`) | `31136448...` | specs 01 and 02, COP regroup (not a gate value) |
| wave 2 (slot `w2`) | `1b5950f9716428765936d6b494126bde1a1851a5` | all three specs: **the new gate value** (1,081,344 bytes, checksum 110093944). The scratch ROMs are in `%TEMP%\blazer-spike\`, outside the repo |

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK (fresh before the specs and again at the end; 0 stale left) |
| `npm run blocks` (each spec) | dry-run, then apply: text identical for 6,047 of 6,047 labels, 0 undefined references, 13,950 two-byte bank references checked, 0 broken, `?INCLUDE` closure OK |
| `npm run rebuild` | OK, SHA-1 `1b5950f9716428765936d6b494126bde1a1851a5`, 1,081,344 bytes (a change from `6a8224ed` is expected for a regroup) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | OK: 26 part notes and 2 block notes, 0 orphans, 0 duplicate keys |
| `npm run audit` | the one finding is the existing R-2 list (`spc_030000` 1, `data_04F000` 5, `asset_list_028000` 1, `string_lookup_080000` 2), unchanged |

## Mesen2 comparison (baseline `6a8224ed` against wave 2 `1b5950f9`, both from power-on)

| Scenario | Method | Result |
|----------|--------|--------|
| Title, file select, name entry, opening dialogue, Trial Room (3,677 frames) | `play_input_file` of `trial.rec` on each slot | same CPU registers and same screenshot hash `2767aaee...` at frame 3,677. `compare_runs` of the full run: stage 2 0 divergent frames; final build one frame of phase from frame 3389 (`OQ-I019-1`) |
| Menu, status page | `a` for 3 frames, 30 frames later | identical hash `6a3c7d11eec9c32a4e17667dea73f3741cd918b3` (the same value as in I018); `b` closes it and the Trial Room returns |
| Menu, souls page | `down` on the status page with the souls word set | black screen in both builds at 33 and 93 frames: **no evidence** (`OQ-I019-6`) |
| Boss fight | scene jump `$0318 = 0x0306`, arrival `$037C = $0080`, `$037E = $00A0`, `$0380 = 0`, state saved at frame 3,977 in each build; `compare_runs` of `boss_fight.rec` (538 frames, watches `$0301`, `$0374`, `$0376`, `$033A`, `$0808`, `$0312`) | 0 divergent frames. The state words `$0300` .. `$043F` and the boss room screenshot (hash `15dbbd50...`) are equal at frame 3,977. Work RAM: 236 bytes differ (Findings) |
| World scene jump | `$0318 = 0x0101` from the boss-room state | black screen in both builds at 400 and 1,000 frames, identical state words: **no evidence** (`OQ-I018-5`, `OQ-I019-6`) |

Limits: the runtime evidence is the 3,677-frame title to Trial Room run, the status page, and the 538-frame boss fight. The five COP family blocks and the engine blocks run in every one of those scenes (COP dispatch, reset, NMI, scheduler, spawn and death paths), but no world scene rendered in this run, so Grass Valley and later worlds were verified statically (text, references, banks) and through the shared engine paths only. Screenshot hashes are used only on a settled screen with no scene change before it. A stray write to `$1B42` (a word of the item bytes) happened in both slots before the souls test; it affected only those scratch slots. One screenshot was written by the Mesen2 server into the results folder of `gaia-iog-baserom` (its default) and was deleted; later screenshots went to `%TEMP%`.

## Suggested commit message

```
PB3 wave 2: merge COP handlers into five families, split the bank 0 engine (I019)

Regroup with npm run blocks (blocks.json): cop_core (exit chain plus the two
single-caller routines code_0064CC and code_006537), cop_dispatch, five COP
family blocks (cop_script_flow_flags, cop_items_stats_text, cop_conditions,
cop_actor_fields_animation, cop_tiles_spawn_kill; 110 files to 5), and the
engine_000000 parts moved into engine_boot_main_loop, engine_vblank_nmi,
engine_spawn_lairs_death_drops and engine_unreferenced_code. Renamed
engine_000000 to engine_scheduler_sprites_combat_collision and engine_006B7F
to engine_title_file_select. All new blocks stay pinned in bank 0. Text
identical for 6,047 labels, 0 undefined references, 0 broken bank guarantees;
title-to-Trial-Room, the status page and the 538-frame boss fight match the
wave 1 build. Rebuilt SHA-1 6a8224ed -> 1b5950f9 (expected for a regroup).
```

Please commit when you're ready.
