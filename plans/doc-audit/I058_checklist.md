# I058 checklist: hub `docs/code/README.md`, the seven `docs/worlds/<world>.md` pages, refreshed `docs/README.md`, `docs/areas-and-scenes.md`, `docs/wram-memory-map.md`, and `docs/walkthrough-crosswalk.md`

PD step "hub and worlds" of the plan "Blazer docs and analysis". Written before the first edit; the Progress section is updated as items finish.

Rules in force: notes and comments change only through `npm run merge`, names only through `npm run names` (dry-run first); no ad-hoc scripts for notes, comments or names; no commits; no comparison of the original ROM with the rebuilt ROM (the rebuilt places are only named through `rebuilt/layout.json`); every claim cites a label, a file or a document; the walkthrough is the source of truth for game names and facts, the ROM text for exact spelling and behaviour; every mismatch is an OQ with tag DISCREPANCY; record files (this checklist, `questions/I058_questions.md`, `results/I058_results.md`, each document) are written once with the Write tool. Read-only surveys (bank map from `us/blocks.json` and `us/files.json`, `?INCLUDE` closure, link and identifier checks) write nothing into the repository.

## Scope

Documents to write or refresh:

| Document | Action |
|----------|--------|
| `docs/code/README.md` | new: the hub the 15 spokes already link to (`*Part of the [Soul Blazer Code Documentation](README.md)*`): ROM and bank map, address ranges by category, file inventory (all 136 extracted `.asm` files), compilation units (`?INCLUDE`), call chains, document suite and relationship map, calling conventions, key WRAM variables (pointers only), design patterns, `blocks.json` structure, related resources |
| `docs/worlds/grass_valley.md`, `greenwood.md`, `st_elles.md`, `mountain_of_souls.md`, `leos_lab.md`, `magridds_castle.md`, `world_of_evil.md` | new, light: area and scene mapping, actor files, roster by name (walkthrough names, current labels), enemies, boss, sidequest hooks, each tied to its walkthrough chapter; the seven pages are written in parallel from one template |
| `docs/README.md` | refresh: link every page (hub, 15 spokes through the hub, 7 worlds, crosswalk), drop the "not yet written" paragraph |
| `docs/areas-and-scenes.md` | refresh: world table gets the world pages, the actor files per block group (the labels of the regroup), the boss per world, links to the hub and the crosswalk |
| `docs/wram-memory-map.md` | refresh: names added since the last refresh (`file_select_request`, `front_end_step`), stale "left unnamed" entries, links to the 15 spokes |
| `docs/walkthrough-crosswalk.md` | new: the summary of `plans/doc-audit/walkthrough-crosswalk.md` with current labels and the DISCREPANCY index |

Inputs: the 15 spokes of `docs/code/`, `docs/cop/index.md`, `docs/audio/`, `plans/doc-audit/walkthrough-crosswalk.md` (I004; its actor labels predate the I034-I042 renames and are re-resolved against `extracted/`), `plans/doc-audit/placement/pinned.md`, `spike-decision.md`, the block notes (`notes/blockNotes/`), `us/blocks.json`, `us/files.json`, `us/groups.json`, `us/config.json`, `us/mnemonics.json`, the walkthrough chapters, every `plans/extracted-audit/questions/I0nn_questions.md` that a page cites.

Not repeated: anything a spoke already explains. The hub names the subject, links the spoke and shows only what no spoke owns (the bank map, the file inventory, the inclusion tree, the call chains that cross spokes).

## To do

- [x] Fresh `npm run extract:lt` before any edit.
- [x] Read the required documents (plan, `plans/doc-audit/README.md`, `code-bank-documentation.md`, the mapping plan §0 and §8c-8e, the walkthrough README, the crosswalk, the pinned and spike records, the overviews of the 15 spokes).
- [x] Survey (read-only): bank map from `us/blocks.json` and `us/files.json`, asset counts, `?BANK` and `?INCLUDE` of every file, the labels and block notes of the world files, mnemonics against the WRAM document.
- [x] Write this checklist.
- [x] Spawn the seven world-page agents (one page each) with the shared template; collect their lists of mismatches.
- [x] Write `docs/code/README.md` (one Write call).
- [x] Write `docs/walkthrough-crosswalk.md` (one Write call).
- [x] Refresh `docs/README.md`, `docs/areas-and-scenes.md`, `docs/wram-memory-map.md`.
- [x] Verify: every relative link of the new and refreshed documents resolves; every spoke, world page and reference page is linked from the hub; every backticked identifier exists in `extracted/`, `us/` or the documents; the walkthrough names in each world page match `docs/walkthrough/`.
- [x] Write `plans/extracted-audit/questions/I058_questions.md` (OQ-I058-k, DISCREPANCY rows from the world pages and the crosswalk refresh).
- [x] Gate: `npm run extract:lt`, `npm run rebuild` (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`), `npm run names -- --check`, `npm run merge -- --check`.
- [x] Write `plans/extracted-audit/results/I058_results.md` with the suggested commit message. Do not commit.

## Progress

- Survey and checklist done; extraction is fresh (136 `.asm` files, 81,763 lines, 353 asset files).
- World pages written by seven parallel agents and checked (links, OQ ids, identifiers); two slips fixed (Deathtole spelling, stale label row).
- Hub, crosswalk summary, README, areas-and-scenes and WRAM map written or refreshed; one comment corrected through edits/I058.json.
- Gate passed (extract:lt, rebuild SHA-1 unchanged, names --check, merge --check). Results: plans/extracted-audit/results/I058_results.md; questions: plans/extracted-audit/questions/I058_questions.md.
