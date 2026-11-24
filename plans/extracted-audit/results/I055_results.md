# I055 results: docs/code/flags-switches-and-inventory-bytes.md

Topic: flags, switches and inventory bytes. The `<files>` placeholder was empty, so the files were chosen like in I043-I054 (list in `plans/doc-audit/I055_checklist.md`).

## Deliverables

| File | What |
|------|------|
| `docs/code/flags-switches-and-inventory-bytes.md` | New spoke, 356 lines: breadcrumb, source links, overview with one diagram (14 nodes), memory map (code, data, state), the state (the shared bit space and its two addressings, event flags by byte, chests, lairs and switches, permanent map changes), the inventory (the table and the commands, giving an item, the progress items, the souls), a lifetime table, walkthrough cross-check, open questions, See Also |
| `plans/extracted-audit/edits/I055.json` | Merge spec: 5 notes corrected (the `RegisterSwitchOwner` part note, three block notes, the `lib_map_tile_patches` bullet) and 5 comments rewritten, in 7 notes files |
| `plans/extracted-audit/questions/I055_questions.md` | OQ-I055-1 to OQ-I055-6 (all GAP), plus the static answers to OQ-I011-13, OQ-I031-5, OQ-I035-7, OQ-I037-4 and OQ-I035-6 |
| `plans/doc-audit/I055_checklist.md` | Checklist, written before the first edit, ticked as items finished |
| Hand edits | `cop-dispatch.md` (the "Event flags and switches" paragraph no longer says the readers of `switch_owner_table` are untraced; link; See Also), `menus-inventory-status-hud.md` and `save-and-load.md` (See Also), `docs/wram-memory-map.md` (rows `switch_owner_table` and `event_flags`, the note on the chest, lair and switch arrays) |

## Findings

1. **One bit space, three arrays.** The bit-array routines take a bit number (`& $3FF`) and a base: event flags `$1A5E` (`$000-$0FF`), chests `$1A7E` (`$100-$17F`, 16 of 32 bytes used), released lairs `$1A9E` (`$200-$3FF`); the switches `$1ADE` have their own base. The COP flag word is the same number split in two (bits 8-14 byte, bits 0-7 bit), so flag `$1F02` is bit `$FA`. `FlagMapPatchTable` stores the bit number directly, which is why 33 of its 70 rows test event flags and 37 test released lairs.
2. **114 distinct flags are named by 480 COP sites** (`Cop05` 70, `Cop07` 190, `Cop08` 7, `Cop09` 213), in bytes `$00-$0A` and `$19-$1F`; bytes `$0B-$18` are never named. Flag bytes by meaning: `$1A0n` Emblem n taken, `$1B0n` stone n given, `$1C00-$1E00` Fairy Gem rewards paid once.
3. **Only byte 0 of the flags is scene-local** (`InitSceneState` clears it at every scene load); scripts use it as scratch and two boss scripts as a counter.
4. **Flag `$FF` (`$1F07`) is set at boot and never cleared**, so the 13 map-patch rows that test it always apply (answers the static part of OQ-I011-13 and OQ-I031-5).
5. **Five flags are only written by scripts** (`$0502`, `$0601`, `$0706`, `$0907`, `$0A00`); they are bit numbers of map-patch rows, so `ApplyFlagMapPatches` is their reader. OQ-I037-4 and OQ-I035-6 ("no reader found") are answered, and the five writer comments say so now.
6. **`$1B01` is the Green Stone's given flag** and `$1B00-$1B05` pair with the stones `$3A-$3F`; `gv_up_above_actors_and_name_entry` reads all six (OQ-I035-7).
7. **`switch_owner_table` has one reader, `FacePlayerTowardReturnTarget`, and is zeroed only on a return trip.** The old note said "cleared at every scene load" and "readers not traced yet".
8. **The three lair writers set `$1A9E` and `$1ADE` together**, so the arrays are equal bit for bit (OQ-I055-1). `PlayLairReleaseScene` runs in the home location of a freed NPC (started by `RunLairReleaseOnReturn`), not at the switch. 27 of 420 lair records have a release switch at `+1E`, none pointing at itself.
9. **`ShowOpenedChests` redraws an opened chest as a column walk** (every `$FB` cell from (x, y - 1) down to the map end becomes `$FC`). `ChestListLoc2B` has two chests in one column twice, and `ChestListLoc29` has two rows with id `$17` holding the same item (OQ-I055-3). 67 chests in 36 lists: 21 Gems, 3 empty, 43 items (13 Medical Herbs, 5 Strange Bottles).
10. **The Herb rule is in `StoreInventoryEntry`**: it tests the old value `$38` and sets `heal_pending`, which matches the walkthrough's "if you already have one and get another, effect is immediate". Only chests can trigger it, because `Cop0A` skips owned items. Ids from `$19` up keep the old equipped bit 7, so a removed equipped item comes back equipped.
11. **Hand-over is `Cop19` (equipped in the Item cell) then `Cop0B`**, as the walkthrough's "equip the ..." lines say; Goat's Food is the exception (`Cop18` twice).
12. **`souls_flags` bits 0-4** are Magician, Light, Shield, Detection, Reality, each set together with one event flag; `RunEnding` tests `& $1F` for exactly 1 and clears it.
13. The document links to `README.md` (the hub), which does not exist yet; the link is dead until the hub is written, as in I043-I054.
14. `extracted/` holds line-tracked output (`; {n}` tags), because the last extraction before the gate was `npm run extract:lt`, as in earlier iterations.

## Open questions

| ID | Tag | Topic |
|----|-----|-------|
| OQ-I055-1 | GAP | Are `$1A9E` and `$1ADE` ever different? |
| OQ-I055-2 | GAP | The 27 records with a release switch at `+1E` and their chains |
| OQ-I055-3 | GAP | The duplicate chest id `$17` in `ChestListLoc29`; the column walk of `ShowOpenedChests` over the paired chests of `ChestListLoc2B` |
| OQ-I055-4 | GAP | Uses of the never-named flags (bytes `$0B-$18`, `$1A01`, `$1A03`, `$1B06`) |
| OQ-I055-5 | GAP | Flag `$FF` in every game; the image tail `$1B9B-$1C57` |
| OQ-I055-6 | GAP | What `$1B07` records |

No DISCREPANCY: the game terms of the document agree with `items.md`, `sidequests.md`, `02-grass-valley.md`, `03-greenwood.md`, `04-st-elles.md` and chapters 05-08 as far as static reading can check.

## Gate

| Check | Result |
|-------|--------|
| `npm run merge -- plans/extracted-audit/edits/I055.json --dry-run`, then apply | OK; 7 notes files changed (`blockNotes/bank00`, `bank01`, `bank02`, `partNotes/bank00`, `comments/bank01`, `bank02`, `bank0F`); two length warnings (comments `{121270}` and `{1023459}`) |
| `npm run extract:lt` | OK; the corrected notes and comments show in `extracted/` |
| `npm run rebuild` | SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1,081,344 bytes, checksum 110070696: unchanged; the "Cross bank call" warnings are as before |
| `npm run names -- --check` | OK (2765 names) |
| `npm run merge -- --check` | 0 errors, 0 warnings, 0 orphans (1401 comments, 1684 part notes, 135 block notes) |
| Document checks | the memory-map addresses were read from `us/names/` (LoROM conversion); all 134 backticked identifiers exist in `extracted/` or `us/names/`; relative links resolve except the hub `README.md`; 356 lines; 1 diagram of 14 nodes; the flag counts per byte were re-summed from the survey |

## Follow-ups

- The hub `docs/code/README.md` should link `flags-switches-and-inventory-bytes.md` and must not repeat the bit-space table or the flag survey.
- OQ-I055-3 can be settled statically first (the stride of the `ShowOpenedChests` loop, `dp$00`), then with one Mesen2 run at location `$2B`.
- The question rows of OQ-I011-13, OQ-I031-5, OQ-I035-7, OQ-I037-4 and OQ-I035-6 in earlier iterations are left as they are; their static answers are in `I055_questions.md`.
- What the five map-patch flags draw (the rectangles of `FlagMapPatchTable`) belongs to a map-patch or scene spoke.

## Suggested commit message

```
docs(blazer): add flags-switches-and-inventory-bytes spoke (I055)

Document the shared bit space ($1A5E arrays), the COP flag word, event flag
lifetime, chests, lair switches, the permanent map patches, the inventory
byte and the progress items. Correct the notes of RegisterSwitchOwner,
InitFixedState, FlagMapPatchTable and the chest lists, and the comments of
the five map-patch flags and $1B01. Link the spoke from cop-dispatch,
menus-inventory-status-hud, save-and-load and wram-memory-map.
```

Please commit when you're ready.
