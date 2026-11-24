# I044 results: `docs/code/actor-system.md` (slots, scheduler, spawn)

PD step of the plan "Blazer docs and analysis". The prompt left `<files>` empty; I chose the files that make up the topic (see Sources), as in I043. Work started from a fresh `npm run extract:lt`; the gate was run at the end.

## Deliverables

| File | What |
|------|------|
| `docs/code/actor-system.md` | New topic document (327 lines): breadcrumb, source links, overview with two mermaid diagrams (scene and frame lifecycle, the two list directions), memory-map table (code and state), 13 `###` sections (pool, list with the player-helper worked example, `RunActors`, `RunActorList`, script contract, `StepActorMotion`, `CullAndSortActors`, scene spawn, lairs, script spawns, full pool, kills, respawn), walkthrough cross-check, open questions, See Also. |
| `plans/extracted-audit/edits/I044.json` | Merge spec: find/with edits of block notes, part notes and comments in 6 extracted files (see Findings). |
| `plans/extracted-audit/renames/apply-I044_names.json` | 44 sub-label renames (`loc_xxxxxx` to descriptive names) in the scheduler, the spawn code, `cop_core`, `cop_tiles_spawn_kill` and the kill and respawn code; applied with `npm run names`. |
| `plans/extracted-audit/questions/I044_questions.md` | OQ-I044-1 to OQ-I044-7. |
| `plans/extracted-audit/results/I044_results.md` | This file. |
| `docs/wram-memory-map.md` §4, `docs/cop/index.md` §2 and §4.7, `docs/code/boot-nmi-main-loop.md` (See Also) | Edited by hand (no notes, comments or names): the same link-direction corrections, and the link to the new document. |

Sources documented: `engine_actor_scheduler_and_sprites` (`RunActors`, `RunActorList`, `StepActorMotion`, `CullAndSortActors`; the sprite routines only as pointers), `engine_spawn_lairs_death_drops` (`InitActorPool`, `SpawnSceneActors`, `SpawnPlacementList`, `InitActorFromPlacement`, `SpawnLairActor`, `SpawnLairMonster`, `RunMonsterAppearPuff`, `LoadMonsterFromMeta`, `KillAllOtherActors`, `KillAllProjectiles`, `RespawnOrKillActor`), `cop_core` (`PopFreeSlot`, `SpawnActorAfter`, `SpawnActorBefore`, `InitSpawnedActor`, the exit chain), `cop_tiles_spawn_kill` (spawn and kill commands), `cop_script_flow_flags` and `cop_conditions` (the yield commands, `CopAD_WaitUntilOnScreen`), the placement, meta and lair data files, `InitSceneState`, `ApplyLairStatesToScene` and `InitPlayerActor`. Left to later spokes: drawing and animation (`BuildOamFromActors`, `BuildActorSprites`, `SetActorAnimFrame`), hit rules, the death sequence and drops, the lair scripts' details and the scene loader.

## Findings

1. **The `$3C` / `$3E` direction was documented backwards.** `RunActors` loads `actor_list_tail` and `NextActor` loads `$3E`, so run order is tail to head along `$3E`; `CullAndSortActors` walks head to tail along `$3C`. The notes (and `docs/cop/index.md`, `docs/wram-memory-map.md`) called `$3C` "next" and `$3E` "previous". Consequence found in the code: `SpawnActorAfter` (new `$3E` = X, X `$3C` = new) puts the new actor **before** its caller in run order, so it first runs next frame; `SpawnActorBefore` puts it right **after** the caller, so it runs in the same frame. The old notes said "after = later" and "an actor linked before X runs earlier", both wrong. The run order of the player helpers in the `player_core` block note (`WatchForLevelUp`, `RunSoulOrb`, `FilterPlayerInput`, hero, `RunWeaponLayer`, `FinishPlayerMove`) agrees with the new reading and is the worked example in the document. Corrected through `merge`: `cop_core` block note and `SpawnActorAfter` part note, `cop_tiles_spawn_kill` block note, `Cop84`/`Cop85` part notes and the comment at `Cop86_KillSelf`, `engine_actor_scheduler_and_sprites` block note ("a new actor is linked in as the new head" was true only for the placement list), and the "`$3C` is the next-actor link" wording in `se_obj_pearl_ride_out_0F8FAB` (note and comment). The handler names themselves still say "after" and "before": OQ-I044-4 (decision).
2. **`$1A` bit `$1000` is never set, so the respawn branch of `RespawnOrKillActor` is dead by static reading.** `rg` over `extracted/` finds stores into `$1A` only of `$0080`, `$0100`, `$0200`, `$0400`, `$0800`, `$2000`, `$4000`, `$8000`; `InitSpawnedActor` zeroes the field. The part note and the block note now say so (OQ-I044-6).
3. **"The first row of every list is the hero" was wrong for 4 of 97 lists.** 93 rows have meta type 0; `PlacementA00S09` starts with type `$53`, and `PlacementA00S0A`, `PlacementA00S0B`, `PlacementA00S0C` have one row each (types `$56`, `$57`, `$5B`). The block note said 97 hero rows and 816 actors; now 93 and 820 (OQ-I044-5).
4. **Free-slot stack end.** The empty test of `PopFreeSlot` reads the word at `dp$4A`; after 64 pops that is `$1880`, which nothing in `extracted/` writes (OQ-I044-2). `PopFreeSlot` clears the stack entry, not the slot.
5. **Full pool.** The COP spawn handlers ignore the carry of `PopFreeSlot` and write into scratch slot `$06AA`; only the lair scripts test `LDA ($4A)` first (OQ-I044-3).
6. **Scheduler details recorded.** The script is called by `RTL` with `StepActorMotion − 1` pushed first; `$14` is cleared before each run, so a script that sets nothing runs every frame; hit stun freezes an actor only when `$1A` bit `$0040` is set; `InitSpawnedActor` clears `$16` bit `$0010`, so clones do not run in sub-frames unless their script sets it again (`RunAppearPuff` does); a script that kills its own actor still passes once through `StepActorMotion`.
7. **Walkthrough cross-check:** no mismatch (no DISCREPANCY). Terms checked: Monster Lair and green switch, one by one, a single group, a lair that waits for the hero, monsters that leave the screen.

## Open questions

OQ-I044-1 (why two `RunActors` passes in `InitSceneState`), OQ-I044-2 (free-stack end marker `$1880`), OQ-I044-3 (does the pool ever fill), OQ-I044-4 (rename the "after"/"before" handlers; decision), OQ-I044-5 (the four lists without a hero), OQ-I044-6 (`$1A` bit `$1000`), OQ-I044-7 (a clone inherits the lair slot `$32`). Details and Mesen2 tools in `questions/I044_questions.md`. Statements in the document that rest on static reading say so.

## Not done / follow-ups

- The breadcrumb links to `docs/code/README.md`, which does not exist yet (the hub is a later PD step); the link is dead until then, as in I043.
- Renames: only sub-labels that the document cites were renamed (44). The `RequireLairTile`, `SyncLairCount`, lair-script and `NotifyLairOfDeath` sub-labels (`loc_00285E`, `loc_0028D4`, `loc_0026F6`, `loc_002701` and the like) are still `loc_xxxxxx`; they belong to the lair and combat spokes.
- Counts in the `cop_core` and `cop_tiles_spawn_kill` notes ("13 scripts", "346 scripts", ...) were copied into the spawn table, not re-counted.
- No Mesen2 run was made; claims about timing and pool use are static.

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK (fresh before the work, again after the names and merge steps and at the end) |
| `npm run names -- apply-I044_names.json --dry-run`, then applied | 44 renames, `bank00.json` only |
| `npm run merge -- plans/extracted-audit/edits/I044.json --dry-run`, then applied | 6 extracted files, 5 notes files changed (`blockNotes/bank00`, `partNotes/bank00`, `partNotes/bank0F`, `comments/bank00`, `comments/bank0F`); the changes show in `extracted/` |
| `npm run rebuild` | OK, SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1081344 bytes: unchanged (annotation and rename only) |
| `npm run names -- --check` | OK (2737 names) |
| `npm run merge -- --check` | OK: 1397 comments, 1684 part notes, 135 block notes; 0 errors, 0 warnings, 0 orphans, 0 duplicate keys |
| Links in the new document | all relative targets exist except the hub `README.md` (see above) |

No original-versus-rebuilt ROM comparison was made; the SHA-1 is the one recorded for the rebuilt ROM.

## Suggested commit message

```
docs: add code doc for the actor system (I044)

- docs/code/actor-system.md: slot pool, actor list, RunActors and
  RunActorList, CullAndSortActors, placement, lair and script spawns,
  kills, respawn
- notes: correct the $3C/$3E direction (run order is tail to head along
  $3E; SpawnActorAfter runs before its caller), the placement-list hero
  claim (93 of 97 lists) and the respawn note (no code sets $1A bit $1000)
- names: 44 sub-labels of the scheduler, spawn, kill and respawn code
- docs: wram-memory-map, cop/index and boot-nmi-main-loop follow the
  corrected link direction
- plans: I044 edits, renames, questions OQ-I044-1..7, results
```

Please commit when you're ready.
