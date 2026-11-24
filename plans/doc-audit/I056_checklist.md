# I056 checklist: docs/code/spc-interface.md

Topic: the SPC interface (the CPU side of the sound chip; links `docs/audio/`). `<files>` was not given, so the files are chosen like in I043-I055 (list below). Written before the first edit; the Progress section is updated as items finish.

Rules in force: notes and comments change only through `npm run merge`, names only through `npm run names` (dry-run first); no ad-hoc scripts for notes, comments or names; no commits; no comparison of the original ROM with the rebuilt ROM; every claim cites a label; the walkthrough is the source of truth for game names and facts, the ROM text for exact spelling and behaviour; every mismatch is an OQ with tag DISCREPANCY; record files (`edits/`, `questions/`, `results/`, the document) are written once with the Write tool. Read-only survey scripts (decoding of the song and driver streams, the `BRK` operand counts, the track table) live outside the repository and write nothing into it.

## Scope

Files (all under `extracted/`):

- `system/engine_spc_ipl_upload.asm` (`UploadSpcDriver`, `UploadSpcStream`, `SendSpcIplBlocks`, `SpcEngineBlock`; the sine-wave mover at its start is not SPC code and only gets a sentence)
- `system/data_spc_driver.asm` (`SpcDriverBlock`), the 21 `.bgm` files and `sfx/sfx00-20.sfx` (stream format and the 33 samples), `system/data_engine_tables.asm` (`MusicPointerTable`)
- `system/engine_vblank_nmi.asm` (`HandleVBlank`, `WriteSoundPort`), `system/cop_dispatch.asm` (`HandleBrk`)
- `system/engine_spawn_lairs_death_drops.asm` (the music-load chain `MusicLoadSendFade` ... `MusicLoadFinish`, `RunBossDeath`, `RunEnding`), `cop_handlers/cop_script_flow_flags.asm` (`Cop31_FadeAndLoadMusic`, `Cop32_StopAndLoadMusic`)
- `library/lib_scene_asset_loader.asm` (`LoadSceneMusic`, `UploadSceneMusic`, `CheckAssetCache`, `WaitVblankFrames`), `system/data_scene_asset_lists.asm` (the `music` records), `library/lib_system_helpers.asm` (`WaitVBlank`, `EnableNmi`, `DisableNmi`)
- `library/lib_main_loop_helpers.asm` (`HandlePauseBanner`: `$F2` and `$01`), `greenwood/woods_of_greenwood/gw_woods_actors_01B98D.asm` (the restaurant joke: `APUIO0` = 0 then 1), `grass_valley/front_end/gv_front_end.asm` (the boot actor), `magridds_castle/castle_of_magridd/mc_castle_actors.asm` (the singer: `COP [31] #12`)
- the SPC side as far as the CPU sees it: `docs/audio/spc-disassembly.md` (`ReadPortData`, `ProcessSequenceTick`, `DispatchCommand`, `HandleFadeIn`, `StopAllChannels`, `SetEchoBit6`, `HandleBootHandshake`, `BootHandshake`, `SFXHandler`, `SFXInitChannel`)

Not repeated (already in the spokes or in `docs/audio/`): the N-SPC opcode set, the DSP register use and the IoG comparison (`audio/spc-engine.md`), the asset-list commands other than `music` and the scene change itself (`scene-area-warp-loading.md`), the NMI body (`boot-nmi-main-loop.md`), COP dispatch (`cop-dispatch.md`).

## To do

- [x] Fresh `npm run extract:lt` before any edit.
- [x] Read the conventions: notes-and-comments.md, code-bank-documentation.md, doc-audit README, walkthrough README and the castle chapter, mapping plan §0 and §8c-8e, the format of I055.
- [x] Survey: every `BRK` operand (289 sites, 57 ids) split by port; every `COP 31` / `COP 32` operand and the `music` records of `SceneAssetLists`; the record shape of the driver block and of all 21 songs (do they tile exactly, do the sample directory entries and the end pointer follow from the sample sizes).
- [x] Read every routine of the topic in the annotated asm and the SPC side of the ports in `spc-disassembly.md`.
- [x] Cross-check game terms against the walkthrough (title music, the singer, the Harp String, the dog's joke).
- [x] Check the existing notes against the code (`HandleBrk`, the music-load chain, the two SPC block notes, `UploadSceneMusic`, `HandlePauseBanner`, the restaurant comment).
- [x] Write `docs/code/spc-interface.md` in one Write call: breadcrumb, source links, overview with at most 2 diagrams of at most 15 nodes, memory map (code, data, state, ARAM), `###` sections that answer the Three Questions, the track table, walkthrough cross-check, open questions, See Also.
- [x] Write `plans/extracted-audit/edits/I056.json` (note corrections found while writing); `npm run merge -- ... --dry-run`, apply, `npm run extract:lt`.
- [x] Write `plans/extracted-audit/questions/I056_questions.md`.
- [x] Hand edits: replace the "Planned spokes: the sound driver behind `BRK`" lines in `cop-dispatch.md`, `text-and-dialogue.md` and `menus-inventory-status-hud.md`; link from `boot-nmi-main-loop.md`; fix the stale or open rows of `docs/audio/spc-engine.md` (file name, instrument base offset, the TBD ARAM rows) and `docs/wram-memory-map.md` where a fact changes.
- [x] Verify: every backticked identifier exists in `extracted/` or `us/names/` (SPC-side labels in `audio/spc-disassembly.md`); every relative link resolves (hub `README.md` excepted); line count 50-900; at most 2 mermaid diagrams with at most 15 nodes; memory-map addresses match `us/names/` after the LoROM conversion.
- [x] Gate: `npm run extract:lt`, `npm run rebuild` (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` unchanged), `npm run names -- --check`, `npm run merge -- --check`.
- [x] Write `plans/extracted-audit/results/I056_results.md` with the gate table and a suggested commit message.

## Progress

- Fresh `extract:lt` done; survey and reading done. Facts that shape the document:
  - All 21 songs and the driver block have one shape: IPL records `$2E4E` (instruments), `$2F00` (24 bytes), `$1000` (sequence data), `$2C34` (sample directory entries) and `$0FFD` (the sample end pointer) for a song; `$2E00`, `$2F00`, `$2400`, `$2C00`, `$0FFF` for the driver; each closed by a record of length 0 whose destination word is the sample count (low byte) and the first sample index (high byte), followed by one index byte per further sample. All 22 streams tile to their last byte; every directory entry and every end pointer follows from `$3000` / `$7353` plus the sizes of the samples in `sfx00-20.sfx`.
  - The SPC reads port 0 as a song number or a command (`$F0` and up) on every sequence tick, and echoes its current command (`$04`) back: that is why `MusicLoadWaitFadeAck`, `MusicLoadWaitSilence` and `UploadSceneMusic` wait for values on `APUIO0`. A command of `$F0` or more is dispatched again on every tick while the port holds it, so the `$01` answer of `MusicLoadWaitFadeAck` is needed.
  - 289 `BRK` sites, 57 ids, all (id and `$3F`) in 1-38: 89 sites use the low byte (SFX voice 7, port 2), 200 the high byte (voice 8, port 3), 46 set bit 7 (both voices).
- Document written: 398 lines, two diagrams (11 and 9 nodes), every identifier checked; the only dead link is the hub `README.md`.
- `edits/I056.json` applied: 5 block notes, 8 part notes and 3 comments corrected in 10 notes files (the dry run had one length warning, the dog comment, which was shortened first).
- Hand edits done in `cop-dispatch.md`, `boot-nmi-main-loop.md`, `text-and-dialogue.md`, `menus-inventory-status-hud.md`, `audio/spc-engine.md` and `wram-memory-map.md`.
- Gate passed: `extract:lt` OK, `rebuild` SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` (1,081,344 bytes, checksum 110070696), `names --check` OK (2765 names), `merge --check` OK (0 errors, 0 warnings, 0 orphans).
