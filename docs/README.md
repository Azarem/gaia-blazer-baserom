# Soul Blazer baserom documentation

Start with the code hub: [code/README.md](code/README.md) is the map of the ROM (banks, files, include layers, call chains) and links every topic document.

| Page | Content |
|---|---|
| [code/README.md](code/README.md) | Hub of the code documentation: ROM and bank map, file inventory, conventions, cross-file call chains, document suite |
| [code/boot-nmi-main-loop.md](code/boot-nmi-main-loop.md) | Boot, the frame, the NMI |
| [code/actor-system.md](code/actor-system.md) | The 64 actor slots, run order, spawning and removal |
| [code/cop-dispatch.md](code/cop-dispatch.md) | How `COP` and `BRK` reach their handlers |
| [code/player.md](code/player.md) | The hero, spells and level-up |
| [code/collision-and-physics.md](code/collision-and-physics.md) | Tile collision and motion |
| [code/combat-damage-and-enemy-records.md](code/combat-damage-and-enemy-records.md) | Hits, damage, enemy records, death |
| [code/scene-area-warp-loading.md](code/scene-area-warp-loading.md) | Scene change and the scene loader |
| [code/data-tables.md](code/data-tables.md) | The keyed tables |
| [code/flags-switches-and-inventory-bytes.md](code/flags-switches-and-inventory-bytes.md) | Event flags, switches, chests, inventory |
| [code/menus-inventory-status-hud.md](code/menus-inventory-status-hud.md) | Menus, status screens, the HUD |
| [code/text-and-dialogue.md](code/text-and-dialogue.md) | Strings, the dictionary, the two text renderers |
| [code/sprites-oam-animation.md](code/sprites-oam-animation.md) | Animation, spritemaps, OAM |
| [code/vram-dma-hdma-palettes.md](code/vram-dma-hdma-palettes.md) | VRAM, DMA, HDMA, palettes |
| [code/spc-interface.md](code/spc-interface.md) | The APU ports and the sound requests |
| [code/save-and-load.md](code/save-and-load.md) | SRAM slots and the file select |
| [cop/index.md](cop/index.md) | The COP script system: dispatcher, exit chain, actor fields, all 108 commands with handler names and offsets |
| [areas-and-scenes.md](areas-and-scenes.md) | World block groups, area and scene folder keys with ids, in-game names, boss scenes |
| [wram-memory-map.md](wram-memory-map.md) | Named WRAM addresses (`us/mnemonics.json`) with the evidence for each, DMA/video buffers, game state, direct-page roles, unnamed addresses |
| [walkthrough-crosswalk.md](walkthrough-crosswalk.md) | Walkthrough names matched to ROM labels, with confidence and the discrepancy index |
| [walkthrough/README.md](walkthrough/README.md) | Game guide by world (source for names; not verified against the ROM) |
| [audio/spc-engine.md](audio/spc-engine.md), [audio/spc-disassembly.md](audio/spc-disassembly.md) | SPC700 sound engine |

## World pages

One page per world: its areas and scenes, actor files, roster, enemies, boss and set pieces, and the walkthrough cross-check.

| World | Page |
|---|---|
| Grass Valley (with Up Above, the title and the ending) | [worlds/grass_valley.md](worlds/grass_valley.md) |
| GreenWood | [worlds/greenwood.md](worlds/greenwood.md) |
| St. Elles | [worlds/st_elles.md](worlds/st_elles.md) |
| Mountain of Souls | [worlds/mountain_of_souls.md](worlds/mountain_of_souls.md) |
| Dr. Leo's Laboratory | [worlds/leos_lab.md](worlds/leos_lab.md) |
| King Magridd's Castle | [worlds/magridds_castle.md](worlds/magridds_castle.md) |
| World of Evil | [worlds/world_of_evil.md](worlds/world_of_evil.md) |

Work records live in `plans/mapping/` (the five-pass mapping plan), `plans/doc-audit/` (the documentation audit) and `plans/extracted-audit/` (specs, results and
open questions of the documentation pass). Notes and comments are changed only with `npm run merge`, names only with
`npm run names` (see `gaia-core/docs/notes-and-comments.md`).
