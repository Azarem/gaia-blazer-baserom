# I039 results (PC annotate actor batch magridds_castle)

## Scope

Group `magridds_castle`, 9 blocks in 9 files (file offsets 147368-159834 for the actors and texts, 1039944-1042972 for the enemies, 19438-19850 for the boss):

| Block | File | Part of the work |
|-------|------|------------------|
| `mc_castle_actors` | `magridds_castle/castle_of_magridd/mc_castle_actors.asm` | the soldiers, maids, singers, the Queen and King Magridd of the castle town (A10S01), with their arrival children |
| `mc_airship_dock_actors` | `magridds_castle/airship_dock/mc_airship_dock_actors.asm` | the dock cutscene (A13S01), the soldier's dream (A13S03), the key wheel and take-off, the airship deck pieces (A13S02) |
| `mc_boss_demon_falcon` | `magridds_castle/airship_dock/mc_boss_demon_falcon.asm` | the Demon Falcon with the fire stream and the wing dust |
| `mc_castle_dungeon_actors` | `magridds_castle/castle_dungeon/mc_castle_dungeon_actors.asm` | harp string pick-up, dungeon fairy, floor spikes |
| `mc_castle_towers_actors` | `magridds_castle/castle_towers/mc_castle_towers_actors.asm` | prison fairy, corridor scroll |
| `mc_castle_dungeon_enemies` | `magridds_castle/castle_dungeon/mc_castle_dungeon_enemies.asm` | wall spears, statue shooters, Bouncing Ball, Wraithe, Green Snake, Skeleton Soldier, wall prop |
| `mc_castle_towers_enemies` | `magridds_castle/castle_towers/mc_castle_towers_enemies.asm` | Purple and Red Knight, statue shooters, Mimic, Bronze Robot, Chess Knight, static prop |
| `mc_return_prompt_and_chest_hint_texts` | `magridds_castle/mc_return_prompt_and_chest_hint_texts.asm` | the fairy's chest hint and the return prompt |
| `mc_unreferenced_string_stub_02623C` | `magridds_castle/mc_unreferenced_string_stub_02623C.asm` | block note only |

Depth: actors, light (a name from the walkthrough, a block note with role, trigger, flags and dialogue, a part note per root and per helper actor, comments only for non-obvious logic). The Demon Falcon got the state machine because it is a boss.

## Counts

| Item | Count |
|------|-------|
| Names added / renamed (`renames/apply-I039a..h_names.json`) | 303 spec rows (names total now 2457) |
| Block notes | 9 |
| Part notes | 124 (34 + 43 + 14 + 21 + 12) |
| Comments | 69 (21 + 27 + 6 + 8 + 7), each with an `expect` guard |
| Mnemonics | 0 (no evidence for a mnemonic name was found; `us/mnemonics.json` untouched) |
| Open questions | 12 (`questions/I039_questions.md`) |

Merge specs: `edits/I039a.json` (castle town), `I039b.json` (dock and dream, dungeon actors, tower actors, texts, stub), `I039c.json` (Demon Falcon), `I039d.json` (dungeon enemies), `I039e.json` (tower enemies). Each was dry-run first, applied, and followed by `npm run extract:lt`. Names specs `g` and `h` were added after reading the dock and boss code: `g` renamed Lisa's arrival (it falls through into her crying script, so it was not an escort), named the Dr. Leo scene routines, and moved the deck pieces from `mc_dock_*` to `mc_deck_*`; `h` renamed the boss's 'feather' pieces to 'fire' (the walkthrough calls the attack 'Fire Streams'; nothing in the data says feather).

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK |
| `npm run rebuild` | OK, SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes (unchanged) |
| `npm run names -- --check` | OK (2457 names) |
| `npm run merge -- --check` | OK (1297 comments, 1458 part notes, 136 block notes; 0 errors, 0 warnings, 0 orphans) |

## Findings

- Every castle NPC is released by a lair of the dungeon or the towers: the switch id is the lair record index, and its +9 byte names the speaker ($2F soldier, $30 maid, $31 singer, $32 King Magridd, $34 Queen). The arrival children (COP 30) say a second line when the hero comes home through that record.
- The dock scene is a chain of flags between actors: Dr. Leo's talk sets `$0000`, the soldier is shot (`$0001`), the four intruders strike three times (`$0003`, `$0000`), Lisa and the escort walk in (`$0007`), the key is handed over at tile ($1E,$18) (item `$23`), and the explosion chain sets `$0006`, after which `$0805` marks the scene done. After the boss, `mc_deck_airship_return_026D80` sets `$0900`, which turns Lisa's script into the question and Leo's into a farewell.
- The soldier's dream (A13S03) sets `$0803` and sends the hero back to the sleeper's tile ($02,$1F), where the sleeper wakes up and gives the Elemental Mail.
- The Demon Falcon has two attack branches (5 in 8 swoop, 3 in 8 strafe with fire streams) and is the monster of boss lair `$195`; its HP in the ROM is 99 against 90 in the walkthrough.
- The wall spear carries the immunity class `$0200`, the Wraithe `$0800` (Spirit Sword only), as documented in `CheckImmunityClass`.
- Discrepancies against the walkthrough, logged as OQs: Elemental Armor / Mail (OQ-I039-1), Demon Falcon HP (OQ-I039-3, with OQ-I033-1), the Skeleton Soldier and wall spear stats (OQ-I039-5, with OQ-I033-3).

## Corrections

None to notes of earlier iterations. In this iteration the first draft of `edits/I039a.json` had wrong readings of the Queen's flag, the theater guard and the king's wait flag; they were corrected before the dry-run. Before applying `I039b.json`, invented walkthrough quotes were replaced with the real wording, and the OQ number for the unreferenced text was changed from -8 to -12 in the texts block note (the dry-run reported it as an update).

## Files changed

- `us/names/bank00.json`, `us/names/bank02.json`, `us/names/bank0F.json` (303 spec rows), plus the references that `npm run names` rewrote in `us/blocks.json` and the notes
- `notes/blockNotes/bank00.json`, `bank02.json`, `bank0F.json`; `notes/partNotes/bank00.json`, `bank02.json`, `bank0F.json`; `notes/comments/bank00.json`, `bank02.json`, `bank0F.json`
- `extracted/magridds_castle/**` (regenerated by `extract:lt`; the line-tracking annotations are in the working tree, run `npm run extract` for a clean commit)
- `plans/extracted-audit/renames/apply-I039a..h_names.json`, `edits/I039a..e.json`, `questions/I039_questions.md`, `results/I039_results.md`, `plans/doc-audit/I039_checklist.md`

## Open questions

12, see `questions/I039_questions.md`; the main ones are OQ-I039-1 (Elemental Armor or Mail), OQ-I039-3 (Demon Falcon HP), OQ-I039-5 (Skeleton Soldier and spear stats) and OQ-I039-7 (the speakers of the dock scene).

## Suggested commit message

```
I039: annotate actor batch magridds_castle

Name 303 parts and document the castle town NPCs, the dock cutscene and
dream, the Demon Falcon, the dungeon and tower actors and enemies:
9 block notes, 124 part notes, 69 guarded comments, 12 open questions.
ROM SHA-1 unchanged.
```

Please commit when you're ready.
