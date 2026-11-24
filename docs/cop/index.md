# Soul Blazer COP script system

Soul Blazer runs every actor (NPCs, enemies, lairs, doors, cutscene objects) from a script of 65C816 machine code
in which the game's own commands are issued with the `COP` instruction. Extracted `.asm` shows them as
`COP [id] ( operands )` and `us/copdef.json` is the operand schema (`size`, `parts`). This page documents the
dispatcher, the conventions every handler follows, and each of the 108 commands. How the mechanism works (the
stack frame, the exit chain, the waiting idioms, the position conventions, the helpers) is explained in
[docs/code/cop-dispatch.md](../code/cop-dispatch.md); this page is the command list.

Sources: `extracted/system/cop_dispatch.asm` (dispatcher and tables), `extracted/cop_handlers/*.asm` (five files grouped by
family: flow and flags, items and stats, conditions, actor fields and animation, tiles and spawn), `us/copdef.json`. Every claim below was read from those files. The numbers in `{}` are the
line-tracking file offsets (`npm run extract:lt`) of the handler's first instruction. LoROM: SNES `00:xxxx` is
`xxxx` in bank 0, file offset = `(bank << 15) | (xxxx & 0x7FFF)`.

Names: the handlers are named `Cop<ID>_<Verb...>`. The verb part is a reading of the handler code; where the
purpose is not known the name describes the mechanics (the called routine or field) instead. Open points are
in `plans/extracted-audit/questions/` (rows `OQ-I001-n`).

## 1. Dispatch

`HandleCop` (`cop_dispatch`, file offset 22046) is the native-mode COP vector.

```
SEP #$20
TXY                     ; Y = actor slot (X is the actor slot at the COP site)
LDA $04,S : STA $3A     ; script bank   = bank byte of the pushed return address
REP #$20
LDA $02,S : DEC : STA $38   ; script pointer = return address - 1  (the COP signature byte = command id)
LDA [$38] : INC $38     ; read the id, advance
AND #$00FF : ASL : TAX
JMP ($&CopHandlerTable_00_3C,X)
```

- Script pointer: direct page `$38` (word) and `$3A` (bank byte). Operands are read with `LDA [$38]` and `$38` is
  advanced by hand.
- One word-pointer table is indexed by `id * 2`, split in three extracted parts: `CopHandlerTable_00_3C` (ids
  `00-3C`), `CopFillerTable_3D_7F` (ids `3D-7F`, filler words `#$0000` / `#$FFFF` and one `#$0020` at index `$26`, no handlers) and `CopHandlerTable_80_B2`
  (ids `80-B2`, file offset 22328). The ids `0E`, `0F`, `2C`, `2D` have `#$0000` entries (no handler); ids `3D-7F`
  and `B3+` are not defined and must never be executed.
- Every handler starts with `TYX` (X = actor slot again) and ends with a `BRL` into the exit chain at the end of
  `CopB2_SpawnBeforeRelative` (`cop_core`).

### Exit chain (`cop_core`)

| Label | Effect |
|---|---|
| `CopExitSkip5` | skip 5 operand bytes, then fall through |
| `CopExitSkip4` | skip 4 |
| `CopExitSkip3` | skip 3 |
| `CopExitSkip2` | skip 2 |
| `CopExitSkip1` | skip 1 |
| `CopExitContinue` | continue at `$38` (all operands already consumed) |
| `CopExitJump` | `A` is the new script pointer: `STA $02,S` then `RTI`, so the script continues at `A` (jump) |
| `CopExitSaveResume` | store `$38` into the actor's resume pointer (`$18,X`), then yield |
| `CopExitYield` | yield: `PLA PLA RTL`, back to the actor loop; the script is resumed from `$18,X`/`$36,X` once `$14` has run out (next frame when `$14` is 0) |

A conditional jump handler reads its operand words and exits through `CopExitJump` when taken and through the
`CopExitSkipN` that matches the unread operand bytes when not taken. A and Y are scratch across a handler; X is the
actor slot on exit. The full conventions are in the `cop_core` block note.

## 2. Actor structure fields used by the commands

Slots are 0x40 bytes wide in the table starting at `$0800` (slot ids `$0800, $0840, ...`). Fields seen in the
handlers:

| Offset | Use |
|---|---|
| `$00` / `$02` | X / Y position (word) |
| `$10` / `$12` | width / height (used by `Cop15_BlockOwnTiles`, `Cop16_UnblockOwnTiles`) |
| `$14` | wait counter: the script runs when it goes below 0, so a delay of N runs N+1 frames later (`Cop1B_DelayThenGoto`, `CopAD_WaitUntilOnScreen`) |
| `$16` | flags word. Bit 15 = off screen (read by `Cop8D`/`Cop8E`/`CopAD`), `$2000` hidden/inactive, `$0800` hit stun, `$0004` blocked, `$0010` runs in sub-frames |
| `$18` | script resume pointer (word); `$36` its bank byte |
| `$1A` | attribute flags: `$8000` dynamic tile source, `$4000` draw in front (sort key 0), `$2000` draw behind (key `$01FE`), `$0080` not drawn, `$1000` respawns after death |
| `$1C` | OAM attribute word: bit 15 flip Y, 14 flip X, 12-13 priority, 9-11 palette |
| `$1E` / `$20` | animation id / animation step |
| `$30` | general data word (`Cop13`, `Cop17`) |
| `$2C` / `$2E` | loop start / loop counter of `Cop03`/`Cop04` (one loop per actor; also the lair monster counter) |
| `$3C` / `$3E` | list links: `$3C` toward the tail (runs earlier), `$3E` toward the head (runs later); `RunActors` follows `$3E` from `actor_list_tail` (see `docs/code/actor-system.md`) |

`$16` flag meanings other than bit 15, and `$1A`, `$22`, `$24`, `$2C`, `$34`: unknown (OQ-I001-4).

## 3. Shared memory the commands touch

| Address | Use |
|---|---|
| `$1A5E` | event-flag bit array (flag word: low byte = bit 0-7, high 7 bits = byte index) |
| `$1B1E` | inventory byte array (entry n at +n-1; bits 0-6 = value, which for an owned entry is its own number; bit 7 = equipped, tested by `Cop19`) |
| `$1ADE` | switch bit array tested by `Cop14`/`Cop3B`, indexed by the lair record index of `LairRecords` (bit set = released; `HoldActorUntilReleased` sets it) |
| `$7F0483` | word table filled by `Cop14`: slot id of the actor registered for each switch id |
| `$7F8000` / `$7E8000` | collision buffers (low nibble = tile type; `$F0` marks blocked) |
| `$0318` (`scene_next`) | next scene: low byte scene, high byte area (non-zero starts the loader `ChangeSceneIfRequested`) |
| `$0374` / `$0376` | player X / Y |
| `$1B88` / `$1B8A` | player HP / max HP |
| `$039C`, `$039E`, `$03A0` | the three player actor slots |

## 4. Commands

Columns: operands from `copdef.json`; **Uses** = occurrences of `COP [id]` in `extracted/` (as of Pass 4);
`&Code` operands are 2-byte same-bank script targets, `@Code` 3-byte, `Word` 2, `Byte` 1.
"jumps" means the command exits through `CopExitJump` to the `&Code` operand, otherwise it skips the operands.

### 4.1 Flow control and waits

| Id | Handler | Operands | Uses | Behavior |
|---|---|---|---|---|
| 00 | `Cop00_Yield` {22430} | none | 0 | yields (`CopExitYield`) without saving a resume pointer |
| 03 | `Cop03_LoopStart` {22517} | Byte | 229 | loop count to `$2E`, loop start (`$38`) to `$2C` and `$18`; continues |
| 04 | `Cop04_LoopNext` {22539} | none | 228 | `DEC $2E`; when zero continues, otherwise sets the resume pointer to the loop start `$2C` and yields |
| 05 | `Cop05_WaitWhileFlagEquals` {22557} | Word | 70 | operand bit 15 clear: waits until the event flag is set; bit 15 set: waits until it is clear. Waiting = rewinds `$38` by 2 to the COP instruction itself, saves the resume pointer and yields (re-tests every frame) |
| 06 | `Cop06_Jump` {22584} | &Code | 0 | jumps to the word at the script pointer |
| 07 | `Cop07_JumpIfFlagEquals` {22590} | Word, &Code | 190 | jumps when the event flag equals the sense bit v (bit 15 of the word; bit 15 clear: jumps when the flag is clear) |
| 08 | `Cop08_JumpIfFlagNotEquals` {22595} | Word, &Code | 7 | jumps when the event flag differs from v (bit 15 clear: jumps when the flag is set) |
| 1B | `Cop1B_DelayThenGoto` {23176} | &Code, Word | 211 | sets resume pointer `$18` to the target and the delay `$14`, then yields |
| 27 | `Cop27_YieldThenGoto` {23473} | &Code | 81 | sets resume pointer and yields |
| 91 | `Cop91_SetEntryHere` {24675} | none | 414 | saves `$38`/`$3A` as the actor's resume pointer and continues |
| 86 | `Cop86_KillSelf` {24333} | none | 283 | unlinks the actor from the actor list and frees it |

### 4.2 Event flags, inventory, scene

| Id | Handler | Operands | Uses | Behavior |
|---|---|---|---|---|
| 09 | `Cop09_SetOrClearFlag` {22631} | Word | 213 | bit 15 of the word set: set the flag, clear: clear it. Low 15 bits: flag number |
| 0A | `Cop0A_GiveItemIfNotOwned` {22644} | Byte | 47 | looks the `$1B1E` entry up with `cop_core.LookupInventoryEntry` (value bits 0-6); when the value is zero calls `lib_inventory_store.StoreInventoryEntry`, which stores the entry number into it (entries `< $19` are overwritten, others keep bit 7; `$1B64` is set when bit 7 is set; when the old value was `$38` (Medical Herb), `$043B` is recomputed). Entry ids: Medical Herb `$38`, Strange Bottle `$39`, Magic Bell `$40`, Magic Armor `$0C` (`docs/walkthrough/items.md`) |
| 0B | `Cop0B_RemoveItem` {22664} | Byte | 27 | when the entry's value bits are non-zero, clears them (bit 7 is kept; if bit 7 was set `$1B64` is zeroed) |
| 18 | `Cop18_JumpIfItemMissing` {23055} | Byte, &Code | 55 | jumps when the entry is zero |
| 19 | `Cop19_JumpUnlessItemEquipped` {23080} | Byte, &Code | 36 | jumps when the entry is zero or bit 7 is clear |
| 10 | `Cop10_SetNextScene` {22854} | Word, Byte, Word, Word | 65 | operand byte 0 = area, byte 1 = scene (`XBA` into `scene_next`), then `$0380`, `$037C`, `$037E` (arrival values) |
| 3C | `Cop3C_SetTransitionType` {24172} | Byte | 23 | stores the byte in `transition_type` (`$03E3`); always `#$04` and always just before `Cop10` (OQ-I025-6) |
| 38 | `Cop38_QueueExp` {23998} | Word | 13 | stores the BCD amount in `exp_pending` (`$043D`); `lib_player_helpers.DrainPendingExp` pays it into `$1B78`/`$1B7A` one digit step per 8 frames |
| 1F | `Cop1F_StepRandom` {23254} | none | 49 | advances the additive random generator in `rng_state` (`$0301`; the bytes `$0302`-`$0311` are the state) (adds each byte to its neighbor with carry, then increments) |
| 35 | `Cop35_RandomMod` {23926} | Byte | 9 | `$0437` = random value modulo the byte (RNG state `$0302`) |
| 37 | `Cop37_HealPlayerToFull` {23984} | none | 12 | `heal_pending` (`$043B`) = `$1B8A - $1B88`; the HP rises one point every 4 frames |
| 39 | `Cop39_DamagePlayer` {24011} | Byte | 6 | subtracts the byte from the low byte of `$1B88` (floor 0), sets bit `$04` of `$0332`, sets the player actor's `$26 = $FFE0`, issues `BRK #$04` and sets `$0800` in the player actor's `$16` |
| 36 | `Cop36_AddExp` {23956} | Word | 0 | decimal-mode add of the word to the 32-bit counter at `$1B78`/`$1B7A`, uncapped (unused; `Cop38` awards EXP) |

### 4.3 Text and menus

| Id | Handler | Operands | Uses | Behavior |
|---|---|---|---|---|
| 01 | `Cop01_ShowText` {22434} | &ASCIIString | 608 | draws the text at the word pointer using the script bank (`ShowDialogueText`) |
| 02 | `Cop02_PromptYesNo` {22461} | &Code | 0 | opens the Yes/No choice (string `ChoiceYesNoText`); jumps when cancelled or the choice is non-zero (unused; `Cop1A` makes the same prompt) |
| 1A | `Cop1A_ChoiceMenu` {23107} | &ASCIIString$2, Byte, &Code | 27 | shows the string (always in bank `$02`, `shared_choice_prompt_texts`) and a choice menu (byte = number of entries); the choice goes to `$03D0`; jumps when cancelled |

### 4.4 Actor movement, position and animation

| Id | Handler | Operands | Uses | Behavior |
|---|---|---|---|---|
| 11 | `Cop11_MoveActorToTile` {22896} | Byte, Byte, Byte | 32 | slot byte, then tile X and Y: sets the position of another actor to the tile (helpers `SlotNumberToActor`, `TileToPixel`) |
| 12 | `Cop12_SetActorResume` {22942} | Byte, &Code | 10 | sets the resume pointer of another actor (`$18`) |
| 13 | `Cop13_SetActorParam` {22965} | Byte, Byte, Byte | 0 | sets `$30` of another actor to the word (copdef size is 3) |
| 17 | `Cop17_SetOwnParam` {23042} | &Code | 367 | sets own `$30` to the word |
| 2F | `Cop2F_ShiftPlayerActors` {23703} | Word, Word | 12 | adds (dx, dy) to the player actor at `$039C` and the one linked at its `$3E` (OQ-I025-9) |
| 9F | `Cop9F_AddX` {25071} | Word | 79 | adds to X |
| A0 | `CopA0_AddY` {25088} | Word | 39 | adds to Y |
| A1 | `CopA1_AddXY` {25105} | Word, Word | 58 | adds to X and Y |
| A8 | `CopA8_SetAnimationTable` {25253} | Word, Byte | 37 | sets `$22` (word) and `$24` (byte) |
| A9 | `CopA9_SetDynamicTileSource` {25281} | Word, Byte | 1 | sets `$34`, `$2C`, and `$1A \|= $8000` |
| 80 | `Cop80_SetAnimation` {24186} | Byte | 1614 | animation id to `$1E`, step `$20 = 0`, saves the resume pointer, continues |
| 81 | `Cop81_SetAnimationRepeat` {24208} | Byte, Byte | 522 | like 80, the second byte goes to `$2A` (repeat count) |
| 82 | `Cop82_WaitAnimationDone` {24240} | none | 1623 | runs one animation step (`engine_actor_scheduler_and_sprites.SetActorAnimFrame`); when it reports done (carry set) continues, otherwise yields |
| 83 | `Cop83_WaitAnimationRepeat` {24253} | none | 529 | animation steps; each time one finishes `$2A` is decremented and the animation restarts until `$2A` is zero, then continues; yields while a step is running |
| 92 | `Cop92_StartAnimation` {24693} | Byte | 21 | animation id to `$1E`, step `$20 = 0`, runs `NextFrameRecord` and `CopyFrameData` (both in block `lib_animation`) once, saves the resume pointer and yields |
| 93 | `Cop93_StartAnimationCount` {24718} | Byte, Byte | 0 | as 92 with a count |
| 94 | `Cop94_AnimTick` {24753} | none | 22 | `DEC $26`; when it goes negative runs the frame-advance routine `NextFrameRecord` (carry set = animation finished: continue); always runs `CopyFrameData` (both in block `lib_animation`) and yields otherwise |
| 95 | `Cop95_AnimTickRepeat` {24781} | none | 0 | like 94, repeating the frame-advance `$2A` times |
| 9D | `Cop9D_SetAnimationClearBlocked` {25010} | Byte | 51 | like 80 and clears `$16` bit 2 |
| 9E | `Cop9E_WaitAnimationDoneOrJumpIfBlocked` {25041} | &Code | 51 | `$16` bit 2 set: jumps to the target. Clear: one animation step, skipping the operand and continuing when it reports done, yielding otherwise |
| 87 / 88 | `Cop87_ToggleFlipX` {24389} / `Cop88_ToggleFlipY` {24402} | none | 45 / 4 | toggle `$1C` bit 14 / 15 |
| 96 / 97 | `Cop96_SetFlipX` {24814} / `Cop97_ClearFlipX` {24832} | none | 226 / 310 | set / clear `$1C` bit 14 |
| 98 / 99 | `Cop98_SetFlipY` {24850} / `Cop99_ClearFlipY` {24868} | none | 10 / 14 | set / clear `$1C` bit 15 |
| A2 | `CopA2_SetPriority` {25135} | Byte | 54 | clears `$1C` bits 12-13, then ORs the operand byte shifted into the high byte (the script supplies the bits already in place) |
| AA | `CopAA_SetPalette` {25318} | Byte | 11 | clears `$1C` bits 9-11, then ORs the operand byte shifted into the high byte (the script supplies the bits already in place) |
| 8F / 90 | `Cop8F_FacePlayerX` {24609} / `Cop90_FacePlayerY` {24642} | none | 3 / 2 | `8F`: sets `$1C` bit 14 when the player X is `>=` the actor X, clears it otherwise; `90` does the same for bit 15 and Y |
| A3 / A4 | `CopA3_DrawInFront` {25160} / `CopA4_DrawBehind` {25173} | none | 121 / 34 | set `$1A` bit `$4000` / `$2000` |
| A6 / A7 | `CopA6_ClearDrawInFront` {25227} / `CopA7_ClearDrawBehind` {25240} | none | 13 / 5 | clear them |
| 33 / 34 | `Cop33_ShowPlayerActors` {23856} / `Cop34_HidePlayerActors` {23891} | none | 5 / 12 | clear / set `$1A` bit `$0080` on the three player actors (`$039C`..`$03A0`) |

### 4.5 Conditional jumps on actor/player position and state

| Id | Handler | Operands | Uses | Behavior |
|---|---|---|---|---|
| 0C | `Cop0C_JumpIfActorInBox` {22697} | Byte, Byte, &Code | 94 | slot byte, margin byte (`$00`): jumps when the other actor's position lies inside the caller's box (`$10`/`$12` size) widened by the margin; otherwise skips |
| 2E | `Cop2E_JumpIfActorInBoxWord` {23681} | Byte, Word, &Code | 3 | same test, the margin is a word (enters `Cop0C` at `CopActorBoxTest`) |
| 0D | `Cop0D_JumpIfActorAtTile` {22797} | Byte, Byte, Byte, &Code | 76 | slot byte, tile X, tile Y: jumps when the actor's X equals the tile X position and its Y equals the (tile Y + 1) position |
| 1C | `Cop1C_JumpIfActorFlags` {23198} | Word, &Code | 6 | jumps when `$16` has the masked bits |
| 1D / 1E | `Cop1D_SetActorFlags` {23222} / `Cop1E_MaskActorFlags` {23238} | Word | 1 / 1 | OR / AND the word into `$16` |
| 20 | `Cop20_JumpIfPlayerOffGrid` {23293} | &Code | 3 | jumps when the player is not on a tile boundary |
| 89 / 8A | `Cop89_JumpIfPlayerWithinX` {24415} / `Cop8A_JumpIfPlayerWithinY` {24453} | Word, &Code | 0 / 0 | jumps when the absolute player-to-actor distance on the axis is `<=` the word (unused) |
| 8B / 8C | `Cop8B_JumpIfPlayerBeyondX` {24491} / `Cop8C_JumpIfPlayerBeyondY` {24529} | Word, &Code | 0 / 0 | jumps when the distance is `>` the word (unused) |
| 8D / 8E | `Cop8D_JumpIfOnScreen` {24567} / `Cop8E_JumpIfOffScreen` {24588} | &Code | 0 / 0 | jump on `$16` bit 15 clear / set; on the other path the handler continues without skipping the operand (OQ-I001-1) |
| 9A / 9B | `Cop9A_JumpByPlayerDeltaX` {24886} / `Cop9B_JumpByPlayerDeltaY` {24925} | Word, &Code x3 | 175 / 174 | threshold T, then three targets with d = player - actor: first when the player is left of (above) the actor by more than T (`abs(d) > T`), third when right of (below) it by T or more (`d >= T`), second otherwise (also `d = 0`); the band is one pixel wider on the right/below side |
| 9C | `Cop9C_JumpByPlayerAxis` {24964} | &Code, &Code | 28 | first target when the X distance to the player is greater than the Y distance, second otherwise |
| A5 | `CopA5_JumpByFlipState` {25186} | &Code x4 | 25 | clears `$1C` bits 14-15 and jumps to one of four targets by their old value: none, flip X only, flip Y only, both (in that order) |
| 26 | `Cop26_PayGemsOrJump` {23417} | Word, &Code | 8 | spell price check: the word is the Gem cost in BCD (1, 2, 4, 8, `$20`); it becomes 0 with the Magic Bell (`$1B64 = $40`) and is halved (at least 1) with the Magic Armor (`$1B60 = $0C`); `lib_player_helpers.SubtractGems` subtracts it; carry set (not enough Gems, nothing taken): jumps; otherwise sets bit `$10` of `$0332` and skips |
| AD | `CopAD_WaitUntilOnScreen` {25459} | Byte | 80 | while the actor is OFF screen (`$16` bit 15 set) sets `$18` to re-run this command, `$14` = byte and yields; once it is on screen skips the byte and continues |

### 4.6 Collision and tile tests

| Id | Handler | Operands | Uses | Behavior |
|---|---|---|---|---|
| 14 | `Cop14_JumpIfSwitchSet` {22988} | Word, &Code | 245 | registers the actor in `$7F0483` under the switch id (`RegisterSwitchOwner`); when the bit is set in `$1ADE` (`lib_bit_array`) clears `$16` bit `$2000` and jumps, otherwise skips |
| 3B | `Cop3B_JumpIfSwitchSetElseHold` {24077} | Word, &Code | 28 | variant of 14: first checks a word at +`$1E` of the 32-byte `LairRecords` record selected by the switch id and tests the `$1ADE` bit; when it does not jump it may set `$16` bit `$0010` (from `lair_state` bit `$40`, `$7F0203 + n`) or yield. Only partly understood (OQ-I025-1) |
| 15 | `Cop15_BlockOwnTiles` {23028} | none | 209 | marks the tiles under the actor solid (`$7F8000` entries \|= `$F0`) |
| 16 | `Cop16_UnblockOwnTiles` {23035} | none | 82 | clears them |
| 2A / 2B | `Cop2A_BlockTileAt` {23583} / `Cop2B_UnblockTileAt` {23632} | Word, Word | 20 / 20 | block / unblock the tile at (dx, dy) relative to the actor; the block ORs `$F0`, the unblock zeroes the whole low byte |
| 21 | `Cop21_JumpIfTileAbove` {23317} | &Code | 43 | jumps when the tile above is occupied |
| 22 | `Cop22_JumpIfTileBelow` {23339} | &Code | 45 | at the actor position |
| 23 / 24 | `Cop23_JumpIfTileLeft` {23353} / `Cop24_JumpIfTileRight` {23375} | &Code | 50 / 47 | left / right |
| 28 | `Cop28_JumpIfTileHere` {23489} | &Code | 24 | tile under the actor |
| 29 | `Cop29_JumpIfTileIdDiffers` {23531} | Byte x3 | 0 | unused |
| AE | `CopAE_JumpIfTileTypeNonZero` {25513} | Word, Word, &Code | 52 | tile-type nibble at (dx, dy) is non-zero |

### 4.7 Spawning

All variants take a free slot from the free-slot stack at `$4A` (`PopFreeSlot`; carry set when none is left),
link it into the actor list on the `$3C` side of the caller (`cop_core.SpawnActorAfter`: the new actor runs before the
caller, first on the next frame) or on the `$3E` side (`SpawnActorBefore`: it runs right after the caller, in the same
frame), and then
`InitSpawnedActor` clones the first `$3C` bytes of the caller into it (`MVN`), sets `$16 \|= $2000` and clears `$16`
bit `$0010`, and zeroes `$1A`, `$30` and `$14`. The variants then overwrite the resume pointer (`$18` + bank `$36`)
and, depending on the variant, X/Y and `$16`. Without an explicit position the new actor starts on the caller's.

| Id | Handler | Operands | Uses | Behavior |
|---|---|---|---|---|
| 84 | `Cop84_SpawnActorAfter` {24271} | @Code | 13 | spawn after the caller (entry address only) |
| 85 | `Cop85_SpawnActorBefore` {24302} | @Code | 346 | spawn before the caller |
| AF / B0 | `CopAF_SpawnAfterWithFlags` {25569} / `CopB0_SpawnBeforeWithFlags` {25609} | @Code, Word | 12 / 76 | adds the flags word `$16` |
| B1 / B2 | `CopB1_SpawnAfterRelative` {25649} / `CopB2_SpawnBeforeRelative` {25715} | @Code, Word x3 | 0 / 114 | entry, then relative X, relative Y added to the caller's, then flags |
| AB / AC | `CopAB_SpawnAfterAbsolute` {25343} / `CopAC_SpawnBeforeAbsolute` {25401} | @Code, Word x3 | 0 / 38 | same with absolute X, Y |
| 30 | `Cop30_SpawnIfEnteredViaRecord` {23766} | Word, &Code, Byte | 32 | when `return_active` (`$03FB`) is non-zero and the word (a lair record index) equals `return_record` (`$0405`): continues as `Cop85`; otherwise skips |
| 31 / 32 | `Cop31_FadeAndLoadMusic` {23792} / `Cop32_StopAndLoadMusic` {23824} | Byte | 9 / 5 | spawn (before the caller) an actor whose script is the fixed engine routine `MusicLoadSendFade` / `MusicLoadSendStop`; the byte becomes its `$30` and is the track number, an index into `MusicPointerTable`. The chain (`MusicLoadSendFade`, `MusicLoadWaitFadeAck`, `MusicLoadWaitSilence`, `MusicLoadSendStop`, `MusicLoadWaitStopped`, `MusicLoadUpload`, `MusicLoadFinish`) is in `engine_spawn_lairs_death_drops` (OQ-I025-2, -3) |

### 4.8 Not understood / unused

`Cop25_AddGems` {23397} (Word BCD amount, copdef lists two Bytes; unused; `lib_player_helpers.AddGems` adds it, capped at 999999, and sets bit `$10` of `$0332`) and
`Cop3A_EnterPlayerName` {24069} (no operand, one use in `gv_up_above_actors_and_name_entry`: runs `lib_name_entry_and_staff_roll` between two
texts, the name entry of the walkthrough chapter In the Beginning). The handlers with 0 uses (00, 02, 06, 13, 25, 29, 36,
89-8E, 93, 95, AB, B1) are listed in OQ-I025-4; older open points are in `plans/extracted-audit/questions/I001_questions.md`.

## 5. Notes on the `copdef.json` entries

- Only the entries named below were re-read against their handlers in Pass 4; the used commands were already
  consistent because the extraction round-trips the ROM byte for byte. Corrected (all unused in the scripts, so
  the extracted `.asm` and the rebuilt ROM did not change): `06` (now `&Code`), `89`-`8C` (now `Word, &Code`
  instead of four bytes), `8D`, `8E` (now `&Code`, were size 0).
- Commands marked 0 uses are never emitted in the extracted scripts; their copdef sizes come from the handler.

## 6. Differences from Illusion of Gaia

The structure (`TXY`, `[$38]` script pointer, the `SetEntryHere` and jump-on-flag commands) mirrors the IOG engine
but the command ids and operand layouts are not the same. Do not reuse IOG `copdef.json` ids.
