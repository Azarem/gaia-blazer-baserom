# I025 checklist: annotate batch A3 (`cop_handlers`, `cop_core` exit chain, music load chain)

Plan: `c:\Users\azare\.cursor\plans\blazer_docs_and_analysis_e740ea3f.plan.md`, step PC for batch A3. Full depth (core code, not actors).

Rules for this iteration: names only through `npm run names`, notes and comments only through `npm run merge`, both dry-run first; hand edits only in `us/mnemonics.json`, `docs/cop/index.md` and `docs/wram-memory-map.md`; no ad-hoc scripts; no commits.

## Where the A3 rows live

| File | Content | Block note |
|------|---------|------------|
| `extracted/cop_handlers/cop_script_flow_flags.asm` | flow, flags, scene, random, music commands | new |
| `extracted/cop_handlers/cop_items_stats_text.asm` | items, Gems, EXP, HP, text, menus | new |
| `extracted/cop_handlers/cop_conditions.asm` | conditional jumps on actors, player, screen | new |
| `extracted/cop_handlers/cop_actor_fields_animation.asm` | position, animation, flip, draw order, player actors | new |
| `extracted/cop_handlers/cop_tiles_spawn_kill.asm` | footprint, tile tests, spawn, kill | new |
| `extracted/system/cop_core.asm` | exit chain, `CopB2_SpawnBeforeRelative` | rewritten |
| `extracted/system/engine_spawn_lairs_death_drops.asm` | `MusicLoad*` chain, `RespawnOrKillActor` | extended |

## Checklist

- [x] Read: `notes-and-comments.md`, `rom-mapping-guide.md`, `code-bank-documentation.md`, `mapping-action-plan.md`, `plans/doc-audit/README.md`, `docs/walkthrough` (items, In the Beginning), `docs/cop/index.md`, I024 files, the handler files, `lib_player_stats`, `lib_012281`, `lib_system_helpers`, `lib_tile_triggers_and_lair_return`
- [x] Baseline: fresh `npm run extract:lt`, `npm run rebuild`, SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`
- [x] Names spec `plans/extracted-audit/renames/apply-I025_names.json`; dry-run; apply; `npm run extract:lt`
- [x] Mnemonics in `us/mnemonics.json` for the names with evidence; evidence in `docs/wram-memory-map.md` section 7d
- [x] Merge specs `plans/extracted-audit/edits/I025.json` and `I025b.json`: block notes, part notes (In / Out / Clobbers + When, Sees, Why), comments with `expect` guards
- [x] `npm run merge -- <spec> --dry-run`; apply; `npm run extract:lt`; read the result
- [x] `docs/cop/index.md` corrected by hand
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 unchanged), `names -- --check`, `merge -- --check`
- [x] `plans/extracted-audit/questions/I025_questions.md` (`OQ-I025-1` to `-11`)
- [x] `plans/extracted-audit/results/I025_results.md` with a suggested commit message
