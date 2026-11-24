# I036 results (PC annotate actor batch st_elles)

## Scope

The 12 blocks of group `st_elles`: the Seabed Sanctuary actors (`se_seabed_sanctuary_actors_0F8000`, `se_seabed_sanctuary_actors_0F8D58`), the seabed actors and enemies (`se_seabed_of_st_elles_actors`, `se_seabed_of_st_elles_enemies`, `se_enemy_0FBB78`), the coast (`se_st_elles_coast_actors`, `se_st_elles_coast_enemies`, `w2_actor_0FA6F5`, `w2_shared_0FA945`) and the Ghost Ship (`se_ghost_ship_actors`, `se_ghost_ship_enemies`, `se_boss_floating_skull`).

## Depth

Actors, light: a name from the walkthrough, the lair record or the meta table, a block note (roster, trigger, flags, dialogue; for enemies also stats and the lair records that spawn them) and a part note per actor root with When / Sees / Why / In / Out / Clobbers. Comments only where the logic is not obvious (flags, switches, immunity and hit bits, hand-overs). Every comment has an `expect` guard.

## Counts

| | Before | After |
|-|-------:|------:|
| Names | 1835 | 1955 (+120) |
| Part notes | 976 | 1134 (+158) |
| Block notes | 99 | 111 (+12) |
| Comments | 962 | 1071 (+109) |
| Mnemonics (by hand) | - | +0 (no evidence for a new `us/mnemonics.json` entry) |

(+120 names = three name specs of 38, 29 and 53. The seven merge specs: I036a 32 part notes and 11 comments, I036b 26 and 20, I036c 27 and 23, I036d 19 and 20 over four files, I036e 8 and 4, I036f 29 and 13, I036g 17 and 18 over two files.)

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK |
| `npm run rebuild` | OK, SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, unchanged |
| `npm run names -- --check` | OK (1955 names) |
| `npm run merge -- --check` | 1071 comments, 1134 part notes, 111 block notes against 151 extracted files; errors 0, warnings 0, orphans 0, duplicates 0 |

## Main findings

- **Identification chain:** meta type (`MetaStElles`) -> placement scene (A06-A09) or lair record (`+9` name index, `+B` lair location `$29`-`$34`, `+15` meta type of the world) -> walkthrough chapter 4 and the bestiary. Lair monsters: Jellyfish, Hermit Crab, Manta Ray and Yellow Seahorse (seabed), Walking Tree, Monster Rock, Ape, Metal Ape and Tornadic Eagle (island), the Floating Skull (record `$B6`). Placed monsters: Sea Urchin, Purple Fish, Purple Worm, Ghost Ship Torch, the Lightning Pyramid and the Durean vents. The record types of other worlds share the same numbers (`$32`-`$37` in locations `$1D`-`$21` and `$41`-`$47` belong to other worlds' lists); only the locations of world 2 were used.
- **Seabed Sanctuary and seabed:** the four mermaid statues send the hero to A07S01 with the trip flag `$0903`; the gates at the seabed end set the passage flags (`$0406`, `$0407`, `$0500`, `$0501`) and clear the trip flag (OQ-I036-1). The captive mermaids and dolphins run on `COP 3B` / `HoldActorUntilReleased` with their lair record; the oxygen rule, the hot coals (tile `$47`, 4 HP), the Durean tears logic and the epilogue are described in the block notes.
- **Durean lava bombs confirmed:** the bomb sets `$16 = $0301` while it flies, the exact value `DestroyHazardsNearOrb` (the Soul of Shield, `engine_003005`) bursts near the orb. The engine note called that link inferred; the bomb script now confirms it. The bomb switches to `$0200` for the landing, so the orb no longer matches it.
- **`$16` bits:** the engine's target mask `$EEC0` contains `$0200`, so an actor with that bit cannot be hit by sword or projectile; `$0100` keeps an actor from being a hit source; `$02A0` is an unhittable hit-source projectile. This explains the Purple Worm (hidden underground with `$0200`, `STZ $16` when it comes out), the stunned torch (`$0200`) and the retreating hands of the boss (`$0300`). `$1A` bit `$0100` (survives a lethal hit with 1 HP) makes the Ghost Ship torches and the hands indestructible, matching the walkthrough ('indestructible - attacks merely will stem their efforts for a few seconds').
- **Partial resolution of OQ-I031-2:** the hot-coal tile `$47` and its 4 HP of damage (actors file) close part of the question about the tile test helper; the helper name stays.
- **Boss:** the Floating Skull, its fire spawner and the skull talk through event flag `$0000` (set by the skull, cleared by the spawner); the hands have HP `$63` and retreat for 300 frames below `$5A` (ten points of damage); a link actor copies another actor's state to the skull and halts it when that actor dies (the source is not identified, OQ-I036-12).
- **Discrepancies (never resolved by invention):** the unmapped glyph in the ghost ship statue text (OQ-I036-2), 'Bubble Clothing' in the ROM against 'Bubble Armor' in the walkthrough (OQ-I036-3), the Hermit Crab's metal class bit against 'Metal? No' (OQ-I036-8); the Skull's ROM HP 69 against the bestiary's 70 stays `OQ-I033-1`.
- **Not named on purpose:** the walkthrough does not name the Red-Hot Stick mermaid (OQ-I036-4); the unused enemy type `$33` keeps a descriptive name (OQ-I036-9); no mnemonic was added.

## Corrections made while writing

- The herb mermaid's text order, the statue test (a per-frame `COP 0D` check, not a wait), the vertical axis of `COP 9B`, the west guard's two texts and the order of Lue's friend's text were corrected in the actor specs before they were applied.
- The lair table of the first draft read the wrong columns for the island types; it was redone with the type at `+15` and the lair location at `+B`, and the roster of each block note uses only world 2 locations.
- The passage flags in OQ-I036-1 were corrected to `$0406`, `$0407`, `$0500`, `$0501` (`$0502` belongs to the arrival statue).
- The first draft of the Manta Ray note did not explain `$0200` in its own `$16`; it now says the actor is unhittable while it fires.
- A claim that the skull 'is never hit by the code' was replaced by the walkthrough quote and the statement that no step of the file explains it.

## Files changed (not committed)

- `plans/extracted-audit/renames/apply-I036a_names.json`, `apply-I036b_names.json`, `apply-I036c_names.json`
- `plans/extracted-audit/edits/I036a.json` to `I036g.json`
- `plans/extracted-audit/questions/I036_questions.md`, `plans/extracted-audit/results/I036_results.md`, `plans/doc-audit/I036_checklist.md`
- Tool output: `us/names/bank00.json`, `bank0F.json`, `us/blocks.json` (part references), `notes/blockNotes|partNotes|comments/bank00.json` and `bank0F.json`, `extracted/**` (from `extract:lt`: run `npm run extract` before committing if the `; {n}` tags are not wanted). The working tree also holds changes of other batches that are not part of this step.

## Open questions

12 rows in `questions/I036_questions.md` (`OQ-I036-1` to `-12`; DISCREPANCY on -2, -3 and -8).

## Suggested commit message

```
Annotate actor batch st_elles (I036)

Name and document the 12 st_elles blocks: the Seabed Sanctuary and seabed
actors (mermaid statues, gates, captive mermaids and dolphins, Durean),
the coast and island enemies, the Ghost Ship enemies and the Floating
Skull boss. 120 names, 12 block notes, 158 part notes, 109 comments.
ROM SHA-1 unchanged. Open questions OQ-I036-1..12 (passage flags, text
glyph and item name, Hermit Crab metal bit, unused type $33, skull link).
```

Please commit when you're ready.
