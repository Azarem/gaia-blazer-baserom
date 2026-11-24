# I049 results: `docs/code/combat-damage-and-enemy-records.md` (combat, damage and enemy records)

PD step of the plan "Blazer docs and analysis", topic "combat, damage and enemy records". The prompt left `<files>` empty; I chose the files that make up the topic (see Sources), as in I043 to I048. Work started from a fresh `npm run extract:lt`; the gate was run at the end. The plan checklist is `plans/doc-audit/I049_checklist.md`.

## Deliverables

| File | What |
|------|------|
| `docs/code/combat-damage-and-enemy-records.md` | New topic document (371 lines): breadcrumb, source links, overview with one mermaid diagram (14 nodes), memory-map tables (code, data, state), 18 `###` sections (the masks over `$16` and `$1A`, who the sword hits, what each weapon does, damage/stun/kill, the spell `$30` bytes and the Phoenix, when the hero is hurt, what the hit does, armor and bracelets, the six `Cop39_DamagePlayer` hazards, the Soul of Shield and the lava bombs, the 14-byte enemy record, bosses, the enemy gauge, `RunEnemyDeath`, boss death, EXP and Gems), a walkthrough cross-check table, open questions and See Also. |
| `plans/extracted-audit/edits/I049.json` | Merge spec: seven note corrections (five part notes, two block notes; see finding 9). |
| `plans/extracted-audit/questions/I049_questions.md` | OQ-I049-1 to OQ-I049-9 (seven GAP, two DISCREPANCY). |
| `plans/extracted-audit/results/I049_results.md` | This file. |
| `plans/doc-audit/I049_checklist.md` | The checklist with its progress section. |
| `docs/code/player.md`, `docs/code/actor-system.md`, `docs/code/collision-and-physics.md` | See Also lines and the planned-spokes lines; `player.md` also gets the `AddExp` caller fix. Edited by hand; no notes, comments or names. |

Sources documented: `engine_combat_hits` (all parts), the 469 rows of `WorldMetaPointers`, `RunEnemyDeath`, `RunBossDeath`, `FinishEnemyDeath`, the Gem pickups and `ApplyGemPickup` (`engine_spawn_lairs_death_drops`), `DestroyHazardsNearOrb` (`engine_player_death_and_actor_helpers`), the hit-stun and flash lines of the scheduler, the spell `$30` bytes (`player_spells_level_up`, read only), `UpdateHud` and the enemy gauge (`lib_hud`), `AddExp` and `AddGems`, `RecalcGearStats` and `GearStatTable` (`lib_menus`), `Cop39_DamagePlayer` and its six scripts. Not repeated: pose and spell code (`player.md`), lair scripts and the scheduler (`actor-system.md`), tile collision (`collision-and-physics.md`).

## Findings

1. **Three masks decide everything.** `DetectHitSourceCollisions` takes an actor that has `$16` bit `$0080` and none of `$0D00` as a source, a target must have none of `$EEC0`, and `DetectPlayerContact` skips actors with any of `$25C0`. `$0100` makes an actor inert, `$0200` makes it hurt without being hittable, `$0040` removes it from both scans. This answers OQ-I005-14 for `$0100` and `$0200`.
2. **Only swings hurt.** `ApplySwordHit` ignores the hit when player animation `$1E` is `$24` or more; every swing is below that (OQ-I048-4 stays open for the carried sword). The hit is also ignored while the hero is dying, and the scan runs only from `RunMainLoop`.
3. **Weapons.** Soul Blade (8) skips every class test; Psycho Sword (2) freezes the classes `$0E00` (not the boss) for 180 frames; Critical Sword (3) kills outright when `frame_counter` and `$0F` is 0 (not the boss); Recovery Sword (7) heals 1 HP per kill. Immunity classes in `$1A`: `$0800` spirit needs weapon 6, `$0400` metal needs weapon 5 or the hit is deflected (sound `$4C`), `$0200` special is ignored.
4. **Damage.** Sword: max(1, `attack_current` − the row's defence), doubled by the Power Bracelet or both bracelets, after the subtraction. The Phoenix: `gear_power` + `level_power` − defence, floor 1, never doubled. Contact: max(1, attack − 1 − `defense_current`), halved by the Shield Bracelet or both. The bracelets never change `attack_current` or `defense_current` (OQ-I049-2, DISCREPANCY with `items.md` and `level-up.md`).
5. **Contact.** Light Armor (`$0E`) blocks a hit whose floor(attack × 1.5) is below `defense_current`, with sound `$0C` and no stun (OQ-I049-4); stun is `$FFE0`, `$FFC0` with Mystic Armor (`$0D`); `contact_lock` disables contact; while the hero is stunned only pickups are tested. `Cop39_DamagePlayer` is fixed damage with no armor or bracelet test, called by six hazard scripts (five test an item first; the hot coals do not).
6. **The record.** A 14-byte row: attack, defence, HP (binary), EXP (BCD word), animation, flags, table, script; 469 rows in seven lists (95, 81, 87, 68, 55, 62, 21). A spawned shot copies `$38` from its spawner, so it hurts with the spawner's attack (OQ-I049-8). The enemy gauge shows for 128 frames after a hit that does not kill, except for `$16` bit `$0001`; locations `$0F` to `$12` have no HUD.
7. **Death.** `RunEnemyDeath` zeroes `$1A`, so `RespawnOrKillActor`'s respawn branch cannot be reached by an ordinary enemy (extends OQ-I044-6, now OQ-I049-7). Gem drops depend on `world_index` and the Lucky Blade; `RunBossDeath` makes 32 explosions, kills every other actor (`KillAllOtherActors`, mask `$24D0`) and starts `RunEnding` at `location_id` `$7D`.
8. **The lava bombs.** `DestroyHazardsNearOrb` (Soul of Shield) bursts actors whose `$16` is exactly `$0301` within `$30` pixels of the orb; the Durean lava bomb is the only such actor.
9. **Seven notes corrected with `merge`:** `ApplySwordHit` and `DetectHitSourceCollisions` ("knocked back": the hit stuns, it does not move the target); `AddExp` (its callers are in `engine_combat_hits`, not in the scheduler); `MetaGrassValley` (`$2E` is Monster Blocks, not a second Purple Bird); `mc_obj_floor_spikes_check_026F36` (knock-back wording); the block note of `engine_actor_scheduler_and_sprites` (the `$16` bits it called unexplained now are, with the rest pointing to OQ-I049-9); the block note of `se_st_elles_coast_enemies` (the pyramid `$30` inference is settled: `$FF`).
10. **Walkthrough cross-check.** All eight swords, the eight armors, the spell damage, the Lucky Blade, the Soul of Shield and the lava bombs agree with the walkthrough. Mismatches are OQ-I049-1 (Monster Blocks EXP 3 against 2), OQ-I049-2 (bracelets) and OQ-I049-3 (Phoenix on the final Deathtoll); the bosses' HP in the bestiary (70, 70, 80, 90) differs from the ROM rows (69, 79, 89, 99); the document lists both columns and does not pick one.
11. **Counts recorded:** 469 meta rows, 142 distinct backticked identifiers, 14 diagram nodes, 18 `###` sections.

## Open questions

OQ-I049-1 (DISCREPANCY: Monster Blocks EXP), OQ-I049-2 (DISCREPANCY: what the bracelets double), OQ-I049-3 (Phoenix damage on Deathtoll's final form), OQ-I049-4 (Light Armor block repeats), OQ-I049-5 (EXP words that are never paid), OQ-I049-6 (the EXP digit sprite map at `$7EF000`), OQ-I049-7 (dead respawn code), OQ-I049-8 (damage of enemy shots), OQ-I049-9 (`$16` bits `$0008` and `$0040`). Details and Mesen2 tools in `questions/I049_questions.md`.

## Not done / follow-ups

- The breadcrumb links to `docs/code/README.md`, which does not exist yet (the hub is a later PD step); the link is dead until then, as in I043 to I048. **The hub should link this document and should not repeat the damage tables or the hit-mask table.**
- No Mesen2 run was made; every claim that rests on static reading is marked or carries an OQ.
- The status and equipment menus (`RecalcGearStats` is only named), the sprite and animation tables, and the camera remain separate spokes.

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK (fresh before the work and after the merge) |
| `npm run merge -- plans/extracted-audit/edits/I049.json --dry-run`, then applied | 4 notes files changed (`blockNotes/bank00`, `blockNotes/bank0F`, `partNotes/bank00`, `partNotes/bank02`); 5 part notes and 2 block notes updated |
| `npm run rebuild` at the end | OK, SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1081344 bytes, checksum 110070696: unchanged (annotation only) |
| `npm run names -- --check` | OK (2765 names; no rename in this step) |
| `npm run merge -- --check` | OK: 1401 comments, 1684 part notes, 135 block notes; 0 errors, 0 warnings, 0 orphans, 0 duplicate keys |
| Backticked identifiers of the new document | 142 distinct, each found in `extracted/` or `us/names/` as a whole word |
| Links in the new document | all relative targets exist except the hub `README.md` (see above) |

## Suggested commit message

```
docs: combat, damage and enemy records (I049)

Add docs/code/combat-damage-and-enemy-records.md: the hit masks over $16
and $1A, the sword and each weapon's effect, spell and Phoenix damage,
contact damage with armor and bracelets, the Cop39_DamagePlayer hazards,
the Soul of Shield and the lava bombs, the 14-byte enemy record and the
469 rows, the enemy gauge, RunEnemyDeath, boss death, drops, EXP and
Gems, and a walkthrough cross-check. Correct seven notes (knock-back
wording, AddExp callers, Monster Blocks row, the $16 legend, the pyramid
damage byte). Link the new document from player.md, actor-system.md and
collision-and-physics.md. Add I049 questions (two DISCREPANCY rows),
results and checklist. ROM SHA-1 unchanged.
```

Please commit when you're ready.
