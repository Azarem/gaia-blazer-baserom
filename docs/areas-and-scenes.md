# Areas and scenes

*Part of the [Soul Blazer Documentation](README.md) · code hub: [Soul Blazer Code Documentation](code/README.md)*

Maps the folder keys in `us/groups.json` / `us/files.json` (and `extracted/<area>/<scene>/`) to the game's
location ids and in-game names. Scene id = `(area << 8) | scene` (decimal in `groups.json`). Names come from the
ROM's own location-name table `lib_banner_texts.LocationNameList`, indexed by `$1C6A`, which is the first
`asset8` byte of the scene's asset-list record (checked in the emulator: area 3 scene 1 gives `$1C6A = 07`,
"Leo's Paintings"). The guide texts in `docs/walkthrough/` describe the same places.

The game has 7 worlds, 22 areas and 97 scenes. Each world has a page ([worlds](#worlds-block-groups)) with the area
and scene table of that world, its actor files, roster, enemies and boss; the walkthrough names are matched to ROM
labels in [walkthrough-crosswalk.md](walkthrough-crosswalk.md).

## Worlds (block groups)

The actor script blocks are grouped by world in `us/blocks.json` and live in `extracted/<group>/<area>/`. The labels
carry the world prefix (`gv_`, `gw_`, `se_`, `ms_`, `ll_`, `mc_`, `we_`; shared actors `cm_`) and the file offset in hex.
The asset files of an area are in `extracted/<area>/` (a different folder from the actor files).

| Block group | World | World page | Walkthrough | Meta list |
|---|---|---|---|---|
| `grass_valley` | Grass Valley | [worlds/grass_valley.md](worlds/grass_valley.md) | [02-grass-valley.md](walkthrough/02-grass-valley.md) | `MetaGrassValley` |
| `greenwood` | GreenWood | [worlds/greenwood.md](worlds/greenwood.md) | [03-greenwood.md](walkthrough/03-greenwood.md) | `MetaGreenwood` |
| `st_elles` | St. Elles | [worlds/st_elles.md](worlds/st_elles.md) | [04-st-elles.md](walkthrough/04-st-elles.md) | `MetaStElles` |
| `mountain_of_souls` | Mountain of Souls | [worlds/mountain_of_souls.md](worlds/mountain_of_souls.md) | [05-mountain-of-souls.md](walkthrough/05-mountain-of-souls.md) | `MetaMountainOfSouls` |
| `leos_lab` | Dr. Leo's Laboratory | [worlds/leos_lab.md](worlds/leos_lab.md) | [06-dr-leos-lab.md](walkthrough/06-dr-leos-lab.md) | `MetaLeosLab` |
| `magridds_castle` | King Magridd's Castle | [worlds/magridds_castle.md](worlds/magridds_castle.md) | [07-king-magridds-castle.md](walkthrough/07-king-magridds-castle.md) | `MetaMagriddsCastle` |
| `world_of_evil` | World of Evil | [worlds/world_of_evil.md](worlds/world_of_evil.md) | [08-world-of-evil.md](walkthrough/08-world-of-evil.md) | `MetaWorldOfEvil` |

The meta lists are in [`WorldMetaPointers.asm`](../extracted/system/WorldMetaPointers.asm). Up Above, the title and the
front end are filed under Grass Valley (`front_end/`, `up_above/`); the Master's shrine event of the last world is
filed under World of Evil.

Evidence for the world order and names: the dialogue text of each script bank (plan §8c).

## Areas (file groups)

| Area key | Id | Prefix | In-game name | Scenes | World | Scene keys |
|---|---|---|---|--:|---|---|
| `up_above` | 0 | `a00` | Up Above (shrines of each world, Trial room) | 13 | Grass Valley (World of Evil for its shrine event) | `grass_valley_shrine`, `greenwood_shrine`, `st_elles_shrine`, `soul_sanctuary`, `laboratory_shrine`, `magridd_castle_shrine`, `evil_world_shrine`, `trial_room`, `unnamed_0f` .. `unnamed_13` |
| `grass_valley_village` | 1 | `a01` | Grass Valley | 4 | Grass Valley | `highlands`, `childs_secret_passage`, `treasure_room`, `chiefs_room` |
| `underground_castle` | 2 | `a02` | Underground Castle | 3 | Grass Valley | `west`, `east`, `lisas_dream` |
| `leos_paintings` | 3 | `a03` | Leo's Paintings | 6 | Grass Valley | `paintings_1` .. `paintings_4`, `tulips_dream`, `metal_mantis` |
| `woods_of_greenwood` | 4 | `a04` | Woods of GreenWood | 6 | GreenWood | `woods`, `moles_hole`, `squirrels_house`, `squirrel_exchanger`, `birds_dream`, `stumps_dream` |
| `lostside_marsh` | 5 | `a05` | Lostside, a marsh | 10 | GreenWood | `marsh`, `water_shrine_1..3`, `fire_shrine_1..3`, `light_shrine_1..2`, `statue_tomb` |
| `seabed_sanctuary` | 6 | `a06` | The Seabed Sanctuary | 1 | St. Elles | `sanctuary` |
| `seabed_of_st_elles` | 7 | `a07` | The Seabed of St. Elles | 5 | St. Elles | `seabed_1`, `secret_cave_1`, `secret_cave_2`, `dolphins_dream`, `seabed_2` |
| `st_elles_coast` | 8 | `a08` | St. Elles coast and dungeons | 4 | St. Elles | `southerta`, `rockbird_reef`, `durean`, `blester` |
| `ghost_ship` | 9 | `a09` | Ghost ship | 2 | St. Elles | `ship`, `servas_dream` |
| `soul_of_mountain_house` | 10 | `a0A` | Soul of Mountain House | 1 | Mountain of Souls | `house` |
| `mountain_of_souls_dungeon` | 11 | `a0B` | Mountain of Souls | 7 | Mountain of Souls | `north_slope`, `aurora_ridge`, `old_mans_dream`, `passage_to_lune`, `lune_lake`, `mushrooms_dream`, `poseidon` |
| `snow_mountain` | 12 | `a0C` | Snow Mountain and Laynole | 3 | Mountain of Souls | `summit`, `ice_hill`, `laynole_ice_field` |
| `leos_laboratory` | 13 | `a0D` | Leo's Laboratory | 5 | Leo's Lab | `laboratory_1`, `laboratory_2`, `attic`, `mice_nest`, `cats_dream` |
| `laboratory_dungeon` | 14 | `a0E` | Laboratory Dungeon | 5 | Leo's Lab | `basement_1`, `basement_2`, `power_plant`, `tin_doll`, `dream` |
| `town_models` | 15 | `a0F` | Town models | 2 | Leo's Lab | `model_1`, `model_2` |
| `castle_of_magridd` | 16 | `a10` | Castle of King Magridd | 1 | Magridd's Castle | `castle` |
| `castle_dungeon` | 17 | `a11` | Castle Dungeon (lower) | 4 | Magridd's Castle | `torture_chamber`, `basement_1`, `basement_2`, `dream` |
| `castle_towers` | 18 | `a12` | Castle Dungeon (towers and prison) | 7 | Magridd's Castle | `left_tower_1..2`, `prison`, `right_tower_1..3`, `dock_corridor` |
| `airship_dock` | 19 | `a13` | Airship dock | 3 | Magridd's Castle | `dock`, `deck`, `soldiers_dream` |
| `evil_world` | 20 | `a14` | World of Evil | 3 | World of Evil | `world_of_evil_1`, `world_of_evil_2`, `dazzling_space` |
| `deathtolls_shrine` | 21 | `a15` | Deathtoll's Shrine | 2 | World of Evil | `shrine`, `battle` |

Hex area ids match the prefix (`a0B` = area 11). The exact scene ids are in `us/groups.json`. Area key collisions
with block group names are avoided on purpose (`extracted/<group>/` is shared): `evil_world`, `grass_valley_village`
and `mountain_of_souls_dungeon` differ from `world_of_evil`, `grass_valley` and `mountain_of_souls`.

Open: Up Above locations `0F`..`13` have no name string (OQ-I001-6 in `plans/extracted-audit/questions/I001_questions.md`).

## Boss scenes

| Scene (`area/scene`) | Scene key | Boss | Boss file | World |
|---|---|---|---|---|
| `03/06` | `leos_paintings/metal_mantis` | Metal Mantis | [`gv_boss_metal_mantis`](../extracted/grass_valley/leos_paintings/gv_boss_metal_mantis.asm) | [Grass Valley](worlds/grass_valley.md) |
| `05/0A` | `lostside_marsh/statue_tomb` | Light, Water and Fire Statues | [`gw_boss_light_water_fire_statues`](../extracted/greenwood/lostside_marsh/gw_boss_light_water_fire_statues.asm) | [Greenwood](worlds/greenwood.md) |
| `09/01` | `ghost_ship/ship` | Floating Skull | [`se_boss_floating_skull`](../extracted/st_elles/ghost_ship/se_boss_floating_skull.asm) | [St. Elles](worlds/st_elles.md) |
| `0B/07` | `mountain_of_souls_dungeon/poseidon` | Poseidon | [`ms_boss_poseidon`](../extracted/mountain_of_souls/mountain_of_souls_dungeon/ms_boss_poseidon.asm) | [Mountain of Souls](worlds/mountain_of_souls.md) |
| `0E/04` | `laboratory_dungeon/tin_doll` | Tin Doll | [`ll_boss_tin_doll`](../extracted/leos_lab/laboratory_dungeon/ll_boss_tin_doll.asm) | [Leo's Lab](worlds/leos_lab.md) |
| `13/02` | `airship_dock/deck` | Demon Falcon | [`mc_boss_demon_falcon`](../extracted/magridds_castle/airship_dock/mc_boss_demon_falcon.asm) | [Magridd's Castle](worlds/magridds_castle.md) |
| `15/01` | `deathtolls_shrine/shrine` | Deathtoll the Mage | [`we_deathtolls_shrine_actors`](../extracted/world_of_evil/deathtolls_shrine/we_deathtolls_shrine_actors.asm) | [World of Evil](worlds/world_of_evil.md) |
| `15/02` | `deathtolls_shrine/battle` | Deathtoll the Demon | same file | [World of Evil](worlds/world_of_evil.md) |

The boss HP values of the ROM differ from the bestiary for five of the eight bosses (OQ-I004-1, see
[walkthrough-crosswalk.md](walkthrough-crosswalk.md)).

## Related

How a (area, scene) pair is requested, loaded and left again (asset list, placement and exit tables, `LocationAreaScene`): [code/scene-area-warp-loading.md](code/scene-area-warp-loading.md). The tables that are keyed by the location id: [code/data-tables.md](code/data-tables.md).
