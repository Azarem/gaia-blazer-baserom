# I050 results: `docs/code/sprites-oam-animation.md` (sprites, OAM and animation)

PD step of the plan "Blazer docs and analysis", topic "sprites, OAM and animation (spritemap format)". The prompt left `<files>` empty; I chose the files that make up the topic (see Sources), as in I043 to I049. Work started from a fresh `npm run extract:lt`; the gate was run at the end. The plan checklist is `plans/doc-audit/I050_checklist.md`.

## Deliverables

| File | What |
|------|------|
| `docs/code/sprites-oam-animation.md` | New topic document (348 lines): breadcrumb, source links, overview with one mermaid diagram (11 nodes), memory-map tables (code, data, state) and the actor-field table, 17 `###` sections (draw order, `BuildOamFromActors`, `BuildActorSprites`, the spritemap entry with a worked example, the hero's streamed tiles and the two NMI DMA passes, `DmaOamBuffer`, `SetActorAnimFrame` and `EndAnimation`, lists/steps/frames with a worked example, the animation commands, the six fixed banks, scene spritemaps at `$7E:3800`, the EXP popup map at `$7E:F000`, the appear/death/hold effects, `NextFrameRecord` and `CopyFrameData`, which OAM tiles hold what), a walkthrough cross-check table, open questions and See Also. |
| `plans/extracted-audit/edits/I050.json` | Merge spec: five edits in four part notes, two block-note edits and two comment corrections (see finding 8). |
| `plans/extracted-audit/questions/I050_questions.md` | OQ-I050-1 to OQ-I050-6 (all GAP, no DISCREPANCY). |
| `plans/extracted-audit/results/I050_results.md` | This file. |
| `plans/doc-audit/I050_checklist.md` | The checklist with its progress section. |
| `docs/code/actor-system.md`, `boot-nmi-main-loop.md`, `cop-dispatch.md`, `player.md`, `combat-damage-and-enemy-records.md` | Links, See Also and planned-spokes lines; the "candidates: bosses" wording in `boot-nmi-main-loop.md`; the OQ-I049-6 sentence in the combat document. Edited by hand; no notes, comments or names. |

Sources documented: `engine_actor_scheduler_and_sprites` (draw order, `BuildOamFromActors`, `BuildActorSprites`, `BuildDynamicTileSprites`, `SetActorAnimFrame`, `EndAnimation`), `engine_vblank_nmi` (`DmaOamBuffer`, `DmaDynamicSpriteTiles`, `DmaSpriteTileRecords`, `DmaAnimatedTileStrip`), `cop_actor_fields_animation` and `lib_animation` (the animation commands, `NextFrameRecord`, `CopyFrameData`), `lib_scene_asset_loader` (`LoadSceneSpritemap`, `scene_sprite_attr`), the six `data_anim_*` banks, `engine_spawn_lairs_death_drops` (`RunEnemyDeath`, `RunMonsterAppearPuff`, `HoldActorUntilReleased`), the hero's `InitPlayerActor` and the `.spm` scene maps. Not repeated: the pool and scheduler (`actor-system.md`), the frame and NMI (`boot-nmi-main-loop.md`), COP handlers in general (`cop-dispatch.md`), pose code (`player.md`), damage and the EXP table (`combat-damage-and-enemy-records.md`).

## Findings

1. **Draw order.** The key is (255 − (y − scroll_y)) × 2; `$1A` bit `$4000` forces key 0 (front), `$2000` forces `$01FE` (behind). The list is drawn in ascending key order and a lower OAM index is in front, so when the 128 entries run out the back-most actors lose their sprites (OQ-I050-6).
2. **Order inside a frame.** The cull pass uses the previous scroll and the OAM pass the new one (`RunMainLoop`), so the draw list is one scroll step old.
3. **Spritemap.** Word count, then 7-byte entries: flags (bit 0 = size), x, x flipped, y, y flipped, tile/attribute word (XOR `$1C`, OR `$06` on the stun flash). Origin is x − `$08`, y − `$0A` − (scroll − 16). Clipped entries write `$E080` without advancing the OAM index.
4. **Animation chain.** Table word by id → list of 8-byte steps (duration, dx, dy, frame; negative ends) → frame leaf (12-byte header: left, right, top, bottom, width, height; then the spritemap). A step lasts duration + 1 frames; the dx/dy of the step is the actor's walking speed. Flip bits negate the speed and mirror the box (formulas in the document).
5. **Dynamic tiles are the hero only.** `CopA9_SetDynamicTileSource` has one caller, `InitPlayerActor`; the source is the `graphics_054000` copy at `$7F:3000`. A frame has at most three records (OAM tiles 0-5 and 16-21, 384 bytes), and the NMI sends them in two passes (`$40` bytes to VRAM word `$2000` upward, then source + `$200` to `$2100` upward). The `DmaAnimatedTileStrip` slots (tiles 6-13 and 22-29) are disjoint from these, which answers the collision part of OQ-I043-4.
6. **The six banks.** `$0A` unarmed hero (26 lists, 116 steps, 64 leaves), `$0B` armed hero (44/184/100), `$0C` weapon (44/120/42 blobs), `$0D` colour lists (80/686/593, stepped by `NextFrameRecord` and `CopyFrameData`, copied through the RAM stub at `$1C5C`), `$0E` effects (17/83/28), `$0F` magic (54/264/124, eight selecting scripts).
7. **The EXP popup.** `RunEnemyDeath` writes the digit count and digit tiles into the map at `$7E:F000`, one 7-byte slot per actor slot; `COP 1B` waits `$10` frames, then `FinishEnemyDeath` runs. This answers OQ-I049-6. What keeps that map intact is OQ-I050-2.
8. **Notes corrected with `merge`:** `DmaDynamicSpriteTiles` (the "candidates: bosses and large monsters" guess; only the hero is dynamic) and the block note of `engine_actor_scheduler_and_sprites` (same fact); the block note of `w2_effect_player_overlay` (`$7E3800` is its animation table, the scene spritemap, not a dynamic tile source); `InitActorFromPlacement`, `SpawnLairActor`, `RunMonsterAppearPuff` and comments 5073 and 10547 (`$0372` was written as a constant attribute; it is the address of `scene_sprite_attr`, a variable whose high byte `ApplySceneProfile` writes from profile byte 4, bits 4-5).
9. **Walkthrough cross-check.** Five rows, no mismatch: the document uses only terms the walkthrough has (Soul Blade, Magician, magic effects, Dr. Leo's Lab); the sprite format itself is not described in the walkthrough, so those claims rest on the ROM.
10. **Counts recorded:** 109 distinct backticked identifiers, 11 diagram nodes, 17 `###` sections, 348 lines.

## Open questions

OQ-I050-1 (hero-only dynamic tiles: runtime check), OQ-I050-2 (what keeps the EXP map at `$7E:F000` intact), OQ-I050-3 (effect frames name the animated strip slots), OQ-I050-4 (four unreferenced weapon leaves in `binary_060836`, `$0C:8852` to `$0C:88A5`), OQ-I050-5 (source of tiles `$20`-`$5F`, `$A0` and up, and enemy tiles), OQ-I050-6 (sprite budget with 128 OAM entries). Details and Mesen2 tools in `questions/I050_questions.md`.

## Not done / follow-ups

- The breadcrumb links to `docs/code/README.md`, which does not exist yet (the hub is a later PD step); the link is dead until then, as in I043 to I049. **The hub should link this document and should not repeat the spritemap or animation formats.**
- No Mesen2 run was made; every claim that rests on static reading is marked or carries an OQ.
- VRAM and HDMA, and the HUD, remain separate spokes (named in the planned-spokes lines).

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK (fresh before the work and after the merge; the corrected notes appear in the output) |
| `npm run merge -- plans/extracted-audit/edits/I050.json --dry-run`, then applied | 4 notes files changed (`blockNotes/bank00`, `blockNotes/bank0F`, `partNotes/bank00`, `comments/bank00`); 4 part notes, 2 block notes and 2 comments updated |
| `npm run rebuild` at the end | OK, SHA-1 `040a408a1f2b5fd4e759c3bcd789321df0b8f18a`, 1081344 bytes, checksum 110070696: unchanged (annotation only) |
| `npm run names -- --check` | OK (2765 names; no rename in this step) |
| `npm run merge -- --check` | OK: 1401 comments, 1684 part notes, 135 block notes; 0 errors, 0 warnings, 0 orphans, 0 duplicate keys |
| Backticked identifiers of the new document | 109 distinct, each found in `extracted/` or `us/` |
| Links in the new document | all relative targets exist except the hub `README.md` (see above) |
| Mermaid diagrams in the new document | 1, 11 nodes |

## Suggested commit message

```
docs: sprites, OAM and animation (I050)

Add docs/code/sprites-oam-animation.md: draw order, the OAM buffer and
spritemap entry, animation lists/steps/frames, the six animation banks,
the hero's streamed tiles, scene spritemaps and the EXP popup map.
Correct notes that called bosses dynamic-tile candidates, called $7E3800
a tile source for the effect overlay, and treated $0372 as a constant
(scene_sprite_attr). Link the new document from the sibling docs.
OQ-I050-1 to OQ-I050-6 logged. ROM SHA-1 unchanged.
```

Please commit when you're ready.
