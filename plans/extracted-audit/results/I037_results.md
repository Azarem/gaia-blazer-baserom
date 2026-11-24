# I037 results (PC annotate actor batch mountain_of_souls)

## Scope

The 9 blocks of group `mountain_of_souls`:

- Soul of Mountain house actors: `ms_soul_of_mountain_house_actors_020000` (13 NPCs: King, grandmas, boy, snail, mushroom, Nome...) and `ms_soul_of_mountain_house_actors_02100B` (14 NPCs: prison captives, grandpas, the snail race, mushrooms, the girl).
- `ms_dungeon_actors` (the dreams and the HDMA effects), `ms_multi_area_actors` (fairy gems, push zones), `ms_snow_mountain_actors` (marker scan, ice slide).
- Enemies: `ms_multi_area_enemies`, `ms_enemy_0FCFD6`, `ms_enemy_0FD058` (types `$2D`-`$37` of `MetaMountainOfSouls`).
- Boss: `ms_boss_poseidon` (type `$38`).

## Depth

Actors, light: a name from the walkthrough, a block note with role, trigger, flags and dialogue, a part note per actor root, comments only for non-obvious logic. The Poseidon script, because it is a boss, got a part note for every actor of the fight.

## Counts

| Item | Before | After | Change |
|------|--------|-------|--------|
| Names | 1955 | 2063 | +108 |
| Block notes | 111 | 120 | +9 |
| Part notes | 1134 | 1238 | +104 |
| Comments | 1071 | 1150 | +79 |

## Gate

- `npm run extract:lt`: OK.
- `npm run rebuild`: OK; SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, unchanged.
- `npm run names -- --check`: OK (2063 names).
- `npm run merge -- --check`: 1150 comments, 1238 part notes and 120 block notes checked; errors 0, warnings 0, orphans 0, duplicate keys 0.
- `us/mnemonics.json`: no hand edit; no new evidence (+0).

## Main findings

- The 27 NPCs of `PlacementA0AS01` and those of the other scenes are matched to their lair records (switch id -> lair location -> monster type), so every NPC name rests on the placement row, the meta type and the walkthrough.
- The Soul of Mountain house runs on a small set of flags: `$0000` grandpa welcome, `$0003` snail spoke, `$0004` / `$0005` call start and grandmas done, `$0007` the 'Hooray' one-shot, `$0705` King thanked, `$0A00` / `$0A01` Phoenix call, `$1F02` the ending ran, `$1B03` Silver Stone given by Nome, `$1A04` Emblem E, `$1A05` Emblem F, `$1E00` / `$1D05` the fairy gems, `$0707` the old man's dream seen.
- The old man's dream (`$40`), the silent figure (`$41`), the mushroom's dream (`$42`) and the Emblem F trigger (`$43`) are in `ms_dungeon_actors`, with three HDMA effects (BG2HOFS shear, BG2VOFS wave, COLDATA gradient) described by table layout.
- The fairy gems (`$3E` switch `$EC`, 300 EXP; `$3F` switch `$D9`, 400 EXP) share one Stay / Go back prompt that sends the hero to A0AS01 at ($01D8,$0040).
- The push zones are 8-byte records (x0, x1, y0, y1, dx, dy) for four areas; every zone has dx 0, dy +1.
- The ice slide (`$3B`) works only without the Mushroom Shoes (`$22`), moves the hero 2 pixels per step along the animation direction and stops at a wall found by `COP 21..24`.
- The enemy stats and lair lists are documented per type (Lizard, Caribou, Yeti, Fire Bat, snowball, Purple and Red Wizard, Ice Maker, Ice Crystal, Cave Bat, Green Blob). The Ice Crystal explodes at its first hit because actor `+$25` is its HP.
- Poseidon's script is a loop of rounds (`$30` = 2): triple fireball, spear thrust (on a second random side, 'may do twice'), the homing pair, dives. This matches the walkthrough's three attacks and their order.

## Corrections made

- The first draft of I037a contained invented labels, wrong COP semantics, tile numbers and a reversed `COP 07` sense for the boy `$E9`; the whole spec was rewritten from the asm, the placement table and `docs/cop/index.md`.
- I037b: 'four racers' became 'three jockeys' (plus the starter); two unverified claims were removed; one 'flip toggled once per lap' wording was corrected.
- I037c: an unverified fixed-point claim was replaced by the observed byte swap (`XBA`); the marker wording and the wall test (checked only at tile boundaries on the movement axis) were corrected.
- I037d: wrong comment tags were fixed before the dry-run.
- I037e: 'hidden' for `$16 |= $0300` became 'submerged / not hittable'; the homing fireball steering was rewritten after tracing `COP 9B` / `9A` (vertical test first, then x).

## Files changed (not committed)

- `plans/extracted-audit/renames/apply-I037a_names.json` to `apply-I037e_names.json`
- `plans/extracted-audit/edits/I037a.json` to `I037e.json`
- `plans/extracted-audit/questions/I037_questions.md`, `plans/extracted-audit/results/I037_results.md`, `plans/doc-audit/I037_checklist.md`
- Tool output: `us/names/bank00.json`, `bank02.json`, `bank0F.json`, `us/blocks.json` (part references), `notes/blockNotes|partNotes|comments/bank00.json`, `bank02.json` and `bank0F.json`, `extracted/**` (from `extract:lt`: run `npm run extract` before committing if the `; {n}` tags are not wanted). The working tree also holds changes of earlier batches that are not part of this step.

## Open questions

14 rows in `questions/I037_questions.md` (`OQ-I037-1` to `-14`; DISCREPANCY on -1, -2 and -3). Existing `OQ-I033-1` (Poseidon HP 79 against 70) and `OQ-I033-3` (types `$31` and `$35`) are cited, not duplicated.

## Suggested commit message

```
Annotate actor batch mountain_of_souls (I037)

Name and document the 9 mountain_of_souls blocks: the Soul of Mountain
house NPCs (King, grandmas, Nome, the snail race, prison captives), the
dream and HDMA actors, fairy gems, push zones and the ice slide, the
snow mountain and dungeon enemies, and the Poseidon boss. 108 names,
9 block notes, 104 part notes, 79 comments. ROM SHA-1 unchanged. Open
questions OQ-I037-1..14 (Phoenix caller, lair monster names, unmapped
text glyph, unread flags, $16 bits, ice markers, projectile motion).
```

Please commit when you're ready.
