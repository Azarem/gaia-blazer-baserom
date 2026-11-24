# I054 results: docs/code/save-and-load.md

Topic: save and load. The `<files>` placeholder was empty, so the files were chosen like in I043-I053 (list in `plans/doc-audit/I054_checklist.md`).

## Deliverables

| File | What |
|------|------|
| `docs/code/save-and-load.md` | New spoke, about 290 lines: breadcrumb, source links, overview with one diagram (11 nodes), memory map (code, data, state, the slot layout and the image offsets), the slot format (contents, checksum, mirror and write order), the Master's Record and `SaveGameToSlot`, the file select (title Start, `DrawSaveSlotMenu`, `HandleFileSelectChoice`, Erase record, load and the empty slot), what is not saved, walkthrough cross-check, open questions, See Also |
| `plans/extracted-audit/edits/I054.json` | Merge spec: 15 note edits (5 block-note edits, 6 part-note edits, 4 comments) in 7 notes files |
| `plans/extracted-audit/questions/I054_questions.md` | OQ-I054-1 and OQ-I054-2 (both GAP), plus the static answers to OQ-I024-5 and OQ-I011-12 |
| `plans/doc-audit/I054_checklist.md` | Checklist, written before the first edit, ticked as items finished |
| Hand edits | `menus-inventory-status-hud.md` (the planned-spoke line is now a link, the overview names the new spoke), `scene-area-warp-loading.md` (two "inferred" cells), `boot-nmi-main-loop.md` and `text-and-dialogue.md` (links), `docs/wram-memory-map.md` (`$1B90`: "after Continue") |

## Findings

1. **Only two places touch the SRAM, each with one caller.** `SaveGameToSlot` is called only by the Master's Record (`cm_npc_master_record_0076EF`); `LoadGameFromSlot` only by `HandleFileSelectChoice`. No other file of `extracted/` has an absolute `$70:xxxx` operand or an `MVN` with the bank `$70`. A death never reloads a slot.
2. **The fifth row of the file select is `Erase record`** (`SaveSlotMenuText`; cursor cell `$05CA` = `TitleMenuCursorOffsets[4]`). The old "probably erase" is settled by the label. The erase stores the slot offset over word 0 of the main and the backup block, so both checksums fail; the data stay in the SRAM. Edge case (derived, OQ-I054-1): a slot whose word 0 already equals the written value would survive.
3. **A failed load is a new game**: the walkthrough says "Opt for an empty file to begin" (`01-in-the-beginning.md`), which is the carry-set path (`scene_next` = 1). The "inferred" wording of three notes and two table cells is gone. A new game keeps whatever the boot left in WRAM (`InitFixedState` is called once from `BootGame`).
4. **The notes said "after Continue"; there is no Continue row.** The rows are `No1` to `No4` and `Erase record`. Corrected in `lib_save_system` (block note and the `SaveGameToSlot` comment) and in `wram-memory-map.md`.
5. **The name field is nine bytes** (`$0447-$044F`): five word loads whose last overlaps the fourth, so a full eight-letter name keeps its terminator (the same fact as the terminator at `$1B9A`, OQ-I010-13). The block note said "five fields into `$0447-$044E`".
6. **The Area column is one BCD digit**, the low nibble of `saved_scene` = the world number 1-7 (answers the width question of OQ-I011-12).
7. **The slot is `lair_state` (`$200`) + the image `$1A5E-$1C57` (`$1FA`) + two checksum words**; the first `$1FD` words are summed and xored from the seed `$3652`. A table maps every named cell of the image to its slot offset. The tail `$1B9B-$1C57` is not named by any operand (OQ-I054-2).
8. **The mirror makes a reset during a Record harmless**: the main block and its checksum are written first, the mirror last; the file select repairs from the mirror on every open and refreshes it.
9. **Record always writes the file chosen at the title**, including the empty file of a new game; the walkthrough's "The northern square will allow you to save your adventure, as well as move on later in the game" (`01-in-the-beginning.md`) matches Record and Move on tile (7, 4), with Move gated by flag `$1B00`.
10. **dp `$0C`, `$16`, `$18` scratch of the save routines is harmless**: the main loop runs with D = 0, so these are global scratch cells and not actor fields.
11. **EnterFileSelect follows Start**: the title scene is reloaded with `file_select_request` = 1 and the title actor branches to it; the notes said "when the player chooses to load". Corrected.
12. The document links to `README.md` (the hub), which does not exist yet; the link is dead until the hub is written, as in I043-I053.
13. `extracted/` holds line-tracked output (`; {n}` tags), because the last extraction before the gate was `npm run extract:lt`, as in earlier iterations.

## Open questions

| ID | Tag | Topic |
|----|-----|-------|
| OQ-I054-1 | GAP | Erase record at runtime: the colour change, the vanished slot, and the case in which word 0 already equals the written value |
| OQ-I054-2 | GAP | The contents of the saved image tail `$1B9B-$1C57` |

No DISCREPANCY: the game terms of the document agree with `01-in-the-beginning.md`, `05-mountain-of-souls.md`, `06-dr-leos-lab.md` and `07-king-magridds-castle.md` (the walkthrough's "save point" against the ROM's `Record` is a naming difference).

## Gate

| Check | Result |
|-------|--------|
| `npm run merge -- plans/extracted-audit/edits/I054.json --dry-run`, then apply | OK; 7 notes files changed (`blockNotes/bank00`, `blockNotes/bank02`, `partNotes/bank00`, `partNotes/bank01`, `partNotes/bank02`, `comments/bank00`, `comments/bank02`) |
| `npm run extract:lt` | OK; the corrected notes show in `extracted/` (`Erase record`, no "after Continue", no "inferred" in `engine_title_file_select.asm` and `lib_save_system.asm`) |
| `npm run rebuild` | SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1,081,344 bytes, checksum 110070696: unchanged; the "Cross bank call" warnings are as before |
| `npm run names -- --check` | OK (2765 names) |
| `npm run merge -- --check` | 0 errors, 0 warnings, 0 orphans (1401 comments, 1684 part notes, 135 block notes) |
| Document checks | the labels and addresses of the memory map were read from the extracted source and `us/names/` (LoROM conversion); the identifiers that are not in the map were spot-checked in `extracted/`; relative links resolve except the hub `README.md`; about 290 lines; 1 diagram of 11 nodes |

## Follow-ups

- The hub `docs/code/README.md` should link `save-and-load.md` and must not repeat the slot table or the file select flow.
- OQ-I054-1 and OQ-I054-2 can be settled in one Mesen2 session (screenshots and `dump_memory` of `$70:0000` and `$70:1000`).
- The Master's other commands (Move, the arrival-tile texts) are only summarised here; they belong to a shrine or Up Above spoke.
- OQ-I024-5 and OQ-I011-12 are answered statically; the question rows of earlier iterations are left as they are.

## Suggested commit message

```
docs(code): save and load spoke (I054)

Add docs/code/save-and-load.md: the four SRAM record slots (layout,
checksum, backup mirror, write order), the Master's Record, the file
select (list, repair, Erase record, load, empty slot as a new game),
what is not saved, walkthrough cross-check.
Correct notes that called the failed load "inferred", the erase
"probable", the file select's saved-scene load "after Continue", the
name field eight bytes, and EnterFileSelect's caller "choose to load".
Link the spoke from the sibling documents. Open questions
OQ-I054-1..2. Rebuild SHA-1 unchanged.
```

Please commit when you're ready.
