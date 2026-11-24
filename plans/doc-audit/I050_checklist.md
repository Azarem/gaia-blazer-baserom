# I050 checklist: docs/code/sprites-oam-animation.md

Topic: sprites, OAM and animation (the spritemap format). `<files>` was not given, so the files are chosen like in I043-I049.

Rules in force: notes and comments change only through `npm run merge`, names only through `npm run names`; no ad-hoc scripts; no commits; no comparison of the original ROM with the rebuilt ROM; every claim cites a label; the walkthrough is the source of truth for game names, the ROM text for exact spelling and behaviour; every mismatch is an OQ with tag DISCREPANCY.

## Scope

Files (all under `extracted/`):

- `system/engine_actor_scheduler_and_sprites.asm` (`BuildOamFromActors`, `BuildActorSprites`, `BuildDynamicTileSprites`, `SetActorAnimFrame`, `EndAnimation`; `CullAndSortActors` only for what decides the OAM order)
- `system/engine_vblank_nmi.asm` (`DmaOamBuffer`, `DmaDynamicSpriteTiles`, `DmaSpriteTileRecords`, `DmaAnimatedTileStrip`)
- `library/lib_animation.asm` (`NextFrameRecord`, `CopyFrameData`) and `cop_handlers/cop_actor_fields_animation.asm` (Cop80-Cop83, Cop87/88, Cop8F/90, Cop92-95, Cop96-99, Cop9D/9E, CopA2-CopA9, CopAA)
- the six animation banks: `system/data_anim_player_unarmed.asm`, `data_anim_player.asm`, `data_anim_weapon_overlay.asm`, `data_anim_palette_cycles.asm`, `data_anim_effects.asm`, `data_anim_magic.asm`
- the scene spritemaps (`*.spm`, 30 files), `library/lib_scene_asset_loader.asm` (`LoadSceneSpritemap`, `ExpandSpritemap`), `system/data_scene_asset_lists.asm`, `system/WorldMetaPointers.asm` (animation table column)
- the EXP popup map (`RunEnemyDeath`, `WriteLowNibbleDigit`), the appear and hold effects (`RunMonsterAppearPuff`, `LoadMonsterFromMeta`, `HoldActorUntilReleased`), `InitPlayerActor` (the one `CopA9`), `ApplyPlayerWeaponPose`, `ApplyBootPpuLayout` (OBJSEL)

Not repeated (already in the spokes): the actor slot layout, the scheduler and the sort passes (actor-system.md), the NMI sequence and the main loop (boot-nmi-main-loop.md), the hero's action loop and `PlayerFacingByAnim` numbers (player.md), the COP dispatcher and exit chain (cop-dispatch.md), the hit masks over `$16` and `$1A` (combat-damage-and-enemy-records.md), tile collision (collision-and-physics.md).

## To do

- [x] Read the conventions: notes-and-comments.md (Notes Merge), rom-mapping-guide.md (spritemaps), code-bank-documentation.md (Three Questions), mapping-action-plan.md, doc-audit README, walkthrough README, `magic.md`, `01-in-the-beginning.md`, the format of the I049 documents.
- [x] Read every routine of the topic in the annotated asm and decode the data: hero leaf `binary_050408`, scene spritemap `spritemap_0F3595.spm`, EXP popup map `spritemap_0F0CEE.spm`, the leaf entry counts of the five sprite banks, the table column of the 469 meta rows.
- [x] Cross-check the existing notes against the code: `DmaDynamicSpriteTiles` ("candidates: bosses and large monsters"), `w2_effect_player_overlay` ("dynamic tile source $7E3800"), the `$0372` comments of `InitActorFromPlacement`, `SpawnLairActor` and `RunMonsterAppearPuff`.
- [x] Write this checklist (before any edit).
- [x] Write `docs/code/sprites-oam-animation.md` in one Write call: breadcrumb, source links, overview with one mermaid diagram (at most 15 nodes), memory map (code, data, state), `###` sections that answer the Three Questions, walkthrough cross-check, open questions, See Also.
- [x] Write `plans/extracted-audit/edits/I050.json` (part-note, block-note and comment corrections); `npm run merge -- ... --dry-run`, apply, `npm run extract:lt`.
- [x] Write `plans/extracted-audit/questions/I050_questions.md`.
- [x] Hand edits: `actor-system.md`, `boot-nmi-main-loop.md`, `cop-dispatch.md`, `player.md`, `combat-damage-and-enemy-records.md` (links, planned-spokes lines, OQ-I049-6 and OQ-I043-4 answers).
- [x] Verify: every backticked identifier of the new document exists in `extracted/` or `us/names/`; every relative link resolves; line count 50-900; at most one mermaid diagram with at most 15 nodes.
- [x] Gate: `npm run extract:lt`, `npm run rebuild` (SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1,081,344 bytes, checksum 110070696 unchanged), `npm run names -- --check`, `npm run merge -- --check`.
- [x] Write `plans/extracted-audit/results/I050_results.md` with the gate table and a suggested commit message.

## Progress

- Fresh `npm run extract:lt` and a baseline `npm run rebuild` (SHA-1 `040a408a...`, unchanged) done before any edit.
- Reading, decoding and the cross-check of the existing notes done (see the ticked items).
- Doc, questions file and merge spec written; merge dry-run then applied (4 notes files changed); fresh `npm run extract:lt` shows the corrected notes.
- Hand edits made in five sibling docs; identifiers (109 distinct) all found, links resolve except the planned hub `README.md`.
- Gate run: rebuild SHA-1 unchanged, `names --check` OK, `merge --check` OK. Results in `plans/extracted-audit/results/I050_results.md`.
