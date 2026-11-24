# I040 checklist (PC annotate actor batch world_of_evil)

Scope: the 5 actor and enemy files of group `world_of_evil`: `up_above/w6_actor_01EC4B.asm` (the Master's shrine event), `deathtolls_shrine/w6_actor_01F14F.asm` (the final battle's BG2 effect), `deathtolls_shrine/we_deathtolls_shrine_actors.asm` (the Mage, the Demon and the ending curtain), `evil_world/we_evil_world_actors.asm` (the Phoenix-call scene, the Dazzling Space hazard, two BG2 effects) and `evil_world/we_evil_world_enemies.asm` (Purple Bull, Firefly, Wall Tile, pop-up turret, arc jet, static hazard).

Rules for this iteration: names only through `npm run names`, notes and comments only through `npm run merge`, both dry-run first; hand edits only in `us/mnemonics.json` (no tool exists); no ad-hoc scripts; no commits; the original ROM is never compared with the rebuilt ROM. The walkthrough is the source of truth for game names, the ROM text for exact spelling; mismatches are logged as `DISCREPANCY` questions. Light depth for actors: a name, a block note (role, trigger, flags, dialogue) and a part note per actor root; comments only for non-obvious logic.

## Progress

- [x] Read the conventions, the five files, `WorldMetaPointers` (`MetaWorldOfEvil`), the placements A14S01-A15S02, the lair records `$196`-`$1A3`, the walkthrough chapter 8 and the bestiary
- [x] Names specs `renames/apply-I040a..c_names.json` (130 names): dry-run, apply, `names -- --check`, `extract:lt`
- [x] Merge specs `edits/I040a..d.json` (5 block notes, 130 part notes, 68 comments): dry-run, apply, `extract:lt`
- [x] Mnemonics (`us/mnemonics.json`): none added. `$0466` is read by the curtain actor and incremented by `RunEnding` but is shared with other files (OQ-I040-3, OQ-I034-16)
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, unchanged), `names -- --check` (2587 names), `merge -- --check` (errors 0, warnings 0, orphans 0)
- [x] Questions `questions/I040_questions.md` (OQ-I040-1 to -14)
- [x] Results `results/I040_results.md` with the suggested commit message (nothing committed)
