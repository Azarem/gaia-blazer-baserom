# I001 results (Pass 4: COP system)

Date: 2026-11-19. Spec files: `edits/I001.json` (merge), `renames/apply-p4-001_names.json` (108 COP handlers),
`renames/apply-p4-002_names.json` (two corrections after reading `code_0120F9`). Questions: `questions/I001_questions.md`.

## What was changed

| Item | Result |
|---|---|
| Names | 108 COP handler labels `Cop<ID>_<Name>` (`bank00.json`, 111 names in total). Names rewrote 107 references in `us/blocks.json`. The two corrections renamed `Cop0A_InventoryCall` -> `Cop0A_SetInventoryIfEmpty` and `Cop0B_InventoryClear` -> `Cop0B_ClearInventoryEntry` |
| Block notes | 4: `engine_00561E`, `cop_handler_006473`, `engine_0064F8`, `engine_0065A7` (`notes/blockNotes/bank00.json`) |
| Part notes | 26: dispatcher and its three tables, the exit chain (9 labels), flag/inventory helpers, slot/spawn/collision helpers, `code_0064CC`, `lib_0109D6_part3.code_0120F9`. `merge` created `notes/partNotes/bank01.json` (confirms item 4.1) |
| Inline comments | none |
| `us/copdef.json` | `06` now `&Code` (size 2), `89`-`8C` now `Word, &Code` (were four bytes), `8D`/`8E` now `&Code` (were size 0). All unused in the scripts, so the extracted asm and the ROM did not change |
| Docs | `docs/cop/index.md` (dispatch, exit chain, actor fields, 108 commands), `docs/areas-and-scenes.md`, `docs/README.md` |
| Tooling | the dangling `groups` command in `src/index.ts` was removed (see below) |

## Verdicts

- Every behavior in `docs/cop/index.md` was read from the handler asm (`extracted/cop_handlers/`), the exit chain
  and the helpers in `engine_0064F8` / `engine_0065A7`. A second reading of the handler bodies corrected the first
  draft in many rows (03-05, 0A, 0C, 0D, 14, 26, 36, 39, 3B, 81-83, 89-8C, 92, 94, 95, 9A, 9C, 9E, A2, A5, AA and
  the spawn helpers). The remaining rows (for example 17, 1C-1E, 20, 21-24, 28, 30-32, AB, AC, AF-B1) were read
  once; `3B` and `A3`-`A9` flag meanings are only partly understood (OQ-I001-3, OQ-I001-4).
- Names that state a mechanism instead of a purpose (not guessed): `Cop25_CallLib0276A5`, `Cop26_JumpIfLib0276C9`,
  `Cop3A_CallLib0124EE`, `Cop31/32_SpawnEngineActor<addr>`, `CopA8_SetFields22And24`, `CopA9_SetFields34And2C`,
  `CopA3/A4/A6/A7_*Flag1A*`.
- The COP table (`code_list_005638`) is now readable in `extracted/system/engine_00561E.asm`.

## Not done in this iteration

4.4 (block notes for the other ~700 blocks), 4.5 (scene loader, `meta_tables`, VRAM/DMA, NMI, main loop), 4.6
(comments), 4.8 `docs/code/bankNN/` and `docs/wram-memory-map.md`, 4.9 vectors/engine entry points/library/actors/
tables, and runtime confirmation of the handler names (OQ-I001-7).

## Gate

| Gate | Result |
|---|---|
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- <spec> --dry-run`, then apply | OK, 3 notes files written |
| `npm run merge -- --check` | 0 errors, 0 warnings, 0 orphans (26 part notes, 4 block notes, 704 files) |
| `npm run extract:lt` | OK, notes and names visible in `extracted/` |
| `npm run rebuild` | OK, SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes, unchanged from before Pass 4 |

## Tooling note

`src/groups-rename.ts` and the `groups` package script (from the area/scene rename) were no longer in the working
tree while `src/index.ts` still imported them, so every command (including `names`) failed. The unused import and
`case 'groups'` were removed from `src/index.ts`. The renames themselves are in `us/files.json` / `us/groups.json`
(spec kept in `plans/mapping/apply-areas_groups.json`).

## Suggested commit message

`Blazer mapping pass 4 (I001): COP handler names, dispatcher and helper notes, COP and area docs`
