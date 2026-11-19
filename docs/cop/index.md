# Soul Blazer COP script system

Soul Blazer runs every actor (NPCs, enemies, lairs, doors, cutscene objects) from a small byte-code script.
The script commands are issued with the 65C816 `COP` instruction. Extracted `.asm` shows them as
`COP [id] ( operands )` and `us/copdef.json` is the operand schema (`size`, `parts`). This page documents the
dispatcher, the conventions every handler follows, and each of the 108 commands.

Sources: `extracted/system/engine_00561E.asm` (dispatcher and tables), `extracted/cop_handlers/*.asm` (one file
per handler), `us/copdef.json`. Every claim below was read from those files. The numbers in `{}` are the
line-tracking file offsets (`npm run extract:lt`) of the handler's first instruction. LoROM: SNES `00:xxxx` is
`xxxx` in bank 0, file offset = `(bank << 15) | (xxxx & 0x7FFF)`.

Names: the handlers are named `Cop<ID>_<Verb...>`. The verb part is a reading of the handler code; where the
purpose is not known the name describes the mechanics (the called routine or field) instead. Open points are
in `plans/extracted-audit/questions/` (rows `OQ-I001-n`).

## 1. Dispatch

`native_mode_cop_00561E` (`engine_00561E`, file offset 22046) is the native-mode COP vector.

```
SEP #$20
TXY                     ; Y = actor slot (X is the actor slot at the COP site)
LDA $04,S : STA $3A     ; script bank   = bank byte of the pushed return address
REP #$20
LDA $02,S : DEC : STA $38   ; script pointer = return address - 1  (the COP signature byte = command id)
LDA [$38] : INC $38     ; read the id, advance
AND #$00FF : ASL : TAX
JMP ($&code_list_005638,X)
```

- Script pointer: direct page `$38` (word) and `$3A` (bank byte). Operands are read with `LDA [$38]` and `$38` is
  advanced by hand.
- One word-pointer table is indexed by `id * 2`, split in three extracted parts: `code_list_005638` (ids
  `00-3C`), `cop_junk` (ids `3D-7F`, filler words `#$0000` / `#$FFFF`, no handlers) and `code_list_005738`
  (ids `80-B2`, file offset 22328). The ids `0E`, `0F`, `2C`, `2D` have `#$0000` entries (no handler); ids `3D-7F`
  and `B3+` are not defined and must never be executed.
- Every handler starts with `TYX` (X = actor slot again) and ends with a `BRL` into the exit chain at the end of
  `CopB2_SpawnBeforeRelative` (`cop_handler_006473`).

### Exit chain (`cop_handler_006473`)

| Label | Effect |
|---|---|
| `loc_0064B5` | skip 5 operand bytes, then fall through |
| `loc_0064B7` | skip 4 |
| `loc_0064B9` | skip 3 |
| `loc_0064BB` | skip 2 |
| `loc_0064BD` | skip 1 |
| `loc_0064BF` | continue at `$38` (all operands already consumed) |
| `loc_0064C1` | `A` is the new script pointer: `STA $02,S` then `RTI`, so the script continues at `A` (jump) |
| `loc_0064C4` | store `$38` into the actor's resume pointer (`$18,X`), then yield |
| `loc_0064C9` | yield: `PLA PLA RTL`, back to the actor loop; the script is resumed next frame from `$18,X`/`$36,X` |

A conditional jump handler reads its operand words and exits through `loc_0064C1` when taken and through a
`loc_0064B*` skip when not taken.

## 2. Actor structure fields used by the commands

Slots are 0x40 bytes wide in the table starting at `$0800` (slot ids `$0800, $0840, ...`). Fields seen in the
handlers:

| Offset | Use |
|---|---|
| `$00` / `$02` | X / Y position (word) |
| `$10` / `$12` | width / height (used by `Cop15_BlockOwnTiles`, `Cop16_UnblockOwnTiles`) |
| `$14` | wait counter (`Cop1B_SetResumeAndDelay`, `CopAD_YieldWhileInView`) |
| `$16` | flags word. Bit 15 is the in-view flag read by `Cop8D`/`Cop8E`/`CopAD` |
| `$18` | script resume pointer (word); `$36` its bank byte |
| `$1A` | attribute flags (bits `$0080`, `$2000`, `$4000`, `$8000` have set/clear commands) |
| `$1C` | OAM attribute word: bit 15 flip Y, 14 flip X, 12-13 priority, 9-11 palette |
| `$1E` / `$20` | animation id / animation step |
| `$30` | general data word (`Cop13`, `Cop17`) |
| `$3C` / `$3E` | next / previous actor link |

`$16` flag meanings other than bit 15, and `$1A`, `$22`, `$24`, `$2C`, `$34`: unknown (OQ-I001-4).

## 3. Shared memory the commands touch

| Address | Use |
|---|---|
| `$1A5E` | event-flag bit array (flag word: low byte = bit 0-7, high 7 bits = byte index) |
| `$1B1E` | inventory / progress byte array (index = operand - 1; bit 7 = flag, 0-6 = value) |
| `$1ADE` | switch bit array tested by `Cop14`/`Cop3B` (bit set = already triggered) |
| `$7F0483` | word table filled by `Cop14`: slot id of the actor registered for each switch id |
| `$7F8000` / `$7E8000` | collision buffers (low nibble = tile type; `$F0` marks blocked) |
| `$0318` (`scene_next`) | next scene: low byte scene, high byte area (non-zero starts the loader `code_027781`) |
| `$0374` / `$0376` | player X / Y |
| `$1B88` / `$1B8A` | player HP / max HP |
| `$039C`, `$039E`, `$03A0` | the three player actor slots |

## 4. Commands

Columns: operands from `copdef.json`; **Uses** = occurrences of `COP [id]` in `extracted/` (as of Pass 4);
`&Code` operands are 2-byte same-bank script targets, `@Code` 3-byte, `Word` 2, `Byte` 1.
"jumps" means the command exits through `loc_0064C1` to the `&Code` operand, otherwise it skips the operands.

### 4.1 Flow control and waits

| Id | Handler | Operands | Uses | Behavior |
|---|---|---|---|---|
| 00 | `Cop00_Yield` {22430} | none | 0 | yields (`loc_0064C9`) without saving a resume pointer |
| 03 | `Cop03_LoopStart` {22517} | Byte | 229 | loop count to `$2E`, loop start (`$38`) to `$2C` and `$18`; continues |
| 04 | `Cop04_LoopNext` {22539} | none | 228 | `DEC $2E`; when zero continues, otherwise sets the resume pointer to the loop start `$2C` and yields |
| 05 | `Cop05_WaitFlag` {22557} | Word | 70 | operand bit 15 clear: waits until the event flag is set; bit 15 set: waits until it is clear. Waiting = rewinds `$38` over the operand, saves the resume pointer and yields |
| 06 | `Cop06_Jump` {22584} | &Code | 0 | jumps to the word at the script pointer |
| 07 | `Cop07_JumpIfFlagClear` {22590} | Word, &Code | 190 | jumps when event flag is clear |
| 08 | `Cop08_JumpIfFlagSet` {22595} | Word, &Code | 7 | jumps when event flag is set |
| 1B | `Cop1B_SetResumeAndDelay` {23176} | &Code, Word | 211 | sets resume pointer `$18` to the target and the delay `$14`, then yields |
| 27 | `Cop27_SetResumeAndYield` {23473} | &Code | 81 | sets resume pointer and yields |
| 91 | `Cop91_SetEntryHere` {24675} | none | 0 | saves `$38`/`$3A` as the actor's resume pointer and continues |
| 86 | `Cop86_KillSelf` {24333} | none | 283 | unlinks the actor from the actor list and frees it |

### 4.2 Event flags, inventory, scene

| Id | Handler | Operands | Uses | Behavior |
|---|---|---|---|---|
| 09 | `Cop09_SetOrClearFlag` {22631} | Word | 213 | bit 15 of the word set: set the flag, clear: clear it. Low 15 bits: flag number |
| 0A | `Cop0A_SetInventoryIfEmpty` {22644} | Byte | 47 | looks the `$1B1E` entry up with `engine_0064F8.code_00651E` (value bits 0-6); when the value is zero calls `lib_0109D6_part3.code_0120F9`, which stores the entry number into it (entries `< $19` are overwritten, others keep bit 7; `$1B64` is set when bit 7 is set; when the old value was `$38`, `$043B` is recomputed). What the entries mean in the game is not confirmed (OQ-I001-3) |
| 0B | `Cop0B_ClearInventoryEntry` {22664} | Byte | 27 | when the entry's value bits are non-zero, clears them (bit 7 is kept; if bit 7 was set `$1B64` is zeroed) |
| 18 | `Cop18_JumpIfInventoryZero` {23055} | Byte, &Code | 55 | jumps when the entry is zero |
| 19 | `Cop19_JumpUnlessInventoryBit7` {23080} | Byte, &Code | 36 | jumps when the entry is zero or bit 7 is clear |
| 10 | `Cop10_SetNextScene` {22854} | Word, Byte, Word, Word | 65 | operand byte 0 = area, byte 1 = scene (`XBA` into `scene_next`), then `$0380`, `$037C`, `$037E` (arrival values) |
| 3C | `Cop3C_SetMode03E3` {24172} | Byte | 23 | stores the byte in `$03E3` |
| 38 | `Cop38_SetParam043D` {23998} | Word | 13 | stores the word in `$043D` |
| 1F | `Cop1F_StepRandom` {23254} | none | 49 | advances the additive random generator in `$0301`-`$0311` (adds each byte to its neighbor with carry, then increments) |
| 35 | `Cop35_RandomMod` {23926} | Byte | 9 | `$0437` = random value modulo the byte (RNG state `$0302`) |
| 37 | `Cop37_GetMissingHp` {23984} | none | 12 | `$043B` = `$1B8A - $1B88` |
| 39 | `Cop39_DamagePlayer` {24011} | Byte | 6 | subtracts the byte from the low byte of `$1B88` (floor 0), sets bit `$04` of `$0332`, sets the player actor's `$26 = $FFE0`, issues `BRK #$04` and sets `$0800` in the player actor's `$16` |
| 36 | `Cop36_AddBcdCounter` {23956} | Word | 0 | decimal-mode add of the word to the 32-bit counter at `$1B78`/`$1B7A` |

### 4.3 Text and menus

| Id | Handler | Operands | Uses | Behavior |
|---|---|---|---|---|
| 01 | `Cop01_ShowText` {22434} | &ASCIIString | 608 | draws the text at the word pointer using the script bank (`code_012C27`) |
| 02 | `Cop02_PromptFixedString` {22461} | &Code | 0 | opens the choice with the fixed string `asciistring_014F02`; jumps when cancelled or the choice is non-zero |
| 1A | `Cop1A_ChoiceMenu` {23107} | &ASCIIString$2, Byte, &Code | 27 | shows the string and a choice menu (byte = menu type); the choice goes to `$03D0`; jumps when cancelled |

### 4.4 Actor movement, position and animation

| Id | Handler | Operands | Uses | Behavior |
|---|---|---|---|---|
| 11 | `Cop11_MoveActorToTile` {22896} | Byte, Byte, Byte | 32 | slot byte, then tile X and Y: sets the position of another actor to the tile (helpers `code_006617`, `code_006628`) |
| 12 | `Cop12_SetActorResume` {22942} | Byte, &Code | 10 | sets the resume pointer of another actor (`$18`) |
| 13 | `Cop13_SetActorData30` {22965} | Byte, Byte, Byte | 0 | sets `$30` of another actor to the word (copdef size is 3) |
| 17 | `Cop17_SetOwnData30` {23042} | &Code | 367 | sets own `$30` to the word |
| 2F | `Cop2F_ShiftPlayerActors` {23703} | Word, Word | 12 | adds (dx, dy) to the player actor at `$039C` and the one linked at its `$3E` |
| 9F | `Cop9F_AddX` {25071} | Word | 79 | adds to X |
| A0 | `CopA0_AddY` {25088} | Word | 39 | adds to Y |
| A1 | `CopA1_AddXY` {25105} | Word, Word | 58 | adds to X and Y |
| A8 | `CopA8_SetFields22And24` {25253} | Word, Byte | 37 | sets `$22` (word) and `$24` (byte) |
| A9 | `CopA9_SetFields34And2C` {25281} | Word, Byte | 1 | sets `$34`, `$2C`, and `$1A \|= $8000` |
| 80 | `Cop80_SetAnimation` {24186} | Byte | 1614 | animation id to `$1E`, step `$20 = 0`, saves the resume pointer, continues |
| 81 | `Cop81_SetAnimationCount` {24208} | Byte, Byte | 522 | like 80, the second byte goes to `$2A` (repeat count) |
| 82 | `Cop82_AnimStepYield` {24240} | none | 1623 | runs one animation step (`engine_000000.code_0008F3`); when it reports done (carry set) continues, otherwise yields |
| 83 | `Cop83_AnimStepRepeat` {24253} | none | 529 | animation steps; each time one finishes `$2A` is decremented and the animation restarts until `$2A` is zero, then continues; yields while a step is running |
| 92 | `Cop92_StartAnimation` {24693} | Byte | 21 | animation id to `$1E`, step `$20 = 0`, runs `lib_01065B` and `lib_0106CD` once, saves the resume pointer and yields |
| 93 | `Cop93_StartAnimationCount` {24718} | Byte, Byte | 0 | as 92 with a count |
| 94 | `Cop94_AnimTick` {24753} | none | 22 | `DEC $26`; when it goes negative runs the frame-advance routine `lib_01065B` (carry set = animation finished: continue); always runs `lib_0106CD` and yields otherwise |
| 95 | `Cop95_AnimTickRepeat` {24781} | none | 0 | like 94, repeating the frame-advance `$2A` times |
| 9D | `Cop9D_SetAnimationUnlock` {25010} | Byte | 51 | like 80 and clears `$16` bit 2 |
| 9E | `Cop9E_AnimStepUnlessBit2` {25041} | &Code | 51 | `$16` bit 2 set: jumps to the target. Clear: one animation step, skipping the operand and continuing when it reports done, yielding otherwise |
| 87 / 88 | `Cop87_ToggleFlipX` {24389} / `Cop88_ToggleFlipY` {24402} | none | 45 / 4 | toggle `$1C` bit 14 / 15 |
| 96 / 97 | `Cop96_SetFlipX` {24814} / `Cop97_ClearFlipX` {24832} | none | 226 / 310 | set / clear `$1C` bit 14 |
| 98 / 99 | `Cop98_SetFlipY` {24850} / `Cop99_ClearFlipY` {24868} | none | 10 / 14 | set / clear `$1C` bit 15 |
| A2 | `CopA2_SetPriority` {25135} | Byte | 54 | clears `$1C` bits 12-13, then ORs the operand byte shifted into the high byte (the script supplies the bits already in place) |
| AA | `CopAA_SetPalette` {25318} | Byte | 11 | clears `$1C` bits 9-11, then ORs the operand byte shifted into the high byte (the script supplies the bits already in place) |
| 8F / 90 | `Cop8F_FacePlayerX` {24609} / `Cop90_FacePlayerY` {24642} | none | 3 / 2 | `8F`: sets `$1C` bit 14 when the player X is `>=` the actor X, clears it otherwise; `90` does the same for bit 15 and Y |
| A3 / A4 | `CopA3_SetFlag1A4000` {25160} / `CopA4_SetFlag1A2000` {25173} | none | 121 / 34 | set `$1A` bit `$4000` / `$2000` |
| A6 / A7 | `CopA6_ClearFlag1A4000` {25227} / `CopA7_ClearFlag1A2000` {25240} | none | 13 / 5 | clear them |
| 33 / 34 | `Cop33_PlayerActorsClearBit7` {23856} / `Cop34_PlayerActorsSetBit7` {23891} | none | 5 / 12 | clear / set `$1A` bit `$0080` on the three player actors (`$039C`..`$03A0`) |

### 4.5 Conditional jumps on actor/player position and state

| Id | Handler | Operands | Uses | Behavior |
|---|---|---|---|---|
| 0C | `Cop0C_JumpIfActorInBox` {22697} | Byte, Byte, &Code | 94 | slot byte, margin byte (`$00`): jumps when the other actor's position lies inside the caller's box (`$10`/`$12` size) widened by the margin; otherwise skips |
| 2E | `Cop2E_JumpIfActorInBoxWord` {23681} | Byte, Word, &Code | 3 | same test, the margin is a word (enters `Cop0C` at `loc_0058C0`) |
| 0D | `Cop0D_JumpIfActorAtTile` {22797} | Byte, Byte, Byte, &Code | 76 | slot byte, tile X, tile Y: jumps when the actor's X equals the tile X position and its Y equals the (tile Y + 1) position |
| 1C | `Cop1C_JumpIfActorFlags` {23198} | Word, &Code | 6 | jumps when `$16` has the masked bits |
| 1D / 1E | `Cop1D_SetActorFlags` {23222} / `Cop1E_MaskActorFlags` {23238} | Word | 1 / 1 | OR / AND the word into `$16` |
| 20 | `Cop20_JumpIfPlayerOffGrid` {23293} | &Code | 3 | jumps when the player is not on a tile boundary |
| 89 / 8A | `Cop89_JumpIfPlayerWithinX` {24415} / `Cop8A_JumpIfPlayerWithinY` {24453} | Word, &Code | 0 / 0 | jumps when the absolute player-to-actor distance on the axis is `<=` the word (unused) |
| 8B / 8C | `Cop8B_JumpIfPlayerBeyondX` {24491} / `Cop8C_JumpIfPlayerBeyondY` {24529} | Word, &Code | 0 / 0 | jumps when the distance is `>` the word (unused) |
| 8D / 8E | `Cop8D_JumpIfBit15Clear` {24567} / `Cop8E_JumpIfBit15Set` {24588} | &Code | 0 / 0 | jump on `$16` bit 15 clear / set; on the other path the handler continues without skipping the operand (OQ-I001-1) |
| 9A / 9B | `Cop9A_JumpByPlayerDeltaX` {24886} / `Cop9B_JumpByPlayerDeltaY` {24925} | Word, &Code x3 | 175 / 174 | threshold word, then three targets: first when the player is left of (above) the actor by at least the threshold, second when within it, third when right of (below) it |
| 9C | `Cop9C_JumpByPlayerAxis` {24964} | &Code, &Code | 28 | first target when the X distance to the player is greater than the Y distance, second otherwise |
| A5 | `CopA5_JumpByFlipState` {25186} | &Code x4 | 25 | clears `$1C` bits 14-15 and jumps to one of four targets by their old value: none, flip X only, flip Y only, both (in that order) |
| 26 | `Cop26_JumpIfLib0276C9` {23417} | Word, &Code | 8 | calls `lib_0276C9` with A = the word (changed to 0 when `$1B64 = $40`, or halved/rounded when `$1B60 = $0C`); carry set: jumps; otherwise sets bit `$10` of `$0332` and skips |
| AD | `CopAD_YieldWhileInView` {25459} | Byte | 80 | when the actor is in view (`$16` bit 15 and inside the screen) sets `$18` to re-run this command, `$14` = byte and yields; otherwise skips the byte |

### 4.6 Collision and tile tests

| Id | Handler | Operands | Uses | Behavior |
|---|---|---|---|---|
| 14 | `Cop14_JumpIfSwitchSet` {22988} | Word, &Code | 245 | registers the actor in `$7F0483` under the switch id (`code_00662D`); when the bit is set in `$1ADE` (`lib_0273A2`) clears `$16` bit `$2000` and jumps, otherwise skips |
| 3B | `Cop3B_JumpIfSwitchSetData` {24077} | Word, &Code | 28 | variant of 14: first checks a word at +`$1E` of the 32-byte `data_00BA0D` record selected by the switch id and tests the `$1ADE` bit; when it does not jump it may set `$16` bit `$0010` (from `$7F0203` bit 6) or yield. Only partly understood (OQ-I001-3) |
| 15 | `Cop15_BlockOwnTiles` {23028} | none | 209 | marks the tiles under the actor solid (`$7F8000` entries \|= `$F0`) |
| 16 | `Cop16_UnblockOwnTiles` {23035} | none | 82 | clears them |
| 2A / 2B | `Cop2A_BlockTileAt` {23583} / `Cop2B_UnblockTileAt` {23632} | Word, Word | 20 / 20 | block / unblock the tile at the offset |
| 21 | `Cop21_JumpIfTileAbove` {23317} | &Code | 43 | jumps when the tile above is occupied |
| 22 | `Cop22_JumpIfTileAtPos` {23339} | &Code | 45 | at the actor position |
| 23 / 24 | `Cop23_JumpIfTileLeft` {23353} / `Cop24_JumpIfTileRight` {23375} | &Code | 50 / 47 | left / right |
| 28 | `Cop28_JumpIfTileHere` {23489} | &Code | 24 | tile under the actor |
| 29 | `Cop29_JumpIfTileIdDiffers` {23531} | Byte x3 | 0 | unused |
| AE | `CopAE_JumpIfTileTypeSet` {25513} | Word, Word, &Code | 52 | tile-type nibble at (dx, dy) is non-zero |

### 4.7 Spawning

All variants take a free slot from the free-slot stack at `$4A` (`code_00668A`; carry set when none is left),
link it into the actor list after (`engine_0065A7.code_00663A`) or before (`code_006662`) the caller, and then
`code_0066A3` clones the first `$3C` bytes of the caller into it (`MVN`), sets `$16 \|= $2000` and clears `$16`
bit `$0010`, and zeroes `$1A`, `$30` and `$14`. The variants then overwrite the resume pointer (`$18` + bank `$36`)
and, depending on the variant, X/Y and `$16`. Without an explicit position the new actor starts on the caller's.

| Id | Handler | Operands | Uses | Behavior |
|---|---|---|---|---|
| 84 | `Cop84_SpawnActorAfter` {24271} | @Code | 13 | spawn after the caller (entry address only) |
| 85 | `Cop85_SpawnActorBefore` {24302} | @Code | 346 | spawn before the caller |
| AF / B0 | `CopAF_SpawnAfterFlags` {25569} / `CopB0_SpawnBeforeFlags` {25609} | @Code, Word | 12 / 76 | adds the flags word `$16` |
| B1 / B2 | `CopB1_SpawnAfterRelative` {25649} / `CopB2_SpawnBeforeRelative` {25715} | @Code, Word x3 | 0 / 114 | entry, then relative X, relative Y added to the caller's, then flags |
| AB / AC | `CopAB_SpawnAfterAbsolute` {25343} / `CopAC_SpawnBeforeAbsolute` {25401} | @Code, Word x3 | 0 / 38 | same with absolute X, Y |
| 30 | `Cop30_ConditionalSpawn` {23766} | Word, &Code, Byte | 32 | when `$03FB` is non-zero and the word equals `$0405`: continues as `Cop85`; otherwise skips |
| 31 / 32 | `Cop31_SpawnEngineActor2C9B` {23792} / `Cop32_SpawnEngineActor2CCB` {23824} | Byte | 9 / 5 | spawn (before the caller) an actor whose script is the fixed engine routine `code_002C9B` / `code_002CCB`; the byte becomes its `$30` |

### 4.8 Not understood / unused

`Cop25_CallLib0276A5` {23397} (Byte, Byte, unused; calls `lib_0276A5` and sets bit `$10` of `$0332`),
`Cop26_JumpIfLib0276C9` {23417} (Word, &Code; the condition comes from `lib_0276C9`),
`Cop3A_CallLib0124EE` {24069} (no operand, one use in `common_actor_00797B`: calls `lib_0124EE` between two
texts). Their purpose is unknown: OQ-I001-3 in `plans/extracted-audit/questions/I001_questions.md`.

## 5. Notes on the `copdef.json` entries

- Only the entries named below were re-read against their handlers in Pass 4; the used commands were already
  consistent because the extraction round-trips the ROM byte for byte. Corrected (all unused in the scripts, so
  the extracted `.asm` and the rebuilt ROM did not change): `06` (now `&Code`), `89`-`8C` (now `Word, &Code`
  instead of four bytes), `8D`, `8E` (now `&Code`, were size 0).
- Commands marked 0 uses are never emitted in the extracted scripts; their copdef sizes come from the handler.

## 6. Differences from Illusion of Gaia

The structure (`TXY`, `[$38]` script pointer, the `SetEntryHere` and jump-on-flag commands) mirrors the IOG engine
but the command ids and operand layouts are not the same. Do not reuse IOG `copdef.json` ids.
