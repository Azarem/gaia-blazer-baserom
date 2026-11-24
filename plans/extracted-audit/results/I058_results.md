# I058 results: code hub, world pages, crosswalk summary and refreshed indexes

Step "PD hub and worlds" of the plan "Blazer docs and analysis". ROM unchanged (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`). One comment corrected through `merge`; no name, block or override changed.

## What was written

| Document | Action | Lines |
|----------|--------|------:|
| `docs/code/README.md` | new: the hub the 15 spokes link to. Overview and metrics, document suite (15 topic documents, 7 reference documents, 7 world pages) with a relationship diagram of 15 nodes, ROM and bank map `$00`-`$1F`, address ranges by category, the inventory of all 136 `.asm` files (system 35, library 25, COP handlers 5, shared actors 4, world folders 67) and of the 23 asset groups, compilation units (the four `?INCLUDE` layers), calling conventions, key WRAM variables (pointers), eight cross-file call chains, design patterns, `blocks.json` structure, related resources | 516 |
| `docs/worlds/grass_valley.md`, `greenwood.md`, `st_elles.md`, `mountain_of_souls.md`, `leos_lab.md`, `magridds_castle.md`, `world_of_evil.md` | new: areas and scenes with `loc` and ROM names, actor files, roster, enemies, boss and set pieces, sidequest hooks, walkthrough cross-check, open questions (written by seven parallel agents from one template, then checked) | 208, 188, 201, 176, 199, 205, 151 |
| `docs/walkthrough-crosswalk.md` | new: how to read the ids, the confidence codes, the worlds, the eight bosses with current labels, the items and enemies that differ, the DISCREPANCY index, the actor-name convention | 112 |
| `docs/README.md` | refreshed: hub, 15 spokes, reference pages, 7 world pages, crosswalk; the "not yet written" paragraph is gone | 46 |
| `docs/areas-and-scenes.md` | refreshed: world pages and meta lists, scene counts and world per area (22 areas, 97 scenes), boss scene table, links | 88 |
| `docs/wram-memory-map.md` | refreshed: `file_select_request` (`$0445`) and `front_end_step` (`$0482`) added to §2, the stale "left unnamed" entry for `$0482` removed (`$0466` stays, with its two OQs), breadcrumb, new §9 that maps each section to its topic documents | 301 |
| `plans/extracted-audit/edits/I058.json` | merge spec: one comment correction | |
| `plans/extracted-audit/questions/I058_questions.md` | three rows | |

## Corrections found while checking

- `docs/worlds/magridds_castle.md` said `Deathtolle`; the ROM dictionary spells `Deathtole` (`data_dictionary`, entry `$06`). Fixed.
- `docs/worlds/greenwood.md` had a row about a stale crosswalk label; the row is gone (the crosswalk summary now explains the label change once).
- The comment of the dolphin's `COP [07]` in `se_seabed_sanctuary_actors_0F8000` named `se_npc_servas_son_0FA23B` (that label does not exist; 0FA23B is the father, the son is `se_npc_servas_son_0FA3A5`, which sets flag `$0704`). Corrected through `edits/I058.json` (comment `1015849` in `notes/comments/bank0F.json`).

## Open questions

| ID | Tag | Short |
|----|-----|-------|
| OQ-I058-1 | D | OQ-I033-1 and OQ-I004-1 are the same boss-HP question; which id is canonical |
| OQ-I058-2 | GAP | the full tables of `plans/doc-audit/walkthrough-crosswalk.md` still use the first-mapping labels |
| OQ-I058-3 | GAP | the plural in `deathtolls_shrine` and `we_deathtolls_shrine_actors` against the dictionary `Deathtole` |

No new DISCREPANCY about game facts: every mismatch in the world pages is an existing OQ (OQ-I004-1 to -7, -10, -15 and their refinements OQ-I033-1, OQ-I039-3, OQ-I040-2).

## Gate

| Step | Result |
|------|--------|
| `npm run merge -- plans/extracted-audit/edits/I058.json --dry-run`, then applied | 1 comment updated; `notes/comments/bank0F.json` written |
| `npm run extract:lt` (after the merge) | OK; the corrected text is on line 92 of `extracted/st_elles/seabed_sanctuary/se_seabed_sanctuary_actors_0F8000.asm` |
| `npm run rebuild` | OK; SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` (unchanged), 1,081,344 bytes |
| `npm run names -- --check` | OK (2765 names) |
| `npm run merge -- --check` | OK: 1401 comments, 1684 part notes, 135 block notes; errors 0, warnings 0, orphans 0, duplicate keys 0 |
| link check of the new and refreshed documents | every relative link and anchor resolves; every `OQ-Innn-k` cited exists in `plans/extracted-audit/questions/`; every routine name in the hub exists in `extracted/` |
| hub completeness | every document under `docs/` except the eight walkthrough chapters and their five sub-pages is linked directly from the hub (the walkthrough is linked through `walkthrough/README.md`); all 136 extracted `.asm` files are named in the hub |

What the checker still lists is not an error of these documents: prefixes written as `gv_`, `cm_`, extension examples (`.asm`, `.bin`), placeholders (`bankNN`), link texts that name a file in another repository, and bare file names such as `level-up.md` and `enemy-bestiary.md` in older spokes.

## Follow-ups

- Refresh the full tables of `plans/doc-audit/walkthrough-crosswalk.md` to the current labels (OQ-I058-2).
- Decide the canonical id for the boss-HP question (OQ-I058-1); the documents cite OQ-I004-1.
- The walkthrough names in the world pages were matched by the writing agents and spot-checked (Grass Valley, Magridd's Castle, Greenwood, World of Evil); a runtime check of the chest and flag claims in the pages is still open (the pages mark them static).

## Suggested commit message

```
docs: add the code hub, the seven world pages and the crosswalk summary (I058)

docs/code/README.md is the hub the fifteen spokes link to: bank map, file
inventory of all 136 extracted files, include layers, calling conventions,
cross-file call chains, document suite. docs/worlds/<world>.md describes
each world (areas and scenes, actor files, roster, enemies, boss, walkthrough
cross-check). docs/walkthrough-crosswalk.md summarises the walkthrough to ROM
mapping with current labels and the DISCREPANCY index. Refreshes
docs/README.md, docs/areas-and-scenes.md and docs/wram-memory-map.md
(file_select_request, front_end_step). Corrects one stale comment in
se_seabed_sanctuary_actors_0F8000. ROM unchanged.
```
