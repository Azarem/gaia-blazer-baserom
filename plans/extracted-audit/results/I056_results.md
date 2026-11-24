# I056 results: docs/code/spc-interface.md

Topic: the SPC interface (the CPU side of the sound chip; links `docs/audio/`). The `<files>` placeholder was empty, so the files were chosen like in I043-I055 (list in `plans/doc-audit/I056_checklist.md`).

## Deliverables

| File | What |
|------|------|
| `docs/code/spc-interface.md` | New spoke, 398 lines: breadcrumb, source links, overview with two diagrams (11 and 9 nodes), memory map (code, data, state, ARAM as the CPU fills it), the ports, the command channel (`APUIO0`), the sound request (`BRK` to `APUIO2`/`APUIO3`), the uploads (record protocol, two phases, driver block, song format, the two senders), music changes by script (with the 21-track table), pause and the dog, boot, hazards for a patch, walkthrough cross-check, open questions, See Also |
| `plans/extracted-audit/edits/I056.json` | Merge spec: 5 block notes, 8 part notes and 3 comments corrected in 7 extracted files (10 notes files written) |
| `plans/extracted-audit/questions/I056_questions.md` | OQ-I056-1 to OQ-I056-6 (all GAP), plus the static answers to OQ-I024-1, OQ-I025-2, OQ-I013-6, OQ-I035-3, OQ-I042-6, the static half of OQ-I043-1, and a note on OQ-I042-5 |
| `plans/doc-audit/I056_checklist.md` | Checklist, written before the first edit, ticked as items finished |
| Hand edits | `cop-dispatch.md` (the `BRK` paragraph says what the two bytes mean; See Also), `boot-nmi-main-loop.md` (the pause sentence, the sound-request paragraph, See Also), `text-and-dialogue.md` and `menus-inventory-status-hud.md` (See Also: the "Planned spokes" line is replaced), `docs/audio/spc-engine.md` (file name, instrument base offset, the TBD ARAM rows, two rows of the BGM conversion guide), `docs/wram-memory-map.md` (rows `sound_request` and the new `$0320`) |

## Findings

1. **The two sound bytes are two SFX voices.** `HandleBrk` puts n in the low byte (`APUIO2`, SPC `$F6`, voice 7) or `n and $BF` in the high byte (`APUIO3`, `$F7`, voice 8); bit 7 of the low byte plays on both voices; bits 0-5 are the sound id 1-`$26` (`SFXInitChannel`, table at `ARAM $2400`). The 289 sites use 57 operands, 89 on the low byte, 200 on the high byte, 46 with bit 7; every id is in range (settles OQ-I024-1).
2. **`APUIO0` is a command channel with an echo.** Below `$F0` a value is a song number (only 0 and 1 are ever sent), from `$F0` up a command: `$F0` stop, `$F1` fade-out, `$F2` pause, `$FF` enter the engine's own record receiver. The SPC writes its current command back to the same port, which is what every wait loop reads.
3. **A command of `$F0` or more is run again on every tick while the port holds it.** That is why `MusicLoadWaitFadeAck` answers `$01` (the fade counter would restart each tick), why `$F0` can stay, and why the pause freezes the sequence while `$F2` stays (settles OQ-I025-2 and OQ-I013-6 statically; `$F1` is a fade-out).
4. **The final `$01` starts the song.** The SPC leaves a transfer with last song 0, so `$01` differs and `PlaySong` starts song 1; the same `$01` at the end of the pause equals the playing song and resumes. Every song is stored as song 1; the 21 tracks are 21 files for one slot.
5. **The restaurant dog stops and restarts the music.** The 0 keys off the music voices and freezes the sequence, the later 1 restarts the tune from its first phrase (static half of OQ-I035-3).
6. **The streams are decoded.** The driver block and all 21 songs are five IPL records and a closing record of length 0 whose destination word is the sample count and the first sample index; the samples come from the 33-entry table at `$07:8000`. Driver: instruments at `$2E00`, a 24-byte table at `$2F00`, the sound effect table and sequences at `$2400`, 13 directory entries at `$2C00`, `$0D` at `$0FFF`. Songs: instruments from `$2E4E`, the same 24 bytes, sequence data at `$1000` (first word `$1002`), directory entries from `$2C34`, the end pointer at `$0FFD`. All 22 streams tile to their last byte and every directory entry and end pointer follows from the sample sizes (settles OQ-I042-6).
7. **A song upload is two handshakes.** `UploadSpcStream` sends the records, waits two vblanks, writes `$FF` again and sends the samples; the later uploads never use the SPC boot ROM (the old notes said "IPL boot handler"). `UploadSpcDriver` leaves `$7353` in `$0320`.
8. **The zero on odd frames is the end of a pulse.** `SFXHandler` has no previous-value test, so the word on `APUIO2`/`APUIO3` is a level for one frame; the zero is what allows the same id twice (static half of OQ-I043-1).
9. **Track `$12` is also the music of area 0 scene `$0B`** (read as the ending by `boot-nmi-main-loop.md`); the singer's `COP 31 #12` plays it. The title scene has track `$10` for variant 0 and `$13` for variant 1; the boot scene has no music record, which `UploadSceneMusic` could not survive before the engine runs.
10. **The sine-wave mover in `engine_spc_ipl_upload.asm` is not SPC code**; it shares the skeleton of the arc jets but moves the actor itself (OQ-I042-5 stays open: no reference).
11. **`docs/audio/spc-engine.md` had three stale or open spots**: the file name `chunk_0FAA49.asm`, "always 0 at boot" for the instrument base offset (the driver sets `$0D`) and the TBD ARAM rows (now `$2C00`/`$2C34` for the directory, `$1000` for songs, `$2E00`/`$2E4E` for instruments).
12. The document links to `README.md` (the hub), which does not exist yet; the link is dead until the hub is written, as in I043-I055.
13. `extracted/` holds line-tracked output (`; {n}` tags), because the last extraction before the gate was `npm run extract:lt`, as in earlier iterations.

## Open questions

| ID | Tag | Topic |
|----|-----|-------|
| OQ-I056-1 | GAP | Does one sound word start the sound once or twice (`SFXHandler` runs about twice per frame)? |
| OQ-I056-2 | GAP | What the dog's 0 and 1 sound like: cut or ring-out, restart from the first phrase |
| OQ-I056-3 | GAP | What bit 6 and bit 5 of SPC byte `$48` do (`$F2`, `StopAllChannels`): mute, echo write? |
| OQ-I056-4 | GAP | `MusicLoadUpload`'s `EnableNmi` in the middle of the work phase |
| OQ-I056-5 | GAP | Frames of a music change and of a scene music change; the length of the fade |
| OQ-I056-6 | GAP | What the 38 sound ids and the 13 driver samples are |

No DISCREPANCY: the game terms of the document (title screen music, the singer and the Harp String with "the alternate music", the restaurant dog's joke, the Start pause) agree with `01-in-the-beginning.md`, `03-greenwood.md` and `07-king-magridds-castle.md` as far as static reading can check.

## Gate

| Check | Result |
|-------|--------|
| `npm run merge -- plans/extracted-audit/edits/I056.json --dry-run`, then apply | OK; 10 notes files changed (`blockNotes/bank00`, `bank02`, `bank03`, `bank0F`, `partNotes/bank00`, `bank01`, `bank0F`, `comments/bank00`, `bank01`, `bank02`); one length warning in the dry run (the dog comment, 181 characters), fixed before applying |
| `npm run extract:lt` | OK; the corrected notes and comments show in `extracted/` |
| `npm run rebuild` | SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1,081,344 bytes, checksum 110070696: unchanged; the "Cross bank call" warnings are as before |
| `npm run names -- --check` | OK (2765 names) |
| `npm run merge -- --check` | 0 errors, 0 warnings, 0 orphans (1401 comments, 1684 part notes, 135 block notes) |
| Document checks | the memory-map addresses were converted from `us/names/` (LoROM); 114 backticked identifiers: all exist in `extracted/`, `us/names/`, `us/mnemonics.json` or the SPC listing (`ProcessSequenceTick`, `PlaySong`, `SetEchoBit6`, `BootLoadData`, `SFXHandler`, `SFXInitChannel`, `ReadPortData`, `InitSampleEndPtr` are SPC-side labels of `audio/spc-disassembly.md`, as the document says); `sfxLocation` and `sfxCount` are keys of `us/config.json`; relative links resolve except the hub `README.md`; 398 lines; 2 diagrams of 11 and 9 nodes; the stream decode, the sample sums and the `BRK` counts were re-run from the survey |

## Follow-ups

- The hub `docs/code/README.md` should link `spc-interface.md` and must not repeat the port table, the command table or the track table.
- `$0320` has no name in `us/mnemonics.json`; a RAM name such as `spc_upload_dest` would make the loader and `UploadSpcStream` read better (a mnemonics change, not a `names` change).
- OQ-I056-6 can be settled statically first by decoding the 38 sequences at `ARAM $2400` with the N-SPC opcodes of `audio/spc-engine.md`; that would also name the 13 driver instruments.
- OQ-I056-3 can be settled statically by following SPC byte `$48` to the DSP in `DSPOutputLoop` before any runtime run.
- The earlier question rows of OQ-I024-1, OQ-I025-2, OQ-I013-6, OQ-I035-3, OQ-I042-6 and OQ-I043-1 are left as they are; their static answers are in `I056_questions.md`.

## Suggested commit message

```
docs(blazer): add spc-interface spoke (I056)

Document the CPU side of the sound chip: the four ports, the APUIO0
command channel and its echo ($F0 stop, $F1 fade-out, $F2 pause, $FF
receiver), the BRK sound word as requests for SFX voices 7 and 8, the
record protocol, the driver block and song stream format (decoded and
checked against the sample sizes), the music-load chain, the 21 tracks,
the pause and the restaurant dog. Correct the notes of HandleBrk, the
music-load chain, UploadSpcStream, SendSpcIplBlocks, SpcDriverBlock,
UploadSceneMusic and HandlePauseBanner, and the comments of the fade
answer, the pause and the dog. Fill the TBD ARAM rows of spc-engine.md.
Link the spoke from cop-dispatch, boot-nmi-main-loop, text-and-dialogue,
menus-inventory-status-hud and wram-memory-map.
```

Please commit when you're ready.
