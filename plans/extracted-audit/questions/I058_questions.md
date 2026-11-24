# I058 open questions (docs/code/README.md hub, docs/worlds/*.md, docs/walkthrough-crosswalk.md)

IDs are scoped to this iteration and cover only new findings. Nothing here is written into names, `blocks.json`, `overrides.json` or the docs as fact. Mode: R = static read only, R+S = read, then confirm with a short Mesen2 run, S = needs a runtime run, D = needs a decision.

The seven world pages were checked against the walkthrough chapter of their world, the ROM text and the earlier open questions. They add no new DISCREPANCY: every mismatch they list is an existing OQ (OQ-I004-1 to OQ-I004-7, OQ-I004-10, OQ-I004-15 and their refinements). The three items below are housekeeping findings of the iteration.

Settled statically by this iteration (no new row):

- The comment of the dolphin's `COP [07]` in `se_seabed_sanctuary_actors_0F8000` named `se_npc_servas_son_0FA23B`, a label that does not exist (0FA23B is the father, the son is `se_npc_servas_son_0FA3A5`); corrected through `edits/I058.json`.
- `OQ-I004-7` (Skeleton Soldier): the block notes of `mc_castle_dungeon_enemies` match the chapter 07 name to `mc_enemy_skeleton_soldier_0FE236` (`w5:$10`, HP 23, EXP 750). The match is now confidence C; what stays open is that the bestiary has no row for it.

| ID | Tag | Question | Static evidence so far | How to settle | Mode | Pri | Mesen2 tool |
|----|-----|----------|------------------------|---------------|------|-----|-------------|
| OQ-I058-1 | D | OQ-I033-1 (combat document) and OQ-I004-1 (crosswalk) ask the same question about the HP of the bosses. Keep both ids or retire one? | Both rows list the same five bosses (Floating Skull 69, Poseidon 79, Tin Doll 89, Demon Falcon 99, Deathtoll Mage 99); `docs/walkthrough-crosswalk.md` and the world pages cite OQ-I004-1 with the refinements OQ-I033-1, OQ-I039-3 and OQ-I040-2. | Decide which id is canonical; the docs name OQ-I004-1. | D | P3 | none |
| OQ-I058-2 | GAP | `plans/doc-audit/walkthrough-crosswalk.md` still uses the labels of the first mapping (`w0_actor_01AB4F`, `common_actor_0033C6`, `lib_0118FC_part13`). Refresh the full tables to the current labels? | `docs/walkthrough-crosswalk.md` gives the current labels for bosses and for the rows that differ; the offset suffix is unchanged, so a search by suffix finds the current label. | Re-run the crosswalk against a fresh `extract:lt` in a later iteration. | D | P3 | none |
| OQ-I058-3 | GAP | The folder and file names `deathtolls_shrine` and `we_deathtolls_shrine_actors` use "deathtolls" (walkthrough: Deathtoll's Shrine; ROM dictionary: `Deathtole`). Is the plural a name or a typo? | The ROM banner prints `Deathtoll s Shrine`; the dictionary entry `$06` spells `Deathtole` (OQ-I004-5). `us/groups.json` and `us/files.json` use the key `deathtolls_shrine`. | Settle OQ-I004-5 first, then rename the group key and the file through `npm run names` and `blocks` if the spelling changes. | D | P3 | none |
