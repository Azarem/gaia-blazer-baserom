# I051 results: `docs/code/vram-dma-hdma-palettes.md` (VRAM, DMA, HDMA and palettes)

PD step of the plan "Blazer docs and analysis", topic "VRAM, DMA, HDMA and palettes". The prompt left `<files>` empty; I chose the files that make up the topic (see Sources), as in I043 to I050. Work started from a fresh `npm run extract:lt`; the gate was run at the end. The plan checklist is `plans/doc-audit/I051_checklist.md`.

## Deliverables

| File | What |
|------|------|
| `docs/code/vram-dma-hdma-palettes.md` | New topic document (about 360 lines): breadcrumb, source links, overview with one mermaid diagram (10 nodes), memory-map tables (code, data, state), 19 `###` sections (the VRAM word map, what a scene sets, the DMA channel owners, what the NMI sends, the write queue and sweep redraw, strip records, the CGRAM buffer, the colour writers, the menu save and restore, the HDMA queue, the table shapes, the effect catalogue, the soul circle windows, the title split and Mode 7, the iris, fades and mosaic), a walkthrough cross-check table, open questions and See Also. |
| `plans/extracted-audit/edits/I051.json` | Merge spec: six part notes (eight edits) and three block notes (see finding 8). |
| `plans/extracted-audit/questions/I051_questions.md` | OQ-I051-1 to OQ-I051-11 (one DISCREPANCY, ten GAP/BUG). |
| `plans/extracted-audit/results/I051_results.md` | This file. |
| `plans/doc-audit/I051_checklist.md` | The checklist with its progress section. |
| `docs/code/boot-nmi-main-loop.md`, `actor-system.md`, `sprites-oam-animation.md`, `scene-area-warp-loading.md` | See Also links; "VRAM and HDMA" removed from the planned-spokes lines (HUD stays planned). Edited by hand; no notes, comments or names. |

Sources documented: `engine_vblank_nmi` (the transfer routines), `lib_system_helpers` (the HDMA queue, the NMI switches, `ApplyBootPpuLayout`), `lib_hdma_window_effects` (BG3 scroll table, soul windows), `lib_map_scroll_and_redraw` (strip records, sweep redraw, tile lookups), `lib_scene_asset_loader` and `data_scene_asset_lists` (graphics pages, palette destinations, `ApplySceneProfile`, `InitHardwareAndClearWram`), `lib_menu_screen_setup` and `lib_menus` (menu graphics and palette handoff), `lib_boot_and_scene_init` (`InitSceneState`, `ClearBg3Buffer`, `RunIrisTransition`, `LoadBootGraphicsBuffers`), `data_iris_and_icon_tiles`, `engine_title_file_select` and `gv_front_end` (Mode 7 and the title split, ending bands, colour ramps), the HDMA actors of the worlds, `lib_animation` and `data_anim_palette_cycles` (the colour stepper), `DrawGaugeBar`. Not repeated: the NMI order and main loop, the asset-list format and scene change, OAM and the OBJ tile table.

## Findings

1. **Who writes video memory.** Only the loaders (screen blanked, NMI off) and the NMI (vblank). The NMI uses DMA channels 0 (OAM), 1 (CGRAM, 512 bytes, then three `COLDATA` bytes) and 2 (every VRAM transfer); channel 3 is never started; channels 4-7 belong to the HDMA queue. `LoadSceneGraphics` and `LoadMode7Map` copy with the CPU. `UploadScrollStrips` is the only NMI routine that writes `VMAIN` and always leaves it at `$80`, which the BG3 page DMA of the next NMI relies on.
2. **VRAM word map.** `$0000`-`$1FFF` BG1/BG2 characters (asset pages `$00`, `$10`), `$2000`-`$3FFF` the two OBJ tables (pages `$20`, `$30`; BG tile numbers from `$200` land there too, which is how the animated strip is both a BG and an OBJ tile), `$4000`-`$57FF` the BG3 font, `$5800` BG3 map, `$5C00` the menu's BG2 map, `$6000` and `$7000` the BG1 and BG2 maps; the Mode 7 title uses `$0000`-`$3FFF` and shares `$3000`-`$3FFF` with a sprite page. The BG3 font comes from the boot scene `A00S0C` (page `$40`) and then stays; tile 0 is borrowed by the iris.
3. **Palettes.** `cgram_buffer` (`$7F:0000`) is sent whole every NMI; `coldata_buffer` (`$7F:0200`) feeds `COLDATA`. The table of writers lists 12 sources; the menu return runs `RestoreSceneBgGfxAndPalette`, `RestoreCgramBuffer`, `LoadEquippedMagicGfx` in that order and the order matters.
4. **Map streaming.** A strip record is 258 bytes (address word + four 64-byte blocks); a column goes with `VMAIN` `$81` to address, +1, +`$800`, +`$801`, a row with `$80` to address, +`$20`, +`$400`, +`$420`. The entry redraw builds 32 column strips per layer. The sweep redraw queues four (address, word) pairs per metatile into `vram_write_queue`, with the BG1/BG2 lookup address formula decoded.
5. **HDMA queue.** Channels 4-7 in order; the fifth call in a frame silently programs `$4381`-`$4387` and is lost (OQ-I009-9); the document lists which actors use how many channels and OQ-I051-4 asks whether a scene exceeds four. Table shapes (direct and indirect with repeat counts) and an 18-row catalogue with the PPU register, channel count and effect of each actor.
6. **Soul circle windows.** `BuildSoulOrbCircleWindow` writes `WH0` and `WH1` tables (radius `$40`, two lines per entry); outside the circle both edges are `$FF`, a one-pixel window at x = 255. The register values of the four souls are decoded: Reality and Detection mask BG2 inside the circle, which agrees with the walkthrough's "disable BG#2" tip; Light withholds colour math inside the circle; Shield not read to a picture. Offered as a proposed answer to OQ-I042-2 (OQ-I051-2 asks for the runtime check).
7. **Iris.** Not a circle: `IrisFrames` rewrites BG3 tile 0 (an 8 x 8, 2-bit mask) and the BG3 page is all tile 0, so the screen shows a grid of squares that fills in and opens into holes (frame `$00` solid, `$1F` empty).
8. **Notes corrected with `merge`:** `RunSoulOfLightEffect` (the dark place is the Light Shrine B1F, entered from the Lostside marsh, not "Woods of GreenWood B1F"; DISCREPANCY OQ-I051-1); `BuildSoulOrbCircleWindow` part and block note (the closing line is `$FF` / `$FF`, not full width); `se_effect_seabed_wave_hdma_0FA874`, `se_effect_sanctuary_wave_hdma_0FA7C4` and the two block notes (PPU registers `$0D`, `$0E`, `$0F` were called "channels"); `RunIrisTransition` and `IrisFrames` ("a circle").
9. **Walkthrough cross-check.** Six rows (the four souls, the title, the X menu). One DISCREPANCY (Soul of Light, corrected). The walkthrough does not describe waves, gradients, the iris or the BG3 scroll table; those claims rest on the ROM.
10. **Counts recorded:** 208 distinct backticked tokens, all found in `extracted/` except the 17 file names and the data value `E700`; the 35 single-address and the multi-address rows of the memory-map tables match `us/names/` after the LoROM conversion; 10 diagram nodes; 19 `###` sections.

## Open questions

OQ-I051-1 (DISCREPANCY: the Soul of Light place, corrected), OQ-I051-2 (soul windows at screen level), OQ-I051-3 (`$FF` / `$FF` outside the circle), OQ-I051-4 (can a frame need more than four HDMA channels), OQ-I051-5 (HDMA tables rewritten while the picture is drawn), OQ-I051-6 (`LookupBg2TileAndVramAddr` uses the BG1 width), OQ-I051-7 (which layer each wave moves, `bg_scroll_swap`), OQ-I051-8 (who writes the BG3 font range after the boot scene), OQ-I051-9 (which OAM tiles use sprite table 1), OQ-I051-10 (Mode 7 map and sprite page share words), OQ-I051-11 (the iris colour). Details and Mesen2 tools in `questions/I051_questions.md`.

## Not done / follow-ups

- The breadcrumb links to `docs/code/README.md`, which does not exist yet (the hub is a later PD step); the link is dead until then, as in I043 to I050. **The hub should link this document and should not repeat the VRAM map, the DMA channel table or the HDMA catalogue.**
- No Mesen2 run was made; every claim that rests on static reading is marked or carries an OQ.
- The colour-math side (`CGADSUB` per scene: which layers take the tint, add or subtract) was not tabulated; the document says so.
- The HUD remains a separate spoke (named in the planned-spokes lines).

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK (fresh before the work and after the merge; the corrected notes appear in the output) |
| `npm run merge -- plans/extracted-audit/edits/I051.json --dry-run`, then applied | 6 notes files changed (`blockNotes/bank01`, `blockNotes/bank0F`, `partNotes/bank01`, `partNotes/bank02`, `partNotes/bank04`, `partNotes/bank0F`); 6 part notes and 3 block notes updated |
| `npm run rebuild` at the end | OK, SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1081344 bytes, checksum 110070696: unchanged (annotation only) |
| `npm run names -- --check` | OK (2765 names; no rename in this step) |
| `npm run merge -- --check` | OK: 1401 comments, 1684 part notes, 135 block notes; 0 errors, 0 warnings, 0 orphans, 0 duplicate keys |
| Backticked identifiers of the new document | found in `extracted/` or `us/` (file names and `E700` excepted) |
| Addresses of the memory-map tables | match `us/names/` after the LoROM conversion |
| Links in the new document | all relative targets exist except the hub `README.md` (see above) |
| Mermaid diagrams in the new document | 1, 10 nodes |

## Suggested commit message

```
docs: VRAM, DMA, HDMA and palettes (I051)

Add docs/code/vram-dma-hdma-palettes.md: the VRAM word map, DMA channel
ownership and the NMI transfers, map strip records and the sweep redraw,
the CGRAM buffer and its writers, the HDMA channel queue with an effect
catalogue, the soul circle windows, the Mode 7 title split and the iris.
Correct notes that put the Soul of Light's dark area in the Woods of
GreenWood, called PPU registers "channels", described the iris as one
circle and the soul window closing line as full width.
OQ-I051-1 to OQ-I051-11 logged (one DISCREPANCY). ROM SHA-1 unchanged.
```

Please commit when you're ready.
