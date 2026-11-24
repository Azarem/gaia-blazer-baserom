# I053 results: docs/code/menus-inventory-status-hud.md

Topic: menus, inventory, status and HUD. The `<files>` placeholder was empty, so the files were chosen like in I043-I052 (list in `plans/doc-audit/I053_checklist.md`).

## Deliverables

| File | What |
|------|------|
| `docs/code/menus-inventory-status-hud.md` | New spoke, 385 lines: breadcrumb, source links, overview with one diagram (14 nodes), memory map (code, data, state), the inventory table and the equipped cells with their readers, giving and removing items, the equipment menu (video state, rows, lists, icons, descriptions, gear numbers), the status and souls screen, Gems, EXP and HP queues, the HUD (dirty mask, layout, enemy gauge), walkthrough cross-check, open questions, See Also |
| `plans/extracted-audit/edits/I053.json` | Merge spec: 8 note corrections in 3 notes files |
| `plans/extracted-audit/edits/I053b.json` | Merge spec: 1 more note correction (an edit spec cannot be re-applied, so the late finding got its own file) |
| `plans/extracted-audit/questions/I053_questions.md` | OQ-I053-1 to OQ-I053-6 (2 DISCREPANCY, 4 GAP) |
| `plans/doc-audit/I053_checklist.md` | Checklist, written before the first edit |
| Hand edits | Planned-spoke lines of `player.md`, `vram-dma-hdma-palettes.md`, `actor-system.md`, `boot-nmi-main-loop.md`, `sprites-oam-animation.md`, `text-and-dialogue.md` are now links; `ExitEquipmentMenu` corrected in `player.md` and in five places of `docs/wram-memory-map.md` |

## Findings

1. **`ExitEquipmentMenu` is not the restore.** It is the `SEC` / `RTS` return of `RunEquipmentMenu`. The restore of the scroll words, `BG2SC`, `TM`, `CGADSUB`, `W12SEL`, the three-step graphics and palette restore, the projectile kill, `ApplyPlayerWeaponPose` and the HUD redraw are the tail of `OpenEquipmentMenu`. Two part notes (`LoadEquippedMagicGfx`, `RestoreSceneBgGfxAndPalette`), the `lib_player_helpers` block note, `player.md` and five places of `wram-memory-map.md` named the wrong routine; all corrected.
2. **`LoadEquippedMagicGfx` runs after every menu close.** The spell graphics sit at VRAM word `$2600`, inside the `$2000`-`$2FFF` block that `LoadMenuBg2Graphics` overwrites, so the menu destroys them; the call is unconditional. The part note and the `MagicGraphicsPointers` note said "when the equipped magic changes"; corrected.
3. **`MagicPalettePointers` has 3-byte entries**, like `MagicGraphicsPointers`; `LoadEquippedMagicGfx` indexes both with 3 × n and reads only the word of the palette entry (the bank is fixed to `$0F`). The `lib_menu_screen_setup` block note said "a word per spell"; corrected.
4. **"Next level :" is the next level's EXP total.** `player_exp_next` is loaded from `LevelExpThresholds` by `WatchForLevelUp` and compared with `player_exp`, which is never reduced; the notes of `ShowStatusAndSoulsScreen` and `lib_menus` said "the EXP still needed". Corrected; runtime check is OQ-I053-6.
5. **The Herb's "old value was `$38`" branch is reachable** (reachability half of OQ-I026-7): `Cop0A_GiveItemIfNotOwned` never reaches it, but `TryOpenChest` calls `StoreInventoryEntry` with no ownership test and 13 of the 67 chest rows hold content `$38`. The count comes from the content bytes of `data_chest_lists.asm`; the heal itself is OQ-I053-3.
6. **A used Herb or Bottle leaves a marked empty slot** (`Cop0B_RemoveItem` keeps `$80`), and `StoreInventoryEntry` ORs the old bit 7 back in, so the next one is worn at once (OQ-I053-4, derived).
7. **Inventory address of entry `$38` is `$1B55`** (`$1B1E` + `$38` − 1). OQ-I026-7 and OQ-I006-2 wrote `$1B56`; the new questions use `$1B55`. The old rows were left as they are (earlier records are not rewritten).
8. **Who reads the equipped cells** is now one table (weapon: gear sums, input filter, pose, six combat effects, Lucky Blade, Phoenix gear; armor: gear sums, Magic Armor, Light and Mystic Armor, Phoenix gear; magic: spell dispatch, spell graphics, Phoenix; bracelet cell: Magic Bell, the three bracelets). Scripts that test items use `Cop18` / `Cop19` on the table's bit 7 instead.
9. **Fourteen stub description records** (ids `$2B`-`$31`, `$33`, `$34`, `$3B`-`$3F`), not the seven the part reading suggests.
10. **Walkthrough cross-check:** the menu buttons, "Wep.", ten item-grid positions, the weapon and armor tables (levels and +1 … +12), the spell order and Gem costs, the Bell and Magic Armor, the bracelets (Power, Shield), the Herb, the Gem counter, the HP bar and the lair count on Start agree. New DISCREPANCY: the Psycho Sword (`items.md` "N/A" against `03-greenwood.md` and the ROM text, OQ-I053-1) and the Recovery Sword text against its code (OQ-I053-2).
11. The document links to `README.md` (the hub), which does not exist yet; the link is dead until the hub is written, as in I043-I052.
12. `extracted/` currently holds line-tracked output (`; {n}` tags), because the last command before the gate was `npm run extract:lt`, as in earlier iterations.

## Open questions

| ID | Tag | Topic |
|----|-----|-------|
| OQ-I053-1 | DISCREPANCY | Psycho Sword effect: `items.md` "N/A" against chapter 3 and the ROM text |
| OQ-I053-2 | DISCREPANCY | Recovery Sword: text "HP will be filled" against +1 HP per kill |
| OQ-I053-3 | GAP | a second Herb chest heals at once (runtime) |
| OQ-I053-4 | GAP | a used Herb or Bottle leaves a marked slot and the next one is worn automatically |
| OQ-I053-5 | GAP | HUD rows against the BG3 scroll HDMA region, and the `$700` row |
| OQ-I053-6 | GAP | "Next level :" shows the EXP total, not a remainder |

## Gate

| Check | Result |
|-------|--------|
| `npm run merge -- plans/extracted-audit/edits/I053.json --dry-run`, then apply | OK; 3 notes files changed (`blockNotes/bank01`, `partNotes/bank00`, `partNotes/bank01`) |
| `npm run merge -- plans/extracted-audit/edits/I053b.json --dry-run`, then apply | OK; 1 notes file changed (`blockNotes/bank02`) |
| `npm run extract:lt` | OK; the corrected notes show in `extracted/` (`ExitEquipmentMenu` no longer appears in `lib_player_helpers.asm` or `lib_menu_screen_setup.asm`) |
| `npm run rebuild` | SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1,081,344 bytes, checksum 110070696: unchanged; 27 "Cross bank call" warnings, as before |
| `npm run names -- --check` | OK (2765 names) |
| `npm run merge -- --check` | 0 errors, 0 warnings, 0 orphans (1401 comments, 1684 part notes, 135 block notes) |
| Document checks | 200 backticked identifiers exist in `extracted/` or `us/`; 83 `label` + `$bank:addr` pairs match `us/names/` after the LoROM conversion; 34 state rows match `us/mnemonics.json`; relative links resolve except the hub `README.md`; 385 lines; 1 diagram of 14 nodes |

## Follow-ups

- The hub `docs/code/README.md` should link `menus-inventory-status-hud.md` and must not repeat the equipped-cell reader table or the menu restore order.
- The `lib_choice_menus` and `lib_menu_screen_setup` parts that serve the file select (`ChooseMenuRowAtTable`, `SetupMenuBg2Screen`) are left to the file-select and save spoke.
- OQ-I024-7 (rename `equipped_bracelet`) is still a decision; the document keeps the current name and says what the cell holds.
- OQ-I053-3, -4 and -6 can be settled in one Mesen2 session with `write_memory` on `$7E:1B55` and two screenshots.

## Suggested commit message

```
docs(code): menus, inventory, status and HUD spoke (I053)

Add docs/code/menus-inventory-status-hud.md: inventory table and the
equipped cells with their readers, item give/remove, the equipment
menu and its video-state swap and restore order, icons, descriptions,
gear numbers, the status and souls screen, Gem/EXP/HP queues, the HUD
dirty mask and enemy gauge.
Correct notes that named ExitEquipmentMenu as the menu restore (it is
the tail of OpenEquipmentMenu), that said the spell graphics reload
only when the magic changes, that gave MagicPalettePointers a word per
spell, and that called player_exp_next the EXP still needed. Link the
spoke from the sibling documents. Open questions OQ-I053-1..6.
Rebuild SHA-1 unchanged.
```

Please commit when you're ready.
