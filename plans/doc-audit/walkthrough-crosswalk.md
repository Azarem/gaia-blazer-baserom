# Walkthrough crosswalk (P1, iteration I004)

Maps every world, area, boss, NPC, item, spell, enemy type and sidequest named in `docs/walkthrough/` to the ROM evidence in `extracted/` (read after a fresh `npm run extract:lt`). Nothing in the project was changed to produce it: no names, notes, comments, blocks or docs.

Rules that were followed (see `plans/doc-audit/README.md`):

- The walkthrough is the source for game names and facts, the ROM text is the source for exact spelling and behaviour. Every mismatch is an open question `OQ-I004-n` with tag `DISCREPANCY` in `plans/extracted-audit/questions/I004_questions.md`.
- Static evidence only. Nothing here is a runtime trace. Whatever a Mesen2 check could change is marked in the OQ file.
- The original ROM and the rebuilt ROM are not compared.

## 0. Reading the tables

### Offsets and ids

- `{n}` is the decimal file offset printed by `extract:lt`. A label suffix is the file offset in hex (`w0_actor_01AB4F` starts at `$01AB4F`). The SNES address is LoROM: bank = offset >> 15.
- `loc` is the location id `$1C6A`. It is the first `asset8` byte of the scene record in `asset_list_028000`. Its name is entry `loc` of `lib_014536_part2.asciistring_list_0147C2` (128 entries). `scene` is written `area/scene` (hex), as in `table_0099B4`.
- World of a location or enemy = `loc / 20` (decimal): `w0` = locs `$00`-`$13`, `w1` = `$14`-`$27`, `w2` = `$28`-`$3B`, `w3` = `$3C`-`$4F`, `w4` = `$50`-`$63`, `w5` = `$64`-`$77`, `w6` = `$78`-`$8B`.
- `item N` is the inventory/progress id (`$1B1E + N - 1`), the index of `lib_shared_014F74.asciistring_list_014F74`.
- `meta wN:XX` is entry `XX` of per-world table `N` in `meta_tables_008000` (14-byte `meta_entry`: +1 defence, +2 HP in hex, +3 EXP in BCD, +B code entry). Enemy code lives in `common/common_actor_0FAA49` ... `0FEEA5` (bank 0F) and is world-specific even though it is filed under `common/`.
- String quirks of `us/stringTypes.json`: the apostrophe prints as a space (`Leo s brush`), `+` is the hyphen glyph (`Red+Hot Ball`), `-` is the period glyph. These are encoding artefacts, not spelling differences, and are not logged as discrepancies.

### Confidence

| Code | Meaning |
|------|---------|
| A | exact and unique: an id, offset or exact stat match on a single record |
| B | exact pool: the stats match several records that cannot be told apart statically |
| C | inferred from location name, dialogue or roster position |
| D | matched, but a fact differs: `DISCREPANCY` (OQ id given) |
| U | unmatched: no ROM evidence found yet (OQ id given where there is a question) |

## 1. Worlds

| Walkthrough chapter | ROM world | Locations (`loc`) | Actor bank / folder | Boss `meta` | Status |
|---------------------|-----------|-------------------|---------------------|-------------|--------|
| 01 In the Beginning (Up Above, Trial Room) | w0 | `$0D` Trial room; `$0F`-`$13` unnamed (OQ-I001-6) | `grass_valley/` (`w0_actor_*`) | none | A (Trial Room), C (Up Above: names missing in the table) |
| 02 Grass Valley (Underground Castle, Leo's Painting) | w0 | `$00`-`$0E` | `grass_valley/`, bank 01 | w0:1F Metal Mantis | A |
| 03 GreenWood (Lostside) | w1 | `$14`-`$24` | `greenwood/`, bank 03 | w1:3D three statues | A |
| 04 St. Elles | w2 | `$28`-`$34` | `st_elles/`, bank 0F | w2:41 Floating Skull | A |
| 05 Mountain of Souls | w3 | `$3C`-`$47` | `mountain_of_souls/`, bank 04 | w3:38 Poseidon | A |
| 06 Dr. Leo's Lab | w4 | `$50`-`$5C` | `leos_lab/` | w4:1E Tin Doll | A |
| 07 King Magridd's Castle | w5 | `$64`-`$73` | `magridds_castle/` | w5:09 Demon Falcon | A |
| 08 World of Evil | w6 | `$78`-`$7D` | `world_of_evil/` | w6:09 and w6:11 Deathtoll | A |

Folder to world is the `w0_`..`w6_` file prefix; the 0xFxxx enemy actors in `common/` belong to the world given by the meta table (section 8).

## 2. Areas and scenes

Every `scene` of `table_0099B4` (97 scenes). Walkthrough names are the section or `~ area ~` headings of the chapter.

### w0 (chapters 01 and 02)

| scene | loc | ROM name | Walkthrough | Status |
|-------|-----|----------|-------------|--------|
| 00/08 | `0D` | Trial room | Trial Room (ch. 01); chest `item 01` Sword of Life; `w0_actor_01A7AC` Soul of Magician + Flame Ball | A |
| 00/09-00/0D | `0F`-`13` | (empty) | Up Above... (ch. 01); scene 00/0D (`13`) places `w0_actor_01B33A`, the Lisa and goat Turbo scene | C, OQ-I001-6 |
| 00/01 | `00` | Grass Valley Shrine | Master's Shrine of Grass Valley | C |
| 01/01 | `01` | Grass Valley highlands | Grass Valley (village; "Grass Valley - Arrival", "The Rest of Grass Valley") | A |
| 01/02 | `02` | Child s secret passage | the cave behind the boy's gate (Clubhouse Pass, "Grass Valley - Boss Preparation") | C |
| 01/03 | `03` | Treasure room | cave of "Grass Valley - The Elevator": Iron Armor and 50 Gems (chests) | A |
| 01/04 | `04` | The village Chief s room | the chief's house: Brown Stone (`w0_actor_01A098`) | A |
| 02/01 | `05` | Underground Castle, west | Underground Castle Part 1 and Part 2 (12 Gems, Medical Herb, Dream Rod chests) | A |
| 02/02 | `06` | Underground Castle, east | Underground Castle Part 3 (Leo's brush chest) | A |
| 02/03 | `0E` | Lisa s dream | Lisa's dream ("Grass Valley - Lisa") | A |
| 03/01, 03/02, 03/03 | `07`, `08`, `09` | Leo s Paintings | Leo's Painting Part 1 (three areas); `08` also holds the Medical Herb and Tornado chests (metal-monster sidequest) | C |
| 03/04 | `0A` | Tulip s Dream | the tulip's dream | C |
| 03/05 | `0B` | Leo s Paintings | Leo's Painting Part 2 (path to the boss) | C |
| 03/06 | `0C` | Monster in the paintings | boss arena of the Metal Mantis | C |

### w1 (chapter 03)

| scene | loc | ROM name | Walkthrough | Status |
|-------|-----|----------|-------------|--------|
| 00/02 | `14` | GreenWood Shrine | Master's Shrine of GreenWood | C |
| 04/01 | `15` | Woods of GreenWood | Woods of GreenWood (Ice Armor chest `sw0C`; `w1_actor_01BF32` Magic Bell fairy) | A |
| 04/02 | `16` | A mole s hole | Monmo's hole; Mole's Ribbon chest | A |
| 04/03 | `17` | A squirrel s house | the squirrels' hollows (Emblem C, `w1_actor_01E1C0`) | C |
| 04/04 | `18` | Squirrel, the Exchanger | the hollow where the squirrel swaps Delicious Seeds for the Psycho Sword (`w1_actor_01E005`) | A |
| 04/05 | `23` | Bird s Dream | the bird's dream | C |
| 04/06 | `24` | Stump s Dream | the tree stump's dream | C |
| 05/01 | `19` | Lostside, a marsh | Lostside Exterior | A |
| 05/02-05/04 | `1A`-`1C` | Water Shrine (3) | Water Shrine (Lostside Part 1, 3 floors; chests: 50 Gems; 150 Gems and Medical Herb; Delicious Seeds and 50 Gems) | A |
| 05/05-05/07 | `1D`-`1F` | Fire Shrine (3) | Fire Shrine (Lostside Part 2 and Part 3: B1F, B2F, B3F) | A |
| 05/08, 05/09 | `20`, `21` | Light Shrine (2) | Light Shrine (Lostside Part 4); `20` holds the Flame Pillar chest of the spirit-monster sidequest | A |
| 05/0A | `22` | Tomb of a stone statue | arena of the Light, Water and Fire statues (Lostside - Boss) | C |

### w2 (chapter 04)

| scene | loc | ROM name | Walkthrough | Status |
|-------|-----|----------|-------------|--------|
| 00/03 | `28` | St- Elles Shrine | Master's Shrine of St. Elles | C |
| 06/01 | `29` | The Seabed Sanctuary | St. Elles / Seabed Sanctuary (chests Mermaid's Tears, Big Pearl) | A |
| 07/01 | `2A` | The Seabed of St- Elles | the southern seabed (Part 2, 3, 4, 6 entrance) | C |
| 07/05 | `34` | The Seabed of St- Elles | the northern seabed (Part 5 and Part 6; Power Bracelet chest) | C |
| 07/02, 07/03 | `2B`, `2C` | The Secret Cave | The Secret Cave (Part 6; Emblem D, 80 Gems, empty, Medical Herb chests) | A |
| 07/04 | `2D` | A dolphin s dream | the napping dolphin's dream | C |
| 08/01 | `2E` | Southerta | Southerta | A |
| 08/02 | `2F` | Shore reef of Rockbird | Shore Reef of Rockbird | A |
| 08/03 | `30` | Durean | Durean (Critical Sword, Strange Bottle chests) | A |
| 08/04 | `31` | Blester | Blester | A |
| 09/01 | `32` | A ghost ship | the Ghost Ship (1 Gem chest, Floating Skull) | A |
| 09/02 | `33` | Servas  dream | Servas' dream (before the Ghost Ship sank) | A |

### w3 (chapter 05)

| scene | loc | ROM name | Walkthrough | Status |
|-------|-----|----------|-------------|--------|
| 00/04 | `3C` | The Soul s Sanctuary | Master's Shrine of the Mountain of Souls | C |
| 0A/01 | `3D` | Soul of Mountain House | Soul of Mountain House (spelling of the ROM string: two leading spaces) | A |
| 0B/01 | `3E` | Mountain, North+slope | North Slope | A |
| 0B/02 | `3F` | Aurora s Ridge | Aurora's Ridge | A |
| 0B/03 | `40` | An old man s dream | the old man's dream | C |
| 0B/04 | `41` | A passage to Lune | A Passage to Lune | A |
| 0B/05 | `42` | Underground lake,Lune | The Underground Lake, Lune | A |
| 0B/06 | `43` | A mushroom s dream | the mushroom's dream | C |
| 0B/07 | `44` | Poseidon | arena of the Poseidon boss | C |
| 0C/01 | `45` | The top of Snow Mountain | Top of Snow Mountain | A |
| 0C/02 | `46` | An ice hill | An Ice Hill | A |
| 0C/03 | `47` | Ice field of Laynole | Ice Field of Laynole (Lucky Blade, Strange Bottle, Rotator chests) | A |

### w4 (chapter 06)

| scene | loc | ROM name | Walkthrough | Status |
|-------|-----|----------|-------------|--------|
| 00/05 | `50` | The Laboratory Shrine | Master's Shrine (Dr. Leo's Lab) | C |
| 0D/01 | `51` | Leo s Laboratory | Leo's Laboratory (ground floor; Zantetsu Sword chest) | A |
| 0D/02 | `52` | Leo s Laboratory | Leo's Laboratory (first floor / kitchen) | C |
| 0D/03 | `53` | An attic | the attic (Marie: Purple Stone, Herb storage chest) | A |
| 0D/04 | `54` | A mice nest | the kitchen back room (the mouse who gives the Spark Bomb) | C |
| 0D/05 | `55` | A cat s dream | the cat's dream | C |
| 0E/01, 0E/02 | `56`, `57` | Basement of Laboratory | Laboratory Basement B1F and B2F (Part 1 and Part 2) | A |
| 0E/03 | `58` | power plant | Power Plant (Light Armor chest) | A |
| 0E/04 | `59` | Tin Doll | arena of the Tin Doll | C |
| 0E/05 | `5A` | A dream 1 | an unnamed dream (OQ-I004-14) | U |
| 0F/01, 0F/02 | `5B`, `5C` | Model of a town | Town Model 1 and Town Model 2 | A |

### w5 (chapter 07)

| scene | loc | ROM name | Walkthrough | Status |
|-------|-----|----------|-------------|--------|
| 00/06 | `64` | Magridd Castle Shrine | Master's Shrine (Magridd Castle) | C |
| 10/01 | `65` | Castle of King Magridd | Castle of King Magridd (town; `w5_actor_025561` Black Stone) | A |
| 11/01 | `66` | The torture chamber | Castle Dungeon Part 1 / The Torture Chamber (Spirit Sword chest) | A |
| 11/02 | `67` | Basement of the castle | Basement of the Castle (B2F) | A |
| 11/03 | `68` | Basement of the castle | Castle Dungeon Part 3 (Emblem B chest) | A |
| 11/04 | `69` | A dream 1 | an unnamed dream (OQ-I004-14) | U |
| 12/01, 12/02 | `6A`, `6B` | The left tower | Left Tower 1F-2F | A |
| 12/03 | `6C` | A prison | Left Tower 3F (Prison) | A |
| 12/04-12/06 | `6D`-`6F` | The right tower | Right Tower 1F-3F | A |
| 12/07 | `70` | A corridor to the dock | Right Tower 4F (A Corridor to the Dock) | A |
| 13/01 | `71` | The dock for an airship | Right Tower 4F (Airship Dock) | A |
| 13/02 | `72` | The deck of an airship | arena of the Demon Falcon | C |
| 13/03 | `73` | A soldier s dream | a soldier's dream | C |

### w6 (chapter 08)

| scene | loc | ROM name | Walkthrough | Status |
|-------|-----|----------|-------------|--------|
| 00/07 | `78` | The Evil World Shrine | Master's Shrine (World of Evil) | C |
| 14/01 | `79` | World of Evil | World of Evil: First Area (Red-Hot Ball, 200 Gems, Medical Herb chests) | A |
| 14/02 | `7A` | World of Evil | World of Evil: Second Area (Soul Armor chest) | A |
| 14/03 | `7B` | Dazzling Space | Dazzling Space (Soul Blade, 100 Gems chests) | A |
| 15/01 | `7C` | Deathtoll s Shrine | the shrine before the final fight (Deathtoll the Mage's actor `common_actor_004D8B`) | A |
| 15/02 | `7D` | Battle with Deathtoll | The Final Clash | A |

Spelling: the table writes the name as `Deathtoll s Shrine`. The dictionary table `string_lookup_080000` spells `Deathtole` (OQ-I004-5).

## 3. Bosses

| Walkthrough boss | HP, EXP (walkthrough) | ROM record | HP, EXP (ROM) | Spawn area | Status |
|------------------|-----------------------|------------|---------------|------------|--------|
| Metal Mantis | 50, 50 | meta w0:1F, `common_actor_0031AD` | 50 (`$32`), 50 | `0C` Monster in the paintings (C) | A |
| Light, Water and Fire Statues | 50 each (150), 30 each (90) | meta w1:3D, `common_actor_0033C6` | 50, 30 per entry | `22` Tomb of a stone statue (C) | A |
| Floating Skull | 70, 200 | meta w2:41, `common_actor_003E43` | 69 (`$45`), 200 | `32` A ghost ship (C) | D, OQ-I004-1 |
| Poseidon | 70, 400 | meta w3:38, `common_actor_004299` | 79 (`$4F`), 400 | `44` Poseidon (C) | D, OQ-I004-1 |
| Tin Doll | 80, 800 | meta w4:1E, `common_actor_004659` | 89 (`$59`), 800 | `59` Tin Doll (C) | D, OQ-I004-1 |
| Demon Falcon | 90, 5000 | meta w5:09, `common_actor_004BEE` | 99 (`$63`), 5000 | `72` deck of an airship (C) | D, OQ-I004-1 |
| Deathtoll the Mage | 100, 0 | meta w6:09, `common_actor_004D8B` | 99 (`$63`), 0 | `7C` (placed in scene 15/01; A) | D, OQ-I004-1 |
| Deathtoll the Demon | 100, 0 | meta w6:11, `common_actor_005043` | 100 (`$64`), 0, defence `$FF` | `7D` (placed in scene 15/02; A) | A |

Notes:

- Only the two Deathtoll actors appear in a scene placement list (`unk2`). The other bosses are spawned from lair records, and the lair whose released monster is the boss was not identified (OQ-I004-13).
- The walkthrough's bestiary lists Deathtoll as "200 HP total", while the chapter text gives 100 + 100.
- The pattern 69/79/89/99 (+10 per world) versus 70/70/80/90 suggests the meta HP byte is not exactly the HP shown in the gauge for these bosses.

## 4. Items

All 64 ids of `lib_shared_014F74` (`$01`-`$40`). "Grant site" is the code that gives the item. Chests come from `table_00A9DE` (6-byte records: x, y, switch id, item, 16-bit BCD gem count; item `$FF` = gems, `$00` = empty chest); the record is written `loc/switch`. Actors grant with `COP [0A] ( #id )`.

| id | ROM name | Walkthrough name | Grant site | Walkthrough section | Status |
|----|----------|------------------|------------|---------------------|--------|
| 01 | Sword of Life | Sword of Life | chest `0D/00` | Trial Room | A |
| 02 | Psycho Sword | Psycho Sword | `w1_actor_01E005` (squirrel exchange) | Woods of GreenWood - The Soul of Light | A |
| 03 | Critical Sword | Critical Sword | chest `30/20` (Durean) | St. Elles Part 4 | A |
| 04 | Lucky Blade | Lucky Blade | chest `47/29` | Mountain of Souls Part 2 | A |
| 05 | Zantetsu Sword | Zantetsu Sword | chest `51/3F` | Leo's Laboratory - Zantetsu Sword | A |
| 06 | Spirit Sword | Spirit Sword | chest `66/40` | Castle Dungeon Part 1 | A |
| 07 | Recovery Sword | Recovery Sword | `w0_actor_01AB4F` (dialogue says "Recover Sword") | Sidequest: Defeating Metal Monsters (Fairy Gem in Grass Valley) | D, OQ-I004-6 |
| 08 | The Soul Blade | Soul Blade | chest `7B/3B` | World of Evil - Into the Dazzling Space | A |
| 09 | Iron Armor | Iron Armor | chest `03/05` | Grass Valley - The Elevator | A |
| 0A | Ice Armor | Ice Armor | chest `15/0C` | Woods of GreenWood - Ice Armor | A |
| 0B | Bubble Armor | Bubble Armor | `w2_actor_0F8B6A` | Seabed Sanctuary - Bubble Armor | A |
| 0C | Magic Armor | Magic Armor | chest `3F/25` | Mountain of Souls Part 1 | A |
| 0D | Mystic Armor | Mystic Armor | `w4_actor_0229DF` | Leo's Laboratory - Town Model 1 | A |
| 0E | Light Armor | Light Armor | chest `58/2B` | Laboratory Dungeon Part 6 | A |
| 0F | Elemental Mail | Elemental Mail (also "Elemental Armor" in ch. 07 prose) | `w5_actor_024259` | Castle of King Magridd - Elemental Mail | A |
| 10 | Soul Armor | Soul Armor | chest `7A/3A` | World of Evil - Into the Dazzling Space | A |
| 11 | Flame Ball | Flame Ball | `w0_actor_01A7AC` | Trial Room | A |
| 12 | Light Arrow | Light Arrow | `w1_actor_01E540` ("Here, take this Light Arrow Magic") | Lostside Part 2 (fairy in the Fire Shrine) | A |
| 13 | Magic Flair | Magic Flair | `w2_actor_0F905C` | Seabed Sanctuary - The Thunder Ring | A |
| 14 | Rotator | Rotator | chest `47/41` | Mountain of Souls Part 3 | A |
| 15 | Spark Bomb | Spark Bomb | `w4_actor_0238A7` | Leo's Laboratory - Boss Preparations | A |
| 16 | Flame Pillar | Flame Pillar | chest `20/42` (Light Shrine) | Sidequest: Defeating the Spirit Monsters | A |
| 17 | Tornado | Tornado | chest `08/0A` (Leo s Paintings) | Sidequest: Defeating Metal Monsters | A |
| 18 | Phoenix | Phoenix | `w3_actor_020563`; it also clears items 32, 33, 34 | Summoning the Phoenix! (the king in the Mountain of Souls) | A |
| 19 | Goat s Food | Goat's Food (ch. 02 prose: "goat food") | `w0_actor_0191D2` (boy in the tool shop) | Grass Valley - Lisa | A |
| 1A | Harp string | Harp String | `w5_actor_0269F6` (dialogue: found "harp string") | Castle Dungeon Part 1 (checklist); handed to the singer in the Platinum Card section | A |
| 1B | a pass | A Pass / Clubhouse Pass (walkthrough uses both) | `w0_actor_0197DA` (tulip) | Grass Valley - Boss Preparation | A |
| 1C | Dream Rod | Dream Rod | chest `05/03` | Underground Castle Part 2 | A |
| 1D | Leo s brush | Leo's Brush | chest `06/04` | Underground Castle Part 3 | A |
| 1E | Leaves | Leaves | `w1_actor_01D6AB` (the file also has the Soul of Light) | Woods of GreenWood - Leaves of GreenWood | A |
| 1F | Mole s Ribbon | Mole's Ribbon | chest `16/0D` | Woods of GreenWood - Boss Preparation (mole's hole) | A |
| 20 | the Big Pearl | Big Pearl | chest `29/18` | Seabed Sanctuary - The Thunder Ring | A |
| 21 | Mermaid s Tears | Mermaid's Tears | chest `29/17` (two records: `y $39` and `y $B9`) | Seabed Sanctuary - Bubble Armor | A |
| 22 | Mushroom Shoes | Mushroom Shoes | `w3_actor_020CC6` | Soul of Mountain House - Mushroom Shoes | A |
| 23 | a mobile key | A Mobile Key | `w5_actor_025E61` (Dr. Leo) | Castle of King Magridd - Boss Preparations | A |
| 24 | Thunder Ring | Thunder Ring | `w2_actor_0F9B8B` (Lue) | Seabed Sanctuary - The Thunder Ring | A |
| 25 | Delicious Seeds | Delicious Seeds | chest `1C/10` | Lostside Part 1 | A |
| 26 | Leaves | Actinidia Leaves | `w4_actor_02317F` (the dialogue says "Actinidia leaves", the item table "Leaves") | Leo's Laboratory - Boss Preparations | D, OQ-I004-6 |
| 27 | a door key | A Door Key | `w4_actor_022F68` (cat) | Leo's Laboratory | A |
| 28 | Platinum Card | Platinum Card | `w5_actor_024BC8` | Castle of King Magridd - Platinum Card | A |
| 29 | the VIP Card | VIP Card | `w5_actor_02494A` (also grants item 37) | Castle of King Magridd - VIP Card | A |
| 2A-31 | Emblem A-H | Master's Emblem A-H | A `w0_actor_0186A2`; B chest `68/B4`; C `w1_actor_01E1C0`; D chest `2B/19`; E `w3_actor_021A4B`; F `w3_actor_021E8F`; G `w4_actor_0229DF`; H `w5_actor_025302` | see sidequests.md | D (name), OQ-I004-6 |
| 32 | Red+Hot Mirror | Red-Hot Mirror | `w1_actor_01BDE5` (the bird) | Sidequest: Defeating the Spirit Monsters | A |
| 33 | Red+Hot Ball | Red-Hot Ball | chest `79/39` | The World of Evil - The Red-Hot Ball | A |
| 34 | Red+Hot Stick | Red-Hot Stick | `w2_actor_0F982F` (St. Elles bank, mermaid) | Sidequest: Defeating Metal Monsters (Durean) | A |
| 35 | Power Bracelet | Power Bracelet | chest `34/23` | St. Elles Part 6 | A |
| 36 | Shield Bracelet | Shield Bracelet | `w1_actor_01DBE5` (needs the Mole's Ribbon) | Woods of GreenWood - Boss Preparation | A |
| 37 | Super Bracelet | Super Bracelet | `w5_actor_02494A` | Castle of King Magridd - Boss Preparations | A |
| 38 | Medical Herb | Medical Herb | chests (13 records) and `w0_actor_018353`, `w0_actor_01891A`, `w1_actor_01D045`, `w2_actor_0F82DD`, `w4_actor_022B80`, `w4_actor_0232B3`, `w5_actor_024E53` | all "Medical Herb" lines | A |
| 39 | Strange Bottle | Strange Bottle | `w0_actor_0198A6`, `w1_actor_01E47B`; chests `1E/13`, `30/21`, `47/2A`, `5C/AF`, `67/B2` | GV Boss Prep; Lostside Part 1; Fire Shrine (metal sidequest); Durean; Laynole; Town Model 2; Castle Part 2 | A |
| 3A | Brown Stone | Brown Stone | `w0_actor_01A098` (chief's room) | The Rest of Grass Valley | A |
| 3B | Green Stone | Green Stone | `w1_actor_01D4F9` (the Guardian of the Woods) | Woods of GreenWood - Conclusion | A |
| 3C | Blue Stone | Blue Stone | `w2_actor_0F911E` | St. Elles - Conclusion | A |
| 3D | Silver Stone | Silver Stone | `w3_actor_02108F` (Nome) | Soul of Mountain House - Conclusion | A |
| 3E | Purple Stone | Purple Stone | `w4_actor_0234EC` (Marie) | Leo's Laboratory - Conclusion | A |
| 3F | Black Stone | Black Stone | `w5_actor_025561` | Castle of King Magridd - Conclusion | A |
| 40 | Magic Bell | Magic Bell | `w1_actor_01BF32` (needs items 2A-31, then clears them) | Castle of King Magridd - Boss Preparations | A |

Pause-menu grid: the walkthrough grid position (row r, column c) equals id `$19 + (r-1)*10 + (c-1)` for all 40 key items. Checked against all rows of `items.md`.

Chest table gem records match the walkthrough treasure lists: Treasure room 50 Gems, Underground Castle 12 Gems, Water Shrine 50/150/50, Fire Shrine 100 and 60, Secret Cave 80, Rockbird 60, Ghost Ship 1, Mountain 40/50, Model town 50/80, castle basement 100, World of Evil 200/100.

The empty chests (`item 00`) match the walkthrough's "nothing" chests: Fire Shrine (`1E/14`), Secret Cave (`2B/1C`), Aurora's Ridge (`3F/26`).

## 5. Weapons and armour

| Fact | Walkthrough (`items.md`) | ROM | Status |
|------|--------------------------|-----|--------|
| Weapon strength +1, +2, +3, +4, +6, +8, +10, +12 (items 01-08) | same | `lib_0118FC_part13.binary_0161AC`, first row: `00 01 02 03 04 06 08 0A 0C` | A |
| Armour defence +1, +2, +3, +4, +6, +8, +10, +12 (items 09-10) | same | same table, second row from item 09 | A |
| Minimum swing level 1, 5, 11, 15, 16, 19, 22, 24 | `items.md` | not located | U, OQ-I004-9 |
| Armour effects (Ice Armor vs fire, Bubble Armor underwater, Magic Armor halves gem cost, Mystic Armor longer invulnerability, Light Armor, Elemental Mail spikes, Soul Armor) | `items.md` | not traced | U, OQ-I004-9 |

## 6. Magic

| Spell | Gems (walkthrough) | Location (walkthrough) | ROM grant | Status |
|-------|--------------------|------------------------|-----------|--------|
| Flame Ball | 4 | Trial Room | `w0_actor_01A7AC`, scene 00/08 | A (grant); cost U |
| Light Arrow | 8 | Lostside Part 2 | `w1_actor_01E540` | A; cost U |
| Magic Flair | 8 | Seabed Sanctuary - The Thunder Ring | `w2_actor_0F905C` | A; cost U |
| Rotator | 1 | Mountain of Souls Part 3 | chest `47/41` | A; cost U |
| Spark Bomb | 8 | Leo's Laboratory - Boss Preparations | `w4_actor_0238A7` | A; cost U |
| Flame Pillar | 20 | Sidequest: Defeating the Spirit Monsters | chest `20/42` | A; cost U |
| Tornado | 8 | Sidequest: Defeating Metal Monsters | chest `08/0A` | A; cost U |
| Phoenix | 2 | Summoning the Phoenix! | `w3_actor_020563` (checks items 32-34, then clears them) | A; cost U |

Gem cost per spell, the halving with Magic Armor and the zero cost with the Magic Bell were not located (OQ-I004-9).

## 7. Souls

| Walkthrough soul | Where (walkthrough) | ROM actor | Evidence | Status |
|------------------|---------------------|-----------|----------|--------|
| Soul of Magician | Trial Room | `w0_actor_01A7AC` | "Now I will join you- I am a magician..." | A |
| Soul of Light | Woods of GreenWood - The Soul of Light | `w1_actor_01D6AB` | "I light up the darkness ... The creature who lights up darkness joined" | A |
| Soul of Shield | Seabed Sanctuary - Another Mermaid Statue | `w2_actor_0F80A4` | "I will protect you from the Magma ... The creature that ena..." | A |
| Soul of Detection | Leo's Laboratory - Soul of Detection | `w4_actor_022E10` | "The soul that enables you to see invisible enemies in model towns joins you" | A |
| Soul of Reality | Castle of King Magridd - Soul of Reality | `w5_actor_0251DC` | "I know all of the invisible passages in the Magridd Castle" | A |

## 8. Enemy types

Matched by (HP, EXP) against the per-world `meta_entry` tables. `w:XX` = world and entry id; the label is the code entry. Pool entries (B) share their stats with another walkthrough name, so only the pool is certain.

| Walkthrough name | HP, EXP (walkthrough) | ROM entry (`common_actor_...`) | Status |
|------------------|-----------------------|--------------------------------|--------|
| Blue Liquid, Fly, Green Humanoid, Walking Bush | 3, 1 | w0:20 `0FAA49`, w0:22 `0FAB9A`, w0:23 `0FAC31`, w0:24 `0FAC7A` | B (four records, four names; mapping by animation id not done) |
| Blue Torch | 5, 2 | w0:25 `0FACF2` | A |
| Yellow Humanoid | 4, 2 | w0:21 `0FAA8F` | A |
| Green Torch | 9, 4 | w0:29 `0FAFAD` | A |
| Yellow Knight | 9, 5 | w0:26 `0FAD2A` | A |
| Metal Crawler | 24, 250 | w0:27 `0FAEE5` | A |
| Purple Bird | 4, 3 | w0:28 `0FAF44` (w0:2E `0FB04F` has the same stats) | B |
| Monster Blocks | 4, 2 | best candidate w0:2E `0FB04F` (4, **3**) | D, OQ-I004-4 |
| Water Lizard | 10, 10 | w1:2C `0FB0F5` | A |
| Mud Man | 12, 11 | w1:2D `0FB302` | A |
| Walking Plant | 6, 12 | w1:2E `0FB348` | A |
| Stone Statue | 13, 12 | w1:2F `0FB433` | A |
| Purple Flower, Purple Flower's Bee | 3, 6 | w1:30 `0FB561` | B |
| Spirit Ball | 40, 1100 | w1:33 `0FB5E3` | A |
| Ghost Head, Green Lizard Man | 8, 14 | w1:35 `0FB695` | B |
| Fire Man | 12, 13 | w1:48 `0FB9D6` | A |
| Metal Scorpion | 30, 350 | w1:49 `0FBABC` | A |
| Sea Urchin | 36, 20 | w2:32 `0FBB1F` | A |
| Jellyfish | 10, 25 | w2:34 `0FBBA3` | A |
| Hermit Crab | 15, 22 | w2:35 `0FBC22` | A |
| Manta Ray | 10, 30 | w2:36 `0FBD12` | A |
| Yellow Seahorse | 8, 21 | w2:37 `0FBE81` | A |
| Walking Tree | 10, 22 | w2:3A `0FC01E` | A |
| Monster Rock | 20, 24 | w2:3B `0FC0E5` | A |
| Purple Fish | 8, 20 | w2:3C `0FC14E` | A |
| Ape | 12, 23 | w2:3D `0FC296` | A |
| Metal Ape ("Metal Gorillas" in the ch. 06 prose) | 30, 35 | w2:3E `0FC3E8` | A |
| Tornadic Eagle | 21, 28 | w2:3F `0FC536` | A |
| Purple Worms | 5, 10 | w2:44 `004102`, w2:46 `004248` | B |
| Green Lizard | 8, 65 | w3:2D `0FC72F` | A |
| Undead Caribou | 25, 70 | w3:2E `0FC845` | A |
| Yeti | 20, 80 | w3:2F `0FC8FE` | A |
| Fire Bat | 14, 85 | w3:30 `0FC9BC` | A |
| Purple Wizard | 17, 85 | w3:32 `0FCBDF` | A |
| Red Wizard | 20, 100 | w3:33 `0FCDBA` | A |
| Ice Maker | 24, 70 | w3:34 `0FCFD6` | A |
| Cave Bat | 14, 75 | w3:36 `0FD11B` | A |
| Green Blob | 12, 80 | w3:37 `0FD1E5` | A |
| Mini Race Car | 12, 150 | w4:1F `0FD275` | A |
| Mini Bulldozer | 14, 145 | w4:20 `0FD345` | A |
| Mini Helicopter | 18, 160 | w4:21 `0FD402` | A |
| Ball Worm | 18, 150 | w4:22 `0FD502` | A |
| Sweeper Bot | 24, 140 | w4:24 `0FD752` | A |
| Toy Soldier | 16, 165 | w4:25 `0FD944` | A |
| Toy Calvary | 29, 175 | w4:27 `0FDAED` (24, 175) or w4:26 `0FD9E6` (20, 170) | D, OQ-I004-3 |
| Catapult | 30, 180 | w4:28 `0FDBFB` | A |
| Spike Launcher | 36, 160 | w4:29 `0FDCFC` | A |
| Bronze Robot | 20, 800 | w5:16 `0FE83E` | A |
| Bouncing Ball | 20, 900 | w5:0C `0FDFC3` | A |
| Wraithe | 22, 700 | w5:0D `0FE045` | A |
| Green Snake | 16, 600 | w5:0E `0FE14E` | A |
| Purple Knight | 30, 750 | w5:11 `0FE413` | A |
| Red Knight | 36, 950 | w5:12 `0FE4F2` | A |
| Mimic | 25, 1000 | w5:15 `0FE76C` | A |
| Chess Knight | 28, 850 | w5:17 `0FE88E` | A |
| Skeleton Soldier (ch. 07 prose, no bestiary row) | none given | candidates w5:10 `0FE236` (23, 750), w5:0A `0FDE48` (5, 800) | U, OQ-I004-7 |
| Firefly | 23, 3000 | w6:0B `0FEB95` | A |
| Wall Tile | 10, 4000 | w6:0C `0FECD9` | A |
| Purple Bull | 23, 2700 | w6:0A `0FEA1D` (**45**, 2700) | D, OQ-I004-2 |
| Ghost Ship Torches | ?, 0 | no record with HP and EXP 0 found | U |
| Ice Crystal | ?, 0 | no record found | U |

Boss rows are in section 3. ROM entries with no walkthrough name: w1:31 (5, 3000), w1:34, w1:36, w1:37 (12, 12), w1:38 (15, 15), w3:31 (40, 2000), w3:35 (24, 4000), w4:23 (1, 1000), w4:26 (20, 170), w5:0A, w5:10, w6:0D-0F, w6 (OQ-I004-8).

## 9. NPCs and named characters

Names in the walkthrough, with the ROM text that carries them (counts from the extracted `.asm`): Lisa 27, Turbo 18, Lue 16, Nome 6, Marie 4, Monmo 6, Billy 2, Magridd 30, Deathtoll 22, Phoenix 17, Poseidon 1, Tin Doll 1, Zantetsu 3.

| Walkthrough | ROM evidence | Status |
|-------------|--------------|--------|
| Dr. Leo | `w5_actor_025E61` ("I am Dr-Leo..."), item-granting key, many dialogues | A |
| King Magridd | the people of the Soul of Mountain House ask for him (`w3_actor_02032B`, `w3_actor_020452`: "Please save the King!") and `w3_actor_020563` ("King, are you okay?") is where the Phoenix is granted; the king's own actor was not isolated; ch. 07 releases him again on the airship | C |
| Lisa | location `0E` "Lisa s dream"; `w0_actor_018A59` (Lisa asleep, Dream Rod, paintbrush story); `w0_actor_01B33A` ("I am Lisa, and the goat behind me is Turbo", placed in scene 00/0D = loc `13`, the last Up Above scene); the spelling is "Lisa" in all decoded text, "Liesa" only in the dictionary | A, spelling D, OQ-I004-5 |
| Village chief | `w0_actor_0180F7` (wife: "My husband used to be the village Chief"); `w0_actor_01A098` (chief, Brown Stone); `w0_actor_01A34B` (his room) | A |
| Tool shop woman and son | `w0_actor_018353` (Medical Herb), `w0_actor_0191D2` (goat food boy) | A |
| Goat | `w0_actor_019CDE` ("Gourmet Goat"), `w0_actor_019EF4`, `w0_actor_019F7A` | C |
| Tulip | `w0_actor_01A004` (tulips; the Clubhouse Pass hint), `w0_actor_0197DA` (item 1B) | C |
| Gate boy (cave) | `w0_actor_0198A6` ("secret passage... without a pass"; item 39) | A |
| Architect Gaudi | `w0_actor_01910C` ("My name is Gaudi, I am an architect"); `w5_actor_024027` is his nephew. Not named in the walkthrough | ROM only |
| Turbo | `w1_actor_01DF73`, `w1_actor_01C98A` ("Here lies Turbo, builder of GreenWood"), `w1_actor_01E241` | A |
| Billy and the Woodstin Trio | `w1_actor_01D045` (Medical Herb, "I am Billy, leader of the Woodstin Trio"), `w1_actor_01BB3F`, `w1_actor_01D2F3` | A |
| Monmo (mole) | `w1_actor_01DDB7` ("My name is Monmo the mole"), `w1_actor_01D8C8`, `w1_actor_01D857` | A |
| Guardian of the Woods | `w1_actor_01D4F9` (Green Stone) | A |
| Lue (dolphin) | `w2_actor_0F9B8B` (Thunder Ring), `w2_actor_0F9DBE` ("Lue! I m coming!") | A |
| Servas (dolphin) | `w2_actor_0F89CF` ("Servas is the name of my friend the dolphin") | A |
| Mermaid queen and mermaids | `w2_actor_0F911E` (Blue Stone), `w2_actor_0F8B6A` (Bubble Armor), `w2_actor_0F82DD` (Medical Herb) | A |
| Mermaid dancers Anna, Kanna, Nanna | `w2_actor_0F8577`, `0F85E1`, `0F873E`. Not named in the walkthrough | ROM only |
| Nome (Dr. Leo's snail) | `w3_actor_02108F` ("My name is Nome... Dr-Leo") | A |
| Marie (doll) | `w4_actor_0234EC` ("I am Marie, the doll") | A |
| Dr. Leo's pet dog Turbo | `w1_actor_01DF73` ("Turbo, the dog, used to live with a human named Dr-Leo") | A |
| Devout mouse (heals) | `w4_actor_022D05` ("I am a devout mouse, stand here and you will be purified") | A |
| Actinidia plant | `w4_actor_02317F` | A |
| Deathtoll | the two boss actors (section 3); ROM name `Deathtoll`, dictionary name `Deathtole` | A, spelling D, OQ-I004-5 |
| Poseidon, Tin Doll, Floating Skull, Demon Falcon, Metal Mantis | bosses (section 3); names only in the walkthrough: ROM text contains "Poseidon" once and "Tin Doll" once | C |

## 10. Sidequests

| Walkthrough sidequest | ROM evidence | Status |
|-----------------------|--------------|--------|
| The Master's Eight Emblems | items 2A-31 granted as in section 4; `w1_actor_01BF32` checks all eight and grants item 40, then clears them (dialogue: "you collected all 8 emblems... the Magic Bell") | A |
| Defeating Metal Monsters | Tornado chest `08/0A`; Recovery Sword `w0_actor_01AB4F`; Emblem A `w0_actor_0186A2`; Strange Bottle chest `1E/13`; Red-Hot Stick `w2_actor_0F982F`; the Zantetsu requirement is stated by `w5_actor_026E9D` and the lab door | A |
| Defeating the Spirit Monsters | Spirit Sword chest `66/40`; Flame Pillar chest `20/42`; Red-Hot Mirror `w1_actor_01BDE5` | A |
| Summoning the Phoenix | `w3_actor_020563` tests items 32-34 and clears them; the hint strings are `w1_actor_01D615` and `lib_0118FC_part13.asciistring_015F08` | A |
| Defeating the Metal Monsters (spelling) | the sidequest names are the author's; the ROM has no title strings | C |

## 11. Level-up and stats

| Fact | Walkthrough (`level-up.md`) | ROM | Status |
|------|-----------------------------|-----|--------|
| Level cap 50 | 50 | `code_002F56` stops at `player_level >= $32` | A |
| EXP needed for each level | cumulative values for levels 2-50 | `data_00F9F7.word_00FBB8`: 4 bytes per level (24-bit BCD pair: next-level EXP) | A, all 49 rows equal |
| HP +2 per level, cap 100 | 8 at level 1, 100 at level 47 | `code_002F56` adds 2 to max HP and HP, clamps to `$64` | A |
| Strength +1 at even levels, defence +1 at odd levels | pattern Level/2+1 and Level/2-1 | `code_002F56`: after `INC player_level`, parity of the BCD level selects `INC $1B72` (strength) or `INC $1B76` (defence); labels of the status screen in `lib_0118FC_part11` | A |
| Strength caps at 13, defence at 12 | at level 24-25 | no cap found in `code_002F56` | D, OQ-I004-10 |
| Initial values | HP 8, strength 1, defence 0 | `lib_027912.code_027912`: max HP 8, level 1 | A (HP, level); strength and defence start not checked |

## 12. Proposed actor naming convention

Currently actors are `w0_actor_018353`, `common_actor_0FC296`, etc.: the world is in the prefix, the file offset is the only identity, and the enemy actors sit in `common/` although they belong to one world. Nothing is renamed by this step; the proposal is for the later naming pass, done with `npm run names -- <spec.json>` only.

```
<area>_<role>_<what>_<OFFSET>
```

- `<OFFSET>` stays the file offset in hex, the existing label suffix, so the label stays unique and stays tied to the ROM address (a name with a different suffix would break the rule that label = offset).
- `<area>` is one of: `gv` (w0 Grass Valley, Underground Castle, Leo's Painting, Trial Room), `gw` (w1 GreenWood and Lostside), `se` (w2 St. Elles), `ms` (w3 Mountain of Souls), `ll` (w4 Leo's Laboratory), `mc` (w5 Magridd's Castle), `we` (w6 World of Evil), `cm` (common, bank 00 shared actors: player, items, effects).
- `<role>`: `npc`, `give` (grants an item or spell), `soul`, `boss`, `enemy`, `chest` (chest or pickup helpers), `door`, `fx`, `dream` (dream scenes), `switch`.
- `<what>` is lower-case ASCII with underscores: the walkthrough name for characters, items and enemies (`lisa`, `metal_mantis`, `recovery_sword`), never an apostrophe or a space. Where the ROM spelling differs from the walkthrough (OQ-I004-5, OQ-I004-6), the walkthrough spelling is used and the ROM spelling goes into a note.

Examples (all for existing labels):

| Current | Proposed |
|---------|----------|
| `common_actor_0031AD` | `gv_boss_metal_mantis_0031AD` |
| `common_actor_0033C6` | `gw_boss_statue_0033C6` |
| `common_actor_003E43` | `se_boss_floating_skull_003E43` |
| `common_actor_004299` | `ms_boss_poseidon_004299` |
| `common_actor_004659` | `ll_boss_tin_doll_004659` |
| `common_actor_004BEE` | `mc_boss_demon_falcon_004BEE` |
| `common_actor_004D8B` / `common_actor_005043` | `we_boss_deathtoll_mage_004D8B` / `we_boss_deathtoll_demon_005043` |
| `common_actor_0FC296` | `se_enemy_ape_0FC296` |
| `common_actor_0FE88E` | `mc_enemy_chess_knight_0FE88E` |
| `w0_actor_01AB4F` | `gv_give_recovery_sword_01AB4F` |
| `w0_actor_01A7AC` | `gv_soul_magician_01A7AC` |
| `w4_actor_0234EC` | `ll_give_purple_stone_marie_0234EC` |
| `w1_actor_01BF32` | `gw_give_magic_bell_01BF32` |
| `w3_actor_02108F` | `ms_give_silver_stone_nome_02108F` |

Rules:

1. Enemies take the world prefix from the meta table (section 8), not from the folder.
2. A multi-purpose file keeps its first and main role and lists the others in the part note (for example `w5_actor_02494A` gives item 29 and item 37; `w1_actor_01D6AB` is the Soul of Light and gives item 1E).
3. Pool matches (confidence B) get the pool name until the animation id settles the mapping (`gv_enemy_walking_bush_...` is not allowed for the four 3 HP records until OQ-I004-11 is closed).
4. No new name is created without a ledger row; a name that has a DISCREPANCY keeps the old label until the OQ is settled.

## 13. Not located

| What | Why | OQ |
|------|-----|----|
| Spell gem costs and the Magic Armor/Bell modifiers | the Y-button handlers were not read | OQ-I004-9 |
| Weapon minimum levels | not found as a table | OQ-I004-9 |
| Lair roster per walkthrough area (which enemy type each lair spawns) | `data_00BA0D` is a 420 x 32-byte lair table; its spawned-monster byte at +0x15 was read but not matched per scene | OQ-I004-12 |
| Boss spawn lairs | see section 3 | OQ-I004-13 |
| Hidden, unnamed Up Above locations `0F`-`13` | OQ-I001-6 | open |
| Fairy Gem EXP amounts (30, 80, 150, 180, 200, 250, 300, 400 EXP) | the EXP is granted by lair/Fairy Gem actors not yet read | OQ-I004-12 |

Correction to the plan wording: `data_00BA0D` holds lair and release records (420 x 32 bytes: +0 release location, +0x0B lair location, +0x0C/+0x0D tile x/y, +0x10 behaviour, +0x15 spawned monster id, +0x1E switch word), not enemy statistics. HP, defence and EXP are in `meta_tables_008000`.

## 14. DISCREPANCY index

| OQ | Subject |
|----|---------|
| OQ-I004-1 | Boss HP: Floating Skull 69 vs 70, Poseidon 79 vs 70, Tin Doll 89 vs 80, Demon Falcon 99 vs 90, Deathtoll Mage 99 vs 100 |
| OQ-I004-2 | Purple Bull HP 23 (walkthrough) vs 45 (ROM) |
| OQ-I004-3 | Toy Calvary 29 HP / 175 EXP vs ROM 24/175 or 20/170 |
| OQ-I004-4 | Monster Blocks EXP 2 vs ROM 3 |
| OQ-I004-5 | Dictionary spellings `Deathtole` and `Liesa` vs `Deathtoll` and `Lisa` |
| OQ-I004-6 | Item names: `Recover Sword` (dialogue) vs `Recovery Sword`; `Emblem` vs `Master's Emblem`; `Leaves` vs `Actinidia Leaves` |
| OQ-I004-7 | Skeleton Soldier is named in ch. 07 prose but has no bestiary row |
| OQ-I004-10 | Strength/defence caps (13/12) with no cap in the level-up code |
| OQ-I004-15 | Walkthrough-internal naming variants (no ROM action) |
