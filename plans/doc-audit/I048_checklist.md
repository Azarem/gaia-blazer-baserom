# I048 checklist - `docs/code/player.md` (the hero)

PD step of the plan "Blazer docs and analysis" (`c:\Users\azare\.cursor\plans\blazer_docs_and_analysis_e740ea3f.plan.md`, prompt "PD - Docs", topic = player). Continues I047. Annotation and docs only: the ROM SHA-1 must not change.

Baseline gate before this step: `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` (1,081,344 bytes, checksum 110070696), measured with `npm run rebuild` at the start.

Files of the topic (the prompt left `<files>` empty): `extracted/system/{player_core, player_spells_level_up, engine_player_death_and_actor_helpers (CheckPlayerDeath, MarkPlayerDead), data_engine_tables (PlayerFacingByAnim, PlayerMoveDirByAnim, LevelExpThresholds, SineTable, SineTableTail, WeaponMinLevelBcd), data_anim_player, data_anim_player_unarmed, data_anim_weapon_overlay, WorldMetaPointers (hero entries), engine_combat_hits (boundary only)}.asm`, `extracted/library/{lib_player_helpers, lib_boot_and_scene_init (InitFixedState), lib_menus (status screen clamp, RecalcGearStats)}.asm`, `extracted/cop_handlers/{cop_items_stats_text (Cop26, Cop37), cop_actor_fields_animation (Cop33, Cop34)}.asm`.

## Read first

- [x] `gaia-core/docs/notes-and-comments.md` (Notes Merge, Names Merge), `gaia-core/docs/rom-mapping-guide.md`
- [x] `gaia-knowledge/curated/gaialabs/code-bank-documentation.md` (skeleton, Three Questions)
- [x] `plans/mapping/mapping-action-plan.md` section 0 and 8c-8e, `plans/doc-audit/README.md`, `docs/walkthrough/README.md` and the pages for the terms used (`02-grass-valley.md` crab-walk, `08-world-of-evil.md` Phoenix, `items.md`, `magic.md`, `level-up.md`)
- [x] `docs/code/actor-system.md`, `docs/code/collision-and-physics.md`, `docs/code/boot-nmi-main-loop.md`, `docs/code/cop-dispatch.md`, `docs/cop/index.md` (style and overlap: link, do not repeat), `plans/doc-audit/function-map/FM-A10.md` (the earlier player analysis)
- [x] Fresh `npm run extract:lt`; the files above read

## Analysis findings to settle before writing

- [x] One hero actor and five helpers; spawn order and run order (`InitPlayerActor`; `actor-system.md` worked example); the return-trip variant
- [x] The script runs once per animation step (`Cop82_WaitAnimationDone`); walk steps 6 x duration 3, 2 px per frame in all six; `FilterPlayerInput` cuts in through `$18`
- [x] `FilterPlayerInput` order: hidden count, no weapon / no-combat, Gem pull, weapon level gate on B only, `$14`-`$23` protected, B interrupts, dying, `AnimKeepKeyMask`
- [x] `ChoosePlayerAction`: unarmed and armed paths, direct walk priority Right, Left, Down, Up, table path, the carry (clear `$00`-`$13`, set `$24`-`$2B`)
- [x] `PlayerActionTable`: 44 x 6 words, facing-only rows, rows `$14`-`$1F` all `StartIdleUp`; the 28 handlers in five groups; backstep and sidestep naming checked against `PlayerFacingByAnim` and `PlayerMoveDirByAnim` (existing backstep notes wrong)
- [x] Animation data: ids `$14`-`$1F` (idle leaves held 60 frames, three-step slides, death shape), swings 3 / 1 / 8, carried-sword poses, frame leaf header words `$10` / `$12` = 16 / 16 in all 164 hero leaves, the blade's 8 x 8 leaves
- [x] Swings, `PayPhoenixCost`, the four Phoenix shots and `InitPhoenixProjectile`; the blade layer and why the blade (not the hero) is the hit source
- [x] `FinishPlayerMove` wiring only (the mechanics are in `collision-and-physics.md`); the hero's hurt box in `DetectPlayerContact`
- [x] Gem pull: standing armed hero, pickups with `$4000` and animation `$04`-`$06`, 17 px lane, 3 / 2 / 1 px; return trip facing by the dominant axis
- [x] Death: `CheckPlayerDeath` items and ids against the walkthrough grid, `MarkPlayerDead`, `PlayPlayerDeath` banks and `scene_next`
- [x] Orb and controller (steering point, pull distances, sine orbit), `DispatchSpellCast` refusals, cost table with Magic Bell and Magic Armor, cast-actor `$16` values, the seven spells, the cast lock
- [x] `WatchForLevelUp`: threshold layout, BCD level, even / odd stat, HP cap 100, banner timing; `level_power` has one writer and `InitFixedState` does not set it
- [x] Bank-04 helpers: `ApplyPlayerWeaponPose`, `GetPlayerFacing`, `FlipActorX`, pending heal and EXP, `AddExp`, `AddGems`, `SubtractGems`
- [x] Walkthrough cross-check: crab-walk, weapon levels, level table and caps, spell costs, Phoenix gear, Medical Herb, Strange Bottle, Magic Bell, orb; DISCREPANCY rows OQ-I032-3 and OQ-I032-8 repeated, new OQ-I048-5 (spelling)

## Plan

### A. Document

- [x] A1 `docs/code/player.md`: breadcrumb, source links, overview with one diagram (at most 15 nodes), memory-map tables, `###` sections that pass the Three Questions, walkthrough cross-check, Open questions, See Also
- [x] A2 One See Also line each in `actor-system.md`, `collision-and-physics.md` and `boot-nmi-main-loop.md`
- [x] A3 Every backticked identifier exists in `extracted/` or `us/names/`, every relative link resolves (the hub `README.md` excepted, as in I043-I047)

### B. Notes and names

- [x] B1 `edits/I048.json`: six part-note corrections found while writing (four `StartBackstep*`, `StartIdleUp`, `RunSoulOrbController`); no rename

### C. Records and gate

- [x] C1 `plans/extracted-audit/questions/I048_questions.md`
- [x] C2 Gate: `extract:lt`, `rebuild` (SHA-1 `040a408a...`), `names -- --check`, `merge -- --check`
- [x] C3 `plans/extracted-audit/results/I048_results.md` with the suggested commit message

## Progress

- Read-and-verify phase finished (see the findings above); `npm run rebuild` baseline recorded (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`); no file was edited before the read phase ended.
- A: `docs/code/player.md` written (370 lines, 1 mermaid diagram of 13 nodes, 27 `###` sections, 191 distinct backticked identifiers all found; every relative link resolves except the hub `README.md`). Corrected while checking: the weapon overlay has 42 leaves (41 of them 8 x 8); `Cop33` and `Cop34` cited with their full names. See Also lines added in `actor-system.md`, `collision-and-physics.md` and `boot-nmi-main-loop.md`.
- B: `edits/I048.json` dry-run, applied (`partNotes/bank00.json`, 6 part notes).
- C: questions (6), gate and results file done. Gate: `extract:lt` OK, `rebuild` SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` unchanged, `names -- --check` OK (2765 names), `merge -- --check` OK (0 errors, 0 warnings, 0 orphans).
