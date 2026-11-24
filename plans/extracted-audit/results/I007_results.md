# I007 results: PA batch A3 (`cop_handlers`)

Date 2026-11-21. Scope: read-only analysis. No names, notes, comments, blocks, overrides or docs of the project were changed. One function-map document and this record pair were added.

## Added

| File | Purpose |
|------|---------|
| `plans/doc-audit/function-map/FM-A3.md` | 132 rows (119 top-level labels of 110 files plus 13 sub-label rows): offset, size, callers and `COP [id]` use counts, family, current and proposed name with confidence and evidence, operands, effect, clobbers, data touched; models for the exit chain and resume mechanics, the flag word, switches and inventory, the spawn variants, the tile footprint and index, text and menus, the music load through the SPC IPL and the player-relative operands; actor-field, `data_00BA0D` and operand structures; 11 WRAM rows with proposals; findings for later batches |
| `plans/extracted-audit/questions/I007_questions.md` | `OQ-I007-1` .. `OQ-I007-28` (4 tagged DISCREPANCY, all against `docs/cop/index.md`) |
| `plans/extracted-audit/results/I007_results.md` | this file |

## Method

Fresh `npm run extract:lt` tree. Read all 110 `extracted/cop_handlers/*.asm` files end to end, plus the dispatcher (`engine_00561E`), the helpers they call (`engine_0064F8`, `engine_0065A7`, `lib_027462_part1/part2`, `lib_0273A2`, `lib_0276A5`, `lib_0276C9`, `lib_0275ED`, `lib_027614`, `lib_01065B`, `lib_0106CD`, `lib_0124EE_part2`, `lib_shared_0131B7`, `lib_0118FC_part8`, `common_shared_0FEEA6.code_0FEFF5`, `data_00F9F7.table_00FB49`) and the consumers of the unnamed WRAM they touch (`lib_0109D6`, `lib_010EA9_part1`, `common_actor_001A28_part1`). Caller counts and `COP [id]` use counts came from read-only `rg` queries over `extracted/`; sizes are the distance to the next label (sub-label rows split the size of the label they sit in). The walkthrough was used as the source for item ids, Gem costs, EXP and HP facts and the name-entry screen; every checked claim agrees with the ROM. No script was written to the repository and nothing was written to a names, notes or comments file.

## Findings

- All handlers share one convention: `TYX`, operands through `LDA [$38]` / `INC $38`, and one of four ends in `cop_handler_006473` after `CopB2` (continue, jump, yield, save-resume-and-yield). The exit chain has nine labels; `CopExitContinue` (`loc_0064BF`) has 68 sites in 66 files.
- The event-flag word's bit 15 is a comparison value: Cop09 writes it, Cop07 jumps when flag = it, Cop08 when flag != it, Cop05 waits while flag = it. The current names are right only for bit 15 clear (OQ-I007-1).
- `$16` bit 15 is "off screen": Cop8D/8E and CopAD follow FM-A1 R27, and `docs/cop/index.md` has it reversed (OQ-I007-2). Cop8D/8E (0 uses) do not skip their operand on the other path.
- Spawn variants **store** `$16` (and `$00`, `$02`), they do not add: OQ-I006-19 is answered. `CopB1/B2` add the caller's x and y; `CopAB/AC` are absolute.
- Cop31 and Cop32 are not plain spawns: they start an actor chain that fades or stops the SPC, re-enters the IPL boot loop and uploads one of 21 music blocks (`table_00FB49`). `cop_handler_005CF0_part1` is therefore sound code, not COP handlers. `loc_002D40` is a respawn-after-600-frames-off-screen routine, which corrects FM-A2 X070.
- Cop37 is the pending heal (`$043B`, drained by `lib_0275ED`) and Cop38 the pending EXP (`$043D`, drained by `lib_027614` in 8-frame steps); Cop36 (0 uses) adds EXP at once. Cop3A is the player-name entry (matches `01-in-the-beginning.md`). Cop26 pays the Gem costs of `magic.md` (halved with the Magic Armor, free with the Magic Bell). Cop0A/0B/18/19 use the item ids of the crosswalk section 4; bit 7 of an inventory byte is "equipped".
- Cop33/34 show and hide the player, weapon and orb actors and also unlock and lock input through `$0464` (read by the player loop `code_001512`). `$0458` is incremented by the six boss actors, cleared by the music load and read by `lib_0109D6` before the `$FE` exit tile; `$0405` is the record index of the last warp used (Cop30).
- Tile handlers: `code_0272B8` adds `y & $0F` unmasked, Cop2B zeroes the type nibble when it unblocks, Cop11 clears the footprint at the new position (OQ-I007-5 to 7).
- Cop0C's margin is `* 16` (FM-A2 X055 said "plus 2"). `lib_01065B` (used by Cop92-95) writes `$08-$0E` per animation step, which FM-A1 4.1 lists as extents (OQ-I007-24).
- 17 of 108 handlers have no `COP [id]` site (00, 02, 06, 13, 25, 29, 36, 89, 8A, 8B, 8C, 8D, 8E, 93, 95, AB, B1); `docs/cop/index.md` has stale counts (Cop91: 0, measured 414).
- Placement proposals for PB: `code_0064CC` next to `engine_0064F8`, `code_006537` next to `engine_0065A7`, the exit chain as its own block, `cop_handler_005CF0_part1` out of `cop_handlers`.

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK, 0 stale files removed |
| `npm run rebuild` | OK, SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes (unchanged) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | OK: 26 part notes and 4 block notes against 704 extracted files, 0 errors, 0 warnings, 0 orphans |

`extracted/` shows as modified in `git status` only because it holds the line-tracked extraction; earlier iterations left it in the same state. The other modified or untracked paths (`package.json`, `src/`, `.cursor/rules`, the other `plans/` files) come from earlier iterations, not from this step.

## Suggested commit message

Please commit when you're ready.

```
Add PA batch A3 function map (cop_handlers)

FM-A3: 132 rows (110 files) with proposed names, contracts, exit-chain,
flag-word, spawn, tile, music-load models, structures and WRAM
proposals. I007: 28 open questions (4 DISCREPANCY vs docs/cop).
No name, note, comment or db change; SHA-1 unchanged.
```
