# I049 checklist: docs/code/combat-damage-and-enemy-records.md

Topic: combat, damage and enemy records. `<files>` was not given, so the files are chosen like in I043-I048.

Rules in force: notes and comments change only through `npm run merge`, names only through `npm run names`; no ad-hoc scripts; no commits; no comparison of the original ROM with the rebuilt ROM; every claim cites a label; the walkthrough is the source of truth for game names, the ROM text for exact spelling and behaviour; every mismatch is an OQ with tag DISCREPANCY.

## Scope

Files (all under `extracted/`):

- `system/engine_combat_hits.asm` (the hit pipeline, `$00:8A34`-`$8F27`)
- `system/WorldMetaPointers.asm` (the 469 meta rows, `$01:8000`)
- `system/engine_spawn_lairs_death_drops.asm` (`RunEnemyDeath`, `RunBossDeath`, the Gem pickups, `ApplyGemPickup`, `RunHazardPuff`)
- `system/engine_player_death_and_actor_helpers.asm` (`DestroyHazardsNearOrb`)
- `system/engine_actor_scheduler_and_sprites.asm` (hit-stun lines of `RunActorList`, the flash in `BuildActorSprites`)
- `system/player_spells_level_up.asm` (the `$30` damage byte of each spell, read only)
- `library/lib_hud.asm` (`UpdateHud`, `EnemyGaugeText`), `library/lib_player_helpers.asm` (`AddExp`, `AddGems`), `library/lib_menus.asm` (`RecalcGearStats`, `GearStatTable`)
- `cop_handlers/cop_items_stats_text.asm` (`Cop39_DamagePlayer`) and the six scripts that call it
- enemy and boss scripts only where they set `$16` or `$1A` bits

Not repeated (already in the spokes): `PublishPlayerAnim` numbers, `CheckPlayerDeath`, the Phoenix shot and spell costs, `WatchForLevelUp` (player.md); lair scripts, `RespawnOrKillActor` mechanics, the scheduler (actor-system.md); tile collision (collision-and-physics.md).

## To do

- [x] Read the conventions: notes-and-comments.md, rom-mapping-guide.md, code-bank-documentation.md, mapping-action-plan.md, doc-audit README, walkthrough README and items, magic, level-up, enemy-bestiary and the chapters that name hazards.
- [x] Read every routine of the topic in the annotated asm (labels listed above).
- [x] Cross-check the 469 meta rows against the bestiary (HP, EXP) and the equipment table of `items.md`.
- [x] Find the stale notes (knock-back, `AddExp` callers, `$2E` Purple Bird) and the facts the old `$16` legend left open (`$0100`, `$0200`).
- [x] Write this checklist (before any edit).
- [x] Write `docs/code/combat-damage-and-enemy-records.md` in one Write call: breadcrumb, source links, overview with one mermaid diagram (at most 15 nodes), memory map (code, data, state), `###` sections that answer the Three Questions, walkthrough cross-check, open questions, See Also.
- [x] Write `plans/extracted-audit/edits/I049.json` (part-note and block-note corrections); `npm run merge -- ... --dry-run`, apply, `npm run extract:lt`.
- [x] Write `plans/extracted-audit/questions/I049_questions.md`.
- [x] Hand edits: `player.md` (the `AddExp` caller sentence and the planned-spokes line), `actor-system.md` (planned-spokes line, see also), `collision-and-physics.md` (see also).
- [x] Verify: every backticked identifier of the new document exists in `extracted/` or `us/names/`; every relative link resolves; line count 50-900; at most one mermaid diagram with at most 15 nodes.
- [x] Gate: `npm run extract:lt`, `npm run rebuild` (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1,081,344 bytes, checksum 110070696 unchanged), `npm run names -- --check`, `npm run merge -- --check`.
- [x] Write `plans/extracted-audit/results/I049_results.md` with the gate table and a suggested commit message.

## Progress

- Reading and cross-check done (see the ticked items).
- Checklist, `docs/code/combat-damage-and-enemy-records.md` (371 lines, 14-node diagram) and `edits/I049.json` written.
- Merge dry-run OK, applied (4 notes files; 5 part notes, 2 block notes), fresh `extract:lt` shows the new notes.
- `questions/I049_questions.md` written (OQ-I049-1 to OQ-I049-9).
- Hand edits done: `player.md` (`AddExp` callers, See Also, planned spokes), `actor-system.md` (death sentence, See Also), `collision-and-physics.md` (See Also).
- Verified: 142 identifiers found; relative links resolve except the hub `README.md`; one mermaid diagram.
- Gate passed: rebuild SHA-1 `040a408a...` unchanged, `names --check` OK, `merge --check` OK (0 errors, 0 orphans).
- `results/I049_results.md` written with the suggested commit message.
