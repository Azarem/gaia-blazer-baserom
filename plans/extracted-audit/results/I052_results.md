# I052 results: docs/code/text-and-dialogue.md

Topic: text and dialogue. The `<files>` placeholder was empty, so the files were chosen like in I043-I051 (list in `plans/doc-audit/I052_checklist.md`).

## Deliverables

| File | What |
|------|------|
| `docs/code/text-and-dialogue.md` | New spoke, 426 lines: breadcrumb, source links, overview with one diagram, memory map (code, data, state), the string format and control-code table, the menu renderer, the dialogue renderer (second diagram), `Cop01`, a worked example (the restaurant dog), the choice menus, the B-button talk, chest and lair messages, name entry, story screens, banners, walkthrough cross-check, open questions, See Also |
| `plans/extracted-audit/edits/I052.json` | Merge spec: 3 note corrections and 1 comment correction (below) |
| `plans/extracted-audit/questions/I052_questions.md` | OQ-I052-1 to OQ-I052-3 (all GAP) |
| `plans/doc-audit/I052_checklist.md` | Checklist, written before the first edit |
| Hand edits | See Also lines in `cop-dispatch.md` (the planned-spoke line is now a link), `boot-nmi-main-loop.md`, `actor-system.md`, `vram-dma-hdma-palettes.md`, `player.md`, `scene-area-warp-loading.md`; the `text_delay` row of `docs/wram-memory-map.md` |

## Findings

1. **Sub-frame actors.** Three notes said that actors keep running or animating while text waits (`RunSubFrame` part note, `WaitFrames` part note, the `lib_text_render` block note). `FilterSubFrameActor` skips every actor without `$16` bit `$0010` while `subframe_active` is set, so only the hero and the other `$0010` actors run. Corrected through `merge` (spec `I052.json`); the new document says so in "Typing".
2. **`text_delay` is set at boot, not by a new game.** `InitFixedState` runs once from `BootGame`. Corrected in the `lib_text_render` block note, in the `RunEnding` comment at `{21425}` and in `docs/wram-memory-map.md`. The writers found by `rg text_delay` are listed in the document: `InitFixedState` 3, `RunEnding` 6, the Lisa epilogue 7, 5, 1, 5, 2, 5, the dock scenes 4 and 3, the restaurant dog 5 and restore.
3. **The standard box holds four lines** (first line at row 18, border at row 26), derived from `AdvanceDialogueLine` and `OpenDialogueBox`; marked as derived in the document and listed as OQ-I052-1.
4. **How a box closes.** The strings that end a speech carry `[08:408]` (11 files), directly or through a `[JMP]` to a shared tail (`asciistring_01EC46`, `ChestGemsFoundText`). This is evidence for OQ-I010-14; the universal claim is OQ-I052-3.
5. **No new DISCREPANCY.** The candidate "GEMs against Gems" is not a mismatch (the walkthrough writes "GEMs" in chapters 05, 06 and 08). The queen's name string `Queen` in `NpcNameStrings` is a short form of the walkthrough's "Queen Magridd", not a contradiction. The DISCREPANCY rows that touch the topic are carried by ID: OQ-I010-2, OQ-I004-5, OQ-I026-11.
6. The document links to `README.md` (the hub), which does not exist yet; the link is dead until the hub is written, as in I043-I051.

## Open questions

| ID | Tag | Topic |
|----|-----|-------|
| OQ-I052-1 | GAP | four-line capacity and scroll of the standard box (runtime) |
| OQ-I052-2 | GAP | B press: talk and sword swing |
| OQ-I052-3 | GAP | does every box that opens end with `[08:408]` |

## Gate

| Check | Result |
|-------|--------|
| `npm run merge -- plans/extracted-audit/edits/I052.json --dry-run`, then apply | OK; 4 notes files changed (`blockNotes/bank01`, `partNotes/bank00`, `partNotes/bank01`, `comments/bank00`) |
| `npm run extract:lt` | OK; the three corrected notes and the comment show in `extracted/` |
| `npm run rebuild` | SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1,081,344 bytes, checksum 110070696: unchanged; 27 "Cross bank call" warnings, as before |
| `npm run names -- --check` | OK (2765 names) |
| `npm run merge -- --check` | 0 errors, 0 warnings, 0 orphans (1401 comments, 1684 part notes, 135 block notes) |
| Document checks | 145 backticked identifiers exist in `extracted/` or `us/names/`; every `label` + `$bank:addr` pair matches `us/names/` after the LoROM conversion; relative links resolve except the hub `README.md`; 426 lines; 2 diagrams of 12 and 10 nodes (both under 15) |

## Follow-ups

- The hub `docs/code/README.md` should link `text-and-dialogue.md` and must not repeat the control-code table or the renderer descriptions.
- Planned spokes that this document leaves to others: the menus and inventory (every window there is a `PrintTextString` call), the HUD, the sound driver behind `BRK #$07` and `BRK #$18`.
- OQ-I010-1 (byte or word `text_delay`) could now be answered with one Mesen2 watch on `$1B85` during the Lisa epilogue, which writes words.

## Suggested commit message

```
docs(code): text and dialogue spoke (I052)

Add docs/code/text-and-dialogue.md: string format and control codes,
dictionary, menu and dialogue renderers, Cop01 and Cop1A, choice menus,
B-button talk, chest and lair messages, name entry, story screens.
Correct three notes that said actors keep running while text waits
(only $16 bit $0010 actors run in a sub-frame) and the text_delay
boot wording; link the spoke from the sibling documents.
Open questions OQ-I052-1..3. Rebuild SHA-1 unchanged.
```

Please commit when you're ready.
