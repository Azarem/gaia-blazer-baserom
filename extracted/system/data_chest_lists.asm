; Chest lists: the 128-word pointer table by location_id and the lists of 6-byte chest rows (file offsets 43486-44181, SNES $01:A9DE-$AC95, bank 00; 256 + 440 bytes).
; 
; === MODEL ===
; TryOpenChest (lib_tile_triggers_and_lair_return) and the scene init code in lib_map_tile_patches read chest_list_ofs, the list of the current location, which the scene loader takes from ChestListPointers[location_id x 2]. A chest is not an actor: the map holds the chest tile ($FB closed, $FC open) and the list says which tile belongs to which chest, what it holds and which bit of the chest array remembers that it was opened.
; Row (6 bytes): +0 x, +1 y of the tile the player stands on (the chest tile is one above, y - 1); +2 chest id (bits 0-6 = the bit number in the array $1A7E, bit 7 = the tile is also edited on BG2); +3 content (0 empty, $FF Gems, any other value an inventory entry); +4 word Gem amount (BCD, little-endian: the bytes 12 00 are 12 Gems). A list ends with $FF.
; 
; === WHAT IS HERE ===
; 97 of the 128 location ids have a list; the 31 ids without a scene (25-27, 35-3B, 48-4F, 5D-63, 74-77, 7E, 7F) hold $0000. Of the 97, 60 share ChestListEmpty (a single $FF byte) and 37 have their own label: 36 with chests (67 chests in all: 1 to 4 per room) and ChestListLoc0A, an empty list of its own (Tulip's Dream) that duplicates the shared one. Names are ChestListLocLL with LL = location_id in hex.
; Locations with chests (ROM location names): 03 Treasure room, 05 and 06 the Underground Castle, 08 Leo's Paintings, 0D Trial room, 15 Woods of GreenWood, 16 A mole's hole, 1A-1C Water Shrine, 1D-1F Fire Shrine, 20 Light Shrine, 29 Seabed Sanctuary, 2B Secret Cave, 2E Southerta, 2F Shore reef of Rockbird, 30 Durean, 32 A ghost ship, 34 Seabed of St. Elles, 3E Mountain North slope, 3F Aurora's Ridge, 47 Ice field of Laynole, 51 Leo's Laboratory, 58 the power plant, 5B and 5C Model of a town, 66 the torture chamber, 67 and 68 the castle basement, 6E and 6F the right tower, 79 and 7A World of Evil, 7B Dazzling Space.
; Checked against the walkthrough: the chest of the Trial room (ChestListLoc0D) holds item 1, the Sword of Life (01-in-the-beginning.md); the chest in the Underground Castle (ChestListLoc05) holds the 12 Gems of 02-grass-valley.md.
; 
; === NOTES ===
; - The bit number is a 7-bit value, so a chest id is below 128; the chest-opened array is $1A7E, right behind the 32 event flag bytes: chest bit n is bit number $100 + n of the shared bit space (16 of its 32 bytes are used).
---------------------------------------------

?BANK 01

---------------------------------------------

; The chest list pointers: 128 words by location_id.
; 
; When: the scene loader (chest_list_ofs) and TryOpenChest.
; Sees: nothing by itself; the chests of the room open when the player walks into them from below.
; Why: any room can hold chests without an actor script.
; In: n/a (data): word at location_id x 2: the bank-$01 address of the location's list, or $0000 for the 31 ids without a scene.
; Out: 97 non-zero words: 60 point to ChestListEmpty (locations 00-02, 04, 07, 09, 0B, 0C, 0E-14, 17-19, 21-24, 28, 2A, 2C, 2D, 31, 33, 3C, 3D, 40-46, 50, 52-57, 59, 5A, 64, 65, 69-6D, 70-73, 78, 7C, 7D), 0A to ChestListLoc0A, 36 to their own list.
; Clobbers: n/a (data).

ChestListPointers [
  &ChestListEmpty   ;00
  &ChestListEmpty   ;01
  &ChestListEmpty   ;02
  &ChestListLoc03   ;03
  &ChestListEmpty   ;04
  &ChestListLoc05   ;05
  &ChestListLoc06   ;06
  &ChestListEmpty   ;07
  &ChestListLoc08   ;08
  &ChestListEmpty   ;09
  &ChestListLoc0A   ;0A
  &ChestListEmpty   ;0B
  &ChestListEmpty   ;0C
  &ChestListLoc0D   ;0D
  &ChestListEmpty   ;0E
  &ChestListEmpty   ;0F
  &ChestListEmpty   ;10
  &ChestListEmpty   ;11
  &ChestListEmpty   ;12
  &ChestListEmpty   ;13
  &ChestListEmpty   ;14
  &ChestListLoc15   ;15
  &ChestListLoc16   ;16
  &ChestListEmpty   ;17
  &ChestListEmpty   ;18
  &ChestListEmpty   ;19
  &ChestListLoc1A   ;1A
  &ChestListLoc1B   ;1B
  &ChestListLoc1C   ;1C
  &ChestListLoc1D   ;1D
  &ChestListLoc1E   ;1E
  &ChestListLoc1F   ;1F
  &ChestListLoc20   ;20
  &ChestListEmpty   ;21
  &ChestListEmpty   ;22
  &ChestListEmpty   ;23
  &ChestListEmpty   ;24
  #$0000   ;25
  #$0000   ;26
  #$0000   ;27
  &ChestListEmpty   ;28
  &ChestListLoc29   ;29
  &ChestListEmpty   ;2A
  &ChestListLoc2B   ;2B
  &ChestListEmpty   ;2C
  &ChestListEmpty   ;2D
  &ChestListLoc2E   ;2E
  &ChestListLoc2F   ;2F
  &ChestListLoc30   ;30
  &ChestListEmpty   ;31
  &ChestListLoc32   ;32
  &ChestListEmpty   ;33
  &ChestListLoc34   ;34
  #$0000   ;35
  #$0000   ;36
  #$0000   ;37
  #$0000   ;38
  #$0000   ;39
  #$0000   ;3A
  #$0000   ;3B
  &ChestListEmpty   ;3C
  &ChestListEmpty   ;3D
  &ChestListLoc3E   ;3E
  &ChestListLoc3F   ;3F
  &ChestListEmpty   ;40
  &ChestListEmpty   ;41
  &ChestListEmpty   ;42
  &ChestListEmpty   ;43
  &ChestListEmpty   ;44
  &ChestListEmpty   ;45
  &ChestListEmpty   ;46
  &ChestListLoc47   ;47
  #$0000   ;48
  #$0000   ;49
  #$0000   ;4A
  #$0000   ;4B
  #$0000   ;4C
  #$0000   ;4D
  #$0000   ;4E
  #$0000   ;4F
  &ChestListEmpty   ;50
  &ChestListLoc51   ;51
  &ChestListEmpty   ;52
  &ChestListEmpty   ;53
  &ChestListEmpty   ;54
  &ChestListEmpty   ;55
  &ChestListEmpty   ;56
  &ChestListEmpty   ;57
  &ChestListLoc58   ;58
  &ChestListEmpty   ;59
  &ChestListEmpty   ;5A
  &ChestListLoc5B   ;5B
  &ChestListLoc5C   ;5C
  #$0000   ;5D
  #$0000   ;5E
  #$0000   ;5F
  #$0000   ;60
  #$0000   ;61
  #$0000   ;62
  #$0000   ;63
  &ChestListEmpty   ;64
  &ChestListEmpty   ;65
  &ChestListLoc66   ;66
  &ChestListLoc67   ;67
  &ChestListLoc68   ;68
  &ChestListEmpty   ;69
  &ChestListEmpty   ;6A
  &ChestListEmpty   ;6B
  &ChestListEmpty   ;6C
  &ChestListEmpty   ;6D
  &ChestListLoc6E   ;6E
  &ChestListLoc6F   ;6F
  &ChestListEmpty   ;70
  &ChestListEmpty   ;71
  &ChestListEmpty   ;72
  &ChestListEmpty   ;73
  #$0000   ;74
  #$0000   ;75
  #$0000   ;76
  #$0000   ;77
  &ChestListEmpty   ;78
  &ChestListLoc79   ;79
  &ChestListLoc7A   ;7A
  &ChestListLoc7B   ;7B
  &ChestListEmpty   ;7C
  &ChestListEmpty   ;7D
  #$0000   ;7E
  #$0000   ;7F
]

---------------------------------------------
; The chest of the Trial room (location 0D): 1 row.
; 
; When: location 0D, the first room of the game.
; Sees: the chest in front of the player yields the Sword of Life (walkthrough 01-in-the-beginning.md).
; Why: the first weapon is a normal chest, so the tutorial teaches the chest.
; In: n/a (data). Row: x 4, y 5, id 0, content 1 (the Sword of Life), Gems 0.
; Out: one row, then $FF.
; Clobbers: n/a (data).

ChestListLoc0D #040500010000FF

ChestListLoc03 #070705090000080706FF5000FF

---------------------------------------------
; The chests of the Underground Castle, west part (location 05): 3 rows.
; 
; When: location 05.
; Sees: a chest with 12 Gems (walkthrough 02-grass-valley.md) and two chests with items.
; Why: see the block note.
; In: n/a (data). Rows: (x 27, y 18) id 1 content $FF = Gems, 12 BCD Gems; (25, 37) id 2 content $38; (68, 20) id 3 content $1C.
; Out: three rows, then $FF.
; Clobbers: n/a (data).

ChestListLoc05 #1B1201FF12001925023800004414031C0000FF

ChestListLoc06 #0435041D0000FF

ChestListLoc08 #1808093800003A040A170000FF

---------------------------------------------
; An empty chest list of its own for location 0A (Tulip's Dream).
; 
; When: location 0A.
; Sees: no chest.
; Why: unknown; ChestListEmpty would do (a duplicate $FF byte).
; In: n/a (data).
; Out: an immediate end of the list.
; Clobbers: n/a (data).

ChestListLoc0A #FF

ChestListLoc15 #10060C0A0000FF

ChestListLoc16 #08130D1F0000FF

ChestListLoc1A #020C0BFF5000FF

ChestListLoc1B #14060EFF50010D2B0F380000FF

ChestListLoc1C #0F3C102500002B3C11FF5000FF

ChestListLoc1D #090F12380000FF

ChestListLoc1E #1A19140000002D0413390000FF

ChestListLoc1F #281B15FF0001201816FF6000FF

ChestListLoc20 #2A0442160000FF

ChestListLoc29 #2A39172100002AB917210000041418200000FF

ChestListLoc2B #0407192D00000A071AFF8000040B1B3800000A0B1C000000FF

ChestListLoc2E #36251D380000FF

ChestListLoc2F #24241E380000292A1FFF6000FF

ChestListLoc30 #301A200300003A2721390000FF

ChestListLoc32 #033522FF0100FF

ChestListLoc34 #463C23350000FF

ChestListLoc3E #293A24FF4000FF

ChestListLoc3F #1813250C00001A14260000001D14273800001F1528FF5000FF

ChestListLoc47 #16062904000026062A390000380841140000FF

ChestListLoc51 #180C3F050000FF

ChestListLoc58 #1D152B0E0000FF

ChestListLoc5B #2A30ACFF5000220EAD380000280EAEFF8000FF

ChestListLoc5C #221DAF3900002425B0380000FF

ChestListLoc66 #051A31FF8000260640060000FF

ChestListLoc67 #1508B23900000F27B3380000191FC3FF0001FF

ChestListLoc68 #0305B42B0000FF

ChestListLoc6E #1911BDFF80001D11BEFF8000FF

ChestListLoc6F #051535FF00010B1B36380000FF

ChestListLoc79 #1E4737380000114738FF00021C2039330000FF

ChestListLoc7A #1C233A100000FF

ChestListLoc7B #1C3D3B080000033D3CFF0001FF

---------------------------------------------
; The shared empty chest list: one $FF byte.
; 
; When: 60 locations point here (see ChestListPointers).
; Sees: a room without chests.
; Why: one terminator serves every room without chests.
; In: n/a (data).
; Out: an immediate end of the list.
; Clobbers: n/a (data).

ChestListEmpty #FF