# I017 results: PB3 wave 0, nine fall-through units

Date 2026-11-21. Scope: `placement-audit.md` section 7.1 ("wave 0, the nine fall-through units"), applied with `npm run blocks`. The original ROM was never compared with a rebuilt ROM; the baseline for every comparison is the build before the step (`fdafd6c9`, the I016 gate value).

## Changed in the project

| File | Change |
|------|--------|
| `us/blocks.json` | by `npm run blocks`: nine `merge` operations, each an actor block plus the tail block it falls into (table below). Group, bank and `movable` unchanged (all pinned) |
| `extracted/` | regenerated: 18 files removed, 9 added (703 to 694 files); `?INCLUDE` lines 1,510 to 1,499; cross-file references 3,530 to 3,523 |
| `plans/extracted-audit/edits/I017_blocks_01_wave0_fallthrough.json` | new, applied (dry-run first) |
| `plans/doc-audit/placement/pinned.md` | new: wave 0 section (no cluster failed, all nine stay pinned, with the inbound 2-byte references) and the pins carried from PB1/PB2 |
| `plans/doc-audit/README.md`, `placement/README.md` | gate value and the `pinned.md` row |
| `plans/extracted-audit/questions/I017_questions.md` | `OQ-I017-1` .. `-5`; closes `OQ-I015-1` and `OQ-I016-3`; two rows tagged DISCREPANCY |
| `plans/extracted-audit/results/I017_results.md` | this file |

No names, notes, comments, `transforms.json`, `overrides.json` or docs were changed by hand. The nine absorbed blocks had no block note and no part note (checked in `notes/`), so nothing had to move with `names` or `merge`. `us/transforms.json` and `docs/cop/index.md` show as modified in `git status` from I016, not from this step.

## The nine merges

| New block (descriptive name) | Absorbed | Bank | Rebuilt location (`layout.json`) | Size |
|------------------------------|----------|-----:|---------------------------------:|-----:|
| `gv_fairy_gem_advice_return` | `w0_actor_01AC32` + `w0_shared_01AD1B` | 03 | 118571 | 263 |
| `gw_fairy_gem_return_prompt` | `w1_actor_01E4C3` + `w1_shared_01E4E9` | 03 | 126007 | 77 |
| `gw_player_shift_north` | `w1_actor_01E759` + `w1_shared_01E75C` | 03 | 124905 | 124 |
| `gw_player_shift_south` | `w1_actor_01E7D5` + `w1_shared_01E7D8` | 03 | 125029 | 124 |
| `gw_player_shift_west` | `w1_actor_01E851` + `w1_shared_01E854` | 03 | 123067 | 156 |
| `gw_player_shift_east` | `w1_actor_01E8ED` + `w1_shared_01E8F0` | 03 | 122907 | 160 |
| `se_fairy_gem_return_prompt` | `w2_actor_0FA440` + `w2_shared_0FA46D` | 1F | 1046039 | 84 |
| `ms_fairy_gem_return_prompt` | `w3_actor_021ECE` + `w3_shared_021EFB` | 04 | 159792 | 84 |
| `ll_fairy_gem_return_prompt` | `w4_actor_023DD3` + `w4_shared_023E00` | 04 | 159876 | 84 |

Names state what the code does and use the walkthrough's term where the ROM text supports it: "Fairy Gem" (walkthrough chapters 02, 03, 05, 06; the text is "I am watching over the world ... received EXP!" followed by "Would you like to return to <hub>?" with a Stay / Go back choice, FM-A8 D05) and `player_shift` (`COP [2F]` moves the player by 2 pixels per frame in one direction). The first actor of each Fairy Gem pair gives EXP, sets a flag with `COP [09]` and falls into the prompt; later contacts jump to the prompt through `COP [07]`. The role of the four shift actors is not known (`OQ-I017-3`); the Grass Valley gem actor was not located on screen (`OQ-I017-4`).

## Findings

- **All nine pairs passed every constraint**; nothing is listed as "not merged" in `placement/pinned.md`. All nine blocks stay `movable`-less because other files reach their labels by 2-byte `COP [07]`, `COP [27]` or `COP [12]` operands and `BRL`.
- **The baseline ran the shift actors wrong; the merge fixes it** (`OQ-I015-1`, closed). Before: shims executed 318 to 392 times in 500 frames, tails never. After: slot `$0DC0` runs `gw_player_shift_north`'s shim at frame 3825 and 3859, and the tail in the same frame at 3859.
- **Boss scene jump works** with arrival values written alongside `$0318` (`OQ-I016-3`, closed).
- **`COP [AD]` semantics confirmed at run time**: while the actor is in view it re-runs the command every 9 frames; when it is not, the byte is skipped and the next instruction (the tail) runs.
- **Two walkthrough versus ROM wording differences** in the return prompts: "Seabed Palace" against "Seabed Sanctuary", and "the location of the Mountain of Souls" against "Soul of Mountain House" (`OQ-I017-1`, `-2`). Grass Valley, GreenWood and Dr. Leo's Laboratory agree.
- **The verifier still cannot see fall-through** (`OQ-I017-5`, was `OQ-I015-9`).

## Builds

| Build | SHA-1 | Meaning |
|-------|-------|---------|
| baseline (Mesen2 slot `b3`) | `fdafd6c9ddf6b153ad74c6ad8bd8fc2a20991de3` | end of I016 |
| wave 0 (Mesen2 slot `w0`) | `b6087e4dc69caf327190e405ab0948729183b381` | nine merges: **the new gate value** (1,081,344 bytes, checksum 110135380). The dry-run SHA-1 was identical |

## Gate

| Check | Result |
|-------|--------|
| `npm run extract:lt` | OK (fresh before the spec and again at the end; 694 files, 0 stale left) |
| `npm run rebuild` | OK, SHA-1 `b6087e4dc69caf327190e405ab0948729183b381`, 1,081,344 bytes (a change from `fdafd6c9` is expected for a regroup) |
| `npm run names -- --check` | OK (111 names) |
| `npm run merge -- --check` | OK: 0 errors, 0 warnings, 0 orphans (0 comments, 26 part notes, 4 block notes, 694 extracted files) |
| Text equivalence (`blocks` verify, scratch extract and rebuild) | 6,047 of 6,047 top-level labels identical, 8,256 labels before and after |
| Undefined references | 0 |
| Bank guarantees | 13,950 two-byte references checked, 0 broken |
| Order inside each merged block | actor part first, tail second; rebuilt bytes checked at the `layout.json` location of each block: `02 AD 08` then `02 A4` for the four shift blocks, `02 09 xx xx` then `02 01` for the five Fairy Gem blocks |
| `npm run audit` | 694 blocks, 6 movable; the one finding is the existing R-2 list (`spc_030000` 1, `data_04F000` 5, `asset_list_028000` 1, `string_lookup_080000` 2), unchanged |

### Mesen2 (slots `b3` = baseline, `w0` = wave 0; temp files in `%TEMP%\blazer-spike`, not in the repository)

| Path | Method | Result |
|------|--------|--------|
| Title, file select, name entry, opening dialogue, Trial Room (3,677 frames) | `compare_runs` of `trial.rec` from power-on, watches `$0314`, `$0316`, `$0318`, `$032E` (words) and `$03E3` (byte) | 0 divergent frames; Trial Room screenshot hash equal to the I016 value |
| Menu | `compare_runs` of `menu.rec` (354 frames: `a` opens the status menu, cursor down/right, `b`, `start` shows the location banner, `a`), watches `$0301`, `$0322`, `$0326`, `$033A`, `$0374` | 0 divergent frames; end screenshot hash `19946759...` in both builds (the location banner "Grass Valley Shrine"). The status menu itself (name, HP 8/8, Next level, weapon, armor, magic, item rows) was seen on `w0` only, during the replay |
| World | scene jumps `$0318 = 0x0501` (Lostside marsh) and `0x0201` (Underground Castle); the first one with exec counters in both builds | both builds load the scene (same screenshot); exec results in `OQ-I015-1` above |
| Boss fight | scene jump `$0318 = 0x0306`, arrival `$037C = $0080`, `$037E = $00A0`; state saved in both builds; `compare_runs` of `boss_fight.rec` (538 frames, watches `$0301`, `$0374`, `$0376`, `$033A`, `$0808`) | 0 divergent frames; the fight ends in the game-over return to the Trial Room in both |
| Changed code | logged exec hits on shim and tail of the four shift blocks (500 frames) | see Findings |

Limits: the five Fairy Gem pairs were verified statically (bytes and 2-byte reference closure) and by the shared engine paths; no gem could be reached in the run (`OQ-I017-4`). Screenshot hashes of two runs of the same ROM are not a valid comparator after a scene change (random power-on RAM), so counts and watches were used there.

## Suggested commit message

```
PB3 wave 0: merge nine fall-through units (I017)

Merge each actor that ends in COP [09] / COP [AD] and falls into the next
file with that file (blocks.json, npm run blocks): gv_fairy_gem_advice_return,
gw_fairy_gem_return_prompt, gw_player_shift_{north,south,west,east},
se/ms/ll_fairy_gem_return_prompt. All pinned (2-byte COP operands from other
files). The rebuilt layout had separated every pair, so the shift actors
re-ran their shim every frame and never reached their body; Mesen2 now
shows the tail running in the same frame. Text identical for 6,047 labels,
0 undefined references, boss/menu/title-to-Trial-Room compare_runs
identical. Rebuilt SHA-1 fdafd6c9 -> b6087e4d (expected for a regroup).
Adds placement/pinned.md, I017 spec, questions (two walkthrough
DISCREPANCY rows) and results.
```

Please commit when you're ready.
