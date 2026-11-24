# I005 results: PA batch A1 (`engine_000000`)

Date 2026-11-21. Scope: read-only analysis. No names, notes, comments, blocks, overrides or docs of the project were changed. One function-map document and this record pair were added.

## Added

| File | Purpose |
|------|---------|
| `plans/doc-audit/function-map/FM-A1.md` | one row for each of the 52 top-level labels of `extracted/system/engine_000000.asm` (offset, size, callers, subsystem, proposed name with confidence and evidence, inputs, outputs, clobbers, data touched), frame and NMI model, structures observed (actor slot, flag bits, animation, spritemap, meta entry), hit rules matched against the walkthrough, 39 unnamed WRAM and DP addresses with proposed names |
| `plans/extracted-audit/questions/I005_questions.md` | `OQ-I005-1` .. `OQ-I005-24` (4 tagged DISCREPANCY: Super Bracelet, Critical Sword, Psycho Sword, the `$16` bit 15 polarity) |
| `plans/extracted-audit/results/I005_results.md` | this file |

## Method

Fresh `npm run extract:lt` tree. Read `engine_000000.asm` end to end (3060 lines) and the heads of its callees (listed at the top of `FM-A1.md`). Cross-file callers came from read-only `rg` queries over `extracted/`; the counts match the `npm run audit -- --block=engine_000000` matrix. No script was written to the repository and nothing was written to a names, notes or comments file.

## Findings

- Frame structure: the work phase of the main loop runs with NMI off; NMI is enabled only just before WaitVBlank. That is what makes the stack relocation in `code_0005C4` and `code_0006EE` safe. Three sub-frame routines (`code_000127`, `code_000173`, `code_0001BE`) repeat the whole pipeline from inside the scene loader, menus and text; `code_000173` and `code_0001BE` rely on the caller having NMI off (OQ-I005-20).
- Scheduler: `code_0005A6` enters `code_0009BF` by an `RTS` trick and gets control back through `code_0005BB`; actor scripts are called by pushing a return address and executing `RTL`. The sort in `code_0005C4` clears its bucket table with `PHA`/`PLA` on the word it just consumed.
- NMI order is OAM, CGRAM, BG3 page, scroll registers, scroll strips, dynamic sprite tiles, VRAM strip, VRAM write queue, then the `engine_006B7F` hook, joypad and the sound word at `$0398`.
- Combat rules match the walkthrough for the Power, Shield, Zantetsu, Spirit, Soul Blade, Mystic Armor and Light Armor entries (FM-A1 section 4.6). They do not match for the Super Bracelet, Critical Sword and Psycho Sword (OQ-I005-1 to -3).
- Equipment variables: `$1B5E`, `$1B60`, `$1B62`, `$1B64` are the equipped weapon, armor, magic and bracelet ids; `$1B70`, `$1B72`, `$1B74`, `$1B76` are weapon strength, level strength, armor defence and level defence; `$1B8C` and `$1B8E` are the effective attack and defence. This also explains `OQ-I004-10` (level strength and defence are `$1B72` and `$1B76`).
- Two extracted routines are decoded with the wrong M flag (`lib_01185E.code_01185E`, `lib_01010B.code_01010B`); the correct text is in `OQ-I005-7`.
- `docs/cop/index.md` section 2 and the name `CopAD_YieldWhileInView` have the polarity of `$16` bit 15 backwards (OQ-I005-11).
- `code_000205` to `code_00031D` (offsets 517-833) is a dead debug block with no references.

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK, 0 stale files removed |
| `npm run rebuild` | OK, SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes (unchanged) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | OK: 26 part notes and 4 block notes against 704 extracted files, 0 errors, 0 warnings, 0 orphans |

`extracted/` shows as modified in `git status` only because it holds the line-tracked extraction; the earlier iterations left it in the same state.

## Suggested commit message

Please commit when you're ready.

```
Add PA batch A1 function map (engine_000000)

FM-A1: 52 routines with proposed names, contracts, structures and
WRAM proposals. I005: 24 open questions (4 DISCREPANCY). No name,
note, comment or db change; SHA-1 unchanged.
```
