# Soul Blazer documentation and analysis: rules

Working folder of the plan "Blazer docs and analysis" (`c:\Users\azare\.cursor\plans\blazer_docs_and_analysis_e740ea3f.plan.md`). Phases: P0 tooling, P1 walkthrough crosswalk, PA read-only function map, PB placement audit and regroup, PC names/notes/comments, PD `docs/code`, PQ open-question inventory, final audit.

| Path | Content |
|------|---------|
| `baseline.md`, `baseline-audit.txt` | numbers measured before any documentation work (P0, iteration I003) |
| `function-map/` | PA output, `FM-<Ax>.md` (A1..A11) |
| `placement/` | PB output: `placement-audit.md`, `spike-decision.md`, `pinned.md` |
| `mesen2/` | PQ output: `question-inventory.md` |
| `walkthrough-crosswalk.md` | P1 output |
| `final-audit.md` | final audit output |

Iteration records live in `plans/extracted-audit/{edits,renames,results,questions}/` as `I0nn_*` (numbering continues from I003; an iteration is done when its results file exists; never edit an older one).

## Source of truth

Priority for game facts:

1. `docs/walkthrough/` (KeyBlade999 guide: `README.md`, `01..08-*.md`, `items.md`, `magic.md`, `enemy-bestiary.md`, `level-up.md`, `sidequests.md`): world, area, boss, NPC, item, magic and enemy names, progression, sidequests.
2. In-ROM text (the location-name table `asciistring_list_0147C2`, dialogue): exact in-game spelling and behaviour.
3. Handler asm: how things work.
4. Mesen2 runtime evidence.

The walkthrough is not verified against the ROM. Never invent a game fact; use placeholders such as `[NPC at area 0B scene 03]` until matched. A walkthrough-versus-ROM mismatch is an `OQ-I0nn-k` row with tag `DISCREPANCY` in the iteration's questions file, never silently resolved.

## Rules for every step

- Notes and comments change only through `npm run merge -- <spec> [--dry-run]`; names only through `npm run names -- <spec> [--dry-run]`; block structure only through `npm run blocks -- <spec> [--dry-run]`. No ad-hoc scripts. If a tool lacks a feature, extend `src/`, document it in `gaia-core/docs/notes-and-comments.md` and tell the user.
- Name rows take `address` and `old` from `npm run extract:lt` output; sub-labels need their own rows; rename a parent only after reading its sub-labels.
- LoROM: file offset to SNES bank is `offset >> 15`; notes and names files are keyed by `floor(offset / 65536)`. Never compare the original ROM with the rebuilt ROM; use `rebuilt/layout.json`.
- Assembler: `$&` same bank, `$@` long; bare `LSR`/`ASL`/`INC`/`DEC`/`ROL`/`ROR`; hex label offsets; COP code needs X = D = actor slot.
- Work from a fresh `npm run extract:lt`. Write each record file once with the Write tool.
- The agent never commits. Every results file ends with a suggested commit message; the user commits.
- Comment standards: `gaia-core/docs/notes-and-comments.md` "Comment Authoring Guide" and `gaia-knowledge/curated/gaialabs/code-bank-documentation.md`: read first, comment second, explain why not what, answer the Three Questions (when it runs, what the player sees, why it exists) for each routine.

## Tools (P0)

| Command | Use | Reference |
|---------|-----|-----------|
| `npm run audit` | read-only coverage (block note, part notes, comments, auto-named labels) and the cross-file reference matrix, top fan-in, findings; `-- --blocks [--group=<g>]`, `-- --block=<name>`, `-- --matrix`, `-- --top=N`, `-- --json=<path>` | `gaia-core/docs/notes-and-comments.md` §"Audit Report" |
| `npm run blocks -- <spec.json> [--dry-run]` | `merge`, `move-part`, `rename`, `set` (`scene`, `group`, `order`, `movable`) with scratch extract+rebuild verification | `gaia-core/docs/notes-and-comments.md` §"Blocks Merge", `gaia-core/docs/rom-mapping-guide.md` §9.3a |

## Gate after every iteration

1. `npm run extract:lt`
2. `npm run rebuild`
3. `npm run names -- --check`
4. `npm run merge -- --check`
5. SHA-1 unchanged for annotation-only iterations. Current gate value: `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` (1,081,344 bytes, checksum 110070696, since I042: wave 6, final layout of the core engine and library; 10 merges, 4 part splits, 2 part moves and the block renames changed it). Earlier values: `3148390e...` (I022 to I041: PB3 wave 5, strings and data merged with their users, helpers by subsystem; checksum 110068443), `e061c9e4...` (I021: wave 4, regroup of the world groups and `actor_shared`; the 5 renames add no byte change of their own), `3939c4be...` (I020: wave 3, regroup of `common`), `1b5950f9...` (I019: wave 2, COP handlers and bank 0 engine blocks; also the value after every rename and `set` of I020), `6a8224ed...` (I018: wave 1, 32 single-caller merges), `b6087e4d...` (I017: wave 0, nine fall-through units), `1af812e1...` (I018 before the souls strings were joined), `fdafd6c9...` (I016: R-2 transform, `meta_tables_008000` pinned to bank 1, `lib_animation` regrouped and movable), `65ff27aa...` (I001-I015), `f20dcbdf...` (R-2 transform only), `6224eaf9...` (plus the bank-1 pin).

Regroup iterations (`npm run blocks`) also need: per-label asm-text equivalence and 0 undefined references (both are checked inside `blocks`, in a scratch folder, before it writes), a rebuild, and a Mesen2 runtime comparison (title to a world, a menu, a boss). A regroup moves code inside banks, so its SHA-1 changes: record the new value in the results file and use it as the next gate value. A pure rename, or a `scene`/`order` change, must keep the SHA-1.

After a `blocks` run, `npm run extract:lt` sweeps stale files; commit the moved `extracted/` files with the `us/blocks.json` change.

## Open-question rows

Every iteration writes `OQ-I0nn-k` rows: question, static evidence, the check that would settle it, mode (R runtime, R+S static then runtime, S static, D decision), priority (P1-P3), the Mesen2 tool or recipe (breakpoints, `get_cdl_data`, `read_memory`, `trace_between`, `run_script`), and a tag (including `DISCREPANCY`). The final consolidation is `mesen2/question-inventory.md`. Keep `compare_runs` watches few: 232 watches timed out.
