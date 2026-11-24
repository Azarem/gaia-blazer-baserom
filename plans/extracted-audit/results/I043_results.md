# I043 results: `docs/code/boot-nmi-main-loop.md` (boot, NMI and main loop)

PD step of the plan "Blazer docs and analysis". The prompt left `<files>` empty; I chose the files that make up the topic (see Sources). Work started from a fresh `npm run extract:lt`; the gate was run at the end.

## Deliverables

| File | What |
|------|------|
| `docs/code/boot-nmi-main-loop.md` | New topic document (322 lines): breadcrumb, source links, overview with two mermaid diagrams (frame, NMI), memory-map table (40 routines plus the state table), 25 `###` headings (one is the state table), walkthrough cross-check, open questions, See Also. |
| `plans/extracted-audit/edits/I043.json` | Merge spec: 7 partial edits that correct stale notes (see Findings). |
| `plans/extracted-audit/renames/apply-I043_names.json` | 14 sub-label renames (`loc_xxxxxx` to descriptive names) in the NMI file, `RunSubFrameLoader` and `WaitVBlank`; applied with `npm run names`. |
| `plans/extracted-audit/questions/I043_questions.md` | OQ-I043-1 to OQ-I043-5. |
| `plans/extracted-audit/results/I043_results.md` | This file. |

Sources documented: `engine_boot_main_loop`, `engine_vblank_nmi`, `lib_system_helpers` (NMI switches, `ResetHdmaQueue`, `ApplyBootPpuLayout`), `lib_main_loop_helpers` (`QueueAnimatedTileStrip`, `HandlePauseBanner`, `WaitFrameForStart`), and the boot callees `InitHardwareAndClearWram`, `InitFixedState`, `ClearBg3Buffer`, `ChangeSceneIfRequested`, `UploadScrollStrips`, `HandleBrk`, `HandleIrq`. The HDMA queue entry points (`QueueHdmaDirect`, `QueueHdmaIndirect`) and the scene loader internals are left to the VRAM/HDMA and scene-loading spokes.

## Findings

1. **Stale notes corrected through `merge`** (all were wrong against the code, no byte changed):
   - `ResetHdmaQueue` part note named "the two scene-change paths and the sub-frame wrapper"; the six call sites are `RunMainLoop`, `RunReducedLoop`, `RunReturnLoop` and the three sub-frame runners, all in `engine_boot_main_loop`.
   - `QueueAnimatedTileStrip` part note and `lib_main_loop_helpers` block note spoke of "wait loops of the front end"; the five call sites are `RunMainLoop`, `RunReturnLoop` and the three sub-frame runners. The "water, lava and similar" claim was replaced by "animated background tiles" (which tiles is still OQ-I013-14).
   - `engine_boot_main_loop` block note and `RunReducedLoop` part note called locations `$10`-`$12` "unnamed scenes of the Up Above area". See 2.
2. **OQ-I005-21 settled statically (runtime check left as OQ-I043-2).** The first command of the records of area 0 scenes `$0A`, `$0B`, `$0C` in `data_scene_asset_lists` is `asset8 < #10 >`, `#11`, `#12`, no other record uses these values, and `ApplySceneProfile` stores that id in `location_id`. So the reduced loop runs only in the title (`$10`), the ending (`$11`) and the boot scene (`$12`), and `UpdateTitleMode7` (acts at `$10`) is consistent with that. The Up Above hub scene is not among them.
3. **`VMAIN` invariant of the NMI.** `UploadScrollStrips` writes `VMAIN = $81` and then `$80` before it tests whether the records are empty; it is the only `VMAIN` write in the NMI, so every NMI leaves `$80` for the later transfers and for the next NMI's `DmaBg3TilemapPage`. The DMA source bank is hard-coded `$7E`; `InitFixedState` sets `dp$34`/`dp$37` for the pointer reads.
4. **Possible VRAM overlap (OQ-I043-4).** `OBJSEL` is written only at boot (0, then `$01`), which puts the sprite character base at word `$2000` by the hardware rule; `DmaDynamicSpriteTiles` fills `$2000`/`$2100` upward, and `DmaAnimatedTileStrip` refreshes `$2060`-`$20C0` and `$100` words above them. Needs a Mesen2 look.
5. **Walkthrough cross-check:** no mismatch (no DISCREPANCY). Terms checked: Start at the title opens the file select, Start shows the number of monster lairs, B speaks to a person, the Medical Herb heals at 0 HP.

## Open questions

OQ-I043-1 (even/odd sound port), OQ-I043-2 (runtime `location_id` of the front-end scenes), OQ-I043-3 (D at NMI entry), OQ-I043-4 (VRAM `$2000`-`$21FF` shared), OQ-I043-5 (worst-case NMI length). Details and Mesen2 tools in `questions/I043_questions.md`. Claims in the document that rest on static reading say so ("by static reading"): the frame-rate effect of `EnableNmi`, the front-end location numbers.

## Not done / follow-ups

- The breadcrumb and the first line of the document link to `docs/code/README.md`, which does not exist yet (the hub is a later PD step). The link is dead until then. The hub name is my choice (`README.md`, matching `docs/README.md`); the skeleton in `code-bank-documentation.md` says `index.md`: rename the breadcrumb if the hub is called `index.md`.
- The planned spokes (actor system, scene loading, VRAM and HDMA, HUD) are named in See Also without links.

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK (fresh before the work and again after the merge) |
| `npm run merge -- plans/extracted-audit/edits/I043.json --dry-run`, then applied | 3 files, 5 notes files written; the changes show in `extracted/` |
| `npm run names -- apply-I043_names.json --dry-run`, then applied | 14 renames |
| `npm run rebuild` | OK, SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1081344 bytes: unchanged (annotation and rename only) |
| `npm run names -- --check` | OK (2693 names) |
| `npm run merge -- --check` | OK: 1397 comments, 1684 part notes, 135 block notes; 0 errors, 0 warnings, 0 orphans, 0 duplicate keys |
| Links in the new document | all relative targets exist except the hub `README.md` (see above) |

No original-versus-rebuilt ROM comparison was made; the SHA-1 is the one recorded for the rebuilt ROM.

## Suggested commit message

```
docs: add code doc for boot, NMI and main loop (I043)

- docs/code/boot-nmi-main-loop.md: reset, RunMainLoop and its variants,
  sub-frame runners, pause, NMI uploads, joypad and sound port
- names: 14 sub-labels of engine_vblank_nmi, RunSubFrameLoader, WaitVBlank
- notes: correct call-site lists of ResetHdmaQueue and QueueAnimatedTileStrip,
  and the location_id $10-$12 scenes (title, ending, boot)
- plans: I043 edits, renames, questions OQ-I043-1..5, results
```

Please commit when you're ready.
