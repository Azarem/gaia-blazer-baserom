# I034 results (PC annotate actor batch grass_valley)

## Scope

The 13 actor, enemy, boss and front end files of group `grass_valley`: the village actors (`gv_village_actors_018000`, `gv_village_actors_019475`), `gv_multi_area_actors`, the Leo's Paintings and Underground Castle actors, the three enemy files and the boss `gv_boss_metal_mantis`, the Up Above actors with the name entry, the trial room Magician with the closing Lisa and Turbo scene, `gv_front_end` (boot, title, prologue, ending, staff roll) and the stub `gv_unreferenced_string_stub_01A4F9`. The four text blocks (`gv_title_texts`, `gv_prologue_texts`, `gv_epilogue_texts`, `gv_watching_over_world_texts`) were only read (notes from I029).

## Depth

Actors, light: a name from the walkthrough or the lair record, a block note (role, trigger, flags, dialogue) and a part note per actor root with In / Out / Clobbers and When / Sees / Why. Comments only where the logic is not obvious (flags, scene reloads, shared counters). Every comment has an `expect` guard.

## Counts

| | Before | After |
|-|-------:|------:|
| Names | 1647 | 1763 (+116) |
| Part notes | 754 | 904 (+150) |
| Block notes | 78 | 91 (+13) |
| Comments | 826 | 877 (+51) |
| Mnemonics (by hand) | - | +2 (`file_select_request` `$0445`, `front_end_step` `$0482`) |

(Counts are the I033 results against the current gate; the 116 / 150 / 13 / 51 are exactly the sums of the six name specs and six merge specs below.)

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK |
| `npm run rebuild` | OK, SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, unchanged (also with the two new mnemonics) |
| `npm run names -- --check` | OK (1763 names) |
| `npm run merge -- --check` | 877 comments, 904 part notes, 91 block notes against 151 extracted files; errors 0, warnings 0, orphans 0, duplicates 0 |

## Main findings

- **Village and Underground Castle:** the actors follow the walkthrough chapter 2 (Lisa, the old woman, the architect, the bridge guard, the water mill, the goat pen); the Underground Castle fairy gives 30 EXP once (`$1C02`) and offers the return to Grass Valley; the elevator is split into three actors; the seven push-zone tables are named by the location ids the setup actor tests.
- **Enemy identities come from the lair records.** Type byte `+$15` of the record -> `WorldMetaPointers` row -> placement scene -> walkthrough bestiary. This corrected one early guess: `$22` is the Walking Bush and `$23` the Fly (OQ-I034-10).
- **Metal Mantis:** the boss script has fireballs, shots and two arm actors, selected by the hero's Y; the silver phase is not a separate state (OQ-I034-12).
- **Name entry and hub:** `gv_obj_name_entry_voice_00797B` runs once (`$1F06`). The hub A00S09 is a seven-stop path walker with six gates `$1B00`-`$1B05`; `B` on a stop warps to A00S01-A00S07. The post-ending cut scene replaces the walker when `$1F04` (set in the World of Evil) is set and `$1F05` is clear (OQ-I034-14).
- **Closing scene:** two passes of A00S0D chosen by the hero's tile (`COP 0D`), the Master's farewell, Lisa and Turbo, the Yes / No question and THE END. The staff roll in `gv_front_end` jumps to it with `COP 10` (arrival animation 2).
- **Front end:** boot loader, Mode 7 title with an HDMA split (`7F 0F 60 09 00` / `7F 11 60 14 00`), 14 prologue pages with fade actors, Start -> file select via `scene_variant = 1` and `file_select_request = 1`; the ending has a TM curtain and a BG2 parallax. `$0482` is the step counter (answers OQ-I024-6).
- **Discrepancies (never resolved by invention):** 'Recover Sword' (ROM) vs 'Recovery Sword' (walkthrough) (OQ-I034-3); Monster Blocks 3 EXP vs 2 (OQ-I034-11); `docs/areas-and-scenes.md` lists the A03 scenes in a different order than the placements (OQ-I034-17).
- **Not named on purpose:** `$0466` is used by `gv_front_end`, `we_deathtolls_shrine_actors` and `engine_spawn_lairs_death_drops` (OQ-I034-16). The `gv_front_end` block note calls it `ending_page_flag`, which is a description, not a mnemonic.

## Corrections made while writing

- Facts written from memory in I034c were checked against the asm, placements and docs and corrected before the merge (push-zone coordinates, HDMA bands, fairy flow, quotes). Walkthrough quotes that did not belong to a table were dropped; speculative statements were removed.
- In the last two specs `COP 10`'s second operand is the arrival animation (`warp_dest_anim`), not a variant; the front end and closing scene notes say so.

## Files changed (not committed)

- `plans/extracted-audit/renames/apply-I034a_names.json` to `apply-I034e_names.json`
- `plans/extracted-audit/edits/I034a.json` to `I034f.json`
- `plans/extracted-audit/questions/I034_questions.md`, `plans/extracted-audit/results/I034_results.md`, `plans/doc-audit/I034_checklist.md`
- Hand edit: `us/mnemonics.json` (+2)
- Tool output: `us/names/bank00.json`, `bank01.json`, `bank0F.json`, `us/blocks.json` (part and block references), `notes/blockNotes|partNotes|comments/bank00.json`, `bank01.json`, `bank0F.json`, `extracted/**` (from `extract:lt`: run `npm run extract` before committing if the `; {n}` tags are not wanted). The working tree also holds changes of other batches (greenwood, leo's lab, cop handlers and so on) that are not part of this step.

## Open questions

18 rows in `questions/I034_questions.md` (`OQ-I034-1` to `-18`; DISCREPANCY on -3, -11 and -17).

## Suggested commit message

```
Annotate actor batch grass_valley (I034)

Name and document the 13 actor, enemy, boss and front end files of
grass_valley: village, Underground Castle, Leo's Paintings, the Metal
Mantis, the Up Above hub and name entry, the trial room Magician, the
closing scene with Lisa and Turbo, and the boot/title/ending actors.
116 names, 13 block notes, 150 part notes, 51 comments, 2 mnemonics
(file_select_request, front_end_step). ROM SHA-1 unchanged. Open
questions OQ-I034-1..18 (enemy identities, hub, front end visuals,
Recover/Recovery Sword).
```

Please commit when you're ready.
