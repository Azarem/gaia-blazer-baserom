; Plate lists: the 256-word pointer table and 6 lists of 4-byte pressure plate rows, plus the shared empty list (file offsets 46746-47628, SNES $01:B69A-$BA0C, bank 00; 512 + 371 bytes).
; 
; === MODEL ===
; A pressure plate is a tile that switches a room between two map variants after a lair was released. TriggerVariantPlate (lib_tile_triggers_and_lair_return) reads plate_list_ofs, which the scene loader takes from the word at ($03AA = location_id x 4) + plate_variant x 2 of this table; plate_lists_ofs keeps the address of the pair. The index is therefore location_id x 2 + variant (0 or 1): the two lists of a pair are the plates of variant 0 and variant 1, and stepping on an active plate of the current variant applies the lair record's slab and toggles the variant, so the next plate takes over.
; Row (4 bytes): +0 x, +1 y of the plate tile, +2 word lair record index (the bit number in the released array $1A9E: the plate is inactive until that lair has been released). A list ends with $FF.
; 
; === WHAT IS HERE ===
; Only three rooms have plates: location 01 (Grass Valley, the highlands: PlateListLoc01V0 with 17 rows and PlateListLoc01V1 with 12), location 29 (the Seabed Sanctuary: V0 with 19 rows, V1 with 10) and location 65 (the Castle of King Magridd: V0 with 23 rows, V1 with 10). The rows of one list name only a few lair records (for example PlateListLoc01V0 uses records 2 and 6 in its first rows). 188 of the 256 words point to PlateListEmpty (one $FF byte), 62 are $0000 (the 31 ids without a scene, two words each) and 6 point to the lists above.
---------------------------------------------

?BANK 01

---------------------------------------------

; The plate list pointers: 256 words, location_id x 2 + variant.
; 
; When: the scene loader (plate_list_ofs, plate_lists_ofs) and TriggerVariantPlate after every plate.
; Sees: nothing by itself; the room changes when an active plate is stepped on.
; Why: two lists per location let the plates alternate between the two map variants.
; In: n/a (data): word at (location_id x 2 + variant) x 2.
; Out: 6 words point to the plate lists of locations 01, 29 and 65, 188 to PlateListEmpty and 62 are $0000.
; Clobbers: n/a (data).

PlateListPointers [
  &PlateListEmpty   ;00
  &PlateListEmpty   ;01
  &PlateListLoc01V0   ;02
  &PlateListLoc01V1   ;03
  &PlateListEmpty   ;04
  &PlateListEmpty   ;05
  &PlateListEmpty   ;06
  &PlateListEmpty   ;07
  &PlateListEmpty   ;08
  &PlateListEmpty   ;09
  &PlateListEmpty   ;0A
  &PlateListEmpty   ;0B
  &PlateListEmpty   ;0C
  &PlateListEmpty   ;0D
  &PlateListEmpty   ;0E
  &PlateListEmpty   ;0F
  &PlateListEmpty   ;10
  &PlateListEmpty   ;11
  &PlateListEmpty   ;12
  &PlateListEmpty   ;13
  &PlateListEmpty   ;14
  &PlateListEmpty   ;15
  &PlateListEmpty   ;16
  &PlateListEmpty   ;17
  &PlateListEmpty   ;18
  &PlateListEmpty   ;19
  &PlateListEmpty   ;1A
  &PlateListEmpty   ;1B
  &PlateListEmpty   ;1C
  &PlateListEmpty   ;1D
  &PlateListEmpty   ;1E
  &PlateListEmpty   ;1F
  &PlateListEmpty   ;20
  &PlateListEmpty   ;21
  &PlateListEmpty   ;22
  &PlateListEmpty   ;23
  &PlateListEmpty   ;24
  &PlateListEmpty   ;25
  &PlateListEmpty   ;26
  &PlateListEmpty   ;27
  &PlateListEmpty   ;28
  &PlateListEmpty   ;29
  &PlateListEmpty   ;2A
  &PlateListEmpty   ;2B
  &PlateListEmpty   ;2C
  &PlateListEmpty   ;2D
  &PlateListEmpty   ;2E
  &PlateListEmpty   ;2F
  &PlateListEmpty   ;30
  &PlateListEmpty   ;31
  &PlateListEmpty   ;32
  &PlateListEmpty   ;33
  &PlateListEmpty   ;34
  &PlateListEmpty   ;35
  &PlateListEmpty   ;36
  &PlateListEmpty   ;37
  &PlateListEmpty   ;38
  &PlateListEmpty   ;39
  &PlateListEmpty   ;3A
  &PlateListEmpty   ;3B
  &PlateListEmpty   ;3C
  &PlateListEmpty   ;3D
  &PlateListEmpty   ;3E
  &PlateListEmpty   ;3F
  &PlateListEmpty   ;40
  &PlateListEmpty   ;41
  &PlateListEmpty   ;42
  &PlateListEmpty   ;43
  &PlateListEmpty   ;44
  &PlateListEmpty   ;45
  &PlateListEmpty   ;46
  &PlateListEmpty   ;47
  &PlateListEmpty   ;48
  &PlateListEmpty   ;49
  #$0000   ;4A
  #$0000   ;4B
  #$0000   ;4C
  #$0000   ;4D
  #$0000   ;4E
  #$0000   ;4F
  &PlateListEmpty   ;50
  &PlateListEmpty   ;51
  &PlateListLoc29V0   ;52
  &PlateListLoc29V1   ;53
  &PlateListEmpty   ;54
  &PlateListEmpty   ;55
  &PlateListEmpty   ;56
  &PlateListEmpty   ;57
  &PlateListEmpty   ;58
  &PlateListEmpty   ;59
  &PlateListEmpty   ;5A
  &PlateListEmpty   ;5B
  &PlateListEmpty   ;5C
  &PlateListEmpty   ;5D
  &PlateListEmpty   ;5E
  &PlateListEmpty   ;5F
  &PlateListEmpty   ;60
  &PlateListEmpty   ;61
  &PlateListEmpty   ;62
  &PlateListEmpty   ;63
  &PlateListEmpty   ;64
  &PlateListEmpty   ;65
  &PlateListEmpty   ;66
  &PlateListEmpty   ;67
  &PlateListEmpty   ;68
  &PlateListEmpty   ;69
  #$0000   ;6A
  #$0000   ;6B
  #$0000   ;6C
  #$0000   ;6D
  #$0000   ;6E
  #$0000   ;6F
  #$0000   ;70
  #$0000   ;71
  #$0000   ;72
  #$0000   ;73
  #$0000   ;74
  #$0000   ;75
  #$0000   ;76
  #$0000   ;77
  &PlateListEmpty   ;78
  &PlateListEmpty   ;79
  &PlateListEmpty   ;7A
  &PlateListEmpty   ;7B
  &PlateListEmpty   ;7C
  &PlateListEmpty   ;7D
  &PlateListEmpty   ;7E
  &PlateListEmpty   ;7F
  &PlateListEmpty   ;80
  &PlateListEmpty   ;81
  &PlateListEmpty   ;82
  &PlateListEmpty   ;83
  &PlateListEmpty   ;84
  &PlateListEmpty   ;85
  &PlateListEmpty   ;86
  &PlateListEmpty   ;87
  &PlateListEmpty   ;88
  &PlateListEmpty   ;89
  &PlateListEmpty   ;8A
  &PlateListEmpty   ;8B
  &PlateListEmpty   ;8C
  &PlateListEmpty   ;8D
  &PlateListEmpty   ;8E
  &PlateListEmpty   ;8F
  #$0000   ;90
  #$0000   ;91
  #$0000   ;92
  #$0000   ;93
  #$0000   ;94
  #$0000   ;95
  #$0000   ;96
  #$0000   ;97
  #$0000   ;98
  #$0000   ;99
  #$0000   ;9A
  #$0000   ;9B
  #$0000   ;9C
  #$0000   ;9D
  #$0000   ;9E
  #$0000   ;9F
  &PlateListEmpty   ;A0
  &PlateListEmpty   ;A1
  &PlateListEmpty   ;A2
  &PlateListEmpty   ;A3
  &PlateListEmpty   ;A4
  &PlateListEmpty   ;A5
  &PlateListEmpty   ;A6
  &PlateListEmpty   ;A7
  &PlateListEmpty   ;A8
  &PlateListEmpty   ;A9
  &PlateListEmpty   ;AA
  &PlateListEmpty   ;AB
  &PlateListEmpty   ;AC
  &PlateListEmpty   ;AD
  &PlateListEmpty   ;AE
  &PlateListEmpty   ;AF
  &PlateListEmpty   ;B0
  &PlateListEmpty   ;B1
  &PlateListEmpty   ;B2
  &PlateListEmpty   ;B3
  &PlateListEmpty   ;B4
  &PlateListEmpty   ;B5
  &PlateListEmpty   ;B6
  &PlateListEmpty   ;B7
  &PlateListEmpty   ;B8
  &PlateListEmpty   ;B9
  #$0000   ;BA
  #$0000   ;BB
  #$0000   ;BC
  #$0000   ;BD
  #$0000   ;BE
  #$0000   ;BF
  #$0000   ;C0
  #$0000   ;C1
  #$0000   ;C2
  #$0000   ;C3
  #$0000   ;C4
  #$0000   ;C5
  #$0000   ;C6
  #$0000   ;C7
  &PlateListEmpty   ;C8
  &PlateListEmpty   ;C9
  &PlateListLoc65V0   ;CA
  &PlateListLoc65V1   ;CB
  &PlateListEmpty   ;CC
  &PlateListEmpty   ;CD
  &PlateListEmpty   ;CE
  &PlateListEmpty   ;CF
  &PlateListEmpty   ;D0
  &PlateListEmpty   ;D1
  &PlateListEmpty   ;D2
  &PlateListEmpty   ;D3
  &PlateListEmpty   ;D4
  &PlateListEmpty   ;D5
  &PlateListEmpty   ;D6
  &PlateListEmpty   ;D7
  &PlateListEmpty   ;D8
  &PlateListEmpty   ;D9
  &PlateListEmpty   ;DA
  &PlateListEmpty   ;DB
  &PlateListEmpty   ;DC
  &PlateListEmpty   ;DD
  &PlateListEmpty   ;DE
  &PlateListEmpty   ;DF
  &PlateListEmpty   ;E0
  &PlateListEmpty   ;E1
  &PlateListEmpty   ;E2
  &PlateListEmpty   ;E3
  &PlateListEmpty   ;E4
  &PlateListEmpty   ;E5
  &PlateListEmpty   ;E6
  &PlateListEmpty   ;E7
  #$0000   ;E8
  #$0000   ;E9
  #$0000   ;EA
  #$0000   ;EB
  #$0000   ;EC
  #$0000   ;ED
  #$0000   ;EE
  #$0000   ;EF
  &PlateListEmpty   ;F0
  &PlateListEmpty   ;F1
  &PlateListEmpty   ;F2
  &PlateListEmpty   ;F3
  &PlateListEmpty   ;F4
  &PlateListEmpty   ;F5
  &PlateListEmpty   ;F6
  &PlateListEmpty   ;F7
  &PlateListEmpty   ;F8
  &PlateListEmpty   ;F9
  &PlateListEmpty   ;FA
  &PlateListEmpty   ;FB
  #$0000   ;FC
  #$0000   ;FD
  #$0000   ;FE
  #$0000   ;FF
]

---------------------------------------------
; Plates of variant 0 in location 01 (Grass Valley, the highlands): 17 rows.
; 
; When: location 01 while plate_variant is 0.
; Sees: stepping on a plate whose lair is released changes part of the room.
; Why: see the block note.
; In: n/a (data). Row: x, y, word lair record index.
; Out: 17 rows, then $FF.
; Clobbers: n/a (data).

PlateListLoc01V0 [
  unk7 < #04, #1C, #$0002 >   ;00
  unk7 < #0E, #18, #$0002 >   ;01
  unk7 < #0A, #14, #$0002 >   ;02
  unk7 < #16, #19, #$0006 >   ;03
  unk7 < #18, #17, #$0006 >   ;04
  unk7 < #29, #1A, #$000E >   ;05
  unk7 < #3A, #21, #$0010 >   ;06
  unk7 < #37, #1F, #$0010 >   ;07
  unk7 < #3B, #1E, #$0010 >   ;08
  unk7 < #3B, #1D, #$0010 >   ;09
  unk7 < #39, #09, #$001A >   ;0A
  unk7 < #30, #07, #$001A >   ;0B
  unk7 < #30, #05, #$001A >   ;0C
  unk7 < #38, #3A, #$0023 >   ;0D
  unk7 < #0D, #28, #$0028 >   ;0E
  unk7 < #13, #28, #$0028 >   ;0F
  unk7 < #0F, #2A, #$0028 >   ;10
]

---------------------------------------------
; Plates of variant 1 in location 01 (Grass Valley, the highlands): 12 rows.
; 
; When: location 01 while plate_variant is 1.
; Sees: as PlateListLoc01V0, the second state.
; Why: see the block note.
; In: n/a (data). Row: x, y, word lair record index.
; Out: 12 rows, then $FF.
; Clobbers: n/a (data).

PlateListLoc01V1 [
  unk7 < #04, #1D, #$0002 >   ;00
  unk7 < #0E, #19, #$0002 >   ;01
  unk7 < #16, #1A, #$0006 >   ;02
  unk7 < #29, #1B, #$000E >   ;03
  unk7 < #3A, #22, #$0010 >   ;04
  unk7 < #36, #1F, #$0010 >   ;05
  unk7 < #39, #0A, #$001A >   ;06
  unk7 < #30, #08, #$001A >   ;07
  unk7 < #38, #3B, #$0023 >   ;08
  unk7 < #0C, #28, #$0028 >   ;09
  unk7 < #14, #28, #$0028 >   ;0A
  unk7 < #0F, #2B, #$0028 >   ;0B
]

---------------------------------------------
; Plates of variant 0 in location 29 (Seabed Sanctuary): 19 rows.
; 
; When: location 29 while plate_variant is 0.
; Sees: as PlateListLoc01V0.
; Why: see the block note.
; In: n/a (data). Row: x, y, word lair record index.
; Out: 19 rows, then $FF.
; Clobbers: n/a (data).

PlateListLoc29V0 [
  unk7 < #1A, #2D, #$00A1 >   ;00
  unk7 < #25, #2D, #$00A1 >   ;01
  unk7 < #13, #2D, #$00A1 >   ;02
  unk7 < #2C, #2D, #$00A1 >   ;03
  unk7 < #10, #38, #$00A1 >   ;04
  unk7 < #2F, #38, #$00A1 >   ;05
  unk7 < #15, #32, #$00A1 >   ;06
  unk7 < #1B, #33, #$00A1 >   ;07
  unk7 < #24, #36, #$00A1 >   ;08
  unk7 < #2A, #32, #$00A1 >   ;09
  unk7 < #1F, #3E, #$00A1 >   ;0A
  unk7 < #20, #3E, #$00A1 >   ;0B
  unk7 < #1D, #08, #$00B6 >   ;0C
  unk7 < #22, #08, #$00B6 >   ;0D
  unk7 < #0A, #08, #$0095 >   ;0E
  unk7 < #0B, #06, #$0095 >   ;0F
  unk7 < #0C, #04, #$0095 >   ;10
  unk7 < #35, #08, #$0084 >   ;11
  unk7 < #1F, #06, #$00B6 >   ;12
]

---------------------------------------------
; Plates of variant 1 in location 29 (Seabed Sanctuary): 10 rows.
; 
; When: location 29 while plate_variant is 1.
; Sees: as PlateListLoc01V0.
; Why: see the block note.
; In: n/a (data). Row: x, y, word lair record index.
; Out: 10 rows, then $FF.
; Clobbers: n/a (data).

PlateListLoc29V1 [
  unk7 < #1A, #2C, #$00A1 >   ;00
  unk7 < #25, #2C, #$00A1 >   ;01
  unk7 < #13, #2C, #$00A1 >   ;02
  unk7 < #2C, #2C, #$00A1 >   ;03
  unk7 < #0F, #38, #$00A1 >   ;04
  unk7 < #30, #38, #$00A1 >   ;05
  unk7 < #1D, #09, #$00B6 >   ;06
  unk7 < #22, #09, #$00B6 >   ;07
  unk7 < #0A, #09, #$0095 >   ;08
  unk7 < #35, #09, #$0084 >   ;09
]

---------------------------------------------
; Plates of variant 0 in location 65 (Castle of King Magridd): 23 rows.
; 
; When: location 65 while plate_variant is 0.
; Sees: as PlateListLoc01V0.
; Why: see the block note.
; In: n/a (data). Row: x, y, word lair record index.
; Out: 23 rows, then $FF.
; Clobbers: n/a (data).

PlateListLoc65V0 [
  unk7 < #07, #1D, #$018D >   ;00
  unk7 < #08, #33, #$0167 >   ;01
  unk7 < #04, #2E, #$0167 >   ;02
  unk7 < #09, #2E, #$0167 >   ;03
  unk7 < #09, #30, #$0167 >   ;04
  unk7 < #1C, #33, #$016B >   ;05
  unk7 < #1C, #30, #$016B >   ;06
  unk7 < #24, #33, #$0179 >   ;07
  unk7 < #25, #30, #$0179 >   ;08
  unk7 < #36, #33, #$0187 >   ;09
  unk7 < #37, #2C, #$0187 >   ;0A
  unk7 < #1F, #0B, #$018C >   ;0B
  unk7 < #10, #09, #$018C >   ;0C
  unk7 < #2F, #09, #$018C >   ;0D
  unk7 < #13, #08, #$018C >   ;0E
  unk7 < #29, #06, #$018C >   ;0F
  unk7 < #1E, #06, #$018C >   ;10
  unk7 < #34, #07, #$018C >   ;11
  unk7 < #0C, #05, #$018C >   ;12
  unk7 < #38, #1D, #$017F >   ;13
  unk7 < #32, #2C, #$0187 >   ;14
  unk7 < #1F, #05, #$018C >   ;15
  unk7 < #14, #07, #$018C >   ;16
]

---------------------------------------------
; Plates of variant 1 in location 65 (Castle of King Magridd): 10 rows.
; 
; When: location 65 while plate_variant is 1.
; Sees: as PlateListLoc01V0.
; Why: see the block note.
; In: n/a (data). Row: x, y, word lair record index.
; Out: 10 rows, then $FF.
; Clobbers: n/a (data).

PlateListLoc65V1 [
  unk7 < #07, #1E, #$018D >   ;00
  unk7 < #08, #34, #$0167 >   ;01
  unk7 < #1C, #34, #$016B >   ;02
  unk7 < #24, #34, #$0179 >   ;03
  unk7 < #36, #34, #$0187 >   ;04
  unk7 < #1F, #0C, #$018C >   ;05
  unk7 < #10, #0A, #$018C >   ;06
  unk7 < #2F, #0A, #$018C >   ;07
  unk7 < #38, #1E, #$017F >   ;08
  unk7 < #31, #2C, #$0187 >   ;09
]

---------------------------------------------
; The shared empty plate list: one $FF byte.
; 
; When: 188 pointer words use it (every location with a scene except 01, 29 and 65).
; Sees: a room without plates.
; Why: one terminator serves all.
; In: n/a (data).
; Out: an immediate end of the list.
; Clobbers: n/a (data).

PlateListEmpty [
]