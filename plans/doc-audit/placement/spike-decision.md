# PB2 spike decision: R-2 and the regroup spike (I016)

Date 2026-11-21. Builds are compared by behaviour in Mesen2 and by asm text per label; the original ROM is never compared with a rebuilt ROM.

## Decision

**GO, with three conditions.** Regrouping with `npm run blocks` works and is safe for blocks that are bank-agnostic. A regroup changes the ROM bytes (the packer orders by size), so the text check is the gate and Mesen2 confirms behaviour.

1. **`meta_tables_008000` may move inside bank 1 only.** It is now pinned with `set movable:false` (the block is placed in the bank of its start, bank 01; the position inside the bank is still the packer's choice). Never mark it movable again.
2. **A block may become `movable` only when nothing reaches it by a 2-byte reference** and nothing under it relies on its bank (DBR-relative reads, fall-through, `$&` closures). The verifier checks the first part; the rest is the audit's classes (placement-audit section 4).
3. **Every regroup is followed by a Mesen2 run** over the recorded path (`compare_runs` with few watches) and a count check on the touched routine.

## R-2: the bank-base idiom

### Two kinds of `$&meta_tables_008000` read

| Kind | Sites | DBR | Meaning | May the table move? |
|------|-------|-----|---------|---------------------|
| Base-relative meta read (`LDA $&meta_tables_008000+N, X/Y`) | 34 (`engine_000000`, `engine_0026F3`, `engine_0029EC`, `engine_003005`, `lib_0118FC`, `common_actor_0FB0F5`) | `$01` (actor code runs with DBR `$81`/`$01`) | `X`/`Y` hold an offset from the table base (`$03B0 = list pointer - base`, plus `type * 14`); the 16-bit address only works while the table is in bank 1 | inside bank 1 yes, to another bank no |
| False reference (`lib_01065B` line 18, `LDA $&meta_tables_008000, Y`) | 1 | `$24,X` of the actor (animation data bank) | the original code is `LDA $8000, Y`, the first word of the animation pointer table in the actor's data bank; the extractor mistook `$8000` for the label | n/a, the label was wrong |

### Runtime evidence (Mesen2, slots b0 / b1 / b3, same recorded input)

Recorded path `trial.rec` (3,677 frames: title, file select, name entry, the opening dialogue, walk into the Trial Room). All builds show the same screenshot hash (`2767aaee...`) at frame 3677. Then `$0318 = 0x0101` (Grass Valley) and 600 frames:

| Build | `Cop94` JSL (counted) | `lib_01065B` entries | NMI | Result |
|-------|------------------------|----------------------|-----|--------|
| B0 (`65ff27aa`, baseline, false reference) | 65,536+ (counter saturated) | 65,536+ | 159 | the animation tick spins (both hooks report exactly 65,536, presumably the hook's 16-bit limit), NMIs drop to 159, the HP bar is empty; an earlier B0 run went to a black screen with NMI stalled |
| B1 (`f20dcbdf`, literal `$8000` by `transforms.json`) | 522 | 522 | 463 | normal Grass Valley |
| B3 (`fdafd6c9`, spike) | not counted | 522 (at its new address `00:FDBA`) | 463 | same as B1 |

At the halt in B0 the correct word was `0xB155` and the rebuilt read returned `0x3576` (`0D:E490 + Y` instead of `0D:8000 + Y`): the baseline ROM rebuilt by this project had a real bug, hidden in the walkthrough path because Grass Valley is not on the recorded route. `OQ-I015-4` is answered: the transform works and `meta_tables_008000` stays where the packer puts it.

Traces on B1 (300 and 400 frames in Grass Valley and after the scene change):

| Trace | Result |
|-------|--------|
| Exec log at the `LDA $8000, Y` (`02:E956`) | 349 hits, all DBR `$0D` (`table_068000`, which `layout.json` places at the start of bank `$0D`) |
| Read log over the table (`01:E490-01:FE43`), after a scene change | 81 reads, all DBR `$01`, from 20 distinct engine PCs (`00:92E9`, `00:93F6`-`00:941F`, `00:94xx`, `00:C44A`-`00:C4DF`, `00:8ECB`), addresses `01:E490`-`01:E713`: all base-relative, none from `lib_animation` |
| Same read log in steady state (300 frames, no spawns) | 0 reads: the table is read when actors spawn |

### Why pin it

The verifier cannot see this dependence. The 34 reads are 2-byte references from bank 0 and bank 2 to a block in bank 1 whose `DBR=$01` is set at run time, so the bank guarantee check does not cover them (it only covers same-file and same-pin references). `meta_tables_008000` was `movable: true` before I016 and only stayed in bank 1 because the packer's gap fill put it at the end of bank 1. Pinning removes the dependence on luck at no cost (the pin changes bytes, no label text: 6,047 of 6,047 labels identical).

## The spike

| Step | Spec (written once) | Result |
|------|---------------------|--------|
| R-2 fix | `us/transforms.json` rule on `lib_01065B` (not a `blocks` operation) | B1, only the two operand bytes change (`B9 00 80`) |
| Pin | `I016_blocks_01_pin_meta_tables.json` (`set movable:false`) | B2 `6224eaf9`, text 6,047 identical, 0 broken banks; `meta_tables_008000` now `?BANK 01` at `01:B481` |
| Cluster regroup | `I016_blocks_02_spike_lib_animation.json` (`merge lib_01065B + lib_0106CD into lib_animation`, `movable: true`) | B3 `fdafd6c9`, text 6,047 identical, 0 undefined, 0 broken banks, `?INCLUDE` 1,514 to 1,510, the transform rule moved to the new key, `docs/cop/index.md` mentions rewritten (then fixed by hand to name the two labels), `lib_animation` placed by the packer at `00:FDBA` (150 bytes, was `02:E946`, bank 2 to bank 0) |
| Fallback proof | `I016_blocks_03_fallback_cop_animation.json` (dry-run only) | 4 pinned handlers into `cop_animation`: text 6,047 identical, 0 broken banks, SHA-1 `0c8748f6...`; not applied |
| Neutrality probe | `I016_blocks_04_neutrality_probe.json` (dry-run only) | `set group` and `set scene` leave the SHA-1 identical (`OQ-I015-3` answered); `set movable` changes bytes |

Cluster choice: `lib_01065B` and `lib_0106CD` (150 bytes) have only long inbound references (`JSL $@` from four COP handlers), no `&` reference in and, after the transform, none out. `lib_0106CD` runs the RAM stub at `$1C5C`, which does not depend on its own bank.

### Mesen2 comparison, B1 against B3 (spike)

- `compare_runs` over the 3,677 recorded frames with five watches (`$0314`, `$0316`, `$0318`, `$032E` as words, `$03E3` as a byte): **identical, 0 divergent frames**.
- Bytes at `00:FDBA` read back `08 8B E2 20 BD 24 00 48 AB C2 20 BD 1E 00 0A A8 B9 00 80 ...`.
- After the jump to Grass Valley and 600 frames: `lib_animation` entered 522 times and 463 NMIs, equal to B1; CPU registers at the stop (A, X, Y, flags, DBR) are equal, only PC is relocated.
- Screenshot hashes after a scene jump are **not** a valid comparator: two runs of the same B1 ROM gave different hashes (`979b27ab...`, `c362b5a6...`) because Mesen2 randomises power-on RAM; the images are visually the same apart from fog position. Compare counts, registers and watches instead, and keep watches few (232 watches timed out earlier).

### Not covered by the spike

- Nine actors that fall through a file boundary (`OQ-I015-1`) and the other pin classes of the placement audit were not touched by this cluster. A regroup that moves a fall-through file must be checked separately.
- Eight 2-byte references to `spc_030000`, `data_04F000`, `asset_list_028000` and `string_lookup_080000` (all movable blocks) remain R-2 hazards (`OQ-I016-2`).
- Only one cluster and only the Up Above, Trial Room and Grass Valley paths were run. Larger waves need a second path (menu, boss scene, SPC upload).
- A jump to `$0318 = 0x0306` (boss scene) on B1 returned to the Trial Room (a dialogue appeared) instead of loading the scene; the scene change needs more state than the write. Not a spike regression (B0 and B1 share the state), but it means the boss scene is not covered.

## Fallback (if a later wave is a no-go)

File-level grouping without `movable`: merge related blocks into **multi-part blocks that stay pinned** (the `cop_animation` dry-run is the pattern), and use `set order` to place the parts inside the bank file. Pinned blocks keep their bank, so there is no bank risk, and `rename`, `set scene`, `set group` and `set order` are byte-neutral or text-neutral. This gives one file per subsystem and bank with the same text per label; it gives up only the packer's gap filling. It is also the only option for COP handlers (a 2-byte `&` COP table and `BRL` into the bank-0 exit chain), for blocks with `$&` closures, and for anything read with DBR-relative addresses.

## Tool gaps found

1. `blocks-verify` cannot see DBR-relative reads from other banks (the 34 meta table reads); `audit` lists them only as R-2 findings. Candidate: refuse `movable: true` on a block with any cross-bank 2-byte reference that is not a pointer table entry (`OQ-I016-1`).
2. The merge rewrites mentions of absorbed block names in prose, which blurs a sentence that named two blocks (`docs/cop/index.md`); labels are not touched. Fix the prose by hand afterwards.
3. `us/transforms.json` keeps a stale `chunk_000000` key (empty list); the tool tolerates it.
