# I004 results: P1 walkthrough crosswalk

Date 2026-11-21. Scope: read-only analysis. No names, notes, comments, blocks, overrides or docs of the project were changed. One new analysis document and this record pair were added.

## Added

| File | Purpose |
|------|---------|
| `plans/doc-audit/walkthrough-crosswalk.md` | worlds, 97 scenes, bosses, 64 item ids, weapon and armour stats, spells, souls, 73 bestiary rows, NPCs, sidequests, level-up table, naming convention proposal, list of what was not located |
| `plans/extracted-audit/questions/I004_questions.md` | `OQ-I004-1` .. `OQ-I004-15` (9 with tag DISCREPANCY) |
| `plans/extracted-audit/results/I004_results.md` | this file |

## Method

Fresh `npm run extract:lt` tree. Read-only `rg`/`awk` queries over the extracted `.asm` for: the location-name table (`lib_014536_part2`), the scene table (`table_0099B4`, `asset_list_028000`), the per-world enemy tables (`meta_tables_008000`), the chest table (`table_00A9DE`), the item name table (`lib_shared_014F74`), the `COP [0A]` grant sites, the level-up code and EXP table, and the dialogue strings of every `w0_`..`w6_` actor. The queries were one-off reads; no script was written to the repository and nothing was written to a names, notes or comments file.

## Findings

### Matched exactly

- All 97 scenes map to a ROM location name and a walkthrough area; area names such as `Aurora s Ridge`, `A passage to Lune`, `Dazzling Space`, `A corridor to the dock` equal the walkthrough headings.
- All 64 item ids have a ROM name; every key item and every sword, armour and spell has a grant site (chest records or `COP [0A]` actors) in the section the walkthrough names. Gem chests and empty chests in `table_00A9DE` equal the walkthrough treasure checklists.
- Pause-menu grid positions equal item id `$19 + (r-1)*10 + (c-1)`.
- Weapon strength (`+1..+12`) and armour defence (`+1..+12`) are in `lib_0118FC_part13.binary_0161AC` and equal `items.md`.
- The EXP table `data_00F9F7.word_00FBB8` equals the walkthrough EXP column for all 49 level steps (checked row by row). HP +2 per level capped at 100 equals the walkthrough.
- All five souls and all six stone grants (Brown, Green, Blue, Silver, Purple, Black) have an actor.
- Of the 73 rows of the walkthrough bestiary, 63 match a meta record on (HP, EXP) (including the Metal Mantis, 50/50). The three statues (50 HP, 30 EXP per entry) match by hand. Ten rows have no exact match: the four boss rows with off-by-9/1 HP, Deathtoll (200 total), Purple Bull, Toy Calvary, Ghost Ship Torches, Ice Crystal.

### Discrepancies (all in the questions file)

| OQ | Item |
|----|------|
| 1 | boss HP 69/79/89/99/99 in the ROM vs 70/70/80/90/100 |
| 2 | Purple Bull 23 vs 45 HP |
| 3 | Toy Calvary 29/175 vs 24/175 or 20/170 |
| 4 | Monster Blocks EXP 2 vs 3 |
| 5 | dictionary spellings `Deathtole`, `Liesa` |
| 6 | item spelling differences (`Recover Sword`, `Emblem`, `Leaves`) |
| 7 | Skeleton Soldier without a bestiary row |
| 10 | strength/defence caps 13/12 not visible in `code_002F56` |
| 15 | walkthrough-internal naming variants |

### Not located (OQ-I004-9, 11, 12, 13)

Spell gem costs, weapon minimum levels, armour effects, the per-lair monster roster, Fairy Gem EXP amounts, and the lair or script that spawns each boss.

### Corrections to earlier notes

- The plan text "enemy records (`data_00BA0D`, 420 x 32 bytes)" is wrong: `data_00BA0D` holds lair and release records. Enemy HP, defence and EXP are in `meta_tables_008000`. Recorded in the crosswalk (section 13).
- A first reading of the Magic Bell exchanger as a squirrel in the GreenWood bank was wrong: `w1_actor_01BF32` is the fairy (Fairy Gem) west of the great tree in the Woods of GreenWood, as in the walkthrough.

## Gate (real project)

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK, 704 files, stale files removed: 0 |
| `npm run rebuild` | SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes (unchanged) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | 0 errors, 0 warnings, 0 orphans (0 comments, 26 part notes, 4 block notes) |

`extracted/` is still in the line-tracked form produced by `extract:lt` (the same state as after I003). Run `npm run extract` first if the plain form is wanted in a commit.

## Suggested commit message

```
docs(blazer): walkthrough crosswalk (P1, I004)

Map walkthrough worlds, areas, bosses, items, spells, souls, enemies, NPCs
and sidequests to ROM evidence (scenes, chest table, meta tables, grant
actors, level table). Propose the actor naming convention. Log 15 open
questions, 9 of them tagged DISCREPANCY. No project data changed; SHA-1 unchanged.
```

Please commit when you're ready.
