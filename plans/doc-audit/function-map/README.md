# function-map

PA output, read-only analysis (no ROM-facing edits). One file per batch, `FM-<Ax>.md`:

| Batch | Region |
|-------|--------|
| A1 | `engine_000000` boot, NMI, main loop, scheduler |
| A2 | `engine_*` rest, `native_mode_brk`, `engine_routines_*` |
| A3 | `cop_handlers` |
| A4 | library `0100-0111` |
| A5 | library `0118` |
| A6 | library `0127` and `0124-0126` |
| A7 | library `0133-0147` |
| A8 | library `014F-0175` |
| A9 | library `0270-0279` |
| A10 | `common_actor_001A28` (player) |
| A11 | data and tables: struct inventory |

Row per routine: label, offset, size, callers (count and files), proposed subsystem, proposed name (VerbNoun, confidence, evidence label), inputs, outputs, clobbers, data touched (WRAM names from `us/mnemonics.json`). Callers and fan-in come from `npm run audit -- --block=<name>` and `-- --matrix`. Unverified claims go to the iteration's questions file as `OQ` rows. Rules: `../README.md`.
