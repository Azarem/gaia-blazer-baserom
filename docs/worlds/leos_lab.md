# Dr. Leo's Lab (`leos_lab`)

*Part of the [Soul Blazer Documentation](../README.md) · code hub: [Soul Blazer Code Documentation](../code/README.md)*

> World index **4** (`MetaLeosLab`): [Dr. Leo's Lab](../walkthrough/06-dr-leos-lab.md) covers Leo's Laboratory, the Laboratory Dungeon (basement and power plant), the two town models, and the boss **Tin Doll**.

**Source:** [`extracted/leos_lab/`](../../extracted/leos_lab/) (seven `.asm` files by area folder); enemy and NPC types in [`extracted/system/WorldMetaPointers.asm`](../../extracted/system/WorldMetaPointers.asm) (`MetaLeosLab`, rows w4:`$05`–`$36`); walkthrough [ch. 06](../walkthrough/06-dr-leos-lab.md), [sidequests](../walkthrough/sidequests.md), [items](../walkthrough/items.md), [magic](../walkthrough/magic.md), [enemy-bestiary](../walkthrough/enemy-bestiary.md).

---

## Overview

Chapter 6 is the metal-enemy tutorial world. The player clears pipe-themed **basement** scenes (`0E/01`–`02`), returns upstairs for the **Zantetsu Sword** (`51/3F`), can leave briefly for the optional [Defeating Metal Monsters](../walkthrough/sidequests.md) sweep across earlier worlds, then reopens the basement, enters the first **model of a town** (`0F/01`), earns the **Soul of Detection**, clears both models and the **power plant** (`0E/03`), prepares in the kitchen (Actinidia leaves, **Spark Bomb**), and fights **Tin Doll** (`0E/04`) before **Marie** gives the **Purple Stone** in the attic ([ch. 06](../walkthrough/06-dr-leos-lab.md)).

The `leos_lab` group holds **seven** actor files: the laboratory NPC roster (`ll_laboratory_actors`), dungeon support actors and hazards (`ll_laboratory_dungeon_actors`, `ll_laboratory_dungeon_enemies`, `ll_boss_tin_doll`), town-model fairies and building-removal FX (`ll_town_models_actors`, `ll_town_models_enemies`), and shared fairy strings (`ll_watching_over_world_return_prompt_texts`). Lair releases in the dungeon and models free matching objects upstairs (doors, cats, plants, mice, chests of drawers, town-model warp objects, Marie). The Master shrine for this world is **Up Above** scene `00/05` (`loc` `$50`, The Laboratory Shrine), using the same `cm_npc_master_shrine_menu_00766C` pattern as other worlds (meta type `$2D` in `MetaLeosLab`).

```mermaid
flowchart LR
  Shrine[00/05 Laboratory Shrine] --> Lab1[0D/01 Laboratory]
  Lab1 --> B1[0E/01 Basement B1]
  B1 --> Zantetsu[Zantetsu Sword chest]
  Zantetsu --> B2[0E/02 Basement B2]
  B2 --> Model1[0F/01 Town model 1]
  Model1 --> Soul[Soul of Detection]
  Soul --> Model2[0F/02 Town model 2]
  Model2 --> Plant[Power plant 0E/03]
  Plant --> Boss[0E/04 Tin Doll]
  Boss --> Marie[Purple Stone / Magridd]
```

---

## Areas and scenes

Scene id = `area/scene` in hex (`us/groups.json` prefixes `a0D`, `a0E`, `a0F`, `a00`). Banner names are from `LocationNameList` / `$1C6A` ([areas-and-scenes.md](../areas-and-scenes.md)); ROM spellings below match extractor output (apostrophe → space, full stop → `-`).

| Extracted folder / scene key | Scene | `loc` | ROM name (banner) | Walkthrough | Actor file(s) |
|---|---|---|---|---|---|
| `up_above/laboratory_shrine` | `00/05` | `$50` | The Laboratory Shrine | Master's Shrine (Dr. Leo's Lab) | [`cm_npc_master_shrine_menu_00766C`](../../extracted/actor_shared/shared_actor_helpers_bank0.asm) (meta `$2D`) |
| `leos_laboratory/laboratory_1` | `0D/01` | `$51` | Leo s Laboratory | Arrival; ground floor; Zantetsu chest | [`ll_laboratory_actors`](../../extracted/leos_lab/leos_laboratory/ll_laboratory_actors.asm) |
| `leos_laboratory/laboratory_2` | `0D/02` | `$52` | Leo s Laboratory | First floor / kitchen / models room | `ll_laboratory_actors` |
| `leos_laboratory/attic` | `0D/03` | `$53` | An attic | Herb storage; Marie; Purple Stone | `ll_laboratory_actors` |
| `leos_laboratory/mice_nest` | `0D/04` | `$54` | A mice nest | Spark Bomb mouse; timid mice | `ll_laboratory_actors` |
| `leos_laboratory/cats_dream` | `0D/05` | `$55` | A cat s dream | Dream Rod on suffering cat | `ll_laboratory_actors` (`ll_dream_scene_023B0B`, dream actors) |
| `laboratory_dungeon/basement_1` | `0E/01` | `$56` | Basement of Laboratory | Dungeon part 1 | `ll_laboratory_dungeon_enemies`; fairies in [`ll_laboratory_dungeon_actors`](../../extracted/leos_lab/laboratory_dungeon/ll_laboratory_dungeon_actors.asm) |
| `laboratory_dungeon/basement_2` | `0E/02` | `$57` | Basement of Laboratory | Dungeon part 2 | same + `ll_obj_fire_pit_023F17` |
| `laboratory_dungeon/power_plant` | `0E/03` | `$58` | power plant | Part 6; Light Armor chest | `ll_laboratory_dungeon_enemies`, `ll_laboratory_dungeon_actors` |
| `laboratory_dungeon/tin_doll` | `0E/04` | `$59` | Tin Doll | Boss arena | [`ll_boss_tin_doll`](../../extracted/leos_lab/laboratory_dungeon/ll_boss_tin_doll.asm) (lair-spawned) |
| `laboratory_dungeon/dream` | `0E/05` | `$5A` | A dream 1 | Not named in FAQ | unmatched (OQ-I004-14) |
| `town_models/model_1` | `0F/01` | `$5B` | Model of a town | Town Model 1 | [`ll_town_models_enemies`](../../extracted/leos_lab/town_models/ll_town_models_enemies.asm), [`ll_town_models_actors`](../../extracted/leos_lab/town_models/ll_town_models_actors.asm) |
| `town_models/model_2` | `0F/02` | `$5C` | Model of a town | Town Model 2 | same |

Enemy placements and lairs live in system data ([`data_scene_placements.asm`](../../extracted/system/data_scene_placements.asm), [`data_lair_records.asm`](../../extracted/system/data_lair_records.asm)); the block notes in each `*_enemies.asm` and `ll_laboratory_actors` tie record indices to walkthrough releases.

---

## Actor files

| File | Role (from block notes) |
|---|---|
| [`ll_laboratory_actors.asm`](../../extracted/leos_lab/leos_laboratory/ll_laboratory_actors.asm) | All `0D` NPCs, doors, cats, plants, drawers, Marie, town-model warp objects, cat's-dream scene; meta types `$05`–`$1C`, `$2B`, `$2C`, `$33`–`$36` |
| [`ll_laboratory_dungeon_actors.asm`](../../extracted/leos_lab/laboratory_dungeon/ll_laboratory_dungeon_actors.asm) | Fairy Gems (300 EXP, types `$2F`, `$32`), return prompt `ll_fairy_return_prompt_023E00`, fire-pit hazard (meta `$2E`) |
| [`ll_laboratory_dungeon_enemies.asm`](../../extracted/leos_lab/laboratory_dungeon/ll_laboratory_dungeon_enemies.asm) | Basement/power-plant enemies w4:`$1F`–`$24` (Mini vehicles, Ball Worm, Sweeper Bot, Flail) |
| [`ll_boss_tin_doll.asm`](../../extracted/leos_lab/laboratory_dungeon/ll_boss_tin_doll.asm) | Boss w4:`$1E`; lair record `$12F`, location `$59` |
| [`ll_town_models_actors.asm`](../../extracted/leos_lab/town_models/ll_town_models_actors.asm) | Town Model 1 fairy (meta `$30`); building-removal effect (meta `$31`, lair `$143`) |
| [`ll_town_models_enemies.asm`](../../extracted/leos_lab/town_models/ll_town_models_enemies.asm) | Town combatants w4:`$25`–`$29` |
| [`ll_watching_over_world_return_prompt_texts.asm`](../../extracted/leos_lab/ll_watching_over_world_return_prompt_texts.asm) | Fairy EXP line, Stay/Go back strings, dialogue erase tail for all laboratory talk |

---

## Roster

Laboratory NPCs wait on **lair record** releases (COP 14 switch roots in `ll_laboratory_actors`). Types index into `MetaLeosLab`. Souls use `souls_flags`; gifts use COP item handlers cited in the block note.

| Name | Label | Where | Grant / role | Walkthrough |
|---|---|---|---|---|
| Entrance door | `ll_npc_door_entrance_talk_023A36` | `0D/01` | Zantetsu Sword hint; flag `$0600` | Arrival |
| Locked door | `ll_npc_door_locked_key_02260D` | `0D/01` | Needs item `$27` door key; flag `$0800` | Town Model 1 (after cat dream) |
| Chest of drawers | `ll_npc_drawers_mystic_armor_0229DF` | `0D/01` | [Mystic Armor](../walkthrough/items.md) (`$0D`); [Master's Emblem G](../walkthrough/items.md) (`$30`, flag `$1A06`) | Town Model 1 |
| Soul of Detection door | `ll_npc_door_soul_of_detection_022E10` | `0D/02` | Soul (`souls_flags` bit `$08`); flag `$0603`; vanishes | Soul of Detection |
| Cat (dream / key) | `ll_npc_cat_dream_key_022F68` | `0D/02` | Dream Rod → `0D/05`; then door key (`$27`, flag `$0802`) | Town Model 1 |
| Cat followers | `ll_npc_cat_follower_a_022794`, `ll_npc_cat_follower_b_022886` | `0D/01`–`02` | Follow when item `$26` Leaves equipped; flags `$0605`/`$0606` | Boss Preparations |
| Plant (Actinidia) | `ll_npc_plant_actinidia_02317F` | `0D/02` | Item `$26` Leaves (dialogue: Actinidia leaves) | Boss Preparations |
| Plant (Medical Herb) | `ll_npc_plant_medical_herb_022B80` | `0D/01`; kitchen | Medical Herb (`$38`) | Boss Preparations |
| Spark Bomb mouse | `ll_npc_mouse_spark_bomb_0238A7` | `0D/04` | [Spark Bomb](../walkthrough/magic.md) (`$15`) after both cats out | Boss Preparations |
| Devout mouse | `ll_npc_mouse_purify_022D05` | `0D/02` | Full heal on tile (`$14`,`$05`) | Town Model 2 |
| Herb-storage drawers | `ll_npc_drawers_herb_storage_0232B3` | `0D/03` | Stores one Medical Herb (flag `$0807`) | Boss Preparations |
| Marie (doll) | `ll_npc_marie_purple_stone_0234EC` | `0D/03` | [Purple Stone](../walkthrough/items.md) (`$3E`, flag `$1B04`) after boss | Conclusion |
| Town model 1 / 2 | `ll_obj_model_town_1_0239BA`, `ll_obj_model_town_2_0239F8` | `0D/02` | Warp to `0F/01` / `0F/02` | Town models |
| Fairy Gem (300 EXP) | `ll_npc_fairy_exp_300_023DD3`, `ll_npc_fairy_exp_300_023E27`, `ll_npc_fairy_exp_300_023E57` | `0E/02`, `0F/01`, `0E/03` | 300 EXP once each (flags `$1D01`–`$1D03`) | Parts 2, 3, 6 |
| Master | `cm_npc_master_shrine_menu_00766C` | `00/05` | Heal, save, warp hub | Throughout ch. 06 |

**Chests and fixed pickups** ([`data_chest_lists.asm`](../../extracted/system/data_chest_lists.asm); [walkthrough crosswalk](../walkthrough-crosswalk.md) §4):

| Item | `loc`/note | Walkthrough section |
|---|---|---|
| Zantetsu Sword | chest `51/3F` | Zantetsu Sword |
| Light Armor | chest `58/2B` | Dungeon Part 6 |
| Strange Bottle | chest `5C/AF` | Town Model 2 (Part 5) |
| Mystic Armor | `ll_npc_drawers_mystic_armor_0229DF` (not a chest) | Town Model 1 |
| Door key, Spark Bomb, Purple Stone | actors above | Town Model 1 / Boss Prep / Conclusion |
| 80 / 50 Gems, Medical Herb (model 1) | Lair-spawned treasures in `0F/01` | Parts 3–4 (walkthrough checklist) |

---

## Enemies

Stats: walkthrough tables in [ch. 06](../walkthrough/06-dr-leos-lab.md) and [enemy-bestiary.md](../walkthrough/enemy-bestiary.md); ROM HP/EXP from `meta_entry` bytes in [`WorldMetaPointers.asm`](../../extracted/system/WorldMetaPointers.asm) (`MetaLeosLab`). Confidence as in [walkthrough-crosswalk](../walkthrough-crosswalk.md) §8.

| Enemy | HP / EXP (walkthrough) | Meta / label | Conf. | Note |
|---|---|---|---|---|
| Mini Race Car | 12 / 150 (metal) | w4:`$1F` `ll_enemy_mini_race_car_0FD275` | A | Sets `$1A` bit `$0400` |
| Mini Bulldozer | 14 / 145 (metal) | w4:`$20` `ll_enemy_mini_bulldozer_0FD345` | A | |
| Mini Helicopter | 18 / 160 (metal) | w4:`$21` `ll_enemy_mini_helicopter_0FD402` | A | |
| Ball Worm | 18 / 150 | w4:`$22` `ll_enemy_ball_worm_0FD502` | A | |
| Sweeper Bot | 24 / 140 | w4:`$24` `ll_enemy_sweeper_bot_0FD752` | A | |
| Flail (pipes) | — | w4:`$23` `ll_enemy_flail_0FD6EC` | U | 1 HP; hazard; **OQ-I004-8** |
| Toy Soldier | 16 / 165 | w4:`$25` `ll_enemy_toy_soldier_0FD944` | A | Town models only |
| Toy Calvary | **29** / 175 | w4:`$27` `ll_enemy_toy_lunge_0FDAED` (24 HP) or w4:`$26` `ll_enemy_toy_spear_0FD9E6` (20 / 170) | D | FAQ spelling Calvary; **OQ-I004-3**, **OQ-I038-3** |
| Catapult | 30 / 180 | w4:`$28` `ll_enemy_catapult_0FDBFB` | A | |
| Spike Launcher | 36 / 160 | w4:`$29` `ll_enemy_spike_launcher_0FDCFC` | A | |

Mini Race Car, Mini Bulldozer, and Mini Helicopter require the **Zantetsu Sword** (metal class in [`engine_combat_hits.asm`](../../extracted/system/engine_combat_hits.asm)). Fire floors in `0E/02`–`03` are handled by `ll_obj_fire_pit_023F17` (Ice Armor item `$0A`).

---

## Boss and set pieces

| | Walkthrough | ROM (`MetaLeosLab` `$1E`) |
|---|---|---|
| Name | Tin Doll | `ll_boss_tin_doll_004659` |
| HP / EXP | 80 / 800 | **89** (`#59`) / 800 (`#$0800`) |
| Arena | Power plant approach → boss stairs | Scene `0E/04`, `loc` `$59`; **lair record `$12F`** (spawn at tile `$16`,`$17`) |
| Aftermath | Hit southeast lair; stairs north; Marie in attic | Record `$12F` frees Marie type `$19`; Purple Stone from `ll_npc_marie_purple_stone_0234EC` |

Block note: boss arms `boss_fight_active`, map patch id 3, then a four-direction walk loop with contact branches for the scripted **flower** child (`ll_boss_tin_doll_flower_004B1C`) / meteor rain (`ll_boss_tin_doll_meteor_*`) and close-range **fireballs** (`ll_boss_tin_doll_fire_*`); the doll also teleports along the arena sides. Walkthrough attacks (Meteor Rain, Fireball, Tackle, Flower Possession) map to those routines ([ch. 06 §BOSS](../walkthrough/06-dr-leos-lab.md)).

**Dream / cutscene rooms:** Cat's dream (`0D/05`, `ll_dream_scene_023B0B`); unused banner scene `0E/05` (`loc` `$5A`, "A dream 1", **OQ-I004-14**). Soul-of-Detection gameplay in models uses meta `$2A` → `RunSoulOfDetectionEffect` in [`lib_hdma_window_effects.asm`](../../extracted/library/lib_hdma_window_effects.asm).

---

## Sidequest and progression hooks

| Sidequest | Touching this world | Implementation |
|---|---|---|
| [Defeating Metal Monsters](../walkthrough/sidequests.md) | **Zantetsu Sword** (`51/3F`) is the prerequisite; the FAQ detours through Grass Valley, GreenWood, and St. Elles, then returns to the first basement | Entrance text `ll_npc_door_entrance_talk_023A36`; metal bit on mini enemies and (per script) the boss — see **OQ-I038-2** |
| [Master's Emblem G](../walkthrough/sidequests.md) | Leo's Laboratory – Town Model 1 | `ll_npc_drawers_mystic_armor_0229DF`, item `$30`, flag `$1A06` (push drawers; **OQ-I038-7** vs walkthrough "hold R") |
| Magic Bell (eight emblems) | Emblem G above | — |
| Phoenix (Red-Hot trio) | Metal sidequest awards **Red-Hot Stick** in St. Elles; not granted in `leos_lab` | — |

Progression items for later worlds: **Purple Stone** (`$3E`) ends the chapter toward Magridd's Castle. Flags called out in `ll_laboratory_actors` include kitchen cat-out flags `$0605`/`$0606`, Soul of Detection `$0603`, door key `$0802`, and boss stone `$1B04`.

---

## Walkthrough cross-check

| Term | Walkthrough | ROM / code | Result |
|---|---|---|---|
| Tin Doll HP | 80 ([ch. 06](../walkthrough/06-dr-leos-lab.md)) | `#59` (89) in `MetaLeosLab` `$1E` | mismatch, see **OQ-I004-1** |
| Toy Calvary HP | 29 / 175 | w4:`$27` 24 / 175; w4:`$26` 20 / 170 | mismatch, see **OQ-I004-3** |
| Actinidia / Leaves | Actinidia Leaves (prose); Leaves in [items.md](../walkthrough/items.md) | Item `$26` table "Leaves"; plant text "Actinidia leaves" | mismatch, see **OQ-I004-6** |
| Master's Emblem G | "Master's Emblem G" | Drawer script text "Master s Emblem G" | mismatch, see **OQ-I004-6** |
| Tin Doll metal? | Metal = No (bestiary) | `ll_boss_tin_doll_004659` sets `$1A` bit `$0400` | mismatch, see **OQ-I038-2** |
| Scene `0E/05` | — | Banner `A dream 1`, `loc` `$5A` | unmatched, see **OQ-I004-14** |
| w4:`$23` Flail | Pipe hazards (prose) | 1 HP, 1000 EXP meta; no FAQ row | unmatched, see **OQ-I004-8** |
| Toy Calvary vs spear type | One bestiary row | Two ROM types `$26`/`$27` | mismatch, see **OQ-I038-3** |
| Mouse "come inside" reward | Implies a gift | `ll_npc_mouse_cats_scared_0226C0` gives no item | mismatch, see **OQ-I038-10** |

---

## Open questions

| ID | Summary |
|---|---|
| OQ-I004-1 | Boss HP walkthrough vs meta (includes Tin Doll 80 vs 89) |
| OQ-I004-3 | Toy Calvary 29 HP vs ROM 24/20 HP rows |
| OQ-I004-6 | Item/emblem display names (`Leaves`, `Master's Emblem`, etc.) |
| OQ-I004-8 | Unnamed meta rows (w4:`$23` Flail, w4:`$26` spear thruster) |
| OQ-I004-14 | `A dream 1` scenes (`0E/05`, `loc` `$5A`) vs walkthrough |
| OQ-I004-15 | Walkthrough-internal spellings (Toy **Calvary**, Metal **Gorillas**, Clubhouse Pass, …) |
| OQ-I038-1 | Fire-pit metatiles `$F3` / `$E1` vs visible fire tiles |
| OQ-I038-2 | Tin Doll metal flag vs bestiary |
| OQ-I038-3 | Which ROM type is Toy Calvary |
| OQ-I038-6 | Speakers in cat's dream (`0D/05`) |
| OQ-I038-7 | Drawer push vs walkthrough "hold R" |
| OQ-I038-10 | Mouse thank-you line without item grant |
| OQ-I038-13 | Boss "flower" = scene object vs child sprite |

No new **OQ-I058-?** candidates beyond the crosswalk and rows above.

---

## See Also

- [Soul Blazer Code Documentation](../code/README.md) (hub)
- [scene-area-warp-loading.md](../code/scene-area-warp-loading.md), [actor-system.md](../code/actor-system.md), [combat-damage-and-enemy-records.md](../code/combat-damage-and-enemy-records.md) (`MetaLeosLab`), [data-tables.md](../code/data-tables.md) (lair records)
- [flags-switches-and-inventory-bytes.md](../code/flags-switches-and-inventory-bytes.md), [text-and-dialogue.md](../code/text-and-dialogue.md), [menus-inventory-status-hud.md](../code/menus-inventory-status-hud.md)
- [Walkthrough ch. 06](../walkthrough/06-dr-leos-lab.md), [sidequests](../walkthrough/sidequests.md), [items](../walkthrough/items.md), [magic](../walkthrough/magic.md), [enemy-bestiary](../walkthrough/enemy-bestiary.md)
- [areas-and-scenes.md](../areas-and-scenes.md), [walkthrough-crosswalk.md](../walkthrough-crosswalk.md)
- Previous world: [mountain_of_souls.md](mountain_of_souls.md) · Next world: [magridds_castle.md](magridds_castle.md)