# Walkthrough crosswalk

*Part of the [Soul Blazer Documentation](README.md) · code hub: [Soul Blazer Code Documentation](code/README.md)*

> How the names and facts of the [walkthrough](walkthrough/README.md) map to the ROM: worlds, bosses, the items and enemies that do not match, the confidence of every match, and the index of discrepancies. The walkthrough is the source for game names; the ROM text is the source for exact spelling and behaviour.

**Source:** the full tables are in [`plans/doc-audit/walkthrough-crosswalk.md`](../plans/doc-audit/walkthrough-crosswalk.md) (iteration I004, written against the earlier label scheme); the current labels are in [`extracted/`](../extracted/); the discrepancies are open questions in [`plans/extracted-audit/questions/`](../plans/extracted-audit/questions/).

---

## How to read it

### Ids and offsets

- A label suffix is the file offset in hex: `gv_npc_fairy_recover_sword_01AB4F` starts at file offset `$01AB4F` (LoROM: bank = offset ÷ `$8000`).
- `loc` is the location id `$1C6A`: the first `asset8` byte of the scene's record in [`data_scene_asset_lists`](../extracted/system/data_scene_asset_lists.asm). Its name is entry `loc` of the location name list in [`lib_banner_texts`](../extracted/library/lib_banner_texts.asm). A scene is written `area/scene` in hex.
- A world's locations are `loc ÷ 20` (decimal): world 0 is `$00`-`$13`, world 1 `$14`-`$27`, world 2 `$28`-`$3B`, world 3 `$3C`-`$4F`, world 4 `$50`-`$63`, world 5 `$64`-`$77`, world 6 `$78`-`$8B`.
- `item N` is the inventory and progress id: byte `N - 1` of the inventory ([flags-switches-and-inventory-bytes.md](code/flags-switches-and-inventory-bytes.md)).
- `wN:XX` is entry `XX` of the meta list of world `N` in [`WorldMetaPointers`](../extracted/system/WorldMetaPointers.asm): a 14-byte actor type with defence, HP, EXP and the code entry ([combat-damage-and-enemy-records.md](code/combat-damage-and-enemy-records.md)).
- The ROM prints an apostrophe as a blank, a period as `-` and a hyphen as `+` in place and item names (`Leo s Paintings`, `Red+Hot Ball`). These are encoding artefacts, not spelling differences, and are not discrepancies.

### Confidence

| Code | Meaning |
|------|---------|
| A | exact and unique: an id, an offset or an exact stat match on a single record |
| B | exact pool: the stats match several records that cannot be told apart statically |
| C | inferred from a location name, dialogue or the position in a roster |
| D | matched, but a fact differs: a `DISCREPANCY` with its open question |
| U | unmatched: no ROM evidence found yet |

The walkthrough is never changed to fit the ROM and the ROM is never changed to fit the walkthrough; a difference stays open until a runtime check settles it.

---

## Worlds

| Walkthrough chapter | World page | `blocks.json` group | Locations (`loc`) | Boss (meta) | Confidence |
|---------------------|------------|---------------------|-------------------|-------------|------------|
| 01 In the Beginning (Up Above, Trial Room) | [Grass Valley](worlds/grass_valley.md) | `grass_valley` | `$0D` Trial room; `$0F`-`$13` have no name | none | A (Trial Room), C (Up Above) |
| 02 Grass Valley | [Grass Valley](worlds/grass_valley.md) | `grass_valley` | `$00`-`$0E` | `w0:$1F` Metal Mantis | A |
| 03 GreenWood | [Greenwood](worlds/greenwood.md) | `greenwood` | `$14`-`$24` | `w1:$3D` three statues | A |
| 04 St. Elles | [St. Elles](worlds/st_elles.md) | `st_elles` | `$28`-`$34` | `w2:$41` Floating Skull | A |
| 05 Mountain of Souls | [Mountain of Souls](worlds/mountain_of_souls.md) | `mountain_of_souls` | `$3C`-`$47` | `w3:$38` Poseidon | A |
| 06 Dr. Leo's Lab | [Leo's Lab](worlds/leos_lab.md) | `leos_lab` | `$50`-`$5C` | `w4:$1E` Tin Doll | A |
| 07 King Magridd's Castle | [Magridd's Castle](worlds/magridds_castle.md) | `magridds_castle` | `$64`-`$73` | `w5:$09` Demon Falcon | A |
| 08 World of Evil | [World of Evil](worlds/world_of_evil.md) | `world_of_evil` | `$78`-`$7D` | `w6:$09` and `w6:$11` Deathtoll | A |

Areas and scenes are in [areas-and-scenes.md](areas-and-scenes.md); every world page has the area and scene table of its world with the walkthrough section of each scene. The 97 scenes of the scene index are matched by location name or by the walkthrough heading, with confidence A where a name or an id fixes the scene and C where only the walkthrough heading does.

---

## Bosses

| Walkthrough boss | HP, EXP (walkthrough) | Label | HP, EXP (ROM) | Arena (`loc`) | Confidence |
|------------------|-----------------------|-------|---------------|---------------|------------|
| Metal Mantis | 50, 50 | `gv_boss_metal_mantis_0031AD` (`w0:$1F`) | 50, 50 | `$0C` | A |
| Light, Water and Fire Statues | 50 each, 30 each | `gw_boss_light_water_fire_statues_0033C6` (`w1:$3D`) | 50, 30 per entry | `$22` | A |
| Floating Skull | 70, 200 | `se_boss_floating_skull_003E43` (`w2:$41`) | 69, 200 | `$32` | D, OQ-I004-1 |
| Poseidon | 70, 400 | `ms_boss_poseidon_004299` (`w3:$38`) | 79, 400 | `$44` | D, OQ-I004-1 |
| Tin Doll | 80, 800 | `ll_boss_tin_doll_004659` (`w4:$1E`) | 89, 800 | `$59` | D, OQ-I004-1 |
| Demon Falcon | 90, 5000 | `mc_boss_demon_falcon_004BEE` (`w5:$09`) | 99, 5000 | `$72` | D, OQ-I004-1 |
| Deathtoll the Mage | 100, 0 | `we_boss_deathtoll_mage_004D8B` (`w6:$09`) | 99, 0 | `$7C` | D, OQ-I004-1 |
| Deathtoll the Demon | 100, 0 | `we_boss_deathtoll_demon_005043` (`w6:$11`) | 100, 0 (defence `$FF`) | `$7D` | A |

Four bosses and the first Deathtoll form differ by one point or a few points from the bestiary; the ROM pattern of 69, 79, 89, 99 (ten more per world) against 70, 70, 80, 90 suggests that the HP byte of the meta record is not exactly the HP of the gauge. Which value the game uses is the open question OQ-I004-1; its refinements are OQ-I033-1, OQ-I039-3 and OQ-I040-2. The bestiary also gives Deathtoll "200 HP total" where the chapter gives 100 and 100.

The boss labels are the first actor of the boss file; each file also holds the boss's arms, shots and pillars, listed on the world page.

---

## Other facts that differ or are not located

| Subject | Walkthrough | ROM label and value | Confidence | OQ |
|---------|-------------|---------------------|------------|----|
| Item `$07` | Recovery Sword | `gv_npc_fairy_recover_sword_01AB4F`: the dialogue says "Recover Sword", the item table "Recovery Sword" | D | OQ-I004-6 |
| Item `$26` | Actinidia Leaves | `ll_npc_plant_actinidia_02317F`: the dialogue says "Actinidia leaves", the item table "Leaves" | D | OQ-I004-6 |
| Items `$2A`-`$31` | Master's Emblem A-H | the item table says "Emblem A-H"; grants in `gv_npc_water_mill_keeper_0186A2` (A), `gw_npc_squirrel_master_emblem_c_01E1C0` (C), `ms_npc_snail_master_emblem_e_021A4B` (E), `ms_obj_master_emblem_f_021E8F` (F), `ll_npc_drawers_mystic_armor_0229DF` (G), `mc_npc_soldier_emblem_h_025302` (H); B and D are chests | D (name) | OQ-I004-6 |
| Monster Blocks | HP 4, EXP 2 | `gv_enemy_monster_blocks_0FB04F`: HP 4, EXP 3 | D | OQ-I004-4 |
| Toy Calvary | HP 29, EXP 175 | `ll_enemy_toy_lunge_0FDAED` (24, 175) or `ll_enemy_toy_spear_0FD9E6` (20, 170) | D | OQ-I004-3 |
| Purple Bull | HP 23, EXP 2700 | `we_enemy_purple_bull_0FEA1D`: HP 45, EXP 2700 | D | OQ-I004-2 |
| Skeleton Soldier | in the chapter 07 text and tables, no bestiary row | `mc_enemy_skeleton_soldier_0FE236` (`w5:$10`, HP 23, EXP 750), the type that the block notes name; the other candidate `mc_obj_wall_spear_0FDE48` is a wall spear | C, bestiary gap | OQ-I004-7 |
| Dictionary spellings | Deathtoll, Lisa | the dictionary of [`data_dictionary`](../extracted/system/data_dictionary.asm) spells `Deathtole` and `Liesa` | D | OQ-I004-5 |
| Strength and defence caps | 13 and 12 | no cap in the level-up code | D | OQ-I004-10 |
| Weapon minimum levels, armour effects | [items.md](walkthrough/items.md) | not located as a table, effects not traced | U | OQ-I004-9 |
| Ghost Ship Torches, Ice Crystal | EXP 0, HP unknown | no record found | U | none |

Spell gem costs, the lair roster per area, the lair that releases each boss (a statically known pair only for Poseidon and Floating Skull) and the EXP of the Fairy Gems are tracked as OQ-I004-9, OQ-I004-12 and OQ-I004-13. The two unnamed hidden Up Above locations `$0F`-`$13` are OQ-I001-6.

---

## DISCREPANCY index

| OQ | Subject | Where it is discussed |
|----|---------|-----------------------|
| OQ-I004-1 | Boss HP: Floating Skull 69 against 70, Poseidon 79 against 70, Tin Doll 89 against 80, Demon Falcon 99 against 90, Deathtoll Mage 99 against 100 | [St. Elles](worlds/st_elles.md), [Mountain of Souls](worlds/mountain_of_souls.md), [Leo's Lab](worlds/leos_lab.md), [Magridd's Castle](worlds/magridds_castle.md), [World of Evil](worlds/world_of_evil.md) |
| OQ-I004-2 | Purple Bull HP 23 against 45 | [World of Evil](worlds/world_of_evil.md) |
| OQ-I004-3 | Toy Calvary 29 HP and 175 EXP against 24/175 or 20/170 | [Leo's Lab](worlds/leos_lab.md) |
| OQ-I004-4 | Monster Blocks EXP 2 against 3 | [Grass Valley](worlds/grass_valley.md) |
| OQ-I004-5 | Dictionary spellings `Deathtole` and `Liesa` against `Deathtoll` and `Lisa` | [World of Evil](worlds/world_of_evil.md), [text-and-dialogue.md](code/text-and-dialogue.md) |
| OQ-I004-6 | Item names: `Recover Sword` against `Recovery Sword`; `Emblem` against `Master's Emblem`; `Leaves` against `Actinidia Leaves` | [items.md](walkthrough/items.md) |
| OQ-I004-7 | Skeleton Soldier named in chapter 07 without a bestiary row (the block notes now name `w5:$10`; the bestiary gap stays) | [Magridd's Castle](worlds/magridds_castle.md) |
| OQ-I004-10 | Strength and defence caps (13 and 12) with no cap in the level-up code | [combat-damage-and-enemy-records.md](code/combat-damage-and-enemy-records.md) |
| OQ-I004-15 | Naming variants inside the walkthrough itself (no ROM action) | [walkthrough/README.md](walkthrough/README.md) |

Two ids describe one fact: OQ-I033-1 repeats the boss HP question of OQ-I004-1 from the combat document; both are kept until a runtime check settles the value.

---

## Actor names

The crosswalk of iteration I004 proposed a naming convention for the actor files; the extracted code now uses it. A label is a world prefix (`gv_`, `gw_`, `se_`, `ms_`, `ll_`, `mc_`, `we_`, or `cm_` for shared actors), a role (`npc`, `obj`, `enemy`, `boss`, `fx`), a name and the file offset in hex. Older documents that cite `w0_actor_01AB4F` or `common_actor_0033C6` use the labels of the first mapping; the offset in the suffix is the same, so a search for the hex suffix finds the current label.
