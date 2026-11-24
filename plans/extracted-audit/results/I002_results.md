# I002 results (Pass 5: mnemonics)

Date: 2026-11-19. No spec file: `us/mnemonics.json` is edited directly (it is not a name/note/comment file; the
`names` and `merge` tools do not cover it). Questions: `questions/I002_questions.md`.

## What was changed

| Item | Result |
|---|---|
| `us/mnemonics.json` | 4 -> 61 entries. Removed the wrong key `768` (`$0300`, unreferenced) and re-added `area_current` at `788` (`$0314`). All names are snake_case (the Blazer baserom already uses `scene_next`, ...), each with one sentence of evidence in `docs/wram-memory-map.md`. |
| `us/overrides.json` | `"78758": { "B": 1 }` (`code_0133A6`) and `"80300": { "B": 1 }` (`code_0139AC`). Without a known data bank the extractor printed 121 hardware-register operands raw (`STA $2116`, `STA $2140`); now all print by name (`$VMADDL`, `$APUIO0`, ...). |
| Docs | `docs/wram-memory-map.md` (new), `docs/README.md` (link). |
| Records | `results/I002_results.md`, `questions/I002_questions.md` (8 questions). |

Names by group (61 total): system/input 9, scene/area/scroll/player 29 (includes the 3 existing `scene_current`,
`scene_next`, `area_next` and the re-keyed `area_current`), actor list 2, video/DMA/buffers 13, game state 8.
Result in `extracted/`: 1,067 operand references now print a mnemonic.

## Verdicts per plan item

- **5.1** done for the verified set above; every unverified address is left unnamed and tracked in OQ-I002-2..6.
- **5.2** done for `$7F0000`, `$7F0200`, `$7F7000`, `$7F8000`, `$7F0483`, `$0486`; `$7E8000`, `$7EC000`, `$7F0203`,
  `$7F6FC0`, `$7E7000`/`$7E7800` stay open (OQ-I002-6).
- **5.3** no mnemonics (per-actor fields); the struct is documented in `docs/cop/index.md` §2 and summarised in
  `docs/wram-memory-map.md` §4.
- **5.4** not possible with the current extractor: only `Address` operands are resolved, DP operands are plain
  numbers (a test entry changed nothing). Roles documented in `docs/wram-memory-map.md` §5; decision in OQ-I002-1.
- **5.5** satisfied by `gaia-core/snes/vectors.json`; the remaining raw hardware references were a data-bank problem
  and are fixed by the two `B` overrides (0 raw `$21xx`/`$42xx`/`$43xx` operands left).
- **5.6** `area_current` fixed and the scene/area neighbours (`scroll_*`, `map_*`, `warp_dest_*`, `return_*`,
  `transition_type`, `scene_active`, `location_id`) named.
- **5.7** `docs/wram-memory-map.md` written.
- **5.8** gate below.

## Not named, by design

`$06AA` (scratch actor slot) and `$1ADE` (switch bit array) are only ever referenced as immediates
(`LDY #$06AA`, `LDY #$1ADE`); an entry for them printed nothing, so both were removed again and are documented in
prose only.

## Gate

| Gate | Result |
|---|---|
| `npm run extract:lt` | OK; every one of the 61 names prints in `extracted/` (checked by counting `$name` operands) |
| `npm run rebuild` | OK, SHA-1 `65ff27aaf7ae15537351f5eace690193813a5556`, 1,081,344 bytes, unchanged |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | 0 errors, 0 warnings, 0 orphans |

## Tooling note

Read-only helper scripts were run from outside the repository (`~/an/p5/*.py`) to count address usage and print
context around a name; no repository file was written by a script. This results file and the docs were written by
hand.
