# I045 checklist - `docs/code/cop-dispatch.md` (COP dispatch)

PD step of the plan "Blazer docs and analysis" (`c:\Users\azare\.cursor\plans\blazer_docs_and_analysis_e740ea3f.plan.md`, prompt "PD - Docs", topic = COP dispatch, extends `docs/cop/index.md`; handler families get links). Continues I044. Annotation and docs only: the ROM SHA-1 must not change.

Baseline gate before this step: `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` (1,081,344 bytes, checksum 110070696), measured with `npm run rebuild` at the start.

Files of the topic (the prompt left `<files>` empty): `extracted/system/cop_dispatch.asm`, `extracted/system/cop_core.asm`, `extracted/cop_handlers/{cop_script_flow_flags, cop_items_stats_text, cop_conditions, cop_actor_fields_animation, cop_tiles_spawn_kill}.asm`.

## Read first

- [x] `gaia-core/docs/notes-and-comments.md` (merge, names, comment guide), `gaia-core/docs/rom-mapping-guide.md`
- [x] `gaia-knowledge/curated/gaialabs/code-bank-documentation.md` (skeleton, Three Questions)
- [x] `plans/mapping/mapping-action-plan.md` section 0 and 8c-8e, `plans/doc-audit/README.md`, `docs/walkthrough/README.md` and the chapters for the terms used
- [x] `docs/cop/index.md` (the hub of the command list: not to be duplicated), `docs/code/actor-system.md`, `docs/code/boot-nmi-main-loop.md` (style and overlap)
- [x] Fresh `npm run extract:lt`; all seven asm files read end to end

## Analysis findings to settle before writing

- [x] `HandleCop`: stack frame, script pointer, table indexing, why the table and all handlers are in bank 00 (JMP (abs,X) reads the pointer from PB, the vector forces PB = 0)
- [x] `HandleBrk`: the "about a hundred call sites" claim against a count (289 `BRK #n` instructions)
- [x] Exit chain: what each exit does to the stack, to `$18`/`$36`/`$14`; which commands write the bank byte `$36` (only `Cop91` for the running actor; the spawn and music commands for the new actor)
- [x] Wait idioms: rewind of `$38` (`Cop05`, `CopAD`) against the resume pointer saved by `Cop80`/`Cop81`/`Cop9D` (`Cop82`, `Cop83`, `Cop9E`); the "re-runs next frame" claim in the notes (wrong: duration + 1 frames; pairs verified 1614/1614, 522/522, 51/51, 21/21)
- [x] Operand conventions: Byte read as word and masked, 8-bit `INC $38` with carry into `$39` (`Cop1A`, `CopA8`, `CopA9`, `Cop29`); `&ASCIIString$2` of `Cop1A` (bank 02, bank hint of `cop.ts`) against `Cop01` (script bank)
- [x] Box tests, three-way branches, tile probes: the bottom-edge convention (y = bottom edge) and which command samples which tile
- [x] Use counts of `docs/cop/index.md` against `rg` over `extracted/` (11,025 command sites; per-family sums)
- [x] Hub claims verified: filler words (`#$0020` at index `$26`), `Cop9A`/`Cop9B` band, `Cop1A` byte, "byte-code" wording

## Plan

### A. Names (`renames/apply-I045_names.json`)

- [x] A1 21 sub-labels the document cites; `--dry-run`, apply, `extract:lt`

### B. Notes (`edits/I045.json`, `edits/I045b.json`)

- [x] B1 `HandleBrk` part note: BRK count
- [x] B2 `CopFillerTable_3D_7F` part note: the `#$0020` word
- [x] B3 `SpawnActorBefore` part note: run-order wording left over from before I044
- [x] B4 `cop_core` block note and `CopExitYield`/`CopExitJump` part notes: wait idioms, frame, bank of a jump
- [x] B5 `cop_actor_fields_animation` block note, `Cop82_WaitAnimationDone` and `Cop83_WaitAnimationRepeat`: duration + 1 frames, count below 2
- [x] B6 comments on the stack-frame instructions of `HandleCop`, `HandleBrk`, `CopExitJump`, `CopExitYield`
- [x] B7 `--dry-run`, apply, `extract:lt` (I045)
- [x] B8 found while checking the document (I045b): `ClearActorFootprint` (Cop11 clears at the new position), `Cop86_KillSelf` and the `cop_tiles_spawn_kill` block note (RTL at 280 of 283 sites); `--dry-run`, apply, `extract:lt`

### C. Document

- [x] C1 `docs/code/cop-dispatch.md`: breadcrumb, source links, overview with two diagrams, memory map, 16 `###` sections (Three Questions), worked example, walkthrough cross-check, open questions, See Also
- [x] C2 `docs/cop/index.md`: corrections (filler words, `Cop9A`/`Cop9B` band, `Cop1A` byte, byte-code wording, yield wording) and the link to the new document
- [x] C3 `docs/code/boot-nmi-main-loop.md`: BRK count; `docs/code/actor-system.md`: See Also link
- [x] C4 every backticked label of the document exists in `extracted/` (211 tokens); every relative link resolves (except the hub `README.md`, not written yet)

### D. Records and gate

- [x] D1 `questions/I045_questions.md` (OQ-I045-1 DISCREPANCY, -2, -3)
- [x] D2 gate: `extract:lt`, `rebuild` (SHA-1 unchanged), `names -- --check` (2758), `merge -- --check` (0 errors)
- [x] D3 `results/I045_results.md` with the suggested commit message

## Progress

- 2026-11-23: checklist written, baseline measured (`040a408a...`).
- 2026-11-23: names applied (21), merge I045 applied (3 files), `extract:lt` fresh.
- 2026-11-23: document written; verification found three errors in my own draft and in the notes (RegisterSwitchOwner readers, ClearActorFootprint timing in Cop11, "always followed by RTL"); fixed, I045b applied.
- 2026-11-23: hub, boot doc and actor-system See Also edited; questions and results written; gate passed, SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a` unchanged.
