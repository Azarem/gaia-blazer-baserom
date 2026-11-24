# I040 results (PC annotate actor batch world_of_evil)

## Scope

The five actor and enemy files of group `world_of_evil`: the Master's shrine event (`w6_actor_01EC4B`), the Phoenix-call scene, the Dazzling Space hazard and the two scroll effects (`we_evil_world_actors`), the Mage and the Demon of Deathtoll's shrine with the ending curtain (`we_deathtolls_shrine_actors`), the band effect of the final battle (`w6_actor_01F14F`) and the six monster types of the outdoor areas (`we_evil_world_enemies`).

## Depth

Actors, light: a name from the walkthrough or the meta type, a block note (roster, trigger, flags, dialogue, open points) and a part note per actor root with When / Sees / Why / In / Out / Clobbers. Comments only where the logic is not obvious (flags, counters, the boss hand-over, HDMA tables); every comment has an `expect` guard.

## Counts

| | Before | After |
|-|-------:|------:|
| Names | 2457 | 2587 (+130) |
| Part notes | 1458 | 1588 (+130) |
| Block notes | 136 | 141 (+5) |
| Comments | 1297 | 1365 (+68) |
| Mnemonics (by hand) | - | 0 |

(130 / 130 / 5 / 68 are exactly the sums of the three name specs (17 + 51 + 62) and the four merge specs (parts 7 + 10 + 51 + 62, block notes 1 + 2 + 1 + 1, comments 10 + 14 + 30 + 14).)

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK |
| `npm run rebuild` | OK, SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, unchanged |
| `npm run names -- --check` | OK (2587 names) |
| `npm run merge -- --check` | 1365 comments, 1588 part notes, 141 block notes against 151 extracted files; errors 0, warnings 0, orphans 0, duplicates 0 |

## Main findings

- **The Master's shrine** (`we_obj_master_shrine_event_01EC4B`) has three branches on the event flags `$1F02`-`$1F05`; it sets `$1F04`, which the hub in Grass Valley tests. The hub parts are misnamed `post_ending` (OQ-I040-1).
- **Deathtoll's Mage:** a state machine of warp, hit window (about 80 frames), orbs and hide; it takes `boss_actor`, and on death hands it to the speech actor (`we_boss_deathtoll_mage_handover`), so `RunBossDeath` skips its clean-up and `RunEnding` for the Mage and the fight continues in A15S02. ROM HP 99 against the walkthrough's 100 (OQ-I040-2).
- **Deathtoll's Demon:** waves of 4 fire pillars (HP byte `$FF`, destroyed below `$FC`), a counter in the low byte of `event_flags`; at 4 the Demon can be hit until it fires three fireballs and sets `$0200` again; the scepters and lasers choose their direction with flags `$1906` / `$1907`. The pillar gem pickup answers the pattern question of OQ-I038-8 (OQ-I040-10).
- **Ending curtain:** `we_fx_ending_tm_curtain_0055C6` survives `KillAllOtherActors` (`$16` bit `$0010`) and switches its TM table when `RunEnding` increments `$0466` (OQ-I040-3; partial answer to OQ-I034-16).
- **Outdoor monsters:** Purple Bull (row / column mode, four shots), Firefly (eight invulnerable dashes), Wall Tile (immune class `$0200`, bounces between walls), pop-up turret (deletes itself when its wall tile type is 0), arc jet (seven flames on a half-sine) and an empty static hazard type with 12 placements. Placement counts and lair records are in the block note.
- **Discrepancies (never resolved by invention):** hub parts called `post_ending` (OQ-I040-1); Mage HP 99 against 100 (OQ-I040-2). The Purple Bull's 45 HP against the bestiary's 23 is the older OQ-I033-2.
- **Not named on purpose:** `$0466` (see above); the block names `w6_actor_01EC4B` and `w6_actor_01F14F` are still the engine's scaffold names; a rename needs `npm run blocks` (decision for the user).

## Corrections made while writing

- The Demon's wave is 4 pillars (the `COP 03` operand), not 5; the notes say 4.
- `COP 07` with operand bit 15 clear jumps when the flag is clear, so the gate speech runs while `$1F03` is clear; the notes were written with that reading.
- Frame counts follow the `COP 1B` operand (N frames), not N + 1; the specs were corrected before the merge.
- The first comment pass of the Deathtoll file was cut from 65 to 30 comments to keep the light depth.

## Files changed (not committed)

- `plans/extracted-audit/renames/apply-I040a_names.json` to `apply-I040c_names.json`
- `plans/extracted-audit/edits/I040a.json` to `I040d.json`
- `plans/extracted-audit/questions/I040_questions.md`, `plans/extracted-audit/results/I040_results.md`, `plans/doc-audit/I040_checklist.md`
- Tool output: `us/names/bank00.json`, `bank01.json`, `bank0F.json`, `us/blocks.json` (part and block references), `notes/blockNotes|partNotes|comments/bank00.json`, `bank01.json`, `bank0F.json`, `extracted/**` (from `extract:lt`: run `npm run extract` before committing if the `; {n}` tags are not wanted). The working tree also holds changes of other batches that are not part of this step.

## Open questions

14 rows in `questions/I040_questions.md` (`OQ-I040-1` to `-14`; DISCREPANCY on -1 and -2).

## Suggested commit message

```
Annotate actor batch world_of_evil (I040)

Name and document the 5 actor and enemy files of world_of_evil: the
Master's shrine event, the Phoenix-call scene, the Dazzling Space
hazard, the BG2 effects, Deathtoll's Mage and Demon with the ending
curtain, and the Purple Bull, Firefly, Wall Tile, pop-up turret and
arc jet. 130 names, 5 block notes, 130 part notes, 68 comments.
ROM SHA-1 unchanged. Open questions in OQ-I040-1 to -14.
```

Please commit when you're ready.
