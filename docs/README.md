# Soul Blazer baserom documentation

| Page | Content |
|---|---|
| [cop/index.md](cop/index.md) | The COP script system: dispatcher, exit chain, actor fields, all 108 commands with handler names and offsets |
| [areas-and-scenes.md](areas-and-scenes.md) | World block groups and area/scene folder keys with ids and in-game names |
| [wram-memory-map.md](wram-memory-map.md) | Named WRAM addresses (`us/mnemonics.json`) with the evidence for each, DMA/video buffers, game state, direct-page roles, unnamed addresses |
| [walkthrough/README.md](walkthrough/README.md) | Game guide by world (source for names; not verified against the ROM) |
| [audio/spc-engine.md](audio/spc-engine.md), [audio/spc-disassembly.md](audio/spc-disassembly.md) | SPC700 sound engine |

Work records live in `plans/mapping/` (the five-pass mapping plan) and `plans/extracted-audit/` (specs, results and
open questions of the documentation pass). Notes and comments are changed only with `npm run merge`, names only with
`npm run names` (see `gaia-core/docs/notes-and-comments.md`).

Not yet written: per-bank code documentation (`docs/code/bankNN/`), because most blocks are still partitioned by
reachability and carry no functional notes (Pass 4 continues, see `plans/mapping/mapping-action-plan.md` §8d).
