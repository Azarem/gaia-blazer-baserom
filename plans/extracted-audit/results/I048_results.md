# I048 results: `docs/code/player.md` (the hero)

PD step of the plan "Blazer docs and analysis", topic "player". The prompt left `<files>` empty; I chose the files that make up the topic (see Sources), as in I043 to I047. Work started from a fresh `npm run extract:lt`; the gate was run at the end. The plan checklist is `plans/doc-audit/I048_checklist.md`.

## Deliverables

| File | What |
|------|------|
| `docs/code/player.md` | New topic document (370 lines): breadcrumb, source links, overview with one mermaid diagram (13 nodes), memory-map tables (code, data, state), 27 `###` sections (spawn, one script step per animation step, `FilterPlayerInput`, `AnimKeepKeyMask`, `ChoosePlayerAction` and the carry, `PlayerActionTable`, the 28 pose handlers, animation ids no handler plays, swings and the Phoenix shot, the blade layer, finishing the move, the Gem pull, the return trip, `CheckPlayerDeath`, `PlayPlayerDeath`, the orb and its controller, `DispatchSpellCast`, the seven spells, the cast lock, `WatchForLevelUp`, weapon level and stats, pending heal and EXP, `ApplyPlayerWeaponPose`, `GetPlayerFacing` and `FlipActorX`), a walkthrough cross-check table, open questions and See Also. |
| `plans/extracted-audit/edits/I048.json` | Merge spec: six part-note corrections (the four `StartBackstep*` notes, `StartIdleUp`, `RunSoulOrbController`). |
| `plans/extracted-audit/questions/I048_questions.md` | OQ-I048-1 to OQ-I048-6 (five GAP, one DISCREPANCY). |
| `plans/extracted-audit/results/I048_results.md` | This file. |
| `plans/doc-audit/I048_checklist.md` | The checklist with its progress section. |
| `docs/code/actor-system.md`, `docs/code/collision-and-physics.md`, `docs/code/boot-nmi-main-loop.md` | One See Also line each. Edited by hand; no notes, comments or names. |

Sources documented: `player_core` (all parts: `FilterPlayerInput`, `AnimKeepKeyMask`, `PullGemsToPlayer`, `PullGemTowardPlayer`, `FacePlayerTowardReturnTarget`, `InitPlayerActor`, `ChoosePlayerAction`, `PlayerActionTable`, the 28 pose handlers, `PlayPlayerDeath`, `PayPhoenixCost`, `PublishPlayerAnim`, the four Phoenix shots; `FinishPlayerMove`, `ScanPushZones` and `SlideAroundCorner` only as wiring, with a link), `player_spells_level_up` (blade layer, orb, controller, `DispatchSpellCast`, the seven spells, `EndSpellActor`, `WatchForLevelUp`), `lib_player_helpers`, `CheckPlayerDeath` and `MarkPlayerDead` (`engine_player_death_and_actor_helpers`), the player tables of `data_engine_tables`, the three player animation banks, the hero entries of `WorldMetaPointers`, and the player-related COP handlers (`Cop26_PayGemsOrJump`, `Cop37_HealPlayerToFull`). Not written here: damage and hit rules (`engine_combat_hits` is only the boundary), the status and equipment menus, `DestroyHazardsNearOrb`, the camera.

## Findings

1. **The hero is six actors.** `InitPlayerActor` clones `WatchForLevelUp`, `RunSoulOrb` (which spawns `RunSoulOrbController`), `FilterPlayerInput`, `FinishPlayerMove` and `RunWeaponLayer` from the hero; run order `WatchForLevelUp`, `RunSoulOrb`, `RunSoulOrbController`, `FilterPlayerInput`, hero, `RunWeaponLayer`, `FinishPlayerMove`. With `return_active` only the watcher is spawned and the hero becomes `FacePlayerTowardReturnTarget`.
2. **The script runs once per animation step.** Walk steps are six of duration 3 with 2 pixels per frame in all six (statically confirms the data side of OQ-I032-15); `FilterPlayerInput` writes `ChoosePlayerAction` into `$18` to cut a step short.
3. **The carry is the armed/unarmed switch.** Clear = pose family `$00`-`$13`, set = `$24`-`$2B` (sword carried). The direct walks get the carry from the key test itself; the armed table path sets it only without L or R. By `ApplySwordHit` only animations below `$24` can hurt (OQ-I048-4).
4. **`PlayerActionTable` depends only on the facing.** Rows `$14`-`$1F` are all `StartIdleUp`; the 28 handlers are paired by the carry. A backstep keeps its facing and moves the opposite way (corrected in four notes).
5. **Animation data not played by any routine** (OQ-I048-2): `$14`-`$17` idle leaves held 60 frames, `$18`-`$1B` three-step slides of 8, 5, 3 pixels per frame (32 pixels), `$1D`-`$1F` the shape of the death animation. Extends OQ-I032-2.
6. **The blade is the hit source** (static reading, OQ-I048-6): the hero has `$0100` set and cannot be a source, the blade clears it.
7. **Answer to OQ-I047-3 for the hero.** Header words `$10` and `$12` are 16 and 16 in all 100 leaves of `PlayerAnims` and all 64 of `PlayerUnarmedAnims`; the blade's leaves are 8 × 8 (41 of 42). The hero's hurt box is a fixed box in `DetectPlayerContact`, not the frame.
8. **Death and items.** `CheckPlayerDeath` tests Medical Herb `$38`, Strange Bottle `$39`, Magic Bell `$40`, else `ZeroGemsAndDie`; the ids match the walkthrough's grid. `PlayPlayerDeath` forces banks `$0B` and `$0C` because the unarmed bank has no animation `$1C`.
9. **Spells.** Gate refusals in order (`no_combat_scene`, `subframe_active`, no magic, empty actor stack), `spell_active_count` lock, costs and projectile damage bytes in one table; the Gem costs and behaviors agree with `magic.md` except the Spark Bomb angle (OQ-I032-3). Tornado heading restart is always down-left (OQ-I032-6).
10. **Level-up.** Thresholds are two big-endian BCD words per level, high word first; 49 of 49 walkthrough thresholds agree; `level_power` and `level_defense` have one writer and no cap (OQ-I032-8, DISCREPANCY); their starting values are not set by `InitFixedState` (OQ-I048-1).
11. **Part-note errors corrected with `merge`:** the four `StartBackstep*` notes said "moving down/up/right/left backwards" (they face that way and move the other way); `StartIdleUp` called the hero "Blazer" and cited the planning file FM-A10; `RunSoulOrbController` said it runs "just before the orb" (spawned with `COP 85`, it runs right after, as `actor-system.md` derives).
12. **Counts recorded:** 28 pose handlers, 44 rows × 6 words, 191 distinct backticked identifiers, 13 diagram nodes.

## Open questions

OQ-I048-1 (starting `level_power` and `level_defense`), OQ-I048-2 (what plays `$14`-`$1B` and `$1D`-`$1F`), OQ-I048-3 (derived walk, swing and death timings), OQ-I048-4 (does the carried sword hurt), OQ-I048-5 (DISCREPANCY: "Defence" on the status screen against "Defense" in the walkthrough), OQ-I048-6 (the blade as the only hit source). Details and Mesen2 tools in `questions/I048_questions.md`. Existing DISCREPANCY rows the document repeats: OQ-I032-3 and OQ-I032-8.

## Not done / follow-ups

- The breadcrumb links to `docs/code/README.md`, which does not exist yet (the hub is a later PD step); the link is dead until then, as in I043 to I047. **The hub should link this document and should not repeat the action table or the spell table.**
- `ApplySwordHit`, `ApplyProjectileHit`, `GearStatTable` and `RecalcGearStats` are only named; combat and damage is a separate spoke. The status and equipment menus likewise.
- No Mesen2 run was made; every claim that rests on static reading is marked or carries an OQ.
- The 191 identifiers include WRAM names that exist only as `!` definitions; they were checked against `extracted/` and `us/names/` as whole words.

## Gate

| Check | Result |
|-------|--------|
| `npm run rebuild` at the start | SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1081344 bytes, checksum 110070696 |
| `npm run extract:lt` | OK (fresh before the work and after the merge) |
| `npm run merge -- plans/extracted-audit/edits/I048.json --dry-run`, then applied | 1 notes file changed (`partNotes/bank00`), 6 part notes updated |
| `npm run rebuild` at the end | OK, SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1081344 bytes, checksum 110070696: unchanged (annotation only) |
| `npm run names -- --check` | OK (2765 names; no rename in this step) |
| `npm run merge -- --check` | OK: 1401 comments, 1684 part notes, 135 block notes; 0 errors, 0 warnings, 0 orphans, 0 duplicate keys |
| Backticked identifiers of the new document | 191 distinct, each found in `extracted/` or `us/names/` |
| Links in the new document | all relative targets exist except the hub `README.md` (see above) |

## Suggested commit message

```
docs: the hero (I048)

Add docs/code/player.md: the six actors of the hero and their frame order,
the one-step-per-animation script, FilterPlayerInput and AnimKeepKeyMask,
ChoosePlayerAction with the carry, PlayerActionTable and the 28 pose
handlers, swings and the Phoenix shot, the blade layer, the Gem pull, the
return trip, CheckPlayerDeath and PlayPlayerDeath, the soul orb, the spell
gate and the seven spells with the cast lock, WatchForLevelUp and the
bank-04 helpers, and a walkthrough cross-check. Correct six part notes
(backstep wording, hero name, orb controller order). Add I048 questions
(one DISCREPANCY: "Defence" spelling), results and checklist. ROM SHA-1
unchanged.
```

Please commit when you're ready.
