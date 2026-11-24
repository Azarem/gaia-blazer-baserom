# placement

PB output (static placement audit and regroup).

| File | Phase | Content |
|------|-------|---------|
| `placement-audit.md` | PB1 | target file layout per subsystem (about 200-1,500 lines per file), cross-file calls to remove by merging, per-block pin constraints (vectors, DBR-relative reads of bank-1 data, `$&` closures, pointer tables with bank hints, `rewrites.json` return-address idioms, R-2 bank-base idioms, short-branch reach), scene and group audit |
| `spike-decision.md` | PB2 | R-2 result from Mesen2, the regroup spike on one small cluster, go or no-go and the fallback |
| `pinned.md` | PB3 | clusters that stay pinned, with the reason (one section per wave; wave 0 done in I017) |

Regroups are applied only with `npm run blocks` (spec under `plans/extracted-audit/edits/`). The tool already refuses a spec that changes label text, leaves a reference undefined, crosses a bank or breaks a same-bank 2-byte reference; the Mesen2 comparison is still needed. `npm run audit` lists the 2-byte references that target movable blocks (R-2). Rules: `../README.md`.
