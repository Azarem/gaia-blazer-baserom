# I033 checklist (PC annotate A11, data and tables)

Scope: the data blocks of FM-A11: `WorldMetaPointers` (7 world meta lists), the scene lists (`data_scene_placements`, `data_chest_lists`, `data_exit_lists`, `data_plate_lists`), `data_lair_records`, `data_lair_formations`, `data_scene_variant_rules`, `data_engine_tables`, `data_scene_asset_lists`, `data_spc_driver`, `data_iris_and_icon_tiles`, `data_menu_palettes_and_groups`, the animation banks (`data_anim_player_unarmed`, `data_anim_player`, `data_anim_weapon_overlay`, `data_anim_palette_cycles`, `data_anim_effects`, `data_anim_magic`) and `data_dictionary`. Data has no instructions: names, block notes and part notes only (no comments, no mnemonics).

## Progress

- [x] Read the conventions, `FM-A11.md`, the consumer notes (lairs, chests, exits, plates, variants, animation, scene loader) and the walkthrough (`enemy-bestiary.md`, `level-up.md`, chapters 1 and 2)
- [x] Names spec `renames/apply-I033_names.json` (285 rows) and `apply-I033b_names.json` (2 renames: `EffectAnims`, `MagicAnims`): dry-run, apply, `extract:lt`, `names --check` (1647 names)
- [x] Blocks specs `edits/I033_blocks.json` (19 renames to snake_case) and `I033b_blocks.json` (2 renames): dry-run, apply, bytes identical; the `WorldMetaPointers` rename dropped (OQ-I033-14)
- [x] Merge spec `edits/I033.json`: 20 block notes and 60 new part notes (In / Out / Clobbers + When / Sees / Why): dry-run, apply, re-applied twice with hedged wording (variant music, Deathtoll HP)
- [x] Merge spec `edits/I033_fixes.json`: one sentence of the `lib_tile_triggers_and_lair_return` block note that said the `LairRecords` part note was not written yet
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 `3148390ed40ce14060b33c1387303a8a77e7a0c1`, 1,081,344 bytes, unchanged), `names --check`, `merge --check` (826 comments, 754 part notes, 78 block notes, 0 errors)
- [x] Questions `questions/I033_questions.md` (15 rows; DISCREPANCY on -1 to -7)
- [x] Results `results/I033_results.md` with the suggested commit message (nothing committed)
