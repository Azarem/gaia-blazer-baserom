# I009 results: PA batch A5 (library `0118`)

Date 2026-11-21. Scope: read-only analysis. No names, notes, comments, blocks, overrides or docs of the project were changed. One function-map document and this record pair were added. The iteration number I009 was chosen so that a parallel A4 batch (I008) does not clash.

## Added

| File | Purpose |
|------|---------|
| `plans/doc-audit/function-map/FM-A5.md` | 61 routine rows (41 top-level labels of 15 files plus 20 sub-label rows): offset, size, callers, subsystem, proposed name with confidence and evidence, inputs, outputs, clobbers, data touched; 23 data rows (strings, the pointer list, the gear table) and the 65-row description-string table; models for the main-loop position, the HDMA queue, the button map, the inventory table, the equipment menu, the status and souls screen, the talk probe, the HUD, the VRAM and palette handoff and the text control codes; structure layouts with field evidence; WRAM proposals; findings for later batches; branch-label inventory |
| `plans/extracted-audit/questions/I009_questions.md` | `OQ-I009-1` .. `OQ-I009-18` (3 tagged DISCREPANCY: VIP Card text against `items.md`, Psycho Sword text against `items.md`, the display clamp of 12 against the walkthrough caps) |
| `plans/extracted-audit/results/I009_results.md` | this file |

## Method

Fresh `npm run extract:lt` tree. Read all 15 `extracted/library/lib_01185E`, `lib_01186E`, `lib_0118FC` and `lib_0118FC_part2` .. `part13` files end to end, plus the callers and consumers that give the data meaning: `engine_000000` (main loop and NMI), `lib_shared_012769` (text renderer), `lib_shared_01230B`, `lib_shared_012416`, `lib_shared_0131B7`, `lib_shared_0131D1`, `lib_shared_014789`, `lib_shared_014F74`, `lib_0273D4`, `lib_0273EB`, `lib_027781_part1/part3`, `lib_02719F`, `lib_0133A6_part3`, `engine_0064F8`, `cop_handler_005888`, `common_actor_0066C6`, `common_actor_001A28_part1`, `data_00F9F7`, `data_048000`, `data_04F000`, `lib_0161CE`. Caller counts came from a read-only search over `extracted/` and every decimal offset in the tables was checked against the hex suffix of its label. The walkthrough (`items.md`, `magic.md`, `01-in-the-beginning.md`) and the crosswalk were used for names and facts. No script was written to the repository and nothing was written to a names, notes or comments file.

## Findings

- `code_01185E` is `ResetHdmaQueue`; the extractor decodes it with M=16, so PC needs `"71774": {"M": 1}` in `overrides.json` (OQ-I005-7). `code_01186E` and `code_01188A` queue one HDMA channel (4-7) each: A.low = bank, **B = PPU register index**, Y = table address. `binary_0118BC` holds the DMAP value for each register. The queue has no overflow guard (OQ-I009-9).
- `code_0118FC` is the field button dispatcher: Select/X opens the equipment menu, B talks, A (with no direction) shows the status and souls screen. The A-button screen is not in the walkthrough (OQ-I009-5).
- Talk: `code_011AC4` finds the first actor with `$16` bit `$0040` whose box contains the probe point in front of the player. `loc_011AF9` calls the script at `$30,X` through a pushed RTL frame; `$16` bit `$0008` makes the NPC turn to face the player first and restores its slot from `$1A1E`. This answers OQ-I007-14 and part of OQ-I005-14.
- Inventory: `$1B1E` is one 64-byte table indexed by item id minus 1 (weapons `$01-$08`, armors `$09-$10`, magic `$11-$18`, items `$19-$40`); bit 7 of a slot is the marker. B and Y both confirm a choice; no live path cancels. The equipped cells `$1B5E-$1B64` are word cells whose high bytes nothing writes (OQ-I009-18).
- `binary_0161AC` gives the weapon strength and armor defence bonuses (1, 2, 3, 4, 6, 8, 10, 12 for both); `code_011EED` sums them into `$1B70` and `$1B74`. The minimum swing levels are `word_0161CE` (BCD 01, 05, 11, 15, 16, 19, 22, 24, compared in `common_actor_001A28_part1`); this locates the table that OQ-I004-9 listed as not found and matches the walkthrough.
- All 65 description strings pair with the item ids of the crosswalk. Weapon, armor and magic texts agree with the walkthrough (Gem costs 4, 8, 8, 1, 8, 20, 8, 2). DISCREPANCY: the VIP Card text names no tower while `items.md` says Right Tower (OQ-I009-1); the Psycho Sword text states a freeze that `items.md` omits (OQ-I009-3); the status screen clamps strength and defence at 12 where the walkthrough says 13 and 12 (OQ-I009-6). The Super Bracelet text agrees with the walkthrough, not with FM-A1's reading of the code (OQ-I009-4).
- HUD: `code_012659` draws the enemy gauge from the `$0330` timer, drains the pending heal and EXP, then draws one string per set bit of `$0332`. This answers OQ-I005-13.
- Four routines have no live caller: `code_011E44`, `code_012086`, `loc_011D42` and, through them, `code_011EBD` (OQ-I009-14).
- Placement proposals for PB: the HDMA queue and the NMI pair `code_0131A2`/`code_0131AE` with `code_0131B7` as a system helper block; the menu code, strings and description list as one `menu` block; `code_013215`, `code_0131E8` and `code_0131D1` as `arithmetic`; the four A7 soul lines next to `asciistring_014636`.
- The 20 sub-label rows (listed in FM-A5 section 5) each need an `!` override or name row in PC because the label namespace is flat.

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK, 0 stale files removed |
| `npm run rebuild` | OK, SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes (unchanged) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | OK: 26 part notes and 4 block notes against 704 extracted files, 0 errors, 0 warnings, 0 orphans |

`extracted/` shows as modified in `git status` only because it holds the line-tracked extraction. The other modified or untracked paths (`package.json`, `src/`, `.cursor/rules`, the other `plans/` files) come from earlier iterations, not from this step.

## Suggested commit message

```
docs(blazer): function map FM-A5 for library 0118 (I009)

Add the function map for batch A5 (61 routines, 23 data rows, 65 item
description strings), 18 open questions (3 DISCREPANCY) and the results
record. No names, notes, db files or ROM bytes changed.
```

Please commit when you're ready.
