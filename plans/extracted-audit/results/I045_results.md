# I045 results: `docs/code/cop-dispatch.md` (COP dispatch)

PD step of the plan "Blazer docs and analysis", topic "COP dispatch (extends `docs/cop/index.md`; handler families get links)". The prompt left `<files>` empty; I chose the files that make up the topic (see Sources), as in I043 and I044. Work started from a fresh `npm run extract:lt`; the gate was run at the end. The plan checklist is `plans/doc-audit/I045_checklist.md`.

## Deliverables

| File | What |
|------|------|
| `docs/code/cop-dispatch.md` | New topic document (344 lines): breadcrumb, source links, overview with two mermaid diagrams (a `COP` from script to handler and back, the exit chain) and a table of the six handler files with handler and use counts, memory-map table (26 entries), 16 `###` sections (HandleCop, command tables, operands, exit chain with the skip table, resume pointer writers, wait pairs, delays and loops, position conventions, three-way branches, tile probes, flag/inventory/footprint/slot helpers, spawning pointer, COP outside a script, HandleBrk, worked example), walkthrough cross-check, open questions, See Also. |
| `plans/extracted-audit/edits/I045.json` | Merge spec: find/with edits of block notes and part notes and 4 comments in 3 extracted files. |
| `plans/extracted-audit/edits/I045b.json` | Second merge spec (two corrections found while checking the document): `ClearActorFootprint`, the `cop_tiles_spawn_kill` block note and `Cop86_KillSelf`. |
| `plans/extracted-audit/renames/apply-I045_names.json` | 21 sub-label renames (`loc_xxxxxx` to descriptive names) in `HandleBrk`, `Cop04`, `Cop05`, the box test, `Cop82`/`Cop83`, `Cop9A`/`Cop9B`, `CopA5`, `CopAD` and the two multi-tile footprint branches; applied with `npm run names`. |
| `plans/extracted-audit/questions/I045_questions.md` | OQ-I045-1 to OQ-I045-3. |
| `plans/extracted-audit/results/I045_results.md` | This file. |
| `plans/doc-audit/I045_checklist.md` | The checklist with its progress section. |
| `docs/cop/index.md`, `docs/code/boot-nmi-main-loop.md`, `docs/code/actor-system.md` | Edited by hand (no notes, comments or names): see Findings 6 to 9. |

Sources documented: `cop_dispatch` (`HandleCop`, `HandleBrk`, the three tables), `cop_core` (exit chain, `TestEventFlag`, `WriteEventFlag`, `LookupInventoryEntry`, the footprint routines, `SlotNumberToActor`, `TileToPixel`, `RegisterSwitchOwner`, the spawn helpers as pointers), the five `cop_handlers` files (as families, with the per-command list left to the hub) and `copdef.json` (operand types). The worked example is `gv_village_actors_019475` (`gv_obj_leos_painting_019475` and its helpers).

## Findings

1. **`HandleBrk` had a wrong count.** The note said "about a hundred call sites"; `rg '^\s+BRK #'` over `extracted/` finds 289 instructions. Corrected in the part note and in `boot-nmi-main-loop.md` (which had the same sentence).
2. **The wait commands were described as re-running "next frame".** `Cop82`, `Cop83` and `Cop9E` yield with the pointer that `Cop80`, `Cop81` and `Cop9D` saved, and `SetActorAnimFrame` puts the step duration in `$14`, so the next call is duration + 1 frames later. The `cop_core` block note also said that `Cop82` and `Cop83` save a resume pointer; they do not (only `Cop05` and `CopAD` do). Both notes and the `Cop82` part note are corrected. The pairing is complete in the code: 1,614 of 1,614 `COP [80]` are followed by `COP [82]`, 522 of 522 `COP [81]` by `COP [83]`, 51 of 51 `COP [9D]` by `COP [9E]` and 21 of 21 `COP [92]` by `COP [94]`; seven `COP [82]` and seven `COP [83]` sites follow a `COP [91]`; two `COP [82]` sites follow neither (OQ-I045-2).
3. **`CopExitJump` writes only the PC word of the frame.** The part note said it replaces the return address; the bank byte at `$04,S` is untouched and `RTI` restores P, so a jump can never leave the bank of the script. That is why every jump target is a 2-byte `&Code`. The note now says so; `CopExitYield` says when the actor is called again (`$14` has run out).
4. **`SpawnActorBefore` still carried the pre-I044 run order** ("an actor linked before X runs earlier"); it sits on the `$3E` side and runs right after X in the same frame. Corrected (I044 fixed the block note and `SpawnActorAfter` only).
5. **`CopFillerTable_3D_7F` is not only `#$0000` and `#$FFFF`:** index `$26` (id `$63`) is `#$0020`. Corrected in the part note and the hub.
6. **Hub corrections (`docs/cop/index.md`).** The intro no longer says "small byte-code script"; the filler words include the `#$0020`; the `CopExitYield` row says when the script resumes; `Cop1A` row: the byte is the number of entries (`RunChoiceMenu` gets it in A) and the string is always in bank `$02`; `Cop9A`/`Cop9B` row: left when abs(d) > T, right when d >= T (one pixel asymmetry from `EOR #$FFFF` without `INC`). A link to the new document was added.
7. **`Cop1A`'s string pointer is in bank `$02` by design.** `copdef.json` writes `&ASCIIString$2`; the `$2` is a bank hint of the copdef reader (`gaia-core` `cop.ts`), and `PrintTextString` forces `DBR = $02`. All 27 `COP [1A]` sites use `shared_choice_prompt_texts` (bank `$02`). The "Cross bank call detected ... COP ChoiceYesNoText" lines of `npm run rebuild` (present before this step) come from the writer warning for every `&` reference of a `COP` into another bank; they are expected for this command. No change made.
8. **`ClearActorFootprint` note said "before it moves an actor"** for `Cop11_MoveActorToTile`; the code stores the new position first and then clears the footprint at the new place (as the `Cop11` note and OQ-I025-8 already say). Corrected in I045b.
9. **`COP [86]` is followed by `RTL` at 280 of 283 sites**, not at all of them: `KillAllOtherActors`, `KillAllProjectiles` and `ApplyGemPickup` issue it from engine code with X = the victim. The `Cop86_KillSelf` part note and the block note of `cop_tiles_spawn_kill` said "always"; corrected in I045b.
10. **Other documented behaviour that the notes left unsaid:** the handlers enter with M = 16 and the script's P comes back with `RTI`; four handlers (`Cop1A`, `CopA8`, `CopA9`, the unused `Cop29`) read a byte with M = 8 and carry into `$39` by hand; `Cop83` decrements before testing, so a count of 0 would run 65,536 times (no script uses a count below 2); `Cop9A`/`Cop9B` have a one-pixel asymmetry; `Cop2B` clears the type nibble together with the mark. These are in the document and in the new comments on `HandleBrk`, `HandleCop`, `CopExitJump` and `CopExitYield`.
11. **Counts verified.** 11,025 `COP` lines, 108 handlers of which 91 are used, and the per-family sums (2,076 + 840 + 639 + 5,964 + 1,392 + 114) match the hub; the animation family is 54 % of all sites.
12. **Walkthrough cross-check:** Leo's Brush and the painting, the switch under a cleared lair, Magic Bell, Magic Armor, Medical Herb and Strange Bottle agree. One DISCREPANCY: the place name (`Leo's Painting` in the walkthrough, `Leo s Paintings` in the ROM banner text; OQ-I045-1).

## Open questions

OQ-I045-1 (the place name, DISCREPANCY, decision), OQ-I045-2 (two `COP [82]` sites without a resume-saving predecessor), OQ-I045-3 (D = 0 and DBR = `$01` at `HandleCop`, read from the boot code, not measured). Details and Mesen2 tools in `questions/I045_questions.md`. Earlier questions the document relies on: OQ-I001-1, OQ-I024-1, OQ-I025-4, OQ-I025-8.

## Not done / follow-ups

- The breadcrumb links to `docs/code/README.md`, which does not exist yet (the hub is a later PD step); the link is dead until then, as in I043 and I044.
- Renames: only the sub-labels the document cites were renamed (21). Many other `loc_xxxxxx` sub-labels remain in the handler files (`CopFlagJumpTail` has `loc_005852`, `loc_005857`, `loc_00585A`; the `Cop3B` paths; `Cop9C`; the animation steppers); they are not needed to follow the mechanism.
- The use counts in the part notes ("When: 245 scripts" and so on) were re-added to the family sums, not re-counted one by one; the sums equal the hub and the total.
- `RegisterSwitchOwner` readers remain untraced (named in the document as such).
- No Mesen2 run was made; claims about the register state at `HandleCop` and about resume pointers are static (OQ-I045-2, -3).

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK (fresh before the work, after the names step, after each merge and at the end) |
| `npm run names -- apply-I045_names.json --dry-run`, then applied | 21 renames, `bank00.json` only |
| `npm run merge -- plans/extracted-audit/edits/I045.json --dry-run`, then applied | 3 extracted files, 3 notes files changed (`blockNotes/bank00`, `partNotes/bank00`, `comments/bank00`) |
| `npm run merge -- plans/extracted-audit/edits/I045b.json --dry-run`, then applied | 2 extracted files, 2 notes files changed (`blockNotes/bank00`, `partNotes/bank00`) |
| `npm run rebuild` | OK, SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1081344 bytes, checksum 110070696: unchanged (annotation and rename only) |
| `npm run names -- --check` | OK (2758 names; 2737 before + 21) |
| `npm run merge -- --check` | OK: 1401 comments, 1684 part notes, 135 block notes; 0 errors, 0 warnings, 0 orphans, 0 duplicate keys |
| Backticked labels of the new document | 211 distinct tokens, each found in `extracted/` (short forms such as `Cop05` occur in the extracted notes) |
| Links in the new document | all relative targets exist except the hub `README.md` (see above) |

No original-versus-rebuilt ROM comparison was made; the SHA-1 is the one recorded for the rebuilt ROM. No git command that changes history was run.

## Suggested commit message

```
docs: add code doc for COP dispatch (I045)

- docs/code/cop-dispatch.md: HandleCop and the command tables, operand
  conventions, the exit chain and the skip table, resume pointer
  writers and the wait pairs, position and tile-probe conventions,
  shared helpers, COP from engine code, HandleBrk, worked example
- notes: BRK count (289), CopExitJump/CopExitYield semantics, wait
  commands re-run duration + 1 frames later (not next frame),
  SpawnActorBefore run order, the #$0020 filler word, ClearActorFootprint
  in Cop11 runs at the new position, COP [86] is followed by RTL at 280
  of 283 sites; stack-frame comments on HandleBrk, HandleCop,
  CopExitJump, CopExitYield
- names: 21 sub-labels of the COP handlers and the footprint routines
- docs: cop/index corrections (filler words, Cop1A byte, Cop9A/Cop9B
  band, yield wording) and link; boot-nmi-main-loop BRK count;
  actor-system See Also
- plans: I045 checklist, edits (2 specs), renames, questions
  OQ-I045-1..3 (one DISCREPANCY), results
```

Please commit when you're ready.
