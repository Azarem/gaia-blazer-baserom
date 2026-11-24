# I014 results: PA batch A10 (the player actor `common_actor_001A28`)

Date 2026-11-21. Scope: read-only analysis. No names, notes, comments, blocks, overrides or docs of the project were changed. One function-map document and this record pair were added.

## Added

| File | Purpose |
|------|---------|
| `plans/doc-audit/function-map/FM-A10.md` | 39 routine rows P01-P39 (including the sub-label rows `loc_001A65`, `code_002163` and `code_0023E3`, which have callers outside their routine), 2 data rows (`word_001588`, `code_list_001B2B`), the tables the code reads, ten models (player actor and its five helpers, animation stepping, action choice and the meaning of the carry, facing tables, input filter, push zones and corner slide, Gem pull, soul orb and the seven spells, level-up, return trip and death), 6 structure layouts with the evidence for each field width, WRAM name proposals, the inner-label inventory, fan-in, findings and placement constraints |
| `plans/extracted-audit/questions/I014_questions.md` | `OQ-I014-1` .. `OQ-I014-20` (three tagged DISCREPANCY: 3, 5 and 18) |
| `plans/extracted-audit/results/I014_results.md` | this file |

## Method

Fresh `npm run extract:lt`; the four files of the batch were read end to end (`part1` 5394-7483, `part2` 8143-9848, `part3` 9959-9971, `part4` 12118-12293: 3981 bytes in four pieces separated by the A2 handlers and the Phoenix projectile scripts). The callees and callers that give each routine its meaning were read in full: the NMI joypad decode, the scheduler and the animation step, `Cop82`, `CopB0`, `COP 26`, the 28 pose handlers and the death handler of A2, the Phoenix scripts, the six animation tables, the seven hero meta entries, the four push-zone setters and the five soul actors, the Gem actors, the status screen. Field widths of the structures come from the consuming handlers. Tables `binary_00FA7F`, `binary_00FAAB`, `word_00FAD7`, `word_00FBB8`, the sine tables and the anim tables were joined with their readers. The walkthrough (`magic.md`, `items.md`, `level-up.md`, chapters 1, 2, 7, 8) was checked for every spell, cost, stat and mechanic.

## Findings

- **The state table is a function of facing**: 44 rows x 6 words (B, Right, Left, Down, Up, none), eight rows per facing and twelve filler rows (`$14`-`$1F`). The carry on entering a pose handler selects the `$00`-`$13` family (L or R held, or no weapon: sidestep, backstep and thrust) against the `$24`-`$2B` family (armed, walking or standing with the sword carried). This **answers OQ-I006-4**; the reason for banks `$0B` and `$0C` in the death handler is partly answered (OQ-I006-22).
- **Helper actors**: the hero is five cloned actors: level-up watcher, soul orb, input filter, motion finish and weapon layer, plus the orb controller spawned by the orb; run order Y1, Y2, S, Y3, player, Y5, Y4. The orb controller reads `joy_pressed` before the filter strips Y, so spells work without a weapon.
- **Walking is driven by animation steps** (duration, dx, dy) at 2 px per frame; the filter's only job is to interrupt the current step when the key is released or B pressed.
- **Push zones**: 13 lists, 54 records, all 8-byte `unk16`; 52 move 1 px per frame, two (St. Elles) move 4 px per frame to the left.
- **Spells**: all seven costs, damage bytes, flags and animations decoded. `$0433` is a count of live spell actors that doubles as a global cast lock (FM-A5's `spell_charge` is the wrong reading).
- **Level-up**: EXP thresholds are two big-endian BCD words per level, loaded high word first; strength and defence alternate by the parity of the new BCD level; the 12 cap is display-only.
- **Corrections**: FM-A8 C04 ("sword push-back scan") is a Gem pull (OQ-I014-3); the walkthrough's Spark Bomb 60 degrees does not match the code's timing (OQ-I014-5).
- Dead bytes and defects: `loc_001753` (unreferenced `RTS`), `LDA #$0302` in the Tornado, `word_001588` entries `$14`-`$23` never read.
- Naming hazards for step PC: the files `common_actor_001A28_part1`-`part4` are positions in the interleaving, not subsystems; `loc_001A65`, `code_002163` and `code_0023E3` each need their own `names` row; the 28 handlers of A2 can now be named by pose (FM-A10 section 7).

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK |
| `npm run rebuild` | OK, SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes (unchanged) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | OK: 0 errors, 0 warnings, 0 orphans (0 comments, 26 part notes, 4 block notes, 704 extracted files) |

`git status` shows `extracted/` as modified because the line-tracked extraction was run last; run `npm run extract` if the tracking annotations should not be committed.

## Suggested commit message

```
docs(blazer): A10 function map for the player actor, soul orb, spells and level-up (I014)
```

Please commit when you're ready.
