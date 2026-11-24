# Soul Blazer SPC700 Sound Engine — Analysis & IoG Comparison

_Full reverse-engineering of the Soul Blazer N-SPC engine, with systematic comparison to the Illusion of Gaia variant._

**Engine binary:** 2,887 bytes uploaded to ARAM at boot from `SpcEngineBlock` in `extracted/system/engine_spc_ipl_upload.asm` (`UploadSpcDriver`). The CPU side of the ports, the driver block and the song format are in [../code/spc-interface.md](../code/spc-interface.md).
**ARAM range:** `$0400`–`$0F46` (vs IoG: `$0400`–`$0FC9`, 3,018 bytes).
**Variant:** N-SPC (Nintendo SPC, Quintet-customized). Soul Blazer is the earliest of the Soul Blazer trilogy.

---

## Executive Summary

The Soul Blazer and Illusion of Gaia SPC engines are the **same N-SPC variant** with identical sequence data encoding, identical opcode set ($E0–$FA), and identical pitch calculation. The differences are:

1. **ARAM address layout** — all data tables (instruments, DV table, sample directory, sequence data) reside at different ARAM addresses
2. **Instrument mapping** — Blazer uses an additive offset; IoG uses a lookup table
3. **SFX subsystem** — Blazer has a dedicated 2-channel SFX handler not present in IoG
4. **Timer architecture** — Blazer uses 1 hardware timer; IoG uses 2
5. **Volume pipeline** — Blazer includes a global fade multiplier stage
6. **$FF opcode** — DSP Register Write is supported in IoG but not in Blazer

**For music conversion:** The sequence data format is byte-compatible. Converting BGM tracks between games requires only address remapping in the BGM file block headers — no sequence data rewriting is needed.

---

## Table of Contents

1. [ARAM Memory Map Comparison](#aram-memory-map-comparison)
2. [Initialization Differences](#initialization-differences)
3. [Main Loop Architecture](#main-loop-architecture)
4. [Opcode Dispatch & Handler Tables](#opcode-dispatch--handler-tables)
5. [Instrument Mapping](#instrument-mapping)
6. [Volume Pipeline](#volume-pipeline)
7. [SFX Subsystem (Blazer Only)](#sfx-subsystem-blazer-only)
8. [Data Tables](#data-tables)
9. [Sequence Data Format Compatibility](#sequence-data-format-compatibility)
10. [BGM File Conversion Guide](#bgm-file-conversion-guide)

---

## ARAM Memory Map Comparison

| Purpose | Soul Blazer | IoG | Delta |
|---------|------------|-----|-------|
| Engine code | `$0400`–`$0F46` | `$0400`–`$0FC9` | −131 bytes |
| Zero page (DP state) | `$0000`–`$00EF` | `$0000`–`$00EF` | **Identical** |
| Stack | `$0100`–`$01CF` | `$0100`–`$01CF` | **Identical** |
| Instrument base offset | `$0FFF` (1 byte) | — | Blazer only |
| SPC slot table | — | `$0FE0` (6 bytes) | IoG only |
| Song base pointer | `$0FFE`+X (indexed) | `$0FFC` (fixed) | Different mechanism |
| Sample end pointer | `$0FFD`–`$0FFE` | `$0FFE`–`$0FFF` | −1 |
| Instrument definitions | `$2E00` (slots 0-12 from the driver; a song's from `$2E4E`) | `$1254` | Different |
| Duration/velocity table | `$2F00` | `$1300` | +$1C00 |
| Song sequence data | `$1000` (every song; first word `$1002`); `$2400` is the sound effect table and sequences | `$1400` (ext) / `$5532` (std) | Different |
| Sample directory | `$2C00` (13 entries from the driver; a song's from `$2C34`) | `$1038` (6×4, std) | Different |
| Extended sample directory | none (one directory) | `$1000` (14×4) | — |
| Handler address table | `$0A54` (54 bytes) | `$0B49` (64 bytes) | Different |
| Param count table | `$0A8A` (32 bytes) | `$0B89` (32 bytes) | Different |
| Frequency table | `$0D72` (26 bytes) | `$0E59` (26 bytes) | −$E7 |
| Octave shift table | `$0D8C` (16 bytes) | `$0E73` (16 bytes) | −$E7 |
| Pitch interpolation | `$0CE9` (18 bytes) | `$0E10` (18 bytes) | −$127 |
| Vibrato sine LUT | `$0CFB` (67 bytes) | — | Blazer only |
| Envelope curve | `$0D3E` (24 bytes) | `$0E22` (32 bytes) | Different |
| FIR coefficients | `$0D56` (22 bytes) | `$0E42` (23 bytes) | Different |
| DSP config table | `$0D5D` / `$0D67` | `$0E44` / `$0E4E` | Different |

### Key Insight

The `+$1C00` offset for instrument definitions and DV table suggests Blazer uses a higher ARAM region for song data, likely because the BRR samples are packed differently. The IoG convention of `$1254` and `$1300` does not apply.

---

## Initialization Differences

### Side-by-side init sequence

| Step | Soul Blazer ($0400) | IoG ($0400) |
|------|--------------------|----|
| Stack | SP = $CF | SP = $CF |
| Zero fill | $00–$EF → 0 | $00–$EF → 0 |
| Early store | **`MOV $0FFF, A`** (store 0 to inst offset) | **`SET1 $48.6`** (set echo flag bit 6) |
| Volume init | CALL $09A9 | CALL $0A76 |
| Echo flag | SET1 $48.5 | SET1 $48.5 |
| Master volume | **`MOV A, #$60`** (MVOL = 96) | **`MOV A, #$00`** (MVOL = 0, silent) |
| DSP writes | MVOL_L, MVOL_R, ECEN+DIR combo | MVOL_L, MVOL_R, ECEN, $3C, DIR |
| Timer 0 | T0DIV = $10 (500 Hz) | T0DIV = $10 (500 Hz) |
| Timer 1 | **Not initialized** | **T1DIV = $10 (500 Hz)** |
| CONTROL | $30 (reset ports), then **$01** (timer 0 only) | $30, then **$03** (timers 0+1) |

### Implications

- Blazer starts with audible master volume ($60); IoG starts silent and fades in
- Blazer uses only hardware Timer 0; IoG uses both Timer 0 and Timer 1
- Blazer stores instrument base offset to $0FFF during init (0 at that moment); the driver block then sets it to `$0D` (13), so a song's instrument n is slot 13 + n (the driver owns slots 0-12)

---

## Main Loop Architecture

### Soul Blazer Main Loop

```
MainLoop ($0436):
  ├── DSP register output loop (10 iterations)
  ├── Wait for Timer 0 tick
  ├── Tempo accumulator 1: tick × $40 → on overflow → CALL SFXHandler ($0DA0)
  ├── Song change check (compare $4C/$4D)
  ├── Tempo accumulator 2: tick × $53 → on overflow → CALL ProcessSequenceTick ($0683)
  ├── Fade processing (decrement $31, stop when zero)
  ├── Port data read/write
  └── If no seq tick: process SFX channels only → loop
```

### IoG Main Loop

```
MainLoop ($0443):
  ├── DSP register output loop (10 iterations)
  ├── Wait for Timer 0 tick
  ├── Tempo accumulator 1: tick × $40 → on overflow → fade check + song change
  ├── Wait for Timer 1 tick ← SEPARATE HARDWARE TIMER
  ├── Tempo accumulator 2: tick × $53 → on overflow → CALL ProcessSequenceTick ($0738)
  ├── Fade processing
  ├── Port data read/write
  └── If no seq tick: process SFX channels only → loop
```

### Critical Difference: Single vs Dual Timer

Blazer derives both tempo accumulators from a single timer tick (Timer 0), using PUSH/POP to share the tick count:

```
0464:  6d          PUSH Y           ; save timer 0 count
0465:  e8 40       MOV A, #$40      ; SFX tempo multiplier
0467:  cf          MUL YA           ; Y × $40
...
0479:  e4 53       MOV A, $53       ; music tempo byte
047b:  ee          POP Y            ; restore SAME timer 0 count
047c:  cf          MUL YA           ; Y × tempo
```

IoG reads two separate timer counters ($FD and $FE):
```
046d:  eb fd       MOV Y, $fd       ; Timer 0 output
...
0495:  eb fe       MOV Y, $fe       ; Timer 1 output (different timer!)
```

Both approaches yield a 500 Hz base tick. The dual-timer approach gives slightly better timing isolation but is functionally equivalent for music playback.

---

## Opcode Dispatch & Handler Tables

### Dispatch Mechanism (Identical)

Both engines use the same computed-jump dispatch via PUSH+RET:

```
; Blazer $07C3 / IoG $0881 — identical logic
ASL              ; opcode × 2 → Y index for handler table
MOV Y, A
MOV A, table+1+Y ; handler high byte
PUSH A
MOV A, table+Y   ; handler low byte
PUSH A
...
MOV A, paramTable+Y  ; param count
BEQ skip
MOV A, [$d4+X]       ; read first param byte
...
RET                   ; jump to handler
```

### Handler Address Comparison

| Opcode | Name | Blazer Handler | IoG Handler | Params | Code Match |
|--------|------|---------------|-------------|--------|------------|
| `$E0` | Set Instrument | `$07DF` | `$089D` | 1 | **Modified** (see §Instrument Mapping) |
| `$E1` | Pan | `$0849` | `$0909` | 1 | Identical logic |
| `$E2` | Pan Fade | `$0857` | `$0917` | 2 | Identical logic |
| `$E3` | Vibrato | `$0870` | `$0930` | 3 | Identical logic |
| `$E4` | Vibrato Off | `$087C` | `$093C` | 0 | Identical logic |
| `$E5` | Main Volume | `$0897` | `$0957` | 1 | **Modified** (offset $00 vs $1E) |
| `$E6` | Volume Fade | `$08A1` | `$0968` | 2 | Identical logic |
| `$E7` | Tempo | `$08B3` | `$097A` | 1 | Identical logic |
| `$E8` | Tempo Fade | `$08BC` | `$0983` | 2 | Identical logic |
| `$E9` | Global Transpose | `$08CE` | `$0995` | 1 | Identical logic |
| `$EA` | Per-voice Transpose | `$08D1` | `$0998` | 1 | Identical logic |
| `$EB` | Tremolo | `$08D5` | `$099C` | 3 | Identical logic |
| `$EC` | ADSR Attack Override | `$08E1` | `$09A8` | 0 | Identical logic |
| `$ED` | Channel Volume | `$0902` | `$09C9` | 1 | Identical logic |
| `$EE` | Channel Vol Fade | `$090B` | `$09D8` | 2 | Identical logic |
| `$EF` | Subcommand | `$0928` | `$09F5` | 3 | Identical logic |
| `$F0` | Amplitude Mod | `$0887` | `$0948` | 1 | Identical logic |
| `$F1` | ADSR Override | `$08E4` | `$09AC` | 3 | Identical logic |
| `$F2` | Pitch Envelope | `$08E8` | `$09B0` | 3 | Identical logic |
| `$F3` | Pitch Envelope Off | `$08FE` | `$09C6` | 0 | Identical logic |
| `$F4` | Tuning | `$0924` | `$09F1` | 1 | Identical logic |
| `$F5` | Echo On | `$094C` | `$0A19` | 3 | Identical logic |
| `$F6` | Echo Off | `$0980` | `$0A4D` | 0 | Identical logic |
| `$F7` | Echo FIR Filter | `$0987` | `$0A54` | 3 | Identical logic |
| `$F8` | Subroutine Call | `$095F` | `$0A2C` | 3 | Identical logic |
| `$F9` | Loop/Return | `$0A05` | `$0AFB` | 3 | Identical logic |
| `$FA` | Conditional | `$09EB` | `$0AE0` | 1 | Identical logic |
| `$FB`–`$FE` | Unused | Invalid | Invalid | — | Both unused |
| `$FF` | DSP Register Write | **Not supported** | `$0AB8` | 1 | **Blazer lacks this** |

### Param Count Table

Identical for opcodes $E0–$FA (27 entries). The $FB–$FF entries differ because Blazer overlaps the handler table with the param count table to save 10 bytes.

### Handler/Param Table Overlap

The handler table has space for 32 entries ($E0–$FF = 32 opcodes × 2 bytes = 64 bytes), but only 27 are valid ($E0–$FA). The entries for $FB–$FF (at `$0A8A`–`$0A93`) overlap the first 10 bytes of the param count table (which also starts at `$0A8A`). This is a deliberate space optimization — both engines do this, saving 10 bytes. The param count bytes (`01 01 02 03 00`) are interpreted as word addresses (`$0101`, `$0302`, `$0005`) if the handler table is indexed with those opcodes, but since opcodes $FB–$FE are never dispatched, this is harmless.

---

## Instrument Mapping

### IoG: Slot Table Lookup

IoG uses a 6-byte slot table at ARAM `$0FE0`. The `$E0` command's parameter is used as a direct index:

```
; IoG $089D
MOV A, $0215+X, A     ; store instrument number
...
PUSH A
MOV X, A
MOV A, $0FE0+X        ; lookup in slot table → SRCN
```

Each song uploads its own slot table mapping local instrument indices to global sample IDs.

### Blazer: Additive Offset

Blazer uses a single byte at `$0FFF` as an additive base offset:

```
; Blazer $07DF
MOV A, $0215+X, A     ; store instrument number
...
CLRC
ADC A, $0FFF          ; ADD base offset from $0FFF
```

The instrument number is directly added to the base offset stored at `$0FFF`. This is simpler but means instruments are mapped linearly rather than through an arbitrary lookup table.

### Conversion Impact

When converting BGM files between formats, the instrument definition upload addresses and the slot mapping mechanism must be adapted. Blazer songs should set `$0FFF` to the appropriate base offset; IoG songs should populate the `$0FE0` slot table.

---

## Volume Pipeline

### Blazer: Global Fade Multiplier

Blazer's volume output pipeline at `$0CCB` includes an additional multiplication stage:

```
; Blazer $0CDA–$0CE5
MOV A, $30             ; fade control flag
BEQ skip_fade
MOV A, $31             ; fade amount (0–255)
ASL
MUL YA                 ; multiply current volume by fade
skip_fade:
MOV A, Y
MUL YA                 ; continue volume pipeline
```

This provides a hardware-level global fade that's applied to every channel's volume calculation. IoG does not have this intermediate multiplication — it fades through the master volume DSP registers instead.

### $E5 (Main Volume) Offset

| Game | Handler | Offset | Effect |
|------|---------|--------|--------|
| Soul Blazer | `$0897` | `SBC A, #$00` | Raw param stored to `$58` |
| IoG | `$0957` | `SBC A, #$1E` | Param − 30 stored to `$58` |

IoG applies a −30 bias to the main volume parameter. This means an IoG `$E5 $64` (100) stores 70 to `$58`, while the same command in Blazer stores 100. When converting sequences, volume parameters may need adjustment.

Additionally, IoG's handler auto-sets `$31 = $FF` if the fade counter was zero, enabling the fade system. Blazer's handler is simpler and does not do this.

---

## SFX Subsystem (Blazer Only)

### Architecture

Soul Blazer includes a complete SFX subsystem at `$0DA0`–`$0F05` (358 bytes) that is **entirely absent from IoG**. This subsystem:

- Manages two SFX channels (indices `$10` and `$12`, corresponding to DSP voices 7 and 8)
- Reads SFX commands from APU ports 2 (`$F6`) and 3 (`$F7`)
- Has its own channel init routine (`$0E14`) and tick processor (`$0E79`)
- Temporarily masks music channels during SFX playback
- Uses SFX sequence pointers from a table at ARAM `$2400`

### SFX Channel Processing

The SFX handler runs on every SFX tempo overflow (accumulator 1), separate from the music sequence tick:

```
SFXHandler ($0DA0):
  ├── Save music enable mask ($1A → $37)
  ├── Mask to channels 0–5 only (AND $1A, #$3F)
  ├── Set SFX mode flag ($34 = $FF)
  ├── Process channel 7 ($10) from port 2 ($F6)
  │   ├── If port 2 positive: init SFX on channel 7
  │   └── If port 2 negative: init BOTH channels 7 + 8 (stereo SFX)
  ├── Process channel 8 ($12) from port 3 ($F7) — independent
  ├── Clear SFX mode flag
  └── Restore music enable mask
```

### SFX Sequence Processing

SFX channel tick processing (`$0E79`) uses the same note/opcode dispatch as music channels, including support for DV bytes, note playing, and N-SPC opcodes. This means SFX can use the full N-SPC instruction set.

One unique feature: the SFX processor at `$0E8E` includes a **vibrato sine table lookup** from `$0CFE+Y` that modulates the pan parameter for stereo SFX panning effects. This is the vibrato sine table data unique to Blazer.

### SFX and the Volume Pipeline

When the SFX mode flag `$34` is set, the volume output pipeline at `$0CCB` takes a different path: it uses `$59` (SFX volume scale) instead of the normal per-channel volume calculation. This prevents music volume fades from affecting SFX.

---

## Data Tables

### Frequency Table — Identical

Both engines use the same 13-entry frequency table (C through C+):

| Note | Value | Blazer Address | IoG Address |
|------|-------|---------------|-------------|
| C | `$085F` (2143) | `$0D72` | `$0E59` |
| C# | `$08DE` (2270) | `$0D74` | `$0E5B` |
| D | `$0965` (2405) | `$0D76` | `$0E5D` |
| D# | `$09F4` (2548) | `$0D78` | `$0E5F` |
| E | `$0A8C` (2700) | `$0D7A` | `$0E61` |
| F | `$0B2C` (2860) | `$0D7C` | `$0E63` |
| F# | `$0BD6` (3030) | `$0D7E` | `$0E65` |
| G | `$0C8B` (3211) | `$0D80` | `$0E67` |
| G# | `$0D4A` (3402) | `$0D82` | `$0E69` |
| A | `$0E14` (3604) | `$0D84` | `$0E6B` |
| A# | `$0EEA` (3818) | `$0D86` | `$0E6D` |
| B | `$0FCD` (4045) | `$0D88` | `$0E6F` |
| C+ | `$10BE` (4286) | `$0D8A` | `$0E71` |

### Octave Shift Table — Identical

```
00 00 10 00 20 00 30 00 40 00 50 00 60 00 70 00
```

### Pitch Interpolation Curve — Identical

18-byte quarter-sine curve starting at `00 01 03 07 0D 15 1E 29 34 42 51 5E 67 6E 73 77 7A 7C`:

| Blazer Address | IoG Address |
|---------------|-------------|
| `$0CE9` | `$0E10` |

### Vibrato Sine Table — Blazer Only

64-byte sinusoidal lookup table at `$0CFB`–`$0D3D` used by the SFX stereo panning system. Values range 0–20 ($00–$14):

```
0A 0B 0C 0D 0E 0F 10 11 11 12 12 13 13 13
14 14 14 14 14 13 13 13 12 12 11 11 10 0F 0E 0D
0C 0B 0A 09 08 07 06 05 04 03 03 02 02 01 01 01
00 00 00 00 00 01 01 01 02 02 03 03 04 05 06 07
08 09
```

This is a smooth sine wave with center value $0A (10) and amplitude $0A (±10).

### Envelope/FIR Data — Functionally Identical

The ADSR envelope curve and FIR coefficient data have the same values but different sizes/boundaries due to table packing:

| Data | Blazer | IoG |
|------|--------|-----|
| Envelope curve bytes | `$0D3E` (24 bytes) | `$0E22` (32 bytes) |
| FIR coefficients | `$0D56` (22 bytes) | `$0E42` (23 bytes) |

The extra bytes in IoG's tables are padding/alignment. The musically significant coefficient values are identical.

### DSP Config Tables

Both engines use two tables for the DSP register output loop (register numbers and data source addresses). The values differ only in their ARAM locations:

| Purpose | Blazer Table | IoG Table |
|---------|-------------|-----------|
| DSP register numbers | `$0D5D` | `$0E44` |
| Data source pointers | `$0D67` | `$0E4E` |

---

## Sequence Data Format Compatibility

### Byte Encoding — Identical

| Byte Range | Type | Blazer | IoG |
|------------|------|--------|-----|
| `$00` | End | ✓ | ✓ |
| `$01`–`$7F` | Duration/Velocity | ✓ | ✓ |
| `$80`–`$C7` | Note (72 notes) | ✓ | ✓ |
| `$C8` | Tie | ✓ | ✓ |
| `$C9` | Rest | ✓ | ✓ |
| `$CA`–`$DF` | Percussion | ✓ | ✓ |
| `$E0`–`$FA` | Opcodes | ✓ (27 opcodes) | ✓ (27 opcodes) |
| `$FB`–`$FE` | Unused | ✓ | ✓ |
| `$FF` | DSP Register Write | ✗ | ✓ (1 opcode) |

### DV Byte Format — Identical

The duration/velocity byte encoding is the same:
- Bits 6-4 (after XCN): duration class → gate fraction table
- Bits 3-0 (after XCN): velocity index → velocity table

Both engines use the same XCN+AND extraction sequence:

```
; Both engines:
XCN A           ; swap nibbles
AND A, #$07     ; extract gate class (bits 6-4 of original)
MOV Y, A
MOV A, $XX00+Y  ; gate fraction lookup (Blazer: $2F00, IoG: $1300)
...
AND A, #$0f     ; extract velocity (bits 3-0 of original)
MOV Y, A
MOV A, $XX08+Y  ; velocity lookup (Blazer: $2F08, IoG: $1308)
```

### Pitch Calculation — Identical Algorithm

Both engines use the same multi-step pitch calculation:
1. noteIndex = (byte − $80) + channelTranspose
2. octave = noteIndex / 12, semitone = noteIndex % 12
3. Frequency table lookup with tuning interpolation
4. Octave shift via ASL+ROL then LSR+ROR loop (6 − octave iterations)
5. Instrument pitch multiplication → DSP pitch register

### Song Structure — Same Format

Both use the phrase list → pattern → channel pointer hierarchy:
- Phrase list: array of u16 pattern pointers, `$00FF` = loop marker, `$0000` = end
- Pattern: 16 bytes (8 × u16 channel pointers)
- Channel data: byte stream with notes, DV bytes, and opcodes

---

## BGM File Conversion Guide

### Converting IoG BGM → Soul Blazer

For each BGM file block, remap the ARAM target addresses:

| IoG Block Target | Blazer Target | Contents |
|-----------------|---------------|----------|
| `$1254` | `$2E4E` | Instrument definitions (N × 6 bytes); the 21 Blazer songs all write them from `$2E4E` (slot 13), so the `+$1C00` shift of the table above is not exact for this row |
| `$1300` | `$2F00` | Duration/velocity table (24 bytes) |
| `$1400` or `$5532` | `$1000` | Sequence data |
| `$1038` | `$2C34` | Sample directory entries (13 and up; 0-12 belong to the driver) |
| `$0FFC` | Song pointer table | Song base pointer |
| `$0FFE` | `$0FFD`–`$0FFE` | Sample end pointer |
| `$0FE0` | `$0FFF` (1 byte) | Instrument slot mapping → base offset |

### Sequence Data: No Modification Required

The raw sequence data bytes (notes, DV bytes, opcodes $E0–$FA, ties, rests) are byte-compatible. No rewriting is needed.

### Volume Adjustment

If a song uses `$E5` (Main Volume), the parameter value may need adjustment:
- IoG applies a −30 offset internally
- Blazer uses the raw value
- To convert IoG → Blazer: subtract 30 from the `$E5` parameter (or accept slightly different volume curve)

### Opcodes to Avoid

- `$FF` (DSP Register Write): not supported in Blazer — remove from sequence data if present in IoG songs

### Instrument Mapping Conversion

IoG's per-song slot table (`$0FE0`, 6 entries mapping slot→SRCN) must be converted to Blazer's additive offset model (`$0FFF`, single byte). If the IoG song uses a linear slot mapping (slot 0 → SRCN 0, slot 1 → SRCN 1, etc.), set `$0FFF` to the SRCN of slot 0. Non-linear mappings require instrument definition reordering.

---

## See Also

- [SPC Disassembly](spc-disassembly.md) — Full annotated disassembly of the engine binary
- [IoG SPC Engine](../../../gaia-iog-baserom/docs/audio/spc-engine.md) — IoG engine reference
- [IoG SPC Disassembly](../../../gaia-iog-baserom/docs/audio/spc-disassembly.md) — IoG disassembly for direct comparison
