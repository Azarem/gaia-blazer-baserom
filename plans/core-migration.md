# Blazer baserom → @gaialabs/core 1.0.7 migration

Goal: `npm run extract` / `npm run extract:lt` work against the current `@gaialabs/core` (linked from `../gaia-core`),
the `us/*.json` files use the current formats, and notes / comments / names use the new `merge` / `names` process.

Blazer last matched core ~0.2.x (March 2026). Core is now 1.0.7. `rebuilt/Soul Blazer (USA).sfc` is the original ROM
(input of extraction). Per `.cursor/rules`, the original ROM is never compared byte-wise with the rebuilt ROM and
`rebuilt/layout.json` is the only location reference for the rebuilt ROM.

## Analysis: what changed in core that affects this repo

| # | Area | Old (Blazer today) | New (core 1.0.7) | Action |
|---|------|--------------------|------------------|--------|
| 1 | `stringTypes.json` | `characterMap` + `shiftType`, dictionary `range` | `layers: [{ map, base?, shiftBit?, on? }]` (required); `range` ignored | convert (done) |
| 2 | `labels.json` | array of `{ location, label }` | `Record<address, label>` | convert (done) |
| 3 | `DbGameRomModule` | no `headers` | `headers` required (core exports `snes.headers`); `names`, `types`, `comments`, `blockNotes`, `partNotes` optional | wire in `src/index.ts` |
| 4 | `config.json` | `entryPoints` array of `{location, name}` | header vector fields `nativeCop`, `nativeBrk`, `nativeNmi`, `nativeIrq`, `emulationReset` (label names) + `gameTitle`, `countryCode`, `developerId`, `gameVersion`; `entryPoints` unused (`writeEntryPoints` is dead code) | rewrite config |
| 5 | `snes/` folder | local `addressingModes.json` (stale regexes: no `.` in names, no `A` accumulator parse), `opCodes`, `registers`, ... | core exports `snes.addressingModes`, `snes.vectors`, `snes.headers` | use core exports, delete local `snes/` |
| 6 | `mnemonics.json` | 190 SNES register names + 4 game names (`_TM`/`_TS`) | module spreads `snes.vectors` first; file holds game RAM names only | reduce to the 4 game entries |
| 7 | Type overrides | `overrides.json` `{"type": ...}` | `types.json` (address → type); overrides keep only M / X / B | create `us/types.json`, move 4 entries |
| 8 | Names | none (auto names `code_XXXXXX`, part names in blocks.json) | `us/names/bankNN.json` merged in `src/names.ts`; edited only with `npm run names` | create names layer + tool |
| 9 | Notes / comments | none | `notes/{blockNotes,partNotes,comments}/bankNN.json`, edited only with `npm run merge` | create notes layer + tool |
| 10 | Line tracking | none | `extract --linetracking` sets `config.emitLineTracking` → `; {address}` tags | add `extract:lt` |
| 11 | Extraction hygiene | `extract` overwrites into `extracted/` | `.extract-state.json` marker + stale sweep; `rebuild` refuses incomplete trees | port `src/extract-state.ts` |
| 12 | `rebuildAllContent` | returned `ChunkFile[]` | returns `{ masterLookup, files, header, romData }` | fix `rebuild()` (layout.json) |
| 13 | `DbPart` / `DbFile` / `DbOverride` | lenient | strict validation (name/type/start/end required) | run extraction, fix offenders |
| 14 | Dictionary ids (core) | `(command << 8) \| (base + ix)` | `((command ?? 0) << 8) \| ix` — **drops `base`** | Blazer's only dictionary is base-only (`base: 128`): rebuild compresses to the wrong byte. Needs a core fix (see "Open issues") |
| 15 | CLI | `extract`, `rebuild` only | `--flag` / `--key=value` parsing, `merge`, `names`, `--check` | port |
| 16 | Tooling | eslint / vitest scripts but deps removed | tsdown + typescript only | drop dead scripts |
| 17 | `jp/` module | same old formats | same new formats | migrate mechanically after US works |

## Checklist

### A. Data files (`us/`)
- [x] A1 `stringTypes.json` → `layers`
- [x] A2 `labels.json` → record
- [x] A3 `config.json` → header fields, drop `entryPoints`
- [x] A4 `mnemonics.json` → game-only entries
- [x] A5 `types.json` (new) from `overrides.json` `type` entries; strip them from overrides
- [x] A6 verify `blocks.json`, `files.json`, `fileTypes.json`, `structs.json`, `copdef.json`, `groups.json`, `rewrites.json`, `transforms.json` against strict validation (run extraction)
- [x] A7 review the staged-but-uncommitted edits already in `us/blocks.json` / `labels.json` / `mnemonics.json` (movable flags, new labels) survive the conversion

### B. Source (`src/`)
- [x] B1 `src/index.ts`: module wiring (`headers`, `names`, `types`, notes), `extract --linetracking`, sweep, `rebuild` fix, `merge` / `names` commands
- [x] B2 `src/names.ts`: per-bank names merge
- [x] B3 port `extract-state.ts`, `notes-common.ts`, `merge.ts`, `merge-check.ts`, `names-merge.ts`, `transform-guard.ts` (db dir is `us/`, not `db-us/`)
- [x] B4 `package.json` scripts: `extract:lt`, `merge`, `names`; remove dead lint/test scripts
- [x] B5 delete local `snes/`; `.gitignore` additions; `tsconfig` includes

### C. Notes / comments / names scaffolding
- [x] C1 `us/names/bankNN.json` files + import in `src/names.ts`
- [x] C2 `notes/blockNotes`, `notes/partNotes`, `notes/comments` + loader
- [x] C3 `.cursor/rules/no-adhoc-scripts.mdc` for this repo
- [x] C4 `npm run names -- --check`, `npm run merge -- --check` pass

### D. Verification
- [x] D1 `npm run extract` completes without errors / warnings that point at data problems
- [x] D2 `npm run extract:lt` emits `; {n}` tags
- [x] D3 spot-check extracted asm (code boundaries, strings, structs, spritemaps, SFX/music files)
- [~] D4 `npm run rebuild` runs and writes `GaiaLabs-Blazer.smc` + `layout.json`, but the ROM is 1,081,344 bytes (one page over 1 MB): see Open issues 2
- [~] D5 `npm run type-check`: only environment errors remain (no `@types/node`, same as gaia-iog-baserom)

### E. `jp/` module
- [x] E1 convert `jp/stringTypes.json`, `jp/labels.json`, `jp/config.json`, `jp/mnemonics.json`
- [x] E2 `extract-jp` loads (no JP ROM needed to validate the load)

## Open issues (need a decision, not a workaround)
1. **Core dictionary id regression (item 14).** Fixed in `gaia-core/src/database/strings.ts` (`+ (y.base ?? 0)`;
   `npm run build` in gaia-core regenerates `dist`). With the fix every asm chunk rebuilds to the same size as the
   previous rebuild. Without it, dictionary hits are emitted as ids 0x00-0x7F that collide with string commands
   (`[10]`, `[12]`, `[00]` ...). **Resolved 2026-11-19** (the user reports the gaia-core fix is committed).
2. **Rebuilt ROM is one 32 KB page over 1 MB.** Content is 1,048,204 bytes (372 spare), but the page packer leaves
   only 2-28 free bytes per page and one 63-byte tilemap (`tilemap_0F7891`) fits nowhere. Cause: the April 2026
   QuintetLZ compactor fix (matches that overlap the write head now follow the decoder semantics) makes 27 tilemaps
   1-2 bytes larger (38 bytes total). Needs a packer improvement in core (best-fit / repack) or a decision to shrink
   data. Not a Blazer data problem.
3. **3,387 "Cross bank call" warnings on rebuild**: 3,369 are LoROM false positives (core masks banks as HiROM);
   18 are `COP asciistring_*` operands that are cross-bank in the game too. Core diagnostic only.
4. **Sprite groups struct**: the dangling `struct: "&spritemap"` in `fileTypes.json` was removed (it clashed with the
   asset child struct). A real struct mapping for Blazer sprite groups is still to be written.
5. **JP module** migrated mechanically (loads via `DbRootUtils.fromGameModule`) but unverified against a ROM:
   `gameTitle` is unset and `countryCode: 0` is assumed.
6. **String map contains `[ ] {`** characters that overlap command / dictionary delimiters on rebuild (round-trip of
   those characters unverified).

## Progress log
- A1, A2: `stringTypes.json` -> layers (hex fixed sizes `ASCIIString(C)`), `labels.json` -> record (276 entries).
- A3-A7: config header fields, game-only mnemonics, `types.json`; all `us/` files pass strict validation.
- B1-B5: `src/index.ts` rewritten, `names.ts`, tools ported (`?BANK` is the SNES bank: `bankFromDirective` in
  `notes-common.ts` converts LoROM SNES bank -> storage bank), `package.json` scripts, local `snes/` deleted,
  `.gitignore` / `tsconfig.json` updated.
- C1-C4: names + notes scaffolding, rule file; `names --check` and `merge --check` OK; names dry-run smoke test OK.
- D1-D3, E1-E2: `extract` and `extract:lt` complete; JP module loads.

