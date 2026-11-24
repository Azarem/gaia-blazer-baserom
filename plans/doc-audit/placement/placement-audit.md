# Placement audit (PB1, iteration I015)

Static audit of where every block of `us/blocks.json` should live, which cross-file calls a merge removes, what pins a block to its bank, and whether the `common` group and the world groups agree with the spawn tables. Nothing in the project was changed: every merge below is a proposal, written as an `npm run blocks` outline, and none was applied.

Sources: a fresh `npm run extract:lt`, `npm run audit -- --json` (704 blocks, 789 parts, 11 groups, 67,746 lines, 3,531 cross-file references in 1,514 file pairs), the function maps FM-A1 .. FM-A11, `plans/doc-audit/walkthrough-crosswalk.md`, `rebuilt/layout.json` (read for block adjacency only, never compared with the original ROM), `us/config.json`, `us/labels.json`, `us/rewrites.json`, `us/overrides.json`, the meta lists, the placement lists (`table_0099B4`) and the lair records (`data_00BA0D`). Scratch analysis scripts lived outside the repository; no script touches names, notes, comments or `blocks.json`.

Conventions: `{n}` is the decimal file offset printed by `extract:lt`; a label suffix is the file offset in hex; LoROM bank = offset >> 15. `ref` means one cross-file reference (short `$&`, long `$@`, bank `^`, or a 16-bit `BRL`). World numbers `w0`..`w6` and area keys (`a00` up_above .. `a15` deathtolls_shrine) are those of the crosswalk and `us/groups.json`.

## 0. Findings in short

1. **Nine actors fall through a file boundary, and the rebuilt layout does not keep them adjacent.** `COP [09]` (set or clear an event flag) and `COP [AD]` (yield while on screen) both continue with the next instruction, and nine actor files end with one of them: `w0_actor_01AC32`, `w1_actor_01E4C3`, `w1_actor_01E759`, `w1_actor_01E7D5`, `w1_actor_01E851`, `w1_actor_01E8ED`, `w2_actor_0FA440`, `w3_actor_021ECE`, `w4_actor_023DD3`. In the original they run on into `w0_shared_01AD1B`, `w1_shared_01E4E9`, `w1_shared_01E75C`, `w1_shared_01E7D8`, `w1_shared_01E854`, `w1_shared_01E8F0`, `w2_shared_0FA46D`, `w3_shared_021EFB` and `w4_shared_023E00`. `rebuilt/layout.json` places each pair apart (for example `w1_actor_01E759` at 126768 and `w1_shared_01E75C` at 124860), and the four three-byte `COP [AD]` files of GreenWood sit back to back, so `w1_actor_01E759` runs into the next `COP [AD]` and then into an `RTL`. The audit counts references, so it cannot see this. Section 4.7 and `OQ-I015-1` (a Mesen2 check); the fix is a merge of each pair, wave 0 in section 7.
2. **`common` is not common.** Of its 125 blocks only 7 are used by more than one world (the four `common_actor_001A28` pieces of the player, `common_actor_0029E8`, the save point `common_actor_00766C`, and `common_actor_004659_part1`). 116 are single-world, 2 are unreachable 3-byte stubs. The 83 enemy files in bank `$1F` and the 8 boss files in bank 0 belong to a world by the meta table (crosswalk sections 3, 8 and 12). Section 5.
3. **The world groups are clean.** Every world-group block that a meta list reaches (the other 30 are parts and helpers, 5.4) is "world-own": only its own world's meta list reaches it. Every placed type index is inside its world's list (97 placement index rows, 913 placement rows).
4. **Area routing exists for 357 of the 376 meta-listed blocks of the world groups plus single-world `common`** (the rest: 14 multi-area, 5 without evidence). Placement rows give the scene; lair records give the area of a monster with the lair location (record byte `+B`), not the home location (`+0`, section 5.2).
5. **Three shared helpers live in a world group and are used by other worlds**: `w0_shared_01B161` (worlds 0 to 5), `w0_actor_0191D2_part3` (w1) and `w3_shared_022289` / `w3_shared_02249A` (worlds 3 to 5). They are the only genuine "common actor helpers"; section 5.4.
6. **632 of the 3,531 cross-file references (253 of 1,514 pairs) are removable by merges that stay inside one bank and one group**: 149 refs in 45 same-bank, same-group single-caller blocks, plus 524 refs inside the proposed (world, area, bank) target files; the two sets overlap. The remaining 2,899 are the shared utilities (1,305 refs into targets with 10 or more calling files), table and string reads that cannot cross a bank, and engine and library calls. Section 3.
7. **Every bank is full**. Banks 0, 2, 3, 4 and 31 have 29,178 to 31,901 bytes of blocks; bank 1 has 32,324 (rebuilt layout: 1 to 84 bytes free per bank). A merge must therefore be size-neutral and bank-local; nothing can move between banks.
8. **`npm run blocks` cannot split a part**. `engine_000000` is seven parts, and the largest (`native_mode_irq_0005A5`, 1445 to 4783, 3,338 bytes) holds the IRQ stub, the scheduler, the sprite builder, combat, collision and part of spawn. Section 6.1 uses only the existing part boundaries; a `split-part` operation is a tool extension (`OQ-I015-8`).

## 1. Capacity and structure

| Fact | Value |
|------|-------|
| Blocks / parts / groups | 704 / 789 / 11 |
| `scene` set on a block | 0 (all null; the folder under a group is `extracted/<group>/<scene>/`, see `PATH_PART` in `src/blocks-edit.ts`) |
| `movable` blocks | 6: `meta_tables_008000`, `asset_list_028000`, `spc_030000`, `data_048000`, `data_04F000`, `string_lookup_080000` |
| Code parts checked for fall-through | 635 |

Blocks per group (bytes of ROM): common 125 (38,340), cop_handlers 110 (3,734), library 139 (33,055), system 36 (90,481), grass_valley 52 (14,733), greenwood 57 (12,990), st_elles 54 (10,825), mountain_of_souls 42 (9,507), leos_lab 37 (6,789), magridds_castle 45 (12,604), world_of_evil 7 (1,455). Lines: common 18,420, cop_handlers 2,918, library 13,161, system 16,699, grass_valley 2,952, greenwood 3,340, st_elles 2,994, mountain_of_souls 2,589, leos_lab 1,747, magridds_castle 2,333, world_of_evil 593.

Bytes of blocks per bank (source bank = offset >> 15):

| Bank | Blocks | Bytes | Content |
|------|-------:|------:|---------|
| 0 | 166 | 31,319 | engine, COP handlers, player, bosses, front-end and boot actors, shared helpers |
| 1 | 9 | 32,324 | `meta_tables_008000`, `table_0099B4`, `table_00A9DE`, `table_00AC96`, `table_00B69A`, `data_00BA0D`, `data_00EE8E`, `data_00F99A`, `data_00F9F7` |
| 2 | 114 | 30,512 | library code and strings (`lib_01xxxx`) |
| 3 | 116 | 29,178 | world 0, 1 and 6 actors |
| 4 | 149 | 31,443 | world 3, 4 and 5 actors, `lib_027xxx` |
| 5, 6 | 1, 1 | 4,098, 1,807 | `asset_list_028000`, `spc_030000` |
| 9 | 2 | 4,000 | `data_048000`, `data_04F000` |
| 10 to 15 | 1 each | 3,272 .. 14,336 | `table_050000` .. `table_078000` |
| 16 | 1 | 1,536 | `string_lookup_080000` |
| 31 | 139 | 31,901 | world 2 actors, the 83 enemy files, SPC upload `common_shared_0FEEA6` |

The packer places files per bank, largest first (`rebuilt/layout.json`: `engine_000000`, `common_actor_0033C6`, `common_actor_001A28_part1`, ... in descending size), so a merge changes the order inside a bank and therefore the ROM bytes and SHA-1. The packer does not honour the order of the source file, which is why section 4.7 matters.

## 2. Method for the target layout

Target files are sized at about 200 to 1,500 lines (`placement/README.md`). The rules used:

- A target file is a union of **whole blocks of one group and one bank** (`merge` refuses a block spanning two banks and refuses two groups). Parts are the finest unit `npm run blocks` can move (`move-part`); a split inside a part needs the extension of `OQ-I015-8`.
- A file stays whole when its fan-in is high and its callers are in many files (section 3.4): merging it would pull a shared utility into one caller's file.
- Strings stay in bank 2 whatever calls them (4.2). Data tables stay in their bank (4.3).
- Names follow the crosswalk section 12 convention (`gv`, `gw`, `se`, `ms`, `ll`, `mc`, `we`); a block name is a new identifier that must not collide with a label. The file offset stays in the label, so no name is proposed that hides an address.

## 3. Cross-file call analysis

### 3.1 Reference forms (3,531 refs, 1,514 file pairs)

| Form | Refs | Meaning |
|------|-----:|---------|
| short `$&` | 1,530 | 2 bytes, bank of the referrer |
| long `$@` | 1,718 | 3 bytes |
| bank `^` | 77 | bank byte of a label |
| rel (branch) | 206 | **all 205 cross-file branches are 16-bit `BRL`** (qualified `BRL file.label`); no 8-bit branch crosses a file |

Same-bank pairs: 669 (1,692 refs). Cross-bank pairs: 845 (1,839 refs). 622 pairs carry short refs; 140 of those pairs (287 refs) cross a bank, which is only legal for data read with the right DBR (4.2, 4.3) or the string COPs (4.2). `BRL` reaches the whole bank, so branch distance is not a placement constraint; the constraint is that the target is in the same bank.

### 3.2 Group matrix (refs from row to column)

The largest cells of `npm run audit` (from, to, refs): system to system 577, common to system 309, system to common 230, library to system 197, cop_handlers to cop_handlers 151, common to library 107. Each world group mostly refers to itself (grass_valley 141, greenwood 130, st_elles 104, magridds_castle 110, mountain_of_souls 94, leos_lab 69, world_of_evil 3), then to `system` (22 to 48) and little to `library` (3 to 11); `system` refers to the world groups (6 to 54 each, the meta table). `cop_handlers` refers to `system` 42 and `library` 35. `library` refers to itself 414 and to `system` 197.

Cross-world references: greenwood to grass_valley 20, magridds_castle to mountain_of_souls 11, leos_lab to mountain_of_souls 6, st_elles to grass_valley 4, leos_lab to grass_valley 3, magridds_castle to grass_valley 2, mountain_of_souls to grass_valley 2. All of them point at the shared helpers of 5.4.

### 3.3 Fan-in of the shared utilities (they stay shared)

| File | Refs | From files | Note |
|------|-----:|-----------:|------|
| `engine_0026F3` | 567 | 138 | the actor-spawn and lair entry (`code_0026F3` 156, `code_00299D` 150 from 137 files) |
| `engine_routines_001D3B` | 273 | 1 | all from the player (`common_actor_001A28_part1`); a mutual pair, 3.5 |
| `cop_handler_006473` | 140 | 102 | the COP exit chain; 124 `BRL` pairs |
| `w0_shared_01B988` | 106 | 35 | string `asciistring_01B988` (worlds 0 and 1) |
| `w1_` to `w5_shared_*` string files | 60 to 100 each | | one per world (`w1_shared_01E4E9` etc.) |
| `lib_shared_012769` | 82 | 18 | text renderer |
| `lib_shared_014F74` | 73 | 4 | item names |
| `data_00BA0D` | 71 | 10 | lair records |
| `table_068000` | 69 | 1 | animation data of the player |
| `common_actor_0029E8` | 65 | via `meta_tables_008000` | pickup and container base actor |
| `engine_003005` | 61 | 34 | return-address helper (4.5) |
| `meta_tables_008000` | 41 | 7 | 4.3 |
| `lib_027462_part1` | 40 | 23 | |
| `lib_shared_0131B7` | 39 | 9 | |
| `lib_027781_part2` | 28 | 4 | |

1,305 refs go to targets with 10 or more calling files. A merge cannot remove those without duplicating the target; they are the shared surface of the program.

### 3.4 Single-caller analysis (683 non-table code blocks)

| Class | Blocks | Note |
|-------|-------:|------|
| no code caller (reached only from a table or a meta list) | 492 | actor entries, COP table, `code_list_001B2B`, vectors |
| single caller | 110 | below |
| several callers | 81 | stay separate |

The 110 single-caller blocks:

| Position | Blocks | Refs | Verdict |
|----------|-------:|-----:|---------|
| same bank, same group | 45 | 149 | **merge** (7.2) |
| same bank, different group | 2 | 305 | the `common_actor_001A28_part1` / `engine_routines_001D3B` pair (32 and 273 refs); merge after the player moves to the system group, or keep together (6.3) |
| different bank, different group | 52 | | mostly bank-2 strings called from one actor or one engine file; **cannot merge** (4.2) |
| different bank, same group | 11 | | library blocks in bank 2 called from bank 4; cannot merge |

The 45 (blocks, caller, refs): common 6 (`001A28_part2` and `_part4` into `_part1` 2 and 1 refs, `_part3` into `_part2` 7, `005043_part2` 1, `006E28_part2` 2, `00729D_part2` 4); cop_handlers 4 (`005867_part2`, `0059F4_part2`, `0058A9` into `005C81`, `005EEE` into `005CD6`; 1 ref each); grass_valley 5 (12 refs); greenwood 6 (11 refs); library 20 (78 refs); magridds_castle 1 (`w5_actor_025E61_part2`, 18 refs); system 2 (`engine_005354` into `engine_0029EC` 2 refs, `engine_routines_002678` into `engine_routines_001D3B` 4); world_of_evil 1 (3 refs). Total 149 refs.

Strings by caller (the single callers that own several strings): `common_actor_0066FC` 16, `common_actor_00729D` 7, `common_actor_00766C` 3, `common_actor_0066C6` 2, `common_actor_001A28_part4` 2, `engine_006B7F` 4; `engine_000000` calls 11 library helpers (not strings).

### 3.5 What the cross-file branches say

- 124 pairs: every COP handler `BRL`s into the exit chain `cop_handler_006473` (`loc_0064B5` .. `loc_0064C9`). The chain is shared; keep it in its own file, bank 0.
- 32 `BRL` sites from the `common_actor_001A28_part1` handlers into `engine_routines_001D3B` (`loc_001A65`).
- Worlds: `w1_actor_01E510/01E540/01E594` to `w1_shared_01E4E9`; `w2_actor_0FA494/0FA4C4/0FA4F4` to `w2_shared_0FA46D`; `w3_actor_021F22` to `w3_shared_021EFB`; `w4_actor_023E27/023E57` to `w4_shared_023E00`; `w5_actor_026E9D` to `w5_shared_026DF2`; `w0_actor_01A3B0_part2` and `w0_actor_01ADF8` to `w0_shared_01AD1B`. Each `*_shared_` file is the tail that the actors in front of it fall into or branch to, so the shared file is the join point of a family of actors; the family should sit in one file.
- `common_actor_001A28_part2` to `part3` (`code_0026E7`); `common_actor_0066FC` to `engine_006B7F.loc_006CC1`; `engine_0029EC` to `cop_handler_005CF0_part1.loc_002D40`.

## 4. Per-block pin constraints

A pin is something that makes a move or a merge unsafe, or fixes a bank. Classes, then the blocks.

### 4.1 Vectors and tables of handlers (bank 0, non-movable)

`us/config.json`: `nativeCop = native_mode_cop_00561E` (block `engine_00561E`), `nativeBrk = native_mode_brk_0055FC`, `nativeNmi = native_mode_nmi_000342` and `nativeIrq = native_mode_irq_0005A5` (both in `engine_000000`), `emulationReset = emulation_mode_reset_000000`. The COP table (`code_list_005638`, `code_list_005738`) holds `&Code` words, so all 110 COP handlers and the 28 pose handlers of `code_list_001B2B` stay in bank 0 with their tables.

### 4.2 Strings (bank 2 and DBR `$02`)

The ASCII-string COPs read their operand through the data bank register; the renderer forces DBR `$02`, so every string that a COP names must be in bank 2. The audit lists 27 expected warnings for cross-bank short references of this kind. Pinned: the 46 `ASCIIString` blocks of the library (4,701 bytes, 252 lines in all, e.g. `lib_013B27` .. `lib_014F5B`, `lib_0124EE_part2`, `lib_0118FC_part11`, `lib_016264` 1,597), `&ASCIIString` tables `lib_014536_part2` (1,856), `lib_shared_014F74` (882), `lib_010EA9_part2` (600), and `lib_0118FC_part13` (3,216). Merging strings among themselves is free (same bank); moving one out is impossible.

### 4.3 Data read with a bank assumption (bank 1, 5, 6, 9, 16)

| Block | Bank | Why it is pinned |
|-------|-----:|------------------|
| `meta_tables_008000` | 1 | movable; real reads in `engine_000000`, `engine_0026F3`, `engine_003005`, `engine_0029EC`, `lib_0118FC`, `common_actor_0FB0F5` use the base-subtract pair `SBC #$&meta_tables_008000` with `$03B0` and DBR `$01`: relocation-safe only while the block stays in bank 1 and contiguous |
| `table_0099B4`, `data_00BA0D`, `table_00A9DE`, `table_00AC96`, `table_00B69A`, `data_00EE8E`, `data_00F99A`, `data_00F9F7` | 1 | read through DBR `$01` or with long pointers into bank `$01` (`dp$29-$2B`) |
| `asset_list_028000` | 5 | `$5` selector in `us/labels.json` |
| `spc_030000` | 6 | `$6` selector |
| `data_048000`, `data_04F000` | 9 | `$9` selector (6 uses) |
| `string_lookup_080000` | 16 | |
| `table_050000` .. `table_078000` | 10 to 15 | long reads, one block per bank |

`us/labels.json` has 276 entries: 95 `^LABEL` bank-byte hints, 60 empty `""`, about 120 bank selectors (`$0` 34, `$2` 64, `$1` 12, `$9` 6, `$5`, `$6`, `$A`, `$B` one each) and one `*04F200`. They are operand transforms that force bank resolution, so they pin the targets to banks 0, 1, 2, 5, 6 and 9.

**R-2 (movable-block 2-byte references)**: `meta_tables_008000` 35, `data_04F000` 5, `string_lookup_080000` 2, `spc_030000` 1, `asset_list_028000` 1. The reads above are fine. **`lib_01065B:18 LDA $&meta_tables_008000, Y` is a false reference.** It reads `$8000` under DBR `$24` (an animation bank pointer table) and the rebuild resolves it to about `$E490` in bank 1. It needs a literal `$8000` through `transforms.json` (OQ-I008-3); until then `meta_tables_008000` is effectively not relocatable and its bank must not be treated as a free choice. `OQ-I015-4`.

### 4.4 Decode overrides and rewrites

`us/overrides.json` (15 entries): `engine_000000` (517 M=1, 797 M=1), `engine_006B7F` (27856, 27982 M=0), `lib_0106CD` (67277 M=1; FM-A9 says this is an anomaly to fix), `lib_0109D6`, `lib_0112F5`, `lib_0133A6_part1`, `lib_011695`, `lib_0118FC`, `lib_012281`, `lib_0133A6_part3` (B=1, twice), `lib_027462_part1` (X=0), `lib_027462` (M=0). They are keyed by address, so a regroup never breaks them; they pin only the part that holds the address. Missing overrides found by FM-A5 (71774, 65803) go with step PC.

`us/rewrites.json` (7 entries, offset to offset +1 or -1: the return-address idioms): `cop_handler_005CF0_part1`, `engine_003005`, `common_actor_005043`, `w0_shared_01B161`, `w0_shared_01B988`, `w3_actor_02220D`, `w2_actor_0FA874`. A merge that changes the size of a block must be checked against these entries.

### 4.5 Return-address idiom (`LDA #$&label-1`, `PHA`, `RTS`)

The target of the idiom must be in the bank of the routine that executes the `RTS`. Shared targets and their users: `engine_003005.code_00305F-1` (about 11 callers in worlds 0, 1, 5), `w0_shared_01B161.code_01B17C-1` (w0 and w1 actors, 21 callers, worlds 0 to 5), `w3_shared_022289.code_022289-1` (worlds 3, 4, 5), `common_actor_004659_part1.code_002D67-1` (`004659` and 7 bank-31 actors, worlds 0, 1, 3, 5, 6). All four targets are pinned to the bank they are in today; the `blocks` verification (2-byte guarantee, 0 undefined refs) covers them.

### 4.6 Bank clusters (`$&` closure)

Any `$&` reference needs both ends in one bank. Clusters that are larger than one file:

- Player: `common_actor_001A28_part1..part4` + `engine_routines_001D3B` + `engine_routines_002678` + 28 pose handlers + `code_list_001B2B`: bank 0. P05, P07, P08 call bank 4 by `JSL`, so they are not bank-bound.
- COP handlers: bank 0 (4.1).
- `common_actor_0066FC` to `engine_006B7F.loc_006CC1` (`BRL`): bank 0. `engine_0029EC` to `cop_handler_005CF0_part1.loc_002D40`: bank 0.
- World families: each `*_shared_` tail with its `BRL` actors (3.5): one bank.
- Bank-31 enemies use `&` helpers inside bank 31 (e.g. `common_actor_0FD11B` jumps by `COP [9B]` to its own labels).
- `common_actor_004659_part1` (345 bytes, bank 0) is referenced as `&`/`@` from bank 31 (9 callers); the `@` references allow it, the `&` ones must stay within bank 0 or bank 31 respectively.

### 4.7 Fall-through at a file boundary (new class, F)

The audit and the `blocks` verification look at references. They do not see that the last instruction of a file lets the CPU run on into whatever follows it. A scan of all 635 code parts (last tagged instruction of each part against the terminators `RTS RTL RTI JMP JML BRA BRL STP`) finds 18 parts whose last instruction is not a terminator:

| Part | Last instruction | What follows | Verdict |
|------|------------------|--------------|---------|
| `w0_actor_01AC32` {109847} | `COP [09] ( #$9C02 )` (set a flag) | `w0_shared_01AD1B` | **fall-through** |
| `w1_actor_01E4C3` {124133} | `COP [09] ( #$9C05 )` | `w1_shared_01E4E9` | **fall-through** |
| `w1_actor_01E759`, `01E7D5`, `01E851`, `01E8ED` | `COP [AD] ( #08 )` | `w1_shared_01E75C`, `01E7D8`, `01E854`, `01E8F0` | **fall-through** |
| `w2_actor_0FA440` {1025129} | `COP [09] ( #$9D00 )` | `w2_shared_0FA46D` | **fall-through** |
| `w3_actor_021ECE` {138999} | `COP [09] ( #$9E00 )` | `w3_shared_021EFB` | **fall-through** |
| `w4_actor_023DD3` {146940} | `COP [09] ( #$9D01 )` | `w4_shared_023E00` | **fall-through** |
| `w1_actor_01DDB7`, `01E2FB`, `w2_actor_0F8446`, `w3_actor_020143`, `w4_actor_0229DF`, `023A36` | `COP [27] ( &label )` | data after the instruction (the instruction tag is well before the part end) | jump, no fall-through |
| `common_actor_0FD11B`, `0FD502` | `COP [9B]` (`Cop9B_JumpByPlayerDeltaY`) | next file | jump with three targets, no fall-through |
| `cop_handler_005CF0_part1`, part `code_002CCB` | `COP [1B] ( &code_002CE8, #$0002 )` | next part `code_002CE8` | jump to the next part, safe at the boundary |

Semantics are from FM-A3 (H021 `Cop09_SetOrClearFlag` "continues"; H055 `CopAD_YieldWhileInView`: `$18,X = $38 - 2`, yields, resumes at the same COP, then continues; H051 `Cop9B_JumpByPlayerDeltaY`).

In `rebuilt/layout.json` none of the nine pairs is adjacent (locations of actor and shared file: `w0_actor_01AC32` 120221 / `w0_shared_01AD1B` 126363; `w1_actor_01E4C3` 126441 / `w1_shared_01E4E9` 126402; `w1_actor_01E759` 126768 / `w1_shared_01E75C` 124860; `01E7D5` 126771 / `01E7D8` 124981; `01E851` 126774 / `01E854` 123180; `01E8ED` 126777 / `01E8F0` 122868; `w4_actor_023DD3` 161241 / `w4_shared_023E00` 161369; `w3_actor_021ECE` 161196 / `w3_shared_021EFB` 161330; `w2_actor_0FA440` 1047175 / `w2_shared_0FA46D` 1047304). The rebuilt bytes at the four GreenWood shims read `02 AD 08 02 AD 08 02 AD 08 02 AD 08 6B`: the shim of `w1_actor_01E759` runs three more `COP [AD]` and an `RTL` instead of entering `code_01E75C`. This is static; whether the game misbehaves is `OQ-I015-1` (S, Mesen2). A merge of each pair into one block with the actor first is expected to remove the problem, because the parts of one block are emitted together in `blocks.json` order; this is checked in the PB2 spike, not assumed. At the part level inside `engine_000000` and the other multi-part blocks the scan found no fall-through, so every existing part boundary is a safe split point.

### 4.8 Remaining pins

- Dead code that can move freely (no reference): `engine_000000` parts `code_000205`, `binary_00030D`, `code_00031D` (R05 to R12), `code_027277`, `code_027374`, `common_shared_0FDFC0`, `common_shared_0FE769`, `w0_shared_01A4F9`, `w5_shared_02623C`, `code_006BA5`, `engine_0074B1` (an unreferenced actor script). They are bytes in the ROM, so they cannot be dropped, but they can be gathered into one `*_dead` file in their bank.
- Contiguity rule inside `lib_027781_part1..part3` (FM-A9 L031 to L033: `BRL`/`BMI` to `loc_02787C`, run in order): keep in one block, in order.
- `code_0064CC` (`WriteEventFlag`, sole caller Cop09) belongs next to `engine_0064F8`, `code_006537` (`BlockActorFootprint`) next to `engine_0065A7` (FM-A3); both sit in `cop_handlers` only because of their single caller.
- `cop_handler_005CF0_part1` is the music-load actor chain and `loc_002D40` respawn, not a COP handler (FM-A3 2.13).

## 5. Scene and group audit

### 5.1 Method

Actors are reached from three sources: the per-world meta lists (469 entries of 14 bytes in 7 lists of 95, 81, 87, 68, 55, 62 and 21 entries; the first entry of each is the player); the placement rows (97 index rows in `table_0099B4`, 913 rows of 4 bytes, area and scene); the lair records of `data_00BA0D` (420 records of 32 bytes). Each block was assigned to the world of the list that reaches it and to the areas of the scenes that place it.

### 5.2 Lair records: home location (`+0`) and lair location (`+B`)

170 of the 420 records have a home location different from the lair location; the world is the same in every one. Example: record `02` has `+0 = $01` (Grass Valley highlands) and `+B = $05` (Underground Castle) with monster type `$20` and script `code_0026F3`. FM-A11 section 4.6 reads `+0` as the home location (a being freed by stepping on the lair tile at `+B` appears there) and does not say in which scene the monsters of `+15` (type) are spawned. The area routing below puts the monsters at the **lair location `+B`**, for two reasons: for the other 250 records `+0` equals `+B`, and for the six boss records `+B` equals the crosswalk's boss spawn area while `+0` is a different place (for Metal Mantis `$04`, not the paintings). This is a static reading; `OQ-I015-10` asks for a Mesen2 check. Using `+0` instead moves some actors between the villages and the dungeons of the same world (the area counts of 5.5 change by a few blocks per world, the world of every block does not). The six boss records (script `code_002752`, count 1) also answer the open question OQ-I004-13 statically:

| World | Boss actor | Record | Home | Lair (scene) | Crosswalk spawn area |
|------:|-----------|-------:|-----:|--------------|----------------------|
| 0 | `common_actor_0031AD` | `$09` | `$04` | `$0C` (03/06) | `0C` |
| 1 | `common_actor_0033C6` | `$50` | `$15` | `$22` (04/..) | `22` |
| 2 | `common_actor_003E43` | `$B6` | `$29` | `$32` (06/..) | `32` |
| 3 | `common_actor_004299` | `$103` | `$3D` | `$44` (0A/..) | `44` |
| 4 | `common_actor_004659` | `$12F` | `$53` | `$59` (0D/03) | `59` |
| 5 | `common_actor_004BEE` | `$195` | `$65` | `$72` (10/..) | `72` |

(World 6: the two Deathtoll actors are placed in scenes 15/01 and 15/02.) Lair location equals the crosswalk's spawn area in all six, so crosswalk section 3 and this audit agree; no DISCREPANCY.

### 5.3 The `common` verdict

| Class | Blocks | Bytes | Lines |
|-------|-------:|------:|------:|
| bank 0, several worlds | 7 | 5,113 | 2,652 |
| bank 0, one world | 33 | 12,151 | 5,835 |
| bank 31, one world | 83 | 21,070 | 9,917 |
| bank 31, unreachable (3-byte stubs `common_shared_0FDFC0`, `common_shared_0FE769`) | 2 | 6 | 16 |

The 7 multi-world blocks: `common_actor_001A28_part1..part4` (player, all 7 worlds), `common_actor_0029E8` (generic pickup and container base, 4 bytes, 65 meta refs, all 7 worlds), `common_actor_00766C` (save point, all 7 worlds), `common_actor_004659_part1` (345-byte helper, worlds 0, 1, 3, 4, 5, 6). Everything else is one world's. `common_shared_0FEEA6` (SPC upload, 3,575 bytes, bank 31) is called by the boot actor, `cop_handler_005CF0_part1` and `lib_0133A6_part3`, that is by engine code; its class in the audit is a one-world artefact, so it belongs in `system` (6.2).

Single-world blocks of `common` by world (the crosswalk's enemy rows: `common_actor_0FAA49` .. `0FEEA5` are the bestiary of bank `$1F`):

| World | Bank 0: blocks, bytes, lines | Bank 31: blocks, bytes, lines |
|------:|------------------------------|-------------------------------|
| 0 | 19, 3,286, 1,573 | 12, 1,708, 981 |
| 1 | 1, 2,685, 1,399 | 14, 2,602, 1,358 |
| 2 | 4, 1,086, 566 | 14, 3,088, 1,678 |
| 3 | 1, 960, 441 | 11, 2,886, 1,514 |
| 4 | 1, 1,429, 642 | 11, 3,027, 1,552 |
| 5 | 1, 413, 208 | 14, 3,023, 1,636 |
| 6 | 3, 1,481, 591 | 6, 1,161, 604 |

(The 83rd bank-31 block is `common_shared_0FEEA6`.) Bank-0 blocks are bosses, the boss-room ghosts and the world 0 boot, title and file-select actors, which must stay in bank 0 but can change group:

- World 0, area `00` up_above, 18 blocks and 2,749 bytes: `common_actor_0066C6` (boot, scene `00/0C`), `0066FC` (title, `00/0A`), `00729D` (file select, `00/0B`), `006E28`, `0070B3` .. `007127` (13 small blocks, `00/09`), `00797B` (`00/01`); plus `w0_actor_01A7AC` (`00/08`, Trial Room), `w0_actor_01B33A` and `01B967` (`00/0D`, Lisa and Turbo; crosswalk OQ-I001-6).
- Bosses: `0031AD` (Metal Mantis, w0), `0033C6` (GreenWood statues, 2,685 B), `003E43` (Floating Skull) with the ghost-ship `004102/0041A0/004248` (Purple Worms, scene 09/01), `004299` (Poseidon), `004659` (Tin Doll, 1,429 B), `004BEE` (Demon Falcon), `004D8B`, `004F4D`, `005043` (Deathtoll; scenes 15/01 and 15/02).

### 5.4 World groups against the spawn tables

The world-group blocks that a meta list reaches are reached only by their own world's list (294 world-group blocks; 30 of them are parts and helpers that no list names). Unused meta entries (a type in a list that no placement and no lair uses): world 0 type `$09`; world 1 types `$34`, `$36`, `$3B`, `$3E`; world 2 types `$14`, `$25`, `$27`, `$33`; worlds 3 to 6 none. Unreached helpers: `w0_shared_01A4F9`, `w5_shared_02623C`, `common_shared_0FDFC0`, `common_shared_0FE769`. Four meta entries point at library code: `lib_0116C3` (the soul effect actor) in worlds 1 (type `$2A`), 2 (`$56`), 4 (`$2A`) and 5 (`$04`); library code is therefore an actor script (`OQ-I015-5`). Fifteen lair records with home location `$63` have no scene (type `$FF`, count 1): inert placeholders (`OQ-I015-6`).

World-group blocks that no list reaches (parts and shared helpers): grass_valley 10, greenwood 7, leos_lab 2, magridds_castle 4, mountain_of_souls 3, st_elles 3, world_of_evil 1.

**Shared helpers that live in a world group but serve other worlds:**

| Block | Bank | Bytes | Used by |
|-------|-----:|------:|---------|
| `w0_shared_01B161` | 3 | 48 | actors of worlds 0 to 5 (21 callers; `&`/`@` from banks 3, 4, 31) |
| `w0_actor_0191D2_part3` | 3 | 102 | `w1_actor_01D045`, `w1_actor_01D2F3` |
| `w0_shared_01B988` | 3 | | string `asciistring_01B988`, 35 files, worlds 0 and 1 |
| `w3_shared_022289` | 4 | 129 | worlds 3, 4, 5 |
| `w3_shared_02249A` | 4 | 137 | worlds 3, 4, 5 |

They should move to one shared actor-helper group (`actor_shared`, one file per bank: banks 3 and 4 for these, and bank 0 for `common_actor_0029E8`, `common_actor_004659_part1` and the save point `common_actor_00766C` with its string `engine_007A52`). A group move is `set group`; it is a rename of the folder only. Do not merge them into one world's file, because that would turn five users into cross-group callers.

### 5.5 Area routing per world

Single-area means every scene that places the block, plus the lair location of its monster type, lies in one area. Counts are for world-group blocks plus single-world `common` blocks that are in a meta list.

| World | Blocks | Single-area | Multi-area | No evidence | Areas (blocks, bytes) |
|------:|-------:|------------:|-----------:|------------:|-----------------------|
| 0 | 73 | 70 | 3 | 0 | `01` grass_valley_village 28 (9,573), `00` up_above 21 (4,997), `02` underground_castle 11 (1,656), `03` leos_paintings 10 (1,743) |
| 1 | 65 | 61 | 0 | 4 | `04` woods_of_greenwood 35 (11,194), `05` lostside_marsh 26 (5,815) |
| 2 | 69 | 67 | 1 | 1 | `06` seabed_sanctuary 30 (7,260), `07` seabed_of_st_elles 18 (3,109), `08` st_elles_coast 13 (2,446), `09` ghost_ship 6 (1,603) |
| 3 | 51 | 41 | 10 | 0 | `0A` soul_of_mountain_house 27 (7,444), `0B` mountain_of_souls_dungeon 10 (1,980), `0C` snow_mountain 4 (939) |
| 4 | 47 | 47 | 0 | 0 | `0D` leos_laboratory 30 (6,320), `0E` laboratory_dungeon 10 (3,293), `0F` town_models 7 (1,476) |
| 5 | 56 | 56 | 0 | 0 | `10` castle_of_magridd 25 (7,026), `13` airship_dock 12 (3,436), `11` castle_dungeon 10 (1,735), `12` castle_towers 9 (1,574) |
| 6 | 15 | 15 | 0 | 0 | `14` evil_world 10 (1,894), `15` deathtolls_shrine 4 (1,652), `00` up_above 1 (546) |

No evidence: `common_actor_0FB680`, `common_actor_0FB6F8`, `w1_actor_01E7D5`, `w1_actor_01E4BB` (w1), `common_actor_0FBB78` (w2). Multi-area: `w0_actor_01B1F7`, `w0_actor_01AFFD`, `common_actor_0FAA49` (w0), `w2_actor_0FA6F5` (w2), the ten w3 enemies and helper `common_actor_0FC72F`, `0FC845`, `0FC8FE`, `0FC9BC`, `0FCA35`, `0FCBDF`, `0FCDBA`, `0FD11B`, `0FD1E5`, `w3_actor_02220D`.

World 0's area `00` is the game's own key for the title, file select, boot and the Up Above scenes (`00/01`, `00/08` to `00/0D`); the crosswalk walkthrough mapping (chapter 01 for `00/08` to `00/0D`, chapter 02 for the rest) agrees with the ROM, so no DISCREPANCY. The name of a folder for the title, boot and file-select actors is a decision (`OQ-I015-7`).

Cross-check with the walkthrough chapter and the ROM (crosswalk sections 1 and 2): worlds and chapter names, the 7 boss actors against their lairs, and the area keys of `us/groups.json` agree for every row above. No placement-specific DISCREPANCY was found; the DISCREPANCY rows of the crosswalk (boss HP 69/79/89/99 against the walkthrough's 70/70/80/90 and others) are unchanged by placement.

## 6. Target file layout

Line counts are those of the current extracted blocks. "Cut" lists the blocks merged into the target (`npm run blocks`, wave in section 7). Every target is one bank, one group.

### 6.1 `system` (engine; bank 0)

Only existing part boundaries are used.

| Target file | Cut | Bytes | Lines | Notes |
|-------------|-----|------:|------:|-------|
| `engine_boot` | `engine_000000` part `emulation_mode_reset_000000` (R01 to R04: reset, main loop, three sub-frame helpers) | 517 | ~295 | vector `emulationReset`; pinned bank 0 |
| `engine_debug_dead` | `engine_000000` parts `code_000205`, `binary_00030D`, `code_00031D` (R05 to R12) | 317 | ~110 | no references; overrides 517 and 797 follow the addresses |
| `engine_nmi` | part `native_mode_nmi_000342` (R13 to R23: NMI, OAM, palette, BG3, scroll, strip and tile DMA, VRAM queue) | 611 | ~330 | vector `nativeNmi` |
| `engine_actor_core` | part `native_mode_irq_0005A5` (R24 to R47: IRQ stub, scheduler, sprite builder, combat, motion and tile collision) | 3,338 | ~1,900 | vector `nativeIrq` is its first byte; split in four with `split-part` (`OQ-I015-8`): `engine_irq` 1 B, scheduler and sprites 1446 to 2612 (1,166 B), combat 2612 to 3880 (1,268 B), collision 3880 to 4783 (903 B) |
| `engine_spawn` | part `code_0012AF` (R48 to R52) + `engine_0026F3` + `engine_0029EC` + `engine_005354` + `engine_002EC0` + `cop_handler_005CF0_part1` | 3,035 | ~1,220 | actor pool, scene spawn, lair and pickup spawn, and the music-load actor chain with the `loc_002D40` respawn that `engine_0029EC` branches to (FM-A3 2.13: not a COP handler); `engine_005354` has one caller (`engine_0029EC`, 2 refs); the `cop_handler_005CF0_part1` rewrite and the `BRL` from `engine_0029EC` become internal |
| `cop_core` | `cop_handler_006473` (exit chain H001 to H009) + `engine_0064F8` + `code_0064CC` + `engine_0065A7` + `code_006537` | ~560 | ~450 | 140 refs from 102 files stay cross-file; the two moved routines have one caller each |
| `cop_dispatch` | `engine_00561E` + `native_mode_brk_0055FC` | 418 | 364 | vectors `nativeCop`, `nativeBrk`; tables of handler addresses |
| `engine_title` | `engine_006B7F` (title matrix, 681 B, 362 L) | 681 | 362 | `common_actor_0066FC` branches in (`loc_006CC1`); overrides 27856 and 27982 |
| `player_core` | `common_actor_001A28_part1` + `engine_routines_001D3B` + `engine_routines_002678` | ~2,860 | 1,663 | the mutual pair (305 refs) becomes internal; over 1,500 lines: accept or split P-rows with `split-part` |
| `player_magic` | `common_actor_001A28_part2` + `_part3` + `_part4` | 1,892 | 1,020 | soul orb (298 B), spells (1,402 B), level-up (175 B); `split-part` would give `soul_orb`, `spells`, `level_up` (FM-A10 section 7) |

Line counts marked `~` are estimated from the share of bytes in a multi-part block and are measured at PB2 (a part has no line count of its own in `npm run audit`). Three small `system` blocks are not engine code and go with their only users: `engine_004281` (24 bytes, three child scripts of the ghost-ship Purple Worms `common_actor_004102` and `common_actor_004248`) to `se_ghost_ship`; `engine_007A52` (a string reached from the save point `common_actor_00766C`) to the save-point file of `actor_shared` (5.4); `engine_0074B1` (34 bytes, a `COP [80]` / `COP [82]` actor script with no reference anywhere in `extracted/`) is unreferenced and goes into the bank-0 dead-code file (4.8).

Table blocks of `system` are not touched: `meta_tables_008000` (885 lines), `table_0099B4` (1,307), `table_00A9DE` (210), `table_00AC96` (626), `table_00B69A` (374), `data_00BA0D` (428), `data_00EE8E` (888), `data_00F99A`/`data_00F9F7` (29, 320), `asset_list_028000` (925), `spc_030000` (117), `data_048000` (168), `data_04F000` (74), `table_050000` .. `table_078000` (354, 566, 386, 2,198, 213, 734), `string_lookup_080000` (132). FM-A11 proposes retyping and merging the sine tables `binary_00FC84` and `binary_00FC84+40`; those are not blocks.

### 6.2 `cop_handlers` (bank 0)

110 blocks, 2,918 lines, 4 to 129 lines each (3,734 bytes). All stay in bank 0. Targets by the FM-A3 family (`BRL` to `cop_core` stays cross-file):

| Target file | Families (FM-A3) | Blocks | Lines |
|-------------|------------------|-------:|------:|
| `cop_flow_flags` | script flow 2.2 (9 blocks), flags and switches 2.3 (4), random 2.12 (2), scene and transition 2.6 (2), music-load entries 2.13 (`cop_handler_005CF0`, `005D10`) | 19 | ~420 |
| `cop_game_state` | inventory, Gems, EXP, HP 2.4 (10), text, menus, name entry 2.5 (4) | 14 | 370 |
| `cop_conditions` | conditions on actors, the player, the screen 2.7 (15) | 15 | 469 |
| `cop_actor_fields` | actor field setters 2.8 (29), animation 2.9 (10) | 39 | 783 |
| `cop_tiles_spawn` | tiles and collision 2.10 (12), spawn and kill 2.11 (9, without the exit chain) | 21 | ~650 |

(The block `cop_handler_006473` is both the exit chain 2.1 and the spawn row of 2.11; it goes to `cop_core`.) The `_part2` handlers of `005867` and `0059F4` and the two single-caller pairs (`0058A9` into `005C81`, `005EEE` into `005CD6`) fall inside these targets.

### 6.3 `library` (banks 2 and 4)

Bank 2 holds `lib_01xxxx` (114 blocks), bank 4 `lib_027xxx` (35). 76 code blocks, 4 code-with-data blocks, 46 ASCII string blocks, 10 data blocks (types of `blocks.json`).

| Target file | Cut | Lines | Note |
|-------------|-----|------:|------|
| `lib_text_render` | `lib_shared_012769` (+ `lib_shared_014789`, 3 refs), `lib_0126CF`, `lib_0124EE` | ~2,100 | 82 refs from 18 files; larger than 1,500: keep `lib_shared_012769` (1,682) as its own file and merge the rest (`lib_shared_014789`, `lib_0126CF`, `lib_0124EE`) into one |
| `lib_menus` | `lib_0118FC` + parts 3, 4, 7, 11 (strings), 13 (3,216 B data and strings) + other `lib_0118FC_part*` | ~1,700 | keep part 13 as data file `lib_menu_data` (285 L) |
| `lib_loader_save` | `lib_0133A6_part1`, `_part2`, `_part3`, `_part4`, `_part5` (631 B, 9 refs) | ~2,050 | `_part3` 1,453 L (save system L001 to L003); `_part4`/`_part5` are data (`&Binary`, `unk13`); keep data apart as `lib_loader_data` |
| `lib_scene_flow` | `lib_027781_part1` + `_part2` + `_part3` + `lib_027912`, `lib_0276C9`, `lib_0276A5` | ~700 | L030 to L035; L031 to L033 contiguous (4.8) |
| `lib_player_stats` | `lib_027462`, `_part1`, `_part2`, `lib_027572`, `lib_0275ED`, `lib_027614` | ~450 | `lib_027462` mixes three unrelated routines (FM-A9) |
| `lib_map_helpers` | `lib_0270E4`, `lib_027132`, `lib_shared_02716E`, `lib_02719F`, `lib_027223`, `lib_shared_027260`, `lib_0272E6`, `lib_027348`, `lib_0273A2`, `lib_0273D4`, `lib_0273EB` | ~420 | dead: `lib_027277`, `lib_027374` |
| `lib_scene_loader_b2` | `lib_01010B`, `_part2`, `_part3`, `lib_01020E`, `_part2`, `lib_shared_01032F`, `lib_shared_010419`, `lib_shared_0104AF`, `lib_0109D6` + `_part1`/`_part3`..`_part5`, `lib_010EA9_part1`..`_part3`, `lib_010EEA` + `_part2` | ~2,250 | decide the boundary at PB3; the sub-frame transitions R03 and the loaders must stay in bank 2 |
| `lib_text_strings` | the 46 ASCII string blocks, `lib_shared_014F74`, `lib_014536_part2`, `lib_010EA9_part2` | ~1,000 | bank 2 only; the 46 pure-string blocks (`lib_013B27` .. `lib_016264`, 4,701 bytes, 252 lines in all) become one file of about 250 lines, the three `&ASCIIString` tables stay as they are or join it |

The 11 diff-bank / same-group library blocks and the 52 diff-bank / diff-group string blocks cannot join their callers (4.2). `lib_01065B:18` (false R-2) stays where it is until OQ-I008-3 is closed.

### 6.4 World actors (one file per world, area and bank)

Same-bank, same-area blocks merge. Bank is fixed by the world: banks 3 (w0, w1, w6), 4 (w3, w4, w5), 31 (w2); enemy and boss `common` blocks are bank 31 and bank 0.

| World / area | Bank | Blocks | Bytes | Lines | Target file |
|--------------|-----:|-------:|------:|------:|-------------|
| w0 `01` grass_valley_village | 3 | 28 | 9,573 | 1,922 | `gv_village_actors` (over 1,500: split by scene `01/01`, `01/04`.. at PB3) |
| w0 `02` underground_castle | 3, 31 | 6, 5 | 989, 667 | 351, 403 | `gv_castle_actors`, `gv_castle_enemies` |
| w0 `03` leos_paintings | 3, 31, 0 | 3, 6, 1 | 235, 971, 537 | 85, 531, 238 | `gv_paintings_actors`, `_enemies`, `gv_boss_metal_mantis` |
| w0 `00` up_above | 3, 0 | 3, 18 | 2,248, 2,749 | 303, 1,335 | `gv_up_above_actors`, `gv_front_end` (OQ-I015-7) |
| w1 `04` woods_of_greenwood | 3 | 35 | 11,194 | 2,584 | `gw_woods_actors` (split in two) |
| w1 `05` lostside_marsh | 3, 31, 0 | 13, 12, 1 | 965, 2,165, 2,685 | 436, 1,151, 1,399 | `gw_lostside_actors`, `_enemies`, `gw_boss_statues` |
| w2 `06` seabed_sanctuary | 31 | 30 | 7,260 | 1,857 | `se_sanctuary_actors` (split by role) |
| w2 `07` seabed_of_st_elles | 31 | 18 | 3,109 | 1,256 | `se_seabed_actors` |
| w2 `08` st_elles_coast | 31 | 13 | 2,446 | 1,291 | `se_coast_actors` |
| w2 `09` ghost_ship | 0, 31 | 4, 2 | 1,086, 517 | 566, 59 | `se_ghost_ship` (bank 0, with `engine_004281`), `se_ghost_ship_b31` |
| w3 `0A` soul_of_mountain_house | 4 | 27 | 7,444 | 1,674 | `ms_house_actors` |
| w3 `0B` mountain_of_souls_dungeon | 4, 0 | 8, 1 | 890, 960 | 342, 441 | `ms_dungeon_actors`, `ms_boss_poseidon` |
| w3 `0C` snow_mountain | 4, 31 | 3, 1 | 744, 195 | 436, 106 | `ms_snow_actors` |
| w3 multi | 31, 4 | 9, 1 | 2,561, 124 | 1,333, 55 | `ms_enemies` (all w3 enemies in one file) |
| w4 `0D` leos_laboratory | 4 | 30 | 6,320 | 1,545 | `ll_lab_actors` |
| w4 `0E` laboratory_dungeon | 4, 31, 0 | 3, 6, 1 | 121, 1,743, 1,429 | 90, 900, 642 | `ll_dungeon_actors`, `ll_enemies`, `ll_boss_tin_doll` |
| w4 `0F` town_models | 4, 31 | 2, 5 | 192, 1,284 | 75, 652 | `ll_town_actors`, `ll_town_enemies` |
| w5 `10` castle_of_magridd | 4 | 25 | 7,026 | 1,317 | `mc_castle_actors` |
| w5 `11` castle_dungeon / `12` castle_towers | 4, 31 | 3+2, 7+7 | 286, 3,023 | 112, 1,636 | `mc_dungeon_actors`, `mc_enemies` |
| w5 `13` airship_dock | 4, 0 | 11, 1 | 3,023, 413 | 680, 208 | `mc_dock_actors`, `mc_boss_demon_falcon` |
| w6 `14` evil_world | 3, 31 | 4, 6 | 733, 1,161 | 408, 604 | `we_world_actors`, `we_enemies` |
| w6 `15` deathtolls_shrine / `00` | 0, 3 | 3, 1+1 | 1,481, 717 | 591, 180 | `we_boss_deathtoll`, `we_shrine_actors` |

Where a world has several areas with enemies in bank 31, one `<world>_enemies` file per world (the bank-31 per-world counts of 5.3) is simpler than one per area: lines 981, 1,358, 1,678, 1,514, 1,552, 1,636, 604.

Group after the move: enemies, bosses and front-end move to the world groups (`set group`, then `scene`), the shared helpers of 5.4 (including `common_actor_0029E8`, `common_actor_004659_part1`, `common_actor_00766C`) to `actor_shared`, the player pieces and `common_shared_0FEEA6` (SPC upload) to `system`, the two dead stubs into the bank-31 dead-code file; `common` becomes empty and can be deleted (`createGroup` is the only new group, `actor_shared`).

## 7. Proposed merges (not applied)

Outlines for `npm run blocks`; a spec lives under `plans/extracted-audit/edits/`, `--dry-run` first, then `npm run extract:lt`, `npm run rebuild`, `npm run merge -- --check`, `npm run names -- --check`. Expected SHA-1: every `merge` changes it (the packer re-orders files by size); a `set` of `scene` or `group` is expected to leave it unchanged but has not been measured (`OQ-I015-3`, PB2 spike).

### 7.1 Wave 0, the nine fall-through units (correctness)

```json
[
 { "op": "merge", "blocks": ["w0_actor_01AC32", "w0_shared_01AD1B"], "into": "w0_shared_01AD1B" },
 { "op": "merge", "blocks": ["w1_actor_01E4C3", "w1_shared_01E4E9"], "into": "w1_shared_01E4E9" },
 { "op": "merge", "blocks": ["w1_actor_01E759", "w1_shared_01E75C"], "into": "w1_shared_01E75C" },
 { "op": "merge", "blocks": ["w1_actor_01E7D5", "w1_shared_01E7D8"], "into": "w1_shared_01E7D8" },
 { "op": "merge", "blocks": ["w1_actor_01E851", "w1_shared_01E854"], "into": "w1_shared_01E854" },
 { "op": "merge", "blocks": ["w1_actor_01E8ED", "w1_shared_01E8F0"], "into": "w1_shared_01E8F0" },
 { "op": "merge", "blocks": ["w2_actor_0FA440", "w2_shared_0FA46D"], "into": "w2_shared_0FA46D" },
 { "op": "merge", "blocks": ["w3_actor_021ECE", "w3_shared_021EFB"], "into": "w3_shared_021EFB" },
 { "op": "merge", "blocks": ["w4_actor_023DD3", "w4_shared_023E00"], "into": "w4_shared_023E00" }
]
```

Each pair: same group, same bank, adjacent in the original. Meta rows, `COP [27]` and `BRL` references to the absorbed label keep working (labels are not renamed; `blocks` rewrites block names in notes only). The verification does not detect adjacency, so the dry-run report is not proof: check the order of parts in the merged file after `extract:lt` (the actor part first) and the position in `layout.json`. Removes 9 pairs of files; the reference count is unchanged (there was no reference).

### 7.2 Wave 1, same-bank, same-group single-caller (149 refs, 45 blocks)

Merge each block into its single caller, using the table of 3.4; the library `lib_0118FC` parts 3, 4, 7, 11, 13 and `lib_0133A6_part2`, `_part4`, `_part5` go to `lib_menus` and `lib_loader_save` of 6.3. The player pieces are not merged into one block (`_part2` to `_part1` would erase the subsystem boundary of FM-A10); use `player_core` and `player_magic` of 6.1 instead. Per group: common 17 refs, cop_handlers 4, grass_valley 12, greenwood 11 (after wave 0 the four `w1_actor_01E7xx` shims are inside their shared files), library 78, magridds_castle 18, system 6, world_of_evil 3.

### 7.3 Wave 2, system and COP families

`merge` into `engine_spawn`, `cop_core`, `cop_dispatch`, the five COP family files of 6.2 (`move-part` for `code_0064CC` and `code_006537`, which are blocks today and become parts of `cop_core`; `move-part` for the five `engine_000000` parts of 6.1 into new blocks with `"create": { "group": "system" }`). The COP merges are a cut of 110 files to 5; they keep the 124 `BRL` pairs into `cop_core` cross-file by design.

### 7.4 Wave 3, regroup `common`

`set` `group` (and `scene`) per 5.3 to 5.5: bosses, enemies and front-end to the world groups with the area key as `scene` (`extracted/<group>/<scene>/`), shared helpers to `actor_shared` (`createGroup`), player and SPC upload to `system`, dead stubs to a `*_dead` file. `set` is re-appliable. After this the world families of wave 4 can be merged because both ends are in one group.

### 7.5 Wave 4, world families

Merge per (world, area, bank) as in 6.4, family by family: first the `*_shared_` tails with their `BRL` actors (3.5), then the areas. 524 refs lie inside the target files. Stop merging at about 1,500 lines (split by scene at PB3). Strings stay in the files where they are (4.2).

### 7.6 Effect and verification

| Measure | Value |
|---------|-------|
| Refs removed by waves 1, 3 and 4 (union) | 632 of 3,531; pairs 253 of 1,514 |
| Remaining | 1,305 into targets with 10 or more calling files, 207 data reads, 134 bank-2 string reads, 1,253 other (engine and library calls, tables) |
| Files | not estimated here: the number of files after every wave depends on the PB3 decision about each over-1,500-line family; the COP handlers alone go from 110 to 5 |
| SHA-1 | changes with every merge; unchanged with `set` (to be measured) |
| Bank fill | unchanged: merges are size-neutral |

## 8. Tool gaps (nothing was changed)

1. `npm run blocks` has no `split-part`. A split at a label boundary inside a part (for the engine, `lib_0118FC`, `lib_shared_012769`, the player) would need an operation that creates a new part with the same label text, checked by `blocks-verify`. Per the project rules this is a change to `src/blocks-edit.ts`, to be documented in `gaia-core/docs/notes-and-comments.md` §"Blocks Merge", not worked around.
2. `npm run audit` should report fall-through (4.7): any part whose last instruction is not one of `RTS RTL RTI JMP JML BRA BRL STP` and not a `COP` known to jump, with the block that follows it in the ROM and whether the two are adjacent in `layout.json`. Today only this document knows the nine pairs.
3. `blocks-verify` should reject a merge that makes a fall-through pair non-adjacent, and a `split` that separates one.
4. Group move (`set group`) byte-neutrality is unmeasured.

## 9. Open questions

Recorded in `plans/extracted-audit/questions/I015_questions.md`: `OQ-I015-1` (do the nine fall-through actors run wrong in the rebuilt ROM), `-2` (the `$63` placeholder lair records), `-3` (is `set group` / `set scene` byte-neutral), `-4` (false R-2 read in `lib_01065B`), `-5` (library actor `lib_0116C3`), `-6` (unused meta entries), `-7` (folder for the title, boot and file-select actors), `-8` (`split-part`), `-9` (audit and verify fall-through), `-10` (lair home versus lair location). No DISCREPANCY with the walkthrough was found in this step.
