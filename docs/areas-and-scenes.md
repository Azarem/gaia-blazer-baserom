# Areas and scenes

Maps the folder keys in `us/groups.json` / `us/files.json` (and `extracted/<area>/<scene>/`) to the game's
location ids and in-game names. Scene id = `(area << 8) | scene` (decimal in `groups.json`). Names come from the
ROM's own location-name table `lib_014536_part2.asciistring_list_0147C2`, indexed by `$1C6A`, which is the first
`asset8` byte of the scene's asset-list record (checked in the emulator: area 3 scene 1 gives `$1C6A = 07`,
"Leo's Paintings"). The guide texts in `docs/walkthrough/` describe the same places.

## Worlds (block groups)

The actor script blocks (`wN_actor_<offset>`, `wN_shared_<offset>`) are grouped by world in `us/blocks.json`.

| Block group | World | Walkthrough |
|---|---|---|
| `grass_valley` | Grass Valley | `docs/walkthrough/02-grass-valley.md` |
| `greenwood` | GreenWood | `docs/walkthrough/03-greenwood.md` |
| `st_elles` | St. Elles | `docs/walkthrough/04-st-elles.md` |
| `mountain_of_souls` | Mountain of Souls | `docs/walkthrough/05-mountain-of-souls.md` |
| `leos_lab` | Dr. Leo's Laboratory | `docs/walkthrough/06-dr-leos-lab.md` |
| `magridds_castle` | King Magridd's Castle | `docs/walkthrough/07-king-magridds-castle.md` |
| `world_of_evil` | World of Evil | `docs/walkthrough/08-world-of-evil.md` |

Evidence for the world order and names: the dialogue text of each script bank (plan §8c).

## Areas (file groups)

| Area key | Id | Prefix | In-game name | Scene keys |
|---|---|---|---|---|
| `up_above` | 0 | `a00` | Up Above (shrines of each world, Trial room) | `grass_valley_shrine`, `greenwood_shrine`, `st_elles_shrine`, `soul_sanctuary`, `laboratory_shrine`, `magridd_castle_shrine`, `evil_world_shrine`, `trial_room`, `unnamed_0f` .. `unnamed_13` |
| `grass_valley_village` | 1 | `a01` | Grass Valley | `highlands`, `childs_secret_passage`, `treasure_room`, `chiefs_room` |
| `underground_castle` | 2 | `a02` | Underground Castle | `west`, `east`, `lisas_dream` |
| `leos_paintings` | 3 | `a03` | Leo's Paintings | `paintings_1` .. `paintings_4`, `tulips_dream`, `metal_mantis` |
| `woods_of_greenwood` | 4 | `a04` | Woods of GreenWood | `woods`, `moles_hole`, `squirrels_house`, `squirrel_exchanger`, `birds_dream`, `stumps_dream` |
| `lostside_marsh` | 5 | `a05` | Lostside, a marsh | `marsh`, `water_shrine_1..3`, `fire_shrine_1..3`, `light_shrine_1..2`, `statue_tomb` |
| `seabed_sanctuary` | 6 | `a06` | The Seabed Sanctuary | `sanctuary` |
| `seabed_of_st_elles` | 7 | `a07` | The Seabed of St. Elles | `seabed_1`, `secret_cave_1`, `secret_cave_2`, `dolphins_dream`, `seabed_2` |
| `st_elles_coast` | 8 | `a08` | St. Elles coast and dungeons | `southerta`, `rockbird_reef`, `durean`, `blester` |
| `ghost_ship` | 9 | `a09` | Ghost ship | `ship`, `servas_dream` |
| `soul_of_mountain_house` | 10 | `a0A` | Soul of Mountain House | `house` |
| `mountain_of_souls_dungeon` | 11 | `a0B` | Mountain of Souls | `north_slope`, `aurora_ridge`, `old_mans_dream`, `passage_to_lune`, `lune_lake`, `mushrooms_dream`, `poseidon` |
| `snow_mountain` | 12 | `a0C` | Snow Mountain and Laynole | `summit`, `ice_hill`, `laynole_ice_field` |
| `leos_laboratory` | 13 | `a0D` | Leo's Laboratory | `laboratory_1`, `laboratory_2`, `attic`, `mice_nest`, `cats_dream` |
| `laboratory_dungeon` | 14 | `a0E` | Laboratory Dungeon | `basement_1`, `basement_2`, `power_plant`, `tin_doll`, `dream` |
| `town_models` | 15 | `a0F` | Town models | `model_1`, `model_2` |
| `castle_of_magridd` | 16 | `a10` | Castle of King Magridd | `castle` |
| `castle_dungeon` | 17 | `a11` | Castle Dungeon (lower) | `torture_chamber`, `basement_1`, `basement_2`, `dream` |
| `castle_towers` | 18 | `a12` | Castle Dungeon (towers and prison) | `left_tower_1..2`, `prison`, `right_tower_1..3`, `dock_corridor` |
| `airship_dock` | 19 | `a13` | Airship dock | `dock`, `deck`, `soldiers_dream` |
| `evil_world` | 20 | `a14` | World of Evil | `world_of_evil_1`, `world_of_evil_2`, `dazzling_space` |
| `deathtolls_shrine` | 21 | `a15` | Deathtoll's Shrine | `shrine`, `battle` |

Hex area ids match the prefix (`a0B` = area 11). The exact scene ids are in `us/groups.json`. Area key collisions
with block group names are avoided on purpose (`extracted/<group>/` is shared): `evil_world`, `grass_valley_village`
and `mountain_of_souls_dungeon` differ from `world_of_evil`, `grass_valley` and `mountain_of_souls`.

Open: Up Above locations `0F`..`13` have no name string (OQ-I001-6 in `plans/extracted-audit/questions/I001_questions.md`).
