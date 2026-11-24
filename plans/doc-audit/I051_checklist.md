# I051 checklist: docs/code/vram-dma-hdma-palettes.md

Topic: VRAM, DMA, HDMA and palettes. `<files>` was not given, so the files are chosen like in I043-I050.

Rules in force: notes and comments change only through `npm run merge`, names only through `npm run names`; no ad-hoc scripts; no commits; no comparison of the original ROM with the rebuilt ROM; every claim cites a label; the walkthrough is the source of truth for game names, the ROM text for exact spelling and behaviour; every mismatch is an OQ with tag DISCREPANCY.

## Scope

Files (all under `extracted/`):

- `system/engine_vblank_nmi.asm` (the transfers of `HandleVBlank`: `DmaOamBuffer`, `DmaCgramAndFixedColor`, `DmaBg3TilemapPage`, `WriteScrollRegisters`, `UploadMapStripBuffers`, `DmaDynamicSpriteTiles`, `DmaAnimatedTileStrip`, `FlushVramWriteQueue`)
- `library/lib_system_helpers.asm` (`ResetHdmaQueue`, `QueueHdmaIndirect`, `QueueHdmaDirect`, `WriteHdmaChannelRegisters`, `HdmaDmapByRegister`, `ForceBlankNmiOff`, `EnableNmi`, `DisableNmi`, `ApplyBootPpuLayout`)
- `library/lib_hdma_window_effects.asm` (`QueueBg3ScrollHdma`, `Bg3ScrollHdmaTable`, the four `RunSoulOf*Effect` actors, `BuildSoulOrbCircleWindow`)
- `library/lib_map_scroll_and_redraw.asm` (strip records, `UploadScrollStrips`, `DmaStripChunk`, `RedrawBackgroundsAtEntry`, `StepSweepRedraw`, the two tile lookups)
- `library/lib_scene_asset_loader.asm` (`LoadSceneGraphics`, `LoadScenePalette`, `LoadMode7Map`, `ApplySceneProfile`, `InitHardwareAndClearWram`), `library/lib_scene_profile_data.asm`, `system/data_scene_asset_lists.asm` (VRAM pages and palette destinations)
- `library/lib_menu_screen_setup.asm`, `library/lib_menus.asm` (`OpenEquipmentMenu`, `SaveCgramBuffer`, `RestoreCgramBuffer`), `system/data_menu_palettes_and_groups.asm`
- `library/lib_boot_and_scene_init.asm` (`LoadBootGraphicsBuffers`, `ClearBg3Buffer`, `RunIrisTransition`, `InitSceneState`), `system/data_iris_and_icon_tiles.asm`
- `system/engine_title_file_select.asm` (Mode 7: `UpdateTitleMode7`, `WriteMode7Matrix`, `BuildRotationMatrix`), `grass_valley/front_end/gv_front_end.asm` (title split, ending bands, colour ramps)
- the HDMA actors of the worlds (`se_effect_seabed_wave_hdma_0FA874`, `se_effect_sanctuary_wave_hdma_0FA7C4`, `gw_effect_wave_hdma_01E9D3`, `gw_effect_water_ripple_hdma_01EAFB`, `we_fx_bg2_hofs_wave_01EEF3`, `we_fx_bg2_vofs_wobble_01F063`, `we_fx_battle_bg2_hofs_bands_01F14F`, `we_fx_ending_tm_curtain_0055C6`, `ms_effect_hdma_*`, `gv_fx_hdma_gradient_*`)
- the palette writers outside the loaders (`lib_animation`, `data_anim_palette_cycles`, `DrawGaugeBar`, `HandleFileSelectChoice`, `mc_dream_soldier_dialogue_026A4E`, `ms_effect_hdma_coldata_gradient_022457`)

Not repeated (already in the spokes): the NMI order and the main loop (boot-nmi-main-loop.md), the asset-list format, the loaders' command table and the scene change (scene-area-warp-loading.md), OAM, the hero's streamed tiles and the OBJ tile table (sprites-oam-animation.md), the actor slots (actor-system.md).

## To do

- [x] Fresh `npm run extract:lt` and a baseline `npm run rebuild` (SHA-1 `040a408a...`) before any edit.
- [x] Read the conventions: notes-and-comments.md (headings), code-bank-documentation.md (Three Questions), doc-audit README, walkthrough README, `items.md` (souls), `01-in-the-beginning.md`, the format of I050.
- [x] Read every routine of the topic in the annotated asm; derive the VRAM word map, the DMA channel use, the HDMA channel budget, the palette writers.
- [x] Cross-check the existing notes against the code and the walkthrough: the Soul of Light note (dark areas), the seabed and sanctuary wave notes ("channels `$0D`/`$0E`"), the `IrisFrames` note ("a circle").
- [x] Write this checklist (before any edit).
- [x] Write `docs/code/vram-dma-hdma-palettes.md` in one Write call: breadcrumb, source links, overview with one mermaid diagram (at most 15 nodes), memory map (code, data, state), `###` sections that answer the Three Questions, walkthrough cross-check, open questions, See Also.
- [x] Write `plans/extracted-audit/edits/I051.json` (note corrections); `npm run merge -- ... --dry-run`, apply, `npm run extract:lt`.
- [x] Write `plans/extracted-audit/questions/I051_questions.md`.
- [x] Hand edits: link the new document from `boot-nmi-main-loop.md`, `scene-area-warp-loading.md`, `sprites-oam-animation.md` (planned-spokes lines, See Also).
- [x] Verify: every backticked identifier of the new document exists in `extracted/` or `us/names/`; every relative link resolves (hub `README.md` excepted); line count 50-900; at most 2 mermaid diagrams with at most 15 nodes.
- [x] Gate: `npm run extract:lt`, `npm run rebuild` (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1,081,344 bytes, checksum 110070696 unchanged), `npm run names -- --check`, `npm run merge -- --check`.
- [x] Write `plans/extracted-audit/results/I051_results.md` with the gate table and a suggested commit message.

## Progress

- Fresh `npm run extract:lt` and a baseline `npm run rebuild` (SHA-1 `040a408a...`, unchanged) done before any edit.
- Reading, decoding and the cross-check of the existing notes done (see the ticked items). Findings that become notes corrections: the Soul of Light note named the wrong place (walkthrough: the Light Shrine B1F), three HDMA actor notes call PPU register numbers "channels", the iris note says "a circle".
- Document written (`docs/code/vram-dma-hdma-palettes.md`, 19 `###` sections, 1 diagram of 10 nodes). A second pass re-checked every claim against the annotated asm and the walkthrough and corrected: the entry redraw (32 column strips, no row strips), the BG3 page flag logic (no invented menu dependency), the effect table (counts only where a note states them), the soul table text (`$FF` lead-in and closing line), the iris frames (decoded from `IrisFrames`), the menu exit button (not decoded), the font loader (boot scene `A00S0C`, OQ-I051-8).
- `edits/I051.json` applied with `npm run merge` (dry run first): 6 notes files, 6 part notes (8 edits) in the soul, iris and wave notes and 3 block notes (3 edits); `extract:lt` shows the corrected text.
- Questions file written (OQ-I051-1 to OQ-I051-11; one DISCREPANCY). Sibling hand edits: links in `boot-nmi-main-loop.md`, `actor-system.md`, `sprites-oam-animation.md`, `scene-area-warp-loading.md`; "VRAM and HDMA" removed from the planned spokes.
- Verify: all backticked identifiers found in `extracted/` (except file names and the data value `E700`); all relative links resolve (hub `README.md` excepted); every code and data address of the memory-map tables matches `us/names/` (LoROM conversion); 356 lines.
- Gate: `extract:lt` OK, `rebuild` OK with SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` (1081344 bytes, checksum 110070696), `names --check` OK, `merge --check` OK (0 errors, 0 warnings, 0 orphans).
