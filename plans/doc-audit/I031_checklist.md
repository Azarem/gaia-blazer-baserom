# I031 checklist (PC annotate A9, library `0270`-`0279`)

## Progress

- [x] Read the conventions, `FM-A9.md`, the 13 extracted A9 files end to end and the callers of every routine
- [x] Verify by code and `rg`: save layout and checksum, transition ladders and iris arithmetic, tile type mask, BCD drains and caps, pause flow, `InitFixedState` / `InitSceneState` order, `Cop3C` uses (23, all `#04`), hazard call sites against the walkthrough items
- [x] Names spec `renames/apply-I031_names.json` (98 rows): dry-run, apply, `extract:lt`, `names --check`
- [x] Mnemonics (evidence exists): `wave_amplitude`, `wave_request`, `wave_phase_step`, `iris_frame`, `iris_step`, `reload_menu_gfx`, `player_exp+2`, `player_exp_next+2`, `saved_scene`; SHA-1 unchanged
- [x] Merge spec `edits/I031.json`: 13 block notes, 36 part notes, 84 comments with `expect`: dry-run, apply (twice, the second for the transition-type usage)
- [x] `docs/wram-memory-map.md`: EXP rows corrected, `saved_scene`, section 7i, section 8 list
- [x] Gate: `extract:lt`, `rebuild` (SHA-1 unchanged), `names --check`, `merge --check`
- [x] Questions `OQ-I031-1` to `-6` (DISCREPANCY: `-4`, corrected in the docs)
- [x] Results `results/I031_results.md` with the suggested commit message (nothing committed)
- [x] No actor in the batch, so the light actor depth was not needed
