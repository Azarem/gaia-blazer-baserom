# I035 results (PC annotate actor batch greenwood)

## Scope

The 8 blocks of group `greenwood`: the Woods of GreenWood actors (`gw_woods_actors_01B98D`, `gw_woods_actors_01D045`), the Lostside marsh actors (`gw_lostside_marsh_actors`: fairy gems, rafts, screen effects), `w1_actor_01E4BB`, the text block `gw_watching_over_world_return_prompt_texts` (block note only), the enemies (`gw_lostside_marsh_enemies`, `gw_enemies_without_placement`) and the boss `gw_boss_light_water_fire_statues`.

## Depth

Actors, light: a name from the walkthrough, the lair record or the meta table, a block note (roster, trigger, flags, dialogue) and a part note per actor root with When / Sees / Why / In / Out / Clobbers. Comments only where the logic is not obvious (flags, shared counters, scene changes, immunity bits, hand-over). Every comment has an `expect` guard.

## Counts

| | Before | After |
|-|-------:|------:|
| Names | 1763 | 1835 (+72) |
| Part notes | 904 | 976 (+72) |
| Block notes | 91 | 99 (+8) |
| Comments | 877 | 962 (+85) |
| Mnemonics (by hand) | - | +0 (no evidence for a new `us/mnemonics.json` entry) |

(The 72 / 72 / 8 / 85 are the sums of the three name specs and five merge specs: I035a 15 part notes and 12 comments, I035b 21 and 25, I035c 21 and 21, I035d 14 and 9, I035e 1 and 18.)

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK |
| `npm run rebuild` | OK, SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, unchanged |
| `npm run names -- --check` | OK (1835 names) |
| `npm run merge -- --check` | 962 comments, 976 part notes, 99 block notes against 151 extracted files; errors 0, warnings 0, orphans 0, duplicates 0 |

## Main findings

- **Identification chain:** meta type (`MetaGreenwood`) -> placement scene (A04 Woods, A05 Lostside) or lair record (`+9` name index, `+B` lair location, `+15` type) -> walkthrough chapter 3 and the bestiary. Lair monsters: Mud Man / Walking Plant (marsh and Water Shrines), Stone Statue (Water Shrines 2 and 3), Metal Scorpion (Fire Shrines), Spirit Ball (Light Shrines), Ghost Head, Lizard Men and Fire Man (Fire and Light Shrines). Placed monsters: Water Lizard, Purple Flower and the floor spears in A05S01-S03.
- **Woods actors:** the animals of the Woods each hold a switch (`COP 14` / `COP 3B`) tied to a lair record; the Woodstin-Trio show (Billy, the restaurant joke) runs on a flag protocol across the actors, written out in the block note; the mole hole, the squirrel exchanger and the dream rooms are placements of the same set.
- **Marsh actors:** the four fairy gems (150 / 180 EXP, the Light Arrow Magic fairy and the return-only one) share one return prompt; the rafts and the Strange Bottle trigger are documented with their flags.
- **Statue boss:** one root serves all three statues. Only one is `boss_actor`; the others wait for bit `$0400` of the boss's `$16`, which `RunBossDeath` writes (`$0700`) when it kills the boss, and take over after 8 frames. The hand-over happens while the explosions run, so `RunBossDeath` of the earlier statues finds `X != boss_actor` and skips `KillAllOtherActors` and the music change; only the last statue ends the fight. The Light Statue's T-shaped bolt is eight children in the order south, west, north, east (the walkthrough's order). The Water Statue's puddle trail counts its segments in byte 0 of `event_flags`.
- **Discrepancies (never resolved by invention):** the ROM stats of `$37` / `$38` against the bestiary's Green Lizard Man (OQ-I035-1); the far-right statue of formation `$20` runs the Fire script while the walkthrough puts the Water Statue there (OQ-I035-13).
- **Not named on purpose:** the immunity bits of `$1A` and the `$16` bits `$0200` / `$0400` stay in the notes and in comments (OQ-I035-14, -15); no mnemonic was added.

## Corrections made while writing

- File-offset ranges in the I035b and I035c block notes were fixed from `us/blocks.json` (the wave effect and the ripple parts lie inside the other blocks' ranges).
- The `COP 07` semantics were corrected after the first draft (bit 15 of the operand set: jumps when the flag is set; clear: when it is clear); the digger's flag tests and the block-note flag line were rewritten.
- Unverified claims were removed or reworded: 'walks' and 'follows' for animation-driven movement, 'blocked tiles' for the crocodiles, Monmo's 'present' (it is the chest with the Mole's Ribbon), the placement of effect actors in A06 / A08 (other worlds' meta tables) and the walkthrough attribution of the return-only fairy.
- In I035d the order of the tile tests was fixed against `docs/cop/index.md` (21 above, 22 below, 23 left, 24 right); the Water / Fire attack text of I035e was reduced to what the code shows, and the walkthrough statements are marked as such.

## Files changed (not committed)

- `plans/extracted-audit/renames/apply-I035a_names.json`, `apply-I035b_names.json`, `apply-I035c_names.json`
- `plans/extracted-audit/edits/I035a.json` to `I035e.json`
- `plans/extracted-audit/questions/I035_questions.md`, `plans/extracted-audit/results/I035_results.md`, `plans/doc-audit/I035_checklist.md`
- Tool output: `us/names/bank01.json`, `bank0F.json`, `bank00.json`, `us/blocks.json` (part references), `notes/blockNotes|partNotes|comments/bank00.json`, `bank01.json`, `bank0F.json`, `extracted/**` (from `extract:lt`: run `npm run extract` before committing if the `; {n}` tags are not wanted). The working tree also holds changes of other batches that are not part of this step.

## Open questions

17 rows in `questions/I035_questions.md` (`OQ-I035-1` to `-17`; DISCREPANCY on -1 and -13).

## Suggested commit message

```
Annotate actor batch greenwood (I035)

Name and document the 8 greenwood blocks: the Woods actors, the Lostside
marsh actors with the fairy gems and rafts, the marsh enemies, the two
unused monster scripts, the Light / Water / Fire statue boss and the
fairy text block. 72 names, 8 block notes, 72 part notes, 85 comments.
ROM SHA-1 unchanged. Open questions OQ-I035-1..17 (Lizard Man stats vs
bestiary, statue positions, boss hand-over order, event flag byte 0).
```

Please commit when you're ready.
