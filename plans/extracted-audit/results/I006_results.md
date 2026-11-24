# I006 results: PA batch A2 (`engine_*` rest, `native_mode_brk`, `engine_routines_*`)

Date 2026-11-21. Scope: read-only analysis. No names, notes, comments, blocks, overrides or docs of the project were changed. One function-map document and this record pair were added.

## Added

| File | Purpose |
|------|---------|
| `plans/doc-audit/function-map/FM-A2.md` | 109 rows (106 top-level labels of 15 files plus 3 sub-label rows): offset, size, callers, subsystem, proposed name with confidence and evidence, inputs, outputs, clobbers, data touched; models for the attack dispatch, the lair system and the souls; structures observed; 31 WRAM rows (unnamed addresses) with proposals; findings for later batches |
| `plans/extracted-audit/questions/I006_questions.md` | `OQ-I006-1` .. `OQ-I006-26` (1 tagged DISCREPANCY: Magic Bell and Gems on death) |
| `plans/extracted-audit/results/I006_results.md` | this file |

## Method

Fresh `npm run extract:lt` tree. Read every A2 file end to end (`engine_routines_001D3B`, `engine_routines_002678`, `engine_0026F3`, `engine_0029EC`, `engine_002EC0`, `engine_003005`, `engine_004281`, `engine_005354`, `native_mode_brk_0055FC`, `engine_00561E`, `engine_0064F8`, `engine_0065A7`, `engine_006B7F`, `engine_0074B1`, `engine_007A52`) and the key consumers and callees (listed at the top of `FM-A2.md`). Caller counts came from read-only `rg` queries over `extracted/`, cross-checked with `npm run audit -- --block=<name>`. Sizes are the distance to the next label and match the part ends in `us/blocks.json`. No script was written to the repository and nothing was written to a names, notes or comments file. The walkthrough was used as the source for game names and facts; the only mismatch found is OQ-I006-1.

## Findings

- `engine_routines_001D3B` is the set of handlers that the player attack state table `code_list_001B2B` points to: 27 labels, each one starts a player animation through `code_001F9D`, which also publishes the animation to the weapon actor and recomputes `$1B8C`/`$1B8E`. This answers OQ-I005-23: the animations `$20-$23` are the four swing handlers.
- The Phoenix needs Soul Blade, Soul Armor and the Phoenix magic and pays its Gems through Cop26 at every swing (`code_001F7B`); this matches the walkthrough. Cop26 pays, it does not only test.
- `engine_0026F3` is the monster-lair script set: six spawner types (one of them, `code_0027A0`, with no reference), the lair tile gate (`$FD` at `$7E8000`), the seal routine and the NPC "appear" puff `code_00299D` (150 sites in 137 files). 417 `data_00BA0D` records point at five of the spawners.
- `$1B82` is the souls bit field (`$01` Magician, `$02` Light, `$04` Shield, `$08` Detection, `$10` Reality); `engine_003005.code_00310F` is the Soul of Shield effect (destroys the `$0301` hazards near the orb), which matches the walkthrough.
- The death logic is in three places: enemy death and gem drop (`code_002A10`: drop chances `2w + 1` and `4w + 4` per cent, doubled by the Lucky Blade), boss death (`loc_002B96`: 32 explosions, `KillAllOtherActors`, then the ending when `location_id == $7D`), and the player death check (`code_003005`: Medical Herb, Strange Bottle, Magic Bell).
- `$039A` is the boss slot (stored by the boss actors, tested in the enemy death script); this settles OQ-I005-15. The Magic Bell (`$40`) lives in `$1B64`; the Herb and Bottle are tested through inventory bit 7 (partial answer to OQ-I005-24).
- Correction to FM-A1 section 1.2: `engine_006B7F.code_006B7F` is the Mode 7 matrix hook of the title screen (only when `location_id == $10`), not a block-copy routine. The save-slot `MVN` mirror is in `code_006D4E`.
- Dead candidates: `code_0027A0`, `code_006BA5`, `code_006C50` (only called by the former) and `code_0074B1`.
- The ending text matches the walkthrough names; the warp after the text (scene 00/07) is not described in the walkthrough (OQ-I006-11).

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK, 0 stale files removed |
| `npm run rebuild` | OK, SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes (unchanged) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | OK: 26 part notes and 4 block notes against 704 extracted files, 0 errors, 0 warnings, 0 orphans |

`extracted/` shows as modified in `git status` only because it holds the line-tracked extraction; the earlier iterations left it in the same state. The other modified or untracked paths (`package.json`, `src/`, `.cursor/rules`) come from earlier iterations, not from this step.

## Suggested commit message

Please commit when you're ready.

```
Add PA batch A2 function map (engine_* rest, BRK, engine_routines_*)

FM-A2: 109 routines with proposed names, contracts, lair, soul and
death models, structures and WRAM proposals. I006: 26 open questions
(1 DISCREPANCY). No name, note, comment or db change; SHA-1 unchanged.
```
